Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A81C77B7A
	for <git@archiver.kernel.org>; Fri, 26 May 2023 18:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbjEZSoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 14:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242793AbjEZSoK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 14:44:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968A5E78
        for <git@vger.kernel.org>; Fri, 26 May 2023 11:43:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f61530506aso11556325e9.1
        for <git@vger.kernel.org>; Fri, 26 May 2023 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685126621; x=1687718621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+7lfYXaVj9vgposw9D8127ONBcvsK6nZ8NayjNoJ7c=;
        b=PHHkAzrCjWtUGpc+ELMcCW8Tlq73kLWBqgEaQ1b8qfhj+IxhFco8Zzo8ZlQIS4EftY
         HCngU6rqMlr8uw8flnrEJ/R7KMNmV0Uv9WwpGxB1SK8ZdevF84nWDKy4ipCDNSt514QA
         ilKrtIA5QK729lzb6H0hWg5nkHzxO7z4CjkP7HE49k3SWop2AK7NvEfK5CLsnQsZ1aR+
         PLRAu+0nOKcPvd9dufGVl4PvXIcFycxgmyUO2btmN3i7SH7L+2ZrCg6R2C2IDIi8p4W8
         vcNdqYtU7iSvIErNMY670Ln0XUCtn7xHzFmQyVl9WyzdKOfGfS1kgcyXeUjkDeudZP2p
         ydEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126621; x=1687718621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+7lfYXaVj9vgposw9D8127ONBcvsK6nZ8NayjNoJ7c=;
        b=XquE9jpQs1d1Nt62d4aF2JG6HTKzW8rEX+C+/b9CvZ/vuL2wU+Soa0CszKv95ofrH6
         iYfGXaH7G05eRMzaeD3h1wqdRIIDRs6mVkI2EsVX/xm6Ch9iQJX7zcv3EXe6dDmtPzid
         jlXdxnkXnXiK3cgDIJ3SESMik/3YtvvxTvopEIiGFNiNeiccmE6C87lcxsZal0xtUNq3
         nIK6gL2LJSwUTNtReWJs8+KUgex2MnnW4yroRJFrLDYzyFlolvCzaMVL5RhytjUvmZxy
         mC9A1w6xB4iJldKUCKn36M8EE3dBickliQDKrROaItIu0DvkVpjynwX0wQLhURXZ/WhP
         RHZg==
X-Gm-Message-State: AC+VfDxFDpgSt7KhYgZbHeXRbO876zKp7pt8/FhVRGCyIkqGrI/QL3q2
        aVlOAsSOILGMt8NVKv2mHzXwbZnu1FM=
X-Google-Smtp-Source: ACHHUZ7U2NwWyeUns8qoWH2dv/sxe2WTaLuMALi7bVy12n9Z35KcpD2gnFn/F2l/vuwVpfUikMO4og==
X-Received: by 2002:a1c:6a03:0:b0:3f5:6e5:1689 with SMTP id f3-20020a1c6a03000000b003f506e51689mr2393356wmc.17.1685126621421;
        Fri, 26 May 2023 11:43:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c00c900b003f182a10106sm6026303wmm.8.2023.05.26.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:43:41 -0700 (PDT)
Message-Id: <481a81a515efb29bc4eb0b1a09b7d1df3f3c074b.1685126618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 May 2023 18:43:37 +0000
Subject: [PATCH 3/3] repository: create read_replace_refs setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, me@ttaylorr.com, newren@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'read_replace_refs' global specifies whether or not we should
respect the references of the form 'refs/replace/<oid>' to replace which
object we look up when asking for '<oid>'. This global has caused issues
when it is not initialized properly, such as in b6551feadfd (merge-tree:
load default git config, 2023-05-10).

To make this more robust, move its config-based initialization out of
git_default_config and into prepare_repo_settings(). This provides a
repository-scoped version of the 'read_replace_refs' global.

The global still has its purpose: it is disabled process-wide by the
GIT_NO_REPLACE_OBJECTS environment variable or by a call to
disable_replace_refs() in some specific Git commands.

Since we already encapsulated the use of the constant inside
replace_refs_enabled(), we can perform the initialization inside that
method, if necessary. This solves the problem of forgetting to check the
config, as we will check it before returning this value.

There is an interesting behavior change possible here: we now have a
repository-scoped understanding of this config value. Thus, if there was
a command that recurses into submodules and might follow replace refs,
then it would now respect the core.useReplaceRefs config value in each
repository.

Unfortunately, the existing processes that recurse into submodules do
not appear to follow object IDs to their contents, so this behavior
change is not visible in the current implementation. It is something
valuable for future behavior changes.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 config.c         |  5 -----
 replace-object.c | 13 +++++++++++--
 replace-object.h |  8 --------
 repo-settings.c  |  1 +
 repository.h     |  8 ++++++++
 5 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/config.c b/config.c
index 43b0d3fb573..d0ce902af39 100644
--- a/config.c
+++ b/config.c
@@ -1838,11 +1838,6 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.usereplacerefs")) {
-		read_replace_refs = git_config_bool(var, value);
-		return 0;
-	}
-
 	/* Add other config variables here and to Documentation/config.txt. */
 	return platform_core_config(var, value, cb);
 }
diff --git a/replace-object.c b/replace-object.c
index cf91c3ba456..c599729a281 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -64,7 +64,7 @@ void prepare_replace_object(struct repository *r)
  * replacement object's name (replaced recursively, if necessary).
  * The return value is either oid or a pointer to a
  * permanently-allocated value.  This function always respects replace
- * references, regardless of the value of read_replace_refs.
+ * references, regardless of the value of r->settings.read_replace_refs.
  */
 const struct object_id *do_lookup_replace_object(struct repository *r,
 						 const struct object_id *oid)
@@ -94,5 +94,14 @@ void disable_replace_refs(void)
 
 int replace_refs_enabled(struct repository *r)
 {
-	return read_replace_refs;
+	if (!read_replace_refs)
+		return 0;
+
+	if (r->gitdir) {
+		prepare_repo_settings(r);
+		return r->settings.read_replace_refs;
+	}
+
+	/* repository has no objects or refs. */
+	return 0;
 }
diff --git a/replace-object.h b/replace-object.h
index b141075023e..8813a75b96e 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -5,14 +5,6 @@
 #include "repository.h"
 #include "object-store.h"
 
-/*
- * Do replace refs need to be checked this run?  This variable is
- * initialized to true unless --no-replace-object is used or
- * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
- * commands that do not want replace references to be active.
- */
-extern int read_replace_refs;
-
 struct replace_object {
 	struct oidmap_entry original;
 	struct object_id replacement;
diff --git a/repo-settings.c b/repo-settings.c
index 1df0320bf33..5a7c990300d 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -68,6 +68,7 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "pack.usebitmapboundarytraversal",
 		      &r->settings.pack_use_bitmap_boundary_traversal,
 		      r->settings.pack_use_bitmap_boundary_traversal);
+	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repository.h b/repository.h
index c42f7ab6bdc..13fefa540bc 100644
--- a/repository.h
+++ b/repository.h
@@ -39,6 +39,14 @@ struct repo_settings {
 	int pack_read_reverse_index;
 	int pack_use_bitmap_boundary_traversal;
 
+	/*
+	 * Do replace refs need to be checked this run?  This variable is
+	 * initialized to true unless --no-replace-object is used or
+	 * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
+	 * commands that do not want replace references to be active.
+	 */
+	int read_replace_refs;
+
 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
 
 	int index_version;
-- 
gitgitgadget
