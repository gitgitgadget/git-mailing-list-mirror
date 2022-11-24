Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52707C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 03:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKXDhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKXDhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 22:37:13 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974B4CB686
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:37:11 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so3028629wma.1
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq6eZ6M+zCnOWlXXSVshTkFTxVr8OezoHYy/O3wJTiA=;
        b=VeKVpCmSP0bIiXRw32d6fGXfHaVJiSdr8gBI2g/vatqmih0HusVRG7dCzalNsMQ5GG
         7/w4lCId/2KIgQ3yybOjAvlKPcdGtrUAdZ0oCT6BZ/U1PCnJD6iQC0ckYNjD6nQ2NYYm
         LqxhvyWvqPxMtkuWj+BpfxKoF/iI3h6kMI55YOcoy/urH8okeWcxyjkhEIOBojeSKmAo
         Y2Ysi2G31g2p/FHf6suGAMZYVg0GD5M/Eqs7m7wH7FYQwT35Shu7KfDeJbURa4llfs0x
         GDWyMAl50NssNKJK8eKK9eed0JM6Ks/kUDigtFRPyVIPGN5dtUsrq0KWOF3vL7EYsecu
         qAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq6eZ6M+zCnOWlXXSVshTkFTxVr8OezoHYy/O3wJTiA=;
        b=u+8GAWi2E4kIxuG9WfrDUQYxMnuBm0PdWsAfyd4dZxmqrJQ4/z1UTcDb7TccLqt/h9
         hHLnvwaU/yg3KrEXFMv+yF26JeWQjabKYotuRtSvGkR1e3nN9fD5p+24m1KrsnHo9iQM
         n6IPc/3/4wqeOSug+G7ULxSrMQNuV4E+mhWytCdjq0X/rrv/0iZztsEdv6/9z/mdRWdi
         G/R8xE+iodRaagv6Wu9DcImdlBnVZbdMwtkb+h6mR3okSsq9zZBkDi6MlsdoJ0qNQhkF
         R0tRkNdTlwQSfueSgjLJApWSD4lJ87U04m49suBBLGDGd1z4BTyd0o4NjwovFbV22m2C
         KI+g==
X-Gm-Message-State: ANoB5pnW0aSBrW/8hWennKXUPidsZSXA9npbkQgiftFyMfJ15qfvgB00
        ZgcLfmVVtTNk2MYDUEMdoHzUaNBDHHo=
X-Google-Smtp-Source: AA0mqf486Cg4diNFTL52x8o4vCqmannmF7lOWTI+vBUUA8FI5stt1ySx3fkhnsm8+8EFVvT+fcidYQ==
X-Received: by 2002:a05:600c:4e4b:b0:3cf:7624:5fcd with SMTP id e11-20020a05600c4e4b00b003cf76245fcdmr21665818wmq.195.1669261029977;
        Wed, 23 Nov 2022 19:37:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm5405166wmq.36.2022.11.23.19.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:37:09 -0800 (PST)
Message-Id: <1cf1c69b8e8e8e81eccc42b5d8efc605a36ab7eb.1669261026.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v8.git.1669261026.gitgitgadget@gmail.com>
References: <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
        <pull.1397.v8.git.1669261026.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 03:37:04 +0000
Subject: [PATCH v8 1/3] merge-tree.c: add --merge-base=<commit> option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, kylezhao <kylezhao@tencent.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Kyle Zhao <kylezhao@tencent.com>,
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
 builtin/merge-tree.c             | 46 ++++++++++++++++++++++++--------
 t/t4301-merge-tree-write-tree.sh | 27 +++++++++++++++++++
 3 files changed, 66 insertions(+), 11 deletions(-)

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
index fe853aa8f91..62c6d43cdb9 100644
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
 
@@ -529,6 +551,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 		if (o.mode == MODE_TRIVIAL)
 			die(_("--trivial-merge is incompatible with all other options"));
+		if (merge_base)
+			die(_("--merge-base is incompatible with --stdin"));
 		line_termination = '\0';
 		while (strbuf_getline_lf(&buf, stdin) != EOF) {
 			struct strbuf **split;
@@ -538,7 +562,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			if (!split[0] || !split[1] || split[2])
 				die(_("malformed input line: '%s'."), buf.buf);
 			strbuf_rtrim(split[0]);
-			result = real_merge(&o, split[0]->buf, split[1]->buf, prefix);
+			result = real_merge(&o, merge_base, split[0]->buf, split[1]->buf, prefix);
 			if (result < 0)
 				die(_("merging cannot continue; got unclean result of %d"), result);
 			strbuf_list_free(split);
@@ -581,7 +605,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 	/* Do the relevant type of merge */
 	if (o.mode == MODE_REAL)
-		return real_merge(&o, argv[0], argv[1], prefix);
+		return real_merge(&o, merge_base, argv[0], argv[1], prefix);
 	else
 		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index cac85591b52..6db96ccbaae 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -860,4 +860,31 @@ test_expect_success '--stdin with both a successful and a conflicted merge' '
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
+	test_when_finished "rm -rf base-b2-p" &&
+	git init base-b2-p &&
+	test_commit -C base-b2-p c1 file1 &&
+	test_commit -C base-b2-p c2 file2 &&
+	test_commit -C base-b2-p c3 file3 &&
+
+	# Testing
+	TREE_OID=$(git -C base-b2-p merge-tree --write-tree --merge-base=c2 c1 c3) &&
+
+	q_to_tab <<-EOF >expect &&
+	100644 blob $(git -C base-b2-p rev-parse c1:file1)Qfile1
+	100644 blob $(git -C base-b2-p rev-parse c3:file3)Qfile3
+	EOF
+
+	git -C base-b2-p ls-tree $TREE_OID >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

