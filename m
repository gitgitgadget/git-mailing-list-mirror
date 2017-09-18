Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39D62047F
	for <e@80x24.org>; Mon, 18 Sep 2017 16:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbdIRQwV (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 12:52:21 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:53338 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932307AbdIRQwU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 12:52:20 -0400
Received: by mail-pg0-f45.google.com with SMTP id j70so438513pgc.10
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w+MBF/qVi6frDsFJBwCn9/csYtrE6bB5cdpKqXKQ4mU=;
        b=bvU19Q465RSh9EBPzwyke5tD2I0UJbwt9ubOqt1y9ouVJXH1C+bzE2hG5CO1oPeiun
         1bAlEMtzWfWQx4h+apk1hbpx1gr64foQU+MhcJVuNOIob8QE49nLTY+0HPuXx4YnTSkM
         9MVw7cRpKMTmLWb7pkBYq1Mn9eq4rfuh7nay3rmqYGOlgn3v/YnFNr3DJvGS47r1JVey
         F7r1KeIrg5FJkUQUE5AvoG74EOOdJGXAeW+dczZ2rsUT4ly2pBz04uHhfY6zcjYRyU8B
         cLlB0xrz/02r33mBe+UoUF5zr3tpCWy9P/1y+Fsdb9SjRdR0A93OIZ6NwNd+RTALDp4x
         +yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w+MBF/qVi6frDsFJBwCn9/csYtrE6bB5cdpKqXKQ4mU=;
        b=ftaSodpixikbCr419unaWe1eg3Q48b7yjqUfEcqDv2EJYdy/jVvYt/uNd8Ngk3sUdS
         awXT0mrS51uAAJ5tEKazZ67n4+Dmo9nnWdeuYx6MlHyPUwUvn/kBBngb7rIJ+lgR7B7Z
         LL8FzNzDElZzklH43wsjgZe6u7+RVrSziY9F60Xau8Gv9giB/gHMIVv6rJYsgZUznNlY
         5yl73H7V61aXAdbjbItVxlEGhfsn+mwPANvlBpUmPm5/roTPqrMyHPwG2/cI1FAKAd/9
         9E4wVT8PUYJU2lW11k/NrqWMwg1rYVa+0TIoheDSj2e4Xc/r5WxzLYwZD2Vq2HTSDCE7
         tmRg==
X-Gm-Message-State: AHPjjUhV+SMWpCggpACdCCuUWdSl++bGLlwYQsQO4S+zm6yzBz3CoUvO
        LX5XVn07kGQGdlXj
X-Google-Smtp-Source: ADKCNb4d2wLDNBLrwujGUVlVyV/JI2ZJux9wGhZjIXKVStauOMGYmxTU4u9uHfRHIhcyvrbCdsZMTw==
X-Received: by 10.84.128.14 with SMTP id 14mr30735143pla.329.1505753539485;
        Mon, 18 Sep 2017 09:52:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c140:486c:cfb0:5862])
        by smtp.gmail.com with ESMTPSA id g68sm15056432pfb.120.2017.09.18.09.52.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 09:52:18 -0700 (PDT)
Date:   Mon, 18 Sep 2017 09:52:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 2/4] push, fetch: error out for submodule entries not
 pointing to commits
Message-ID: <20170918165217.GD144331@google.com>
References: <20170912172330.GA144745@aiede.mtv.corp.google.com>
 <20170912173027.GC144745@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170912173027.GC144745@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12, Jonathan Nieder wrote:
> From: Stefan Beller <sbeller@google.com>
> 
> The check_has_commit helper uses resolves a submodule entry to a
> commit, when validating its existence. As a side effect this means
> tolerates a submodule entry pointing to a tag, which is not a valid
> submodule entry that git commands would know how to cope with.
> 
> Tighten the check to require an actual commit, not a tag pointing to a
> commit.
> 
> Also improve the error handling when a submodule entry points to
> non-commit (e.g., a blob) to error out instead of warning and
> pretending the pointed to object doesn't exist.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Looks good!

> ---
>  submodule.c                    | 33 +++++++++++++++++++++++++--------
>  t/t5531-deep-submodule-push.sh | 10 ++++++++++
>  2 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 3cea8221e0..e0da55920d 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -767,19 +767,36 @@ static int append_oid_to_argv(const struct object_id *oid, void *data)
>  	return 0;
>  }
>  
> +struct has_commit_data {
> +	int result;
> +	const char *path;
> +};
> +
>  static int check_has_commit(const struct object_id *oid, void *data)
>  {
> -	int *has_commit = data;
> +	struct has_commit_data *cb = data;
>  
> -	if (!lookup_commit_reference(oid))
> -		*has_commit = 0;
> +	enum object_type type = sha1_object_info(oid->hash, NULL);
>  
> -	return 0;
> +	switch (type) {
> +	case OBJ_COMMIT:
> +		return 0;
> +	case OBJ_BAD:
> +		/*
> +		 * Object is missing or invalid. If invalid, an error message
> +		 * has already been printed.
> +		 */
> +		cb->result = 0;
> +		return 0;
> +	default:
> +		die(_("submodule entry '%s' (%s) is a %s, not a commit"),
> +		    cb->path, oid_to_hex(oid), typename(type));
> +	}
>  }
>  
>  static int submodule_has_commits(const char *path, struct oid_array *commits)
>  {
> -	int has_commit = 1;
> +	struct has_commit_data has_commit = { 1, path };
>  
>  	/*
>  	 * Perform a cheap, but incorrect check for the existence of 'commits'.
> @@ -795,7 +812,7 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
>  
>  	oid_array_for_each_unique(commits, check_has_commit, &has_commit);
>  
> -	if (has_commit) {
> +	if (has_commit.result) {
>  		/*
>  		 * Even if the submodule is checked out and the commit is
>  		 * present, make sure it exists in the submodule's object store
> @@ -814,12 +831,12 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
>  		cp.dir = path;
>  
>  		if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1) || out.len)
> -			has_commit = 0;
> +			has_commit.result = 0;
>  
>  		strbuf_release(&out);
>  	}
>  
> -	return has_commit;
> +	return has_commit.result;
>  }
>  
>  static int submodule_needs_pushing(const char *path, struct oid_array *commits)
> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> index 0f84a53146..39cb2c1c34 100755
> --- a/t/t5531-deep-submodule-push.sh
> +++ b/t/t5531-deep-submodule-push.sh
> @@ -298,6 +298,16 @@ test_expect_success 'push succeeds if submodule commit disabling recursion from
>  	)
>  '
>  
> +test_expect_success 'submodule entry pointing at a tag is error' '
> +	git -C work/gar/bage tag -a test1 -m "tag" &&
> +	tag=$(git -C work/gar/bage rev-parse test1^{tag}) &&
> +	git -C work update-index --cacheinfo 160000 "$tag" gar/bage &&
> +	git -C work commit -m "bad commit" &&
> +	test_when_finished "git -C work reset --hard HEAD^" &&
> +	test_must_fail git -C work push --recurse-submodules=on-demand ../pub.git master 2>err &&
> +	test_i18ngrep "is a tag, not a commit" err
> +'
> +
>  test_expect_success 'push fails if recurse submodules option passed as yes' '
>  	(
>  		cd work/gar/bage &&
> -- 
> 2.14.1.690.gbb1197296e
> 

-- 
Brandon Williams
