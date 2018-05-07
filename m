Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6828A200B9
	for <e@80x24.org>; Mon,  7 May 2018 17:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeEGRxb (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 13:53:31 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45699 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752730AbeEGRxL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 13:53:11 -0400
Received: by mail-lf0-f67.google.com with SMTP id y14-v6so41532400lfy.12
        for <git@vger.kernel.org>; Mon, 07 May 2018 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dyoAvoyFg4jUJfdz4aKXhqjKtPxM6RS8h0KV2O9Y/lA=;
        b=Lqtk1tYl9oe02ptWQu2bT6VG75YFWpM6rHsDqA7MRlKUrWa9XPauwqoKV1cNawh6p0
         5mG9s84g5I95vk4heZ6lQcJmPsBnsZrKAGP4KHBMjW8Smh4vBTxe/SNddq/gz3HoUdrQ
         D29b0CZVSbxhG1ECvNVcDzQ4oBI7aBN883fkTS94TbTQ5FIF5kW1jRSX1+yCPmZrbDCV
         FQ3TRwmebvmneNqtmtRLZ9DdUoCA8IL6ysVSa51xgPVagOFDJnXL4jGWfMObO6VXQlGZ
         uluBbR+7+EW/8+UIzPOqfNEBlETYCNILCCH3poNHQVqtZwfZ8ePsxwlOW7gD6lR2NGrh
         1cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dyoAvoyFg4jUJfdz4aKXhqjKtPxM6RS8h0KV2O9Y/lA=;
        b=MavjV+ri8iu3Y9/97D7AzmnqND16cBk95zOzOzzcn+i6E+FhYF0wsHqXHKq4t6bYfY
         dK3UO6DbUc1FZCWy2j9BtKtJJQK5ezTCHRLHrQe6RuZOKkvZjYj6E/NbTdGZ7NWkTo96
         Kzt29OZG/KxYzf6OxYM9iS9STrJjT4tclJhMJKg7OEvolyZ06jzuVG0Zy0QMqic6rUuz
         mjieFsG3zDKMsaGtJJWtT7l8+VrZ+8oeBAlPDJLbZwnurwbtVsbA+23snPFDXfrktkcn
         jiJJT+d9HYH+HC7Gm5411ibJ47OeCXF/IF/xwXWzE2sfXFdNi7Zzpsdz0z7EkMrqX5Hl
         2Qqw==
X-Gm-Message-State: ALQs6tBk4c+uJNCUxvXMFLrNXIAQOJ3KKlL9uC2tsSksfZrjbsCadxrt
        b7bx/G0KAWPrayKhLma+4jk=
X-Google-Smtp-Source: AB8JxZpc1ucS/djozZqZ6gB8Jyn9r0LRcgcNckcOSfC3vX5YhyJg5YGyvtJ85wowU0x83UTXyTBCaA==
X-Received: by 2002:a2e:5559:: with SMTP id j86-v6mr24511182ljb.147.1525715589824;
        Mon, 07 May 2018 10:53:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4376865ljk.83.2018.05.07.10.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 10:53:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v6 08/13] git: support --list-cmds=list-<category>
Date:   Mon,  7 May 2018 19:52:17 +0200
Message-Id: <20180507175222.12114-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180507175222.12114-1-pclouds@gmail.com>
References: <20180429181844.21325-1-pclouds@gmail.com>
 <20180507175222.12114-1-pclouds@gmail.com>
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
---
 generate-cmdlist.sh | 17 +++++++++++++++++
 git.c               |  7 +++++++
 help.c              | 23 +++++++++++++++++++++++
 help.h              |  2 ++
 4 files changed, 49 insertions(+)

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
index 3c032d01fc..67f3e20ae9 100644
--- a/git.c
+++ b/git.c
@@ -53,6 +53,13 @@ static int list_cmds(const char *spec)
 			list_all_main_cmds(&list);
 		else if (len == 6 && !strncmp(spec, "others", 6))
 			list_all_other_cmds(&list);
+		else if (len > 5 && !strncmp(spec, "list-", 5)) {
+			struct strbuf sb = STRBUF_INIT;
+
+			strbuf_add(&sb, spec + 5, len - 5);
+			list_cmds_by_category(&list, sb.buf);
+			strbuf_release(&sb);
+		}
 		else
 			die(_("unsupported command listing type '%s'"), spec);
 		spec += len;
diff --git a/help.c b/help.c
index d5ce9dfcbb..1117f7d1d1 100644
--- a/help.c
+++ b/help.c
@@ -329,6 +329,29 @@ void list_all_other_cmds(struct string_list *list)
 	clean_cmdnames(&other_cmds);
 }
 
+void list_cmds_by_category(struct string_list *list,
+			   const char *cat)
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
+			string_list_append(list, drop_prefix(cmd->name));
+	}
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 97e6c0965e..734bba32d3 100644
--- a/help.h
+++ b/help.h
@@ -21,6 +21,8 @@ static inline void mput_char(char c, unsigned int num)
 extern void list_common_cmds_help(void);
 extern void list_all_main_cmds(struct string_list *list);
 extern void list_all_other_cmds(struct string_list *list);
+extern void list_cmds_by_category(struct string_list *list,
+				  const char *category);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.705.g3525833791

