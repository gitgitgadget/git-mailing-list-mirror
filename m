Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2391F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755522AbeDYQbo (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:31:44 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43879 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754849AbeDYQbi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:31:38 -0400
Received: by mail-lf0-f66.google.com with SMTP id g12-v6so10285677lfb.10
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDAe/d76uaZOlAEklEgea131WnqVIlW7WUUPuqptQF4=;
        b=UvLaauTgmGkCDcy1aQv/qWLUOy8eHpPbNAAPlbc1HPmghySDYKqgUrCXt3XF6eiof3
         mC8AyPtba7ybijqqgbfJIAUdHtqxbEbZosVdlKed8Q6dZ2REnSV/a6uXMK1XvgzD41UY
         6ZwZSFS7HAOzmhG3NAdvVTZ8xnq3Ac+pfEgAmgIiXh0Ux6TzbNC4S3m4VxRvlFNxtKTT
         eNSy6pLauwYi2l8MIabtBfyXThIu3jSxTc1Hd7L8QeTIouN9q7m/otYkEpSi+/AUpNED
         g9A8iWNNPHFPJ5l8QyWsYkHRrr4a7Tlzc2WhyqIm0bISf6im4MQqIZ2gizgICPyB3ILZ
         WCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDAe/d76uaZOlAEklEgea131WnqVIlW7WUUPuqptQF4=;
        b=mbO7sPVHxyGE51kDHqN+lC/0XDZixq3Ik90PTuDCiCleLmNtOvdQ74nqj+8W6wSCq3
         K+W5n87PtBuFXxB1MFapZEJoMbk5h2zsxVkV6IQVQKY8mAp5PNfzMgzaIfGIGMU5vv26
         fcaREdeDDEVV6PECaBlAxTHlenTV+erUbz99Uiwh7q5apo3l2RixWPZjiCNoRu/efw7q
         awXUXjxaJb/6wH3eZtr+0gdLwjlTBXPTkmQzwoLnaCssyi0k9mS9Bf55jgv3Cj6YJIwp
         GyOFpifVA/wOSTT5A7TY1xHk3xPy0InXI7P3b1O7MTyNKH4WeW8ud0E0fKirVDEsRGwW
         XNEQ==
X-Gm-Message-State: ALQs6tB2Gu0Wd6G1BHtgGjiJqbj8PvRAE94+UtHkkTDSHOrdi7RmeCC+
        SoyOuJB7bOxCy3ZrpRKY2Lw=
X-Google-Smtp-Source: AIpwx4/VgXeFWlQfJ8P9YdyjuLxcmiltDZp+VRng+Ee0TPUFUeuWFhprXrpIW+ZMXJ6JDQBpE/tn1Q==
X-Received: by 10.46.29.83 with SMTP id d80mr18710007ljd.104.1524673896903;
        Wed, 25 Apr 2018 09:31:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t24sm518370ljg.65.2018.04.25.09.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:31:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v4/wip 08/12] git: support --list-cmds=<category>
Date:   Wed, 25 Apr 2018 18:31:03 +0200
Message-Id: <20180425163107.10399-9-pclouds@gmail.com>
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

This allows us to select any group of commands by a category defined
in command-list.txt. This is an internal/hidden option so we don't
have to be picky about the category name or worried about exposing too
much.

This will be used later by git-completion.bash to retrieve certain
command groups.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 generate-cmdlist.sh | 17 +++++++++++++++++
 git.c               |  2 +-
 help.c              | 19 +++++++++++++++++++
 help.h              |  1 +
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 57f9800123..c14c0a7adc 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -47,6 +47,21 @@ define_categories() {
 	test "$bit" -gt 32 && die "Urgh.. too many categories?"
 }
 
+define_category_names() {
+	echo
+	echo "/* Category names */"
+	echo "static const char *category_names[] = {"
+	bit=0
+	category_list "$1" |
+	while read cat
+	do
+		echo "	\"$cat\", /* (1UL << $bit) */"
+		bit=$(($bit+1))
+	done
+	echo "	NULL"
+	echo "};"
+}
+
 print_command_list() {
 	echo "static struct cmdname_help command_list[] = {"
 
@@ -72,4 +87,6 @@ struct cmdname_help {
 "
 define_categories "$1"
 echo
+define_category_names "$1"
+echo
 print_command_list "$1"
diff --git a/git.c b/git.c
index fa6e542d06..6c071d44f5 100644
--- a/git.c
+++ b/git.c
@@ -232,7 +232,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			else if (!strcmp(cmd, "all"))
 				list_all_cmds();
 			else
-				die("unsupported command listing type '%s'", cmd);
+				list_cmds_by_category(cmd);
 			commands_listed++;
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
diff --git a/help.c b/help.c
index 217864999e..affa8e4343 100644
--- a/help.c
+++ b/help.c
@@ -305,6 +305,25 @@ void list_all_cmds(void)
 	clean_cmdnames(&other_cmds);
 }
 
+void list_cmds_by_category(const char *cat)
+{
+	int i;
+	int cat_id = 0;
+
+	for (i = 0; category_names[i]; i++) {
+		if (!strcmp(cat, category_names[i])) {
+			cat_id = 1 << i;
+			break;
+		}
+	}
+	if (!cat_id)
+		die("unsupported command listing type '%s'", cat);
+
+	for (i = 0; command_list[i].name; i++)
+		if (command_list[i].category & cat_id)
+			puts(command_list[i].name);
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 0bf29f8dc5..3e30542927 100644
--- a/help.h
+++ b/help.h
@@ -18,6 +18,7 @@ static inline void mput_char(char c, unsigned int num)
 
 extern void list_common_cmds_help(void);
 extern void list_all_cmds(void);
+extern void list_cmds_by_category(const char *category);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.519.gb89679a4aa

