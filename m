Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AF13A3ED
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590369; cv=none; b=FFM37KoRUPzSQcEviN+w3BCY8+xTERXlpGkL2WXhb+I8rmZEBE/v9S658WVjLdt4Nn7SGcanQDx8R6woKscOUKiQyjfMU20m84nI/GOFXyzowK1BD19l1T4mnLTAmRGXJPkWF+pANdo1OKSh0KYEh2cGFzuASo0VnVA6CLIJeVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590369; c=relaxed/simple;
	bh=9TfYP2xRHN4rf1zH/xLO6EsYEXi3tfHqQSz942NfQK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNGjUNRPYBIEuIbFzwtapIJTEzuFOrHf9APTmgldYW3EInzP1XyeItn5Kr9BUrxpiYMmHgFRXloCGfyzXNXPYZOt09gRHfbA1uui9piaZGZ0iH7wHcO1vH2JelJKBq328biX+wlimxYfRDYPQiTRo9iCAAS9ZL3Tyq9iy447jRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NutX8iJm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c+Xjz0RY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NutX8iJm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+Xjz0RY"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F18D25400C3;
	Mon, 10 Mar 2025 03:06:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Mar 2025 03:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741590363; x=1741676763; bh=SnD6tFKtxE
	mMkNy4+u9hzluPsEiH3kv6hLsMuuJfIK4=; b=NutX8iJm31nS+LxTwLmt59170n
	cdOS3f4Qb1oW67MKLy4dZh4OxaN5fNtPZaAZssOEze+0s2o5vK4MSvbMUjdfMu+U
	42IdoVurAXDXHb+f9T+5OXwLIPllmTNwxIsp/Bpu5uAzx00PBa0qXCCV9E8A5AkU
	growKf16YQTusZTu1UO5dcUNdoW4H/4302smNhZYgtj8tIVwbSHKQtWkPmODSybb
	qoVqL353BdpBNeZTScuXkRXju0hMzeFAtz7YLMUHZ4CAPdOKi2ZgPic1+qWn7X5C
	6AAIz7TtYwdSX3WL/rAHm37/6GfdCyAWHEWLAL5IYlm5OWWp9p7lK0LovFww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741590363; x=1741676763; bh=SnD6tFKtxEmMkNy4+u9hzluPsEiH3kv6hLs
	MuuJfIK4=; b=c+Xjz0RYiTvPuQkj+H7W03e7krpEHoGZtdHsNFqF4kkwRJe6BUA
	gtz4+YNpAmi662J5m6MS7oUR1ufNxnXxQsqPG7gSf3VrUb3t1yzPU15WGcrjNwe1
	g7DMux3wi2S7SDKKioVdXkX6cLK6ZBYJzbLdo/QNzoEH/CUQI/5iU6MI1I5FBB2a
	ru7Hy0fwYLE4ie2rXhsvDuQwHRLC21x8rjBBEY7Uqj+V1+0rNjxsRwmakAbE2I3J
	3tCl69KMNelwbPj6Pf/90vzYVGK6PX/aBxj6KWh9ewqc5ihS6NEQ471OPo0ErjUo
	0uzCktiYw/B+sW7YCQ32uvG3SZm3k5/tK/g==
X-ME-Sender: <xms:W4_OZz1dylRQWORwMJsA5U5R0-IY-ur3YkULuRi59ImSogOltRlaig>
    <xme:W4_OZyGdIAy3c4c0PtLNzQLX7Js6qdsr-YCxu4fII2yOv1YWL7VaAmuQLXcLeTlGO
    dDSDSanpwjm8MpM7w>
X-ME-Received: <xmr:W4_OZz7l2uYE5edXOw-q5peeLR1RwqQGuyo-yBnUNSv4UXNj4ZcaNUV139wtcqwevKh2zNFWqQ1FotwtLuQWz2kTqz2Isvnx6xEPPX44MhKrWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:W4_OZ427NFNiI6h6lQ5oVEWrsdCc7V9cBMlYA0idH4HJ3hfHKZd83A>
    <xmx:W4_OZ2FNNDbrqkBnVfVQf2xBddHlswqpAQgQFEtGFX2hZNb9kQZzaA>
    <xmx:W4_OZ5-0HAa8L0c0N1N-TFY4bAHqvY-SWpdrparij4Exm8e4dd-cmw>
    <xmx:W4_OZzlTsTsl6YEr4ug04lGuuT7sCnwTQY-glp1ekRNXilP3xkubuA>
    <xmx:W4_OZyBvhV_-ZWfTkV9NP7Ojgw2NA9HHOubzauzZ1U8Inz6xdTm70HYg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:06:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d8855fac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:05:59 +0000 (UTC)
Date: Mon, 10 Mar 2025 08:05:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Subject: Re: [PATCH] environment: move access to "core.attributesfile" into
 repo settings
Message-ID: <Z86PUkJ1sbSH2VTU@pks.im>
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309153321.254844-1-ayu.chandekar@gmail.com>

On Sun, Mar 09, 2025 at 09:03:21PM +0530, Ayush Chandekar wrote:
> Stop relying on global state to access the "core.attributesfile"
> configuration. Instead, store the value in `struct repo_settings` and
> retrieve it via `repo_settings_get_attributes_file_path()`.
> 
> This prevents incorrect values from being used when a user or tool is
> handling multiple repositories in the same process, each with different
> attribute configurations. It also improves repository isolation and helps
> progress towards libification by avoiding unnecessary global state.

We typically switch the order around a bit in our commit messages: we
first explain what the actual problem is, and then we say how we fix it.

> diff --git a/attr.c b/attr.c
> index 0bd2750528..aec4b42245 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -879,12 +879,9 @@ const char *git_attr_system_file(void)
>  	return system_wide;
>  }
>  
> -const char *git_attr_global_file(void)
> +const char *git_attr_global_file(struct repository *repo)
>  {
> -	if (!git_attributes_file)
> -		git_attributes_file = xdg_config_home("attributes");
> -
> -	return git_attributes_file;
> +	return repo_settings_get_attributesfile_path(repo);
>  }
>  
>  int git_attr_system_is_enabled(void)

Hm. I wonder what the actual merit of this function is after the
refactoring. Right now there isn't really any as it is a direct wrapper
of `repo_settings_get_attributesfile_path()`.

> diff --git a/attr.h b/attr.h
> index a04a521092..c4f26b8f58 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -213,11 +213,13 @@ void git_check_attr(struct index_state *istate,
>  		    const char *path,
>  		    struct attr_check *check);
>  
> +struct repository;
> +
>  /*
>   * Retrieve all attributes that apply to the specified path.
>   * check holds the attributes and their values.
>   */
> -void git_all_attrs(struct index_state *istate,
> +void git_all_attrs(struct repository *repo, struct index_state *istate,
>  		   const char *path, struct attr_check *check);
>  
>  enum git_attr_direction {
> @@ -233,7 +235,7 @@ void attr_start(void);
>  const char *git_attr_system_file(void);
>  
>  /* Return the global gitattributes file, if any. */
> -const char *git_attr_global_file(void);
> +const char *git_attr_global_file(struct repository *repo);
>  
>  /* Return whether the system gitattributes file is enabled and should be used. */
>  int git_attr_system_is_enabled(void);

I think it would make sense to split out this change into a separate
commit. The first commit would move the config into "repo-settings.c",
the second commit would adapt functions and their callers as necessary.

> @@ -283,4 +285,5 @@ struct match_attr {
>  struct match_attr *parse_attr_line(const char *line, const char *src,
>  				   int lineno, unsigned flags);
>  
> +
>  #endif /* ATTR_H */

Extraneous newline.

> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> index 7cf275b893..1b8a89dfb2 100644
> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -70,7 +70,7 @@ static void check_attr(const char *prefix, struct attr_check *check,
>  		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
>  
>  	if (collect_all) {
> -		git_all_attrs(the_repository->index, full_path, check);
> +		git_all_attrs(the_repository, the_repository->index, full_path, check);
>  	} else {
>  		git_check_attr(the_repository->index, full_path, check);
>  	}
> diff --git a/builtin/var.c b/builtin/var.c
> index ada642a9fe..3d635c235e 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -69,9 +69,9 @@ static char *git_attr_val_system(int ident_flag UNUSED)
>  	return NULL;
>  }
>  
> -static char *git_attr_val_global(int ident_flag UNUSED)
> +static char *repo_git_attr_val_global(struct repository *repo, int ident_flag UNUSED)
>  {
> -	char *file = xstrdup_or_null(git_attr_global_file());
> +	char *file = xstrdup_or_null(git_attr_global_file(repo));
>  	if (file) {
>  		normalize_path_copy(file, file);
>  		return file;
> @@ -79,6 +79,11 @@ static char *git_attr_val_global(int ident_flag UNUSED)
>  	return NULL;
>  }
>  
> +static char *git_attr_val_global(int ident_flag)
> +{
> +	return repo_git_attr_val_global(the_repository, ident_flag);
> +}
> +
>  static char *git_config_val_system(int ident_flag UNUSED)
>  {
>  	if (git_config_system()) {

I think we should just retain `git_attr_val_global()` and plug in
`the_repository`. The extra change here doesn't add anything, and
"builtin/var.c" being a builtin means is not reused anywhere else,
either.

> diff --git a/repo-settings.c b/repo-settings.c
> index 9d16d5399e..420ca72f5f 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -167,3 +168,13 @@ int repo_settings_get_warn_ambiguous_refs(struct repository *repo)
>  			      &repo->settings.warn_ambiguous_refs, 1);
>  	return repo->settings.warn_ambiguous_refs;
>  }
> +
> +const char *repo_settings_get_attributesfile_path(struct repository *repo)
> +{
> +	if (!repo->settings.git_attributes_file) {
> +		if (repo_config_get_pathname(repo, "core.attributesfile", &repo->settings.git_attributes_file)) {
> +			repo->settings.git_attributes_file = xdg_config_home("attributes");
> +		}
> +	}

We don't use curly braces around one-line statements.

> +	return repo->settings.git_attributes_file;
> +}

One thing I'm missing is the code to `free()` the allocated memory in
`repo_settings_clear()`.

> \ No newline at end of file

Nit: missing newline at the end of the file.

Thanks!

Patrick
