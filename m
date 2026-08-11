Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C2C282F30
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486539; cv=none; b=F0f9RAuJpxVkHyXZBqlhGXTrZdsMmA1VIS53aB3aJUVTryCF+n2ouEPlqslkvjjUnJ5fzml5nIoy5vRKAlR74l/IhL7Yk6Jx0uZz+bDwmKhVwgKBWduo9zTHO33WEURBNb1tS3tIBPjwiV0/L3HvhEJT6Mb64qyPV/QyAUZOIgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486539; c=relaxed/simple;
	bh=utdixoOG2mdvl0f5pzbCt6oKmQa2NrGe45ht4uDbrH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amz87cDkR4w1Xfu0JYYrO9iEnbhtVCXbckKUnDd+HbnHMaxnl56YclsUvw/6JW2N9vpMocdOvok7rKqD4mr1O7BiqDiQaH7wQ9MJYRbnfjjHOKjA/sIzzqwSsIEWHFaJq9CiwYtQcgu3l6GwjZOh6T4gelT+VfmjURwm/SfRvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD3/Nkd1; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD3/Nkd1"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb61bbeb25so326650a34.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 15:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786486536; x=1787091336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/j0hxncg+Jm/Nmu68KAfvXfmTM8UP9ggnDNfIHxo77g=;
        b=WD3/Nkd1vXHcEPLqmR0eNOdCwSWtddpopEjlDM1PVC0TE9RqOAjoeblryoP2DXqYx1
         MP1S8q9zK3oy95FVrbtTNKl4fsfvItjqzdaOdEjLUWBgxUpO55ydac11WfqlLEOSFl6h
         wRE2+UY8IbaQDfnZQI4+408iJtlcd3Sp9W6ITRlwONKdLLng7jqkQZR65m1xHJb9FI6e
         e6OY8LuW394l/z+hN+pHAk2ppUz6ZGKI1OvxkpVUU0nNs4o1NhmCenxmfgq5P7EnYDhj
         /QmQBVTDwIsniifPBAs7BlwNjS2P1A2gFXRTphqzEi6uIfBF0wGqki8bgjzI1ts0ZJKD
         qsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786486536; x=1787091336;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/j0hxncg+Jm/Nmu68KAfvXfmTM8UP9ggnDNfIHxo77g=;
        b=Ho9hlIflmhNFm0ybpwrx3EO3BJrKmlYbjI9Hp+l4M7otlotV/DvdNOBGUyih3Yjnea
         pMDEQoBdYUhL5CTExGE7UhItJdTq/dA6ULcxB+hmrrT3nDHP5Yf8mv/J9uWybluQlOjd
         LoSRYnDkhPBaslWP9s/UYjELR2atnh0Q4P2TozU8CxfCG4H1/7mQxxLICkEl74qymUFN
         oQ8q2fOqf3JeUrRQ2k0jJk9M7L+fePuGQF7fPqMPVe6sIXXL+p5WxohGtbeDOuA+OLSv
         79VeIEQhpj2d+gwYKVbZH6XSZRNCZdEkOr/HC4TZ1Bn4jl4IX9selgyJBHRc/k20OyHK
         m8eA==
X-Gm-Message-State: AOJu0YzzjM4ZlmrlsjBowWaLkKBM4CYYCGWWeKaE+2lTzwuqVSZ15aBt
	psSXmbyuXucF0HxwM24xrLWQOwVyVuioYcQG75oxmxyEjjeOobR22KDoKK5K7A==
X-Gm-Gg: AR+sD11ptxrQTfqOhwMyqq5kPs1Pa0k5yDgPvlW2TH1udnC9PQ32kBPkMYjKiPPnIs9
	1cnzaG6gIqqiSijsz9h6DFPZ4c0jREM5xDTCswz2WsPUCePSlcRxu5HdTaqYIGirg1UrNXDZZMe
	iFUAV+ClxinnDcx0trGix58ZvvoaUrvS4i3qFXigBOvOYSDhx8CVp5QUkQ+sU2xadqX2Ekin99x
	e/3K9EOx0/p9ZxueSOSzSU3DrTrxbp5IP/YZ3pVd2GOELmhqMMgT6+sqP1kFzUfZ4p/Bi1EwtFv
	xufzykzgxJxvRJjReFRS2l8xqlNddt2wOenR9HeszCWl42m/G/L8V2qJ3ap+ZgnC4GJcNRrBHTV
	tvzKScRdFllPLoGrQlZ5HG0u7G1TftIfSG2VvuYpdKfSKd9Pouy8fpiKYHN7BYVPIe/JBvk3HHy
	CiEZFOPB4i+rTE/cwbHIeEircSyk2BQy/Asho1Gn8W2OccBNGcwuZYQA==
X-Received: by 2002:a05:6830:6ae7:b0:7e6:e385:4c1e with SMTP id 46e09a7af769-7f3b76ff2c4mr565577a34.4.1786486536494;
        Tue, 11 Aug 2026 15:15:36 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b3420625sm962171a34.22.2026.08.11.15.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 15:15:35 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:15:33 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] odb: eagerly initialize alternates
Message-ID: <anucxvBIF-5Wmd33@denethor>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
 <20260810-pks-odb-eagerly-prepare-alternates-v1-2-f0fa4a4004e1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-pks-odb-eagerly-prepare-alternates-v1-2-f0fa4a4004e1@pks.im>

On 26/08/10 03:33PM, Patrick Steinhardt wrote:
> When creating the object database we initialize the main object database
> source, but we don't yet initialize its alternates. Instead, we have
> many calls to `odb_prepare_alternates()` cluttered around the code base
> whenever we are about to iterate through the sources.
> 
> This lazy loading doesn't really add much value: the moment where read

Should this say "where we read" instead?

> any object we _have_ to load the alternates anyway. So given that most
> of our commands would access the object database this optimization is
> not really buying us much in the first place. Quite on the contrary, it
> makes the code harder to understand and is a potential source of bugs in
> case any callsite forgot to prepare alternates before we iterate through
> the sources.
> 
> Historically though there was a reason why we deferred lazy-loading: it
> may happen that the repository has "core.ignoreCase" configured, and we
> use that to deduplicate the list of alternates in case we had the same
> alternate configured multiple times, but with different casing. We used
> to initialize the object database before we had fully configured the
> owning repository though, and consequently we couldn't access that
> configuration yet. This has changed in the preceding commit though where
> we started to parse "core.ignoreCase" manually.
> 
> Eagerly prepare alternates both when creating the object database and
> when flushing its caches. Drop the now-unneeded calls to prepare the
> alternates that are scattered across the code base.

This sounds like the right direction and overall much simpler. Nice.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -1091,6 +1071,8 @@ struct object_database *odb_new(struct repository *repo,
>  	o->alternate_db = secondary_sources;
>  	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
>  
> +	odb_prepare_alternates(o);

Now we eagerly prepare alternates at time of ODB creation.

> +
>  	free(primary_source);
>  	return o;
>  }
> @@ -1151,10 +1133,10 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
>  	 */
>  	if (flags & ODB_PREPARE_FLUSH_CACHES) {
>  		o->loaded_alternates = 0;
> +		odb_prepare_alternates(o);
>  		o->object_count_valid = 0;
>  	}

Ok we also invoke `odb_prepare_alternates()` when we need to refresh all
alternate sources. Makes sense.

The rest of this patch just removes the now-unneeded
`odb_prepare_alternates()` call sites and looks good.

-Justin
