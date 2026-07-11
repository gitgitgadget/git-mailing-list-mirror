Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748A913A244
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783794074; cv=none; b=W63cELt3DrSI7xqQrieQHZ9MlkfXm/peLNO5uxmRFX/mwq+BWfDlbayoUotYDm9EFUAdxQBD0tC/77Whyu/uTIHZQBib3e/KBo0vzAtI46edGRlg7WEHQF3rBl4UGET+MVWxgsfIfxX6AKXi49/PDe0noMzXdqt7VjQiohnUKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783794074; c=relaxed/simple;
	bh=/XnUHHO0yc+yg0ZIp7ulRolrFQv+UqWm2F5IAzZbxN8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=WsFqA2T2RUg5/pPx4uZavqeM1E9C1A6FgZrujYJJ3BwIlOSYNdRLsy1F7WSjt8DtGXKum/fzGwptuN/Zx1z6tS09X6b4AA1QgoICiugqId3v5+IMGBl4Fj+1jJXpLwg6YNEb774S8NNUo5zGvPEQZw1DpxPvcH2zKiFseZPF7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0mllEqd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0mllEqd"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-472326ca506so1495996f8f.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783794071; x=1784398871; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pgBtBrjAnoE9P15/zDp3Fn/xeHOIj+0akrv+W2J8mbk=;
        b=k0mllEqdknTYM2BU3ivFPvEHqlEQ6un/nr8jaFFjFpEvSm45InjnYOdG355lPftWQO
         dFSEFSJj65BWaVBPPmucB3LpM0a8pmKPazBt71e2UqyWhuJ7e8hSJ+EqQR3JkWLXYTSa
         5vUvn+MGkv1Hxl0Cp+tYxax2B3o5ySwEUrEYlJbwWzXO/EFAbLDq7LUqYF6o19rortbV
         CaKTAUOsgBiKiXpA0BZkNxLj5WPVwx0kVEJcQ+zAVnMYGnPGENIuSFBk71D37MUXipW8
         DNtQs6XguNx3OZdQAKS22oDHTlPSCNQA8suLPPEzuXXvoO6AR4Yg9zML7CqRoetuz3M8
         Imug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783794071; x=1784398871;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgBtBrjAnoE9P15/zDp3Fn/xeHOIj+0akrv+W2J8mbk=;
        b=RYdibGGTVUB8+9LSxp9FIpO0fHcAB2UDjE+i/DTyf41ZVHKuN5hGW+rlNlk+RiymrG
         Bq2MiMvXOMhUUT6jUDp+4vg0w2nl3ZqoDm9MTbkpqgCqUKvPfaG0tcfMk0Bh+nKAklMf
         rIdkuWpL2us13lp0ngen2NgNV4Q5t8bwVszjyc93XuaGUoSgIeukwg5xV5sM5o70iC3X
         vrUdinc3Kmd4fXXZEqRYyKm2I1ZSjOO9SyAZ52PNG4MIuA20yT3fvwWLl/Pk7jQWylEr
         KJcd+2uUicQ+V/l+7sTnkD3IeWR15holaRKmAtfbOgtOM9dIEbFZHRndeV/KV38rDo58
         bfSQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgQXgpoLi5ym8GYutIWiZGTV3DteUGxbZ9k1TW2FSR+cVabPHzjo/6zOBnwckKFiVZJ1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz76iV+gizULS3cblNEnFyrahyms9ZuJzhoxeBfprcMYZjdGYXZ
	O1hv/rMH64PavmEYUIF3OLXA/ubPWIRVaGVqldFbaYTkMU4tF+lSzPr+
X-Gm-Gg: AfdE7cn5qolqjR7Z7UYcs/uKBo6NKnoRiKVyh4R1GcFq/75uOpfrMLD8qNf+PjqlpDY
	Z3R5jyyHZdvo760ECvGNCyZTQb4YQfNeHZGD0qUdRx+qQC2OWhlfbC576dKP5DwMDDGfN/q9bSn
	YM5+SG2YOfOX+YNB86KxrAIChYbkbCIPFbDd7XQoFZNr0v83RknmCIFgryfBtZ0AnTNjPWvv+qW
	Bd7HPfBulZoyf8NMeSZTXQz1sg76dkT2nBSttJv4YPQaJOCGsJUReWjaVDOYxQUjhSnFWTgjnrd
	WqUe/hJYGmy2Ug7xoYBMYJ2ZDkp+SMPXTSoKNO2aFv/hnrKgPS3VjWUeAAWgQQMwasE6sxGKSrd
	btJ1I37QEaJdi/DDCIMqgC6VfaKIpE5i1ZY6XJ6yXeZhcjWqaPSiF5pFrsqdD3AJa5d7xLUePSj
	WtZ9xKHRNKznP0O1NqeI0y2I96Tp225dLiMAAn3iIFBWbk5AIFEs/fhFTUz1B7WGlw0IMpmAJLg
	tIXEIOkTDKPccguil/9HYLSCu4KzJXfVBTFvKsqwT5gpRXrBqCm1gEWJHeBdeklBterVnFjlLzd
	QTpV7rixiXcDDtDD2eoiywijKbj91DGM6keyXHy/km1uZDbZOiF8gqM5weytzLqfd5enqA==
X-Received: by 2002:a05:6000:717:b0:47d:df96:c9f4 with SMTP id ffacd0b85a97d-47f2dcb3aa2mr3518414f8f.10.1783794070613;
        Sat, 11 Jul 2026 11:21:10 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm73654061f8f.21.2026.07.11.11.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 11:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 20:21:08 +0200
Message-Id: <DJVY828NHN8O.22CRAQOF73S6D@gmail.com>
To: "Tian Yuchen" <cat@malon.dev>, <git@vger.kernel.org>
Cc: <cirnovskyv@gmail.com>, <szeder.dev@gmail.com>, "Christian Couder"
 <christian.couder@gmail.com>, "Ayush Chandekar" <ayu.chandekar@gmail.com>,
 "Olamide Caleb Bello" <belkid98@gmail.com>
Subject: Re: [PATCH v9 2/9] environment: move excludes_file into
 repo_config_values
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260708160300.8852-1-cat@malon.dev>
 <20260709161145.13349-1-cat@malon.dev>
 <20260709161145.13349-3-cat@malon.dev>
In-Reply-To: <20260709161145.13349-3-cat@malon.dev>

On Thu Jul 9, 2026 at 6:11 PM CEST, Tian Yuchen wrote:
> The global variable 'excludes_file' is used to track the path to the
> global ignore file. If this variable is NULL,
> 'setup_standard_excludes()'

Nit: Strange line break here.

> in 'dir.c' forcefully evaluates and assigns the XDG default path to it.
>
> Continue the libification effort by encapsulating this lazy-loading
> fallback logic into a proper getter and moving the variable into
> 'struct repo_config_values'.
>
> Since 'excludes_file' is a dynamically allocated string, it requires
> proper heap memory management. It is safely freed using the newly
> introduced `repo_config_values_clear()` function when the repository
> is torn down.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  dir.c         |  4 ++--
>  environment.c | 15 ++++++++++++---
>  environment.h |  4 +++-
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 7a73690fbc..4f87a52b3c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -3481,11 +3481,11 @@ static GIT_PATH_FUNC(git_path_info_exclude, "info=
/exclude")
>
>  void setup_standard_excludes(struct dir_struct *dir)
>  {
> +	const char *excludes_file =3D repo_excludes_file(the_repository);
> +
>  	dir->exclude_per_dir =3D ".gitignore";
>
>  	/* core.excludesfile defaulting to $XDG_CONFIG_HOME/git/ignore */
> -	if (!excludes_file)
> -		excludes_file =3D xdg_config_home("ignore");
>  	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
>  		add_patterns_from_file_1(dir, excludes_file,
>  					 dir->untracked ? &dir->internal.ss_excludes_file : NULL);
> diff --git a/environment.c b/environment.c
> index 13677484de..5950592d63 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -57,7 +57,6 @@ enum fsync_method fsync_method =3D FSYNC_METHOD_DEFAULT=
;
>  enum fsync_component fsync_components =3D FSYNC_COMPONENTS_DEFAULT;
>  char *editor_program;
>  char *askpass_program;
> -char *excludes_file;
>  enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
>  enum eol core_eol =3D EOL_UNSET;
>  int global_conv_flags_eol =3D CONV_EOL_RNDTRP_WARN;
> @@ -134,6 +133,14 @@ int is_bare_repository(void)
>  	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
>  }
>
> +const char *repo_excludes_file(struct repository *repo)
> +{
> +	if (!repo_config_values(repo)->excludes_file)
> +		repo_config_values(repo)->excludes_file =3D xdg_config_home("ignore");
> +
> +	return repo_config_values(repo)->excludes_file;
> +}

repo_config_values() returns a pointer so there should be no need to
call the function 3 times.

We could have the function be called once and use it then:

  const char *repo_excludes_file(struct repository *repo)
  {
	  struct repo_config_values *cfg =3D repo_config_values(repo);

	  if (!cfg->excludes_file)
		  cfg->excludes_file =3D xdg_config_home("ignore");

	  return cfg->excludes_file;
  }

> +
>  int have_git_dir(void)
>  {
>  	return startup_info->have_repository
> @@ -461,8 +468,8 @@ int git_default_core_config(const char *var, const ch=
ar *value,
>  	}
>
>  	if (!strcmp(var, "core.excludesfile")) {
> -		FREE_AND_NULL(excludes_file);
> -		return git_config_pathname(&excludes_file, var, value);
> +		FREE_AND_NULL(cfg->excludes_file);
> +		return git_config_pathname(&cfg->excludes_file, var, value);
>  	}
>
>  	if (!strcmp(var, "core.whitespace")) {
> @@ -715,6 +722,7 @@ int git_default_config(const char *var, const char *v=
alue,
>  void repo_config_values_init(struct repo_config_values *cfg)
>  {
>  	cfg->attributes_file =3D NULL;
> +	cfg->excludes_file =3D NULL;
>  	cfg->apply_sparse_checkout =3D 0;
>  	cfg->branch_track =3D BRANCH_TRACK_REMOTE;
>  	cfg->trust_ctime =3D 1;
> @@ -744,4 +752,5 @@ void repo_config_values_clear(struct repository *repo=
)
>  	cfg =3D repo_config_values(repo);
>
>  	FREE_AND_NULL(cfg->attributes_file);
> +	FREE_AND_NULL(cfg->excludes_file);
>  }
> diff --git a/environment.h b/environment.h
> index c4a6a45704..2e8352de7f 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -90,6 +90,7 @@ struct repository;
>  struct repo_config_values {
>  	/* section "core" config values */
>  	char *attributes_file;
> +	char *excludes_file;
>  	int apply_sparse_checkout;
>  	int trust_ctime;
>  	int check_stat;
> @@ -133,6 +134,8 @@ int git_default_config(const char *, const char *,
>  int git_default_core_config(const char *var, const char *value,
>  			    const struct config_context *ctx, void *cb);
>
> +const char *repo_excludes_file(struct repository *repo);
> +
>  void repo_config_values_init(struct repo_config_values *cfg);
>
>  /*
> @@ -217,7 +220,6 @@ extern char *git_log_output_encoding;
>
>  extern char *editor_program;
>  extern char *askpass_program;
> -extern char *excludes_file;
>
>  /*
>   * The character that begins a commented line in user-editable file

The rest looks fine.

Regards,
Pablo
