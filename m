Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E096B1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbeLTTpN (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40656 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389449AbeLTTpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so2988412wrt.7
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzzPuVxc3vgTRs8OE9ZT9k8wESiX84mYKjr6qiWY7bM=;
        b=F/mACFAP8WpNcb3zi/C+taIb1CdLRF7TljFGqw67AxrI5VR2nVoOjQ2tnehb0p8D46
         hmmsneigzqrbGsdW7djHhR0DMwu3lXkHp+Sh/IGgd+2Y8iQsrx/CfsUau5PK3V4E/S9A
         XCKCl0wycfPiY4Q6uC8o7c4BSKZx9mtlV5/AFR3WYAv2A/hnfHRyBLSptVmlWoSlfg0I
         tgMyL7yGHhYyiOgIdZKs9xVbJ9Urqz2iYwc/CLaz3oTisP1DBo4qM651pUYKa/g4JqrU
         Jl1HYf41KPp4aph7Fh6S4Vk+rwulMri2Y6ezTUo5YjH74K3v+kl8fgJ6AfYLz2E8mGzo
         F/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzzPuVxc3vgTRs8OE9ZT9k8wESiX84mYKjr6qiWY7bM=;
        b=O7tXZoPeXR+ELAkHpgIswiQ4ba/InW/p1YNb3/jkC1WF+T8ZqUojzW+Qf835U/fmLu
         /YGkf9elVxTwauawFikG4M4vvOJmvZNoI52q/MzpSl1tIirscyA8Gh6iy/pFO6y1aGMG
         AZyxvUzqJZ2fOhpQK6/UrLk9lHdZUJe8ySiINnX1UKCwTt0NcZK9QH/gGA2MdBe/UO5+
         eNDj6ivvWUJIgMXAXyKiIjF66T9X5bz3TEk9Sq6VLFk5Zsy9YYpjhyik638yiWFlcCpe
         jkX7bklfScU5/zCE62Yw2vjL5SM6dhVzpjNI/rS4ZMtlUOijCrE6yOlOY3TRclzjvXvm
         vACQ==
X-Gm-Message-State: AA+aEWZDirTbeagUK3cfGpgwrwIPEbAnnNx/5DuPIVsd7BSeaHd1veDl
        w7/tUo0f64k6SPGPGJF2/hRXF101IBU=
X-Google-Smtp-Source: AFSGD/W8DjmUdwdgRRoDOrFJ9VkhRWr+LeEu7/QsGuK4ssuZSlc0xNomWK3RpWs0vh4/k2/PA3dbQg==
X-Received: by 2002:adf:91a3:: with SMTP id 32mr21538544wri.99.1545335106490;
        Thu, 20 Dec 2018 11:45:06 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:45:05 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 19/26] stash: make push -q quiet
Date:   Thu, 20 Dec 2018 21:44:35 +0200
Message-Id: <033e7911bbdca69bd785e04c5645390f5adae984.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
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
index c77f62c895..5f9914ca27 100644
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
@@ -1122,7 +1124,9 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 	refresh_cache(REFRESH_QUIET);
 
 	if (get_oid("HEAD", &info->b_commit)) {
-		fprintf_ln(stderr, _("You do not have the initial commit yet"));
+		if (!quiet)
+			fprintf_ln(stderr, _("You do not have "
+					     "the initial commit yet"));
 		ret = -1;
 		goto done;
 	} else {
@@ -1147,7 +1151,9 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
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
@@ -1155,26 +1161,29 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
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
@@ -1200,7 +1209,9 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 
 	if (commit_tree(stash_msg_buf->buf, stash_msg_buf->len, &info->w_tree,
 			parents, &info->w_commit, NULL, NULL)) {
-		fprintf_ln(stderr, _("Cannot record working tree state"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot record "
+					     "working tree state"));
 		ret = -1;
 		goto done;
 	}
@@ -1235,7 +1246,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	memset(&ps, 0, sizeof(ps));
 	strbuf_addstr(&stash_msg_buf, stash_msg);
 	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
-			      NULL);
+			      NULL, 0);
 
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1298,26 +1309,29 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 
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
@@ -1418,7 +1432,9 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
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
index 98c25a671c..b67d7a1120 100755
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
2.20.1.441.g764a526393

