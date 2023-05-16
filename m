Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7DC7EE24
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjEPGe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjEPGeY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0682118
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso10664128f8f.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218861; x=1686810861;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/raonn5P8XNPOorE/zDwoE74Mq22nPtfuefiUhISLg=;
        b=mx+KKWOWOT/4q0fr6wGEkrj3xwYs3sug9w50bKDxuHWa66ebjQ0uIl5VPitqLUlE2B
         jRZxLJzax+dy9X2d5ETndtpZQnDnacJVEQkPoZ3zkqlImnr8NX/AdsVVGcpzU9ArfkS8
         jwep7hZuOyFT9BAvgf9IXhtCL1SFnmusu6qeYNDUJ1SMlxTK91N6oJSV9rRP1f/VL1mr
         tGFAts5SYdLONFagSuBB4nlehcWwrORXloOAHHrO/qUEWdXKpg9FM5YkKUnV+6Tp51bS
         WIxJyZLc2EcF4ZU/B9UdySekKCNMpuJ7VatGljnpPe+eJ8lqNqPm99cyE9Yer077RAH5
         EU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218861; x=1686810861;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/raonn5P8XNPOorE/zDwoE74Mq22nPtfuefiUhISLg=;
        b=ckNlgW0n+sm5ZAljTPuuN6fa+tAFD/do3c/zDFyd6xicqL/E6W9GI37gwnCWLwqzfv
         HRmEwW6P8jz2/4UGeispyk3OncWOq2XmKY9MouExUu4FkqJvJq+NexGmv6CIMw4YA4sG
         GfN3omKRwIYqK43Iml94EO7zHXyHD8zU4mTBmE11vAsSKeLuTQN6/Z1OIQkCrb3W9CS+
         GINb4Hb9nyBnisqE8PSRvVPkTV2DDQ5L7qbNrfs4LQsXuoBjdgDLPzdpINvRJHSwUl5h
         KGjgJKz3wmVZApzVre+rIN94tT7XlAUtdHpB9taw2DNjSOgWUnSM7aXH3/ZKa/Eskf33
         OsRg==
X-Gm-Message-State: AC+VfDygr1VEadwbDacpTfT1g71kWEkIK+msImnUQ1XhE2y459gxgUZM
        MuxHL78O2Bcc9RQrnYGO02qwJrT7ATo=
X-Google-Smtp-Source: ACHHUZ5Ba+4b8lfQKj+EOcFHH9SS3OmJZsoUxpgtptYfzQPodJ0G5W41aMyREr7vynH3Ifjx833HMA==
X-Received: by 2002:adf:ef4a:0:b0:306:44a9:76a0 with SMTP id c10-20020adfef4a000000b0030644a976a0mr27983292wrp.9.1684218860764;
        Mon, 15 May 2023 23:34:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14-20020adfe68e000000b00307b5376b2csm1356752wrm.90.2023.05.15.23.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:20 -0700 (PDT)
Message-Id: <28c8f4a29a88a63429ff6b7a28299f844251d00b.1684218851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:43 +0000
Subject: [PATCH v3 03/28] init-db, clone: change unnecessary global into
 passed parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Much like the parent commit, this commit was prompted by a desire to
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
index 32ab0a13e09..ae0122534aa 100644
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

