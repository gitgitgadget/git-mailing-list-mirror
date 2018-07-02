Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5344D1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 10:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753673AbeGBK6P (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 06:58:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50262 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934036AbeGBK6G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 06:58:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so7582424wmc.0
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cPOF8pqILzJemW3Fn7kMoQoxtsQpE56H3rLcZ/JC5p0=;
        b=rK1DIQyWYLlESzoJdZKPF3iJY7UAfSf1HKaZkHBDNNCh6B78BzZKmoYZMSaXxkTT86
         nrFwIclBx5nrGaD6Hb28AGlonU9RyAI2rgF8jPtGuuMXNZcLvdjVbUbsubvg0l1UFJE8
         yVqjafo2JTVrLoofLSiVyJjA54ntyRikYJItWmLASyQ/mx6bJ6bxzSMRIdLgvLi1x4l9
         1FwUWkQIGku5A+oEwbp3PVu8FDV+pbVAsvXWJHiVTBBlK7jbZAh4EAOlILFtmY+xq48i
         3DZIq5kNVbGTEDF1sRBlbwq5F2IdX0HA24kb2vAQPDj/dcjBa2sOax9HLbMD5+mPj6jA
         LVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cPOF8pqILzJemW3Fn7kMoQoxtsQpE56H3rLcZ/JC5p0=;
        b=pGUSxYIFr1TgptAzJCenGuySJOtAz4b0eACrEa/pwvJsIOpJ2krtikCelVyN76hMcc
         uiSF4aV9/DxoyclRepAgxL43J0csL2QamZQipCQZp6uTLSzHsqaRBIFDeRJBcyx49XSr
         wEovfqr89nCa8ir2Xb9G4uemZnb7O8W99dg/GTA1WqhF9sfSEiuIhUb3V0CJv8+zTQIs
         1ha9m+EqU3EN6qQpTNB5TGB1gwJs8AEawsyG2SlCARo+Yl+8iZiCWbtyPiLn0bXYAQIa
         AXwpPuHeg9aWHk87sctHss8pdZ7WphD0A+FusEdtni8QpsNp9bBZ8sLNdA10myCGJlXN
         Y7Tg==
X-Gm-Message-State: APt69E2uYUrOEcdx8ukAex4lBe83c/hc2X3Fm8wPJ637Udm92fJwZkST
        qqEUjP2Hjq3Y2RMPT+K7DQvvMtlZ
X-Google-Smtp-Source: AAOMgpdNHiYlc7+3Cvx2P6ijluzQXQ5XpiV/2Led/cMk9zvXvvxk70eY+g6Fp8Lf9cgDaedKzv9yvA==
X-Received: by 2002:a1c:4083:: with SMTP id n125-v6mr7473934wma.32.1530529084217;
        Mon, 02 Jul 2018 03:58:04 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.googlemail.com with ESMTPSA id m64-v6sm7462437wmb.38.2018.07.02.03.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 03:58:03 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 3/7] editor: add a function to launch the sequence editor
Date:   Mon,  2 Jul 2018 12:57:13 +0200
Message-Id: <20180702105717.26386-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702105717.26386-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the rewrite of interactive rebase, the sequencer will need to
open the sequence editor to allow the user to edit the todo list.
Instead of duplicating the existing launch_editor() function, this
refactors it to a new function, launch_specified_editor(), which takes
the editor as a parameter, in addition to the path, the buffer and the
environment variables.  launch_sequence_editor() is then added to launch
the sequence editor.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 cache.h  |  1 +
 editor.c | 27 +++++++++++++++++++++++++--
 strbuf.h |  2 ++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index d49092d94..33fa70f55 100644
--- a/cache.h
+++ b/cache.h
@@ -1472,6 +1472,7 @@ extern const char *fmt_name(const char *name, const char *email);
 extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
+extern const char *git_sequence_editor(void);
 extern const char *git_pager(int stdout_is_tty);
 extern int is_terminal_dumb(void);
 extern int git_ident_config(const char *, const char *, void *);
diff --git a/editor.c b/editor.c
index 9a9b4e12d..c985eee1f 100644
--- a/editor.c
+++ b/editor.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "strbuf.h"
 #include "run-command.h"
 #include "sigchain.h"
@@ -34,10 +35,21 @@ const char *git_editor(void)
 	return editor;
 }
 
-int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+const char *git_sequence_editor(void)
 {
-	const char *editor = git_editor();
+	const char *editor = getenv("GIT_SEQUENCE_EDITOR");
+
+	if (!editor)
+		git_config_get_string_const("sequence.editor", &editor);
+	if (!editor)
+		editor = git_editor();
 
+	return editor;
+}
+
+static int launch_specified_editor(const char *editor, const char *path,
+				   struct strbuf *buffer, const char *const *env)
+{
 	if (!editor)
 		return error("Terminal is dumb, but EDITOR unset");
 
@@ -95,3 +107,14 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		return error_errno("could not read file '%s'", path);
 	return 0;
 }
+
+int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+{
+	return launch_specified_editor(git_editor(), path, buffer, env);
+}
+
+int launch_sequence_editor(const char *path, struct strbuf *buffer,
+			   const char *const *env)
+{
+	return launch_specified_editor(git_sequence_editor(), path, buffer, env);
+}
diff --git a/strbuf.h b/strbuf.h
index 60a35aef1..66da9822f 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -575,6 +575,8 @@ extern void strbuf_add_unique_abbrev(struct strbuf *sb,
  * file's contents are not read into the buffer upon completion.
  */
 extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
+extern int launch_sequence_editor(const char *path, struct strbuf *buffer,
+				  const char *const *env);
 
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
-- 
2.18.0

