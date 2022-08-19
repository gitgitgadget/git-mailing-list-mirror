Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDB3C32796
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352891AbiHSQck (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353176AbiHSQbA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:31:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3852C11C944
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w19so9633075ejc.7
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=guXPjrBq1iq36CdjWz+sGJB6j5CEW9/djFYcbkeWqao=;
        b=gN5PRFBfTmLnvfLAPqyt+6YiUugwsnYsBkMDWBAzMouM15gthDDQ33c4IO5eKec0nr
         YgkxpnBHQdewCqHuW2s9eNIPQh8tn5tVJm+VzqIwt+sn1seE4rGhjuDbkAVaEYvwhdDx
         Hcr8RguGmcqhGvYdtikSPz5UzXSCoRws2rLATst7tQtWtJEr9ts15C60jmSWGteGibGN
         wa/IYHfC9J9a3gFqso7xV7BmqrsDu14o6CfBnIvb/skPM+M6WNBPNnbn4Jq90uS1IXDM
         sxz16z+cUkE4Cvxs2NuJ0VpBT08DrsQAINc8JVrre8EpFrXQC0U2JYXGYpLQ3QkUXwK9
         lhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=guXPjrBq1iq36CdjWz+sGJB6j5CEW9/djFYcbkeWqao=;
        b=q1/XQmiDrdTodZoCj/9vZe9hMYUON70V+KvzhqQ28ZCa+cqa2AIlPQ2q1qhBC6OjaN
         ZUewaPvgvQGLbTlEieKqjg6RmngEfCntCkLq8T7nXxDjo4FR2P9mQOuiBZGKwRtuEO2p
         YGn1/qFTbS6qFw3wd1iq47XDdFPIU0SBn8of4NRKoCIbODLmLm+Q0uF0mHR7uIAiRpER
         5x7NCnjDL7VifwYhU72vcB0qMDf18kKHzcQyeFLnSguSTj4u26D/ORN79BZf5CI9uIsp
         hq0v8O0RNmJgwuowDsn0O2hFxbPAAWVQoEGOFJXCiW2CRNlNvFAktY89q4iK0kQ8fUQq
         Haaw==
X-Gm-Message-State: ACgBeo3yZNlEQPEN4eLTtXWl2bDS+XrRs9rGDUq864l+7xniHMM7slqa
        Ht7LuAxdzhlzJTExoeQlUJj8E2xuLX8=
X-Google-Smtp-Source: AA6agR7x3P6xNjfYMd3JoT6Kr3BsR2LwLzqDTHR29cuxZrLfejjfx0y7t/eGepYE3Lwz5Yr3rKyCLQ==
X-Received: by 2002:a17:906:9b15:b0:73d:3943:d407 with SMTP id eo21-20020a1709069b1500b0073d3943d407mr1906407ejc.564.1660925100369;
        Fri, 19 Aug 2022 09:05:00 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id o18-20020aa7dd52000000b00445d98df225sm3269936edw.93.2022.08.19.09.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:59 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 15/20] builtin/notes.c: let parse-options parse subcommands
Date:   Fri, 19 Aug 2022 18:04:06 +0200
Message-Id: <20220819160411.1791200-16-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git notes' parses its subcommands with a long list of if-else if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
handling unknown subcommands, and listing subcommands for Bash
completion.  Make sure that the default operation mode doesn't accept
any arguments.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/notes.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index a3d0d15a22..42cbae4659 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -994,17 +994,31 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 
 int cmd_notes(int argc, const char **argv, const char *prefix)
 {
-	int result;
 	const char *override_notes_ref = NULL;
+	parse_opt_subcommand_fn *fn = list;
 	struct option options[] = {
 		OPT_STRING(0, "ref", &override_notes_ref, N_("notes-ref"),
 			   N_("use notes from <notes-ref>")),
+		OPT_SUBCOMMAND("list", &fn, list),
+		OPT_SUBCOMMAND("add", &fn, add),
+		OPT_SUBCOMMAND("copy", &fn, copy),
+		OPT_SUBCOMMAND("append", &fn, append_edit),
+		OPT_SUBCOMMAND("edit", &fn, append_edit),
+		OPT_SUBCOMMAND("show", &fn, show),
+		OPT_SUBCOMMAND("merge", &fn, merge),
+		OPT_SUBCOMMAND("remove", &fn, remove_cmd),
+		OPT_SUBCOMMAND("prune", &fn, prune),
+		OPT_SUBCOMMAND("get-ref", &fn, get_ref),
 		OPT_END()
 	};
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
+	if (fn == list && argc && strcmp(argv[0], "list")) {
+		error(_("unknown subcommand: %s"), argv[0]);
+		usage_with_options(git_notes_usage, options);
+	}
 
 	if (override_notes_ref) {
 		struct strbuf sb = STRBUF_INIT;
@@ -1014,28 +1028,5 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		strbuf_release(&sb);
 	}
 
-	if (argc < 1 || !strcmp(argv[0], "list"))
-		result = list(argc, argv, prefix);
-	else if (!strcmp(argv[0], "add"))
-		result = add(argc, argv, prefix);
-	else if (!strcmp(argv[0], "copy"))
-		result = copy(argc, argv, prefix);
-	else if (!strcmp(argv[0], "append") || !strcmp(argv[0], "edit"))
-		result = append_edit(argc, argv, prefix);
-	else if (!strcmp(argv[0], "show"))
-		result = show(argc, argv, prefix);
-	else if (!strcmp(argv[0], "merge"))
-		result = merge(argc, argv, prefix);
-	else if (!strcmp(argv[0], "remove"))
-		result = remove_cmd(argc, argv, prefix);
-	else if (!strcmp(argv[0], "prune"))
-		result = prune(argc, argv, prefix);
-	else if (!strcmp(argv[0], "get-ref"))
-		result = get_ref(argc, argv, prefix);
-	else {
-		result = error(_("unknown subcommand: %s"), argv[0]);
-		usage_with_options(git_notes_usage, options);
-	}
-
-	return result ? 1 : 0;
+	return !!fn(argc, argv, prefix);
 }
-- 
2.37.2.817.g36f84ce71d

