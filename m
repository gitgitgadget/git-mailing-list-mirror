Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF481F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeIZEo1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33468 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeIZEo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id g26-v6so212203edp.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nRCxfS81ntbf/koySzoV/kzjnRTIu6+hgctDbWXzHjw=;
        b=grifNlEoGgZxye+2ra/bI485OLRR8eCvCIlCZkC8neSXfL9ra0MI3TwOTeklY4LRbv
         tEfWZ5Dpbv/YnylSyBKr2iP/xwTlaCb1m+DifjOrhsUAAElnfxaIoM8hLksxk1Zh5vJA
         9gJP6jBuAMdvDazqYkHvUfG58QYoeMAgNhU2EUtMNNoRkRjnMeXHfLHc1Rku7r+nWRMb
         y++EK8HUC/kgNdYNhtsVGwZtDMFyxvQuyAWkVGX1HlSpCgLf8cyuctCRkhvk6xMUYnuy
         I/tTT7yY8FtHamy6OUX2Ls9PLr5/hWwUZsODGhD4MhWSygpnkW9YCQG0Y0cBipXJGr97
         4rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nRCxfS81ntbf/koySzoV/kzjnRTIu6+hgctDbWXzHjw=;
        b=JPNcleG+YPvGXq3pTcHSJilFb5J7d7MqA3wKa4LY7bVBCW1BjoDORiOsZHs4wkQomd
         wSXcjemUHC38wkUWvWqCkV3q1fuaxuwEWnzt5NLyqu8duKlybTKs6SZ/yo6aEdXMCmNi
         DW9Qela3C8xkRtGtm+55KhckDmHxN5Nb/kPpfUudZ69/WWcbRVzA945xpFKIJSnY93r1
         fyIrDv4vjmSJpSoz3RAXjTRlD4DnKQjC4iOi3weXDE9ULKu6XB/G3VIZJYN++Ngd5LU8
         h9oo4wfhM1icJ9Rs02IA4fWthY+7UStruBCC0irEnLxdoK/ps9MP8Kj0crV0AHH8uesR
         bykw==
X-Gm-Message-State: ABuFfoiZP2zCNP3Xmsx+iKCwsurfKF99ddWQaa2EDl9LuXzIfWvANona
        4JYgerUfKML6EfvpM/CwtD/bWGLw
X-Google-Smtp-Source: ACcGV60dpRtuSzgy9CsWCgBZ9YAqVKoJ2Mp4Ot1XmBZ3brDb3FBysWWGZSZrORO0ViItCKYTwzUKlA==
X-Received: by 2002:a50:a588:: with SMTP id a8-v6mr5010887edc.289.1537914880436;
        Tue, 25 Sep 2018 15:34:40 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:39 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 17/21] stash: make push -q quiet
Date:   Wed, 26 Sep 2018 01:33:33 +0300
Message-Id: <a09ae6260efec6a1d608a0df96b6e3680b5a15a1.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
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
 builtin/stash--helper.c | 45 ++++++++++++++++++++++++++---------------
 t/t3903-stash.sh        | 23 +++++++++++++++++++++
 2 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index d79233d7ec..73bb22dc94 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -967,7 +967,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 }
 
 static int stash_patch(struct stash_info *info, struct pathspec ps,
-		       struct strbuf *out_patch)
+		       struct strbuf *out_patch, int quiet)
 {
 	int ret = 0;
 	struct strbuf out = STRBUF_INIT;
@@ -1020,7 +1020,8 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	}
 
 	if (!out_patch->len) {
-		fprintf_ln(stderr, _("No changes selected"));
+		if (!quiet)
+			fprintf_ln(stderr, _("No changes selected"));
 		ret = 1;
 	}
 
@@ -1098,7 +1099,8 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 
 static int do_create_stash(struct pathspec ps, char **stash_msg,
 			   int include_untracked, int patch_mode,
-			   struct stash_info *info, struct strbuf *patch)
+			   struct stash_info *info, struct strbuf *patch,
+			   int quiet)
 {
 	int ret = 0;
 	int flags = 0;
@@ -1117,7 +1119,8 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 	refresh_cache(REFRESH_QUIET);
 
 	if (get_oid("HEAD", &info->b_commit)) {
-		fprintf_ln(stderr, _("You do not have the initial commit yet"));
+		if (!quiet)
+			fprintf_ln(stderr, _("You do not have the initial commit yet"));
 		ret = -1;
 		*stash_msg = NULL;
 		goto done;
@@ -1144,7 +1147,8 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
 	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
 			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
-		fprintf_ln(stderr, _("Cannot save the current index state"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot save the current index state"));
 		ret = -1;
 		*stash_msg = NULL;
 		goto done;
@@ -1153,7 +1157,8 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 	if (include_untracked && get_untracked_files(ps, include_untracked,
 						     &untracked_files)) {
 		if (save_untracked_files(info, &msg, untracked_files)) {
-			fprintf_ln(stderr, _("Cannot save the untracked files"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save the untracked files"));
 			ret = -1;
 			*stash_msg = NULL;
 			goto done;
@@ -1161,17 +1166,19 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps, patch);
+		ret = stash_patch(info, ps, patch, quiet);
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
@@ -1197,7 +1204,8 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 
 	if (commit_tree(*stash_msg, strlen(*stash_msg), &info->w_tree,
 			parents, &info->w_commit, NULL, NULL)) {
-		fprintf_ln(stderr, _("Cannot record working tree state"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot record working tree state"));
 		ret = -1;
 		goto done;
 	}
@@ -1231,7 +1239,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 
 	memset(&ps, 0, sizeof(ps));
 	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info,
-			      NULL);
+			      NULL, 0);
 
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1295,23 +1303,27 @@ static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
 	if (!reflog_exists(ref_stash) && do_clear_stash()) {
 		stash_msg = NULL;
 		ret = -1;
-		fprintf_ln(stderr, _("Cannot initialize stash"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot initialize stash"));
 		goto done;
 	}
 
 	if (do_create_stash(ps, &stash_msg, include_untracked, patch_mode,
-			    &info, &patch)) {
+			    &info, &patch, quiet)) {
 		ret = -1;
 		goto done;
 	}
 
 	if (do_store_stash(&info.w_commit, stash_msg, 1)) {
 		ret = -1;
-		fprintf_ln(stderr, _("Cannot save the current status"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot save the current status"));
 		goto done;
 	}
 
-	printf_ln(_("Saved working directory and index state %s"), stash_msg);
+	if (!quiet)
+		printf_ln(_("Saved working directory and index state %s"),
+			  stash_msg);
 
 	if (!patch_mode) {
 		if (include_untracked && !ps.nr) {
@@ -1412,7 +1424,8 @@ static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
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
2.19.0.rc0.23.g1fb9f40d88

