Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CC197A7F
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343992; cv=none; b=AeT5qBOPNcEROga+YKbVcVXhw0g0g+3whtYr22pDScCSqqkhGyTJHGylwFvuGdIcxJ4BvbeeF8TuXQrWk4TELQ75WyelNNLIdc4AL9IsYSE7F7VzZZrz/ep0Dl7fLo6MHFUI6H52d1wm/jvwJouRnOv1IsheUCQ/wmALI1lXcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343992; c=relaxed/simple;
	bh=8CZxX9A8aGD4TjCet0IjR75d6alDYO32GOZJybDnd1k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=SuavhqHSFBb3geCSg1d4jzmpzV93lDLoPvGoZrmuaGSgU/ZURQjppeKOGRcd4L7z2nVUTVydcdeOOrvpiaE6ygFLTwgomP1a5gHIZjSQ1xpe82R+MVQQRj425OZG2TpTK//8W/8jODzQky3WW3AuN1icdcXQQOryMa8+MZjsIS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsRchj5q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsRchj5q"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so38016405e9.2
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731343988; x=1731948788; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZAzUeGWVJ65lxXDJb2pkrpH2budGcXx557JYcnyIUo=;
        b=bsRchj5qGhoWKWnM9vieOoHlQrY8p3yM4rR2j1yZkdUu/AcVGqKJpFqJB5I/bDswVV
         VDjeyLh2a/aLJGr/MyGOs9s7+XVXe9delmTE7kV40aea6vWvbnVNunRxG8k90ErRGIFm
         PZV7XbymmwbfeRLTkLER3bUHUzDxkrhXw36NYke7nsQB72K6kgbWrI2nTRAbQl+OijZH
         QuY7NThvuAJ7zPPmEzEPQ6+QjDkbh8YIZoW8FVxhtR98ZeyP9Xk4Ycn8tZCap86skeSm
         PRHNrP4VN3rx1X/CqaAm5OpsyeDZP7PMBJd8/M7bB6EiUoWxwdbxfVuzmnBFHdccUEZS
         C3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343988; x=1731948788;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZAzUeGWVJ65lxXDJb2pkrpH2budGcXx557JYcnyIUo=;
        b=ATxuYpwOisxHyvtn9YxofifhDg2gYBL+8sPwUkp5gdJfdtC/CLa2aqSl3XskDSPrUs
         wjZgq5r0QO/uwJdAPFyJJcLSM+2oW9xkDjbmE9uUyNmR6OjHUv5u394ztZiiGEuT2kaF
         +q86XsKQZ5QnkRibtfWP2VdpO8GmhLwc6ce4AAFTO+LlgIu96AQZEIUlOqoEutKKxDPm
         UXSqBE2IfnwfLmtrcSOXuXBmZHUlx90Vld58uFnEYGpLfGYBT4OyyOwLYNnmfcEXu3lp
         IwmCqv2YTP6wNF5QxaXc2R4zu3gQPPfuUh2nQuHpNCgcyF7uWAfv1zph2JZ1dNrzCLYN
         S9Aw==
X-Gm-Message-State: AOJu0YxEXF0BUK9f3hSeuv6A/jq5qJcmR1/ibsYli6gVn3J4P7Kl5qBN
	fAgIdbTrm3bM6fEa/esRTh9z+NG4UV4IVg4BFd9ukBqy5zP4fxvscPZVQg==
X-Google-Smtp-Source: AGHT+IFgJEqUhSBcJVNQIlULInvNyNo8Oo6raiqWSOTOyfQcWZVbmJMdtPiabD+Bsx2sWE2W2co6Tg==
X-Received: by 2002:a05:600c:1911:b0:431:2460:5574 with SMTP id 5b1f17b1804b1-432b751c122mr108926585e9.27.1731343987124;
        Mon, 11 Nov 2024 08:53:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970fb7sm13199377f8f.21.2024.11.11.08.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:53:06 -0800 (PST)
Message-Id: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Nov 2024 16:53:00 +0000
Subject: [PATCH v2 0/5] doc: git diff reformatting
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
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This is the continuation of the editing of the manpages to reflect the new
formatting rules.

Note that this patch makes use of the synopsis paragraph styling and needs
to be applied above ja/doc-synopsis-markup. As the dots can be primarily
interpreted as a grammar sign for repetition, here the dots which are part
of the synopsis are manually forced to verbatim.

Jean-Noël Avila (5):
  doc: git-diff: apply new documentation guidelines
  doc: git-diff: apply format changes to diff-options
  doc: git-diff: apply format changes to diff-format
  doc: git-diff: apply format changes to diff-generate-patch
  doc: git-diff: apply format changes to config part

 Documentation/config/diff.txt         | 163 +++++-----
 Documentation/diff-format.txt         |  42 +--
 Documentation/diff-generate-patch.txt |  44 +--
 Documentation/diff-options.txt        | 423 +++++++++++++-------------
 Documentation/git-diff.txt            | 103 +++----
 5 files changed, 390 insertions(+), 385 deletions(-)


base-commit: facbe4f633e4ad31e641f64617bc88074c659959
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1769%2Fjnavila%2Fgit_diff_new-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1769/jnavila/git_diff_new-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1769

Range-diff vs v1:

 1:  515ddbf1dce ! 1:  c104bd50b64 doc: git-diff: apply new documentation guidelines
     @@ Documentation/git-diff.txt: git-diff - Show changes between commits, commit and
      +git diff [<options>] [<commit>] [--] [<path>...]
      +git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
      +git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
     -+git diff [<options>] <commit>`...`<commit> [--] [<path>...]
     ++git diff [<options>] <commit>...<commit> [--] [<path>...]
      +git diff [<options>] <blob> <blob>
      +git diff [<options>] --no-index [--] <path> <path>
       
     @@ Documentation/git-diff.txt: between the index and a tree, changes between two tr
       files on disk.
       
      -'git diff' [<options>] [--] [<path>...]::
     -+`git diff` [_<options>_] [`--`] [_<path>_...]::
     ++`git diff [<options>] [--] [<path>...]`::
       
       	This form is to view the changes you made relative to
       	the index (staging area for the next commit).  In other
     @@ Documentation/git-diff.txt: files on disk.
       	stage these changes by using linkgit:git-add[1].
       
      -'git diff' [<options>] --no-index [--] <path> <path>::
     -+`git diff` [_<options>_] `--no-index` [`--`] _<path>_ _<path>_::
     ++`git diff [<options>] --no-index [--] <path> <path>`::
       
       	This form is to compare the given two paths on the
       	filesystem.  You can omit the `--no-index` option when
     @@ Documentation/git-diff.txt: files on disk.
       	controlled by Git. This form implies `--exit-code`.
       
      -'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]::
     -+`git diff` [_<options>_] `--cached` [`--merge-base`] [_<commit>_] [`--`] [_<path>_...]::
     ++`git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]`::
       
       	This form is to view the changes you staged for the next
      -	commit relative to the named <commit>.  Typically you
     @@ Documentation/git-diff.txt: files on disk.
       `git diff --cached $(git merge-base A HEAD)`.
       
      -'git diff' [<options>] [--merge-base] <commit> [--] [<path>...]::
     -+`git diff` [_<options>_] [`--merge-base`] _<commit>_ [`--`] [_<path>_...]::
     ++`git diff [<options>] [--merge-base] <commit> [--] [<path>...]`::
       
       	This form is to view the changes you have in your
      -	working tree relative to the named <commit>.  You can
     @@ Documentation/git-diff.txt: files on disk.
       `git diff $(git merge-base A HEAD)`.
       
      -'git diff' [<options>] [--merge-base] <commit> <commit> [--] [<path>...]::
     -+`git diff` [_<options>_] [`--merge-base`] _<commit>_ _<commit>_ [`--`] [_<path>_...]::
     ++`git diff [<options>] [--merge-base] <commit> <commit> [--] [<path>...]`::
       
       	This is to view the changes between two arbitrary
      -	<commit>.
     @@ Documentation/git-diff.txt: files on disk.
       `git diff $(git merge-base A B) B`.
       
      -'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]::
     -+`git diff` [_<options>_] _<commit>_ __<commit>__++...++__<commit>__ [`--`] [_<path>_...]::
     ++`git diff [<options>] <commit> <commit>...<commit> [--] [<path>...]`::
       
       	This form is to view the results of a merge commit.  The first
      -	listed <commit> must be the merge itself; the remaining two or
      +	listed _<commit>_ must be the merge itself; the remaining two or
       	more commits should be its parents.  Convenient ways to produce
     - 	the desired set of revisions are to use the suffixes `^@` and
     +-	the desired set of revisions are to use the suffixes `^@` and
      -	`^!`.  If A is a merge commit, then `git diff A A^@`,
     ++	the desired set of revisions are to use the suffixes `@` and
      +	`^!`.  If `A` is a merge commit, then `git diff A A^@`,
       	`git diff A^!` and `git show A` all give the same combined diff.
       
      -'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
     -+`git diff` [_<options>_] __<commit>__++..++__<commit>__ [`--`] [_<path>_...]::
     ++`git diff [<options>] <commit>..<commit> [--] [<path>...]`::
       
       	This is synonymous to the earlier form (without the `..`) for
      -	viewing the changes between two arbitrary <commit>.  If <commit> on
     @@ Documentation/git-diff.txt: files on disk.
      +	using `HEAD` instead.
       
      -'git diff' [<options>] <commit>\...<commit> [--] [<path>...]::
     -+`git diff` [_<options>_] __<commit>__++...++__<commit>__ [`--`] [_<path>_...]::
     ++`git diff [<options>] <commit>...<commit> [--] [<path>...]`::
       
       	This form is to view the changes on the branch containing
      -	and up to the second <commit>, starting at a common ancestor
     @@ Documentation/git-diff.txt: files on disk.
      -and the range notations (`<commit>..<commit>` and
      -`<commit>...<commit>`) do not mean a range as defined in the
      +However, `diff` is about comparing two _endpoints_, not ranges,
     -+and the range notations (__<commit>__++..++__<commit>__ and
     -+__<commit>__++...++__<commit>__) do not mean a range as defined in the
     ++and the range notations (`<commit>..<commit>` and `<commit>...<commit>`)
     ++do not mean a range as defined in the
       "SPECIFYING RANGES" section in linkgit:gitrevisions[7].
       
      -'git diff' [<options>] <blob> <blob>::
     -+`git diff` [_<options>_] _<blob>_ _<blob>_::
     ++`git diff [<options>] <blob> <blob>`::
       
       	This form is to view the differences between the raw
       	contents of two blob objects.
 2:  c1e7d6afb50 ! 2:  129763c2aae doc: git-diff: apply format changes to diff-options
     @@ Documentation/diff-options.txt: endif::git-format-patch[]
       
       --diff-merges=<format>::
       	Specify diff format to be used for merge commits. Default is
     -@@ Documentation/diff-options.txt: ifdef::git-log[]
     - The following formats are supported:
     - +
     - --
     --off, none::
     -+off::
     -+none::
     +@@ Documentation/diff-options.txt: The following formats are supported:
     + off, none::
       	Disable output of diffs for merge commits. Useful to override
       	implied value.
      -+
     --on, m::
      +
     -+on::
     -+m::
     + on, m::
       	Make diff output for merge commits to be shown in the default
       	format. The default format can be changed using
       	`log.diffMerges` configuration variable, whose default value
       	is `separate`.
      -+
     --first-parent, 1::
      +
     -+first-parent::
     -+1::
     + first-parent, 1::
       	Show full diff with respect to first parent. This is the same
       	format as `--patch` produces for non-merge commits.
      -+
     @@ Documentation/diff-options.txt: ifdef::git-log[]
       	Show full diff with respect to each of parents.
       	Separate log entry and diff is generated for each parent.
      -+
     --combined, c::
      +
     -+combined::
     -+c::
     + combined, c::
       	Show differences from each of the parents to the merge
       	result simultaneously instead of showing pairwise diff between
       	a parent and the result one at a time. Furthermore, it lists
       	only files which were modified from all parents.
      -+
     --dense-combined, cc::
      +
     -+dense-combined::
     -+cc::
     + dense-combined, cc::
       	Further compress output produced by `--diff-merges=combined`
       	by omitting uninteresting hunks whose contents in the parents
       	have only two variants and the merge result picks one of them
       	without modification.
      -+
     --remerge, r::
      +
     -+remerge::
     -+r::
     + remerge, r::
       	Remerge two-parent merge commits to create a temporary tree
       	object--potentially containing files with conflict markers
     - 	and such.  A diff is then shown between that temporary tree
      @@ Documentation/diff-options.txt: documented).
       --
       
       --combined-all-paths::
      -	This flag causes combined diffs (used for merge commits) to
     -+	cause combined diffs (used for merge commits) to
     ++	Cause combined diffs (used for merge commits) to
       	list the name of the file from all parents.  It thus only has
       	effect when `--diff-merges=[dense-]combined` is in use, and
       	is likely only useful if filename changes are detected (i.e.
     @@ Documentation/diff-options.txt: documented).
      --U<n>::
      ---unified=<n>::
      -	Generate diffs with <n> lines of context instead of
     -+++-U++__<n>__::
     -+++--unified=++__<n>__::
     ++`-U<n>`::
     ++`--unified=<n>`::
      +	Generate diffs with _<n>_ lines of context instead of
       	the usual three.
       ifndef::git-format-patch[]
     @@ Documentation/diff-options.txt: documented).
       endif::git-format-patch[]
       
      ---output=<file>::
     --	Output to a specific file instead of stdout.
     -+++--output=++__<file>__::
     -+	Output to _<file>_ instead of stdout.
     ++`--output=<file>`::
     + 	Output to a specific file instead of stdout.
       
      ---output-indicator-new=<char>::
      ---output-indicator-old=<char>::
      ---output-indicator-context=<char>::
     -+++--output-indicator-new=++__<char>__::
     -+++--output-indicator-old=++__<char>__::
     -+++--output-indicator-context=++__<char>__::
     ++`--output-indicator-new=<char>`::
     ++`--output-indicator-old=<char>`::
     ++`--output-indicator-context=<char>`::
       	Specify the character used to indicate new, old or context
      -	lines in the generated patch. Normally they are '+', '-' and
      +	lines in the generated patch. Normally they are `+`, `-` and
     @@ Documentation/diff-options.txt: endif::git-log[]
       	Generate a diff using the "histogram diff" algorithm.
       
      ---anchored=<text>::
     -+++--anchored=++__<text>__::
     ++`--anchored=<text>`::
       	Generate a diff using the "anchored diff" algorithm.
       +
       This option may be specified more than once.
     @@ Documentation/diff-options.txt: endif::git-log[]
       diff" algorithm internally.
       
      ---diff-algorithm={patience|minimal|histogram|myers}::
     -+`--diff-algorithm=`(`patience`|`minimal`|`histogram`|`myers`)::
     ++`--diff-algorithm=(patience|minimal|histogram|myers)`::
       	Choose a diff algorithm. The variants are as follows:
       +
       --
     @@ Documentation/diff-options.txt: endif::git-log[]
      +   `histogram`;;
       	This algorithm extends the patience algorithm to "support
       	low-occurrence common elements".
     ----
     --+
     -+
     - For instance, if you configured the `diff.algorithm` variable to a
     + --
     +@@ Documentation/diff-options.txt: For instance, if you configured the `diff.algorithm` variable to a
       non-default value and want to use the default one, then you
       have to use `--diff-algorithm=default` option.
     -+--
       
      ---stat[=<width>[,<name-width>[,<count>]]]::
     -+`--stat`[++=++__<width>__[++,++__<name-width>__[++,++__<count>__]]]::
     ++`--stat[=<width>[,<name-width>[,<count>]]]`::
       	Generate a diffstat. By default, as much space as necessary
       	will be used for the filename part, and the rest for the graph
       	part. Maximum width defaults to terminal width, or 80 columns
     @@ Documentation/diff-options.txt: endif::git-log[]
      -	`diff.statGraphWidth=<width>`. Using `--stat` or
      +	_<width>_. The width of the filename part can be limited by
      +	giving another width _<name-width>_ after a comma or by setting
     -+	++diff.statNameWidth=++__<name-width>__. The width of the graph part can be
     -+	limited by using ++--stat-graph-width=++__<graph-width>__ or by setting
     -+	++diff.statGraphWidth=++__<graph-width>__. Using `--stat` or
     ++	`diff.statNameWidth=<name-width>`. The width of the graph part can be
     ++	limited by using `--stat-graph-width=<graph-width>` or by setting
     ++	`diff.statGraphWidth=<graph-width>`. Using `--stat` or
       	`--stat-graph-width` affects all commands generating a stat graph,
       	while setting `diff.statNameWidth` or `diff.statGraphWidth`
       	does not affect `git format-patch`.
     @@ Documentation/diff-options.txt: endif::git-log[]
      +	By giving a third parameter _<count>_, you can limit the output to
      +	the first _<count>_ lines, followed by `...` if there are more.
       +
     --These parameters can also be set individually with `--stat-width=<width>`,
     --`--stat-name-width=<name-width>` and `--stat-count=<count>`.
     -+These parameters can also be set individually with ++--stat-width=++__<width>__,
     -+++--stat-name-width=++__<name-width>__ and ++--stat-count=++__<count>__.
     + These parameters can also be set individually with `--stat-width=<width>`,
     + `--stat-name-width=<name-width>` and `--stat-count=<count>`.
       
      ---compact-summary::
      +`--compact-summary`::
     @@ Documentation/diff-options.txt: endif::git-log[]
       
      --X[<param1,param2,...>]::
      ---dirstat[=<param1,param2,...>]::
     -+`-X`[__<param>__++,++...]::
     -+`--dirstat`[++=++__<param>__++,++...]::
     ++`-X [<param>,...]`::
     ++`--dirstat[=<param>,...]`::
       	Output the distribution of relative amount of changes for each
       	sub-directory. The behavior of `--dirstat` can be customized by
       	passing it a comma separated list of parameters.
     @@ Documentation/diff-options.txt: directories with less than 10% of the total amou
       
      ---dirstat-by-file[=<param1,param2>...]::
      -	Synonym for --dirstat=files,<param1>,<param2>...
     -+`--dirstat-by-file`[++=++__<param>__++,++...]::
     -+	Synonym for ++--dirstat=files,++__<param>__++,++... .
     ++`--dirstat-by-file[=<param>,...]`::
     ++	Synonym for `--dirstat=files,<param>,...`.
       
      ---summary::
      +`--summary`::
     @@ Documentation/diff-options.txt: Without this option, pathnames with "unusual" ch
       	Just like `--name-only` the file names are often encoded in UTF-8.
       
      ---submodule[=<format>]::
     -+`--submodule`[++=++__<format>__]::
     ++`--submodule[=<format>]`::
       	Specify how differences in submodules are shown.  When specifying
      -	`--submodule=short` the 'short' format is used.  This format just
      +	`--submodule=short` the `short` format is used.  This format just
     @@ Documentation/diff-options.txt: Without this option, pathnames with "unusual" ch
       	if the config option is unset.
       
      ---color[=<when>]::
     -+`--color`[++=++__<when>__]::
     ++`--color[=<when>]`::
       	Show colored diff.
      -	`--color` (i.e. without '=<when>') is the same as `--color=always`.
      -	'<when>' can be one of `always`, `never`, or `auto`.
     -+	`--color` (i.e. without ++=++__<when>__) is the same as `--color=always`.
     ++	`--color` (i.e. without `=<when>`) is the same as `--color=always`.
      +	_<when>_ can be one of `always`, `never`, or `auto`.
       ifdef::git-diff[]
       	It can be changed by the `color.ui` and `color.diff`
     @@ Documentation/diff-options.txt: Without this option, pathnames with "unusual" ch
       	It is the same as `--color=never`.
       
      ---color-moved[=<mode>]::
     -+`--color-moved`[++=++__<mode>__]::
     ++`--color-moved[=<mode>]`::
       	Moved lines of code are colored differently.
       ifdef::git-diff[]
       	It can be changed by the `diff.colorMoved` configuration setting.
     @@ Documentation/diff-options.txt: Without this option, pathnames with "unusual" ch
       	settings. It is the same as `--color-moved=no`.
       
      ---color-moved-ws=<modes>::
     -+++--color-moved-ws=++__<mode>__++,++...::
     ++`--color-moved-ws=<mode>,...`::
       	This configures how whitespace is ignored when performing the
       	move detection for `--color-moved`.
       ifdef::git-diff[]
     @@ Documentation/diff-options.txt: endif::git-diff[]
       
      ---word-diff[=<mode>]::
      -	Show a word diff, using the <mode> to delimit changed words.
     -+`--word-diff`[++=++__<mode>__]::
     -+	Show a word diff, using the _<mode>_ to delimit changed words.
     ++`--word-diff[=<mode>]`::
       	By default, words are delimited by whitespace; see
      -	`--word-diff-regex` below.  The <mode> defaults to 'plain', and
      +	`--word-diff-regex` below.  The _<mode>_ defaults to `plain`, and
     @@ Documentation/diff-options.txt: endif::git-diff[]
      +`color`::
       	Highlight changed words using only colors.  Implies `--color`.
      -plain::
     +-	Show words as `[-removed-]` and `{+added+}`.  Makes no
      +`plain`::
     - 	Show words as `[-removed-]` and `{+added+}`.  Makes no
     ++	Show words as ++[-removed-]++ and ++{+added+}++.  Makes no
       	attempts to escape the delimiters if they appear in the input,
       	so the output may be ambiguous.
      -porcelain::
     @@ Documentation/diff-options.txt: endif::git-diff[]
       
      ---word-diff-regex=<regex>::
      -	Use <regex> to decide what a word is, instead of considering
     -+++--word-diff-regex=++__<regex>__::
     ++`--word-diff-regex=<regex>`::
      +	Use _<regex>_ to decide what a word is, instead of considering
       	runs of non-whitespace to be a word.  Also implies
       	`--word-diff` unless it was already enabled.
     @@ Documentation/diff-options.txt: linkgit:gitattributes[5] or linkgit:git-config[1
       override configuration settings.
       
      ---color-words[=<regex>]::
     -+`--color-words`[++=++__<regex>__]::
     ++`--color-words[=<regex>]`::
       	Equivalent to `--word-diff=color` plus (if a regex was
     --	specified) `--word-diff-regex=<regex>`.
     -+	specified) ++--word-diff-regex=++__<regex>__.
     + 	specified) `--word-diff-regex=<regex>`.
       endif::git-format-patch[]
       
      ---no-renames::
     @@ Documentation/diff-options.txt: linkgit:gitattributes[5] or linkgit:git-config[1
       	file gives the default to do so.
       
      ---[no-]rename-empty::
     -+`--`[`no-`]`rename-empty`::
     ++`--[no-]rename-empty`::
       	Whether to use empty blobs as rename source.
       
       ifndef::git-format-patch[]
     @@ Documentation/diff-options.txt: ifndef::git-format-patch[]
      +	with `--exit-code`.
       
      ---ws-error-highlight=<kind>::
     -+++--ws-error-highlight=++__<kind>__::
     ++`--ws-error-highlight=<kind>`::
       	Highlight whitespace errors in the `context`, `old` or `new`
       	lines of the diff.  Multiple values are separated by comma,
       	`none` resets previous values, `default` reset the list to
     @@ Documentation/diff-options.txt: ifndef::git-format-patch[]
       endif::git-format-patch[]
       
      ---abbrev[=<n>]::
     -+`--abbrev`[++=++__<n>__]::
     ++`--abbrev[=<n>]`::
       	Instead of showing the full 40-byte hexadecimal object
       	name in diff-raw format output and diff-tree header
      -	lines, show the shortest prefix that is at least '<n>'
     @@ Documentation/diff-options.txt: ifndef::git-format-patch[]
       	In diff-patch output format, `--full-index` takes higher
       	precedence, i.e. if `--full-index` is specified, full blob
       	names will be shown regardless of `--abbrev`.
     --	Non default number of digits can be specified with `--abbrev=<n>`.
     -+	Non default number of digits can be specified with ++--abbrev=++__<n>__.
     + 	Non default number of digits can be specified with `--abbrev=<n>`.
       
      --B[<n>][/<m>]::
      ---break-rewrites[=[<n>][/<m>]]::
     -+`-B`[_<n>_][++/++__<m>__]::
     -+`--break-rewrites`[`=`[_<n>_][++/++__<m>__]]::
     ++`-B[<n>][/<m>]`::
     ++`--break-rewrites[=[<n>][/<m>]]`::
       	Break complete rewrite changes into pairs of delete and
       	create. This serves two purposes:
       +
     @@ Documentation/diff-options.txt: It affects the way a change that amounts to a to
       few lines that happen to match textually as the context, but as a
       single deletion of everything old followed by a single insertion of
      -everything new, and the number `m` controls this aspect of the -B
     -+everything new, and the number _<m>_ controls this aspect of the -B
     ++everything new, and the number _<m>_ controls this aspect of the `-B`
       option (defaults to 60%). `-B/70%` specifies that less than 30% of the
       original should remain in the result for Git to consider it a total
       rewrite (i.e. otherwise the resulting patch will be a series of
     @@ Documentation/diff-options.txt: It affects the way a change that amounts to a to
       
      --M[<n>]::
      ---find-renames[=<n>]::
     -+`-M`[_<n>_]::
     -+`--find-renames`[++=++__<n>__]::
     ++`-M[<n>]`::
     ++`--find-renames[=<n>]`::
       ifndef::git-log[]
       	Detect renames.
       endif::git-log[]
     @@ Documentation/diff-options.txt: endif::git-log[]
       
      --C[<n>]::
      ---find-copies[=<n>]::
     -+`-C`[_<n>_]::
     -+`--find-copies`[++=++__<n>__]::
     ++`-C[<n>]`::
     ++`--find-copies[=<n>]`::
       	Detect copies as well as renames.  See also `--find-copies-harder`.
      -	If `n` is specified, it has the same meaning as for `-M<n>`.
     -+	If _<n>_ is specified, it has the same meaning as for ++-M++__<n>__.
     ++	If _<n>_ is specified, it has the same meaning as for `-M<n>`.
       
      ---find-copies-harder::
      +`--find-copies-harder`::
     @@ Documentation/diff-options.txt: endif::git-log[]
       of a delete/create pair.
       
      --l<num>::
     -+++-l++__<num>__::
     ++`-l<num>`::
       	The `-M` and `-C` options involve some preliminary steps that
       	can detect subsets of renames/copies cheaply, followed by an
       	exhaustive fallback portion that compares all remaining
     @@ Documentation/diff-options.txt: of a delete/create pair.
       
       ifndef::git-format-patch[]
      ---diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
     -+`--diff-filter=`[(`A`|`C`|`D`|`M`|`R`|`T`|`U`|`X`|`B`)...[_*_]]::
     ++`--diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]`::
       	Select only files that are Added (`A`), Copied (`C`),
       	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
       	type (i.e. regular file, symlink, submodule, ...) changed (`T`),
     @@ Documentation/diff-options.txt: Also, these upper-case letters can be downcased
       renamed entries cannot appear if detection for those types is disabled.
       
      --S<string>::
     -+++-S++__<string>__::
     ++`-S<string>`::
       	Look for differences that change the number of occurrences of
      -	the specified string (i.e. addition/deletion) in a file.
      +	the specified _<string>_ (i.e. addition/deletion) in a file.
     @@ Documentation/diff-options.txt: very first version of the block.
       Binary files are searched as well.
       
      --G<regex>::
     -+++-G++__<regex>__::
     ++`-G<regex>`::
       	Look for differences whose patch text contains added/removed
      -	lines that match <regex>.
      +	lines that match _<regex>_.
       +
      -To illustrate the difference between `-S<regex> --pickaxe-regex` and
     --`-G<regex>`, consider a commit with the following diff in the same
     -+To illustrate the difference between ++-S++__<regex>__ `--pickaxe-regex` and
     -+++-G++__<regex>__, consider a commit with the following diff in the same
     ++To illustrate the difference between `-S<regex>` `--pickaxe-regex` and
     + `-G<regex>`, consider a commit with the following diff in the same
       file:
       +
     - ----
      @@ Documentation/diff-options.txt: filter will be ignored.
       See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
       information.
       
      ---find-object=<object-id>::
     -+++--find-object=++__<object-id>__::
     ++`--find-object=<object-id>`::
       	Look for differences that change the number of occurrences of
       	the specified object. Similar to `-S`, just the argument is different
       	in that it doesn't search for a specific string but for a specific
     @@ Documentation/diff-options.txt: information.
       endif::git-format-patch[]
       
      --O<orderfile>::
     -+++-O++__<orderfile>__::
     ++`-O<orderfile>`::
       	Control the order in which files appear in the output.
       	This overrides the `diff.orderFile` configuration variable
       	(see linkgit:git-config[1]).  To cancel `diff.orderFile`,
     @@ Documentation/diff-options.txt: the normal order.
      ---skip-to=<file>::
      ---rotate-to=<file>::
      -	Discard the files before the named <file> from the output
     -+++--skip-to=++__<file>__::
     -+++--rotate-to=++__<file>__::
     ++`--skip-to=<file>`::
     ++`--rotate-to=<file>`::
      +	Discard the files before the named _<file>_ from the output
       	(i.e. 'skip to'), or move them to the end of the output
       	(i.e. 'rotate to').  These options were invented primarily for the use
     @@ Documentation/diff-options.txt: the normal order.
       
      ---relative[=<path>]::
      ---no-relative::
     -+`--relative`[++=++__<path>__]::
     ++`--relative[=<path>]`::
      +`--no-relative`::
       	When run from a subdirectory of the project, it can be
       	told to exclude changes outside the directory and show
     @@ Documentation/diff-options.txt: the normal order.
      --I<regex>::
      ---ignore-matching-lines=<regex>::
      -	Ignore changes whose all lines match <regex>.  This option may
     -+++-I++__<regex>__::
     -+++--ignore-matching-lines=++__<regex>__::
     ++
     ++`-I<regex>`::
     ++`--ignore-matching-lines=<regex>`::
      +	Ignore changes whose all lines match _<regex>_.  This option may
       	be specified more than once.
       
      ---inter-hunk-context=<lines>::
      -	Show the context between diff hunks, up to the specified number
     -+++--inter-hunk-context=++__<number>__::
     ++`--inter-hunk-context=<number>`::
      +	Show the context between diff hunks, up to the specified _<number>_
       	of lines, thereby fusing hunks that are close to each other.
       	Defaults to `diff.interHunkContext` or 0 if the config option
     @@ Documentation/diff-options.txt: endif::git-format-patch[]
      -	Ignore changes to submodules in the diff generation. <when> can be
      -	either "none", "untracked", "dirty" or "all", which is the default.
      -	Using "none" will consider the submodule modified when it either contains
     -+`--ignore-submodules`[++=++__<when>__]::
     -+	Ignore changes to submodules in the diff generation. _<when>_ can be
     -+	either `none`, `untracked`, `dirty` or `all`, which is the default.
     +-	untracked or modified files or its HEAD differs from the commit recorded
     ++
     ++`--ignore-submodules[=(none|untracked|dirty|all)]`::
     ++	Ignore changes to submodules in the diff generation. `all` is the default.
      +	Using `none` will consider the submodule modified when it either contains
     - 	untracked or modified files or its HEAD differs from the commit recorded
     ++	untracked or modified files or its `HEAD` differs from the commit recorded
       	in the superproject and can be used to override any settings of the
      -	'ignore' option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
      -	"untracked" is used submodules are not considered dirty when they only
     @@ Documentation/diff-options.txt: endif::git-format-patch[]
       
      ---src-prefix=<prefix>::
      -	Show the given source prefix instead of "a/".
     -+++--src-prefix=++__<prefix>__::
     ++`--src-prefix=<prefix>`::
      +	Show the given source _<prefix>_ instead of "a/".
       
      ---dst-prefix=<prefix>::
      -	Show the given destination prefix instead of "b/".
     -+++--dst-prefix=++__<prefix>__::
     ++`--dst-prefix=<prefix>`::
      +	Show the given destination _<prefix>_ instead of "b/".
       
      ---no-prefix::
     @@ Documentation/diff-options.txt: endif::git-format-patch[]
       	Use the default source and destination prefixes ("a/" and "b/").
       	This overrides configuration variables such as `diff.noprefix`,
       	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
     - 	(see `git-config`(1)).
     +-	(see `git-config`(1)).
     ++	(see linkgit:git-config[1]).
       
      ---line-prefix=<prefix>::
      -	Prepend an additional prefix to every line of output.
     -+++--line-prefix=++__<prefix>__::
     ++`--line-prefix=<prefix>`::
      +	Prepend an additional _<prefix>_ to every line of output.
       
      ---ita-invisible-in-index::
 3:  81b5782d152 ! 3:  8fec37ee174  doc: git-diff: apply format changes to diff-format
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -     doc: git-diff: apply format changes to diff-format
     +    doc: git-diff: apply format changes to diff-format
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     @@ Documentation/diff-format.txt
       compared differs:
       
      -git-diff-index <tree-ish>::
     -+`git-diff-index` _<tree-ish>_::
     -         compares the <tree-ish> and the files on the filesystem.
     +-        compares the <tree-ish> and the files on the filesystem.
     ++`git-diff-index <tree-ish>`::
     ++	compares the _<tree-ish>_ and the files on the filesystem.
       
      -git-diff-index --cached <tree-ish>::
     -+`git-diff-index --cached` _<tree-ish>_::
     -         compares the <tree-ish> and the index.
     +-        compares the <tree-ish> and the index.
     ++`git-diff-index --cached <tree-ish>`::
     ++	compares the _<tree-ish>_ and the index.
       
      -git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
     -+`git-diff-tree` [`-r`] _<tree-ish-1>_ _<tree-ish-2>_ [_<pattern>_...]::
     ++`git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]`::
               compares the trees named by the two arguments.
       
      -git-diff-files [<pattern>...]::
     -+`git-diff-files` [_<pattern>_...]::
     ++`git-diff-files [<pattern>...]`::
               compares the index and the files on the filesystem.
       
      -The "git-diff-tree" command begins its output by printing the hash of
 4:  3c475a2ee4e ! 4:  daed146639d  doc: git-diff: apply format changes to diff-generate-patch
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -     doc: git-diff: apply format changes to diff-generate-patch
     +    doc: git-diff: apply format changes to diff-generate-patch
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     @@ Documentation/diff-generate-patch.txt: or like this (when the `--cc` option is u
      -       mode <mode>,<mode>..<mode>
      -       new file mode <mode>
      -       deleted file mode <mode>,<mode>
     - +
     --The `mode <mode>,<mode>..<mode>` line appears only if at least one of
     --the <mode> is different from the rest. Extended headers with
     +++
      +[synopsis]
     -+index <hash>,<hash>`..`<hash>
     ++index <hash>,<hash>..<hash>
      +mode <mode>,<mode>`..`<mode>
      +new file mode <mode>
      +deleted file mode <mode>,<mode>
     -++
     -+The `mode` __<mode>__++,++__<mode>__++..++__<mode>__ line appears only if at least one of
     -+the _<mode>_ is different from the rest. Extended headers with
     + +
     + The `mode <mode>,<mode>..<mode>` line appears only if at least one of
     + the <mode> is different from the rest. Extended headers with
       information about detected content movement (renames and
       copying detection) are designed to work with the diff of two
      -<tree-ish> and are not used by combined diff format.
 5:  acb5bdda904 ! 5:  17a2f028d59  doc: git-diff: apply format changes to config part
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -     doc: git-diff: apply format changes to config part
     +    doc: git-diff: apply format changes to config part
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     @@ Documentation/config/diff.txt
       	default behavior of the `--dirstat` option to linkgit:git-diff[1]
       	and friends. The defaults can be overridden on the command line
      -	(using `--dirstat=<param1,param2,...>`). The fallback defaults
     -+	(using ++--dirstat=++__<param1>__++,++__<param2>__...). The fallback defaults
     ++	(using `--dirstat=<param>,...`). The fallback defaults
       	(when not changed by `diff.dirstat`) are `changes,noncumulative,3`.
       	The following parameters are available:
       +
     @@ Documentation/config/diff.txt: directories with less than 10% of the total amoun
       	your files, you might want to use linkgit:gitattributes[5] instead.
       
      -diff.trustExitCode::
     +-	If this boolean value is set to true then the
      +`diff.trustExitCode`::
     - 	If this boolean value is set to true then the
     ++	If this boolean value is set to `true` then the
       	`diff.external` command is expected to return exit code
       	0 if it considers the input files to be equal or 1 if it
      -	considers them to be different, like `diff(1)`.
     @@ Documentation/config/diff.txt: directories with less than 10% of the total amoun
       	this configuration is in effect, reverse diff output also swaps
       	the order of the prefixes:
      @@ Documentation/config/diff.txt: diff.mnemonicPrefix::
     + 	 compares a (c)ommit and the (w)ork tree;
     + `git diff --cached`;;
     + 	compares a (c)ommit and the (i)ndex;
     +-`git diff HEAD:file1 file2`;;
     ++`git diff HEAD:<file1> <file2>`;;
     + 	compares an (o)bject and a (w)ork tree entity;
       `git diff --no-index a b`;;
       	compares two non-git things (1) and (2).
       
     @@ Documentation/config/diff.txt: diff.mnemonicPrefix::
       	characters are *ignorable* whitespace.
       
      -diff.<driver>.command::
     -+++diff.++__<driver>__++.command++::
     ++`diff.<driver>.command`::
       	The custom diff driver command.  See linkgit:gitattributes[5]
       	for details.
       
      -diff.<driver>.trustExitCode::
     -+++diff.++__<driver>__++.trustExitCode++::
     ++`diff.<driver>.trustExitCode`::
       	If this boolean value is set to true then the
     --	`diff.<driver>.command` command is expected to return exit code
     -+	++diff.++__<driver>__++.command++ command is expected to return exit code
     + 	`diff.<driver>.command` command is expected to return exit code
       	0 if it considers the input files to be equal or 1 if it
      -	considers them to be different, like `diff(1)`.
      +	considers them to be different, like `diff`(1).
     @@ Documentation/config/diff.txt: diff.mnemonicPrefix::
       	Any other exit code causes Git to report a fatal error.
       
      -diff.<driver>.xfuncname::
     -+++diff.++__<driver>__++.xfuncname++::
     ++`diff.<driver>.xfuncname`::
       	The regular expression that the diff driver should use to
       	recognize the hunk header.  A built-in pattern may also be used.
       	See linkgit:gitattributes[5] for details.
       
      -diff.<driver>.binary::
      -	Set this option to true to make the diff driver treat files as
     -+++diff.++__<driver>__++.binary++::
     ++`diff.<driver>.binary`::
      +	Set this option to `true` to make the diff driver treat files as
       	binary.  See linkgit:gitattributes[5] for details.
       
      -diff.<driver>.textconv::
     -+++diff.++__<driver>__++.textconv++::
     ++`diff.<driver>.textconv`::
       	The command that the diff driver should call to generate the
       	text-converted version of a file.  The result of the
       	conversion is used to generate a human-readable diff.  See
       	linkgit:gitattributes[5] for details.
       
      -diff.<driver>.wordRegex::
     -+++diff.++__<driver>__++.wordRegex++::
     ++`diff.<driver>.wordRegex`::
       	The regular expression that the diff driver should use to
       	split words in a line.  See linkgit:gitattributes[5] for
       	details.
       
      -diff.<driver>.cachetextconv::
     -+++diff.++__<driver>__++.cachetextconv++::
     ++`diff.<driver>.cachetextconv`::
       	Set this option to true to make the diff driver cache the text
       	conversion outputs.  See linkgit:gitattributes[5] for details.
       
     @@ Documentation/config/diff.txt: diff.mnemonicPrefix::
       	Choose a diff algorithm.  The variants are as follows:
       +
       --
     +-`default`, `myers`;;
     ++`default`;;
     ++`myers`;;
     + 	The basic greedy diff algorithm. Currently, this is the default.
     + `minimal`;;
     + 	Spend extra time to make sure the smallest possible diff is
      @@ Documentation/config/diff.txt: diff.algorithm::
       --
       +
     @@ Documentation/config/diff.txt: diff.algorithm::
       	Highlight whitespace errors in the `context`, `old` or `new`
       	lines of the diff.  Multiple values are separated by comma,
       	`none` resets previous values, `default` reset the list to
     - 	`new` and `all` is a shorthand for `old,new,context`.  The
     - 	whitespace errors are colored with `color.diff.whitespace`.
     --	The command line option `--ws-error-highlight=<kind>`
     -+	The command line option ++--ws-error-highlight=++__<kind>__
     +@@ Documentation/config/diff.txt: diff.wsErrorHighlight::
     + 	The command line option `--ws-error-highlight=<kind>`
       	overrides this setting.
       
      -diff.colorMoved::
     @@ Documentation/config/diff.txt: diff.algorithm::
       	When moved lines are colored using e.g. the `diff.colorMoved` setting,
      -	this option controls the `<mode>` how spaces are treated.
      -	For details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
     -+	this option controls the _<mode>_ how spaces are treated.
     ++	this option controls the mode how spaces are treated.
      +	For details of valid modes see `--color-moved-ws` in linkgit:git-diff[1].

-- 
gitgitgadget
