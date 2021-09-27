Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E1C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE856103B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhI0Qfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbhI0Qfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CADEC061769
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:53 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g16so53029284wrb.3
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yIedRzplGiQDHiWuPxxWeYHFV27L00E6qb7aSf5eEeU=;
        b=cWFPhBldtdrsqiKBjMWkS2g+9z6jdGjKtabVI6bxjJ7+l0ow2gY04wFogLRxzPizlo
         uqfaTYMTi1LH21OPzW2hHNDmK15hccHaG/D3fhmm1giEx8oA4K7zQREmfSl85SG6pl5w
         QEpjE0KCkSPO0hjbJyPr5mM6EbceTYCa5nvVdrNd/p1Q6ziDVJTdlUvpqcVxmHUi3P2K
         g+Y1s5+10MJZMzhmaliF1z8oD6NQBKQY6n/Zg9pzG1GlRU6Dzbg+9G7OBeq6y1fdP1/U
         ojy0wzB7lobYt2AugKgfYNGZ5DarLFWzFSAkyaMsV/S+BEwN1jJFEpQOk5FvjBJcDxgV
         OkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yIedRzplGiQDHiWuPxxWeYHFV27L00E6qb7aSf5eEeU=;
        b=etlmc/JpfqUjYozAHQdKwY4gfAynVq74fOYDFbqNrRULuNIwL4oTjiYY2FqFRYRX9H
         KKJUx6qLOHzWj3JtBbWK9QMsjS4NbbS7TazvPvrxUOjf+IwWnSj3q5pQiVwgo7zsOZfg
         BOpnkzS00SsIMEy966wtDMuZd6HTQZy8KcZ8IU3p33xAD4IniD+6Cm7xR1weIRQbatpX
         KKx1NKI3gcQFHXdZsudxgEdRsg4eIEgJfpx1zWZl8UUXgHaXAnb0CwAYOq47frRkF5Ow
         8+NUHgHXHXb3Vkh6F6CTb8nUGzz62Z6T50QjFz+HaXBhFQSR1966w6ng3zM/h0FB0SlA
         WkMw==
X-Gm-Message-State: AOAM533og4DsIKqrCCvm/DaHg/JuHSulgMvAIRgsMfnl/PuZYSXjPslF
        R13VvYvNldOsn2ccfxIzh3OOaE8NQ4Y=
X-Google-Smtp-Source: ABdhPJwqevtRNkblQDyYKpT0iqP8PxamWrOHNMEZnxrXuOeZTtF776tEsZNhDdVwdkqnnMk+yhv6oQ==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr964892wrd.194.1632760431791;
        Mon, 27 Sep 2021 09:33:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y18sm16675089wrq.6.2021.09.27.09.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:51 -0700 (PDT)
Message-Id: <f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:41 +0000
Subject: [PATCH v3 04/11] unpack-trees: introduce preserve_ignored to
 unpack_trees_options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Currently, every caller of unpack_trees() that wants to ensure ignored
files are overwritten by default needs to:
   * allocate unpack_trees_options.dir
   * flip the DIR_SHOW_IGNORED flag in unpack_trees_options.dir->flags
   * call setup_standard_excludes
AND then after the call to unpack_trees() needs to
   * call dir_clear()
   * deallocate unpack_trees_options.dir
That's a fair amount of boilerplate, and every caller uses identical
code.  Make this easier by instead introducing a new boolean value where
the default value (0) does what we want so that new callers of
unpack_trees() automatically get the appropriate behavior.  And move all
the handling of unpack_trees_options.dir into unpack_trees() itself.

While preserve_ignored = 0 is the behavior we feel is the appropriate
default, we defer fixing commands to use the appropriate default until a
later commit.  So, this commit introduces several locations where we
manually set preserve_ignored=1.  This makes it clear where code paths
were previously preserving ignored files when they should not have been;
a future commit will flip these to instead use a value of 0 to get the
behavior we want.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c        |  3 +++
 builtin/checkout.c  | 11 ++---------
 builtin/clone.c     |  2 ++
 builtin/merge.c     |  2 ++
 builtin/read-tree.c | 13 +++----------
 builtin/reset.c     |  2 ++
 builtin/stash.c     |  3 +++
 merge-ort.c         |  8 +-------
 merge-recursive.c   |  8 +-------
 merge.c             |  8 +-------
 reset.c             |  2 ++
 sequencer.c         |  2 ++
 unpack-trees.c      | 10 ++++++++++
 unpack-trees.h      |  1 +
 14 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e4a0ff9cd7c..1ee70692bc3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1918,6 +1918,9 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	opts.update = 1;
 	opts.merge = 1;
 	opts.reset = reset;
+	if (!reset)
+		/* FIXME: Default should be to remove ignored files */
+		opts.preserve_ignored = 1;
 	opts.fn = twoway_merge;
 	init_tree_desc(&t[0], head->buffer, head->size);
 	init_tree_desc(&t[1], remote->buffer, remote->size);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5335435d616..5e7957dd068 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -648,6 +648,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.skip_unmerged = !worktree;
 	opts.reset = 1;
 	opts.merge = 1;
+	opts.preserve_ignored = 0;
 	opts.fn = oneway_merge;
 	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
@@ -746,11 +747,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				       new_branch_info->commit ?
 				       &new_branch_info->commit->object.oid :
 				       &new_branch_info->oid, NULL);
-		if (opts->overwrite_ignore) {
-			topts.dir = xcalloc(1, sizeof(*topts.dir));
-			topts.dir->flags |= DIR_SHOW_IGNORED;
-			setup_standard_excludes(topts.dir);
-		}
+		topts.preserve_ignored = !opts->overwrite_ignore;
 		tree = parse_tree_indirect(old_branch_info->commit ?
 					   &old_branch_info->commit->object.oid :
 					   the_hash_algo->empty_tree);
@@ -760,10 +757,6 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
-		if (topts.dir) {
-			dir_clear(topts.dir);
-			FREE_AND_NULL(topts.dir);
-		}
 		clear_unpack_trees_porcelain(&topts);
 		if (ret == -1) {
 			/*
diff --git a/builtin/clone.c b/builtin/clone.c
index ff1d3d447a3..be1c3840d62 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -687,6 +687,8 @@ static int checkout(int submodule_progress)
 	opts.update = 1;
 	opts.merge = 1;
 	opts.clone = 1;
+	/* FIXME: Default should be to remove ignored files */
+	opts.preserve_ignored = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
diff --git a/builtin/merge.c b/builtin/merge.c
index 3fbdacc7db4..1e5fff095fc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -680,6 +680,8 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	opts.verbose_update = 1;
 	opts.trivial_merges_only = 1;
 	opts.merge = 1;
+	/* FIXME: Default should be to remove ignored files */
+	opts.preserve_ignored = 1;
 	trees[nr_trees] = parse_tree_indirect(common);
 	if (!trees[nr_trees++])
 		return -1;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 73cb957a69b..443d206eca6 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -201,11 +201,9 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if ((opts.update || opts.index_only) && !opts.merge)
 		die("%s is meaningless without -m, --reset, or --prefix",
 		    opts.update ? "-u" : "-i");
-	if (opts.update && !opts.reset) {
-		CALLOC_ARRAY(opts.dir, 1);
-		opts.dir->flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(opts.dir);
-	}
+	if (opts.update && !opts.reset)
+		opts.preserve_ignored = 0;
+	/* otherwise, opts.preserve_ignored is irrelevant */
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
 
@@ -245,11 +243,6 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (unpack_trees(nr_trees, t, &opts))
 		return 128;
 
-	if (opts.dir) {
-		dir_clear(opts.dir);
-		FREE_AND_NULL(opts.dir);
-	}
-
 	if (opts.debug_unpack || opts.dry_run)
 		return 0; /* do not write the index out */
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 51c9e2f43ff..7f38656f018 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -67,6 +67,8 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	case KEEP:
 	case MERGE:
 		opts.update = 1;
+		/* FIXME: Default should be to remove ignored files */
+		opts.preserve_ignored = 1;
 		break;
 	case HARD:
 		opts.update = 1;
diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca91..88287b890d5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -258,6 +258,9 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.merge = 1;
 	opts.reset = reset;
 	opts.update = update;
+	if (update && !reset)
+		/* FIXME: Default should be to remove ignored files */
+		opts.preserve_ignored = 1;
 	opts.fn = oneway_merge;
 
 	if (unpack_trees(nr_trees, t, &opts))
diff --git a/merge-ort.c b/merge-ort.c
index 35aa979c3a4..0d64ec716bd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4045,11 +4045,7 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.quiet = 0; /* FIXME: sequencer might want quiet? */
 	unpack_opts.verbose_update = (opt->verbosity > 2);
 	unpack_opts.fn = twoway_merge;
-	if (1/* FIXME: opts->overwrite_ignore*/) {
-		CALLOC_ARRAY(unpack_opts.dir, 1);
-		unpack_opts.dir->flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(unpack_opts.dir);
-	}
+	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore*/
 	parse_tree(prev);
 	init_tree_desc(&trees[0], prev->buffer, prev->size);
 	parse_tree(next);
@@ -4057,8 +4053,6 @@ static int checkout(struct merge_options *opt,
 
 	ret = unpack_trees(2, trees, &unpack_opts);
 	clear_unpack_trees_porcelain(&unpack_opts);
-	dir_clear(unpack_opts.dir);
-	FREE_AND_NULL(unpack_opts.dir);
 	return ret;
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 233d9f686ad..2be3f5d4044 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -411,9 +411,7 @@ static int unpack_trees_start(struct merge_options *opt,
 	else {
 		opt->priv->unpack_opts.update = 1;
 		/* FIXME: should only do this if !overwrite_ignore */
-		CALLOC_ARRAY(opt->priv->unpack_opts.dir, 1);
-		opt->priv->unpack_opts.dir->flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(opt->priv->unpack_opts.dir);
+		opt->priv->unpack_opts.preserve_ignored = 0;
 	}
 	opt->priv->unpack_opts.merge = 1;
 	opt->priv->unpack_opts.head_idx = 2;
@@ -428,10 +426,6 @@ static int unpack_trees_start(struct merge_options *opt,
 	init_tree_desc_from_tree(t+2, merge);
 
 	rc = unpack_trees(3, t, &opt->priv->unpack_opts);
-	if (opt->priv->unpack_opts.dir) {
-		dir_clear(opt->priv->unpack_opts.dir);
-		FREE_AND_NULL(opt->priv->unpack_opts.dir);
-	}
 	cache_tree_free(&opt->repo->index->cache_tree);
 
 	/*
diff --git a/merge.c b/merge.c
index 6e736881d90..2382ff66d35 100644
--- a/merge.c
+++ b/merge.c
@@ -53,7 +53,6 @@ int checkout_fast_forward(struct repository *r,
 	struct unpack_trees_options opts;
 	struct tree_desc t[MAX_UNPACK_TREES];
 	int i, nr_trees = 0;
-	struct dir_struct dir = DIR_INIT;
 	struct lock_file lock_file = LOCK_INIT;
 
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
@@ -80,11 +79,7 @@ int checkout_fast_forward(struct repository *r,
 	}
 
 	memset(&opts, 0, sizeof(opts));
-	if (overwrite_ignore) {
-		dir.flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(&dir);
-		opts.dir = &dir;
-	}
+	opts.preserve_ignored = !overwrite_ignore;
 
 	opts.head_idx = 1;
 	opts.src_index = r->index;
@@ -101,7 +96,6 @@ int checkout_fast_forward(struct repository *r,
 		clear_unpack_trees_porcelain(&opts);
 		return -1;
 	}
-	dir_clear(&dir);
 	clear_unpack_trees_porcelain(&opts);
 
 	if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
diff --git a/reset.c b/reset.c
index 79310ae071b..41b3e2d88de 100644
--- a/reset.c
+++ b/reset.c
@@ -56,6 +56,8 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
+	/* FIXME: Default should be to remove ignored files */
+	unpack_tree_opts.preserve_ignored = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
 	if (!detach_head)
 		unpack_tree_opts.reset = 1;
diff --git a/sequencer.c b/sequencer.c
index 614d56f5e21..098566c68d9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3699,6 +3699,8 @@ static int do_reset(struct repository *r,
 	unpack_tree_opts.fn = oneway_merge;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.update = 1;
+	/* FIXME: Default should be to remove ignored files */
+	unpack_tree_opts.preserve_ignored = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
 
 	if (repo_read_index_unmerged(r)) {
diff --git a/unpack-trees.c b/unpack-trees.c
index 8ea0a542da8..1e4eae1dc7d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1707,6 +1707,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		ensure_full_index(o->dst_index);
 	}
 
+	if (!o->preserve_ignored) {
+		CALLOC_ARRAY(o->dir, 1);
+		o->dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(o->dir);
+	}
+
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
@@ -1868,6 +1874,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 done:
 	if (free_pattern_list)
 		clear_pattern_list(&pl);
+	if (o->dir) {
+		dir_clear(o->dir);
+		FREE_AND_NULL(o->dir);
+	}
 	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
 	trace_performance_leave("unpack_trees");
 	return ret;
diff --git a/unpack-trees.h b/unpack-trees.h
index 2d88b19dca7..f98cfd49d7b 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -49,6 +49,7 @@ struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
 		     update,
+		     preserve_ignored,
 		     clone,
 		     index_only,
 		     nontrivial_merge,
-- 
gitgitgadget

