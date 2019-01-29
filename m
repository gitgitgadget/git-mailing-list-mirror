Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A261F1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfA2PDT (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:03:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54581 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbfA2PDR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so18211278wmh.4
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQuBbgxTdhepmfIatQ3mgqhjkKwSXtfG4dYMHMULmQI=;
        b=dFqfEVaZTnaKVmXLmbk+MbyvO7IERKYCzq6+DnOltkS2SfMTLt2RD5CNn1LBHsR6iz
         jqbkM4bPng4dj0MhsPq84zX0SGCvvzZoLNqdDH0cX3pHm1GmGc3Ag3JlG9H6QavuMXwY
         OQSv2PPPOwUwBhN9r6yM3lxRo+qIYPq19C777HtgecDwhS5wSpB4P/rQcCi+ddQVl/Dh
         61Pldtv8uWUcOrEZ0g4iQpkQQLlbxY9OV8Tf+9fb65HmAw4sosOfuoS2bhIOKFKhP3Fh
         b1PDAXghIjtyA+X2FfN9T0sEUUUxN6UXhYaBV1mhSbin3WSqdrvJq92+2laP/Ewz4aPy
         Yxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQuBbgxTdhepmfIatQ3mgqhjkKwSXtfG4dYMHMULmQI=;
        b=JYr2orEiDNtq9Q7CY2n+0BCARhinMyhwjje935nDRzBIfmIXsew3rJ3ZNx/F9hGi4Z
         4aK4NMQapKui+eNN22uSxm6AGZjN3AxO+00AjNPMjLrjBxkCD2mn/kckXxVwyyCScMoY
         Qw7s19W/jUrf4V7WMsM/XC53qpTZhGAmP966l/T1aboO4Dbw3Q89pJlg8qQ/o3L9fZYw
         J5OJ+avP9vX5QY1Yb4iyZYvxEkhd3klFY2zTESU8RsLiUYq3jwC95bEb2YCJUsSzdRk4
         Xc9pZw8Q82LmwCTwCOEoI202cmyNL4yWAyGP1FV3xZmNcetRyrTdymJ9nU/j5E6soVla
         g9EA==
X-Gm-Message-State: AJcUukebv7636+nIq3k2OCyqFw6pa8igJEI7JlGOWpjDqKsINoYH0XHb
        plWyOGjIHPAWmSCNOScROCNkFajc
X-Google-Smtp-Source: ALg8bN6ulFV9NpytHVtWoIJNp68tz3omaElRBGQwCqQZCahoJKyYt+e/Sw8ofM9EZaEh8kXmdfsKog==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr22265698wmz.150.1548774194799;
        Tue, 29 Jan 2019 07:03:14 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.googlemail.com with ESMTPSA id 129sm4420851wmd.18.2019.01.29.07.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:03:14 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 13/16] rebase-interactive: append_todo_help() changes
Date:   Tue, 29 Jan 2019 16:01:56 +0100
Message-Id: <20190129150159.10588-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150159.10588-1-alban.gruin@gmail.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
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
 rebase-interactive.c | 12 +++++++++++-
 rebase-interactive.h |  3 ++-
 sequencer.c          | 17 ++++-------------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index d396ecc599..807f8370db 100644
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
index 187b5032d6..0e5925e3aa 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -5,7 +5,8 @@ struct strbuf;
 struct repository;
 struct todo_list;
 
-void append_todo_help(unsigned edit_todo, unsigned keep_empty,
+void append_todo_help(unsigned keep_empty, int command_count,
+		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
 int edit_todo_list(struct repository *r, unsigned flags);
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
diff --git a/sequencer.c b/sequencer.c
index d8d045067c..92de982bc4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4580,22 +4580,13 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
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

