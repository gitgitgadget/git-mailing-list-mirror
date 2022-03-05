Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57797C4332F
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiCEAPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiCEAPp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:15:45 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48A924317C
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:14:56 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t18-20020a63dd12000000b00342725203b5so5279634pgg.16
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UH8t/E0TczNz4tziesvMRSUOID+d/VyUA9f/OELjrWw=;
        b=Men7xyLM44UuSxdBmFXksCEsl/dYMad4Qqt4Bz7uJ8m3AcXn6dSMrvCR9J4lZwNmby
         IqvA2rsDcfj36Q6AFxcElcrFXOsJ5oE4FmAH6kfqEsuFfEx6oQXTnTvYMsqGLJ+Xucl5
         03yJc9MREo3FgYrG7t6Xxbod7KKcyu0Z48kd4YFR9s2/8ziPhQa0fjJ8vEz6FbdqjcSL
         BFxxUhcE+ItM1/TPWwBhS8QHb2tQjJR4Io2S5M+9YwwyHAkH2f9UYrKPjCfx+M5uFcyk
         YqgtgVByPKw4MB1sl84vR4TlVZbRf6C9NxdQsnhxpGXVr4wO/lUrkeKcl0ktXPUI0RXV
         KM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UH8t/E0TczNz4tziesvMRSUOID+d/VyUA9f/OELjrWw=;
        b=sG4IqufscTsNvJeuIShZoDtNWzOIUt8OgTR9lbGJEWupvoR+Uv4WeRJGFktymS5ujm
         XCgUfezSi4n7zbI58sfMUN8Tw3R4vKcdTg8PQvf/fW1bj165kTiMHoMN0NxabW45fmBo
         1gqYXJKInOqfTbIecINQuOlDSKR5N54VRax8G8A/qYhLyC3gOQrObJobXzXe1MtQNNQZ
         pwhLfUSauY4Q2GQYWyPrvCektLw+cR1ORFZ6ivYjqkR77mRWlCxzPSHLQxprvpCXvzs/
         5IMWhdfoU3/Xt+AUfW/aop/V0eozuS0YvcN5jA1LbYaEHdNQdNRU2l6tx1Lr4HWG6L43
         WRqA==
X-Gm-Message-State: AOAM532TDOoeCJz2TMLbbXR4dtqRA+g/30XvEnmBiOs3t23KzQ6Ycvcs
        5dpSnkmaQTbXzqe3dPNm/6u/elRrZLcoYpXnvRlOzAf4jZ5zVJ7WiSlf1+V3Wsu8S2HhEdbQLtc
        7ziVqJfY7H2lWaFSLvvvJFJ5TRMO77UVHaQMGrcA627NF1RfR2Lwuh8rYP5p3qfg=
X-Google-Smtp-Source: ABdhPJw5bPaMRDUJh39NIPIDv0vsRJh8Hn3hWO4w2kd6W81rIE28y78C67nv0Mis0Tbqf2bkIdjpeJDSaQlZ+Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:22c1:b0:150:ca1:bfda with SMTP id
 y1-20020a17090322c100b001500ca1bfdamr869079plg.115.1646439296067; Fri, 04 Mar
 2022 16:14:56 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:50 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 02/13] submodule--helper: remove update-module-mode
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

