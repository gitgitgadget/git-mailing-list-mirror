Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C814AC352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 23:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF04206DB
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 23:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9k6bRZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgBLXuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:50:51 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39184 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBLXuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 18:50:51 -0500
Received: by mail-vs1-f66.google.com with SMTP id p14so2426143vsq.6
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 15:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2TARZ49dyg9iIkEnB5t9byndktkO+qUDcFgQOqC3qoc=;
        b=H9k6bRZmjdF5rWcqoO54bbPdpBqajGzIaXnrV+4ULnVqkU20MtlZ87zcCWo6/Lf4+q
         uwx/FXBNUwJeJTB7yIVuQT0GFtd7vM7lp2hd8L8c6zGFmy2a1tceDxcOcAoLYhrqi05e
         rWxno6OaIqnHWCRhyhwsFrUfLVNqlO4nzJa81tmuZgzgI08xaTc9TAs4kyGE6djuQPVD
         0IxzGfkXqgDG9JsaAVBZ9E5Dz+3Heds+UbLN5YuTxli+DCbPrt/XYHJdvTeFAUzaV0b3
         nB1pqpjES/TOrkfIeS/F2zJmUYctGQtQeqmrqCOIi4dks4t/nJv7N9rlx7Kq51bKHQ4l
         APow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2TARZ49dyg9iIkEnB5t9byndktkO+qUDcFgQOqC3qoc=;
        b=mfvdRjRxkoka2PAdvX2llksHEptfJ06LlaWSXvOTD8FnXZKSNcDhw0joHb+yY/DVz0
         gDL4nBSluEHuY5oMjPORZeNWDjSXDoHSOeRpx+iBX/sFhneFOngmZvgiP+UtGypKJhM1
         HPyQ9xkV7Y1jk5MJNSYPPMoR9t27SM4c/AczL980usjzSSyHkWYcd6lHrkIpTrmLVRJC
         WeunyPHMvLEASCH6i4U2lsoBm44piaGRgroI2G3/GlwIyKbM0JKKta1v3RW2bK9p3OuO
         nslmlVqblp1jkoUWHNoF/NaSVGdS+ngkprEkoPjHbRWOqK00kiJ8g8PjdV8QOgDYjmGm
         xrVg==
X-Gm-Message-State: APjAAAXFvtyjsZLsBuyqdtmU39C7070wOKJVBHDEkLhnKvNtq0xgTSqq
        iWyrS/65CnA4rjoWziG0rUW8s+PeedW3Gw==
X-Google-Smtp-Source: APXvYqzWVFb5FkxFU+Zy5/1cYVUPJDMmUWKWUUtJOBxYulpQcUUROAlK/vgrMi0PPC/qOvoFmSprkw==
X-Received: by 2002:a67:ae43:: with SMTP id u3mr15103339vsh.44.1581551449657;
        Wed, 12 Feb 2020 15:50:49 -0800 (PST)
Received: from linuxerio.hitronhub.home ([186.4.59.87])
        by smtp.gmail.com with ESMTPSA id m80sm180266vka.26.2020.02.12.15.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:50:49 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH] [RFC PATCH] stash save/push: add --index-only option
Date:   Wed, 12 Feb 2020 17:50:33 -0600
Message-Id: <20200212235033.782656-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow git-stash to save only the content of what's in staging area.
No working tree files (unstaged or untracked) will be added
to the stash nor will be modified then the opreration finishes.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/stash.c | 115 ++++++++++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 43 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 879fc5f368..d96b849965 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -27,9 +27,10 @@ static const char * const git_stash_usage[] = {
 	N_("git stash clear"),
 	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
-	   "          [--] [<pathspec>...]]"),
+	   "          [-i|--index-only] [--] [<pathspec>...]]"),
 	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
+	   "          [-u|--include-untracked] [-a|--all]\n"
+	   "          [-i|--index-only] [<message>]"),
 	NULL
 };
 
@@ -76,13 +77,14 @@ static const char * const git_stash_store_usage[] = {
 static const char * const git_stash_push_usage[] = {
 	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
-	   "          [--] [<pathspec>...]]"),
+	   "          [-i|--index-only] [--] [<pathspec>...]]"),
 	NULL
 };
 
 static const char * const git_stash_save_usage[] = {
 	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
+	   "          [-u|--include-untracked] [-i|--index-only] [-a|--all]\n"
+	   "          [<message>]"),
 	NULL
 };
 
@@ -1055,7 +1057,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	return ret;
 }
 
-static int stash_working_tree(struct stash_info *info, const struct pathspec *ps)
+static int stash_working_tree(struct stash_info *info, const struct pathspec *ps, int index_only)
 {
 	int ret = 0;
 	struct rev_info rev;
@@ -1089,17 +1091,20 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 		goto done;
 	}
 
-	cp_upd_index.git_cmd = 1;
-	argv_array_pushl(&cp_upd_index.args, "update-index",
-			 "--ignore-skip-worktree-entries",
-			 "-z", "--add", "--remove", "--stdin", NULL);
-	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-
-	if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
-			 NULL, 0, NULL, 0)) {
-		ret = -1;
-		goto done;
+	if (!index_only) {
+		cp_upd_index.git_cmd = 1;
+		argv_array_pushl(&cp_upd_index.args, "update-index",
+				"--ignore-skip-worktree-entries",
+				"-z", "--add", "--remove", "--stdin", NULL);
+		argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
+				stash_index_path.buf);
+
+		if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
+				NULL, 0, NULL, 0)) {
+			printf("salimos por pipe_command\n");
+			ret = -1;
+			goto done;
+		}
 	}
 
 	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
@@ -1119,7 +1124,7 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 }
 
 static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_buf,
-			   int include_untracked, int patch_mode,
+			   int include_untracked, int index_only, int patch_mode,
 			   struct stash_info *info, struct strbuf *patch,
 			   int quiet)
 {
@@ -1199,7 +1204,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 			goto done;
 		}
 	} else {
-		if (stash_working_tree(info, ps)) {
+		if (stash_working_tree(info, ps, index_only)) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
 						     "worktree state"));
@@ -1256,7 +1261,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	if (!check_changes_tracked_files(&ps))
 		return 0;
 
-	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, &info,
+	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, 0, &info,
 			      NULL, 0);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1266,7 +1271,8 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 }
 
 static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
-			 int keep_index, int patch_mode, int include_untracked)
+			 int keep_index, int patch_mode, int include_untracked,
+			 int index_only)
 {
 	int ret = 0;
 	struct stash_info info;
@@ -1283,9 +1289,16 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		ret = -1;
 		goto done;
 	}
+	
+	if (include_untracked && index_only) {
+		fprintf_ln(stderr, _("Can't use --index_only and --include-untracked"
+				     " at the same time")); // TODO how about --all?
+		ret = -1;
+		goto done;
+	}
 
 	read_cache_preload(NULL);
-	if (!include_untracked && ps->nr) {
+	if (!include_untracked && !index_only && ps->nr) {
 		int i;
 		char *ps_matched = xcalloc(ps->nr, 1);
 
@@ -1322,8 +1335,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
-	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
-			    &info, &patch, quiet)) {
+	if (do_create_stash(ps, &stash_msg_buf, include_untracked, index_only,
+			    patch_mode, &info, &patch, quiet)) {
 		ret = -1;
 		goto done;
 	}
@@ -1335,9 +1348,14 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		goto done;
 	}
 
-	if (!quiet)
-		printf_ln(_("Saved working directory and index state %s"),
-			  stash_msg_buf.buf);
+	if (!quiet) {
+		if (index_only)
+			printf_ln(_("Saved index state %s"),
+				stash_msg_buf.buf);
+		else
+			printf_ln(_("Saved working directory and index state %s"),
+				stash_msg_buf.buf);
+	}
 
 	if (!patch_mode) {
 		if (include_untracked && !ps->nr) {
@@ -1354,30 +1372,34 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			}
 		}
 		discard_cache();
-		if (ps->nr) {
-			struct child_process cp_add = CHILD_PROCESS_INIT;
+		if (index_only || ps->nr) {
 			struct child_process cp_diff = CHILD_PROCESS_INIT;
 			struct child_process cp_apply = CHILD_PROCESS_INIT;
 			struct strbuf out = STRBUF_INIT;
 
-			cp_add.git_cmd = 1;
-			argv_array_push(&cp_add.args, "add");
-			if (!include_untracked)
-				argv_array_push(&cp_add.args, "-u");
-			if (include_untracked == INCLUDE_ALL_FILES)
-				argv_array_push(&cp_add.args, "--force");
-			argv_array_push(&cp_add.args, "--");
-			add_pathspecs(&cp_add.args, ps);
-			if (run_command(&cp_add)) {
-				ret = -1;
-				goto done;
+			if (!index_only) {
+				struct child_process cp_add = CHILD_PROCESS_INIT;
+
+				cp_add.git_cmd = 1;
+				argv_array_push(&cp_add.args, "add");
+				if (!include_untracked)
+					argv_array_push(&cp_add.args, "-u");
+				if (include_untracked == INCLUDE_ALL_FILES)
+					argv_array_push(&cp_add.args, "--force");
+				argv_array_push(&cp_add.args, "--");
+				add_pathspecs(&cp_add.args, ps);
+				if (run_command(&cp_add)) {
+					ret = -1;
+					goto done;
+				}
 			}
 
 			cp_diff.git_cmd = 1;
 			argv_array_pushl(&cp_diff.args, "diff-index", "-p",
 					 "--cached", "--binary", "HEAD", "--",
 					 NULL);
-			add_pathspecs(&cp_diff.args, ps);
+			if (!index_only)
+				add_pathspecs(&cp_diff.args, ps);
 			if (pipe_command(&cp_diff, NULL, 0, &out, 0, NULL, 0)) {
 				ret = -1;
 				goto done;
@@ -1391,7 +1413,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 				ret = -1;
 				goto done;
 			}
-		} else {
+		} else if (!index_only) {
 			struct child_process cp = CHILD_PROCESS_INIT;
 			cp.git_cmd = 1;
 			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
@@ -1456,6 +1478,7 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 	int keep_index = -1;
 	int patch_mode = 0;
 	int include_untracked = 0;
+	int index_only = 0;
 	int quiet = 0;
 	const char *stash_msg = NULL;
 	struct pathspec ps;
@@ -1467,6 +1490,8 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("quiet mode")),
 		OPT_BOOL('u', "include-untracked", &include_untracked,
 			 N_("include untracked files in stash")),
+		OPT_BOOL('i', "index-only", &index_only,
+			 N_("stash only what is in staging area")),
 		OPT_SET_INT('a', "all", &include_untracked,
 			    N_("include ignore files"), 2),
 		OPT_STRING('m', "message", &stash_msg, N_("message"),
@@ -1482,7 +1507,7 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 		       prefix, argv);
 	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
-			     include_untracked);
+			     include_untracked, index_only);
 }
 
 static int save_stash(int argc, const char **argv, const char *prefix)
@@ -1490,6 +1515,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	int keep_index = -1;
 	int patch_mode = 0;
 	int include_untracked = 0;
+	int index_only = 0;
 	int quiet = 0;
 	int ret = 0;
 	const char *stash_msg = NULL;
@@ -1503,6 +1529,8 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("quiet mode")),
 		OPT_BOOL('u', "include-untracked", &include_untracked,
 			 N_("include untracked files in stash")),
+		OPT_BOOL('i', "index-only", &index_only,
+			 N_("stash only what is in staging area")),
 		OPT_SET_INT('a', "all", &include_untracked,
 			    N_("include ignore files"), 2),
 		OPT_STRING('m', "message", &stash_msg, "message",
@@ -1519,7 +1547,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 
 	memset(&ps, 0, sizeof(ps));
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
-			    patch_mode, include_untracked);
+			    patch_mode, include_untracked, index_only);
 
 	strbuf_release(&stash_msg_buf);
 	return ret;
@@ -1625,6 +1653,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 			    !strcmp(argv[i], "--no-keep-index") ||
 			    !strcmp(argv[i], "--patch") ||
 			    !strcmp(argv[i], "--quiet") ||
+			    !strcmp(argv[i], "--index-only") ||
 			    !strcmp(argv[i], "--include-untracked"))
 				continue;
 
-- 
2.24.1

