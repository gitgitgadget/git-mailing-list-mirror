Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E16F158853
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720904918; cv=none; b=FXj920qMzMFTMI2U98tGvxFYcNVddVFPUq70Y8/jC9eDRlYFs+elTAynNIkkiZ00/zPG4Mm1sVIZpsOz3PfnizdN+I/iVZ3u8jyVjp4kj8MWKWcwqitoYBFZKRDyZwRBzxFVW6wK16409TE7sRxDow4thJtL+g7Mny9PEgPrLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720904918; c=relaxed/simple;
	bh=vPT+TOEiMe/bjQeQ0jCb6acz4GYnr54LsJHfh1fhtc4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bw1JKjxc0BRtShnzURKO+AC9faf56UNlNEO8itIFVrpUEKglaEJ7rOxYCr60xRPJCHnrqRYKanEsH4xLNRTMg+GOcJhqObjC96Iaxbjvu1qucTtoJnywUzEDHPsz376px3a2zjgheWNVmIldZabEG2Nj67kwvr3nPjscSdwQOe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT32jI8t; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT32jI8t"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42797bcfc77so21262005e9.2
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720904914; x=1721509714; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkJwz/YY+MwgxQ1TrFALyw+kqQQqMj4QPMpSB0JQrS4=;
        b=WT32jI8tjB0SesX6ufrUmCsxuVnYjCtLZlR/9Mc1wQwZchqyeNEZEgXmReSE+lbXFX
         nN0C28JxQdVEJCxkRToxtlaOh8IoGzzmHfFn7dOLsTkSXh5b78gtzIwewP/UJGVmnBQF
         GHK3Vw+Cd6xOc3pRt3AsCDytJ+Yf+inXRFTQzRnrEUt7gCIdGD/cc/WxgcY/3v2Sp3Tk
         yQYjo7ASL9HglLMgHc/H0I5vcVwe+TvFPQ0rrKktCAaWf+kjWCi9wqPuGBBAZRFSAYVt
         QO3mtdx/mMTiOBT5nfdWVHP1xIAIqoEriJJedubNnTwBt2aaMWntDMxY+ALhrjmkuo+E
         bTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720904914; x=1721509714;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkJwz/YY+MwgxQ1TrFALyw+kqQQqMj4QPMpSB0JQrS4=;
        b=IL2fov8GCncs+/3nPGQFllAB0js1PrBDUvKhsxbOEOojpMA819jveVcZKAE1ME4Mgs
         7Cj9ZHLem+J5kL7W9SNMQVEHHI+H2L3sYivyq5mWssr0jlP4Zp2pBm7U2Fd1/dY/UPye
         H4cKb6+08ovcz87MnJKbApTRWmobcDuWcoZFTmDR6mxNqQc75bET+6Z3I3wDWpadM73J
         k0xC0sm9XTOZzXmWQpjwhH3BiKmff8hx4v1dcMfbm6KST3NyLXmCBJ53U1GUK2Cll+J9
         60NSOhU8SFcolDGZarlkG/q+rvxMBQ3r8izoqwAWSYaVwQZaNxlp+XkcjaL+2s218sZp
         Pehg==
X-Gm-Message-State: AOJu0YyLCfdab+F/S12bMVDdVOyue84gAjdpcEv1YTK8ZtwizYy/x17t
	LnwB7p+m973CpH76PZ1v9qsEU+0Fu8v7xUl5MMqsOc6S6qd3pdZ3XfLOlg==
X-Google-Smtp-Source: AGHT+IEB1veNH0QmjUyijd28sd7KW57q6uqysLCWItUbotbZs+CAEvpYC3XXVu+1F+uWZ6nluJUI5g==
X-Received: by 2002:a05:600c:245:b0:426:6fd3:1547 with SMTP id 5b1f17b1804b1-426707cf19fmr96370585e9.2.1720904914348;
        Sat, 13 Jul 2024 14:08:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d73bdsm68131615e9.43.2024.07.13.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:08:33 -0700 (PDT)
Message-Id: <7c8eba5bfd82944402e90eaaaf5150e9d7e7d8a3.1720904905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
References: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
	<pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jul 2024 21:08:24 +0000
Subject: [PATCH v3 7/7] var(win32): do report the GIT_SHELL_PATH that is
 actually used
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, Unix-like paths like `/bin/sh` make very little sense. In
the best case, they simply don't work, in the worst case they are
misinterpreted as absolute paths that are relative to the drive
associated with the current directory.

To that end, Git does not actually use the path `/bin/sh` that is
recorded e.g. when `run_command()` is called with a Unix shell
command-line. Instead, as of 776297548e (Do not use SHELL_PATH from
build system in prepare_shell_cmd on Windows, 2012-04-17), it
re-interprets `/bin/sh` as "look up `sh` on the `PATH` and use the
result instead".

This is the logic users expect to be followed when running `git var
GIT_SHELL_PATH`.

However, when 1e65721227 (var: add support for listing the shell,
2023-06-27) introduced support for `git var GIT_SHELL_PATH`, Windows was
not special-cased as above, which is why it outputs `/bin/sh` even
though that disagrees with what Git actually uses.

Let's fix this by using the exact same logic as `prepare_shell_cmd()`,
adjusting the Windows-specific `git var GIT_SHELL_PATH` test case to
verify that it actually finds a working executable.

Reported-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/var.c      | 3 ++-
 t/t0007-git-var.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index 5dc384810c0..e30ff45be1c 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "path.h"
 #include "strbuf.h"
+#include "run-command.h"
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
@@ -51,7 +52,7 @@ static char *default_branch(int ident_flag UNUSED)
 
 static char *shell_path(int ident_flag UNUSED)
 {
-	return xstrdup(SHELL_PATH);
+	return git_shell_path();
 }
 
 static char *git_attr_val_system(int ident_flag UNUSED)
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index ff4fd9348cc..9fc58823873 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -157,7 +157,7 @@ test_expect_success POSIXPERM 'GIT_SHELL_PATH points to a valid executable' '
 test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
 	shellpath=$(git var GIT_SHELL_PATH) &&
 	case "$shellpath" in
-	*sh) ;;
+	[A-Z]:/*/sh.exe) test -f "$shellpath";;
 	*) return 1;;
 	esac
 '
-- 
gitgitgadget
