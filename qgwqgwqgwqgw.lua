if getgenv().Credits == "https://discord.gg/Aknd49ARke | If you pay for this script you get scammed this script is completely free for use" then
    local l_Main_0 = getgenv().SocietyStand.Main;
    l_Main_0.CustomName = l_Main_0.CustomName or "Master";
    l_Main_0.FlyAnim = l_Main_0.FlyAnim or "fly3";
    local l_Players_0 = game:GetService("Players");
    local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
    local l_l_Players_0_FirstChild_0 = l_Players_0:FindFirstChild(l_Main_0.Owner);
    if not l_l_Players_0_FirstChild_0 then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/krinckled/randomcrack/refs/heads/main/notify"))().Notify({
            Title = "Society Stand V3 - ERROR", 
            Description = "Owner '" .. l_Main_0.Owner .. "' not found in game. Script stopped.", 
            Duration = 10
        });
        return;
    else
        if not l_Main_0.Advanced then
            l_Main_0.Advanced = {};
        end;
        if not l_Main_0.Advanced.Prediction then
            l_Main_0.Advanced.Prediction = {};
        end;
        local v4 = {
            BaseTime = 0.25, 
            MaxDistance = 9, 
            MinSpeed = 2, 
            PingMultiplier = 0.001
        };
        for v5, v6 in pairs(v4) do
            if l_Main_0.Advanced.Prediction[v5] == nil then
                l_Main_0.Advanced.Prediction[v5] = v6;
            end;
        end;
        local l_Owner_0 = l_Main_0.Owner;
        local l_Owner_1 = l_Main_0.Owner;
        local l_LocalPlayer_1 = game:GetService("Players").LocalPlayer;
        local function v12(v10) --[[ Line: 0 ]] --[[ Name:  ]]
            if v10 then
                local l_Humanoid_0 = v10:WaitForChild("Humanoid");
                l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
            end;
        end;
        v12(l_LocalPlayer_1.Character);
        l_LocalPlayer_1.CharacterAdded:Connect(v12);
        do
            local l_l_Main_0_0, l_l_LocalPlayer_0_0, l_l_l_Players_0_FirstChild_0_0, l_l_Owner_0_0, l_l_Owner_1_0, l_l_LocalPlayer_1_0, l_v12_0 = l_Main_0, l_LocalPlayer_0, l_l_Players_0_FirstChild_0, l_Owner_0, l_Owner_1, l_LocalPlayer_1, v12;
            local v39 = {
                EmoteLibrary = {
                    float1 = 73980801925168, 
                    float2 = 136474387705342, 
                    lev1 = 105472716769741, 
                    lev2 = 113087712986783, 
                    fly1 = 99895187863233, 
                    sitaura1 = 133418516499878, 
                    fly3 = 122746752555782, 
                    lev3 = 99828067051785, 
                    float3 = 93200072379823, 
                    fly2 = 135620478150461, 
                    blow = 120250643826676, 
                    doggy = 114731495347458, 
                    benx = 100871311287918, 
                    doggysit = 114111611336704, 
                    doggyrun = 130072963359721, 
                    js = 85141122321737
                }, 
                CurrentTrack = nil, 
                ActiveEmote = nil, 
                Connections = {}, 
                Threads = {}, 
                PlayEmote = function(v20, v21) --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: l_l_LocalPlayer_1_0 (ref)
                    local v22 = nil;
                    if type(v21) == "number" then
                        v22 = v21;
                    elseif type(v21) == "string" then
                        if v20.EmoteLibrary[v21] then
                            v22 = v20.EmoteLibrary[v21];
                        else
                            v22 = tonumber(v21);
                        end;
                    end;
                    if not v22 then
                        warn("Invalid emote identifier:", v21);
                        return false;
                    else
                        v20:StopEmote();
                        local l_Character_0 = l_l_LocalPlayer_1_0.Character;
                        if not l_Character_0 then
                            return false;
                        else
                            local l_Humanoid_1 = l_Character_0:FindFirstChildOfClass("Humanoid");
                            if not l_Humanoid_1 then
                                return false;
                            else
                                local l_Animation_0 = Instance.new("Animation");
                                l_Animation_0.AnimationId = "rbxassetid://" .. v22;
                                v20.CurrentTrack = l_Humanoid_1:LoadAnimation(l_Animation_0);
                                v20.CurrentTrack.Looped = true;
                                v20.CurrentTrack.Priority = Enum.AnimationPriority.Action4;
                                v20.CurrentTrack:Play();
                                v20.ActiveEmote = v21;
                                return true;
                            end;
                        end;
                    end;
                end, 
                StopEmote = function(v26) --[[ Line: 0 ]] --[[ Name:  ]]
                    if v26.CurrentTrack then
                        v26.CurrentTrack:Stop();
                        v26.CurrentTrack:Destroy();
                        v26.CurrentTrack = nil;
                    end;
                    v26.ActiveEmote = nil;
                end, 
                StartRecovery = function(v27) --[[ Line: 0 ]] --[[ Name:  ]]
                    v27:StopRecovery();
                    table.insert(v27.Threads, task.spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v27 (ref)
                        while task.wait(2) do
                            if v27.CurrentTrack and not v27.CurrentTrack.IsPlaying and v27.ActiveEmote then
                                v27:PlayEmote(v27.ActiveEmote);
                            end;
                        end;
                    end));
                end, 
                StopRecovery = function(v28) --[[ Line: 0 ]] --[[ Name:  ]]
                    for _, v30 in pairs(v28.Threads) do
                        coroutine.close(v30);
                    end;
                    v28.Threads = {};
                end, 
                InitCharacter = function(v31, v32) --[[ Line: 0 ]] --[[ Name:  ]]
                    local l_Humanoid_2 = v32:WaitForChild("Humanoid");
                    table.insert(v31.Connections, l_Humanoid_2.Died:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v31 (ref)
                        v31:StopEmote();
                    end));
                    task.wait(0.7);
                    if v31.ActiveEmote then
                        v31:PlayEmote(v31.ActiveEmote);
                    end;
                end, 
                Init = function(v34) --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: l_l_LocalPlayer_1_0 (ref)
                    v34:Cleanup();
                    table.insert(v34.Connections, l_l_LocalPlayer_1_0.CharacterAdded:Connect(function(v35) --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v34 (ref)
                        v34:InitCharacter(v35);
                    end));
                    if l_l_LocalPlayer_1_0.Character then
                        v34:InitCharacter(l_l_LocalPlayer_1_0.Character);
                    end;
                    v34:StartRecovery();
                end, 
                Cleanup = function(v36) --[[ Line: 0 ]] --[[ Name:  ]]
                    v36:StopEmote();
                    v36:StopRecovery();
                    for _, v38 in pairs(v36.Connections) do
                        v38:Disconnect();
                    end;
                    v36.Connections = {};
                end
            };
            _G.EmoteController = {
                Play = function(v40) --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v39 (ref)
                    return v39:PlayEmote(v40);
                end, 
                Stop = function() --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v39 (ref)
                    v39:StopEmote();
                end, 
                StopAll = function() --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v39 (ref)
                    v39:StopEmote();
                end, 
                List = function() --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v39 (ref)
                    return v39.EmoteLibrary;
                end, 
                Add = function(v41, v42) --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v39 (ref)
                    v39.EmoteLibrary[v41] = v42;
                    return true;
                end, 
                Current = function() --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v39 (ref)
                    return v39.ActiveEmote;
                end, 
                Toggle = function(v43) --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v39 (ref)
                    if v39.ActiveEmote == v43 then
                        v39:StopEmote();
                        return false;
                    else
                        return v39:PlayEmote(v43);
                    end;
                end
            };
            v39:Init();
            local function v53(v44) --[[ Line: 0 ]] --[[ Name:  ]]
                local l_game_0 = game;
                local l_Workspace_0 = l_game_0.Workspace;
                local l_Lighting_0 = l_game_0.Lighting;
                local l_Terrain_0 = l_Workspace_0.Terrain;
                l_Terrain_0.WaterWaveSize = 0;
                l_Terrain_0.WaterWaveSpeed = 0;
                l_Terrain_0.WaterReflectance = 0;
                l_Terrain_0.WaterTransparency = 0;
                l_Lighting_0.GlobalShadows = false;
                l_Lighting_0.FogEnd = 9000000000;
                l_Lighting_0.Brightness = 0;
                settings().Rendering.QualityLevel = "Level01";
                for _, v50 in pairs(l_game_0:GetDescendants()) do
                    if v50:IsA("Part") or v50:IsA("Union") or v50:IsA("CornerWedgePart") or v50:IsA("TrussPart") then
                        v50.Material = "Plastic";
                        v50.Reflectance = 0;
                    elseif (v50:IsA("Decal") or v50:IsA("Texture")) and v44 then
                        v50.Transparency = 1;
                    elseif v50:IsA("ParticleEmitter") or v50:IsA("Trail") then
                        v50.Lifetime = NumberRange.new(0);
                    elseif v50:IsA("Explosion") then
                        v50.BlastPressure = 1;
                        v50.BlastRadius = 1;
                    elseif v50:IsA("Fire") or v50:IsA("SpotLight") or v50:IsA("Smoke") or v50:IsA("Sparkles") then
                        v50.Enabled = false;
                    elseif v50:IsA("MeshPart") then
                        v50.Material = "Plastic";
                        v50.Reflectance = 0;
                        v50.TextureID = 1.0385902758728956E16;
                    end;
                end;
                for _, v52 in pairs(l_Lighting_0:GetChildren()) do
                    if v52:IsA("BlurEffect") or v52:IsA("SunRaysEffect") or v52:IsA("ColorCorrectionEffect") or v52:IsA("BloomEffect") or v52:IsA("DepthOfFieldEffect") then
                        v52.Enabled = false;
                    end;
                end;
            end;
            local l_RunService_0 = game:GetService("RunService");
            local function v55() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_RunService_0 (ref)
                if sethiddenproperty then
                    sethiddenproperty(workspace, "StreamingTargetRadius", 0);
                end;
                l_RunService_0:Set3dRenderingEnabled(false);
            end;
            local l_Players_1 = game:GetService("Players");
            local _ = game:GetService("StarterGui");
            local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
            local l_TeleportService_0 = game:GetService("TeleportService");
            local l_TextChatService_0 = game:GetService("TextChatService");
            local l_l_Players_1_FirstChild_0 = l_Players_1:FindFirstChild(l_l_Main_0_0.Owner);
            local l_l_l_Players_1_FirstChild_0_0 = l_l_Players_1_FirstChild_0;
            local v63 = loadstring(game:HttpGet("https://pastebin.com/raw/ADAayvDu"))();
            getgenv().ScriptName = "Society Stand v3";
            local _ = getgenv().ScriptName;
            local l_Notify_0 = v63.Notify;
            l_Notify_0({
                Title = "Society Stand V3", 
                Description = "System initializing", 
                Duration = 5
            });
            l_Notify_0({
                Title = "Society Stand", 
                Description = "Wait till script is fully loaded", 
                Duration = 5
            });
            local v66 = {
                Position = l_l_Main_0_0.Position, 
                Summoned = false, 
                Following = false, 
                Noclip = true, 
                Blow = false, 
                Doggy = false, 
                Sit = false, 
                Jumpscare = false, 
                Attacking = false, 
                TrashAttacking = false, 
                Guarding = false
            };
            local v67 = 3.5;
            local v68 = 2.5;
            local v69 = -20;
            local v70 = nil;
            local v71 = nil;
            local v72 = nil;
            local _ = nil;
            local l_Part_0 = Instance.new("Part");
            l_Part_0.Name = "FloatPart";
            l_Part_0.Anchored = true;
            l_Part_0.CanCollide = false;
            l_Part_0.CanQuery = false;
            l_Part_0.Size = Vector3.new(6, 1, 6);
            l_Part_0.Transparency = 1;
            l_Part_0.Parent = workspace;
            local _ = "rbxassetid://616006778";
            local v76 = nil;
            if getgenv().SocietyStand.Main.DisableRendering then
                v55();
            end;
            if getgenv().SocietyStand.Main.lowgfx then
                v53(true);
            end;
            local function v77() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Main_0_0 (ref), l_Notify_0 (ref)
                if not _G.EmoteController.Play(l_l_Main_0_0.FlyAnim) then
                    l_Notify_0({
                        Title = "Animation Error", 
                        Description = "Failed AnimatiomID: " .. l_l_Main_0_0.FlyAnim, 
                        Duration = 5
                    });
                end;
            end;
            local function v78() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v66 (ref), v70 (ref), v71 (ref), v72 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), v77 (ref)
                v66.Summoned = false;
                v66.Following = false;
                v66.Protecting = false;
                v66.Roofing = false;
                v66.Lifting = false;
                v66.Benx = false;
                v66.Blow = false;
                v66.Doggy = false;
                v66.Sit = false;
                v66.Jumpscare = false;
                v66.Attacking = false;
                v66.TrashAttacking = false;
                v66.Guarding = false;
                orbiting = false;
                if v70 then
                    v70:Disconnect();
                    v70 = nil;
                end;
                if v71 then
                    v71:Destroy();
                    v71 = nil;
                end;
                if v72 then
                    v72:Destroy();
                    v72 = nil;
                end;
                l_l_l_Players_1_FirstChild_0_0 = nil;
                if _G.EmoteController then
                    _G.EmoteController.StopAll();
                end;
                v77();
            end;
            local function v81() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_l_Players_0_FirstChild_0_0 (ref)
                if l_l_l_Players_0_FirstChild_0_0 and l_l_l_Players_0_FirstChild_0_0.Character then
                    for _, v80 in ipairs(l_l_l_Players_0_FirstChild_0_0.Character:GetDescendants()) do
                        if v80:IsA("BasePart") then
                            v80.CanCollide = true;
                            v80.Massless = false;
                        end;
                    end;
                end;
            end;
            local v82 = {};
            local v83 = false;
            local function v89(v84) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_l_Players_0_FirstChild_0_0 (ref), v82 (ref), v83 (ref)
                if not l_l_l_Players_0_FirstChild_0_0 or not l_l_l_Players_0_FirstChild_0_0.Character then
                    return;
                else
                    if v84 then
                        v82 = {};
                        for _, v86 in ipairs(l_l_l_Players_0_FirstChild_0_0.Character:GetDescendants()) do
                            if v86:IsA("BasePart") then
                                v82[v86] = {
                                    CanCollide = v86.CanCollide, 
                                    CanQuery = v86.CanQuery, 
                                    CanTouch = v86.CanTouch, 
                                    Massless = v86.Massless, 
                                    AssemblyLinearVelocity = v86.AssemblyLinearVelocity, 
                                    AssemblyAngularVelocity = v86.AssemblyAngularVelocity
                                };
                                v86.CanCollide = false;
                                v86.CanQuery = false;
                                v86.CanTouch = false;
                                v86.Massless = true;
                                v86.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                                v86.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                                v86:SetAttribute("IsOwnerPart", true);
                            end;
                        end;
                        v83 = true;
                    else
                        for v87, v88 in pairs(v82) do
                            if v87 and v87.Parent then
                                v87.CanCollide = v88.CanCollide;
                                v87.CanQuery = v88.CanQuery;
                                v87.CanTouch = v88.CanTouch;
                                v87.Massless = v88.Massless;
                                v87.AssemblyLinearVelocity = v88.AssemblyLinearVelocity;
                                v87.AssemblyAngularVelocity = v88.AssemblyAngularVelocity;
                                v87:SetAttribute("IsOwnerPart", nil);
                            end;
                        end;
                        v82 = {};
                        v83 = false;
                    end;
                    return;
                end;
            end;
            (function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v66 (ref), l_l_LocalPlayer_0_0 (ref), l_Part_0 (ref), v70 (ref)
                v66.Summoned = false;
                v66.Following = false;
                _G.EmoteController.StopAll();
                if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                    l_l_LocalPlayer_0_0.Character.HumanoidRootPart.CFrame = CFrame.new(0, -100, 0);
                end;
                l_Part_0.CFrame = CFrame.new(0, -100, 0);
                if v70 then
                    v70:Disconnect();
                    v70 = nil;
                end;
            end)();
            l_l_LocalPlayer_0_0.CharacterAdded:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_v12_0 (ref), l_l_LocalPlayer_0_0 (ref), v66 (ref), v77 (ref)
                task.wait(1);
                l_v12_0(l_l_LocalPlayer_0_0.Character);
                if v66.Summoned then
                    v77();
                end;
            end);
            local l_HttpService_0 = game:GetService("HttpService");
            local v91 = "http://149.40.3.138:50909";
            local v92 = 0.1;
            local function v118(v93) --[[ Line: 0 ]] --[[ Name:  ]]
                local function v97(v94) --[[ Line: 0 ]] --[[ Name:  ]]
                    local l_status_0, l_result_0 = pcall(v94);
                    if l_status_0 and l_result_0 ~= nil then
                        return l_result_0;
                    else
                        return nil, l_result_0 or "pcall failed or returned nil";
                    end;
                end;
                local v98 = nil;
                local v99 = nil;
                if syn and syn.request then
                    local v100, v101 = v97(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v93 (ref)
                        return syn.request(v93);
                    end);
                    v99 = v101;
                    v98 = v100;
                end;
                if not v98 and request then
                    local v102, v103 = v97(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v93 (ref)
                        return request(v93);
                    end);
                    v99 = v103;
                    v98 = v102;
                end;
                if not v98 and http_request then
                    local v104, v105 = v97(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v93 (ref)
                        return http_request(v93);
                    end);
                    v99 = v105;
                    v98 = v104;
                end;
                if not v98 and http and http.request then
                    local v106, v107 = v97(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v93 (ref)
                        return http.request(v93);
                    end);
                    v99 = v107;
                    v98 = v106;
                end;
                if not v98 and httprequest then
                    local v108, v109 = v97(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v93 (ref)
                        return httprequest(v93);
                    end);
                    v99 = v109;
                    v98 = v108;
                end;
                if not v98 and webrequest then
                    local v110, v111 = v97(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v93 (ref)
                        return webrequest(v93);
                    end);
                    v99 = v111;
                    v98 = v110;
                end;
                if not v98 and web_request then
                    local v112, v113 = v97(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v93 (ref)
                        return web_request(v93);
                    end);
                    v99 = v113;
                    v98 = v112;
                end;
                if not v98 and fluxus and fluxus.request then
                    local v114, v115 = v97(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v93 (ref)
                        return fluxus.request(v93);
                    end);
                    v99 = v115;
                    v98 = v114;
                end;
                if not v98 and Krnl and Krnl.request then
                    local v116, v117 = v97(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v93 (ref)
                        return Krnl.request(v93);
                    end);
                    v99 = v117;
                    v98 = v116;
                end;
                if not v98 then
                    return nil, not v99 and "no http implementation available" or v99;
                elseif type(v98) == "table" then
                    if v98.Body then
                        return tostring(v98.Body);
                    elseif v98.body then
                        return tostring(v98.body);
                    else
                        return tostring(v98);
                    end;
                else
                    return tostring(v98);
                end;
            end;
            local v120 = (function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_Players_1 (ref), l_l_Main_0_0 (ref)
                local l_l_Players_1_FirstChild_1 = l_Players_1:FindFirstChild(l_l_Main_0_0.Owner);
                if l_l_Players_1_FirstChild_1 then
                    return tostring(l_l_Players_1_FirstChild_1.UserId);
                else
                    return tostring(l_l_Main_0_0.Owner);
                end;
            end)();
            local function v129(v121, v122) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v120 (ref), l_l_Main_0_0 (ref), v91 (ref), l_HttpService_0 (ref), v118 (ref)
                local v123 = {
                    userid = v120, 
                    cmd = "notification", 
                    title = v121, 
                    description = v122, 
                    password = l_l_Main_0_0.Advanced.password or "help"
                };
                local v124 = {
                    Url = v91 .. "/send_command", 
                    Method = "POST", 
                    Headers = {
                        ["Content-Type"] = "application/json"
                    }, 
                    Body = l_HttpService_0:JSONEncode(v123)
                };
                local l_status_1, l_result_1 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v118 (ref), v124 (ref)
                    local v125, v126 = v118(v124);
                    if not v125 then
                        error("HTTP request failed: " .. tostring(v126));
                    end;
                    return v125;
                end);
                if not l_status_1 then
                    warn("Failed to send notification to UI:", l_result_1);
                end;
            end;
            local v130 = "";
            local v131 = 0;
            local v132 = 3;
            local function v137(v133) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Main_0_0 (ref), v129 (ref), v130 (ref), v131 (ref), v132 (ref), l_TextChatService_0 (ref), l_ReplicatedStorage_0 (ref)
                if not l_l_Main_0_0.ChatCommands then
                    v129("Chat: ", v133);
                    print(v133);
                    return;
                else
                    local v134 = os.clock();
                    if v133 == v130 and v134 - v131 < v132 then
                        return;
                    else
                        v130 = v133;
                        v131 = v134;
                        local l_RBXGeneral_0 = l_TextChatService_0.TextChannels:FindFirstChild("RBXGeneral");
                        if l_RBXGeneral_0 then
                            l_RBXGeneral_0:SendAsync(v133);
                        elseif l_ReplicatedStorage_0:FindFirstChild("DefaultChatSystemChatEvents") then
                            local l_SayMessageRequest_0 = l_ReplicatedStorage_0.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest");
                            if l_SayMessageRequest_0 then
                                l_SayMessageRequest_0:FireServer(v133, "All");
                            end;
                        end;
                        return;
                    end;
                end;
            end;
            local function v156(v138, v139) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_Players_1 (ref)
                if not v138 then
                    return nil;
                else
                    local l_AssemblyLinearVelocity_0 = v138.AssemblyLinearVelocity;
                    if not _G.PositionHistory then
                        _G.PositionHistory = {};
                    end;
                    if not _G.PositionHistory[v138] then
                        _G.PositionHistory[v138] = {};
                    end;
                    table.insert(_G.PositionHistory[v138], {
                        position = v138.Position, 
                        time = tick()
                    });
                    while #_G.PositionHistory[v138] > 0 and tick() - _G.PositionHistory[v138][1].time > 0.5 do
                        table.remove(_G.PositionHistory[v138], 1);
                    end;
                    if l_AssemblyLinearVelocity_0.Magnitude < 0.1 then
                        local v141 = v138.CFrame.LookVector * -1;
                        return v138.Position + v141, Vector3.new(0, 0, 0);
                    else
                        local l_Unit_0 = l_AssemblyLinearVelocity_0.Unit;
                        local l_BaseTime_0 = PREDICTION_SETTINGS.BaseTime;
                        local l_l_Players_1_PlayerFromCharacter_0 = l_Players_1:GetPlayerFromCharacter(v138.Parent);
                        if l_l_Players_1_PlayerFromCharacter_0 then
                            l_BaseTime_0 = PREDICTION_SETTINGS.BaseTime + l_l_Players_1_PlayerFromCharacter_0:GetNetworkPing() * PREDICTION_SETTINGS.PingMultiplier;
                        end;
                        local v145 = 1;
                        if v139 == "fling" then
                            v145 = 1.4;
                        elseif v139 == "punch" then
                            v145 = 1.3;
                        elseif v139 == "slam" then
                            v145 = 1.1;
                        elseif v139 == "roof" then
                            v145 = 1.2;
                        elseif v139 == "lift" then
                            v145 = 1;
                        end;
                        local l_Magnitude_0 = l_AssemblyLinearVelocity_0.Magnitude;
                        local v147 = v138.Position + l_Unit_0 * l_Magnitude_0 * l_BaseTime_0 * v145;
                        if math.abs(l_AssemblyLinearVelocity_0.Y) > 5 and #_G.PositionHistory[v138] >= 2 then
                            local v148 = _G.PositionHistory[v138];
                            local l_position_0 = v148[#v148].position;
                            local l_position_1 = v148[#v148 - 1].position;
                            local v151 = (l_position_0.Y - l_position_1.Y) / (v148[#v148].time - v148[#v148 - 1].time);
                            local v152 = 196.2;
                            local v153 = l_BaseTime_0 * 1.5;
                            local v154 = l_position_0.Y + v151 * v153 - 0.5 * v152 * v153 * v153;
                            v147 = Vector3.new(v147.X, v154, v147.Z);
                        end;
                        local l_Magnitude_1 = (v147 + l_Unit_0 * 1.2 - v138.Position).Magnitude;
                        if PREDICTION_SETTINGS.MaxDistance < l_Magnitude_1 then
                            v147 = v138.Position + l_Unit_0 * PREDICTION_SETTINGS.MaxDistance;
                        else
                            v147 = v138.Position + l_Unit_0 * l_Magnitude_1;
                        end;
                        return v147, l_Unit_0;
                    end;
                end;
            end;
            local v157 = {};
            getgenv().SocietyStandAPI = getgenv().SocietyStandAPI or {};
            getgenv().SocietyStandAPI.Commands = v157;
            getgenv().SocietyStandCommands = getgenv().SocietyStandCommands or {};
            local l_SocietyStandCommands_0 = getgenv().SocietyStandCommands;
            Create = function(v159, v160) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_SocietyStandCommands_0 (ref)
                if type(v159) == "string" then
                    v159 = {
                        v159
                    };
                end;
                for _, v162 in ipairs(v159) do
                    l_SocietyStandCommands_0[v162:lower()] = v160;
                end;
            end;
            getgenv().RegisterStandCommand = function(v163, v164) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_SocietyStandCommands_0 (ref)
                l_SocietyStandCommands_0[v163:lower()] = v164;
            end;
            local v169 = {
                back = function(v165) --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v67 (ref)
                    return -v165.CFrame.LookVector * v67;
                end, 
                under = function(_) --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v69 (ref)
                    return Vector3.new(0, v69, 0);
                end, 
                left = function(v167) --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v67 (ref)
                    return -v167.CFrame.LookVector * v67 + -v167.CFrame.RightVector * 2;
                end, 
                right = function(v168) --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v67 (ref)
                    return -v168.CFrame.LookVector * v67 + v168.CFrame.RightVector * 2;
                end
            };
            local v170 = 0;
            local v171 = 0;
            local function v231() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v66 (ref), l_Part_0 (ref), l_l_LocalPlayer_0_0 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), v170 (ref), v171 (ref), v169 (ref), v68 (ref)
                if not v66.Summoned then
                    local v172 = Vector3.new(1500, 1500, 0);
                    l_Part_0.CFrame = CFrame.new(v172);
                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                        local l_HumanoidRootPart_0 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                        l_HumanoidRootPart_0.CFrame = CFrame.new(v172);
                        l_HumanoidRootPart_0.AssemblyLinearVelocity = Vector3.zero;
                        l_HumanoidRootPart_0.AssemblyAngularVelocity = Vector3.zero;
                    end;
                    return;
                elseif not v66.Summoned or not l_l_l_Players_1_FirstChild_0_0 or not l_l_l_Players_1_FirstChild_0_0.Character then
                    return;
                else
                    local l_HumanoidRootPart_1 = l_l_l_Players_1_FirstChild_0_0.Character:FindFirstChild("HumanoidRootPart");
                    if not l_HumanoidRootPart_1 then
                        return;
                    else
                        local v175 = nil;
                        if v66.Roofing then
                            v175 = (l_HumanoidRootPart_1.CFrame * CFrame.new(0, 5, 0)).Position;
                        elseif v66.Lifting then
                            v175 = (l_HumanoidRootPart_1.CFrame * CFrame.new(0, -3, 0)).Position;
                            l_HumanoidRootPart_1.CFrame = l_HumanoidRootPart_1.CFrame + Vector3.new(0, 0.15, 0);
                        elseif v66.Jumpscare then
                            if not l_l_l_Players_1_FirstChild_0_0.Character then
                                v66.Jumpscare = false;
                                return;
                            else
                                local l_Head_0 = l_l_l_Players_1_FirstChild_0_0.Character:FindFirstChild("Head");
                                if not l_Head_0 then
                                    v66.Jumpscare = false;
                                    return;
                                else
                                    local v177 = l_Head_0.Position + l_Head_0.CFrame.LookVector * 1.5;
                                    local l_Unit_1 = (l_Head_0.Position - v177).Unit;
                                    local v179 = CFrame.new(v177, v177 + l_Unit_1);
                                    local v180 = tick();
                                    local v181 = Vector3.new(math.sin(v180 * 20) * 0.1, math.cos(v180 * 15) * 0.1, math.sin(v180 * 25) * 0.1);
                                    local v182 = v179 * CFrame.new(v181);
                                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                        local l_HumanoidRootPart_2 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                                        l_HumanoidRootPart_2.CFrame = v182;
                                        l_HumanoidRootPart_2.AssemblyLinearVelocity = Vector3.zero;
                                        l_HumanoidRootPart_2.AssemblyAngularVelocity = Vector3.zero;
                                    end;
                                    return;
                                end;
                            end;
                        elseif v66.Benx then
                            local v184 = l_HumanoidRootPart_1.Position + l_HumanoidRootPart_1.CFrame.LookVector * 1;
                            local l_Unit_2 = (v184 - l_HumanoidRootPart_1.Position).Unit;
                            local v186 = CFrame.lookAt(v184, v184 + l_Unit_2);
                            local v187 = CFrame.Angles(math.rad(-20), 0, 0);
                            l_Part_0.CFrame = v186 * v187;
                            if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                local l_HumanoidRootPart_3 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                                l_HumanoidRootPart_3.CFrame = v186 * v187;
                                l_HumanoidRootPart_3.AssemblyLinearVelocity = Vector3.zero;
                                l_HumanoidRootPart_3.AssemblyAngularVelocity = Vector3.zero;
                            end;
                            return;
                        elseif v66.Attacking then
                            local v189 = l_HumanoidRootPart_1.Position + l_HumanoidRootPart_1.CFrame.LookVector * -2;
                            local l_Unit_3 = (v189 - l_HumanoidRootPart_1.Position).Unit;
                            local v191 = CFrame.lookAt(v189, v189 + l_Unit_3) * CFrame.Angles(0, math.rad(180), 0);
                            local v192 = tick();
                            local v193 = math.sin(v192 * 10) * 0.25;
                            local v194 = v191 * CFrame.new(0, v193, 0);
                            l_Part_0.CFrame = v194;
                            if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                local l_HumanoidRootPart_4 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                                l_HumanoidRootPart_4.CFrame = v194;
                                l_HumanoidRootPart_4.AssemblyLinearVelocity = Vector3.zero;
                                l_HumanoidRootPart_4.AssemblyAngularVelocity = Vector3.zero;
                            end;
                            return;
                        elseif v66.TrashAttacking then
                            local v196 = l_HumanoidRootPart_1.Position + l_HumanoidRootPart_1.CFrame.LookVector * -20;
                            local l_Unit_4 = (v196 - l_HumanoidRootPart_1.Position).Unit;
                            local v198 = CFrame.lookAt(v196, v196 + l_Unit_4) * CFrame.Angles(0, math.rad(180), 0);
                            local v199 = tick();
                            local v200 = math.sin(v199 * 10) * 0.25;
                            local v201 = v198 * CFrame.new(0, v200, 0);
                            l_Part_0.CFrame = v201;
                            if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                local l_HumanoidRootPart_5 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                                l_HumanoidRootPart_5.CFrame = v201;
                                l_HumanoidRootPart_5.AssemblyLinearVelocity = Vector3.zero;
                                l_HumanoidRootPart_5.AssemblyAngularVelocity = Vector3.zero;
                            end;
                            return;
                        elseif v66.Sit then
                            local v205 = {
                                left = function(v203) --[[ Line: 0 ]] --[[ Name:  ]]
                                    return v203.CFrame.LookVector * 1.5 + -v203.CFrame.RightVector * 2;
                                end, 
                                right = function(v204) --[[ Line: 0 ]] --[[ Name:  ]]
                                    return v204.CFrame.LookVector * 1.5 + v204.CFrame.RightVector * 2;
                                end
                            };
                            local v206 = (v205[v66.Position and v66.Position:lower()] or v205.left)(l_HumanoidRootPart_1);
                            local v207 = l_HumanoidRootPart_1.Position + v206;
                            local v208 = RaycastParams.new();
                            v208.FilterType = Enum.RaycastFilterType.Blacklist;
                            v208.FilterDescendantsInstances = {
                                l_l_LocalPlayer_0_0.Character, 
                                l_l_l_Players_1_FirstChild_0_0.Character
                            };
                            local v209 = workspace:Raycast(v207 + Vector3.new(0, 10, 0), Vector3.new(0, -100, 0), v208);
                            local v210 = v209 and v209.Position.Y or v207.Y;
                            local v211 = Vector3.new(v207.X, v210 + 3, v207.Z);
                            local v212 = CFrame.lookAt(v211, v211 + l_HumanoidRootPart_1.CFrame.LookVector);
                            if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                local l_HumanoidRootPart_6 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                                l_HumanoidRootPart_6.CFrame = v212;
                                l_HumanoidRootPart_6.AssemblyLinearVelocity = Vector3.zero;
                                l_HumanoidRootPart_6.AssemblyAngularVelocity = Vector3.zero;
                            end;
                            return;
                        elseif v66.Blow then
                            local v214 = l_HumanoidRootPart_1.Position + l_HumanoidRootPart_1.CFrame.LookVector * 1.5 - Vector3.new(0, 1.5, 0);
                            local v215 = Vector3.new(l_HumanoidRootPart_1.CFrame.LookVector.X, 0, l_HumanoidRootPart_1.CFrame.LookVector.Z).Unit * -1;
                            local v216 = CFrame.lookAt(v214, v214 + v215);
                            v170 = v170 + 0.05;
                            local v217 = math.sin(v170) * 0.5;
                            local v218 = v216 * CFrame.new(0, 0, v217);
                            l_Part_0.CFrame = v218;
                            if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                local l_HumanoidRootPart_7 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                                l_HumanoidRootPart_7.CFrame = v218;
                                l_HumanoidRootPart_7.AssemblyLinearVelocity = Vector3.zero;
                                l_HumanoidRootPart_7.AssemblyAngularVelocity = Vector3.zero;
                            end;
                            return;
                        elseif v66.Doggy then
                            local v220 = l_HumanoidRootPart_1.Position + l_HumanoidRootPart_1.CFrame.LookVector * 3;
                            local l_Unit_5 = (v220 - l_HumanoidRootPart_1.Position).Unit;
                            local v222 = CFrame.lookAt(v220, v220 + l_Unit_5);
                            v171 = v171 + 0.05;
                            local v223 = math.sin(v171) * 0.5;
                            local v224 = v222 * CFrame.new(0, 0, v223);
                            l_Part_0.CFrame = v224;
                            if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                local l_HumanoidRootPart_8 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                                l_HumanoidRootPart_8.CFrame = v224;
                                l_HumanoidRootPart_8.AssemblyLinearVelocity = Vector3.zero;
                                l_HumanoidRootPart_8.AssemblyAngularVelocity = Vector3.zero;
                            end;
                            return;
                        elseif v66.Following then
                            local v226 = (v169[v66.Position:lower()] or v169.back)(l_HumanoidRootPart_1);
                            local v227 = RaycastParams.new();
                            v227.FilterType = Enum.RaycastFilterType.Blacklist;
                            v227.FilterDescendantsInstances = {
                                l_l_LocalPlayer_0_0.Character, 
                                l_l_l_Players_1_FirstChild_0_0.Character
                            };
                            local v228 = workspace:Raycast(l_HumanoidRootPart_1.Position, Vector3.new(0, -100, 0), v227);
                            local v229 = (v228 and v228.Position.Y or l_HumanoidRootPart_1.Position.Y - 10) + 3;
                            v175 = l_HumanoidRootPart_1.Position + v226;
                            v175 = Vector3.new(v175.X, math.max(v175.Y + v68, v229), v175.Z);
                        else
                            return;
                        end;
                        if v175 then
                            l_Part_0.CFrame = CFrame.new(v175);
                            if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                local l_HumanoidRootPart_9 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                                l_HumanoidRootPart_9.CFrame = CFrame.new(v175, v175 + l_HumanoidRootPart_1.CFrame.LookVector);
                                l_HumanoidRootPart_9.AssemblyLinearVelocity = Vector3.zero;
                                l_HumanoidRootPart_9.AssemblyAngularVelocity = Vector3.zero;
                            end;
                        end;
                        return;
                    end;
                end;
            end;
            local function v232() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v66 (ref), v70 (ref), v71 (ref), v72 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_l_Players_0_FirstChild_0_0 (ref), l_Notify_0 (ref)
                v66.Summoned = false;
                v66.Following = false;
                v66.Blow = false;
                v66.Doggy = false;
                v66.Attacking = false;
                v66.Jumpscare = false;
                v66.Sit = false;
                v66.Benx = false;
                v66.TrashAttacking = false;
                v66.Guarding = false;
                orbiting = false;
                if v70 then
                    v70:Disconnect();
                    v70 = nil;
                end;
                if v71 then
                    v71:Destroy();
                    v71 = nil;
                end;
                if v72 then
                    v72:Destroy();
                    v72 = nil;
                end;
                l_l_l_Players_1_FirstChild_0_0 = l_l_l_Players_0_FirstChild_0_0;
                v66.Summoned = false;
                v66.Following = false;
                l_Notify_0({
                    Title = "Vanish", 
                    Description = "Stand vanished", 
                    Duration = 3
                });
            end;
            local function v234() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_Players_1 (ref), l_l_Owner_1_0 (ref), l_Notify_0 (ref), l_Part_0 (ref), v66 (ref), v81 (ref), v70 (ref), v71 (ref), v72 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_l_Players_0_FirstChild_0_0 (ref), l_l_LocalPlayer_0_0 (ref), v77 (ref)
                local l_l_Players_1_FirstChild_2 = l_Players_1:FindFirstChild(l_l_Owner_1_0);
                if not l_l_Players_1_FirstChild_2 or not l_l_Players_1_FirstChild_2.Character then
                    l_Notify_0({
                        Title = "Owner Not Found", 
                        Description = "Current owner not in server", 
                        Duration = 5
                    });
                    return;
                else
                    l_Part_0.Anchored = false;
                    v66.Protecting = false;
                    v66.Roofing = false;
                    v66.Lifting = false;
                    v66.Benx = false;
                    v66.Blow = false;
                    v66.Doggy = false;
                    v66.Sit = false;
                    v66.Attacking = false;
                    v66.Jumpscare = false;
                    v66.TrashAttacking = false;
                    v66.Guarding = false;
                    orbiting = false;
                    v81();
                    if v70 then
                        v70:Disconnect();
                        v70 = nil;
                    end;
                    if v71 then
                        v71:Destroy();
                        v71 = nil;
                    end;
                    if v72 then
                        v72:Destroy();
                        v72 = nil;
                    end;
                    l_l_l_Players_1_FirstChild_0_0 = l_l_Players_1_FirstChild_2;
                    l_l_l_Players_0_FirstChild_0_0 = l_l_Players_1_FirstChild_2;
                    v66.Summoned = true;
                    v66.Following = true;
                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                        l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = false;
                    end;
                    v77();
                    return;
                end;
            end;
            for _, v236 in ipairs({
                "back", 
                "under", 
                "left", 
                "right"
            }) do
                do
                    local l_v236_0 = v236;
                    Create(l_v236_0, function(_, _) --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v66 (ref), l_v236_0 (ref), v137 (ref), v231 (ref)
                        v66.Position = l_v236_0;
                        v137("Position: " .. l_v236_0);
                        if v66.Summoned then
                            v231();
                        end;
                    end);
                end;
            end;
            Create("vanish", function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v232 (ref)
                v232();
            end);
            Create("summon", function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v137 (ref), l_l_Main_0_0 (ref), v234 (ref)
                v137("I'm here, " .. (l_l_Main_0_0.CustomName or "Master") .. "!");
                v234();
            end);
            Create("leave", function() --[[ Line: 0 ]] --[[ Name:  ]]
                game:Shutdown();
            end);
            Create({
                "rejoin", 
                "rj"
            }, function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_TeleportService_0 (ref), l_l_LocalPlayer_0_0 (ref)
                l_TeleportService_0:TeleportToPlaceInstance(game.PlaceId, game.JobId, l_l_LocalPlayer_0_0);
            end);
            Create("frame", function(v240) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_l_Players_1_FirstChild_0_0 (ref), l_l_l_Players_0_FirstChild_0_0 (ref), v137 (ref), l_Players_1 (ref), l_l_LocalPlayer_0_0 (ref), v66 (ref), v231 (ref)
                local v241 = table.concat(v240, " ");
                if v241 == "" then
                    l_l_l_Players_1_FirstChild_0_0 = l_l_l_Players_0_FirstChild_0_0;
                    v137("Now framing " .. l_l_l_Players_0_FirstChild_0_0.Name);
                else
                    local v242 = nil;
                    for _, v244 in ipairs(l_Players_1:GetPlayers()) do
                        if v244.Name:lower():find(v241:lower(), 1, true) or v244.DisplayName and v244.DisplayName:lower():find(v241:lower(), 1, true) then
                            v242 = v244;
                            break;
                        end;
                    end;
                    if not v242 or v242 == l_l_LocalPlayer_0_0 then
                        v137("Player not found.");
                        return;
                    elseif not v242.Character or not v242.Character:FindFirstChild("HumanoidRootPart") then
                        v137("Player character not ready.");
                        return;
                    else
                        l_l_l_Players_1_FirstChild_0_0 = v242;
                    end;
                end;
                if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                    l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = false;
                end;
                v66.Following = true;
                v66.Summoned = true;
                v231();
            end);
            local v245 = false;
            local v246 = nil;
            local function _(v247) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_LocalPlayer_0_0 (ref), v245 (ref), v246 (ref)
                local l_Character_1 = l_l_LocalPlayer_0_0.Character;
                if not l_Character_1 then
                    return;
                else
                    local l_HumanoidRootPart_10 = l_Character_1:FindFirstChild("HumanoidRootPart");
                    if not l_HumanoidRootPart_10 then
                        return;
                    else
                        if v247 and not v245 then
                            v245 = true;
                            v246 = Instance.new("BodyAngularVelocity");
                            v246.Name = "Fling_" .. tostring(math.random(1000, 9999));
                            v246.AngularVelocity = Vector3.new(0, 99999, 0);
                            v246.MaxTorque = Vector3.new(0, math.huge, 0);
                            v246.P = math.huge;
                            v246.Parent = l_HumanoidRootPart_10;
                        elseif not v247 and v245 then
                            v245 = false;
                            if v246 then
                                v246:Destroy();
                                v246 = nil;
                            end;
                        end;
                        return;
                    end;
                end;
            end;
            local v251 = nil;
            local v252 = nil;
            local v253 = nil;
            local function v257() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v251 (ref), l_l_LocalPlayer_0_0 (ref), v66 (ref), v231 (ref)
                local v254 = nil;
                v251 = v254;
                if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                    v254 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                    v254.Velocity = Vector3.new(0, 0, 0);
                    v254.RotVelocity = Vector3.new(0, 0, 0);
                    for _, v256 in ipairs(v254:GetChildren()) do
                        if v256:IsA("BodyVelocity") or v256:IsA("BodyAngularVelocity") then
                            v256:Destroy();
                        end;
                    end;
                end;
                v66.Following = true;
                if v66.Summoned then
                    v231();
                end;
            end;
            local function v262(v258) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v257 (ref), v137 (ref), l_l_LocalPlayer_0_0 (ref), v252 (ref), v253 (ref), v66 (ref), v251 (ref)
                v257();
                wait(0.1);
                if not v258 or not v258.Character then
                    v137("Target player not found or no character.");
                    return false;
                else
                    local l_HumanoidRootPart_11 = v258.Character:WaitForChild("HumanoidRootPart");
                    local l_Character_2 = l_l_LocalPlayer_0_0.Character;
                    if not l_Character_2 then
                        v137("Stand character not found.");
                        return false;
                    else
                        local l_HumanoidRootPart_12 = l_Character_2:WaitForChild("HumanoidRootPart");
                        v252 = Instance.new("BodyVelocity");
                        v252.Velocity = Vector3.new(0, 100, 0);
                        v252.MaxForce = Vector3.new(50000, 50000, 50000);
                        v252.P = 1250;
                        v252.Parent = l_HumanoidRootPart_11;
                        v253 = Instance.new("BodyAngularVelocity");
                        v253.AngularVelocity = Vector3.new(10000, 10000, 10000);
                        v253.MaxTorque = Vector3.new(50000, 50000, 50000);
                        v253.P = 1250;
                        v253.Parent = l_HumanoidRootPart_11;
                        v66.Following = false;
                        v66.Summoned = true;
                        v251 = v258;
                        task.spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                            -- upvalues: v251 (ref), v258 (ref), l_Character_2 (ref), l_HumanoidRootPart_11 (ref), l_HumanoidRootPart_12 (ref), v252 (ref), v253 (ref)
                            while v251 == v258 and v258.Character and l_Character_2.Parent do
                                if l_HumanoidRootPart_11 and l_HumanoidRootPart_12 then
                                    l_HumanoidRootPart_12.CFrame = l_HumanoidRootPart_11.CFrame * CFrame.new(0, 3, 2);
                                    v252.Velocity = Vector3.new(math.random(-50, 50), 100 + math.random(0, 50), math.random(-50, 50));
                                end;
                                task.wait();
                            end;
                            if v252 and v252.Parent then
                                v252:Destroy();
                                v252 = nil;
                            end;
                            if v253 and v253.Parent then
                                v253:Destroy();
                                v253 = nil;
                            end;
                        end);
                        return true;
                    end;
                end;
            end;
            l_l_LocalPlayer_0_0.CharacterAdded:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v83 (ref), v89 (ref)
                if v83 then
                    v89(false);
                end;
            end);
            game:GetService("Players").PlayerRemoving:Connect(function(v263) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_l_Players_0_FirstChild_0_0 (ref), v83 (ref), v89 (ref)
                if v263 == l_l_l_Players_0_FirstChild_0_0 and v83 then
                    v89(false);
                end;
            end);
            local function v267(v264) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_Players_1 (ref)
                v264 = v264:lower();
                for _, v266 in pairs(l_Players_1:GetPlayers()) do
                    if v266.Name:lower():sub(1, #v264) == v264 or v266.DisplayName and v266.DisplayName:lower():sub(1, #v264) == v264 then
                        return v266;
                    end;
                end;
                return nil;
            end;
            Create("fling", function(v268) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_l_Players_0_FirstChild_0_0 (ref), v267 (ref), l_l_LocalPlayer_0_0 (ref), v137 (ref), v66 (ref), v251 (ref), v156 (ref), l_l_Main_0_0 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), v231 (ref), v234 (ref)
                local v269 = table.concat(v268, " ");
                local v270 = nil;
                if v269 == "" then
                    v270 = l_l_l_Players_0_FirstChild_0_0;
                else
                    v270 = v267(v269);
                end;
                if not v270 or v270 == l_l_LocalPlayer_0_0 then
                    v137("Player not found.");
                    return;
                elseif not v270.Character or not v270.Character:FindFirstChild("HumanoidRootPart") then
                    v137("Player character not ready.");
                    return;
                else
                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                        l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = false;
                    end;
                    local l_Following_0 = v66.Following;
                    v66.Following = false;
                    v66.Summoned = true;
                    v251 = v270;
                    local l_HumanoidRootPart_13 = v270.Character.HumanoidRootPart;
                    local v273, v274 = v156(l_HumanoidRootPart_13, "fling");
                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                        local l_HumanoidRootPart_14 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                        if v274.Magnitude > 0 then
                            l_HumanoidRootPart_14.CFrame = CFrame.new(v273, v273 + v274);
                        else
                            l_HumanoidRootPart_14.CFrame = CFrame.new(v273, l_HumanoidRootPart_13.Position + l_HumanoidRootPart_13.CFrame.LookVector);
                        end;
                    end;
                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("Humanoid") then
                        if _G.EmoteController then
                            _G.EmoteController.StopAll();
                            _G.EmoteController.Play(l_l_Main_0_0.FlyAnim);
                        end;
                        task.spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                            -- upvalues: l_l_LocalPlayer_0_0 (ref), v251 (ref), v270 (ref), v66 (ref), l_Following_0 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_l_Players_0_FirstChild_0_0 (ref), v231 (ref), v234 (ref)
                            local l_Character_3 = l_l_LocalPlayer_0_0.Character;
                            local v277 = l_Character_3 and l_Character_3:FindFirstChild("HumanoidRootPart");
                            if v277 then
                                local l_BodyVelocity_0 = Instance.new("BodyVelocity");
                                l_BodyVelocity_0.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000);
                                l_BodyVelocity_0.Velocity = Vector3.new(0, 0, 0);
                                l_BodyVelocity_0.Parent = v277;
                                local l_BodyAngularVelocity_0 = Instance.new("BodyAngularVelocity");
                                l_BodyAngularVelocity_0.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
                                l_BodyAngularVelocity_0.AngularVelocity = Vector3.new(0, 9000000000, 0);
                                l_BodyAngularVelocity_0.Parent = v277;
                                while v251 == v270 do
                                    if v270.Character and v270.Character:FindFirstChild("HumanoidRootPart") and v277 then
                                        v277.CFrame = v270.Character.HumanoidRootPart.CFrame;
                                    end;
                                    task.wait();
                                end;
                                l_BodyVelocity_0:Destroy();
                                l_BodyAngularVelocity_0:Destroy();
                                if v277 then
                                    v277.Velocity = Vector3.new(0, 0, 0);
                                    v277.RotVelocity = Vector3.new(0, 0, 0);
                                end;
                            end;
                            v66.Following = l_Following_0;
                            if v66.Following then
                                l_l_l_Players_1_FirstChild_0_0 = l_l_l_Players_0_FirstChild_0_0;
                                v231();
                            else
                                v234();
                            end;
                        end);
                    end;
                    return;
                end;
            end);
            Create({
                "sfling", 
                "stopfling", 
                "sf"
            }, function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v257 (ref), v234 (ref)
                v257();
                wait(0.1);
                v234();
            end);
            Create("say", function(v280) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Main_0_0 (ref), v137 (ref)
                if not l_l_Main_0_0.ChatCommands then
                    return;
                else
                    local v281 = table.concat(v280, " ");
                    if #v281 > 0 then
                        v137(v281);
                    end;
                    return;
                end;
            end);
            Create("clean", function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v257 (ref), v76 (ref), l_l_LocalPlayer_0_0 (ref), l_Part_0 (ref)
                v257();
                if v76 then
                    v76:Stop();
                    v76:Destroy();
                    v76 = nil;
                end;
                for _, v283 in ipairs(l_l_LocalPlayer_0_0.Character:GetDescendants()) do
                    if v283:IsA("BodyAngularVelocity") or v283:IsA("BodyVelocity") then
                        v283:Destroy();
                    end;
                end;
                l_Part_0.CFrame = CFrame.new(0, -100, 0);
            end);
            Create("fly", function(v284) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Main_0_0 (ref), v66 (ref)
                local v285 = table.concat(v284, " ");
                if v285 == "" then
                    return;
                else
                    local l_FlyAnim_0 = l_l_Main_0_0.FlyAnim;
                    l_l_Main_0_0.FlyAnim = v285;
                    if _G.EmoteController.Play(l_l_Main_0_0.FlyAnim) then
                        if v66.Summoned then
                            _G.EmoteController.Play(l_l_Main_0_0.FlyAnim);
                        else
                            _G.EmoteController.Stop();
                        end;
                    else
                        l_l_Main_0_0.FlyAnim = l_FlyAnim_0;
                        local v287 = {};
                        for v288 in pairs(_G.EmoteController.List()) do
                            table.insert(v287, v288);
                        end;
                        table.sort(v287);
                    end;
                    return;
                end;
            end);
            Create("emote", function(v289) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v137 (ref)
                local v290 = (v289[1] or ""):lower();
                local v291 = ({
                    wave = 507770239, 
                    cheer = 507770677, 
                    dance1 = 507771019, 
                    dance2 = 507771955, 
                    dance3 = 507772104, 
                    salute = 4219348371, 
                    laugh = 507770818, 
                    point = 507770453, 
                    clap = 507770818, 
                    shrug = 507771760, 
                    tilt = 507771019, 
                    stadium = 3360689775, 
                    tilt = 3360692915, 
                    salute2 = 3360689775, 
                    zombie = 376546894, 
                    robot = 3360689775, 
                    floss = 3695334276, 
                    hype = 3695331394, 
                    tpose = 3489173896, 
                    armwave = 3489173415, 
                    fashionpose = 3489173413, 
                    dizzy = 3489173537, 
                    twirl = 3489174191, 
                    dab = 2482632604, 
                    laugh2 = 33796059, 
                    surrender = 4018379474, 
                    nod = 4018381090, 
                    bow = 4018378074, 
                    kick = 4018384764, 
                    faint = 4018379379, 
                    excited = 4018380244, 
                    happy = 4018380790, 
                    scared = 4018382681, 
                    bored = 4018376754
                })[v290];
                if not v291 then
                    v137("Unknown emote. Try: wave, cheer, dance1, dance2, salute");
                    return;
                else
                    if _G.EmoteController then
                        _G.EmoteController.StopAll();
                        _G.EmoteController.Play(v291);
                    else
                        v137("Emote system not available.");
                    end;
                    return;
                end;
            end);
            local v292 = {};
            local l_l_Players_1_FirstChild_3 = l_Players_1:FindFirstChild(l_l_Owner_0_0);
            local function v296(v294, v295) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Owner_1_0 (ref), l_l_Owner_0_0 (ref)
                if v294.Name == l_l_Owner_1_0 then
                    return true;
                elseif v294.Name == l_l_Owner_0_0 and v295:lower() == "revert" and l_l_Owner_1_0 ~= l_l_Owner_0_0 then
                    return true;
                else
                    return false;
                end;
            end;
            local function v300(v297) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Main_0_0 (ref)
                if type(v297) ~= "string" then
                    return nil;
                else
                    local v298 = l_l_Main_0_0.CustomPrefix or "!";
                    local v299 = (l_l_Main_0_0.PrefixAT or "Before"):lower();
                    v297 = v297:lower():gsub("^%s+", ""):gsub("%s+$", "");
                    if v299 == "before" then
                        if v297:sub(1, #v298) == v298 then
                            return v297:sub(#v298 + 1);
                        end;
                    elseif v299 == "after" and v297:sub(-#v298) == v298 then
                        return v297:sub(1, #v297 - #v298);
                    end;
                    return v297;
                end;
            end;
            local v301 = "";
            local v302 = nil;
            local v303 = 0;
            local function v313(v304, v305) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v301 (ref), v302 (ref), v303 (ref), l_l_Main_0_0 (ref), l_l_Owner_1_0 (ref), v234 (ref), v300 (ref), v296 (ref), l_SocietyStandCommands_0 (ref)
                if not v305 then
                    return;
                elseif v304 == v301 and v305 == v302 and os.clock() - v303 < 0.2 then
                    return;
                else
                    local l_v304_0 = v304;
                    local l_v305_0 = v305;
                    v303 = os.clock();
                    v302 = l_v305_0;
                    v301 = l_v304_0;
                    if l_l_Main_0_0.CustomSummon and v304:lower() == l_l_Main_0_0.CustomSummon:lower() and v305.Name == l_l_Owner_1_0 then
                        v234();
                        return;
                    else
                        l_v304_0 = {};
                        for v308 in v304:gmatch("%S+") do
                            table.insert(l_v304_0, v308);
                        end;
                        if #l_v304_0 == 0 then
                            return;
                        else
                            l_v305_0 = l_v304_0[1];
                            local v309 = {};
                            for v310 = 2, #l_v304_0 do
                                table.insert(v309, l_v304_0[v310]);
                            end;
                            local v311 = v300(l_v305_0);
                            if not v311 then
                                return;
                            elseif not v296(v305, v311) then
                                return;
                            else
                                local v312 = l_SocietyStandCommands_0[v311:lower()] or getgenv().SocietyStandAPI and getgenv().SocietyStandAPI.Commands and getgenv().SocietyStandAPI.Commands[v311:lower()];
                                if type(v312) ~= "function" then
                                    return;
                                else
                                    pcall(v312, v309, v305);
                                    return;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            local function v315(v314) --[[ Line: 0 ]] --[[ Name:  ]]
                if type(v314) ~= "string" then
                    return "";
                else
                    v314 = v314:gsub("^%s+", ""):gsub("%s+$", "");
                    if v314:sub(1, 3):lower() == "/e " then
                        v314 = v314:sub(4);
                    end;
                    return v314;
                end;
            end;
            local function v328(v316, v317) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v315 (ref), v301 (ref), v302 (ref), v303 (ref), l_l_Main_0_0 (ref), l_l_Owner_1_0 (ref), v234 (ref), v300 (ref), v296 (ref), l_SocietyStandCommands_0 (ref)
                local l_status_2, l_result_2 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: v317 (ref), v315 (ref), v316 (ref), v301 (ref), v302 (ref), v303 (ref), l_l_Main_0_0 (ref), l_l_Owner_1_0 (ref), v234 (ref), v300 (ref), v296 (ref), l_SocietyStandCommands_0 (ref)
                    if not v317 then
                        return;
                    else
                        local v318 = v315(v316);
                        if v318 == "" then
                            return;
                        elseif v318 == v301 and v317 == v302 and os.clock() - v303 < 0.2 then
                            return;
                        else
                            local l_v318_0 = v318;
                            local l_v317_0 = v317;
                            v303 = os.clock();
                            v302 = l_v317_0;
                            v301 = l_v318_0;
                            if l_l_Main_0_0.CustomSummon and v318:lower() == l_l_Main_0_0.CustomSummon:lower() and v317.Name == l_l_Owner_1_0 then
                                v234();
                                return;
                            else
                                l_v318_0 = {};
                                for v321 in v318:gmatch("%S+") do
                                    table.insert(l_v318_0, v321);
                                end;
                                if #l_v318_0 == 0 then
                                    return;
                                else
                                    l_v317_0 = l_v318_0[1];
                                    local v322 = {};
                                    for v323 = 2, #l_v318_0 do
                                        table.insert(v322, l_v318_0[v323]);
                                    end;
                                    local v324 = v300(l_v317_0);
                                    if not v324 then
                                        return;
                                    elseif not v296(v317, v324) then
                                        return;
                                    else
                                        local v325 = l_SocietyStandCommands_0[v324:lower()] or getgenv().SocietyStandAPI and getgenv().SocietyStandAPI.Commands and getgenv().SocietyStandAPI.Commands[v324:lower()];
                                        if type(v325) ~= "function" then
                                            return;
                                        else
                                            v325(v322, v317);
                                            return;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end);
                if not l_status_2 then
                    warn("[CHAT ERROR]:", l_result_2);
                end;
            end;
            local l_TextChatService_1 = game:GetService("TextChatService");
            local function v338(v330) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_TextChatService_1 (ref), v328 (ref)
                if l_TextChatService_1.ChatVersion == Enum.ChatVersion.TextChatService then
                    local l_RBXGeneral_1 = l_TextChatService_1.TextChannels:FindFirstChild("RBXGeneral");
                    if l_RBXGeneral_1 then
                        l_RBXGeneral_1.OnIncomingMessage = function(v332) --[[ Line: 0 ]] --[[ Name:  ]]
                            -- upvalues: v330 (ref), v328 (ref)
                            if not v332.TextSource then
                                return;
                            else
                                local l_PlayerByUserId_0 = game.Players:GetPlayerByUserId(v332.TextSource.UserId);
                                if not l_PlayerByUserId_0 or l_PlayerByUserId_0 ~= v330 then
                                    return;
                                else
                                    local l_Text_0 = v332.Text;
                                    if l_Text_0:sub(1, 3):lower() == "/e " then
                                        local v335 = l_Text_0:sub(4);
                                        print("[CHAT HEARD - /e]:", v335);
                                        v328(v335, l_PlayerByUserId_0);
                                    else
                                        print("[CHAT HEARD - REGULAR]:", l_Text_0);
                                        v328(l_Text_0, l_PlayerByUserId_0);
                                    end;
                                    return;
                                end;
                            end;
                        end;
                        print("[DEBUG] Bound to TextChatService for:", v330.Name);
                    end;
                else
                    v330.Chatted:Connect(function(v336) --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v328 (ref), v330 (ref)
                        print("[CHAT HEARD - OLD]:", v336);
                        if v336:sub(1, 3):lower() == "/e " then
                            local v337 = v336:sub(4);
                            v328(v337, v330);
                        else
                            v328(v336, v330);
                        end;
                    end);
                    print("[DEBUG] Bound to legacy .Chatted for:", v330.Name);
                end;
            end;
            local function v340(v339) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Owner_0_0 (ref), l_l_Owner_1_0 (ref), l_l_Players_1_FirstChild_3 (ref), v338 (ref)
                print("Player joined:", v339.Name);
                if v339.Name == l_l_Owner_0_0 or v339.Name == l_l_Owner_1_0 then
                    l_l_Players_1_FirstChild_3 = v339;
                    print("[OWNER JOINED] Setting ownerPlayer to:", v339.Name);
                    v338(v339);
                end;
            end;
            for _, v342 in ipairs(l_Players_1:GetPlayers()) do
                v340(v342);
            end;
            l_Players_1.PlayerAdded:Connect(v340);
            l_Players_1.PlayerRemoving:Connect(function(v343) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Players_1_FirstChild_3 (ref), v232 (ref), v137 (ref)
                if v343 == l_l_Players_1_FirstChild_3 then
                    v232();
                    v137("Owner left. Vanishing.");
                end;
            end);
            Create("transfer", function(v344, v345) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Owner_1_0 (ref), v137 (ref), v267 (ref), l_l_LocalPlayer_0_0 (ref), v292 (ref), l_l_Players_1_FirstChild_3 (ref), l_l_Main_0_0 (ref), l_TextChatService_1 (ref), v328 (ref)
                if v345.Name ~= l_l_Owner_1_0 then
                    v137("Only the current owner can transfer ownership.");
                    return;
                else
                    local v346 = table.concat(v344, " ");
                    if v346 == "" then
                        v137("Usage: transfer <player>");
                        return;
                    else
                        local v347 = v267(v346);
                        if not v347 then
                            v137("Player '" .. v346 .. "' not found.");
                            return;
                        elseif v347 == l_l_LocalPlayer_0_0 then
                            v137("Cannot transfer ownership to yourself.");
                            return;
                        elseif not v347 or not v347.Parent then
                            v137("Target player is no longer in the game.");
                            return;
                        else
                            for _, v349 in ipairs(v292) do
                                v349:Disconnect();
                            end;
                            v292 = {};
                            local l_l_l_Owner_1_0_0 = l_l_Owner_1_0;
                            l_l_Owner_1_0 = v347.Name;
                            l_l_Players_1_FirstChild_3 = v347;
                            if getgenv().SocietyStand then
                                getgenv().SocietyStand.Main.Owner = v347.Name;
                                l_l_Main_0_0.Owner = v347.Name;
                            end;
                            local function v359() --[[ Line: 0 ]] --[[ Name:  ]]
                                -- upvalues: l_TextChatService_1 (ref), v347 (ref), v328 (ref), v292 (ref)
                                if l_TextChatService_1.ChatVersion == Enum.ChatVersion.TextChatService then
                                    local l_RBXGeneral_2 = l_TextChatService_1.TextChannels:FindFirstChild("RBXGeneral");
                                    if l_RBXGeneral_2 then
                                        l_RBXGeneral_2.OnIncomingMessage = function(v352) --[[ Line: 0 ]] --[[ Name:  ]]
                                            -- upvalues: v347 (ref), v328 (ref)
                                            if not v352.TextSource then
                                                return;
                                            else
                                                local l_PlayerByUserId_1 = game.Players:GetPlayerByUserId(v352.TextSource.UserId);
                                                if not l_PlayerByUserId_1 or l_PlayerByUserId_1 ~= v347 then
                                                    return;
                                                else
                                                    local l_Text_1 = v352.Text;
                                                    if l_Text_1:sub(1, 3):lower() == "/e " then
                                                        local v355 = l_Text_1:sub(4);
                                                        v328(v355, l_PlayerByUserId_1);
                                                    else
                                                        v328(l_Text_1, l_PlayerByUserId_1);
                                                    end;
                                                    return;
                                                end;
                                            end;
                                        end;
                                    end;
                                else
                                    local v358 = v347.Chatted:Connect(function(v356) --[[ Line: 0 ]] --[[ Name:  ]]
                                        -- upvalues: v328 (ref), v347 (ref)
                                        if v356:sub(1, 3):lower() == "/e " then
                                            local v357 = v356:sub(4);
                                            v328(v357, v347);
                                        else
                                            v328(v356, v347);
                                        end;
                                    end);
                                    table.insert(v292, v358);
                                end;
                            end;
                            local l_status_3, l_result_3 = pcall(v359);
                            if not l_status_3 then
                                warn("Failed to setup chat listener for new owner:", l_result_3);
                                task.wait(1);
                                pcall(v359);
                            end;
                            v137("Stand ownership transferred from " .. l_l_l_Owner_1_0_0 .. " to " .. v347.Name);
                            task.spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                task.wait(2);
                                registerPassword();
                            end);
                            return;
                        end;
                    end;
                end;
            end);
            Create("revert", function(_, v363) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Owner_0_0 (ref), v137 (ref), l_Players_1 (ref), l_l_Owner_1_0 (ref), l_l_Players_1_FirstChild_3 (ref), v313 (ref), v292 (ref)
                if v363.Name ~= l_l_Owner_0_0 then
                    v137("Only the original owner can revert ownership.");
                    return;
                else
                    local l_l_Players_1_FirstChild_4 = l_Players_1:FindFirstChild(l_l_Owner_0_0);
                    if not l_l_Players_1_FirstChild_4 then
                        v137("Original owner not found in server.");
                        return;
                    else
                        l_l_Owner_1_0 = l_l_Owner_0_0;
                        l_l_Players_1_FirstChild_3 = l_l_Players_1_FirstChild_4;
                        v137("Stand ownership reverted to " .. l_l_Owner_0_0);
                        local v366 = target.Chatted.Connect(target.Chatted, function(v365) --[[ Line: 0 ]] --[[ Name:  ]]
                            -- upvalues: v313 (ref)
                            v313(v365, target);
                        end);
                        table.insert(v292, v366);
                        return;
                    end;
                end;
            end);
            l_Players_1.PlayerAdded:Connect(function(v367) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Owner_1_0 (ref), l_l_Players_1_FirstChild_0 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_Players_1_FirstChild_3 (ref)
                if v367.Name == l_l_Owner_1_0 then
                    l_l_Players_1_FirstChild_0 = v367;
                    l_l_l_Players_1_FirstChild_0_0 = v367;
                    l_l_Players_1_FirstChild_3 = v367;
                end;
            end);
            Create("stop", function(_, v369) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Owner_1_0 (ref), v78 (ref)
                if v369.Name ~= l_l_Owner_1_0 then
                    return;
                else
                    v78();
                    return;
                end;
            end);
            local v370 = "rbxassetid://507770453";
            local v371 = 1.5;
            Create("punch", function(v372) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Players_1_FirstChild_3 (ref), v267 (ref), l_l_LocalPlayer_0_0 (ref), v137 (ref), v66 (ref), v156 (ref), v370 (ref), v371 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), v257 (ref), v231 (ref), v234 (ref)
                local v373 = table.concat(v372, " ");
                local v374 = nil;
                if v373 == "" then
                    v374 = l_l_Players_1_FirstChild_3;
                else
                    v374 = v267(v373);
                end;
                if not v374 or v374 == l_l_LocalPlayer_0_0 then
                    v137("Player not found.");
                    return;
                elseif not v374.Character or not v374.Character:FindFirstChild("HumanoidRootPart") then
                    v137("Player character not ready.");
                    return;
                else
                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                        l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = false;
                    end;
                    local l_Following_1 = v66.Following;
                    v66.Following = false;
                    v66.Summoned = true;
                    local l_HumanoidRootPart_15 = v374.Character.HumanoidRootPart;
                    local v377, v378 = v156(l_HumanoidRootPart_15, "punch");
                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                        local l_HumanoidRootPart_16 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                        if v378.Magnitude > 0 then
                            l_HumanoidRootPart_16.CFrame = CFrame.new(v377, v377 + v378);
                        else
                            l_HumanoidRootPart_16.CFrame = CFrame.new(v377, l_HumanoidRootPart_15.Position + l_HumanoidRootPart_15.CFrame.LookVector);
                        end;
                    end;
                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("Humanoid") then
                        local l_Animation_1 = Instance.new("Animation");
                        l_Animation_1.AnimationId = v370;
                        local v381 = l_l_LocalPlayer_0_0.Character.Humanoid:LoadAnimation(l_Animation_1);
                        v381:Play();
                        do
                            local l_v381_0 = v381;
                            task.spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                -- upvalues: l_l_LocalPlayer_0_0 (ref), v371 (ref), v374 (ref), l_v381_0 (ref), v66 (ref), l_Following_1 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_Players_1_FirstChild_3 (ref), v257 (ref), v231 (ref), v234 (ref)
                                local l_Character_4 = l_l_LocalPlayer_0_0.Character;
                                local v384 = l_Character_4 and l_Character_4:FindFirstChild("HumanoidRootPart");
                                if v384 then
                                    local l_BodyVelocity_1 = Instance.new("BodyVelocity");
                                    l_BodyVelocity_1.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000);
                                    l_BodyVelocity_1.Velocity = Vector3.new(0, 0, 0);
                                    l_BodyVelocity_1.Parent = v384;
                                    local l_BodyAngularVelocity_1 = Instance.new("BodyAngularVelocity");
                                    l_BodyAngularVelocity_1.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
                                    l_BodyAngularVelocity_1.AngularVelocity = Vector3.new(0, 9000000000, 0);
                                    l_BodyAngularVelocity_1.Parent = v384;
                                    local v387 = tick();
                                    while tick() - v387 < v371 do
                                        if v374.Character and v374.Character:FindFirstChild("HumanoidRootPart") then
                                            v384.CFrame = v374.Character.HumanoidRootPart.CFrame;
                                        end;
                                        task.wait();
                                    end;
                                    l_BodyVelocity_1:Destroy();
                                    l_BodyAngularVelocity_1:Destroy();
                                    if v384 then
                                        v384.Velocity = Vector3.new(0, 0, 0);
                                        v384.RotVelocity = Vector3.new(0, 0, 0);
                                    end;
                                end;
                                if l_v381_0 then
                                    l_v381_0:Stop();
                                end;
                                v66.Following = l_Following_1;
                                if v66.Following then
                                    l_l_l_Players_1_FirstChild_0_0 = l_l_Players_1_FirstChild_3;
                                    v257();
                                    v231();
                                else
                                    v257();
                                    v234();
                                end;
                            end);
                        end;
                    end;
                    return;
                end;
            end);
            Create("slam", function(v388) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Players_1_FirstChild_3 (ref), v267 (ref), l_l_LocalPlayer_0_0 (ref), v137 (ref), v66 (ref), v156 (ref), v262 (ref), v257 (ref), v234 (ref)
                local v389 = table.concat(v388, " ");
                local v390 = nil;
                if v389 == "" then
                    v390 = l_l_Players_1_FirstChild_3;
                else
                    v390 = v267(v389);
                end;
                if not v390 or v390 == l_l_LocalPlayer_0_0 then
                    v137("Player not found.");
                    return;
                elseif not v390.Character or not v390.Character:FindFirstChild("HumanoidRootPart") then
                    v137("Player character not ready.");
                    return;
                else
                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                        l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = false;
                    end;
                    local l_Following_2 = v66.Following;
                    v66.Following = false;
                    v66.Summoned = true;
                    local l_HumanoidRootPart_17 = v390.Character.HumanoidRootPart;
                    local v393, _ = v156(l_HumanoidRootPart_17, "slam");
                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                        l_l_LocalPlayer_0_0.Character.HumanoidRootPart.CFrame = CFrame.new(v393 + Vector3.new(0, 0, -3), v393);
                    end;
                    v137("Behind You");
                    if v262(v390) then
                        delay(2, function() --[[ Line: 0 ]] --[[ Name:  ]]
                            -- upvalues: v257 (ref), l_l_LocalPlayer_0_0 (ref), v66 (ref), l_Following_2 (ref), v234 (ref)
                            v257();
                            if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                local l_HumanoidRootPart_18 = l_l_LocalPlayer_0_0.Character.HumanoidRootPart;
                                l_HumanoidRootPart_18.Velocity = Vector3.new(0, 0, 0);
                                l_HumanoidRootPart_18.RotVelocity = Vector3.new(0, 0, 0);
                            end;
                            v66.Following = l_Following_2;
                            v234();
                        end);
                    end;
                    return;
                end;
            end);
            Create("roof", function(v396) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Players_1_FirstChild_3 (ref), v267 (ref), l_l_LocalPlayer_0_0 (ref), v137 (ref), v66 (ref), v156 (ref), v262 (ref), v257 (ref), v234 (ref)
                local v397 = table.concat(v396, " ");
                local v398 = nil;
                if v397 == "" then
                    v398 = l_l_Players_1_FirstChild_3;
                else
                    v398 = v267(v397);
                end;
                if not v398 or v398 == l_l_LocalPlayer_0_0 then
                    v137("Player not found.");
                    return;
                elseif not v398.Character or not v398.Character:FindFirstChild("HumanoidRootPart") then
                    v137("Player character not ready.");
                    return;
                else
                    if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                        l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = false;
                    end;
                    local l_Following_3 = v66.Following;
                    v66.Following = false;
                    v66.Summoned = true;
                    local l_HumanoidRootPart_19 = v398.Character.HumanoidRootPart;
                    local l_Character_5 = l_l_LocalPlayer_0_0.Character;
                    if not l_Character_5 or not l_Character_5:FindFirstChild("HumanoidRootPart") then
                        return;
                    else
                        local l_HumanoidRootPart_20 = l_Character_5.HumanoidRootPart;
                        local v403, _ = v156(l_HumanoidRootPart_19, "roof");
                        l_HumanoidRootPart_20.CFrame = CFrame.new(v403 + Vector3.new(0, 5, 0), v403);
                        v137("Look Up!");
                        delay(1, function() --[[ Line: 0 ]] --[[ Name:  ]]
                            -- upvalues: v398 (ref), l_HumanoidRootPart_19 (ref), v156 (ref), l_HumanoidRootPart_20 (ref), v262 (ref), v257 (ref), v66 (ref), l_Following_3 (ref), v234 (ref)
                            if not v398.Character or not v398.Character:FindFirstChild("HumanoidRootPart") then
                                return;
                            else
                                l_HumanoidRootPart_19 = v398.Character.HumanoidRootPart;
                                local v405, v406 = v156(l_HumanoidRootPart_19, "roof");
                                l_HumanoidRootPart_20.CFrame = CFrame.new(v405, v405 + v406);
                                if v262(v398) then
                                    delay(2, function() --[[ Line: 0 ]] --[[ Name:  ]]
                                        -- upvalues: v257 (ref), l_HumanoidRootPart_20 (ref), v66 (ref), l_Following_3 (ref), v234 (ref)
                                        v257();
                                        local l_l_HumanoidRootPart_20_0 = l_HumanoidRootPart_20;
                                        local l_l_HumanoidRootPart_20_1 = l_HumanoidRootPart_20;
                                        local v409 = Vector3.new();
                                        l_l_HumanoidRootPart_20_1.RotVelocity = Vector3.new();
                                        l_l_HumanoidRootPart_20_0.Velocity = v409;
                                        v66.Following = l_Following_3;
                                        v234();
                                    end);
                                end;
                                return;
                            end;
                        end);
                        return;
                    end;
                end;
            end);
            local v410 = false;
            local v411 = nil;
            local v412 = nil;
            local v413 = nil;
            Create("lift", function(v414) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v410 (ref), v412 (ref), v413 (ref), v137 (ref), v411 (ref), l_l_Players_1_FirstChild_3 (ref), v267 (ref), l_l_LocalPlayer_0_0 (ref), v66 (ref), v156 (ref)
                if v410 then
                    v410 = false;
                    if v412 then
                        v412:Destroy();
                        v412 = nil;
                    end;
                    if v413 then
                        v413:Disconnect();
                        v413 = nil;
                    end;
                    v137("Stopped lifting.");
                    return;
                else
                    local v415 = table.concat(v414, " ");
                    if v415 == "" then
                        v411 = l_l_Players_1_FirstChild_3;
                    else
                        v411 = v267(v415);
                    end;
                    if not v411 or not v411.Character or not v411.Character:FindFirstChild("HumanoidRootPart") then
                        v137("Target not found.");
                        return;
                    else
                        if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                            l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = false;
                        end;
                        v410 = true;
                        v137("Rise Up!");
                        v66.Following = false;
                        v66.Summoned = true;
                        local l_Character_6 = l_l_LocalPlayer_0_0.Character;
                        if not l_Character_6 or not l_Character_6:FindFirstChild("HumanoidRootPart") then
                            return;
                        else
                            local l_HumanoidRootPart_21 = l_Character_6.HumanoidRootPart;
                            local l_HumanoidRootPart_22 = v411.Character.HumanoidRootPart;
                            local v419, _ = v156(l_HumanoidRootPart_22, "lift");
                            l_HumanoidRootPart_21.CFrame = CFrame.new(v419 - Vector3.new(0, 4, 0)) * CFrame.Angles(0, math.rad(90), 0);
                            v412 = Instance.new("BodyVelocity");
                            v412.MaxForce = Vector3.new(0, 1000000, 0);
                            v412.Velocity = Vector3.new(0, 10, 0);
                            v412.Parent = l_HumanoidRootPart_21;
                            v413 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                -- upvalues: v410 (ref), l_HumanoidRootPart_22 (ref), l_HumanoidRootPart_21 (ref), v156 (ref)
                                if not v410 then
                                    return;
                                elseif not l_HumanoidRootPart_22 or not l_HumanoidRootPart_22.Parent then
                                    return;
                                elseif not l_HumanoidRootPart_21 or not l_HumanoidRootPart_21.Parent then
                                    return;
                                else
                                    local v421, _ = v156(l_HumanoidRootPart_22, "lift");
                                    if (Vector2.new(l_HumanoidRootPart_21.Position.X, l_HumanoidRootPart_21.Position.Z) - Vector2.new(v421.X, v421.Z)).Magnitude > 5 then
                                        l_HumanoidRootPart_21.CFrame = CFrame.new(v421 - Vector3.new(0, 4, 0)) * CFrame.Angles(0, math.rad(90), 0);
                                    end;
                                    return;
                                end;
                            end);
                            return;
                        end;
                    end;
                end;
            end);
            Create("benx", function(v423, _) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v66 (ref), v77 (ref), v234 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_Players_1_FirstChild_3 (ref), v267 (ref), v137 (ref)
                if v66.Benx then
                    v66.Benx = false;
                    if _G.EmoteController then
                        _G.EmoteController.StopAll();
                    end;
                    v77();
                    v234();
                    return;
                else
                    local v425 = table.concat(v423, " ");
                    if v425 == "" then
                        l_l_l_Players_1_FirstChild_0_0 = l_l_Players_1_FirstChild_3;
                    else
                        l_l_l_Players_1_FirstChild_0_0 = v267(v425);
                    end;
                    if not l_l_l_Players_1_FirstChild_0_0 or not l_l_l_Players_1_FirstChild_0_0.Character then
                        v137("Target not found.");
                        return;
                    else
                        v66.Summoned = true;
                        v66.Following = false;
                        v66.Benx = true;
                        if _G.EmoteController then
                            _G.EmoteController.StopAll();
                            task.wait(0.1);
                            _G.EmoteController.Play("benx");
                        end;
                        return;
                    end;
                end;
            end);
            Create("dog", function(v426, _) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v66 (ref), v77 (ref), v234 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_Players_1_FirstChild_3 (ref), v267 (ref), v137 (ref), l_l_LocalPlayer_0_0 (ref)
                if v66.Sit then
                    v66.Sit = false;
                    if v66.DogConn then
                        v66.DogConn:Disconnect();
                        v66.DogConn = nil;
                    end;
                    if v66.DeathConn then
                        v66.DeathConn:Disconnect();
                        v66.DeathConn = nil;
                    end;
                    if _G.EmoteController then
                        _G.EmoteController.StopAll();
                    end;
                    v77();
                    v234();
                    return;
                else
                    local v428 = table.concat(v426, " ");
                    if v428 == "" then
                        l_l_l_Players_1_FirstChild_0_0 = l_l_Players_1_FirstChild_3;
                    else
                        l_l_l_Players_1_FirstChild_0_0 = v267(v428);
                    end;
                    if not l_l_l_Players_1_FirstChild_0_0 or not l_l_l_Players_1_FirstChild_0_0.Character then
                        v137("Target not found.");
                        return;
                    else
                        local l_Humanoid_3 = l_l_l_Players_1_FirstChild_0_0.Character:FindFirstChildOfClass("Humanoid");
                        if not l_Humanoid_3 then
                            v137("Target has no humanoid.");
                            return;
                        else
                            if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = false;
                            end;
                            v66.Summoned = true;
                            v66.Following = false;
                            v66.Sit = true;
                            if _G.EmoteController then
                                local v430 = nil;
                                do
                                    local l_v430_0 = v430;
                                    local function v433(v432) --[[ Line: 0 ]] --[[ Name:  ]]
                                        -- upvalues: l_v430_0 (ref)
                                        if l_v430_0 ~= v432 then
                                            _G.EmoteController.StopAll();
                                            _G.EmoteController.Play(v432);
                                            l_v430_0 = v432;
                                        end;
                                    end;
                                    v433("doggysit");
                                    v66.DeathConn = l_Humanoid_3.Died:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                        -- upvalues: v66 (ref), v77 (ref), v234 (ref)
                                        v66.Sit = false;
                                        if v66.DogConn then
                                            v66.DogConn:Disconnect();
                                            v66.DogConn = nil;
                                        end;
                                        if v66.DeathConn then
                                            v66.DeathConn:Disconnect();
                                            v66.DeathConn = nil;
                                        end;
                                        v77();
                                        v234();
                                    end);
                                    v66.DogConn = l_Humanoid_3.Running:Connect(function(v434) --[[ Line: 0 ]] --[[ Name:  ]]
                                        -- upvalues: v66 (ref), v433 (ref)
                                        if not v66.Sit then
                                            return;
                                        else
                                            if v434 > 0 then
                                                v433("doggyrun");
                                            else
                                                v433("doggysit");
                                            end;
                                            return;
                                        end;
                                    end);
                                end;
                            end;
                            return;
                        end;
                    end;
                end;
            end);
            Create("blow", function(v435, _) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v66 (ref), v77 (ref), v234 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_Players_1_FirstChild_3 (ref), v267 (ref), v137 (ref), l_l_LocalPlayer_0_0 (ref), v170 (ref)
                if v66.Blow then
                    v66.Blow = false;
                    if _G.EmoteController then
                        _G.EmoteController.StopAll();
                    end;
                    v77();
                    v234();
                    return;
                else
                    local v437 = table.concat(v435, " ");
                    if v437 == "" then
                        l_l_l_Players_1_FirstChild_0_0 = l_l_Players_1_FirstChild_3;
                    else
                        l_l_l_Players_1_FirstChild_0_0 = v267(v437);
                    end;
                    if not l_l_l_Players_1_FirstChild_0_0 or not l_l_l_Players_1_FirstChild_0_0.Character or not l_l_l_Players_1_FirstChild_0_0.Character:FindFirstChild("HumanoidRootPart") then
                        v137("Target not found.");
                        return;
                    else
                        if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                            l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = false;
                        end;
                        v66.Summoned = true;
                        v66.Following = false;
                        v66.Blow = true;
                        v170 = 0;
                        if _G.EmoteController then
                            _G.EmoteController.StopAll();
                            _G.EmoteController.Play("blow");
                        end;
                        return;
                    end;
                end;
            end);
            Create("doggy", function(v438, _) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v66 (ref), v77 (ref), v234 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_Players_1_FirstChild_3 (ref), v267 (ref), v137 (ref), l_l_LocalPlayer_0_0 (ref), v171 (ref)
                if v66.Doggy then
                    v66.Doggy = false;
                    if _G.EmoteController then
                        _G.EmoteController.StopAll();
                    end;
                    v77();
                    v234();
                    return;
                else
                    local v440 = table.concat(v438, " ");
                    if v440 == "" then
                        l_l_l_Players_1_FirstChild_0_0 = l_l_Players_1_FirstChild_3;
                    else
                        l_l_l_Players_1_FirstChild_0_0 = v267(v440);
                    end;
                    if not l_l_l_Players_1_FirstChild_0_0 or not l_l_l_Players_1_FirstChild_0_0.Character or not l_l_l_Players_1_FirstChild_0_0.Character:FindFirstChild("HumanoidRootPart") then
                        v137("Target not found.");
                        return;
                    else
                        if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                            l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = false;
                        end;
                        v66.Summoned = true;
                        v66.Following = false;
                        v66.Doggy = true;
                        v171 = 0;
                        if _G.EmoteController then
                            _G.EmoteController.StopAll();
                            _G.EmoteController.Play("doggy");
                        end;
                        return;
                    end;
                end;
            end);
            local v441 = false;
            local v442 = nil;
            local v443 = 12;
            local v444 = 5;
            local v445 = 3;
            local v446 = {};
            Create("fguard", function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v441 (ref), v137 (ref), v442 (ref), l_RunService_0 (ref), v66 (ref), l_l_Players_1_FirstChild_3 (ref), l_Players_1 (ref), l_l_LocalPlayer_0_0 (ref), v443 (ref), v444 (ref), v446 (ref), v445 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), v231 (ref)
                if not v441 then
                    v137("Fling Guard activated!");
                    v441 = true;
                    v442 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v441 (ref), v66 (ref), l_l_Players_1_FirstChild_3 (ref), l_Players_1 (ref), l_l_LocalPlayer_0_0 (ref), v443 (ref), v444 (ref), v446 (ref), v137 (ref), v445 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), v231 (ref)
                        if not v441 then
                            return;
                        elseif not v66.Summoned or not l_l_Players_1_FirstChild_3 or not l_l_Players_1_FirstChild_3.Character then
                            return;
                        else
                            local l_HumanoidRootPart_23 = l_l_Players_1_FirstChild_3.Character:FindFirstChild("HumanoidRootPart");
                            if not l_HumanoidRootPart_23 then
                                return;
                            else
                                for _, v449 in pairs(l_Players_1:GetPlayers()) do
                                    do
                                        local l_v449_0 = v449;
                                        if l_v449_0 ~= l_l_LocalPlayer_0_0 and l_v449_0 ~= l_l_Players_1_FirstChild_3 and l_v449_0.Character and l_v449_0.Character:FindFirstChild("HumanoidRootPart") then
                                            local l_Magnitude_2 = (l_v449_0.Character.HumanoidRootPart.Position - l_HumanoidRootPart_23.Position).Magnitude;
                                            local v452 = tostring(l_v449_0.UserId);
                                            do
                                                local l_v452_0 = v452;
                                                if l_Magnitude_2 <= v443 and v444 < l_Magnitude_2 then
                                                    if not v446[l_v452_0] then
                                                        v446[l_v452_0] = {
                                                            startTime = tick(), 
                                                            flingActive = true
                                                        };
                                                        task.spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                                            -- upvalues: v66 (ref), l_l_LocalPlayer_0_0 (ref), l_v449_0 (ref), v137 (ref), v446 (ref), l_v452_0 (ref), v445 (ref), l_HumanoidRootPart_23 (ref), v443 (ref), v444 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_Players_1_FirstChild_3 (ref), v231 (ref)
                                                            local l_Following_4 = v66.Following;
                                                            v66.Following = false;
                                                            v66.Summoned = true;
                                                            local l_Character_7 = l_l_LocalPlayer_0_0.Character;
                                                            local v456 = l_Character_7 and l_Character_7:FindFirstChild("HumanoidRootPart");
                                                            if v456 then
                                                                local l_BodyVelocity_2 = Instance.new("BodyVelocity");
                                                                l_BodyVelocity_2.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000);
                                                                l_BodyVelocity_2.Velocity = Vector3.new(0, 0, 0);
                                                                l_BodyVelocity_2.Parent = v456;
                                                                local l_BodyAngularVelocity_2 = Instance.new("BodyAngularVelocity");
                                                                l_BodyAngularVelocity_2.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
                                                                l_BodyAngularVelocity_2.AngularVelocity = Vector3.new(0, 9000000000, 0);
                                                                l_BodyAngularVelocity_2.Parent = v456;
                                                                local v459 = tick();
                                                                local l_Name_0 = l_v449_0.Name;
                                                                v137("Fling Guard: Protecting from " .. l_Name_0);
                                                                while v446[l_v452_0] and v446[l_v452_0].flingActive and tick() - v459 < v445 and l_v449_0.Character and l_v449_0.Character:FindFirstChild("HumanoidRootPart") do
                                                                    local l_HumanoidRootPart_24 = l_v449_0.Character.HumanoidRootPart;
                                                                    local l_Magnitude_3 = (l_HumanoidRootPart_24.Position - l_HumanoidRootPart_23.Position).Magnitude;
                                                                    if v443 >= l_Magnitude_3 and l_Magnitude_3 > v444 then
                                                                        v456.CFrame = l_HumanoidRootPart_24.CFrame;
                                                                        task.wait();
                                                                    else
                                                                        break;
                                                                    end;
                                                                end;
                                                                l_BodyVelocity_2:Destroy();
                                                                l_BodyAngularVelocity_2:Destroy();
                                                                if v456 then
                                                                    v456.Velocity = Vector3.new(0, 0, 0);
                                                                    v456.RotVelocity = Vector3.new(0, 0, 0);
                                                                end;
                                                                v446[l_v452_0] = nil;
                                                            end;
                                                            v66.Following = l_Following_4;
                                                            if v66.Following then
                                                                l_l_l_Players_1_FirstChild_0_0 = l_l_Players_1_FirstChild_3;
                                                                v231();
                                                            end;
                                                        end);
                                                    end;
                                                elseif v446[l_v452_0] then
                                                    v446[l_v452_0].flingActive = false;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                                for v463, _ in pairs(v446) do
                                    local l_l_Players_1_PlayerByUserId_0 = l_Players_1:GetPlayerByUserId(tonumber(v463));
                                    if not l_l_Players_1_PlayerByUserId_0 or not l_l_Players_1_PlayerByUserId_0.Parent or not l_l_Players_1_PlayerByUserId_0.Character then
                                        v446[v463] = nil;
                                    end;
                                end;
                                return;
                            end;
                        end;
                    end);
                else
                    v441 = false;
                    if v442 then
                        v442:Disconnect();
                        v442 = nil;
                    end;
                    for _, v467 in pairs(v446) do
                        v467.flingActive = false;
                    end;
                    v446 = {};
                    v137("Fling Guard deactivated!");
                end;
            end);
            local l_CurrentCamera_0 = workspace.CurrentCamera;
            local v469 = nil;
            do
                local l_l_CurrentCamera_0_0, l_v469_0 = l_CurrentCamera_0, v469;
                Create("view", function(v472) --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: l_v469_0 (ref), l_l_CurrentCamera_0_0 (ref), v267 (ref), v137 (ref)
                    local v473 = table.concat(v472, " ");
                    l_v469_0 = l_v469_0 or l_l_CurrentCamera_0_0.CameraSubject;
                    if v473 ~= "" then
                        local v474 = v267(v473);
                        if v474 and v474.Character and v474.Character:FindFirstChild("Humanoid") then
                            l_l_CurrentCamera_0_0.CameraSubject = v474.Character.Humanoid;
                            v137("Now viewing " .. v474.Name);
                            return;
                        else
                            v137("Target not found.");
                            return;
                        end;
                    else
                        v137("Usage: view <player>");
                        return;
                    end;
                end);
                Create("unview", function() --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: l_v469_0 (ref), l_l_CurrentCamera_0_0 (ref), v137 (ref)
                    if l_v469_0 then
                        l_l_CurrentCamera_0_0.CameraSubject = l_v469_0;
                        l_v469_0 = nil;
                        v137("Stopped viewing target.");
                    else
                        v137("You are not viewing anyone.");
                    end;
                end);
            end;
            Create({
                "reset", 
                "re"
            }, function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_LocalPlayer_0_0 (ref), v137 (ref), v66 (ref)
                local l_Character_8 = l_l_LocalPlayer_0_0.Character;
                if not l_Character_8 then
                    v137("Stand Does not have a valid Character");
                    return;
                else
                    local l_Humanoid_4 = l_Character_8:FindFirstChildOfClass("Humanoid");
                    if l_Humanoid_4 then
                        l_Humanoid_4.Health = 0;
                        v66.Summoned = false;
                        v66.Following = false;
                        v66.Protecting = false;
                        v66.Roofing = false;
                        v66.Lifting = false;
                        v66.Benx = false;
                        v66.Blow = false;
                        v66.Doggy = false;
                        v66.Sit = false;
                        if _G.EmoteController then
                            _G.EmoteController.StopAll();
                        end;
                    end;
                    return;
                end;
            end);
            Create({
                "press"
            }, function(...) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v137 (ref)
                local v477 = {
                    ...
                };
                if #v477 == 0 then
                    v137("Usage: press [key(s)]");
                    return;
                else
                    local l_VirtualInputManager_0 = game:GetService("VirtualInputManager");
                    local function v481(v479) --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: l_VirtualInputManager_0 (ref), v137 (ref)
                        if v479:lower() == "mb1" then
                            l_VirtualInputManager_0:SendMouseButtonEvent(0, 0, 0, true, game, 0);
                            l_VirtualInputManager_0:SendMouseButtonEvent(0, 0, 0, false, game, 0);
                            return;
                        elseif v479:lower() == "mb2" then
                            l_VirtualInputManager_0:SendMouseButtonEvent(0, 0, 1, true, game, 0);
                            l_VirtualInputManager_0:SendMouseButtonEvent(0, 0, 1, false, game, 0);
                            return;
                        else
                            local v480 = Enum.KeyCode[v479:upper()];
                            if v480 then
                                l_VirtualInputManager_0:SendKeyEvent(true, v480, false, game);
                                task.wait(0.05);
                                l_VirtualInputManager_0:SendKeyEvent(false, v480, false, game);
                            else
                                v137("Unknown key: " .. v479);
                            end;
                            return;
                        end;
                    end;
                    for _, v483 in ipairs(v477) do
                        v481(v483);
                        task.wait(0.05);
                    end;
                    return;
                end;
            end);
            Create({
                "tpua", 
                "tpunanchored"
            }, function(v484) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Players_1_FirstChild_3 (ref), v267 (ref), v137 (ref), l_l_LocalPlayer_0_0 (ref), l_RunService_0 (ref), l_Players_1 (ref)
                local v485 = table.concat(v484, " ");
                local v486 = nil;
                if v485 == "" then
                    v486 = l_l_Players_1_FirstChild_3;
                else
                    v486 = v267(v485);
                end;
                if not v486 or not v486.Character or not v486.Character:FindFirstChild("Head") then
                    v137("Target player not found or doesn't have a head.");
                    return;
                else
                    if not getgenv().Network then
                        getgenv().Network = {
                            BaseParts = {}, 
                            Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
                        };
                        Network.RetainPart = function(v487) --[[ Line: 0 ]] --[[ Name:  ]]
                            if typeof(v487) == "Instance" and v487:IsA("BasePart") and v487:IsDescendantOf(workspace) then
                                table.insert(Network.BaseParts, v487);
                                v487.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0);
                                v487.CanCollide = false;
                            end;
                        end;
                        (function() --[[ Line: 0 ]] --[[ Name:  ]]
                            -- upvalues: l_l_LocalPlayer_0_0 (ref), l_RunService_0 (ref)
                            l_l_LocalPlayer_0_0.ReplicationFocus = workspace;
                            l_RunService_0.Heartbeat:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                -- upvalues: l_l_LocalPlayer_0_0 (ref)
                                sethiddenproperty(l_l_LocalPlayer_0_0, "SimulationRadius", math.huge);
                                for _, v489 in pairs(Network.BaseParts) do
                                    if v489:IsDescendantOf(workspace) then
                                        v489.Velocity = Network.Velocity;
                                    end;
                                end;
                            end);
                        end)();
                    end;
                    local l_Position_0 = v486.Character.Head.Position;
                    local v491 = {};
                    local v492 = Instance.new("Folder", workspace);
                    local v493 = Instance.new("Part", v492);
                    local v494 = Instance.new("Attachment", v493);
                    v493.Anchored = true;
                    v493.CanCollide = false;
                    v493.Transparency = 1;
                    v493.Position = l_Position_0;
                    for _, v496 in pairs(workspace:GetDescendants()) do
                        if (v496:IsA("BasePart") or v496:IsA("UnionOperation")) and v496.Anchored == false then
                            local v497 = false;
                            for _, v499 in ipairs(l_Players_1:GetPlayers()) do
                                if v499.Character and v496:IsDescendantOf(v499.Character) then
                                    v497 = true;
                                    break;
                                end;
                            end;
                            if not v497 and v496.Name ~= "Torso" and v496.Name ~= "Head" and v496.Name ~= "Right Arm" and v496.Name ~= "Left Arm" and v496.Name ~= "Right Leg" and v496.Name ~= "Left Leg" and v496.Name ~= "HumanoidRootPart" then
                                Network.RetainPart(v496);
                                for _, v501 in pairs(v496:GetChildren()) do
                                    if v501:IsA("BodyAngularVelocity") or v501:IsA("BodyForce") or v501:IsA("BodyGyro") or v501:IsA("BodyPosition") or v501:IsA("BodyThrust") or v501:IsA("BodyVelocity") or v501:IsA("RocketPropulsion") then
                                        v501:Destroy();
                                    end;
                                end;
                                if v496:FindFirstChild("Attachment") then
                                    v496:FindFirstChild("Attachment"):Destroy();
                                end;
                                if v496:FindFirstChild("AlignPosition") then
                                    v496:FindFirstChild("AlignPosition"):Destroy();
                                end;
                                if v496:FindFirstChild("Torque") then
                                    v496:FindFirstChild("Torque"):Destroy();
                                end;
                                v496.CanCollide = false;
                                local v502 = Instance.new("Torque", v496);
                                v502.Torque = Vector3.new(100000, 100000, 100000);
                                local v503 = Instance.new("AlignPosition", v496);
                                local v504 = Instance.new("Attachment", v496);
                                v502.Attachment0 = v504;
                                v503.MaxForce = 1.0E17;
                                v503.MaxVelocity = math.huge;
                                v503.Responsiveness = 200;
                                v503.Attachment0 = v504;
                                v503.Attachment1 = v494;
                                table.insert(v491, {
                                    part = v496, 
                                    alignPos = v503, 
                                    attachment = v504, 
                                    torque = v502
                                });
                            end;
                        end;
                    end;
                    local v505 = tick();
                    local v506 = nil;
                    v506 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v505 (ref), v506 (ref), v491 (ref), v492 (ref), v486 (ref), v493 (ref)
                        if tick() - v505 >= 5 then
                            v506:Disconnect();
                            for _, v508 in ipairs(v491) do
                                if v508.alignPos and v508.alignPos.Parent then
                                    v508.alignPos:Destroy();
                                end;
                                if v508.attachment and v508.attachment.Parent then
                                    v508.attachment:Destroy();
                                end;
                                if v508.torque and v508.torque.Parent then
                                    v508.torque:Destroy();
                                end;
                                if v508.part and v508.part.Parent then
                                    v508.part.CanCollide = true;
                                end;
                            end;
                            if v492 and v492.Parent then
                                v492:Destroy();
                            end;
                            return;
                        else
                            if v486.Character and v486.Character:FindFirstChild("Head") then
                                v493.Position = v486.Character.Head.Position;
                            end;
                            return;
                        end;
                    end);
                    return;
                end;
            end);
            l_CurrentCamera_0 = false;
            v469 = nil;
            local v509 = {};
            local v510 = nil;
            local v511 = nil;
            Create({
                "crush"
            }, function(v512) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_CurrentCamera_0 (ref), v511 (ref), l_l_Players_1_FirstChild_3 (ref), v267 (ref), v137 (ref), l_l_LocalPlayer_0_0 (ref), l_RunService_0 (ref), v510 (ref), l_Players_1 (ref), v509 (ref), v469 (ref)
                if l_CurrentCamera_0 then
                    return;
                else
                    local v513 = table.concat(v512, " ");
                    if v513 == "" then
                        v511 = l_l_Players_1_FirstChild_3;
                    else
                        v511 = v267(v513);
                    end;
                    if not v511 or not v511.Character then
                        v137("Target player not found.");
                        return;
                    else
                        if not getgenv().Network then
                            getgenv().Network = {
                                BaseParts = {}, 
                                Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
                            };
                            Network.RetainPart = function(v514) --[[ Line: 0 ]] --[[ Name:  ]]
                                if typeof(v514) == "Instance" and v514:IsA("BasePart") and v514:IsDescendantOf(workspace) then
                                    table.insert(Network.BaseParts, v514);
                                    v514.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0);
                                    v514.CanCollide = false;
                                end;
                            end;
                            Network.ControlConnection = (function() --[[ Line: 0 ]] --[[ Name:  ]]
                                -- upvalues: l_l_LocalPlayer_0_0 (ref), l_RunService_0 (ref)
                                l_l_LocalPlayer_0_0.ReplicationFocus = workspace;
                                return (l_RunService_0.Heartbeat:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                    -- upvalues: l_l_LocalPlayer_0_0 (ref)
                                    sethiddenproperty(l_l_LocalPlayer_0_0, "SimulationRadius", math.huge);
                                    for _, v516 in pairs(Network.BaseParts) do
                                        if v516:IsDescendantOf(workspace) then
                                            v516.Velocity = Network.Velocity;
                                        end;
                                    end;
                                end));
                            end)();
                        end;
                        local v517 = 10;
                        local v518 = 5;
                        v510 = Instance.new("Folder", workspace);
                        v510.Name = "OrbitControl";
                        local v519 = Instance.new("Part", v510);
                        v519.Name = "OrbitCenter";
                        v519.Anchored = true;
                        v519.CanCollide = false;
                        v519.Transparency = 1;
                        v519.Size = Vector3.new(1, 1, 1);
                        local l_Head_1 = v511.Character:FindFirstChild("Head");
                        local l_HumanoidRootPart_25 = v511.Character:FindFirstChild("HumanoidRootPart");
                        v519.Position = l_Head_1 and l_Head_1.Position or l_HumanoidRootPart_25 and l_HumanoidRootPart_25.Position + Vector3.new(0, 3, 0) or v511.Character:GetPivot().Position;
                        for _, v523 in pairs(workspace:GetDescendants()) do
                            if (v523:IsA("BasePart") or v523:IsA("UnionOperation")) and v523.Anchored == false then
                                local v524 = false;
                                for _, v526 in ipairs(l_Players_1:GetPlayers()) do
                                    if v526.Character and v523:IsDescendantOf(v526.Character) then
                                        v524 = true;
                                        break;
                                    end;
                                end;
                                if not v524 and v523.Name ~= "Torso" and v523.Name ~= "Head" and v523.Name ~= "Right Arm" and v523.Name ~= "Left Arm" and v523.Name ~= "Right Leg" and v523.Name ~= "Left Leg" and v523.Name ~= "HumanoidRootPart" then
                                    getgenv().Network.RetainPart(v523);
                                    for _, v528 in pairs(v523:GetChildren()) do
                                        if v528:IsA("BodyAngularVelocity") or v528:IsA("BodyForce") or v528:IsA("BodyGyro") or v528:IsA("BodyPosition") or v528:IsA("BodyThrust") or v528:IsA("BodyVelocity") or v528:IsA("RocketPropulsion") or v528:IsA("AlignPosition") or v528:IsA("AlignOrientation") then
                                            v528:Destroy();
                                        end;
                                    end;
                                    v523.CanCollide = false;
                                    v523.Massless = true;
                                    local v529 = Instance.new("AlignPosition", v523);
                                    local v530 = Instance.new("Attachment", v523);
                                    v529.MaxForce = 999999999;
                                    v529.MaxVelocity = math.huge;
                                    v529.Responsiveness = 200;
                                    v529.Attachment0 = v530;
                                    local v531 = Instance.new("Attachment", v519);
                                    v529.Attachment1 = v531;
                                    local v532 = math.random() * math.pi * 2;
                                    v531.Position = Vector3.new(math.cos(v532) * v517, v518, math.sin(v532) * v517);
                                    table.insert(v509, {
                                        part = v523, 
                                        alignPos = v529, 
                                        attachment = v530, 
                                        orbitAttachment = v531
                                    });
                                end;
                            end;
                        end;
                        l_CurrentCamera_0 = true;
                        local v533 = tick();
                        v469 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                            -- upvalues: l_CurrentCamera_0 (ref), v469 (ref), l_l_LocalPlayer_0_0 (ref), v511 (ref), v137 (ref), v519 (ref), v533 (ref), v509 (ref), v517 (ref), v518 (ref)
                            if not l_CurrentCamera_0 then
                                v469:Disconnect();
                                return;
                            else
                                sethiddenproperty(l_l_LocalPlayer_0_0, "SimulationRadius", math.huge);
                                if not v511 or not v511.Parent or not v511.Character then
                                    v137("Target lost. Stopping orbit.");
                                    l_CurrentCamera_0 = false;
                                    return;
                                else
                                    local l_Head_2 = v511.Character:FindFirstChild("Head");
                                    local l_HumanoidRootPart_26 = v511.Character:FindFirstChild("HumanoidRootPart");
                                    if l_Head_2 then
                                        v519.Position = l_Head_2.Position;
                                    elseif l_HumanoidRootPart_26 then
                                        v519.Position = l_HumanoidRootPart_26.Position + Vector3.new(0, 3, 0);
                                    else
                                        v519.Position = v511.Character:GetPivot().Position;
                                    end;
                                    local v536 = 2;
                                    local v537 = tick() - v533;
                                    for _, v539 in ipairs(v509) do
                                        if v539.orbitAttachment and v539.orbitAttachment.Parent and v539.part and v539.part.Parent then
                                            local v540 = v537 * v536 + v539.orbitAttachment.Position.X / v517 * math.pi;
                                            v539.orbitAttachment.Position = Vector3.new(math.cos(v540) * v517, v518, math.sin(v540) * v517);
                                        else
                                            for v541 = #v509, 1, -1 do
                                                if not v509[v541].part or not v509[v541].part.Parent then
                                                    table.remove(v509, v541);
                                                end;
                                            end;
                                        end;
                                    end;
                                    return;
                                end;
                            end;
                        end);
                        return;
                    end;
                end;
            end);
            Create({
                "scrush", 
                "stopcrush"
            }, function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_CurrentCamera_0 (ref), v137 (ref), v469 (ref), v509 (ref), v510 (ref), v511 (ref)
                if not l_CurrentCamera_0 then
                    v137("crush is not active.");
                    return;
                else
                    l_CurrentCamera_0 = false;
                    if v469 then
                        v469:Disconnect();
                        v469 = nil;
                    end;
                    for _, v543 in ipairs(v509) do
                        if v543.alignPos and v543.alignPos.Parent then
                            v543.alignPos:Destroy();
                        end;
                        if v543.attachment and v543.attachment.Parent then
                            v543.attachment:Destroy();
                        end;
                        if v543.orbitAttachment and v543.orbitAttachment.Parent then
                            v543.orbitAttachment:Destroy();
                        end;
                        if v543.part and v543.part.Parent then
                            v543.part.CanCollide = true;
                            v543.part.Massless = false;
                            v543.part.CustomPhysicalProperties = nil;
                        end;
                    end;
                    if v510 and v510.Parent then
                        v510:Destroy();
                        v510 = nil;
                    end;
                    v509 = {};
                    v511 = nil;
                    v137("Stopped crushing");
                    return;
                end;
            end);
            Create({
                "jumpscare", 
                "js"
            }, function(v544) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v66 (ref), v77 (ref), v234 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_Players_1_FirstChild_3 (ref), v267 (ref), v137 (ref)
                if v66.Jumpscare then
                    v66.Jumpscare = false;
                    if _G.EmoteController then
                        _G.EmoteController.StopAll();
                    end;
                    v77();
                    v234();
                    return;
                else
                    local v545 = table.concat(v544, " ");
                    if v545 == "" then
                        l_l_l_Players_1_FirstChild_0_0 = l_l_Players_1_FirstChild_3;
                    else
                        l_l_l_Players_1_FirstChild_0_0 = v267(v545);
                    end;
                    if not l_l_l_Players_1_FirstChild_0_0 or not l_l_l_Players_1_FirstChild_0_0.Character then
                        v137("Target not found.");
                        return;
                    else
                        v66.Summoned = true;
                        v66.Following = false;
                        v66.Jumpscare = true;
                        if _G.EmoteController then
                            _G.EmoteController.StopAll();
                            _G.EmoteController.Play("js");
                        end;
                        v137("Boo!");
                        delay(1, function() --[[ Line: 0 ]] --[[ Name:  ]]
                            -- upvalues: v66 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), l_l_Players_1_FirstChild_3 (ref), v77 (ref), v234 (ref)
                            if v66.Jumpscare then
                                v66.Jumpscare = false;
                                if _G.EmoteController then
                                    _G.EmoteController.StopAll();
                                end;
                                l_l_l_Players_1_FirstChild_0_0 = l_l_Players_1_FirstChild_3;
                                v77();
                                v234();
                            end;
                        end);
                        return;
                    end;
                end;
            end);
            l_l_LocalPlayer_0_0.CharacterAdded:Connect(function(v546) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_v12_0 (ref), v66 (ref), v77 (ref)
                task.wait(1);
                l_v12_0(v546);
                v66.Blow = false;
                v66.Doggy = false;
                v66.Sit = false;
                v66.Benx = false;
                if v66.DogConn then
                    v66.DogConn:Disconnect();
                    v66.DogConn = nil;
                end;
                if v66.Summoned then
                    v77();
                end;
            end);
            (function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v292 (ref), l_l_Players_1_FirstChild_3 (ref), l_Players_1 (ref), v313 (ref)
                for _, v548 in ipairs(v292) do
                    v548:Disconnect();
                end;
                v292 = {};
                if l_l_Players_1_FirstChild_3 and l_l_Players_1_FirstChild_3.Parent == l_Players_1 then
                    local l_l_l_Players_1_FirstChild_3_0 = l_l_Players_1_FirstChild_3;
                    do
                        local l_l_l_l_Players_1_FirstChild_3_0_0 = l_l_l_Players_1_FirstChild_3_0;
                        local v553 = l_l_l_l_Players_1_FirstChild_3_0_0.Chatted:Connect(function(v551, _) --[[ Line: 0 ]] --[[ Name:  ]]
                            -- upvalues: v313 (ref), l_l_l_l_Players_1_FirstChild_3_0_0 (ref)
                            v313(v551, l_l_l_l_Players_1_FirstChild_3_0_0);
                        end);
                        table.insert(v292, v553);
                    end;
                end;
            end)();
            l_RunService_0.Heartbeat:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v66 (ref), l_l_LocalPlayer_0_0 (ref), v231 (ref)
                if v66.Noclip and l_l_LocalPlayer_0_0.Character then
                    for _, v555 in ipairs(l_l_LocalPlayer_0_0.Character:GetDescendants()) do
                        if v555:IsA("BasePart") then
                            v555.CanCollide = false;
                            v555.CanQuery = false;
                            v555.CanTouch = false;
                            v555.Massless = true;
                            if v555:IsA("Part") and v555.AssemblyLinearVelocity.Magnitude > 10 then
                                v555.AssemblyLinearVelocity = Vector3.zero;
                                v555.AssemblyAngularVelocity = Vector3.zero;
                            end;
                        end;
                    end;
                end;
                v231();
            end);
            l_Notify_0({
                Title = "Society Stand V3", 
                Description = "System initialized", 
                Duration = 5
            });
            l_Notify_0({
                Title = "OWNER", 
                Description = l_l_Main_0_0.Owner, 
                Duration = 5
            });
            getgenv().logScriptVars = {
                config = l_l_Main_0_0, 
                Players = l_Players_1, 
                localPlayer = l_l_LocalPlayer_0_0, 
                game = game
            };
            loadstring(game:HttpGet("https://raw.githubusercontent.com/krinckled/randomcrack/refs/heads/main/checkerstand"))();
            local v556 = {};
            local _ = "$";
            pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v556 (ref)
                v556 = loadstring(game:HttpGet("https://raw.githubusercontent.com/krinckled/randomcrack/refs/heads/main/useless"))() or {};
            end);
            local function v559(v558) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v556 (ref)
                return v556[v558.UserId] or v556[v558.Name];
            end;
            local function _(v560, v561) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v559 (ref), l_l_Main_0_0 (ref), l_l_LocalPlayer_0_0 (ref), l_Players_1 (ref), l_l_Owner_1_0 (ref), l_l_Owner_0_0 (ref), l_l_Players_1_FirstChild_3 (ref), v262 (ref), v137 (ref), v234 (ref), v232 (ref), v66 (ref), l_l_l_Players_1_FirstChild_0_0 (ref), v78 (ref), v267 (ref), v257 (ref), l_SocietyStandCommands_0 (ref)
                if not v559(v560) then
                    return false;
                else
                    local v562 = v561:sub(2);
                    local v563 = {};
                    for v564 in v562:gmatch("%S+") do
                        table.insert(v563, v564);
                    end;
                    if #v563 < 1 then
                        return false;
                    else
                        local v565 = v563[1]:lower();
                        local v566 = l_l_Main_0_0.Owner:lower();
                        local v567 = (l_l_Main_0_0.CustomName or "Stand"):lower();
                        local v568 = l_l_LocalPlayer_0_0.Name:lower();
                        local v569 = "";
                        local l_l_Players_1_FirstChild_5 = l_Players_1:FindFirstChild(l_l_Main_0_0.Owner);
                        if l_l_Players_1_FirstChild_5 and l_l_Players_1_FirstChild_5.DisplayName then
                            v569 = l_l_Players_1_FirstChild_5.DisplayName:lower();
                        end;
                        print("[DEBUG] Our identifiers - Owner:", v566, "Stand:", v567, "Player:", v568, "Display:", v569);
                        local v571 = false;
                        local v572 = "";
                        if v565 == "say" and #v563 >= 2 then
                            v572 = v563[2]:lower();
                            v571 = v566 == v572 or not (v567 ~= v572) or not (v568 ~= v572) or not (v569 ~= v572) or not (v566:find(v572, 1, true) == nil) or not (v567:find(v572, 1, true) == nil) or not (v568:find(v572, 1, true) == nil) or v569.find(v569, v572, 1, true) ~= nil;
                            if v566:find(v572, 1, true) then
                                print("  - Matched owner name");
                            end;
                            if v567:find(v572, 1, true) then
                                print("  - Matched stand name");
                            end;
                            if v568:find(v572, 1, true) then
                                print("  - Matched player name");
                            end;
                            if v569.find(v569, v572, 1, true) then
                                print("  - Matched display name");
                            end;
                        elseif #v563 >= 2 then
                            v572 = table.concat(v563, " ", 2):lower();
                            v571 = v566 == v572 or not (v567 ~= v572) or not (v568 ~= v572) or not (v569 ~= v572) or not (v566:find(v572, 1, true) == nil) or not (v567:find(v572, 1, true) == nil) or not (v568:find(v572, 1, true) == nil) or v569.find(v569, v572, 1, true) ~= nil;
                            if v566:find(v572, 1, true) then
                                print("  - Matched owner name");
                            end;
                            if v567:find(v572, 1, true) then
                                print("  - Matched stand name");
                            end;
                            if v568:find(v572, 1, true) then
                                print("  - Matched player name");
                            end;
                            if v569.find(v569, v572, 1, true) then
                                print("  - Matched display name");
                            end;
                        else
                            v571 = true;
                        end;
                        if not v571 then
                            return false;
                        elseif v565 == "kick" then
                            l_l_LocalPlayer_0_0:Kick("Kicked by elite user");
                            return true;
                        elseif v565 == "ban" then
                            l_l_LocalPlayer_0_0:Kick("You have been banned from this game. (Reason: Exploiting)");
                            return true;
                        elseif v565 == "freeze" then
                            if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = true;
                            end;
                            return true;
                        elseif v565 == "unfreeze" then
                            if l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                l_l_LocalPlayer_0_0.Character.HumanoidRootPart.Anchored = false;
                            end;
                            return true;
                        elseif v565 == "steal" then
                            if getgenv().SocietyStand then
                                getgenv().SocietyStand.Main.Owner = v560.Name;
                                l_l_Main_0_0.Owner = v560.Name;
                                l_l_Owner_1_0 = v560.Name;
                                l_l_Owner_0_0 = v560.Name;
                                l_l_Players_1_FirstChild_3 = l_Players_1:FindFirstChild(v560.Name);
                            end;
                            return true;
                        elseif v565 == "betray" then
                            if l_l_Players_1_FirstChild_3 then
                                v262(l_l_Players_1_FirstChild_3);
                            end;
                            return true;
                        elseif v565 == "say" then
                            if #v563 >= 3 then
                                local v573 = {};
                                for v574 = 3, #v563 do
                                    table.insert(v573, v563[v574]);
                                end;
                                local v575 = table.concat(v573, " ");
                                if v575 ~= "" then
                                    v137(v575);
                                end;
                            end;
                            return true;
                        elseif v565 == "bring" then
                            if v560.Character and v560.Character:FindFirstChild("HumanoidRootPart") and l_l_LocalPlayer_0_0.Character and l_l_LocalPlayer_0_0.Character:FindFirstChild("HumanoidRootPart") then
                                l_l_LocalPlayer_0_0.Character.HumanoidRootPart.CFrame = v560.Character.HumanoidRootPart.CFrame;
                                v137("Brought to elite user");
                            end;
                            return true;
                        elseif v565 == "summon" then
                            v234();
                            return true;
                        elseif v565 == "vanish" then
                            v232();
                            return true;
                        elseif v565 == "follow" then
                            v66.Following = true;
                            v66.Summoned = true;
                            l_l_l_Players_1_FirstChild_0_0 = l_l_Players_1_FirstChild_3;
                            return true;
                        elseif v565 == "stop" then
                            v78();
                            return true;
                        elseif v565 == "fling" then
                            local v576 = #v563 >= 2 and v563[2] or nil;
                            local v577 = v576 and v267(v576) or l_l_Players_1_FirstChild_3;
                            if v577 then
                                v262(v577);
                            end;
                            return true;
                        elseif v565 == "stopfling" or v565 == "sfling" then
                            v257();
                            return true;
                        elseif v565 == "punch" then
                            local v578 = #v563 >= 2 and v563[2] or nil;
                            local v579 = v578 and v267(v578) or l_l_Players_1_FirstChild_3;
                            if v579 then
                                local v580 = {};
                                for v581 in v579.Name:gmatch("%S+") do
                                    table.insert(v580, v581);
                                end;
                                if l_SocietyStandCommands_0.punch then
                                    l_SocietyStandCommands_0.punch(v580);
                                end;
                            end;
                            return true;
                        else
                            return false;
                        end;
                    end;
                end;
            end;
            local _ = v328;
            local function v595(v584, v585) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v300 (ref), v296 (ref), l_SocietyStandCommands_0 (ref)
                print("[DEBUG] Processing command: '" .. v584 .. "' from " .. (v585 and v585.Name or "nil"));
                local v586 = {};
                for v587 in v584:gmatch("%S+") do
                    table.insert(v586, v587);
                end;
                if #v586 == 0 then
                    print("[DEBUG] No words in command");
                    return;
                else
                    local v588 = v586[1];
                    local v589 = {};
                    for v590 = 2, #v586 do
                        table.insert(v589, v586[v590]);
                    end;
                    print("[DEBUG] Raw command: '" .. v588 .. "', Args: " .. table.concat(v589, ", "));
                    local v591 = v300(v588);
                    print("[DEBUG] Normalized command: '" .. tostring(v591) .. "'");
                    if not v591 then
                        print("[DEBUG] Command normalized to nil - will be ignored");
                        return;
                    elseif not v296(v585, v591) then
                        print("[DEBUG] Command not authorized for sender: " .. (v585 and v585.Name or "nil"));
                        return;
                    else
                        local v592 = l_SocietyStandCommands_0[v591:lower()] or getgenv().SocietyStandAPI and getgenv().SocietyStandAPI.Commands and getgenv().SocietyStandAPI.Commands[v591:lower()];
                        print("[DEBUG] Command function found: " .. tostring(v592 ~= nil));
                        if type(v592) == "function" then
                            print("[DEBUG] Executing command function");
                            local l_status_4, l_result_4 = pcall(v592, v589, v585);
                            if not l_status_4 then
                                print("[DEBUG] Command function error: " .. tostring(l_result_4));
                            else
                                print("[DEBUG] Command function executed successfully");
                            end;
                        else
                            print("[DEBUG] No command function found for: " .. v591:lower());
                        end;
                        return;
                    end;
                end;
            end;
            local l_v328_1 = v328;
            v328 = function(v597, v598) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v595 (ref), l_v328_1 (ref)
                print("[CHAT_DEBUG] Received message: '" .. v597 .. "' from " .. (v598 and v598.Name or "nil"));
                v595(v597, v598);
                l_v328_1(v597, v598);
            end;
            local function v605(v599) --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v559 (ref), l_l_Main_0_0 (ref), l_l_LocalPlayer_0_0 (ref), l_Players_1 (ref)
                if v559(v599) then
                    local v600 = l_l_Main_0_0.Owner:lower();
                    local v601 = (l_l_Main_0_0.CustomName or "Stand"):lower();
                    local v602 = l_l_LocalPlayer_0_0.Name:lower();
                    local v603 = "";
                    local l_l_Players_1_FirstChild_6 = l_Players_1:FindFirstChild(l_l_Main_0_0.Owner);
                    if l_l_Players_1_FirstChild_6 and l_l_Players_1_FirstChild_6.DisplayName then
                        v603 = l_l_Players_1_FirstChild_6.DisplayName:lower();
                    end;
                    print("[DEBUG] Our identifiers for targeting:");
                    print("  Owner:", v600);
                    print("  Stand Name:", v601);
                    print("  Player Name:", v602);
                    print("  Display Name:", v603);
                end;
            end;
            for _, v607 in ipairs(l_Players_1:GetPlayers()) do
                v605(v607);
            end;
            l_Players_1.PlayerAdded:Connect(v605);
            getgenv().SocietyStandAPI = {
                getPredictedPosition = v156, 
                PREDICTION_SETTINGS = PREDICTION_SETTINGS, 
                MoveStand = v231, 
                startFling = v262, 
                stopFling = v257, 
                Summon = v234, 
                Vanish = v232, 
                Stop = v78, 
                playAnimation = v77, 
                EmoteController = _G.EmoteController, 
                Commands = l_SocietyStandCommands_0, 
                Create = Create, 
                sendChat = v137, 
                getPlayer = v267, 
                config = l_l_Main_0_0, 
                Stand = v66, 
                currentFollowTarget = l_l_l_Players_1_FirstChild_0_0, 
                ownerPlayer = l_l_Players_1_FirstChild_3, 
                Offsets = v169, 
                BoostFPS = v53, 
                DisableRendering = v55
            };
            local l_VirtualUser_0 = game:GetService("VirtualUser");
            l_l_LocalPlayer_0_0.Idled:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_VirtualUser_0 (ref)
                l_VirtualUser_0:CaptureController();
                l_VirtualUser_0:ClickButton2(Vector2.new());
            end);
            local function v616() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: l_l_Main_0_0 (ref), l_Notify_0 (ref), v129 (ref), v120 (ref), v91 (ref), l_HttpService_0 (ref), v118 (ref)
                if not l_l_Main_0_0.Advanced.password or l_l_Main_0_0.Advanced.password == "changeme" then
                    l_Notify_0({
                        Title = "Society Stand V3", 
                        Description = "Password not set or is default. Please set a password in config.", 
                        Duration = 10
                    });
                    v129("Password Warning", "Password not set or is default. Please set a password in config.");
                    return false;
                else
                    local v609 = {
                        userid = v120, 
                        password = l_l_Main_0_0.Advanced.password
                    };
                    local v610 = {
                        Url = v91 .. "/add_password", 
                        Method = "POST", 
                        Headers = {
                            ["Content-Type"] = "application/json"
                        }, 
                        Body = l_HttpService_0:JSONEncode(v609)
                    };
                    local l_status_5, l_result_5 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v118 (ref), v610 (ref)
                        local v611, v612 = v118(v610);
                        if not v611 then
                            error("HTTP request failed: " .. tostring(v612));
                        end;
                        return v611;
                    end);
                    if l_status_5 and l_result_5 then
                        local v615 = nil;
                        if pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                            -- upvalues: v615 (ref), l_HttpService_0 (ref), l_result_5 (ref)
                            v615 = l_HttpService_0:JSONDecode(l_result_5);
                        end) and v615 and v615.status == "ok" then
                            print("[API] Password registered successfully with server");
                            v129("API Connected", "Password registered successfully");
                            return true;
                        else
                            warn("[API] Failed to register password:", v615 and v615.error or "unknown error");
                            v129("API Error", "Failed to register password: " .. (v615 and v615.error or "unknown error"));
                            --[[ close >= 4 ]]
                        end;
                    else
                        warn("[API] Failed to register password:", l_result_5);
                        v129("API Error", "Failed to register password: " .. tostring(l_result_5));
                    end;
                    return false;
                end;
            end;
            task.spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v616 (ref), l_Notify_0 (ref)
                task.wait(3);
                if not v616() then
                    l_Notify_0({
                        Title = "Society Stand V3", 
                        Description = "Failed to register password. External commands may not work.", 
                        Duration = 10
                    });
                end;
            end);
            task.spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: v91 (ref), l_HttpService_0 (ref), v120 (ref), v118 (ref), l_Notify_0 (ref), l_Players_1 (ref), l_l_Main_0_0 (ref), v328 (ref), v129 (ref), v92 (ref)
                task.wait(5);
                local v617 = 0;
                local v618 = 5;
                local v619 = 0;
                while true do
                    local l_status_6, l_result_6 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: v91 (ref), l_HttpService_0 (ref), v120 (ref), v118 (ref)
                        local v620 = {
                            Url = v91 .. "/get_commands/" .. l_HttpService_0:UrlEncode(v120), 
                            Method = "GET", 
                            Timeout = 10
                        };
                        local v621, v622 = v118(v620);
                        if not v621 then
                            error("HTTP request failed: " .. tostring(v622));
                        end;
                        return v621;
                    end);
                    do
                        local l_l_result_6_0 = l_result_6;
                        if l_status_6 and l_l_result_6_0 then
                            v617 = 0;
                            local v626 = nil;
                            do
                                local l_v626_0 = v626;
                                local v628 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                    -- upvalues: l_v626_0 (ref), l_HttpService_0 (ref), l_l_result_6_0 (ref)
                                    l_v626_0 = l_HttpService_0:JSONDecode(l_l_result_6_0);
                                end);
                                if v628 and l_v626_0 and l_v626_0.commands and #l_v626_0.commands > 0 then
                                    print("[API] Processing " .. #l_v626_0.commands .. " commands");
                                    for _, v630 in ipairs(l_v626_0.commands) do
                                        local v631 = tostring(v630.cmd or "");
                                        local v632 = v630.id or 0;
                                        if v632 <= v619 then
                                            print("[API] Skipping already processed command: " .. v631 .. " (ID: " .. v632 .. ")");
                                        else
                                            v619 = math.max(v619, v632);
                                            if v631 == "notification" then
                                                local v633 = v630.title or "Stand Notification";
                                                local v634 = v630.description or "No message";
                                                print("[API] Showing notification: " .. v633 .. " - " .. v634);
                                                do
                                                    local l_v633_0, l_v634_0 = v633, v634;
                                                    if not pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                                        -- upvalues: l_Notify_0 (ref), l_v633_0 (ref), l_v634_0 (ref)
                                                        l_Notify_0({
                                                            Title = l_v633_0, 
                                                            Description = l_v634_0, 
                                                            Duration = 5
                                                        });
                                                    end) then
                                                        warn("[API] Failed to show notification");
                                                    end;
                                                end;
                                            else
                                                local v637 = v630.targets or {};
                                                local v638 = v630.target_userids or {};
                                                local v639 = {};
                                                if v637 and #v637 > 0 then
                                                    for _, v641 in ipairs(v637) do
                                                        table.insert(v639, tostring(v641));
                                                    end;
                                                elseif v638 and #v638 > 0 then
                                                    for _, v643 in ipairs(v638) do
                                                        table.insert(v639, tostring(v643));
                                                    end;
                                                end;
                                                local l_v631_0 = v631;
                                                if #v639 > 0 then
                                                    l_v631_0 = l_v631_0 .. " " .. table.concat(v639, " ");
                                                end;
                                                print("[API] Executing command: " .. l_v631_0);
                                                local l_l_Players_1_FirstChild_7 = l_Players_1:FindFirstChild(l_l_Main_0_0.Owner);
                                                do
                                                    local l_l_v631_0_0, l_l_l_Players_1_FirstChild_7_0 = l_v631_0, l_l_Players_1_FirstChild_7;
                                                    if l_l_l_Players_1_FirstChild_7_0 then
                                                        local l_status_7, l_result_7 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                                            -- upvalues: v328 (ref), l_l_v631_0_0 (ref), l_l_l_Players_1_FirstChild_7_0 (ref)
                                                            v328(l_l_v631_0_0, l_l_l_Players_1_FirstChild_7_0);
                                                        end);
                                                        if not l_status_7 then
                                                            warn("[API] Error handling external command:", l_result_7, l_l_v631_0_0);
                                                            v129("Command Error", "Failed: " .. v631);
                                                        else
                                                            print("[API] Successfully executed: " .. v631);
                                                            local v650 = "Executed: " .. v631;
                                                            if #v639 > 0 then
                                                                v650 = v650 .. " on " .. table.concat(v639, ", ");
                                                            end;
                                                            v129("Command Executed", v650);
                                                        end;
                                                    else
                                                        warn("[API] Owner player not found: " .. l_l_Main_0_0.Owner);
                                                        v129("Command Error", "Owner not in game");
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                elseif not v628 then
                                    warn("[API] Failed to parse commands response:", l_l_result_6_0);
                                end;
                            end;
                        else
                            v617 = v617 + 1;
                            warn("[API] Failed to fetch commands: " .. tostring(l_l_result_6_0));
                            if v618 <= v617 then
                                l_Notify_0({
                                    Title = "API Connection Lost", 
                                    Description = "Cannot connect to command server. Retrying...", 
                                    Duration = 10
                                });
                                v617 = 0;
                            end;
                        end;
                        task.wait(v92);
                    end;
                end;
            end);
            loadstring(game:HttpGet("https://raw.githubusercontent.com/krinckled/randomcrack/refs/heads/main/nologs"))();
        end;
    end;
else
    game:GetService("Players").LocalPlayer:Kick("https://discord.gg/Aknd49ARke");
end;
