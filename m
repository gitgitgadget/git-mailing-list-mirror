Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF5289373
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282122; cv=none; b=O73pa4lqmeoka08tfiEXtoyPOYdhU8hz7Dp+lTBx1sWjpGuabmVdxtPlyTg7jVe27Q4oOJhmV0+ZLAcM/mcewVWqKFfVe6MJWmMgbp2d9jxV/Bhka8IkSkIAbjQAfmv4KG24+3RZILh2rBrc2vT619++ayS+cc45v7Q9Y7EEICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282122; c=relaxed/simple;
	bh=XpKezBaAl/Wsf0ZmLDfy6bv0iFy1qvwHnw3Yf1RmbA0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ReZ4K89v8U0cHrm/OmROQMzs84SEYM9FsGvagHGvXIm1F94UytKn5KhcqdNBoAbgEDhloWHO0cEfSD3HkjtID55PI3VOiz4YV/QcKGvhOmhQuRTuCrdds5EoHrI7aAw98AlqyYtF3iVHSj6a5hPIBakDJxs48bRfwC9a/f6+1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J510gNbZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J510gNbZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45619d70c72so9478815e9.0
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282119; x=1753886919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xjPdA9ES60a3FC4kdQX4VlWX9Jzq2MtQbdFItutWZ8=;
        b=J510gNbZoRawLF5RwMQy6Ud93y3DSPpoJc91Jotky5j+V8uCs2qi3sD+0pOl5XQ48x
         qX/y+9O6OwXZrcyFFVBSslptHcQoZ+BXlYZ2yOqPlcYkRN18TEH3mmxOj7Y8dTqMZtcp
         UWu4S9yv8lallaak0o/7RhfUn2RMjKLYWQiKygKSXIwYA2xfwz/qFxf26I8wUI6Vaj74
         WjYN9Lr60YFS900nfvmKLyVjCr6pjnjKmNLSuPfqvca9CsXW/if+/qF7FtXoT/nTBDw6
         NcOBbY8MvlXM9R0TON5I8uJUsYynC3bdWVbHnzShFKyfpjW/0KHUNF1tAUCxvR0l62hW
         r0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282119; x=1753886919;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xjPdA9ES60a3FC4kdQX4VlWX9Jzq2MtQbdFItutWZ8=;
        b=kSfX8mrCk3qhMqC34R1Sm26rQglF7CmztXGwrtOSWEwf9CozYM+MDTnxb0iaN3rLkm
         WWSyqL1paZBz4HciszvW1J/wpexVAS7A15egxsdhivzCfrTJ+xER6p3RZsYQR3HqGTrw
         fP5Ffj5RHrPpHpHiyyMGFPaX8fEpIvaobgH1VrulDfMrXJVll1NgyfZ145fXS258PMcv
         zci1t2eWkyX7yy9v98AzuUqQJ75YLYjcwkFzTovj8ouxjhpw/960mdOMc4KheRc6nafE
         TljTvuLB4fuOKbP4zSKTjw9iFUKGr+BrP61YvcDc9jbB0xNshMRE5s5BrhsF3J5+QbKR
         CIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOOez4S3gOwiXraUtz70RjCOczfBVGBcVtfsZJWRMRDBnAvL5xCQkERZQFAZEdpv7DRQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtXLKNNqaOfU7xU3lLV0ucRMJwGYvTEJm9Rpp7f++ZNa6j5Yb
	kGvQLzVPnEQMMR7713dbDe/mz2AnFUwgmsHIZFTSi2n28rAVPaQtqM79S5E/tg==
X-Gm-Gg: ASbGnctTUz8QgqRmToOv59z6wv6jfoJ4IPdQK8ROh+3b1xdr0g/9+4P8gD4p/+LiwXW
	GZrIH7YBmJo6RG/MJ3cP8JpOVGHGeA1x4E0jPUILuluvUxLB6W5W+YIpb+DiSeGn36HTtev9HMg
	+INtqNx3fypjRyMoaLTWEdNNMFYkNN79vkhmrqjmuys9Qdw6CKBdH2/eV5fScdDfGNT7lSnRokY
	x24W5w3YdhiOAb+9kDQ7cRTD172FIHxrdBAoDF0YNXHXMQqtT3HWEe/JE6zKt4Bw2+hUJx7cHif
	SzPLpVBeFVrjkPh7CK+INPb5duH6sstY9OuqE4oYaE1RT/xBvCNy5ENnN2Yn9wV0mFlVPD56Umd
	88m51NwTXPcg07ytZwTOQ7Vvp3n26PA82M6kBfVprD25oR16vTdzEtLkSu78tYlKwRL9zUUhI2K
	zd
X-Google-Smtp-Source: AGHT+IETmM2/rvhAmoxJbZw6Cl7t+xxM5RDxZ821OjAbErX2nR/1eoSKO7SSRVDyL0WMT/5Cfo/bkw==
X-Received: by 2002:a05:6000:2dc3:b0:3a5:270e:7d3 with SMTP id ffacd0b85a97d-3b7634e664fmr5880314f8f.13.1753282118381;
        Wed, 23 Jul 2025 07:48:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca319c0sm16588866f8f.40.2025.07.23.07.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 07:48:37 -0700 (PDT)
Message-ID: <4ea2b50c-7277-432b-bcb6-912a0cbcb261@gmail.com>
Date: Wed, 23 Jul 2025 15:48:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 21/21] config: fix sign comparison warnings
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
 <20250723-pks-config-wo-the-repository-v2-21-1502d60d3867@pks.im>
Content-Language: en-US
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-21-1502d60d3867@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/2025 15:08, Patrick Steinhardt wrote:
> There are a couple of -Wsign-compare warnings in "config.c":
> 
>    - `prepare_include_condition_pattern()` is returns a signed integer,
>      where it either returns a negative error code or the index of the
>      last dir separator in a path. That index will always be a
>      non-negative number, but we cannot just change the return type to a
>      `size_t` due to it being re-used as error code. This is fixed by
>      splitting up concerns: the return value is only used as error code,
>      and the prefix is now returned via an out-pointer. This fixes a sign
>      comparison warning when comparing `text.len < prefix`,
> 

Sounds good, let's see how the caller is affected ...

> @@ -239,7 +240,8 @@ static int include_by_gitdir(const struct key_value_info *kvi,
>   {
>   	struct strbuf text = STRBUF_INIT;
>   	struct strbuf pattern = STRBUF_INIT;
> -	int ret = 0, prefix;
> +	size_t prefix;
> +	int ret = 0;
>   	const char *git_dir;
>   	int already_tried_absolute = 0;
>   
> @@ -250,12 +252,11 @@ static int include_by_gitdir(const struct key_value_info *kvi,
>   
>   	strbuf_realpath(&text, git_dir, 1);
>   	strbuf_add(&pattern, cond, cond_len);
> -	prefix = prepare_include_condition_pattern(kvi, &pattern);
> -
> -again:
> -	if (prefix < 0)
> +	ret = prepare_include_condition_pattern(kvi, &pattern, &prefix);
> +	if (ret < 0)
>   		goto done;
>   
> +again:
prefix is not modified below this point so moving the label down below 
the error check is safe.

This looks good, thanks

Phillip

>   	if (prefix > 0) {
>   		/*
>   		 * perform literal matching on the prefix part so that
> @@ -724,7 +725,6 @@ int git_config_from_parameters(config_fn_t fn, void *data)
>   	if (env) {
>   		unsigned long count;
>   		char *endp;
> -		int i;
>   
>   		count = strtoul(env, &endp, 10);
>   		if (*endp) {
> @@ -736,10 +736,10 @@ int git_config_from_parameters(config_fn_t fn, void *data)
>   			goto out;
>   		}
>   
> -		for (i = 0; i < count; i++) {
> +		for (unsigned long i = 0; i < count; i++) {
>   			const char *key, *value;
>   
> -			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
> +			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%lu", i);
>   			key = getenv_safe(&to_free, envvar.buf);
>   			if (!key) {
>   				ret = error(_("missing config key %s"), envvar.buf);
> @@ -747,7 +747,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
>   			}
>   			strbuf_reset(&envvar);
>   
> -			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
> +			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%lu", i);
>   			value = getenv_safe(&to_free, envvar.buf);
>   			if (!value) {
>   				ret = error(_("missing config value %s"), envvar.buf);
> @@ -1614,13 +1614,13 @@ int config_with_options(config_fn_t fn, void *data,
>   
>   static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
>   {
> -	int i, value_index;
> +	int value_index;
>   	struct string_list *values;
>   	struct config_set_element *entry;
>   	struct configset_list *list = &set->list;
>   	struct config_context ctx = CONFIG_CONTEXT_INIT;
>   
> -	for (i = 0; i < list->nr; i++) {
> +	for (size_t i = 0; i < list->nr; i++) {
>   		entry = list->items[i].e;
>   		value_index = list->items[i].value_index;
>   		values = &entry->value_list;
> @@ -2470,10 +2470,11 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
>    */
>   static void maybe_remove_section(struct config_store_data *store,
>   				 size_t *begin_offset, size_t *end_offset,
> -				 int *seen_ptr)
> +				 unsigned *seen_ptr)
>   {
>   	size_t begin;
> -	int i, seen, section_seen = 0;
> +	int section_seen = 0;
> +	unsigned int i, seen;
>   
>   	/*
>   	 * First, ensure that this is the first key, and that there are no
> @@ -2716,7 +2717,8 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
>   	} else {
>   		struct stat st;
>   		size_t copy_begin, copy_end;
> -		int i, new_line = 0;
> +		unsigned i;
> +		int new_line = 0;
>   		struct config_options opts;
>   
>   		if (!value_pattern)
> 

