Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099C1C433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 03:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJ2DnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 23:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ2DnM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 23:43:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A91C8D63
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 20:42:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so7638159wme.5
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 20:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzAXIvkXQR6tmHQcdxR/tn1VA1JMPCu/cWahejBx4so=;
        b=Ufh3/Yz+wVZU35HEwZ2HpA0UhWtCm0WZGp0ttUYC1EddoeljLBs1VgKs9lhqg86Ved
         Id4wOZHehrHOJSvD0S9sT2FVkwqGs7cDDFjBC8JS94fTgN55CN7n4Xus2W/Q32i0eQFS
         1yh4Zw8q2/jtIBzfCk8xv7+hCaKT3Ae3oxUshgpSEclqYi2ywpBSYdfya9SivOUn2N9z
         t01UjZripsC3torc3gwjtD6wEs2guYrcMJ9uoQS6ztk7OStpCrabaz/B7FRukNlittSf
         U2xKOo6p/a6Uc80WYm08YKBDklKVV3jQFQHiC01Y5J1Iow/11bAvaI8J8zCXqJiKzG6B
         WTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzAXIvkXQR6tmHQcdxR/tn1VA1JMPCu/cWahejBx4so=;
        b=yt6UsL4xsvqWb1B0NB25Hg6Q4QbcIriudySz09NzzbZ03uW6brukTZR/JnnP63EjOr
         ZKPzsJBucvlmEOCRnYsoU0UNTzRFszJnpv7EvbMV1rL8orLwWmj+0a0OJW5RsdmYfl67
         wsKOID2YlOL1vyjpdj54DQ57IYXaxYRk0xPRKDEFcDOaK9rBNcuYdPdfQmmoLfOkzKzt
         4AALNVXDuVLqI7iXubwUWwD2J3IV9TQjAwu+OP/AUDy7eu6vyU6mg/o8nmGx7NQjf1WW
         u0RVHISAKxw5Vuzf7cOO9z99lZqLQ4KRriigEiYZ+foYivpvsq4RMjFEtumKjB9SdByn
         FwrA==
X-Gm-Message-State: ACrzQf0Xo6sTs15L6ibbHllJolwh1b4de+/NDkvwhO/nMb8HihbSCSAl
        TrloKaAHgBRZpMidA+8TcxLKLPfhktc=
X-Google-Smtp-Source: AMsMyM7na8Q0Fp/1ywsxjCJKJA8l7aKrCS9AVryl+gsVyuXST0NapAdEZikZSADOi9nb1qj5Kq3U8g==
X-Received: by 2002:a05:600c:46c7:b0:3c6:f3e6:1f13 with SMTP id q7-20020a05600c46c700b003c6f3e61f13mr11350487wmo.62.1667014976473;
        Fri, 28 Oct 2022 20:42:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d6585000000b00228cd9f6349sm298325wru.106.2022.10.28.20.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:42:55 -0700 (PDT)
Message-Id: <pull.1397.v3.git.1667014975042.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v2.git.1666958144017.gitgitgadget@gmail.com>
References: <pull.1397.v2.git.1666958144017.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Oct 2022 03:42:54 +0000
Subject: [PATCH v3] merge-tree.c: add --merge-base=<commit> option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, kylezhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyle Zhao <kylezhao@tencent.com>

This patch will give our callers more flexibility to use `git merge-tree`,
such as:

    git merge-tree --write-tree --merge-base=branch^ HEAD branch

This does a merge of HEAD and branch, but uses branch^ as the merge-base.

And the reason why using an option flag instead of a positional argument
is to allow additional commits passed to merge-tree to be handled via an
octopus merge in the future.

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
    merge-tree: allow specifying a base commit when --write-tree is passed
    
    Thanks for Elijah's work. I'm very excited that merge-ort is integrated
    into the git merge-tree, which means that we can use merge-ort in bare
    repositories to optimize merge performance.
    
    In this patch, I introduce a new --merge-base=<commit> option to allow
    callers to specify a merge-base for the merge. This may allow users to
    implement git cherry-pick and git rebase in bare repositories with git
    merge-tree cmd.
    
    Changes since v1:
    
     * Changed merge_incore_recursive() to merge_incore_nonrecursive() when
       merge-base is specified.
     * Fixed c style problem.
     * Moved commit lookup/die logic out to the parsing logic in
       cmd_merge_tree().
     * use test_commit for test
    
    Changes since v2:
    
     * commit message
     * Rebased on top of en/merge-tree-sequence.
     * Set opt.ancestor to o->merge_base. Because opt.ancestor is a *char.
       To make it easier to pass parameters, I moved
       lookup_commit_reference_by_name() to real_ merge() again.
     * Added test comment.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1397%2Fkeyu98%2Fkz%2Fmerge-tree-option-merge-base-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1397/keyu98/kz/merge-tree-option-merge-base-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1397

Range-diff vs v2:

 1:  ab4e5d5ad08 ! 1:  554cbde49e8 merge-tree.c: add --merge-base=<commit> option
     @@ Commit message
      
              git merge-tree --write-tree --merge-base=branch^ HEAD branch
      
     -    It would cherry-pick the commit at the tip of the branch on top of the
     -    current commit even if the repository is bare.
     +    This does a merge of HEAD and branch, but uses branch^ as the merge-base.
     +
     +    And the reason why using an option flag instead of a positional argument
     +    is to allow additional commits passed to merge-tree to be handled via an
     +    octopus merge in the future.
      
          Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
      
     @@ builtin/merge-tree.c
       #include "merge-ort.h"
       #include "object-store.h"
      @@ builtin/merge-tree.c: struct merge_tree_options {
     - 	int allow_unrelated_histories;
       	int show_messages;
       	int name_only;
     -+	const struct commit *base_commit;
     + 	int use_stdin;
     ++	const char *merge_base;
       };
       
       static int real_merge(struct merge_tree_options *o,
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
      -	if (!merge_bases && !o->allow_unrelated_histories)
      -		die(_("refusing to merge unrelated histories"));
      -	merge_bases = reverse_commit_list(merge_bases);
     -+	if (o->base_commit) {
     ++	if (o->merge_base) {
     ++		struct commit *base_commit;
      +		struct tree *base_tree, *parent1_tree, *parent2_tree;
      +
     -+		opt.ancestor = "specified merge base";
     -+		base_tree = get_commit_tree(o->base_commit);
     ++		base_commit = lookup_commit_reference_by_name(o->merge_base);
     ++		if (!base_commit)
     ++			die(_("could not lookup commit %s"), o->merge_base);
     ++
     ++		opt.ancestor = o->merge_base;
     ++		base_tree = get_commit_tree(base_commit);
      +		parent1_tree = get_commit_tree(parent1);
      +		parent2_tree = get_commit_tree(parent2);
      +		merge_incore_nonrecursive(&opt, base_tree, parent1_tree, parent2_tree, &result);
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       	if (result.clean < 0)
       		die(_("failure to merge"));
       
     -@@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     - 
     - int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - {
     -+	const char *merge_base = NULL;
     - 	struct merge_tree_options o = { .show_messages = -1 };
     - 	int expected_remaining_argc;
     - 	int original_argc;
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 			   &o.allow_unrelated_histories,
     - 			   N_("allow merging unrelated histories"),
     + 			   &o.use_stdin,
     + 			   N_("perform multiple merges, one per line of input"),
       			   PARSE_OPT_NONEG),
      +		OPT_STRING(0, "merge-base",
     -+			 &merge_base,
     -+			 N_("commit"),
     -+			 N_("specify a merge-base for the merge")),
     ++			   &o.merge_base,
     ++			   N_("commit"),
     ++			   N_("specify a merge-base for the merge")),
       		OPT_END()
       	};
       
     -@@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 		usage_with_options(merge_tree_usage, mt_options);
     - 
     - 	/* Do the relevant type of merge */
     --	if (o.mode == MODE_REAL)
     -+	if (o.mode == MODE_REAL) {
     -+		if (merge_base) {
     -+			o.base_commit = lookup_commit_reference_by_name(merge_base);
     -+			if (!o.base_commit)
     -+				die(_("could not lookup commit %s"), merge_base);
     -+		}
     - 		return real_merge(&o, argv[0], argv[1], prefix);
     -+	}
     - 	else
     - 		return trivial_merge(argv[0], argv[1], argv[2]);
     - }
      
       ## t/t4301-merge-tree-write-tree.sh ##
     -@@ t/t4301-merge-tree-write-tree.sh: test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository
     - 	test_must_fail git -C read-only merge-tree side1 side2
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success '--stdin with both a successful and a conflicted merge' '
     + 	test_cmp expect actual
       '
       
     ++# specify merge-base as parent of branch2
     ++# git merge-tree --write-tree --merge-base=c2 c1 c3
     ++#   Commit c1: add file1
     ++#   Commit c2: add file2 after c1
     ++#   Commit c3: add file3 after c2
     ++#   Expected: add file3, and file2 does NOT appear
     ++
      +test_expect_success 'specify merge-base as parent of branch2' '
      +	# Setup
      +	git init base-b2-p && (


 Documentation/git-merge-tree.txt |  4 ++++
 builtin/merge-tree.c             | 39 ++++++++++++++++++++++++--------
 t/t4301-merge-tree-write-tree.sh | 30 ++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 04bcc416e6e..d9dacb2ce54 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -64,6 +64,10 @@ OPTIONS
 	share no common history.  This flag can be given to override that
 	check and make the merge proceed anyway.
 
+--merge-base=<commit>::
+	Instead of finding the merge-bases for <branch1> and <branch2>,
+	specify a merge-base for the merge.
+
 [[OUTPUT]]
 OUTPUT
 ------
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index fe853aa8f91..cd25aac6ba6 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,6 +3,7 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "help.h"
+#include "commit.h"
 #include "commit-reach.h"
 #include "merge-ort.h"
 #include "object-store.h"
@@ -403,6 +404,7 @@ struct merge_tree_options {
 	int show_messages;
 	int name_only;
 	int use_stdin;
+	const char *merge_base;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -432,16 +434,31 @@ static int real_merge(struct merge_tree_options *o,
 	opt.branch1 = branch1;
 	opt.branch2 = branch2;
 
-	/*
-	 * Get the merge bases, in reverse order; see comment above
-	 * merge_incore_recursive in merge-ort.h
-	 */
-	merge_bases = get_merge_bases(parent1, parent2);
-	if (!merge_bases && !o->allow_unrelated_histories)
-		die(_("refusing to merge unrelated histories"));
-	merge_bases = reverse_commit_list(merge_bases);
+	if (o->merge_base) {
+		struct commit *base_commit;
+		struct tree *base_tree, *parent1_tree, *parent2_tree;
+
+		base_commit = lookup_commit_reference_by_name(o->merge_base);
+		if (!base_commit)
+			die(_("could not lookup commit %s"), o->merge_base);
+
+		opt.ancestor = o->merge_base;
+		base_tree = get_commit_tree(base_commit);
+		parent1_tree = get_commit_tree(parent1);
+		parent2_tree = get_commit_tree(parent2);
+		merge_incore_nonrecursive(&opt, base_tree, parent1_tree, parent2_tree, &result);
+	} else {
+		/*
+		 * Get the merge bases, in reverse order; see comment above
+		 * merge_incore_recursive in merge-ort.h
+		 */
+		merge_bases = get_merge_bases(parent1, parent2);
+		if (!merge_bases && !o->allow_unrelated_histories)
+			die(_("refusing to merge unrelated histories"));
+		merge_bases = reverse_commit_list(merge_bases);
+		merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
+	}
 
-	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
 	if (result.clean < 0)
 		die(_("failure to merge"));
 
@@ -515,6 +532,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &o.use_stdin,
 			   N_("perform multiple merges, one per line of input"),
 			   PARSE_OPT_NONEG),
+		OPT_STRING(0, "merge-base",
+			   &o.merge_base,
+			   N_("commit"),
+			   N_("specify a merge-base for the merge")),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index cac85591b52..5b0073d3dcd 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -860,4 +860,34 @@ test_expect_success '--stdin with both a successful and a conflicted merge' '
 	test_cmp expect actual
 '
 
+# specify merge-base as parent of branch2
+# git merge-tree --write-tree --merge-base=c2 c1 c3
+#   Commit c1: add file1
+#   Commit c2: add file2 after c1
+#   Commit c3: add file3 after c2
+#   Expected: add file3, and file2 does NOT appear
+
+test_expect_success 'specify merge-base as parent of branch2' '
+	# Setup
+	git init base-b2-p && (
+		cd base-b2-p &&
+		test_commit c1 file1 &&
+		test_commit c2 file2 &&
+		test_commit c3 file3
+	) &&
+	# Testing
+	(
+		cd base-b2-p &&
+		TREE_OID=$(git merge-tree --write-tree --merge-base=c2 c1 c3) &&
+
+		q_to_tab <<-EOF >expect &&
+		100644 blob $(git rev-parse c1:file1)Qfile1
+		100644 blob $(git rev-parse c3:file3)Qfile3
+		EOF
+
+		git ls-tree $TREE_OID >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

base-commit: ec1edbcb56ac05e9980299b05924c5c1b51d68b4
-- 
gitgitgadget
