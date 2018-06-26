Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51751F597
	for <e@80x24.org>; Tue, 26 Jun 2018 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeFZQXP (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 12:23:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45282 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeFZQXK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 12:23:10 -0400
Received: by mail-wr0-f194.google.com with SMTP id u7-v6so2599216wrn.12
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JjMI19F+nXFKfEEYMqaKhra71EJud+nHOT1vHZZg01k=;
        b=tnc9cHmh3ajIoJI1ERtkKW7nfyh2GhdRAA0tJQjag4nca61QA195bO5kLpD6Y8DF99
         I0/UFEcUIBbg9HcjoRw9pk+CVJSGmE9vtwZzvpvE2qnzWSCg/jmyICMAPwOUnn6VClBK
         KnQy7gW5EVZQtt1NJXJ7JFXNzwa/IQogJuT6hg7tVZdIlsDhEn7W41ecomPs9PHJgKPG
         hHijvVyPYcPhAbXjcszvVgYlvMWtGM1VjlIhB37hmYZViP2N+Tum9/r3O1BwZSoapx4A
         HCVZyG/31Jw2FxB/UanEa+mkVjlbXL8ycARNcmGlBc6EAABUStlC5xpVcHiSBpen+CGZ
         GzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JjMI19F+nXFKfEEYMqaKhra71EJud+nHOT1vHZZg01k=;
        b=p6/uvABpuq8edUFmiTxxWa+T9ik8s4jWZtvTnEaq/SNVxtmIYEudlT4Y6AA5St8mJl
         7GiUYk8+oWvq0ZP3SOilt2I5/7g/IdZb1Y0fIouvxR9Dflj0CDUe54XE6s5BsZOwtOVH
         N2oVMPSa/UVuzljchboloSLhhaOHPCXPwTWdV/tvbli515HZ7bvYCwcnv9B3ZHu1jryT
         4k9l0ZmYJMocUFKtjmP03JGaFNRSZyx93MR7A2p8FM4x4QS109ixgpkGfsSsUNV4hLjY
         x8ib21NRgLGeTD+Top6I2WoK9cmPXuUXEXdVF+RECSrhCnQGZ25WYvIWFSa/a+eVmHne
         rliQ==
X-Gm-Message-State: APt69E009ZtzRaxxJZk8/Imjfv9NvH5mZZnAXVpC0MyLUrxTPiQ53ZQe
        i7AvDz+NyjglPzIqEWfRPGj9Ex9i
X-Google-Smtp-Source: AAOMgpfi1/ZiaUrVQEAhnYS+1n+/03nweThkQnSH0hGoA7Dx/QCvnu6GvMJU209KWRYnhUP3+zz9ZQ==
X-Received: by 2002:adf:ee43:: with SMTP id w3-v6mr2165156wro.63.1530030188495;
        Tue, 26 Jun 2018 09:23:08 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id n17-v6sm3545723wmd.14.2018.06.26.09.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 09:23:07 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 1/2] editor: add a function to launch the sequence editor
Date:   Tue, 26 Jun 2018 18:21:42 +0200
Message-Id: <20180626162143.31608-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626162143.31608-1-alban.gruin@gmail.com>
References: <20180613152211.12580-1-alban.gruin@gmail.com>
 <20180626162143.31608-1-alban.gruin@gmail.com>
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
index 8b447652a..d70ae49ca 100644
--- a/cache.h
+++ b/cache.h
@@ -1409,6 +1409,7 @@ extern const char *fmt_name(const char *name, const char *email);
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

