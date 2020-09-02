Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70840C433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4482820773
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8w4QkeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIBUP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIBUP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 16:15:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758EC061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 13:15:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so235205pgm.7
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hep/fdJYrH4VrAQjpWEG2fcuBHMgrybQ+Tf6vSgl/A4=;
        b=R8w4QkeLD/HcVbKGvoIV0a1RH8pgI9kFSWSwq39T4xMgoE9oqeqouiZgbMydcTefqE
         qb7p4sLWpaXbFWpioGALm4PPGTXLHnpjkh5fBDLPDsYsJs0+LBNDQid1B9d0iQ0usaCg
         eLqxfaYbptVMkCJvHMuQCj/1r6Xq9R3alCRLN6FSz5zr0VuR7ZzEjxQEpZ84gHUtTdXO
         vFk8euh8RmHe5TRBTaubRGpMh4xNOoOWRYXSIKRcR2bNgHxvXe0jbPGidgIb4FKTiIIp
         0drTmE/gvjop/+od8E2qtjmv/KF25E3RjoKz8+qyllQeVLOeyhlZ6mKqNunq7WsYd/JE
         WSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hep/fdJYrH4VrAQjpWEG2fcuBHMgrybQ+Tf6vSgl/A4=;
        b=hd6IsPgIxk+oTKq3JBxaMOk/T0q/cPXyDCTZVjsOPnml+qe3Twik/43AUKyh7St5rL
         Nx4yw+gk5YdxDnqnaxH+zFBTTGBLi5ouSOnLD2FJAiDxkwkW/DVgUU4UqohB1TNfMgWq
         ov4Cxuv4uq6St2qDkMa7m9aDxZksqOoBzp1HZtZCeiVLMmz+WXEADh9s1jak68h4v35h
         Aq4iLkUriUOmDhwZKjDPQs+0yyjUasZzASq6lXVhjtP6ZV59Es940fvliCt2a5zvMwpX
         HoSJpKv/LniexLyxHWcumaWu/VYcrKNe0Ia5FFlQY08hBoxX2emIekwunF7gPTqVntuL
         hRaA==
X-Gm-Message-State: AOAM533gQOfzNxRJPNlsOyevfscb6WdiYnsFhA6/ipOSi5sE1xxRbpJ9
        5Zk9vbpMVO9oXKJD2Cdy4hk=
X-Google-Smtp-Source: ABdhPJxZ36jMyEB/lHks+hyu31vLhQIs3zoDmqPHMr8zCk0acrN+ONsOPzilum1Qpnsgy2GaKDFQdA==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr165363pll.74.1599077726159;
        Wed, 02 Sep 2020 13:15:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id a13sm255022pjq.36.2020.09.02.13.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 13:15:25 -0700 (PDT)
Date:   Wed, 2 Sep 2020 13:15:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        newren@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 6/8] config: correctly read worktree configs in
 submodules
Message-ID: <20200902201523.GA3941032@google.com>
References: <cover.1599026986.git.matheus.bernardino@usp.br>
 <3e02e1bd248438e0b435a19d857432edcaa15a2c.1599026986.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e02e1bd248438e0b435a19d857432edcaa15a2c.1599026986.git.matheus.bernardino@usp.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares wrote:

> The config machinery is not able to read worktree configs from a
> submodule in a process where the_repository represents the superproject.

... where the_repository represents the superproject and
extensions.worktreeConfig is not set there, right?

> Furthermore, when extensions.worktreeConfig is set on the superproject,
> querying for a worktree config in a submodule will, instead, return
> the value set at the superproject.
>
> The problem resides in do_git_config_sequence(). Although the function
> receives a git_dir string, it uses the_repository->git_dir when making

This part of the commit message seems to be rephrasing what the patch
says; for that kind of thing, it seems better to let the patch speak
for itself.  Can we describe what is happening at a higher level (in
other words the intent instead of the details of how that is
manifested in code)?  For example,

 The relevant code is in do_git_config_sequence. Although it is designed
 to act on an arbitrary repository, specified by the passed-in git_dir
 string, it accidentally depends on the_repository in two places:

 - it reads the global variable `repository_format_worktree_config`,
   which is set based on the content of the_repository, to determine
   whether extensions.worktreeConfig is set

 - it uses the git_pathdup helper to find the config.worktree file,
   instead of making a path using the passed-in git_dir falue

 Sever these dependencies.

[...]
> --- a/config.c
> +++ b/config.c
> @@ -1747,11 +1747,22 @@ static int do_git_config_sequence(const struct config_options *opts,
>  		ret += git_config_from_file(fn, repo_config, data);
>  
>  	current_parsing_scope = CONFIG_SCOPE_WORKTREE;
> -	if (!opts->ignore_worktree && repository_format_worktree_config) {
> +	if (!opts->ignore_worktree && repo_config && opts->git_dir) {

repo_config is non-NULL if and only if commondir is non-NULL and
commondir is always non-NUlL if git_dir is non-NULL (as checked higher
in the function), right?  I think that means this condition could be
written more simply as

	if (!opts->ignore_worktree && opts->git_dir) {

which I think should be easier for the reader to understand.

> +		struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		read_repository_format(&repo_fmt, repo_config);
> +
> +		if (!verify_repository_format(&repo_fmt, &buf) &&
> +		    repo_fmt.worktree_config) {

In the common case where we are acting on the_repository, this add
extra complexity and slows the routine down.

Would passing in the 'struct repository *' to allow distinguishing
that case help?  Something like this:

diff --git i/builtin/config.c w/builtin/config.c
index 5e39f618854..ca4caedf33a 100644
--- i/builtin/config.c
+++ w/builtin/config.c
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
diff --git i/config.c w/config.c
index 2bdff4457be..70a1dd0ad3f 100644
--- i/config.c
+++ w/config.c
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
 
@@ -1824,27 +1824,33 @@ void read_early_config(config_fn_t cb, void *data)
 	struct config_options opts = {0};
 	struct strbuf commondir = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
+	struct repository the_early_repo = {0};
 
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
+	 * discover_git_directory and repo_init.  Update to use a variant of
+	 * repo_init that does its own repository discovery once available.
 	 */
 	} else if (!discover_git_directory(&commondir, &gitdir)) {
-		opts.commondir = commondir.buf;
-		opts.git_dir = gitdir.buf;
+		repo_init(&the_early_repo, gitdir.buf, NULL);
+		opts.repo = &the_early_repo;
 	}
 
 	config_with_options(cb, data, NULL, &opts);
 
+	if (the_early_repo.settings.initialized)
+		repo_clear(&the_early_repo);
 	strbuf_release(&commondir);
 	strbuf_release(&gitdir);
 }
@@ -2097,8 +2103,7 @@ static void repo_read_config(struct repository *repo)
 	struct config_options opts = { 0 };
 
 	opts.respect_includes = 1;
-	opts.commondir = repo->commondir;
-	opts.git_dir = repo->gitdir;
+	opts.repo = repo;
 
 	if (!repo->config)
 		repo->config = xcalloc(1, sizeof(struct config_set));
diff --git i/config.h w/config.h
index 91cdfbfb414..e56293fb29f 100644
--- i/config.h
+++ w/config.h
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
==== >8 ====

[...]
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
[...]
> @@ -72,14 +80,34 @@ static int early_config_cb(const char *var, const char *value, void *vdata)
>  #define TC_VALUE_NOT_FOUND 1
>  #define TC_CONFIG_FILE_ERROR 2
>  
> +static const char *test_config_usage[] = {
> +	"test-tool config [--submodule=<path>] <cmd> [<args>]",
> +	NULL
> +};
> +
>  int cmd__config(int argc, const char **argv)
>  {
>  	int i, val, ret = 0;
>  	const char *v;
>  	const struct string_list *strptr;
>  	struct config_set cs;
> +	struct repository subrepo, *repo = the_repository;
> +	const char *subrepo_path = NULL;
> +
> +	struct option options[] = {
> +		OPT_STRING(0, "submodule", &subrepo_path, "path",
> +			   "run <cmd> on the submodule at <path>"),
> +		OPT_END()
> +	};

Nice.

> +
> +	argc = parse_options(argc, argv, NULL, options, test_config_usage,
> +			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_STOP_AT_NON_OPTION);
> +	if (argc < 2)
> +		die("Please, provide a command name on the command-line");

optional nit: can use usage_with_options here.  It produces a better
error message than any other I can think of (all I can think of are
things like "need a <cmd>").

This is from existing code, but the use of parse_options opens up the
possibility of taking advantage of the parse-options generated message. :)

[...]
> --- a/t/t2404-worktree-config.sh
> +++ b/t/t2404-worktree-config.sh
> @@ -78,4 +78,20 @@ test_expect_success 'config.worktree no longer read without extension' '
>  	test_cmp_config -c wt2 shared this.is
>  '
>  
> +test_expect_success 'correctly read config.worktree from submodules' '
> +	test_unconfig extensions.worktreeconfig &&
> +	git init sub &&
> +	(
> +		cd sub &&
> +		test_commit a &&
> +		git config extensions.worktreeconfig true &&
> +		git config --worktree wtconfig.sub test-value
> +	) &&
> +	git submodule add ./sub &&
> +	git commit -m "add sub" &&
> +	echo test-value >expect &&
> +	test-tool config --submodule=sub get_value wtconfig.sub >actual &&
> +	test_cmp expect actual
> +'

Lovely.

Summary: I like the direction this change goes in.

I think we can do it without repeating repository format discovery in
the the_repository case and without duplicating repository format
discovery code in the submodule case.  If it proves too fussy, then a
NEEDSWORK comment would be helpful to help the reader see what is
going on.

Thanks and hope that helps,
Jonathan
