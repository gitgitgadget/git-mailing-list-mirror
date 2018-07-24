Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC531F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbeGXRld (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:41:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52450 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388533AbeGXRld (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:41:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so3159364wmh.2
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lZIeDJvkJuEUBviMXE7UwBsv47juL7FSo7t39FPz84Q=;
        b=AfVvRVKxT16opoUtNwmQng6kAtm6nMIgdH2nKm+2+ezUx7KOiG0Nm8O97IxAM37tir
         p/SJT/bUUhS9U6zieJOawHf1aUVeyKcfX12uqqg4V0qANNsAUpv7mutXlzfYAqmTTzS8
         93mciKwb2Qec+PVy4i/ffgGueKKzCAD1f9rStQfq4nZyvQ5H+uEC2C1Nq3DVVPQNXMOC
         0c6gox6awmEAJcCn/W/Jt9wfVofVBzp3M0KjejXPBu9B6ZW51jTwXkZb2xj2C99w1Hv+
         Cx/72cj8vTHBNzabhlWTA2HhMJzAgOCOvhfAEB/2X7nIKjKM9l269cR/D+owwstLCiyl
         SwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lZIeDJvkJuEUBviMXE7UwBsv47juL7FSo7t39FPz84Q=;
        b=RrLMRLAT+npi0p2nVOKIPR80eLXSpf0/ez8DQ+mkGK3Xjk+S3Rkduy4kj8Av2fDFSG
         SBH1s+7AcqL/qM8LpTHTanyWJJ//OCaMBo4aZvkQ0wLsvO13Ak4ZqSVDIAtGdUnBCrbm
         oxZOF++vq5zvI6iDZhWWtjbcGKR9IzNthSYwVZO7CZP0qABwPpE0twNEVf0KNVqVHkz7
         CLVwVZ43mYEuWkxA09nuOJ0CVlaVZ5pD5YGj3llKggYWfX7msdgyLXNHdzmb/U6bIAlY
         Bd2vX9/in432vJKcysYbvD0qiH51mdI5jREzH1m8LWYikh0QS/Ew5Zdd2nQtAMv6d1Th
         tIjw==
X-Gm-Message-State: AOUpUlF2rQGDjbYwNKLbg1KDCBsXaYKdR2P77HARakCX/eIgzIUk4eLJ
        f5XKi903q+o8BPHirPekGEyWPPg+
X-Google-Smtp-Source: AAOMgpdaVoocQRxD8v5nMSsejru5L5U9mp5pL/snzZ7OpjUWGF9A3dwW5F71QBaBkc7erz2X/gsZgQ==
X-Received: by 2002:a1c:85cc:: with SMTP id h195-v6mr2264701wmd.110.1532450055211;
        Tue, 24 Jul 2018 09:34:15 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.googlemail.com with ESMTPSA id x124-v6sm1899091wmg.38.2018.07.24.09.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:34:14 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 03/20] editor: add a function to launch the sequence editor
Date:   Tue, 24 Jul 2018 18:32:04 +0200
Message-Id: <20180724163221.15201-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
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
No changes since v3.

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

