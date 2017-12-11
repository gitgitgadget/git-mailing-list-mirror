Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A411F404
	for <e@80x24.org>; Mon, 11 Dec 2017 18:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbdLKSyM (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 13:54:12 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:38918 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbdLKSyK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 13:54:10 -0500
Received: by mail-it0-f67.google.com with SMTP id 68so18221934ite.4
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uitVZ86FEC02MSM6yCGC7Soel1zehEvwj3NE0aqA7Fk=;
        b=oflLmtqfscxT9o3i6Gt238zL0GSEbuhjU4Cwp88R05KP2jvFpH1O50WxkU3Is/mW0X
         /4OaBq58L4iWow5lwEY4M84OMTdwbyPvHLk+npQ9Obzr+VlgbvzzLOT6tjk+ayGWYTia
         2Nk1IaT3v/mQvLdJqed2rn9T+aTz17roitaXbEQRUxgP0Hu02TIDLwlNjqth7B/y2k27
         BYM9YOraH7sP+dYkkb74lIE9SVxYl2WQsj0/awmRyyc5v/SIOCdknhDtFTFN1bfg21QL
         JKoL2iLn2M1+vbRHa6KYl7Aph1Y/bmuc1fGhL7vQFXOk9BAUm0QdtXjEG+OpJhLK/vOe
         yPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uitVZ86FEC02MSM6yCGC7Soel1zehEvwj3NE0aqA7Fk=;
        b=EwA7jYNOayyhLSaL1HmQTqk1bnALRq52uvlhc4jXM1wNutOZUA2urslwT72bGiLv/T
         msFi9aTzsvMBrPYo8/R35yzsbT9VFFvbt7SVtrHJX0m9st5ZJ7eyDUGLErn7kAnvUAa+
         okGcHFp6ryxfb3LkJGQ57s7CXURXC8otimQiwhr45VVMaOz7/tQP+YTUKudIyA3jcQEr
         uXQvO9cu0TldBvZfZ7QsgyVVUF1ww2cJXdZb2ea8kzWJuH8A+1OTYQ7hkT/4SDDNQmro
         GHM0CCbY58JY0Ad4oRq17Xk+350iiJk0VzuGSTrzeQANziTD8DVncGweS0COvJQ9Waro
         ndMQ==
X-Gm-Message-State: AKGB3mLxAKnI9nyqUVkMvtHpcEwLhN5W65/EloA56N1cb5OtTQH+2W0U
        LpBpvK/Bx4139/hYOoWqoyzkpA==
X-Google-Smtp-Source: ACJfBovamHjciHl2eczSnnIvxgCEPmGSCKXUpBo6hgCVVYoP1UmHqAG/J4YFB1IxgFfafHbGZo0/sw==
X-Received: by 10.107.26.195 with SMTP id a186mr1789330ioa.11.1513018448826;
        Mon, 11 Dec 2017 10:54:08 -0800 (PST)
Received: from google.com ([2620:0:100e:422:bdc4:e5a2:2ef4:d600])
        by smtp.gmail.com with ESMTPSA id m91sm6613157iod.76.2017.12.11.10.54.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 10:54:07 -0800 (PST)
Date:   Mon, 11 Dec 2017 10:54:06 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] repository: fix repo_read_index with submodules
Message-ID: <20171211185406.GA177995@google.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171210212202.28231-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171210212202.28231-2-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Thomas Gummerer wrote:
> repo_read_index calls read_index_from, which takes an path argument for
> the location of the index file.  For the split index however it relies
> on the current working directory to construct the path using git_path.
> 
> repo_read_index calls read_index_from with the full path for the index
> file, however it doesn't change the cwd, so when split index mode is
> turned on, read_index_from can't find the file for the split index.
> 
> For example t3007-ls-files-recurse-submodules.sh was broken with
> GIT_TEST_SPLIT_INDEX set in 188dce131f ("ls-files: use repository
> object", 2017-06-22), and t7814-grep-recurse-submodules.sh was also
> broken in a similar manner, probably by introducing struct repository
> there, although I didn't track down the exact commit for that.
> 
> Fix this by introducing a new read_index_for_repo function, which knows
> about the correct paths for the submodules.
> 
> The alternative would have been to make the callers pass in the base
> path for the split index, however that ended up being more complicated,
> and I think we want to converge towards using struct repository for
> things like these anyway.

Thanks for catching this, I'm not a user of split index myself which is
why I unfortunately overlooked this.  Definitely a good change.  I
really only have one nit below.

> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  cache.h      |  1 +
>  read-cache.c | 19 +++++++++++++++++--
>  repository.c |  2 +-
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index cb5db7bf83..d42bea1ef7 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -614,6 +614,7 @@ extern int read_index_preload(struct index_state *, const struct pathspec *paths
>  extern int do_read_index(struct index_state *istate, const char *path,
>  			 int must_exist); /* for testting only! */
>  extern int read_index_from(struct index_state *, const char *path);
> +extern int read_index_for_repo(const struct repository *);
>  extern int is_index_unborn(struct index_state *);
>  extern int read_index_unmerged(struct index_state *);
>  
> diff --git a/read-cache.c b/read-cache.c
> index 2eb81a66b9..4d5c4ad79b 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -20,6 +20,7 @@
>  #include "split-index.h"
>  #include "utf8.h"
>  #include "fsmonitor.h"
> +#include "repository.h"
>  
>  /* Mask for the name length in ce_flags in the on-disk index */
>  
> @@ -1871,7 +1872,8 @@ static void freshen_shared_index(char *base_sha1_hex, int warn)
>  	free(shared_index);
>  }
>  
> -int read_index_from(struct index_state *istate, const char *path)
> +static int do_read_index_from(struct index_state *istate, const char *path,
> +			      const struct repository *repo)
>  {
>  	struct split_index *split_index;
>  	int ret;
> @@ -1896,7 +1898,10 @@ int read_index_from(struct index_state *istate, const char *path)
>  		split_index->base = xcalloc(1, sizeof(*split_index->base));
>  
>  	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
> -	base_path = git_path("sharedindex.%s", base_sha1_hex);
> +	if (repo)
> +		base_path = repo_git_path(repo, "sharedindex.%s", base_sha1_hex);
> +	else
> +		base_path = git_path("sharedindex.%s", base_sha1_hex);
>  	ret = do_read_index(split_index->base, base_path, 1);
>  	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
>  		die("broken index, expect %s in %s, got %s",
> @@ -1909,6 +1914,16 @@ int read_index_from(struct index_state *istate, const char *path)
>  	return ret;
>  }
>  
> +int read_index_for_repo(const struct repository *repo)
> +{
> +	return do_read_index_from(repo->index, repo->index_file, repo);
> +}
> +
> +int read_index_from(struct index_state *istate, const char *path)
> +{
> +	return do_read_index_from(istate, path, NULL);
> +}

Instead of passing NULL and having to special case it in
'do_read_index_from()', how about we pass in 'the_repository'?

> +
>  int is_index_unborn(struct index_state *istate)
>  {
>  	return (!istate->cache_nr && !istate->timestamp.sec);
> diff --git a/repository.c b/repository.c
> index bb2fae5446..928b1f553d 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -229,5 +229,5 @@ int repo_read_index(struct repository *repo)
>  	if (!repo->index)
>  		repo->index = xcalloc(1, sizeof(*repo->index));
>  
> -	return read_index_from(repo->index, repo->index_file);
> +	return read_index_for_repo(repo);
>  }
> -- 
> 2.15.1.504.g5279b80103
> 

-- 
Brandon Williams
