Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC8C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353149AbiHSQdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353209AbiHSQbE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:31:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450AC11D522
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c39so6232104edf.0
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5rkUZ+QtEmue+2DyttapUGVCH3vOg/IAKrGoW+q9m30=;
        b=OOl+Vpj5PJ6FQPD6Ba9P/tfGsbkNi18f7iuqdoquXlav0rwktFqcYagQx0JEalTPQ/
         n45N2Cc0NJUA2Fz6ZIatbKW2bYbAuX2ts78tHbbHeZHTRoHi8cjKYSnyi19VXrS2WUM+
         XlkGhsNNcPPFeQfCWEU9QuqJlVhzL8FmAZSSed8m623BnA+bEz3qGITGLNHY9uZkmGqa
         tioSUdxTmMFXIGooy4owzqah7sygExHGJssRD5btXD1Z3N3FnpSMNwW9+nMg+gAxfTUz
         imy1yK1My5EsXwHM3+fVZbAQ8WywwCJq/oI7eU+9VNW5wdrwioY7xMyv7t3GfFpVfYsC
         gMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5rkUZ+QtEmue+2DyttapUGVCH3vOg/IAKrGoW+q9m30=;
        b=vIRZe0up0+EETOZmaAQyNmDX1k84XTMv4JxowVJ3P3cZ1Uho8oRFAJEZt/wUp30Tdt
         GyVM3fJgKcUd/0upGTyD1rnGR5KN/ZDsLxe3hWuLEoFvbV8M48ncaXIr3XL99auch8AB
         9DUg99Wg2ESwbFd0lcp+V1y5TRS3/Wlx3UwEb3Q+9kGrsAfaBWpq/iE9gacHbAWc0iiV
         BOu4Nglk6IiUzurXrDu1nRlpj71hFk3raj7Bd+J18vySv6MJO0plm26gorWfkXvn9tF3
         34HhA3b98isMii9xOIYixR3PX1zZBTePHoRazIP2GBubAYmGy4TAdRbHwUzV1P/uh/XD
         HyzQ==
X-Gm-Message-State: ACgBeo0+nBfO1D6BdbL/54LZNBalWjqPNMfGKC2mQXzupBV6FgWbVGD5
        BQQtk00OLw9vsM5iWTLW4ANVs/TCjEc=
X-Google-Smtp-Source: AA6agR6XrVKqRULVg46uepaAms5afVcn0VBD+Sk8SkEZ8xDhdE8qZm54KjRJph0nv5qWmD8CBIMQkA==
X-Received: by 2002:a05:6402:4301:b0:43e:4d31:6ec0 with SMTP id m1-20020a056402430100b0043e4d316ec0mr6867692edc.69.1660925109122;
        Fri, 19 Aug 2022 09:05:09 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906304200b0073c37199b86sm2014675ejd.159.2022.08.19.09.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:05:08 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 20/20] builtin/worktree.c: let parse-options parse subcommands
Date:   Fri, 19 Aug 2022 18:04:11 +0200
Message-Id: <20220819160411.1791200-21-szeder.dev@gmail.com>
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

'git worktree' parses its subcommands with a long list of if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
handling missing or unknown subcommands, and listing subcommands for
Bash completion.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/worktree.c | 31 ++++++++++++-------------------
 git.c              |  2 +-
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index cd62eef240..c6710b2552 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1112,31 +1112,24 @@ static int repair(int ac, const char **av, const char *prefix)
 
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("add", &fn, add),
+		OPT_SUBCOMMAND("prune", &fn, prune),
+		OPT_SUBCOMMAND("list", &fn, list),
+		OPT_SUBCOMMAND("lock", &fn, lock_worktree),
+		OPT_SUBCOMMAND("unlock", &fn, unlock_worktree),
+		OPT_SUBCOMMAND("move", &fn, move_worktree),
+		OPT_SUBCOMMAND("remove", &fn, remove_worktree),
+		OPT_SUBCOMMAND("repair", &fn, repair),
 		OPT_END()
 	};
 
 	git_config(git_worktree_config, NULL);
 
-	if (ac < 2)
-		usage_with_options(worktree_usage, options);
 	if (!prefix)
 		prefix = "";
-	if (!strcmp(av[1], "add"))
-		return add(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "prune"))
-		return prune(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "list"))
-		return list(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "lock"))
-		return lock_worktree(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "unlock"))
-		return unlock_worktree(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "move"))
-		return move_worktree(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "remove"))
-		return remove_worktree(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "repair"))
-		return repair(ac - 1, av + 1, prefix);
-	usage_with_options(worktree_usage, options);
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	return fn(ac, av, prefix);
 }
diff --git a/git.c b/git.c
index 73ddf0f452..f52a955410 100644
--- a/git.c
+++ b/git.c
@@ -627,7 +627,7 @@ static struct cmd_struct commands[] = {
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 	{ "version", cmd_version },
 	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
-	{ "worktree", cmd_worktree, RUN_SETUP | NO_PARSEOPT },
+	{ "worktree", cmd_worktree, RUN_SETUP },
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
 };
 
-- 
2.37.2.817.g36f84ce71d

