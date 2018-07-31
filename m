Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B0C1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbeGaTlw (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:41:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44613 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbeGaTlv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:41:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so17571221wrt.11
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dAw/QqL/ENHChcbWomkKWNENDACDRwtGjXUGn73bu4A=;
        b=jHV2rdgS0q6V1A7hZfxNEW6SehRHUMivEXGv2jXq4h+fIdKmw5GPr18A5GmFdRkI+h
         VqpjukiooQrpK/LTZodi9Q/9x9nP7/Yd3V11NDsiPdVGZw45tx6r1zxEXASJuxdGt+jA
         POOYbKxjHdLteOa116f6mgpnApJfIdt8t2aNWXZJ2fn+x81sRcewEQqYvvrHDgxmWdYF
         axPObU/l+kzSIdtO6SePnQca53w/3V0u/ZN8I2LgURTwYuOp13ivkeZKNW35lJ0F/vsK
         Gz56JWPUmmHZnCQ2wBT9ZL6akg9agm6Bdtf5UYg59KDD/aWC1xbwj6Oa+kyaYgXcbjWK
         npzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dAw/QqL/ENHChcbWomkKWNENDACDRwtGjXUGn73bu4A=;
        b=G7r01lvMUyOSr4kA99s69SOoJJhXAJufuswWtXX6Zkm9uO5y7X0j8TKq/9626ryngY
         V4Fpymz3V0aSJE7VYy4VWZU6PPehlaEDipRMtNkDzgN3OppbS85pphks3g94rOOv9aiG
         GKRI7jePPAwRTqA1kzpA2/8TzOmkkndJM5cO53bu4CxeUYC53yua0F7fhTvYuxfWFaGj
         ePc1LpKqGxD/mnfPLjJFSiuUPilWb4IsaCE0ZiXslIiM89i9MtZdasRqmpozWTPNqTCr
         9U/WqLWto1xez/0i3QXDvK/XX2bOYSuJ8TDflA2JgZyk+WBw7kGL6s5eAI0lmLVrXDdC
         MJSA==
X-Gm-Message-State: AOUpUlFJpsyJsGzDxFoad1VBjIpffJ+3tWGiUNbl3dOGEApxHhAm5Eal
        8dTM46ich0iX/UzE74+DU4GQq/sA
X-Google-Smtp-Source: AAOMgpdJPSKpL/ikUAczB8Wij7MXMfIio5/5cSbKb5Cmbcm6uT+3f13dJ/xIqcPaiMixYsGuzt7+2A==
X-Received: by 2002:a5d:44c6:: with SMTP id z6-v6mr21633675wrr.236.1533060022968;
        Tue, 31 Jul 2018 11:00:22 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:21 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 03/20] editor: add a function to launch the sequence editor
Date:   Tue, 31 Jul 2018 19:59:46 +0200
Message-Id: <20180731180003.5421-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
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
No changes since v4.

 cache.h  |  1 +
 editor.c | 27 +++++++++++++++++++++++++--
 strbuf.h |  2 ++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 8b447652a7..d70ae49ca2 100644
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
index 9a9b4e12d1..c985eee1f9 100644
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
index 60a35aef16..66da9822fd 100644
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

