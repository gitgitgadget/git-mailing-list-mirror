Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B0356A12
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023854; cv=none; b=FN3XfTxu+BvnOHuSREieQPG1ECpDqXAlsmcnifCo6FRBwsuVqO/w+fEUZIZJRs8nsfmXuiRPj9spdFWW29DAkosuOmDj0f+tFcyjWo/pSO8byO2u2BQQrUOGeM/zRdUuExxqHpwd8ZrOcvRQf8TEn6G9BedYC238RfbVeubcmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023854; c=relaxed/simple;
	bh=7iePBB6cxQx+a0K7j48lZo9jP0Oisq9WDmpLuzKcQMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dflv2gU6WF6F6a8zCjrzwOauCwJ6oe2wp29X8RMZDFdIYOcEehWCL2Kido4rZEHwqxM/97Tr2CGLLS0jHVosrOSP41tzEOBUHcgY5ZUezPb0ixrR9O621WSkZ1lM2za8/ghzFER+hAmB60rW3X/Pw0/NjZA/iVHTg/g97nhV9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yQCVYITj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O5jyAYyu; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yQCVYITj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O5jyAYyu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 64F2C1D0011E;
	Thu, 10 Sep 2026 03:04:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 10 Sep 2026 03:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789023851; x=1789110251; bh=toCmQ8xj9l
	8WxHZK4r1AMM99sWoTCBC5slyn9q07I9Y=; b=yQCVYITjG8rJktg7XIzalD5cME
	WR3Y+BgGUDJenGqZxbyyxIG93hJNK/JY1QVMIwzblsNVd9th43t2+KzDS38u/3+I
	yG3Byngb4GI9PGy+6hVIbML4UMPr+ze+aFBU27tLY9uetwyVzdDyxgCecWRQlFHN
	nDp6JZAQSMU0PeNOCHs9JqzqGTNuuksWwo6Nr/0OwE/ilXK5MIhxNHszmq2pD0oM
	pEcQkcIafUqYISZ5ZYG2N1VbGLsTGmziKff1xmFSIHvxcAP/l5uU/VmBIZ23DgTX
	QYjLw0dC26tLF2S9WfiAV2NfJ/8phLev3lfpZMBMcEKkPjCnv7t+uTk84srA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789023851; x=1789110251; bh=toCmQ8xj9l8WxHZK4r1AMM99sWoTCBC5sly
	n9q07I9Y=; b=O5jyAYyuMLiLItMbd6skdGAWJJDhy7VKBfH7siz9mWCyYrENTZF
	xDIgmb/j1ihXX9KkC6fodvHWCmxgV0Z/sZd2aBbhJuOkSD+f4N9DRooo0sA41WEF
	9VYuZiJQjriH6XZu1Q8lSkjBo9QhL0T7/jwQ1UyvnLHzEVyyhIn6NJQgQYt9utLK
	+Pu5H38x+0Ug9W3hQy+Ivk4KgLzeyvgXMQZ14UU2X8tmhqz+F3A2eDs8+nCp5X0A
	eUDQNgIbBmUVkU5aLMJb7sr6qRxTMxuEj1DMlhB32oOdyyp/g27sPOd5rzgX1KAl
	ew3z/lHzD7DD+Pyh5a6R0u5lOXxqEUGf+uQ==
X-ME-Sender: <xms:alaiatz4LxkcFAanCGhDKT7xt_RQLxqocr4IwBFJRLNP36jMEQP7OA>
    <xme:alaiakKE_yBoAgwfKNRPWAKvk7oAyMfuIbFEI9RgyqwfnMpkPfMzwlm4ixh4_0PlY
    zW8aOnpoDqivfyyEGgW3iYUasC6guOKhmQyZCCjvYec56ERzp0_Hjo>
X-ME-Received: <xmr:alaiavouiWmlDlq3hkq0hG0SDR-l11aNRb61X8qMspGQiojxoql1aQ>
X-ME-Proxy-Cause: dmFkZTEk0L3HpALCiE6TtBb2I5fX0Zczcp8mWSvz9GNppDuMaOOnFDKAGvua+JfzvLj2YV
    4AERTVSa891OlpMUszD3VICN4plONrXhxLC5O9Z3nt7GIZxpo9EdZ/FMubPvVkIcMB3Oie
    yI6+bYbEh6GUb/uk987wiRp5J12vLFwNZYObzHi7s1mXlKhLRofb8OjikDx/msYLz8JWWC
    lH5CkPgQF0ndWDNJJd2J+hKmZczCnC2rFplQ9BQvFsKHTIkO3xvcDzQjs6rW2iQhjKL1Vc
    AhdEp4LKJD3kYswbSL67jDHBPg/2G4rQFCBh+esst8hnYb/Ba86kmeIkI/DwOM4atuFXsJ
    fntAJ+3A3s9wJoa+FCM5YXs9Bdvg/URvj6PnWtLlC9fHIAwe9kVqc3u3ZyG/i2qiJvq7oM
    SUCu5lWYokf8AkK+2a2sa32ufWQOW4XaZTAW2yg3pqRnEuXrAM5GKkHI485Lx0t0DELCVY
    tEaxyFL7fDStrXb4BMASsRC/VYCf6i9i3Zz2cnOLEfOAtEgx/C0p9uj2d+wzJgVGz+W64d
    g7/wU83Hcbbdwbv8xjNA5EmGYger7i9TjJkJ6gTZDNqzvuPxAUfxGsQEkxllW+xo0vmvRf
    4eKkXcGDtdMihJru+Xzz2eaLBJXxC2s7tcAv8PspqyPQiyKhXnXED/POXkwQ
X-ME-Proxy: <xmx:alaiarLGts_UlpjDlg2UlJxlqNx3TNyeeycvhtVw9ceM2ho8Y8WaXQ>
    <xmx:alaiasRChGR6ufn45mCAZN4DkWPLJLgceFDAjDVw44ly9kPTsfl3Lg>
    <xmx:alaiaivf-Cg8ZB52WJt640Cir51_ptH3ncI-f3weQcJrPXzxoAfQFw>
    <xmx:alaialbvVGbWicxm86xDKW7ikS0I4bxmSY5v-4s-76No4JB3x-Gy8Q>
    <xmx:a1aiajYHzGymF5L12SHbaX_hVlHtupcQvXA52SNiR0k5BMcHzK0JVmRn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 03:04:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57483087 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 07:04:07 +0000 (UTC)
Date: Thu, 10 Sep 2026 09:03:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 3/6] bloom: add helper to check if any key in a vector
 is present
Message-ID: <aqJWX0INerT8F687@pks.im>
References: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
 <20260901-toon-speed-up-last-modified-v4-3-a09949800404@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-toon-speed-up-last-modified-v4-3-a09949800404@iotcl.com>

On Tue, Sep 01, 2026 at 11:10:23AM +0200, Toon Claes wrote:
> diff --git a/bloom.c b/bloom.c
> index caf22f9831..b96534e6e3 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -607,6 +607,18 @@ int bloom_filter_contains_vec(const struct bloom_filter *filter,
>  	return ret;
>  }
>  
> +int bloom_filter_contains_any_vec(const struct bloom_filter *filter,
> +				  const struct bloom_keyvec *vec,
> +				  const struct bloom_filter_settings *settings)
> +{
> +	int ret = 0;
> +
> +	for (size_t nr = 0; !ret && nr < vec->count; nr++)
> +		ret = bloom_filter_contains(filter, &vec->key[nr], settings);
> +
> +	return ret;
> +}

`bloom_filter_contains()` may also return -1 in case `filter->len == 0`,
and we'd bubble up that code. But here...

> diff --git a/bloom.h b/bloom.h
> index 92ab2100d3..f508db23ad 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -164,6 +164,17 @@ int bloom_filter_contains_vec(const struct bloom_filter *filter,
>  			      const struct bloom_keyvec *v,
>  			      const struct bloom_filter_settings *settings);
>  
> +/*
> + * bloom_filter_contains_any_vec - Check if any key in a key vector is in the
> + * Bloom filter.
> + *
> + * Returns 1 if **any** key in the vector is present in the filter, 0 if none
> + * of them are.
> + */
> +int bloom_filter_contains_any_vec(const struct bloom_filter *filter,
> +				  const struct bloom_keyvec *v,
> +				  const struct bloom_filter_settings *settings);

... you only document that it may return 0 or 1. We should either
properly document this or munge the returned value to be 0 or 1, only.
And if so, we could probably adapt this function to have a boolean
return value.

Patrick
