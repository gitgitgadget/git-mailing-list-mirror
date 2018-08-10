Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0743B1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeHJTWz (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:22:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42689 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeHJTWz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:22:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so8843447wrs.9
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MBqEfx1+giT96IXZGWvTt35KbamE9ksEIzQEp7yPiZY=;
        b=YqectECFWHIKPanyJnrAT02/xdX8GF1SX5c/VHB081HaSUdLlxVNpVjtoc6CQa/Jgh
         84tIjmbADkbqsljiaZ3vso+PR96L3dJCOkcPlR7w/9eJFZz7PMdaJnbcIWkL/VFJ+y1q
         xBFTTp4BmhHH2GuveyDf9qJ3cItWP7h+pvmTCDpSKQ1if72UMg0bCVHu/nqXkdGPsAJE
         XaAiVsSO2IV/A4Kz1HkHlyEG7gOXo+GcNEUV1KKFJICKm8DoFSvFJLDqn2dng7cdl4al
         ouNJPVZQ14eUKvFivgPYTmL7I/Z7+8T0h2RFbQ3dlNWbS/EGFD301OByCaJy2CJb3NCX
         Y1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MBqEfx1+giT96IXZGWvTt35KbamE9ksEIzQEp7yPiZY=;
        b=Yg3B94u2dE1ZIxX4FjwFUBPVEcjncrrqhj3nG+AE93Lt7wkhWhRK2FfHdd5nFpMPEQ
         ASyKJx/wo9amiaRGECOAmCrvF7a6TXnLKvxOjL3HyJ7RjiHDqaLGm6PFRhboUzqWQJn/
         JIGyGJJn7W6S48OMgH7fiuvwRdafwXHRdDDjZ4fP8ckuPq6tBmuwf3dXPPMM9x3quxF5
         GD6JJgNCR0BmqwMvkY9mDDtA0qe/JZd5ZsrH/UhnJrtjuAcesOj0Vsmm7EmQ1MzMfeWM
         EWIS5/x69aP7QCNOm+saGpyVYkMkZNcGSltkfnz7hWODTbmQ3Oiac9hizwDERZheWnE7
         a4qg==
X-Gm-Message-State: AOUpUlHcZunPK+RZGPzLi3QVX/XboTCvwHOnnFYjPuiH2KiIOHu++2i9
        NbAbe5lHZnilExEIQWg+IzbWwIdk
X-Google-Smtp-Source: AA+uWPx/fL21+p/4ZjcTl3KELbMovN8pxDG44bqiZgurF/UcVkpx94f0qt9qkKoHQWDr5XqPddlxPQ==
X-Received: by 2002:adf:e14a:: with SMTP id f10-v6mr4557744wri.42.1533919935152;
        Fri, 10 Aug 2018 09:52:15 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:14 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 01/20] sequencer: make three functions and an enum from sequencer.c public
Date:   Fri, 10 Aug 2018 18:51:28 +0200
Message-Id: <20180810165147.4779-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes rebase_path_todo(), get_missing_commit_check_level(),
write_message() and the enum check_level accessible outside sequencer.c,
renames check_level to missing_commit_check_level, and prefixes its
value names by MISSING_COMMIT_ to avoid namespace pollution.

This function and this enum will eventually be moved to
rebase-interactive.c and become static again, so no special attention
was given to the naming.

This will be needed for the rewrite of append_todo_help() from shell to
C, as it will be in a new library source file, rebase-interactive.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 26 +++++++++++---------------
 sequencer.h | 11 +++++++++++
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 16c1411054..dd1b060863 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -52,7 +52,7 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * the lines are processed, they are removed from the front of this
  * file and written to the tail of 'done'.
  */
-static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
+GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
@@ -373,8 +373,8 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	}
 }
 
-static int write_message(const void *buf, size_t len, const char *filename,
-			 int append_eol)
+int write_message(const void *buf, size_t len, const char *filename,
+		  int append_eol)
 {
 	struct lock_file msg_file = LOCK_INIT;
 
@@ -4249,24 +4249,20 @@ int transform_todos(unsigned flags)
 	return i;
 }
 
-enum check_level {
-	CHECK_IGNORE = 0, CHECK_WARN, CHECK_ERROR
-};
-
-static enum check_level get_missing_commit_check_level(void)
+enum missing_commit_check_level get_missing_commit_check_level(void)
 {
 	const char *value;
 
 	if (git_config_get_value("rebase.missingcommitscheck", &value) ||
 			!strcasecmp("ignore", value))
-		return CHECK_IGNORE;
+		return MISSING_COMMIT_CHECK_IGNORE;
 	if (!strcasecmp("warn", value))
-		return CHECK_WARN;
+		return MISSING_COMMIT_CHECK_WARN;
 	if (!strcasecmp("error", value))
-		return CHECK_ERROR;
+		return MISSING_COMMIT_CHECK_ERROR;
 	warning(_("unrecognized setting %s for option "
 		  "rebase.missingCommitsCheck. Ignoring."), value);
-	return CHECK_IGNORE;
+	return MISSING_COMMIT_CHECK_IGNORE;
 }
 
 define_commit_slab(commit_seen, unsigned char);
@@ -4278,7 +4274,7 @@ define_commit_slab(commit_seen, unsigned char);
  */
 int check_todo_list(void)
 {
-	enum check_level check_level = get_missing_commit_check_level();
+	enum missing_commit_check_level check_level = get_missing_commit_check_level();
 	struct strbuf todo_file = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf missing = STRBUF_INIT;
@@ -4295,7 +4291,7 @@ int check_todo_list(void)
 	advise_to_edit_todo = res =
 		parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
-	if (res || check_level == CHECK_IGNORE)
+	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
 
 	/* Mark the commits in git-rebase-todo as seen */
@@ -4330,7 +4326,7 @@ int check_todo_list(void)
 	if (!missing.len)
 		goto leave_check;
 
-	if (check_level == CHECK_ERROR)
+	if (check_level == MISSING_COMMIT_CHECK_ERROR)
 		advise_to_edit_todo = res = 1;
 
 	fprintf(stderr,
diff --git a/sequencer.h b/sequencer.h
index c5787c6b56..792e448b67 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -3,6 +3,7 @@
 
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
+const char *rebase_path_todo(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
@@ -57,6 +58,15 @@ struct replay_opts {
 };
 #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
 
+enum missing_commit_check_level {
+	MISSING_COMMIT_CHECK_IGNORE = 0,
+	MISSING_COMMIT_CHECK_WARN,
+	MISSING_COMMIT_CHECK_ERROR
+};
+
+int write_message(const void *buf, size_t len, const char *filename,
+		  int append_eol);
+
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct replay_opts *opts);
@@ -79,6 +89,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 
 int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
+enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
-- 
2.18.0

