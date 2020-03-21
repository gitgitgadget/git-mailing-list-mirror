Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F29C54FCD
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F7420663
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKa6yChi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgCUSAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:16 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38869 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbgCUSAP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:15 -0400
Received: by mail-ed1-f54.google.com with SMTP id e5so1162239edq.5
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mwt574rCvzjuIjgHLnBc1ctQiJiTBUUVZSbTbk1oCZg=;
        b=qKa6yChiVCd+PpUYPGBSFtPOsjC+8fxJeNfUfj4mshd9MtpzZUTlUuaptniRMrxJ6N
         zcwmiRXVnJ+J0NR4gLGPzHqqnjRh5O1hXUmwq0vhgFFrM4K84G5+VQBHFVHa3blSWOEA
         gdJ5KJvRCAHM0AVI+B7gi31IPNFC+DcaHpB53C/GYI8F4v9QUaBzg9YrRwdJPjg9bTXi
         vXpTxmHsIuJibH2RqQq0IqTROoLOq8yyEeSuZbJLpD+MyU05uILhNTuRbA+Iwx+PEmey
         b+YVN6WJfzOYvd6ropG0H6WAklHBvWU5XqnA2sI8eqI+XJuYbmbT1YXaSm8q9Js8/T7m
         j72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mwt574rCvzjuIjgHLnBc1ctQiJiTBUUVZSbTbk1oCZg=;
        b=VNzwE+NbP71E11ezfEtOw5rhMFeBEGQB+TMFHvd3XmqMf6W6oUivC9SqRrVBb/rzU5
         NspR6fJKBcukU170kJyUSWCSz9rV0uIop4Z36sPQSwP9v0GQTejzKEB1FVzSwhrvjWOT
         UQRqm3qeLI3MU1Cs2i4Ci1cERU0q58Q3axMpSWwdCGIEvpkIEvJOU8sPfUdbvcL2hgXw
         tLb0PArcS1KbfuTctAYeW3O0UuUy2V7HItnkIigpMndLKTzn1wevpy3GUVS8MllXaXdd
         asyGDdBHP+aGiEYatyqOhnWT3KcyuBPcEuei7nefZDxcLZEcX39sKnCRB8DMRDZGiijq
         Ra/Q==
X-Gm-Message-State: ANhLgQ18z6KQVBXg2P8QTFMAhZwC2A/tNpge40C+0zf2LOlg8getJIPM
        NpZ+6XRoQRCcyn/UFvaNqHSQg2IN
X-Google-Smtp-Source: ADFU+vs78m69ZXUAh99ucB5nkjFyYUW66HJAD4Q3WvgJ7fPRzQiZSiFkT5Kv02YdB2BKtyUi3lpVQA==
X-Received: by 2002:aa7:c457:: with SMTP id n23mr14156907edr.288.1584813610441;
        Sat, 21 Mar 2020 11:00:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15sm640364eds.2.2020.03.21.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:09 -0700 (PDT)
Message-Id: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 17:59:51 +0000
Subject: [PATCH v2 00/18] Sparse checkout improvements -- improved sparsity updating
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series provides a replacement for the sparsity updating in
sparse-checkout that is based on the logic from git read-tree -mu HEAD. The
most important bit is patch 9 and its lengthy commit message explaining the
current state and rationale for most the series, though patches 16 and 17
have additional related directions and rationale for the series. Those three
patches are the most important to review.

Changes since v1:

 * addressed several cleanups highlighted by Stolee (and I picked 'reapply'
   for the new subcommand name)
 * added three new minor cleanup commits (patches 2-4)
 * several new patches to adjust the warning messages to look like warnings
   (patches 11-15)
 * display warning messages when paths are unmerged (patch 16)
 * also make checkout and other unpack_trees()-using commands not error out
   when unable to set the SKIP_WORKTREE bit (patch 17)

Also, the loop range in display_warning_msgs() in patch 14 might seem
slightly weird, but I felt adding another unpack_rejects array of some sort
and plumbing through an extra bit everywhere to notify the system which
unpack_rejects array to use would have been more invasive. Opinions either
way (or alternative approaches) welcome.

I was also curious if I should have squashed all the patches to adjust the
warning messages (patches 11-15, they adjust the messages to actually look
like warnings instead of errors), since they are individually kind of small,
but it looked like it'd be much easier to review if I were to split them
apart, so I did so.

Elijah Newren (18):
  unpack-trees: fix minor typo in comment
  unpack-trees: remove unused error type
  unpack-trees: simplify verify_absent_sparse()
  unpack-trees: simplify pattern_list freeing
  t1091: make some tests a little more defensive against failures
  unpack-trees: allow check_updates() to work on a different index
  unpack-trees: do not mark a dirty path with SKIP_WORKTREE
  unpack-trees: pull sparse-checkout pattern reading into a new function
  unpack-trees: add a new update_sparsity() function
  sparse-checkout: use new update_sparsity() function
  sparse-checkout: use improved unpack_trees porcelain messages
  unpack-trees: move ERROR_WOULD_LOSE_SUBMODULE earlier
  unpack-trees: rename ERROR_* fields meant for warnings to WARNING_*
  unpack-trees: split display_error_msgs() into two
  unpack-trees: make sparse path messages sound like warnings
  unpack-trees: provide warnings on sparse updates for unmerged paths
    too
  unpack-trees: failure to set SKIP_WORKTREE bits always just a warning
  sparse-checkout: provide a new reapply subcommand

 Documentation/git-sparse-checkout.txt |  10 +
 builtin/sparse-checkout.c             |  55 +++---
 t/t1011-read-tree-sparse-checkout.sh  |  11 +-
 t/t1091-sparse-checkout-builtin.sh    |  58 +++++-
 t/t2018-checkout-branch.sh            |  22 +++
 unpack-trees.c                        | 256 ++++++++++++++++++++------
 unpack-trees.h                        |  28 ++-
 7 files changed, 330 insertions(+), 110 deletions(-)


base-commit: be8661a3286c67a5d4088f4226cbd7f8b76544b0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-726%2Fnewren%2Fsparse-checkout-improvements-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-726/newren/sparse-checkout-improvements-v2
Pull-Request: https://github.com/git/git/pull/726

Range-diff vs v1:

  1:  9ab9a9d6037 =  1:  3c183727c98 unpack-trees: fix minor typo in comment
  -:  ----------- >  2:  e6beb1c5810 unpack-trees: remove unused error type
  -:  ----------- >  3:  739b52393fe unpack-trees: simplify verify_absent_sparse()
  -:  ----------- >  4:  65772dd46df unpack-trees: simplify pattern_list freeing
  2:  b07fdab55aa =  5:  5cbab2a7a56 t1091: make some tests a little more defensive against failures
  3:  02afa9c13c1 =  6:  5fea19f0136 unpack-trees: allow check_updates() to work on a different index
  4:  baa4f23421b =  7:  3d2531ca818 unpack-trees: do not mark a dirty path with SKIP_WORKTREE
  -:  ----------- >  8:  27d6304d33f unpack-trees: pull sparse-checkout pattern reading into a new function
  5:  9f13a2e8c64 !  9:  a46439c8536 unpack-trees: add a new update_sparsity() function
     @@ -4,93 +4,78 @@
      
          Previously, the only way to update the SKIP_WORKTREE bits for various
          paths was invoking `git read-tree -mu HEAD` or calling the same code
     -    that this codepath invoked.  This however had a number of problems.
     -    Let's look at all the various cases:
     -
     -      Flipping SKIP_WORKTREE -> !SKIP_WORKTREE (materializing files):
     -        A) There is no file in the way
     -        B) There is an untracked file in the way
     -      Flipping !SKIP_WORKTREE -> SKIP_WORKTREE (removing files):
     -        C) The path is clean
     -        D) The path is unmerged
     -        E) The path has unstaged changes
     -        F) The path has staged changes (differs from HEAD)
     -
     -    For `git read-tree -mu HEAD`, the behavior is as follows:
     -        A) Materialize the file, as expected
     -        B) Refuse to make *any* changes (to this path or any others)
     -        C) Remove the file, as expected
     -        D) Refuse to make *any* changes (to this path or any others)
     -        E) Refuse to make *any* changes (to this path or any others)
     -        F) Removes the file from the working copy AND resets the index
     -           to match HEAD
     -
     -    Refusing to modify files that could result in data loss as in cases B,
     -    D, and E is good, but refusing to work on any other paths is very
     -    problematic for users.  If they are in the middle of a rebase or have
     -    made modifications to files that bring in more dependencies, then for
     -    their build to work they need to update the sparse paths -- which they
     -    are prevented from doing.  Sometimes they stage the files and re-try,
     -    at which point they run into case F and believe that their changes are
     -    lost.  (Even if they come ask an expert, they have to trawl through
     -    their loose objects looking for which ones match which files.)
     -
     -    Add a new update_sparsity() function which behaves as follows in these
     -    cases:
     -        A) Materialize the file, as expected
     -        B) Leave the file in the working copy alone, clear the SKIP_WORKTREE
     -           bit, and print a warning (thus leaving them in a state where
     +    that this codepath invoked.  This however had a number of problems if
     +    the index or working directory were not clean.  First, let's consider
     +    the case:
     +
     +      Flipping SKIP_WORKTREE -> !SKIP_WORKTREE (materializing files)
     +
     +    If the working tree was clean this was fine, but if there were files or
     +    directories or symlinks or whatever already present at the given path
     +    then the operation would abort with an error.  Let's label this case
     +    for later discussion:
     +
     +        A) There is an untracked path in the way
     +
     +    Now let's consider the opposite case:
     +
     +      Flipping !SKIP_WORKTREE -> SKIP_WORKTREE (removing files)
     +
     +    If the index and working tree was clean this was fine, but if there were
     +    any unclean paths we would run into problems.  There are three different
     +    cases to consider:
     +
     +        B) The path is unmerged
     +        C) The path has unstaged changes
     +        D) The path has staged changes (differs from HEAD)
     +
     +    If any path fell into case B or C, then the whole operation would be
     +    aborted with an error.  With sparse-checkout, the whole operation would
     +    be aborted for case D as well, but for its predecessor of using `git
     +    read-tree -mu HEAD` directly, any paths that fell into case D would be
     +    removed from the working copy and the index entry for that path would be
     +    reset to match HEAD -- which looks and feels like data loss to users
     +    (only a few are even aware to ask whether it can be recovered, and even
     +    then it requires walking through loose objects trying to match up the
     +    right ones).
     +
     +    Refusing to remove files that have unsaved user changes is good, but
     +    refusing to work on any other paths is very problematic for users.  If
     +    the user is in the middle of a rebase or has made modifications to files
     +    that bring in more dependencies, then for their build to work they need
     +    to update the sparse paths.  This logic has been preventing them from
     +    doing so.  Sometimes in response, the user will stage the files and
     +    re-try, to no avail with sparse-checkout or to the horror of losing
     +    their changes if they are using its predecessor of `git read-tree -mu
     +    HEAD`.
     +
     +    Add a new update_sparsity() function which will not error out in any of
     +    these cases but behaves as follows for the special cases:
     +        A) Leave the file in the working copy alone, clear the SKIP_WORKTREE
     +           bit, and print a warning (thus leaving the path in a state where
                 status will report the file as modified, which seems logical).
     -        C) Remove the file, as expected
     -        D) Do NOT mark this path as SKIP_WORKTREE, but allow others paths
     -           to be updated.
     -        E) Do NOT mark this path as SKIP_WORKTREE and print a warning about
     -           the dirty path, but allow other paths to be updated.
     -        F) Mark the path as SKIP_WORKTREE, but do not revert the version
     +        B) Do NOT mark this path as SKIP_WORKTREE, and leave it as unmerged.
     +        C) Do NOT mark this path as SKIP_WORKTREE and print a warning about
     +           the dirty path.
     +        D) Mark the path as SKIP_WORKTREE, but do not revert the version
                 stored in the index to match HEAD; leave the contents alone.
      
     -    I tried a different behavior for B (leave the SKIP_WORKTREE bit set),
     +    I tried a different behavior for A (leave the SKIP_WORKTREE bit set),
          but found it very surprising and counter-intuitive (e.g. the user sees
          it is present along with all the other files in that directory, tries to
     -    stage it, but git add ignores it since the SKIP_WORKTREE bit is set).
     -    A, B, C, and E all seem like optimal behavior to me.  D may be as well,
     -    though I wonder if printing a warning would be an improvement.  Some
     -    might be slightly surprised by F at first, but given that it does the
     -    right thing with `git commit` and even `git commit -a` (add ignores
     -    entries that are marked SKIP_WORKTREE and thus doesn't delete them, and
     -    commit -a is similar), it seems logical to me.
     +    stage it, but git add ignores it since the SKIP_WORKTREE bit is set).  A
     +    & C seem like optimal behavior to me.  B may be as well, though I wonder
     +    if printing a warning would be an improvement.  Some might be slightly
     +    surprised by D at first, but given that it does the right thing with
     +    `git commit` and even `git commit -a` (`git add` ignores entries that
     +    are marked SKIP_WORKTREE and thus doesn't delete them, and `commit -a`
     +    is similar), it seems logical to me.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/unpack-trees.c b/unpack-trees.c
       --- a/unpack-trees.c
       +++ b/unpack-trees.c
     -@@
     - 		fprintf(stderr, _("Aborting\n"));
     - }
     - 
     -+/*
     -+ * display all the "error" messages as warnings
     -+ */
     -+static void display_warning_msgs(struct unpack_trees_options *o)
     -+{
     -+	int e, i;
     -+	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
     -+		struct string_list *rejects = &o->unpack_rejects[e];
     -+		if (rejects->nr > 0) {
     -+			struct strbuf path = STRBUF_INIT;
     -+			for (i = 0; i < rejects->nr; i++)
     -+				strbuf_addstr(&path, rejects->items[i].string);
     -+			warning(ERRORMSG(o, e), super_prefixed(path.buf));
     -+			strbuf_release(&path);
     -+		}
     -+		string_list_clear(rejects, 0);
     -+	}
     -+}
     -+
     - static int check_submodule_move_head(const struct cache_entry *ce,
     - 				     const char *old_id,
     - 				     const char *new_id,
      @@
       	goto done;
       }
     @@ -99,23 +84,15 @@
      + * Update SKIP_WORKTREE bits according to sparsity patterns, and update
      + * working directory to match.
      + *
     -+ * Returns
     -+ *   0: success with no warnings
     -+ *   1: success with warnings (warnings come either from (a) dirty changes
     -+ *           present in which case we avoid marking those paths as
     -+ *           SKIP_WORKTREE, or (b) from untracked files being in the way us
     -+ *           checking a file out of the index, in which case we leave the file
     -+ *           in the working tree alone while clearing SKIP_WORKTREE)
     -+ *   -1: failure to manipulate the resulting index
     -+ *   -2: failure to reflect the changes to the work tree.
     -+ *
      + * CE_NEW_SKIP_WORKTREE is used internally.
      + */
     -+int update_sparsity(struct unpack_trees_options *o)
     ++enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
      +{
     ++	enum update_sparsity_result ret = UPDATE_SPARSITY_SUCCESS;
      +	struct pattern_list pl;
     -+	int i, empty_worktree, ret = 0;
     ++	int i, empty_worktree;
      +	unsigned old_show_all_errors;
     ++	int free_pattern_list = 0;
      +
      +	old_show_all_errors = o->show_all_errors;
      +	o->show_all_errors = 1;
     @@ -128,17 +105,13 @@
      +
      +	trace_performance_enter();
      +
     ++	/* If we weren't given patterns, use the recorded ones */
      +	if (!o->pl) {
     -+		char *sparse = git_pathdup("info/sparse-checkout");
      +		memset(&pl, 0, sizeof(pl));
     -+		pl.use_cone_patterns = core_sparse_checkout_cone;
     -+		if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0) {
     -+			/* FIXME: Skip to check_updates()?? */
     -+			o->skip_sparse_checkout = 1;
     ++		free_pattern_list = 1;
     ++		populate_from_existing_patterns(o, &pl);
     ++		if (o->skip_sparse_checkout)
      +			goto skip_sparse_checkout;
     -+		} else
     -+			o->pl = &pl;
     -+		free(sparse);
      +	}
      +
      +	/* Set NEW_SKIP_WORKTREE on existing entries. */
     @@ -147,13 +120,13 @@
      +			       CE_NEW_SKIP_WORKTREE, o->verbose_update);
      +
      +	/* Then loop over entries and update/remove as needed */
     -+	ret = 0;
     ++	ret = UPDATE_SPARSITY_SUCCESS;
      +	empty_worktree = 1;
      +	for (i = 0; i < o->src_index->cache_nr; i++) {
      +		struct cache_entry *ce = o->src_index->cache[i];
      +
      +		if (apply_sparse_checkout(o->src_index, ce, o))
     -+			ret = 1;
     ++			ret = UPDATE_SPARSITY_WARNINGS;
      +
      +		if (!ce_skip_worktree(ce))
      +			empty_worktree = 0;
     @@ -167,17 +140,20 @@
      +	 * Do not allow users to do that.
      +	 */
      +	if (o->src_index->cache_nr && empty_worktree) {
     -+		ret = unpack_failed(o, "Sparse checkout leaves no entry on working directory");
     ++		unpack_failed(o, "Sparse checkout leaves no entry on working directory");
     ++		ret = UPDATE_SPARSITY_INDEX_UPDATE_FAILURES;
      +		goto done;
      +	}
      +
      +skip_sparse_checkout:
      +	if (check_updates(o, o->src_index))
     -+		ret = -2;
     ++		ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
      +
      +done:
     -+	display_warning_msgs(o);
     ++	display_error_msgs(o);
      +	o->show_all_errors = old_show_all_errors;
     ++	if (free_pattern_list)
     ++		clear_pattern_list(&pl);
      +	trace_performance_leave("update_sparsity");
      +	return ret;
      +}
     @@ -189,6 +165,20 @@
       diff --git a/unpack-trees.h b/unpack-trees.h
       --- a/unpack-trees.h
       +++ b/unpack-trees.h
     +@@
     + 	NB_UNPACK_TREES_ERROR_TYPES
     + };
     + 
     ++enum update_sparsity_result {
     ++	UPDATE_SPARSITY_SUCCESS = 0,
     ++	UPDATE_SPARSITY_WARNINGS = 1,
     ++	UPDATE_SPARSITY_INDEX_UPDATE_FAILURES = -1,
     ++	UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES = -2
     ++};
     ++
     + /*
     +  * Sets the list of user-friendly error messages to be used by the
     +  * command "cmd" (either merge or checkout), and show_all_errors to 1.
      @@
       int unpack_trees(unsigned n, struct tree_desc *t,
       		 struct unpack_trees_options *options);
  6:  892933752c6 ! 10:  27ed4a3f7a2 sparse-checkout: use new update_sparsity() function
     @@ -12,7 +12,11 @@
       --- a/builtin/sparse-checkout.c
       +++ b/builtin/sparse-checkout.c
      @@
     - 	int result = 0;
     + 
     + static int update_working_directory(struct pattern_list *pl)
     + {
     +-	int result = 0;
     ++	enum update_sparsity_result result;
       	struct unpack_trees_options o;
       	struct lock_file lock_file = LOCK_INIT;
      -	struct object_id oid;
     @@ -40,7 +44,6 @@
       	o.dst_index = r->index;
       	o.skip_sparse_checkout = 0;
       	o.pl = pl;
     --	o.keep_pattern_list = !!pl;
       
      -	resolve_undo_clear_index(r->index);
       	setup_work_tree();
     @@ -55,13 +58,13 @@
       
      -	if (!result) {
      -		prime_cache_tree(r, r->index, tree);
     -+	if (result == 1)
     ++	if (result == UPDATE_SPARSITY_WARNINGS)
      +		/*
      +		 * We don't do any special handling of warnings from untracked
      +		 * files in the way or dirty entries that can't be removed.
      +		 */
     -+		result = 0;
     -+	if (!result)
     ++		result = UPDATE_SPARSITY_SUCCESS;
     ++	if (result == UPDATE_SPARSITY_SUCCESS)
       		write_locked_index(r->index, &lock_file, COMMIT_LOCK);
      -	} else
      +	else
     @@ -141,13 +144,16 @@
      -	test_must_fail git -C dirty sparse-checkout disable &&
      +
      +	git -C dirty sparse-checkout init 2>err &&
     -+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
     ++	test_i18ngrep "error" err &&
     ++	test_i18ngrep "Cannot update sparse checkout" err &&
      +
      +	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
     -+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
     ++	test_i18ngrep "error" err &&
     ++	test_i18ngrep "Cannot update sparse checkout" err &&
      +
      +	git -C dirty sparse-checkout disable &&
     -+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
     ++	test_i18ngrep "error" err &&
     ++	test_i18ngrep "Cannot update sparse checkout" err &&
      +
       	git -C dirty reset --hard &&
       	git -C dirty sparse-checkout init &&
  -:  ----------- > 11:  79b9cc1df55 sparse-checkout: use improved unpack_trees porcelain messages
  -:  ----------- > 12:  2ba7bbdaee3 unpack-trees: move ERROR_WOULD_LOSE_SUBMODULE earlier
  -:  ----------- > 13:  203ece0ec2f unpack-trees: rename ERROR_* fields meant for warnings to WARNING_*
  -:  ----------- > 14:  57679c8e292 unpack-trees: split display_error_msgs() into two
  -:  ----------- > 15:  02a8e01f35b unpack-trees: make sparse path messages sound like warnings
  -:  ----------- > 16:  f664a6dcbb3 unpack-trees: provide warnings on sparse updates for unmerged paths too
  -:  ----------- > 17:  fa997a1c72f unpack-trees: failure to set SKIP_WORKTREE bits always just a warning
  7:  650db686342 ! 18:  5730f7d250a sparse-checkout: provide a new update subcommand
     @@ -1,6 +1,6 @@
      Author: Elijah Newren <newren@gmail.com>
      
     -    sparse-checkout: provide a new update subcommand
     +    sparse-checkout: provide a new reapply subcommand
      
          If commands like merge or rebase materialize files as part of their work,
          or a previous sparse-checkout command failed to update individual files
     @@ -16,13 +16,13 @@
       	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
       	as directory names as in the 'set' subcommand.
       
     -+'update'::
     -+	Update the sparseness of paths in the working tree based on the
     -+	existing patterns.  Commands like merge or rebase can materialize
     -+	paths to do their work (e.g. in order to show you a conflict), and
     -+	other sparse-checkout commands might fail to sparsify an individual
     -+	file (e.g. because it has unstaged changes or conflicts).  In such
     -+	cases, it can make sense to run `git sparse-checkout update` later
     ++'reapply::
     ++	Reapply the sparsity pattern rules to paths in the working tree.
     ++	Commands like merge or rebase can materialize paths to do their
     ++	work (e.g. in order to show you a conflict), and other
     ++	sparse-checkout commands might fail to sparsify an individual file
     ++	(e.g. because it has unstaged changes or conflicts).  In such
     ++	cases, it can make sense to run `git sparse-checkout reapply` later
      +	after cleaning up affected paths (e.g. resolving conflicts, undoing
      +	or committing changes, etc.).
      +
     @@ -38,7 +38,7 @@
       
       static char const * const builtin_sparse_checkout_usage[] = {
      -	N_("git sparse-checkout (init|list|set|add|disable) <options>"),
     -+	N_("git sparse-checkout (init|list|set|add|update|disable) <options>"),
     ++	N_("git sparse-checkout (init|list|set|add|reapply|disable) <options>"),
       	NULL
       };
       
     @@ -46,7 +46,7 @@
       	return modify_pattern_list(argc, argv, m);
       }
       
     -+static int sparse_checkout_update(int argc, const char **argv)
     ++static int sparse_checkout_reapply(int argc, const char **argv)
      +{
      +	repo_read_index(the_repository);
      +	return update_working_directory(NULL);
     @@ -59,8 +59,8 @@
       			return sparse_checkout_set(argc, argv, prefix, REPLACE);
       		if (!strcmp(argv[0], "add"))
       			return sparse_checkout_set(argc, argv, prefix, ADD);
     -+		if (!strcmp(argv[0], "update"))
     -+			return sparse_checkout_update(argc, argv);
     ++		if (!strcmp(argv[0], "reapply"))
     ++			return sparse_checkout_reapply(argc, argv);
       		if (!strcmp(argv[0], "disable"))
       			return sparse_checkout_disable(argc, argv);
       	}

-- 
gitgitgadget
