Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A820C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E5622AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgLVADu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgLVADt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:03:49 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02537C0611CB
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:43 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id l138so10174904qke.4
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TXJQA/b51PKKHbz3F5UC4bTZR/zxTZx2d/9xPC06otY=;
        b=mj3nf7vzVLZdGmxpNUzS564PUhPm5akLh/enNJ3yF8MLR8x3BhL805LMqdH6IkGcCz
         84eesLQwXzd3MZkEX8wA4rdS8OwC6QYuDNmdd2ps7Hulx9xMcd/tRjv+h9jIXegMba3a
         V6duwq94HNIF8zrMd3pJSoYUYml0n97RYD9gXQGD8rKRmDo2QbjMmvW6q5lbQQH1t40m
         VVLCogAAGel1k+v3B7e4X5ZXRLkPcXYbE5kpTb8GqNZ/SJVRYZ1uIr9okMQTN1A2ZTLH
         hBGejLmzgDBxa5/LRIKUV7oLqZZqC8TZ7KjIezaK6SwIE44b5SXACYxTt835PRpyCVxg
         q5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TXJQA/b51PKKHbz3F5UC4bTZR/zxTZx2d/9xPC06otY=;
        b=V2+EV7x6ER6UJtHy2XjJ/BHVVYmHqbZqUTR1VXtS/BAsQKUaT9Y4WA2rIsxG9Ylg5H
         h8jdEkBsbF5w/x7ZQn6VIUtXDEO4Dmqs02m626sOUFOKM9uwHUwxnxmiVJW8wODACdJT
         3hm9z3Un+CFpPdasodH0UHAUV08qYLWgHNXrg87xoXvyiTtXK6Ris8INKSHlm2HU/Mtb
         iy7jgXV16soPDtLe+mWI9FCWw4AkTgHcSD1IrITqSCCBdM8K0TevZCyfXW/nR6dJTnjU
         lQFHU3RDtDwFuz41BURsOK4M80N8ce2xxbn+alc2VL6Y5RkfTPoaH2wPyWfTExsZgvSl
         tHvg==
X-Gm-Message-State: AOAM530ir9B5V5l8N6rRnB1cbrSlPfb6sLXDOv00fN71PqWU+Wp8VN3p
        UuDI0qFLQvN3TyBXsWKVDB1UUUEq0yi+1DDzBtr0rIaG5QqF/PmQPd5zs0hL7t3cmJn6V6jB+9T
        rnxHtYqp/59R8wTxxQpWOIrGxHm6VU+dz9rshJ1lG+cMwbWGhTWzqOzeXVfp5R+pXX26DF9zEeQ
        ==
X-Google-Smtp-Source: ABdhPJzeCy4sHUz2FiaSXGX2n1UCsj9+fDIZzWCgQfbFmDNa0omaTbZNPdt7yCoeJrElRI7qhVRRIbQUs6QGbHFEI28=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:24:: with SMTP id
 b4mr19752680qvr.29.1608595362123; Mon, 21 Dec 2020 16:02:42 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:12 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 09/17] hook: replace find_hook() with hook_exists()
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper to easily determine whether any hooks exist for a given
hook event.

Many callers want to check whether some state could be modified by a
hook; that check should include the config-based hooks as well. Optimize
by checking the config directly. Since commands which execute hooks
might want to take args to replace 'hook.runHookDir', let
'hook_exists()' mirror the behavior of 'hook.runHookDir'.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/bugreport.c |  4 ++--
 hook.c              | 15 +++++++++++++++
 hook.h              |  9 +++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index ad3cc9c02f..2fe65d8f1e 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -3,7 +3,7 @@
 #include "strbuf.h"
 #include "help.h"
 #include "compat/compiler.h"
-#include "run-command.h"
+#include "hook.h"
 
 
 static void get_system_info(struct strbuf *sys_info)
@@ -82,7 +82,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(hook); i++)
-		if (find_hook(hook[i]))
+		if (hook_exists(hook[i], configured_hookdir_opt()))
 			strbuf_addf(hook_info, "%s\n", hook[i]);
 }
 
diff --git a/hook.c b/hook.c
index 5836bbb739..fbb69706d8 100644
--- a/hook.c
+++ b/hook.c
@@ -225,6 +225,21 @@ void run_hooks_opt_init(struct run_hooks_opt *o)
 	o->run_hookdir = configured_hookdir_opt();
 }
 
+int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
+{
+	const char *value = NULL; /* throwaway */
+	struct strbuf hook_key = STRBUF_INIT;
+
+	int could_run_hookdir = (should_run_hookdir == HOOKDIR_INTERACTIVE ||
+				should_run_hookdir == HOOKDIR_WARN ||
+				should_run_hookdir == HOOKDIR_YES)
+				&& !!find_hook(hookname);
+
+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
+
+	return (!git_config_get_value(hook_key.buf, &value)) || could_run_hookdir;
+}
+
 void run_hooks_opt_clear(struct run_hooks_opt *o)
 {
 	strvec_clear(&o->env);
diff --git a/hook.h b/hook.h
index 259662968f..762b6fadad 100644
--- a/hook.h
+++ b/hook.h
@@ -62,6 +62,15 @@ struct run_hooks_opt
 void run_hooks_opt_init(struct run_hooks_opt *o);
 void run_hooks_opt_clear(struct run_hooks_opt *o);
 
+/*
+ * Returns 1 if any hooks are specified in the config or if a hook exists in the
+ * hookdir. Typically, invoke hook_exsts() like:
+ *   hook_exists(hookname, configured_hookdir_opt());
+ * Like with run_hooks, if you take a --run-hookdir flag, reflect that
+ * user-specified behavior here instead.
+ */
+int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
+
 /*
  * Runs all hooks associated to the 'hookname' event in order. Each hook will be
  * passed 'env' and 'args'.
-- 
2.28.0.rc0.142.g3c755180ce-goog

