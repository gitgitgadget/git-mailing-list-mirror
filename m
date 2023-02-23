Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF166C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjBWJP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbjBWJPK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:15:10 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6C548E2C
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id az11-20020a05600c600b00b003dc4fd6e61dso9351821wmb.5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zlfj0vbfKh4f3TIVx9h2XfDPBA9IxoqqKBFHsZHXlIs=;
        b=XVKAJnu3YsL+jVFvj1UkYEuZaNtZyCQLg8+V9fbeXolhscKBxaAtssEQ790gZLH9nL
         2oh7AaDloaLcSdbJ/R64sFegCJBkLhZlKwHLcSG/93pQJOSu50u7uUFgMtzT9/WHasnm
         WP7O9/zTl1iC2zP3LoQMQS/TNrpctownA9EkDm7E1T6bAcCyBIgIelY0voAssP0Dyxcp
         IArwa4In1uiqSCIaZ12vQLedjxqauAERa+FL2fyDu8j0+rdSnASPnAawvwZWaaE+fvTB
         Q1IvPnM/bDv1u/eY6c9pfgESRAS+8Cud7HH46tiTBqHAFiQnqzm3LqYP61x5LzW4yeIx
         RaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zlfj0vbfKh4f3TIVx9h2XfDPBA9IxoqqKBFHsZHXlIs=;
        b=Y5e5SnRwuDlOpxljY8cpXepVjMVHNeORKvFAqwTPEH65VqmZAUvYgXIvizAz0x41Xe
         X/PHRrqrn5zzDxkp30prQMZHx7/e8wycwoSlSj/hqgb6LYir04uDytf9YFAwY284rU4r
         Lc5VugEVpyLYSgKrVdU6N3GYsPWoGWeeZEx8PUE2I4od3Dgm3eLvCD0HFOpbdfcWmQpy
         6a0GALdf1dhxrcs2o6vqTAtbC9NYz7gYKlYEFgo47Yi2NNEtWKQLJwM27QDFELyjW0Mh
         wiuO3h4l3tGyuhF+3p3sGoSXbx6FsXwNkRxpKkqSiQAACsn6L9FQcTQELg+m9pkJg71V
         V4PQ==
X-Gm-Message-State: AO0yUKV9Tq+8OKBYsY0OIpfQ/lcOZMT4I0FA5I1wX0Pbmw8qhGbFmgTi
        Yccl9fK6cBV3ma5eYqz+XCJEhqnZjak=
X-Google-Smtp-Source: AK7set82k7jkkuIwVPtOMQiyJomIShqPkyMmd2Y855CkHqtpfj8KsUP5QcAtaV+xTTEPREG+sUfweQ==
X-Received: by 2002:a05:600c:4591:b0:3e0:481:c897 with SMTP id r17-20020a05600c459100b003e00481c897mr8744187wmo.37.1677143707057;
        Thu, 23 Feb 2023 01:15:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c231200b003e20fa01a86sm9883137wmo.13.2023.02.23.01.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:15:06 -0800 (PST)
Message-Id: <63ee57478edfd731d4f257777ef5aec4c7a02f63.1677143700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 09:14:56 +0000
Subject: [PATCH 07/11] unpack_trees: start splitting internal fields from
 public API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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
index d9c9f330233..e6b5fb980cb 100644
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
@@ -2116,14 +2116,14 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
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
@@ -2338,8 +2338,8 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
 
 	memset(&d, 0, sizeof(d));
-	if (o->dir)
-		d.exclude_per_dir = o->dir->exclude_per_dir;
+	if (o->internal.dir)
+		d.exclude_per_dir = o->internal.dir->exclude_per_dir;
 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	dir_clear(&d);
 	free(pathbuf);
@@ -2393,8 +2393,8 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
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

