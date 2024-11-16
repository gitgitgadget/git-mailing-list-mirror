Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60D1A3BA1
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785782; cv=none; b=Ux19+0YYKjkW8Vo+sJIdvE8b4N1PSjy21RB4421K8RxzPPsvYo0SL/CP/vGxQSgVcAor2pQ4P9sRV9SI6W8nYfAowc6N547ZQ9PMMVYu8LVj7Q9rDWS7kZ4emcsDwTr1rSIW8Ns50BrQqJT8VhgQaOYFKHGiti91x9ByOuLBSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785782; c=relaxed/simple;
	bh=eQaEgQYeAqAI9z/Ci4lldUMZfuqLo3ac4TPkBRZHgAc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=BDPTilxvF+IhnF6L//qIom98Byv+h4pkIeBwZpzA0DbmiNYk0DG8GlBmY+aPI5vYAvw03ifsZcTKjp+QCWObL+T1Qh0RmCpp8O831aqvgWIH0ox4vVFCCOuiYA85hsu7niC5S0cPJnU2GXbTStWC0dcn7OLUqE4CDaEzlwdIX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiGb0LsG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiGb0LsG"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3822ba3cdbcso987273f8f.0
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 11:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731785778; x=1732390578; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhumRkH1SLeEL/3fwKGELzg0e35VskpZ+nrbAYgQBGk=;
        b=WiGb0LsG1nWUh7KdcNJ46cliRS8Gf2A+t9ET2qagd+Ts2MEoS0mJQcLl/re5TZa1Ie
         QBfSi9aEFlKqm0xZPVEtc2+QkKGy0+BvqACCVDl+b7ZVLL+DXsMtNcgL20kKVMINDBE6
         0T25gH0QEG0aUlsJBAhjbEg0mOpOFLcDKLzBcmG+izUqokqTwfJDBxPWvh6+EyOIeop1
         /QCudpwC/xxXw1nunfVkbCVDBTc3WWYJtWNEWZRgAmpLqXGDiKbl7NoBBn8iv02PJYT9
         gpXDrgf0b9OZYf7BQ+3NdTytptAOvU7CFA0N0sqKw4GHQtuAiXV+AhG8MjxNucFbGzKj
         CNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731785778; x=1732390578;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhumRkH1SLeEL/3fwKGELzg0e35VskpZ+nrbAYgQBGk=;
        b=Jj6hSnW0qxMLpZK3qkoeFL8ng9bNN54AEvlHkYhUmNful48u9+Zcsr67ta4LFARJTd
         sNcnpsmj2s4+wXuX1BWdW6TERJGOeAkI6y0IaBriGgm0Vpgc1Vw/cv52p39Xy3gtKyfF
         L9SpByYxs8Gi1MZ9n0trbQ1dnBHdb2G17CsnKkIouONdzYxAzRPx5UQZ73+/5Swx51KG
         jb1dsyX2Vep+qvtBE2YNZ5sNoQF/h0p3yypGcsWLUse2o5jyh4uhDez/Math48MFZexB
         YEDwEpkegX9Lh+oUDPCK9qaAwCqQPvadfj41IOKWciMAzFMoBzEczBIRvAAcfcR+TnuL
         ct+Q==
X-Gm-Message-State: AOJu0YyaYK4q0iYsQSVFeq4qJsnqgcepjTaGiMB4otjb+Yrt+842H+cq
	Dhhf1gaAdy/XP9kAGT4tsLnGwUaDfkW9V1QO6cBMZen1MzuUlnrhgjo2lw==
X-Google-Smtp-Source: AGHT+IE/+kbzY+Silk5tIoyg3qIMc4gGpHHodw6S40OLpbGHTc6quyJkglHwrSvvsB9IB+10vZJqjw==
X-Received: by 2002:a05:6000:796:b0:37d:4744:9d1d with SMTP id ffacd0b85a97d-38225a39168mr5814269f8f.35.1731785777871;
        Sat, 16 Nov 2024 11:36:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3822f6afc20sm3960962f8f.81.2024.11.16.11.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 11:36:16 -0800 (PST)
Message-Id: <4ec2fd9c3c68163a358937498b523292c3d38465.1731785769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
References: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Nov 2024 19:36:08 +0000
Subject: [PATCH v3 5/5] doc: git-diff: apply format changes to config part
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

By the way, we also change the sentences where git-diff would refer to
itself, so that no link is created in the HTML output.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/diff.txt | 204 ++++++++++++++++++----------------
 1 file changed, 111 insertions(+), 93 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 190bda17e51..45f3fe855c5 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -1,18 +1,25 @@
-diff.autoRefreshIndex::
-	When using 'git diff' to compare with work tree
+`diff.autoRefreshIndex`::
+	When using `git diff` to compare with work tree
 	files, do not consider stat-only changes as changed.
 	Instead, silently run `git update-index --refresh` to
 	update the cached stat information for paths whose
 	contents in the work tree match the contents in the
-	index.  This option defaults to true.  Note that this
-	affects only 'git diff' Porcelain, and not lower level
-	'diff' commands such as 'git diff-files'.
+	index.  This option defaults to `true`.  Note that this
+	affects only `git diff` Porcelain, and not lower level
+	`diff` commands such as `git diff-files`.
 
-diff.dirstat::
+`diff.dirstat`::
+ifdef::git-diff[]
+	A comma separated list of `--dirstat` parameters specifying the
+	default behavior of the `--dirstat` option to `git diff` and friends.
+endif::git-diff[]
+ifndef::git-diff[]
 	A comma separated list of `--dirstat` parameters specifying the
 	default behavior of the `--dirstat` option to linkgit:git-diff[1]
-	and friends. The defaults can be overridden on the command line
-	(using `--dirstat=<param1,param2,...>`). The fallback defaults
+	and friends.
+endif::git-diff[]
+	The defaults can be overridden on the command line
+	(using `--dirstat=<param>,...`). The fallback defaults
 	(when not changed by `diff.dirstat`) are `changes,noncumulative,3`.
 	The following parameters are available:
 +
@@ -41,7 +48,7 @@ diff.dirstat::
 	Note that when using `cumulative`, the sum of the percentages
 	reported may exceed 100%. The default (non-cumulative) behavior can
 	be specified with the `noncumulative` parameter.
-<limit>;;
+_<limit>_;;
 	An integer parameter specifies a cut-off percent (3% by default).
 	Directories contributing less than this percentage of the changes
 	are not shown in the output.
@@ -52,58 +59,58 @@ directories with less than 10% of the total amount of changed files,
 and accumulating child directory counts in the parent directories:
 `files,10,cumulative`.
 
-diff.statNameWidth::
-	Limit the width of the filename part in --stat output. If set, applies
-	to all commands generating --stat output except format-patch.
+`diff.statNameWidth`::
+	Limit the width of the filename part in `--stat` output. If set, applies
+	to all commands generating `--stat` output except `format-patch`.
 
-diff.statGraphWidth::
-	Limit the width of the graph part in --stat output. If set, applies
-	to all commands generating --stat output except format-patch.
+`diff.statGraphWidth`::
+	Limit the width of the graph part in `--stat` output. If set, applies
+	to all commands generating `--stat` output except `format-patch`.
 
-diff.context::
-	Generate diffs with <n> lines of context instead of the default
-	of 3. This value is overridden by the -U option.
+`diff.context`::
+	Generate diffs with _<n>_ lines of context instead of the default
+	of 3. This value is overridden by the `-U` option.
 
-diff.interHunkContext::
+`diff.interHunkContext`::
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing the hunks that are close to each other.
 	This value serves as the default for the `--inter-hunk-context`
 	command line option.
 
-diff.external::
+`diff.external`::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
-	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF'
+	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF`
 	environment variable.  The command is called with parameters
 	as described under "git Diffs" in linkgit:git[1].  Note: if
 	you want to use an external diff program only on a subset of
 	your files, you might want to use linkgit:gitattributes[5] instead.
 
-diff.trustExitCode::
-	If this boolean value is set to true then the
+`diff.trustExitCode`::
+	If this boolean value is set to `true` then the
 	`diff.external` command is expected to return exit code
 	0 if it considers the input files to be equal or 1 if it
-	considers them to be different, like `diff(1)`.
-	If it is set to false, which is the default, then the command
-	is expected to return exit code 0 regardless of equality.
+	considers them to be different, like `diff`(1).
+	If it is set to `false`, which is the default, then the command
+	is expected to return exit code `0` regardless of equality.
 	Any other exit code causes Git to report a fatal error.
 
-diff.ignoreSubmodules::
-	Sets the default value of --ignore-submodules. Note that this
-	affects only 'git diff' Porcelain, and not lower level 'diff'
-	commands such as 'git diff-files'. 'git checkout'
-	and 'git switch' also honor
+`diff.ignoreSubmodules`::
+	Sets the default value of `--ignore-submodules`. Note that this
+	affects only `git diff` Porcelain, and not lower level `diff`
+	commands such as `git diff-files`. `git checkout`
+	and `git switch` also honor
 	this setting when reporting uncommitted changes. Setting it to
-	'all' disables the submodule summary normally shown by 'git commit'
-	and 'git status' when `status.submoduleSummary` is set unless it is
-	overridden by using the --ignore-submodules command-line option.
-	The 'git submodule' commands are not affected by this setting.
+	`all` disables the submodule summary normally shown by `git commit`
+	and `git status` when `status.submoduleSummary` is set unless it is
+	overridden by using the `--ignore-submodules` command-line option.
+	The `git submodule` commands are not affected by this setting.
 	By default this is set to untracked so that any untracked
 	submodules are ignored.
 
-diff.mnemonicPrefix::
-	If set, 'git diff' uses a prefix pair that is different from the
-	standard "a/" and "b/" depending on what is being compared.  When
+`diff.mnemonicPrefix`::
+	If set, `git diff` uses a prefix pair that is different from the
+	standard `a/` and `b/` depending on what is being compared.  When
 	this configuration is in effect, reverse diff output also swaps
 	the order of the prefixes:
 `git diff`;;
@@ -112,111 +119,117 @@ diff.mnemonicPrefix::
 	 compares a (c)ommit and the (w)ork tree;
 `git diff --cached`;;
 	compares a (c)ommit and the (i)ndex;
-`git diff HEAD:file1 file2`;;
+`git diff HEAD:<file1> <file2>`;;
 	compares an (o)bject and a (w)ork tree entity;
-`git diff --no-index a b`;;
-	compares two non-git things (1) and (2).
+`git diff --no-index <a> <b>`;;
+	compares two non-git things _<a>_ and _<b>_.
 
-diff.noPrefix::
-	If set, 'git diff' does not show any source or destination prefix.
+`diff.noPrefix`::
+	If set, `git diff` does not show any source or destination prefix.
 
-diff.srcPrefix::
-	If set, 'git diff' uses this source prefix. Defaults to "a/".
+`diff.srcPrefix`::
+	If set, `git diff` uses this source prefix. Defaults to `a/`.
 
-diff.dstPrefix::
-	If set, 'git diff' uses this destination prefix. Defaults to "b/".
+`diff.dstPrefix`::
+	If set, `git diff` uses this destination prefix. Defaults to `b/`.
 
-diff.relative::
-	If set to 'true', 'git diff' does not show changes outside of the directory
+`diff.relative`::
+	If set to `true`, `git diff` does not show changes outside of the directory
 	and show pathnames relative to the current directory.
 
-diff.orderFile::
+`diff.orderFile`::
 	File indicating how to order files within a diff.
-	See the '-O' option to linkgit:git-diff[1] for details.
+ifdef::git-diff[]
+	See the `-O` option for details.
+endif::git-diff[]
+ifndef::git-diff[]
+	See the `-O` option to linkgit:git-diff[1] for details.
+endif::git-diff[]
 	If `diff.orderFile` is a relative pathname, it is treated as
 	relative to the top of the working tree.
 
-diff.renameLimit::
+`diff.renameLimit`::
 	The number of files to consider in the exhaustive portion of
-	copy/rename detection; equivalent to the 'git diff' option
+	copy/rename detection; equivalent to the `git diff` option
 	`-l`.  If not set, the default value is currently 1000.  This
 	setting has no effect if rename detection is turned off.
 
-diff.renames::
-	Whether and how Git detects renames.  If set to "false",
-	rename detection is disabled. If set to "true", basic rename
-	detection is enabled.  If set to "copies" or "copy", Git will
-	detect copies, as well.  Defaults to true.  Note that this
-	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
+`diff.renames`::
+	Whether and how Git detects renames.  If set to `false`,
+	rename detection is disabled. If set to `true`, basic rename
+	detection is enabled.  If set to `copies` or `copy`, Git will
+	detect copies, as well.  Defaults to `true`.  Note that this
+	affects only `git diff` Porcelain like linkgit:git-diff[1] and
 	linkgit:git-log[1], and not lower level commands such as
 	linkgit:git-diff-files[1].
 
-diff.suppressBlankEmpty::
+`diff.suppressBlankEmpty`::
 	A boolean to inhibit the standard behavior of printing a space
-	before each empty output line. Defaults to false.
+	before each empty output line. Defaults to `false`.
 
-diff.submodule::
+`diff.submodule`::
 	Specify the format in which differences in submodules are
-	shown.  The "short" format just shows the names of the commits
-	at the beginning and end of the range. The "log" format lists
+	shown.  The `short` format just shows the names of the commits
+	at the beginning and end of the range. The `log` format lists
 	the commits in the range like linkgit:git-submodule[1] `summary`
-	does. The "diff" format shows an inline diff of the changed
-	contents of the submodule. Defaults to "short".
+	does. The `diff` format shows an inline diff of the changed
+	contents of the submodule. Defaults to `short`.
 
-diff.wordRegex::
+`diff.wordRegex`::
 	A POSIX Extended Regular Expression used to determine what is a "word"
 	when performing word-by-word difference calculations.  Character
 	sequences that match the regular expression are "words", all other
 	characters are *ignorable* whitespace.
 
-diff.<driver>.command::
+`diff.<driver>.command`::
 	The custom diff driver command.  See linkgit:gitattributes[5]
 	for details.
 
-diff.<driver>.trustExitCode::
-	If this boolean value is set to true then the
+`diff.<driver>.trustExitCode`::
+	If this boolean value is set to `true` then the
 	`diff.<driver>.command` command is expected to return exit code
 	0 if it considers the input files to be equal or 1 if it
-	considers them to be different, like `diff(1)`.
-	If it is set to false, which is the default, then the command
+	considers them to be different, like `diff`(1).
+	If it is set to `false`, which is the default, then the command
 	is expected to return exit code 0 regardless of equality.
 	Any other exit code causes Git to report a fatal error.
 
-diff.<driver>.xfuncname::
+`diff.<driver>.xfuncname`::
 	The regular expression that the diff driver should use to
 	recognize the hunk header.  A built-in pattern may also be used.
 	See linkgit:gitattributes[5] for details.
 
-diff.<driver>.binary::
-	Set this option to true to make the diff driver treat files as
+`diff.<driver>.binary`::
+	Set this option to `true` to make the diff driver treat files as
 	binary.  See linkgit:gitattributes[5] for details.
 
-diff.<driver>.textconv::
+`diff.<driver>.textconv`::
 	The command that the diff driver should call to generate the
 	text-converted version of a file.  The result of the
 	conversion is used to generate a human-readable diff.  See
 	linkgit:gitattributes[5] for details.
 
-diff.<driver>.wordRegex::
+`diff.<driver>.wordRegex`::
 	The regular expression that the diff driver should use to
 	split words in a line.  See linkgit:gitattributes[5] for
 	details.
 
-diff.<driver>.cachetextconv::
-	Set this option to true to make the diff driver cache the text
+`diff.<driver>.cachetextconv`::
+	Set this option to `true` to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
 include::../mergetools-diff.txt[]
 
-diff.indentHeuristic::
+`diff.indentHeuristic`::
 	Set this option to `false` to disable the default heuristics
 	that shift diff hunk boundaries to make patches easier to read.
 
-diff.algorithm::
+`diff.algorithm`::
 	Choose a diff algorithm.  The variants are as follows:
 +
 --
-`default`, `myers`;;
+`default`;;
+`myers`;;
 	The basic greedy diff algorithm. Currently, this is the default.
 `minimal`;;
 	Spend extra time to make sure the smallest possible diff is
@@ -229,7 +242,7 @@ diff.algorithm::
 --
 +
 
-diff.wsErrorHighlight::
+`diff.wsErrorHighlight`::
 	Highlight whitespace errors in the `context`, `old` or `new`
 	lines of the diff.  Multiple values are separated by comma,
 	`none` resets previous values, `default` reset the list to
@@ -238,14 +251,19 @@ diff.wsErrorHighlight::
 	The command line option `--ws-error-highlight=<kind>`
 	overrides this setting.
 
-diff.colorMoved::
-	If set to either a valid `<mode>` or a true value, moved lines
-	in a diff are colored differently, for details of valid modes
-	see '--color-moved' in linkgit:git-diff[1]. If simply set to
-	true the default color mode will be used. When set to false,
-	moved lines are not colored.
-
-diff.colorMovedWS::
+`diff.colorMoved`::
+	If set to either a valid _<mode>_ or a `true` value, moved lines
+	in a diff are colored differently.
+ifdef::git-diff[]
+	For details of valid modes see `--color-moved`.
+endif::git-diff[]
+ifndef::git-diff[]
+	For details of valid modes see `--color-moved` in linkgit:git-diff[1].
+endif::git-diff[]
+	If simply set to `true` the default color mode will be used. When
+	set to `false`, moved lines are not colored.
+
+`diff.colorMovedWS`::
 	When moved lines are colored using e.g. the `diff.colorMoved` setting,
-	this option controls the `<mode>` how spaces are treated.
-	For details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
+	this option controls the mode how spaces are treated.
+	For details of valid modes see `--color-moved-ws` in linkgit:git-diff[1].
-- 
gitgitgadget
