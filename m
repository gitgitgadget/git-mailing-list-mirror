Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C086A1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbeKFEmS (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46529 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbeKFEmS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so485141ljh.13
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gXrum+GJ3eIOgPD9srO44Fn45fwUBNViXcYzKNm0QN4=;
        b=CZ55GCc3t1JBCXNuFVTIpE7Q1FyYa7LV1LruDPuvAoiK/++v6Gx97aSiwfwCF374kN
         /d8doHadG+cNahstTqeDeU9cEv6RzZNh6JwlzCGaSzMgXYQAFq+oyuvy0XMUo3IPnID6
         lNkmQNS994wdo697rOXJfXgBTb0O2fkZuTCHSScTKEyeapw3TD2QKqdnBBIalAqAwWnG
         CrPof+3PgNRP7OAhmX2QESCowk2k4D5+E7yKAzIqzxp//yEBQ7Oe4eKaYVm/Vlt32C4P
         ssGsSaDF1qKx/3AGfmPoUB4Wgcb19VOR9J/RwZrrmh6NUC0aRrDfH8Vp+pr2yP7Con05
         i+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gXrum+GJ3eIOgPD9srO44Fn45fwUBNViXcYzKNm0QN4=;
        b=CV7d8UTW3lBJ7iIK3JIPWiJMjB4pXejFHsSZSJDu6eRcbMD3u1WRKHUH39o6qnsYss
         gGI+satjMVVqjipAyNRTag2UhcoWAiQCRSwNZQEcpUIsCnBFvvmIIjrLoRFLHhgNk/EB
         LVlzuqDDDTBFOiHBoXkFdEBLWqo3dip+VFxBZ1RECiRw31hGIok0Nx3aVVxXQO0EUg70
         N6WdKjfKR1zMUjXqSD6QK6URXdE3oRoq1r+XjFQ2lfFcrrf/sMFcxuuiyllfjhcq9yf3
         ypCZC3vGlaGKDABK4oTc5V5H8CxPGh4YXEwZgaqLl+RMaWSuYqfNBhqH5G4PoEq+GQj2
         6lyQ==
X-Gm-Message-State: AGRZ1gIv4sFA4e9GqvOr8tjdVjwP3vpuGgXHLSi8WynXiqjIrje7+ciO
        G7LvpTa4ttpDHhi5tTy8ukQ=
X-Google-Smtp-Source: AJdET5cQDf4MxeevXVXxdxveUZe24RtaQRM/zd8B6y7N8rj2MHxxImycHdFYotC5tMfDu/+wV58bbA==
X-Received: by 2002:a2e:2b99:: with SMTP id r25-v6mr14812037ljr.91.1541445667947;
        Mon, 05 Nov 2018 11:21:07 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:07 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 02/16] alias.c: mark split_cmdline_strerror() strings for translation
Date:   Mon,  5 Nov 2018 20:20:45 +0100
Message-Id: <20181105192059.20303-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function can be part of translated messages. To make sure we
don't have a sentence with mixed languages, mark the strings for
translation, but only use translated strings in places we know we will
output translated strings.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 alias.c         | 4 ++--
 builtin/merge.c | 2 +-
 git.c           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/alias.c b/alias.c
index a7e4e57130..c471538020 100644
--- a/alias.c
+++ b/alias.c
@@ -47,8 +47,8 @@ void list_aliases(struct string_list *list)
 #define SPLIT_CMDLINE_BAD_ENDING 1
 #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
 static const char *split_cmdline_errors[] = {
-	"cmdline ends with \\",
-	"unclosed quote"
+	N_("cmdline ends with \\"),
+	N_("unclosed quote")
 };
 
 int split_cmdline(char *cmdline, const char ***argv)
diff --git a/builtin/merge.c b/builtin/merge.c
index 4aa6071598..92ba7e1c6d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -577,7 +577,7 @@ static void parse_branch_merge_options(char *bmo)
 	argc = split_cmdline(bmo, &argv);
 	if (argc < 0)
 		die(_("Bad branch.%s.mergeoptions string: %s"), branch,
-		    split_cmdline_strerror(argc));
+		    _(split_cmdline_strerror(argc)));
 	REALLOC_ARRAY(argv, argc + 2);
 	MOVE_ARRAY(argv + 1, argv, argc + 1);
 	argc++;
diff --git a/git.c b/git.c
index 5fd30da093..c7e122cfc1 100644
--- a/git.c
+++ b/git.c
@@ -344,7 +344,7 @@ static int handle_alias(int *argcp, const char ***argv)
 		count = split_cmdline(alias_string, &new_argv);
 		if (count < 0)
 			die(_("bad alias.%s string: %s"), alias_command,
-			    split_cmdline_strerror(count));
+			    _(split_cmdline_strerror(count)));
 		option_count = handle_options(&new_argv, &count, &envchanged);
 		if (envchanged)
 			die(_("alias '%s' changes environment variables.\n"
-- 
2.19.1.1005.gac84295441

