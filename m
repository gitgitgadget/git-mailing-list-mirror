Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F311F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755572AbeDYQbp (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:31:45 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45371 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755151AbeDYQbg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:31:36 -0400
Received: by mail-lf0-f65.google.com with SMTP id q5-v6so26353487lff.12
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTt3BEd8vRXdvh+dz+HV5R8hmNbrtBmhumnFQiGhsfs=;
        b=ewy89zMxT7AHHwMQ1IujpDtHT74rR5yIKFzdHB8ojBSBjuLrwrxhjc6j9nRDPhQnVY
         GHVhdD8mo5a5xeiZYq7k5tyaOMPZCOu8a6DnHZsz4NDBJbJfb1B+CTITdzCFEFXJVxsp
         hlb2+7MOgm7cJi9cR6+27+s74TF1RVYnwmyh79z/3Is2p/yXmQXLTGcvHgygaOpmiccD
         eNAHBOkI5mTASDmmpjYolnZkM6KRWtZZecDBw5a2QsS1hhHn41ZEx9mLHbO3Zshm0zhh
         ugI/DVpTJb4it8YiST6QQUx2omAT+cffRsCZcBhxF3CeeTjoXnNBawmrbh4e/9Ub9uER
         XOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTt3BEd8vRXdvh+dz+HV5R8hmNbrtBmhumnFQiGhsfs=;
        b=iDHV3J+MLwBNozM9T1Nig66umtSwTj3TB8LrP+YurcItJJ4jpaCJBaXEmtd7dzcDEk
         K+k7yzjPc3Ywdz3+LCnnvetxHpFVaZuaSh+dIryC5FJleTkP+lx9fZqsB/ptjkbXGcEa
         pmZHvwtKL62y218uHgmv/EDT2ELX5QxUy3WGPUcLBMF1uKMUGDWIOz2oDwx4iAg8iR/7
         PAOEUtcKlwS3LQ2OtqTm596P/PZUiNkmEzDp6T9eB5tgyAa0im29bmzHak/LyiO5yBoB
         7asKRZTga46Uf+Lk7VvL/mrdPS9IcuPFjqnAQtiijJ+jJR3xUWiygzWfq5p/FBj7Rh2K
         QLzg==
X-Gm-Message-State: ALQs6tBbA+6CD9+0SuW9bqjKB/QLNFx+H3sF4NwmWtbkr/EgB1mjXL8k
        RVEcsWa0HuMts8b+9ARLuDw=
X-Google-Smtp-Source: AIpwx49KrG765TJOoSmuPU8qyZDCjUZ350Ib551wLaFsw3KP+JT+pqYa3wnv+q1OJGu4CoPwqi61Sw==
X-Received: by 10.46.147.204 with SMTP id p12mr19628615ljh.80.1524673895635;
        Wed, 25 Apr 2018 09:31:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t24sm518370ljg.65.2018.04.25.09.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:31:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v4/wip 07/12] completion: implement and use --list-cmds=all
Date:   Wed, 25 Apr 2018 18:31:02 +0200
Message-Id: <20180425163107.10399-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.519.gb89679a4aa
In-Reply-To: <20180425163107.10399-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180425163107.10399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of parsing "git help -a" output, which is tricky to get right,
less elegant and also slow, make git provide the list in
machine-friendly form.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  |  2 ++
 help.c                                 | 18 ++++++++++++++++++
 help.h                                 |  1 +
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3556838759..a5f13ade20 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -839,7 +839,7 @@ __git_commands () {
 	then
 		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
 	else
-		git help -a|egrep '^  [a-zA-Z0-9]'
+		git --list-cmds=all
 	fi
 }
 
diff --git a/git.c b/git.c
index a46263306d..fa6e542d06 100644
--- a/git.c
+++ b/git.c
@@ -229,6 +229,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				list_builtins(0, '\n');
 			else if (!strcmp(cmd, "parseopt"))
 				list_builtins(NO_PARSEOPT, ' ');
+			else if (!strcmp(cmd, "all"))
+				list_all_cmds();
 			else
 				die("unsupported command listing type '%s'", cmd);
 			commands_listed++;
diff --git a/help.c b/help.c
index 5b4a2f1b4f..217864999e 100644
--- a/help.c
+++ b/help.c
@@ -287,6 +287,24 @@ void list_common_cmds_help(void)
 	print_cmd_by_category(common_categories);
 }
 
+void list_all_cmds(void)
+{
+	struct cmdnames main_cmds, other_cmds;
+	int i;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
+	load_command_list("git-", &main_cmds, &other_cmds);
+
+	for (i = 0; i < main_cmds.cnt; i++)
+		puts(main_cmds.names[i]->name);
+	for (i = 0; i < other_cmds.cnt; i++)
+		puts(other_cmds.names[i]->name);
+
+	clean_cmdnames(&main_cmds);
+	clean_cmdnames(&other_cmds);
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index b21d7c94e8..0bf29f8dc5 100644
--- a/help.h
+++ b/help.h
@@ -17,6 +17,7 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_cmds(void);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.519.gb89679a4aa

