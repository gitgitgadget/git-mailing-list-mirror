Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DFD7202C1
	for <e@80x24.org>; Thu,  9 Mar 2017 23:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbdCIX3p (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 18:29:45 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33561 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdCIX3o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 18:29:44 -0500
Received: by mail-pg0-f41.google.com with SMTP id 25so31758116pgy.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 15:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VnuU2/fWa5HsY4rV2iYWkDIbH2mNo7DLwUIBNTSga+Q=;
        b=pCh/6bUf7wEBqta6W8wSeFZ3gX9R8EOrzGgp91YcqcZHgIaRfFe+7utawnmofyWXCc
         xeCNeFy7LYq9cRRrf8GsmUQUB0v7CXvrtfLpBlqc1FKEOSC/FrPuIOrONhrpTpwNtMyA
         V81ZvpoydWKjoKn8ylHZJ4D4Deg8+QHPpGLRM8MVx8xyeiJpn4ZNMnA/xPgL+zUwazTS
         pv4cyFdc9lB+hblKKDO3BHpYN3RGfr5VZPpqkcZM4rqMbwRu/LwRsZfvQJsHJy0q1u9H
         HeoDHWA6NNnnPIbkGSJvMn21vbMWbpcqtCDbU2+M68/2NLth9d5aScqUzVNOs1wZI/qP
         /K3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VnuU2/fWa5HsY4rV2iYWkDIbH2mNo7DLwUIBNTSga+Q=;
        b=hb2eGZ6VBvL08Z5kyy7LKbfio7nrPCQQucFy4QMX9Q89T2ZdpHymXhA4uFm3fk/HMc
         srwyMfrRKtseLkRXid0jGoBN/b3EZ8NTJoJuNL8o48/WvLhyB9fhqmDCLFhzP9l4bXxy
         /GvDBhhJn1yHr9EhGUgeAP7NHq8tlWt7PCK9N2QfuBW/1UALePc+7n9YXh+Axyp8LD5/
         8gOftwHOa/+1WTuJUcDh/1io9HEuBNvOFIRDGnwJ4EQ7elXBBV+DuVlzWGrs7TbjE3mt
         /TpAo+xsgJofxrj2fhtSro9c4aGbxR14DBsYZvZTXJBQna2eLLG7xSwGrcXzXtyVza2M
         9YJg==
X-Gm-Message-State: AMke39n5D3clAtkkLyQ1mji3d85sBClzrL222xffrs7Lm2lAKm8+dZORucxj1jw7lfOE0za0
X-Received: by 10.84.168.131 with SMTP id f3mr20731600plb.163.1489102183262;
        Thu, 09 Mar 2017 15:29:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:24ad:64a3:afd2:c7bd])
        by smtp.gmail.com with ESMTPSA id v4sm14491045pfb.36.2017.03.09.15.29.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 15:29:42 -0800 (PST)
Date:   Thu, 9 Mar 2017 15:29:40 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 07/17] connect_work_tree_and_git_dir: safely create
 leading directories
Message-ID: <20170309232940.GC52558@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
 <20170309221543.15897-8-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309221543.15897-8-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Stefan Beller wrote:
> In a later patch we'll use connect_work_tree_and_git_dir when the
> directory for the gitlink file doesn't exist yet. This patch makes
> connect_work_tree_and_git_dir safe to use for both cases of
> either the git dir or the working dir missing.
> 
> To do so, we need to call safe_create_leading_directories[_const]
> on both directories. However this has to happen before we construct
> the absolute paths as real_pathdup assumes the directories to
> be there already.
> 
> So for both the config file in the git dir as well as the .git link
> file we need to
> a) construct the name
> b) call SCLD
> c) get the absolute path
> d) once a-c is done for both we can consume the absolute path
>    to compute the relative path to each other and store those
>    relative paths.
> 
> The implementation provided here puts a) and b) for both cases first,
> and then performs c and d after.
> 
> One of the two users of 'connect_work_tree_and_git_dir' already checked
> for the directory being there, so we can loose that check as
> connect_work_tree_and_git_dir handles this functionality now.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  dir.c       | 32 +++++++++++++++++++++-----------
>  submodule.c | 11 ++---------
>  2 files changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index 4541f9e146..6f52af7abb 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2728,23 +2728,33 @@ void untracked_cache_add_to_index(struct index_state *istate,
>  /* Update gitfile and core.worktree setting to connect work tree and git dir */
>  void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
>  {
> -	struct strbuf file_name = STRBUF_INIT;
> +	struct strbuf gitfile_sb = STRBUF_INIT;
> +	struct strbuf cfg_sb = STRBUF_INIT;
>  	struct strbuf rel_path = STRBUF_INIT;
> -	char *git_dir = real_pathdup(git_dir_);
> -	char *work_tree = real_pathdup(work_tree_);
> +	char *git_dir, *work_tree;
>  
> -	/* Update gitfile */
> -	strbuf_addf(&file_name, "%s/.git", work_tree);
> -	write_file(file_name.buf, "gitdir: %s",
> -		   relative_path(git_dir, work_tree, &rel_path));
> +	/* Prepare .git file */
> +	strbuf_addf(&gitfile_sb, "%s/.git", work_tree_);
> +	if (safe_create_leading_directories_const(gitfile_sb.buf))
> +		die(_("could not create directories for %s"), gitfile_sb.buf);
> +
> +	/* Prepare config file */
> +	strbuf_addf(&cfg_sb, "%s/config", git_dir_);
> +	if (safe_create_leading_directories_const(cfg_sb.buf))
> +		die(_("could not create directories for %s"), cfg_sb.buf);
>  
> +	git_dir = real_pathdup(git_dir_);
> +	work_tree = real_pathdup(work_tree_);

Just a note that this is a spot that'll be affected by the change to
real_pathdup() which adds a 'die_on_error' parameter to correct bad
behaviour I introduced.

> +
> +	/* Write .git file */
> +	write_file(gitfile_sb.buf, "gitdir: %s",
> +		   relative_path(git_dir, work_tree, &rel_path));
>  	/* Update core.worktree setting */
> -	strbuf_reset(&file_name);
> -	strbuf_addf(&file_name, "%s/config", git_dir);
> -	git_config_set_in_file(file_name.buf, "core.worktree",
> +	git_config_set_in_file(cfg_sb.buf, "core.worktree",
>  			       relative_path(work_tree, git_dir, &rel_path));
>  
> -	strbuf_release(&file_name);
> +	strbuf_release(&gitfile_sb);
> +	strbuf_release(&cfg_sb);
>  	strbuf_release(&rel_path);
>  	free(work_tree);
>  	free(git_dir);
> diff --git a/submodule.c b/submodule.c
> index 0e55372f37..04d185738f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1442,8 +1442,6 @@ void absorb_git_dir_into_superproject(const char *prefix,
>  
>  	/* Not populated? */
>  	if (!sub_git_dir) {
> -		char *real_new_git_dir;
> -		const char *new_git_dir;
>  		const struct submodule *sub;
>  
>  		if (err_code == READ_GITFILE_ERR_STAT_FAILED) {
> @@ -1466,13 +1464,8 @@ void absorb_git_dir_into_superproject(const char *prefix,
>  		sub = submodule_from_path(null_sha1, path);
>  		if (!sub)
>  			die(_("could not lookup name for submodule '%s'"), path);
> -		new_git_dir = git_path("modules/%s", sub->name);
> -		if (safe_create_leading_directories_const(new_git_dir) < 0)
> -			die(_("could not create directory '%s'"), new_git_dir);
> -		real_new_git_dir = real_pathdup(new_git_dir);
> -		connect_work_tree_and_git_dir(path, real_new_git_dir);
> -
> -		free(real_new_git_dir);
> +		connect_work_tree_and_git_dir(path,
> +			git_path("modules/%s", sub->name));
>  	} else {
>  		/* Is it already absorbed into the superprojects git dir? */
>  		char *real_sub_git_dir = real_pathdup(sub_git_dir);
> -- 
> 2.12.0.rc1.45.g207f5fbb2b
> 

-- 
Brandon Williams
