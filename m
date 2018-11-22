Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44111F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439056AbeKWJsM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55340 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439027AbeKWJsM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:48:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so10253017wmc.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2AC++0ou9EX7A29PXkDUmXboZDeZgCwMkAV/qz0V/nw=;
        b=HiC/AH+nWiMUGkMAwRG2/Y0ajl2emEk8RPwaOjMv4M8ojhhVlpozcq2HnUzWd/AZS2
         6AccTymxV9YC4ea7kBQKMj/7SiFW0Zj1YfkKd2CoCyGU88Zl7/4yML7y7V3NiOH5KVUF
         pYY6F7dskv0QrbDPZeZJrXL8rfs+SY4xlOZ/+dcAFXa6E+KeS++gBi250rIrqhEH32x9
         oZAXHb4seN6xceGbu2ugrGkdO/NuL/zu7/CW5VjPTurIN74rfVjKvud5a5f8kSkKIoMr
         Gom3yx4/nsO+TJVuOVDe2vVNtldirL2crzARz60JVscXpoGudc65+CJpYCbulgPieAcm
         h/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AC++0ou9EX7A29PXkDUmXboZDeZgCwMkAV/qz0V/nw=;
        b=gJCUPflT9sPc5Fz/BhNJrVOjxkH9mNKY73hhq1mNB29bOOAavwlLs5Bxpx7ykgzV+N
         iZ8W0VZq1VEe/AFa3by7QbCnNEPOv10nxIYzqD6FizE480Iv17yC6MTd2WNRwKwSS2Vo
         LDLuABRFPxcC/wGh7waIDklRtAKKWCSAc3q3pnDl+lpGlXuCClkxVA1Z2KxC/O8wio7j
         ryyzD+TY4wLYbQ23SySeWRi+z7lyGR9RWR898vsY0u9rSfPbAcN4McQS7in0ScbVTOGK
         +UJeCO2fY1RTKB6onVy2zKUyD0kTsZWAso4KdbKGd5XBGRxG2X0lQz0gy+l1QnzY64iC
         dgxA==
X-Gm-Message-State: AA+aEWZn0EbStMYTTYUJE/xmiQNc1zU/S2tRyT63MAmmnBl/1Tdp4mA0
        aBmPHITbqtVZBisnBjG4Ir27paUP
X-Google-Smtp-Source: AJdET5cZk0ydkt2kED6khfri6/g0UxxVkFBzEPs41cknVo2Kl4cO2M/najb2+pTLnMhwaq8UnZlhnw==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr11327224wmd.103.1542927990054;
        Thu, 22 Nov 2018 15:06:30 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:29 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 18/22] stash: make push -q quiet
Date:   Fri, 23 Nov 2018 01:05:38 +0200
Message-Id: <78914337d41163aa0ddb8014e9a8a259241f0d7d.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a change in behaviour with this commit. When there was
no initial commit, the shell version of stash would still display
a message. This commit makes `push` to not display any message if
`--quiet` or `-q` is specified. Add tests for `--quiet`.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 56 ++++++++++++++++++++++++++---------------
 t/t3903-stash.sh        | 23 +++++++++++++++++
 2 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 8683c662fc..0dd5dbade6 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -971,7 +971,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 }
 
 static int stash_patch(struct stash_info *info, struct pathspec ps,
-		       struct strbuf *out_patch)
+		       struct strbuf *out_patch, int quiet)
 {
 	int ret = 0;
 	struct strbuf out = STRBUF_INIT;
@@ -1024,7 +1024,8 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	}
 
 	if (!out_patch->len) {
-		fprintf_ln(stderr, _("No changes selected"));
+		if (!quiet)
+			fprintf_ln(stderr, _("No changes selected"));
 		ret = 1;
 	}
 
@@ -1102,7 +1103,8 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 
 static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 			   int include_untracked, int patch_mode,
-			   struct stash_info *info, struct strbuf *patch)
+			   struct stash_info *info, struct strbuf *patch,
+			   int quiet)
 {
 	int ret = 0;
 	int flags = 0;
@@ -1120,7 +1122,9 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 	refresh_cache(REFRESH_QUIET);
 
 	if (get_oid("HEAD", &info->b_commit)) {
-		fprintf_ln(stderr, _("You do not have the initial commit yet"));
+		if (!quiet)
+			fprintf_ln(stderr, _("You do not have "
+					     "the initial commit yet"));
 		ret = -1;
 		goto done;
 	} else {
@@ -1145,7 +1149,9 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
 	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
 			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
-		fprintf_ln(stderr, _("Cannot save the current index state"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot save the current "
+					     "index state"));
 		ret = -1;
 		goto done;
 	}
@@ -1153,26 +1159,29 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 	if (include_untracked && get_untracked_files(ps, include_untracked,
 						     &untracked_files)) {
 		if (save_untracked_files(info, &msg, untracked_files)) {
-			fprintf_ln(stderr, _("Cannot save "
-					     "the untracked files"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save "
+						     "the untracked files"));
 			ret = -1;
 			goto done;
 		}
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps, patch);
+		ret = stash_patch(info, ps, patch, quiet);
 		if (ret < 0) {
-			fprintf_ln(stderr, _("Cannot save the current "
-					     "worktree state"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save the current "
+						     "worktree state"));
 			goto done;
 		} else if (ret > 0) {
 			goto done;
 		}
 	} else {
 		if (stash_working_tree(info, ps)) {
-			fprintf_ln(stderr, _("Cannot save the current "
-					     "worktree state"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save the current "
+						     "worktree state"));
 			ret = -1;
 			goto done;
 		}
@@ -1198,7 +1207,9 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 
 	if (commit_tree(stash_msg_buf->buf, stash_msg_buf->len, &info->w_tree,
 			parents, &info->w_commit, NULL, NULL)) {
-		fprintf_ln(stderr, _("Cannot record working tree state"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot record "
+					     "working tree state"));
 		ret = -1;
 		goto done;
 	}
@@ -1233,7 +1244,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	memset(&ps, 0, sizeof(ps));
 	strbuf_addstr(&stash_msg_buf, stash_msg);
 	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
-			      NULL);
+			      NULL, 0);
 
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1296,26 +1307,29 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 
 	if (!reflog_exists(ref_stash) && do_clear_stash()) {
 		ret = -1;
-		fprintf_ln(stderr, _("Cannot initialize stash"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot initialize stash"));
 		goto done;
 	}
 
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
 	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
-			    &info, &patch)) {
+			    &info, &patch, quiet)) {
 		ret = -1;
 		goto done;
 	}
 
 	if (do_store_stash(&info.w_commit, stash_msg_buf.buf, 1)) {
 		ret = -1;
-		fprintf_ln(stderr, _("Cannot save the current status"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot save the current status"));
 		goto done;
 	}
 
-	printf_ln(_("Saved working directory and index state %s"),
-		  stash_msg_buf.buf);
+	if (!quiet)
+		printf_ln(_("Saved working directory and index state %s"),
+			  stash_msg_buf.buf);
 
 	if (!patch_mode) {
 		if (include_untracked && !ps.nr) {
@@ -1416,7 +1430,9 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 		argv_array_pushl(&cp.args, "apply", "-R", NULL);
 
 		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
-			fprintf_ln(stderr, _("Cannot remove worktree changes"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot remove "
+						     "worktree changes"));
 			ret = -1;
 			goto done;
 		}
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 8b09a3d6cc..77e0b72035 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1064,6 +1064,29 @@ test_expect_success 'push: <pathspec> not in the repository errors out' '
 	test_path_is_file untracked
 '
 
+test_expect_success 'push: -q is quiet with changes' '
+	>foo &&
+	git add foo &&
+	git stash push -q >output 2>&1 &&
+	test_must_be_empty output
+'
+
+test_expect_success 'push: -q is quiet with no changes' '
+	git stash push -q >output 2>&1 &&
+	test_must_be_empty output
+'
+
+test_expect_success 'push: -q is quiet even if there is no initial commit' '
+	git init foo_dir &&
+	test_when_finished rm -rf foo_dir &&
+	(
+		cd foo_dir &&
+		>bar &&
+		test_must_fail git stash push -q >output 2>&1 &&
+		test_must_be_empty output
+	)
+'
+
 test_expect_success 'untracked files are left in place when -u is not given' '
 	>file &&
 	git add file &&
-- 
2.19.1.878.g0482332a22

