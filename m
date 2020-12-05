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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87474C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6129622DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgLEBrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEBrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:47:42 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28982C08E85E
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:32 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id l15so6390665qvu.8
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0i3Af1xw3+WpEJSag78xE+ks79Awiuaj9JxLRcxb80c=;
        b=JuR8agcc7UWswzxfKJUAgwNRV+fF8tEPvSfwozCP0ql1xCEpWnLpSuC3H4/Ne2utBH
         XyagHdoLLpfH+LlszqqWnCoMmU77B2SP3XV8pD7Zn0kGvL2J3vzNeif0mXq36f9lm6oL
         8qI/eM7Xg+io20K81YdPa0p0GadpcrVkMShLVD5Q5+N34P0PpKFaGHvSf5r0GgDr02Zq
         aDzIPaEjrJhjPS2bk/91w2xjSnkCDBu6w0MUt7uM1Gu59YzlShp1DW4L7HxA06h8OzDs
         UaR3v33dlwqx+Bys+TmDOVK+moe3nAQiZnyW4yPoFXL1uP3Po9KgNCcZMG6dByZTZgJn
         gZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0i3Af1xw3+WpEJSag78xE+ks79Awiuaj9JxLRcxb80c=;
        b=RfjKy61N8/E34Bfk2ty0Oj7JBhNgLOE4AyCx249NhZQr3y5H4mpVYZ+AMLtxNHE3kf
         Rg2fuCTnTzHv4OBcD6uh8Bu0PNeHcJ24+G+tqsjBtl/jm9rkjF4xN75mjbJaPbjnQvgL
         F4tyvP82EngXvP7IQjjkeSaY70h33T6aOYKRIP+9oZuZflYbrHxWl15c/CMrM9KUXlnJ
         rxOdhurZg211dBNvwtQWIpcsN5EpjwgLyE9H1IZVXgduBWFEQ85lup/Pii5pxXeHa36e
         EupOKT/mjZhq8TBHBGzjq7AQC27NBd/xi9lhmYTV9dHZRT8mGbG0vKDN6WHEaQ2tKmtr
         xB9w==
X-Gm-Message-State: AOAM532nfqrlMXJPy4bOO241DOgKt+7JbT3MLNas/kd7UG66g+b/iRre
        KyBKNlC5hDnjObyGfOnusMF0+ewkpbqbegEriCcKUf8EjxGYqLVTwqDsNZkMOA0KQaoHgXuWMpf
        EPgX1Pb88s0pe52UwPVmrV0RtoEExr5A91lcC3j0KeWvPc0+JP2cAoNckF2zOj58Hfe1sKB81mw
        ==
X-Google-Smtp-Source: ABdhPJzeZ45C28B0WHbAjjT15JI2nnT+NXd2ClL8BFEHbijJME4qjdygKlb8G8y9pFjh1zpEVS7XERju5EshnpKu75M=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:55c2:: with SMTP id
 bt2mr9233080qvb.48.1607132791319; Fri, 04 Dec 2020 17:46:31 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:45:59 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 09/17] hook: replace find_hook() with hook_exists()
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

Notes:
    Since v4, updated this commit to include bugreport as a builtin instead of
    as a standalone.
    
    Since v4, a little more nuance when deciding whether a hookdir hook can happen.

 builtin/bugreport.c |  4 ++--
 hook.c              | 15 +++++++++++++++
 hook.h              |  9 +++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 3ad4b9b62e..11043f4a22 100644
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
index c4595a2324..a7a4abdcac 100644
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
+	int could_run_hookdir = (should_run_hookdir == hookdir_interactive ||
+				should_run_hookdir == hookdir_warn ||
+				should_run_hookdir == hookdir_yes)
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
index d1c3d71e82..94a25c7cd0 100644
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

