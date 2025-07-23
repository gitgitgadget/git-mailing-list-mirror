Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7133FB1B
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263502; cv=none; b=OKKiqLOyN990Gltee9uTod6ZZ9zYKUGvndEaBzkRy8ZyyUnjJCLtZu+X7EK6gRSe6RovaAUbN5ishShaGPhV8kpEHN5fy7SxyclMdJmNy/VpexIkAnGL6jCahVN6Po+0l/5NPazwTUCPFyBjV7DnmZpsI9gNwCtmgmcbuwKIvH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263502; c=relaxed/simple;
	bh=DA6dZWDFGJp3b+VGyhqrtrJ/+8Ddv6AjwharwPZi3VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fEQFXyVXqbpaYbAnhcXRBivHcSK/2RxjRahR+d4VFALnieTc/4lBGlbLTVQSBzbZ+DKowul0Bt7YjMpU7gc1iK/BlsUf9yakODknqEt9ukiZEKEk7VUYMzQ4v4DNUGBpAKcC74e8LMxh+suugGEU+eb+bQkHHle2ev7lmVDaVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJFmO22a; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJFmO22a"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a5257748e1so3847786f8f.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753263498; x=1753868298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TKAuIpY0ouj8W4v9vnoqKbsST+qKSi2uH+UgvtvBOWU=;
        b=AJFmO22aJ5jUur9W6uyRxnhTF6VAVquioXP468i8eE9EmRF+9BOF2fc/o83jbRNPub
         jly5D2jk41igF9tWG6z4ygL9gk5KT2XnvpaVrWhwoix7fYlNOcD5/DS33vLVIjshIqPW
         /G8PN1RisAlOerM+zp4C2hxuh1SMkJN7AGs/cZ8veBEeyblFSO6eyNHrBE/hFA0XBV67
         j6XA4sod4zDdrdNIaW0w0AUD6O9ua+ZrIbp3I3J91Jp/Yf2ng6tfQ9pw4+mWTlQ/oQ/o
         nPGOs4ogCQ2nc0ZDVKhbm7KAe6vdjlCxqWsREYiEf5yDttkQ3EUUYx30oj+NJAAB9nxf
         2RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753263498; x=1753868298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKAuIpY0ouj8W4v9vnoqKbsST+qKSi2uH+UgvtvBOWU=;
        b=bD/1G4XlHVpKmNI5QqZhMFHEF6zjo0l9D5QMpFlhhCzl6vxd3osRR1ajzZ3WPU6bwi
         onPpGiFL15AmWefMloCswsAAh+Jpz4/Pgz7ZImiNuUdimfy7Mp3a9j2+FizbvSwsjXkB
         dztetuDtYx5LH7CqoCO7qrwxfFmc6QTh+CPMjvjPTbNDaskidm7KncsfxQ6jtuyB1ld5
         IEczLgyVjUIY9/dyiRCX2i0IZusJupe1XRR8g/eTJe474StjEjWz2p6ICFNOwhr4lRj9
         RpdmM64apL6QEr9e3AyyN1WuHKCZyz1znq7PoBMRsWsUZuffcZ/o3ceNYwx2Ry7DuZSN
         GSDw==
X-Forwarded-Encrypted: i=1; AJvYcCWAvc8+nmSqYVfPXv6NQqB4h1fXKvdzEbML2Tom39YUTDkeoLO+M9Z6L7cvvcMxtrMuzx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTeNsVjNpY4b+vkg4lXiq5RqKVobUHHh/LEOTFVvAV4QfUGk+Y
	y1zLPZtBub/sRJYXwhpa65aD2KsGosUe2ROrYD2LrZVISxVZMTnWm9UptGe4ag==
X-Gm-Gg: ASbGncvJT6mNlft2U0ix+EKpfJ2yRnz8q5zaK/FeNKZXrYCSFNNcvKf8fzoiaImBEtz
	+2mNhHwn+xRiilyvvpaglW1qphp7nyMaf3f8Ukdq0vef54hAQuXgtaY6awQQCd74GDeV1/Y7eea
	QNrTVJhV+AQZex+E0OKddHHJy+WJM+ejfV7Hgksu+kcmvj26bc9XGdBWVcLcZHsQCBLGBlpMSOV
	UPrw2Kz9y+a3gBRmM7rWTJeLa7vcjL9zuVN5JK4JaAYO3FHYEBCMVl2RINpWKxai9ydOsMLKakl
	EIy3ZvafYg/LCDoaJzqutJqAbwEmrRh8A4f1lc3G9zNKg9CbIJf+rQxPtFR8u8uFRXVudubHM/I
	R7YziKMfo5CCaebuJ5TD5IRGVUTjegjPrjPdniIhphpp254QQXzYCgi9gx/4CT7N0hbFJiAEwE5
	eg
X-Google-Smtp-Source: AGHT+IGDt+R59+Ix7/Jv9ghyvUGK1TvK7eFzF+gwUazriAcbl2tOfd2qMEU37P2aR9H9ZAmW0QQPQw==
X-Received: by 2002:a05:6000:40dc:b0:3a6:d6e4:dffd with SMTP id ffacd0b85a97d-3b768ea0206mr1980359f8f.14.1753263498328;
        Wed, 23 Jul 2025 02:38:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45869198e23sm17201845e9.11.2025.07.23.02.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 02:38:17 -0700 (PDT)
Message-ID: <2b914b60-3417-4a49-b545-3109c9a05257@gmail.com>
Date: Wed, 23 Jul 2025 10:38:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 21/21] config: fix sign comparison warnings
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
 <20250717-pks-config-wo-the-repository-v1-21-d888e4a17de1@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-21-d888e4a17de1@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 17/07/2025 11:49, Patrick Steinhardt wrote:
> There are a couple of -Wsign-compare warnings in "config.c":
> 
>    - `prepare_include_condition_pattern()` is declared to return a signed
>      int, but it either returns 0 or the index of the last dir separator
>      in a path.

That is not correct, the function contains the lines

               if (!kvi || !kvi->path)
                         return error(_("relative config include "
                                        "conditionals must come from 
files"));

so a negative return value is possible.

Thanks

Phillip

>      That index will always be positive, so the return type of
>      the function is changed to `size_t`, which allows us to drop a check
>      for `prefix < 0` at the only callsite. Furthermore, this fixes a
>      sign comparison warning when comparing `text.len < prefix`,
> 
>    - We treat `struct config_store_data::seen` as signed integer in
>      several places even though it's unsigned.
> 
>    - There are multiple trivial sign comparison warnings where we use a
>      signed loop index to iterate through an unsigned number of items.
> 
> Fix all of these issues and drop the `DISABLE_SIGN_COMPARE_WARNINGS`
> macro.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   config.c | 33 +++++++++++++++------------------
>   1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 947fba3d8d4..a530c48a048 100644
> --- a/config.c
> +++ b/config.c
> @@ -6,8 +6,6 @@
>    *
>    */
>   
> -#define DISABLE_SIGN_COMPARE_WARNINGS
> -
>   #include "git-compat-util.h"
>   #include "abspath.h"
>   #include "date.h"
> @@ -197,12 +195,12 @@ static void add_trailing_starstar_for_dir(struct strbuf *pat)
>   		strbuf_addstr(pat, "**");
>   }
>   
> -static int prepare_include_condition_pattern(const struct key_value_info *kvi,
> -					     struct strbuf *pat)
> +static size_t prepare_include_condition_pattern(const struct key_value_info *kvi,
> +						struct strbuf *pat)
>   {
>   	struct strbuf path = STRBUF_INIT;
>   	char *expanded;
> -	int prefix = 0;
> +	size_t prefix = 0;
>   
>   	expanded = interpolate_path(pat->buf, 1);
>   	if (expanded) {
> @@ -239,7 +237,8 @@ static int include_by_gitdir(const struct key_value_info *kvi,
>   {
>   	struct strbuf text = STRBUF_INIT;
>   	struct strbuf pattern = STRBUF_INIT;
> -	int ret = 0, prefix;
> +	size_t prefix;
> +	int ret = 0;
>   	const char *git_dir;
>   	int already_tried_absolute = 0;
>   
> @@ -253,9 +252,6 @@ static int include_by_gitdir(const struct key_value_info *kvi,
>   	prefix = prepare_include_condition_pattern(kvi, &pattern);
>   
>   again:
> -	if (prefix < 0)
> -		goto done;
> -
>   	if (prefix > 0) {
>   		/*
>   		 * perform literal matching on the prefix part so that
> @@ -724,7 +720,6 @@ int git_config_from_parameters(config_fn_t fn, void *data)
>   	if (env) {
>   		unsigned long count;
>   		char *endp;
> -		int i;
>   
>   		count = strtoul(env, &endp, 10);
>   		if (*endp) {
> @@ -736,10 +731,10 @@ int git_config_from_parameters(config_fn_t fn, void *data)
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
> @@ -747,7 +742,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
>   			}
>   			strbuf_reset(&envvar);
>   
> -			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
> +			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%lu", i);
>   			value = getenv_safe(&to_free, envvar.buf);
>   			if (!value) {
>   				ret = error(_("missing config value %s"), envvar.buf);
> @@ -1614,13 +1609,13 @@ int config_with_options(config_fn_t fn, void *data,
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
> @@ -2470,10 +2465,11 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
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
> @@ -2716,7 +2712,8 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
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

