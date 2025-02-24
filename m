Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF92571CB
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409768; cv=none; b=mqEk9m/N4lFrHfuRhB5tlETRTJfY09R425yvzmTqIuWosm239dIbcvb9aq2p0Pe3N/E/DZ8EhmKDIQOm22pL79NKa24+BKeUo9pkkgqf34RHNEhzIJ3z0eHjl9g5bnPB0n49RjX7kQUFhvB/ZKPlYqw6AJM5tVhbVGuS2mYH2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409768; c=relaxed/simple;
	bh=Mnx0NjJAwn7rE/GnnubF67FZimg4UXzz450XvMfSAMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm8WAWeoJn68PUCEJ6WQ6NeJ8EtjFGU9mYogDdl61E2UJb/t/FEmaZkH1Svgs0Z92fHmdt7ezFR7UOtlhRQgIllV62q4phs21TduMr48Go7Pm+Hw/490gyW0S/mG/b27yFXM8sZVsQdl+9sFCEDOCPkC3wxT8IrgSepE4Ewl/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9t0Qnj5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9t0Qnj5"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-219f8263ae0so94352375ad.0
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 07:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740409766; x=1741014566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TwImsbLIGn1zWY/C4YJMHVOfqeqyPLwqJwBV0JS+ZDc=;
        b=i9t0Qnj50sE28w1B90B5o6+sjcGC4Xg+yItmAoRN2cWag9OjbHF/LB3IsY6CWwt+iL
         RT/JL53ZOQY8ltvS40r0p5FxBeqREt6/BPbi9BVSu3qcLlv2JSXbfQWC0a/7UayCxXWV
         L8jwFtcJoOYJNL0Tg318Ktt0Abz1zPsCYD9ZiX97s3/Ga/aKQDw4cN499mXYjOlsTJq0
         QN5wG/xxSufWwisbSpvrV64sWVqIzqdVtjo90uDH9RJFSlM8Jimo1TT5B5f+AO4dtFhZ
         EwkyweBWRgH92NtYAvI5DurDiUgzxfbfWR0eADxcl0zx/2wdMLBUc3f1EKPey3bxvU/X
         exuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740409766; x=1741014566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwImsbLIGn1zWY/C4YJMHVOfqeqyPLwqJwBV0JS+ZDc=;
        b=GkMkCGnuNCEXtFP4IBr8J8vnX85VOG7oSBadjxApAasTTBHZUMdnI9h+mPNRYMNT9l
         DIqtpo5mPqdRZqmRqX5K4qgdK0vMH1k8o/fmvhsSIdyJ41dVoTq1/5xNMsU01GDoAMNX
         dIyRg4L/Oe/Pg8glYsPigj/G8r3Gpk9h6Cn3Q41ULrfeBhw/Zv35YE2KjYOyig3As3NZ
         lFWSESH9M0k5cf0jI2jghDI0HaMAPiqxrQncqxjfQ3FzV1u9DcKW6rH3kyKFGfuJI3Nv
         b5+cTlOAMzC4mCsBzrBOTDhhHwbjjq7XJoozI03A2o1ugljkW93k88mdTeKuUh8yM2Dr
         f2Xw==
X-Gm-Message-State: AOJu0YyV4u/OgqoEDJg0Zx7SU1kQZDW6gL3RUdH3Yp2YlGvFsln3ms4B
	1fDDFLcLDq1bc+gqBwa5a0lXJ6hui8SGrwMWaiGYl1oTA/Pg016A
X-Gm-Gg: ASbGncsTEnwawa5JiSuR5UgZTEfch6GrAvZdFsRV4X4UnbodPs56bPAYzCCkXQWd5tz
	zinXZINeZgtQWq3UobObXPG3UeW8idIEBc1MpiV+Cj1rMd/EmEFRFb4bVsUB2UpCJRXzJzV67Gg
	FUYfocO1i6HntCPZuaRBd0kDhlfo09SE1ONEx1XvvW2TM0Eda19KU5yhTMR3ddAVzFLaRPvgwNx
	h3TdSA5JHuhJDbFDJBwOSXCM5bVxqEbj8F5phEvAvX9yJs+0QDWBrZF5vcxKtX2pVCUGNPhO5Ka
	mHhPOxPEPOMVu9jOM77X7A==
X-Google-Smtp-Source: AGHT+IFeKJOpuHymOAym3wdpShOLRz8mMLiw2rHRb653bnB1WPmM+WHpHIozWvAQXW+ZuqkAR9zlsg==
X-Received: by 2002:a17:902:ce88:b0:21f:4c8b:c511 with SMTP id d9443c01a7336-221a1191b71mr209835015ad.33.1740409765831;
        Mon, 24 Feb 2025 07:09:25 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d536455esm182514945ad.74.2025.02.24.07.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:09:25 -0800 (PST)
Date: Mon, 24 Feb 2025 23:09:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 14/16] refs/iterator: implement seeking for
 `packed-ref` iterators
Message-ID: <Z7yLrKVxCF5qb7gP@ArchLinux>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-14-e696e7220b22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-pks-update-ref-optimization-v2-14-e696e7220b22@pks.im>

On Wed, Feb 19, 2025 at 02:23:41PM +0100, Patrick Steinhardt wrote:
> Implement seeking of `packed-ref` iterators. The implementation is again
> straight forward, except that we cannot continue to use the prefix
> iterator as we would otherwise not be able to reseek the iterator
> anymore in case one first asks for an empty and then for a non-empty
> prefix. Instead, we open-code the logic to in `advance()`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/packed-backend.c | 62 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 38a1956d1a8..71a38acfedc 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -819,6 +819,8 @@ struct packed_ref_iterator {
>  
>  	struct snapshot *snapshot;
>  
> +	char *prefix;
> +
>  	/* The current position in the snapshot's buffer: */
>  	const char *pos;
>  
> @@ -841,11 +843,9 @@ struct packed_ref_iterator {
>  };
>  
>  /*
> - * Move the iterator to the next record in the snapshot, without
> - * respect for whether the record is actually required by the current
> - * iteration. Adjust the fields in `iter` and return `ITER_OK` or
> - * `ITER_DONE`. This function does not free the iterator in the case
> - * of `ITER_DONE`.
> + * Move the iterator to the next record in the snapshot. Adjust the fields in
> + * `iter` and return `ITER_OK` or `ITER_DONE`. This function does not free the
> + * iterator in the case of `ITER_DONE`.
>   */
>  static int next_record(struct packed_ref_iterator *iter)
>  {
> @@ -942,6 +942,9 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  	int ok;
>  
>  	while ((ok = next_record(iter)) == ITER_OK) {
> +		const char *refname = iter->base.refname;
> +		const char *prefix = iter->prefix;
> +
>  		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
>  		    !is_per_worktree_ref(iter->base.refname))
>  			continue;
> @@ -951,12 +954,41 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  					    &iter->oid, iter->flags))
>  			continue;
>  
> +		while (prefix && *prefix) {
> +			if (*refname < *prefix)
> +				BUG("packed-refs backend yielded reference preceding its prefix");
> +			else if (*refname > *prefix)
> +				return ITER_DONE;
> +			prefix++;
> +			refname++;
> +		}

Although I cannot understand the code, I want to ask a question here, we
we need to do this in `advance`? Should we check this for
`packed_ref_iterator_seek` or in the `next_record` function?

Before we introduce `seek`, we don't need this logic. I somehow think we
should do this in `packed_ref_iterator_seek`.

> +
>  		return ITER_OK;
>  	}
>  
>  	return ok;
>  }
>  
> +static int packed_ref_iterator_seek(struct ref_iterator *ref_iterator,
> +				    const char *prefix)
> +{
> +	struct packed_ref_iterator *iter =
> +		(struct packed_ref_iterator *)ref_iterator;
> +	const char *start;
> +
> +	if (prefix && *prefix)
> +		start = find_reference_location(iter->snapshot, prefix, 0);
> +	else
> +		start = iter->snapshot->start;
> +
> +	free(iter->prefix);
> +	iter->prefix = xstrdup_or_null(prefix);
> +	iter->pos = start;
> +	iter->eof = iter->snapshot->eof;
> +
> +	return 0;
> +}
> +
>  static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
>  				   struct object_id *peeled)
>  {
> @@ -979,11 +1011,13 @@ static void packed_ref_iterator_release(struct ref_iterator *ref_iterator)
>  		(struct packed_ref_iterator *)ref_iterator;
>  	strbuf_release(&iter->refname_buf);
>  	free(iter->jump);
> +	free(iter->prefix);
>  	release_snapshot(iter->snapshot);
>  }
>  
>  static struct ref_iterator_vtable packed_ref_iterator_vtable = {
>  	.advance = packed_ref_iterator_advance,
> +	.seek = packed_ref_iterator_seek,
>  	.peel = packed_ref_iterator_peel,
>  	.release = packed_ref_iterator_release,
>  };
> @@ -1097,7 +1131,6 @@ static struct ref_iterator *packed_ref_iterator_begin(
>  {
>  	struct packed_ref_store *refs;
>  	struct snapshot *snapshot;
> -	const char *start;
>  	struct packed_ref_iterator *iter;
>  	struct ref_iterator *ref_iterator;
>  	unsigned int required_flags = REF_STORE_READ;
> @@ -1113,14 +1146,6 @@ static struct ref_iterator *packed_ref_iterator_begin(
>  	 */
>  	snapshot = get_snapshot(refs);
>  
> -	if (prefix && *prefix)
> -		start = find_reference_location(snapshot, prefix, 0);
> -	else
> -		start = snapshot->start;
> -
> -	if (start == snapshot->eof)
> -		return empty_ref_iterator_begin();
> -

So, we don't return empty ref iterator. This is the same motivation like
the previous patch.

>  	CALLOC_ARRAY(iter, 1);
>  	ref_iterator = &iter->base;
>  	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable);
> @@ -1130,19 +1155,12 @@ static struct ref_iterator *packed_ref_iterator_begin(
>  
>  	iter->snapshot = snapshot;
>  	acquire_snapshot(snapshot);
> -
> -	iter->pos = start;
> -	iter->eof = snapshot->eof;
>  	strbuf_init(&iter->refname_buf, 0);
> -
>  	iter->base.oid = &iter->oid;
> -
>  	iter->repo = ref_store->repo;
>  	iter->flags = flags;
>  
> -	if (prefix && *prefix)
> -		/* Stop iteration after we've gone *past* prefix: */
> -		ref_iterator = prefix_ref_iterator_begin(ref_iterator, prefix, 0);
> +	packed_ref_iterator_seek(&iter->base, prefix);

Why don't we check the return value here? Actually, in the previous
patch, `cache_ref_iterator_seek` will always return 0, but you still
check. I have thought that you just want to be more defensive.

Thanks,
Jialuo
