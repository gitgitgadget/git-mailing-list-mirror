Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD925A33A
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367326; cv=none; b=X7Ls1ynI8UA2i7Gbqn1aWnR13PQo0YSSblUZfZtVCyU6tZpyldGMaTy1YLH05FTPYHioXteFS209JwECVmWLppvKlb90moC3qTE1GqZm/YOnOLrOiUs/q+DEp9yM9ApOoNET/ON5dVJxzx42eMabTSZSxQKAAVxvuFXhRCSUCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367326; c=relaxed/simple;
	bh=vTXvQZzZIiRIMOqg8/gWpYkNHuFEs6cMjNeQ1aoSnsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAiFcjXevosJFxCm8fxww1cpIt3Oqp7pPwk5z/JeIiCi9kWMSH0URczqtncKWGkaqZhmoImW5PBSdtZTFc3ww7zxMrJVtEhpIpWLHlGncOBPwAb9ggx9TMfgHbN29gaS16J7hVTeeXwgho8rG7qhFLutAcZ3vvjZELBX5kMCCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B+KNF7T1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TUpKjpTx; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B+KNF7T1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TUpKjpTx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A57727A0187;
	Tue,  1 Jul 2025 06:55:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Jul 2025 06:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751367323;
	 x=1751453723; bh=o4Co6HxHj0dzXVKN55QtVVC9Q65Q0PhWCJky3Vcrylk=; b=
	B+KNF7T1GYvLQ0j8p8LBj3qv5+7uy2Srdh3NPCGQ93VHN8ym9AdpaPsY4uRQFtw4
	DsbYrifMVFx8RpNlgbvNvsSVFSCiZTyo3i0ayQIMFu9hsw5w8elfWsrY5KE8ZXZv
	/AyRYlXXYTcIKFwYo+wvsbgklH0rsK86I7MseJCGlGIXqMNdoAdKJp8WJUx6qYa3
	2kSfuWHAc2uTiT+ADg68eFl7qyqR8Yp/lgUOLyfGhWHkv33uqlDpB+hx0+kDnZck
	uD1RXw2QflW8alZY3OGShAae4Ip8dFEjGz7AXTb/N4B7L+J5h+2oGadfvLvOOSzj
	xBu2IgnUEengHq9Uu+bvvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751367323; x=
	1751453723; bh=o4Co6HxHj0dzXVKN55QtVVC9Q65Q0PhWCJky3Vcrylk=; b=T
	UpKjpTx7oD2sZpqzzTfO4je0Rxvfl1m8y3o+KgHiSFbByvBKxGASXB7VtW5HVhXk
	4My+ZXJ4FbMTsFfD7DWWQDNDT0fF11DmIrD5r+YdY/8WKqr3aNFnKZL6bpwSH3ER
	NVP0ZqbIaQgJIPaU9Ti2ipU2MbCnqTG2fSckXCaNQPD1V1l+Lq0hvrx7PWnX8PAf
	v5HWHNfOumuBwKcm3P/EYDOyxQG40JC3Uz2bYgCvbDxd20bGNDuvSt96Ag1yqzJ0
	e1r37UQ3wOnNah0iBSUlvwJ8iT3s2AYVo/7clq3o3LOYsUsfsAgS7oYzeRO3z8CK
	M+acS/nzE8NEwyxRqj8Lw==
X-ME-Sender: <xms:m75jaE_CcUgK1XvFh3IHiFs8OhYNFqYc5xT6a-ofQQFooiG0kqZGlQ>
    <xme:m75jaMvRzPddazQwAOdnB8YbJ2BbOKSIU09MBHNzg-BwNVCiaK2RaKbkCiXJiUay_
    GaQ8mkof7AnsutciQ>
X-ME-Received: <xmr:m75jaKANNu-29ANJ34utwTecy28kZgq1qQeKUV1sHyuzBPK-_l1KEEWS7UJPiTxXnAxbkYZfDaZnxdS6YW6Os2oBv2EKWDp6VGXZ6DQj3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:m75jaEf5pP7XBxHhGLfWa2YhmgbTD5vhnICXZyU6JF9VSjLZzhWSFg>
    <xmx:m75jaJOx6z_k0QFzgP0NAN2U4ATgj0nUU-hbe45vCIbUYevWfJQT6A>
    <xmx:m75jaOlJT6fRYbt0Wqjl3MDlkQzr5jFSuzEGJ19VuWJc4YQpSL4nQA>
    <xmx:m75jaLtfkxxpihQV3vnWVIwNYmnXSZ0IEiq-_FENX9z9QUMJsWsP8w>
    <xmx:m75jaA8wmSkrmNs0DO8Sh_xBW8jDeuLHmejcCkldMb-bQthUl6nwMxv0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 06:55:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a53f428 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 10:55:22 +0000 (UTC)
Date: Tue, 1 Jul 2025 12:55:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/6] parse-options: add precision handling for
 OPTION_SET_INT
Message-ID: <aGO-l81JiOESvbS9@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <3690df99-8a83-4377-9b03-6766f7958c21@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3690df99-8a83-4377-9b03-6766f7958c21@web.de>

On Sun, Jun 29, 2025 at 01:50:39PM +0200, René Scharfe wrote:
> diff --git a/parse-options.c b/parse-options.c
> index da07a000a3..bbb68603cc 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -85,6 +85,36 @@ static intmax_t get_int_value(const struct option *opt)
>  	}
>  }
>  
> +static enum parse_opt_result set_int_value(const struct option *opt,
> +					   enum opt_parsed flags,
> +					   intmax_t value)
> +{
> +	switch (opt->precision) {
> +	case sizeof(int8_t):
> +		*(int8_t *)opt->value = value;
> +		return 0;
> +	case sizeof(int16_t):
> +		*(int16_t *)opt->value = value;
> +		return 0;
> +	case sizeof(int32_t):
> +		*(int32_t *)opt->value = value;
> +		return 0;
> +	case sizeof(int64_t):
> +		*(int64_t *)opt->value = value;
> +		return 0;
> +	default:
> +		BUG("invalid precision for option %s", optname(opt, flags));
> +	}
> +}

The function only ever dies or returns successfully, so can't we make it
return nothing instead? On the other hand it does make a couple of
callsites a bit nicer to read.

> +static int signed_int_fits(intmax_t value, size_t size)
> +{
> +	size_t bits = size * CHAR_BIT;
> +	intmax_t upper_bound = INTMAX_MAX >> (bitsizeof(intmax_t) - bits);
> +	intmax_t lower_bound = -upper_bound - 1;
> +	return lower_bound <= value && value <= upper_bound;
> +}
> +

Should we s/size/precision/ so that it's clear what kind of size this
exactly is?

Patrick
