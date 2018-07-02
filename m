Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4C91F516
	for <e@80x24.org>; Mon,  2 Jul 2018 10:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934070AbeGBK6F (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 06:58:05 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33454 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeGBK6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 06:58:01 -0400
Received: by mail-wr0-f193.google.com with SMTP id k7-v6so11575305wrq.0
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwbXDAWxdSeKu9/VSmryLlwvAP2zifMZNyblEYb/JCk=;
        b=cR8hUEQ8pSqXqeNPd9ucza4YLFJXfF1uaHRJGVhEVsecrTznodqAUwjcKkarEwUfxK
         pCniIQtD3EW7n0OxsV7b2EEw7LbwwDbLRyhAEz7zVxtPeBQk00dS7PN59v5ulpIhXDV0
         I5YI6VAKkW3i9LtoXv696E5kfo77lO84L67JXjDNqM2AFgGcch08tyFZyuCKyZtCYRzQ
         cMS2KIt+xgPWyq5ty9oNdSg+x/yr4IYk4z+7vXQKsSHNCdfOStq5d8yjGmqLFH0WkU31
         6FkPTrAU8Q7CGjbrwFiMu1sHUqNZNGctqFHAEO0aA7cz4q6sXndeXmxsRPHbAfEV8kt/
         aAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwbXDAWxdSeKu9/VSmryLlwvAP2zifMZNyblEYb/JCk=;
        b=Iysdwy6PZPy9Y1ZrUfMOrwGCbHL8ZncME7WAyBmr/BG1BbZg03JRGp80fhaK4s+Lgq
         RfIdlhIKO45AnwhAhs4YepOeQxhhtKr564TMahzfDmfsp5rEUyVt40eDYh+qDjFBzprn
         qkrAxZkb+abjcCQpOGNJueOvP2fpdsJCpKlxOzpuiAJ3QBtBSw50iWB8OSXhLTC36Mvq
         HO2dx0i4K+pzUVIcx83u8msWCbH8Lxa4it1u6eXE8qWhT7Iy9RVmnUTG6FI3gdJ49oHe
         yM03+pV5R/VpLeIwdjgneeFBTIUyP5HXmguCemuDZiBu617nV3U6RzHrRI7QNoaop8Tb
         zgiw==
X-Gm-Message-State: APt69E2AjDyS6c16+BxZFVn0yaWavsDP7CcNAY5FW+MF/WO4NyCCP+ds
        vpdmQH5qpuMRIOjc9gVCgNCQa2mn
X-Google-Smtp-Source: AAOMgpdlfM475bsUJ31Au4IWqPXqtil0kb4dZ2240gMk2k1T+pjx13b/M1/7DpQsAIR1kcnErk3c5Q==
X-Received: by 2002:adf:b86b:: with SMTP id u40-v6mr19118473wrf.162.1530529080220;
        Mon, 02 Jul 2018 03:58:00 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.googlemail.com with ESMTPSA id m64-v6sm7462437wmb.38.2018.07.02.03.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 03:57:59 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 1/7] sequencer: make two functions and an enum from sequencer.c public
Date:   Mon,  2 Jul 2018 12:57:11 +0200
Message-Id: <20180702105717.26386-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702105717.26386-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes rebase_path_todo(), get_missing_commit_check_level() and the
enum check_level accessible outside sequencer.c.  check_level is renamed
missing_commit_check_level, and its value names are prefixed by
MISSING_COMMIT_ to avoid namespace pollution.

This will be needed for the rewrite of append_todo_help() from shell to
C, as it will be in a new library source file, rebase-interactive.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 22 +++++++++-------------
 sequencer.h |  8 ++++++++
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5354d4d51..57fd58bc1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -51,7 +51,7 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * the lines are processed, they are removed from the front of this
  * file and written to the tail of 'done'.
  */
-static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
+GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
@@ -4221,24 +4221,20 @@ int transform_todos(unsigned flags)
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
@@ -4250,7 +4246,7 @@ define_commit_slab(commit_seen, unsigned char);
  */
 int check_todo_list(void)
 {
-	enum check_level check_level = get_missing_commit_check_level();
+	enum missing_commit_check_level check_level = get_missing_commit_check_level();
 	struct strbuf todo_file = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf missing = STRBUF_INIT;
@@ -4267,7 +4263,7 @@ int check_todo_list(void)
 	advise_to_edit_todo = res =
 		parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
-	if (res || check_level == CHECK_IGNORE)
+	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
 
 	/* Mark the commits in git-rebase-todo as seen */
@@ -4302,7 +4298,7 @@ int check_todo_list(void)
 	if (!missing.len)
 		goto leave_check;
 
-	if (check_level == CHECK_ERROR)
+	if (check_level == MISSING_COMMIT_CHECK_ERROR)
 		advise_to_edit_todo = res = 1;
 
 	fprintf(stderr,
diff --git a/sequencer.h b/sequencer.h
index c5787c6b5..ffab798f1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -3,6 +3,7 @@
 
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
+const char *rebase_path_todo(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
@@ -57,6 +58,12 @@ struct replay_opts {
 };
 #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
 
+enum missing_commit_check_level {
+	MISSING_COMMIT_CHECK_IGNORE = 0,
+	MISSING_COMMIT_CHECK_WARN,
+	MISSING_COMMIT_CHECK_ERROR
+};
+
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct replay_opts *opts);
@@ -79,6 +86,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 
 int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
+enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
-- 
2.18.0

