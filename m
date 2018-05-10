Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D911F42D
	for <e@80x24.org>; Thu, 10 May 2018 08:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756937AbeEJIrm (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 04:47:42 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43348 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756858AbeEJIrI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 04:47:08 -0400
Received: by mail-lf0-f66.google.com with SMTP id g12-v6so1801687lfb.10
        for <git@vger.kernel.org>; Thu, 10 May 2018 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ooJb8n7EHzUWeVgQi8TwGwfJqgJCZYzsKF9tp8CqjMY=;
        b=Bm4U1V5k3j3uZsNCb8h9HPTIJ66XjqFlRtzXGXpoZA6ufKSApHszbyYacChMSk1AUt
         53oRe6xHf++EcDcMEdirPRGH+Z0sfycc0Wq2NxMH3AywfQgkYLX70bifOhBQaVRhTBUa
         YFxG3dr3I1Y/Yy5XZ9y/iS8HYNqM6Xh+LysJNP7JcTb1sG3rZCFMhF/AMLDQFgBewVTj
         JIEXgZADYgOklCC/p6ZHJ8aYKEOiWjap/rV6aKYHAt9z2RVVfFUPyo+B13d35hyFajPh
         9v57YNR/fMXkODp/JVRYb7UF9lYg4eG3bTPS1yHCVNuI25/BlLUMAwOUvmrwsjjunPZ0
         FXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ooJb8n7EHzUWeVgQi8TwGwfJqgJCZYzsKF9tp8CqjMY=;
        b=KIuS3Shf9sq3ARnbOlwN8lVcZL01dTrTSPNW4XqMFQucbEvNlfOpn/+xoNJ6VRiTW8
         65o0rrGp55wl5e11ML3yKzP5b/glt7KzttZZMqG3z1j2vsW0gVEKyMAQ+OqJZ3ixs7kB
         lZqCXav/tiEiBVw+4G8rXxIK1FbddbC2jX0NcS05ZQ9DSc3mbYPmkJoUGq5TuSDZLvtZ
         kHmV9Kr9BEkSbniZxeNEYBLaVsZI2zpFrjcnd2WesqO1Ja61UaYQZnjb2aX7FXWQfkjF
         pXr6gExipoZKjjyAa1sXAShy9yvxOxnfwrgmxSvFI6WyPIddgu4CNYIuXp6+v7vqVaD7
         R9BA==
X-Gm-Message-State: ALKqPwdWOq92DeIzME4eVCZdZpByD7iwnPE5HyV7s+d3HiJSAQDlgiS0
        +BBGRbLeiP1KEgghahaSmk0=
X-Google-Smtp-Source: AB8JxZqAyqvtJiH/26vCzCdUSGUBEOdoLPzS6Q2kUgmW2Cs4jEt9dxaTukqxUG7C1RbUmRPbvA3XDQ==
X-Received: by 2002:a2e:9d07:: with SMTP id t7-v6mr486786lji.7.1525942026518;
        Thu, 10 May 2018 01:47:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l24-v6sm68024lje.42.2018.05.10.01.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 01:47:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v7 07/13] completion: implement and use --list-cmds=main,others
Date:   Thu, 10 May 2018 10:46:46 +0200
Message-Id: <20180510084652.25880-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510084652.25880-1-pclouds@gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com>
 <20180510084652.25880-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of parsing "git help -a" output, which is tricky to get right,
less elegant and also slow, make git provide the list in a
machine-friendly form. This adds two separate listing types, main and
others, instead of just "all" for more flexibility.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
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
index 376a59b97f..10907f7266 100644
--- a/git.c
+++ b/git.c
@@ -56,6 +56,10 @@ static int list_cmds(const char *spec)
 
 		if (match_token(spec, len, "builtins"))
 			list_builtins(&list, 0);
+		else if (match_token(spec, len, "main"))
+			list_all_main_cmds(&list);
+		else if (match_token(spec, len, "others"))
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

