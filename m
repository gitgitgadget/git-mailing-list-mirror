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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0907C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89404613E3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhGPSAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhGPSAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 14:00:44 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC589C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:57:48 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id l21-20020a056a0016d5b0290319e1ac27b1so7516238pfc.12
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XsazyeiOS9dVDyAonWX+lmXrUgxkI10dKFnmnIqCEQM=;
        b=eic97L0EDw5fYP99ZBkQ8gflgmxyRnclwu1ZA5yI5r41NL7xDxFm86RLhahl3+n/Ci
         6gO2wLQXC+VGJAl+I5Cn+KgKx23ggDMIBQwndlTAgnY0czMsXpftai2zMokdk1ud9MEk
         4qLYJgZwguAVWdP9gPQ3gRXgWdqfHJKHn+jT2ClFGsEwj/NxGBKwYIhNZnn4dwRGl1d9
         ub/FXq3Oy9rQWwYaJOCr+bMZz/v0+mb7D1AoOM3rr815q9OVOYJtyTUNGxrkstWrdyJN
         trEjcHCa9aj+pTp58Ms6eBplO65ZZxvC8lF06a38ClnZ7E7NcMLk6/Gg4Og/LdYiH3dy
         NwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XsazyeiOS9dVDyAonWX+lmXrUgxkI10dKFnmnIqCEQM=;
        b=rkfICDoRj/QzE6qlF5orbAAjFTz8OMF/JU5RRZsQ3IIwXb5aRjykX77zFtaE9DC3EW
         j8emg0mF413lKe62OnXjQyx8u6C53JShrhT6cI4fsZZGa0sO7f7t3T3liR+QMWe5pwu+
         AAhtxBQAtE6rb/f3SENGiIrotwnCZCm5rJ0PQ4q54n4E/I6W/IxDpsZ2Msbin2TnK7Cg
         YJ1Jqf2TiYrjNu2ggBILghBi1jwI2is18w8BhoM8UKae0HqhHB2huyKapa5ZVnKw7f0z
         tewUah/fWznaR33yq76/48gJ4lKcalwoAoWzE5qx9nOAbDlW7y1bsQAzo7ErEsI1J5Cl
         806Q==
X-Gm-Message-State: AOAM532W9b0GcjlCdNRuqBeTWtCIyOZflOk2x+P4ddvGMs/VA8CexmPg
        rb4UkkBsxi4+UxEV76c0ROwM5JEU1aed9j+cKtIHZqroEXoykB0u7LpfLKOBy0hzKJu2RW567EM
        kKx0Z9ksU6lpgW/vA8OfA3Zm8iwt22No0GFg9RSO19QFYlk54dUgMyBeTb60Kk8FVMv651ny/S3
        /7
X-Google-Smtp-Source: ABdhPJynsAsSOj8Odi7R1Kh+ZD/2reJdlQU72S6a7GGjKlLsM0wpJBGyF3qHv5UeCkI88BmKVRCKEPGfaLD1iUbl2k11
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:70c4:b029:129:45cd:aa90 with
 SMTP id l4-20020a17090270c4b029012945cdaa90mr8596947plt.43.1626458268077;
 Fri, 16 Jul 2021 10:57:48 -0700 (PDT)
Date:   Fri, 16 Jul 2021 10:57:40 -0700
In-Reply-To: <cover.1626453569.git.jonathantanmy@google.com>
Message-Id: <74ed668e9bbf56bb7898bcdfaaf77db4f3205fe5.1626453569.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1623881977.git.jonathantanmy@google.com> <cover.1626453569.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [RFC PATCH v2 1/2] hook: move list of hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, iankaz@google.com,
        sandals@crustytoothpaste.net, avarab@gmail.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The list of hooks will need to be used outside bugreport, so move it to
a central location.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/bugreport.c | 38 +++-----------------------------------
 hook.c              | 34 ++++++++++++++++++++++++++++++++++
 hook.h              |  3 +++
 3 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 190272ba70..4e0806dff3 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -41,38 +41,6 @@ static void get_system_info(struct strbuf *sys_info)
 
 static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 {
-	/*
-	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
-	 * so below is a transcription of `git help hooks`. Later, this should
-	 * be replaced with some programmatically generated list (generated from
-	 * doc or else taken from some library which tells us about all the
-	 * hooks)
-	 */
-	static const char *hook[] = {
-		"applypatch-msg",
-		"pre-applypatch",
-		"post-applypatch",
-		"pre-commit",
-		"pre-merge-commit",
-		"prepare-commit-msg",
-		"commit-msg",
-		"post-commit",
-		"pre-rebase",
-		"post-checkout",
-		"post-merge",
-		"pre-push",
-		"pre-receive",
-		"update",
-		"post-receive",
-		"post-update",
-		"push-to-checkout",
-		"pre-auto-gc",
-		"post-rewrite",
-		"sendemail-validate",
-		"fsmonitor-watchman",
-		"p4-pre-submit",
-		"post-index-change",
-	};
 	int i;
 
 	if (nongit) {
@@ -81,9 +49,9 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 		return;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(hook); i++)
-		if (hook_exists(hook[i], HOOKDIR_USE_CONFIG))
-			strbuf_addf(hook_info, "%s\n", hook[i]);
+	for (i = 0; i < hook_name_count; i++)
+		if (hook_exists(hook_name[i], HOOKDIR_USE_CONFIG))
+			strbuf_addf(hook_info, "%s\n", hook_name[i]);
 }
 
 static const char * const bugreport_usage[] = {
diff --git a/hook.c b/hook.c
index ff80e52edd..3ccacb72fa 100644
--- a/hook.c
+++ b/hook.c
@@ -5,6 +5,40 @@
 #include "run-command.h"
 #include "prompt.h"
 
+/*
+ * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
+ * so below is a transcription of `git help hooks`. Later, this should
+ * be replaced with some programmatically generated list (generated from
+ * doc or else taken from some library which tells us about all the
+ * hooks)
+ */
+const char *hook_name[] = {
+	"applypatch-msg",
+	"pre-applypatch",
+	"post-applypatch",
+	"pre-commit",
+	"pre-merge-commit",
+	"prepare-commit-msg",
+	"commit-msg",
+	"post-commit",
+	"pre-rebase",
+	"post-checkout",
+	"post-merge",
+	"pre-push",
+	"pre-receive",
+	"update",
+	"post-receive",
+	"post-update",
+	"push-to-checkout",
+	"pre-auto-gc",
+	"post-rewrite",
+	"sendemail-validate",
+	"fsmonitor-watchman",
+	"p4-pre-submit",
+	"post-index-change",
+};
+int hook_name_count = ARRAY_SIZE(hook_name);
+
 void free_hook(struct hook *ptr)
 {
 	if (ptr) {
diff --git a/hook.h b/hook.h
index f32189380a..d902166408 100644
--- a/hook.h
+++ b/hook.h
@@ -4,6 +4,9 @@
 #include "strvec.h"
 #include "run-command.h"
 
+extern const char *hook_name[];
+extern int hook_name_count;
+
 struct hook {
 	struct list_head list;
 	/*
-- 
2.32.0.402.g57bb445576-goog

