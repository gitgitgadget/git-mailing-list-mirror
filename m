Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F2E1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeKIRsL (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33556 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeKIRsL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so899546wrr.0
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRaVCyo1Dkh19GqCzC3J80d5A7eXnemW9OeJp3cmHg8=;
        b=Qv3sqc+U0LWzcFXjsxUWSjOs/lm+8fQ67JNCkn2il88Emw3aAypzkAJ556sZtkDNae
         mxfoaKGx5TziOTOxl6uCxG6Cqx4zb6wpHrBuLW2UMlGsCmiFvkRUWEFluaXqKBGecYjz
         AC92ubmcv/X6D681EQh5bBuKDM4Gy27Yb2VrWaFOIERxYSoBem+hCqB0fkvpr8sWtovv
         9E6iDW0CGcn1d9JQ/380cj4RcOZBDlsz83B97fR7M6MCW4Hb/dqfPlmyyVGbf2XCh7Ij
         lF/0dF323s54bBBHTWsjjRPUQH3MGtWD0Djyk5tK4umJYniDhTVr5tPyQqnx8+vF31Qd
         f3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRaVCyo1Dkh19GqCzC3J80d5A7eXnemW9OeJp3cmHg8=;
        b=dEYMPvmSNEyvPZTwX0lQ1Qxbp9HMpzJZfAdSftkdo7skghR5pFmS62QN3cWy/8wcu8
         eR7iFiXZw3LvZau7/YcScHCxzn4xWFA2f4BovmyIYEkMPLInc3BRDX72FaUyf3PHoAdV
         shxZv7pOSpj8sXO5V+4iVf5sCuKqJU9PI/nyMnv1VysGXyw/5d5JurN7cGrRVXETij5X
         SU4E/I+LuE81ST5RyQ+HJA+/R4gFa4horpp+JL/CvYcp6C80N7tIrDrdL0tDD2ilxxi7
         1rRgDVqfQUz/28BVStzwbLwyq/L5gHlP7x+I3tRv8Qbtub9D9hAHuE2XVRYm+lCnnnIL
         AeQg==
X-Gm-Message-State: AGRZ1gJVy9SPBiz0LxAVnHCli7Fqvc499Na6FnXlOPLZrkSkOkK0DtMG
        MsPVdGE1cg9whxB6QxyS8BaIiyuv
X-Google-Smtp-Source: AJdET5c6mj2dRPTsRZb9yECMQ4sIVxNca1M2rPIG78dTnPUPs77BzmxrLAI6TTRfdvXFDZq+bKzbIg==
X-Received: by 2002:adf:e3c2:: with SMTP id k2-v6mr7477543wrm.156.1541750924553;
        Fri, 09 Nov 2018 00:08:44 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:44 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 12/16] rebase-interactive: append_todo_help() changes
Date:   Fri,  9 Nov 2018 09:08:01 +0100
Message-Id: <20181109080805.6350-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
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
 sequencer.c          | 17 ++++-------------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 23569cfa3c..3b7b5e3382 100644
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
index 1c405763c3..cf6f69c93e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4529,22 +4529,13 @@ int todo_list_write_to_file(struct todo_list *todo_list, const char *file,
 			    const char *shortrevisions, const char *shortonto,
 			    int num, unsigned flags)
 {
-	int edit_todo = !(shortrevisions && shortonto), res;
+	int res;
 	struct strbuf buf = STRBUF_INIT;
 
 	todo_list_to_strbuf(todo_list, &buf, num, flags);
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
2.19.1.872.ga867da739e

