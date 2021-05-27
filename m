Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B18C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB37C6128D
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhE0ALu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhE0ALV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:21 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F8C06134E
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:40 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z93-20020a0ca5e60000b02901ec19d8ff47so2569216qvz.8
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wnCTag5HKGK8XoqlyYcgrX7r6UraKb8JZF3vVdV1iQQ=;
        b=fMO08spC8acMpqhB049c0oNKJhNBHktz9mXqeTIhhqbqgvPuI/MXtBRHOMeLh44anl
         u3aop3NpKrwfmzfJBOTU0a7OMlPjixCdViOHT0cyLA8bdO9oemGq5T8PIbtsxQM/iisG
         oavgyT1hzQwzR89E7o1V63KkicA6IwFoytdgBRyIFluydf8elSBUzZa387kUXJRsRg8B
         0RFebfNbUMzww7cU54P8uh+SLocpNQEvNeGppeZu3BDW+6YnKo6Z7B15MMQ7/hogh+Nw
         32By5I+VbI/wJgynjJZHAcIei5u4DcUtuv4YHGVYDreE2n2TjVddirvjiSHUNZqBidoD
         zbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wnCTag5HKGK8XoqlyYcgrX7r6UraKb8JZF3vVdV1iQQ=;
        b=NJUgN560gYLsYqvTQaXfg8wU3NOhrMaYrXUVYAcId2xgB1n5SjknWqL1k1Hwf+f3AL
         sz8e+0RUkzj4jcqEti68r+DOpOZOVlxpGJtyvkvnsOXsZ0uOn2ITjn1rbCVCA/lGVo1O
         ipH5e7Ls43J4xw5jSndkND22HgaqbPJ9yUgbZrreqdrzvY/nRUYHaxN+53OaxhYXSvPg
         tQYlbfambXvYmpPgvZNg6h5TUwM6bhoQ5UjBckBrk9hzxQQXmwWBQln/hv9OjX1fKJxW
         Zv6Hd72AsS+W2X+Vv3gfC7fYtgyNjO8goMjCwL9U5wRyZnat4UnYTjj6Hql6H+Pddl7w
         qEiQ==
X-Gm-Message-State: AOAM530PEZzeKt1MOUj2/yiEZEiu0dOkIxjl5t7JAyjLkv1q2w2UHn/t
        5qLG4cblEocc6yhJJ1M6f7I9W5Fg3QLUzR77BgIJCro2vpVHm5XtDQIbWnI33Dp/bBptONURVTT
        lF/PLAqX6+2i/xNc5bHKsl9sfDFqZexK2Q5p0tsU0Nz/4L04YOq1WcGylyXoRjEFWpXUE22fcoQ
        ==
X-Google-Smtp-Source: ABdhPJx1eIlrQOWIDUwY2RxHkIqpyajuIKUpzdMlvqOKMthpic00dg5avMNI46f/JZ+mGzPPxLM+ZxaomIxPNluGwwA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:4c45:: with SMTP id
 cs5mr571022qvb.6.1622074179837; Wed, 26 May 2021 17:09:39 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:39 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-21-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 20/37] gc: use hook library for pre-auto-gc hook
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the hook.h library instead of the run-command.h library to run
pre-auto-gc means that those hooks can be set up in config files, as
well as in the hookdir. pre-auto-gc is called only from builtin/gc.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt | 3 +++
 builtin/gc.c               | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index c904b160dc..d77170dafb 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -569,6 +569,9 @@ This hook is invoked by `git gc --auto` (see linkgit:git-gc[1]). It
 takes no parameter, and exiting with non-zero status from this script
 causes the `git gc --auto` to abort.
 
+Hooks run during 'pre-auto-gc' will be run in parallel, unless hook.jobs is
+configured to 1.
+
 post-rewrite
 ~~~~~~~~~~~~
 
diff --git a/builtin/gc.c b/builtin/gc.c
index f05d2f0a1a..16890b097c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -348,6 +349,8 @@ static void add_repack_incremental_option(void)
 
 static int need_to_gc(void)
 {
+	struct run_hooks_opt hook_opt;
+
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
 	 * automatic gc.
@@ -394,8 +397,12 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	run_hooks_opt_init_async(&hook_opt);
+	if (run_hooks("pre-auto-gc", &hook_opt)) {
+		run_hooks_opt_clear(&hook_opt);
 		return 0;
+	}
+	run_hooks_opt_clear(&hook_opt);
 	return 1;
 }
 
-- 
2.31.1.818.g46aad6cb9e-goog

