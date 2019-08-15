Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7DB1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbfHOVlP (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33089 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbfHOVlP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so2003002pfq.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fRsjJodhEPq6e6I6tkzDB/Qf9m8nb0Bfb2fXx6hJw4=;
        b=NVO+0k5/PdDUwDr1sWIpzJ4dL6c1mftYGc+ML5eaasq+csOm177bjs5m7TXkwKyEhp
         0IkSDKdtzT/9ckHIGcd1vJTRrVHVfAqKMUyqoegqPs2M6Agjo2R2Ses+taMChEtDg5XF
         Zq23U74Kq0zHiOlkqJzOh2d1aOFUzN3yQB1NQMSusDkNCC7lDthPnmA8o7kzxHoVVzrC
         pitSmzdGUO+G9a9iLAv18ZqAQcM0yLuuFxiaQPAiL4HZplsL4ZuPIbVYYIIYPMWv/8Yu
         OJTM70XQEDL/N442QQX9FUMnPUxJtaOtA4fmrZ3L8lW3Bl7eBO3sug0I2XQH5WnRe2Vt
         5SJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fRsjJodhEPq6e6I6tkzDB/Qf9m8nb0Bfb2fXx6hJw4=;
        b=qJrbLwfVQmCG/EvRfPBiY3w9wrWKsXzdrCRvXHbbihaZXbVbY7oPvpf2xqwYwYz1ST
         qNoBeTNe9Qk/hceTwLjN5ZbXzZvSclWf8cgCxdO8c4SKeqVTMUBa4ftmIm3TQkPULCV2
         uBAfZV5uV3iu9KDgtRSNsOWgUDrItMMgdEf3ATXyX5U0gvD84iD3cb2H0aozBxk0vq3+
         SluTfbD2vUePqIpKfDy+go6l8QpwwZHDsDUugvTimhd5eJyl7iK/pHVRjthAdQuWiZ7V
         jtDlCOdtkeeCgy7lNNdJuQH6qJAoTHWdkw2D/Me2DF7Gaeurbfm81p1uYgHc+Icpv/m7
         v57g==
X-Gm-Message-State: APjAAAUxHXb+qFre+R3ah5MOdatYqwj+2vvPrRA/78flXZd/B4TeIz6O
        bblpJ5ApdyRewkhB96mj5AumWN+m
X-Google-Smtp-Source: APXvYqyYAa2sEgN8uGXsAvp3ARgTkKIj6huAMQx9Q5+CEs8NLMJyK2UUFPzDuogEL4uxpkC4g9iIZA==
X-Received: by 2002:a63:5823:: with SMTP id m35mr5125574pgb.329.1565905273547;
        Thu, 15 Aug 2019 14:41:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:12 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 00/24] Clean up merge API
Date:   Thu, 15 Aug 2019 14:40:29 -0700
Message-Id: <20190815214053.16594-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before writing a replacement merge strategy for recursive, I decided
to first cleanup the merge API -- streamlining merge-recursive.h and
making it more readable.

Thanks to Dscho and Junio for feedback on v1 & v2.

Changes since v2:
  * Addressed feedback from Junio and Dscho
    * splitting a couple patches they highlighted as needing splitting
    * fixed up several commit messages
    * refactored cache-tree write-index-as-tree functions to share code
    * created a separate commit with more sanity checks for merge_options
  * Rebased on master (due to en/disable-dir-rename-in-recursive-merge)
  * Found and fixed a minor bug in checkout; put this and related patches
    at the beginning of the series
  * Incorporated a patch from Stolee, though I removed the repo-settings
    bits to make our patch series independent, and modified it to update
    more existing code to use the new enum values.

Things I'd like reviewers to focus on, in priority order:
  * Patch 12 -- I'm still unsure about cache-tree stuff
  * The new patches (2, 3, 5, 23); in more detail:
    * Patch 5 from Stolee -- I modified his original patch a fair amount
      but left him as author; it's a simple patch, but extra eyes to
      verify I didn't blame him for some nasty mistake of mine would be
      good.
    * Patch 2 fixes a minor issue with checkout -m
    * Patch 23 is the more thorough sanity checks Junio suggested
    * Patch 3 was mostly split out from what is now patch 4, so it was
      mostly reviewed before but it now ties in nicely with patch 2.

Derrick Stolee (1):
  merge-recursive: introduce an enum for detect_directory_renames values

Elijah Newren (23):
  merge-recursive: be consistent with assert
  checkout: provide better conflict hunk description with detached HEAD
  merge-recursive: enforce opt->ancestor != NULL when calling
    merge_trees()
  merge-recursive: provide a better label for diff3 common ancestor
  merge-recursive: future-proof update_file_flags() against memory leaks
  merge-recursive: remove another implicit dependency on the_repository
  Ensure index matches head before invoking merge machinery, round N
  merge-recursive: exit early if index != head
  merge-recursive: remove useless parameter in merge_trees()
  merge-recursive: don't force external callers to do our logging
  cache-tree: share code between functions writing an index as a tree
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
  merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
  merge-recursive: add sanity checks for relevant merge_options
  merge-recursive: alphabetize include list

 builtin/am.c                      |   2 +-
 builtin/checkout.c                |  14 +-
 builtin/merge-recursive.c         |   4 +
 builtin/stash.c                   |   2 +
 cache-tree.c                      |  81 +++--
 cache-tree.h                      |   3 +-
 merge-recursive.c                 | 571 ++++++++++++++++++------------
 merge-recursive.h                 | 164 +++++----
 sequencer.c                       |   5 +-
 t/t3030-merge-recursive.sh        |   9 +-
 t/t6036-recursive-corner-cases.sh |   8 +-
 t/t6047-diff3-conflict-markers.sh | 189 ++++++++++
 12 files changed, 718 insertions(+), 334 deletions(-)
 create mode 100755 t/t6047-diff3-conflict-markers.sh

Range-diff:
19:  d6158e555d =  1:  21f1e04dc9 merge-recursive: be consistent with assert
 -:  ---------- >  2:  ac24702773 checkout: provide better conflict hunk description with detached HEAD
 -:  ---------- >  3:  fd14ed9490 merge-recursive: enforce opt->ancestor != NULL when calling merge_trees()
20:  814a65ecab !  4:  540a1d17d7 merge-recursive: provide a better label for diff3 common ancestor
    @@ Commit message
             1:   <abbreviated commit hash>
             0:   "<empty tree>"
     
    -    Also, the code in merge_3way making use of opt->ancestor was overly
    -    complex because it tried to handle the case of opt->ancestor being NULL.
    -    We always set it first, though, so just add an assert that opt->ancestor
    -    is not NULL and simplify the surrounding code.
    -
         Tests have also been added to check that we get the right ancestor name
         for each of the three cases.
     
    +    Also, since merge_recursive() and merge_trees() have polar opposite
    +    pre-conditions for opt->ancestor, document merge_recursive()'s
    +    pre-condition with an assertion.  (An assertion was added to
    +    merge_trees() already a few commits ago.)  The differences in
    +    pre-conditions stem from two factors: (1) merge_trees() does not recurse
    +    and thus does not have multiple sub-merges to worry about -- each of
    +    which would require a different value for opt->ancestor, (2)
    +    merge_trees() is only passed trees rather than commits and thus cannot
    +    internally guess as good of a label.  Thus, while external callers of
    +    merge_trees() are required to provide a non-NULL opt->ancestor,
    +    merge_recursive() expects to set this value itself.
    +
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
      ## merge-recursive.c ##
    -@@ merge-recursive.c: static int merge_3way(struct merge_options *opt,
    - {
    - 	mmfile_t orig, src1, src2;
    - 	struct ll_merge_options ll_opts = {0};
    --	char *base_name, *name1, *name2;
    -+	char *base, *name1, *name2;
    - 	int merge_status;
    - 
    - 	ll_opts.renormalize = opt->renormalize;
    -@@ merge-recursive.c: static int merge_3way(struct merge_options *opt,
    - 		}
    - 	}
    - 
    --	assert(a->path && b->path && o->path);
    --	if (strcmp(a->path, b->path) ||
    --	    (opt->ancestor != NULL && strcmp(a->path, o->path) != 0)) {
    --		base_name = opt->ancestor == NULL ? NULL :
    --			mkpathdup("%s:%s", opt->ancestor, o->path);
    -+	assert(a->path && b->path && o->path && opt->ancestor);
    -+	if (strcmp(a->path, b->path) || strcmp(a->path, o->path) != 0) {
    -+		base  = mkpathdup("%s:%s", opt->ancestor, o->path);
    - 		name1 = mkpathdup("%s:%s", branch1, a->path);
    - 		name2 = mkpathdup("%s:%s", branch2, b->path);
    - 	} else {
    --		base_name = opt->ancestor == NULL ? NULL :
    --			mkpathdup("%s", opt->ancestor);
    -+		base  = mkpathdup("%s", opt->ancestor);
    - 		name1 = mkpathdup("%s", branch1);
    - 		name2 = mkpathdup("%s", branch2);
    - 	}
    -@@ merge-recursive.c: static int merge_3way(struct merge_options *opt,
    - 	read_mmblob(&src1, &a->oid);
    - 	read_mmblob(&src2, &b->oid);
    - 
    --	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
    -+	merge_status = ll_merge(result_buf, a->path, &orig, base,
    - 				&src1, name1, &src2, name2,
    - 				opt->repo->index, &ll_opts);
    - 
    --	free(base_name);
    -+	free(base);
    - 	free(name1);
    - 	free(name2);
    - 	free(orig.ptr);
    -@@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
    - 	struct commit *merged_merge_bases;
    - 	struct tree *result_tree;
    +@@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
    + 	struct commit *merged_common_ancestors;
    + 	struct tree *mrtree;
      	int clean;
     +	int num_merge_bases;
     +	struct strbuf merge_base_abbrev = STRBUF_INIT;
    ++
    ++	if (!opt->call_depth)
    ++		assert(opt->ancestor == NULL);
      
      	if (show(opt, 4)) {
      		output(opt, 4, _("Merging:"));
    -@@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
    +@@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
      			output_commit_title(opt, iter->item);
      	}
      
    -+	num_merge_bases = commit_list_count(merge_bases);
    - 	merged_merge_bases = pop_commit(&merge_bases);
    - 	if (merged_merge_bases == NULL) {
    ++	num_merge_bases = commit_list_count(ca);
    + 	merged_common_ancestors = pop_commit(&ca);
    + 	if (merged_common_ancestors == NULL) {
      		/* if there is no common ancestor, use an empty tree */
    -@@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
    - 	if (!opt->priv->call_depth)
    +@@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
    + 	if (!opt->call_depth)
      		repo_read_index(opt->repo);
      
     -	opt->ancestor = "merged common ancestors";
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
     +		break;
     +	case 1:
     +		strbuf_add_unique_abbrev(&merge_base_abbrev,
    -+					 &merged_merge_bases->object.oid,
    ++					 &merged_common_ancestors->object.oid,
     +					 DEFAULT_ABBREV);
     +		opt->ancestor = merge_base_abbrev.buf;
     +		break;
     +	default:
     +		opt->ancestor = "merged common ancestors";
     +	}
    - 	clean = merge_trees_internal(opt,
    - 				     repo_get_commit_tree(opt->repo, h1),
    - 				     repo_get_commit_tree(opt->repo, h2),
    - 				     repo_get_commit_tree(opt->repo,
    - 							  merged_merge_bases),
    - 				     &result_tree);
    + 	clean = merge_trees(opt, get_commit_tree(h1), get_commit_tree(h2),
    + 			    get_commit_tree(merged_common_ancestors),
    + 			    &mrtree);
     +	strbuf_release(&merge_base_abbrev);
      	if (clean < 0) {
      		flush_output(opt);
      		return clean;
    -@@ merge-recursive.c: int merge_trees(struct merge_options *opt,
    - 	int clean;
    - 	struct tree *ignored;
    - 
    -+	assert(opt->ancestor != NULL);
    -+
    - 	if (merge_start(opt, head))
    - 		return -1;
    - 	clean = merge_trees_internal(opt, head, merge, merge_base, &ignored);
    -@@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
    - {
    - 	int clean;
    - 
    -+	assert(opt->ancestor == NULL);
    -+
    - 	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
    - 		return -1;
    - 	clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
     
      ## t/t6036-recursive-corner-cases.sh ##
     @@ t/t6036-recursive-corner-cases.sh: test_expect_success 'check nested conflicts' '
 -:  ---------- >  5:  19ff6a9503 merge-recursive: introduce an enum for detect_directory_renames values
 1:  a640f0f2d0 !  6:  5e44146da1 merge-recursive: fix minor memory leak in error condition
    @@ Metadata
     Author: Elijah Newren <newren@gmail.com>
     
      ## Commit message ##
    -    merge-recursive: fix minor memory leak in error condition
    +    merge-recursive: future-proof update_file_flags() against memory leaks
     
    -    Returning before freeing the allocated buffer is suboptimal; as with
    -    elsewhere in the same function, make sure buf gets free'd.
    +    There is a 'free_buf' label to which all but one of the error paths in
    +    update_file_flags() jump; that error case involves a NULL buf and is
    +    thus not a memory leak.  However, make that error case execute the same
    +    deallocation code anyway so that if anyone adds any additional memory
    +    allocations or deallocations, then all error paths correctly deallocate
    +    resources.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
 2:  34f0891d96 <  -:  ---------- merge-recursive: remove another implicit dependency on the_repository
 -:  ---------- >  7:  df210eb029 merge-recursive: remove another implicit dependency on the_repository
 3:  26739a7ed0 !  8:  74dd7b8f59 Ensure index matches head before invoking merge machinery, round N
    @@ Commit message
         So, load the index in builtin/merge-recursive.c, reload the in-memory
         index in builtin/stash.c, and modify the t3030 testcase to correctly
         setup the index and make sure that the test fails in the expected way
    -    (meaning it reports a rename/rename conflict).
    +    (meaning it reports a rename/rename conflict).  This makes sure that
    +    all callers actually make the index match head.  The next commit will
    +    then enforce the condition that index matches head earlier so this
    +    problem doesn't return in the future.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
 4:  76cb459b99 !  9:  f04eba4184 merge-recursive: exit early if index != head
    @@ merge-recursive.c: static int process_entry(struct merge_options *opt,
      	int code, clean;
     -	struct strbuf sb = STRBUF_INIT;
     -
    +-	assert(opt->ancestor != NULL);
    +-
     -	if (!opt->call_depth && repo_index_has_changes(opt->repo, head, &sb)) {
     -		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
     -		    sb.buf);
    @@ merge-recursive.c: static struct commit_list *reverse_commit_list(struct commit_
      {
      	struct commit_list *iter;
      	struct commit *merged_common_ancestors;
    +@@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
    + 	int num_merge_bases;
    + 	struct strbuf merge_base_abbrev = STRBUF_INIT;
    + 
    +-	if (!opt->call_depth)
    +-		assert(opt->ancestor == NULL);
    +-
    + 	if (show(opt, 4)) {
    + 		output(opt, 4, _("Merging:"));
    + 		output_commit_title(opt, h1);
     @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
      		saved_b2 = opt->branch2;
      		opt->branch1 = "Temporary merge branch 1";
    @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
      			return -1;
      		opt->branch1 = saved_b1;
     @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
    - 		repo_read_index(opt->repo);
    - 
    - 	opt->ancestor = "merged common ancestors";
    + 	default:
    + 		opt->ancestor = "merged common ancestors";
    + 	}
     -	clean = merge_trees(opt,
     -			    repo_get_commit_tree(opt->repo, h1),
     -			    repo_get_commit_tree(opt->repo, h2),
    @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
     +				     repo_get_commit_tree(opt->repo,
     +							  merged_common_ancestors),
     +				     &mrtree);
    + 	strbuf_release(&merge_base_abbrev);
      	if (clean < 0) {
      		flush_output(opt);
    - 		return clean;
     @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
      	return clean;
      }
    @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
     +{
     +	struct strbuf sb = STRBUF_INIT;
     +
    -+	assert(opt->branch1 && opt->branch2);
    -+
     +	if (repo_index_has_changes(opt->repo, head, &sb)) {
     +		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
     +		    sb.buf);
    @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
     +{
     +	int clean;
     +
    ++	assert(opt->ancestor != NULL);
    ++
     +	if (merge_start(opt, head))
     +		return -1;
     +	clean = merge_trees_internal(opt, head, merge, common, result);
    @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
     +{
     +	int clean;
     +
    ++	assert(opt->ancestor == NULL);
    ++
     +	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
     +		return -1;
     +	clean = merge_recursive_internal(opt, h1, h2, ca, result);
 5:  2560458522 ! 10:  8688d40739 merge-recursive: remove useless parameter in merge_trees()
    @@ merge-recursive.c: static void merge_finalize(struct merge_options *opt)
      	int clean;
     +	struct tree *ignored;
      
    + 	assert(opt->ancestor != NULL);
    + 
      	if (merge_start(opt, head))
      		return -1;
     -	clean = merge_trees_internal(opt, head, merge, common, result);
 6:  fb340fbe56 ! 11:  a92d460707 merge-recursive: don't force external callers to do our logging
    @@ Commit message
         merge_finalize() function to make sure that all three entry points run
         this function.
     
    +    Note that there are two external callers of merge_trees(), one in
    +    sequencer.c and one in builtin/checkout.c.  The one in sequencer.c is
    +    cleaned up by this patch and just transfers where the call to
    +    diff_warn_rename_limit() is made; the one in builtin/checkout.c is for
    +    switching to a different commit and in the very rare case where the
    +    warning might be triggered, it would probably be helpful to include
    +    (e.g. if someone is modifying a file that has been renamed in moving to
    +    the other commit, but there are so many renames between the commits that
    +    the limit kicks in and none are detected, it may help to have an
    +    explanation about why they got a delete/modify conflict instead of a
    +    proper content merge in a renamed file).
    +
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
      ## merge-recursive.c ##
 7:  884305a3a6 <  -:  ---------- Use write_index_as_tree() in lieu of write_tree_from_memory()
 -:  ---------- > 12:  dec0ea7409 cache-tree: share code between functions writing an index as a tree
 8:  870937b31f = 13:  b51f3d1924 merge-recursive: fix some overly long lines
 9:  5127b75ac4 ! 14:  a069cc4cca merge-recursive: use common name for ancestors/common/base_list
    @@ merge-recursive.c: static struct commit_list *reverse_commit_list(struct commit_
     +	struct commit *merged_merge_bases;
      	struct tree *mrtree;
      	int clean;
    - 
    + 	int num_merge_bases;
     @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
      		output_commit_title(opt, h2);
      	}
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
      			output_commit_title(opt, iter->item);
      	}
      
    +-	num_merge_bases = commit_list_count(ca);
     -	merged_common_ancestors = pop_commit(&ca);
     -	if (merged_common_ancestors == NULL) {
    ++	num_merge_bases = commit_list_count(merge_bases);
     +	merged_merge_bases = pop_commit(&merge_bases);
     +	if (merged_merge_bases == NULL) {
      		/* if there is no common ancestor, use an empty tree */
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
      			return err(opt, _("merge returned no commit"));
      	}
      
    +@@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
    + 		break;
    + 	case 1:
    + 		strbuf_add_unique_abbrev(&merge_base_abbrev,
    +-					 &merged_common_ancestors->object.oid,
    ++					 &merged_merge_bases->object.oid,
    + 					 DEFAULT_ABBREV);
    + 		opt->ancestor = merge_base_abbrev.buf;
    + 		break;
     @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
      				     repo_get_commit_tree(opt->repo, h1),
      				     repo_get_commit_tree(opt->repo, h2),
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
     -							  merged_common_ancestors),
     +							  merged_merge_bases),
      				     &mrtree);
    + 	strbuf_release(&merge_base_abbrev);
      	if (clean < 0) {
    - 		flush_output(opt);
     @@ merge-recursive.c: static void merge_finalize(struct merge_options *opt)
      int merge_trees(struct merge_options *opt,
      		struct tree *head,
    @@ merge-recursive.c: static void merge_finalize(struct merge_options *opt)
      {
      	int clean;
      	struct tree *ignored;
    +@@ merge-recursive.c: int merge_trees(struct merge_options *opt,
      
      	if (merge_start(opt, head))
      		return -1;
    @@ merge-recursive.c: int merge_trees(struct merge_options *opt,
      		    struct commit **result)
      {
      	int clean;
    +@@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
      
      	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
      		return -1;
10:  daee364ce1 ! 15:  93a3ce6b88 merge-recursive: rename 'mrtree' to 'result_tree', for clarity
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
     -	struct tree *mrtree;
     +	struct tree *result_tree;
      	int clean;
    - 
    - 	if (show(opt, 4)) {
    + 	int num_merge_bases;
    + 	struct strbuf merge_base_abbrev = STRBUF_INIT;
     @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
      				     repo_get_commit_tree(opt->repo, h2),
      				     repo_get_commit_tree(opt->repo,
      							  merged_merge_bases),
     -				     &mrtree);
     +				     &result_tree);
    + 	strbuf_release(&merge_base_abbrev);
      	if (clean < 0) {
      		flush_output(opt);
    - 		return clean;
    +@@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
      	}
      
      	if (opt->call_depth) {
11:  50a7a6f671 = 16:  1b1df10c11 merge-recursive: rename merge_options argument to opt in header
12:  4e9e774dc5 = 17:  1526977a85 merge-recursive: move some definitions around to clean up the header
13:  bf40502fd8 ! 18:  c90f2f15cd merge-recursive: consolidate unnecessary fields in merge_options
    @@ merge-recursive.c: void init_merge_options(struct merge_options *opt,
     -	opt->diff_detect_rename = -1;
     -	opt->merge_detect_rename = -1;
     +	opt->detect_renames = -1;
    - 	opt->detect_directory_renames = 1;
    + 	opt->detect_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
      	merge_recursive_config(opt);
      	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
     @@ merge-recursive.c: int parse_merge_opt(struct merge_options *opt, const char *s)
    @@ merge-recursive.c: int parse_merge_opt(struct merge_options *opt, const char *s)
     
      ## merge-recursive.h ##
     @@ merge-recursive.h: struct merge_options {
    - 	long xdl_opts;
    - 	int verbosity;
    - 	int detect_directory_renames;
    + 		MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
    + 		MERGE_DIRECTORY_RENAMES_TRUE = 2
    + 	} detect_directory_renames;
     -	int diff_detect_rename;
     -	int merge_detect_rename;
     -	int diff_rename_limit;
14:  2c39a4be36 ! 19:  6d930dba72 merge-recursive: comment and reorder the merge_options fields
    @@ merge-recursive.c: void init_merge_options(struct merge_options *opt,
      	opt->repo = repo;
     +
     +	opt->detect_renames = -1;
    -+	opt->detect_directory_renames = 1;
    ++	opt->detect_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
     +	opt->rename_limit = -1;
     +
      	opt->verbosity = 2;
    @@ merge-recursive.c: void init_merge_options(struct merge_options *opt,
     +
      	opt->renormalize = 0;
     -	opt->detect_renames = -1;
    --	opt->detect_directory_renames = 1;
    +-	opt->detect_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
     +
     +	string_list_init(&opt->df_conflict_file_set, 1);
     +
    @@ merge-recursive.h: struct commit;
      	const char *ancestor;
      	const char *branch1;
      	const char *branch2;
    +-	enum {
    +-		MERGE_RECURSIVE_NORMAL = 0,
    +-		MERGE_RECURSIVE_OURS,
    +-		MERGE_RECURSIVE_THEIRS
    +-	} recursive_variant;
    +-	const char *subtree_shift;
    +-	unsigned buffer_output; /* 1: output at end, 2: keep buffered */
    +-	unsigned renormalize : 1;
    +-	long xdl_opts;
    +-	int verbosity;
     +
     +	/* rename related options */
     +	int detect_renames;
    -+	int detect_directory_renames;
    -+	int rename_limit;
    -+	int rename_score;
    -+	int show_rename_progress;
    + 	enum {
    + 		MERGE_DIRECTORY_RENAMES_NONE = 0,
    + 		MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
    + 		MERGE_DIRECTORY_RENAMES_TRUE = 2
    + 	} detect_directory_renames;
    +-	int detect_renames;
    + 	int rename_limit;
    + 	int rename_score;
    +-	int needed_rename_limit;
    + 	int show_rename_progress;
     +
     +	/* xdiff-related options (patience, ignore whitespace, ours/theirs) */
     +	long xdl_opts;
    - 	enum {
    - 		MERGE_RECURSIVE_NORMAL = 0,
    - 		MERGE_RECURSIVE_OURS,
    - 		MERGE_RECURSIVE_THEIRS
    - 	} recursive_variant;
    --	const char *subtree_shift;
    ++	enum {
    ++		MERGE_RECURSIVE_NORMAL = 0,
    ++		MERGE_RECURSIVE_OURS,
    ++		MERGE_RECURSIVE_THEIRS
    ++	} recursive_variant;
     +
     +	/* console output related options */
     +	int verbosity;
    - 	unsigned buffer_output; /* 1: output at end, 2: keep buffered */
    ++	unsigned buffer_output; /* 1: output at end, 2: keep buffered */
     +	struct strbuf obuf;     /* output buffer */
     +
     +	/* miscellaneous control options */
     +	const char *subtree_shift;
    - 	unsigned renormalize : 1;
    --	long xdl_opts;
    --	int verbosity;
    --	int detect_directory_renames;
    --	int detect_renames;
    --	int rename_limit;
    --	int rename_score;
    --	int needed_rename_limit;
    --	int show_rename_progress;
    ++	unsigned renormalize : 1;
     +
     +	/* internal fields used by the implementation (do NOT set these) */
      	int call_depth;
15:  c1c71816eb = 20:  ec3e15f6a8 merge-recursive: avoid losing output and leaking memory holding that output
16:  be47a6bfdf ! 21:  7edfac7048 merge-recursive: split internal fields into a separate struct
    @@ merge-recursive.c: static int merge_submodule(struct merge_options *opt,
      	/* store a in result in case we fail */
      	oidcpy(result, a);
     @@ merge-recursive.c: static int handle_rename_via_dir(struct merge_options *opt,
    - 	int mark_conflicted = (opt->detect_directory_renames == 1);
    + 			       MERGE_DIRECTORY_RENAMES_CONFLICT);
      	assert(ren->dir_rename_original_dest);
      
     -	if (!opt->call_depth && would_lose_untracked(opt, dest->path)) {
    @@ merge-recursive.c: static struct diff_queue_struct *get_diffpairs(struct merge_o
      
      	ret = xmalloc(sizeof(*ret));
      	*ret = diff_queued_diff;
    +@@ merge-recursive.c: static int detect_and_process_renames(struct merge_options *opt,
    + 
    + 	if ((opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE) ||
    + 	    (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT &&
    +-	     !opt->call_depth)) {
    ++	     !opt->priv->call_depth)) {
    + 		dir_re_head = get_directory_renames(head_pairs);
    + 		dir_re_merge = get_directory_renames(merge_pairs);
    + 
     @@ merge-recursive.c: static int handle_content_merge(struct merge_file_info *mfi,
      		reason = _("add/add");
      
    @@ merge-recursive.c: static int merge_trees_internal(struct merge_options *opt,
      
      	unpack_trees_finish(opt);
      
    --	if (opt->call_depth) {
    -+	if (opt->priv->call_depth) {
    - 		struct object_id tree_id;
    - 		if (write_index_as_tree(&tree_id, opt->repo->index, NULL,
    - 					WRITE_TREE_FROM_MEMORY, NULL) ||
    +-	if (opt->call_depth &&
    ++	if (opt->priv->call_depth &&
    + 	    !(*result = write_inmemory_index_as_tree(opt->repo)))
    + 		return -1;
    + 
     @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
      
      	for (iter = merge_bases; iter; iter = iter->next) {
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
     +	if (!opt->priv->call_depth)
      		repo_read_index(opt->repo);
      
    - 	opt->ancestor = "merged common ancestors";
    + 	switch (num_merge_bases) {
     @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
      		return clean;
      	}
18:  40161dc352 = 22:  9a381873c2 merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
 -:  ---------- > 23:  c6bc8a196f merge-recursive: add sanity checks for relevant merge_options
17:  f440ee1e64 = 24:  2123e9e4e4 merge-recursive: alphabetize include list
-- 
2.23.0.rc2.32.g2123e9e4e4

