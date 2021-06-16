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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F156C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 23:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB3B6128C
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 23:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhFPXeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbhFPXeD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 19:34:03 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E85C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 16:31:56 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a193-20020a3766ca0000b02903a9be00d619so723128qkc.12
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 16:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6Lk6ikWJM0Q7F68ew9FIqRrwgphRtO5a9G9m7OlHA/E=;
        b=KLUL/5rjOAbXSHwTKiHaY3yMbhs/XUfU7z442IiE0awBrhQXdYIoxWjTLEPCCHX56M
         4JKGKbCq/cfKUdtN7VxD4Tvlg6O7f4kIdiHVyK1gJvLGWHc/pp94ywoqZh0Cg2vOzKYH
         XQkPomHrkF+fBretsadb6nnxjZspvMwLoZNy90RGh7bYhfoiGXlAPT9TM7RDrrJB/Nph
         OQuxmlI+6YVhHuw1BzGT3x3oYwZmfBxdd84c5/EiKt6F61dV41/2R322Cx6UfXTMfZkZ
         Y6pt/yjx9QaKC/itotiy7c/CjhENirOQZty/Y3Lk9EpCO2mSTlHqqsGq6v8mUY6+jAA+
         2QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6Lk6ikWJM0Q7F68ew9FIqRrwgphRtO5a9G9m7OlHA/E=;
        b=WH6jjRsuUG0CPqv8D3EkXEauz4W45mHu32f5wXpclHppuJWCFqW+E6vMDed8ZhL29z
         qx5OYzHe1L/2PhfiWyUccMyZWihCfYy0qPsl1iWJhJ42ROGl6cFzyRRB+nKlKApy7/R3
         J9I7q73lKlxYw0Et0GlKNg+oMSWVXvhIujnrUZquj6OVhe5fKM4ClY6r3VnZhXXh+rZs
         2LuKQsA7IYQA9wsL0mrL8XaOJkH2Uvu1kWmFvmK/ghmvMjpPJU2tT4WBcTXtxxXOYkuX
         +r0eMDXRVq8xHmb6JPCHHO5oJjvPe3VHEtfhNUzSzVRlvn+SX/n8yPQLl2Nppkxyv8DO
         mTRw==
X-Gm-Message-State: AOAM532J7wINMuoegIOza+4TsOhQDM3gXb1qrKYmpD4uS9nCJQevfprN
        aBmKHhSsjhO7sa9CjbHdN+/MCqF9t3LWy0Stg4Y9KF+UWJCmmTU8nskXQByOvJbnQW/XMpTAfTj
        yz+fcdkMy/NR7dkKEn712hNxgWj2DvhQqgSerOKYr6R9CWKyHPddWdWi2iroJLDwAXPhChLn9Ff
        Ek
X-Google-Smtp-Source: ABdhPJzRbGm3SjZk7vjtaK6GSsJMCVfCMUPzrbx7FH46ehkOTZh8WVRM+c28jWGAc2PKtmsg1F5zTK3tGgJdiwBvdPz0
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:11b4:: with SMTP id
 u20mr2712459qvv.4.1623886315465; Wed, 16 Jun 2021 16:31:55 -0700 (PDT)
Date:   Wed, 16 Jun 2021 16:31:48 -0700
In-Reply-To: <cover.1623881977.git.jonathantanmy@google.com>
Message-Id: <74ed668e9bbf56bb7898bcdfaaf77db4f3205fe5.1623881977.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1623881977.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [RFC PATCH 1/2] hook: move list of hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
2.32.0.272.g935e593368-goog

