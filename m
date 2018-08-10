Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2396B1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeHKASq (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:18:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34578 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeHKASq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:18:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so5114491pfi.1
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nLDeTwQw4O1Jsp4jD3bP1IKN/LTvVP7ygzkfhR0gyTo=;
        b=Ejvtvj0KWZFozkv0ja9yZeNeSMD9HA/Xg+mE8MreeBGTvbydNUXvFWsPEMGqDW/2pb
         m8OCZHPepNGGEz5HN0EEX9rwpyfcUEt1Q+VtJupkIWV6l2FuR0oaL5ZiTRULijFoORc1
         Y8NUFm0JN7uvFK3X6G3uumdMmMnD9FHGa8LX6PkZ/WKgX07dHJxpsKd2l9j/9h8JYBaq
         bJpxdR+iIQQCt31yhd7WX5F6puQBN3dNYN2MZNx6unlmJq2q+aa8PKn4Um1xNbwDhkih
         xF24jKVmhKgOG+huC2fFz6X/IjrO9rdKKKkFDL7Gi4hSNCpU0N2ClSxWgakuF48x2c/T
         dhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nLDeTwQw4O1Jsp4jD3bP1IKN/LTvVP7ygzkfhR0gyTo=;
        b=ZTL5lk1w8FH2mtXRl2YEyjXAKX0oI6oc0BXU5IDBiV9GSLhHrIydyt5fIzBlJ/g4X7
         Xk9KtreP7Rub3h6k7rI9geIoCJXVRJ7sNQrhSdOog8iPVziP/+a+GT8iAwIXNHIcZDxS
         FEMy9nuy9UQMZWtu43B2vvPWGHvNuW/lTzlrCEH31DNM4eoT5zIDnK31Molx8R4qKgdw
         RqbmazIXbJnQbyaEsvqw7Bi7F8+ZiQaqTrrgSP1TvW90Nae69D6uKRnn5Xv85CxfGcH3
         bjem3+gLvbc/Za0Kl9dSXVY6+OCXFPEEEMUee0LRBRt/yvFgF1LpSZ7ZFkR52Q9I9n40
         iMFg==
X-Gm-Message-State: AOUpUlH0/KJEjClBzXmlLpfoLbcbR1fvXAXvBPTwIDe93KymsdwOHs5N
        Hn7/FgS0ZQTpfA3MpR5aqnYsAg==
X-Google-Smtp-Source: AA+uWPwwpiXe9g2ByySJWvS5HfHrdH38U2ab5vqv+yvEWl/bb2dmEKnJZGerJVnBFYlkqTlArb0xsA==
X-Received: by 2002:a62:9645:: with SMTP id c66-v6mr8827900pfe.56.1533937625544;
        Fri, 10 Aug 2018 14:47:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id k64-v6sm15602719pgd.47.2018.08.10.14.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 14:47:04 -0700 (PDT)
Date:   Fri, 10 Aug 2018 14:47:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 6/7] submodule--helper: replace
 connect-gitdir-workingtree by ensure-core-worktree
Message-ID: <20180810214703.GB211322@google.com>
References: <20180803222322.261813-1-sbeller@google.com>
 <20180803222322.261813-7-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803222322.261813-7-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03, Stefan Beller wrote:
> e98317508c0 (submodule: ensure core.worktree is set after update,
> 2018-06-18) was overly aggressive in calling connect_work_tree_and_git_dir
> as that ensures both the 'core.worktree' configuration is set as well as
> setting up correct gitlink file pointing at the git directory.
> 
> We do not need to check for the gitlink in this part of the cmd_update
> in git-submodule.sh, as the initial call to update-clone will have ensured
> that. So we can reduce the work to only (check and potentially) set the
> 'core.worktree' setting.
> 
> While at it move the check from shell to C as that proves to be useful in
> a follow up patch, as we do not need the 'name' in shell now.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 64 +++++++++++++++++++++++--------------
>  git-submodule.sh            |  7 ++--
>  2 files changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 8b1088ab58a..e7635d5d9ab 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1964,6 +1964,45 @@ static int push_check(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
> +{
> +	const struct submodule *sub;
> +	const char *path;
> +	char *cw;
> +	struct repository subrepo;
> +
> +	if (argc != 2)
> +		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
> +
> +	path = argv[1];
> +
> +	sub = submodule_from_path(the_repository, &null_oid, path);
> +	if (!sub)
> +		BUG("We could get the submodule handle before?");
> +
> +	if (repo_submodule_init(&subrepo, the_repository, path))
> +		die(_("could not get a repository handle for submodule '%s'"), path);
> +
> +	if (!repo_config_get_string(&subrepo, "core.worktree", &cw)) {
> +		char *cfg_file, *abs_path;
> +		const char *rel_path;
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		cfg_file = xstrfmt("%s/config", subrepo.gitdir);

As I mentioned here:
https://public-inbox.org/git/20180807230637.247200-1-bmwill@google.com/T/#t

This lines should probably be more like:

  cfg_file = repo_git_path(&subrepo, "config");

> +
> +		abs_path = absolute_pathdup(path);
> +		rel_path = relative_path(abs_path, subrepo.gitdir, &sb);
> +
> +		git_config_set_in_file(cfg_file, "core.worktree", rel_path);
> +
> +		free(cfg_file);
> +		free(abs_path);
> +		strbuf_release(&sb);
> +	}
> +
> +	return 0;
> +}
> +
>  static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
> @@ -2029,29 +2068,6 @@ static int check_name(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> -static int connect_gitdir_workingtree(int argc, const char **argv, const char *prefix)
> -{
> -	struct strbuf sb = STRBUF_INIT;
> -	const char *name, *path;
> -	char *sm_gitdir;
> -
> -	if (argc != 3)
> -		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
> -
> -	name = argv[1];
> -	path = argv[2];
> -
> -	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> -	sm_gitdir = absolute_pathdup(sb.buf);
> -
> -	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
> -
> -	strbuf_release(&sb);
> -	free(sm_gitdir);
> -
> -	return 0;
> -}
> -
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>  
>  struct cmd_struct {
> @@ -2065,7 +2081,7 @@ static struct cmd_struct commands[] = {
>  	{"name", module_name, 0},
>  	{"clone", module_clone, 0},
>  	{"update-clone", update_clone, 0},
> -	{"connect-gitdir-workingtree", connect_gitdir_workingtree, 0},
> +	{"ensure-core-worktree", ensure_core_worktree, 0},
>  	{"relative-path", resolve_relative_path, 0},
>  	{"resolve-relative-url", resolve_relative_url, 0},
>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8caaf274e25..19d010eac06 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -535,6 +535,8 @@ cmd_update()
>  	do
>  		die_if_unmatched "$quickabort" "$sha1"
>  
> +		git submodule--helper ensure-core-worktree "$sm_path"
> +
>  		name=$(git submodule--helper name "$sm_path") || exit
>  		if ! test -z "$update"
>  		then
> @@ -577,11 +579,6 @@ cmd_update()
>  			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
>  		fi
>  
> -		if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
> -		then
> -			git submodule--helper connect-gitdir-workingtree "$name" "$sm_path"
> -		fi
> -
>  		if test "$subsha1" != "$sha1" || test -n "$force"
>  		then
>  			subforce=$force
> -- 
> 2.18.0.132.g195c49a2227
> 

-- 
Brandon Williams
