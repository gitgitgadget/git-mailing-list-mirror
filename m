Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8971F428
	for <e@80x24.org>; Sun, 29 Apr 2018 18:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754110AbeD2ST2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 14:19:28 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39917 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753989AbeD2STM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 14:19:12 -0400
Received: by mail-lf0-f68.google.com with SMTP id j193-v6so9359310lfg.6
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUs+OmYiTGg7QDFK4cByKIyVDTtV7LgDMys7yqFhAL4=;
        b=gkJdKDL0vktdpBJZHvq2fOdnqTPaYyFkLA+Loq9TJTY2rLKswZ5ni9GCSIA2N+ZHjc
         XzATmW6oiQOzDRscLgLIf89wEUAo2q1YzsQnhr54U1T+vMKvCI3LzbKFvFPX7scumsU+
         6H1PUdvK63c0KN1M+hbC0QZ8U47Mjeigju/DVj4iO1IsDll7sVYzGrKPC6NxyOqXz+fe
         U4ypgN9mPI3jhabksS8al8h7EIrDE40vwOfMDJAmKVJVWdliesaAq3feH0lvqX7Hb2Ol
         u9eAQkWLsbz7mkjoSaV/oSCi7+yGZ7S3H9yM0yqGOcQFZ9FBRFe0K03M7x3uNH0ocqky
         InWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUs+OmYiTGg7QDFK4cByKIyVDTtV7LgDMys7yqFhAL4=;
        b=rIZ43KT28w8U0ZiWmaISBWusvq+o3+fxOI3MI6NLUXxR54xNCXahI84yFzlBjC8lYS
         eMcBObbltlKod90qoT7/jui6JRMviKt18vs5TEYkkww5Z3jQQhkQmAW2RQiCabOfKvWn
         z9KdEM8b+3CiK+V1/mFU6N7v3ukfb6k1aOMsEvQM+Aq7MBQZxkpma2L1OBAwnK3Fjfwy
         1w+zqGWko0UfxuRbO/HsU2p90YKQ/K5l6hG560deDSklIDynqaPGy42JVzvbAx2CSODK
         V51DUZbJGfXBLbd685c+GmkDqhGdd+tD8jtfxpy8Kq6AYGLjsPPpT7a5gIvgqBdiVNzO
         kOgQ==
X-Gm-Message-State: ALQs6tCfrcFmX092wj+brrLhM5Ynyz3g7fSh0uqxHJi8fi5h92vX8Dqq
        EhHC+HSZSgII8AorNwi9pNI=
X-Google-Smtp-Source: AB8JxZpWXjMSIcHEGxH0WCosEOSKOYW5rKV/Wm6NllUrn2UiG6YrgWv6VhwyxP8rrOQ+YoIbyug2aA==
X-Received: by 2002:a2e:82d6:: with SMTP id n22-v6mr6174036ljh.142.1525025951101;
        Sun, 29 Apr 2018 11:19:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r78-v6sm975376ljb.20.2018.04.29.11.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 11:19:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v5 07/10] git: support --list-cmds=list-<category>
Date:   Sun, 29 Apr 2018 20:18:41 +0200
Message-Id: <20180429181844.21325-8-pclouds@gmail.com>
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

This allows us to select any group of commands by a category defined
in command-list.txt. This is an internal/hidden option so we don't
have to be picky about the category name or worried about exposing too
much.

This will be used later by git-completion.bash to retrieve certain
command groups.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 generate-cmdlist.sh | 17 +++++++++++++++++
 git.c               |  7 +++++++
 help.c              | 22 ++++++++++++++++++++++
 help.h              |  1 +
 4 files changed, 47 insertions(+)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 015eef2804..bfd8ef0671 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -45,6 +45,21 @@ define_categories() {
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
 
@@ -70,4 +85,6 @@ struct cmdname_help {
 "
 define_categories "$1"
 echo
+define_category_names "$1"
+echo
 print_command_list "$1"
diff --git a/git.c b/git.c
index da161a74ae..93927e34c4 100644
--- a/git.c
+++ b/git.c
@@ -52,6 +52,13 @@ static int list_cmds(const char *spec)
 			list_all_main_cmds();
 		else if (len == 6 && !strncmp(spec, "others", 6))
 			list_all_other_cmds();
+		else if (len > 5 && !strncmp(spec, "list-", 5)) {
+			struct strbuf sb = STRBUF_INIT;
+
+			strbuf_add(&sb, spec + 5, len - 5);
+			list_cmds_by_category(sb.buf);
+			strbuf_release(&sb);
+		}
 		else
 			die(_("unsupported command listing type '%s'"), spec);
 		spec += len;
diff --git a/help.c b/help.c
index 71bc001570..156dde1bea 100644
--- a/help.c
+++ b/help.c
@@ -329,6 +329,28 @@ void list_all_other_cmds(void)
 	clean_cmdnames(&other_cmds);
 }
 
+void list_cmds_by_category(const char *cat)
+{
+	int i, n = ARRAY_SIZE(command_list);
+	uint32_t cat_id = 0;
+
+	for (i = 0; category_names[i]; i++) {
+		if (!strcmp(cat, category_names[i])) {
+			cat_id = 1UL << i;
+			break;
+		}
+	}
+	if (!cat_id)
+		die(_("unsupported command listing type '%s'"), cat);
+
+	for (i = 0; i < n; i++) {
+		struct cmdname_help *cmd = command_list + i;
+
+		if (cmd->category & cat_id)
+			puts(drop_prefix(cmd->name));
+	}
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 30e165773e..752368840a 100644
--- a/help.h
+++ b/help.h
@@ -19,6 +19,7 @@ static inline void mput_char(char c, unsigned int num)
 extern void list_common_cmds_help(void);
 extern void list_all_main_cmds(void);
 extern void list_all_other_cmds(void);
+extern void list_cmds_by_category(const char *category);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.664.g8924eee37a

