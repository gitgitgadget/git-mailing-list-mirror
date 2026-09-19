Received: from mail-oa2-f34.google.com (mail-oa2-f34.google.com [74.125.231.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C363AAF41
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789819943; cv=none; b=PCZstRE0Mew+GRoog/m3TpKssmJDvEEvJZ/8S21SKeI6O2bV394PwOZ3yM4X/cStpHoBV7lkZfUEnLJFFcHrSVOcMC7WNsVx7ADu1Za7/jYydfnQ2/1VhBi3vz+PAHTad+2DTmmbRUuK821UigekEUvSkE9bXijf3bMw8EGyg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789819943; c=relaxed/simple;
	bh=HupuBkPAhXRq6Fy9jXFRXXp47HhIOQNp537+G3GqzEY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HnOQU6/yiK5VEfqjIp43FaAkU2BtXMJkq1DnyhCrczwOZU4FtX9tTpYGiw6GbH5wxnC8E32K50CVTch4eg4XzK/XjkfO7zRuIcrXcI74Ip73xNEbwdZeUtg8OLvNwfZFL7qSBNgsw3uGCmIiUxnO3dQQNv1DsMaMPGWDOUJr268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0AIF7Gu; arc=none smtp.client-ip=74.125.231.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0AIF7Gu"
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-466ccde2ad9so1668797fac.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 05:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789819938; x=1790424738; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8qSz5ZMis4rdx+lwtBfpiOLYnKE1zn91r3q7YNttw+M=;
        b=J0AIF7GuWMfh5L0vzsgD5I1Ma9PU8AmbG3wE4HU1AlKFVZrxLkancfiy+SB0oo9KS8
         IoBd1AC90XQl0721Yo97DeZT1G+TPoSk7x3IBb3tjAa/zRFxOjFg3UHwD2h/Pzk4vOUQ
         T+FZ3qe7a3O6bFV9NMt33KwPlQWBJDwHQMD1HJtDLF+b+3GOB56leZ8zLFt39HRHdP/N
         G5b/SV9sQWbK5dRkOWhppUzS9KkFDIg6hyqAWrDZ2xuvsLLxH7DXsP1UjvBXEAmjtiAl
         4RR6G14pg62p+DZVbJh1Fzg2Y/uXh/zjsEBkd7mxo0GD6F53Pc2e48ECq1eG30FSCOu7
         +LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789819938; x=1790424738;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8qSz5ZMis4rdx+lwtBfpiOLYnKE1zn91r3q7YNttw+M=;
        b=An70RAetL7IBbGZzozuH8rJZ+ZjaSNvAuIwQwK1k5NcnxOs04X42AwwPPb8HGCkATe
         MHwuwZwWpE6SdoOq8yfBlbVJoccyKXsnHNFqmGqyfzT2r5xfNCIDMG5uh3MTqRh18XV0
         tpdEmXa8TN67NIZfINYmjTD34UgDY7S50EQamJrL6ITi2/OVnCUuED/JfOiINSSVCSFs
         64r0qrBBgJzQTMq6RRLWsht56zBjF9mnNa9M60Krrq+1ikHEq9RtVKVregh1zzhhaaps
         Dtn43R2UdllpQUUX3V8gMpzE+HkcsjmthRGFDjHGdODq7mfLyG1fQe701zM4ivzAugKC
         g5IQ==
X-Gm-Message-State: AFuF++l9TVjypqwmlCvZjmXh2wbMk/mmnKBXtv0T2rHB1S0m8zfBWJYP
	tfhi9EWkEpWHf32VdSbPhSCLz9bdAXtYcTLo6Wr47IJXxq2RKMaz8Ix1uxKeJw==
X-Gm-Gg: AYBFou3EqK55LGOYWl3eG7DnbQxX8SzrjWrssTmQYhD4jdKqSUrmi9D7kRqPlDfhV5W
	x1hNaZQ6kGGx9PHU7txuDjkHh6b+V+FXg/dkvMr13Qk1JuP21Xnyo/1XFr/IEKhZFftqYX4W+FI
	oyHRk1z2w1pxxZQoFi2itBcdrZ1lQPCw07sSQ3cbDrQEbrviESLRvjhuC9WUTL/Zy2/DwgMkdir
	5Q58mnud3KBn2CxhtZk+QAz5MJgHRcamzTJgARIoE8GvDKa/Fcb8hmwVlm7oA8rF1BA1Dc+MnPA
	1wOMW3v9EHC5CwfxiNLPFmRf3i++o/Lk6waCOEXgk7s6FRSYFeFPUb1MlS33fCV6pqyrYfrcRjV
	e4LI7fRSjJgYozEX3mEO/q4mzyKnzKRQVQ2+21RF+hxGqKwVB5cl3qiMj47ik7mSn5iQDPNrP0K
	9GjLcAQ1uIMhqI41ADQq+mloXAnvKLqG+vNCMH3RUdpVQ5xBA2EOcKEuvjnaTSGmf0vsgpCQYHQ
	d0=
X-Received: by 2002:a05:6820:162a:b0:6be:4eb3:e1c6 with SMTP id 006d021491bc7-6ca9a74914cmr4965553eaf.19.1789819938372;
        Sat, 19 Sep 2026 05:12:18 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.141.197])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48820e35039sm1876634fac.5.2026.09.19.05.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:12:17 -0700 (PDT)
Message-Id: <6a389b2bad1653175bde2a767ffbb5b672e324e2.1789819933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Sep 2026 12:12:10 +0000
Subject: [PATCH 1/4] ci(gitlab,windows): provision GNU Rust for SDK-based
 MinGW builds
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The minimal Git for Windows SDK already supplies Git and GCC. The
MinGW Makefile build needs the GNU Rust toolchain, not another Git
installation or Meson.

Let the dependency installer serve this configuration while keeping
the existing package set for MSVC builds.

Assisted-by: GPT-6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.ps1 | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
index e3b367fa54..8c68fb0cfc 100755
--- a/ci/install-dependencies.ps1
+++ b/ci/install-dependencies.ps1
@@ -1,5 +1,6 @@
 param(
-    [string]$DownloadDirectory = '.dependencies'
+    [string]$DownloadDirectory = '.dependencies',
+    [switch]$Mingw
 )
 
 $ErrorActionPreference = 'Stop'
@@ -41,6 +42,17 @@ function Invoke-Installer {
     }
 }
 
+$rustTarget = if ($Mingw) { 'gnu' } else { 'msvc' }
+$rustMsi = Get-Installer "rust-$rustTarget.msi" (
+    "https://static.rust-lang.org/dist/" +
+    "rust-$RustVersion-x86_64-pc-windows-$rustTarget.msi")
+Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust',
+    'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')
+
+if ($Mingw) {
+    return
+}
+
 $gitAssetVersion = $GitVersion -replace '\.windows\.\d+$', ''
 $gitInstaller = Get-Installer "Git-Installer.exe" `
     "https://github.com/git-for-windows/git/releases/download/v$GitVersion/PortableGit-$gitAssetVersion-64-bit.7z.exe"
@@ -49,7 +61,3 @@ Invoke-Installer $gitInstaller @('-y', '-o"C:\Program Files\Git"')
 $mesonMsi = Get-Installer "meson.msi" `
     "https://github.com/mesonbuild/meson/releases/download/$MesonVersion/meson-$MesonVersion-64.msi"
 Invoke-Installer msiexec.exe @('/i', $mesonMsi, 'INSTALLDIR=C:\Meson', '/quiet', '/norestart')
-
-$rustMsi = Get-Installer "rust.msi" `
-    "https://static.rust-lang.org/dist/rust-$RustVersion-x86_64-pc-windows-msvc.msi"
-Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust', 'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')
-- 
gitgitgadget

