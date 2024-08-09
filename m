Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF35224EA
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723238032; cv=none; b=T/6MOqg3y02RY2aSBbcfXkV1adeSFtCi7antAE9GK1sJPIk4G0kkVGvAKDttv5diIqdpxP3AnL7uyGWwMMO/NSrHlEtxRQusBDIzw8v+kqADc/2arcOZaeTouoErVbXUA6avW1UnLSv6KHgBD2/uUSL+bp3eeIPaDQ1Mbi3Shb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723238032; c=relaxed/simple;
	bh=Ko3MTG7KN0najKeMoO3cFZ8A2eWRBNHOTEcEdusDNuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9sI4XNKrmvx5XDjIEv+YBkGrGLwCTL1wYud8+4WyiEPDVFl5ldIT6724Cq/1Vbs+Pj/cfUt5hJTa1WzaGOYXzvM+9QGcQekARkzm3seI+/drPk6vAHfjpq+LUOW7l6CmZVHtjSopdoocJexiHKBHETiVwKd7b32uHRsIklubCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2fQuhiZ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2fQuhiZ"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-264a12e05b9so1577113fac.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723238030; x=1723842830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JAB2Bkd/gVMgJJpbpbsFTPX4Pz84SVjCTqb6axOVS/8=;
        b=I2fQuhiZ1o9FkTqSG+G66J8Y04LkFf8KRG3xfty+gHVqgzBwXE/Vpsh7L1hf/x+FzY
         ReMMDurjPUHS7hWYc93qYbu0eq8vqb9qieUYHtrtARQ+ubzjHBR7y2AiL1uI3A4iadFJ
         Z4DJy/iveT0rxZ3JUFdhYqxsvnpmlgUnp6TrUAIrdjtOZcHjksjOLXnoD+bz99Ae+XHE
         IDJbuTSJ0nYx4nlD8POMsy1ooy58Op+jtuEpBYlW0EN9pk03CpzaOHVl4Of8r6Jgo1ON
         BXotfwVVgaFUuKWTNxk41GNVFYAfW0TF4Np00Kur6142IltCtvhw0hbeprPOKgGYIRvE
         zCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723238030; x=1723842830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAB2Bkd/gVMgJJpbpbsFTPX4Pz84SVjCTqb6axOVS/8=;
        b=UGlbRv6uYxN67H0NWUrz3uIY95BU1VEnpy51CUx7fnea/ITUoM3SOL7iSnOzs/gjkm
         ochdv5nphfebiGXWVqZ4BLK8HuxIIaqePVMXWCbk5H7bmEUehrf4ASso3h+LSeZipJAF
         x0OUeSKdWSnsc0m9jTAqFWvUwy9dH7egSC9X2fam0prAUwjovNfshBk+RmeOsT76pooa
         eoD2msHn/3ceWBF3s5zuRUWxNOJnN7jqgPn9dbdf1EHlws7pO5AP0fwKOUpqIjhBNS4I
         1zUPCb9oEEbDq79IPNWP1MwrJAzPHIbV2u+fuv4vpgeRZfzYsIdhTIXI6bZE2qo2Dt5w
         jXSw==
X-Gm-Message-State: AOJu0Ywxa5ENZOOIfbDxbb1nBbguw3YC9rK2/KQ0dg3KrBnqdNigkNdU
	Z1uo3ViZ5P98o43/4aI2U2DN2YWjScsJTq4fLunZ1x3vRYra7RXjTbmQGA==
X-Google-Smtp-Source: AGHT+IEQ0rNDeg/D2ggV4+Nhm4C0GdkgqLa2E3YqJtBw4FYWC1TRSBMIAxuxm1EAYVUTQgJ8b5hSsw==
X-Received: by 2002:a05:6870:e415:b0:261:7af:719c with SMTP id 586e51a60fabf-26c62f1140cmr3184652fac.35.1723238030080;
        Fri, 09 Aug 2024 14:13:50 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26c72045928sm193847fac.4.2024.08.09.14.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 14:13:49 -0700 (PDT)
Date: Fri, 9 Aug 2024 16:13:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 20/20] config: hide functions using `the_repository` by
 default
Message-ID: <oksb4qyur7ucqurshkp3232lk3ipqckcwbk56ulungkwozwsf5@w55hc5w6ml4h>
References: <cover.1723013714.git.ps@pks.im>
 <43757f30770bf5a27fd8d7ac55a343185dbe62b3.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43757f30770bf5a27fd8d7ac55a343185dbe62b3.1723013714.git.ps@pks.im>

On 24/08/07 08:58AM, Patrick Steinhardt wrote:
> The config subsytem provides a bunch of legacy functions that read or

s/subsytem/subsystem/

> set configuration for `the_repository`. The use of those functions is
> discouraged, and it is easy to miss the implicit dependency on
> `the_repository` that calls to those functions may cause.
> 
> Move all config-related functions that use `the_repository` into a block
> that gets only conditionally compiled depending on whether or not the
> macro has been defined. This also removes all dependencies on that
> variable in "config.c", allowing us to remove the definition of said
> preprocessor macro.

Here we are making the same change done earlier to "path.h". Use of
config functions that rely on `the_repository` implicitly now require
the caller to define `USE_THE_REPOSITORY_VARIABLE` explicitly. Thus
improving visibility of use.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> +# ifdef USE_THE_REPOSITORY_VARIABLE
> +static inline void git_config(config_fn_t fn, void *data)
> +{
> +	repo_config(the_repository, fn, data);
> +}
> +
> +static inline void git_config_clear(void)
> +{
> +	repo_config_clear(the_repository);
> +}
> +
> +static inline int git_config_get(const char *key)
> +{
> +	return repo_config_get(the_repository, key);
> +}
> +
> +static inline int git_config_get_value(const char *key, const char **value)
> +{
> +	return repo_config_get_value(the_repository, key, value);
> +}
> +
> +static inline int git_config_get_value_multi(const char *key, const struct string_list **dest)
> +{
> +	return repo_config_get_value_multi(the_repository, key, dest);
> +}
> +
> +static inline int git_config_get_string_multi(const char *key,
> +				const struct string_list **dest)
> +{
> +	return repo_config_get_string_multi(the_repository, key, dest);
> +}
> +
> +static inline int git_config_get_string(const char *key, char **dest)
> +{
> +	return repo_config_get_string(the_repository, key, dest);
> +}
> +
> +static inline int git_config_get_string_tmp(const char *key, const char **dest)
> +{
> +	return repo_config_get_string_tmp(the_repository, key, dest);
> +}
> +
> +static inline int git_config_get_int(const char *key, int *dest)
> +{
> +	return repo_config_get_int(the_repository, key, dest);
> +}
> +
> +static inline int git_config_get_ulong(const char *key, unsigned long *dest)
> +{
> +	return repo_config_get_ulong(the_repository, key, dest);
> +}
> +
> +static inline int git_config_get_bool(const char *key, int *dest)
> +{
> +	return repo_config_get_bool(the_repository, key, dest);
> +}
> +
> +static inline int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)
> +{
> +	return repo_config_get_bool_or_int(the_repository, key, is_bool, dest);
> +}
> +
> +static inline int git_config_get_maybe_bool(const char *key, int *dest)
> +{
> +	return repo_config_get_maybe_bool(the_repository, key, dest);
> +}
> +
> +static inline int git_config_get_pathname(const char *key, char **dest)
> +{
> +	return repo_config_get_pathname(the_repository, key, dest);
> +}
> +
> +static inline void git_config_set_in_file(const char *config_filename,
> +					  const char *key, const char *value)
> +{
> +	repo_config_set_in_file(the_repository, config_filename, key, value);
> +}
> +
> +static inline int git_config_set_gently(const char *key, const char *value)
> +{
> +	return repo_config_set_gently(the_repository, key, value);
> +}
> +
> +static inline void git_config_set(const char *key, const char *value)
> +{
> +	repo_config_set(the_repository, key, value);
> +}
> +
> +static inline int git_config_set_in_file_gently(
> +	const char *config_filename,
> +	const char *key,
> +	const char *comment,
> +	const char *value)
> +{
> +	return repo_config_set_in_file_gently(the_repository, config_filename,
> +					      key, comment, value);
> +}
> +
> +static inline int git_config_set_multivar_in_file_gently(
> +	const char *config_filename,
> +	const char *key, const char *value,
> +	const char *value_pattern,
> +	const char *comment,
> +	unsigned flags)
> +{
> +	return repo_config_set_multivar_in_file_gently(the_repository, config_filename,
> +						       key, value, value_pattern,
> +						       comment, flags);
> +}
> +
> +static inline void git_config_set_multivar_in_file(
> +	const char *config_filename,
> +	const char *key,
> +	const char *value,
> +	const char *value_pattern,
> +	unsigned flags)
> +{
> +	repo_config_set_multivar_in_file(the_repository, config_filename,
> +					 key, value, value_pattern, flags);
> +}
> +
> +static inline int git_config_set_multivar_gently(const char *key, const char *value,
> +				   const char *value_pattern, unsigned flags)
> +{
> +	return repo_config_set_multivar_gently(the_repository, key, value,
> +					       value_pattern, flags);
> +}
> +
> +static inline void git_config_set_multivar(const char *key, const char *value,
> +			     const char *value_pattern, unsigned flags)
> +{
> +	repo_config_set_multivar(the_repository, key, value,
> +				 value_pattern, flags);
> +}
> +# endif /* USE_THE_REPOSITORY_VARIABLE */

Once again, very neat to see this guarded behind
`USE_THE_REPOSITORY_VARIABLE` now. :)

-Justin
