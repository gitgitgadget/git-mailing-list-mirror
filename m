Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE48C4332F
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 21:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhL1Vch (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhL1Vca (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 16:32:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B5FC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so10761207wmb.0
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kLiUVAAe9J6maUmPfcrZC7aWsX5ipUHzPINLlxkbOyM=;
        b=cUVTPE52J55ZUTbHHuc+nYh4qJCWvE2awPeek0Fx+Q7BDoJtKiqlhJXixhVhY3GO0E
         X/nWAqknXesG0UogJBhCHlCBS84V/PpAipxf77bRpqSufjh1kusMXAAUpLHPxgEWs9EC
         WMFaFMo/uL51VXsWsilQnzDrlwTaz9vZphe3zkRJyybqHrmzHrhKfjAGVkhD73Gm3BHq
         siKeJwArmk1PtlaXhtmicu5Rc5RqLYjO5aNOK0fo6SkP9yqg/JnfewV0gfMzxX4GV3jD
         W13xnW5VjwAjdbwzXZuZBiPBlygoE02XUuITo87sU5tqX1FbyXrB/MpGaGeeyyuq3n1m
         6gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kLiUVAAe9J6maUmPfcrZC7aWsX5ipUHzPINLlxkbOyM=;
        b=rLgmHoQRPehcIfbW/YDUJUcSGtYeiqz8D4fDfXlGcJK1oyU3ECzHEohj6VoDD3gZU7
         tqZLhaejmsO6/bUbYt/bzrBtQS8fTu1pOw8SFrwey9xE4DK0Fhg9QE8BKe9PiTkm5jZf
         XDmQTUUyJQgOmqcYhjz/4mT9bk2LhfRuMxaIrhVKNy/MemCnZwlzKzR191ZE4/WNVvNa
         vu7OPoM11fcdpTLHgQ1QFQlJIxsDHeVgwPZTwn2nPuahnaU//I+WH7PsXoP/9aSFlW5k
         /SCrpfO28mJVAhwHRpqus0qEskpK+/oc2K6M2QVNL82theRhNlW5BgF18M7VEAl76id7
         M9LA==
X-Gm-Message-State: AOAM532ZSnJFE6NCZexT8wYG5PPZKktYZB2OeG51ZbJTj/BppeY+Yxlm
        y00zO/G8bacSMEnT0CAkZUPt+Ec6JfM=
X-Google-Smtp-Source: ABdhPJy3xLdqbrZTfYUO6/bus8DRZW82Z2fTH6nu4pktnrrRKxgssuAG7noRUkD/80Wsp8KZ49KeWg==
X-Received: by 2002:a1c:8013:: with SMTP id b19mr18533858wmd.35.1640727148039;
        Tue, 28 Dec 2021 13:32:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm21806322wrq.116.2021.12.28.13.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:32:27 -0800 (PST)
Message-Id: <45316cd01c97285d2b8b22d117c4975209f8c3a5.1640727143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
        <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 21:32:21 +0000
Subject: [PATCH v3 4/6] config: add repo_config_set_worktree_gently()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Some config settings, such as those for sparse-checkout, are likely
intended to only apply to one worktree at a time. To make this write
easier, add a new config API method, repo_config_set_worktree_gently().

This method will attempt to write to the worktree-specific config, but
will instead write to the common config file if worktree config is not
enabled.  The next change will introduce a consumer of this method.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c | 21 +++++++++++++++++++++
 config.h |  8 ++++++++
 2 files changed, 29 insertions(+)

diff --git a/config.c b/config.c
index 9c9eef16018..f849aef253c 100644
--- a/config.c
+++ b/config.c
@@ -21,6 +21,7 @@
 #include "dir.h"
 #include "color.h"
 #include "refs.h"
+#include "worktree.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -2880,6 +2881,20 @@ int git_config_set_gently(const char *key, const char *value)
 	return git_config_set_multivar_gently(key, value, NULL, 0);
 }
 
+int repo_config_set_worktree_gently(struct repository *r,
+				    const char *key, const char *value)
+{
+	/* Only use worktree-specific config if it is is already enabled. */
+	if (repository_format_worktree_config) {
+		char *file = repo_git_path(r, "config.worktree");
+		int ret = git_config_set_multivar_in_file_gently(
+					file, key, value, NULL, 0);
+		free(file);
+		return ret;
+	}
+	return repo_config_set_gently(r, key, value);
+}
+
 void git_config_set(const char *key, const char *value)
 {
 	repo_config_set(the_repository, key, value);
@@ -3195,6 +3210,12 @@ int repo_config_set_multivar_gently(struct repository *r, const char *key,
 						      flags);
 }
 
+int repo_config_set_gently(struct repository *r,
+			   const char *key, const char *value)
+{
+	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
+}
+
 void git_config_set_multivar(const char *key, const char *value,
 			     const char *value_pattern, unsigned flags)
 {
diff --git a/config.h b/config.h
index 5531fc018e3..1386009fac8 100644
--- a/config.h
+++ b/config.h
@@ -253,6 +253,13 @@ void git_config_set_in_file(const char *, const char *, const char *);
 
 int git_config_set_gently(const char *, const char *);
 
+/**
+ * Write a config value that should apply to the current worktree. If
+ * extensions.worktreeConfig is enabled, then the write will happen in the
+ * current worktree's config. Otherwise, write to the common config file.
+ */
+int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
+
 /**
  * write config values to `.git/config`, takes a key/value pair as parameter.
  */
@@ -288,6 +295,7 @@ int git_config_set_multivar_gently(const char *, const char *, const char *, uns
 void git_config_set_multivar(const char *, const char *, const char *, unsigned);
 int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
 void repo_config_set_multivar(struct repository *, const char *, const char *, const char *, unsigned);
+int repo_config_set_gently(struct repository *, const char *, const char *);
 int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
 
 /**
-- 
gitgitgadget

