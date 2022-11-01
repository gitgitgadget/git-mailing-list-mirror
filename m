Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7255AFA3745
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 08:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKAIzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiKAIzL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 04:55:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8512B17E23
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 01:55:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h9so19261161wrt.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 01:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKKfKMtObsoOSCMU+7kRFCLLKZOAgOKeZVeBtQqLUFc=;
        b=ASPvDYkUmqHhc6PbkXrtP3QcTVsG6nUP6n8YgRdoR8L2HkDSFI6p3DYgRR3543/YlT
         hEw507eWgl2pmfGpK5F3gV/ayKDS1vZKoHdIAvxIayf+1saZaqz50/eWegse53XVOrJQ
         zV/YNRR1j3tm59rV2f/0m4RCk5rhoLFVsGSn636pjNeu1wzc1NVg0SC5Pw3nQlXSQr9s
         1w86n0mWM98odRRk88QXqvLzFwSkl5TrGCuPRiC6c9gnW8O5AF+aOion/kVMY9HV9Jv8
         zFi4ty39iGYqT8kRBOt41TL2nq8ct2JXL+s7/owMHuyxe0p++WmVlQZ491kkhaqheWgc
         B5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKKfKMtObsoOSCMU+7kRFCLLKZOAgOKeZVeBtQqLUFc=;
        b=zuB0YncBJMuV0WH4J00D5q5+TGyQAmdAYYwZnyJwCkoUh22me809qqR0M+PGD4RvqF
         y3Tt0Bg3snNoaDiIk5BHqN0gBicHLNW5X/DYvEkbAeOmaOu+Uu0REd4bZYA3pHb95ywp
         t9/bPhjKntLcUKX+neEGVaJMIDH21gCqPDpUujbs/W17dsmzHWcU5ICX3/qCkl2qK54m
         wCYcHf/++6Wz1stDdCdpW6zoPZefh2pINiajn8VmTCL5ygwjmIwhW5QYsh0bgmIgwhLZ
         NzZ10lwi866AM5xPYpj+erX23SnkpqH2gmU9c/R5xSTfOpaOd/raTkGlWzP35HyZlo/U
         6K4g==
X-Gm-Message-State: ACrzQf3JshcP9uvWfFnI2+mdy+gIHms7h8X7NrQCBLRhBsVC9DGZsGTj
        rBcq1Ox90Kq/pDpX9qdj90PbGWXjeDc=
X-Google-Smtp-Source: AMsMyM6WSX52QQiFSn1eeEOAUeHDntBJx7C1iYl85WmTe02IhoAHlaWYNxw8ubHGIurKrUYiXHhX8g==
X-Received: by 2002:adf:e603:0:b0:236:80ac:5f4b with SMTP id p3-20020adfe603000000b0023680ac5f4bmr10528616wrm.83.1667292906754;
        Tue, 01 Nov 2022 01:55:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003c70191f267sm10024894wmn.39.2022.11.01.01.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 01:55:06 -0700 (PDT)
Message-Id: <bba854fc8fac39bb5e560b012a78fc48bdf13b15.1667292904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
References: <pull.1397.v3.git.1667014975042.gitgitgadget@gmail.com>
        <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Nov 2022 08:55:03 +0000
Subject: [PATCH v4 1/2] merge-tree.c: add --merge-base=<commit> option
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
 Documentation/git-merge-tree.txt |  4 +++
 builtin/merge-tree.c             | 44 ++++++++++++++++++++++++--------
 t/t4301-merge-tree-write-tree.sh | 30 ++++++++++++++++++++++
 3 files changed, 67 insertions(+), 11 deletions(-)

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
index fe853aa8f91..f402b807c0f 100644
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
@@ -406,6 +407,7 @@ struct merge_tree_options {
 };
 
 static int real_merge(struct merge_tree_options *o,
+		      const char *merge_base,
 		      const char *branch1, const char *branch2,
 		      const char *prefix)
 {
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
+	if (merge_base) {
+		struct commit *base_commit;
+		struct tree *base_tree, *parent1_tree, *parent2_tree;
+
+		base_commit = lookup_commit_reference_by_name(merge_base);
+		if (!base_commit)
+			die(_("could not lookup commit %s"), merge_base);
+
+		opt.ancestor = merge_base;
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
 
@@ -487,6 +504,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	struct merge_tree_options o = { .show_messages = -1 };
 	int expected_remaining_argc;
 	int original_argc;
+	const char *merge_base = NULL;
 
 	const char * const merge_tree_usage[] = {
 		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
@@ -515,6 +533,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &o.use_stdin,
 			   N_("perform multiple merges, one per line of input"),
 			   PARSE_OPT_NONEG),
+		OPT_STRING(0, "merge-base",
+			   &merge_base,
+			   N_("commit"),
+			   N_("specify a merge-base for the merge")),
 		OPT_END()
 	};
 
@@ -538,7 +560,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			if (!split[0] || !split[1] || split[2])
 				die(_("malformed input line: '%s'."), buf.buf);
 			strbuf_rtrim(split[0]);
-			result = real_merge(&o, split[0]->buf, split[1]->buf, prefix);
+			result = real_merge(&o, merge_base, split[0]->buf, split[1]->buf, prefix);
 			if (result < 0)
 				die(_("merging cannot continue; got unclean result of %d"), result);
 			strbuf_list_free(split);
@@ -581,7 +603,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 	/* Do the relevant type of merge */
 	if (o.mode == MODE_REAL)
-		return real_merge(&o, argv[0], argv[1], prefix);
+		return real_merge(&o, merge_base, argv[0], argv[1], prefix);
 	else
 		return trivial_merge(argv[0], argv[1], argv[2]);
 }
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
-- 
gitgitgadget

