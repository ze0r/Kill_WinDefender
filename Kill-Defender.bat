echo off

:: Delete System32 files
takeown /F "C:\Windows\System32\SecurityHealth*" /A
icacls "C:\Windows\System32\SecurityHealth*" /grant Administrators:(F) 
del /F /Q "C:\Windows\System32\SecurityHealth*"

:: directory
takeown /F "C:\Windows\System32\SecurityHealth" /A /R /D Y
icacls "C:\Windows\System32\SecurityHealth" /grant Administrators:(F) /T
rmdir /S /Q "C:\Windows\System32\SecurityHealth"

takeown /F "C:\Program Files\Windows Defender" /A /R /D Y
icacls "C:\Program Files\Windows Defender" /grant Administrators:(F) /T
rmdir /S /Q "C:\Program Files\Windows Defender"

takeown /F "C:\Program Files (x86)\Windows Defender" /A /R /D Y
icacls "C:\Program Files (x86)\Windows Defender" /grant Administrators:(F) /T
rmdir /S /Q "C:\Program Files (x86)\Windows Defender"

takeown /F "C:\Program Files\Windows Defender Advanced Threat Protection" /A /R /D Y
icacls "C:\Program Files\Windows Defender Advanced Threat Protection" /grant Administrators:(F) /T
rmdir /S /Q "C:\Program Files\Windows Defender Advanced Threat Protection"

:: Delete service in registration

sc Config TrustedInstaller binPath= "cmd.exe /C reg delete HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService /f"
sc start TrustedInstaller
sc start TrustedInstaller
sc Config TrustedInstaller binPath= "cmd.exe /C reg delete HKLM\SYSTEM\CurrentControlSet\Services\WinDefend /f"
sc start TrustedInstaller
sc start TrustedInstaller
sc Config TrustedInstaller binPath= "%systemroot%\servicing\TrustedInstaller.exe"

:: Add regedit key to disable VBS & HVCI
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity /v Enabled /t REG_DWORD /d 0 /f
