Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FEA38BF61
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341486; cv=none; b=jzdg3XrLkjC7mnGwByrm5kQjr7QMQd2hNyVWGwBZDANFHUEu7HtAADGtTwbboWSz1uisxAj5IzIYKAcKE9oUzgbdstDOm/jMc6ez5e6XJdFCjr0taJJ0ie2jhsnqjL7e25z/52OEkCtSKGYdXCnyq+m/Tu8391aR+B5l2IfDF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341486; c=relaxed/simple;
	bh=5LT4hmuEwMonlucHp29iEu/6zgI8c65nhzhKHK/zlrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IigJ4uGtElN0TurobuUlFmIyQ/Dak2qkpWTFKqqa6ksYrNZhnha+LHJfapkgfuxv6VGbKVEMiJhdPLs5LqXgPtuacrJxS50P5mEL8JoOlNd5qrH6rGs6+KtyjDDYd+CahHZoaTJx5svMWnKlY2K3VMypo4zKVZBZ32Eoek/rlhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TbuGyDw6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=daC0PSIY; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TbuGyDw6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="daC0PSIY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE0A51400199;
	Tue, 24 Mar 2026 04:37:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Mar 2026 04:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774341477; x=1774427877; bh=0DxNcofaL9
	uHSiBfDONlKV+D7TclBxmQsWwJjGgHCag=; b=TbuGyDw6P3MpIrJ4/vNWV2E00k
	7zklPB5dYUbVgXCj4IRfXXSO2j/bT00gff49Uve1668Rf2dWWCgJwK2vIeqLDsXt
	K5gpyKo72BfXhZ3z/qDg60nj7wDB6AukrSzgAm9JF/ytpg76v0M4TNRNLdMTlBB4
	+xA2XubYwdZ/gwGwvxP2yFsHdct68HTKxHACdthh+jRIxj+pj7LIuwaAW8u9Q/SN
	5V7cCxo9n2QYi+VRlKvPg+tXJXbmoAcfS1ejU6bLZrBwIFqoaVJOYctwqnM5am41
	CMoK2SYvN+03YagRJiy1IDjq1jffuOwkD4I9NJn6Ziv1qWtksl+90IhILhEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774341477; x=1774427877; bh=0DxNcofaL9uHSiBfDONlKV+D7TclBxmQsWw
	JjGgHCag=; b=daC0PSIY5taaBrFO1L0xJle9z9CiYKoK2fP8ME9TkNfithzBcqC
	0FRte7yal39ZDoahM+spzfeP4O/9Ww/R4iWX8tFuoOuiFBeCK5A/7OLU1z+didJ/
	ipUFsDKzppKYePFbwF3Zv2dec5AyRE+UICpFOeDDKaQ74Fn/KiWkKoszDSBKtLh3
	McYpCh6dZ9NtR1RxqPSeMcSeCsBJnGax/+TPJ7c2FIjw+R/l5N0Qm1IdxTic+8RH
	eLzv9HnOIaGVdTOC4P0g1Dteem5UFpFJ/08zQheUhrbhFJOdCAGXdx+KabZgpUKN
	qkyjKvD5Pw2E6oZhOK+O6Zoofr5jBhysyqg==
X-ME-Sender: <xms:ZU3CadJnAnCfsZFxjtJbhO_dtMsrZqHyGsL-6rRCXC3WajDuBZaIaw>
    <xme:ZU3CaQDHEccJ1Z3X6eFqqlt5syODpPjxjIR0vD5Qvp3lj8lZuRWcvGW_40lbMnd7_
    SRPSUr19IlfSfg5j2PCQQ9AzC7pGr-BlOoA_rKa8eMKH3BEEs5rBw>
X-ME-Received: <xmr:ZU3CaeBNbtLxyXpNhmzcLOTeo3O3wOtdP5S_SPkIKdmvAeOFbD2fua0BDglMrq-AOrF6biGdqp5riKeB8jC5zF8nPJQvOUdrPHDbp3CF8iLj3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggurhhirghnrdhrrg
    htihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:ZU3CaaCSD0Mb0oVtl2HxvNPfVF_QHmwhojLuuL4eAh8s5Tfz3BOUxA>
    <xmx:ZU3CaRrr8qvN3jUnws5YcholBflWdNH24UVh3WSNdFgc_Ilah8HsjQ>
    <xmx:ZU3CacnPm8HoE_mOKXk08FlqRiF_Mizax1CfcLJDutPjD6pd6mSDWw>
    <xmx:ZU3CaZxWi512SLCwDqtXzVIGeIGKDXUri98VdnmRz3CWL3sZL9XQvw>
    <xmx:ZU3Cad3ORfSYnlWc2UQqkC2D0S9ZP2R9--OfYLFiC1YiSxVePVgCCtTY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 04:37:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bdf8c9a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 08:37:55 +0000 (UTC)
Date: Tue, 24 Mar 2026 09:37:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 05/10] hook: replace hook_list_clear() ->
 string_list_clear_func()
Message-ID: <acJNYPgOSO86hZYq@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-6-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320115211.177351-6-adrian.ratiu@collabora.com>

On Fri, Mar 20, 2026 at 01:52:06PM +0200, Adrian Ratiu wrote:
> diff --git a/hook.c b/hook.c
> index 6dfaa7e9b1..f6bb1999ae 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -52,8 +52,14 @@ const char *find_hook(struct repository *r, const char *name)
>  	return path.buf;
>  }
>  
> -static void hook_clear(struct hook *h, hook_data_free_fn cb_data_free)
> +/*
> + * Frees a struct hook stored as the util pointer of a string_list_item.
> + * Suitable for use as a string_list_clear_func_t callback.
> + */

This comment should probably live in the header. I also wonder whether
this wrapper isn't a bit too specific to freeing hooks with a string
list. Maybe it would be preferable to expose a "proper" `hook_free()`
function that only takes a hook, and then provide a small wrapper
function for freeing in the string list?

If so it feels like we're going a bit full circle though. Maybe the
original code wasn't all that bad in the first place?

Patrick
