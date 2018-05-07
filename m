Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32B72200B9
	for <e@80x24.org>; Mon,  7 May 2018 17:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeEGRxV (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 13:53:21 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43005 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752716AbeEGRxS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 13:53:18 -0400
Received: by mail-lf0-f68.google.com with SMTP id u21-v6so41885409lfu.9
        for <git@vger.kernel.org>; Mon, 07 May 2018 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8XtsGswM9WseEC3HVTJ52JmS1Z4cTZRDq5mFv16jtp0=;
        b=Y3ebuMzYKd/rId6ShQC0LDjZ94ZLQpnfXSxEr7aBEpmcO6eK7fwJikOhWphW4t6Qsn
         PnUwHjJKmYuKJVJVFx/w4cY9mv8R99SU/6i27SBYjPJ1rlT7bsTStyHNAaBryJYRgqOI
         slVdXyllnIX27nH3e5roM5NhASDQ2y5Fd4KFxAzC9YiA9ZoGVvhfVEDocOsqO2kYkQvT
         al9T2VmpIB+FGfty8J8oPp2G5ifEopC3AsTCFwXHBI98xpvnhPEtUCN/5K6PSdMUsf8I
         UDHTl3cSwWSVzipwX+JuwGTTNiikzOhaE81cXorw+TiEkTwOQ517k7Y3zM2GVWkpGImv
         sqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8XtsGswM9WseEC3HVTJ52JmS1Z4cTZRDq5mFv16jtp0=;
        b=UfC0tKCwVE1ptNx44MdZEUPvt1njFlqcBMFCZFW3iWRxmQ15Xllw+dVL2g+y5GEGaP
         LY2+M8IlkcCD22fTexNjKMeEAWiLzUjdC6Db9/EiTwlGF3zx/CuehgGFuaxy6b4z2xY5
         ukovBVgfvh6vTdAv6LQTh732qh9JFQiMDT7T1kMK8mYqDTCqKqexF0iRBDsnaBArRgSW
         VJqKatd3FU804zb8T9FaQw8euGSvTnLiV4Ti8Xlwz2FmUCLXsUg0VG58f6vqTHdd9ONz
         kFjEHuCqEIIFc8A7mgN/C2sA5AzHvA5NgAy3+8CIG+MC2fBl9Q5m4xW7IFYPeveLtK3G
         OxyA==
X-Gm-Message-State: ALQs6tC+8LUTOyjV+VWZ9LO7Y1ZcTjchuEabd9KsT7N+bJh3gOsMPdCA
        ce9hKR+n7/RPZrrFgqnJU+w=
X-Google-Smtp-Source: AB8JxZqt7slHV2AclUmuy8njkSCDr8q46vYsk+3ZhVJVKIj8NxK+jYoWNq59hJIybyHEgw2tK0KwZg==
X-Received: by 2002:a19:ee02:: with SMTP id g2-v6mr18551629lfb.52.1525715596440;
        Mon, 07 May 2018 10:53:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4376865ljk.83.2018.05.07.10.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 10:53:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v6 13/13] completion: allow to customize the completable command list
Date:   Mon,  7 May 2018 19:52:22 +0200
Message-Id: <20180507175222.12114-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180507175222.12114-1-pclouds@gmail.com>
References: <20180429181844.21325-1-pclouds@gmail.com>
 <20180507175222.12114-1-pclouds@gmail.com>
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
---
 contrib/completion/git-completion.bash | 35 ++++++++++++++++++++++++++
 git.c                                  |  2 ++
 help.c                                 | 33 ++++++++++++++++++++++++
 help.h                                 |  1 +
 4 files changed, 71 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 908692ea52..0fd29803d5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -38,6 +38,38 @@
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
+#     Or you could go with defaults add some extra commands specified
+#     in the configuration variable completion.commands [1] with
+#
+#         GIT_COMPLETION_CMD_GROUPS=mainporcelain,others,list-complete,config
+#
+#     Or go completely custom group with
+#
+#         GIT_COMPLETION_CMD_GROUPS=config
+#
+#     Or you could even play with other command categories found in
+#     command-list.txt.
+#
+#     [1] Note that completion.commands should not be per-repository
+#         since the command list is generated once and cached.
+#
+#         completion.commands could be used to exclude commands as
+#         well.  If a command in this list begins with '-', then it
+#         will be excluded from the list of commands gathered by the
+#         groups specified before "config" in
+#         $GIT_COMPLETION_CMD_GROUPS.
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -840,6 +872,9 @@ __git_commands () {
 		if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 		then
 			printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+		elif test -n "$GIT_COMPLETION_CMD_GROUPS"
+		then
+			git --list-cmds="$GIT_COMPLETION_CMD_GROUPS"
 		else
 			git --list-cmds=list-mainporcelain,others,list-complete
 		fi
diff --git a/git.c b/git.c
index 67f3e20ae9..fd08911e11 100644
--- a/git.c
+++ b/git.c
@@ -53,6 +53,8 @@ static int list_cmds(const char *spec)
 			list_all_main_cmds(&list);
 		else if (len == 6 && !strncmp(spec, "others", 6))
 			list_all_other_cmds(&list);
+		else if (len == 6 && !strncmp(spec, "config", 6))
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

