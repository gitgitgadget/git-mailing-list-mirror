Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BD1A3047
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343995; cv=none; b=FRogHCmkyh5ijfzkCE4AdDEY6skN7+M+RrkIwXfIvmS9/nPH2JcSoo3iEIYVtWQe0MMv5qqXFRq5G9m8yVsI3FkmZ0gp9+AlNvYs2S8QyQ+4H7YDvI1V3dds5pQ7GUoti0oPi6zEmKgfskp8d+RRINBJ7fFTTNYz8mJ33d+Si6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343995; c=relaxed/simple;
	bh=s3S/rhpkpVDHytOZVvw+2cduRm9wPcA/VJsbWqNfwwQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=rhXS9Zd7IbXoUUe88Qg306Mp90P8KCXKB4U9k0/gzfxjCpYs8XHBcLZlZ2W2lRJCAyIYmLq8CZxAqGFn4Bm2yVPBRXvOLkxaA+Q9gEqmq/NHjHmB5oOXNdL83cdb/2hiivvxiSL9S0B/PpIGHlD/f1aCZEiUmtz//mpWHd8S4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0ZZy9ta; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0ZZy9ta"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso4538873f8f.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731343992; x=1731948792; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57G5GPgyKNklQwVCxOKSQOuzsuI0ejhL62Td7m5HfnQ=;
        b=F0ZZy9tabkcpqqn8pCTA/hz6ryz5xKLiQL72AC5uvVZrLOkXGGLEUZNAiLVOSyFyKx
         SwRp7C+BqO3xkNwHDugK3aaKNuTUrCVuhy7dydTIgmlyXSdf9jg8y7PJCv94cxCa5ozh
         rdiuGUI8Cfy9G0VQ6Ye/AYLf7qtvgQV+xpODJNOuSUpK6OXIyMtGprbFUPV1SmVF0Je+
         HMz5/G+R3JMOsygCYrfHpdFPjfv6E8A/mMWrlm9Ns5KtunhxjDnjzcNksHYDbDJDbFxI
         6W1PVDUWGtJzBGELT6BSHDNQwUrCBI6tECWJhoHt0rcVbuR0jp71PUiSDzcDW42sLc1m
         VGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343992; x=1731948792;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57G5GPgyKNklQwVCxOKSQOuzsuI0ejhL62Td7m5HfnQ=;
        b=j7uEx97hCxklR61zPY+sRVjCtEdSyxhV1hVG76fJZUzz5yBMJy/ADX2BvImlR3eOh0
         kAptHGWqvx2fZ9UXN63QeSYx7E6CsbuR0JbBcVpGnrw5SwLKkfH0RKOddWJWrptQxgPO
         OVM3RATSgDEjQuFAzp8ubK7rhG+36MVSsq0n/QaLHxd1KU1lUYG2mjIB6m7AI0GaCLJK
         ZAnFc7ODfMCR+UjpLeGtYJLs+0NHjbhEFzJ0wqMjd0lg9GMA1rhY8gnoTzT8fbzcZwHQ
         jAv1GcC/RDNKRFfOFb8TvAL/AKAjHSAd+k42mVHHeElcydnTfvJg+xdf2xYx+s+cq2QE
         PHNw==
X-Gm-Message-State: AOJu0YzEHXsY0ZHaxrY1Gdd/sD1vX8omWvNq21Fe96fsSN/xKdfTpHJz
	PxpAbxAeit5di+f4WtaiREmY/OJ8bnHUvwIxDJYBkGRUbhCu7jsevRk1sA==
X-Google-Smtp-Source: AGHT+IFM7GJH07JQrzRTt+8a4F8m6414X/4hmUpApsyBdJZk+2pS8iiflQEg61lmKUlingOGSXUAOg==
X-Received: by 2002:a05:6000:1543:b0:37d:95a7:9e57 with SMTP id ffacd0b85a97d-381f1866efamr14290750f8f.2.1731343991591;
        Mon, 11 Nov 2024 08:53:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b3de8710sm164062405e9.17.2024.11.11.08.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:53:11 -0800 (PST)
Message-Id: <17a2f028d59a0097e92229c2b934a69974691e79.1731343985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
	<pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Nov 2024 16:53:05 +0000
Subject: [PATCH v2 5/5] doc: git-diff: apply format changes to config part
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

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/diff.txt | 163 +++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 81 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 190bda17e51..e60c19292da 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -1,18 +1,18 @@
-diff.autoRefreshIndex::
-	When using 'git diff' to compare with work tree
+`diff.autoRefreshIndex`::
+	When using `git diff` to compare with work tree
 	files, do not consider stat-only changes as changed.
 	Instead, silently run `git update-index --refresh` to
 	update the cached stat information for paths whose
 	contents in the work tree match the contents in the
 	index.  This option defaults to true.  Note that this
-	affects only 'git diff' Porcelain, and not lower level
-	'diff' commands such as 'git diff-files'.
+	affects only `git diff` Porcelain, and not lower level
+	`diff` commands such as '`git diff-files`.
 
-diff.dirstat::
+`diff.dirstat`::
 	A comma separated list of `--dirstat` parameters specifying the
 	default behavior of the `--dirstat` option to linkgit:git-diff[1]
 	and friends. The defaults can be overridden on the command line
-	(using `--dirstat=<param1,param2,...>`). The fallback defaults
+	(using `--dirstat=<param>,...`). The fallback defaults
 	(when not changed by `diff.dirstat`) are `changes,noncumulative,3`.
 	The following parameters are available:
 +
@@ -41,7 +41,7 @@ diff.dirstat::
 	Note that when using `cumulative`, the sum of the percentages
 	reported may exceed 100%. The default (non-cumulative) behavior can
 	be specified with the `noncumulative` parameter.
-<limit>;;
+_<limit>_;;
 	An integer parameter specifies a cut-off percent (3% by default).
 	Directories contributing less than this percentage of the changes
 	are not shown in the output.
@@ -52,57 +52,57 @@ directories with less than 10% of the total amount of changed files,
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
+`diff.mnemonicPrefix`::
+	If set, `git diff` uses a prefix pair that is different from the
 	standard "a/" and "b/" depending on what is being compared.  When
 	this configuration is in effect, reverse diff output also swaps
 	the order of the prefixes:
@@ -112,111 +112,112 @@ diff.mnemonicPrefix::
 	 compares a (c)ommit and the (w)ork tree;
 `git diff --cached`;;
 	compares a (c)ommit and the (i)ndex;
-`git diff HEAD:file1 file2`;;
+`git diff HEAD:<file1> <file2>`;;
 	compares an (o)bject and a (w)ork tree entity;
 `git diff --no-index a b`;;
 	compares two non-git things (1) and (2).
 
-diff.noPrefix::
-	If set, 'git diff' does not show any source or destination prefix.
+`diff.noPrefix`::
+	If set, `git diff` does not show any source or destination prefix.
 
-diff.srcPrefix::
-	If set, 'git diff' uses this source prefix. Defaults to "a/".
+`diff.srcPrefix`::
+	If set, `git diff` uses this source prefix. Defaults to "a/".
 
-diff.dstPrefix::
-	If set, 'git diff' uses this destination prefix. Defaults to "b/".
+`diff.dstPrefix`::
+	If set, `git diff` uses this destination prefix. Defaults to "b/".
 
-diff.relative::
-	If set to 'true', 'git diff' does not show changes outside of the directory
+`diff.relative`::
+	If set to `true`, `git diff` does not show changes outside of the directory
 	and show pathnames relative to the current directory.
 
-diff.orderFile::
+`diff.orderFile`::
 	File indicating how to order files within a diff.
-	See the '-O' option to linkgit:git-diff[1] for details.
+	See the `-O` option to linkgit:git-diff[1] for details.
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
+`diff.renames`::
+	Whether and how Git detects renames.  If set to `false`,
+	rename detection is disabled. If set to `true`, basic rename
+	detection is enabled.  If set to `copies` or `copy`, Git will
 	detect copies, as well.  Defaults to true.  Note that this
-	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
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
+`diff.<driver>.trustExitCode`::
 	If this boolean value is set to true then the
 	`diff.<driver>.command` command is expected to return exit code
 	0 if it considers the input files to be equal or 1 if it
-	considers them to be different, like `diff(1)`.
+	considers them to be different, like `diff`(1).
 	If it is set to false, which is the default, then the command
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
+`diff.<driver>.cachetextconv`::
 	Set this option to true to make the diff driver cache the text
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
@@ -229,7 +230,7 @@ diff.algorithm::
 --
 +
 
-diff.wsErrorHighlight::
+`diff.wsErrorHighlight`::
 	Highlight whitespace errors in the `context`, `old` or `new`
 	lines of the diff.  Multiple values are separated by comma,
 	`none` resets previous values, `default` reset the list to
@@ -238,14 +239,14 @@ diff.wsErrorHighlight::
 	The command line option `--ws-error-highlight=<kind>`
 	overrides this setting.
 
-diff.colorMoved::
-	If set to either a valid `<mode>` or a true value, moved lines
+`diff.colorMoved`::
+	If set to either a valid _<mode>_ or a true value, moved lines
 	in a diff are colored differently, for details of valid modes
-	see '--color-moved' in linkgit:git-diff[1]. If simply set to
-	true the default color mode will be used. When set to false,
+	see `--color-moved` in linkgit:git-diff[1]. If simply set to
+	`true` the default color mode will be used. When set to `false`,
 	moved lines are not colored.
 
-diff.colorMovedWS::
+`diff.colorMovedWS`::
 	When moved lines are colored using e.g. the `diff.colorMoved` setting,
-	this option controls the `<mode>` how spaces are treated.
-	For details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
+	this option controls the mode how spaces are treated.
+	For details of valid modes see `--color-moved-ws` in linkgit:git-diff[1].
-- 
gitgitgadget
