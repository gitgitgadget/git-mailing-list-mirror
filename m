Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239B31F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeI1EVE (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:21:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36539 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeI1EVD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:21:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10-v6so4244394wrp.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zXz4AEBEPtVdwzEhfTSoxEPq1n0yzD1px59omZ1kfFE=;
        b=WF0E5fkDr65f+htYzE10MXzqrRQDJI8it7+fyAwHKhVUn2kRsxY/Oba+dIYgUq6gJ+
         2f2JTzueX5bmLGKrM5r/rhbzWpjdl2/5615ujDWswl/FJGAjvuni4JryUbFgpmJxY/RA
         +Ma5mxWAGbQcNyxu6osiUiO6h6Q2GxRTYoAMYnX1xPWX9xDBv16WJISx55vksyIt6Wuu
         rZ50IkzUuyu8ew+mRwh3M/7pJEctwt36NVTgmLESDXUxZol06MPB2JfBElxY04spfZfw
         LZLHaqdvLzjHlRo8WO5AFxYb+t7w2K5dSZ6p4CtLTJzYeARCcMLUb6LQ9yZAIG/yLEk/
         Q95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXz4AEBEPtVdwzEhfTSoxEPq1n0yzD1px59omZ1kfFE=;
        b=Z9MZ7pDRYL4+rE9o5O9eho+j60lG4G9XFZ7gEVd+9kKU+C15mfluVB3h8JCq8El40p
         RVfiHoybY8RcGDcCLY+ay6D3zphL+cQEGaRwR7b6k86gPanGm1jotKi0oPQirBzaEaBb
         EUZ++CWlTn26HHZzD6t698YGKZGD+6mVFMrYVaIIU5HxOH+FmQot5k9+ZoySAfg3LxhP
         ThFikG/KzH7WUyvd9eaDIs59MvWI9btiwO5Eh8Zm01LorcUWlnf/HDuqxVrLQ/gcoGyw
         7aKhffwV0gJfoH7jLmqCRZZfVcZ7ATpFzKt7Ht6ZCgndrvKud3HrveYVmHQfHiajcTcd
         L6NQ==
X-Gm-Message-State: ABuFfoigugsDXrLWWdXu/Ot88EBOQxaCRt26lwpWIudLX7eTvIc4V44F
        5rHYJm3awQJ4k5EXt6fjw572OxS3
X-Google-Smtp-Source: ACcGV63bx28HdEGFFLk/ZvJvW7QrldLFS6XL4zf4aqtDGQiaM6rlMUKBphZHNExKhuu9gqFvWLBn0A==
X-Received: by 2002:adf:e607:: with SMTP id p7-v6mr2547910wrm.254.1538085637144;
        Thu, 27 Sep 2018 15:00:37 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:36 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 08/20] sequencer: refactor append_todo_help() to write its message to a buffer
Date:   Thu, 27 Sep 2018 23:55:58 +0200
Message-Id: <20180927215610.32210-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927215610.32210-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
 <20180927215610.32210-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors append_todo_help() to write its message to a buffer
instead of the todo-list.  This is needed for the rewrite of
complete_action(), which will come after the next commit.

As rebase--helper still needs the file manipulation part of
append_todo_help(), it is extracted to a temporary function,
append_todo_help_to_file().  This function will go away after the
rewrite of complete_action().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 builtin/rebase--helper.c |  2 +-
 rebase-interactive.c     | 43 ++++++++++++++++++++++++++++------------
 rebase-interactive.h     |  4 +++-
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 7d9426d23c..313092c465 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -97,7 +97,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	if (command == ADD_EXEC && argc == 2)
 		return !!sequencer_add_exec_commands(argv[1]);
 	if (command == APPEND_TODO_HELP && argc == 1)
-		return !!append_todo_help(0, keep_empty);
+		return !!append_todo_help_to_file(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
 	if (command == PREPARE_BRANCH && argc == 2)
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 3f9468fc69..4a9a10eff4 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -4,11 +4,9 @@
 #include "sequencer.h"
 #include "strbuf.h"
 
-int append_todo_help(unsigned edit_todo, unsigned keep_empty)
+void append_todo_help(unsigned edit_todo, unsigned keep_empty,
+		      struct strbuf *buf)
 {
-	struct strbuf buf = STRBUF_INIT;
-	FILE *todo;
-	int ret;
 	const char *msg = _("\nCommands:\n"
 "p, pick <commit> = use commit\n"
 "r, reword <commit> = use commit, but edit the commit message\n"
@@ -26,11 +24,7 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 
-	todo = fopen_or_warn(rebase_path_todo(), "a");
-	if (!todo)
-		return 1;
-
-	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
 	if (get_missing_commit_check_level() == MISSING_COMMIT_CHECK_ERROR)
 		msg = _("\nDo not remove any line. Use 'drop' "
@@ -39,7 +33,7 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 		msg = _("\nIf you remove a line here "
 			 "THAT COMMIT WILL BE LOST.\n");
 
-	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
 	if (edit_todo)
 		msg = _("\nYou are editing the todo file "
@@ -50,12 +44,25 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 		msg = _("\nHowever, if you remove everything, "
 			"the rebase will be aborted.\n\n");
 
-	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
 	if (!keep_empty) {
 		msg = _("Note that empty commits are commented out");
-		strbuf_add_commented_lines(&buf, msg, strlen(msg));
+		strbuf_add_commented_lines(buf, msg, strlen(msg));
 	}
+}
+
+int append_todo_help_to_file(unsigned edit_todo, unsigned keep_empty)
+{
+	struct strbuf buf = STRBUF_INIT;
+	FILE *todo;
+	int ret;
+
+	todo = fopen_or_warn(rebase_path_todo(), "a");
+	if (!todo)
+		return -1;
+
+	append_todo_help(edit_todo, keep_empty, &buf);
 
 	ret = fputs(buf.buf, todo);
 	if (ret < 0)
@@ -84,7 +91,17 @@ int edit_todo_list(unsigned flags)
 	strbuf_release(&buf);
 
 	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
-	append_todo_help(1, 0);
+
+	if (strbuf_read_file(&buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	append_todo_help(1, 0, &buf);
+	if (write_message(buf.buf, buf.len, todo_file, 0)) {
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_release(&buf);
 
 	if (launch_sequence_editor(todo_file, NULL, NULL))
 		return -1;
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 155219e742..d33f3176b7 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -1,7 +1,9 @@
 #ifndef REBASE_INTERACTIVE_H
 #define REBASE_INTERACTIVE_H
 
-int append_todo_help(unsigned edit_todo, unsigned keep_empty);
+void append_todo_help(unsigned edit_todo, unsigned keep_empty,
+		      struct strbuf *buf);
+int append_todo_help_to_file(unsigned edit_todo, unsigned keep_empty);
 int edit_todo_list(unsigned flags);
 
 #endif
-- 
2.19.0

