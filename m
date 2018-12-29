Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47CC21F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeL2QFY (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42709 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeL2QFU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:20 -0500
Received: by mail-ed1-f68.google.com with SMTP id y20so19659213edw.9
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9qE9MNETwSuvQYKYOvyg93eNB2Mm83/Le2L2LrNlxo=;
        b=k80ljN1ft/WEcJXQm33WnvNLieN0yUGODwodfvZfzsc/3G12hztSbkHAvn/6LJiBS6
         o0/C+wKiNuetaZSHBSuOLUszQXBzTOyVXOp2Z5l1OlJvoaQ1bN3ARSKrTwgMGplItviN
         Sjx5iwViboQYBU/SyXi2sct0M/FI8CFYwB/nwPAnlNgg9Uzi0uKuf1DABnMzoxf8ooeI
         p9Deos3LsO6Yak9cWY2wl7UqzvIUK0IW7TWsd3GIuXhzsiqqL5YEnaNBx4zjSOvGS3+J
         ha2+VK0aU4u74g0DLuABvYlc9X4+LXNzKuqvtFjW6E5OnXEeQxuWX6YOOlAepxGrcmbJ
         wb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9qE9MNETwSuvQYKYOvyg93eNB2Mm83/Le2L2LrNlxo=;
        b=mjXG6IAhBn428pPvjzzxPtg4WgFYn0DZKaJvENcSwdy1hF4xic3AXrIXOm4J+BYXwF
         PbOo8XuFhzXKDFsue32UlgxUqqiPXCAAP13uVjwNLpmBcEycI1LtDOaqwTHREE5Cr+NK
         Gx2aA/tnUPJiroR4FYdwO0vXMfLBVaZ6Mxvnxfrlv52CZjiasNSBhbj0dRq4FTwGs5Z3
         DEEuOTE1Kn3+Yx5DEjAI00hGs/yzh9TRXwbiEcRMDHx+wPyVeoQDqaind/vV9b5AvZ6k
         5NeHU3ZGTSv1Z8YkMqWBpkxeHTjCNSLSrIDLZp1bV4xv423PwxB57fPF0KWgsViJMAYW
         ouzQ==
X-Gm-Message-State: AA+aEWblrYWMTZvcUZOS3HTm3yT6HYnY7WPjpWeyDQLdfSQm8akRGoi7
        aztQMBdF0tuS+/KsJMPuO7s+kKOU
X-Google-Smtp-Source: AFSGD/VR9C07Pgx6vh4WdC2Ur3vJzHuyYRXGy904VIkKe8zIsX/jSjzoNx+iEq3Q7E1guWlN8IH5NQ==
X-Received: by 2002:a50:9315:: with SMTP id m21mr25890874eda.58.1546099518004;
        Sat, 29 Dec 2018 08:05:18 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:05:17 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 13/16] rebase-interactive: append_todo_help() changes
Date:   Sat, 29 Dec 2018 17:04:10 +0100
Message-Id: <20181229160413.19333-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229160413.19333-1-alban.gruin@gmail.com>
References: <20181109080805.6350-1-alban.gruin@gmail.com>
 <20181229160413.19333-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the writing of the comment "Rebase $shortrevisions onto
$shortonto ($command_count commands)" from todo_list_write_to_file() to
append_todo_help().

shortrevisions, shortonto, and command_count are passed as parameters to
append_todo_help().

During the initial edit of the todo list, shortrevisions and shortonto
are not NULL.  Therefore, if shortrevisions or shortonto is NULL, then
edit_todo would be true, otherwise it would be false.  Thus, edit_todo
is removed from the parameters of append_todo_help().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Slight rewording of the message and changes due to conflicts with
nd/the-index.

 rebase-interactive.c | 12 +++++++++++-
 rebase-interactive.h |  3 ++-
 sequencer.c          | 17 ++++-------------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 994f0f9753..32f95002df 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -28,7 +28,8 @@ static enum missing_commit_check_level get_missing_commit_check_level(void)
 	return MISSING_COMMIT_CHECK_IGNORE;
 }
 
-void append_todo_help(unsigned edit_todo, unsigned keep_empty,
+void append_todo_help(unsigned keep_empty, int command_count,
+		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf)
 {
 	const char *msg = _("\nCommands:\n"
@@ -48,6 +49,15 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 ".       specified). Use -c <commit> to reword the commit message.\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
+	unsigned edit_todo = !(shortrevisions && shortonto);
+
+	if (!edit_todo) {
+		strbuf_addch(buf, '\n');
+		strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
+					      "Rebase %s onto %s (%d commands)",
+					      command_count),
+				      shortrevisions, shortonto, command_count);
+	}
 
 	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
diff --git a/rebase-interactive.h b/rebase-interactive.h
index dd0d717bc1..2f6675eabd 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -4,7 +4,8 @@
 struct strbuf;
 struct repository;
 
-void append_todo_help(unsigned edit_todo, unsigned keep_empty,
+void append_todo_help(unsigned keep_empty, int command_count,
+		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
 int edit_todo_list(struct repository *r, unsigned flags);
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
diff --git a/sequencer.c b/sequencer.c
index dfdba5cec0..dfc705291d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4574,22 +4574,13 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 			    const char *file, const char *shortrevisions,
 			    const char *shortonto, int num, unsigned flags)
 {
-	int edit_todo = !(shortrevisions && shortonto), res;
+	int res;
 	struct strbuf buf = STRBUF_INIT;
 
 	todo_list_to_strbuf(r, todo_list, &buf, num, flags);
-
-	if (flags & TODO_LIST_APPEND_TODO_HELP) {
-		int command_count = count_commands(todo_list);
-		if (!edit_todo) {
-			strbuf_addch(&buf, '\n');
-			strbuf_commented_addf(&buf, Q_("Rebase %s onto %s (%d command)",
-						       "Rebase %s onto %s (%d commands)",
-						       command_count),
-					      shortrevisions, shortonto, command_count);
-		}
-		append_todo_help(edit_todo, flags & TODO_LIST_KEEP_EMPTY, &buf);
-	}
+	if (flags & TODO_LIST_APPEND_TODO_HELP)
+		append_todo_help(flags & TODO_LIST_KEEP_EMPTY, count_commands(todo_list),
+				 shortrevisions, shortonto, &buf);
 
 	res = write_message(buf.buf, buf.len, file, 0);
 	strbuf_release(&buf);
-- 
2.20.1

