Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CA51F428
	for <e@80x24.org>; Sun, 29 Apr 2018 18:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeD2STR (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 14:19:17 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33318 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeD2STL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 14:19:11 -0400
Received: by mail-lf0-f68.google.com with SMTP id m18-v6so9376399lfb.0
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gcNR7mKkvRjtvKMQr03Dv2vLf1MqT2ja/6jjE6N3Jg4=;
        b=pxy1qkFNvFJstzgHidDMJAdD1XNAyDodYi0zFTZn4cq+CGgBasgqLIrafXNxzbWy/e
         mh6EITMmLit/Qpgyx58wKVD+u5EkacF+RPWOVolgH978VfMesdUykABGSfG8WSVCLFeB
         I5kGw4SJolMXh10S5VdozdMbz08Jr/nitirIev1uN7eR0DBQAouwH/XXmmdXw5ysrWSz
         C9FEkW4LOwihLsiQglZOD7IPI7ygqvk9lmN3mJLtFEeBfyo9h5CuGNCDc1kWNLkge1uT
         LTrMDwYKgNXrrWX83Gispb3i+Nk8JkqFWRv/cc7fhWfm0xCalcz2p/9Y/UXOK/HEBfop
         ZXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gcNR7mKkvRjtvKMQr03Dv2vLf1MqT2ja/6jjE6N3Jg4=;
        b=j+bqIE5+MOaqVMSxdlrppJfGcmxG8bTFsuaporJ3jxM8rAPj0NrUFCHlyKwk70BF2d
         iKbYpou23dCJAjiQWjvxEkDVHABdsbCfoXgEBSbDIRg8ndGjNp13Q5h90O1gN5vQ2PbW
         fDfCoINicTvcwdOhvpytSjIgYePrO6RHf3y2frds/4ik19TVnefeXvqMV9FLsM3LeGIu
         taDtd2tZ50irwXnZCfeOub5wgFNB3/Y3XhpLOBrsgl3I9bJ3FZhK2fEsXbxArE+p2eLE
         2EhotEvQMrDo8hAzwhyrp1xORB2Bzb/MfxLHwNvtIZf9g80vkBiGvRi7wjxxgL3A85lK
         O11A==
X-Gm-Message-State: ALQs6tDl0+lZ+C4ovtwRwNJaSI6LMwSRW03a7w1Cit2MayJnnQ2OUn2P
        JlRWvUx6TGvGhw2hSYHPH6s=
X-Google-Smtp-Source: AB8JxZqoYclBqOtgjxtbDuH4faLavif1EThC3As7dqTmKaZecvzTE9Sv/FFopsC0JDuzEzHS6EikXg==
X-Received: by 2002:a2e:2b96:: with SMTP id r22-v6mr6647204ljr.2.1525025949962;
        Sun, 29 Apr 2018 11:19:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r78-v6sm975376ljb.20.2018.04.29.11.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 11:19:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v5 06/10] completion: implement and use --list-cmds=main,others
Date:   Sun, 29 Apr 2018 20:18:40 +0200
Message-Id: <20180429181844.21325-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.664.g8924eee37a
In-Reply-To: <20180429181844.21325-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180429181844.21325-1-pclouds@gmail.com>
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
 help.h                                 |  2 ++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d7b448fd94..77cfb8a20b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -834,7 +834,7 @@ __git_commands () {
 	then
 		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
 	else
-		git help -a|egrep '^  [a-zA-Z0-9]'
+		git --list-cmds=main,others
 	fi
 }
 
diff --git a/git.c b/git.c
index ea9bbfb6a3..da161a74ae 100644
--- a/git.c
+++ b/git.c
@@ -48,6 +48,10 @@ static int list_cmds(const char *spec)
 			list_builtins(0, '\n');
 		else if (len == 8 && !strncmp(spec, "parseopt", 8))
 			list_builtins(NO_PARSEOPT, ' ');
+		else if (len == 4 && !strncmp(spec, "main", 4))
+			list_all_main_cmds();
+		else if (len == 6 && !strncmp(spec, "others", 6))
+			list_all_other_cmds();
 		else
 			die(_("unsupported command listing type '%s'"), spec);
 		spec += len;
diff --git a/help.c b/help.c
index bf2738e9ef..71bc001570 100644
--- a/help.c
+++ b/help.c
@@ -297,6 +297,38 @@ void list_common_cmds_help(void)
 	print_cmd_by_category(common_categories);
 }
 
+void list_all_main_cmds(void)
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
+
+	clean_cmdnames(&main_cmds);
+	clean_cmdnames(&other_cmds);
+}
+
+void list_all_other_cmds(void)
+{
+	struct cmdnames main_cmds, other_cmds;
+	int i;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
+	load_command_list("git-", &main_cmds, &other_cmds);
+
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
index b21d7c94e8..30e165773e 100644
--- a/help.h
+++ b/help.h
@@ -17,6 +17,8 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_main_cmds(void);
+extern void list_all_other_cmds(void);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.664.g8924eee37a

