Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2EFC64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjB0P3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjB0P2j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:28:39 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B455AA27B
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:30 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so3571065wmq.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uh/1PkSv5KAh5i7b2pA+MpoAmuWSfVgixYFdtLJ0dUU=;
        b=U9vl49xFUXkJ4Wpb6x3Wg5bOZr6btuWQ4y0An+Y6JsKVxWD7D9jVv1q+zlmTC69UyX
         xnp3GvZilzvAXz6gQ5mEC6PzxVHNvDuGV2NFc2lchHZIoLoM98q3VHyAP2dK/m91Fels
         WfCChNrK+mYlR1FVbFCMfr3Yf/FRwjcftPEnSUPV1WtvM5JXhBFIm1GOoRjQaOJHMQAG
         VrEfRg2NsotWVdlzRDmNK7s5nu5rL5+0LGUy7bx81qVTq3qJhKOmrnY2K3VGtq+cY6Pq
         Kx6OEH28pBXc0t0aMjE5d/x0fDqwe/Hc/jvsUdKHGytE2wGM1FP4p/wDAm/PUAEpva/r
         SHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uh/1PkSv5KAh5i7b2pA+MpoAmuWSfVgixYFdtLJ0dUU=;
        b=4WWpgUSXC1e/MJCxdRiIPZbbb2qSENZTzzI6rjnZAjBVpawz59qKIYFFpS4rxmr/pg
         BEc77Qbu5ar/tSs6DZCQ6vaLLrr1OjsaIk6XyKSlNfTfxB4Mmb4LpLadiQHANqL/uTy7
         4reGrUpELc5D3zZN0rlGCxAJWAcMnXHmY5ODbqF4BUOuXmRIaTuJ033wESXdW0YNb+wT
         93VcWce/CPSGMa2uRLbqfhRvFlzH6rd31nRhJffd1hLl4nOZ85cJyJsmauYrOmgF2Myr
         RfOiBv/5mLeAHMLZMjoGemn76En1ZMk3Y26SY4q1SSvgK4N8liaOHicjha0zAEqcvUoD
         sH1w==
X-Gm-Message-State: AO0yUKUAyJKyV2w3iCLchc9O2732AmWoBv0JbD/Z8ShilfuszZ9ZmHN+
        r9p4DKhtzIDYh52e51H2DOPmy9riQ6w=
X-Google-Smtp-Source: AK7set/CwFL7DAJWPCtW7S7r52rSfKhTRrDpaK9+RnQLEYM0/wdWdSPr/bCGAW70issaINYD16OffQ==
X-Received: by 2002:a05:600c:3416:b0:3eb:3cc9:9f85 with SMTP id y22-20020a05600c341600b003eb3cc99f85mr4466438wmp.26.1677511708837;
        Mon, 27 Feb 2023 07:28:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020a1ced01000000b003ea57808179sm12744613wmh.38.2023.02.27.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:28:28 -0800 (PST)
Message-Id: <27f2d4771166348f5dd73bdccb4eeba5b16a7416.1677511700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
        <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 15:28:16 +0000
Subject: [PATCH v3 09/13] unpack_trees: start splitting internal fields from
 public API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This just splits the two fields already marked as internal-only into a
separate internal struct.  Future commits will add more fields that
were meant to be internal-only but were not explicitly marked as such
to the same struct.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 40 ++++++++++++++++++++--------------------
 unpack-trees.h |  7 +++++--
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index c8dacd76c5f..ecf89d5bfeb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1809,7 +1809,7 @@ static void populate_from_existing_patterns(struct unpack_trees_options *o,
 	if (get_sparse_checkout_patterns(pl) < 0)
 		o->skip_sparse_checkout = 1;
 	else
-		o->pl = pl;
+		o->internal.pl = pl;
 }
 
 static void update_sparsity_for_prefix(const char *prefix,
@@ -1871,10 +1871,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
-	if (o->dir)
-		BUG("o->dir is for internal use only");
-	if (o->pl)
-		BUG("o->pl is for internal use only");
+	if (o->internal.dir)
+		BUG("o->internal.dir is for internal use only");
+	if (o->internal.pl)
+		BUG("o->internal.pl is for internal use only");
 
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
@@ -1891,9 +1891,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		BUG("UNPACK_RESET_OVERWRITE_UNTRACKED incompatible with preserved ignored files");
 
 	if (!o->preserve_ignored) {
-		o->dir = &dir;
-		o->dir->flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(o->dir);
+		o->internal.dir = &dir;
+		o->internal.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(o->internal.dir);
 	}
 
 	if (o->prefix)
@@ -1943,7 +1943,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
 	if (!o->skip_sparse_checkout)
-		mark_new_skip_worktree(o->pl, o->src_index, 0,
+		mark_new_skip_worktree(o->internal.pl, o->src_index, 0,
 				       CE_NEW_SKIP_WORKTREE, o->verbose_update);
 
 	if (!dfc)
@@ -2009,7 +2009,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		 * If they will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
 		 * so apply_sparse_checkout() won't attempt to remove it from worktree
 		 */
-		mark_new_skip_worktree(o->pl, &o->result,
+		mark_new_skip_worktree(o->internal.pl, &o->result,
 				       CE_ADDED, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE,
 				       o->verbose_update);
 
@@ -2067,9 +2067,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 done:
 	if (free_pattern_list)
 		clear_pattern_list(&pl);
-	if (o->dir) {
-		dir_clear(o->dir);
-		o->dir = NULL;
+	if (o->internal.dir) {
+		dir_clear(o->internal.dir);
+		o->internal.dir = NULL;
 	}
 	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
 	trace_performance_leave("unpack_trees");
@@ -2117,14 +2117,14 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
 		pl = xcalloc(1, sizeof(*pl));
 		populate_from_existing_patterns(o, pl);
 	}
-	o->pl = pl;
+	o->internal.pl = pl;
 
 	/* Expand sparse directories as needed */
-	expand_index(o->src_index, o->pl);
+	expand_index(o->src_index, o->internal.pl);
 
 	/* Set NEW_SKIP_WORKTREE on existing entries. */
 	mark_all_ce_unused(o->src_index);
-	mark_new_skip_worktree(o->pl, o->src_index, 0,
+	mark_new_skip_worktree(o->internal.pl, o->src_index, 0,
 			       CE_NEW_SKIP_WORKTREE, o->verbose_update);
 
 	/* Then loop over entries and update/remove as needed */
@@ -2152,7 +2152,7 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
 	if (free_pattern_list) {
 		clear_pattern_list(pl);
 		free(pl);
-		o->pl = NULL;
+		o->internal.pl = NULL;
 	}
 	trace_performance_leave("update_sparsity");
 	return ret;
@@ -2340,7 +2340,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
 
 	memset(&d, 0, sizeof(d));
-	if (o->dir)
+	if (o->internal.dir)
 		setup_standard_excludes(&d);
 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	dir_clear(&d);
@@ -2395,8 +2395,8 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	if (ignore_case && icase_exists(o, name, len, st))
 		return 0;
 
-	if (o->dir &&
-	    is_excluded(o->dir, o->src_index, name, &dtype))
+	if (o->internal.dir &&
+	    is_excluded(o->internal.dir, o->src_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
diff --git a/unpack-trees.h b/unpack-trees.h
index f3a6e4f90ef..5c1a9314a06 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -97,9 +97,12 @@ struct unpack_trees_options {
 	struct index_state *src_index;
 	struct index_state result;
 
-	struct pattern_list *pl; /* for internal use */
-	struct dir_struct *dir; /* for internal use only */
 	struct checkout_metadata meta;
+
+	struct unpack_trees_options_internal {
+		struct pattern_list *pl;
+		struct dir_struct *dir;
+	} internal;
 };
 
 int unpack_trees(unsigned n, struct tree_desc *t,
-- 
gitgitgadget

