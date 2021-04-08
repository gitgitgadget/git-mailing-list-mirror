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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D98C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35A261106
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhDHXkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXkD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:40:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F376CC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:39:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m189so2103198ybc.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zI0SqhYbUb6g6MYANPSTDMdq64nKDtUvZcfbFNdUUZQ=;
        b=aScs+l33pVfVY30tRk47JjUY+MA6NKMaXPtr2reiWiaKMiWHayq4Otlvy/Gz5IP9Ic
         g2nTdC27GmHNAqNWDhtYhyfIB+RmZZFlGwHe0UwYLAoZM3MDsuMFq2T87U91KbkJ8da/
         YBP4hDDj6wdKSnF8pv+lk2RcJ0LIcr0ozE54tXXBUsTtqPRiwWJcHylTf92zWtW1q0V+
         kPiz0e3r5Gl0ejgwB22AL+fVHIIYdrU4PEuKF4Z4T6dA2I/YjUZSdynQPLyerxlA6efM
         O6OnwtXAAO9AIL1dUX+2RcNSjGfu2DSgBo1Opc9eghjmOa627IatH4z1YW10pfIQLAIG
         EXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zI0SqhYbUb6g6MYANPSTDMdq64nKDtUvZcfbFNdUUZQ=;
        b=rUGDPcYiprMtVbZZj9sA0+Kkhxjt7JMiTLSj9loq7SdMTa8Kr9XKR7qXahVciT+7yE
         SM2QL7RpQ35nGi90e7roA7U3DmyBihglLpwEfqlbSPcYF+G3H0TiwVhJ5CohczdkHOk5
         mmlMdzQ4rapVkq56rRCDSAI5IOm4jBUCI6WeThLkZmorIxx3R0xs/7S0Hdm1avw+djYs
         J6iRZKETJg4FN/jRrQ11gi9ks1yb7BvBQ/qdCVOQaIiuy0UqG7sz9t1pQRjlFxWZtge1
         jUVC5DU4Hdhlm7eG9PRhPJxqnzJH9fNlTdGpIzbb75T9ZEYPGkByEF7pZ79hYebtG6ii
         CKzg==
X-Gm-Message-State: AOAM5337yvAMwWFvMLRgcZ2bLigbIn6sShNDwewoP7SkTJ9Kw5ZcygNp
        R3h6XmdA1bKJvuL3JpPPBl0xrNaMIajgLSYoxd2ibrE6RmxeOpWgH7h2Y06d8pgwtsz44iScIog
        oxMFQVv7WBts+HlLLMwGPJWc9GIfjPRGSB791Yoix30G9tvYOz0/ziXf7qaxnR9YDDtg2qLjaRw
        ==
X-Google-Smtp-Source: ABdhPJx0hPZuFWTwp8vMC8Q+dYxvtkVtv+V8h7qHepQddNGXiaKvEqRhhA4FJi+DopemNXCT954LINR+p5dirBEyISY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:34d1:6a8d:be3e:615f])
 (user=emilyshaffer job=sendgmr) by 2002:a25:1181:: with SMTP id
 123mr14822672ybr.374.1617925191162; Thu, 08 Apr 2021 16:39:51 -0700 (PDT)
Date:   Thu,  8 Apr 2021 16:39:35 -0700
In-Reply-To: <20210408233936.533342-1-emilyshaffer@google.com>
Message-Id: <20210408233936.533342-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210408233936.533342-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [RFC PATCH 1/2] config: rename "submodule" scope to "gitmodules"
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare for the addition of a new config scope which only applies to
submodule projects, disambiguate "CONFIG_SCOPE_SUBMODULES". This scope
refers to configs gathered from the .gitmodules file in the
superproject, so just call it "gitmodules."

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 config.c           | 4 ++--
 config.h           | 2 +-
 submodule-config.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 6428393a41..67d9bf2238 100644
--- a/config.c
+++ b/config.c
@@ -3513,8 +3513,8 @@ const char *config_scope_name(enum config_scope scope)
 		return "worktree";
 	case CONFIG_SCOPE_COMMAND:
 		return "command";
-	case CONFIG_SCOPE_SUBMODULE:
-		return "submodule";
+	case CONFIG_SCOPE_GITMODULES:
+		return "gitmodules";
 	default:
 		return "unknown";
 	}
diff --git a/config.h b/config.h
index 19a9adbaa9..535f5517b8 100644
--- a/config.h
+++ b/config.h
@@ -42,7 +42,7 @@ enum config_scope {
 	CONFIG_SCOPE_LOCAL,
 	CONFIG_SCOPE_WORKTREE,
 	CONFIG_SCOPE_COMMAND,
-	CONFIG_SCOPE_SUBMODULE,
+	CONFIG_SCOPE_GITMODULES,
 };
 const char *config_scope_name(enum config_scope scope);
 
diff --git a/submodule-config.c b/submodule-config.c
index f502505566..0e435e6fdd 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -637,7 +637,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 {
 	if (repo->worktree) {
 		struct git_config_source config_source = {
-			0, .scope = CONFIG_SCOPE_SUBMODULE
+			0, .scope = CONFIG_SCOPE_GITMODULES
 		};
 		const struct config_options opts = { 0 };
 		struct object_id oid;
-- 
2.31.1.295.g9ea45b61b8-goog

