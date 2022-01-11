Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3EFC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbiAKSHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350383AbiAKSGB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:06:01 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA36C034002
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k18so34458914wrg.11
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WCWbgCknVLASCxeZ5soBgr4yUl7SqyT9hYkenmHOnoY=;
        b=EOz/zIA7uVTycBzDi1x2FO6ikHk8uKo/unTTDT1883jnT+o5qEsGcebu4DttaAfHoY
         ilXtu3++3gRPmUPS8XyX9oWe0wgLlR3IuIesEVbRyUBheU9vosTvv6iM/5ImlCjggQR7
         kPNE4jp/ncPSS14y+/zf6vSb7ReOb6UeumutafbzMsYe9dYvi4H8IvEyB3WIQtzqrDW3
         t7MmR3XEl0fBTAkNhhArAFQ8AE2fv+h7VOFAPkpCGzrBbEI3NMc6nbp4qWRUWURJ67D8
         W+VyL8bH47uKgsy1t13as4M+jGDN6YFpRrDx5angY1A9WYZuLWw/KuigVzdymD3sjAjj
         EexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WCWbgCknVLASCxeZ5soBgr4yUl7SqyT9hYkenmHOnoY=;
        b=K5tTcMcxVd2/azQXSwgj8M23uNINnjoVXdBjeGnp/XtV+KWeXz02DaCwoNqLrix09N
         UaghWHg1J4opLztYgi940HIf2sA5FqRQiRv62RuXegsmlf+F1cPXUcoCHXNRQzCLu1qa
         JFDRTwx0aUkEUkBRouIPso95SlKR+hLTJXdRIqfiVoDb5mLhCLR3ZlDErRYykpYSajYi
         Idg+vD7qTrwIrSt1KGmOfaT9KdG21JX40oqrRGSCrlSFxKD3d+XpXwsgYZo6X9x+uJ4D
         AAXdFcvZUdnqqFbq7z54MNNlGBLbMlhtyol5ax43o6YJ4pY4iHakMdyPfTsxOAK9rYBA
         Y3sA==
X-Gm-Message-State: AOAM5331cX3mtVhmpwYTjimWqbOMCfmbNw/CeSXTCo34A6nbB9CRQF4k
        Y3WvvikuVnzgMIq5ZJnYWtqDMUAywpg=
X-Google-Smtp-Source: ABdhPJxO2B9HtMuCbWK1jybtEMxDzBjViFc5pW/RMy87UiZ8QCDyNr4yn9mG05oZuNgojHAGOMJsCg==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr4981813wrn.142.1641924313680;
        Tue, 11 Jan 2022 10:05:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm2243216wmj.15.2022.01.11.10.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:05:13 -0800 (PST)
Message-Id: <601888606d1cf7d7752844dbdbc7fac20d4be8c4.1641924306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
        <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 18:05:02 +0000
Subject: [PATCH v2 5/9] checkout-index: add --ignore-skip-worktree-bits option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update `checkout-index` to no longer refresh files that have the
`skip-worktree` bit set, exiting with an error if `skip-worktree` filenames
are directly provided to `checkout-index`. The newly-added
`--ignore-skip-worktree-bits` option provides a mechanism to replicate the
old behavior, checking out *all* files specified (even those with
`skip-worktree` enabled).

The ability to toggle whether files should be checked-out based on
`skip-worktree` already exists in `git checkout` and `git restore` (both of
which have an `--ignore-skip-worktree-bits` option). The change to, by
default, ignore `skip-worktree` files is especially helpful for
sparse-checkout; it prevents inadvertent creation of files outside the
sparse definition on disk and eliminates the need to expand a sparse index
when using the `--all` option.

Internal usage of `checkout-index` in `git stash` and `git filter-branch` do
not make explicit use of files with `skip-worktree` enabled, so
`--ignore-skip-worktree-bits` is not added to them.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-checkout-index.txt     | 10 +++++++--
 builtin/checkout-index.c                 | 13 ++++++++++++
 t/t1092-sparse-checkout-compatibility.sh | 27 +++++++++++++++---------
 3 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 4d33e7be0f5..01dbd5cbf54 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git checkout-index' [-u] [-q] [-a] [-f] [-n] [--prefix=<string>]
 		   [--stage=<number>|all]
 		   [--temp]
+		   [--ignore-skip-worktree-bits]
 		   [-z] [--stdin]
 		   [--] [<file>...]
 
@@ -37,8 +38,9 @@ OPTIONS
 
 -a::
 --all::
-	checks out all files in the index.  Cannot be used
-	together with explicit filenames.
+	checks out all files in the index except for those with the
+	skip-worktree bit set (see `--ignore-skip-worktree-bits`).
+	Cannot be used together with explicit filenames.
 
 -n::
 --no-create::
@@ -59,6 +61,10 @@ OPTIONS
 	write the content to temporary files.  The temporary name
 	associations will be written to stdout.
 
+--ignore-skip-worktree-bits::
+	Check out all files, including those with the skip-worktree bit
+	set.
+
 --stdin::
 	Instead of taking list of paths from the command line,
 	read list of paths from the standard input.  Paths are
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index e21620d964e..615a118e2f5 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -7,6 +7,7 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
+#include "dir.h"
 #include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
@@ -17,6 +18,7 @@
 #define CHECKOUT_ALL 4
 static int nul_term_line;
 static int checkout_stage; /* default to checkout stage0 */
+static int ignore_skip_worktree; /* default to 0 */
 static int to_tempfile;
 static char topath[4][TEMPORARY_FILENAME_LENGTH + 1];
 
@@ -65,6 +67,7 @@ static int checkout_file(const char *name, const char *prefix)
 	int namelen = strlen(name);
 	int pos = cache_name_pos(name, namelen);
 	int has_same_name = 0;
+	int is_skipped = 1;
 	int did_checkout = 0;
 	int errs = 0;
 
@@ -78,6 +81,9 @@ static int checkout_file(const char *name, const char *prefix)
 			break;
 		has_same_name = 1;
 		pos++;
+		if (!ignore_skip_worktree && ce_skip_worktree(ce))
+			break;
+		is_skipped = 0;
 		if (ce_stage(ce) != checkout_stage
 		    && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
 			continue;
@@ -106,6 +112,9 @@ static int checkout_file(const char *name, const char *prefix)
 		fprintf(stderr, "git checkout-index: %s ", name);
 		if (!has_same_name)
 			fprintf(stderr, "is not in the cache");
+		else if (is_skipped)
+			fprintf(stderr, "has skip-worktree enabled; "
+					"use '--ignore-skip-worktree-bits' to checkout");
 		else if (checkout_stage)
 			fprintf(stderr, "does not exist at stage %d",
 				checkout_stage);
@@ -125,6 +134,8 @@ static int checkout_all(const char *prefix, int prefix_length)
 	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
+		if (!ignore_skip_worktree && ce_skip_worktree(ce))
+			continue;
 		if (ce_stage(ce) != checkout_stage
 		    && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
 			continue;
@@ -185,6 +196,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	struct option builtin_checkout_index_options[] = {
 		OPT_BOOL('a', "all", &all,
 			N_("check out all files in the index")),
+		OPT_BOOL(0, "ignore-skip-worktree-bits", &ignore_skip_worktree,
+			N_("do not skip files with skip-worktree set")),
 		OPT__FORCE(&force, N_("force overwrite of existing files"), 0),
 		OPT__QUIET(&quiet,
 			N_("no warning for existing files and files not in index")),
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index db7ad41109b..434ef0433c0 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -772,9 +772,14 @@ test_expect_success 'checkout-index inside sparse definition' '
 test_expect_success 'checkout-index outside sparse definition' '
 	init_repos &&
 
-	# File does not exist on disk yet for sparse checkouts, so checkout-index
-	# succeeds without -f
-	test_sparse_match git checkout-index -- folder1/a &&
+	# Without --ignore-skip-worktree-bits, outside-of-cone files will trigger
+	# an error
+	test_sparse_match test_must_fail git checkout-index -- folder1/a &&
+	test_i18ngrep "folder1/a has skip-worktree enabled" sparse-checkout-err &&
+	test_path_is_missing folder1/a &&
+
+	# With --ignore-skip-worktree-bits, outside-of-cone files are checked out
+	test_sparse_match git checkout-index --ignore-skip-worktree-bits -- folder1/a &&
 	test_cmp sparse-checkout/folder1/a sparse-index/folder1/a &&
 	test_cmp sparse-checkout/folder1/a full-checkout/folder1/a &&
 
@@ -783,8 +788,8 @@ test_expect_success 'checkout-index outside sparse definition' '
 	run_on_sparse mkdir -p folder1 &&
 	run_on_all cp ../new-a folder1/a &&
 
-	test_all_match test_must_fail git checkout-index -- folder1/a &&
-	test_all_match git checkout-index -f -- folder1/a &&
+	test_all_match test_must_fail git checkout-index --ignore-skip-worktree-bits -- folder1/a &&
+	test_all_match git checkout-index -f --ignore-skip-worktree-bits -- folder1/a &&
 	test_cmp sparse-checkout/folder1/a sparse-index/folder1/a &&
 	test_cmp sparse-checkout/folder1/a full-checkout/folder1/a
 '
@@ -799,14 +804,16 @@ test_expect_success 'checkout-index with folders' '
 	test_all_match test_must_fail git checkout-index -f -- folder1/
 '
 
-# NEEDSWORK: even in sparse checkouts, checkout-index --all will create all
-# files (even those outside the sparse definition) on disk. However, these files
-# don't appear in the percentage of tracked files in git status.
-test_expect_failure 'checkout-index --all' '
+test_expect_success 'checkout-index --all' '
 	init_repos &&
 
 	test_all_match git checkout-index --all &&
-	test_sparse_match test_path_is_missing folder1
+	test_sparse_match test_path_is_missing folder1 &&
+
+	# --ignore-skip-worktree-bits will cause `skip-worktree` files to be
+	# checked out, causing the outside-of-cone `folder1` to exist on-disk
+	test_all_match git checkout-index --ignore-skip-worktree-bits --all &&
+	test_all_match test_path_exists folder1
 '
 
 test_expect_success 'clean' '
-- 
gitgitgadget

