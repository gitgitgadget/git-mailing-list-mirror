Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB48C71145
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 14:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjHXONF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbjHXONB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 10:13:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B9711F
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 07:12:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31aeedbb264so4659969f8f.0
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692886377; x=1693491177;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCerr6TVCjkyPSOEexOpZjWOBJz0lIqoKIpNo0xDc0g=;
        b=ZptjjeHDxEjz7rF8ju7lbqQK0VmAb3t1bs7nM2mevetzX74XltnkU2KDBXZoVbOE+W
         cucQhi1wrS64GZzpx254NzEZDjoWOyj8yjG1cJE2KieB+DIqWFMdaVA+zJzkNPr43Nhb
         Dewgj+Gp2lyHi2/XK+j+dROFacIazw7yt0C439UMd/VdM6nu7NWTK8IvaDFwCwZtbewM
         OPkeIfSPPKpF8TiqIDzaPB4kZX6PqNj3qJt6/RBfeCfQ/JrgmreerbgMVhsrIbs8igU4
         AhcPyCMkUiBCvfgMN+sjkvHPisOovJoolazFVNx3w5PwQNInS1fQfPZe5+xcSp4uH9An
         cIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692886377; x=1693491177;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCerr6TVCjkyPSOEexOpZjWOBJz0lIqoKIpNo0xDc0g=;
        b=DMqCDfFNp7Rxy+ZP+rgGEW2oOBon4ndroYLZP/ehX0EHLqgzn73jv4qWMTt1fNr8N8
         t7Pet6tK1WEkoxioOIINXistIQu8PY6QVXkIgz0G8y6HxYSQZ+O/UPRc01Cy6cfC4VkW
         YPv1kgliE0i7BPZEZSnh7fFc9iJsJyhVCsg5jRCyxuCmk6KcXK1lxCV/TzP1X6wI/w2B
         wGqzE0cJG8DZKLZ7/1DBpScZ5HiVAGON1GAH75KaBHTk5jnhqj/9ROewm+qxWfc4zDB1
         H7GfeOuCMR/jWqb8smhQiomuJxXQYMPPeUrjYcRItm+ZTtbnED4fqMSBcgos16c+Mrw2
         SxQQ==
X-Gm-Message-State: AOJu0YxWMAhm0GZdzYj7KkvWosPg8ErmDQnO/xqrAIsHRmXcuM1XRF25
        tHdto6MdLRwcYyFVXpnLrvGH/RyhJVY=
X-Google-Smtp-Source: AGHT+IHzLWG40f9Us8eqJlr+Lz2cThRowWBBWmAgSFNDKVXsaqHB4Vnd5/2INgZsf6IyD+T0zjCCHw==
X-Received: by 2002:a5d:494c:0:b0:317:5e5e:60e0 with SMTP id r12-20020a5d494c000000b003175e5e60e0mr11031942wrs.28.1692886377212;
        Thu, 24 Aug 2023 07:12:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb4a000000b00317a29af4b2sm22216752wrs.68.2023.08.24.07.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 07:12:56 -0700 (PDT)
Message-ID: <353e1960b4466912c508733e5a7eb80884cd9bdd.1692886365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v2.git.1692886365.gitgitgadget@gmail.com>
References: <pull.1577.git.1692389061490.gitgitgadget@gmail.com>
        <pull.1577.v2.git.1692886365.gitgitgadget@gmail.com>
From:   "Kevin Backhouse via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Aug 2023 14:12:45 +0000
Subject: [PATCH v2 2/2] Fix minor memory leak found by LeakSanitizer.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Backhouse <kevinbackhouse@github.com>,
        Kevin Backhouse <kevinbackhouse@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Backhouse <kevinbackhouse@github.com>

The callers of merge_recursive() and merge_ort_recursive() expects the
commit list passed in as the merge_bases parameter to be fully
consumed by the function and does not free it when the function
returns.  In normal cases, the commit list does get consumed, but when
the function returns early upon encountering an error, it forgets to
clean it up.

Fix this by freeing the list in the code paths for error returns.

Signed-off-by: Kevin Backhouse <kevinbackhouse@github.com>
---
 merge-ort-wrappers.c |  4 +++-
 merge-ort.c          |  4 +++-
 merge-recursive.c    | 32 ++++++++++++++++++++++----------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index 4acedf3c338..aeb56c9970c 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -54,8 +54,10 @@ int merge_ort_recursive(struct merge_options *opt,
 	struct tree *head = repo_get_commit_tree(opt->repo, side1);
 	struct merge_result tmp;
 
-	if (unclean(opt, head))
+	if (unclean(opt, head)) {
+		free_commit_list(merge_bases);
 		return -1;
+	}
 
 	memset(&tmp, 0, sizeof(tmp));
 	merge_incore_recursive(opt, merge_bases, side1, side2, &tmp);
diff --git a/merge-ort.c b/merge-ort.c
index 8631c997002..a0eb91fb011 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5070,8 +5070,10 @@ static void merge_ort_internal(struct merge_options *opt,
 		opt->branch1 = "Temporary merge branch 1";
 		opt->branch2 = "Temporary merge branch 2";
 		merge_ort_internal(opt, NULL, prev, next, result);
-		if (result->clean < 0)
+		if (result->clean < 0) {
+			free_commit_list(merge_bases);
 			return;
+		}
 		opt->branch1 = saved_b1;
 		opt->branch2 = saved_b2;
 		opt->priv->call_depth--;
diff --git a/merge-recursive.c b/merge-recursive.c
index 6a4081bb0f5..49e54d3722f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3652,14 +3652,18 @@ static int merge_recursive_internal(struct merge_options *opt,
 		opt->branch1 = "Temporary merge branch 1";
 		opt->branch2 = "Temporary merge branch 2";
 		if (merge_recursive_internal(opt, merged_merge_bases, iter->item,
-					     NULL, &merged_merge_bases) < 0)
-			return -1;
+					     NULL, &merged_merge_bases) < 0) {
+			clean = -1;
+			goto out;
+		}
 		opt->branch1 = saved_b1;
 		opt->branch2 = saved_b2;
 		opt->priv->call_depth--;
 
-		if (!merged_merge_bases)
-			return err(opt, _("merge returned no commit"));
+		if (!merged_merge_bases) {
+			clean = err(opt, _("merge returned no commit"));
+			goto out;
+		}
 	}
 
 	/*
@@ -3682,8 +3686,11 @@ static int merge_recursive_internal(struct merge_options *opt,
 				     repo_get_commit_tree(opt->repo,
 							  merged_merge_bases),
 				     &result_tree);
+
+out:
 	strbuf_release(&merge_base_abbrev);
 	opt->ancestor = NULL;  /* avoid accidental re-use of opt->ancestor */
+	free_commit_list(merge_bases);
 	if (clean < 0) {
 		flush_output(opt);
 		return clean;
@@ -3729,6 +3736,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 	assert(!opt->record_conflict_msgs_as_headers);
 	assert(!opt->msg_header_prefix);
 
+	CALLOC_ARRAY(opt->priv, 1);
+	string_list_init_dup(&opt->priv->df_conflict_file_set);
+
 	/* Sanity check on repo state; index must match head */
 	if (repo_index_has_changes(opt->repo, head, &sb)) {
 		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
@@ -3737,16 +3747,13 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 		return -1;
 	}
 
-	CALLOC_ARRAY(opt->priv, 1);
-	string_list_init_dup(&opt->priv->df_conflict_file_set);
 	return 0;
 }
 
 static void merge_finalize(struct merge_options *opt)
 {
 	flush_output(opt);
-	if (!opt->priv->call_depth && opt->buffer_output < 2)
-		strbuf_release(&opt->obuf);
+	strbuf_release(&opt->obuf);
 	if (show(opt, 2))
 		diff_warn_rename_limit("merge.renamelimit",
 				       opt->priv->needed_rename_limit, 0);
@@ -3763,8 +3770,10 @@ int merge_trees(struct merge_options *opt,
 
 	assert(opt->ancestor != NULL);
 
-	if (merge_start(opt, head))
+	if (merge_start(opt, head)) {
+		merge_finalize(opt);
 		return -1;
+	}
 	clean = merge_trees_internal(opt, head, merge, merge_base, &ignored);
 	merge_finalize(opt);
 
@@ -3785,8 +3794,11 @@ int merge_recursive(struct merge_options *opt,
 	prepare_repo_settings(opt->repo);
 	opt->repo->settings.command_requires_full_index = 1;
 
-	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
+	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1))) {
+		free_commit_list(merge_bases);
+		merge_finalize(opt);
 		return -1;
+	}
 	clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
 	merge_finalize(opt);
 
-- 
gitgitgadget
