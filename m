Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804E35AC07
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043889; cv=none; b=eq51t+kyna9ggQ3Z/v/6WE5Qwg00ylqrT+WYk25c3DYrNPAeI3q6LJWod6BORtkNZxSVkyDyDRcclWyBfHuBgrBTcWKJ3A+M3nCmnQa9L3jISyduQKhes6YqiRIzEb6nDonSacWJqtaOBdXtmfUzmwHnmZbPqTZNinGgYPlgCM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043889; c=relaxed/simple;
	bh=tyZFehL0351JLa8pBfNu+Gq7cmTBKXH+dK+D07bfN3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mj0wWx2j5y5BXo4D8HW+ptdLGah8Tb77+Jj4caR0BkSm9kwEV8JlhvyAdQsmX0DPdUN8Fx7Gqn8A6OXWgvgttxMbmg7oNmGSLiV+kCHiW1JP07TkFMou66kcDG5kSmDOOhOmgJSJqcesSGqe4o76gRnvRx1wT7XSzDbGu2wRCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DM4UJVAc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hufHFURx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DM4UJVAc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hufHFURx"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FEF57A0185
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:58:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 15 Oct 2026 01:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792043886; x=1792130286; bh=uNsoD+Vd1I
	nqCZKLC1aRLKLXEku1TMfQSGCqlQt0w1s=; b=DM4UJVAcq5iOeKmXyZWqPb/dQX
	ESB2GaUMvsY8y1sWKGWMCDq+vWjwJeN5LfvjlfRoNxs0e3lE8zf0zlUedjzsyYxr
	djXcuiKfJlFEdeqBwGQhsQC1k7C4Krtr6TgwkO7jl340yfy+F10voGiarHMGVKbx
	NMsph3dXnS4gQlKn5Xd37fEGpe7t1LLTTFI06D2VBtoC2f/lcyBpUkqCiUoEqRVR
	N1HjyXdTyjOJtWolgiVHhUk7+2eDvmOjnN4o6rTO4guHQKwmc55OeJu12gfzJ5x/
	h82gpXwmuMxMTit5LILPO663m+2oabJFgh8y8iXsDOA508YfAdXQ3Z8lTj4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792043886; x=1792130286; bh=uNsoD+Vd1InqCZKLC1aRLKLXEku1TMfQSGC
	qlQt0w1s=; b=hufHFURx0JOqcIQeMMutrdRVAwx0JoBl4o99PAWmPatzbhThFAD
	OJa7hw5sEgWp8M/zEuo03h++3hbgmh7L3oPogJTD932UOEjI/ePltxxLFvMWo0b2
	GF320H+PCCvnuZBILtuRTkiZwwQhqPCr+fbIuCRUY/UkXMtfOKYUnSr8O5VF6dlm
	yZkWWx9eatBC3Bt5ooyWXaq9BnSf1wbx6fklE07MqDtDC11Hc4PBXDBH3hTEGKCv
	p6NpO22dFCClJu8yYdsUDhNH+blKrY6x+d3dy5Xs6RCMKT20ma54+Uq+7mbMHI7z
	kAUt2oZAAxVSxkCw22E4Kl2VOdHsJJi1fBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792043886; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nddQH3F8pKEp9ccH1zfIEpFR+TEtksZAh8vn9CxwWN+Tix3
	Zpigq+piU+aigRxIQL8Ynb2jTzZcvkZ72u3COXL6ynj59eIhVr+2WKCrWv7a1iaN
	o2s7PlcjcGPHFK1yFKZhjgyQHlv1KG/EFvJ/XPitp+t1wrIaiNBG1ZczxaFOV/f9
	Rt0vnrcxqcM2cawdNDbegDmRGvGRJIs5wk4opTr4BHsVTNlqAeqrYKgqXZcKLAJd
	n63uDr9eHm+4i/atK4m0UJ81fFyF/OFSFRee+EHQHR/1NO+AR8+PqXuXWmP0jHfL
	Y8NKoY5FxfuHAHYsgLN0LckhO46QcCBMR1fVDSg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:No+lNDgp4je2Rl+AB6v3D6WbGJej3+BN9nNd4Lbmyw4=:tyZFehL0351JLa8pBfNu+Gq7cmTBKXH+dK+D07bfN3Y=;
X-ME-Sender: <xms:bmvQas_5EVPjyFyMaUEDPnOdfmaCHkxH5V57ts0bNyUoQGuqkTwGpA>
    <xme:bmvQasJOvQPlrRpqyVqANGkZ5T7HK-gRT3F40vtYWY0R58lYuh62XXU0dddXkeRWY
    fCRvqjhs7I-ppjJ6JuqkGtJJwTFl89vXGGFqpMjuEfYosPdx5rrQg>
X-ME-Received: <xmr:bmvQavbcsrdCfbf4TciQjA1LkHhpzCJwM0qFBHvRQDXSKoMEzBH-_5WUXmYWM-GfWSKJXSE>
X-ME-Proxy-Cause: dmFkZTGzA/d6c/3aXEA6QSc/AM3qGSKySyqHjTMwEPcO1wm0UzNK0Yxz+YfVJlw1lyWDPa
    ioPUoyT+kNc488XEPAyt0OU/9iWKUUQA4dB2z43NU016yDtDMFQd9Ao8xyHVzFg5IAaaWz
    wsRUHfA1reGA20+VcUuv1T104Z+AHXCGf5FImsq4ZWeVFbH0hUnfSk4bTzRx+dQkIJ6shE
    kR86EohjY4mlJETiIsZPlZL13XzsEgN5mGooMVcUKthBoJCyg37K68PP8Q3WtP90bjdTvX
    Ceu7I9bsJ1ywZ0yy4qAIklwwuHjeA0RdVLs13+7X9XE9w0YOIp3+qooFVF2IsVRkJLvBjJ
    o5FxNuH9oWPiusGK2/3Ymxa04t2qWWOkAEtpLootnX/0/0R/vsyo2bm51VXIUOhiY4IF59
    Pa0vOhXlj2oJgk5JfHs0TS+4nbGPBVhStuzAZqyZnp3nl4HxeL18oAWga0iWSELbILzVOH
    p5fT0fiNE+l28wsH53pgD7F7bOuUgX723EUMBkoJuBgZ100kcaQZ14V5lYxIYWITEuwMU3
    fyMykJA+Y0+RpK3Ia+71pRNtXaYEPDAj7rReUDVSRP8G12zcY/qPKEAE4AbFvBeyfI9NNz
    uNUBCPmu/b34KX5KyqD9SJ0+TdbtcWZJikVRND2M2tbhKlE7ssHZ7YyF2XgQ
X-ME-Proxy: <xmx:bmvQamKcP9mOnJojfiQujzgwAdcH6hnxvr7l4aIQFoUdkSECmYyYFw>
    <xmx:bmvQalAdTze2llLbRTFrLT-i2z3LkK7Tt9AQhlXuNlJotiolNmTz4w>
    <xmx:bmvQajrcVhEfMxh8bPg8cFEf6LJAOWThgYWTerbpwxKMZMYPE0AB6A>
    <xmx:bmvQaojqIivmNPqduYpGZHcmBeWwA6FC3q_31qV69YbEaN7RjaGQHA>
    <xmx:bmvQainDxBAhDhnrKm3Hk6wN1IhAwOs4dG1w0yGQS1ZtWDNkeOyHPUWl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 01:58:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 870f17ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 05:58:04 +0000 (UTC)
Date: Thu, 15 Oct 2026 07:58:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] refs/files: keep root refs out of loose ref cache
Message-ID: <atBraYoY1SVwnezN@pks.im>
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014153208.2194727-1-andy.koppe@gmail.com>

On Wed, Oct 14, 2026 at 04:32:08PM +0100, Andy Koppe wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 71628550f2..74409878b6 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -481,8 +481,21 @@ static void add_root_refs(struct files_ref_store *refs,
>  	for_each_root_ref(refs, fill_root_ref, &data);
>  }
>  
> -static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
> -					     unsigned int flags)
> +/*
> + * Create a separate ref cache containing only the root refs. These are kept
> + * out of the loose ref cache, which may already exist and is shared by
> + * iterations that should not include them.
> + */

This raises the question whether an alternative fix could have been to
teach the cache itself to skip over root refs in case the caller is not
interested in them. The answer may very well be a "no", but I would be
curious to learn why you settled on the proposed fix instead.

> +static struct ref_cache *create_root_ref_cache(struct files_ref_store *refs)
> +{
> +	struct ref_cache *cache = create_ref_cache(&refs->base, NULL);
> +
> +	cache->root->flag &= ~REF_INCOMPLETE;
> +	add_root_refs(refs, get_ref_dir(cache->root));
> +	return cache;
> +}
> +
> +static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
>  {
>  	if (!refs->loose) {
>  		struct ref_dir *dir;
> @@ -1094,9 +1107,17 @@ static struct ref_iterator *files_ref_iterator_begin(
>  	 * disk, and re-reads it if not.
>  	 */
>  
> -	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, flags),
> +	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
>  					      prefix, ref_store->repo, 1);
>  
> +	if (flags & REFS_FOR_EACH_INCLUDE_ROOT_REFS) {
> +		root_refs = create_root_ref_cache(refs);
> +		loose_iter = overlay_ref_iterator_begin(
> +				cache_ref_iterator_begin(root_refs, prefix,
> +							 ref_store->repo, 0),
> +				loose_iter);
> +	}

It's a bit weird that we recreate the root ref "cache" for every single
ref iterator we create that asks for root refs. Is there a reason why
you have decided to not actually cache the root refs the same way as we
cache the loose refs?

Thanks!

Patrick
