Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AE2200B9
	for <e@80x24.org>; Mon,  7 May 2018 17:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeEGRxP (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 13:53:15 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42988 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeEGRxK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 13:53:10 -0400
Received: by mail-lf0-f67.google.com with SMTP id u21-v6so41884811lfu.9
        for <git@vger.kernel.org>; Mon, 07 May 2018 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TV58toI9DRQUId3OwPFtJ2I/JBkONreeAUj6Zg12Aac=;
        b=fv3vvNmQphw7Ro+sV8j5kir1q4m/NV+C4VMxZzlIAHk+a57Z+BLQZZbthvejheY/jb
         sptNR3RsBIdSf32XHi91CEr3rKJoF4IdqJ44oskqhQ4YTIWFy1Ov85+9/9iHEP5kf/jb
         iexwpvA5wTWGZFXYuu36HDkV/UTAhdkJ4++3Ems+ehFss4vxS7NvYNaoWjUhmaN0TqO8
         T6iPE5FY8tnQSYqy/Z/6CtZG+3pFFzmBkNeSyL1pALT2lkXA37XjOXxaq3aC3InAZLZT
         NbrIykmnwNCL51cM8fgq3iSILPHS7467CpESyYrnU3827SzxYDJZV7VZJATB7CnCTUWF
         rGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TV58toI9DRQUId3OwPFtJ2I/JBkONreeAUj6Zg12Aac=;
        b=ViIH3lNe5II6KRxvL296+I1Pv5aFX/pouQHq4CaqtRMbm2Sz7wufVcT+pfyRYyBTgi
         8KWjSfADn1Gf7LqWiqS6DwXmpItsPuTjSiZmv0vlrhEwEtKQ/jKoB5q54ZI677NcDWgD
         KHCPQ2dhj12P3u4tjE3j9GsbaTrJNJ4z6CCF7pCBdunRidl/yYIFu1RKKoHJ7HraNwMZ
         H9Hg4RscB7gIj03eCxZI8B2AHPx0nQ/3aijYf90RD9GOYJ7B5KuZBmh1V+knHbn0keS5
         9RqQxRMy2EpTklMFhFfUO//n+5ExTCTmLJhF6JIMUOsuSYtUgr8oDKcnWcjfY1cgwBWO
         doDQ==
X-Gm-Message-State: ALKqPwcDp2Jffjs0WSeXiZn0z6YpIWhPpAngWsgXFL3iE1rzPbsaGk+d
        Mf/mUNhJQNlYOFB0vL1aYcmQSA==
X-Google-Smtp-Source: AB8JxZoPgf+uegTRMCFfX524xpm1Nyy8iUu+5gmD2ARs47xrMvK04ORs4h9F36m727XHVGVRkjrnGg==
X-Received: by 2002:a2e:9816:: with SMTP id a22-v6mr1753744ljj.27.1525715588610;
        Mon, 07 May 2018 10:53:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4376865ljk.83.2018.05.07.10.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 10:53:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v6 07/13] completion: implement and use --list-cmds=main,others
Date:   Mon,  7 May 2018 19:52:16 +0200
Message-Id: <20180507175222.12114-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180507175222.12114-1-pclouds@gmail.com>
References: <20180429181844.21325-1-pclouds@gmail.com>
 <20180507175222.12114-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of parsing "git help -a" output, which is tricky to get right,
less elegant and also slow, make git provide the list in a
machine-friendly form. This adds two separate listing types, main and
others, instead of just "all" for more flexibility.
---
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  |  4 ++++
 help.c                                 | 32 ++++++++++++++++++++++++++
 help.h                                 |  4 ++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3556838759..62ca8641f4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -839,7 +839,7 @@ __git_commands () {
 	then
 		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
 	else
-		git help -a|egrep '^  [a-zA-Z0-9]'
+		git --list-cmds=main,others
 	fi
 }
 
diff --git a/git.c b/git.c
index a0477c459e..3c032d01fc 100644
--- a/git.c
+++ b/git.c
@@ -49,6 +49,10 @@ static int list_cmds(const char *spec)
 
 		if (len == 8 && !strncmp(spec, "builtins", 8))
 			list_builtins(&list, 0);
+		else if (len == 4 && !strncmp(spec, "main", 4))
+			list_all_main_cmds(&list);
+		else if (len == 6 && !strncmp(spec, "others", 6))
+			list_all_other_cmds(&list);
 		else
 			die(_("unsupported command listing type '%s'"), spec);
 		spec += len;
diff --git a/help.c b/help.c
index 2d6a3157f8..d5ce9dfcbb 100644
--- a/help.c
+++ b/help.c
@@ -297,6 +297,38 @@ void list_common_cmds_help(void)
 	print_cmd_by_category(common_categories);
 }
 
+void list_all_main_cmds(struct string_list *list)
+{
+	struct cmdnames main_cmds, other_cmds;
+	int i;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
+	load_command_list("git-", &main_cmds, &other_cmds);
+
+	for (i = 0; i < main_cmds.cnt; i++)
+		string_list_append(list, main_cmds.names[i]->name);
+
+	clean_cmdnames(&main_cmds);
+	clean_cmdnames(&other_cmds);
+}
+
+void list_all_other_cmds(struct string_list *list)
+{
+	struct cmdnames main_cmds, other_cmds;
+	int i;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
+	load_command_list("git-", &main_cmds, &other_cmds);
+
+	for (i = 0; i < other_cmds.cnt; i++)
+		string_list_append(list, other_cmds.names[i]->name);
+
+	clean_cmdnames(&main_cmds);
+	clean_cmdnames(&other_cmds);
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index b21d7c94e8..97e6c0965e 100644
--- a/help.h
+++ b/help.h
@@ -1,6 +1,8 @@
 #ifndef HELP_H
 #define HELP_H
 
+struct string_list;
+
 struct cmdnames {
 	int alloc;
 	int cnt;
@@ -17,6 +19,8 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_main_cmds(struct string_list *list);
+extern void list_all_other_cmds(struct string_list *list);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.705.g3525833791

