Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B8FC1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeHJTW7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:22:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36305 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeHJTW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:22:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so2568271wmc.1
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q1zbET0JXclKOUteu53UmZ7Lm1Lxq0mzvtOHkV7IFqk=;
        b=Y9efIPl8k5My0ije+wipwPefa7c/Pd8w6TtJNzyf5DUoyIJnLhC4nCVJGBKToBJm2f
         URSLJ+f7YABB5jyeKnh0x4Mha8TEwgdY3gsPSA8KUzeiKF8AeQrcFRBJKVmO+ea+slm9
         49C5hj+fS5pS0zkONy+VUGzHBj52pvgsynKdX2orx3Ofmie46ZXJWfpZH5IYtn501svW
         c3joxFSNFf7ZtPtTuha5/jIUfH1TEajU3AMS6M9N2eus9LtBmvivBzxCYtIoWCjKrKcx
         ASHxFHptL6o3m7FtiS3weMFlDfiMCe0w23lKCQvpUBnZtneQfpRJzixPLnQ4yPgrhi81
         YGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q1zbET0JXclKOUteu53UmZ7Lm1Lxq0mzvtOHkV7IFqk=;
        b=p0BHvb03rYq9JHjX084y/5KIqGkNzePi4TSVVTLgizL37ffOxTiLkHcSI4T3ypCmLM
         ZbjzfIPvWtTGynaT5BSg6WcEJcW5KRBhh3O9yfKgZTiQwdMY6YX+W+TsL6QXgJvk9mjU
         EoNrK01kkbUGxVL6FjKCfB8wSFe44J027afP4HB9NMtMohLNxof10vP7WnruP/R2QXhG
         6pbo1ZASvJMC7gP3F1sc+r9pzPPAdD1nOoAbUM2G5yIsS12HPIHY9RtcM7sFffBAaF+E
         5AreLMxlLpprpwVbNBmeu83jojXgBeIgmFcuf9CzJUhbbUN+xJncf4teL58EErvKpVkN
         Fe/w==
X-Gm-Message-State: AOUpUlFcrav7UnrQ+f3WhSYXL8xl1irvRSAziN8PPwcRArwWpS1JxVrt
        bkdUdRzkbZt30wOA7/l3U059nuE+
X-Google-Smtp-Source: AA+uWPx2RyYc6mhIK/wrzUpYlSqxid6TE3yqAfFRnhjep9obGElFh8bQ5tpocmT0Ic+AVzUgUlbbsQ==
X-Received: by 2002:a1c:55c8:: with SMTP id j191-v6mr2003167wmb.67.1533919938857;
        Fri, 10 Aug 2018 09:52:18 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:17 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 03/20] editor: add a function to launch the sequence editor
Date:   Fri, 10 Aug 2018 18:51:30 +0200
Message-Id: <20180810165147.4779-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
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
No changes since v5.

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

