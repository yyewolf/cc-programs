local printer, reader
local names = peripheral.getNames()

local numbers = {
    {
        "###",
        "# #",
        "# #",
        "# #",
        "###"
    },
    {
        " # ",
        "## ",
        " # ",
        " # ",
        "###"
    },
    {
        "###",
        "  #",
        "###",
        "#  ",
        "###"
    },
    {
        "###",
        "  #",
        "###",
        "  #",
        "###"
    },
    {
        "# #",
        "# #",
        "###",
        "  #",
        "  #"
    },
    {
        "###",
        "#  ",
        "###",
        "  #",
        "###"
    },
    {
        "###",
        "#  ",
        "###",
        "# #",
        "###"
    },
    {
        "###",
        "  #",
        "  #",
        "  #",
        "  #"
    },
    {
        "###",
        "# #",
        "###",
        "# #",
        "###"
    },
    {
        "###",
        "# #",
        "###",
        "  #",
        "###"
    },
    {
        "   ",
        "   ",
        "###",
        "   ",
        "   "
    },
}

local X = {
    "",
    "",
    "",
    "",
    ""
}

local space = "  "

for _, v in pairs(names) do
    if peripheral.getType(v) == "blockReader" then
        print("Reader OK.")
        reader = peripheral.wrap(v)
    end
    if peripheral.getType(v) == "printer" then
        print("Printer OK.")
        printer = peripheral.wrap(v)
    end
end

function getCoord()
    local data = reader.getBlockData()
    if data == nil then
        print("Impossible de récupérer les datas.")
        return nil, nil
    end
    if data.Items == nil then
        print("Impossible de récupérer les items.")
        return nil, nil
    end
    if data.Items[0] == nil then
        print("Impossible de récupérer l'item.")
        return nil, nil
    end
    if data.Items[0].tag == nil then
        print("Impossible de récupérer le tag.")
        return nil, nil
    end
    if data.Items[0].tag.Decorations == nil then
        print("Impossible de récupérer les décorateurs.")
        return nil, nil
    end
    if data.Items[0].tag.Decorations[0] == nil then
        print("Impossible de récupérer le décorateur.")
        return nil, nil
    end
    if data.Items[0].tag.Decorations[0].x == nil then
        print("Impossible de récupérer x.")
        return nil, nil
    end
    if data.Items[0].tag.Decorations[0].z == nil then
        print("Impossible de récupérer y.")
        return nil, nil
    end
    local x = data.Items[0].tag.Decorations[0].x
    local y = data.Items[0].tag.Decorations[0].z
    return tostring(x), tostring(y)
end

function newLine()
    local _, yPos = printer.getCursorPos()
    printer.setCursorPos(1,(yPos + 1))
end

while true do
    local input = read()
    if input == "help" then
        print("Tape 'do' quand tu as mis la map au bon endroit.")
    end
    if input == "do" then
        local x, z = getCoord()
        print("X="..x)
        print("Z="..z)
        if x ~= nil and z ~= nil then
            print("Impression...")
            printer.newPage()
            local width = 25
            local temp = " "
            newLine()
            newLine()
            newLine()
            newLine()
            local spaces = 3*x:len() + 3*x:len()-1
            if spaces < 0 then
                spaces = 0
            end
            spaces = (width-spaces)/2
            for i, _ in pairs(X) do
                printer.write(temp:rep(spaces))
                for j = 1, #x do
                    local coord = x:sub(j, j)
                    local str = numbers[coord+1][i]
                    if coord == "-" then
                        str = numbers[11][i]
                    end
                    printer.write(str)
                    printer.write(space)
                end
                newLine()
            end
            newLine()
            newLine()
            newLine()
            local spaces = 3*z:len() + 3*z:len()-1
            if spaces < 0 then
                spaces = 0
            end
            spaces = (width-spaces)/2
            for i, _ in pairs(X) do
                printer.write(temp:rep(spaces))
                for j = 1, #z do
                    local coord = z:sub(j, j)
                    local str = numbers[coord+1][i]
                    if coord == "-" then
                        str = numbers[11][i]
                    end
                    printer.write(str)
                    printer.write(space)
                end
                newLine()
            end
            printer.endPage()
        end
    end
end