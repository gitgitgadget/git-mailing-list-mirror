Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358BDC4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B279820867
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6dO1mFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgKPKXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKPKXI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 05:23:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D30C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a65so23119769wme.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qjl9N3IEfATOlaqOphrjAxuWei7oq9+KsVONx6jfftw=;
        b=S6dO1mFbOSFM1TkCTYl1h23aHdaAZX9TepgDrFftq0BZeBSQrj/1Nh6y7Yzt6cc8VH
         xTc1/VxRXqReHe3kTVjmA4bR+NAjOefSitnI3zfT92g0CEVrtCTKkBlAlxpvb4ONUofZ
         hWHQ+w3XVQumxRbeBuIlmx0cFwbnIon0p5GbOUWxc2dRnxOv8zkk+QJtmILFfTprJV8f
         jkKoZZJ++870GxXlGYfkj5YiDg37Mwaxo2USRovH9Tp5aXgcSbiWJ9nBj+qYfkJ99oFt
         XIXZ5gXxKwCJFKWunQ/A7LTg5Q5JKdgoJcYf5zq0oKtIigkUmm08z56l61cvQ7MzHSX3
         q+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qjl9N3IEfATOlaqOphrjAxuWei7oq9+KsVONx6jfftw=;
        b=dWCSgOsjJ7ofLZa6JZGxpJ24miiaA712sv7DdhdPvkh5jAaletaS5fNBSB7Ccr6RtB
         Ju2caV+RMG8toijpH2XFV/VUuCzZaTboVsRi3Po1HVbaZ6mZ2alv41yQz8X1QHB80dMn
         kWQIOsrQ5/6556/nYUvc9qh4TOPoc4PzAprlAHlxFMN3BJVJzg7nusbr7QyoI72D13IR
         yGovi4UJKfxmpM3rwgxBq2Ulbcc+DDih3OmzuyPjHonM6lbLOSyAcB36fSyMwW8qdOTW
         kpvT2RA0u8sqVG5yf5UbwawhVSuhY843VKIN9WYDwwR+7XOuHXWLAYesqsBlGP+Y56Lr
         0tZw==
X-Gm-Message-State: AOAM533QOYrOOmKzrDS/1hVsuTQ7GwouzBmMRyL2w9izuX01hQ95rdg4
        OQfDgSFmvStwK4Cw5xCXJ3lGYD9D2Gc=
X-Google-Smtp-Source: ABdhPJyiZd2ePH9Gf5pTZcDv9ymhWGZSI3zel1GEONOygAAA4ofi09tAfD2asXR8VYQmqntN/tFEQw==
X-Received: by 2002:a1c:c909:: with SMTP id f9mr14242879wmb.87.1605522186557;
        Mon, 16 Nov 2020 02:23:06 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id f5sm22884520wrg.32.2020.11.16.02.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:23:06 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 00/12] Rewrite the remaining merge strategies from shell to C
Date:   Mon, 16 Nov 2020 11:21:46 +0100
Message-Id: <20201116102158.8365-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113110428.21265-1-alban.gruin@gmail.com>
References: <20201113110428.21265-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a effort to reduce the number of shell scripts in git's codebase, I
propose this patch series converting the two remaining merge strategies,
resolve and octopus, from shell to C.  This will enable slightly better
performance, better integration with git itself (no more forking to
perform these operations), better portability (Windows and shell scripts
don't mix well).

Three scripts are actually converted: first git-merge-one-file.sh, then
git-merge-resolve.sh, and finally git-merge-octopus.sh.  Not only they
are converted, but they also are modified to operate without forking,
and then libified so they can be used by git without spawning another
process.

The first patch is not important to make the whole series work, but I
made this patch while working on it.

This series keeps the commands `git merge-one-file', `git
merge-resolve', and `git merge-octopus', so any script depending on them
should keep working without any changes.

This series is based on 306ee63a70 (Eighteenth batch, 2020-09-29).  The
tip is tagged as "rewrite-merge-strategies-v5" at
https://github.com/agrn/git.

Changes since v4:

 - [3/12] Split long lines to 80 characters max.

 - [6/12, 8/12] Define fast_forward() when rewriting `merge-resolve'
   instead of `merge-octopus' and use it in merge_strategies_resolve()
   to reduce code duplication.  This version takes a list `tree_desc'
   instead of a list of oids.

 - [6/12, 8/12] Rename some variables (eg. i -> nr, j -> i, k -> j).

 - [8/12] Rewrote the two loops detecting if the merge was a
   fast-forward, or if a step was already up to date, to make only one
   less convoluted loop.

 - [8/12] Moved the blocks doing a fast-forward and a non-fast-forward
   merge to their own functions to make the code simpler.  That way,
   there is no need to free `branch_name' and `common' each time an
   error is handled.

 - [8/12] A call to die has been replaced by an error()/return.

 - [9/12, 10/12] Reformatted a chain of if/else if/else blocks.

Alban Gruin (12):
  t6027: modernise tests
  update-index: move add_cacheinfo() to read-cache.c
  merge-one-file: rewrite in C
  merge-index: libify merge_one_path() and merge_all()
  merge-index: don't fork if the requested program is
    `git-merge-one-file'
  merge-resolve: rewrite in C
  merge-recursive: move better_branch_name() to merge.c
  merge-octopus: rewrite in C
  merge: use the "resolve" strategy without forking
  merge: use the "octopus" strategy without forking
  sequencer: use the "resolve" strategy without forking
  sequencer: use the "octopus" merge strategy without forking

 Makefile                        |   7 +-
 builtin.h                       |   3 +
 builtin/merge-index.c           | 102 ++----
 builtin/merge-octopus.c         |  69 ++++
 builtin/merge-one-file.c        |  94 ++++++
 builtin/merge-recursive.c       |  16 +-
 builtin/merge-resolve.c         |  73 +++++
 builtin/merge.c                 |   7 +
 builtin/update-index.c          |  25 +-
 cache.h                         |   7 +-
 git-merge-octopus.sh            | 112 -------
 git-merge-one-file.sh           | 167 ----------
 git-merge-resolve.sh            |  54 ---
 git.c                           |   3 +
 merge-strategies.c              | 564 ++++++++++++++++++++++++++++++++
 merge-strategies.h              |  43 +++
 merge.c                         |  12 +
 read-cache.c                    |  35 ++
 sequencer.c                     |  16 +-
 t/t6407-merge-binary.sh         |  27 +-
 t/t6415-merge-dir-to-symlink.sh |   2 +-
 21 files changed, 974 insertions(+), 464 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 create mode 100644 builtin/merge-one-file.c
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-octopus.sh
 delete mode 100755 git-merge-one-file.sh
 delete mode 100755 git-merge-resolve.sh
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

Range-diff against v4:
 1:  08c7df596a =  1:  08c7df596a t6027: modernise tests
 2:  df237da758 =  2:  df237da758 update-index: move add_cacheinfo() to read-cache.c
 3:  b64bad0d23 !  3:  eedddde8ea merge-one-file: rewrite in C
    @@ -498,7 +498,8 @@
     +		 * added so there is nothing to be done, except making
     +		 * the path merged.
     +		 */
    -+		return add_to_index_cacheinfo(r->index, our_mode, our_blob, path, 0, 1, 1, NULL);
    ++		return add_to_index_cacheinfo(r->index, our_mode, our_blob,
    ++					      path, 0, 1, 1, NULL);
     +	} else if (!orig_blob && !our_blob && their_blob) {
     +		struct cache_entry *ce;
     +		printf(_("Adding %s\n"), path);
    @@ -506,7 +507,8 @@
     +		if (file_exists(path))
     +			return error(_("untracked %s is overwritten by the merge."), path);
     +
    -+		if (add_to_index_cacheinfo(r->index, their_mode, their_blob, path, 0, 1, 1, &ce))
    ++		if (add_to_index_cacheinfo(r->index, their_mode, their_blob,
    ++					   path, 0, 1, 1, &ce))
     +			return -1;
     +		return checkout_from_index(r->index, path, ce);
     +	} else if (!orig_blob && our_blob && their_blob &&
    @@ -521,7 +523,8 @@
     +
     +		printf(_("Adding %s\n"), path);
     +
    -+		if (add_to_index_cacheinfo(r->index, our_mode, our_blob, path, 0, 1, 1, &ce))
    ++		if (add_to_index_cacheinfo(r->index, our_mode, our_blob,
    ++					   path, 0, 1, 1, &ce))
     +			return -1;
     +		return checkout_from_index(r->index, path, ce);
     +	} else if (our_blob && their_blob) {
 4:  c5577dc691 =  4:  a9b9942243 merge-index: libify merge_one_path() and merge_all()
 5:  a0e6cebe89 =  5:  12775907c5 merge-index: don't fork if the requested program is `git-merge-one-file'
 6:  94fbc7e286 !  6:  54a4a12504 merge-resolve: rewrite in C
    @@ -235,72 +235,86 @@
      	return err;
      }
     +
    -+static int add_tree(const struct object_id *oid, struct tree_desc *t)
    ++static int fast_forward(struct repository *r, struct tree_desc *t,
    ++			int nr, int aggressive)
     +{
    -+	struct tree *tree;
    -+
    -+	tree = parse_tree_indirect(oid);
    -+	if (parse_tree(tree))
    -+		return -1;
    -+
    -+	init_tree_desc(t, tree->buffer, tree->size);
    -+	return 0;
    -+}
    -+
    -+int merge_strategies_resolve(struct repository *r,
    -+			     struct commit_list *bases, const char *head_arg,
    -+			     struct commit_list *remote)
    -+{
    -+	int i = 0;
    -+	struct lock_file lock = LOCK_INIT;
    -+	struct tree_desc t[MAX_UNPACK_TREES];
     +	struct unpack_trees_options opts;
    -+	struct object_id head, oid;
    -+	struct commit_list *j;
    -+
    -+	if (head_arg)
    -+		get_oid(head_arg, &head);
    ++	struct lock_file lock = LOCK_INIT;
     +
    ++	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
     +	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    -+	refresh_index(r->index, 0, NULL, NULL, NULL);
     +
     +	memset(&opts, 0, sizeof(opts));
     +	opts.head_idx = 1;
     +	opts.src_index = r->index;
     +	opts.dst_index = r->index;
    -+	opts.update = 1;
     +	opts.merge = 1;
    -+	opts.aggressive = 1;
    ++	opts.update = 1;
    ++	opts.aggressive = aggressive;
     +
    -+	for (j = bases; j && j->item; j = j->next) {
    -+		if (add_tree(&j->item->object.oid, t + (i++)))
    -+			goto out;
    -+	}
    -+
    -+	if (head_arg && add_tree(&head, t + (i++)))
    -+		goto out;
    -+	if (remote && add_tree(&remote->item->object.oid, t + (i++)))
    -+		goto out;
    -+
    -+	if (i == 1)
    ++	if (nr == 1)
     +		opts.fn = oneway_merge;
    -+	else if (i == 2) {
    ++	else if (nr == 2) {
     +		opts.fn = twoway_merge;
     +		opts.initial_checkout = is_index_unborn(r->index);
    -+	} else if (i >= 3) {
    ++	} else if (nr >= 3) {
     +		opts.fn = threeway_merge;
    -+		opts.head_idx = i - 1;
    ++		opts.head_idx = nr - 1;
     +	}
     +
    -+	if (unpack_trees(i, t, &opts))
    -+		goto out;
    ++	if (unpack_trees(nr, t, &opts))
    ++		return -1;
    ++
    ++	if (write_locked_index(r->index, &lock, COMMIT_LOCK))
    ++		return error(_("unable to write new index file"));
    ++
    ++	return 0;
    ++}
    ++
    ++static int add_tree(struct tree *tree, struct tree_desc *t)
    ++{
    ++	if (parse_tree(tree))
    ++		return -1;
    ++
    ++	init_tree_desc(t, tree->buffer, tree->size);
    ++	return 0;
    ++}
    ++
    ++int merge_strategies_resolve(struct repository *r,
    ++			     struct commit_list *bases, const char *head_arg,
    ++			     struct commit_list *remote)
    ++{
    ++	struct tree_desc t[MAX_UNPACK_TREES];
    ++	struct object_id head, oid;
    ++	struct commit_list *i;
    ++	int nr = 0;
    ++
    ++	if (head_arg)
    ++		get_oid(head_arg, &head);
     +
     +	puts(_("Trying simple merge."));
    -+	write_locked_index(r->index, &lock, COMMIT_LOCK);
    ++
    ++	for (i = bases; i && i->item; i = i->next) {
    ++		if (add_tree(repo_get_commit_tree(r, i->item), t + (nr++)))
    ++			return 2;
    ++	}
    ++
    ++	if (head_arg) {
    ++		struct tree *tree = parse_tree_indirect(&head);
    ++		if (add_tree(tree, t + (nr++)))
    ++			return 2;
    ++	}
    ++
    ++	if (remote && add_tree(repo_get_commit_tree(r, remote->item), t + (nr++)))
    ++		return 2;
    ++
    ++	if (fast_forward(r, t, nr, 1))
    ++		return 2;
     +
     +	if (write_index_as_tree(&oid, r->index, r->index_file,
     +				WRITE_TREE_SILENT, NULL)) {
     +		int ret;
    ++		struct lock_file lock = LOCK_INIT;
     +
     +		puts(_("Simple merge failed, trying Automatic merge."));
     +		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    @@ -311,10 +325,6 @@
     +	}
     +
     +	return 0;
    -+
    -+ out:
    -+	rollback_lock_file(&lock);
    -+	return 2;
     +}
     
      diff --git a/merge-strategies.h b/merge-strategies.h
 7:  b582b7e5d1 =  7:  7c4ad06b95 merge-recursive: move better_branch_name() to merge.c
 8:  d1936645d5 !  8:  edbe08d41b merge-octopus: rewrite in C
    @@ -275,88 +275,107 @@
      #include "lockfile.h"
      #include "merge-strategies.h"
     @@
    - 	rollback_lock_file(&lock);
    - 	return 2;
    + 
    + 	return 0;
      }
     +
    -+static int fast_forward(struct repository *r, const struct object_id *oids,
    -+			int nr, int aggressive)
    -+{
    -+	int i;
    -+	struct tree_desc t[MAX_UNPACK_TREES];
    -+	struct unpack_trees_options opts;
    -+	struct lock_file lock = LOCK_INIT;
    -+
    -+	repo_read_index_preload(r, NULL, 0);
    -+	if (refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL))
    -+		return -1;
    -+
    -+	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    -+
    -+	memset(&opts, 0, sizeof(opts));
    -+	opts.head_idx = 1;
    -+	opts.src_index = r->index;
    -+	opts.dst_index = r->index;
    -+	opts.merge = 1;
    -+	opts.update = 1;
    -+	opts.aggressive = aggressive;
    -+
    -+	for (i = 0; i < nr; i++) {
    -+		struct tree *tree;
    -+		tree = parse_tree_indirect(oids + i);
    -+		if (parse_tree(tree))
    -+			return -1;
    -+		init_tree_desc(t + i, tree->buffer, tree->size);
    -+	}
    -+
    -+	if (nr == 1)
    -+		opts.fn = oneway_merge;
    -+	else if (nr == 2) {
    -+		opts.fn = twoway_merge;
    -+		opts.initial_checkout = is_index_unborn(r->index);
    -+	} else if (nr >= 3) {
    -+		opts.fn = threeway_merge;
    -+		opts.head_idx = nr - 1;
    -+	}
    -+
    -+	if (unpack_trees(nr, t, &opts))
    -+		return -1;
    -+
    -+	if (write_locked_index(r->index, &lock, COMMIT_LOCK))
    -+		return error(_("unable to write new index file"));
    -+
    -+	return 0;
    -+}
    -+
     +static int write_tree(struct repository *r, struct tree **reference_tree)
     +{
     +	struct object_id oid;
     +	int ret;
     +
    -+	ret = write_index_as_tree(&oid, r->index, r->index_file, 0, NULL);
    -+	if (!ret)
    ++	if (!(ret = write_index_as_tree(&oid, r->index, r->index_file, 0, NULL)))
     +		*reference_tree = lookup_tree(r, &oid);
     +
     +	return ret;
     +}
     +
    ++static int octopus_fast_forward(struct repository *r, const char *branch_name,
    ++				struct tree *tree_head, struct tree *current_tree,
    ++				struct tree **reference_tree)
    ++{
    ++	/*
    ++	 * The first head being merged was a fast-forward.  Advance the
    ++	 * reference commit to the head being merged, and use that tree
    ++	 * as the intermediate result of the merge.  We still need to
    ++	 * count this as part of the parent set.
    ++	 */
    ++	struct tree_desc t[2];
    ++
    ++	printf(_("Fast-forwarding to: %s\n"), branch_name);
    ++
    ++	init_tree_desc(t, tree_head->buffer, tree_head->size);
    ++	if (add_tree(current_tree, t + 1))
    ++		return -1;
    ++	if (fast_forward(r, t, 2, 0))
    ++		return -1;
    ++	if (write_tree(r, reference_tree))
    ++		return -1;
    ++
    ++	return 0;
    ++}
    ++
    ++static int octopus_do_merge(struct repository *r, const char *branch_name,
    ++			    struct commit_list *common, struct tree *current_tree,
    ++			    struct tree **reference_tree)
    ++{
    ++	struct tree_desc t[MAX_UNPACK_TREES];
    ++	struct commit_list *j;
    ++	int nr = 0, ret = 0;
    ++
    ++	printf(_("Trying simple merge with %s\n"), branch_name);
    ++
    ++	for (j = common; j; j = j->next) {
    ++		struct tree *tree = repo_get_commit_tree(r, j->item);
    ++		if (add_tree(tree, t + (nr++)))
    ++			return -1;
    ++	}
    ++
    ++	if (add_tree(*reference_tree, t + (nr++)))
    ++		return -1;
    ++	if (add_tree(current_tree, t + (nr++)))
    ++		return -1;
    ++	if (fast_forward(r, t, nr, 1))
    ++		return -1;
    ++
    ++	if (write_tree(r, reference_tree)) {
    ++		struct lock_file lock = LOCK_INIT;
    ++
    ++		puts(_("Simple merge did not work, trying automatic merge."));
    ++		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    ++		ret = merge_all_index(r->index, 0, 0, merge_one_file_func, r);
    ++		write_locked_index(r->index, &lock, COMMIT_LOCK);
    ++
    ++		write_tree(r, reference_tree);
    ++	}
    ++
    ++	return ret ? -2 : 0;
    ++}
    ++
     +int merge_strategies_octopus(struct repository *r,
     +			     struct commit_list *bases, const char *head_arg,
     +			     struct commit_list *remotes)
     +{
    -+	int non_ff_merge = 0, ret = 0, references = 1;
    ++	int ff_merge = 1, ret = 0, references = 1;
     +	struct commit **reference_commit;
    -+	struct tree *reference_tree;
    -+	struct commit_list *j;
    ++	struct tree *reference_tree, *tree_head;
    ++	struct commit_list *i;
     +	struct object_id head;
     +	struct strbuf sb = STRBUF_INIT;
     +
     +	get_oid(head_arg, &head);
     +
    -+	reference_commit = xcalloc(commit_list_count(remotes) + 1, sizeof(struct commit *));
    ++	reference_commit = xcalloc(commit_list_count(remotes) + 1,
    ++				   sizeof(struct commit *));
     +	reference_commit[0] = lookup_commit_reference(r, &head);
     +	reference_tree = repo_get_commit_tree(r, reference_commit[0]);
     +
    ++	tree_head = repo_get_commit_tree(r, reference_commit[0]);
    ++	if (parse_tree(tree_head)) {
    ++		ret = 2;
    ++		goto out;
    ++	}
    ++
     +	if (repo_index_has_changes(r, reference_tree, &sb)) {
     +		error(_("Your local changes to the following files "
     +			"would be overwritten by merge:\n  %s"),
    @@ -366,12 +385,13 @@
     +		goto out;
     +	}
     +
    -+	for (j = remotes; j && j->item; j = j->next) {
    -+		struct commit *c = j->item;
    ++	for (i = remotes; i && i->item; i = i->next) {
    ++		struct commit *c = i->item;
     +		struct object_id *oid = &c->object.oid;
    -+		struct commit_list *common, *k;
    ++		struct tree *current_tree = repo_get_commit_tree(r, c);
    ++		struct commit_list *common, *j;
     +		char *branch_name;
    -+		int can_ff = 1;
    ++		int k = 0, up_to_date = 0;
     +
     +		if (ret) {
     +			/*
    @@ -389,92 +409,47 @@
     +		branch_name = merge_get_better_branch_name(oid_to_hex(oid));
     +		common = get_merge_bases_many(c, references, reference_commit);
     +
    -+		if (!common)
    -+			die(_("Unable to find common commit with %s"), branch_name);
    ++		if (!common) {
    ++			error(_("Unable to find common commit with %s"), branch_name);
     +
    -+		for (k = common; k && !oideq(&k->item->object.oid, oid); k = k->next);
    ++			free(branch_name);
    ++			free_commit_list(common);
     +
    -+		if (k) {
    ++			ret = 2;
    ++			goto out;
    ++		}
    ++
    ++		for (j = common; j && !(up_to_date || !ff_merge); j = j->next) {
    ++			up_to_date |= oideq(&j->item->object.oid, oid);
    ++
    ++			if (k < references)
    ++				ff_merge &= oideq(&j->item->object.oid, &reference_commit[k++]->object.oid);
    ++		}
    ++
    ++		if (up_to_date) {
     +			printf(_("Already up to date with %s\n"), branch_name);
    ++
     +			free(branch_name);
     +			free_commit_list(common);
     +			continue;
     +		}
     +
    -+		if (!non_ff_merge) {
    -+			int i;
    -+
    -+			for (i = 0, k = common; k && i < references && can_ff; k = k->next, i++) {
    -+				can_ff = oideq(&k->item->object.oid,
    -+					       &reference_commit[i]->object.oid);
    -+			}
    -+		}
    -+
    -+		if (!non_ff_merge && can_ff) {
    -+			/*
    -+			 * The first head being merged was a
    -+			 * fast-forward.  Advance the reference commit
    -+			 * to the head being merged, and use that tree
    -+			 * as the intermediate result of the merge.  We
    -+			 * still need to count this as part of the
    -+			 * parent set.
    -+			 */
    -+			struct object_id oids[2];
    -+			printf(_("Fast-forwarding to: %s\n"), branch_name);
    -+
    -+			oidcpy(oids, &head);
    -+			oidcpy(oids + 1, oid);
    -+
    -+			ret = fast_forward(r, oids, 2, 0);
    -+			if (ret) {
    -+				free(branch_name);
    -+				free_commit_list(common);
    -+				goto out;
    -+			}
    -+
    ++		if (ff_merge) {
    ++			ret = octopus_fast_forward(r, branch_name, tree_head,
    ++						   current_tree, &reference_tree);
     +			references = 0;
    -+			write_tree(r, &reference_tree);
     +		} else {
    -+			int i = 0;
    -+			struct tree *next = NULL;
    -+			struct object_id oids[MAX_UNPACK_TREES];
    -+
    -+			non_ff_merge = 1;
    -+			printf(_("Trying simple merge with %s\n"), branch_name);
    -+
    -+			for (k = common; k; k = k->next)
    -+				oidcpy(oids + (i++), &k->item->object.oid);
    -+
    -+			oidcpy(oids + (i++), &reference_tree->object.oid);
    -+			oidcpy(oids + (i++), oid);
    -+
    -+			if (fast_forward(r, oids, i, 1)) {
    -+				ret = 2;
    -+
    -+				free(branch_name);
    -+				free_commit_list(common);
    -+
    -+				goto out;
    -+			}
    -+
    -+			if (write_tree(r, &next)) {
    -+				struct lock_file lock = LOCK_INIT;
    -+
    -+				puts(_("Simple merge did not work, trying automatic merge."));
    -+				repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    -+				ret = !!merge_all_index(r->index, 0, 0, merge_one_file_func, r);
    -+				write_locked_index(r->index, &lock, COMMIT_LOCK);
    -+
    -+				write_tree(r, &next);
    -+			}
    -+
    -+			reference_tree = next;
    ++			ret = octopus_do_merge(r, branch_name, common,
    ++					       current_tree, &reference_tree);
     +		}
     +
    -+		reference_commit[references++] = c;
    -+
     +		free(branch_name);
     +		free_commit_list(common);
    ++
    ++		if (ret == -1)
    ++			goto out;
    ++
    ++		reference_commit[references++] = c;
     +	}
     +
     +out:
 9:  26b1a3979c !  9:  e677b27c06 merge: use the "resolve" strategy without forking
    @@ -22,11 +22,9 @@
      				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
      			die(_("unable to write %s"), get_index_file());
      		return clean ? 0 : 1;
    --	} else {
    -+	} else if (!strcmp(strategy, "resolve"))
    ++	} else if (!strcmp(strategy, "resolve")) {
     +		return merge_strategies_resolve(the_repository, common,
     +						head_arg, remoteheads);
    -+	else {
    + 	} else {
      		return try_merge_command(the_repository,
      					 strategy, xopts_nr, xopts,
    - 					 common, head_arg, remoteheads);
10:  23bc9824df ! 10:  963f316fd6 merge: use the "octopus" strategy without forking
    @@ -11,12 +11,12 @@
      --- a/builtin/merge.c
      +++ b/builtin/merge.c
     @@
    - 	} else if (!strcmp(strategy, "resolve"))
    + 	} else if (!strcmp(strategy, "resolve")) {
      		return merge_strategies_resolve(the_repository, common,
      						head_arg, remoteheads);
    -+	else if (!strcmp(strategy, "octopus"))
    ++	} else if (!strcmp(strategy, "octopus")) {
     +		return merge_strategies_octopus(the_repository, common,
     +						head_arg, remoteheads);
    - 	else {
    + 	} else {
      		return try_merge_command(the_repository,
      					 strategy, xopts_nr, xopts,
11:  3a340f5984 = 11:  0ad967a7e5 sequencer: use the "resolve" strategy without forking
12:  ce3723cf34 = 12:  3814f61717 sequencer: use the "octopus" merge strategy without forking
-- 
2.20.1

