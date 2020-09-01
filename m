Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDE0C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 02:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E8220719
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 02:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3vGBrAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIACle (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgIACle (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 22:41:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9324EC061366
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 19:41:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so930994pjr.4
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 19:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UCenZ9xRODQ19inwq2v+Gw3FHkxbSILIokjjJdOx68c=;
        b=U3vGBrAPcurnunG6csTH/KsL1fBTWMgGwB6x7D4cCdGeMPvAiVx8+17ceuKAnL9/+d
         Gs1peTGM/5ed8Ea+cNHEUTIzYCNc82gtn3ZQDTEkLAcWxhwGIhBiJR/eM83G8DnmiEs6
         nDx9orVmCtfZv0LtX/L4CtW+T7ewbpqXBeK6FRJFFh6parP8DhgyoUybv72jT0ej7qtJ
         hChiVca2LuMLUqe+d0r2UP3zUSUD9Tiad+kSEXA/LbP/j9VLKWJ30QepI4tOA/zrQiDS
         RJk9iZfJTKbe4XyVVb+CK0IK6w6bWU6/5LJ5VHdaDJNH+X4mPLO/H6fJsK6YrJnSXvBZ
         /lIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UCenZ9xRODQ19inwq2v+Gw3FHkxbSILIokjjJdOx68c=;
        b=LuGf66Mfd3od8Hgi2xgZmVdk1UcB+tN5Myxm0GfLVYYGczC00wGoNDR/wbYBMW7clg
         9Sz4yoboYflVGZ9U6A5dSS4LLtuF2iil1DvsG1UZqrJZYgda+JSd6xDlrPdSS1gZjS4b
         nDrKFba8/+X1NHFmA974kRUgOttLZGmJpaaDQAd9Cn82L5a5xWyYSmi7r/fOBORdmfTN
         lwrdpNcl9rpOtef1oHmfD+kstHiJJ5CmuX/x6XThXAa6ZNGuFKTe12RXhcGF/pieVNTt
         s6HlNs3Khjx2xI1AfxAM5WDhpK2/t0VUJkqAw+htXfcaoCwxOUCxNfftnPEn4zccT1YR
         jyyg==
X-Gm-Message-State: AOAM531kzjjmkuuhNzrQ8mVcv/c+fr5+6YkBElIWdzdGjRPnfI/6Z6nP
        zkkQDCbRjhx/Xs4QERRQX7k=
X-Google-Smtp-Source: ABdhPJylowfVxyIxYJll8yg4pkWqFHwZ8OUc+qzCeSJO2K1YsTuzHUsjsQNbycAHOxOZ66yquQknYA==
X-Received: by 2002:a17:902:7790:: with SMTP id o16mr3433615pll.299.1598928092959;
        Mon, 31 Aug 2020 19:41:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id p68sm9554175pfb.40.2020.08.31.19.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 19:41:32 -0700 (PDT)
Date:   Mon, 31 Aug 2020 19:41:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        newren@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 4/6] config: correctly read worktree configs in
 submodules
Message-ID: <20200901024130.GA3332286@google.com>
References: <cover.1591974940.git.matheus.bernardino@usp.br>
 <6402c968077900d48d189551a652e10984437a9f.1591974940.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6402c968077900d48d189551a652e10984437a9f.1591974940.git.matheus.bernardino@usp.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Matheus Tavares wrote:

> One of the steps in do_git_config_sequence() is to load the
> worktree-specific config file. Although the function receives a git_dir
> string, it relies on git_pathdup(), which uses the_repository->git_dir,
> to make the path to the file. Furthermore, it also checks that
> extensions.worktreeConfig is set through the
> repository_format_worktree_config variable, which refers to
> the_repository only. Thus, when a submodule has worktree-specific
> settings, a command executed in the superproject that recurses into the
> submodule won't find the said settings.

I think the above goes out of order: it states the "how" before the
"what".  Instead, a commit message should lead with the problem the
change aims to solve.

Is the idea here that until this patch, we're only able to read
worktree config from a repository when extensions.worktreeConfig is
set in the_repository, meaning that

- when examining submodule config in a process where the_repository
  represents the superproject, we do not read the submodule's worktree
  config even if extensions.worktreeConfig is set in the submodule,
  unless the superproject has extensions.worktreeConfig set, and

- when examining submodule config in a process where the_repository
  represents the superproject, we *do* read the submodule's worktree
  config even if extensions.worktreeConfig is not set in the submodule,
  if the superproject has extensions.worktreeConfig set, and

?

That sounds like a serious problem indeed.  Thanks for fixing it.

> This will be especially important in the next patch: git-grep will learn
> to honor sparse checkouts and, when running with --recurse-submodules,
> the submodule's sparse checkout settings must be loaded. As these
> settings are stored in the config.worktree file, they would be ignored
> without this patch. So let's fix this by reading the right
> config.worktree file and extensions.worktreeConfig setting, based on the
> git_dir and commondir paths given to do_git_config_sequence(). Also
> add a test to avoid any regressions.

I see.  I'm not sure that's more important than other cases, but I
can understand if the problem was noticed in this circumstance. :)

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  config.c                   | 21 +++++++++---
>  t/helper/test-config.c     | 67 +++++++++++++++++++++++++++++++++-----
>  t/t2404-worktree-config.sh | 16 +++++++++
>  3 files changed, 91 insertions(+), 13 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 8db9c77098..c2d56309dc 100644
> --- a/config.c
> +++ b/config.c
> @@ -1747,11 +1747,22 @@ static int do_git_config_sequence(const struct config_options *opts,
>  		ret += git_config_from_file(fn, repo_config, data);
>  
>  	current_parsing_scope = CONFIG_SCOPE_WORKTREE;
> -	if (!opts->ignore_worktree && repository_format_worktree_config) {
> +	if (!opts->ignore_worktree && repo_config && opts->git_dir) {

Can we eliminate the repository_format_worktree_config global to save
the next caller from the same problem?

> +		struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		read_repository_format(&repo_fmt, repo_config);
> +
> +		if (!verify_repository_format(&repo_fmt, &buf) &&
> +		    repo_fmt.worktree_config) {

This undoes the caching the repository_format_worktree_config means to
do.  Can we cache the value in "struct repository" instead?  That way,
in the common case where we're reading the_repository, we wouldn't
experience a slowdown.

> -		char *path = git_pathdup("config.worktree");
> +			char *path = mkpathdup("%s/config.worktree", opts->git_dir);

Can this use a helper like repo_git_path or strbuf_repo_git_path
(preferably one using strbuf like the latter)?

[...]
> +		strbuf_release(&buf);
> +		clear_repository_format(&repo_fmt);
>  	}
>  
>  	current_parsing_scope = CONFIG_SCOPE_COMMAND;
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 61da2574c5..284f83a921 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -2,12 +2,19 @@
>  #include "cache.h"
>  #include "config.h"
>  #include "string-list.h"
> +#include "submodule-config.h"
>  
>  /*
>   * This program exposes the C API of the configuration mechanism
>   * as a set of simple commands in order to facilitate testing.
>   *
> - * Reads stdin and prints result of command to stdout:
> + * Usage: test-tool config [--submodule=<path>] <cmd> [<args>]
> + *
> + * If --submodule=<path> is given, <cmd> will operate on the submodule at the
> + * given <path>. This option is not valid for the commands: read_early_config,
> + * configset_get_value and configset_get_value_multi.

Nice!

[...]
> @@ -93,7 +102,18 @@ int cmd__config(int argc, const char **argv)
>  	if (argc == 0)
>  		goto print_usage_error;
>  
> +	if (skip_prefix(*argv, "--submodule=", &subrepo_path)) {
> +		argc--;
> +		argv++;
> +		if (argc == 0)
> +			goto print_usage_error;
> +	}

Can this use the parse_options API?

> +
>  	if (argc == 2 && !strcmp(argv[0], "read_early_config")) {
> +		if (subrepo_path) {
> +			fprintf(stderr, "Cannot use --submodule with read_early_config\n");
> +			return TC_USAGE_ERROR;

Should this use die() or BUG()?

> +		}
>  		read_early_config(early_config_cb, (void *)argv[1]);
>  		return TC_SUCCESS;
>  	}
> @@ -101,8 +121,23 @@ int cmd__config(int argc, const char **argv)
>  	setup_git_directory();
>  	git_configset_init(&cs);
>  
> +	if (subrepo_path) {
> +		const struct submodule *sub;
> +		struct repository *subrepo = xcalloc(1, sizeof(*repo));

nit: this could be scoped to cmd__config:

	struct repository subrepo = {0};

> +
> +		sub = submodule_from_path(the_repository, &null_oid, subrepo_path);
> +		if (!sub || repo_submodule_init(subrepo, the_repository, sub)) {
> +			fprintf(stderr, "Invalid argument to --submodule: '%s'\n",
> +				subrepo_path);
> +			free(subrepo);
> +			ret = TC_USAGE_ERROR;

Likewise: I think may want to use die() or BUG() (and likewise for other
USAGE_ERROR cases).

Thanks and hope that helps,
Jonathan
