Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0B21F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbeGXRla (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:41:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55353 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbeGXRla (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:41:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so3168310wmc.5
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jzi1BYYu9awAIW6aZOMZ/1HM2REFvsZon36S9G/bI/E=;
        b=JQJmgKa8huZypkEIUFBH7nlLHDzEECPbZb4EAs0iZY+5du8DRO2xikGeoxGBH9UIJi
         LLmeoKfqxYeS1lmPMaoLMtwDsjJuF2YnLX/Wy5RS45e1K2qTiz206l9jjE+k7OlNOHzC
         wcE9EoYyBCLZ9plRAgDxNrCL7wGWIR2jyVTdpXP1NPOPrDnW7GYolBp6mVvpVCjHajiV
         4DijKC7e0P1Nv93pDyj7WY9AMAvo9N3aXPAcsQ9ejNeXNc+taZN8ED9IjnUc7T221IjE
         fdUsGiI3y9K1uz6S4nONq+KjgzX+/MUcLgMxaIf2frcE3W5B6i6fTNsK1T5H7d9x2pjT
         WCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jzi1BYYu9awAIW6aZOMZ/1HM2REFvsZon36S9G/bI/E=;
        b=FjwaUgdksytHpbWVkK/0vktY1FykaUPvvMbZjJIJuMmZ7j6qdBk0/lOSRnkhxgO2Jp
         R5o6nUI5Up0vzWdWCvCEndtQaU0QN9RmhXJtUz3cs/DtV6QYaY7ikL9dbEmRlKjIPvJz
         5D6kIzrxzVaU6cm0vkKI8IfKatG08b3XtSJYW6QxD9MItJDmT5FhR/2elZdAH1oGTynd
         TVAHZOCiwayW/gcfG42uTEBW8+TxNWzbxZjKFp0I+dfFUmZLUAeFKdoivHZ8jvE/+CqN
         pjtdvqODIOsHxF68DVu1uDKJZ5vIPIpzzuP5/R0/e7I1b46RtdS5qCVh6+KE+h+MvBrA
         io6g==
X-Gm-Message-State: AOUpUlHGbyk9xMdZhWySQvGWLQleAkrX7MvzpNhnYcOJhtMzDvN/wLt7
        +qwQJTw85KT1ANqcxQ196QCIxfNt
X-Google-Smtp-Source: AAOMgpe4oDQvOmtZqLni82M7ofLWcN8FsBFj2g04OpJhEsmjgfI/5AsWcXsro9Do0t8Ch738Ou6P0w==
X-Received: by 2002:a1c:8291:: with SMTP id e139-v6mr2621332wmd.39.1532450051255;
        Tue, 24 Jul 2018 09:34:11 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.googlemail.com with ESMTPSA id x124-v6sm1899091wmg.38.2018.07.24.09.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:34:10 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 01/20] sequencer: make two functions and an enum from sequencer.c public
Date:   Tue, 24 Jul 2018 18:32:02 +0200
Message-Id: <20180724163221.15201-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes rebase_path_todo(), get_missing_commit_check_level() and the
enum check_level accessible outside sequencer.c, renames check_level to
missing_commit_check_level, and prefixes its value names by
MISSING_COMMIT_ to avoid namespace pollution.

This function and this enum will eventually be moved to
rebase-interactive.c and become static again, so no special attention
was given to the naming.

This will be needed for the rewrite of append_todo_help() from shell to
C, as it will be in a new library source file, rebase-interactive.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No code changes since v3.

 sequencer.c | 22 +++++++++-------------
 sequencer.h |  8 ++++++++
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 03c47405fb..0fc03dfe48 100644
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
@@ -4245,24 +4245,20 @@ int transform_todos(unsigned flags)
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
@@ -4274,7 +4270,7 @@ define_commit_slab(commit_seen, unsigned char);
  */
 int check_todo_list(void)
 {
-	enum check_level check_level = get_missing_commit_check_level();
+	enum missing_commit_check_level check_level = get_missing_commit_check_level();
 	struct strbuf todo_file = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf missing = STRBUF_INIT;
@@ -4291,7 +4287,7 @@ int check_todo_list(void)
 	advise_to_edit_todo = res =
 		parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
-	if (res || check_level == CHECK_IGNORE)
+	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
 
 	/* Mark the commits in git-rebase-todo as seen */
@@ -4326,7 +4322,7 @@ int check_todo_list(void)
 	if (!missing.len)
 		goto leave_check;
 
-	if (check_level == CHECK_ERROR)
+	if (check_level == MISSING_COMMIT_CHECK_ERROR)
 		advise_to_edit_todo = res = 1;
 
 	fprintf(stderr,
diff --git a/sequencer.h b/sequencer.h
index c5787c6b56..ffab798f1e 100644
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

