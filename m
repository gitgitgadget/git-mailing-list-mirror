Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C1BC7EE2D
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 02:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBYC0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 21:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBYC0L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF1C19F2D
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so652281wmi.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmJLU3lLloiRIzTrFiKr51ibGPmYDkjTwvTmssOhyXM=;
        b=BgrDaUyeZaT3LPvivgbggaW/tJJA0W11x2MM+s6JPF08xh12/XPMq1ntu+wEt6Ub37
         BLz9V5l4IrisI6K8+EgznZ7mPEzbBdzCLGQSBoWTCaUvv0fDC6BWhp6H+LHTB1/LQKRR
         bOLueP+K8DvTZaq2TlgnULL7HXyNjGWdKZD3flaFkyeWDFfOe5EvFKnRpDIe8l/fY9fF
         5GkBZIAKp/8i30J6Pt+Z9/hX7UAnHqFUEeR85fCRYpIoDWq3/5ONjnFwl7TmPxk4paug
         yTGdacslMwR4GUSBp01K+ac8Fwyf0RSJcX7DUFyrJjbTzu1tldJ60S0IbNsra/9x7jgH
         RAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmJLU3lLloiRIzTrFiKr51ibGPmYDkjTwvTmssOhyXM=;
        b=iispAPeGaVrFERRxzgpaukuGk86JGfsxK4PJgo6AQiW8xovj+36NRZ8mESC77ZIU7r
         TgcMuj3ACB56knmF4X8UHM4F6yv6NeZEM/8XkSmloaGgZXugh5C8ruZo+C+mgOmgtArV
         7g6FkpBqFSpA/vZUu0cvkjXp8EQF5Fm+u9fGRNs7Z2uKZFynWk7yEeFur3VeDsYpHhCv
         66CZws11nfk6VZJWs3sp7C80gIEtga/8UQMjgsbh5NzsnDTu9OtQqqXWa7hdyoCqIpms
         eec9xWVL+C3dP2itGHNxLbOyfVWDTn0nH8RSjRuecALOYYi8WmT6mKxy7mobJFzj7jme
         MLmg==
X-Gm-Message-State: AO0yUKURDs1khMk1NCm9wvoUlof3JcuumLw07DFxb8OLExBo2zf2eyW6
        gfQXkTb3rI7CVse/VrclcBwxHYBFLHI=
X-Google-Smtp-Source: AK7set/vOSBDMA02EhnNeMEsAY3U81sPFS9NCzx0+z0qQzKlCWEd5ApHzLA263/x2OyI0y2dWzoM8A==
X-Received: by 2002:a05:600c:3420:b0:3e2:c67:1c7f with SMTP id y32-20020a05600c342000b003e20c671c7fmr13642025wmp.10.1677291968449;
        Fri, 24 Feb 2023 18:26:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b003eb192787bfsm958712wmq.25.2023.02.24.18.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:26:08 -0800 (PST)
Message-Id: <993da584dbb92b682e86d5ce63451c8203eeecd7.1677291961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 02:25:56 +0000
Subject: [PATCH v2 07/11] unpack_trees: start splitting internal fields from
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
 unpack-trees.c | 42 +++++++++++++++++++++---------------------
 unpack-trees.h |  7 +++++--
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4fca051cbea..c659af67c62 100644
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
@@ -2340,8 +2340,8 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
 
 	memset(&d, 0, sizeof(d));
-	if (o->dir)
-		d.exclude_per_dir = o->dir->exclude_per_dir;
+	if (o->internal.dir)
+		d.exclude_per_dir = o->internal.dir->exclude_per_dir;
 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	dir_clear(&d);
 	free(pathbuf);
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

