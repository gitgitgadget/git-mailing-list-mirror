Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446B7C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbiADRhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiADRhH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:37:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3416C061784
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:37:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s1so77668342wra.6
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b3gnaly0SbDZimTJYjT7z4OkRmcrHnGxz9j7WSSRCTU=;
        b=mPga0qRWn9YPxtW0LZVAA7pbgyDkYlONwpwdj1RIDkf/OL332OxoJUlS3w2qBbaXKS
         mocQ3whZZ71mDRV5oFF/G8JqAMSB6YelxebUdGvV4OIYiSmY/X7HoclmAvrRcBcX//Sg
         V5ZZjXnpHn+I3t2k6Rdeufh4SsQyH/KkFR4Qz1TwReZgVuPUgLe0eeKczkfjZjI8hMe+
         aGxFETcG07LjYb2ThJJgj8ofxuckuOnKevQN73/z5K0ANypXrQY+lnnDLbOXsZ+fP+SR
         LV/hwxAQPj+GHg0MLM8h1rSwFzbN3qYCG79H866qaLyt+QvgWsKbunZmLa8/woVzDNF0
         27PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b3gnaly0SbDZimTJYjT7z4OkRmcrHnGxz9j7WSSRCTU=;
        b=GpFn9UR4KnGU0gcnv238rucP0GN9yFd/Ldg9RKW+e/Lz7rMQm054O10Ma65hSP1jlT
         /RBRdMPLBYuX2DV8yhymcpIXKOVHafazOJwWZ3cX0me+NieSRTueAU/r1TwlofUkXpJ1
         TRSibpZgn1Xe9WzQpwwh/f9iscldkj1UdwEDV9GGk7OkGS5grpBVnddWXW+azMKK2a0m
         wTN+2m4OjyVICofAngolEH1iFbX8xeodWlz9Rv8mL/kj9qmgSg3rlUifap01CUDfEFgG
         qGm7z1A9qmQpfdSZ+KG2l5BCvjARAi5BWagSQ15fL1yPg3JORzGM+qSH0oY/wuzQTWnL
         fWoQ==
X-Gm-Message-State: AOAM530bjwg8eeQTE/lnjiXqtx7gl1ZE52Zzbf4f5mN7Wu8IgnxgtlqN
        D7H3fDeWgY2wWWFREzpg/ndQrJYhOOw=
X-Google-Smtp-Source: ABdhPJymJIliEYxHx9q0d0I5cnFsK/LdQAQLKn3PkhpVDzncaG7+jYEbPLtreljtZfQu+gPOazhrWA==
X-Received: by 2002:adf:e791:: with SMTP id n17mr41161194wrm.719.1641317825403;
        Tue, 04 Jan 2022 09:37:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm38664303wrq.12.2022.01.04.09.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:37:05 -0800 (PST)
Message-Id: <ec9a751e8dcde99cfaa5c0a855f063de9284057e.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 17:36:56 +0000
Subject: [PATCH 5/9] checkout-index: add --ignore-skip-worktree-bits option
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

Update `checkout-index --all` to no longer refresh files that have the
`skip-worktree` bit set. The newly-added `--ignore-skip-worktree-bits`
option, when used with `--all`, maintains the old behavior and checks out
all files regardless of `skip-worktree`.

The ability to toggle whether files should be checked-out based on
`skip-worktree` already exists in `git checkout` and `git restore` (both of
which have an `--ignore-skip-worktree-bits` option). Adding the option to
`checkout-index` (and changing the corresponding default behavior to respect
the `skip-worktree` bit) is especially helpful for sparse-checkout: it
prevents inadvertent creation of *all* files outside the sparse definition
on disk and eliminates the need to expand a sparse index by default when
using the `--all` option.

Internal usage of `checkout-index` in `git stash` and `git filter-branch` do
not make explicit use of files with `skip-worktree` enabled, so
`--ignore-skip-worktree-bits` is not added to them.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-checkout-index.txt     | 11 +++++++++--
 builtin/checkout-index.c                 | 12 ++++++++++--
 t/t1092-sparse-checkout-compatibility.sh | 10 +++++-----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 4d33e7be0f5..2815f3d4b19 100644
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
@@ -59,6 +61,11 @@ OPTIONS
 	write the content to temporary files.  The temporary name
 	associations will be written to stdout.
 
+--ignore-skip-worktree-bits::
+	Check out all files, including those with the skip-worktree bit
+	set. Note: may only be used with `--all`; skip-worktree is
+	ignored when explicit filenames are specified.
+
 --stdin::
 	Instead of taking list of paths from the command line,
 	read list of paths from the standard input.  Paths are
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index e21620d964e..2053a80103a 100644
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
@@ -116,7 +117,7 @@ static int checkout_file(const char *name, const char *prefix)
 	return -1;
 }
 
-static int checkout_all(const char *prefix, int prefix_length)
+static int checkout_all(const char *prefix, int prefix_length, int ignore_skip_worktree)
 {
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
@@ -125,6 +126,8 @@ static int checkout_all(const char *prefix, int prefix_length)
 	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
+		if (!ignore_skip_worktree && ce_skip_worktree(ce))
+			continue;
 		if (ce_stage(ce) != checkout_stage
 		    && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
 			continue;
@@ -176,6 +179,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int i;
 	struct lock_file lock_file = LOCK_INIT;
 	int all = 0;
+	int ignore_skip_worktree = 0;
 	int read_from_stdin = 0;
 	int prefix_length;
 	int force = 0, quiet = 0, not_new = 0;
@@ -185,6 +189,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	struct option builtin_checkout_index_options[] = {
 		OPT_BOOL('a', "all", &all,
 			N_("check out all files in the index")),
+		OPT_BOOL(0, "ignore-skip-worktree-bits", &ignore_skip_worktree,
+			N_("do not skip files with skip-worktree set")),
 		OPT__FORCE(&force, N_("force overwrite of existing files"), 0),
 		OPT__QUIET(&quiet,
 			N_("no warning for existing files and files not in index")),
@@ -247,6 +253,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 
 		if (all)
 			die("git checkout-index: don't mix '--all' and explicit filenames");
+		if (ignore_skip_worktree)
+			die("git checkout-index: don't mix '--ignore-skip-worktree-bits' and explicit filenames");
 		if (read_from_stdin)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
@@ -280,7 +288,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (all)
-		err |= checkout_all(prefix, prefix_length);
+		err |= checkout_all(prefix, prefix_length, ignore_skip_worktree);
 
 	if (pc_workers > 1)
 		err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index db7ad41109b..fad61d96107 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -799,14 +799,14 @@ test_expect_success 'checkout-index with folders' '
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
+	test_all_match git checkout-index --ignore-skip-worktree-bits --all &&
+	test_all_match test_path_exists folder1
 '
 
 test_expect_success 'clean' '
-- 
gitgitgadget

