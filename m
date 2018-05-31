Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74CFE1F51C
	for <e@80x24.org>; Thu, 31 May 2018 11:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbeEaLD0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 07:03:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52299 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754441AbeEaLDV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 07:03:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id 18-v6so47711644wml.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 04:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jiQ+ZN1kZwups/JLCM7s4i9WtgYUYRtJs2H1HQHaMUg=;
        b=Uwpp2XxVd2W8SFZtaKwfRN2m5eqX1+/4tSsW9z1qUOpTxDnMGVRoJpp6k50zhldLky
         lFD6cek3X6Oa94wG58Hqya4TxQm9SBxGu6RHfAE/FI19QSIGGyiz7JpW+nlpbbqUyLc1
         KvZQRpDfUdJK6GZ6dxj7iRnhs0FxRBoMlFec1MwGnH2EZo0/XJeRFwKyjKnKKsZJo3gQ
         XjwuKuWHjgPrqXLtKA5QCdlbyyBxspo0vm+6ZEK5TRprIaBlb/uzQX2FDAAd+irtg8hc
         eg64HJeaIYw1Bh9kzujDMnUf9QyFbTszb7IHfZswzqL8uxZXTeH8yk17HoXWNePZhc2H
         tpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jiQ+ZN1kZwups/JLCM7s4i9WtgYUYRtJs2H1HQHaMUg=;
        b=N3kmBq7g9PZZLa0VasyP4gxNOPk0uHDVYD41MvuGVapc8HqpxkaTRJ6MSl5I3XVmod
         wH9PemAQZVcFJyEkF1C16Q5VwQLuPBNCIHC/6dMR+XSaq2Mkc3V441BLDQL4DwUqgNuU
         mH878uQmEARb9e0fFPxNYYt08CRuC+sbwKZLZ54Jh6VbJesfXNCLX5rDivvtBJoyQFHO
         C3pxvxNaBWSlTVVCy0Xt7NvFiegBcMfRD6NU5Bi2gyhxYbxkqWjYmXIBIy+3LRp3r8V+
         zOK89WmuYaOtxtYmWj+uv1XR0zQHGwhrVSMd+9Ng/hh+f5EyrDbXyCfnWYobMD/8z0+e
         AJLQ==
X-Gm-Message-State: ALKqPwfyc61IKKUyASUcIm/X/3G+XenKOtqODqE3/vSUFQ3hvhR0AjsU
        MVgGfVIIfsANVLsKweHM8CNsxge1
X-Google-Smtp-Source: ADUXVKJjSKqhgLzWZAB/qASfMLMmxF4v8f7bLQin+RTPGrqMN7B86PC8uXLW4x8PEjDlCLO2rGOedw==
X-Received: by 2002:a50:9434:: with SMTP id p49-v6mr7532010eda.107.1527764599955;
        Thu, 31 May 2018 04:03:19 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-184-117.w86-199.abo.wanadoo.fr. [86.199.39.117])
        by smtp.googlemail.com with ESMTPSA id f2-v6sm5887419edq.28.2018.05.31.04.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 04:03:18 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 2/2] sequencer: remove newlines from append_todo_help() messages
Date:   Thu, 31 May 2018 13:01:30 +0200
Message-Id: <20180531110130.18839-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180531110130.18839-1-alban.gruin@gmail.com>
References: <20180531110130.18839-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes newlines before and after the messages in
append_todo_help(). This is done to avoid confusions from
translators.

These newlines are now inserted with
`strbuf_add_commented_lines()`. Messages were ended by two newlines
characters, but here we only insert one at a time. This is because
`strbuf_add_commented_lines()` automatically inserts a newline at the
end of the input, and ignore the last from the input.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9b291845e..9ab6c28d7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4228,7 +4228,7 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 	struct strbuf buf = STRBUF_INIT;
 	FILE *todo;
 	int ret;
-	const char *msg = _("\nCommands:\n"
+	const char *msg = _("Commands:\n"
 "p, pick <commit> = use commit\n"
 "r, reword <commit> = use commit, but edit the commit message\n"
 "e, edit <commit> = use commit, but stop for amending\n"
@@ -4243,33 +4243,37 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 ".       message (or the oneline, if no original merge commit was\n"
 ".       specified). Use -c <commit> to reword the commit message.\n"
 "\n"
-"These lines can be re-ordered; they are executed from top to bottom.\n");
+"These lines can be re-ordered; they are executed from top to bottom.");
 
 	todo = fopen_or_warn(rebase_path_todo(), "a");
 	if (!todo)
 		return 1;
 
+	strbuf_add_commented_lines(&buf, "\n", 1);
 	strbuf_add_commented_lines(&buf, msg, strlen(msg));
 
 	if (get_missing_commit_check_level() == CHECK_ERROR)
-		msg = _("\nDo not remove any line. Use 'drop' "
-			 "explicitly to remove a commit.\n");
+		msg = _("Do not remove any line. Use 'drop' "
+			 "explicitly to remove a commit.");
 	else
-		msg = _("\nIf you remove a line here "
-			 "THAT COMMIT WILL BE LOST.\n");
+		msg = _("If you remove a line here "
+			 "THAT COMMIT WILL BE LOST.");
 
+	strbuf_add_commented_lines(&buf, "\n", 1);
 	strbuf_add_commented_lines(&buf, msg, strlen(msg));
 
 	if (edit_todo)
-		msg = _("\nYou are editing the todo file "
+		msg = _("You are editing the todo file "
 			"of an ongoing interactive rebase.\n"
 			"To continue rebase after editing, run:\n"
-			"    git rebase --continue\n\n");
+			"    git rebase --continue");
 	else
-		msg = _("\nHowever, if you remove everything, "
-			"the rebase will be aborted.\n\n");
+		msg = _("However, if you remove everything, "
+			"the rebase will be aborted.");
 
+	strbuf_add_commented_lines(&buf, "\n", 1);
 	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+	strbuf_add_commented_lines(&buf, "\n", 1);
 
 	if (!keep_empty) {
 		msg = _("Note that empty commits are commented out");
-- 
2.16.4

