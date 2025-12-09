Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F802156661
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765301474; cv=none; b=f+WkDHQdqZpYKtpTAUAv/KuE7BpW6J7ew3QnUyy6uKVhq79WX7yRNRPMXD/XrPo7Alnemz6Z20N/JUK/PJXkjyfR363UWZ2nIxs2SoRqdY3kHHP//nCy2USJOYPTwd96ktCT/bdKvcOljkWvoh6vjnDREmpC2feH33GaMguq280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765301474; c=relaxed/simple;
	bh=+5uSpoRZJYZI5KR1NM1yUBCfaQYb2wGFqi8AVM0gw+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMY9G+pL2USuI/cMOo6l+lJRGS/zKntDbfTyPYSObvsGfwCQvJe75cNZeqrDt8gk7jitvnWeBOIrDez2didZYlTvWcxRGaTRujosKmxpl5wiw/CGDFO8VYSLhehCANLyiElDHTxFGMSMdbwAXRtiahKszbMaj9KMtnwCG/PeRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo+UjOmO; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo+UjOmO"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3e898ba2a03so4214539fac.0
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 09:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765301471; x=1765906271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ca/GYBJyGFvb8KqBWNsHnCcJi134ggxZIqxir0T0k0w=;
        b=Vo+UjOmOEBQmxJDyOxZdp2Eb4eSO2mbHhpMo4FTGakPP+O1XbWkt8dihJWY4yWNXVr
         6j+NQgr6IvEYcczzD59ikU3HEf3FQIW2YrkVLKgKC0k4LWfNcI6DHyosIN+obpxwPpKe
         uH04G9H8gM5brrQJbIqBbswHvsnJkWwGi7spiFqEqlGYvoNJpmNSSSgG/znOBApXLV/Q
         Vm1zN/GjVwXl7VjrhlUQvqoya6ZIDVikjfJv62dqQAG7LLLlw5ek7+osFAi6cEdPqEKv
         RMDsk3XU2UJIdXcFL7RgQJXX67ASfRN+riAW4Rle28bmX03htTGeaS1ZqiGwgMfuJm6l
         7otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765301471; x=1765906271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ca/GYBJyGFvb8KqBWNsHnCcJi134ggxZIqxir0T0k0w=;
        b=b8fv++3XA8Xw0r2IWDFCxV8QAP6Utjuq7M6JoVbGkxuzYQ1Ix+xDGTj2b1al7g2iMN
         ESsJcyEJFEz8MCzDxD9c5cZ5bgJjCRKE45WQehWU0C0cHAhpHvgYhG8nSOoyVi5wo2kd
         01F1q1hP3JVO2kZmD8jiMFSYvx81IRsEjLF2cYCZ7lQqHLQsOkx9rxxhRvoDThX/RKmu
         Nt7iFf1QkJ4z8jzMbtaezpiULaZjfrYoNrRfBE4mHNlxBW4HEPkmY//XlvgRFpeDoWSF
         7tYBTC3IebU9yoP8/rnTKBC2DE+vW9VWBpGzAyi1jnHpH1faW+oEQo8ic0eUGshmNfNe
         VuTA==
X-Gm-Message-State: AOJu0Yx656zPC0Z4C0TASxCFGzyJstDcVVBBJWX/5+X3KS0nB76xIUWL
	Fg1e/ddBKJjxgaaM3qaakMVrgIZwbd2LK+z88x5NBeD2q4UsY4l4soX5EUShYA==
X-Gm-Gg: AY/fxX4AH/gStOh4e/azMofMRsVDHbr3RVURrlg/bg7Aam4TWI1oE1uI5bqEbJhynsa
	jVb+y/mWJ5U74xuRZymIvNhP/G1lrSnl82YwK8tZ+phGfa0vcY6/MRKPcNkYH1A/qQRrPdVccAn
	qSFNTyY6/2CLnRTgo/jKhAmiGbxOFe7bX8x9H7fn+E3GZUSf+PO3Gp7Ec/Q4Q7w1arylJxj2GTa
	qasZpmx/lpavutoNIpFEJqmf2Srd/CFqHeHQabkPHCaBmsl3jslCYGmtwvkmFGVzRpa3BLHBkUR
	OkIVmYoWdKpWcUgHOBatWUzt5QO5tjLAzSXPcPUORwTcq2NQNn8EGqpTA3GclpE/2OyM9vTND3C
	JyLgjjMJUITTXywT0zNqsPrJnl3vbcP7QxcYHxI9rK45wWEDHdzyYLQBbxZmb2fC62Z2/4I633M
	oqCihz
X-Google-Smtp-Source: AGHT+IEB/l4dyd22BfrUDQ6aeHZLsn4t0pyiTWBB3XthzL8pTByzcaO3Z5tRVYTmJjstw4qiTql9nA==
X-Received: by 2002:a05:6870:241b:b0:3e8:8e56:6715 with SMTP id 586e51a60fabf-3f5440fdadamr5158313fac.53.1765301471404;
        Tue, 09 Dec 2025 09:31:11 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50b510088sm11361841fac.11.2025.12.09.09.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:31:10 -0800 (PST)
Date: Tue, 9 Dec 2025 11:31:05 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/8] odb: remove mutual recursion when parsing alternates
Message-ID: <qhwjdvcilzbd7bpj64jwmxfwldlzge5w23bsgrz3yma4rtwlw6@6becwkk4u4vj>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251208-b4-pks-odb-alternates-via-source-v1-5-e7ebb8b18c03@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-5-e7ebb8b18c03@pks.im>

On 25/12/08 09:04AM, Patrick Steinhardt wrote:
> When adding an alternative object database source we not only have to
> consider the added source itself, but we also have to add _its_ sources
> to our database. We implement this via mutual recursion:
> 
>   1. We first call `link_alt_odb_entries()`.
> 
>   2. `link_alt_odb_entries()` calls `parse_alternates()`.
> 
>   3. We then add each parsed alternate via `odb_add_source()`.
> 
>   4. `odb_add_source()` calls `link_alt_odb_entries()` again.
> 
> This flow is somewhat hard to follow, but more importantly it means that
> parsing of alternates is somewhat tied to the recursive behaviour.
> 
> Refactor the function to remove the mutual recursion between adding
> sources and parsing alternates. The parsing step thus becomes completely
> oblivious to the fact that there is recursive behaviour going on at all.
> Instead, the recursion is handled exclusively by `odb_add_source()`,
> which now recurses with itself.
> 
> This refactoring allows us to move parsing of alternates into object
> database sources in a subsequent step.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 60 +++++++++++++++++++++++++++---------------------------------
>  1 file changed, 27 insertions(+), 33 deletions(-)
> 
> diff --git a/odb.c b/odb.c
> index 94cff19221..27f3c8e263 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -147,9 +147,8 @@ static bool odb_is_source_usable(struct object_database *o, const char *path)
>   * of the object ID, an extra slash for the first level indirection, and
>   * the terminating NUL.
>   */
> -static void read_info_alternates(struct object_database *odb,
> -				 const char *relative_base,
> -				 int depth);
> +static void read_info_alternates(const char *relative_base,
> +				 struct strvec *out);
>  
>  static struct odb_source *odb_source_new(struct object_database *odb,
>  					 const char *path,
> @@ -171,6 +170,7 @@ static struct odb_source *odb_add_source(struct object_database *odb,
>  					 int depth)
>  {
>  	struct odb_source *alternate = NULL;
> +	struct strvec sources = STRVEC_INIT;
>  	khiter_t pos;
>  	int ret;
>  
> @@ -189,9 +189,17 @@ static struct odb_source *odb_add_source(struct object_database *odb,
>  	kh_value(odb->source_by_path, pos) = alternate;
>  
>  	/* recursively add alternates */
> -	read_info_alternates(odb, alternate->path, depth + 1);
> +	read_info_alternates(alternate->path, &sources);
> +	if (sources.nr && depth + 1 > 5) {
> +		error(_("%s: ignoring alternate object stores, nesting too deep"),
> +		      source);
> +	} else {
> +		for (size_t i = 0; i < sources.nr; i++)
> +			odb_add_source(odb, sources.v[i], depth + 1);
> +	}

Ok, prior to this, read_info_alternates() would not only parse the
alternates file for the ODB source at hand, but also recursively parse
and add alternates of alternates. Now, read_info_alternates() is only
responsible for parsing a single alternates file at a time.

Recursing into child alternates is now handled by odb_add_source(). IMO
this is much easier to reason about and ultimately matches the previous
behavior.

>  
>   error:
> +	strvec_clear(&sources);
>  	return alternate;
>  }
>  
[snip]
> @@ -622,13 +610,19 @@ int odb_for_each_alternate(struct object_database *odb,
>  
>  void odb_prepare_alternates(struct object_database *odb)
>  {
> +	struct strvec sources = STRVEC_INIT;
> +
>  	if (odb->loaded_alternates)
>  		return;
>  
> -	link_alt_odb_entries(odb, odb->alternate_db, PATH_SEP, NULL, 0);
> +	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
> +	read_info_alternates(odb->sources->path, &sources);
> +	for (size_t i = 0; i < sources.nr; i++)
> +		odb_add_source(odb, sources.v[i], 0);

When preparing alternates, sources from the environment and alternates
file are parsed first and then added. Adding sources is now handled
explicitly and is responsible for add child alternates. Looks good.

-Justin
