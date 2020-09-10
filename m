Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E27C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D0820770
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="VD1G7X0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgIJRYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgIJRWK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:22:10 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25050C061798
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:22:01 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id di5so3703198qvb.13
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oayVrQH3pQ2cdsPw+ZgD1w3Ks4FQKxxK6EmlqvxzQZo=;
        b=VD1G7X0pY3LLlvUTfhYkCjSNQXHWF3h+Zl1Ed3W2hLV+UmwCpwA3mloyx1aQ3OvUfe
         4wQ5M483sW8Kmm+6Ae+AUVtF7tDUfM096x4HgDjEO5fQdEONb0xu3sOBJPmTQvw0UJ+z
         GlgCRAC7Jzw7mDhshYGQ3PuNGTRJs8gZ76sxBIHcVRo27QS9agNDu/4XNrZnhY7OG3/Y
         zqlhi0GUgCc6m5dgYzBo8BH02SsoDe3nLaT7uh3Jp0nMyOnv5utbxIgUiFWWsHeWxgsM
         g15TovSFUiYuQXfcoJmggqlr4axNresXGUGs2qpfFJfynzmxpQXvyCV+c/0HznTkHOMo
         fEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oayVrQH3pQ2cdsPw+ZgD1w3Ks4FQKxxK6EmlqvxzQZo=;
        b=nPwtNhpVQoJN90V41q6R8IjSZGbfesgDsxc4CvUBIcZAmQnEK/KZ4ywE+6oI63gaxJ
         cJY/HUV9TFXXysCuB2GjRG3PQBGEdnCSYBjqKZ0DU6ete7ZQm1qwI2kgBA49DVlDWrQZ
         cJNQa5kSMvLHXxe+jgaidUTygoYrSXZIhk1cIDQr9I1ri/CnBnrKQzf9edzyL3iUHi9r
         gEbj+Ik4mj0BlS1P2bG40jVrQ2hD8mwpkFyzMmhKrKfHDxvsFun8Tk8J44bLTXaFcLvq
         nQnmkZre4vbOXonHWq9Gb81FscYl3sRGWi749Q2XewnYoQwsSBPVnVST/gAIB0U+z3t3
         q2Hw==
X-Gm-Message-State: AOAM532hAT0ZbVmYA4WgztDw5m7wHiFFmmI2OEE394X5nD5cn1k4xkCs
        Bbj5C9GDTHteARHx/Lid0oiaOrIKRVZGkA==
X-Google-Smtp-Source: ABdhPJwxsPZI4DQ0ej0eNRNFnDqflPbGj3UeR4Og/J45Z3ag90vCWus9xNfBFhGSKD9I45pphUbyXg==
X-Received: by 2002:a0c:b64f:: with SMTP id q15mr1764323qvf.27.1599758518889;
        Thu, 10 Sep 2020 10:21:58 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id h18sm7037437qkl.12.2020.09.10.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:21:58 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v6 6/9] config: make do_git_config_sequence receive a 'struct repository'
Date:   Thu, 10 Sep 2020 14:21:25 -0300
Message-Id: <f5c0fc33365414987ff1cbeb8d38f11ab99b3004.1599758167.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599758167.git.matheus.bernardino@usp.br>
References: <cover.1599758167.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

The following patch will fix a bug in do_git_config_sequence, which
makes it ignore worktree-specific configurations on submodules when
the_repository represents the superproject. To do so, the function will
need access to the 'struct repository' instance of the submodule. But it
currently only receives the 'git_dir' and 'commondir' paths through
'struct config_options'. So change the struct to hold a repository
pointer instead of the two strings, and adjust its users.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Hi, Jonathan. I just made a small change in this patch, in
read_early_repo(): when running some test cases in t0001, I noticed that
`the_early_repo.settings.initialized` was 0 even though the repo was
populated. So I added a flag to track the repo state for the later
cleanup.

 builtin/config.c |  6 ++----
 config.c         | 35 +++++++++++++++++++++--------------
 config.h         |  4 ++--
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 5e39f61885..ca4caedf33 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -699,10 +699,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_options.respect_includes = !given_config_source.file;
 	else
 		config_options.respect_includes = respect_includes_opt;
-	if (!nongit) {
-		config_options.commondir = get_git_common_dir();
-		config_options.git_dir = get_git_dir();
-	}
+	if (!nongit)
+		config_options.repo = the_repository;
 
 	if (end_nul) {
 		term = '\0';
diff --git a/config.c b/config.c
index 2bdff4457b..97f3022c92 100644
--- a/config.c
+++ b/config.c
@@ -222,8 +222,8 @@ static int include_by_gitdir(const struct config_options *opts,
 	const char *git_dir;
 	int already_tried_absolute = 0;
 
-	if (opts->git_dir)
-		git_dir = opts->git_dir;
+	if (opts->repo && opts->repo->gitdir)
+		git_dir = opts->repo->gitdir;
 	else
 		goto done;
 
@@ -1720,10 +1720,10 @@ static int do_git_config_sequence(const struct config_options *opts,
 	char *repo_config;
 	enum config_scope prev_parsing_scope = current_parsing_scope;
 
-	if (opts->commondir)
-		repo_config = mkpathdup("%s/config", opts->commondir);
-	else if (opts->git_dir)
-		BUG("git_dir without commondir");
+	if (opts->repo && opts->repo->commondir)
+		repo_config = mkpathdup("%s/config", opts->repo->commondir);
+	else if (opts->repo && opts->repo->gitdir)
+		BUG("gitdir without commondir");
 	else
 		repo_config = NULL;
 
@@ -1824,27 +1824,35 @@ void read_early_config(config_fn_t cb, void *data)
 	struct config_options opts = {0};
 	struct strbuf commondir = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
+	struct repository the_early_repo = {0};
+	int early_repo_initialized = 0;
 
 	opts.respect_includes = 1;
 
 	if (have_git_dir()) {
-		opts.commondir = get_git_common_dir();
-		opts.git_dir = get_git_dir();
+		opts.repo = the_repository;
 	/*
 	 * When setup_git_directory() was not yet asked to discover the
 	 * GIT_DIR, we ask discover_git_directory() to figure out whether there
 	 * is any repository config we should use (but unlike
-	 * setup_git_directory_gently(), no global state is changed, most
+	 * setup_git_directory_gently(), no global state is changed; most
 	 * notably, the current working directory is still the same after the
 	 * call).
+	 *
+	 * NEEDSWORK: There is some duplicate work between
+	 * discover_git_directory and repo_init. Update to use a variant of
+	 * repo_init that does its own repository discovery once available.
 	 */
-	} else if (!discover_git_directory(&commondir, &gitdir)) {
-		opts.commondir = commondir.buf;
-		opts.git_dir = gitdir.buf;
+	} else if (!discover_git_directory(&commondir, &gitdir) &&
+		   !repo_init(&the_early_repo, gitdir.buf, NULL)) {
+		opts.repo = &the_early_repo;
+		early_repo_initialized = 1;
 	}
 
 	config_with_options(cb, data, NULL, &opts);
 
+	if (early_repo_initialized)
+		repo_clear(&the_early_repo);
 	strbuf_release(&commondir);
 	strbuf_release(&gitdir);
 }
@@ -2097,8 +2105,7 @@ static void repo_read_config(struct repository *repo)
 	struct config_options opts = { 0 };
 
 	opts.respect_includes = 1;
-	opts.commondir = repo->commondir;
-	opts.git_dir = repo->gitdir;
+	opts.repo = repo;
 
 	if (!repo->config)
 		repo->config = xcalloc(1, sizeof(struct config_set));
diff --git a/config.h b/config.h
index 91cdfbfb41..e56293fb29 100644
--- a/config.h
+++ b/config.h
@@ -21,6 +21,7 @@
  */
 
 struct object_id;
+struct repository;
 
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
@@ -87,8 +88,7 @@ struct config_options {
 	unsigned int ignore_worktree : 1;
 	unsigned int ignore_cmdline : 1;
 	unsigned int system_gently : 1;
-	const char *commondir;
-	const char *git_dir;
+	struct repository *repo;
 	config_parser_event_fn_t event_fn;
 	void *event_fn_data;
 	enum config_error_action {
-- 
2.28.0

