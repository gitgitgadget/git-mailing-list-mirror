Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB50CC77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbjELHEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbjELHEn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2960F7A84
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30644c18072so6393503f8f.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875080; x=1686467080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7mX6didPp0clB/isnJiLz8AyVdfIr4wHUlwIWNKhCY=;
        b=r9u/LgYX+5qTxTh+Nde5ha6nsRNkSx0E2JAQG/AvvWHo5DLxsKpZwOXHGnQgofiC1t
         vUifnosBAFMXIKTJoJrZSlnlf1iT9cYO726OXwO0XhJ5cJt5FNw1pMWbkm34iKIkxIE8
         c7se12WBKwQEriRYKp/ZZiqLtujLy/ZYFbMOcpi2gPmzTM5wW+i5YIcq+kY8zqjY2OPk
         CZH5rjsak9IJE5vDdO+STlK9RIZ+EZmR+/wd/9LuHG1Zkj7rGKvSVM0MBIryWndet6+g
         2oxnBlbDzRgHHxC8BlH6fnIgSI7/uHLs5i+9dCNGYKNewUtoG4yVXvvYiPN4pHqpgBmP
         Qsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875080; x=1686467080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7mX6didPp0clB/isnJiLz8AyVdfIr4wHUlwIWNKhCY=;
        b=P7qULM+sCcMaVK00jjEEAX6LxivG6ftzptUacpag/02CodFQesBIzHAilGtn3YrMRm
         z/duWovn+uPAsMaTg9yzpGS0RsPDHInteD7RCXVWMcLm3zyFTxN3wVQgjr2j2vNuXHlL
         pDvkOE9hUsl8OKU3emMMWNYeESNlnvYKog2P7qO4TIGRn+/evYZRbQ9OcFgxdqjLYnUB
         nWEz2H32hymJQy2ozezr5v56K4p/kDs9ZZeZFxuvvXXCYIsScs8uhQ/2GOumNBbkdcfh
         gykzoKpObZlcIzrcdVv3GVFdgP9BS/UxDxy4yG5PAH+m+l1bk10WmCPTFsF+V2K+X63M
         2kAw==
X-Gm-Message-State: AC+VfDwRQ21yBrGtsJQda+QaUBKujv4C9X5f4S+epMdjFDSMLn2aH+dU
        KJj/A0Vbx7Q98MOuCwW5KopxqAoXXIk=
X-Google-Smtp-Source: ACHHUZ5dJjTXyNKol7VcEA9jERBQ0rVosnUava1e14g4iwbRMX7L45dKTsDwd2wX8yiSGObth1PYKQ==
X-Received: by 2002:a5d:56c1:0:b0:307:a7a4:442 with SMTP id m1-20020a5d56c1000000b00307a7a40442mr8381931wrw.43.1683875080203;
        Fri, 12 May 2023 00:04:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14-20020a056000000e00b002ceacff44c7sm22552325wrx.83.2023.05.12.00.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:39 -0700 (PDT)
Message-Id: <3bc4dfeea901d9e57cee41666f85c783026d7e82.1683875070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:04 +0000
Subject: [PATCH v2 03/27] init-db, clone: change unnecessary global into
 passed parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Much like the former commit, this commit was prompted by a desire to
move the functions which builtin/init-db.c and builtin/clone.c share out
of the former file and into setup.c.  A secondary issue that made it
difficult was the init_shared_repository global variable; replace it
with a simple parameter that is passed to the relevant functions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clone.c   | 3 ++-
 builtin/init-db.c | 9 +++++----
 cache.h           | 3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 15f9912b4ca..cc34c194f5e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -930,6 +930,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int submodule_progress;
 	int filter_submodules = 0;
 	int hash_algo;
+	const int do_not_override_repo_unix_permissions = -1;
 
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -1097,7 +1098,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
-		INIT_DB_QUIET);
+		do_not_override_repo_unix_permissions, INIT_DB_QUIET);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 381801b9637..e9bbfa1e4ff 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -31,8 +31,6 @@
 
 #define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
 
-static int init_shared_repository = -1;
-
 static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 			     DIR *dir)
 {
@@ -199,6 +197,7 @@ static int create_default_files(const char *template_path,
 				const char *initial_branch,
 				const struct repository_format *fmt,
 				int prev_bare_repository,
+				int init_shared_repository,
 				int quiet)
 {
 	struct stat st1;
@@ -418,7 +417,7 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash, const char *initial_branch,
-	    unsigned int flags)
+	    int init_shared_repository, unsigned int flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
@@ -464,6 +463,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	reinit = create_default_files(template_dir, original_git_dir,
 				      initial_branch, &repo_fmt,
 				      prev_bare_repository,
+				      init_shared_repository,
 				      flags & INIT_DB_QUIET);
 	if (reinit && initial_branch)
 		warning(_("re-init: ignored --initial-branch=%s"),
@@ -575,6 +575,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *object_format = NULL;
 	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
+	int init_shared_repository = -1;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
 				N_("directory from which templates will be used")),
@@ -732,5 +733,5 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 
 	flags |= INIT_DB_EXIST_OK;
 	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
-		       initial_branch, flags);
+		       initial_branch, init_shared_repository, flags);
 }
diff --git a/cache.h b/cache.h
index bdedb87e83b..2bc1cd77d9b 100644
--- a/cache.h
+++ b/cache.h
@@ -327,7 +327,8 @@ extern struct index_state the_index;
 
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
-	    const char *initial_branch, unsigned int flags);
+	    const char *initial_branch, int init_shared_repository,
+	    unsigned int flags);
 void initialize_repository_version(int hash_algo, int reinit);
 
 /* Initialize and use the cache information */
-- 
gitgitgadget

