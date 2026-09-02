Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B940B0E8
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340295; cv=none; b=FvYBKq0n3FgSV2vQnuelt5Egq8ctfatykeosmJO6vIXcDX514F4bOmTBP2tPrXgBe4PpdDalk2txJML6t4wICnXlJqnplhZvenH1GdL6VUvzZ7mC5zhrbrjttAaMpo252D+qiJUXj8kwiufSz1HUs0AbAcrhBZAw4beARMtHBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340295; c=relaxed/simple;
	bh=L/aZ0jUPaD3jvKgq6eXnkGJfiJc0pjCfG0u5iZrzJi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyK5aF+Gh36/JlK5QaFBYfdgsGcHZiWxo6lN/PQ9CmLsEF+7k2JD6Nc+MbYcNlYGxfH6I0OLr3eMa3iRw8esG+mS+YpBWJxZy9tb0h+02AcH4yhDL/sAhH0JCu+TKvMhIwVcdLQIW8aVcLYxhlcKNln1vs22oL9ie95ONw0kirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=odQSkcd9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GzH1+gMR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="odQSkcd9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GzH1+gMR"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A72C7A001C;
	Wed,  2 Sep 2026 05:11:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 02 Sep 2026 05:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788340292; x=1788426692; bh=ijper6hLjo
	77qIaBkbdehqskovvmiHnBC1BNDK/CjNg=; b=odQSkcd96zTqz/qfdvy4EAZgNY
	0gz/3tYRLbGIXh8lVz8qb3hsIlUh61r6tuxtoTN0aG7qHiKbKfFf64NnyCFFUcHy
	/6UjURBOXAhFwY2r5+o8wGMONAUfbXmQNaDy3D98SAtCDCNW2g1tmbSztQ3MaXEy
	3R/9aB3IpjeodZ3TUHGcaaouXXgf/8D4r8uxhVlvoCK92FI4jOWJU5TtDGH2837+
	FotfMTQopeKe2E8XiDpBUK6Pxo2C5Lk0GINueyfayKzrpvjysxHcCUaBMmK2ud4e
	VC0BRsHhbhiXFdYMiNf+oKNJLOqw6BZyFkOXcMy42J5xBn3biOr+ATpU4obg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788340292; x=1788426692; bh=ijper6hLjo77qIaBkbdehqskovvmiHnBC1B
	NDK/CjNg=; b=GzH1+gMR0hzWssFbkUzuywjzdutV04/lBJQeCrsyj70Q7E+l4U1
	hJx0C3BmdxOaj51fpONoyiEvNYppAhf/8OiC38ZhMI5a8WcVObq7E4iM/GDznBVA
	mApMbIrNwnqJa6ldVykj0YI+sszpbQifhgOv/1NM4qCLbs+jLbiF0fMKUnBXzqR8
	Pj4m5h5cI24VsNH6TgCeI8f06jfZNaHUNxXTDjmcA3+o14uDuEZAxYdjNNx6WTvE
	vBGMwz3sQVZN6xgrS7vtdeS8V9werXp+WCAsoYQ3hLDRS58QUYA1MEHqV2WjLCYN
	3Abei7hYLsb0YN+cVa0De1ySb2zydoLsY4Q==
X-ME-Sender: <xms:ROiXavLWtWScsRoeoZo5XsItVSDObjDAIx53UDayvI6CqMgS3Ce80A>
    <xme:ROiXapKQNRx0mn51qvVHPkEB6ijb_Px4x9DZ4r8XWfnMn3oqfX3XgI-39GXmu260t
    mKxCKOlmbZLmlKbzODR7agKD25qqUmgqLrgoREYFMn2iFDLbc5URE0>
X-ME-Received: <xmr:ROiXalWwkjmLEffb8piWGz3GHlvojtjUBgliFpZRC7WJxJn8X9J85djIH7XDU5lT4PFubWY>
X-ME-Proxy-Cause: dmFkZTEUSEpIEh9D8txdCyOU67Hs3hk9MsSso5Ue1f5dBGqofBEb5Bw6zjAY1vMtCVdSrL
    J+ck73ChRl2Nl6QbXMtWmS6t3zvVAZv6er4i78htmSEyRZycDW3cYxHxi/2NEo4vYakF+T
    v61gstpbtBUEu7m8cAdMctSXh7a8p3BnOgdTLmsXxMRyGv/9lycnQuBILyKDJMYBvED0yH
    vSwbxj+FdnvLt+I2LQycBP/od8QsEzEnl56VtuX4BTt/co8qLkHFz6n+U7nj8lelGxzsCu
    phgnNqh3KGTPxv5IBRKpSdnCuwmxbAIeNpYoDl58urRsWiWKQqWejKJIPCQwD7ZpPIb0so
    uoV0VjX+B35eixd5yHpN6+mWolJ32S7oFT4+/8IECjWCR8tqUCBQ/DWAtL5L69N0dwNpRz
    AMjqbawVGjUI3fSF6usnzFl2YOjbiqk7sM6nLkMm0K5aC59usvQqqXEh6N4pDR4EOVEjFa
    JS356J0T6i2cikZC8LO/GUR8JUC0VHu2fya0YNbPBv42D/KgSysiiXrD3wHHC3R84r3LL1
    ME3gdxJVVV0CJnavKLr4Vc3uDaAPtgsw7tFBugH8oM56soKt+7jEUUo1UjdAXhnJhcCutW
    4HgpdIbGX4eSux2t7F1kGxb1g1DJBsRZbYtsadawfh4eJH0eGNHlzB9sMO9w
X-ME-Proxy: <xmx:ROiXaji7F7oLCG8iGNN0HiTpaTtGqbzmLpf8cyFqHGLUHSefUUPiWw>
    <xmx:ROiXao-EtZ_p2DyrExoBRTCU9dXqgd55p2c_NJjEQjL53VtgemsnYg>
    <xmx:ROiXalDWzeiIWIhsNKloCCAtdX-JJvRNuJGlRVuUU1xGsVPbMA1qVw>
    <xmx:ROiXatLShNs2gMw-xO_tNfYw0izB-A675rJ3sDTz_wCD5aThbQC-2g>
    <xmx:ROiXalpV9jUFmMdpd6YiSm5_2VoLRK1oxIzD0Y901Bq97u1_tFcWiGVE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 05:11:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6852225b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 09:11:37 +0000 (UTC)
Date: Wed, 2 Sep 2026 11:11:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule--helper: free URL when repository setup
 fails
Message-ID: <apfoO5br4MMZv7nR@pks.im>
References: <20260902055117.GA41587@coredump.intra.peff.net>
 <20260902055730.GB41747@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902055730.GB41747@coredump.intra.peff.net>

On Wed, Sep 02, 2026 at 01:57:30AM -0400, Jeff King wrote:
> If repo setup fails, we'll return an error without freeing the allocated
> url string, leaking the memory. The test suite does trigger this error,
> but never with the leak. We only allocate a url if submodule_from_path()
> returned something, but our tests use other situations, like totally
> nonexistent submodules.
> 
> We can cover this case by asking about a submodule that exists but which
> has not been initialized. The new test fails with SANITIZE=leak.
> 
> The smallest fix would just be a call to free(url), but I think it's a
> little nicer to set up a dedicated out-path for cleanup here. The
> previous commit made it safe to call repo_clear() even if
> repo_submodule_init() fails.

Agreed.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/submodule--helper.c             | 10 +++++++---
>  t/t7426-submodule-get-default-remote.sh | 17 +++++++++++++++++
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index e7cd3225fa..469e3dbcc9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -80,6 +80,7 @@ static int get_default_remote_submodule(const char *module_path, char **default_
>  	struct repository subrepo;
>  	const char *remote_name = NULL;
>  	char *url = NULL;
> +	int ret = 0;
>  
>  	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), module_path);
>  	if (sub && sub->url) {

Nit, feel free to ignore: do we want to keep the value uninitialized
and...

> @@ -96,9 +97,11 @@ static int get_default_remote_submodule(const char *module_path, char **default_
>  	}
>  
>  	if (repo_submodule_init(&subrepo, the_repository, module_path,
> -				null_oid(the_hash_algo)) < 0)
> -		return die_message(_("could not get a repository handle for submodule '%s'"),
> +				null_oid(the_hash_algo)) < 0) {
> +		ret = die_message(_("could not get a repository handle for submodule '%s'"),
>  				   module_path);
> +		goto out;
> +	}
>  
>  	/* Look up by URL first */
>  	if (url)
> @@ -108,10 +111,11 @@ static int get_default_remote_submodule(const char *module_path, char **default_
>  
>  	*default_remote = xstrdup(remote_name);
>  

... set it to 0 here? Many compilers would warn in case the value was
uninitialized, which ensures that the return value is being explicitly
set before every `goto out`.

> +out:
>  	repo_clear(&subrepo);
>  	free(url);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int module_get_default_remote(int argc, const char **argv, const char *prefix,
> diff --git a/t/t7426-submodule-get-default-remote.sh b/t/t7426-submodule-get-default-remote.sh
> index b842af9a2d..0379c9f044 100755
> --- a/t/t7426-submodule-get-default-remote.sh
> +++ b/t/t7426-submodule-get-default-remote.sh
> @@ -60,6 +60,23 @@ test_expect_success 'get-default-remote fails with non-submodule path' '
>  	)
>  '
>  
> +test_expect_success 'get-default-remote fails with uninitialized submodule' '
> +	test_when_finished "
> +		git -C super config -f .gitmodules --remove-section submodule.uninitialized &&
> +		git -C super update-index --force-remove uninitialized
> +	" &&

I was about to say we could use `test_config` instead, but you're of
course not modifying the normal ".git/config" file but ".gitmodules".

> +	(
> +		cd super &&
> +		git config -f .gitmodules submodule.uninitialized.path uninitialized &&
> +		git config -f .gitmodules submodule.uninitialized.url ../sub &&
> +		head=$(git -C ../sub rev-parse HEAD) &&
> +		git update-index --add --cacheinfo 160000,$head,uninitialized &&
> +		test_must_fail git submodule--helper get-default-remote \
> +			uninitialized 2>err &&
> +		test_grep "could not get a repository handle" err
> +	)
> +'

Thanks!

Patrick
