Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B213EC6379F
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjBWJPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjBWJPT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:15:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1A94C6EC
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t15so10174520wrz.7
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mYLqinIHFnY79uYRcuCVDkAngrQ5G3f1RW/KxtfJss=;
        b=fowJYt2YsKomSAu6qhwcDHrk9nTTteT0b8frIaxb+iVr1F60Ao+Fcv6iEvhdCPHNdv
         GDHz0tSXUv6JYCiBgvojuXDlv/XoYoLJbTf3374Ytnq8Kw+yuh8Gq3yTE9ntJohbJGBN
         iSepq1E7NuZCVsdsYnBhNiahkjeHgX6lMIJKkvCIgh/Zpm5l9uY3rRmm/tv/DBMiH4HM
         c6VN25QnyAidmoTBRVi44RdxCrxw6EKAezE+cbOlLE+zYC2HhCHif4dr7uKi5KJ7tJNq
         Ltehwc1HE7vq+pdLdBftNnfVgHQNap462v7xRY71hK6v8DQrlhz+8bZH059bo8RXv7zd
         kwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mYLqinIHFnY79uYRcuCVDkAngrQ5G3f1RW/KxtfJss=;
        b=WZ9X7ncg3yjyPrj5jXm9WpN2WYH6uCOHSvnOb8eoACbvyvtSSjeDGtUNoZKdVTB4Wo
         w90iO/q5N8Hl0lnh2mo883ny/y05+/kzXiZKsvlRoTs6Douw+9iIIs1QWgj2qXDft4T1
         VcltmYr08xw5KdMH7O/E/RYsO0hHVbzXmrY/gw3bVy5k/Vy8M7d1Thkm4jeA0WOEp+QV
         o/+UtXfiHM0u1K8zB8PKiqUAGKgb5PgfM6rb2w+agRWTsVe0M7+CyG/Vvi4ucI2cHSDU
         k747Qo0nXJ9NYyHj2VeopSQW/St9akR0RYB92kpCRcGOnjeE3QqO40zpQJH5z7yoiseY
         b33g==
X-Gm-Message-State: AO0yUKVYJNjs8OV701COIC0xJr8+9Nz00WiQkqhXcevsiLcELNtd71Ea
        CzEbuTriy25B+K9lpPiOnTGpgfQZy9Q=
X-Google-Smtp-Source: AK7set/Cs5zutEv6UuRgxSOeOjZGErYTrreo5yLIBFBkdFs8KELY68vNZ6pnWNc6tVw7DDvoFEm/qQ==
X-Received: by 2002:a5d:4b43:0:b0:2c7:604:52a1 with SMTP id w3-20020a5d4b43000000b002c7060452a1mr6634771wrs.29.1677143709129;
        Thu, 23 Feb 2023 01:15:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm10312867wrn.97.2023.02.23.01.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:15:08 -0800 (PST)
Message-Id: <a5048ea00b23938a681f35ceffcae08e722e4a54.1677143700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 09:14:59 +0000
Subject: [PATCH 10/11] unpack-trees: special case read-tree debugging as
 internal usage
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

builtin/read-tree.c has some special functionality explicitly designed
for debugging unpack-trees.[ch].  Associated with that is two fields
that no other external caller would or should use.  Mark these as
internal to unpack-trees, but allow builtin/read-tree to read or write
them for this special case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/read-tree.c | 10 +++++-----
 unpack-trees.c      | 22 +++++++++++-----------
 unpack-trees.h      |  6 +++---
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 3ce75417833..6034408d486 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -87,9 +87,9 @@ static int debug_merge(const struct cache_entry * const *stages,
 {
 	int i;
 
-	printf("* %d-way merge\n", o->merge_size);
+	printf("* %d-way merge\n", o->internal.merge_size);
 	debug_stage("index", stages[0], o);
-	for (i = 1; i <= o->merge_size; i++) {
+	for (i = 1; i <= o->internal.merge_size; i++) {
 		char buf[24];
 		xsnprintf(buf, sizeof(buf), "ent#%d", i);
 		debug_stage(buf, stages[i], o);
@@ -144,7 +144,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 		OPT__DRY_RUN(&opts.dry_run, N_("don't update the index or the work tree")),
 		OPT_BOOL(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
 			 N_("skip applying sparse checkout filter")),
-		OPT_BOOL(0, "debug-unpack", &opts.debug_unpack,
+		OPT_BOOL(0, "debug-unpack", &opts.internal.debug_unpack,
 			 N_("debug unpack-trees")),
 		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
@@ -247,7 +247,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			opts.head_idx = 1;
 	}
 
-	if (opts.debug_unpack)
+	if (opts.internal.debug_unpack)
 		opts.fn = debug_merge;
 
 	/* If we're going to prime_cache_tree later, skip cache tree update */
@@ -263,7 +263,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (unpack_trees(nr_trees, t, &opts))
 		return 128;
 
-	if (opts.debug_unpack || opts.dry_run)
+	if (opts.internal.debug_unpack || opts.dry_run)
 		return 0; /* do not write the index out */
 
 	/*
diff --git a/unpack-trees.c b/unpack-trees.c
index fa186a27ccc..60b6e38fd69 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -839,7 +839,7 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 		mark_ce_used(src[0], o);
 	}
 	free(tree_ce);
-	if (o->debug_unpack)
+	if (o->internal.debug_unpack)
 		printf("Unpacked %d entries from %s to %s using cache-tree\n",
 		       nr_entries,
 		       o->src_index->cache[pos]->name,
@@ -1488,7 +1488,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	while (!p->mode)
 		p++;
 
-	if (o->debug_unpack)
+	if (o->internal.debug_unpack)
 		debug_unpack_callback(n, mask, dirmask, names, info);
 
 	/* Are we supposed to look at the index too? */
@@ -1929,7 +1929,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			init_split_index(&o->internal.result);
 	}
 	oidcpy(&o->internal.result.oid, &o->src_index->oid);
-	o->merge_size = len;
+	o->internal.merge_size = len;
 	mark_all_ce_unused(o->src_index);
 
 	o->internal.result.fsmonitor_last_update =
@@ -2880,9 +2880,9 @@ int twoway_merge(const struct cache_entry * const *src,
 	const struct cache_entry *oldtree = src[1];
 	const struct cache_entry *newtree = src[2];
 
-	if (o->merge_size != 2)
+	if (o->internal.merge_size != 2)
 		return error("Cannot do a twoway merge of %d trees",
-			     o->merge_size);
+			     o->internal.merge_size);
 
 	if (oldtree == o->df_conflict_entry)
 		oldtree = NULL;
@@ -2962,9 +2962,9 @@ int bind_merge(const struct cache_entry * const *src,
 	const struct cache_entry *old = src[0];
 	const struct cache_entry *a = src[1];
 
-	if (o->merge_size != 1)
+	if (o->internal.merge_size != 1)
 		return error("Cannot do a bind merge of %d trees",
-			     o->merge_size);
+			     o->internal.merge_size);
 	if (a && old)
 		return o->quiet ? -1 :
 			error(ERRORMSG(o, ERROR_BIND_OVERLAP),
@@ -2988,9 +2988,9 @@ int oneway_merge(const struct cache_entry * const *src,
 	const struct cache_entry *old = src[0];
 	const struct cache_entry *a = src[1];
 
-	if (o->merge_size != 1)
+	if (o->internal.merge_size != 1)
 		return error("Cannot do a oneway merge of %d trees",
-			     o->merge_size);
+			     o->internal.merge_size);
 
 	if (!a || a == o->df_conflict_entry)
 		return deleted_entry(old, old, o);
@@ -3025,8 +3025,8 @@ int stash_worktree_untracked_merge(const struct cache_entry * const *src,
 	const struct cache_entry *worktree = src[1];
 	const struct cache_entry *untracked = src[2];
 
-	if (o->merge_size != 2)
-		BUG("invalid merge_size: %d", o->merge_size);
+	if (o->internal.merge_size != 2)
+		BUG("invalid merge_size: %d", o->internal.merge_size);
 
 	if (worktree && untracked)
 		return error(_("worktree and untracked commit have duplicate entries: %s"),
diff --git a/unpack-trees.h b/unpack-trees.h
index 0335c89bc75..e8737adfeda 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -65,7 +65,6 @@ struct unpack_trees_options {
 		     skip_unmerged,
 		     initial_checkout,
 		     diff_index_cached,
-		     debug_unpack,
 		     skip_sparse_checkout,
 		     quiet,
 		     exiting_early,
@@ -78,7 +77,6 @@ struct unpack_trees_options {
 	merge_fn_t fn;
 
 	int head_idx;
-	int merge_size;
 
 	struct cache_entry *df_conflict_entry;
 	void *unpack_data;
@@ -90,8 +88,10 @@ struct unpack_trees_options {
 
 	struct unpack_trees_options_internal {
 		unsigned int nontrivial_merge,
-			     show_all_errors;
+			     show_all_errors,
+			     debug_unpack; /* used by read-tree debugging */
 
+		int merge_size; /* used by read-tree debugging */
 		int cache_bottom;
 		const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
 		struct strvec msgs_to_free;
-- 
gitgitgadget

