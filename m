Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8048C1F436
	for <e@80x24.org>; Tue, 28 Aug 2018 12:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeH1QCa (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:02:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55449 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeH1QC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so1671770wmc.5
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fQPReEbj1yHX3Z7gw7kha0zDNEMRNkhs3kbDfgEf+ZM=;
        b=qDOY7m+xJ9yHKgVvM8fwPSSi7/FrmUxl3IqeqcOn3fxGK172/Hban+OMXE2ogo8i5t
         XirniD7X1ZySXh232Jtgu+7L30viXbdNNxeSviJxGA3bohcfDW4kRSVyta4qRFeuQJdW
         PIXb5p79rMxhrhTY9N6djXIxMFjpEv8zMhcbd4lrrLYF+BhrjFe8ZkOZumQG5wZFFHdV
         axL79Ga5d0qtGAk0SMew+Bq/tf7LRlJ2D7+n2beJXZVdjiiktw17nziaiUI1CO5aHMgI
         JSt/M+pzU2G7XoBmYrAbFJ8v50FUgLRfG4rUHtN3Sp+orzu5NSZkRz2hS8SJbRUWpxhe
         DxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fQPReEbj1yHX3Z7gw7kha0zDNEMRNkhs3kbDfgEf+ZM=;
        b=CFsSywtMtDbg/nk7VN0udvpqwZICWX1rs7PHDpCK3EBx4OVifo5uMl60lE8XKVHLkf
         3wcGe2YQ4N846PnZ9siRlmFTYn6TsGJu7q6DsE1PXcuT2iethc4J1falKpdsyl1m9F6Z
         GOTugBnW49n4RNby0aIErm1rX/eiigeCKfKCOOodCuVEQ1tozIHShqbl8Y9jfNu2dkGx
         r1CDFbxLf7A2l9STpn0VOXJH6lb5ryovzwBv1S1t61L01s8bzTAGFf6U+15FSn24ALyQ
         NZ/prpO+0BXO1H+wxk/qjqGtPlb83dRBen015DGTEWFD35mBW+rR2mjU3xfdFoIgzcKX
         Tu2A==
X-Gm-Message-State: APzg51BNpuKq3NWJ0dE6AYYcLRYfIhN3Yrg4j/su1pilwmIcVKVHJT3Z
        TkIamc+YUUiHq8oI1/Kbtxj5gzHy
X-Google-Smtp-Source: ANB0VdZYpspZ5i7oyTNPHFNo8siADqjIv9oM8wMRpDhO0wrskoErpOxC+NYIMfI61vW8rJ4NTSw2vA==
X-Received: by 2002:a1c:b404:: with SMTP id d4-v6mr1213362wmf.28.1535458265854;
        Tue, 28 Aug 2018 05:11:05 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1702790wmg.14.2018.08.28.05.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:11:04 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v7 03/20] editor: add a function to launch the sequence editor
Date:   Tue, 28 Aug 2018 14:10:28 +0200
Message-Id: <20180828121045.14933-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828121045.14933-1-alban.gruin@gmail.com>
References: <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180828121045.14933-1-alban.gruin@gmail.com>
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
No changes since v6.

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

