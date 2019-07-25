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
	by dcvr.yhbt.net (Postfix) with ESMTP id 941C61F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403854AbfGYRqi (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46940 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403838AbfGYRqf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id k189so4354893pgk.13
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YeeYwat7JALVGhdXq5ZkezVWI6aOMzWfQJrXvaHy75k=;
        b=vYPavgN8ZdkUyd9rxSQthhwYZDBcfY0aRoDyo63e+EzJJ2DPVUnihIAkyUsfRr0ZAg
         GNotFQ5ATa05XHc8hi5bNtyA1koYFPkrv8cojXN3NzWRM3ZNPvYeO8m7eaguVOQD2cxn
         qF5hhdUFQCPuq6Y9Z+BDnMbCOrqLjzyXmE9MgkRV6Bx0FRW6sqTZJk12N8W5iyGbyiTl
         C0dvOZy6Wno2IT3L6LHLVPQgz/AFa2g9ZIxj7thhW9tiQP/jDMYvPmAs/iTuiycCXX7m
         EHB3ZS+FRHrghW8KqdqSUrQx0iUJ+SuJWoW6GsRzszFlQEhguFEMHOOXFHAXzaGp9/kt
         XIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YeeYwat7JALVGhdXq5ZkezVWI6aOMzWfQJrXvaHy75k=;
        b=VOeN+DdRPsIdMj3NdghIk+M1Ma+O/ut8m5Z9yGJNrMVtxgdyQtmJshFLh7SivANlBd
         BfeiMjV0mxBCanrufGRfoinXdSqWtSUykXYMjPAuvL8EiMxVm/LcTHdb8zBPO4i47i4I
         4icZ2dz7qTrY1IkvhFqZQgjsOHmeaGOGBxIwXVq7AEoYHuMy7aJIV6sKXZeEo1x0Tlta
         je8lcpWTpoH1aWiwZvCkETuD9o/aGDcioFUo8xvAQuYFQRlwxjo/jfDFEmIgJ40knDQ3
         zVqrwc1sJ5StsXut/ybdPZ7i0utqrDPr02wIRFiHHs7VQhKCy2gwQg+CocH+IleaDpQb
         9x2g==
X-Gm-Message-State: APjAAAViBWTxmpPSZWGAcn0iW66EkXzRj5mu44XyLIh0BUA9rRNuf7lL
        nZV2IwZ6NyUhYon09b/mCKkEFm+Y
X-Google-Smtp-Source: APXvYqwKcm6qUC70vXapt59e9Lq1ls6E3J0ZA/vSq5WtuGsEp70jojphBK1a3lmZmrtHL8gC1b7dRg==
X-Received: by 2002:a17:90a:cb97:: with SMTP id a23mr92083415pju.67.1564076794241;
        Thu, 25 Jul 2019 10:46:34 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:33 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 19/19] merge-recursive: provide a better label for diff3 common ancestor
Date:   Thu, 25 Jul 2019 10:46:11 -0700
Message-Id: <20190725174611.14802-20-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 7ca56aa07619 ("merge-recursive: add a label for ancestor",
2010-03-20), a label was added for the '||||||' line to make it have
the more informative heading '|||||| merged common ancestors', with
the statement:

    It would be nicer to use a more informative label.  Perhaps someone
    will provide one some day.

This chosen label was perfectly reasonable when recursiveness kicks in,
i.e. when there are multiple merge bases.  (I can't think of a better
label in such cases.)  But it is actually somewhat misleading when there
is a unique merge base or no merge base.  Change this based on the
number of merge bases:
    >=2: "merged common ancestors"
    1:   <abbreviated commit hash>
    0:   "<empty tree>"

Also, the code in merge_3way making use of opt->ancestor was overly
complex because it tried to handle the case of opt->ancestor being NULL.
We always set it first, though, so just add an assert that opt->ancestor
is not NULL and simplify the surrounding code.

Tests have also been added to check that we get the right ancestor name
for each of the three cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                 |  35 ++++--
 t/t6036-recursive-corner-cases.sh |   8 +-
 t/t6047-diff3-conflict-markers.sh | 191 ++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+), 14 deletions(-)
 create mode 100755 t/t6047-diff3-conflict-markers.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index 4cd6599296..8ac53cacdf 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1034,7 +1034,7 @@ static int merge_3way(struct merge_options *opt,
 {
 	mmfile_t orig, src1, src2;
 	struct ll_merge_options ll_opts = {0};
-	char *base_name, *name1, *name2;
+	char *base, *name1, *name2;
 	int merge_status;
 
 	ll_opts.renormalize = opt->renormalize;
@@ -1058,16 +1058,13 @@ static int merge_3way(struct merge_options *opt,
 		}
 	}
 
-	assert(a->path && b->path && o->path);
-	if (strcmp(a->path, b->path) ||
-	    (opt->ancestor != NULL && strcmp(a->path, o->path) != 0)) {
-		base_name = opt->ancestor == NULL ? NULL :
-			mkpathdup("%s:%s", opt->ancestor, o->path);
+	assert(a->path && b->path && o->path && opt->ancestor);
+	if (strcmp(a->path, b->path) || strcmp(a->path, o->path) != 0) {
+		base  = mkpathdup("%s:%s", opt->ancestor, o->path);
 		name1 = mkpathdup("%s:%s", branch1, a->path);
 		name2 = mkpathdup("%s:%s", branch2, b->path);
 	} else {
-		base_name = opt->ancestor == NULL ? NULL :
-			mkpathdup("%s", opt->ancestor);
+		base  = mkpathdup("%s", opt->ancestor);
 		name1 = mkpathdup("%s", branch1);
 		name2 = mkpathdup("%s", branch2);
 	}
@@ -1076,11 +1073,11 @@ static int merge_3way(struct merge_options *opt,
 	read_mmblob(&src1, &a->oid);
 	read_mmblob(&src2, &b->oid);
 
-	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
+	merge_status = ll_merge(result_buf, a->path, &orig, base,
 				&src1, name1, &src2, name2,
 				opt->repo->index, &ll_opts);
 
-	free(base_name);
+	free(base);
 	free(name1);
 	free(name2);
 	free(orig.ptr);
@@ -3517,6 +3514,8 @@ static int merge_recursive_internal(struct merge_options *opt,
 	struct commit *merged_merge_bases;
 	struct tree *result_tree;
 	int clean;
+	int num_merge_bases;
+	struct strbuf commit_name = STRBUF_INIT;
 
 	if (show(opt, 4)) {
 		output(opt, 4, _("Merging:"));
@@ -3538,6 +3537,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 			output_commit_title(opt, iter->item);
 	}
 
+	num_merge_bases = commit_list_count(merge_bases);
 	merged_merge_bases = pop_commit(&merge_bases);
 	if (merged_merge_bases == NULL) {
 		/* if there is no common ancestor, use an empty tree */
@@ -3579,13 +3579,26 @@ static int merge_recursive_internal(struct merge_options *opt,
 	if (!opt->priv->call_depth)
 		repo_read_index(opt->repo);
 
-	opt->ancestor = "merged common ancestors";
+	switch (num_merge_bases) {
+	case 0:
+		opt->ancestor = "<empty tree>";
+		break;
+	case 1:
+		strbuf_add_unique_abbrev(&commit_name,
+					 &merged_merge_bases->object.oid,
+					 DEFAULT_ABBREV);
+		opt->ancestor = commit_name.buf;
+		break;
+	default:
+		opt->ancestor = "merged common ancestors";
+	}
 	clean = merge_trees_internal(opt,
 				     repo_get_commit_tree(opt->repo, h1),
 				     repo_get_commit_tree(opt->repo, h2),
 				     repo_get_commit_tree(opt->repo,
 							  merged_merge_bases),
 				     &result_tree);
+	strbuf_release(&commit_name);
 	if (clean < 0) {
 		flush_output(opt);
 		return clean;
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index d23b948f27..7fddcc8c73 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1562,6 +1562,7 @@ test_expect_success 'check nested conflicts' '
 		cd nested_conflicts &&
 
 		git clean -f &&
+		MASTER=$(git rev-parse --short master) &&
 		git checkout L2^0 &&
 
 		# Merge must fail; there is a conflict
@@ -1582,7 +1583,7 @@ test_expect_success 'check nested conflicts' '
 		git cat-file -p R1:a >theirs &&
 		test_must_fail git merge-file --diff3 \
 			-L "Temporary merge branch 1" \
-			-L "merged common ancestors"  \
+			-L "$MASTER"  \
 			-L "Temporary merge branch 2" \
 			ours  \
 			base  \
@@ -1594,7 +1595,7 @@ test_expect_success 'check nested conflicts' '
 		git cat-file -p R1:b >theirs &&
 		test_must_fail git merge-file --diff3 \
 			-L "Temporary merge branch 1" \
-			-L "merged common ancestors"  \
+			-L "$MASTER"  \
 			-L "Temporary merge branch 2" \
 			ours  \
 			base  \
@@ -1732,6 +1733,7 @@ test_expect_success 'check virtual merge base with nested conflicts' '
 	(
 		cd virtual_merge_base_has_nested_conflicts &&
 
+		MASTER=$(git rev-parse --short master) &&
 		git checkout L3^0 &&
 
 		# Merge must fail; there is a conflict
@@ -1760,7 +1762,7 @@ test_expect_success 'check virtual merge base with nested conflicts' '
 		cp left merged-once &&
 		test_must_fail git merge-file --diff3 \
 			-L "Temporary merge branch 1" \
-			-L "merged common ancestors"  \
+			-L "$MASTER"  \
 			-L "Temporary merge branch 2" \
 			merged-once \
 			base        \
diff --git a/t/t6047-diff3-conflict-markers.sh b/t/t6047-diff3-conflict-markers.sh
new file mode 100755
index 0000000000..08cb1668a5
--- /dev/null
+++ b/t/t6047-diff3-conflict-markers.sh
@@ -0,0 +1,191 @@
+#!/bin/sh
+
+test_description='recursive merge diff3 style conflict markers'
+
+. ./test-lib.sh
+
+# Setup:
+#          L1
+#            \
+#             ?
+#            /
+#          R1
+#
+# Where:
+#   L1 and R1 both have a file named 'content' but have no common history
+#
+
+test_expect_success 'setup no merge base' '
+	test_create_repo no_merge_base &&
+	(
+		cd no_merge_base &&
+
+		git checkout --orphan L &&
+		test_seq 1 9 >content &&
+		echo "A" >>content &&
+		git add content &&
+		test_tick &&
+		git commit -m "version L1 of content" &&
+
+		# Create R
+		git checkout --orphan R &&
+		test_seq 1 9 >content &&
+		echo "10" >>content &&
+		git add content &&
+		test_tick &&
+		git commit -m "version R1 of content"
+	)
+'
+
+test_expect_success 'check no merge base' '
+	(
+		cd no_merge_base &&
+
+		git checkout L^0 &&
+
+		test_must_fail git -c merge.conflictstyle=diff3 merge --allow-unrelated-histories -s recursive R^0 &&
+
+		grep "|||||| <empty tree>" content
+	)
+'
+
+# Setup:
+#          L1
+#         /  \
+#   master    ?
+#         \  /
+#          R1
+#
+# Where:
+#   L1 and R1 have modified the same file ('content') in conflicting ways
+#
+
+test_expect_success 'setup unique merge base' '
+	test_create_repo unique_merge_base &&
+	(
+		cd unique_merge_base &&
+
+		test_seq 1 9 >content &&
+		git add content &&
+		test_tick &&
+		git commit -m initial &&
+
+		git branch L &&
+		git branch R &&
+
+		# Create L1
+		git checkout L &&
+		test_seq 0 9 >content &&
+		echo "A" >>content &&
+		git add content &&
+		test_tick &&
+		git commit -m "version L1 of content" &&
+
+		# Create R1
+		git checkout R &&
+		test_seq 0 9 >content &&
+		echo "ten" >>content &&
+		git add content &&
+		git mv content renamed &&
+		test_tick &&
+		git commit -m "version R1 of content"
+	)
+'
+
+test_expect_success 'check unique merge base' '
+	(
+		cd unique_merge_base &&
+
+		git checkout L^0 &&
+		MASTER=$(git rev-parse --short master) &&
+
+		test_must_fail git -c merge.conflictstyle=diff3 merge -s recursive R^0 &&
+
+		grep "|||||| $MASTER:content" renamed
+	)
+'
+
+# Setup:
+#          L1---L2--L3
+#         /  \ /      \
+#   master    X1       ?
+#         \  / \      /
+#          R1---R2--R3
+#
+# Where:
+#   commits L1 and R1 have modified the same file in non-conflicting ways
+#   X1 is an auto-generated merge-base used when merging L1 and R1
+#   commits L2 and R2 are merges of R1 and L1 into L1 and R1, respectively
+#   commits L3 and R3 both modify 'content' in conflicting ways
+#
+
+test_expect_success 'setup multiple merge bases' '
+	test_create_repo multiple_merge_bases &&
+	(
+		cd multiple_merge_bases &&
+
+		# Create some related files now
+		test_seq 1 9 >content &&
+		git add content &&
+		test_tick &&
+		git commit -m initial &&
+
+		git branch L &&
+		git branch R &&
+
+		# Create L1
+		git checkout L &&
+		test_seq 0 9 >content &&
+		git add content &&
+		test_tick &&
+		git commit -m "version L1 of content" &&
+		git tag L1 &&
+
+		# Create R1
+		git checkout R &&
+		test_seq 1 10 >content &&
+		git add content &&
+		test_tick &&
+		git commit -m "verson R1 of content" &&
+		git tag R1 &&
+
+		# Create L2
+		git checkout L &&
+		git merge R1 &&
+
+		# Create R2
+		git checkout R &&
+		git merge L1 &&
+
+		# Create L3
+		git checkout L &&
+		test_seq 0 9 >content &&
+		echo "A" >>content &&
+		git add content &&
+		test_tick &&
+		git commit -m "version L3 of content" &&
+
+		# Create R3
+		git checkout R &&
+		test_seq 0 9 >content &&
+		echo "ten" >>content &&
+		git add content &&
+		git mv content renamed &&
+		test_tick &&
+		git commit -m "version R3 of content"
+	)
+'
+
+test_expect_success 'check multiple merge bases' '
+	(
+		cd multiple_merge_bases &&
+
+		git checkout L^0 &&
+
+		test_must_fail git -c merge.conflictstyle=diff3 merge -s recursive R^0 &&
+
+		grep "|||||| merged common ancestors:content" renamed
+	)
+'
+
+test_done
-- 
2.22.0.559.g28a8880890.dirty

