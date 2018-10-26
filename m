Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D821F453
	for <e@80x24.org>; Fri, 26 Oct 2018 19:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeJ0DyM (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 23:54:12 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:42892 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJ0DyM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 23:54:12 -0400
Received: by mail-qk1-f201.google.com with SMTP id m63-v6so2134474qkb.9
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HM6GO6uq9i73kdDT++f+xu8dPgacT2cFe/ZzlwFNTSA=;
        b=iCg5OjED0HexxPDLsWvSMYVeB4O3B3QQ0zh13oVOc5/mtVG+sEbIZU9nSHqIQNnkNT
         NzHOxIkJGoenMa5ongUsArCE52RoxoG9cBYMLngaGh0eaCH2fXo8cwV8oKFOolfPGib9
         2tqLGDD+6zq60ohVEnDfO9bbHas+nUUHPnwrgwq+F7uwByBIUs91acrIa2gw0nwZ1+mC
         uWoItlE91HiprmLdy4QilBUX+9uHS/JPtGtk5oyHF6yEc9RFw1biH/7U2KLdlpFMYDNJ
         yeU9KkCqyK7EVLFtoiCUvS1LFh7KI915Uxo9ltmLcQJEcNFrLuz8q7gwdB1P93OlN2rK
         Z1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HM6GO6uq9i73kdDT++f+xu8dPgacT2cFe/ZzlwFNTSA=;
        b=YpzawYjSwBsLs8wN4xx6o/KI6XPwuHbwI1Fy6MZHkgiU2pae2gENLyF+UxBJEo5YxF
         whjucBm4SC17YAipQC2T3OKBxTP/QZtu45XdyNl8L/GkpsBNM2E+Bx+xLpwihXXCHLV3
         8KA1ZO/pIhR5iX5w3JRD4Xo6iP/RIBCsgChL1YbDzzWYQrPfwVxFjQ6vkIQnFmNcv4OO
         hrLjf6TiCXWQ4WoxEOS+69JqqFsl/nkusGvJI/oCJRcR4k2nDuM3C06L43wNkE3Fwt4v
         6pyRhk+Quwes8I7TqiLpPsvufSNoc9RQ/VavIGsHbhlZbgjiecSYYA5RcvOUHCC3jH16
         m6Cg==
X-Gm-Message-State: AGRZ1gJ+9+PfXxxq6gXQHA6Qom2XEgWm3SHfnsu4PGQCxwm8mMsLtwZg
        yj+M2Xu5I6aIFpA/QeAN1RrEjTSgbQfqeS97kFbl
X-Google-Smtp-Source: AJdET5f9f6enHAnctuA7dLbyA0ocjlQ7RHo6ZSQ87RGZR1mZApTHB6ax0gfB0WXKxSThXoRBN8t9yZn3K0EWGFLAnSPf
X-Received: by 2002:a37:8084:: with SMTP id b126-v6mr3920243qkd.43.1540581356715;
 Fri, 26 Oct 2018 12:15:56 -0700 (PDT)
Date:   Fri, 26 Oct 2018 12:15:53 -0700
In-Reply-To: <20181025233231.102245-7-sbeller@google.com>
Message-Id: <20181026191553.108916-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-7-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 06/10] repository: repo_submodule_init to take a submodule struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 7da8fef31a..ba7634258a 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -418,7 +418,10 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
>  			  const struct object_id *oid,
>  			  const char *filename, const char *path)
>  {
> -	struct repository submodule;
> +	struct repository subrepo;
> +	const struct submodule *sub = submodule_from_path(superproject,
> +							  &null_oid, path);

[snip]

> -	if (repo_submodule_init(&submodule, superproject, path)) {
> +	if (repo_submodule_init(&subrepo, superproject, sub)) {

The last argument to repo_submodule_init is now
"submodule_from_path(superproject, &null_oid, path)" instead of "path",
and looking forward into the patch, we do not need a NULL check because
repo_submodule_init() tolerates NULL in that argument.

Let's see if the rest of the code follows the pattern - a call to
submodule_from_path() with the 3 expected arguments (repo, null OID,
path).

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 7f9919a362..4d1649c1b3 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -206,17 +206,19 @@ static void show_files(struct repository *repo, struct dir_struct *dir);
>  static void show_submodule(struct repository *superproject,
>  			   struct dir_struct *dir, const char *path)
>  {
> -	struct repository submodule;
> +	struct repository subrepo;
> +	const struct submodule *sub = submodule_from_path(superproject,
> +							  &null_oid, path);
>  
> -	if (repo_submodule_init(&submodule, superproject, path))
> +	if (repo_submodule_init(&subrepo, superproject, sub))

So far so good.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 5f8a804a6e..015aa1471f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2037,7 +2037,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
>  	if (!sub)
>  		BUG("We could get the submodule handle before?");
>  
> -	if (repo_submodule_init(&subrepo, the_repository, path))
> +	if (repo_submodule_init(&subrepo, the_repository, sub))

The definition of "sub" is not quoted here in this e-mail, but it is
indeed "submodule_from_path(the_repository, &null_oid, path)".
("the_repository" in the invocation to submodule_from_path() is correct
because the 2nd argument to the invocation of repo_submodule_init() is
"the_repository".)

> -int repo_submodule_init(struct repository *submodule,
> +int repo_submodule_init(struct repository *subrepo,
>  			struct repository *superproject,
> -			const char *path)
> +			const struct submodule *sub)
>  {
> -	const struct submodule *sub;
>  	struct strbuf gitdir = STRBUF_INIT;
>  	struct strbuf worktree = STRBUF_INIT;
>  	int ret = 0;
>  
> -	sub = submodule_from_path(superproject, &null_oid, path);

As expected, this line is removed.

>  	if (!sub) {
>  		ret = -1;
>  		goto out;
>  	}
>  
> -	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", path);
> -	strbuf_repo_worktree_path(&worktree, superproject, "%s", path);
> +	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", sub->path);
> +	strbuf_repo_worktree_path(&worktree, superproject, "%s", sub->path);

path and sub->path are the same, so this is fine. (This can be seen from
cache_put_path() and cache_lookup_path() in submodule-config.c.)

> -	submodule->submodule_prefix = xstrfmt("%s%s/",
> -					      superproject->submodule_prefix ?
> -					      superproject->submodule_prefix :
> -					      "", path);
> +	subrepo->submodule_prefix = xstrfmt("%s%s/",
> +					    superproject->submodule_prefix ?
> +					    superproject->submodule_prefix :
> +					    "", sub->path);

Likewise.

> +/*
> + * Initialize the repository 'subrepo' as the submodule given by the
> + * struct submodule 'sub' in parent repository 'superproject'.
> + * Return 0 upon success and a non-zero value upon failure, which may happen
> + * if the submodule is not found, or 'sub' is NULL.
> + */
> +struct submodule;
> +int repo_submodule_init(struct repository *subrepo,
>  			struct repository *superproject,
> -			const char *path);
> +			const struct submodule *sub);

Here is where it says that the last argument can be NULL.

> diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
> index a31e2a9bea..bc97929bbc 100644
> --- a/t/helper/test-submodule-nested-repo-config.c
> +++ b/t/helper/test-submodule-nested-repo-config.c
> @@ -10,19 +10,21 @@ static void die_usage(int argc, const char **argv, const char *msg)
>  
>  int cmd__submodule_nested_repo_config(int argc, const char **argv)
>  {
> -	struct repository submodule;
> +	struct repository subrepo;
> +	const struct submodule *sub;
>  
>  	if (argc < 3)
>  		die_usage(argc, argv, "Wrong number of arguments.");
>  
>  	setup_git_directory();
>  
> -	if (repo_submodule_init(&submodule, the_repository, argv[1])) {
> +	sub = submodule_from_path(the_repository, &null_oid, argv[1]);
> +	if (repo_submodule_init(&subrepo, the_repository, sub)) {

The expected pattern.

This patch looks good to me.
