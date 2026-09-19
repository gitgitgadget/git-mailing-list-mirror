Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4339A81B
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789819956; cv=none; b=lpZtZaTFERznAEwKXk6CEVdTG/psJmXhOmMf+IJ/6fT54jp/rJvcN47rgUApJsTfS7eQFmLqXcyF6+p4db4sAHHHPrvyacdeydngKP8UR+sMxy5xtJBpPb4+tezDNt8FgjB8o4/QBDDmJdcTZWlZcXsw2MFpk7Rloi2db3ffWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789819956; c=relaxed/simple;
	bh=XEwuSU3r56lfC/nhryR5IM9x8dNfLZZ076jrcdQ6hIc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qaD163519e5KNPrPh+pkJGVOihpml/NamWVxejpH8e8QxvHE6o7sBEP9/ANfcNPOrG0zTGGS52v17/XNOMGQQvDH17sKNa27Y91BfIUwiAO6MdaNUba4a50ShCN6FdBdiZJvGtIZ+oT+cneQ9GNw0WRUrilt9fEpB83MKuO61wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrBuXots; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrBuXots"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-805bf8c2661so1168753a34.3
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 05:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789819947; x=1790424747; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XbXmtcviNmYrGpBZTo9L3TGzaGolomMUf3RDCJLZWqg=;
        b=YrBuXotsGPn2WxTcHGN1mWI7cnAH+89lymZOXZjAMkP4Q1j4ywGz2VVm+xdcYb+/qr
         jVa3V2q4u8Zz633AgwA5IuiD0+TU5apt2OLxb98eMtjw9b0EVT7T9+DDLSqh64R/9CU9
         KAoGhkHJW1pWx43Dtmau2azk6tLAFemgcoHFqJgeLVW51/oGGtPOqJ+bMJi5cp5L4QNF
         7aoX8kr2/PGQ+4DkmMg5yYJFiRbUgTdF/zHkIm7BKylnyOpM8LC7UxKZv8LyUbX8EYrL
         mcl6n4VvPhtVHI+2RSUe8E3kempztxgWSTUzOcqygQnijW1XgJ+R/gMfxc+Ti5SJcb7I
         KXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789819947; x=1790424747;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XbXmtcviNmYrGpBZTo9L3TGzaGolomMUf3RDCJLZWqg=;
        b=JFdbR7ZiQ8f1n5/Ow5x4vtT/PAY4DLCc4atEW9P2BehD7jSE0ftHZnwyHGAFWKikCn
         EYB66eWh6beY/HmitjU7l61RMpz7XcXnAjisIThsf8qUNlJb9+/8myJo/ZrOVBzRVeLx
         a1igvZO8wFB8DIhvjx3Yep6ELI8nQE1M0R+jSsknF1PVssOo4p1gD0OvxDPWNMzPJQnV
         uTFV2zKdTNPeGsV2AZB2OHTG7mrwoT8a4kV14GXuCVssWsyJjmQVFpRqBjnd64Yx6Glz
         NuuBS2uDQYEqKjyBLpNhOQaUtxBOpelhyQ8f3DLjeHQoAPcY7yvdfQ/Di4xNZH/V7/7R
         LREw==
X-Gm-Message-State: AFuF++mkI6K8lJtHMjxLIV0Iy/UjvubYxEILHo4Pqb0yhPmaDd0SJnHb
	Wv9NXCvXvzexg+nEScOuWtvyIbPRYjhX8BR1fk3JVyZI2IKCWhoLQb4IqM8SVw==
X-Gm-Gg: AYBFou3NvM3RReT1IYu86mh38qXfdxZcbuG4r7uSiGu2VdviiBA4waWCW4Krwd7E3c8
	1uP0UrTkVOeiX0e9aoQz/vczmW+/cj5STMhcjIpsZXdqVAmWP7IOUs2ffU7ZUwBrhNq0mL9x/Um
	3zp/ifM+H8pNg4mXxfKpr/ql0u78eJqhNl+0WlcZoFxZhgAdAt/bQ1DTxFTdir15wcqomLkQYlT
	Bca6PcOJZ5P6TKTNQaFp/awATGYz4+3dTAJXIzq4MR9ulVO/HiBT6jDRfJmD8b+v/ZFiVn7J4AA
	zErdwpp1/7KseU4g1hs6c/ciOQhc2+CW8Jci4KisadzJLzja757gXHydKCJ5UMXISWgqHhTzmpm
	IlfyVuRrJMgjF+/99YyiLY12cNKEbgFjunTQFiYV9Ooiz7ZTt1HraHiaw34TyDI4QDvbhc70yFA
	8G9f+zbgpIZy6MVz1fpxCTogfJX2sP+ZQ2gZVAi+inDIIbKHuoyUxCFbw22CriCPF1M2UsaH7mx
	24=
X-Received: by 2002:a05:6830:82e5:b0:806:6853:3e91 with SMTP id 46e09a7af769-80de2bd83d1mr6501311a34.16.1789819947011;
        Sat, 19 Sep 2026 05:12:27 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.141.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8107e89493bsm2050763a34.18.2026.09.19.05.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:12:25 -0700 (PDT)
Message-Id: <1ed79f00cf72b2d5f2e5f55bb11de51dceeeb2bb.1789819933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Sep 2026 12:12:13 +0000
Subject: [PATCH 4/4] ci(gitlab,windows): provide GNU Rust's host-linker
 support
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

GitLab's MinGW job cannot find `x86_64-w64-mingw32-gcc` when linking
gitcore's build script:
https://gitlab.com/dscho/git1/-/jobs/16593470275

Although gitcore is a static library, Cargo first links `build.rs`
as a host executable. We omitted the GNU MSI's `Gcc` feature, which
supplies the required linker and platform libraries:
https://github.com/rust-lang/rust/blob/1.96.0/src/etc/installer/msi/rust.wxs

Assisted-by: GPT-6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.ps1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
index f6868dc670..9b833b9370 100755
--- a/ci/install-dependencies.ps1
+++ b/ci/install-dependencies.ps1
@@ -49,7 +49,7 @@ $rustMsi = Get-Installer "rust-$rustTarget.msi" (
     "https://static.rust-lang.org/dist/" +
     "rust-$RustVersion-x86_64-pc-windows-$rustTarget.msi")
 Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust',
-    'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')
+    "ADDLOCAL=Rustc,Cargo,Std$(if ($Mingw) { ',Gcc' })", '/quiet', '/norestart')
 
 if ($Mingw) {
     return
-- 
gitgitgadget
