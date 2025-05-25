Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2A1C6FEC
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204842; cv=none; b=PrCpJBiPlBEfFv0kSGRjV44xzu4Qdq+2p+c4w0v2XYgXJqKic6VFZI0Yq/EKqnWLYGaoRoQBzWN3N447hGLSbt+3Wl+dbDFdZOST+9TzeWaQjpOZo3+fSkJT6E3/NHD/vnlT0rnYgYuOUZQg9MSDZ2YSSaskxi8A4oiD933VHMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204842; c=relaxed/simple;
	bh=2D/TpcErbm2osXn/yCQv19Bf5WvGPlFTWATaip2dr+k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=hyUKPQv6qgN2eOde/PH/FnpqczT4+yToRCffyRkAV+5XJmGZ48PgchVFljxctyNRabrYFPFIlGOLM+Zq3Jm5ugaiEiI/NP50+bsNVmEj5OC4vhs4FZp3AClXP/5MgXFKDJhLF+WTCbfLYD6yD+K+iYSoDXPKLdh0BcIUanN2fLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfrWOD/n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfrWOD/n"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edb40f357so13468125e9.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748204838; x=1748809638; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vGTj4D8FmIC95y38Tb76glNjLDCAa4LydZTX4VLu68=;
        b=GfrWOD/nxM4TDtzOwX5GjYtZhxJXJjtrQTANsJ4zhblU0dI6PFIXWRJ/n2pWbOenZr
         uf9aXzAYbWwn7NY+3d6rDiMBz2sazaL6xRlGN8EQJEtZPDmsyF1He+BrF+jyQbuTDvoM
         KEFFeodOk9R8ERQPA1jfRMuo5g1xipA3hy3el87G1Y+tP9FPcWVUmsYJRCUreqkW5NZe
         JUUvOrho4UcJJsW+m3tfgLunnTe7virYhJzhVWHenGWsCLHC1G7/kw3DfFVQCAqsNGTP
         zc4bQVLN2zgBWeTYhupN+YFgkDnpDKpYvNdAt/YbH0hVkwcEvieIkfkQn/60xOA/6bD3
         5q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748204838; x=1748809638;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vGTj4D8FmIC95y38Tb76glNjLDCAa4LydZTX4VLu68=;
        b=e6qNf4lxemqi3iMS3iCC7uoVnvDkfGjb/NKgroRGu2r2ZR61v/5XkpDxV4nsSD6FRY
         ZUALtutSAQZgaJtXyxESIRgGVVq3ApSl7mSjeeOA1NME2/Rkak1MsiHLiCevPEtNyWqI
         itF98XBD7bJ51i9hcEM4c3ukzDV3lja310s3ShOd1nz9QCwSlMaRJDtN0f1dmmmt/UL6
         oXaFdKYFHYw1XVSSYnvFjH19OoFpAdEOB9wlsbrr59IDj4F3l4guaQEkrjP3NZJO5fjs
         /6y/CIdsL0nx3udEAlh1IwhsRsNcofYWiHM4esg6H0VaxtUtUIfpzqbd4W4loj1N0gdI
         qaPw==
X-Gm-Message-State: AOJu0YwJqSX2SKAhVhH3kSM2ezPUFHtgoU5nRzmIMZCXaqaV2xXKzRok
	V6vSlK3iFIZPIYEf6mYj99jqfw031g4kyrBJCnysorOm5fPFHURDxvbvzFaxMA==
X-Gm-Gg: ASbGncvRxVMu6H+iAMdaUS56n6jYkXA5zdfgRmTM5fbRFGMnettZUUEoKAR0NprP+0x
	CAiVjbLyaXq71N/gJUZLOFQZjSXHB5avPDajQ8jmiYySSFg841VN/PBbAfrxoZo/mhwdL5FAS5K
	0+sMtA88JypvOWarIrC86c3mwMGU81dfie6WINiT9t094gcu9seDvM1zQR4iZm9LS+yu8PUFePV
	T/vJvg+JJ7r3ICPK8He1KZNeyvNED01CIZ/kDS+emSSbUKYYTjJnwZzA6Unhv5jDPwm5iy736uc
	roF4ruzHY6iDvQAQ75xIcl/XuQ4of65cg8O4dZiDtli/qLH4gY3GuWfe3z54Tp0=
X-Google-Smtp-Source: AGHT+IER8XTDik/qhEuf/wnKRB1zPzQnowSd8hpLsc1MN9lcE0NSYf4bJ7+1y3l7+bDP0r6m2sAQxg==
X-Received: by 2002:a05:6000:2909:b0:3a3:5c05:d98b with SMTP id ffacd0b85a97d-3a4cb44533fmr5628982f8f.5.1748204838051;
        Sun, 25 May 2025 13:27:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d54af5c9sm2334779f8f.40.2025.05.25.13.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 13:27:17 -0700 (PDT)
Message-Id: <907bbb46c4bac448ed6666e1e95bda7df8d7e010.1748204829.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
References: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 20:27:08 +0000
Subject: [PATCH 8/9] doc: convert git-mergetool options to new synopsis style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/mergetool.adoc   | 54 +++++++++++++--------------
 Documentation/mergetools/vimdiff.adoc | 16 ++++----
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Documentation/config/mergetool.adoc b/Documentation/config/mergetool.adoc
index 00bf665aa09b..6be506145c15 100644
--- a/Documentation/config/mergetool.adoc
+++ b/Documentation/config/mergetool.adoc
@@ -1,24 +1,24 @@
-mergetool.<tool>.path::
+`mergetool.<tool>.path`::
 	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
+	your tool is not in the `$PATH`.
 
-mergetool.<tool>.cmd::
+`mergetool.<tool>.cmd`::
 	Specify the command to invoke the specified merge tool.  The
 	specified command is evaluated in shell with the following
-	variables available: 'BASE' is the name of a temporary file
+	variables available: `BASE` is the name of a temporary file
 	containing the common base of the files to be merged, if available;
-	'LOCAL' is the name of a temporary file containing the contents of
-	the file on the current branch; 'REMOTE' is the name of a temporary
+	`LOCAL` is the name of a temporary file containing the contents of
+	the file on the current branch; `REMOTE` is the name of a temporary
 	file containing the contents of the file from the branch being
-	merged; 'MERGED' contains the name of the file to which the merge
+	merged; `MERGED` contains the name of the file to which the merge
 	tool should write the results of a successful merge.
 
-mergetool.<tool>.hideResolved::
+`mergetool.<tool>.hideResolved`::
 	Allows the user to override the global `mergetool.hideResolved` value
 	for a specific tool. See `mergetool.hideResolved` for the full
 	description.
 
-mergetool.<tool>.trustExitCode::
+`mergetool.<tool>.trustExitCode`::
 	For a custom merge command, specify whether the exit code of
 	the merge command can be used to determine whether the merge was
 	successful.  If this is not set to true then the merge target file
@@ -26,7 +26,7 @@ mergetool.<tool>.trustExitCode::
 	if the file has been updated; otherwise, the user is prompted to
 	indicate the success of the merge.
 
-mergetool.meld.hasOutput::
+`mergetool.meld.hasOutput`::
 	Older versions of `meld` do not support the `--output` option.
 	Git will attempt to detect whether `meld` supports `--output`
 	by inspecting the output of `meld --help`.  Configuring
@@ -35,7 +35,7 @@ mergetool.meld.hasOutput::
 	to `true` tells Git to unconditionally use the `--output` option,
 	and `false` avoids using `--output`.
 
-mergetool.meld.useAutoMerge::
+`mergetool.meld.useAutoMerge`::
 	When the `--auto-merge` is given, meld will merge all non-conflicting
 	parts automatically, highlight the conflicting parts, and wait for
 	user decision.  Setting `mergetool.meld.useAutoMerge` to `true` tells
@@ -45,15 +45,15 @@ mergetool.meld.useAutoMerge::
 	value of `false` avoids using `--auto-merge` altogether, and is the
 	default value.
 
-mergetool.<vimdiff variant>.layout::
-	Configure the split window layout for vimdiff's `<variant>`, which is any of `vimdiff`,
+`mergetool.<variant>.layout`::
+	Configure the split window layout for vimdiff's _<variant>_, which is any of `vimdiff`,
 	`nvimdiff`, `gvimdiff`.
 	Upon launching `git mergetool` with `--tool=<variant>` (or without `--tool`
-	if `merge.tool` is configured as `<variant>`), Git will consult
+	if `merge.tool` is configured as _<variant>_), Git will consult
 	`mergetool.<variant>.layout` to determine the tool's layout. If the
-	variant-specific configuration is not available, `vimdiff`'s is used as
+	variant-specific configuration is not available, `vimdiff` ' s is used as
 	fallback.  If that too is not available, a default layout with 4 windows
-	will be used.  To configure the layout, see the `BACKEND SPECIFIC HINTS`
+	will be used.  To configure the layout, see the 'BACKEND SPECIFIC HINTS'
 ifdef::git-mergetool[]
 	section.
 endif::[]
@@ -61,39 +61,39 @@ ifndef::git-mergetool[]
 	section in linkgit:git-mergetool[1].
 endif::[]
 
-mergetool.hideResolved::
+`mergetool.hideResolved`::
 	During a merge, Git will automatically resolve as many conflicts as
-	possible and write the 'MERGED' file containing conflict markers around
-	any conflicts that it cannot resolve; 'LOCAL' and 'REMOTE' normally
-	represent the versions of the file from before Git's conflict
-	resolution. This flag causes 'LOCAL' and 'REMOTE' to be overwritten so
+	possible and write the `$MERGED` file containing conflict markers around
+	any conflicts that it cannot resolve; `$LOCAL` and `$REMOTE` normally
+	are the versions of the file from before Git`s conflict
+	resolution. This flag causes `$LOCAL` and `$REMOTE` to be overwritten so
 	that only the unresolved conflicts are presented to the merge tool. Can
 	be configured per-tool via the `mergetool.<tool>.hideResolved`
 	configuration variable. Defaults to `false`.
 
-mergetool.keepBackup::
+`mergetool.keepBackup`::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
 	is set to `false` then this file is not preserved.  Defaults to
 	`true` (i.e. keep the backup files).
 
-mergetool.keepTemporaries::
+`mergetool.keepTemporaries`::
 	When invoking a custom merge tool, Git uses a set of temporary
 	files to pass to the tool. If the tool returns an error and this
 	variable is set to `true`, then these temporary files will be
 	preserved; otherwise, they will be removed after the tool has
 	exited. Defaults to `false`.
 
-mergetool.writeToTemp::
-	Git writes temporary 'BASE', 'LOCAL', and 'REMOTE' versions of
+`mergetool.writeToTemp`::
+	Git writes temporary `BASE`, `LOCAL`, and `REMOTE` versions of
 	conflicting files in the worktree by default.  Git will attempt
 	to use a temporary directory for these files when set `true`.
 	Defaults to `false`.
 
-mergetool.prompt::
+`mergetool.prompt`::
 	Prompt before each invocation of the merge resolution program.
 
-mergetool.guiDefault::
+`mergetool.guiDefault`::
 	Set `true` to use the `merge.guitool` by default (equivalent to
 	specifying the `--gui` argument), or `auto` to select `merge.guitool`
 	or `merge.tool` depending on the presence of a `DISPLAY` environment
diff --git a/Documentation/mergetools/vimdiff.adoc b/Documentation/mergetools/vimdiff.adoc
index ab915df408e8..abfd426f74a0 100644
--- a/Documentation/mergetools/vimdiff.adoc
+++ b/Documentation/mergetools/vimdiff.adoc
@@ -183,13 +183,13 @@ latter will be used as fallback if the variant-specific one is not set).
 In addition, for backwards compatibility with previous Git versions, you can
 also append `1`, `2` or `3` to either `vimdiff` or any of the variants (ex:
 `vimdiff3`, `nvimdiff1`, etc...) to use a predefined layout.
-In other words, using `--tool=[g,n,]vimdiffx` is the same as using
-`--tool=[g,n,]vimdiff` and setting configuration variable
-`mergetool.[g,n,]vimdiff.layout` to...
+In other words, using `--tool=[g|n]vimdiff<x>` is the same as using
+`--tool=[g|n]vimdiff` and setting configuration variable
+`mergetool.[g|n]vimdiff.layout` to...
 
-  * `x=1`: `"@LOCAL, REMOTE"`
-  * `x=2`: `"LOCAL, MERGED, REMOTE"`
-  * `x=3`: `"MERGED"`
+  * `<x>=1`: `"@LOCAL, REMOTE"`
+  * `<x>=2`: `"LOCAL, MERGED, REMOTE"`
+  * `<x>=3`: `"MERGED"`
 
-Example: using `--tool=gvimdiff2` will open `gvim` with three columns (LOCAL,
-MERGED and REMOTE).
+Example: using `--tool=gvimdiff2` will open `gvim` with three columns (`LOCAL`,
+`MERGED` and `REMOTE`).
-- 
gitgitgadget

