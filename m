Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49EA11F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeJ1GM2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33927 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeJ1GM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so4671346wrt.1
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ze02cil/vNrIRx8iSri4WwyS2toGFJdwfz1K92pmNis=;
        b=vb1IAbxNxlpgzNKZiWZOhrzbs+A9Pojw7PcCU5d4Ha0ZZzcx090Rki4rR4ACAQlNig
         v5n75pZku4oyVUiuk7Szy6xI7HkTdLgyY+9FgZoDT/dzvs2nedgpiSw1Qw1snqymmjxM
         hUad7iWNLv9UqhAztq+sXHm6DC85JZRl3e0tYS6kcdD8S5ygkrip7OCESAK5RphTD6RR
         UyHFxEwirDjgj9dkPRNfLACoc5ZmTBvYTlwqQmxkEP0Aiwb2bPfd6xs/FWRul+hiZh4J
         5xhGqL7+3LBJu5Wm20WrdR8hyV+o5Viynkftke6JQt3fMg6L2536pAgfooNvBw8jRSYw
         vQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ze02cil/vNrIRx8iSri4WwyS2toGFJdwfz1K92pmNis=;
        b=a5SyOYPOQC3mT5AU2dBH0TEua7FafpAbFRVhjXrZPSNZP+KVIV19zDirK2xBo2D0qi
         4Lgs/nimwAWJmPMyZIgqj0rqO4oFOd6qJ4JCTMCepNwusREZDIyw4Yqkh2nkl9RfGuN5
         6Vbi9DxptMChyWEGcw3pT4q0wJYi+h0dbdOGeHD1tmZsVRHxI0rjwxciT6Ms6fsSlXpx
         BX4xH0X2yd7k0lYfGX2VnOEknLU4KIfWMpr0SpUQDbT8D0gtrsF+dZAekTq/lxQ/XZBz
         TewSeGM2tRbEJCyvJPxHubofbMzf8ks0SD4vAqJWp+NcbCkO88HhY4ldxGdqq0dURmSS
         qdxg==
X-Gm-Message-State: AGRZ1gJpO6SG3OEWTyTOatLzqmPeyZxKbE2I8lAqTWvWMU8l1HMfhfvQ
        zo2D8k3/J87rmX8ZBLII3hj2XEbc
X-Google-Smtp-Source: AJdET5cJ8Rtgl+eZsEmy2/9jtHU8bzrRH6aWleNu74OZZEPehhC4ys6EhZhishniQJpjWskxeummkA==
X-Received: by 2002:adf:b211:: with SMTP id u17-v6mr9244324wra.52.1540675807731;
        Sat, 27 Oct 2018 14:30:07 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:30:07 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 12/16] rebase-interactive: append_todo_help() changes
Date:   Sat, 27 Oct 2018 23:29:26 +0200
Message-Id: <20181027212930.9303-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the writing of the comment "Rebase $shortrevisions onto
$shortonto ($command_count commands)" from complete_action() to
append_todo_help().

shortrevisions, shortonto, and command_count are passed as parameters to
append_todo_help().

During the initial edit of the todo list, shortrevisions and shortonto
are not NULL.  Therefore, if shortrevisions or shortonto is NULL, then
edit_todo would be true, otherwise it would be false.  Thus, edit_todo
is removed from the parameters of append_todo_help().

edit_todo_list() and complete_action() are modified to fit these
changes.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 rebase-interactive.c | 12 +++++++++++-
 rebase-interactive.h |  3 ++-
 sequencer.c          | 16 ++++------------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index b2be99a900..0643d54b1b 100644
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
@@ -47,6 +48,15 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
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
index 6bc7bc315d..61858f3a02 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -1,7 +1,8 @@
 #ifndef REBASE_INTERACTIVE_H
 #define REBASE_INTERACTIVE_H
 
-void append_todo_help(unsigned edit_todo, unsigned keep_empty,
+void append_todo_help(unsigned keep_empty, int command_count,
+		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
 int edit_todo_list(unsigned flags);
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
diff --git a/sequencer.c b/sequencer.c
index 7286498572..4c664d6388 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4331,21 +4331,13 @@ int todo_list_write_to_file(struct todo_list *todo_list, const char *file,
 			    const char *shortrevisions, const char *shortonto,
 			    int command_count, int append_help, int num, unsigned flags)
 {
-	int edit_todo = !(shortrevisions && shortonto), res;
+	int res;
 	struct strbuf buf = STRBUF_INIT;
 
 	todo_list_to_strbuf(todo_list, &buf, num, flags);
-
-	if (append_help) {
-		if (!edit_todo) {
-			strbuf_addch(&buf, '\n');
-			strbuf_commented_addf(&buf, Q_("Rebase %s onto %s (%d command)",
-						       "Rebase %s onto %s (%d commands)",
-						       command_count),
-					      shortrevisions, shortonto, command_count);
-		}
-		append_todo_help(edit_todo, flags & TODO_LIST_KEEP_EMPTY, &buf);
-	}
+	if (append_help)
+		append_todo_help(flags & TODO_LIST_KEEP_EMPTY, command_count,
+				 shortrevisions, shortonto, &buf);
 
 	res = write_message(buf.buf, buf.len, file, 0);
 	strbuf_release(&buf);
-- 
2.19.1

