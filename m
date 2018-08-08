Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 076D31F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbeHHVUh (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:37 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35111 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbeHHVUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:36 -0400
Received: by mail-wr1-f46.google.com with SMTP id g1-v6so2943113wru.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6afWHi/8Po61Z2fo8Dk07Wvcj77ra2V716Saspp5sd0=;
        b=kzh+tPh2K9e26vkAF8fGmQwWwaQE1dhc9eog8Psgv4TIksQ/bzYMwP93vGJt+O+r4F
         lZtBl814MYLZMp+Wc5kHihniu0fV9TURkl4aWGZGZdsw3xtDCYpFBHOF2aFf1fQGaUwz
         pwkaW/ZlfpSyLCfKFbncLp26nuxVD4xrkRQ/Mxor1YnqssdGTRyK3pM53GyY0Jgf1F24
         iobv6Pe+82Nrjwr5W6O43vdZMY/1F9c7iB1JqM0QupUdrmRWOK9Z6SHbOD7jDux6Ree1
         PnVUP4e8JQdjMit6o/GlwQeMPDaRRHnS9lneaYVMyiJiO85UQGP/rUAUFI0g/6yW9odD
         EX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6afWHi/8Po61Z2fo8Dk07Wvcj77ra2V716Saspp5sd0=;
        b=rOZfAqTy6pzNCsXe+8/U913TtRBLjEDw++UErcGv/w23AJ/8LiLDIFcjZruB5ad8sp
         b8qbqHN2Yb6LkT4uyuLBrpp3oHRq43/n4YIeNJRM6AtjMcNNmngvlM3146r08YHUgZhO
         WP9o9R6BF3mIVTuetxedWnUhH3DnLeIuw7B4tY38hKfomEeOZTt+hWYqWSKbL44taIVY
         ojVgDOJc5ADxAuIqE5bXOI7nhIpifhMF8j12kMlfguTeveJ84SQuToYnCaWAFFYWpmvE
         SJcFBFg0Gq3FLCu8Zk6M9sXr/CEvTiANTYX59Jyw7B/7QCrKLxjKdL5KKnWMa9BR0H8M
         Nayw==
X-Gm-Message-State: AOUpUlFt0hMhEO8eSfW8x3pM0yL2rsGuYbLn4Xt1QOdBWfOvG8QgLbG1
        PtYrGZl/3J9KTba2wz9qC8IO2EZ6
X-Google-Smtp-Source: AA+uWPwi6scWOYJk7BPLXrEttDwlEzO7sWRoPE0U8++5F4b/dNR0F0y6vWJqFrHRe+0izQQWrATJWA==
X-Received: by 2002:adf:84e5:: with SMTP id 92-v6mr2770055wrg.56.1533754773979;
        Wed, 08 Aug 2018 11:59:33 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.33
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:33 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 19/26] stash: make push to be quiet
Date:   Wed,  8 Aug 2018 21:58:58 +0300
Message-Id: <c778a6aa99edd1ab58cfebc0976f1475f759611c.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a change in behaviour with this commit. When there was
no initial commit, the shell version of stash would still display
a message. This commit makes `push` to not display any message if
`--quiet` or `-q` is specified.
---
 builtin/stash--helper.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index c26cad3d5..4fd79532c 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -1079,7 +1079,7 @@ static int stash_working_tree(struct stash_info *info,
 
 static int do_create_stash(int argc, const char **argv, const char *prefix,
 			   const char **stash_msg, int include_untracked,
-			   int patch_mode, struct stash_info *info)
+			   int patch_mode, struct stash_info *info, int quiet)
 {
 	int untracked_commit_option = 0;
 	int ret = 0;
@@ -1105,7 +1105,8 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
 	}
 
 	if (get_oid("HEAD", &info->b_commit)) {
-		fprintf_ln(stderr, "You do not have the initial commit yet");
+		if (!quiet)
+			fprintf_ln(stderr, "You do not have the initial commit yet");
 		ret = -1;
 		goto done;
 	} else {
@@ -1127,7 +1128,8 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
 	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
 	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
 			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
-		fprintf_ln(stderr, "Cannot save the current index state");
+		if (!quiet)
+			fprintf_ln(stderr, "Cannot save the current index state");
 		ret = -1;
 		goto done;
 	}
@@ -1135,7 +1137,8 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
 	if (include_untracked && get_untracked_files(argv, 1,
 						     include_untracked, &out)) {
 		if (save_untracked_files(info, &msg, &out)) {
-			printf_ln("Cannot save the untracked files");
+			if (!quiet)
+				printf_ln("Cannot save the untracked files");
 			ret = -1;
 			goto done;
 		}
@@ -1144,14 +1147,16 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
 	if (patch_mode) {
 		ret = stash_patch(info, argv);
 		if (ret < 0) {
-			printf_ln("Cannot save the current worktree state");
+			if (!quiet)
+				printf_ln("Cannot save the current worktree state");
 			goto done;
 		} else if (ret > 0) {
 			goto done;
 		}
 	} else {
 		if (stash_working_tree(info, argv, prefix)) {
-			printf_ln("Cannot save the current worktree state");
+			if (!quiet)
+				printf_ln("Cannot save the current worktree state");
 			ret = -1;
 			goto done;
 		}
@@ -1176,7 +1181,8 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
 
 	if (commit_tree(*stash_msg, strlen(*stash_msg), &info->w_tree,
 			parents, &info->w_commit, NULL, NULL)) {
-		printf_ln("Cannot record working tree state");
+		if (!quiet)
+			printf_ln("Cannot record working tree state");
 		ret = -1;
 		goto done;
 	}
@@ -1208,7 +1214,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 			     0);
 
 	ret = do_create_stash(argc, argv, prefix, &stash_msg,
-			      include_untracked, 0, &info);
+			      include_untracked, 0, &info, 0);
 
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1261,25 +1267,31 @@ static int do_push_stash(int argc, const char **argv, const char *prefix,
 		return -1;
 
 	if (!check_changes(argv, include_untracked, prefix)) {
-		fprintf_ln(stdout, "No local changes to save");
+		if (!quiet)
+			fprintf_ln(stdout, "No local changes to save");
 		return 0;
 	}
 
 	if (!reflog_exists(ref_stash) && do_clear_stash()) {
-		fprintf_ln(stderr, "Cannot initialize stash");
+		if (!quiet)
+			fprintf_ln(stderr, "Cannot initialize stash");
 		return -1;
 	}
 
 	if ((ret = do_create_stash(argc, argv, prefix, &stash_msg,
-				   include_untracked, patch_mode, &info)))
+				   include_untracked, patch_mode, &info,
+				   quiet)))
 		return ret;
 
 	if (do_store_stash(oid_to_hex(&info.w_commit), stash_msg, 1)) {
-		fprintf(stderr, "Cannot save the current status");
+		if (!quiet)
+			fprintf_ln(stderr, "Cannot save the current status");
 		return -1;
 	}
 
-	fprintf(stdout, "Saved working directory and index state %s", stash_msg);
+	if (!quiet)
+		fprintf(stdout, "Saved working directory and index state %s",
+			stash_msg);
 
 	if (!patch_mode) {
 		if (include_untracked && ps.nr == 0) {
@@ -1367,7 +1379,8 @@ static int do_push_stash(int argc, const char **argv, const char *prefix,
 		argv_array_pushl(&cp.args, "apply", "-R", NULL);
 
 		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
-			fprintf_ln(stderr, "Cannot remove worktree changes");
+			if (!quiet)
+				fprintf_ln(stderr, "Cannot remove worktree changes");
 			return -1;
 		}
 
-- 
2.18.0.573.g56500d98f

