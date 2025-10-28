Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B732B994
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658648; cv=none; b=NJVMaW0GLB/Vdty2D1GaRdnzbTd/DWuJAil026ZlluJKwpgL+nu6h6P3uzsmRf/7tHKHW/G2WM57O0g4k0tLYFRRMw9ZPUECp4XtuxI3dR5IGvO3ZKMdudH1wro8dkcaG+exH8HqzWDWIXEQ3EbZf1Ua1PslCDcKGRB7XpIyJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658648; c=relaxed/simple;
	bh=LqwYl8N88CmKckq4juBYwkz6dG7MdWX8cy7puPTv7hc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CD49qXl5iCwYfDg84jw1ONW7HJw1kjuwPGNV83Spbej8GvPoT54yJ3Q6HFy2spWGpCPE2T1dHy2ar+/p0liwEC/szqTIiVhacyNN8K2A6C8qJ6t0p0Ta9KUlipO1H411/nkjOIAZEGKBYXv7u8/E56qlcC+ss50j5Dra2XEJw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpjqsWmT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpjqsWmT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d3540a43fso63092345ad.3
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761658645; x=1762263445; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZtG3wYwJRaMwfSZjLws07Tz6NojQ9iOYClmBYHuVzg=;
        b=gpjqsWmTCg6l7SOiauOe6MhJc8xtiGwDyMthvl//ZLFHD1rIPzBOYPvUXLoLiVc+px
         gR2+lI/pf2DKQooxrnSkuIwtBwKdCxop8oTTk6MFE6+7rDWM85/e1R/sJG7b3vw1EvMd
         1eS8paYGMmjb4NHofRO422W6aykydQiYRaBz4UPa6b21edAq83Qa+NWqP2TuoMYmh+4X
         oSXkOcIAnBUo0ES/KPOckn4ft9OXnizIc8C/hNruAMO7b2qUYFiEitqyIdHrc8ARcnlE
         5Fa42glRleFgfxQ61x1i6khsc50uy5JEHwV6NwPuu0iw/CRV3FBMGEWgpiXgGt4Ohlhh
         JV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761658645; x=1762263445;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZtG3wYwJRaMwfSZjLws07Tz6NojQ9iOYClmBYHuVzg=;
        b=O2veCnSHPZLB8tM6V9/oPGdWxLu3g3eygfDP3rbtAY6YDprCyC8VojRnfSRFwlmil7
         Zo+st01uKcHjLdeqvmo7jCUjwOlF2aQS+WVLtyYVQr03UZqu6jUDeMzKcwF9tGzF50jh
         Isv8XnCZeOyE1PB1WrKs8A35os/db2Kgswh9iQ32GRA2eM4eBK37xBY9M3ueagwkM3Sw
         KGmDO+fE4zPTwTv34Z9kgvc9Zuu2eGI6nT8QZBv1BJgaQsQe6uwu6FTOphxjYDp0iQsl
         Vn/quZrCCAdFda3q8fayVHyyH374KsDeQDnPz5WzqKr5t8YKfUOttZ2pew3kvuDOSZzJ
         wYtg==
X-Gm-Message-State: AOJu0YyRwTudY1T/j0YfErfDBY0Q1zVo16iIYBwDZvSJTRLb153G2+0I
	McrmzFuE6LD+REduPHlK/ipj73riRRkMpU/7Un1NV+a9WI11fxZ1XVOHZbWQgw==
X-Gm-Gg: ASbGncvE/472TfpEyW5d1lObl3imS6ke4bHhRsPj2ozorsG6QcKwvaCZK3z+EpCvogQ
	+dmMhDNneejaDkSDXBznTU2PgtK5M8hET5+m4mkJNxN5LFeOwFCKuyPHIyYFnsSnhAjOiBDZhis
	qcREvtnBD3WhM3m/nIMKhDmenxM+9e0KGwM+pkJamP3fMDZAuUlfdpC1mkHZ7mMotL811KqJc6I
	4oP7R3cxUP3LtabGAvo8WEUCzJNB23B/Pd3LNx5s1T5lZxWowxrN3jPuRcYcVYs4XrvF0eksFJR
	Ze50VG8uu5OK3fDun3VhM/nlacUfGqy2zNXi67nMDfUpLAJJhwYxW4Cq5OlJ2fWAg9Vv7xO/fXW
	bvGMfa3yOKnqNEn85PQfRGDnD3U5ikA8O+ozbj3cbluKzEb+Ro2SblzqU+M8v02M+Fj1ni+9m/E
	SBxA==
X-Google-Smtp-Source: AGHT+IEfF0c3CBsC8xr9UXDkOFTBzeY4S+zNDwOsNowBGg6fqwWaHHQzHFvG20UIe8RqI7igWgG0Hw==
X-Received: by 2002:a17:902:e5c6:b0:267:99bf:6724 with SMTP id d9443c01a7336-294cb4f2d53mr49781165ad.31.1761658644559;
        Tue, 28 Oct 2025 06:37:24 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d44db4sm119789295ad.86.2025.10.28.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:37:24 -0700 (PDT)
Message-Id: <pull.2075.v2.git.git.1761658643278.gitgitgadget@gmail.com>
In-Reply-To: <pull.2075.git.git.1760972162827.gitgitgadget@gmail.com>
References: <pull.2075.git.git.1760972162827.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Oct 2025 13:37:23 +0000
Subject: [PATCH v2] blame: make diff algorithm configurable
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

The diff algorithm used in 'git-blame(1)' is set to 'myers',
without the possibility to change it aside from the `--minimal` option.

There has been long-standing interest in changing the default diff
algorithm to "histogram", and Git 3.0 was floated as a possible occasion
for taking some steps towards that:

https://lore.kernel.org/git/xmqqed873vgn.fsf@gitster.g/

As a preparation for this move, it is worth making sure that the diff
algorithm is configurable where useful.

Make it configurable in the `git-blame(1)` command by introducing the
`--diff-algorithm` option and make honor the `diff.algorithm` config
variable. Keep Myers diff as the default.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
    blame: make diff algorithm configurable
    
    Changes since v1:
    
     * add tests
     * ignore --diff-algorithm when it is provided before --minimal
     * improve patch description
     * remove duplication of documentation sections
     * style improvements

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2075%2Fwetneb%2Fblame_respects_diff_algorithm-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2075/wetneb/blame_respects_diff_algorithm-v2
Pull-Request: https://github.com/git/git/pull/2075

Range-diff vs v1:

 1:  32b59d0204 ! 1:  107f51620b blame: make diff algorithm configurable
     @@ Metadata
       ## Commit message ##
          blame: make diff algorithm configurable
      
     -    The diff algorithm used in 'git-blame(1)' can be configured using the
     -    `--diff-algorithm` option or the `diff.algorithm` config variable.
     -    Myers diff remains the default.
     +    The diff algorithm used in 'git-blame(1)' is set to 'myers',
     +    without the possibility to change it aside from the `--minimal` option.
     +
     +    There has been long-standing interest in changing the default diff
     +    algorithm to "histogram", and Git 3.0 was floated as a possible occasion
     +    for taking some steps towards that:
     +
     +    https://lore.kernel.org/git/xmqqed873vgn.fsf@gitster.g/
     +
     +    As a preparation for this move, it is worth making sure that the diff
     +    algorithm is configurable where useful.
     +
     +    Make it configurable in the `git-blame(1)` command by introducing the
     +    `--diff-algorithm` option and make honor the `diff.algorithm` config
     +    variable. Keep Myers diff as the default.
      
          Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
      
     - ## Documentation/git-blame.adoc ##
     -@@ Documentation/git-blame.adoc: include::blame-options.adoc[]
     - 	Ignore whitespace when comparing the parent's version and
     - 	the child's to find where the lines came from.
     - 
     + ## Documentation/diff-algorithm-option.adoc (new) ##
     +@@
      +`--diff-algorithm=(patience|minimal|histogram|myers)`::
      +	Choose a diff algorithm. The variants are as follows:
      ++
     @@ Documentation/git-blame.adoc: include::blame-options.adoc[]
      +For instance, if you configured the `diff.algorithm` variable to a
      +non-default value and want to use the default one, then you
      +have to use `--diff-algorithm=default` option.
     +
     + ## Documentation/diff-options.adoc ##
     +@@ Documentation/diff-options.adoc: and starts with _<text>_, this algorithm attempts to prevent it from
     + appearing as a deletion or addition in the output. It uses the "patience
     + diff" algorithm internally.
     + 
     +-`--diff-algorithm=(patience|minimal|histogram|myers)`::
     +-	Choose a diff algorithm. The variants are as follows:
     +-+
     +---
     +-   `default`;;
     +-   `myers`;;
     +-	The basic greedy diff algorithm. Currently, this is the default.
     +-   `minimal`;;
     +-	Spend extra time to make sure the smallest possible diff is
     +-	produced.
     +-   `patience`;;
     +-	Use "patience diff" algorithm when generating patches.
     +-   `histogram`;;
     +-	This algorithm extends the patience algorithm to "support
     +-	low-occurrence common elements".
     +---
     +-+
     +-For instance, if you configured the `diff.algorithm` variable to a
     +-non-default value and want to use the default one, then you
     +-have to use `--diff-algorithm=default` option.
     ++include::diff-algorithm-option.adoc[]
     + 
     + `--stat[=<width>[,<name-width>[,<count>]]]`::
     + 	Generate a diffstat. By default, as much space as necessary
     +
     + ## Documentation/git-blame.adoc ##
     +@@ Documentation/git-blame.adoc: include::blame-options.adoc[]
     + 	Ignore whitespace when comparing the parent's version and
     + 	the child's to find where the lines came from.
     + 
     ++include::diff-algorithm-option.adoc[]
      +
       --abbrev=<n>::
       	Instead of using the default 7+1 hexadecimal digits as the
     @@ builtin/blame.c: static int blame_move_callback(const struct option *option, con
       	return 0;
       }
       
     ++static int blame_diff_algorithm_minimal(const struct option *option,
     ++					const char *arg, int unset)
     ++{
     ++	int *opt = option->value;
     ++
     ++	BUG_ON_OPT_NEG(unset);
     ++	BUG_ON_OPT_ARG(arg);
     ++
     ++	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
     ++	*opt |= XDF_NEED_MINIMAL;
     ++
     ++	return 0;
     ++}
     ++
      +static int blame_diff_algorithm_callback(const struct option *option,
      +					 const char *arg, int unset)
      +{
     @@ builtin/blame.c: static int blame_move_callback(const struct option *option, con
      +		return error(_("option diff-algorithm accepts \"myers\", "
      +			       "\"minimal\", \"patience\" and \"histogram\""));
      +
     -+	// ignore any previous --minimal setting, following git-diff's behavior
     -+	*opt &= ~XDF_NEED_MINIMAL;
     -+	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
     ++	*opt &= ~(XDF_NEED_MINIMAL | XDF_DIFF_ALGORITHM_MASK);
      +	*opt |= value;
      +
      +	return 0;
     @@ builtin/blame.c: static int blame_move_callback(const struct option *option, con
       {
       	struct object_id oid;
      @@ builtin/blame.c: int cmd_blame(int argc,
     - 		OPT_BIT('f', "show-name", &output_option, N_("show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
     - 		OPT_BIT('n', "show-number", &output_option, N_("show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
     - 		OPT_BIT('p', "porcelain", &output_option, N_("show in a format designed for machine consumption"), OUTPUT_PORCELAIN),
     --		OPT_BIT(0, "line-porcelain", &output_option, N_("show porcelain format with per-line commit information"), OUTPUT_PORCELAIN|OUTPUT_LINE_PORCELAIN),
     -+		OPT_BIT(0, "line-porcelain", &output_option, N_("show porcelain format with per-line commit information"), OUTPUT_PORCELAIN | OUTPUT_LINE_PORCELAIN),
     - 		OPT_BIT('c', NULL, &output_option, N_("use the same output mode as git-annotate (Default: off)"), OUTPUT_ANNOTATE_COMPAT),
     - 		OPT_BIT('t', NULL, &output_option, N_("show raw timestamp (Default: off)"), OUTPUT_RAW_TIMESTAMP),
     - 		OPT_BIT('l', NULL, &output_option, N_("show long commit SHA1 (Default: off)"), OUTPUT_LONG_OBJECT_NAME),
       		OPT_BIT('s', NULL, &output_option, N_("suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
       		OPT_BIT('e', "show-email", &output_option, N_("show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
       		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
     @@ builtin/blame.c: int cmd_blame(int argc,
       		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
       		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
       		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
     + 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
     ++		OPT_CALLBACK_F(0, "minimal", &xdl_opts, NULL,
     ++			       N_("spend extra cycles to find better match"),
     ++			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
     ++			       blame_diff_algorithm_minimal),
     + 		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
     + 		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("use revisions from <file> instead of calling git-rev-list")),
     + 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("use <file>'s contents as the final image")),
     +
     + ## t/meson.build ##
     +@@ t/meson.build: integration_tests = [
     +   't8012-blame-colors.sh',
     +   't8013-blame-ignore-revs.sh',
     +   't8014-blame-ignore-fuzzy.sh',
     ++  't8015-blame-diff-algorithm.sh',
     +   't8020-last-modified.sh',
     +   't9001-send-email.sh',
     +   't9002-column.sh',
     +
     + ## t/t8015-blame-diff-algorithm.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++test_description='git blame with specific diff algorithm'
     ++
     ++. ./test-lib.sh
     ++
     ++test_expect_success setup '
     ++	cat >file.c <<-\EOF &&
     ++	int f(int x, int y)
     ++	{
     ++		if (x == 0)
     ++		{
     ++			return y;
     ++		}
     ++		return x;
     ++	}
     ++
     ++	int g(size_t u)
     ++	{
     ++		while (u < 30)
     ++		{
     ++			u++;
     ++		}
     ++		return u;
     ++	}
     ++	EOF
     ++	test_write_lines x x x x >file.txt &&
     ++	git add file.c file.txt &&
     ++	GIT_AUTHOR_NAME=Initial git commit -m Initial &&
     ++
     ++	cat >file.c <<-\EOF &&
     ++	int g(size_t u)
     ++	{
     ++		while (u < 30)
     ++		{
     ++			u++;
     ++		}
     ++		return u;
     ++	}
     ++
     ++	int h(int x, int y, int z)
     ++	{
     ++		if (z == 0)
     ++		{
     ++			return x;
     ++		}
     ++		return y;
     ++	}
     ++	EOF
     ++	test_write_lines x x x A B C D x E F G >file.txt &&
     ++	git add file.c file.txt &&
     ++	GIT_AUTHOR_NAME=Second git commit -m Second
     ++'
     ++
     ++test_expect_success 'blame uses Myers diff algorithm by default for now' '
     ++	cat >expected <<-\EOF &&
     ++	Second
     ++	Initial
     ++	Second
     ++	Initial
     ++	Second
     ++	Initial
     ++	Second
     ++	Initial
     ++	Initial
     ++	Second
     ++	Initial
     ++	Second
     ++	Initial
     ++	Second
     ++	Initial
     ++	Second
     ++	Initial
     ++	EOF
     ++
     ++	# git blame file.c | grep --only-matching -e Initial -e Second > actual &&
     ++	# test_cmp expected actual
     ++	echo goo
     ++'
     ++
     ++test_expect_success 'blame honors --diff-algorithm option' '
     ++	cat >expected <<-\EOF &&
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	EOF
     ++
     ++	git blame file.c --diff-algorithm=histogram | \
     ++		grep --only-matching -e Initial -e Second > actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'blame honors diff.algorithm config variable' '
     ++	cat >expected <<-\EOF &&
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	EOF
     ++
     ++	git config diff.algorithm histogram &&
     ++	git blame file.c | \
     ++		grep --only-matching -e Initial -e Second > actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'blame honors --minimal option' '
     ++	cat >expected <<-\EOF &&
     ++	Initial
     ++	Initial
     ++	Initial
     ++	Second
     ++	Second
     ++	Second
     ++	Second
     ++	Initial
     ++	Second
     ++	Second
     ++	Second
     ++	EOF
     ++
     ++	git blame file.txt --minimal | \
     ++		grep --only-matching -e Initial -e Second > actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_done


 Documentation/diff-algorithm-option.adoc |  20 +++
 Documentation/diff-options.adoc          |  21 +---
 Documentation/git-blame.adoc             |   2 +
 builtin/blame.c                          |  52 ++++++++
 t/meson.build                            |   1 +
 t/t8015-blame-diff-algorithm.sh          | 154 +++++++++++++++++++++++
 6 files changed, 230 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/diff-algorithm-option.adoc
 create mode 100755 t/t8015-blame-diff-algorithm.sh

diff --git a/Documentation/diff-algorithm-option.adoc b/Documentation/diff-algorithm-option.adoc
new file mode 100644
index 0000000000..8e3a0b63d7
--- /dev/null
+++ b/Documentation/diff-algorithm-option.adoc
@@ -0,0 +1,20 @@
+`--diff-algorithm=(patience|minimal|histogram|myers)`::
+	Choose a diff algorithm. The variants are as follows:
++
+--
+   `default`;;
+   `myers`;;
+	The basic greedy diff algorithm. Currently, this is the default.
+   `minimal`;;
+	Spend extra time to make sure the smallest possible diff is
+	produced.
+   `patience`;;
+	Use "patience diff" algorithm when generating patches.
+   `histogram`;;
+	This algorithm extends the patience algorithm to "support
+	low-occurrence common elements".
+--
++
+For instance, if you configured the `diff.algorithm` variable to a
+non-default value and want to use the default one, then you
+have to use `--diff-algorithm=default` option.
diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index ae31520f7f..9cdad6f72a 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -197,26 +197,7 @@ and starts with _<text>_, this algorithm attempts to prevent it from
 appearing as a deletion or addition in the output. It uses the "patience
 diff" algorithm internally.
 
-`--diff-algorithm=(patience|minimal|histogram|myers)`::
-	Choose a diff algorithm. The variants are as follows:
-+
---
-   `default`;;
-   `myers`;;
-	The basic greedy diff algorithm. Currently, this is the default.
-   `minimal`;;
-	Spend extra time to make sure the smallest possible diff is
-	produced.
-   `patience`;;
-	Use "patience diff" algorithm when generating patches.
-   `histogram`;;
-	This algorithm extends the patience algorithm to "support
-	low-occurrence common elements".
---
-+
-For instance, if you configured the `diff.algorithm` variable to a
-non-default value and want to use the default one, then you
-have to use `--diff-algorithm=default` option.
+include::diff-algorithm-option.adoc[]
 
 `--stat[=<width>[,<name-width>[,<count>]]]`::
 	Generate a diffstat. By default, as much space as necessary
diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index e438d28625..adcbb6f5dc 100644
--- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -85,6 +85,8 @@ include::blame-options.adoc[]
 	Ignore whitespace when comparing the parent's version and
 	the child's to find where the lines came from.
 
+include::diff-algorithm-option.adoc[]
+
 --abbrev=<n>::
 	Instead of using the default 7+1 hexadecimal digits as the
 	abbreviated object name, use <m>+1 digits, where <m> is at
diff --git a/builtin/blame.c b/builtin/blame.c
index 2703820258..eb0ab71dba 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -779,6 +779,19 @@ static int git_blame_config(const char *var, const char *value,
 		}
 	}
 
+	if (!strcmp(var, "diff.algorithm")) {
+		long diff_algorithm;
+		if (!value)
+			return config_error_nonbool(var);
+		diff_algorithm = parse_algorithm_value(value);
+		if (diff_algorithm < 0)
+			return error(_("unknown value for config '%s': %s"),
+				     var, value);
+		xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
+		xdl_opts |= diff_algorithm;
+		return 0;
+	}
+
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
 	if (userdiff_config(var, value) < 0)
@@ -824,6 +837,38 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 	return 0;
 }
 
+static int blame_diff_algorithm_minimal(const struct option *option,
+					const char *arg, int unset)
+{
+	int *opt = option->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
+	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
+	*opt |= XDF_NEED_MINIMAL;
+
+	return 0;
+}
+
+static int blame_diff_algorithm_callback(const struct option *option,
+					 const char *arg, int unset)
+{
+	int *opt = option->value;
+	long value = parse_algorithm_value(arg);
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (value < 0)
+		return error(_("option diff-algorithm accepts \"myers\", "
+			       "\"minimal\", \"patience\" and \"histogram\""));
+
+	*opt &= ~(XDF_NEED_MINIMAL | XDF_DIFF_ALGORITHM_MASK);
+	*opt |= value;
+
+	return 0;
+}
+
 static int is_a_rev(const char *name)
 {
 	struct object_id oid;
@@ -915,10 +960,17 @@ int cmd_blame(int argc,
 		OPT_BIT('s', NULL, &output_option, N_("suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_CALLBACK_F(0, "diff-algorithm", &xdl_opts, N_("<algorithm>"),
+			       N_("choose a diff algorithm"),
+			       PARSE_OPT_NONEG, blame_diff_algorithm_callback),
 		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
 		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
+		OPT_CALLBACK_F(0, "minimal", &xdl_opts, NULL,
+			       N_("spend extra cycles to find better match"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       blame_diff_algorithm_minimal),
 		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
 		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("use revisions from <file> instead of calling git-rev-list")),
 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("use <file>'s contents as the final image")),
diff --git a/t/meson.build b/t/meson.build
index 401b24e50e..9f2fe7af8b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -955,6 +955,7 @@ integration_tests = [
   't8012-blame-colors.sh',
   't8013-blame-ignore-revs.sh',
   't8014-blame-ignore-fuzzy.sh',
+  't8015-blame-diff-algorithm.sh',
   't8020-last-modified.sh',
   't9001-send-email.sh',
   't9002-column.sh',
diff --git a/t/t8015-blame-diff-algorithm.sh b/t/t8015-blame-diff-algorithm.sh
new file mode 100755
index 0000000000..43996df177
--- /dev/null
+++ b/t/t8015-blame-diff-algorithm.sh
@@ -0,0 +1,154 @@
+#!/bin/sh
+
+test_description='git blame with specific diff algorithm'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	cat >file.c <<-\EOF &&
+	int f(int x, int y)
+	{
+		if (x == 0)
+		{
+			return y;
+		}
+		return x;
+	}
+
+	int g(size_t u)
+	{
+		while (u < 30)
+		{
+			u++;
+		}
+		return u;
+	}
+	EOF
+	test_write_lines x x x x >file.txt &&
+	git add file.c file.txt &&
+	GIT_AUTHOR_NAME=Initial git commit -m Initial &&
+
+	cat >file.c <<-\EOF &&
+	int g(size_t u)
+	{
+		while (u < 30)
+		{
+			u++;
+		}
+		return u;
+	}
+
+	int h(int x, int y, int z)
+	{
+		if (z == 0)
+		{
+			return x;
+		}
+		return y;
+	}
+	EOF
+	test_write_lines x x x A B C D x E F G >file.txt &&
+	git add file.c file.txt &&
+	GIT_AUTHOR_NAME=Second git commit -m Second
+'
+
+test_expect_success 'blame uses Myers diff algorithm by default for now' '
+	cat >expected <<-\EOF &&
+	Second
+	Initial
+	Second
+	Initial
+	Second
+	Initial
+	Second
+	Initial
+	Initial
+	Second
+	Initial
+	Second
+	Initial
+	Second
+	Initial
+	Second
+	Initial
+	EOF
+
+	# git blame file.c | grep --only-matching -e Initial -e Second > actual &&
+	# test_cmp expected actual
+	echo goo
+'
+
+test_expect_success 'blame honors --diff-algorithm option' '
+	cat >expected <<-\EOF &&
+	Initial
+	Initial
+	Initial
+	Initial
+	Initial
+	Initial
+	Initial
+	Initial
+	Second
+	Second
+	Second
+	Second
+	Second
+	Second
+	Second
+	Second
+	Second
+	EOF
+
+	git blame file.c --diff-algorithm=histogram | \
+		grep --only-matching -e Initial -e Second > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'blame honors diff.algorithm config variable' '
+	cat >expected <<-\EOF &&
+	Initial
+	Initial
+	Initial
+	Initial
+	Initial
+	Initial
+	Initial
+	Initial
+	Second
+	Second
+	Second
+	Second
+	Second
+	Second
+	Second
+	Second
+	Second
+	EOF
+
+	git config diff.algorithm histogram &&
+	git blame file.c | \
+		grep --only-matching -e Initial -e Second > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'blame honors --minimal option' '
+	cat >expected <<-\EOF &&
+	Initial
+	Initial
+	Initial
+	Second
+	Second
+	Second
+	Second
+	Initial
+	Second
+	Second
+	Second
+	EOF
+
+	git blame file.txt --minimal | \
+		grep --only-matching -e Initial -e Second > actual &&
+	test_cmp expected actual
+'
+
+test_done

base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
-- 
gitgitgadget
