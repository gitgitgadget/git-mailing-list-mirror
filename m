Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555629A312
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228186; cv=none; b=VLMi0NWe3MhOqFi1OpqNPZBEPTgdkjJNrXdzSBewX+RaK+8qo9XEG0GqPpFEbWyRBCQkKGrRUvhKQ/a161PeLXFoUf3NvjXoAfyNTLXIZNgarqbQ+Q43e7AfqDFaVmBO4y6cy12VF7PS91bHVgphSWBlNqk+1urhT8vvz6z3IEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228186; c=relaxed/simple;
	bh=PQEpyabxMHSp85BRmfOxbHLxmKv7wZyItJ+aCBebKrk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RxtLfKvdSNgvDzV6A5GvpwQzW6zY/QA43VItAI7PLlOlVMG/Bcy4FH4NJknfjGPvemqkn8/SofsEUR65V7+cgVImSamBbEP2jQrWcmWdE6ORADZuxmpFKRzK3e6ux5Ivx2yHrzY7v9WXfUcL6inxQKdTXv7Pvah2eUIusaC+fU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1Psz4Vm; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1Psz4Vm"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso69657115e9.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 06:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768228182; x=1768832982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZKNAVrk0rbru3PVjyMKl8W1ul9a4oCjMwUNgkv1BdM=;
        b=a1Psz4Vm1mMUfb9bJF2r9HQKAISEECubV5drTNAjpzhBSH7JNFc11HKvqA9SiLRE9C
         LsLIMGI1/7iNc+yqjqXOCP5iCEQZWlAyFsTMZyqn1zNI0zlqvMK6aoB+S9oXJ5CIvS2m
         bujyBdcfeLnBRks5qlEJugk6/Vp9YUi0CTojsnsbvaVVj8bdqTjAtxdhD1OenQQ9m9bh
         lXZpOcYRBT/5qc7EoMepfDeuM5/iER8Qj/CYd38/aQ1fsRlJcmHjzAXCdRLeMbl7DZLM
         PKCLIkg7vcnPSKNgYm8LTZb0AsUsQY88hC/Il+iT2mY+OS843vDgwWiWU/gKs0bI29o4
         mz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768228182; x=1768832982;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZKNAVrk0rbru3PVjyMKl8W1ul9a4oCjMwUNgkv1BdM=;
        b=G4e6+w2jF8AXnU/fyTQBZH7OwBh01MVz+4fbIAZwxY9nq05hHRyAzC50Fbf3iXL/O/
         Zsl3Yn/eegwsTWQskkkoEep2RYDo+rT0umyM8lCp4y0xiCz/7rdRym6uTBLZ/omzIO01
         uakZxPhhcgTQa5iKpQQVoqYACstC/3wkW2JHf8Oh7Zg+0Kr5XCKtKhKfCIb8jxd5H7MC
         clo78tpZBwdwcj5Ub27Dcjea6NY0m/pXfyGGLFCrM3pu9jyqK1/11dvnqjA09dha14FW
         P3XtzQ6LkVcUSdUk+AQmk6WCJt14wAGekiMrGWCfWSM3lO7iTqB1m6anPEFw7KGtn9cB
         rqtw==
X-Forwarded-Encrypted: i=1; AJvYcCU1pn6SawYGQtZNti0hT7xvkLJSP7qkcLVNwJMWiaTNzJkMqQNfs2yVxdvbSqLWVa0L5e4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3p5bGRfJU6T4LkmT2MNl/Mci7Lw6vgKOgg1FqBJnIRO+jqhG/
	qzstA+1fOOllPVJIDqegdbQzb8COIqRlqDAGrio8KlY4tszga30MDdrk
X-Gm-Gg: AY/fxX55lgQ7culRmkOJxDDxrnS0aHFPyMWDvkEtz/meOmRiXsB3YddG1T6dzvpzeXH
	KUkqeFTO5x4gmfMTis43HfZT2PstWDg3xF4/TQ/DX0PaoUYAmkjHUvNk18rFxP9gGcaxOeFBWC8
	k5Jp0tAapO4+HV5mo0/0xGk/wknsyVZQ0zSJn+V2/4AvbvKiu2UlE8iq9VS4ReCs+wQ5J+xw0Fh
	HoZl9KqThZgD+T4GxTpYuRhr9YxPs6toPLUDvmX9aHXOiFmDkSLIA6xqXztpaDf2QMImoxqyJ+v
	n9KO/bWO50sJgilY6vo5+57k/MuuUMKUKo/vGpnsie7a7KyEcE1344nzVNIS4A/hX2+kLGPN8qL
	ts6OUfD7w26F3vz5MyP0d712Jf4jhNhMMYjNSDnGLycRuwei65AF4lZe9pYEfuFVn4lhOkT44Ox
	o/3yCCIoMcygtcvUoEVcMInYmqXYH4iUBkTy8NbKEp9InYNCE6nswnvjjVkkmAXgvrjA==
X-Google-Smtp-Source: AGHT+IFrS5RHE2jASp/EdpJm6W+nEKk7vP/K0gF78qrct+awq46CpsgOvn5K9he5LgYFv2A11YKIJw==
X-Received: by 2002:a05:600c:c0c7:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-47d84b33bd7mr183990825e9.22.1768228182365;
        Mon, 12 Jan 2026 06:29:42 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41f5e0sm350346045e9.8.2026.01.12.06.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 06:29:41 -0800 (PST)
Message-ID: <b0e4b10d-5c2a-4685-9b79-92bf838c90cf@gmail.com>
Date: Mon, 12 Jan 2026 14:29:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH RFC 1/3] environment: stop storing
 `core.attributesFile` globally
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com,
 karthik.188@gmail.com
References: <cover.1768217572.git.belkid98@gmail.com>
 <abbfe2531158e9bc99ddb903b60a77c26beb0c9c.1768217572.git.belkid98@gmail.com>
Content-Language: en-US
In-Reply-To: <abbfe2531158e9bc99ddb903b60a77c26beb0c9c.1768217572.git.belkid98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Olamide

On 12/01/2026 12:59, Olamide Caleb Bello wrote:
> The config value parsed in git_default_core_config() is loaded eagerly
> and stored in the global variable `git_attributes_file`.
> Storing this value in a global variable can lead to unexpected
> behaviours when more than one Git repository run in the same Git process.
> 
> Move this value into a `struct config_values` which holds all the values
> parsed by `git_default_config()` and can be accessed per
> repository via `git_default_config()`. This will prevent us from
> moving any code from git_default_core_config(), ensuring the current
> behaviour remains the same while also enabling the libification of Git.

The important thing is that we're not changing when the config is 
parsed, not that we're not removing code from git_default_core_config().

Looking at the changes below, I think it would be simpler to embed 
`struct config_values` in `struct repository` as we do for `struct 
repo_settings`. That would simplify things as we wouldn't have to mess 
about allocating an instance on the heap and freeing it in repo_clear(). 
I'd be tempted to call the new struct `repo_config` rather than 
`config_values` which is rather non-specific. I'm also not sure 
config.[ch] is the best home for it, maybe it should live in 
environment.[ch] for now - we might want to move it to it's own file at 
some point.

Thanks

Phillip

> It is important to note that `git_default_config()` is a wrapper to other
> `git_default_*_config()` such as `git_default_core_config()`.
> Therefore to access and modify this global variable,
> the change has to be made in the function which parses and
> stores the value in the global variable.
> 
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> ---
>   attr.c        | 8 +++++---
>   config.c      | 5 +++++
>   config.h      | 8 ++++++++
>   environment.c | 7 ++++---
>   environment.h | 1 -
>   repository.c  | 6 ++++++
>   repository.h  | 4 ++++
>   7 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/attr.c b/attr.c
> index 4999b7e09d..eb7b82707d 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -881,10 +881,12 @@ const char *git_attr_system_file(void)
>   
>   const char *git_attr_global_file(void)
>   {
> -	if (!git_attributes_file)
> -		git_attributes_file = xdg_config_home("attributes");
> +	struct config_values *cfg = the_repository->cfg_values;
>   
> -	return git_attributes_file;
> +	if (!cfg->attributes_file_path)
> +		cfg->attributes_file_path = xdg_config_home("attributes");
> +
> +	return cfg->attributes_file_path;
>   }
>   
>   int git_attr_system_is_enabled(void)
> diff --git a/config.c b/config.c
> index 7f6d53b473..8b882f64ae 100644
> --- a/config.c
> +++ b/config.c
> @@ -1761,6 +1761,11 @@ static int config_set_element_cmp(const void *cmp_data UNUSED,
>   	return strcmp(e1->key, e2->key);
>   }
>   
> +void config_values_clear(struct config_values *cfg)
> +{
> +	free(cfg->attributes_file_path);
> +}
> +
>   void git_configset_init(struct config_set *set)
>   {
>   	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
> diff --git a/config.h b/config.h
> index ba426a960a..1652d315e2 100644
> --- a/config.h
> +++ b/config.h
> @@ -135,6 +135,13 @@ struct config_context {
>   	/* Config source metadata for key and value. */
>   	const struct key_value_info *kvi;
>   };
> +
> +/* Holds values parsed by git_default_config() */
> +struct config_values {
> +	/* core config values */
> +	char *attributes_file_path;
> +
> +};
>   #define CONFIG_CONTEXT_INIT { 0 }
>   
>   /**
> @@ -187,6 +194,7 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
>   void git_config_push_parameter(const char *text);
>   void git_config_push_env(const char *spec);
>   int git_config_from_parameters(config_fn_t fn, void *data);
> +void config_values_clear(struct config_values *cfg);
>   
>   /*
>    * Read config when the Git directory has not yet been set up. In case
> diff --git a/environment.c b/environment.c
> index a770b5921d..d633b0405b 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -53,7 +53,6 @@ char *git_commit_encoding;
>   char *git_log_output_encoding;
>   char *apply_default_whitespace;
>   char *apply_default_ignorewhitespace;
> -char *git_attributes_file;
>   int zlib_compression_level = Z_BEST_SPEED;
>   int pack_compression_level = Z_DEFAULT_COMPRESSION;
>   int fsync_object_files = -1;
> @@ -327,6 +326,8 @@ static enum fsync_component parse_fsync_components(const char *var, const char *
>   static int git_default_core_config(const char *var, const char *value,
>   				   const struct config_context *ctx, void *cb)
>   {
> +	struct config_values *cfg = the_repository->cfg_values;
> +
>   	/* This needs a better name */
>   	if (!strcmp(var, "core.filemode")) {
>   		trust_executable_bit = git_config_bool(var, value);
> @@ -364,8 +365,8 @@ static int git_default_core_config(const char *var, const char *value,
>   	}
>   
>   	if (!strcmp(var, "core.attributesfile")) {
> -		FREE_AND_NULL(git_attributes_file);
> -		return git_config_pathname(&git_attributes_file, var, value);
> +		FREE_AND_NULL(cfg->attributes_file_path);
> +		return git_config_pathname(&cfg->attributes_file_path, var, value);
>   	}
>   
>   	if (!strcmp(var, "core.bare")) {
> diff --git a/environment.h b/environment.h
> index 51898c99cd..3512a7072e 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -152,7 +152,6 @@ extern int assume_unchanged;
>   extern int warn_on_object_refname_ambiguity;
>   extern char *apply_default_whitespace;
>   extern char *apply_default_ignorewhitespace;
> -extern char *git_attributes_file;
>   extern int zlib_compression_level;
>   extern int pack_compression_level;
>   extern unsigned long pack_size_limit_cfg;
> diff --git a/repository.c b/repository.c
> index c7e75215ac..3ad944e71c 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -55,6 +55,7 @@ void initialize_repository(struct repository *repo)
>   	repo->remote_state = remote_state_new();
>   	repo->parsed_objects = parsed_object_pool_new(repo);
>   	ALLOC_ARRAY(repo->index, 1);
> +	CALLOC_ARRAY(repo->cfg_values, 1);
>   	index_state_init(repo->index, repo);
>   	repo->check_deprecated_config = true;
>   
> @@ -403,6 +404,11 @@ void repo_clear(struct repository *repo)
>   		FREE_AND_NULL(repo->remote_state);
>   	}
>   
> +	if (repo->cfg_values) {
> +		config_values_clear(repo->cfg_values);
> +		FREE_AND_NULL(repo->cfg_values);
> +	}
> +
>   	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
>   		ref_store_release(e->value);
>   	strmap_clear(&repo->submodule_ref_stores, 1);
> diff --git a/repository.h b/repository.h
> index 6063c4b846..5fb825f799 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -13,6 +13,7 @@ struct object_database;
>   struct submodule_cache;
>   struct promisor_remote_config;
>   struct remote_state;
> +struct config_values;
>   
>   enum ref_storage_format {
>   	REF_STORAGE_FORMAT_UNKNOWN,
> @@ -171,6 +172,9 @@ struct repository {
>   
>   	/* Should repo_config() check for deprecated settings */
>   	bool check_deprecated_config;
> +
> +	/* Repository's config values parsed by git_default_config() */
> +	struct config_values *cfg_values;
>   };
>   
>   #ifdef USE_THE_REPOSITORY_VARIABLE

