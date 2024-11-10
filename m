Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0966E224FD
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731275235; cv=none; b=gsA0U7qXFLSjPWUq1yr4DP0+/6InlDKIWawkbRqo4hzmnzTC3Vv8fIPmM3HQKy2LinAw1gMK6mYxvmA/EynfPAMZ9i+1s1V0scNAyJDPhaMTG9qlmfR9pY2GnXEynBtibgZSWObqS2dhPw6RNnCWijT+NKbTdcvZiqnP40QiZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731275235; c=relaxed/simple;
	bh=9XMg20x2ZxOhuETmb5dFmBeRDReSLbYZAZVIxUZzXc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DUW1RijxDbWxO35MoRIzj+IV2aDWKpjUrxJig1/SmcYY/SrZ/9YZh8iT8H5+ypCN8h4JTSW0kfm+OoqNcNJCgNxumUjGaAOZwWEv31PTw4JUlfCRTWxrKeMhfVzUe+ratUamAarLeAUL0bdcM2lsC5DXPmtVvcz5ie32DTW55zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SU8stnf6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SU8stnf6"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43193678216so37347675e9.0
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 13:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731275232; x=1731880032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/p9eu+eADkcvmzad2lN7Jg7e0HfQWqb40zyGRuj6Rlo=;
        b=SU8stnf6+Rb6sSW6mjHp2xXjNW/6Cb0/TJbXerdyalEtMFPL7OXzea0uhfFV0DdiKw
         /+taNUTRug7cOd0mywnLF83j32c1SsHM4Ka3n7TnU7EfyWQ79229V66aUpSXQg58Wsbh
         UFy4XedD4c2NpiQPmj3opDpXlsowIbvMykzNbCTlHwAbMLbm1Aj3/VeE59li/2mmhhLv
         WDmUGyPGs5uBjgvMvK1DE6I+Oki0Zr9aSKP56cExsDhIbGo6EmpVXpS1Og3ncpf2vkv0
         swiGNBd/BCcOC9llsYjrBzh+WFGUxYj0yLlOZXU0SDMJsq/2Lps2Ag+UBbrO89jQnhY/
         jjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731275232; x=1731880032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/p9eu+eADkcvmzad2lN7Jg7e0HfQWqb40zyGRuj6Rlo=;
        b=UsIIIhIPkoa8H1ckAJmEN3X8+9z9Guo/Tm1VazoA4E53NDn4cnn+/ZhGtf9uW6Y/Ns
         UOqBxV/0jzur5ReakWiVlloOo8LoL+vqgWu2apYHO69Z2ovkdcENNgFFs5JCRsGligxu
         A0Z4L1/YTfowjqfC437LgWwyH12tng2dQOZH1Pb8Twf/kywj1f5oOsfbj2cja2gNnSni
         ILfKzad4MB9UleV+4DZGXIFgR6IuxuFh1HMQ53oVsHJaG/Oq5UqYHPs5olx3HiWkFILH
         HLUzrm84fuHvFdeuSi5JgEpL0UqPtAy7JyVlAuG928hqtEQZ6BdkdNl21QuPy3OYDuHo
         B5wg==
X-Forwarded-Encrypted: i=1; AJvYcCXhl88NmAor8xxD6rE1HLXYM/NEFpxevxKE27+5dVKJMPSpCBRIxJ3aoMAIUe2C5YlqeWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5XenXRIGuhCUdgGhNip2JcfaYwdBkAgsYjX4BtFmofk2LMEBW
	J1SsQv/BqEB9UdokT4sKMes5RSHN9ZxIph+tM5WVyiJ5Pp9dtsmwzDKGOw==
X-Google-Smtp-Source: AGHT+IGKe8mt4Pe9nc0M1i8BSf11c0ZIJSvpsHE1ONRrzIBfE1236aQQF2didMrQhGdUbKgyL/h1wA==
X-Received: by 2002:a05:600c:5493:b0:42e:75a6:bb60 with SMTP id 5b1f17b1804b1-432b7508b8amr92035445e9.19.1731275232272;
        Sun, 10 Nov 2024 13:47:12 -0800 (PST)
Received: from gmail.com ([178.237.229.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa709f3fsm195250335e9.32.2024.11.10.13.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 13:47:11 -0800 (PST)
Message-ID: <5d18abb7-52a1-41d0-8207-066a012d41e7@gmail.com>
Date: Sun, 10 Nov 2024 22:47:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/26] builtin/init-db: fix leaking directory paths
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1730901926.git.ps@pks.im>
 <256427084f63c9b2141bd468d633ee4d079fd33f.1730901926.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <256427084f63c9b2141bd468d633ee4d079fd33f.1730901926.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Nov 06, 2024 at 04:11:11PM +0100, Patrick Steinhardt wrote:
> We've got a couple of leaking directory paths in git-init(1), all of
> which are marked with `UNLEAK()`. Fixing them is trivial, so let's do
> that instead so that we can get rid of `UNLEAK()` entirely.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/init-db.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 7e00d57d654..9e069e27426 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -75,10 +75,12 @@ int cmd_init_db(int argc,
>  		const char *prefix,
>  		struct repository *repo UNUSED)
>  {
> -	const char *git_dir;
> +	char *git_dir;
>  	const char *real_git_dir = NULL;
> -	const char *work_tree;
> +	char *real_git_dir_to_free = NULL;
> +	char *work_tree = NULL;
>  	const char *template_dir = NULL;
> +	char *template_dir_to_free = NULL;
>  	unsigned int flags = 0;
>  	const char *object_format = NULL;
>  	const char *ref_format = NULL;
> @@ -106,6 +108,7 @@ int cmd_init_db(int argc,
>  			   N_("specify the reference format to use")),
>  		OPT_END()
>  	};
> +	int ret;
>  
>  	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
>  
> @@ -113,12 +116,10 @@ int cmd_init_db(int argc,
>  		die(_("options '%s' and '%s' cannot be used together"), "--separate-git-dir", "--bare");
>  
>  	if (real_git_dir && !is_absolute_path(real_git_dir))
> -		real_git_dir = real_pathdup(real_git_dir, 1);
> +		real_git_dir = real_git_dir_to_free = real_pathdup(real_git_dir, 1);
>  
> -	if (template_dir && *template_dir && !is_absolute_path(template_dir)) {
> -		template_dir = absolute_pathdup(template_dir);
> -		UNLEAK(template_dir);
> -	}
> +	if (template_dir && *template_dir && !is_absolute_path(template_dir))
> +		template_dir = template_dir_to_free = absolute_pathdup(template_dir);
>  
>  	if (argc == 1) {
>  		int mkdir_tried = 0;
> @@ -192,7 +193,7 @@ int cmd_init_db(int argc,
>  	 * Set up the default .git directory contents
>  	 */
>  	if (!git_dir)
> -		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
> +		git_dir = xstrdup(DEFAULT_GIT_DIR_ENVIRONMENT);
>  
>  	/*
>  	 * When --separate-git-dir is used inside a linked worktree, take
> @@ -213,6 +214,7 @@ int cmd_init_db(int argc,
>  			if (chdir(mainwt.buf) < 0)
>  				die_errno(_("cannot chdir to %s"), mainwt.buf);
>  			strbuf_release(&mainwt);
> +			free(git_dir);
>  			git_dir = strbuf_detach(&sb, NULL);
>  		}
>  		strbuf_release(&sb);
> @@ -245,12 +247,14 @@ int cmd_init_db(int argc,
>  			set_git_work_tree(work_tree);
>  	}
>  
> -	UNLEAK(real_git_dir);
> -	UNLEAK(git_dir);

We were doing this, out of simplicity, even in cases where it wasn't
necessary ...

> -	UNLEAK(work_tree);

... and this line is now the `free()` we are doing below.

OK.  Nice clean up.

> -
>  	flags |= INIT_DB_EXIST_OK;
> -	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
> +	ret =  init_db(git_dir, real_git_dir, template_dir, hash_algo,
>  		       ref_storage_format, initial_branch,
>  		       init_shared_repository, flags);
> +
> +	free(template_dir_to_free);
> +	free(real_git_dir_to_free);
> +	free(work_tree);
> +	free(git_dir);
> +	return ret;
>  }
> -- 
> 2.47.0.229.g8f8d6eee53.dirty
> 
