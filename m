Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF765C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 17:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbiDYRw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244082AbiDYRwd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 13:52:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5110A26AF8
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n32-20020a05600c3ba000b00393ea7192faso2740wms.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1qAvMrK9QQnFN1vnNGvpGaSBmcFGP+U1S3g7XKOBhP8=;
        b=kLw/nRaPoJNXGcJYs37N5vcm9H1C+RPxCANru2VPyK75B6H54PRbxDt7o3RzA9hisp
         QlGJ5ThzrYsfxs1dt83RCyFfBG5cemfrmwVGVsaW5CHG2XUQdjMgsnBm47jCuR+suAFB
         wJ7SEgnFtZ+ypJnl7ZGzKQtNvOGQvrS8b2OtT0VQhD6ylCkcZEPCjYBXf7e+s5EQ3FmD
         IPZVnrHEjnxOuHTXNRh3glE1Va6qRwIN26RzOSDgeVSGwLe5M2pJYoX3AuGq+NaZAi8L
         jQ3SrSjiA99ZSydh3fEGbc5+7ry0Z3tuFLTAxgEWrLst2Gc7kvSGCConqu0wYXNdf3YP
         CrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1qAvMrK9QQnFN1vnNGvpGaSBmcFGP+U1S3g7XKOBhP8=;
        b=mi5Cu9GEXqD6Xqv0QRwAsTDbuGwuWRRiW7/4qV8JTaXb2xWm+KNukh4aY7H0vMiyuO
         4onecP1xYSvf5TLK+QzKc4xs3s2jPZ/OmIVFTCxkSJYUEaEokObZn3KBCCyBAPbthCcw
         CP4sJWOqFboy7I13y8rCXQqqVZZ4D+8zwQmVMORI6y9e1dSGmQbnNp9sQegrbQKiUeSy
         pcC2FEBmyWdz06xVdNvFZBie6iC8Mh4E0/vQhTjqM7HtbR/d6uBPZKE9ejW9lSy0y35A
         stEdskwnL3gqlCovsRg4N+F1n1jjN9uTuS7DfQnepSkcHm00s21SZ7vtUUdgnWmEIALw
         rcuQ==
X-Gm-Message-State: AOAM530tIdg2PI4StxtgMsMA764SRD3Nl5QcMLTs347uJCn+d56GBDe6
        sSFSXweysLqVIgyPq1W5a9XuBFw2iJU=
X-Google-Smtp-Source: ABdhPJwFQJbcnSShwIuFmlEB6r+d5VhrjUj6Ryhw7C75hy+v92ahp+AcNY3U8m1bME7PEna7JNN/pA==
X-Received: by 2002:a1c:3b89:0:b0:38e:b37f:52d with SMTP id i131-20020a1c3b89000000b0038eb37f052dmr17291661wma.197.1650908966586;
        Mon, 25 Apr 2022 10:49:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bu17-20020a056000079100b00207a3124b1dsm9148870wrb.65.2022.04.25.10.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:49:25 -0700 (PDT)
Message-Id: <80c25c7587484ca32afcfd6cc054eab78dd1348a.1650908958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 17:49:15 +0000
Subject: [PATCH 5/7] merge-recursive: add merge function arg to
 'merge_recursive_generic'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Replace the hardcoded 'merge_recursive()' function used by the
'merge_recursive_generic()' with a caller-specific merge function. This will
allow us to use 'merge_ort_recursive()' (and therefore avoid the index
expansion of 'merge_recursive()') in commands that perform merges with
'merge_recursive_generic()', such as 'git stash pop'.

Note that this patch is strictly a refactor; all callers still use
'merge_recursive()', and any changing to 'merge_ort_recursive()' will be
done in a later commit.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/am.c              | 2 +-
 builtin/merge-recursive.c | 2 +-
 builtin/stash.c           | 2 +-
 merge-ort.c               | 3 ++-
 merge-recursive.c         | 4 ++--
 merge-recursive.h         | 9 ++++++++-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0f4111bafa0..6d01185d122 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1614,7 +1614,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	if (state->quiet)
 		o.verbosity = 0;
 
-	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
+	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, merge_recursive, &result)) {
 		repo_rerere(the_repository, state->allow_rerere_autoupdate);
 		free(their_tree_name);
 		return error(_("Failed to merge in the changes."));
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index b9acbf5d342..687ed1e527b 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -81,7 +81,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	if (o.verbosity >= 3)
 		printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
 
-	failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, &result);
+	failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, merge_recursive, &result);
 
 	free(better1);
 	free(better2);
diff --git a/builtin/stash.c b/builtin/stash.c
index 1bfba532044..16171eb1dab 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -554,7 +554,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	bases[0] = &info->b_tree;
 
 	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
-				      &result);
+				      merge_recursive, &result);
 	if (ret) {
 		rerere(0);
 
diff --git a/merge-ort.c b/merge-ort.c
index 8545354dafd..4bccdfcf355 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4737,7 +4737,8 @@ void merge_incore_recursive(struct merge_options *opt,
 	trace2_region_enter("merge", "incore_recursive", opt->repo);
 
 	/* We set the ancestor label based on the merge_bases */
-	assert(opt->ancestor == NULL);
+	assert(opt->ancestor == NULL ||
+	       !strcmp(opt->ancestor, "constructed merge base"));
 
 	trace2_region_enter("merge", "merge_start", opt->repo);
 	merge_start(opt, result);
diff --git a/merge-recursive.c b/merge-recursive.c
index 1ee6364e8b1..2088f5c5fb3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3806,6 +3806,7 @@ int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *merge,
 			    int num_merge_bases,
 			    const struct object_id **merge_bases,
+			    recursive_merge_fn_t merge_fn,
 			    struct commit **result)
 {
 	int clean;
@@ -3829,8 +3830,7 @@ int merge_recursive_generic(struct merge_options *opt,
 	}
 
 	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
-	clean = merge_recursive(opt, head_commit, next_commit, ca,
-				result);
+	clean = merge_fn(opt, head_commit, next_commit, ca, result);
 	if (clean < 0) {
 		rollback_lock_file(&lock);
 		return clean;
diff --git a/merge-recursive.h b/merge-recursive.h
index b88000e3c25..6a21f2da538 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -53,6 +53,12 @@ struct merge_options {
 	struct merge_options_internal *priv;
 };
 
+typedef int (*recursive_merge_fn_t)(struct merge_options *opt,
+				    struct commit *h1,
+				    struct commit *h2,
+				    struct commit_list *merge_bases,
+				    struct commit **result);
+
 void init_merge_options(struct merge_options *opt, struct repository *repo);
 
 /* parse the option in s and update the relevant field of opt */
@@ -105,7 +111,7 @@ int merge_recursive(struct merge_options *opt,
 
 /*
  * merge_recursive_generic can operate on trees instead of commits, by
- * wrapping the trees into virtual commits, and calling merge_recursive().
+ * wrapping the trees into virtual commits, and calling the provided merge_fn.
  * It also writes out the in-memory index to disk if the merge is successful.
  *
  * Outputs:
@@ -120,6 +126,7 @@ int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *merge,
 			    int num_merge_bases,
 			    const struct object_id **merge_bases,
+			    recursive_merge_fn_t merge_fn,
 			    struct commit **result);
 
 #endif
-- 
gitgitgadget

