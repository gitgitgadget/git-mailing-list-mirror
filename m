Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD2121F42D
	for <e@80x24.org>; Thu, 10 May 2018 08:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756934AbeEJIrm (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 04:47:42 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46175 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756860AbeEJIrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 04:47:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id x7-v6so1798874lff.13
        for <git@vger.kernel.org>; Thu, 10 May 2018 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPyBgE986HPj/Q1cLhkOnkKV9yi9tpYM8qsj5MPCqfY=;
        b=n3dmSb1XnrOm/MjRuMD3iqXdIBVjy68UeqXgmU0LP40bt3ZBy/8zTglhQaYb3rxcb0
         XH9Aq1+1QASDP42vc3kCu++Pe4YFI0vY16GdzE8JFTofw0iSZxgNU9Z4PhL6YUA7DO1/
         vsiKhfijgB5WV+oSz4XZHwAzuxu0ff/XNrGZot7LD0hGfkreytuk1qzEk00f2dEltDkM
         DZS8sNCO99oON8muUxcD5VhfY9g3Pe+1m33jQLLrKEDQwz2zoFOyxQFDtYpNoiXdpev0
         0H+YFyuMf4etz+AD1KwhlMeX9NrS46lyXCtzbIaRI5/yfRPFug3zpHXLeHldiy8rHyhU
         ZMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPyBgE986HPj/Q1cLhkOnkKV9yi9tpYM8qsj5MPCqfY=;
        b=mwPOXTEZiunCTrLlLlLWhDjh4aWvdnPC5zam+81cJOh9Djg5rOf8gEleRDj9Q1O29b
         ctzkEUO4f5HDVbx6tFNphEA+61yKWmPQiproYBIqxa4MchRnx8c620sKeMbLnfyn6VJF
         WpogA0FLp6SWn2qqefd+HvhM9Iwclf631lKjtvv1flKr+CY7JXgfrAZXjWgdDVLq9FqP
         Ke7s9pQZ4+Zz0LxuNTTHOsjISnpA3jDSgLGGL9RNK6L8AgF4h0WN5o6PBnS3hixLKnJD
         nrGhIwNClWnwmAFxaP1lO9mfb8CJ41kNjcOWz/kAW3HG85v95HQqFyDdUgcL/TTHXUKh
         C45A==
X-Gm-Message-State: ALKqPwe8EaaLrg0aoFaS6zhrffoYvKlQBXYBoNMK3jhNNJo/ltZWA4Qy
        4bMAR29HaJlWYe5c1SidRxA=
X-Google-Smtp-Source: AB8JxZqSpKjo8HVcS0YIrW2rLp1yVSZ2Ipf0/vKIyhN3V7ipntqgNIW3SyrStW1/Plev0D+dgUe4vg==
X-Received: by 2002:a2e:4152:: with SMTP id o79-v6mr520048lja.3.1525942027574;
        Thu, 10 May 2018 01:47:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l24-v6sm68024lje.42.2018.05.10.01.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 01:47:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v7 08/13] git: support --list-cmds=list-<category>
Date:   Thu, 10 May 2018 10:46:47 +0200
Message-Id: <20180510084652.25880-9-pclouds@gmail.com>
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
 help.c              | 23 +++++++++++++++++++++++
 help.h              |  2 ++
 4 files changed, 49 insertions(+)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 3bcc1ee57d..8d6d8b45ce 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -45,6 +45,21 @@ define_categories () {
 	test "$bit" -gt 32 && die "Urgh.. too many categories?"
 }
 
+define_category_names () {
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
 print_command_list () {
 	echo "static struct cmdname_help command_list[] = {"
 
@@ -70,4 +85,6 @@ struct cmdname_help {
 "
 define_categories "$1"
 echo
+define_category_names "$1"
+echo
 print_command_list "$1"
diff --git a/git.c b/git.c
index 10907f7266..4d5b8a9931 100644
--- a/git.c
+++ b/git.c
@@ -60,6 +60,13 @@ static int list_cmds(const char *spec)
 			list_all_main_cmds(&list);
 		else if (match_token(spec, len, "others"))
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

