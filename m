Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF09C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiCCA6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiCCA6b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:31 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4D6151C46
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:57:45 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d4-20020a170902f14400b001518350e5c7so1885780plb.13
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UH8t/E0TczNz4tziesvMRSUOID+d/VyUA9f/OELjrWw=;
        b=hakUbMM+cMadRYNdZVhsifWNCoEoD4X/Vqc4hiS5PhGSfCGIAfKlkbuEClO2fumHJ1
         7WlT2AC4DyYj4F6O6be1xZThsqM3hEBdqjsuxoYWn8mocUWfDXV0HcNNqiOTlj3/XyY6
         ZN2bUrGz0UV49nIGrAmVuGD2ukz3qYa/WfJdOryZqUYAZ8dZOAyG27ETjdYcET0nt6+Z
         v+oQ31sTDiqdLYi9XwG5A8o+0cLczyiY79kpef9RiyFGUrELcGJvzhDfT3BRlgOdZYLQ
         /qwToMFaZOMya8EcO9bU6/z5oV4HetAURUQlyQAJSk1hMFSzvv9JxGiPFP9EYk5K0ixO
         qPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UH8t/E0TczNz4tziesvMRSUOID+d/VyUA9f/OELjrWw=;
        b=hNZ2O6l/sZjgsjKaZzB8c7xCJDCPijrBRnEMpsnbE3V3jzc1qwKrOMwvEzmB5tnXpj
         9yuwaWnlVwmNzI4MiR395TKjXPFxaD1aQqZjWSjkeQ90AcAmOEq74peklDALehMTyBlK
         4DL9HJhSVt0zoIcM8eJyg28QCxvplrpYnT0bxVUyqpBgrtmP0e8md1MgYDM2vdyzrQoS
         S3Ez9nqYrzWQX+ieFtvF/3s8fW1QAcshMzNTVbrlYHY0H05Aj4kKcUi5DQXTplIxneIW
         zzzNHUWHtyUMXO1GfrCJklCsEULXnQ37zQ4hBm0LBl9ppxdAcmQtdU6SuFu9i9wG6ZAB
         juAw==
X-Gm-Message-State: AOAM531psdU2p8/etJ3ZPTJhhT5+NugpspkMInOPtWvuz008tGGWgGSd
        /zbQ4SDfkB8a/5tgTa0wGprjp+6LreS45SGmLl4qvJpxt4QJZ2nGKCCqqx2oEX+dMW2//A4gJOH
        O1qWw2RIT7L3NtXiz5FLjQT/K0dOtMpfB5DZtZh4Rd2/PMd9ua7f5P0PL5g4kiis=
X-Google-Smtp-Source: ABdhPJxmNbrv5dciVl870l/zhtX5JFAKikINf8qog3gQwizcnwuAYr+5WVIcA5Ri4HRYVkzBu84wecws/ozGZw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:1203:0:b0:374:4ee8:8f20 with SMTP id
 h3-20020a631203000000b003744ee88f20mr27661641pgl.294.1646269065192; Wed, 02
 Mar 2022 16:57:45 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:16 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 02/13] submodule--helper: remove update-module-mode
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is dead code - it has not been used since c51f8f94e5
(submodule--helper: run update procedures from C, 2021-08-24).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index eeacefcc38..c11ee1ea2b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1957,29 +1957,6 @@ static void determine_submodule_update_strategy(struct repository *r,
 	free(key);
 }
 
-static int module_update_module_mode(int argc, const char **argv, const char *prefix)
-{
-	const char *path, *update = NULL;
-	int just_cloned;
-	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
-
-	if (argc < 3 || argc > 4)
-		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
-
-	just_cloned = git_config_int("just_cloned", argv[1]);
-	path = argv[2];
-
-	if (argc == 4)
-		update = argv[3];
-
-	determine_submodule_update_strategy(the_repository,
-					    just_cloned, path, update,
-					    &update_strategy);
-	fputs(submodule_strategy_to_string(&update_strategy), stdout);
-
-	return 0;
-}
-
 struct update_clone_data {
 	const struct submodule *sub;
 	struct object_id oid;
@@ -3430,7 +3407,6 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
-	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
-- 
2.33.GIT

