Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD451F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbfGZPxH (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35074 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGZPxG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so24737202pfn.2
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=voaOyNt1ls/1DKJ9qnWnK0I4vKppWXk+yACvJ4qB0Vw=;
        b=RTNW3D8Ob+QowZ0SeKfhgeAoVf9Bd4ao7N+aApTJAj6B6i6mK8KiXof4OL/JrO6sFL
         A5aORa/24bfgb+LAXwyrpIbXWdFnyudX7sIqCsepOSeTDJWnTq13ajKiz68S0XXQjcPE
         BITAhn/lGaEzP6flJKvxuz/jMo9FGtNRgqLB0LBBDWGm0hU8yyezSST260Rpykgm2Uhx
         AOHcZrQXS2q1kFAb0YozU/9N3x4n9s3qvRgqFojnJJznwcIJt4Gd1QxivYF7OxWzqRhT
         P9t8uSC22QlqUTxwL7uJnxmO9ihg1bi9ETykUuEW9ZHyOBClD6XACnAx1UtdZ8Oypqdk
         5Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=voaOyNt1ls/1DKJ9qnWnK0I4vKppWXk+yACvJ4qB0Vw=;
        b=YKCiPfit5hv4gy9XhQro+o+eTcgINQSo3nDC6V9RUd2gOF2YwrgCzuwIMVaSXzDuuv
         oMH9Yfd9xuFLaoTUpOqr9BsCS8RY3CB9uXsUv8aSo49uSmFxTefUxWPd9rIzuj+3FAAD
         J9sVMLYIB/zvLi7r8+8NJgJ7BiNvHw68N3u3IdOcJfGExaeFwSfUK5VFvyeWTkW/ogf8
         a3A1XlO6pdMcjVdaAdrY9Uqdne61dCATNm+dma9NNPqewd8nO2fILERCOG0LgS3/PPZX
         7cml6mCGd+VhGIkBUD4kImRxp+0M3IVAAWohFsPIER/9sxH9KhRCZD/a+KN2aMjHHfqa
         T30Q==
X-Gm-Message-State: APjAAAWOJl4/D46To6eMe6dDbypiQi2vqLRyuD3SQ3r6XG8PWDnQWvNB
        +DZdnlpQz8JLzFuM6Wiceg8fdQDD
X-Google-Smtp-Source: APXvYqz0k+1qTc+KDXCfZzZGRMm7h5kTmn8SsQimGrg3nBLieuEgZOQR8IpOl6Uizecm+21PfoQpaw==
X-Received: by 2002:a63:5f95:: with SMTP id t143mr31819255pgb.304.1564156384938;
        Fri, 26 Jul 2019 08:53:04 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:04 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 00/20] Cleanup merge API
Date:   Fri, 26 Jul 2019 08:52:38 -0700
Message-Id: <20190726155258.28561-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before writing a replacement merge strategy for recursive, I decided
to first cleanup the merge API -- streamlining merge-recursive.h and
making it more readable.  It includes some fixes I noticed along the
way, and two forgotten patches of mine from months ago that I rebased
and included at the end.  As with v1:

    While there are minor textual and semantic dependencies between
    these patches (preventing me from splitting up this series), they
    are logically separate and can be reviewed independently.

Notable highlights (full range-diff below):
  * Patches 8, 11, and 16 show up in the range-diff but have no
    substantive changes (these diffs merely represents the minimal
    changes needed to adjust due to the patches before them in the
    series).  A few other patches (e.g. 9, 12) had some real changes
    but most of the range-diff for those was similar noise.
  * [Patch 4] Fixed a (pre-existing) memory leak pointed out by Dscho
    and renamed a couple new variables to have a clearer meaning.
  * [Patch 5, new] Added a new commit that simplified and clarified the
    merge_trees() API by removing a parameter that would never be
    written anyway.  I also added a comment to the header summarizing
    some of Dscho's remarks about how best to pass the merge_bases to
    the merge_recursive() function.
  * [Patch 7] Made a small extension to write_index_as_tree(), deleted
    write_tree_from_memory(), and converted callers of the latter into
    callers of the former.  This patch replaces patches 6 & 7 from v1.
  * [Patch 9] The only substantive change was to update the new comment
    from patch 5 to also be affected by the parameter renaming that this
    patch was for.
  * [Patch 12] Added documentation carefully stating the expected outputs
    of merge_trees(), merge_recursive(), and merge_recursive_generic()
    and how they differ.
  * [Patch 15, new] I noticed a case where we could accidentally lose
    output and the memory holding it for future callers of merge_trees()
    and fixed it.
  * [Patch 20 (used to be 19)] Renamed a var Dscho pointed out as needing
    a better name, added some asserts around how merge_trees() and
    merge_recursive() have opposite expectations to avoid future callers
    messing it up, and simplified the new t6047 testcase.

Stuff I'd most welcome review on:
  * Patch 7 again -- do my changes to write_index_as_tree() look sane?
  * Patches 5 & 15, since they are new and not reviewed last time.

Some notes (same as last time, but still true):
  * Applies on master, merges cleanly to next & pu
  * Only patches 3, 5-7 touch anything outside of merge-recursive
  * I'm going to be out next week (July 29-Aug 3), so I can only
    respond to feedback today and tomorrow or it'll have to wait until
    the 5th.

Elijah Newren (20):
  merge-recursive: fix minor memory leak in error condition
  merge-recursive: remove another implicit dependency on the_repository
  Ensure index matches head before invoking merge machinery, round N
  merge-recursive: exit early if index != head
  merge-recursive: remove useless parameter in merge_trees()
  merge-recursive: don't force external callers to do our logging
  Use write_index_as_tree() in lieu of write_tree_from_memory()
  merge-recursive: fix some overly long lines
  merge-recursive: use common name for ancestors/common/base_list
  merge-recursive: rename 'mrtree' to 'result_tree', for clarity
  merge-recursive: rename merge_options argument to opt in header
  merge-recursive: move some definitions around to clean up the header
  merge-recursive: consolidate unnecessary fields in merge_options
  merge-recursive: comment and reorder the merge_options fields
  merge-recursive: avoid losing output and leaking memory holding that
    output
  merge-recursive: split internal fields into a separate struct
  merge-recursive: alphabetize include list
  merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
  merge-recursive: be consistent with assert
  merge-recursive: provide a better label for diff3 common ancestor

 builtin/checkout.c                |  10 +-
 builtin/merge-recursive.c         |   4 +
 builtin/stash.c                   |   2 +
 cache-tree.c                      |  36 +-
 cache-tree.h                      |   3 +-
 merge-recursive.c                 | 536 ++++++++++++++++++------------
 merge-recursive.h                 | 160 +++++----
 sequencer.c                       |   5 +-
 t/t3030-merge-recursive.sh        |   9 +-
 t/t6036-recursive-corner-cases.sh |   8 +-
 t/t6047-diff3-conflict-markers.sh | 189 +++++++++++
 11 files changed, 646 insertions(+), 316 deletions(-)
 create mode 100755 t/t6047-diff3-conflict-markers.sh

Range-diff:
 1:  28d4fb4710 =  1:  a640f0f2d0 merge-recursive: fix minor memory leak in error condition
 2:  5aa56bacce =  2:  34f0891d96 merge-recursive: remove another implicit dependency on the_repository
 3:  f38e2c4dcc =  3:  26739a7ed0 Ensure index matches head before invoking merge machinery, round N
 4:  858ec5c6e7 !  4:  76cb459b99 merge-recursive: exit early if index != head
    @@ -19,7 +19,8 @@
         other callers (which were fixed in the commit prior to this one).
     
         Make sure we do the index == head check at the beginning of the merge,
    -    and error out immediately if it fails.
    +    and error out immediately if it fails.  While we're at it, fix a small
    +    leak in the show-the-error codepath.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
    @@ -111,6 +112,7 @@
     +	if (repo_index_has_changes(opt->repo, head, &sb)) {
     +		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
     +		    sb.buf);
    ++		strbuf_release(&sb);
     +		return -1;
     +	}
     +
    @@ -128,14 +130,14 @@
     +		struct tree *common,
     +		struct tree **result)
     +{
    -+	int ret;
    ++	int clean;
     +
     +	if (merge_start(opt, head))
     +		return -1;
    -+	ret = merge_trees_internal(opt, head, merge, common, result);
    ++	clean = merge_trees_internal(opt, head, merge, common, result);
     +	merge_finalize(opt);
     +
    -+	return ret;
    ++	return clean;
     +}
     +
     +int merge_recursive(struct merge_options *opt,
    @@ -144,14 +146,14 @@
     +		    struct commit_list *ca,
     +		    struct commit **result)
     +{
    -+	int ret;
    ++	int clean;
     +
     +	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
     +		return -1;
    -+	ret = merge_recursive_internal(opt, h1, h2, ca, result);
    ++	clean = merge_recursive_internal(opt, h1, h2, ca, result);
     +	merge_finalize(opt);
     +
    -+	return ret;
    ++	return clean;
     +}
     +
      static struct commit *get_ref(struct repository *repo, const struct object_id *oid,
 -:  ---------- >  5:  2560458522 merge-recursive: remove useless parameter in merge_trees()
 5:  71c37a0928 =  6:  fb340fbe56 merge-recursive: don't force external callers to do our logging
 6:  286221dbf1 <  -:  ---------- Change call signature of write_tree_from_memory()
 7:  725bda6b1d <  -:  ---------- Move write_tree_from_memory() from merge-recursive to cache-tree
 -:  ---------- >  7:  884305a3a6 Use write_index_as_tree() in lieu of write_tree_from_memory()
 8:  d7fca78573 !  8:  870937b31f merge-recursive: fix some overly long lines
    @@ -54,7 +54,7 @@
      
      	for (iter = ca; iter; iter = iter->next) {
     @@
    - 	return ret;
    + 	return clean;
      }
      
     -static struct commit *get_ref(struct repository *repo, const struct object_id *oid,
 9:  6090301564 !  9:  5127b75ac4 merge-recursive: use common name for ancestors/common/base_list
    @@ -146,19 +146,19 @@
      int merge_trees(struct merge_options *opt,
      		struct tree *head,
      		struct tree *merge,
    --		struct tree *common,
    -+		struct tree *merge_base,
    - 		struct tree **result)
    +-		struct tree *common)
    ++		struct tree *merge_base)
      {
    - 	int ret;
    + 	int clean;
    + 	struct tree *ignored;
      
      	if (merge_start(opt, head))
      		return -1;
    --	ret = merge_trees_internal(opt, head, merge, common, result);
    -+	ret = merge_trees_internal(opt, head, merge, merge_base, result);
    +-	clean = merge_trees_internal(opt, head, merge, common, &ignored);
    ++	clean = merge_trees_internal(opt, head, merge, merge_base, &ignored);
      	merge_finalize(opt);
      
    - 	return ret;
    + 	return clean;
     @@
      int merge_recursive(struct merge_options *opt,
      		    struct commit *h1,
    @@ -167,15 +167,15 @@
     +		    struct commit_list *merge_bases,
      		    struct commit **result)
      {
    - 	int ret;
    + 	int clean;
      
      	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
      		return -1;
    --	ret = merge_recursive_internal(opt, h1, h2, ca, result);
    -+	ret = merge_recursive_internal(opt, h1, h2, merge_bases, result);
    +-	clean = merge_recursive_internal(opt, h1, h2, ca, result);
    ++	clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
      	merge_finalize(opt);
      
    - 	return ret;
    + 	return clean;
     @@
      int merge_recursive_generic(struct merge_options *opt,
      			    const struct object_id *head,
    @@ -212,6 +212,16 @@
      --- a/merge-recursive.h
      +++ b/merge-recursive.h
     @@
    +  *
    +  * NOTE: empirically, about a decade ago it was determined that with more
    +  *       than two merge bases, optimal behavior was found when the
    +- *       ancestors were passed in the order of oldest merge base to newest
    +- *       one.  Also, ancestors will be consumed (emptied) so make a copy if
    +- *       you need it.
    ++ *       merge_bases were passed in the order of oldest commit to newest
    ++ *       commit.  Also, merge_bases will be consumed (emptied) so make a
    ++ *       copy if you need it.
    +  */
      int merge_recursive(struct merge_options *o,
      		    struct commit *h1,
      		    struct commit *h2,
    @@ -219,15 +229,16 @@
     +		    struct commit_list *merge_bases,
      		    struct commit **result);
      
    - /* rename-detecting three-way merge, no recursion */
    + /*
    +@@
      int merge_trees(struct merge_options *o,
      		struct tree *head,
      		struct tree *merge,
    --		struct tree *common,
    -+		struct tree *merge_base,
    - 		struct tree **result);
    +-		struct tree *common);
    ++		struct tree *merge_base);
      
      /*
    +  * "git-merge-recursive" can be fed trees; wrap them into
     @@
      int merge_recursive_generic(struct merge_options *o,
      			    const struct object_id *head,
10:  33228a4b3d = 10:  daee364ce1 merge-recursive: rename 'mrtree' to 'result_tree', for clarity
11:  3be41685ad ! 11:  50a7a6f671 merge-recursive: rename merge_options argument to opt in header
    @@ -25,20 +25,25 @@
     +		opt->diff_detect_rename >= 0 ? opt->diff_detect_rename : 1;
      }
      
    - /* merge_trees() but with recursive ancestor consolidation */
    + /*
    +@@
    +  *       commit.  Also, merge_bases will be consumed (emptied) so make a
    +  *       copy if you need it.
    +  */
     -int merge_recursive(struct merge_options *o,
     +int merge_recursive(struct merge_options *opt,
      		    struct commit *h1,
      		    struct commit *h2,
      		    struct commit_list *merge_bases,
    - 		    struct commit **result);
    - 
    - /* rename-detecting three-way merge, no recursion */
    +@@
    +  * rename-detecting three-way merge, no recursion; result of merge is written
    +  * to opt->repo->index.
    +  */
     -int merge_trees(struct merge_options *o,
     +int merge_trees(struct merge_options *opt,
      		struct tree *head,
      		struct tree *merge,
    - 		struct tree *merge_base,
    + 		struct tree *merge_base);
     @@
       * "git-merge-recursive" can be fed trees; wrap them into
       * virtual commits and call merge_recursive() proper.
12:  b1c396e505 ! 12:  4e9e774dc5 merge-recursive: move some definitions around to clean up the header
    @@ -74,7 +74,12 @@
      	struct repository *repo;
      };
      
    --/*
    ++void init_merge_options(struct merge_options *opt, struct repository *repo);
    ++
    ++/* parse the option in s and update the relevant field of opt */
    ++int parse_merge_opt(struct merge_options *opt, const char *s);
    ++
    + /*
     - * For dir_rename_entry, directory names are stored as a full path from the
     - * toplevel of the repository and do not include a trailing '/'.  Also:
     - *
    @@ -83,7 +88,12 @@
     - *   new_dir:            final name of directory being renamed
     - *   possible_new_dirs:  temporary used to help determine new_dir; see comments
     - *                       in get_directory_renames() for details
    -- */
    ++ * RETURN VALUES: All the merge_* functions below return a value as follows:
    ++ *   > 0     Merge was clean
    ++ *   = 0     Merge had conflicts
    ++ *   < 0     Merge hit an unexpected and unrecoverable problem (e.g. disk
    ++ *             full) and aborted merge part-way through.
    +  */
     -struct dir_rename_entry {
     -	struct hashmap_entry ent; /* must be the first member! */
     -	char *dir;
    @@ -91,47 +101,80 @@
     -	struct strbuf new_dir;
     -	struct string_list possible_new_dirs;
     -};
    -+void init_merge_options(struct merge_options *opt, struct repository *repo);
    - 
    +-
     -struct collision_entry {
     -	struct hashmap_entry ent; /* must be the first member! */
     -	char *target_file;
     -	struct string_list source_files;
     -	unsigned reported_already:1;
     -};
    -+/* parse the option in s and update the relevant field of opt */
    -+int parse_merge_opt(struct merge_options *opt, const char *s);
      
     -static inline int merge_detect_rename(struct merge_options *opt)
     -{
     -	return opt->merge_detect_rename >= 0 ? opt->merge_detect_rename :
     -		opt->diff_detect_rename >= 0 ? opt->diff_detect_rename : 1;
     -}
    -+/* rename-detecting three-way merge, no recursion */
    ++/*
    ++ * rename-detecting three-way merge, no recursion.
    ++ *
    ++ * Outputs:
    ++ *   - See RETURN VALUES above
    ++ *   - No commit is created
    ++ *   - opt->repo->index has the new index
    ++ *   - $GIT_INDEX_FILE is not updated
    ++ *   - The working tree is updated with results of the merge
    ++ */
     +int merge_trees(struct merge_options *opt,
     +		struct tree *head,
     +		struct tree *merge,
    -+		struct tree *merge_base,
    -+		struct tree **result);
    ++		struct tree *merge_base);
      
    - /* merge_trees() but with recursive ancestor consolidation */
    + /*
    +  * merge_recursive is like merge_trees() but with recursive ancestor
    +- * consolidation, and when successful, it creates an actual commit
    +- * and writes its address to *result.
    ++ * consolidation and, if the commit is clean, creation of a commit.
    +  *
    +  * NOTE: empirically, about a decade ago it was determined that with more
    +  *       than two merge bases, optimal behavior was found when the
    +  *       merge_bases were passed in the order of oldest commit to newest
    +  *       commit.  Also, merge_bases will be consumed (emptied) so make a
    +  *       copy if you need it.
    ++ *
    ++ * Outputs:
    ++ *   - See RETURN VALUES above
    ++ *   - If merge is clean, a commit is created and its address written to *result
    ++ *   - opt->repo->index has the new index
    ++ *   - $GIT_INDEX_FILE is not updated
    ++ *   - The working tree is updated with results of the merge
    +  */
      int merge_recursive(struct merge_options *opt,
    + 		    struct commit *h1,
     @@
    - 		    struct commit_list *merge_bases,
      		    struct commit **result);
      
    --/* rename-detecting three-way merge, no recursion */
    + /*
    +- * rename-detecting three-way merge, no recursion; result of merge is written
    +- * to opt->repo->index.
    +- */
     -int merge_trees(struct merge_options *opt,
     -		struct tree *head,
     -		struct tree *merge,
    --		struct tree *merge_base,
    --		struct tree **result);
    +-		struct tree *merge_base);
     -
    - /*
    +-/*
     - * "git-merge-recursive" can be fed trees; wrap them into
     - * virtual commits and call merge_recursive() proper.
     + * merge_recursive_generic can operate on trees instead of commits, by
     + * wrapping the trees into virtual commits, and calling merge_recursive().
    ++ * It also writes out the in-memory index to disk if the merge is successful.
    ++ *
    ++ * Outputs:
    ++ *   - See RETURN VALUES above
    ++ *   - If merge is clean, a commit is created and its address written to *result
    ++ *   - opt->repo->index has the new index
    ++ *   - $GIT_INDEX_FILE is updated
    ++ *   - The working tree is updated with results of the merge
       */
      int merge_recursive_generic(struct merge_options *opt,
      			    const struct object_id *head,
13:  bc653085af = 13:  bf40502fd8 merge-recursive: consolidate unnecessary fields in merge_options
14:  28a8880890 = 14:  2c39a4be36 merge-recursive: comment and reorder the merge_options fields
 -:  ---------- > 15:  c1c71816eb merge-recursive: avoid losing output and leaking memory holding that output
15:  8937e231d9 ! 16:  be47a6bfdf merge-recursive: split internal fields into a separate struct
    @@ -525,12 +525,11 @@
      
      	unpack_trees_finish(opt);
      
    --	if (opt->call_depth && !(*result = write_tree_from_memory(opt->repo)))
    -+	if (opt->priv->call_depth &&
    -+	    !(*result = write_tree_from_memory(opt->repo)))
    - 		return -1;
    - 
    - 	return clean;
    +-	if (opt->call_depth) {
    ++	if (opt->priv->call_depth) {
    + 		struct object_id tree_id;
    + 		if (write_index_as_tree(&tree_id, opt->repo->index, NULL,
    + 					WRITE_TREE_FROM_MEMORY, NULL) ||
     @@
      
      	for (iter = merge_bases; iter; iter = iter->next) {
    @@ -566,14 +565,6 @@
      		*result = make_virtual_commit(opt->repo, result_tree,
      					      "merged tree");
      		commit_list_insert(h1, &(*result)->parents);
    - 		commit_list_insert(h2, &(*result)->parents->next);
    - 	}
    - 	flush_output(opt);
    --	if (!opt->call_depth && opt->buffer_output < 2)
    -+	if (!opt->priv->call_depth && opt->buffer_output < 2)
    - 		strbuf_release(&opt->obuf);
    - 	return clean;
    - }
     @@
      		return -1;
      	}
    @@ -583,8 +574,12 @@
      	return 0;
      }
      
    -@@
    + static void merge_finalize(struct merge_options *opt)
      {
    + 	flush_output(opt);
    +-	if (!opt->call_depth && opt->buffer_output < 2)
    ++	if (!opt->priv->call_depth && opt->buffer_output < 2)
    + 		strbuf_release(&opt->obuf);
      	if (show(opt, 2))
      		diff_warn_rename_limit("merge.renamelimit",
     -				       opt->needed_rename_limit, 0);
16:  0ba049d6a2 = 17:  f440ee1e64 merge-recursive: alphabetize include list
17:  43eed3490b = 18:  40161dc352 merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
18:  3afc6d987a = 19:  d6158e555d merge-recursive: be consistent with assert
19:  ac7176acaf ! 20:  814a65ecab merge-recursive: provide a better label for diff3 common ancestor
    @@ -81,7 +81,7 @@
      	struct tree *result_tree;
      	int clean;
     +	int num_merge_bases;
    -+	struct strbuf commit_name = STRBUF_INIT;
    ++	struct strbuf merge_base_abbrev = STRBUF_INIT;
      
      	if (show(opt, 4)) {
      		output(opt, 4, _("Merging:"));
    @@ -103,10 +103,10 @@
     +		opt->ancestor = "<empty tree>";
     +		break;
     +	case 1:
    -+		strbuf_add_unique_abbrev(&commit_name,
    ++		strbuf_add_unique_abbrev(&merge_base_abbrev,
     +					 &merged_merge_bases->object.oid,
     +					 DEFAULT_ABBREV);
    -+		opt->ancestor = commit_name.buf;
    ++		opt->ancestor = merge_base_abbrev.buf;
     +		break;
     +	default:
     +		opt->ancestor = "merged common ancestors";
    @@ -117,10 +117,28 @@
      				     repo_get_commit_tree(opt->repo,
      							  merged_merge_bases),
      				     &result_tree);
    -+	strbuf_release(&commit_name);
    ++	strbuf_release(&merge_base_abbrev);
      	if (clean < 0) {
      		flush_output(opt);
      		return clean;
    +@@
    + 	int clean;
    + 	struct tree *ignored;
    + 
    ++	assert(opt->ancestor != NULL);
    ++
    + 	if (merge_start(opt, head))
    + 		return -1;
    + 	clean = merge_trees_internal(opt, head, merge, merge_base, &ignored);
    +@@
    + {
    + 	int clean;
    + 
    ++	assert(opt->ancestor == NULL);
    ++
    + 	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
    + 		return -1;
    + 	clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
     
      diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
      --- a/t/t6036-recursive-corner-cases.sh
    @@ -196,20 +214,11 @@
     +	(
     +		cd no_merge_base &&
     +
    -+		git checkout --orphan L &&
    -+		test_seq 1 9 >content &&
    -+		echo "A" >>content &&
    -+		git add content &&
    -+		test_tick &&
    -+		git commit -m "version L1 of content" &&
    ++		git checkout -b L &&
    ++		test_commit A content A &&
     +
    -+		# Create R
     +		git checkout --orphan R &&
    -+		test_seq 1 9 >content &&
    -+		echo "10" >>content &&
    -+		git add content &&
    -+		test_tick &&
    -+		git commit -m "version R1 of content"
    ++		test_commit B content B
     +	)
     +'
     +
    @@ -241,30 +250,32 @@
     +	(
     +		cd unique_merge_base &&
     +
    -+		test_seq 1 9 >content &&
    -+		git add content &&
    -+		test_tick &&
    -+		git commit -m initial &&
    ++		test_commit base content "1
    ++2
    ++3
    ++4
    ++5
    ++" &&
     +
     +		git branch L &&
     +		git branch R &&
     +
    -+		# Create L1
     +		git checkout L &&
    -+		test_seq 0 9 >content &&
    -+		echo "A" >>content &&
    -+		git add content &&
    -+		test_tick &&
    -+		git commit -m "version L1 of content" &&
    ++		test_commit L content "1
    ++2
    ++3
    ++4
    ++5
    ++7" &&
     +
    -+		# Create R1
     +		git checkout R &&
    -+		test_seq 0 9 >content &&
    -+		echo "ten" >>content &&
    -+		git add content &&
    -+		git mv content renamed &&
    -+		test_tick &&
    -+		git commit -m "version R1 of content"
    ++		git rm content &&
    ++		test_commit R renamed "1
    ++2
    ++3
    ++4
    ++5
    ++six"
     +	)
     +'
     +
    @@ -300,30 +311,32 @@
     +	(
     +		cd multiple_merge_bases &&
     +
    -+		# Create some related files now
    -+		test_seq 1 9 >content &&
    -+		git add content &&
    -+		test_tick &&
    -+		git commit -m initial &&
    ++		test_commit initial content "1
    ++2
    ++3
    ++4
    ++5" &&
     +
     +		git branch L &&
     +		git branch R &&
     +
     +		# Create L1
     +		git checkout L &&
    -+		test_seq 0 9 >content &&
    -+		git add content &&
    -+		test_tick &&
    -+		git commit -m "version L1 of content" &&
    -+		git tag L1 &&
    ++		test_commit L1 content "0
    ++1
    ++2
    ++3
    ++4
    ++5" &&
     +
     +		# Create R1
     +		git checkout R &&
    -+		test_seq 1 10 >content &&
    -+		git add content &&
    -+		test_tick &&
    -+		git commit -m "verson R1 of content" &&
    -+		git tag R1 &&
    ++		test_commit R1 content "1
    ++2
    ++3
    ++4
    ++5
    ++6" &&
     +
     +		# Create L2
     +		git checkout L &&
    @@ -335,20 +348,23 @@
     +
     +		# Create L3
     +		git checkout L &&
    -+		test_seq 0 9 >content &&
    -+		echo "A" >>content &&
    -+		git add content &&
    -+		test_tick &&
    -+		git commit -m "version L3 of content" &&
    ++		test_commit L3 content "0
    ++1
    ++2
    ++3
    ++4
    ++5
    ++A" &&
     +
     +		# Create R3
     +		git checkout R &&
    -+		test_seq 0 9 >content &&
    -+		echo "ten" >>content &&
    -+		git add content &&
    -+		git mv content renamed &&
    -+		test_tick &&
    -+		git commit -m "version R3 of content"
    ++		git rm content &&
    ++		test_commit R3 renamed "0
    ++2
    ++3
    ++4
    ++5
    ++six"
     +	)
     +'
     +
-- 
2.22.0.550.g71c37a0928.dirty

