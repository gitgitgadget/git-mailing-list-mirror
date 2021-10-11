Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B606C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59E060F21
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhJKUc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbhJKUc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:32:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9DBC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o20so59695276wro.3
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GeJg5j0KjhoiYZfkVfGbXTqvOiOqWSt2Hq4eYQJJWig=;
        b=eaNM2sHBcCkrbKvui3aK0IfFvIUsIpRbDecU2XlLp9wARx+MFVXqM5EXRJmiZ5L3te
         dFC68WdTnBmmRPbjOMGBMTc/gq1SRQuntwh6zS6p664F1WrV7vx1UzB4+RHtKPN36tJb
         YnJx3Y4HTby+lT5nn9NfyA5bV06KZM6JMEjfRXEsnu/LgVkGpbfEESPBIrp4rKbp5ZFl
         5a0dBPXkX22LiXToP9p3JLyS/ILw0oIAmms4Ck2B+/wZBcsq1G5e9IuKWF/wsOBSPD7p
         Fd4L3Iz3oTO1rXghxwkxCSb1OHlVKAIP4NprW4VTj+coY3Gs/KVz3dwbQh3Kc3fmZXWD
         gL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GeJg5j0KjhoiYZfkVfGbXTqvOiOqWSt2Hq4eYQJJWig=;
        b=iEpeWJpiIGoA4LHJyBQhThS6RufG+bjbNw9BWuPkcNgOPu1ozN+wOk1H0Re1X7sgzv
         ePk9WA9xI38qTkTcJB9McCOnJsRg1i9osHi8cVJzpxiyZ8CQZfQ1h05EjY9m1DVqr8rb
         VBBFw9KB1HmPVQpVo8z3ilQMkygOlZpFMXLEM/rfqIHTHiC83/VEGOIEeI66aQsnfETP
         dFlbKvc2EC/fr9aSftJLqG0qHZ3sxAlxCwhD9rBjaOzeg1+gQ4f1FjlxQcpFPpVnf8J5
         H180ZtxO3xijqH6WsCVddgWE9Gg8yO5tq/KUUYd1313CU7M9TIuv1h9QDtmW3r0ZoCmC
         yF0Q==
X-Gm-Message-State: AOAM530kNLyKNZ64fHD7wyuramtBKRdiGDAZWQwe6x3WSCpIWDc0ZuHa
        Vw2I2Lz+ExZNbJQ4OYUa/rCAev66law=
X-Google-Smtp-Source: ABdhPJxHZPNB8NqNCftvHFI+86vU518X7k8FjlTZVxZDKu7WyKRINm3jqih5CE08dgIzlfw3uFZNZQ==
X-Received: by 2002:a5d:6d02:: with SMTP id e2mr13063390wrq.427.1633984225434;
        Mon, 11 Oct 2021 13:30:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm9094591wrg.3.2021.10.11.13.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 13:30:25 -0700 (PDT)
Message-Id: <bd72bd175da52a167c27bfba1310e050d9e33a50.1633984222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
References: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Oct 2021 20:30:16 +0000
Subject: [PATCH v4 2/8] reset: preserve skip-worktree bit in mixed reset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Change `update_index_from_diff` to set `skip-worktree` when applicable for
new index entries. When `git reset --mixed <tree-ish>` is run, entries in
the index with differences between the pre-reset HEAD and reset <tree-ish>
are identified and handled with `update_index_from_diff`. For each file, a
new cache entry in inserted into the index, created from the <tree-ish> side
of the reset (without changing the working tree). However, the newly-created
entry must have `skip-worktree` explicitly set in either of the following
scenarios:

1. the file is in the current index and has `skip-worktree` set
2. the file is not in the current index but is outside of a defined sparse
   checkout definition

Not setting the `skip-worktree` bit leads to likely-undesirable results for
a user. It causes `skip-worktree` settings to disappear on the
"diff"-containing files (but *only* the diff-containing files), leading to
those files now showing modifications in `git status`. For example, when
running `git reset --mixed` in a sparse checkout, some file entries outside
of sparse checkout could show up as deleted, despite the user never deleting
anything (and not wanting them on-disk anyway).

Additionally, add a test to `t7102` to ensure `skip-worktree` is preserved
in a basic `git reset --mixed` scenario and update a failure-documenting
test from 19a0acc (t1092: test interesting sparse-checkout scenarios,
2021-01-23) with new expected behavior.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c                          | 14 ++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh | 19 +++++--------------
 t/t7102-reset.sh                         | 17 +++++++++++++++++
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index d3695ce43c4..e441b6601b9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -25,6 +25,7 @@
 #include "cache-tree.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "dir.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -130,6 +131,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 	int intent_to_add = *(int *)data;
 
 	for (i = 0; i < q->nr; i++) {
+		int pos;
 		struct diff_filespec *one = q->queue[i]->one;
 		int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);
 		struct cache_entry *ce;
@@ -141,6 +143,18 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 
 		ce = make_cache_entry(&the_index, one->mode, &one->oid, one->path,
 				      0, 0);
+
+		/*
+		 * If the file 1) corresponds to an existing index entry with
+		 * skip-worktree set, or 2) does not exist in the index but is
+		 * outside the sparse checkout definition, add a skip-worktree bit
+		 * to the new index entry.
+		 */
+		pos = cache_name_pos(one->path, strlen(one->path));
+		if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
+		    (pos < 0 && !path_in_sparse_checkout(one->path, &the_index)))
+			ce->ce_flags |= CE_SKIP_WORKTREE;
+
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"),
 			    one->path);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 886e78715fe..889079f55b8 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -459,26 +459,17 @@ test_expect_failure 'blame with pathspec outside sparse definition' '
 	test_all_match git blame deep/deeper2/deepest/a
 '
 
-# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-# in this scenario, but it shouldn't.
-test_expect_failure 'checkout and reset (mixed)' '
+test_expect_success 'checkout and reset (mixed)' '
 	init_repos &&
 
 	test_all_match git checkout -b reset-test update-deep &&
 	test_all_match git reset deepest &&
-	test_all_match git reset update-folder1 &&
-	test_all_match git reset update-folder2
-'
-
-# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-# in this scenario, but it shouldn't.
-test_expect_success 'checkout and reset (mixed) [sparse]' '
-	init_repos &&
 
-	test_sparse_match git checkout -b reset-test update-deep &&
-	test_sparse_match git reset deepest &&
+	# Because skip-worktree is preserved, resetting to update-folder1
+	# will show worktree changes for full-checkout that are not present
+	# in sparse-checkout or sparse-index.
 	test_sparse_match git reset update-folder1 &&
-	test_sparse_match git reset update-folder2
+	run_on_sparse test_path_is_missing folder1
 '
 
 test_expect_success 'merge, cherry-pick, and rebase' '
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 601b2bf97f0..d05426062ec 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -472,6 +472,23 @@ test_expect_success '--mixed refreshes the index' '
 	test_cmp expect output
 '
 
+test_expect_success '--mixed preserves skip-worktree' '
+	echo 123 >>file2 &&
+	git add file2 &&
+	git update-index --skip-worktree file2 &&
+	git reset --mixed HEAD >output &&
+	test_must_be_empty output &&
+
+	cat >expect <<-\EOF &&
+	Unstaged changes after reset:
+	M	file2
+	EOF
+	git update-index --no-skip-worktree file2 &&
+	git add file2 &&
+	git reset --mixed HEAD >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'resetting specific path that is unmerged' '
 	git rm --cached file2 &&
 	F1=$(git rev-parse HEAD:file1) &&
-- 
gitgitgadget

