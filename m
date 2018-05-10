Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EBBF1F42D
	for <e@80x24.org>; Thu, 10 May 2018 08:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756916AbeEJIr1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 04:47:27 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35791 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756774AbeEJIrO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 04:47:14 -0400
Received: by mail-lf0-f66.google.com with SMTP id y72-v6so1835173lfd.2
        for <git@vger.kernel.org>; Thu, 10 May 2018 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9pYSUKkKI1VmOy0TozOlCRKHLqsYtl5iwlf2ImhMxc=;
        b=EAKf80WQV5EJY0N8RT9guzHfUJU814voUIyFtmN1/t4ZvmnWxnRsUWkMBvqiVlkosS
         07pyB9Ep8YExuj/fM9Mld5/2y7sc9c+kAjRJUAJISw7FXMJNoZHrZ2ntIDKJSNPtQZl7
         uCksHQEjpQmZIPXG3m9yBLl4DDI10ZnE4NV9QaJqNHzHsuIoUSWe01BGmcs9VF/e8uU/
         f8SkXBcteQT9sg1ZRvZWXSJDpsfF1UWtTbEQ75q5xKrOE0nFFdz+uuGXKfszYrQkajrI
         ZvD0s/S1VCnxraz8771/tI1WwvxOTqTMP7lscz8OaosYEon6bCKmzbB8VowtNm3NUxSA
         M8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9pYSUKkKI1VmOy0TozOlCRKHLqsYtl5iwlf2ImhMxc=;
        b=pxs7PGJOH1BITuArGb2OV0DTJP5JHpr1HhYtubs8Ar4hzzDy59EaOCQH6ubfblg1ye
         KcUrJTMKFwzbbsS+EwBNX48jcJZEmZNeUIkrwDMoZTEdR4BaeX1nRkzZvuSUgRSBnylc
         hedLbSr1tC+dGsXwnz8CWLxvj4OQE4sFpe+YirIBySxHlA4xwhqaPK029lssi7smAaZ0
         l9ej/92QqiHcA9J+DcpVqeAIAvmrp5oJhbTAKwBu59ML0FqI76c7NsYE/Hngm0URO1Wi
         MrXqIZGmZhQvfYuLEoJG3KcFnWtNqskaxaCYYrQYyWII8ZPDei3un/wIv61UrrBYqekN
         mGoQ==
X-Gm-Message-State: ALKqPwecjV1sp+o4HCE3vQ6RD8TwZR436Wr6AN6zPSbo92cFBq94yqNB
        dd2/CxPtlMWue/Ma3GNcgPQjuQ==
X-Google-Smtp-Source: AB8JxZoTutduA7y4r9asHi4UzTIeiTJUIpHyj9AZ1lUvEMzv6FqAq3qJFYYXAGOKKt7V7lq4+H+icA==
X-Received: by 2002:a2e:944d:: with SMTP id o13-v6mr504278ljh.65.1525942033155;
        Thu, 10 May 2018 01:47:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l24-v6sm68024lje.42.2018.05.10.01.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 01:47:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v7 13/13] completion: allow to customize the completable command list
Date:   Thu, 10 May 2018 10:46:52 +0200
Message-Id: <20180510084652.25880-14-pclouds@gmail.com>
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

By default we show porcelain, external commands and a couple others
that are also popular. If you are not happy with this list, you can
now customize it. See the big comment block for details.

PS. perhaps I should make aliases a group too, which makes it possible
to _not_ complete aliases by omitting this special group in
$GIT_COMPLETION_CMD_GROUPS

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt               | 10 ++++++++
 contrib/completion/git-completion.bash | 28 +++++++++++++++++++++-
 git.c                                  |  2 ++
 help.c                                 | 33 ++++++++++++++++++++++++++
 help.h                                 |  1 +
 5 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..91f7eaed7b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1343,6 +1343,16 @@ credential.<url>.*::
 credentialCache.ignoreSIGHUP::
 	Tell git-credential-cache--daemon to ignore SIGHUP, instead of quitting.
 
+completion.commands::
+	This is only used by git-completion.bash to add or remove
+	commands from the complete list. Normally only porcelain
+	commands and a few select others are in the complete list. You
+	can add more commands, separated by space, in this
+	variable. Prefixing the command with '-' will remove it from
+	the existing list.
++
+This variable should not be per-repository.
+
 include::diff-config.txt[]
 
 difftool.<tool>.path::
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 908692ea52..f7ca9a4d4f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -38,6 +38,29 @@
 #
 #     When set to "1", do not include "DWIM" suggestions in git-checkout
 #     completion (e.g., completing "foo" when "origin/foo" exists).
+#
+#   GIT_COMPLETION_CMD_GROUPS
+#
+#     When set, "git --list-cmds=$GIT_COMPLETION_CMD_GROUPS" will be
+#     used to get the list of completable commands. The default is
+#     "mainporcelain,others,list-complete" (in English: all porcelain
+#     commands and external ones are included. Certain non-porcelain
+#     commands are also marked for completion in command-list.txt).
+#     You could for example complete all commands with
+#
+#         GIT_COMPLETION_CMD_GROUPS=main,others
+#
+#     Or you could go with main porcelain only and extra commands in
+#     the configuration variable completion.commands with
+#
+#         GIT_COMPLETION_CMD_GROUPS=mainporcelain,config
+#
+#     Or go completely custom group with
+#
+#         GIT_COMPLETION_CMD_GROUPS=config
+#
+#     Or you could even play with other command categories found in
+#     command-list.txt.
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -840,8 +863,11 @@ __git_commands () {
 		if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 		then
 			printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+		elif test -n "$GIT_COMPLETION_CMD_GROUPS"
+		then
+			git --list-cmds="$GIT_COMPLETION_CMD_GROUPS"
 		else
-			git --list-cmds=list-mainporcelain,others,list-complete
+			git --list-cmds=list-mainporcelain,others,list-complete,config
 		fi
 		;;
 	all)
diff --git a/git.c b/git.c
index 4d5b8a9931..ea4feedd0b 100644
--- a/git.c
+++ b/git.c
@@ -60,6 +60,8 @@ static int list_cmds(const char *spec)
 			list_all_main_cmds(&list);
 		else if (match_token(spec, len, "others"))
 			list_all_other_cmds(&list);
+		else if (match_token(spec, len, "config"))
+			list_cmds_by_config(&list);
 		else if (len > 5 && !strncmp(spec, "list-", 5)) {
 			struct strbuf sb = STRBUF_INIT;
 
diff --git a/help.c b/help.c
index 23924dd300..abf87205b2 100644
--- a/help.c
+++ b/help.c
@@ -366,6 +366,39 @@ void list_cmds_by_category(struct string_list *list,
 	}
 }
 
+void list_cmds_by_config(struct string_list *list)
+{
+	const char *cmd_list;
+
+	/*
+	 * There's no actual repository setup at this point (and even
+	 * if there is, we don't really care; only global config
+	 * matters). If we accidentally set up a repository, it's ok
+	 * too since the caller (git --list-cmds=) should exit shortly
+	 * anyway.
+	 */
+	if (git_config_get_string_const("completion.commands", &cmd_list))
+		return;
+
+	string_list_sort(list);
+	string_list_remove_duplicates(list, 0);
+
+	while (*cmd_list) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *p = strchrnul(cmd_list, ' ');
+
+		strbuf_add(&sb, cmd_list, p - cmd_list);
+		if (*cmd_list == '-')
+			string_list_remove(list, cmd_list + 1, 0);
+		else
+			string_list_insert(list, sb.buf);
+		strbuf_release(&sb);
+		while (*p == ' ')
+			p++;
+		cmd_list = p;
+	}
+}
+
 void list_common_guides_help(void)
 {
 	struct category_description catdesc[] = {
diff --git a/help.h b/help.h
index b2293e99be..3b38292a1b 100644
--- a/help.h
+++ b/help.h
@@ -26,6 +26,7 @@ extern void list_all_main_cmds(struct string_list *list);
 extern void list_all_other_cmds(struct string_list *list);
 extern void list_cmds_by_category(struct string_list *list,
 				  const char *category);
+extern void list_cmds_by_config(struct string_list *list);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.705.g3525833791

