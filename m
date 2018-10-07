Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368531F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeJHDIp (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54967 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbeJHDIo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so6188181wma.4
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNHdhBEgEZG8en3WNInKU4noer8hF/Jn1jEms1FDHMI=;
        b=bU6GzuUcsv74bUmlwdwBn7RzPCmwgSkT/DbbkXync2JXXjt5skJpLCdFQ2uMnHGZp+
         eahdvEtefWXH14CUxaGESY7Gx+wLegerDWM3cEBvjhwI+SK+4jCi4WotU0Og7gKHvkWF
         /5of/nyumMq69213G/6uslnKUfnudRtAt/+3LNgGUWXlZAGFtlKEPndKQDVfBBTzm8AL
         MUGkAPuWJM9QA9Kini9oru89OPLrqd5SKDcvWWBu4oaJTCd1Ybe9v9Os/6/sED47V8HW
         w7O35KRpZJz5axHCocGOcz6zWC3JNc/1a6KmhxLWpw71CyPCDfSTypaIBg2C7d4t0ebY
         aJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNHdhBEgEZG8en3WNInKU4noer8hF/Jn1jEms1FDHMI=;
        b=YJaEcFX0B6zjBDpBIAACThlaqynFdYBn72mhdv4pcRyaqU+2mOpCxCKO9rwZ24Lj9I
         Tyk4+Bi9+NfESu5sthjvIANzF0CI47i1EhLtMutILipbNpHx1hSrb1vu9qNRNROWmATW
         LCdyWRTatv58+Z3gjH6q7AgZBm9gggz9zUV4MlyXJ1MxdzNmNgkTzeWdUVmFzINtZpgm
         uClWzCIH11/zt8p5l7GEkI+NAHuG3pOHB9TQrw6eb1Rjgi98Yj/tV2lZ+dwFdxp0UebY
         kHzIh7s7MbyW1DicXDwpr8FUvDGwT2LlIS3NFhvicvemTwOF//a6nZWe62I3H4tRZQ4o
         IULw==
X-Gm-Message-State: ABuFfohH29+aBZF+DHq7ZMB0lIkWb4HtErIK78MhpSB8HJU59UoDjpIq
        6ctpjp4Xcr946mc3cqVyNyaUmxEH
X-Google-Smtp-Source: ACcGV62MJ53ZgXzZ5rbr4WaTHdrXs7j5qibGWAY+/ai8xws7XXIwTa0i5yXvz8u8bEam2m+SO6G1dA==
X-Received: by 2002:a1c:1a52:: with SMTP id a79-v6mr9779536wma.119.1538942420380;
        Sun, 07 Oct 2018 13:00:20 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:19 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 11/15] rebase-interactive: append_todo_help() changes
Date:   Sun,  7 Oct 2018 21:54:14 +0200
Message-Id: <20181007195418.25752-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
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
 rebase-interactive.c | 14 ++++++++++++--
 rebase-interactive.h |  3 ++-
 sequencer.c          |  8 ++------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index f42d48e192..7168d56d17 100644
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
 
@@ -89,7 +99,7 @@ int edit_todo_list(unsigned flags)
 	if (!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list))
 		todo_list_transform(&todo_list, flags | TODO_LIST_SHORTEN_IDS);
 
-	append_todo_help(1, 0, &todo_list.buf);
+	append_todo_help(flags, 0, NULL, NULL, &todo_list.buf);
 
 	if (write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0)) {
 		todo_list_release(&todo_list);
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
index a432b64048..94d3058359 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4636,12 +4636,8 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 
 	todo_list_transform(todo_list, flags | TODO_LIST_SHORTEN_IDS);
 
-	strbuf_addch(buf, '\n');
-	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
-				      "Rebase %s onto %s (%d commands)",
-				      command_count),
-			      shortrevisions, shortonto, command_count);
-	append_todo_help(0, flags & TODO_LIST_KEEP_EMPTY, buf);
+	append_todo_help(flags & TODO_LIST_KEEP_EMPTY, command_count,
+			 shortrevisions, shortonto, buf);
 
 	if (write_message(buf->buf, buf->len, todo_file, 0))
 		return error_errno(_("could not write '%s'"), todo_file);
-- 
2.19.1

