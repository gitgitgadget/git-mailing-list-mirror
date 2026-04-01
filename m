Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995D43CEFD
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051221; cv=none; b=tUJ/aYsF77x3HDSA+uN+1PxGWwYWvs3n4dc8SMeXZ02DIGy/vonyoIRY41ul2XOtsTf6w2WVLfnBzpHdKNbuzOa2T7703YLlPe/sH2wS29Zc3s8z6nUMcP8hDPGnMpJywDnPNEJh4LexBqqOlE5n6aVkH14oiy+1egfKThys94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051221; c=relaxed/simple;
	bh=SSUkkLGr1VxK+1mp8s8jnkRMiTeFIGWXV8q3GfB7/kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEiwm2Zh+gWvLJwU7mKSIWE2L9RRWDJBiBKID3099VCZsyz8uOYuNvlWgEY1wCIVPDAcrKL+3cRbWNmbEW/l5zWtFBe7KRgJHpH69PRG8Q9kLqmnIRB2FYCkfbMEotD7ZDILa6dhOcqxMChr/6KKJ/UzwgDYFbQccfPZnD6RR5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wKF8NVff; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fAMvaTfM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wKF8NVff";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fAMvaTfM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D5CCEC0302;
	Wed,  1 Apr 2026 09:46:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 01 Apr 2026 09:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775051219; x=1775137619; bh=hGJoRSCs6S
	8VIj3ihheLbbRyKFZlvb0qMFaF19RXNiM=; b=wKF8NVffJ/BUjX0tzMXpNXWwFj
	189/OPXZYsPMbaMrHgndMMeSggxCGqvw2QBzAN4Nz1y6Qkw3RNOYTI1wEqvzHC16
	coJ8nj9cI1bgEnNwSnX+5YEWmW6V1hLUQFQ/ATbOw9gjboNZUQMXH//LN/LzxmGj
	azfo9MyNZIgmV81CNgKTsEbdEZ4u+POrRxlpikAmbVYJvYBAICyrDxpRAQm+QBwd
	bJFisW0jfZbzlzjImD39yI03FpP4pP1v+paiZnbIM6jyOcuqGPxh74rya/jNk6tA
	wd3uunD1LKiGDmbmSmCRYpVy9H/+JDIzwD76N8JO/2wSzcvEOrqIQVBAlBJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775051219; x=1775137619; bh=hGJoRSCs6S8VIj3ihheLbbRyKFZlvb0qMFa
	F19RXNiM=; b=fAMvaTfMfyj0+vGZRgwrgCwrnPOi6l4eOr8Tj13GVBS06sjMI/z
	lNpvym1nqsSlpOnvx6uzt4ev5W7RzF3uIdArkgiSa5LJA10kPyzu44xPDHJb52F2
	aBGr62cCHTLriYUgEOMKWIGbOGL6wQWk7c3ecgZ9d/03g1EnOa4PZhVBHpGEyW1I
	aZPOYy4IA9+syXv90x6K8qHwM+9LwsHnT4yjJY9kaEhEwxnTibNwblgz7PU4EIR9
	4gca+8seH1InmAPMhBH+uD3D6Tfa6eZhElhP2TXq2g1cXQAB59LjxiswQRao3Vb8
	X0g3/ZCKVKwDpzjJjNdYgm63K5xU6Q9eraA==
X-ME-Sender: <xms:0yHNaZ1HlsK7VWk4MUaT815UmrgODsJZsCLRzwDyBO41dQdTARO3Qw>
    <xme:0yHNaXFMPmycIAkNthcyzPgKpZjcdgIN-3YLoXEHHSy9ipDj6kiEFao6v6C0IMrWE
    XGXc7V0XgvaFy9awjSeTGoOb3P3mkFSxYuWCCHu_OgGOsi9az7LfA>
X-ME-Received: <xmr:0yHNae4fSvPMeDsJxQ081YeR5yXJU1RAJaXXMPhQxmP2hlm3Vx29gX25i7RsOEzZdRSV5gM9sEx1wsO-Zn18p2QerUyfs72W9gv8I-il_cs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesghhruhgsihigrdgvuhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    ohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0yHNaVt6x9vJRlCFHXsn21omFdoojQMK_Wo08bK4LuV25WweIg45kQ>
    <xmx:0yHNaX4QAi-gDuNu9c9TybbmHftJEfZiLllUjEgEPLLhDomNHrU5gA>
    <xmx:0yHNaYWHcKVx-t_KPsCRp9N8MIB5Ypq8va-nrJQVKGgf7oWkI2He4A>
    <xmx:0yHNaR9FMleMhbxsOyQi_YsP4CDdo5TqsRNNO1peE1UsBauoRNClBg>
    <xmx:0yHNaccU1puZUYSQK50qGwYU9f1kaeZPdpAbyLgVfusPBle3sysWqt-o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 09:46:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7eb18aa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 13:46:57 +0000 (UTC)
Date: Wed, 1 Apr 2026 15:46:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 08/12] skip_prefix(): check const match between in and
 out params
Message-ID: <ac0hzlDdqEEPPMkh@pks.im>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331235017.GH2328529@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331235017.GH2328529@coredump.intra.peff.net>

On Tue, Mar 31, 2026 at 07:50:17PM -0400, Jeff King wrote:
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4bb59b3101..58e494e037 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -491,6 +491,23 @@ static inline bool skip_prefix(const char *str, const char *prefix,
>  	return false;
>  }
>  
> +/*
> + * Check that an out-parameter that is "at least as const as" a matching
> + * in-parameter. For example, skip_prefix() will return "out" that is a subset
> + * of "str". So:
> + *
> + *  const str, const out: ok
> + *  non-const str, const out: ok
> + *  non-const str, non-const out: ok
> + *  const str, non-const out: compile error
> + *
> + *  See the skip_prefix macro below for an example of use.
> + */
> +#define CONST_OUTPARAM(in, out) \
> +    ((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))
> +#define skip_prefix(str, prefix, out) \
> +	skip_prefix((str), (prefix), CONST_OUTPARAM((str), (out)))

Okay. In theory this would cause us to evaluate both `out` and `str`
multiple times. But I guess because this is a dead branch we expect the
compiler to optimize these statements away so that we don't have to
worry about this.

Constructs like this always feel a bit dirty, but I guess this is going
to be fine in practice.

Patrick
