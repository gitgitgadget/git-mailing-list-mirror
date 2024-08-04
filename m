Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B393F175AE
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722801945; cv=none; b=ZTUo+AbpN+jGHkSpxfMo8w94jLcKLaZ4aVqo14SvVRmCFYNbTuNRnAOG2jt67h1hgJW2V2+xXS2IgltyJx3OMXmLtKL3dQIttZIoi00wI0WWLPvzf4uVj8NRx9EcfXNBw/masMfbyS43T1HzPbs+rWX9JAQkiEOS/kzYBtLgK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722801945; c=relaxed/simple;
	bh=ccYi7xMBAc6yuMgIWHn6HJ3fRRkRILcFhaHnQ3zyrMw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=TYh25EfCfN1uqlski68Fu/AKX4xfwTfVKreZDYBQski78pUMTUZsX6w5DilMJboFJyhv32aomV3U78lwADx9r7iK+WTKCeb+JynBoGLtwUxUPFP8cshq6oUWMOrrTvLf3t8rcPEtn99FTKxIBd3woaA2zKlQ9XP6WXGme+WZyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNG2HGZS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNG2HGZS"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3687f91af40so5748475f8f.0
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 13:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722801941; x=1723406741; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFc2zaKdgF1zZP4gV9X43xA2yd7VsgF5g2CmCBUJ1JQ=;
        b=XNG2HGZSS23KYS1eV2Z5a/KDlwQb9a6m4Z3wR/42x58PIz2ivVLURrmRKy8PYU/HPZ
         BamyX3qVHu+tLpqpWFbdRvpx2pBXfroPGSju41zjdOHCdxfQon3mv6POseGHedY/wjaG
         MacQw+y359WYQqghPH7OZ5KxUs0WZVYmty3BFaoXgJPaF4o2ktaplYTcYN5Evs0uDEgQ
         UxNbdtag33rm9FRNST7V/uRtSZmcOunOsVNFudqfaaIvFh1mS/WwjN020Q0ilhZgStin
         e8wNnOXJtP1cCwfsKhs880yM4oPuz9QkumlumRMDjQ57m/ax+YpfmmvH2DYoDzpLTvFx
         +SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722801941; x=1723406741;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFc2zaKdgF1zZP4gV9X43xA2yd7VsgF5g2CmCBUJ1JQ=;
        b=b7qaEvSwwYK+a2UIzuME+GCz7NyyTek3wdbODzegfPdCifn/HLFke8C2euJxaLnKWd
         wb+xGO6rBzpjtp/0r8gJs6/bkr54LcBhuJvgbZRPLIH1nOx+bGiFzkJIVajg3B+ZUZe6
         vzN38PmYZgVyNtdqcXGgCW/8iCCD/NPiuxlF/qyj5LvbkoLRLjxdSefCV0mafdciQcmR
         LWhfeFp59aa3hg48XQzu3kqUCAJMFAbprk/aWb3L4D5Sb/i+EdU3gRmHj4SGpbBnDFEd
         33dFiyeATTkjc67/8V4tRvgR+k9zBNHKefFRU3Q7p+bsmd/mb+AuwEkE2idAkAGKoyw5
         Yg3w==
X-Gm-Message-State: AOJu0YyM46x8nfB7K9eyJuDYKq2J7C174BLf2bSqCkXy0hn09bpUViSD
	y1n2Z8YJF4+9zFCLUUiiM3kaYXJ5oNmVNAdi6qEqybyfvqo9bwMgq/CXNg==
X-Google-Smtp-Source: AGHT+IG5AxuiYRCUVbRb4Hyq5DnX3ogV7vLsrjgsCSq61MhqY6K2S+cWtuGtVZMBF6wZPuO4aB0smA==
X-Received: by 2002:adf:ee8e:0:b0:367:9803:bfe5 with SMTP id ffacd0b85a97d-36bbc194210mr6095598f8f.55.1722801939903;
        Sun, 04 Aug 2024 13:05:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1e175sm7724521f8f.29.2024.08.04.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 13:05:39 -0700 (PDT)
Message-Id: <c1e7d6afb5099ecd533275ce228aae1c405654bd.1722801936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Aug 2024 20:05:33 +0000
Subject: [PATCH 2/5] doc: git-diff: apply format changes to diff-options
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

The format change is only applied to the sections of the file that are
filtered in git-diff.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-options.txt | 451 +++++++++++++++++----------------
 1 file changed, 229 insertions(+), 222 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index cd0b81adbb6..76050af6995 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -19,16 +19,16 @@ ifdef::git-format-patch[]
 endif::git-format-patch[]
 
 ifndef::git-format-patch[]
--p::
--u::
---patch::
+`-p`::
+`-u`::
+`--patch`::
 	Generate patch (see <<generate_patch_text_with_p>>).
 ifdef::git-diff[]
 	This is the default.
 endif::git-diff[]
 
--s::
---no-patch::
+`-s`::
+`--no-patch`::
 	Suppress all output from the diff machinery.  Useful for
 	commands like `git show` that show the patch by default to
 	squelch their output, or to cancel the effect of options like
@@ -39,28 +39,28 @@ endif::git-format-patch[]
 ifdef::git-log[]
 -m::
 	Show diffs for merge commits in the default format. This is
-	similar to '--diff-merges=on', except `-m` will
+	similar to `--diff-merges=on`, except `-m` will
 	produce no output unless `-p` is given as well.
 
 -c::
 	Produce combined diff output for merge commits.
-	Shortcut for '--diff-merges=combined -p'.
+	Shortcut for `--diff-merges=combined -p`.
 
 --cc::
 	Produce dense combined diff output for merge commits.
-	Shortcut for '--diff-merges=dense-combined -p'.
+	Shortcut for `--diff-merges=dense-combined -p`.
 
 --dd::
 	Produce diff with respect to first parent for both merge and
 	regular commits.
-	Shortcut for '--diff-merges=first-parent -p'.
+	Shortcut for `--diff-merges=first-parent -p`.
 
 --remerge-diff::
 	Produce remerge-diff output for merge commits.
-	Shortcut for '--diff-merges=remerge -p'.
+	Shortcut for `--diff-merges=remerge -p`.
 
 --no-diff-merges::
-	Synonym for '--diff-merges=off'.
+	Synonym for `--diff-merges=off`.
 
 --diff-merges=<format>::
 	Specify diff format to be used for merge commits. Default is
@@ -70,37 +70,43 @@ ifdef::git-log[]
 The following formats are supported:
 +
 --
-off, none::
+off::
+none::
 	Disable output of diffs for merge commits. Useful to override
 	implied value.
-+
-on, m::
+
+on::
+m::
 	Make diff output for merge commits to be shown in the default
 	format. The default format can be changed using
 	`log.diffMerges` configuration variable, whose default value
 	is `separate`.
-+
-first-parent, 1::
+
+first-parent::
+1::
 	Show full diff with respect to first parent. This is the same
 	format as `--patch` produces for non-merge commits.
-+
+
 separate::
 	Show full diff with respect to each of parents.
 	Separate log entry and diff is generated for each parent.
-+
-combined, c::
+
+combined::
+c::
 	Show differences from each of the parents to the merge
 	result simultaneously instead of showing pairwise diff between
 	a parent and the result one at a time. Furthermore, it lists
 	only files which were modified from all parents.
-+
-dense-combined, cc::
+
+dense-combined::
+cc::
 	Further compress output produced by `--diff-merges=combined`
 	by omitting uninteresting hunks whose contents in the parents
 	have only two variants and the merge result picks one of them
 	without modification.
-+
-remerge, r::
+
+remerge::
+r::
 	Remerge two-parent merge commits to create a temporary tree
 	object--potentially containing files with conflict markers
 	and such.  A diff is then shown between that temporary tree
@@ -112,33 +118,33 @@ documented).
 --
 
 --combined-all-paths::
-	This flag causes combined diffs (used for merge commits) to
+	cause combined diffs (used for merge commits) to
 	list the name of the file from all parents.  It thus only has
 	effect when `--diff-merges=[dense-]combined` is in use, and
 	is likely only useful if filename changes are detected (i.e.
 	when either rename or copy detection have been requested).
 endif::git-log[]
 
--U<n>::
---unified=<n>::
-	Generate diffs with <n> lines of context instead of
+++-U++__<n>__::
+++--unified=++__<n>__::
+	Generate diffs with _<n>_ lines of context instead of
 	the usual three.
 ifndef::git-format-patch[]
 	Implies `--patch`.
 endif::git-format-patch[]
 
---output=<file>::
-	Output to a specific file instead of stdout.
+++--output=++__<file>__::
+	Output to _<file>_ instead of stdout.
 
---output-indicator-new=<char>::
---output-indicator-old=<char>::
---output-indicator-context=<char>::
+++--output-indicator-new=++__<char>__::
+++--output-indicator-old=++__<char>__::
+++--output-indicator-context=++__<char>__::
 	Specify the character used to indicate new, old or context
-	lines in the generated patch. Normally they are '+', '-' and
+	lines in the generated patch. Normally they are `+`, `-` and
 	' ' respectively.
 
 ifndef::git-format-patch[]
---raw::
+`--raw`::
 ifndef::git-log[]
 	Generate the diff in raw format.
 ifdef::git-diff-core[]
@@ -155,103 +161,104 @@ endif::git-log[]
 endif::git-format-patch[]
 
 ifndef::git-format-patch[]
---patch-with-raw::
+`--patch-with-raw`::
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
 ifdef::git-log[]
--t::
+`-t`::
 	Show the tree objects in the diff output.
 endif::git-log[]
 
---indent-heuristic::
+`--indent-heuristic`::
 	Enable the heuristic that shifts diff hunk boundaries to make patches
 	easier to read. This is the default.
 
---no-indent-heuristic::
+`--no-indent-heuristic`::
 	Disable the indent heuristic.
 
---minimal::
+`--minimal`::
 	Spend extra time to make sure the smallest possible
 	diff is produced.
 
---patience::
+`--patience`::
 	Generate a diff using the "patience diff" algorithm.
 
---histogram::
+`--histogram`::
 	Generate a diff using the "histogram diff" algorithm.
 
---anchored=<text>::
+++--anchored=++__<text>__::
 	Generate a diff using the "anchored diff" algorithm.
 +
 This option may be specified more than once.
 +
 If a line exists in both the source and destination, exists only once,
-and starts with this text, this algorithm attempts to prevent it from
+and starts with _<text>_, this algorithm attempts to prevent it from
 appearing as a deletion or addition in the output. It uses the "patience
 diff" algorithm internally.
 
---diff-algorithm={patience|minimal|histogram|myers}::
+`--diff-algorithm=`(`patience`|`minimal`|`histogram`|`myers`)::
 	Choose a diff algorithm. The variants are as follows:
 +
 --
-`default`, `myers`;;
+   `default`;;
+   `myers`;;
 	The basic greedy diff algorithm. Currently, this is the default.
-`minimal`;;
+   `minimal`;;
 	Spend extra time to make sure the smallest possible diff is
 	produced.
-`patience`;;
+   `patience`;;
 	Use "patience diff" algorithm when generating patches.
-`histogram`;;
+   `histogram`;;
 	This algorithm extends the patience algorithm to "support
 	low-occurrence common elements".
---
-+
+
 For instance, if you configured the `diff.algorithm` variable to a
 non-default value and want to use the default one, then you
 have to use `--diff-algorithm=default` option.
+--
 
---stat[=<width>[,<name-width>[,<count>]]]::
+`--stat`[++=++__<width>__[++,++__<name-width>__[++,++__<count>__]]]::
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
 	part. Maximum width defaults to terminal width, or 80 columns
 	if not connected to a terminal, and can be overridden by
-	`<width>`. The width of the filename part can be limited by
-	giving another width `<name-width>` after a comma or by setting
-	`diff.statNameWidth=<width>`. The width of the graph part can be
-	limited by using `--stat-graph-width=<width>` or by setting
-	`diff.statGraphWidth=<width>`. Using `--stat` or
+	_<width>_. The width of the filename part can be limited by
+	giving another width _<name-width>_ after a comma or by setting
+	++diff.statNameWidth=++__<name-width>__. The width of the graph part can be
+	limited by using ++--stat-graph-width=++__<graph-width>__ or by setting
+	++diff.statGraphWidth=++__<graph-width>__. Using `--stat` or
 	`--stat-graph-width` affects all commands generating a stat graph,
 	while setting `diff.statNameWidth` or `diff.statGraphWidth`
 	does not affect `git format-patch`.
-	By giving a third parameter `<count>`, you can limit the output to
-	the first `<count>` lines, followed by `...` if there are more.
+	By giving a third parameter _<count>_, you can limit the output to
+	the first _<count>_ lines, followed by `...` if there are more.
 +
-These parameters can also be set individually with `--stat-width=<width>`,
-`--stat-name-width=<name-width>` and `--stat-count=<count>`.
+These parameters can also be set individually with ++--stat-width=++__<width>__,
+++--stat-name-width=++__<name-width>__ and ++--stat-count=++__<count>__.
 
---compact-summary::
+`--compact-summary`::
 	Output a condensed summary of extended header information such
-	as file creations or deletions ("new" or "gone", optionally "+l"
-	if it's a symlink) and mode changes ("+x" or "-x" for adding
+	as file creations or deletions ("new" or "gone", optionally `+l`
+	if it's a symlink) and mode changes (`+x` or `-x` for adding
 	or removing executable bit respectively) in diffstat. The
 	information is put between the filename part and the graph
 	part. Implies `--stat`.
 
---numstat::
+`--numstat`::
 	Similar to `--stat`, but shows number of added and
 	deleted lines in decimal notation and pathname without
 	abbreviation, to make it more machine friendly.  For
 	binary files, outputs two `-` instead of saying
 	`0 0`.
 
---shortstat::
+`--shortstat`::
 	Output only the last line of the `--stat` format containing total
 	number of modified files, as well as number of added and deleted
 	lines.
 
--X[<param1,param2,...>]::
---dirstat[=<param1,param2,...>]::
+`-X`[__<param>__++,++...]::
+`--dirstat`[++=++__<param>__++,++...]::
 	Output the distribution of relative amount of changes for each
 	sub-directory. The behavior of `--dirstat` can be customized by
 	passing it a comma separated list of parameters.
@@ -284,7 +291,7 @@ These parameters can also be set individually with `--stat-width=<width>`,
 	Note that when using `cumulative`, the sum of the percentages
 	reported may exceed 100%. The default (non-cumulative) behavior can
 	be specified with the `noncumulative` parameter.
-<limit>;;
+_<limit>_;;
 	An integer parameter specifies a cut-off percent (3% by default).
 	Directories contributing less than this percentage of the changes
 	are not shown in the output.
@@ -295,29 +302,29 @@ directories with less than 10% of the total amount of changed files,
 and accumulating child directory counts in the parent directories:
 `--dirstat=files,10,cumulative`.
 
---cumulative::
-	Synonym for --dirstat=cumulative
+`--cumulative`::
+	Synonym for `--dirstat=cumulative`.
 
---dirstat-by-file[=<param1,param2>...]::
-	Synonym for --dirstat=files,<param1>,<param2>...
+`--dirstat-by-file`[++=++__<param>__++,++...]::
+	Synonym for ++--dirstat=files,++__<param>__++,++... .
 
---summary::
+`--summary`::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
 
 ifndef::git-format-patch[]
---patch-with-stat::
+`--patch-with-stat`::
 	Synonym for `-p --stat`.
 endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 
--z::
+`-z`::
 ifdef::git-log[]
-	Separate the commits with NULs instead of newlines.
+	Separate the commits with __NUL__s instead of newlines.
 +
 Also, when `--raw` or `--numstat` has been given, do not munge
-pathnames and use NULs as output field terminators.
+pathnames and use __NUL__s as output field terminators.
 endif::git-log[]
 ifndef::git-log[]
 	When `--raw`, `--numstat`, `--name-only` or `--name-status` has been
@@ -328,89 +335,89 @@ Without this option, pathnames with "unusual" characters are quoted as
 explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
---name-only::
+`--name-only`::
 	Show only the name of each changed file in the post-image tree.
 	The file names are often encoded in UTF-8.
 	For more information see the discussion about encoding in the linkgit:git-log[1]
 	manual page.
 
---name-status::
+`--name-status`::
 	Show only the name(s) and status of each changed file. See the description
 	of the `--diff-filter` option on what the status letters mean.
 	Just like `--name-only` the file names are often encoded in UTF-8.
 
---submodule[=<format>]::
+`--submodule`[++=++__<format>__]::
 	Specify how differences in submodules are shown.  When specifying
-	`--submodule=short` the 'short' format is used.  This format just
+	`--submodule=short` the `short` format is used.  This format just
 	shows the names of the commits at the beginning and end of the range.
-	When `--submodule` or `--submodule=log` is specified, the 'log'
+	When `--submodule` or `--submodule=log` is specified, the `log`
 	format is used.  This format lists the commits in the range like
 	linkgit:git-submodule[1] `summary` does.  When `--submodule=diff`
-	is specified, the 'diff' format is used.  This format shows an
+	is specified, the `diff` format is used.  This format shows an
 	inline diff of the changes in the submodule contents between the
-	commit range.  Defaults to `diff.submodule` or the 'short' format
+	commit range.  Defaults to `diff.submodule` or the `short` format
 	if the config option is unset.
 
---color[=<when>]::
+`--color`[++=++__<when>__]::
 	Show colored diff.
-	`--color` (i.e. without '=<when>') is the same as `--color=always`.
-	'<when>' can be one of `always`, `never`, or `auto`.
+	`--color` (i.e. without ++=++__<when>__) is the same as `--color=always`.
+	_<when>_ can be one of `always`, `never`, or `auto`.
 ifdef::git-diff[]
 	It can be changed by the `color.ui` and `color.diff`
 	configuration settings.
 endif::git-diff[]
 
---no-color::
+`--no-color`::
 	Turn off colored diff.
 ifdef::git-diff[]
 	This can be used to override configuration settings.
 endif::git-diff[]
 	It is the same as `--color=never`.
 
---color-moved[=<mode>]::
+`--color-moved`[++=++__<mode>__]::
 	Moved lines of code are colored differently.
 ifdef::git-diff[]
 	It can be changed by the `diff.colorMoved` configuration setting.
 endif::git-diff[]
-	The <mode> defaults to 'no' if the option is not given
-	and to 'zebra' if the option with no mode is given.
+	The _<mode>_ defaults to `no` if the option is not given
+	and to `zebra` if the option with no mode is given.
 	The mode must be one of:
 +
 --
-no::
+`no`::
 	Moved lines are not highlighted.
-default::
+`default`::
 	Is a synonym for `zebra`. This may change to a more sensible mode
 	in the future.
-plain::
+`plain`::
 	Any line that is added in one location and was removed
-	in another location will be colored with 'color.diff.newMoved'.
-	Similarly 'color.diff.oldMoved' will be used for removed lines
+	in another location will be colored with `color.diff.newMoved`.
+	Similarly `color.diff.oldMoved` will be used for removed lines
 	that are added somewhere else in the diff. This mode picks up any
 	moved line, but it is not very useful in a review to determine
 	if a block of code was moved without permutation.
-blocks::
+`blocks`::
 	Blocks of moved text of at least 20 alphanumeric characters
 	are detected greedily. The detected blocks are
-	painted using either the 'color.diff.{old,new}Moved' color.
+	painted using either the `color.diff.(old|new)Moved` color.
 	Adjacent blocks cannot be told apart.
-zebra::
-	Blocks of moved text are detected as in 'blocks' mode. The blocks
-	are painted using either the 'color.diff.{old,new}Moved' color or
-	'color.diff.{old,new}MovedAlternative'. The change between
+`zebra`::
+	Blocks of moved text are detected as in `blocks` mode. The blocks
+	are painted using either the `color.diff.(old|new)Moved` color or
+	`color.diff.(old|new)MovedAlternative`. The change between
 	the two colors indicates that a new block was detected.
-dimmed-zebra::
-	Similar to 'zebra', but additional dimming of uninteresting parts
+`dimmed-zebra`::
+	Similar to `zebra`, but additional dimming of uninteresting parts
 	of moved code is performed. The bordering lines of two adjacent
 	blocks are considered interesting, the rest is uninteresting.
 	`dimmed_zebra` is a deprecated synonym.
 --
 
---no-color-moved::
+`--no-color-moved`::
 	Turn off move detection. This can be used to override configuration
 	settings. It is the same as `--color-moved=no`.
 
---color-moved-ws=<modes>::
+++--color-moved-ws=++__<mode>__++,++...::
 	This configures how whitespace is ignored when performing the
 	move detection for `--color-moved`.
 ifdef::git-diff[]
@@ -419,63 +426,63 @@ endif::git-diff[]
 	These modes can be given as a comma separated list:
 +
 --
-no::
+`no`::
 	Do not ignore whitespace when performing move detection.
-ignore-space-at-eol::
+`ignore-space-at-eol`::
 	Ignore changes in whitespace at EOL.
-ignore-space-change::
+`ignore-space-change`::
 	Ignore changes in amount of whitespace.  This ignores whitespace
 	at line end, and considers all other sequences of one or
 	more whitespace characters to be equivalent.
-ignore-all-space::
+`ignore-all-space`::
 	Ignore whitespace when comparing lines. This ignores differences
 	even if one line has whitespace where the other line has none.
-allow-indentation-change::
+`allow-indentation-change`::
 	Initially ignore any whitespace in the move detection, then
 	group the moved code blocks only into a block if the change in
 	whitespace is the same per line. This is incompatible with the
 	other modes.
 --
 
---no-color-moved-ws::
+`--no-color-moved-ws`::
 	Do not ignore whitespace when performing move detection. This can be
 	used to override configuration settings. It is the same as
 	`--color-moved-ws=no`.
 
---word-diff[=<mode>]::
-	Show a word diff, using the <mode> to delimit changed words.
+`--word-diff`[++=++__<mode>__]::
+	Show a word diff, using the _<mode>_ to delimit changed words.
 	By default, words are delimited by whitespace; see
-	`--word-diff-regex` below.  The <mode> defaults to 'plain', and
+	`--word-diff-regex` below.  The _<mode>_ defaults to `plain`, and
 	must be one of:
 +
 --
-color::
+`color`::
 	Highlight changed words using only colors.  Implies `--color`.
-plain::
+`plain`::
 	Show words as `[-removed-]` and `{+added+}`.  Makes no
 	attempts to escape the delimiters if they appear in the input,
 	so the output may be ambiguous.
-porcelain::
+`porcelain`::
 	Use a special line-based format intended for script
 	consumption.  Added/removed/unchanged runs are printed in the
 	usual unified diff format, starting with a `+`/`-`/` `
 	character at the beginning of the line and extending to the
 	end of the line.  Newlines in the input are represented by a
 	tilde `~` on a line of its own.
-none::
+`none`::
 	Disable word diff again.
 --
 +
 Note that despite the name of the first mode, color is used to
 highlight the changed parts in all modes if enabled.
 
---word-diff-regex=<regex>::
-	Use <regex> to decide what a word is, instead of considering
+++--word-diff-regex=++__<regex>__::
+	Use _<regex>_ to decide what a word is, instead of considering
 	runs of non-whitespace to be a word.  Also implies
 	`--word-diff` unless it was already enabled.
 +
 Every non-overlapping match of the
-<regex> is considered a word.  Anything between these matches is
+_<regex>_ is considered a word.  Anything between these matches is
 considered whitespace and ignored(!) for the purposes of finding
 differences.  You may want to append `|[^[:space:]]` to your regular
 expression to make sure that it matches all non-whitespace characters.
@@ -490,20 +497,20 @@ linkgit:gitattributes[5] or linkgit:git-config[1].  Giving it explicitly
 overrides any diff driver or configuration setting.  Diff drivers
 override configuration settings.
 
---color-words[=<regex>]::
+`--color-words`[++=++__<regex>__]::
 	Equivalent to `--word-diff=color` plus (if a regex was
-	specified) `--word-diff-regex=<regex>`.
+	specified) ++--word-diff-regex=++__<regex>__.
 endif::git-format-patch[]
 
---no-renames::
+`--no-renames`::
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
 
---[no-]rename-empty::
+`--`[`no-`]`rename-empty`::
 	Whether to use empty blobs as rename source.
 
 ifndef::git-format-patch[]
---check::
+`--check`::
 	Warn if changes introduce conflict markers or whitespace errors.
 	What are considered whitespace errors is controlled by `core.whitespace`
 	configuration.  By default, trailing whitespaces (including
@@ -511,9 +518,9 @@ ifndef::git-format-patch[]
 	that is immediately followed by a tab character inside the
 	initial indent of the line are considered whitespace errors.
 	Exits with non-zero status if problems are found. Not compatible
-	with --exit-code.
+	with `--exit-code`.
 
---ws-error-highlight=<kind>::
+++--ws-error-highlight=++__<kind>__::
 	Highlight whitespace errors in the `context`, `old` or `new`
 	lines of the diff.  Multiple values are separated by comma,
 	`none` resets previous values, `default` reset the list to
@@ -525,30 +532,30 @@ ifndef::git-format-patch[]
 
 endif::git-format-patch[]
 
---full-index::
+`--full-index`::
 	Instead of the first handful of characters, show the full
 	pre- and post-image blob object names on the "index"
 	line when generating patch format output.
 
---binary::
+`--binary`::
 	In addition to `--full-index`, output a binary diff that
 	can be applied with `git-apply`.
 ifndef::git-format-patch[]
 	Implies `--patch`.
 endif::git-format-patch[]
 
---abbrev[=<n>]::
+`--abbrev`[++=++__<n>__]::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
-	lines, show the shortest prefix that is at least '<n>'
+	lines, show the shortest prefix that is at least _<n>_
 	hexdigits long that uniquely refers the object.
 	In diff-patch output format, `--full-index` takes higher
 	precedence, i.e. if `--full-index` is specified, full blob
 	names will be shown regardless of `--abbrev`.
-	Non default number of digits can be specified with `--abbrev=<n>`.
+	Non default number of digits can be specified with ++--abbrev=++__<n>__.
 
--B[<n>][/<m>]::
---break-rewrites[=[<n>][/<m>]]::
+`-B`[_<n>_][++/++__<m>__]::
+`--break-rewrites`[`=`[_<n>_][++/++__<m>__]]::
 	Break complete rewrite changes into pairs of delete and
 	create. This serves two purposes:
 +
@@ -556,22 +563,22 @@ It affects the way a change that amounts to a total rewrite of a file
 not as a series of deletion and insertion mixed together with a very
 few lines that happen to match textually as the context, but as a
 single deletion of everything old followed by a single insertion of
-everything new, and the number `m` controls this aspect of the -B
+everything new, and the number _<m>_ controls this aspect of the -B
 option (defaults to 60%). `-B/70%` specifies that less than 30% of the
 original should remain in the result for Git to consider it a total
 rewrite (i.e. otherwise the resulting patch will be a series of
 deletion and insertion mixed together with context lines).
 +
-When used with -M, a totally-rewritten file is also considered as the
-source of a rename (usually -M only considers a file that disappeared
-as the source of a rename), and the number `n` controls this aspect of
-the -B option (defaults to 50%). `-B20%` specifies that a change with
+When used with `-M`, a totally-rewritten file is also considered as the
+source of a rename (usually `-M` only considers a file that disappeared
+as the source of a rename), and the number _<n>_ controls this aspect of
+the `-B` option (defaults to 50%). `-B20%` specifies that a change with
 addition and deletion compared to 20% or more of the file's size are
 eligible for being picked up as a possible source of a rename to
 another file.
 
--M[<n>]::
---find-renames[=<n>]::
+`-M`[_<n>_]::
+`--find-renames`[++=++__<n>__]::
 ifndef::git-log[]
 	Detect renames.
 endif::git-log[]
@@ -580,7 +587,7 @@ ifdef::git-log[]
 	For following files across renames while traversing history, see
 	`--follow`.
 endif::git-log[]
-	If `n` is specified, it is a threshold on the similarity
+	If _<n>_ is specified, it is a threshold on the similarity
 	index (i.e. amount of addition/deletions compared to the
 	file's size). For example, `-M90%` means Git should consider a
 	delete/add pair to be a rename if more than 90% of the file
@@ -590,12 +597,12 @@ endif::git-log[]
 	the same as `-M5%`.  To limit detection to exact renames, use
 	`-M100%`.  The default similarity index is 50%.
 
--C[<n>]::
---find-copies[=<n>]::
+`-C`[_<n>_]::
+`--find-copies`[++=++__<n>__]::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
-	If `n` is specified, it has the same meaning as for `-M<n>`.
+	If _<n>_ is specified, it has the same meaning as for ++-M++__<n>__.
 
---find-copies-harder::
+`--find-copies-harder`::
 	For performance reasons, by default, `-C` option finds copies only
 	if the original file of the copy was modified in the same
 	changeset.  This flag makes the command
@@ -604,8 +611,8 @@ endif::git-log[]
 	projects, so use it with caution.  Giving more than one
 	`-C` option has the same effect.
 
--D::
---irreversible-delete::
+`-D`::
+`--irreversible-delete`::
 	Omit the preimage for deletes, i.e. print only the header but not
 	the diff between the preimage and `/dev/null`. The resulting patch
 	is not meant to be applied with `patch` or `git apply`; this is
@@ -617,7 +624,7 @@ endif::git-log[]
 When used together with `-B`, omit also the preimage in the deletion part
 of a delete/create pair.
 
--l<num>::
+++-l++__<num>__::
 	The `-M` and `-C` options involve some preliminary steps that
 	can detect subsets of renames/copies cheaply, followed by an
 	exhaustive fallback portion that compares all remaining
@@ -627,11 +634,11 @@ of a delete/create pair.
 	destinations, this exhaustive check is O(N^2).  This option
 	prevents the exhaustive portion of rename/copy detection from
 	running if the number of source/destination files involved
-	exceeds the specified number.  Defaults to diff.renameLimit.
+	exceeds the specified number.  Defaults to `diff.renameLimit`.
 	Note that a value of 0 is treated as unlimited.
 
 ifndef::git-format-patch[]
---diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
+`--diff-filter=`[(`A`|`C`|`D`|`M`|`R`|`T`|`U`|`X`|`B`)...[_*_]]::
 	Select only files that are Added (`A`), Copied (`C`),
 	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
 	type (i.e. regular file, symlink, submodule, ...) changed (`T`),
@@ -649,9 +656,9 @@ Also, these upper-case letters can be downcased to exclude.  E.g.
 Note that not all diffs can feature all types. For instance, copied and
 renamed entries cannot appear if detection for those types is disabled.
 
--S<string>::
+++-S++__<string>__::
 	Look for differences that change the number of occurrences of
-	the specified string (i.e. addition/deletion) in a file.
+	the specified _<string>_ (i.e. addition/deletion) in a file.
 	Intended for the scripter's use.
 +
 It is useful when you're looking for an exact block of code (like a
@@ -662,12 +669,12 @@ very first version of the block.
 +
 Binary files are searched as well.
 
--G<regex>::
+++-G++__<regex>__::
 	Look for differences whose patch text contains added/removed
-	lines that match <regex>.
+	lines that match _<regex>_.
 +
-To illustrate the difference between `-S<regex> --pickaxe-regex` and
-`-G<regex>`, consider a commit with the following diff in the same
+To illustrate the difference between ++-S++__<regex>__ `--pickaxe-regex` and
+++-G++__<regex>__, consider a commit with the following diff in the same
 file:
 +
 ----
@@ -686,7 +693,7 @@ filter will be ignored.
 See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
 information.
 
---find-object=<object-id>::
+++--find-object=++__<object-id>__::
 	Look for differences that change the number of occurrences of
 	the specified object. Similar to `-S`, just the argument is different
 	in that it doesn't search for a specific string but for a specific
@@ -695,25 +702,25 @@ information.
 The object can be a blob or a submodule commit. It implies the `-t` option in
 `git-log` to also find trees.
 
---pickaxe-all::
+`--pickaxe-all`::
 	When `-S` or `-G` finds a change, show all the changes in that
 	changeset, not just the files that contain the change
-	in <string>.
+	in _<string>_.
 
---pickaxe-regex::
-	Treat the <string> given to `-S` as an extended POSIX regular
+`--pickaxe-regex`::
+	Treat the _<string>_ given to `-S` as an extended POSIX regular
 	expression to match.
 
 endif::git-format-patch[]
 
--O<orderfile>::
+++-O++__<orderfile>__::
 	Control the order in which files appear in the output.
 	This overrides the `diff.orderFile` configuration variable
 	(see linkgit:git-config[1]).  To cancel `diff.orderFile`,
 	use `-O/dev/null`.
 +
 The output order is determined by the order of glob patterns in
-<orderfile>.
+_<orderfile>_.
 All files with pathnames that match the first pattern are output
 first, all files with pathnames that match the second pattern (but not
 the first) are output next, and so on.
@@ -724,7 +731,7 @@ If multiple pathnames have the same rank (they match the same pattern
 but no earlier patterns), their output order relative to each other is
 the normal order.
 +
-<orderfile> is parsed as follows:
+_<orderfile>_ is parsed as follows:
 +
 --
  - Blank lines are ignored, so they can be used as separators for
@@ -738,106 +745,106 @@ the normal order.
 --
 +
 Patterns have the same syntax and semantics as patterns used for
-fnmatch(3) without the FNM_PATHNAME flag, except a pathname also
+`fnmatch`(3) without the `FNM_PATHNAME` flag, except a pathname also
 matches a pattern if removing any number of the final pathname
 components matches the pattern.  For example, the pattern "`foo*bar`"
 matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
 
---skip-to=<file>::
---rotate-to=<file>::
-	Discard the files before the named <file> from the output
+++--skip-to=++__<file>__::
+++--rotate-to=++__<file>__::
+	Discard the files before the named _<file>_ from the output
 	(i.e. 'skip to'), or move them to the end of the output
 	(i.e. 'rotate to').  These options were invented primarily for the use
 	of the `git difftool` command, and may not be very useful
 	otherwise.
 
 ifndef::git-format-patch[]
--R::
+`-R`::
 	Swap two inputs; that is, show differences from index or
 	on-disk file to tree contents.
 endif::git-format-patch[]
 
---relative[=<path>]::
---no-relative::
+`--relative`[++=++__<path>__]::
+`--no-relative`::
 	When run from a subdirectory of the project, it can be
 	told to exclude changes outside the directory and show
 	pathnames relative to it with this option.  When you are
 	not in a subdirectory (e.g. in a bare repository), you
 	can name which subdirectory to make the output relative
-	to by giving a <path> as an argument.
+	to by giving a _<path>_ as an argument.
 	`--no-relative` can be used to countermand both `diff.relative` config
 	option and previous `--relative`.
 
--a::
---text::
+`-a`::
+`--text`::
 	Treat all files as text.
 
---ignore-cr-at-eol::
+`--ignore-cr-at-eol`::
 	Ignore carriage-return at the end of line when doing a comparison.
 
---ignore-space-at-eol::
+`--ignore-space-at-eol`::
 	Ignore changes in whitespace at EOL.
 
--b::
---ignore-space-change::
+`-b`::
+`--ignore-space-change`::
 	Ignore changes in amount of whitespace.  This ignores whitespace
 	at line end, and considers all other sequences of one or
 	more whitespace characters to be equivalent.
 
--w::
---ignore-all-space::
+`-w`::
+`--ignore-all-space`::
 	Ignore whitespace when comparing lines.  This ignores
 	differences even if one line has whitespace where the other
 	line has none.
 
---ignore-blank-lines::
+`--ignore-blank-lines`::
 	Ignore changes whose lines are all blank.
 
--I<regex>::
---ignore-matching-lines=<regex>::
-	Ignore changes whose all lines match <regex>.  This option may
+++-I++__<regex>__::
+++--ignore-matching-lines=++__<regex>__::
+	Ignore changes whose all lines match _<regex>_.  This option may
 	be specified more than once.
 
---inter-hunk-context=<lines>::
-	Show the context between diff hunks, up to the specified number
+++--inter-hunk-context=++__<number>__::
+	Show the context between diff hunks, up to the specified _<number>_
 	of lines, thereby fusing hunks that are close to each other.
 	Defaults to `diff.interHunkContext` or 0 if the config option
 	is unset.
 
--W::
---function-context::
+`-W`::
+`--function-context`::
 	Show whole function as context lines for each change.
 	The function names are determined in the same way as
-	`git diff` works out patch hunk headers (see 'Defining a
-	custom hunk-header' in linkgit:gitattributes[5]).
+	`git diff` works out patch hunk headers (see "Defining a
+	custom hunk-header" in linkgit:gitattributes[5]).
 
 ifndef::git-format-patch[]
 ifndef::git-log[]
---exit-code::
-	Make the program exit with codes similar to diff(1).
+`--exit-code`::
+	Make the program exit with codes similar to `diff`(1).
 	That is, it exits with 1 if there were differences and
 	0 means no differences.
 
---quiet::
+`--quiet`::
 	Disable all output of the program. Implies `--exit-code`.
 	Disables execution of external diff helpers whose exit code
 	is not trusted, i.e. their respective configuration option
-	`diff.trustExitCode` or `diff.<driver>.trustExitCode` or
+	`diff.trustExitCode` or ++diff.++__<driver>__++.trustExitCode++ or
 	environment variable `GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE` is
 	false.
 endif::git-log[]
 endif::git-format-patch[]
 
---ext-diff::
+`--ext-diff`::
 	Allow an external diff helper to be executed. If you set an
 	external diff driver with linkgit:gitattributes[5], you need
 	to use this option with linkgit:git-log[1] and friends.
 
---no-ext-diff::
+`--no-ext-diff`::
 	Disallow external diff drivers.
 
---textconv::
---no-textconv::
+`--textconv`::
+`--no-textconv`::
 	Allow (or disallow) external text conversion filters to be run
 	when comparing binary files. See linkgit:gitattributes[5] for
 	details. Because textconv filters are typically a one-way
@@ -847,42 +854,42 @@ endif::git-format-patch[]
 	linkgit:git-log[1], but not for linkgit:git-format-patch[1] or
 	diff plumbing commands.
 
---ignore-submodules[=<when>]::
-	Ignore changes to submodules in the diff generation. <when> can be
-	either "none", "untracked", "dirty" or "all", which is the default.
-	Using "none" will consider the submodule modified when it either contains
+`--ignore-submodules`[++=++__<when>__]::
+	Ignore changes to submodules in the diff generation. _<when>_ can be
+	either `none`, `untracked`, `dirty` or `all`, which is the default.
+	Using `none` will consider the submodule modified when it either contains
 	untracked or modified files or its HEAD differs from the commit recorded
 	in the superproject and can be used to override any settings of the
-	'ignore' option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
-	"untracked" is used submodules are not considered dirty when they only
+	`ignore` option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
+	`untracked` is used submodules are not considered dirty when they only
 	contain untracked content (but they are still scanned for modified
-	content). Using "dirty" ignores all changes to the work tree of submodules,
+	content). Using `dirty` ignores all changes to the work tree of submodules,
 	only changes to the commits stored in the superproject are shown (this was
-	the behavior until 1.7.0). Using "all" hides all changes to submodules.
+	the behavior until 1.7.0). Using `all` hides all changes to submodules.
 
---src-prefix=<prefix>::
-	Show the given source prefix instead of "a/".
+++--src-prefix=++__<prefix>__::
+	Show the given source _<prefix>_ instead of "a/".
 
---dst-prefix=<prefix>::
-	Show the given destination prefix instead of "b/".
+++--dst-prefix=++__<prefix>__::
+	Show the given destination _<prefix>_ instead of "b/".
 
---no-prefix::
+`--no-prefix`::
 	Do not show any source or destination prefix.
 
---default-prefix::
+`--default-prefix`::
 	Use the default source and destination prefixes ("a/" and "b/").
 	This overrides configuration variables such as `diff.noprefix`,
 	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
 	(see `git-config`(1)).
 
---line-prefix=<prefix>::
-	Prepend an additional prefix to every line of output.
+++--line-prefix=++__<prefix>__::
+	Prepend an additional _<prefix>_ to every line of output.
 
---ita-invisible-in-index::
-	By default entries added by "git add -N" appear as an existing
-	empty file in "git diff" and a new file in "git diff --cached".
-	This option makes the entry appear as a new file in "git diff"
-	and non-existent in "git diff --cached". This option could be
+`--ita-invisible-in-index`::
+	By default entries added by `git add -N` appear as an existing
+	empty file in `git diff` and a new file in `git diff --cached`.
+	This option makes the entry appear as a new file in `git diff`
+	and non-existent in `git diff --cached`. This option could be
 	reverted with `--ita-visible-in-index`. Both options are
 	experimental and could be removed in future.
 
-- 
gitgitgadget

