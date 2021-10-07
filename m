Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB51C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4726113E
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhJGJsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhJGJsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 05:48:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD2AC061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 02:46:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t2so17151645wrb.8
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3Nmj27q9/iyW2WRHYnSBkQuQ6y+/kLuszybmuDO04c=;
        b=MGEaT+ceJaVpL7DKOQB80NUl9QWrGYwqVj/AUAhQ5ZgzVxhP90tYE/ycE7U1JtZ0uH
         8s+kQ24b2t6Kz3MFPLMDHnLagXc/UCjzKxXeAhRiYCAEsrYi1T/smIB6Ytuw1cdAdM5D
         t6P2QS8cZ8obCurwqbSEwmDgeBVJxespmv3CBi8cQG7ZPOK7HhluGz7L1FO2ZjqlUqKE
         zZ0pyr2u9XzpMFXCOTcmzRHKEhxBu+ILmYn99bBSOQ/TuJXMfmaxJuTke/+1ZJ0HDrLa
         Oi9bOQJruSixJmXseOd9cpKnYUMSe4OhNV5uu7H+m91TnHdXOkONz3zaNyv5iXyzzLe7
         kzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3Nmj27q9/iyW2WRHYnSBkQuQ6y+/kLuszybmuDO04c=;
        b=evJBSQdpo3SagynliZcs8nHROxJ4O8tXbZ1STHPnymTbkU1P5M4D6EqET/zfYZ/GjV
         OYsirWQBhPkn6LeaXMn4BjyhWiQCVHGOO4COwYFH151AkT88HOFNmmo9ibH7RRtPHN7L
         oLDO9muq97MCSRrHS+yxTjD0NttOilXFW5Re/EHEj9FsCmNboYdeZOh47VFJWXsNZlap
         qaIK9IEdIAsS3R4j3kQUIg1vmF8nRdqPQdimC0pQeftD2oGlJoxZa/iBC4zeFAC1TlR9
         ElVonA3Pl9WbJzfdS1gmrEjlVsmQlIyx7iWLPXFKTVtZ7Nbxf3lTjyqhMTvEifT6T3o0
         Kwfg==
X-Gm-Message-State: AOAM531aEc6FReN+28M0Yj8h6EXs8GyQUzobPzrInWOOzDUmbvdiTTY8
        9SqSd2tHyT4fVVf6xeZ69TYWvdGD23wGyw==
X-Google-Smtp-Source: ABdhPJxVWqkOE53TOM2Xobv10jTt+ugGGzg4OADxcbu0Gq2Nmwc/RR43TrYrHAlq1aVzGcox74qIgg==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr3693725wmc.117.1633599973713;
        Thu, 07 Oct 2021 02:46:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l13sm7720489wme.38.2021.10.07.02.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 02:46:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] unpack-trees: memory-leak fixes
Date:   Thu,  7 Oct 2021 11:46:08 +0200
Message-Id: <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches fix a couple of stray memory leaks in unpack-trees.c.

This goes on top of ab/sanitize-leak-ci (but not
en/removing-untracked-fixes, although they combine to fix more leaks
in the area).

Changes since v1[1]:

In rebasing v1 from some earlier patches I came up with something that
didn't make sense with related fixes in Elijah's
en/removing-untracked-fixes. This hopefully makes sense:

 * The old 3/3 is gone, but there's a new 2-3/3 which fix the only
   actual leak that was left, i.e. the one in sequencer.c.

 * We might want something like the 3/3 from v1 of this series where
   we call clear_unpack_trees_porcelain() everywhere (and rename it to
   unpack_trees_options_release()) just for good measure and in case
   we'd ever add something to the struct that needs unconditional
   freeing.

   But let's punt on that here and just keep the current
   setup_unpack_trees_porcelain()/clear_unpack_trees_porcelain()
   behavior, callers who don't use setup_unpack_trees_porcelain() but
   use "struct unpack_trees_options" don't need to call any free-like
   function at the end.

1. https://lore.kernel.org/git/cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  unpack-trees: don't leak memory in verify_clean_subdirectory()
  sequencer: add a "goto cleanup" to do_reset()
  sequencer: fix a memory leak in do_reset()

 sequencer.c                 | 36 +++++++++++++++---------------------
 t/t1001-read-tree-m-2way.sh |  2 ++
 unpack-trees.c              |  3 ++-
 3 files changed, 19 insertions(+), 22 deletions(-)

Range-diff against v1:
1:  e5ef1be2aa9 = 1:  e5ef1be2aa9 unpack-trees: don't leak memory in verify_clean_subdirectory()
2:  21f9da06b46 ! 2:  1d5f5e9fff0 built-ins & lib: plug memory leaks with unpack_trees_options_release()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    built-ins & lib: plug memory leaks with unpack_trees_options_release()
    +    sequencer: add a "goto cleanup" to do_reset()
     
    -    Plug memory leaks in various built-ins and the "diff-lib.c" and
    -    "sequencer.c" libraries that were missing
    -    unpack_trees_options_release() calls.
    +    Restructure code that's mostly added in 9055e401dd6 (sequencer:
    +    introduce new commands to reset the revision, 2018-04-25) to avoid
    +    code duplication, and to make freeing other resources easier in a
    +    subsequent commit.
     
    -    In the case of "git archive" we'll need to memset() the "struct
    -    unpack_trees_options" first, to avoid having to call
    -    clear_unpack_trees_porcelain() twice within the
    -    "!args->worktree_attributes" branch.
    +    It's safe to initialize "tree_desc" to be zero'd out in order to
    +    unconditionally free desc.buffer, it won't be initialized on the first
    +    couple of "goto"'s.
    +
    +    There are three earlier "return"'s in this function that I'm not
    +    bothering to covert, those don't need to rollback anything, or free
    +    any resources, so let's leave, even though they could safely "goto
    +    cleanup" as well.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## archive.c ##
    -@@ archive.c: int write_archive_entries(struct archiver_args *args,
    - 	/*
    - 	 * Setup index and instruct attr to read index only
    - 	 */
    -+	memset(&opts, 0, sizeof(opts));
    - 	if (!args->worktree_attributes) {
    --		memset(&opts, 0, sizeof(opts));
    - 		opts.index_only = 1;
    - 		opts.head_idx = -1;
    - 		opts.src_index = args->repo->index;
    - 		opts.dst_index = args->repo->index;
    - 		opts.fn = oneway_merge;
    - 		init_tree_desc(&t, args->tree->buffer, args->tree->size);
    --		if (unpack_trees(1, &t, &opts))
    + ## sequencer.c ##
    +@@ sequencer.c: static int do_reset(struct repository *r,
    + 	struct strbuf ref_name = STRBUF_INIT;
    + 	struct object_id oid;
    + 	struct lock_file lock = LOCK_INIT;
    +-	struct tree_desc desc;
    ++	struct tree_desc desc = { 0 };
    + 	struct tree *tree;
    + 	struct unpack_trees_options unpack_tree_opts;
    + 	int ret = 0;
    +@@ sequencer.c: static int do_reset(struct repository *r,
    + 		strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
    + 		if (get_oid(ref_name.buf, &oid) &&
    + 		    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
    +-			error(_("could not read '%s'"), ref_name.buf);
    +-			rollback_lock_file(&lock);
    +-			strbuf_release(&ref_name);
     -			return -1;
    -+		if (unpack_trees(1, &t, &opts)) {
    -+			err = -1;
    ++			ret = error(_("could not read '%s'"), ref_name.buf);
     +			goto cleanup;
    -+		}
    - 		git_attr_set_direction(GIT_ATTR_INDEX);
    + 		}
      	}
      
    -@@ archive.c: int write_archive_entries(struct archiver_args *args,
    - 		if (err)
    - 			break;
    - 	}
    -+
    -+cleanup:
    - 	strbuf_release(&path_in_archive);
    - 	strbuf_release(&content);
    -+	clear_unpack_trees_porcelain(&opts);
    - 
    - 	return err;
    - }
    -
    - ## builtin/am.c ##
    -@@ builtin/am.c: static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
    - 	struct lock_file lock_file = LOCK_INIT;
    - 	struct unpack_trees_options opts;
    - 	struct tree_desc t[2];
    -+	int ret = 0;
    - 
    - 	if (parse_tree(head) || parse_tree(remote))
    - 		return -1;
    -@@ builtin/am.c: static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
    +@@ sequencer.c: static int do_reset(struct repository *r,
    + 	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
      
    - 	if (unpack_trees(2, t, &opts)) {
    - 		rollback_lock_file(&lock_file);
    --		return -1;
    -+		ret = -1;
    + 	if (repo_read_index_unmerged(r)) {
    +-		rollback_lock_file(&lock);
    +-		strbuf_release(&ref_name);
    +-		return error_resolve_conflict(_(action_name(opts)));
    ++		ret = error_resolve_conflict(_(action_name(opts)));
     +		goto cleanup;
      	}
      
    - 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
    - 		die(_("unable to write new index file"));
    --
    --	return 0;
    -+cleanup:
    -+	clear_unpack_trees_porcelain(&opts);
    -+	return ret;
    - }
    - 
    - /**
    -@@ builtin/am.c: static int merge_tree(struct tree *tree)
    - 	struct lock_file lock_file = LOCK_INIT;
    - 	struct unpack_trees_options opts;
    - 	struct tree_desc t[1];
    -+	int ret = 0;
    - 
    - 	if (parse_tree(tree))
    - 		return -1;
    -@@ builtin/am.c: static int merge_tree(struct tree *tree)
    - 
    - 	if (unpack_trees(1, t, &opts)) {
    - 		rollback_lock_file(&lock_file);
    + 	if (!fill_tree_descriptor(r, &desc, &oid)) {
    +-		error(_("failed to find tree of %s"), oid_to_hex(&oid));
    +-		rollback_lock_file(&lock);
    +-		free((void *)desc.buffer);
    +-		strbuf_release(&ref_name);
     -		return -1;
    -+		ret = -1;
    ++		ret = error(_("failed to find tree of %s"), oid_to_hex(&oid));
     +		goto cleanup;
      	}
      
    - 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
    - 		die(_("unable to write new index file"));
    - 
    --	return 0;
    -+cleanup:
    -+	clear_unpack_trees_porcelain(&opts);
    -+	return ret;
    - }
    - 
    - /**
    -
    - ## builtin/checkout.c ##
    -@@ builtin/checkout.c: static int reset_tree(struct tree *tree, const struct checkout_opts *o,
    - {
    - 	struct unpack_trees_options opts;
    - 	struct tree_desc tree_desc;
    -+	int ret;
    - 
    - 	memset(&opts, 0, sizeof(opts));
    - 	opts.head_idx = -1;
    -@@ builtin/checkout.c: static int reset_tree(struct tree *tree, const struct checkout_opts *o,
    - 		 */
    - 		/* fallthrough */
    - 	case 0:
    --		return 0;
    -+		ret = 0;
    -+		break;
    - 	default:
    --		return 128;
    -+		ret = 128;
    - 	}
    -+
    -+	clear_unpack_trees_porcelain(&opts);
    -+	return ret;
    - }
    - 
    - static void setup_branch_path(struct branch_info *branch)
    -
    - ## builtin/clone.c ##
    -@@ builtin/clone.c: static int checkout(int submodule_progress)
    - 	init_tree_desc(&t, tree->buffer, tree->size);
    - 	if (unpack_trees(1, &t, &opts) < 0)
    - 		die(_("unable to checkout working tree"));
    -+	clear_unpack_trees_porcelain(&opts);
    - 
    - 	free(head);
    - 
    -
    - ## builtin/commit.c ##
    -@@ builtin/commit.c: static void create_base_index(const struct commit *current_head)
    - 	struct tree *tree;
    - 	struct unpack_trees_options opts;
    - 	struct tree_desc t;
    -+	int exit_early = 0;
    - 
    - 	if (!current_head) {
    - 		discard_cache();
    -@@ builtin/commit.c: static void create_base_index(const struct commit *current_head)
    - 	parse_tree(tree);
    - 	init_tree_desc(&t, tree->buffer, tree->size);
    - 	if (unpack_trees(1, &t, &opts))
    --		exit(128); /* We've already reported the error, finish dying */
    -+		exit_early = 1; /* We've already reported the error, finish dying */
    -+	clear_unpack_trees_porcelain(&opts);
    -+	if (exit_early)
    -+		exit(128);
    - }
    - 
    - static void refresh_cache_or_die(int refresh_flags)
    -
    - ## builtin/merge.c ##
    -@@ builtin/merge.c: static int read_tree_trivial(struct object_id *common, struct object_id *head,
    - 	struct tree *trees[MAX_UNPACK_TREES];
    - 	struct tree_desc t[MAX_UNPACK_TREES];
    - 	struct unpack_trees_options opts;
    -+	int ret = 0;
    - 
    - 	memset(&opts, 0, sizeof(opts));
    - 	opts.head_idx = 2;
    -@@ builtin/merge.c: static int read_tree_trivial(struct object_id *common, struct object_id *head,
    - 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
    - 	}
    - 	if (unpack_trees(nr_trees, t, &opts))
    + 	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
    +-		rollback_lock_file(&lock);
    +-		free((void *)desc.buffer);
    +-		strbuf_release(&ref_name);
     -		return -1;
    --	return 0;
     +		ret = -1;
    -+	clear_unpack_trees_porcelain(&opts);
    -+	return ret;
    - }
    - 
    - static void write_tree_trivial(struct object_id *oid)
    -
    - ## builtin/read-tree.c ##
    -@@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
    - 		OPT__QUIET(&opts.quiet, N_("suppress feedback messages")),
    - 		OPT_END()
    - 	};
    -+	int ret = 0;
    - 
    - 	memset(&opts, 0, sizeof(opts));
    - 	opts.head_idx = -1;
    -@@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
    - 		parse_tree(tree);
    - 		init_tree_desc(t+i, tree->buffer, tree->size);
    - 	}
    --	if (unpack_trees(nr_trees, t, &opts))
    --		return 128;
    -+	if (unpack_trees(nr_trees, t, &opts)) {
    -+		ret = 128;
     +		goto cleanup;
    -+	}
    - 
    - 	if (opts.debug_unpack || opts.dry_run)
    --		return 0; /* do not write the index out */
    -+		goto cleanup; /* do not write the index out */
    - 
    - 	/*
    - 	 * When reading only one tree (either the most basic form,
    -@@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
    - 
    - 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
    - 		die("unable to write new index file");
    --	return 0;
    -+
    -+cleanup:
    -+	clear_unpack_trees_porcelain(&opts);
    -+	return ret;
    - }
    -
    - ## builtin/reset.c ##
    -@@ builtin/reset.c: static int reset_index(const char *ref, const struct object_id *oid, int reset_t
    - 
    - 	if (reset_type == KEEP) {
    - 		struct object_id head_oid;
    --		if (get_oid("HEAD", &head_oid))
    --			return error(_("You do not have a valid HEAD."));
    --		if (!fill_tree_descriptor(the_repository, desc + nr, &head_oid))
    --			return error(_("Failed to find tree of HEAD."));
    -+		if (get_oid("HEAD", &head_oid)) {
    -+			error(_("You do not have a valid HEAD."));
    -+			goto out;
    -+		}
    -+		if (!fill_tree_descriptor(the_repository, desc + nr, &head_oid)) {
    -+			error(_("Failed to find tree of HEAD."));
    -+			goto out;
    -+		}
    - 		nr++;
    - 		opts.fn = twoway_merge;
      	}
    -@@ builtin/reset.c: static int reset_index(const char *ref, const struct object_id *oid, int reset_t
    - 	ret = 0;
    - 
    - out:
    -+	clear_unpack_trees_porcelain(&opts);
    - 	for (i = 0; i < nr; i++)
    - 		free((void *)desc[i].buffer);
    - 	return ret;
    -
    - ## builtin/stash.c ##
    -@@ builtin/stash.c: static int reset_tree(struct object_id *i_tree, int update, int reset)
    - 	struct tree_desc t[MAX_UNPACK_TREES];
    - 	struct tree *tree;
    - 	struct lock_file lock_file = LOCK_INIT;
    -+	int ret = 0;
    - 
    - 	read_cache_preload(NULL);
    - 	if (refresh_cache(REFRESH_QUIET))
    -@@ builtin/stash.c: static int reset_tree(struct object_id *i_tree, int update, int reset)
    - 		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
    - 	opts.fn = oneway_merge;
    - 
    --	if (unpack_trees(nr_trees, t, &opts))
    --		return -1;
    -+	if (unpack_trees(nr_trees, t, &opts)) {
    -+		ret = -1;
    -+		goto cleanup;
    -+	}
    - 
    - 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
    --		return error(_("unable to write new index file"));
    -+		ret = error(_("unable to write new index file"));
      
    --	return 0;
    -+cleanup:
    -+	clear_unpack_trees_porcelain(&opts);
    -+	return ret;
    - }
    - 
    - static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
    -@@ builtin/stash.c: static void diff_include_untracked(const struct stash_info *info, struct diff_op
    - 
    - 	if (unpack_trees(ARRAY_SIZE(tree_desc), tree_desc, &unpack_tree_opt))
    - 		die(_("failed to unpack trees"));
    -+	clear_unpack_trees_porcelain(&unpack_tree_opt);
    - 
    - 	do_diff_cache(&info->b_commit, diff_opt);
    - }
    -
    - ## diff-lib.c ##
    -@@ diff-lib.c: static int diff_cache(struct rev_info *revs,
    - 	struct tree *tree;
    - 	struct tree_desc t;
    - 	struct unpack_trees_options opts;
    -+	int ret;
    - 
    - 	tree = parse_tree_indirect(tree_oid);
    - 	if (!tree)
    -@@ diff-lib.c: static int diff_cache(struct rev_info *revs,
    - 	opts.pathspec->recursive = 1;
    - 
    - 	init_tree_desc(&t, tree->buffer, tree->size);
    --	return unpack_trees(1, &t, &opts);
    -+	ret = unpack_trees(1, &t, &opts);
    -+	clear_unpack_trees_porcelain(&opts);
    -+	return ret;
    - }
    - 
    - void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
    -
    - ## sequencer.c ##
    + 	tree = parse_tree_indirect(&oid);
     @@ sequencer.c: static int do_reset(struct repository *r,
    - 		rollback_lock_file(&lock);
    - 		free((void *)desc.buffer);
    - 		strbuf_release(&ref_name);
    -+		clear_unpack_trees_porcelain(&unpack_tree_opts);
    - 		return -1;
    - 	}
      
    -@@ sequencer.c: static int do_reset(struct repository *r,
    - 				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
    + 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0)
    + 		ret = error(_("could not write index"));
    +-	free((void *)desc.buffer);
      
    + 	if (!ret)
    + 		ret = update_ref(reflog_message(opts, "reset", "'%.*s'",
    + 						len, name), "HEAD", &oid,
    + 				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
    +-
    ++cleanup:
    ++	free((void *)desc.buffer);
    ++	if (ret < 0)
    ++		rollback_lock_file(&lock);
      	strbuf_release(&ref_name);
    -+	clear_unpack_trees_porcelain(&unpack_tree_opts);
      	return ret;
      }
    - 
-:  ----------- > 3:  66ae63db8fd sequencer: fix a memory leak in do_reset()
-- 
2.33.0.1446.g6af949f83bd

