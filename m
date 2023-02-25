Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF4C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 02:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjBYC0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 21:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBYC01 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BFE68693
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bt28so1040572wrb.8
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as+x1b3MsWKauOgDqZQuTNqTJkOTVUMhmysHQsKXQOA=;
        b=mmsx8sLMEQUtEMcpDemwpWLzJRuydP/wpliwxOg5NQD8FxvVugbTdLtbfBM2uaHYPB
         XCNPa04RZmcpCK9yUdRTkWJSuFNmKvZ7cvPZ1WTwKAAVFjQuLuJrKPDBHsSeImN7ZDgs
         m2Fzw9DZOSbBR3/m/HqcpjOzojzfsl7IZczJk9yBSs3iVR1yWIk4KF15FvAAFcB3ewMb
         SNcZ4h1ItZjJniXcNPkf+dr1j7NRBehqVKBCkO2DDWVeP1XiGclrt5xUIxj8o3tsN2gV
         IcuIj8Fo2JJpQqVBCQlZJDh6n2L7sc1mwQKOePhV7nZsR7MGMNqnoo+5Mxw+N57L/ZT4
         q6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=as+x1b3MsWKauOgDqZQuTNqTJkOTVUMhmysHQsKXQOA=;
        b=PL5l5QxJV7N8QuEx0e/JE9zYe+jgAiAhBX9mLMyWuFaSyU0mweRPOqbI8oPYztGsTd
         gXhQ/TKyfY4XJ8dQsMtUt0x+qH/ChDA6P5EYyX15ngS8jTvpMaHnGx7nNUha4wvdRTCY
         IHWdcn6f/0V+97S5w8EcJ1BfKhb/3QE6QRjfTKMxjwS/ZoyLUip+Qf8hSD7/sPbK+4Kd
         mPSrLHz6XDw2mnV7uR+dDPUzoXpwyHK+6DGAfbxQk0uWX6OchGfOc3Z2RdH+yNXDuse9
         XqcR7/kPCb+7fMOmyR931j5jf102/vlR0xquruSu4PPslrPC76GOqnLmGIapMSHTfcEg
         lO2g==
X-Gm-Message-State: AO0yUKUIT/bZoVVHcl2bPLiMheGfD8adWQaDyZXeEe0o66Nte7sZzKvO
        SzPGzF3ewHGm/T19VtavlFmiYp3GUmU=
X-Google-Smtp-Source: AK7set+7/Acb0EGGGnABNw5b1cfNTS0bXcU/tgKwyXEeT/S9audLdux8kkUcp0BNmFZpWq/IyPzC6Q==
X-Received: by 2002:a05:6000:108a:b0:2c5:9fb3:ec0a with SMTP id y10-20020a056000108a00b002c59fb3ec0amr17050471wrw.34.1677291970755;
        Fri, 24 Feb 2023 18:26:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y18-20020adffa52000000b002c55efa9cbesm397266wrr.39.2023.02.24.18.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:26:10 -0800 (PST)
Message-Id: <5af04d7fe2334d426dc0ba59f74ce2b082436773.1677291961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 02:25:59 +0000
Subject: [PATCH v2 10/11] unpack-trees: special case read-tree debugging as
 internal usage
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
index 985896d6af6..e58f0f6a867 100644
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
@@ -2882,9 +2882,9 @@ int twoway_merge(const struct cache_entry * const *src,
 	const struct cache_entry *oldtree = src[1];
 	const struct cache_entry *newtree = src[2];
 
-	if (o->merge_size != 2)
+	if (o->internal.merge_size != 2)
 		return error("Cannot do a twoway merge of %d trees",
-			     o->merge_size);
+			     o->internal.merge_size);
 
 	if (oldtree == o->df_conflict_entry)
 		oldtree = NULL;
@@ -2964,9 +2964,9 @@ int bind_merge(const struct cache_entry * const *src,
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
@@ -2990,9 +2990,9 @@ int oneway_merge(const struct cache_entry * const *src,
 	const struct cache_entry *old = src[0];
 	const struct cache_entry *a = src[1];
 
-	if (o->merge_size != 1)
+	if (o->internal.merge_size != 1)
 		return error("Cannot do a oneway merge of %d trees",
-			     o->merge_size);
+			     o->internal.merge_size);
 
 	if (!a || a == o->df_conflict_entry)
 		return deleted_entry(old, old, o);
@@ -3027,8 +3027,8 @@ int stash_worktree_untracked_merge(const struct cache_entry * const *src,
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

