Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE716C852
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453853; cv=none; b=kgP7Tlzacqz+NGKwHO9KwilgD/6aB0QWfIXD76TNERMIyUenFSzoNFA0RbFmSAOAUNMahs6pKoZ69CzlDghsC7e5Z3BFhqRDLT9DmLNxQ0hfmIwunFFs3TTMpwqLRcITqJy4DBQkc+nnoOdozhKeBKzocTMPlhKQMVZLHqIv/iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453853; c=relaxed/simple;
	bh=Gv6EfT/IFVkaGaLwwxDOFqWVlLBJ6ncN735bEBdMeGw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=omRYgyNy8D3+oBCEI61bua3r8f0t3Ih3k064RSq5pqSJzxzAj+VCqkEEuPlcLvRyIbRDnALNOLRXUm3MJykygejIqSBSXezHly7yhPkDYO/o17bKqKpl7NWnK63dKDgjKM1KUjc+/m45OsD2PbPjus7I6heHOo9WwC8AmrDfeJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbTBIBiU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbTBIBiU"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-369c609d0c7so2949794f8f.3
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723453850; x=1724058650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kf1fC87TbZp1A/KvB5Qlc819ggNJsEI65UcoRHW+S/E=;
        b=UbTBIBiUjYy4pQlXfpZlfu+L7s25YJJrnE/ozEs8jnwhheSQQoyoh4UQDiboxve8dr
         3vVFChPhOINr6gx2rVE/BFAwDnY3R2gZIeQL6l9+O01nfHq8xyH/mD2PLiW0V3DkfG36
         z/rBxDe5qgPqQyFUCo9OecKwYtSaTxmKJYoXRwd0jnDFnmnbswV2bj8T3A4mrZEWvrO7
         8iZEjL5SzHmgwocNuxTZulL6R7cPKnAA/8b5zAWjpCPvdwoVkaJ7E9Eb5zfBtSjemNzc
         T0w/zcfko8pq/2/88OxA3z4+lUAXtQ95FRAzWQZmJaCA5vnB2hPzycx01Fqoxgjya0wC
         MLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453850; x=1724058650;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf1fC87TbZp1A/KvB5Qlc819ggNJsEI65UcoRHW+S/E=;
        b=K8OTeeogAV1eoUWur12pqwtADO64M1Kmpg1afXXxIHHmBjEv9NX3iVeqfqhNNgEbPP
         qCvglKMZWDotEnlsHBb7Rr7NBk2s5ShmCrHSzZKfmlN7rAhoqKITOCRoZVhpDze9CMX5
         eQYeka2oxv0e+o8dSHxCh6dfgU4/CHzvfxXNGsXF/9rTytF5ex81OJE5gzwICwbafd0a
         yfx1FNNkqL5tZ0IzZ4JkkCtgmuiwnDNnpMVH3t5iY40fDDNsBk30AwhOb7YAWmcyVHA9
         6IYPKmcvi9Z9llhi7LwMxBmwmRHuJxIsRqX7dg8fElMBD7eV/R7LJgFB7lEil3gtiVVv
         YpoA==
X-Forwarded-Encrypted: i=1; AJvYcCWx0G7bglzBRphuu+iZhHsbPm3YABuq2vTrI5Ad546MNzPjI344pLLeC+o+cgB3AbPhgeb1DDT99TXB4zdvytK5tn5A
X-Gm-Message-State: AOJu0YzoK/bfM02SaemIBuWrNXed2M69TghBtE9SVvGJhHJ4Vmq5TTQy
	uD3A24nAN+vK3YJR4P73q6jJTNlwYM9G60Vqd/LenQU1P2Lg9WUO
X-Google-Smtp-Source: AGHT+IE/KV7WFk5ClG72/sxn7hUDbVKFe9ky1k5HjxRF18Zp403phFlmtE4EbacK07Y/YLPB1Fx17A==
X-Received: by 2002:adf:e792:0:b0:368:5b38:14ee with SMTP id ffacd0b85a97d-36d5e1d35acmr6564843f8f.23.1723453849620;
        Mon, 12 Aug 2024 02:10:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36ba72sm6964751f8f.16.2024.08.12.02.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:10:49 -0700 (PDT)
Message-ID: <47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com>
Date: Mon, 12 Aug 2024 10:10:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/5] config: add git_configset_alloc() and
 git_configset_clear_and_free()
Reply-To: phillip.wood@dunelm.org.uk
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
 emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com,
 mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com,
 dsimic@manjaro.org
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <908ad0b82fa084fc4e56d7f6dff49e4f255af6ec.1723242556.git.steadmon@google.com>
Content-Language: en-US
In-Reply-To: <908ad0b82fa084fc4e56d7f6dff49e4f255af6ec.1723242556.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh

On 09/08/2024 23:41, Josh Steadmon wrote:
> Add git_configset_alloc() and git_configset_clear_and_free() functions
> so that callers can manage config_set structs on the heap. This also
> allows non-C external consumers to treat config_sets as opaque structs.

Do we really need to add this code to config.c rather than handling it 
in the wrapper layer in the next patch?

Looking ahead I wonder how useful it is to users of the library to 
separate out allocation from initialization. A function that allocates 
and initializes a configset would be more convenient and harder to 
misuse. Calling release functions *_free() rather than 
*_clear_and_free() would be more convenient as well. I also noticed that 
the data types are not namespaced when they are exported. So perhaps we 
could drop this patch and add the following to the next patch.

/*
  * Namespace data types as well as functions and ensure consistent
  * naming of data types and the functions that operate on them.
  */
struct libgit_configset {
	struct config_set set;
};

struct libgit_configset *libgit_configset_new() {
	struct libgit_configset *set = xmalloc(sizeof(*set));

	git_configset_init(&set->set);
	return set;
}

void libgit_configset_free(struct libgit_configset *set) {
	git_configset_clear(&set->set);
	free(set);
}

Best Wishes

Phillip

> Co-authored-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>   config.c | 11 +++++++++++
>   config.h | 10 ++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/config.c b/config.c
> index 6421894614..444db8de79 100644
> --- a/config.c
> +++ b/config.c
> @@ -2324,6 +2324,11 @@ static int config_set_element_cmp(const void *cmp_data UNUSED,
>   	return strcmp(e1->key, e2->key);
>   }
>   
> +struct config_set *git_configset_alloc(void)
> +{
> +	return xmalloc(sizeof(struct config_set));
> +}
> +
>   void git_configset_init(struct config_set *set)
>   {
>   	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
> @@ -2353,6 +2358,12 @@ void git_configset_clear(struct config_set *set)
>   	set->list.items = NULL;
>   }
>   
> +void git_configset_clear_and_free(struct config_set *set)
> +{
> +	git_configset_clear(set);
> +	free(set);
> +}
> +
>   static int config_set_callback(const char *key, const char *value,
>   			       const struct config_context *ctx,
>   			       void *cb)
> diff --git a/config.h b/config.h
> index 54b47dec9e..074c85a788 100644
> --- a/config.h
> +++ b/config.h
> @@ -472,6 +472,11 @@ struct config_set {
>   	struct configset_list list;
>   };
>   
> +/**
> + * Alloc a config_set
> + */
> +struct config_set *git_configset_alloc(void);
> +
>   /**
>    * Initializes the config_set `cs`.
>    */
> @@ -520,6 +525,11 @@ int git_configset_get_string_multi(struct config_set *cs, const char *key,
>    */
>   void git_configset_clear(struct config_set *cs);
>   
> +/**
> + * Clears and frees a heap-allocated `config_set` structure.
> + */
> +void git_configset_clear_and_free(struct config_set *cs);
> +
>   /*
>    * These functions return 1 if not found, and 0 if found, leaving the found
>    * value in the 'dest' pointer.
