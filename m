Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239C51F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933222AbeGJMRW (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:17:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40162 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933176AbeGJMRR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so14374218wrn.7
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cPOF8pqILzJemW3Fn7kMoQoxtsQpE56H3rLcZ/JC5p0=;
        b=nWqKOvT6NvY41FV9AZ6x4yL1a9poSCR3VowPK3HTlXMRcxfQt1coyCFUrra80xVlP6
         a8lfbn/pm/Me8S/tz59AfDITMYF8IHFldi+o8WVtgWcAu29ewip5Wj6huZgHjfoYHZRJ
         8E2On63BYmMQsXGtl8iMJf8ZIwO6ugLO4IL4c7WTYFq6EmP5/jc/xYb5ZaqAD2vjJjtC
         VRD5J9P6u9MyzfXyhL9NrKd5qPMkhUIK3zBuo4oYnNiA+MBG87Jz6qe1swHcy5yxL4SJ
         NoQMXCks30IwfL+W5T64P4KsyaszoB1erhtSM8QR1GmfeUi2cRnrLC9RQc9LZom8VjoO
         fVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cPOF8pqILzJemW3Fn7kMoQoxtsQpE56H3rLcZ/JC5p0=;
        b=H7zV1DqfpwWZT/QtjIlEJmXjR/ig/QcNQJc2a10dHEhKbHZHQCdROAa3xX4h4lOQuk
         9lSiAkUl07cduCpn28Kz07Lfap99DajsjWYCe/KbLgMIancWYV2Dg3swIJTSqpw+GlTn
         GX+l7XESIDrKj3yopF43osP3C9K7eubR4EsXiLX7lrKt34chBxWLAHun+upd/GkofUvq
         MFZN3d63RzDPw4DT6e9hH+l0Pr+ZFJPJUlZpTDfAEbYlW5KVwzIOK4j4YvPVXbMbkT5v
         +LyiN13O5skjFxwswkVfgHfVcBuzcfZ70iAPCVVHbm6yOvyw9/2IhBpEstijPQJvEOT4
         1Dfg==
X-Gm-Message-State: AOUpUlE//t/THue5cXWrP1ZwBdaWPy4m50mWiG7MSvlErPz0lo1y75UO
        x5amLi2ScW2qncEHNZGB4fpPKCad
X-Google-Smtp-Source: AAOMgpfwgnodLilY6Hjc3dLhnP9+nR1IGYQnXLLAuk9BHkU+kryseOflY39K8nDrifnLTZ50vqUvIg==
X-Received: by 2002:adf:b842:: with SMTP id u2-v6mr6924880wrf.162.1531225036340;
        Tue, 10 Jul 2018 05:17:16 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm28244334wre.95.2018.07.10.05.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:17:15 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 03/13] editor: add a function to launch the sequence editor
Date:   Tue, 10 Jul 2018 14:15:47 +0200
Message-Id: <20180710121557.6698-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710121557.6698-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
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

