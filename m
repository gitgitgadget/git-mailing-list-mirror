Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD61433993
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789223888; cv=none; b=qpXkt7F6nje9DcBW+rCqLFBx2UfMFyr3LN37doiJuOpZnxHmwh2rVlX1wNmU58xelPKQD06mqFeTygizYmzB6Xp2+XB90/Ld29GN35j0irr0FMWOzc9S36J8S7mQlKuRzjSrlELzUS+dkapbbj8SDBfzJuq7Kq/7hOzznyCIiJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789223888; c=relaxed/simple;
	bh=mGFypBjTatNJLKzS3whx5yh53K0bvawMZ9PJLB9+tq0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gtRiNxg0POHM3ovaTdVrkjoTh7j/rVN4yhF/u4HWDjqyCewj7MzEdV91xrr1aaupi86e3+QeDCOC8hSFN3VSwP/OQ68EwyRZjWFbdEwIoaZiW7lx6GO0M4kkbWnvmJ0ciCgV9aIWKGaLAvesyL31zYFSmURp5IaZoMuX/dqBCuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8N8Gl+O; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8N8Gl+O"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e3so12411346d6.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2026 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789223884; x=1789828684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Od3kZqLGaEnyJgkaImWWww9HmO5g/LLUaS9rxDAmXIk=;
        b=j8N8Gl+OhBir4qry9GSCIUBrlOT8MeyPp/ShvxQIW2+1F6EyRip/heZgWeL1aDzAMT
         CX422E0iPKAasp0MrxAxPdg35hh1Uy9xQBeZbcdS4TzcBcMn1BGpR2eO764ByE1ckGDH
         +ry7b9vt0AkE8k0AaZn2TSVJcBXbqcDtkPisNV1C1vsvTz0YgmbyJi6Vkv1XfBX88ITY
         aZ8+THINh3yew7yAC4sNPPf/cS2SIv93SWAUAllNU3FN2g1gzgINUAEB4v5idAWqKkfb
         ZJye2x2Dm50hwBnavLsCTDgoF8jnaLhQBA8xIRyP1W3zjlRAAafIV34Q9rFUdviE1DDY
         gIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789223884; x=1789828684;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Od3kZqLGaEnyJgkaImWWww9HmO5g/LLUaS9rxDAmXIk=;
        b=gw9oG9IsbltSrDNpIrtBunkKENbbiSSrGxGunVQXoSB80z1gbTPxFz03A/jXFUs1gl
         GZlYr7tYstn6kEjE1UYNDKLT5UKR8k5elZuWNpfZ22bkBSXsAWTwgwznAMv3NK9WbPxk
         RH0QwcAzaAGCDe1NZe7wHxEqmeTPPdIkdoZMDDtULWBok+89uMpnHbwxfUdf2cqrPWKJ
         glXpc6NORBTTpt2FuDGZ1Lewuty4m0lucXE3tFaRTKrZ35TruCuFcd0XNXGvg3VBJJ05
         6N1I05pzaPkyKPaDE0qjagIOV1iAhTx/J3FU6KgdonAUa1Rlf9zRtd6WTJcp6OSjNou0
         QW7g==
X-Gm-Message-State: AFuF++npWsr5ngCsYxVZ/RW562IwDia9xXBoEGvnSHEYu6DNw9s9aNjv
	FuFE05jh8N1Eyy+SaihdJ6Qnx4ZGTlO78O3vv9hV8mEJ4V+ksM6NCK9mcBXqlA==
X-Gm-Gg: AYBFou3+x1y/0Fx4OEcAWGTiL5+42ZRWKFtZKppdk4SouMC89qKv305toEOLTbdHpQb
	WT9rcQSNfm6eYivZ098UFyUffEIB4p9c7DlCRipujBQS9U4pjS4u4+w7Bh1Wdn0jixsoMUF0BAI
	/q3gI6ShboH3S6jrOs3Bq3DAFkAh4B/Qs83o6O79ItbQw+3IQt8jkuMa6sKtc94wHCCMCyl3liZ
	LnEdY5aFuc/a4MS3V5VtygSf69hxYbT+D9RAt8k0dk9bj5E5um+J009Dy4YdMPmYzRiXNSAmFwR
	q3zvoQNSSulMSB4ABplgKB5wL4mQCEoU8l8LgXbigsy9V7ttgLcKkf/7REDOsrYj7TBH5Y6HYg5
	vHG2aM8i1++B4sVGKgIs1LHxsE2X88SrfP37GWhwZPWfnLimvxjnUzCMeJWij22A9wdOeLkzq2J
	kQ/DIKVfJP4fpV1xv/k+N7DEziNw/U7noG5XbXLeLXIA64Pmg1WNbTciJY8iGocHvhzRV9yuxe
X-Received: by 2002:a05:620a:4625:b0:939:8905:ce9b with SMTP id af79cd13be357-939ea0a8d84mr1228212885a.17.1789223883631;
        Sat, 12 Sep 2026 07:38:03 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.173.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a0cfa2299sm89357085a.18.2026.09.12.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 07:38:03 -0700 (PDT)
Message-Id: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Sep 2026 14:38:02 +0000
Subject: [PATCH] ci: only warn about perforce/git-lfs/JGit on platforms that
 need them
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

perforce, git-lfs, and JGit test git's own interop code, not anything
platform-specific, so installing them once on ubuntu-* (all three)
and macos-* (perforce) is enough coverage. debian, i386/ubuntu,
alpine, fedora and almalinux never install them, yet the presence
check at the end of the script warned on all of them anyway.

Scope each check to the platforms that attempt the install, so a
warning means one actually failed.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    ci: only warn about perforce/git-lfs/JGit on platforms that need them
    
    Only warn about a missing perforce/git-lfs/JGit install on the platforms
    that actually need and attempt them (ubuntu-*, plus macOS for perforce),
    since every other platform never installs them and was warning
    regardless.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2403%2FHaraldNordgren%2Fci-scope-optional-tool-warnings-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2403/HaraldNordgren/ci-scope-optional-tool-warnings-v1
Pull-Request: https://github.com/git/git/pull/2403

 ci/install-dependencies.sh | 54 ++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 2f61fbb07c..a68cec64b4 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -171,30 +171,38 @@ Documentation)
 	;;
 esac
 
-if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
-then
-	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
-	p4d -V
-	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
-	p4 -V
-else
-	echo >&2 "::warning:: perforce wasn't installed, see above for clues why"
-fi
+case "$distro" in
+ubuntu-*|macos-*)
+	if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
+	then
+		echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
+		p4d -V
+		echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
+		p4 -V
+	else
+		echo >&2 "::warning:: perforce wasn't installed, see above for clues why"
+	fi
+	;;
+esac
 
-if type git-lfs >/dev/null 2>&1
-then
-	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
-	git-lfs version
-else
-	echo >&2 "::warning:: git-lfs wasn't installed, see above for clues why"
-fi
+case "$distro" in
+ubuntu-*)
+	if type git-lfs >/dev/null 2>&1
+	then
+		echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
+		git-lfs version
+	else
+		echo >&2 "::warning:: git-lfs wasn't installed, see above for clues why"
+	fi
 
-if type jgit >/dev/null 2>&1
-then
-	echo "$(tput setaf 6)JGit Version$(tput sgr0)"
-	jgit version
-else
-	echo >&2 "::warning:: JGit wasn't installed, see above for clues why"
-fi
+	if type jgit >/dev/null 2>&1
+	then
+		echo "$(tput setaf 6)JGit Version$(tput sgr0)"
+		jgit version
+	else
+		echo >&2 "::warning:: JGit wasn't installed, see above for clues why"
+	fi
+	;;
+esac
 
 end_group "Install dependencies"

base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
-- 
gitgitgadget
