Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69895C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 03:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2834120716
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 03:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSldAmex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCODqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:46:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33595 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgCODqN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 23:46:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id z65so17545437ede.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 20:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yGyt7AQ8zTjyW31n3uBMr0ANdqgK0pfoIKf0uKriifI=;
        b=hSldAmexDa0VFj/pu3sFHSkw0IwBVkWKYIQgzY1RurWqkRoKEUpwFSKYTdjwLbRXal
         yvwAI3YklPlHmWwIZ8ijHKg7zDtoY+8rzzBW7lkAl/zUO+fOiBfT+s+QnzbTwQFGrVHC
         faQTcN8SL5KjAU5JRHaGGYh8csTtlGna6v6THb1IQX3uqNje+qzvmYbJDk4/ZtQUe+Kd
         GaE68nlHXLnmgLUIJEE2+hyl8XNOvQT0tJ15EJwrbOy54AjtU5dbWQSVUX4lwgie7FOH
         lomqFegnB3IkWSCdDxEB945eRCWUXSFs9JiDjzwAEqOoCEi8NgUefh+dPYJNRgp8wBFp
         QLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yGyt7AQ8zTjyW31n3uBMr0ANdqgK0pfoIKf0uKriifI=;
        b=DDiCrbswhtpiS84ftyXwJNVC/1lshNczJWXFojTRfMyxoLLGvw0Jifhf72OOB7ASxr
         zG067ym1NvibrA7Ls3GU3C76O5c0uge7rNcgFBbI6jkPzgOKJkbCht5VhTYv1zz174AK
         coh1ZuCAtMQRCT51JE7zHXDw2lvdexD1wQuS6j254wG6W+hqDVLbWflgxy6XlHZxloSC
         7BKMw7E8qRKqj0h4CyOF1qTjJf4ZFPCeoRnrRWiqjr/oootB0MV7G2Z7ghFq0ZY7p6E7
         LEV91GaGspTkxKK6KsVTyGUBC/8yvV7O1ScXf8L/ZKX1ExrbSO/9wa1wE9FXBNVwDYzj
         8Z3Q==
X-Gm-Message-State: ANhLgQ0ZXcejv8EL4FKput2fFAdFj7iIXKZ9JGGmXPhXiL3MWP9Wwf3o
        Bm0FSdaJhf+sPGjSaZiNsvms11SS
X-Google-Smtp-Source: ADFU+vv2cW6oq4+yoMTTCT9kVYNWOjBd0hH3/pUGaIszeOEICQnIcYbkvwIQyPuJWZEjIU+cMCWcZw==
X-Received: by 2002:a05:6402:1d2d:: with SMTP id dh13mr16840028edb.276.1584169898541;
        Sat, 14 Mar 2020 00:11:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm4053338eju.35.2020.03.14.00.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 00:11:38 -0700 (PDT)
Message-Id: <9f13a2e8c64d47a5b3a4a2a96451decaf548ca4e.1584169893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Mar 2020 07:11:31 +0000
Subject: [PATCH 5/7] unpack-trees: add a new update_sparsity() function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previously, the only way to update the SKIP_WORKTREE bits for various
paths was invoking `git read-tree -mu HEAD` or calling the same code
that this codepath invoked.  This however had a number of problems.
Let's look at all the various cases:

  Flipping SKIP_WORKTREE -> !SKIP_WORKTREE (materializing files):
    A) There is no file in the way
    B) There is an untracked file in the way
  Flipping !SKIP_WORKTREE -> SKIP_WORKTREE (removing files):
    C) The path is clean
    D) The path is unmerged
    E) The path has unstaged changes
    F) The path has staged changes (differs from HEAD)

For `git read-tree -mu HEAD`, the behavior is as follows:
    A) Materialize the file, as expected
    B) Refuse to make *any* changes (to this path or any others)
    C) Remove the file, as expected
    D) Refuse to make *any* changes (to this path or any others)
    E) Refuse to make *any* changes (to this path or any others)
    F) Removes the file from the working copy AND resets the index
       to match HEAD

Refusing to modify files that could result in data loss as in cases B,
D, and E is good, but refusing to work on any other paths is very
problematic for users.  If they are in the middle of a rebase or have
made modifications to files that bring in more dependencies, then for
their build to work they need to update the sparse paths -- which they
are prevented from doing.  Sometimes they stage the files and re-try,
at which point they run into case F and believe that their changes are
lost.  (Even if they come ask an expert, they have to trawl through
their loose objects looking for which ones match which files.)

Add a new update_sparsity() function which behaves as follows in these
cases:
    A) Materialize the file, as expected
    B) Leave the file in the working copy alone, clear the SKIP_WORKTREE
       bit, and print a warning (thus leaving them in a state where
       status will report the file as modified, which seems logical).
    C) Remove the file, as expected
    D) Do NOT mark this path as SKIP_WORKTREE, but allow others paths
       to be updated.
    E) Do NOT mark this path as SKIP_WORKTREE and print a warning about
       the dirty path, but allow other paths to be updated.
    F) Mark the path as SKIP_WORKTREE, but do not revert the version
       stored in the index to match HEAD; leave the contents alone.

I tried a different behavior for B (leave the SKIP_WORKTREE bit set),
but found it very surprising and counter-intuitive (e.g. the user sees
it is present along with all the other files in that directory, tries to
stage it, but git add ignores it since the SKIP_WORKTREE bit is set).
A, B, C, and E all seem like optimal behavior to me.  D may be as well,
though I wonder if printing a warning would be an improvement.  Some
might be slightly surprised by F at first, but given that it does the
right thing with `git commit` and even `git commit -a` (add ignores
entries that are marked SKIP_WORKTREE and thus doesn't delete them, and
commit -a is similar), it seems logical to me.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.h |   2 +
 2 files changed, 108 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 8f10ac91ce1..21234635573 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -255,6 +255,25 @@ static void display_error_msgs(struct unpack_trees_options *o)
 		fprintf(stderr, _("Aborting\n"));
 }
 
+/*
+ * display all the "error" messages as warnings
+ */
+static void display_warning_msgs(struct unpack_trees_options *o)
+{
+	int e, i;
+	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
+		struct string_list *rejects = &o->unpack_rejects[e];
+		if (rejects->nr > 0) {
+			struct strbuf path = STRBUF_INIT;
+			for (i = 0; i < rejects->nr; i++)
+				strbuf_addstr(&path, rejects->items[i].string);
+			warning(ERRORMSG(o, e), super_prefixed(path.buf));
+			strbuf_release(&path);
+		}
+		string_list_clear(rejects, 0);
+	}
+}
+
 static int check_submodule_move_head(const struct cache_entry *ce,
 				     const char *old_id,
 				     const char *new_id,
@@ -1708,6 +1727,93 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	goto done;
 }
 
+/*
+ * Update SKIP_WORKTREE bits according to sparsity patterns, and update
+ * working directory to match.
+ *
+ * Returns
+ *   0: success with no warnings
+ *   1: success with warnings (warnings come either from (a) dirty changes
+ *           present in which case we avoid marking those paths as
+ *           SKIP_WORKTREE, or (b) from untracked files being in the way us
+ *           checking a file out of the index, in which case we leave the file
+ *           in the working tree alone while clearing SKIP_WORKTREE)
+ *   -1: failure to manipulate the resulting index
+ *   -2: failure to reflect the changes to the work tree.
+ *
+ * CE_NEW_SKIP_WORKTREE is used internally.
+ */
+int update_sparsity(struct unpack_trees_options *o)
+{
+	struct pattern_list pl;
+	int i, empty_worktree, ret = 0;
+	unsigned old_show_all_errors;
+
+	old_show_all_errors = o->show_all_errors;
+	o->show_all_errors = 1;
+
+	/* Sanity checks */
+	if (!o->update || o->index_only || o->skip_sparse_checkout)
+		BUG("update_sparsity() is for reflecting sparsity patterns in working directory");
+	if (o->src_index != o->dst_index || o->fn)
+		BUG("update_sparsity() called wrong");
+
+	trace_performance_enter();
+
+	if (!o->pl) {
+		char *sparse = git_pathdup("info/sparse-checkout");
+		memset(&pl, 0, sizeof(pl));
+		pl.use_cone_patterns = core_sparse_checkout_cone;
+		if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0) {
+			/* FIXME: Skip to check_updates()?? */
+			o->skip_sparse_checkout = 1;
+			goto skip_sparse_checkout;
+		} else
+			o->pl = &pl;
+		free(sparse);
+	}
+
+	/* Set NEW_SKIP_WORKTREE on existing entries. */
+	mark_all_ce_unused(o->src_index);
+	mark_new_skip_worktree(o->pl, o->src_index, 0,
+			       CE_NEW_SKIP_WORKTREE, o->verbose_update);
+
+	/* Then loop over entries and update/remove as needed */
+	ret = 0;
+	empty_worktree = 1;
+	for (i = 0; i < o->src_index->cache_nr; i++) {
+		struct cache_entry *ce = o->src_index->cache[i];
+
+		if (apply_sparse_checkout(o->src_index, ce, o))
+			ret = 1;
+
+		if (!ce_skip_worktree(ce))
+			empty_worktree = 0;
+
+	}
+
+	/*
+	 * Sparse checkout is meant to narrow down checkout area
+	 * but it does not make sense to narrow down to empty working
+	 * tree. This is usually a mistake in sparse checkout rules.
+	 * Do not allow users to do that.
+	 */
+	if (o->src_index->cache_nr && empty_worktree) {
+		ret = unpack_failed(o, "Sparse checkout leaves no entry on working directory");
+		goto done;
+	}
+
+skip_sparse_checkout:
+	if (check_updates(o, o->src_index))
+		ret = -2;
+
+done:
+	display_warning_msgs(o);
+	o->show_all_errors = old_show_all_errors;
+	trace_performance_leave("update_sparsity");
+	return ret;
+}
+
 /* Here come the merge functions */
 
 static int reject_merge(const struct cache_entry *ce,
diff --git a/unpack-trees.h b/unpack-trees.h
index ae1557fb804..5d1a77ae249 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -90,6 +90,8 @@ struct unpack_trees_options {
 int unpack_trees(unsigned n, struct tree_desc *t,
 		 struct unpack_trees_options *options);
 
+int update_sparsity(struct unpack_trees_options *options);
+
 int verify_uptodate(const struct cache_entry *ce,
 		    struct unpack_trees_options *o);
 
-- 
gitgitgadget

