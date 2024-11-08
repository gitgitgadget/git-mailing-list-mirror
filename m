Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DDA1EBA00
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073390; cv=none; b=ilP0V1mnQFYiBLWTKjqsSbu3dj1KQumk8w5b5eNO2XX1A1m9+5K3DSxiWDJu6P/apEgLGzq5xbEzAPcOo/xSFltI2VMzsSMnIF0OECk9QKwo8DgtUwWayJiF4BHUpkWcWydBskCyhHxvEfJvSbPV7qRY3c4Z9zEnAGoZZe6HuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073390; c=relaxed/simple;
	bh=ven7s9h3MpkWQmDdOZVGtMaUXV0kHJG7/hpO0MpNyKU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tiu3Tyf5QZE33RJkqbS69JxQUE51CBVbKNX5UnwSXIvVqEYPdhsLt4g1pfnJDdIuGIgSBIsXehdJSaLQ5Pg103dD3Z6nT0vMtieXsmMesfaCXWydX0oNjwSKbMof2Kh7sbR9+mahGPJvraopA1nl5FYegGftFMJyIrprVBFmDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJucgYwv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJucgYwv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431695fa98bso16950085e9.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731073386; x=1731678186; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCXOE1UPt93oBZ1IA9wCFYIPEoxtjsxBDN65ZYY9HyE=;
        b=XJucgYwvqnKJa1LxbKarfWPxMSLcITedCF8/lfFGJNK9p1NAJV7IffVLaLyY29uQ1X
         xCnQTTs4bP2KDrKH7QYA57nFKE3Fjik42pOqELo3FRrvUQ9fO2uCgLLcBf8aYnh+Apjb
         zgQdwYtq8y2cNaEw98OtwW/A4FmiGj9WgfLRJSDwKsAQeNDO0R68Yyu9C7KUTqR/BFc5
         WGmeQsgiLBH395Hk/XEUpKGkZsS3ZqxXZWM+81yU3AsFu3P8pYoFv7XmX/fH6q6ss4nb
         PlOqcyWEcPxCMje5hOf74ENp9JgnU40sktOxCpAsLL6P9zUs3Rgx8vNeufpP8xBtnEWe
         wi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731073386; x=1731678186;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCXOE1UPt93oBZ1IA9wCFYIPEoxtjsxBDN65ZYY9HyE=;
        b=pcRIOv69Wd9kSJcS34tUollaSVcX9nud0Ri9JuzMRzEsHX/QiLSTXT7HaAtcgu+5Wf
         hBbOMw30jzjP7s3X6LZao++mc9vwRPBfvqIxCcA3YxoIPQtxkrJbnSQ9s42YT/N5oGHk
         uCQhihTD0In6p4vxHM/xN8ffqlQ7EK4UaJ5EkZojNiKUxQZMTrMny9HvbOy+QNONQ5fd
         +buksl3aJrBp8SrBMeCD71OleRImUxRAdqIQ1hKlxPNfwYiXW0IGIF0Ud5u424RgHzqB
         b+fzsw6BX3gkbNKJIynOarMxTEOJGm+fJjHmSbRl79Rdp/tUKagpYhnUzQ8D2tUwQ1qa
         LPSA==
X-Gm-Message-State: AOJu0YwiOdWH0Kn1Jq7SkW1d2/eObNJAr8Bf03Hbb8YY6D1C92hHaC0a
	Fmwa8tZDM0+kUkbHNHGjozLapugPUjQmskCAUzZfDh8+dZHhaNt0An6XRg==
X-Google-Smtp-Source: AGHT+IF+no47XJRpUZrknzK+zUcsBc6OS6g18cTgvhZer3bi0ilDzUkgDAsNB0iajRS7LL9JwK0R9Q==
X-Received: by 2002:a05:600c:4746:b0:42f:80f4:ab31 with SMTP id 5b1f17b1804b1-432b750a43emr24950025e9.18.1731073385589;
        Fri, 08 Nov 2024 05:43:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6bee9asm108912215e9.19.2024.11.08.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:43:04 -0800 (PST)
Message-Id: <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
In-Reply-To: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Nov 2024 13:43:03 +0000
Subject: [PATCH v2] range-diff: optionally include merge commits' diffs in the
 analysis
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `git log` command already offers support for including diffs for
merges, via the `--diff-merges=<format>` option.

Let's add corresponding support for `git range-diff`, too. This makes it
more convenient to spot differences between iterations of non-linear
contributions, where so-called "evil merges" are sometimes necessary and
need to be reviewed, too.

In my code reviews, I found the `--diff-merges=first-parent` option
particularly useful.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Support diff merges option in range diff
    
    The git range-diff command does the same with merge commits as git
    rebase: It ignores them.
    
    However, when comparing branch thickets it can be quite illuminating to
    watch out for inadvertent changes in merge commits, in particular when
    some "evil" merges have been replayed, i.e. merges that needed to
    introduce changes outside of the merge conflicts (e.g. when one branch
    changed a function's signature and another branch introduced a caller of
    said function), in case the replayed merge is no longer "evil" and
    therefore potentially incorrect.
    
    Let's introduce support for the --diff-merges option that is passed
    through to those git log commands.
    
    I had a need for this earlier this year and got it working, leaving the
    GitGitGadget PR in a draft mode. Phil Blain found it and kindly
    nerd-sniped me into readying it for submitting, so say thanks to Phil!
    
    Changes since v1:
    
     * Changed the documentation to recommend first-parent mode instead of
       vaguely talking about various modes' merits.
     * Disallowed the no-arg --diff-merges option (because --diff-merges
       requires an argument).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1734%2Fdscho%2Fsupport-diff-merges-option-in-range-diff-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1734/dscho/support-diff-merges-option-in-range-diff-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1734

Range-diff vs v1:

 1:  11361e07af8 ! 1:  d01a395900b range-diff: optionally include merge commits' diffs in the analysis
     @@ Documentation/git-range-diff.txt: to revert to color all lines according to the
      +	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
      +	and include them in the comparison.
      ++
     -+Note: Some of the formats supported by linkgit:git-log[1] make less sense in
     -+the context of the `range-diff` command than other formats, so choose wisely!
     ++Note: In the common case, the `first-parent` mode will be the most natural one
     ++to use, as it is consistent with the idea that a merge is kind of a "meta
     ++patch", comprising all the merged commits' patches into a single one.
      +
       --[no-]notes[=<ref>]::
       	This flag is passed to the `git log` program
     @@ builtin/range-diff.c: int cmd_range_diff(int argc,
       				  N_("notes"), N_("passed to 'git log'"),
       				  PARSE_OPT_OPTARG),
      +		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
     -+				  N_("style"), N_("passed to 'git log'"),
     -+				  PARSE_OPT_OPTARG),
     ++				  N_("style"), N_("passed to 'git log'"), 0),
       		OPT_BOOL(0, "left-only", &left_only,
       			 N_("only emit output related to the first range")),
       		OPT_BOOL(0, "right-only", &right_only,


 Documentation/git-range-diff.txt | 11 ++++++++++-
 builtin/range-diff.c             | 10 ++++++++++
 range-diff.c                     | 15 +++++++++++----
 range-diff.h                     |  1 +
 t/t3206-range-diff.sh            | 16 ++++++++++++++++
 5 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index fbdbe0befeb..17a85957877 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
-	[--left-only | --right-only]
+	[--left-only | --right-only] [--diff-merges=<format>]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
 	[[--] <path>...]
 
@@ -81,6 +81,15 @@ to revert to color all lines according to the outer diff markers
 	Suppress commits that are missing from the second specified range
 	(or the "right range" when using the `<rev1>...<rev2>` format).
 
+--diff-merges=<format>::
+	Instead of ignoring merge commits, generate diffs for them using the
+	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
+	and include them in the comparison.
++
+Note: In the common case, the `first-parent` mode will be the most natural one
+to use, as it is consistent with the idea that a merge is kind of a "meta
+patch", comprising all the merged commits' patches into a single one.
+
 --[no-]notes[=<ref>]::
 	This flag is passed to the `git log` program
 	(see linkgit:git-log[1]) that generates the patches.
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 1b33ab66a7b..901de5d133d 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -21,6 +21,7 @@ int cmd_range_diff(int argc,
 {
 	struct diff_options diffopt = { NULL };
 	struct strvec other_arg = STRVEC_INIT;
+	struct strvec diff_merges_arg = STRVEC_INIT;
 	struct range_diff_options range_diff_opts = {
 		.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT,
 		.diffopt = &diffopt,
@@ -36,6 +37,8 @@ int cmd_range_diff(int argc,
 		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
 				  N_("notes"), N_("passed to 'git log'"),
 				  PARSE_OPT_OPTARG),
+		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
+				  N_("style"), N_("passed to 'git log'"), 0),
 		OPT_BOOL(0, "left-only", &left_only,
 			 N_("only emit output related to the first range")),
 		OPT_BOOL(0, "right-only", &right_only,
@@ -62,6 +65,12 @@ int cmd_range_diff(int argc,
 	if (!simple_color)
 		diffopt.use_color = 1;
 
+	/* If `--diff-merges` was specified, imply `--merges` */
+	if (diff_merges_arg.nr) {
+		range_diff_opts.include_merges = 1;
+		strvec_pushv(&other_arg, diff_merges_arg.v);
+	}
+
 	for (i = 0; i < argc; i++)
 		if (!strcmp(argv[i], "--")) {
 			dash_dash = i;
@@ -155,6 +164,7 @@ int cmd_range_diff(int argc,
 	res = show_range_diff(range1.buf, range2.buf, &range_diff_opts);
 
 	strvec_clear(&other_arg);
+	strvec_clear(&diff_merges_arg);
 	strbuf_release(&range1);
 	strbuf_release(&range2);
 
diff --git a/range-diff.c b/range-diff.c
index bbb0952264b..9e59733059b 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -38,7 +38,8 @@ struct patch_util {
  * as struct object_id (will need to be free()d).
  */
 static int read_patches(const char *range, struct string_list *list,
-			const struct strvec *other_arg)
+			const struct strvec *other_arg,
+			unsigned int include_merges)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
@@ -49,7 +50,7 @@ static int read_patches(const char *range, struct string_list *list,
 	size_t size;
 	int ret = -1;
 
-	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
+	strvec_pushl(&cp.args, "log", "--no-color", "-p",
 		     "--reverse", "--date-order", "--decorate=no",
 		     "--no-prefix", "--submodule=short",
 		     /*
@@ -64,6 +65,8 @@ static int read_patches(const char *range, struct string_list *list,
 		     "--pretty=medium",
 		     "--show-notes-by-default",
 		     NULL);
+	if (!include_merges)
+		strvec_push(&cp.args, "--no-merges");
 	strvec_push(&cp.args, range);
 	if (other_arg)
 		strvec_pushv(&cp.args, other_arg->v);
@@ -96,11 +99,14 @@ static int read_patches(const char *range, struct string_list *list,
 		}
 
 		if (skip_prefix(line, "commit ", &p)) {
+			char *q;
 			if (util) {
 				string_list_append(list, buf.buf)->util = util;
 				strbuf_reset(&buf);
 			}
 			CALLOC_ARRAY(util, 1);
+			if (include_merges && (q = strstr(p, " (from ")))
+				*q = '\0';
 			if (repo_get_oid(the_repository, p, &util->oid)) {
 				error(_("could not parse commit '%s'"), p);
 				FREE_AND_NULL(util);
@@ -571,13 +577,14 @@ int show_range_diff(const char *range1, const char *range2,
 
 	struct string_list branch1 = STRING_LIST_INIT_DUP;
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
+	unsigned int include_merges = range_diff_opts->include_merges;
 
 	if (range_diff_opts->left_only && range_diff_opts->right_only)
 		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
 
-	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg))
+	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg, include_merges))
 		res = error(_("could not parse log for '%s'"), range1);
-	if (!res && read_patches(range2, &branch2, range_diff_opts->other_arg))
+	if (!res && read_patches(range2, &branch2, range_diff_opts->other_arg, include_merges))
 		res = error(_("could not parse log for '%s'"), range2);
 
 	if (!res) {
diff --git a/range-diff.h b/range-diff.h
index 2f69f6a434d..cd85000b5a0 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -16,6 +16,7 @@ struct range_diff_options {
 	int creation_factor;
 	unsigned dual_color:1;
 	unsigned left_only:1, right_only:1;
+	unsigned include_merges:1;
 	const struct diff_options *diffopt; /* may be NULL */
 	const struct strvec *other_arg; /* may be NULL */
 };
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 86010931ab6..c18a3fdab83 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -909,4 +909,20 @@ test_expect_success 'submodule changes are shown irrespective of diff.submodule'
 	test_cmp expect actual
 '
 
+test_expect_success '--diff-merges' '
+	renamed_oid=$(git rev-parse --short renamed-file) &&
+	tree=$(git merge-tree unmodified renamed-file) &&
+	clean=$(git commit-tree -m merge -p unmodified -p renamed-file $tree) &&
+	clean_oid=$(git rev-parse --short $clean) &&
+	conflict=$(git commit-tree -m merge -p unmodified -p renamed-file^ $tree) &&
+	conflict_oid=$(git rev-parse --short $conflict) &&
+
+	git range-diff --diff-merges=1 $clean...$conflict >actual &&
+	cat >expect <<-EOF &&
+	1:  $renamed_oid < -:  ------- s/12/B/
+	2:  $clean_oid = 1:  $conflict_oid merge
+	EOF
+	test_cmp expect actual
+'
+
 test_done

base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
gitgitgadget
