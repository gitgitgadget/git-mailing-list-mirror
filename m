Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6ADF1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeHaBqH (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:46:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38071 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeHaBqH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:46:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so9359506wrc.5
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ie3hZT2zv40ozxPHQCxhEBMgegsufvZ2cjvCHWp0iGE=;
        b=XrYBx2N0Fw3gQ3SZcTl2iMSlHO2134XJhay4zlAkBA62S3oL3Bi2E61QSF53yq//7z
         peB68SoCB7KsZ97GTDj8zYdhwu5tnYT+wC2ylzAacn80t68pAafKRk0l44yJPAl+7G9Z
         899v/QFAWpOWh8S2bQJD6rji2Gidb3V7dvZEAQnoSwY9LHffhbarfAU2iUYksrcAKEf2
         3J4eh962re6QwW12eqGb7GQ2XpSwpB9KxIpVq55mHSkWwJS3RKyLYifQL6gArNKgqDvR
         YpK1l/VbWy3e18ZIrf/qwVFA8RK5TGnQy2ASbbmTNRI9hQSTXlQ3s1zTlVkPbFSxdpzG
         54DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ie3hZT2zv40ozxPHQCxhEBMgegsufvZ2cjvCHWp0iGE=;
        b=VbssAjbkdsupscmgiljQVmF5D0t+q426XXxm+9PkkOQlR8SmsUhLbV49holj9y0szs
         IdHGGnZRXlvvh8ptC0D4vwrwKeBRM5jNvNYdkOoEXiUfjTyRWJW/yU7kJCJ/2FXOUF76
         1FqSxuG/aU8UF3RZw8svsxixV0lvmr1LXa9ZLoo8AwEyb2gi5lPjM+JX9QcF6wX0xqF0
         D2T/5T5V44z0K3HHu2P2WZnZNG+yje9Hmje559QpBGtK4WacM7Ma563zaevu8rDIxH1a
         kDeCXhh6lOKxpoSKUzUMmvbB52bqfuxdEUsEc942ji6lVEFpIlJd/D5sKEvr/VLb6DVQ
         iDaA==
X-Gm-Message-State: APzg51CCP3wv6en9YkSO6XZSVjF+1AxLnCaV7hO/iqR/fWQw6jfS72zB
        y9OWXFIdcKDq9wfzMB3Qozv0knwJ
X-Google-Smtp-Source: ANB0VdanPAMn+K+JoaVKJ00Cc+QPow5Ug1/y40zNNwq7UHTDXvBJz4cvn6ZrQL3BSsR36XaixgsZfA==
X-Received: by 2002:a5d:470d:: with SMTP id y13-v6mr9105891wrq.229.1535665312871;
        Thu, 30 Aug 2018 14:41:52 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:52 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 16/20] stash: make push -q quiet
Date:   Fri, 31 Aug 2018 00:40:46 +0300
Message-Id: <7bbac617d67349182bbab2c67827639060b25e2f.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
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

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 47 ++++++++++++++++++++++++++---------------
 t/t3903-stash.sh        | 23 ++++++++++++++++++++
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 23670321d8..e5153a63ea 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -938,7 +938,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 
 static struct strbuf patch = STRBUF_INIT;
 
-static int stash_patch(struct stash_info *info, struct pathspec ps)
+static int stash_patch(struct stash_info *info, struct pathspec ps, int quiet)
 {
 	int i;
 	int ret = 0;
@@ -991,7 +991,8 @@ static int stash_patch(struct stash_info *info, struct pathspec ps)
 	}
 
 	if (!patch.len) {
-		fprintf_ln(stderr, _("No changes selected"));
+		if (!quiet)
+			fprintf_ln(stderr, _("No changes selected"));
 		ret = 1;
 	}
 
@@ -1069,7 +1070,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 
 static int do_create_stash(struct pathspec ps, const char **stash_msg,
 			   int include_untracked, int patch_mode,
-			   struct stash_info *info)
+			   struct stash_info *info, int quiet)
 {
 	int untracked_commit_option = 0;
 	int ret = 0;
@@ -1094,7 +1095,8 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
 	}
 
 	if (get_oid("HEAD", &info->b_commit)) {
-		fprintf_ln(stderr, _("You do not have the initial commit yet"));
+		if (!quiet)
+			fprintf_ln(stderr, _("You do not have the initial commit yet"));
 		ret = -1;
 		*stash_msg = NULL;
 		goto done;
@@ -1115,7 +1117,8 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
 	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
 	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
 			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
-		fprintf_ln(stderr, _("Cannot save the current index state"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot save the current index state"));
 		ret = -1;
 		*stash_msg = NULL;
 		goto done;
@@ -1124,7 +1127,8 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
 	if (include_untracked && get_untracked_files(ps, include_untracked,
 						     &out)) {
 		if (save_untracked_files(info, &msg, &out)) {
-			fprintf_ln(stderr, _("Cannot save the untracked files"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save the untracked files"));
 			ret = -1;
 			*stash_msg = NULL;
 			goto done;
@@ -1132,17 +1136,19 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps);
+		ret = stash_patch(info, ps, quiet);
 		*stash_msg = NULL;
 		if (ret < 0) {
-			fprintf_ln(stderr, _("Cannot save the current worktree state"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save the current worktree state"));
 			goto done;
 		} else if (ret > 0) {
 			goto done;
 		}
 	} else {
 		if (stash_working_tree(info, ps)) {
-			fprintf_ln(stderr, _("Cannot save the current worktree state"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save the current worktree state"));
 			ret = -1;
 			*stash_msg = NULL;
 			goto done;
@@ -1168,7 +1174,8 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
 
 	if (commit_tree(*stash_msg, strlen(*stash_msg), &info->w_tree,
 			parents, &info->w_commit, NULL, NULL)) {
-		fprintf_ln(stderr, _("Cannot record working tree state"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot record working tree state"));
 		ret = -1;
 		goto done;
 	}
@@ -1201,7 +1208,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 			     0);
 
 	memset(&ps, 0, sizeof(ps));
-	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info);
+	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info, 0);
 
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1255,28 +1262,33 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 		return -1;
 
 	if (!check_changes(ps, include_untracked)) {
-		printf_ln(_("No local changes to save"));
+		if (!quiet)
+			printf_ln(_("No local changes to save"));
 		return 0;
 	}
 
 	if (!reflog_exists(ref_stash) && do_clear_stash()) {
-		fprintf_ln(stderr, _("Cannot initialize stash"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot initialize stash"));
 		return -1;
 	}
 
 	if (do_create_stash(ps, &stash_msg, include_untracked, patch_mode,
-			    &info)) {
+			    &info, quiet)) {
 		ret = -1;
 		goto done;
 	}
 
 	if (do_store_stash(oid_to_hex(&info.w_commit), stash_msg, 1)) {
-		fprintf(stderr, _("Cannot save the current status"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot save the current status"));
 		ret = -1;
 		goto done;
 	}
 
-	printf_ln(_("Saved working directory and index state %s"), stash_msg);
+	if (!quiet)
+		printf_ln(_("Saved working directory and index state %s"),
+			stash_msg);
 
 	if (!patch_mode) {
 		if (include_untracked && !ps.nr) {
@@ -1375,7 +1387,8 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 		argv_array_pushl(&cp.args, "apply", "-R", NULL);
 
 		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
-			fprintf_ln(stderr, _("Cannot remove worktree changes"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot remove worktree changes"));
 			ret = -1;
 			goto done;
 		}
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3114c7bc4c..ed4611d3d8 100755
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
2.19.0.rc0.22.gc26283d74e

