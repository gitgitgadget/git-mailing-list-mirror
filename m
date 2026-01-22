Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466C3502BD
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092808; cv=none; b=gltwVcw6v2GB35u4vbp96fpsL9rlH8wTenxgPQjym/6aooeAe8wP7fcySel87DUg3HmJidoFPV+TQ0UQw9zOdDlZ6BNI0IV5HVFoTBjWp6bWHUS+n4EUVTTIMxX3Q/ZnLJ8404sEK5ETsQ+U80AhYxxlk4vTByJ7ON5WPjHWGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092808; c=relaxed/simple;
	bh=+kelFEseTXshHwpUwa6ni4lb0TdoWbLNOJ5kjnylAH8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VMUmlN+0NGJpCm8fNSY9Wk8Y+Zo9B8twNt7MZup/AivD5glKiPnW35FAwum/fhUK7rUUaEiRtkweoiwENTA0aqNJU3nKq9KKCjRLOY6Ed+JQIiTal9Y1sf6cfWHh9R/9Ktqu30KKOpJ1heqATSByJpGuFWdovZ7FKTjDOvQ5HbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L82Fq7Ew; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L82Fq7Ew"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so1397821a12.2
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 06:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769092802; x=1769697602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HVwV62iQtasrwPSMiTL92nIWj32v9fXWDw/NGjexmGY=;
        b=L82Fq7Ew295Iwwv2GxPGszKjYffGVI1j/OIt2Tzor9ZSpm/mGBYfyzYTfsXLfaOwA+
         dR+ITeP469C711bh4d53jZ7s/qUGcKxtITXJeW1dPgTFENpUt1pCigVgl22NA/vni/MS
         KXl1l7T2OW1ADYx9Z/qS0JE7DEcyvWTYjtC8Fj7+Cdx/yvdQmfUQbass00JsJRiQH/QG
         DSJufzo/HJPB/8VnxckMF3lT+8OtFLtaWj+4Z6xDsagXtiei9pqhYUfbkrgOG01OrOxV
         r6CAYGgUYv5zm1HWxCBN0AfudZSljMKaUYuZG3EUy+X7jlVyg/xSahIuMBXmwoVOA7f3
         yaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769092802; x=1769697602;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVwV62iQtasrwPSMiTL92nIWj32v9fXWDw/NGjexmGY=;
        b=ad+iqZ+pgxkExQEkvDUGvGXWuVwwRaLZoKcmIMpDkD6EqmjPkxD7BWL8ZhWHSc4XHZ
         HptsPlOxAYWNGqUH4bL7ol310IUmT3WEWpT/H0PXYuCizzKj6O0Gu2TUzlFBDvOgyqsO
         jYcQBbHsTfVo1BhOuVdgZOIYGV2JfDyZrUQVzEKzdhsT3KBUz5X5QPHENtJQgfjVr1Yr
         1SAWJ/GX47uZfdCObeRXlqKAP/tn0nA2IRV10lo5VOe0Yygh+A6KCDph35opOy64E8+N
         LktAva/g31TG8EhWkMhOeza/8b/X/hWuyaEbQ5EpJOx7R/uSzn9ElKph79JgXc/SGamQ
         mL9A==
X-Forwarded-Encrypted: i=1; AJvYcCVHAwULDKxX5B+S1rTo0PBCJyGGXWL0dDPSsr5107ejFRCwWAFUbs4pYYa5VdB9fCdl+sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSaBdKl7d6fPUdDMymh/RUnIsh/dPyFd64WlLQoGSOr7/iBHuh
	1VBJ/sRQyA6yBute9cNhuMh2g+tRbntwudeQd894dDZO/1bnHY0506VX
X-Gm-Gg: AZuq6aKKIUph7L89+6eTrt8+20WWroDtQK/Gqkb9kqMbfIQ6hdUaMNy8rNUbvGfyD0t
	Pl+AiO2O0F+g2QphrMn3pfH9NjJQWJWSx7CsD4/KniylBlnEIkUdcT/0hUVRufWymtqRwqJaass
	hTN3PMBX4cHCXVoyAQ9AIB1V3vgybanOoYCvzqdCBBbP/rfA2KMpJExh1OEwPVz4EWL3vlogXk0
	Wq74c0jS01CPB3nAjlbFdJobHuMhihFaP/SgZnZWVxFWTSm5opCLyypGbVmfG2jWGKwzTRv+VcZ
	R+CiB/0S6UX1gUI2EwF4LJIAUpupquCPeJnou9hu52NxrJFuLxhU8G01vd1YGWfklPVIjCluUQn
	k2wXayTAHyCA8C9qB3u6s3EHI3Jvb156PJyzB2Vd5Tt+wooHwmArEcwFJUFJhXmUFouss8w0+xq
	qEpqyNWGgA69F1Q8yF0H8O7C5kg8DV09hwrFFwuJ3OxBSsjGUaYKdIc2Ycyi6xFZ5Vug==
X-Received: by 2002:a17:907:3f95:b0:b87:1fe6:f223 with SMTP id a640c23a62f3a-b87968b6b8cmr1459128466b.6.1769092802229;
        Thu, 22 Jan 2026 06:40:02 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654535c4aa7sm16525444a12.34.2026.01.22.06.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 06:40:01 -0800 (PST)
Message-ID: <60dfb907-c2b8-4fd4-b975-742f7ec18721@gmail.com>
Date: Thu, 22 Jan 2026 14:40:00 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [Outreachy PATCH v3 1/3] environment: stop storing
 `core.attributesFile` globally
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com,
 karthik.188@gmail.com, Toon Claes <toon@iotcl.com>
References: <cover.1768681947.git.belkid98@gmail.com>
 <1aa41da8334296e4c1063b81fc40ec3b1dcdcb7b.1768681947.git.belkid98@gmail.com>
Content-Language: en-US
In-Reply-To: <1aa41da8334296e4c1063b81fc40ec3b1dcdcb7b.1768681947.git.belkid98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Olamide

On 17/01/2026 20:59, Olamide Caleb Bello wrote:
> The config value is parsed in git_default_core_config(), loaded eagerly
> and stored in the global variable `git_attributes_file`.
> Storing this value in a global variable can lead to unexpected
> behaviours when more than one Git repository run in the same Git process.

It would maybe be helpful to explain what the unexpected behavior is and 
how it is caused.

> diff --git a/environment.h b/environment.h
> index 51898c99cd..aea73ff25b 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -84,6 +84,12 @@ extern const char * const local_repo_env[];
>   
>   struct strvec;
>   
> +/* Config values parsed by git_default_config() */
> +struct repo_config_values {
> +	/* core config values */
> +	char *attributes_file_path;

The variable we're converting is called "attributes_file", do we really 
need to add a "_path" suffix?

Apart from that everything here looks good

Thanks

Phillip

> +};
> +
>   /*
>    * Wrapper of getenv() that returns a strdup value. This value is kept
>    * in argv to be freed later.
> @@ -107,6 +113,8 @@ const char *strip_namespace(const char *namespaced_ref);
>   int git_default_config(const char *, const char *,
>   		       const struct config_context *, void *);
>   
> +void repo_config_values_init(struct repo_config_values *cfg);
> +
>   /*
>    * TODO: All the below state either explicitly or implicitly relies on
>    * `the_repository`. We should eventually get rid of these and make the
> @@ -152,7 +160,6 @@ extern int assume_unchanged;
>   extern int warn_on_object_refname_ambiguity;
>   extern char *apply_default_whitespace;
>   extern char *apply_default_ignorewhitespace;
> -extern char *git_attributes_file;
>   extern int zlib_compression_level;
>   extern int pack_compression_level;
>   extern unsigned long pack_size_limit_cfg;
> diff --git a/repository.c b/repository.c
> index c7e75215ac..d308cd78bf 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -57,6 +57,7 @@ void initialize_repository(struct repository *repo)
>   	ALLOC_ARRAY(repo->index, 1);
>   	index_state_init(repo->index, repo);
>   	repo->check_deprecated_config = true;
> +	repo_config_values_init(&repo->config_values);
>   
>   	/*
>   	 * When a command runs inside a repository, it learns what
> diff --git a/repository.h b/repository.h
> index 6063c4b846..638a142577 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -3,6 +3,7 @@
>   
>   #include "strmap.h"
>   #include "repo-settings.h"
> +#include "environment.h"
>   
>   struct config_set;
>   struct git_hash_algo;
> @@ -148,6 +149,9 @@ struct repository {
>   	/* Repository's compatibility hash algorithm. */
>   	const struct git_hash_algo *compat_hash_algo;
>   
> +	/* Repository's config values parsed by git_default_config() */
> +	struct repo_config_values config_values;
> +
>   	/* Repository's reference storage format, as serialized on disk. */
>   	enum ref_storage_format ref_storage_format;
>   

