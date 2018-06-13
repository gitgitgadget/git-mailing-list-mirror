Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EEC91F403
	for <e@80x24.org>; Wed, 13 Jun 2018 15:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935990AbeFMPXX (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 11:23:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38260 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935984AbeFMPXW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 11:23:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so6180475wmf.3
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g8HqoWwJKP5tXo4wtK/6pnBS/rNLL3RPUzwEsZXVypg=;
        b=j3l4SLx1VhH+PWBgxXiZEAUgd7zsrdDEHa9Iead/g6zoViPe/nGT/0UdU/jdMvXstf
         F0HbpfDeOWhTxWEg+B8XxdOCuYvM1FSE2T3Ede1Qfr5reIrDPADTlMq5OQWIGjGzO28F
         2HhrHKMhAV/a97K5Ge2Eyyl4fryxkSpEW/i0fTKnpTePBJzRK9mP1msWmqe7DgD3jCEy
         ry2U5YgPWcK0WbM2edE1zFTY4/7DfRcw826yWUTUBy+yOJL414XCl4HEEx0rO5Hhe5DH
         Ly0eUJulTI9EIYAqCBt+VcFHrg8NfdGnJq6wdOAvqzNWMG6WBnxWJHn8d+Glus/tDDdC
         LWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g8HqoWwJKP5tXo4wtK/6pnBS/rNLL3RPUzwEsZXVypg=;
        b=gzv2UCzHMq4fv8V/KIhh5fJnyUXYHCnsN1oUdQUmanG1panqxvDu6xiv2pwzEGccfz
         gQf+cFm7ebVl09sLy3TMLOMY3jcqFO3EO6fFO/DHQqnJJhm/TFngNqL/doXfKrVnOlGH
         898xo+cDz9LPaKBudQ504J4PqDw2qSqmO9s3vfNeIxQs7jcEXZPQo2IS7Ru+SFiubqfR
         d9gT8sQbN5qBbAEiPYE4NM0SyaguBSnAfzomct+B4gGp23+olcaK9ZOFvbWOM08whPhm
         IcVBkTddBVfcGG9LxU/VvCxZ32oZToGQrrBhfzxgpw+fMe7RH9wsP8NJr6yMSqKC9VZL
         Tarw==
X-Gm-Message-State: APt69E0rT2vXpBxcLeRtdEE3ZKHKxqG7dVhOMohDpBNxSzvPawSjld4u
        3yk/Hn1kVKod8d+RK0/eRwu+pwxC
X-Google-Smtp-Source: ADUXVKJOwmyN9AAeqXrgjmcSFINjDi+H5Sz+4+3a3GksDcGU4STEBD7qWTMdFxwXW54k9AGk+uPQ5g==
X-Received: by 2002:a1c:b60a:: with SMTP id g10-v6mr3586948wmf.18.1528903400169;
        Wed, 13 Jun 2018 08:23:20 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.googlemail.com with ESMTPSA id f2-v6sm4526388wre.16.2018.06.13.08.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:23:19 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 1/2] editor: add a function to launch the sequence editor
Date:   Wed, 13 Jun 2018 17:22:10 +0200
Message-Id: <20180613152211.12580-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180613152211.12580-1-alban.gruin@gmail.com>
References: <20180611135714.29378-1-alban.gruin@gmail.com>
 <20180613152211.12580-1-alban.gruin@gmail.com>
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
index 89a107a7f..c124849a1 100644
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
2.16.4

