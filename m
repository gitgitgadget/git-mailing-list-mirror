Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4C30C144
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783868677; cv=none; b=s+h48vt+gEMbiNSU7MqMZQPrPRWrwzWfZtz0EiK3HsS1UeGzuRW6u4BUYdXcp4AHqrtA3yWIiaB5Y3TbmHk5RPxCyrymsovy3j9zqNLFb/kZfJ8WEbSd0r2nwgmV6/Hwv697B7RVaFfPUzh8bbKYQALoO+tbvlKYfszMqMEG4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783868677; c=relaxed/simple;
	bh=6AwTz7AetHyLTS6kMz7wM8u9I4l0NFPlVBlmR84YGTo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=PKp+5AUkJEdxgdMN2mnCou9pkDEOoOEG1y7Aj8jWjshSBQbmbiNEzXqUYoCgKlxWpHf6Pkakj5O2GHgY959RjGpf8X+59LvHwMIN7+gF4Zk3QI+E4DfNapaQoAnRKvy3Ud5Y1fxKurDvQDw+Wzie1rYosV1bQf5lat8vv08c9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UghEOoXn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UghEOoXn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso18419655e9.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783868675; x=1784473475; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vQuvdOvvfqoUgfwxwA4gOisMlyp4IaUJZyzVOZjytLo=;
        b=UghEOoXnRe16k5GYARdSuOBVI22psJj1QiGb3XQtVKkBBktgPADcTlO/pYzba28BCY
         jjD1VaBS90LGRCqwoFGZoDM0JXOOcfUj5kZgssVxstQZJgK5AvOapGipUpwreBG82ETc
         V1ZsC10TY0SadojzH3DWCKtmpVFIuO5iEy4L2ErJY+cTgF4vnpR/8y2lxhCPT9kTp2gM
         SbZENclGbMmNK7copspboF9/zqK/+IOwe5DlNxcyy+KdcApzymKPnH20jitW2SjNlYUl
         ZKItoHL8v3Ysa5IAvT2/eZxHZB60qtGO02gl1X+5EAUqZchM0IdfgPdDsj+dshEWSfJE
         Itpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783868675; x=1784473475;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQuvdOvvfqoUgfwxwA4gOisMlyp4IaUJZyzVOZjytLo=;
        b=gMwoSvG67eY8jmkrhG2UfeZq+igLKxNm8VhS0OIkkDTZ+iJy2Fo/Mf+skK9mjrDKTM
         nd4/MVPVxna3IpcEZsCvuwIntiI4vNd2NichgYT4jR2eWSnPgf4vFGXxNsAWpv43y/jy
         l0vTpYVzemang/YcXohc2PTyBEC3uX+O+G6BwQMB9AN77EeNqHJD9tGeKdv5QN3G9cdW
         Swge5LLMkB5yjUbLZ3gMNzu6gOI/PKs753cs22UVI5qG7JtcWOApdLM7edAaXzMUHxqz
         fNpd84TZkSJtWnBpbnZyMDnoBS7VeTALSmVdBweON39A0MKafS9KnjGdqgKPjpXpkZlS
         nEHg==
X-Forwarded-Encrypted: i=1; AHgh+RoiMS7zPaB1d9zQsHthK8+RM49E+I59slbXKiNiUZ5XdUlPRYm9pusJ7kpeemRcBVjetkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZXKSjUGOH/ylLscJLV5rTsJZPM5UwFL5lD2xhzt9qSYlvK97
	h2+KSxuKRkD3uQSCvZvn93jrWwVc0RJEqaoVMn7gPqf1N1NVoFbrcRIu
X-Gm-Gg: AfdE7cmZZRV7TM/9vXTWE/pmH1E5QHhetGvmVt34x1OLvRouWuo6nHthTXcX4d7NtRd
	zmO6IKwwxADnIlTQcaFqe/cgv/I/1cD4R8kLKaOWVx82zUOinIRccdCLZqf8VVXTVkbUqvZX1YL
	OGl8NvT3s6XHs5pdJxnWOz+nDUpEu+z0wITR7a4gBb5Lf+vFAMRFtVaf+eRX7W1KZR06zx6a7Wt
	YbIc7/Z5GMgBpDTTeIiXzdR6BqeS3dwdrt9nBzI44F1mtxau4a4YyqFs5KI0XCb6ocqhuNxWraJ
	kbZkXlwV94EzYNKY6MLroNSXV0grHXRtxqyObjEMWQsdYNo8dSALsl7COmTXH88MHalLUyWrloF
	Pd+Vy4+d/G2vueXk0tNhq1GNL9np7eQWwOX1cyA49drHwkrmn/sf/xXJRWJABf7IDclPgXNqo8V
	FhStNxqepqiqDjwXxkXOMiLsQoWjL6qA779kIFz/SUcYUcVvVGC9eVqr5H8gxDwXv8Z5KK2Eq93
	ihwFxQ7gJSh06IRobwNmQBfD2UW+uXcYPpkMX6Xr/ruT5unM2kEQnicJamNfpOpn9SJFgdse2cP
	xZw7oyMi5gaAyeUzdDVFRrtk+8BQ38mIa7vgJ373ntpi4acT6v58gv9PEt+1AFkLlm6QNQ==
X-Received: by 2002:a05:600c:4444:b0:493:e46e:157d with SMTP id 5b1f17b1804b1-493f88243aemr58764855e9.19.1783868674550;
        Sun, 12 Jul 2026 08:04:34 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e77c2esm168329515e9.2.2026.07.12.08.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 08:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 17:04:33 +0200
Message-Id: <DJWOO33P3Y4G.3QMT23XDJFIFV@gmail.com>
To: "Tian Yuchen" <cat@malon.dev>, <git@vger.kernel.org>
Cc: <pabloosabaterr@gmail.com>, <cirnovskyv@gmail.com>,
 <szeder.dev@gmail.com>, "Christian Couder" <christian.couder@gmail.com>,
 "Ayush Chandekar" <ayu.chandekar@gmail.com>, "Olamide Caleb Bello"
 <belkid98@gmail.com>
Subject: Re: [PATCH v10 6/9] environment: migrate apply_default_whitespace
 and apply_default_ignorewhitespace
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260709161145.13349-1-cat@malon.dev>
 <20260712111734.1073514-1-cat@malon.dev>
 <20260712111734.1073514-7-cat@malon.dev>
In-Reply-To: <20260712111734.1073514-7-cat@malon.dev>

On Sun Jul 12, 2026 at 1:17 PM CEST, Tian Yuchen wrote:
> The global variables 'apply_default_whitespace' and
> 'apply_default_ignorewhitespace' are used to store the default
> whitespace configuration for 'git apply'. Move these variables
> into 'struct repo_config_values' to continue the libification
> effort.
>
> Dynamically allocated strings fetched via 'repo_config_get_string()'
> are now tracked per-repository and safely freed in
> 'repo_config_values_clear()'.
>
> As part of this transition, update 'git_apply_config()' to accept a
> 'struct repository *' argument rather than relying on the
> 'the_repository' global.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  apply.c       | 20 ++++++++++++--------
>  environment.c |  6 ++++--
>  environment.h |  4 ++--
>  3 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 249248d4f2..66db9b7678 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -47,11 +47,13 @@ struct gitdiff_data {
>  	int p_value;
>  };
>
> -static void git_apply_config(void)
> +static void git_apply_config(struct repository *repo)
>  {
> -	repo_config_get_string(the_repository, "apply.whitespace", &apply_defau=
lt_whitespace);
> -	repo_config_get_string(the_repository, "apply.ignorewhitespace", &apply=
_default_ignorewhitespace);
> -	repo_config(the_repository, git_xmerge_config, NULL);
> +	repo_config_get_string(repo, "apply.whitespace",
> +			       &repo_config_values(repo)->apply_default_whitespace);
> +	repo_config_get_string(repo, "apply.ignorewhitespace",
> +			       &repo_config_values(repo)->apply_default_ignorewhitespace);

Same pattern, let's call repo_config_values() once.
Also, similar to the previous patches, shouldn't be here a
FREE_AND_NULL() before each repo_config_get_string() call?

> +	repo_config(repo, git_xmerge_config, NULL);
>  }
>
>  static int parse_whitespace_option(struct apply_state *state, const char=
 *option)
> @@ -126,10 +128,12 @@ int init_apply_state(struct apply_state *state,
>  	strset_init(&state->kept_symlinks);
>  	strbuf_init(&state->root, 0);
>
> -	git_apply_config();
> -	if (apply_default_whitespace && parse_whitespace_option(state, apply_de=
fault_whitespace))
> +	git_apply_config(repo);
> +	if (repo_config_values(repo)->apply_default_whitespace &&
> +	    parse_whitespace_option(state, repo_config_values(repo)->apply_defa=
ult_whitespace))
>  		return -1;
> -	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(sta=
te, apply_default_ignorewhitespace))
> +	if (repo_config_values(repo)->apply_default_ignorewhitespace &&
> +	    parse_ignorewhitespace_option(state, repo_config_values(repo)->appl=
y_default_ignorewhitespace))
>  		return -1;
>  	return 0;
>  }
> @@ -192,7 +196,7 @@ int check_apply_state(struct apply_state *state, int =
force_apply)
>
>  static void set_default_whitespace_mode(struct apply_state *state)
>  {
> -	if (!state->whitespace_option && !apply_default_whitespace)
> +	if (!state->whitespace_option && !repo_config_values(state->repo)->appl=
y_default_whitespace)

We should extract cfg from repo_config_values() to avoid this overly
long line.

>  		state->ws_error_action =3D (state->apply ? warn_on_ws_error : nowarn_w=
s_error);
>  }
>
> diff --git a/environment.c b/environment.c
> index 1a26c9c6d6..41ba013c86 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -49,8 +49,6 @@ int assume_unchanged;
>  int is_bare_repository_cfg =3D -1; /* unspecified */
>  char *git_commit_encoding;
>  char *git_log_output_encoding;
> -char *apply_default_whitespace;
> -char *apply_default_ignorewhitespace;
>  int fsync_object_files =3D -1;
>  int use_fsync =3D -1;
>  enum fsync_method fsync_method =3D FSYNC_METHOD_DEFAULT;
> @@ -727,6 +725,8 @@ void repo_config_values_init(struct repo_config_value=
s *cfg)
>  	cfg->editor_program =3D NULL;
>  	cfg->pager_program =3D NULL;
>  	cfg->askpass_program =3D NULL;
> +	cfg->apply_default_whitespace =3D NULL;
> +	cfg->apply_default_ignorewhitespace =3D NULL;
>  	cfg->apply_sparse_checkout =3D 0;
>  	cfg->branch_track =3D BRANCH_TRACK_REMOTE;
>  	cfg->trust_ctime =3D 1;
> @@ -746,4 +746,6 @@ void repo_config_values_clear(struct repo_config_valu=
es *cfg)
>  	FREE_AND_NULL(cfg->editor_program);
>  	FREE_AND_NULL(cfg->pager_program);
>  	FREE_AND_NULL(cfg->askpass_program);
> +	FREE_AND_NULL(cfg->apply_default_whitespace);
> +	FREE_AND_NULL(cfg->apply_default_ignorewhitespace);
>  }
> diff --git a/environment.h b/environment.h
> index a2e9def89d..553f87adee 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -94,6 +94,8 @@ struct repo_config_values {
>  	char *editor_program;
>  	char *pager_program;
>  	char *askpass_program;
> +	char *apply_default_whitespace;
> +	char *apply_default_ignorewhitespace;
>  	int apply_sparse_checkout;
>  	int trust_ctime;
>  	int check_stat;
> @@ -182,8 +184,6 @@ extern int has_symlinks;
>  extern int minimum_abbrev, default_abbrev;
>  extern int ignore_case;
>  extern int assume_unchanged;
> -extern char *apply_default_whitespace;
> -extern char *apply_default_ignorewhitespace;
>  extern unsigned long pack_size_limit_cfg;
>
>  extern int protect_hfs;

The rest LGTM.

Regards,
Pablo
