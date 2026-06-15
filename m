Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B33E95AB
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526112; cv=none; b=Js+DZag89Fl8ZzMGQZjl+Da5i9wXgT9KCshUwshIbWqvD/bXCKw5kT0PnrSZKJwdvsLR4FyQy+07Tu0d1P2nOTV73BoUEKvar905Jw4Zug2DjCJNoEwpsCBQBx3ywiAopNGIgkj47WPqO1cmqfuS8ROK+/rdyA+TVKAo3cHMRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526112; c=relaxed/simple;
	bh=XichFX1UqmGWv5lEB5ERPI+kAku1Xzz3CRir+HJgd6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FJsQUZaV4ciUUZUbpp2zVk5ejgx8mtZOWR5G3ibLebVIYU4gVxEbl6hSAnYWSbaNXdGI/uK3R046fedwaUdXsuo4G2yOOaqIVTsn2IA2oz/iBj2+SW3+I+dGnyP+OCAjQDIdfGKvpemk0JoerovpG/TTJrlvHNx9rbpQnC6Gh3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aoFqxFdJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UXS/V0Gg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aoFqxFdJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UXS/V0Gg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 087E2140004A
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:21:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 08:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1781526109; x=1781612509; bh=Rru5dE/CNp
	NG02zVg6K81ZhTeEStq1mZ9Fcspdee2do=; b=aoFqxFdJUSfDlHLzKdycFYiBSz
	xxpAtSLGiR5SMYEpUynEj5fIY5QSlnBz+7tMaKeaHFcwDnR6g53XIJn1MrLQHPQv
	ggyeDrpopIA7f1MmxiXIxJnO8QBfHqxkhkzinMUgGD/DrbWybhqPYK2xTVLokazT
	8beEvBsBtbVA74HEXsuiyK3ecWBE8MC79iehOMSaXDsgaQY8ROBxvHR+JU12A5Vh
	ImuxXUSdM9QpG8tBelVjN4rGsnbqBtlzF1NuIGC3fyGmt/hha5xV4gL7zK3v6yqH
	mNL/5w7GMEKwxcmM4NEjXdIlln6pNBao09ZidQpvic06GJqroF2lPHvgN47A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1781526109; x=1781612509; bh=Rru5dE/CNpNG02zVg6K81ZhTeESt
	q1mZ9Fcspdee2do=; b=UXS/V0Gggv6Jzhh/S3Y4yvMFxxACuHAvt4LN5ZMpWiDL
	aIoxVy4YOaUxReXD8U8TdWRC/4qKpD0iRT+dQxlmA1atK93NG7qO7h6RiB+E7vu6
	06FiLG36T/tOOdF0u/yfXvwBY1y9Abhsyiqndet5boTA/wOtlvL4zEpwF/RvtNmf
	fK9DbK9DbZjr34dBNC51Ve5CkXYsX9Kk3lTL4Fz5ZqMfk9K7LWJLpnwi9yuooN4J
	+W2bMob7E9pNWYNNSEqnmBefeUGyIbzzjniiWjguvt1Fn27Z11bNxo05jOrtkfzK
	9n592QSmWAuWSu+wCdg5ckO3TwP5XCiLRpyY7oeDsg==
X-ME-Sender: <xms:XO4vatDTnd1xvR-d-VwwF71-DWDSqUItkO1hEQaer_97yuFfw5o6LA>
    <xme:XO4vaick4HJl_HOAqO3zK_5tkey6-PSjGJ2KQ96NDgx4BDFV3eojZrPrN1q_YGy7M
    Kc0EoYITJsU9k-ZGPutdKklu8tlwcfQ8WxeqdvjN7ipsV13MdJ5Nbc>
X-ME-Received: <xmr:XO4vauPZAOwQvxyVezTPiQx2zpjNjIpDNNriSzwomRZjey95trHGoZ7cr6gz2pMExs51q5NGguNEmBUkcjK8nmDZsx7_YXEoEk32KdczHQ>
X-ME-Proxy-Cause: dmFkZTEiSqDZ3ipzL5FBvxhXmlWH6rTj/yeDrU8Wph8uX5n4gvREN7Cfis5TAN98uV2BGC
    Lz9SXFL1fWZNT7GC6j49cXZKMRhJuIz53FXOl7/O4ogxKTjScdlYviurJ7XjGvDPSVTDxD
    +/QJyC08BLoQ4CqyZhpHDir0he6JtswPr43VzxQOO+Ff4ZWsueFxWO2Fh5r4rqByWnUSUp
    2v+tZFuclGYL3L4tM37bNzhG3NX5ag6c81ynsmrDMMrWVbvrIm/ok6+ooUjHnTlWlefIKI
    xYSOprNRypwbp6G25L04WKEKPsz7UCZBMVNJ5fxw7kWs2iHiRIxzNxa2Hhi0oX+mYGnRZG
    LN7+MDTjJVt+bHoFEaMt3T/xB1BEVXSxzhrK1H1RZo6M+9BWeWzcpe9DEvoO3kl3vuEkE+
    y1+PNjRoH2wDfjkEPo5C34LaQctMaAkZHob22+gcAt1UpZfoMBIMDFZw5EOo+HmU4xMIY2
    fkuvp/Xr8ssuNT8Ca6HC5kfqc9WDbzk8BoI1gIx3bsqTQEm7GdpSrpHEsGVQ6Mz8RwV0Fm
    URhsuY3XqproqC0NxMkQbE/pGdMxADTl31V2mRp4r7be1ufuhSTEbUjgswfLVHZKsv6bZ2
    7Pa19VFl/m9vTAHicolRxZRSiJrpp0bsJhpZL0CIpDpyPOXxhU1bc1k71poA
X-ME-Proxy: <xmx:XO4vas442F-m26IWjVoXWM53FJAnamfVotZ3CCrFrZzKz7985BV6Tw>
    <xmx:XO4vaiI5JrVW8O3JrZeLXEO0F2kdXW_fc-1DniJloYtnIrTQDYXFsQ>
    <xmx:XO4vamfMnWFgbRO3ZRGtd9T4EytTk1VkThoZDWHqMHSmcV0L5Tow2Q>
    <xmx:XO4valebxyW9GiaFk1Wl2otKGOYirf7N5jf92VwYPOgjWraJ-v9lMA>
    <xmx:Xe4vasBXpGWxopLeehaV_cZCmJX-UuW5zS1cxtOsS75ZUg4-M2wZD3mU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Jun 2026 08:21:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ef00bba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Jun 2026 12:21:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 14:21:40 +0200
Subject: [PATCH] gitlab-ci: migrate Windows builds away from Chocolatey
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-gitlab-ci-drop-chocolatey-v1-1-51a6e7d5e388@pks.im>
X-B4-Tracking: v=1; b=H4sIAFPuL2oC/yXNQQrCMBBA0auUWTvQhFjQq4iLTDJtR0sTMlGU0
 rsbdfk2/2+gXIQVzt0GhZ+iktYGc+ggzH6dGCU2g+3t0A/miOQw3xUnqYsnDIKxpIxhTiEtvvI
 baeRTdETGOQstkwuP8votLte/9UE3DvXbhX3/ANx4pLqEAAAA
X-Change-ID: 20260615-b4-pks-gitlab-ci-drop-chocolatey-bfe9d4bb1442
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The Windows builds in GitLab CI use Chocolatey to install dependencies.
Unfortunately, Chocolatey seems to be very unreliable, which causes the
jobs to fail very regularly. This is a limitation that seems to be
somewhat known [1]:

  As an organization, you want 100% reliability (or at least that
  potential), and you may want full trust and control as well. This is
  something you can get with internally hosted packages, and you are
  unlikely to achieve from use of the Community Package Repository.

So using the Community Package Repository is kind of discouraged in case
one wants reliability. We _do_ want reliability though, and we cannot
easily switch to an enterprise license to fix this issue.

Introduce a new script that downloads and installs dependencies
directly. This has a couple of benefits:

  - We can drop our dependency on Chocolatey completely, thus improving
    reliability.

  - We can easily cache the installers.

  - We get direct control over the exact versions we install.

  - Installing dependencies is sped up from roundabout 3 minutes to 1
    minute.

[1]: https://docs.chocolatey.org/en-us/community-repository/community-packages-disclaimer/#summary

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi

I've been quite annoyed recently because our Windows builds in GitLab CI
are extremely flakey. All of those flakes come from Chocolatey, which is
why this patch moves away from it.

Thanks!

Patrick
---
 .gitlab-ci.yml              | 11 ++++++---
 ci/install-dependencies.ps1 | 55 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e0b9a0d82b..87a5343a94 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -161,11 +161,16 @@ test:mingw64:
     TEST_OUTPUT_DIRECTORY: "C:/Git-Test"
   tags:
     - saas-windows-medium-amd64
+  cache:
+    key:
+      files:
+        - ci/install-dependencies.ps1
+    paths:
+      - .dependencies
   before_script:
     - *windows_before_script
-    - choco install -y git meson ninja rust-ms
-    - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
-    - refreshenv
+    - ./ci/install-dependencies.ps1
+    - $env:Path = "C:\Meson;C:\Rust\bin;$env:Path"
     - New-Item -Path $env:TEST_OUTPUT_DIRECTORY -ItemType Directory
 
 build:msvc-meson:
diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
new file mode 100755
index 0000000000..e3b367fa54
--- /dev/null
+++ b/ci/install-dependencies.ps1
@@ -0,0 +1,55 @@
+param(
+    [string]$DownloadDirectory = '.dependencies'
+)
+
+$ErrorActionPreference = 'Stop'
+$ProgressPreference = 'SilentlyContinue'
+
+$GitVersion = '2.54.0.windows.1'
+$MesonVersion = '1.11.0'
+$RustVersion = '1.96.0'
+
+New-Item -Path $DownloadDirectory -ItemType Directory -Force | Out-Null
+New-Item -Path .git/info -ItemType Directory -Force | Out-Null
+New-Item -Path .git/info/exclude -ItemType File -Force | Out-Null
+Add-Content -Path .git/info/exclude -Value "/$DownloadDirectory"
+
+function Get-Installer {
+    param(
+        [Parameter(Mandatory = $true)][string]$Name,
+        [Parameter(Mandatory = $true)][string]$Url
+    )
+
+    $path = Join-Path $DownloadDirectory $Name
+    if (-not (Test-Path $path)) {
+        Write-Host "Downloading $Url"
+        Invoke-WebRequest $Url -OutFile $path -TimeoutSec 300
+    }
+    return $path
+}
+
+function Invoke-Installer {
+    param(
+        [Parameter(Mandatory = $true)][string]$FilePath,
+        [Parameter(Mandatory = $true)][string[]]$ArgumentList
+    )
+
+    Write-Host "Running $FilePath $($ArgumentList -join ' ')"
+    $process = Start-Process -Wait -PassThru -FilePath $FilePath -ArgumentList $ArgumentList
+    if ($process.ExitCode -ne 0) {
+        throw "$FilePath failed with exit code $($process.ExitCode)"
+    }
+}
+
+$gitAssetVersion = $GitVersion -replace '\.windows\.\d+$', ''
+$gitInstaller = Get-Installer "Git-Installer.exe" `
+    "https://github.com/git-for-windows/git/releases/download/v$GitVersion/PortableGit-$gitAssetVersion-64-bit.7z.exe"
+Invoke-Installer $gitInstaller @('-y', '-o"C:\Program Files\Git"')
+
+$mesonMsi = Get-Installer "meson.msi" `
+    "https://github.com/mesonbuild/meson/releases/download/$MesonVersion/meson-$MesonVersion-64.msi"
+Invoke-Installer msiexec.exe @('/i', $mesonMsi, 'INSTALLDIR=C:\Meson', '/quiet', '/norestart')
+
+$rustMsi = Get-Installer "rust.msi" `
+    "https://static.rust-lang.org/dist/rust-$RustVersion-x86_64-pc-windows-msvc.msi"
+Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust', 'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')

---
base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
change-id: 20260615-b4-pks-gitlab-ci-drop-chocolatey-bfe9d4bb1442

