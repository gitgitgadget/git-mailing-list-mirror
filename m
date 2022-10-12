Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA01C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 19:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJLTnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 15:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJLTnk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 15:43:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B51278237
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:43:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n9so5433997wms.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHVuQrO5iwiVKBXutVs01HTqA20+nXy6MiwTcIFp5kE=;
        b=YddIti0dGd0tBo0BpN8yxWUSUALGDHN0M0K3fTrAeaG1K0GNjGdFtBdzLNU/LmFSGu
         wDRXXuWgjannZEfengFG2RUgI6oG2TKKb9Qc1nUyTX7DQM53Bqq2A2RQCoTHLqDU+66M
         fFT+dPE6OvroJ9q9QqCW5bglED0MzZw5fTL2UJcyQwgjAr7j6ooBLO17zsBLUC4GAEn4
         0RbErbQP1mQW8Lh1qNm56AuiXVMRJxYbZpAuhmQkPmS25pK8U9lXnCT8j4Rhbxr4BU9W
         Cka8U7sJJN82dbptVkVeQpwcRu+1kUTK60Swx8fRxByw8OzDg4QivMMO2sB3HkdZYAuP
         jW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHVuQrO5iwiVKBXutVs01HTqA20+nXy6MiwTcIFp5kE=;
        b=5zv3oU+fLmjOXAMGcOTO89PQMhKWk8IHVzdZwUVUdtnpXX9+qmCdKumrKU57Q+XM9s
         QiuS8zaGbZcNoQgWVOjhusf203B8UJIS/GPMtakzmrUoXavR/9usajvaLqe9fRCClCYY
         WKRrE/34gRVmlCu1SZRVoHKtHi80PCeJRoQVfArGWW9rx4XyO+ZallawXZuighhn/EOB
         0Zu1/f9nLctKGQVeyQfoklCFbacYq5Tqoi3rwuAGfG7YH9cGBjZ8PwZe5d2lk3MlGHU8
         7CC3LGDRSAZEJqVN0ggmfdFg0AQvtUp+sI9wnFdbmOqlsjhU9rk0U5q7hgGxUruj+cG1
         M6JQ==
X-Gm-Message-State: ACrzQf1Bvp9XW2Xzbk1cQM4I4gpCFNM9PYUUuZvDP9Ns28lscWgyEqcu
        NmxhC1NAi4DEWoUgXguxOSnmo3tMrRs=
X-Google-Smtp-Source: AMsMyM7tTZb9JH6awdVxrCRgf1JX8rBKf0ImdLMYxey+CLBHHJiuyjj+WBOVjbXGI3cUDZLpMANK5g==
X-Received: by 2002:a05:600c:3590:b0:3c6:d9f0:9519 with SMTP id p16-20020a05600c359000b003c6d9f09519mr960671wmq.10.1665603817851;
        Wed, 12 Oct 2022 12:43:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18-20020adfefd2000000b00231a5fa1ae2sm453419wrp.20.2022.10.12.12.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:43:37 -0700 (PDT)
Message-Id: <0ff5b5741a519c63e65ef57d7d0b3148c38c1a52.1665603814.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 19:43:34 +0000
Subject: [PATCH 2/2] config: respect includes in protected config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Protected config is implemented by reading a fixed set of paths,
which ignores config [include]-s. Replace this implementation with a
call to config_with_options(), which handles [include]-s and saves us
from duplicating the logic of 1) identifying which paths to read and 2)
reading command line config.

As a result, git_configset_add_parameters() is unused, so remove it. It
was introduced alongside protected config in 5b3c650777 (config: learn
`git_protected_config()`, 2022-07-14) as a way to handle command line
config.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c                        | 30 ++++++++----------------------
 t/t0033-safe-directory.sh       |  2 +-
 t/t0035-safe-bare-repository.sh |  2 +-
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/config.c b/config.c
index cbb5a3bab74..c157fb5ae3f 100644
--- a/config.c
+++ b/config.c
@@ -2392,11 +2392,6 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
 	return git_config_from_file(config_set_callback, filename, cs);
 }
 
-int git_configset_add_parameters(struct config_set *cs)
-{
-	return git_config_from_parameters(config_set_callback, cs);
-}
-
 int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
 {
 	const struct string_list *values = NULL;
@@ -2641,24 +2636,15 @@ int repo_config_get_pathname(struct repository *repo,
 /* Read values into protected_config. */
 static void read_protected_config(void)
 {
-	char *xdg_config = NULL, *user_config = NULL, *system_config = NULL;
-
+	struct config_options opts = {
+		.respect_includes = 1,
+		.ignore_repo = 1,
+		.ignore_worktree = 1,
+		.system_gently = 1,
+	};
 	git_configset_init(&protected_config);
-
-	system_config = git_system_config();
-	git_global_config(&user_config, &xdg_config);
-
-	if (system_config)
-		git_configset_add_file(&protected_config, system_config);
-	if (xdg_config)
-		git_configset_add_file(&protected_config, xdg_config);
-	if (user_config)
-		git_configset_add_file(&protected_config, user_config);
-	git_configset_add_parameters(&protected_config);
-
-	free(system_config);
-	free(xdg_config);
-	free(user_config);
+	config_with_options(config_set_callback, &protected_config,
+			    NULL, &opts);
 }
 
 void git_protected_config(config_fn_t fn, void *data)
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 720d6cdd60b..dc3496897ab 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -71,7 +71,7 @@ test_expect_success 'safe.directory=*, but is reset' '
 	expect_rejected_dir
 '
 
-test_expect_failure 'safe.directory in included file' '
+test_expect_success 'safe.directory in included file' '
 	cat >gitconfig-include <<-EOF &&
 	[safe]
 		directory = "$(pwd)"
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
index aa6a6a8c3fd..fa33839704b 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -51,7 +51,7 @@ test_expect_success 'safe.bareRepository on the command line' '
 		-c safe.bareRepository=all
 '
 
-test_expect_failure 'safe.bareRepository in included file' '
+test_expect_success 'safe.bareRepository in included file' '
 	cat >gitconfig-include <<-EOF &&
 	[safe]
 		bareRepository = explicit
-- 
gitgitgadget
