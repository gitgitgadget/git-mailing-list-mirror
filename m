Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442637DE8B
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256573; cv=none; b=paHr8xX9onhRNiXZ1zdWxOrWV5ViUzeXV+cNDCoE4glrrBhcfXfLJGwf/DlGC+ErShlgjpolPAVlZ5PaBjKoPdgPnxHRs1jnPq24bpq4QPEpULS8nu+tfqdqWudSNklqArGq4/R1ump1e1CnpmuEtoPVkICIB1QM1jEFJlEz+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256573; c=relaxed/simple;
	bh=fKM8VUdJtomCCX/WW0GoM2PGTOgOFRd3Af0zdoaEAgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOBVi2+Cz2oYlVUv3M1xIc3SsZFxi9oh32jGPkren9t1FPDNljUStkEVzgr3umGU8bih7dZJGckGqJB7RBcQj5XhYG9c9XKy8jhM4Ua8tCJSqnrIMkqS+Tjwjcv2EfLL5dHUuSlESNlMTelw/e+FzHSSPA4JL3YR5YvAqfIqqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwMyFz3T; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwMyFz3T"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-448b69cfc6dso3512383fac.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785256571; x=1785861371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eEsgFOp3n8tm7R1y9L/DUxDn8RW548wUHBZUCeaigGY=;
        b=PwMyFz3TL3BosL+Rtk2tHwA6YAzXeQyDq7+Y5lu019kbK7xu1zHPN5zTqmIg4nf1qC
         Cmw9/3/CC2NDCEKoIM98tRwG5XKEwcZgGpFFdZjCMTulOnE6EzboN6ocduSWZgK4KR8t
         3IGumFe9maUGCc/BmCx86PRNccG8Yndg6zu4Irnv2BQpSbOYqhU3JqlKpoG+aD5ND9km
         oC0FskLqMGFA6CEJwAja7ym4Wviq6plKfTkiqDIiDKP5L0W3SrjpsFiv4i3wAAtY0K6R
         gSlS7XGFmtSjgXgmMmU6CCBiI7gTOJa+ast7pLwqsnzevt72o/zbQ046DFNoOETukaPy
         Foxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785256571; x=1785861371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEsgFOp3n8tm7R1y9L/DUxDn8RW548wUHBZUCeaigGY=;
        b=Yh2kq0ZvM9p0qmKZgEsCr7z/9ZXV8nSV1PV46aiPF0NiMV8mx+EyP6dl7K1HbDPWkK
         hokVbqao75M9tyOazMEySya2WzOuslYDXvryuaXygHR/WHBsqED87XQLAKQ5UmXly0Hn
         NTLIW7bhYSg9C1+TQsM/I9/FpUGxmZAU3Hefsv2k65+3SC4klqar/e0LDCAsthAnU2FF
         hOWfmKJT7arDnsLdFVXCuOqqZEjYLTOqQO0E/eHO0C41yHe3AgXTvMbyUuX57H/e7dx+
         JwsmVounhX16WfT9bUmoUMkuXMuXFXKqaqtHQ4D2AxXY6MnqPWv951PDcpF1oL9SC4mM
         ORLw==
X-Gm-Message-State: AOJu0YyNzReBYIoIlNbuws7rM/zZU87xmzUfNiaCebI+N48V6goJzAl/
	4SmuDvUxkvF8dg0GwmElJGltGl2cMoQO0ZcKL3bBP39WWN17GE3faMRw
X-Gm-Gg: AR+sD10JAaeKrP7lsro1T+PcJRq+OAu9cjJdkXPjh8ewRzvDzB3BiZ5Af6Rr8DzeFwo
	R6mBqx9myygLIckEKQx8Bvxv3T1M+vGZTM6Lcx3sQC/ae3hZHtr4dE6ybWB8p60VX47zuVvlBQv
	Ae4IU775xIM+OgCMfzLV2HhbZvOw5XfFhQoTwvEXtuceC6JwK8Qn/B5868lWNLXdpmPI8nTHP2F
	BobVzbXt8Y+QIini44jAmpDhxZmJKfw2nCajEX7iNa8385BOxVxHzqbUVRP+ut7qRLvHHn6r3st
	/QICbqm/kN+0Mf56xhfIxn9EE5gvCUjJ+hE77RMUEAWDSrymjhSJ/n87+kPXOr5nGEjNedUYBwt
	WdKiMQNLAaAxtXX2IUKmzQ91h92PJWCKPIgcISoD1gDWZBU9yqEfjZl73TdGMs5tUPil3g3Y=
X-Received: by 2002:a05:6871:68e:b0:448:75b1:9c8a with SMTP id 586e51a60fabf-4586c98447cmr1739733fac.16.1785256571120;
        Tue, 28 Jul 2026 09:36:11 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458864c8a5bsm338928fac.8.2026.07.28.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:36:10 -0700 (PDT)
Date: Tue, 28 Jul 2026 11:36:04 -0500
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, lucasseikioshiro@gmail.com
Subject: Re: [PATCH v3 1/7] repo: add path.toplevel with absolute and
 relative suffix formatting
Message-ID: <amjUPEgenletgbp5@denethor>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-2-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726104343.16933-2-jayatheerthkulkarni2005@gmail.com>

On 26/07/26 04:13PM, K Jayatheerth wrote:
> Scripts frequently need to find the root directory of a repository's
> working tree. Currently, this requires using `git rev-parse --show-toplevel`
> or inferring it from other path components.
> 
> Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
> to `git repo info`. This allows scripts to retrieve the top-level
> working tree path in a predictable, strictly formatted manner without
> relying on `rev-parse`.

Ok, this seems like suitable information to also look up under
git-repo-info.

> If requested in a bare repository where no working tree exists, the
> command returns an empty string.

This matches the existing behavior in git-rev-parse(1). Makes sense.

> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/git-repo.adoc | 10 ++++++++++
>  builtin/repo.c              | 28 ++++++++++++++++++++++++++++
>  t/t1900-repo-info.sh        | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index ed7d80c690..e34abe5fea 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -119,6 +119,16 @@ values that they return:
>  `path.gitdir.relative`::
>  	The path to the Git repository directory relative to the current working directory.
>  
> +`path.toplevel.absolute`::
> +	The canonical absolute path to the top-level directory of the
> +	repository's working tree. Outputs an empty string if the repository
> +	is bare.
> +
> +`path.toplevel.relative`::
> +	The path to the top-level directory of the repository's working
> +	tree relative to the current working directory. Outputs an empty
> +	string if the repository is bare.
> +
>  `references.format`::
>  	The reference storage format. The valid values are:
>  +
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 042d6de558..194757eb18 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -121,6 +121,32 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
>  	return 0;
>  }
>  
> +static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *work_tree = repo_get_work_tree(repo);
> +
> +	if (!work_tree) {
> +		strbuf_addstr(buf, "");

The strbuf here is already NULL-terminated when its initialized. I don't
think this should be necessary.

> +		return 0;
> +	}
> +
> +	format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_CANONICAL);
> +	return 0;
> +}
> +
> +static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *work_tree = repo_get_work_tree(repo);
> +
> +	if (!work_tree) {
> +		strbuf_addstr(buf, "");

Same here.

> +		return 0;
> +	}
> +
> +	format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_RELATIVE);
> +	return 0;
> +}
> +
>  static int get_references_format(struct repository *repo, struct strbuf *buf)
>  {
>  	strbuf_addstr(buf,
> @@ -137,6 +163,8 @@ static const struct repo_info_field repo_info_field[] = {
>  	{ "path.commondir.relative", get_path_commondir_relative },
>  	{ "path.gitdir.absolute", get_path_gitdir_absolute },
>  	{ "path.gitdir.relative", get_path_gitdir_relative },
> +	{ "path.toplevel.absolute", get_path_toplevel_absolute },
> +	{ "path.toplevel.relative", get_path_toplevel_relative },
>  	{ "references.format", get_references_format },
>  };
>  
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index ae8c22c817..fbb9063ee5 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -213,4 +213,34 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
>  	'.git' \
>  	'GIT_DIR="../.git" && export GIT_DIR'
>  
> +test_expect_success 'path.toplevel absolute and relative' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		mkdir -p repo/sub &&
> +		cd repo/sub &&
> +
> +		ROOT="$(test-tool path-utils real_path ..)" &&
> +
> +		echo "path.toplevel.absolute=$ROOT" >expect.abs &&
> +		git repo info path.toplevel.absolute >actual.abs &&
> +		test_cmp expect.abs actual.abs &&
> +
> +		echo "path.toplevel.relative=../" >expect.rel &&
> +		git repo info path.toplevel.relative >actual.rel &&
> +		test_cmp expect.rel actual.rel
> +	)
> +'
> +
> +test_expect_success 'path.toplevel returns empty in a bare repository' '
> +	test_when_finished "rm -rf bare.git" &&
> +	git init --bare bare.git &&
> +	(
> +		cd bare.git &&
> +		echo "path.toplevel.absolute=" >expect &&
> +		git repo info path.toplevel.absolute >actual &&
> +		test_cmp expect actual

In this test we are only checking the absolute path. It probably
wouldn't hurt to also check the relative path too.

-Justin
