Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D091F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeJOFz4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38245 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOFzz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1-v6so16083423ede.5
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5IpOGlGifsB/xQS1Zfh01YOGCLKkMxi+mJI08Mhty4c=;
        b=ecGxM+ivJymPYY4PTttc6LsNcrGVVoz+xQtU/M9pfoY762iZe41ZZY4Mmn4BGQuM+j
         ZswzfCxbPM4rcUBiLwHxFDc4l2aRYI+e1Obkl0WSextguJGyxVk7aH7TlCWzPsp/nrWY
         cQ4kN2Fk9QWOmpbWz2dcKcPZcyjpwJh7YZf/v1mnP1vvTwDQAD4f/lDZEbixZ77hLr4P
         nCUnsE8uQO5i9yD16uYe0x2YqgM7ndlzYReYfHqP1c/m6gaLBSqj1CwxuIKGIuoL9RNz
         zMEBKuPdD+XqgF4ksoFvAt3UspB6msuVwMjMfYoaCZ/m8uSxg286xgBCIfMCrRK8vJhf
         pfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5IpOGlGifsB/xQS1Zfh01YOGCLKkMxi+mJI08Mhty4c=;
        b=DCJpYdQ5kYwK2zLXYZU1v4cZMjYEh3pl8YJMf/rwgtLOCRWxKDVOMyVmcLNAwJQ11d
         7zqxF+J57m2L89znuChZwwzyiHrTi71bJwKAOg+2H58u6obvFfJP7twOUaMIZeH9yD7A
         MClg6QIQPAZpGEKZEApiyiLgkFTFHm+JrYBiAmsgazENJRx0kjUc5JeXjj4X9XoeF6up
         xs+Rqjt1hfLXP+hXOZNUSDHjGY8oGvZ4Aq3rbZ8KeKjfyTmh8z/4XUzQ9EFkLQ1HwWrh
         eVyEjMf1R4KpEa0g0ySebjVjmoX+V1lcqeHo9shSm8RGftC9nJW1AjPRWyNMpKkPGf9/
         V4vQ==
X-Gm-Message-State: ABuFfogDDPXlIXzS+5jVB0+pUDk1KqYlhB2JWimd9O2ziLS0XIoUuW2O
        xHqCEHkCWW0yvWOhY2+SoNrdDFef
X-Google-Smtp-Source: ACcGV60jCsKdpv/Dr95JcBEP3z4pu0B3YR+Wo6ZNEX80EhTy2x92VcC1vuLJTDISpT+G9j4mYmw6aQ==
X-Received: by 2002:a17:906:1096:: with SMTP id u22-v6mr16518584eju.197.1539555206503;
        Sun, 14 Oct 2018 15:13:26 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:25 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 17/21] stash: make push -q quiet
Date:   Mon, 15 Oct 2018 01:11:23 +0300
Message-Id: <ea8814762c75a3387b9e697f62ea6122b5a1d014.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
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
 builtin/stash--helper.c | 55 +++++++++++++++++++++++++++--------------
 t/t3903-stash.sh        | 23 +++++++++++++++++
 2 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 23f1329637..befb944871 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -973,7 +973,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 }
 
 static int stash_patch(struct stash_info *info, struct pathspec ps,
-		       struct strbuf *out_patch)
+		       struct strbuf *out_patch, int quiet)
 {
 	int ret = 0;
 	struct strbuf out = STRBUF_INIT;
@@ -1026,7 +1026,8 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	}
 
 	if (!out_patch->len) {
-		fprintf_ln(stderr, _("No changes selected"));
+		if (!quiet)
+			fprintf_ln(stderr, _("No changes selected"));
 		ret = 1;
 	}
 
@@ -1105,7 +1106,8 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 
 static int do_create_stash(struct pathspec ps, char **stash_msg,
 			   int include_untracked, int patch_mode,
-			   struct stash_info *info, struct strbuf *patch)
+			   struct stash_info *info, struct strbuf *patch,
+			   int quiet)
 {
 	int ret = 0;
 	int flags = 0;
@@ -1124,7 +1126,9 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 	refresh_cache(REFRESH_QUIET);
 
 	if (get_oid("HEAD", &info->b_commit)) {
-		fprintf_ln(stderr, _("You do not have the initial commit yet"));
+		if (!quiet)
+			fprintf_ln(stderr, _("You do not have "
+					     "the initial commit yet"));
 		ret = -1;
 		*stash_msg = NULL;
 		goto done;
@@ -1151,7 +1155,9 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
 	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
 			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
-		fprintf_ln(stderr, _("Cannot save the current index state"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot save the current "
+					     "index state"));
 		ret = -1;
 		*stash_msg = NULL;
 		goto done;
@@ -1160,8 +1166,9 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 	if (include_untracked && get_untracked_files(ps, include_untracked,
 						     &untracked_files)) {
 		if (save_untracked_files(info, &msg, untracked_files)) {
-			fprintf_ln(stderr, _("Cannot save "
-					     "the untracked files"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save "
+						     "the untracked files"));
 			ret = -1;
 			*stash_msg = NULL;
 			goto done;
@@ -1169,19 +1176,21 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps, patch);
+		ret = stash_patch(info, ps, patch, quiet);
 		*stash_msg = NULL;
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
 			*stash_msg = NULL;
 			goto done;
@@ -1210,7 +1219,9 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 
 	if (commit_tree(*stash_msg, strlen(*stash_msg), &info->w_tree,
 			parents, &info->w_commit, NULL, NULL)) {
-		fprintf_ln(stderr, _("Cannot record working tree state"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot record "
+					     "working tree state"));
 		ret = -1;
 		goto done;
 	}
@@ -1244,7 +1255,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 
 	memset(&ps, 0, sizeof(ps));
 	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info,
-			      NULL);
+			      NULL, 0);
 
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1306,23 +1317,27 @@ static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
 
 	if (!reflog_exists(ref_stash) && do_clear_stash()) {
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
@@ -1423,7 +1438,9 @@ static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
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
2.19.0.rc0.23.g10a62394e7

