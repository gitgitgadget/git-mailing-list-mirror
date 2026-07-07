Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA942A151
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435169; cv=none; b=KBos1Teh15CkLAcuXh8olQ2LyimDjTBIOHMPsqsvUSZlZB6YeNZvMqkRzik2i4b09vxKBvb1V6A+HnOL6xr6ZLDgq0Cs4X0gvyPcUX6FH4YXADwoTwczVKrpJWtD8MyOPzTQVi5gvAkSsmANDUGq30/NRNtVgE1MHvKsiFj6Eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435169; c=relaxed/simple;
	bh=nss+EK5OuuS5g4kS/O6w8XQw/+QVevonoHCjWGRX61s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HOvxfUwVtzUpO5NaPU3AWiG+R76RhgQ7XTGifOqJc8L9Lfjy+CjTCZMm9j3Pb6zliYpAxl1uQJvQVeAIC/Qc0x9/6szozpB+8gfCqkTUUP4MCy3TCNoPaRj5BIqhMCZkjSBYayyBsFDiGNqbx1SBwEc/7RiXk7DGdmcSwL53s1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kUQPjGYb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YdwgilAA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kUQPjGYb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YdwgilAA"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B92727A002D;
	Tue,  7 Jul 2026 10:39:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 07 Jul 2026 10:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783435166; x=1783521566; bh=yp+/HCblMe
	L2SVvFJ8pcqfmsWrKUUhNM/mzbf8G4hcA=; b=kUQPjGYbtMUYIvgaC4URvIsJ4g
	rPGRTz93LFMW4kFXd9U9EovjzqCvVA9ruZV2lCS6S9fjGfelvmc8QXAA8UqAYg1j
	mlxJ9nHOiITvmFTKaav8jak5ZlzQPokHUgaeqo3Dc/33AZrWMzG0hp10sJzVWKYL
	LXWm9cF+A26wWQWr0xEoQZhKudYr76G2J7oGvOUv8c5Cr+SP9Llryw7U9r083S4N
	zoVJPRmgvoFNH7Ai0ScPy2qaM8af+7zsUPGmPwXQwBgVfH0Ijp6QlWhBBBhGeDP/
	v8qxCQD1HCvigtAL8NIuxG5Hi8rlbff/NteelcRCQMuoyccNrHf9BAhOS6Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783435166; x=1783521566; bh=yp+/HCblMeL2SVvFJ8pcqfmsWrKUUhNM/mz
	bf8G4hcA=; b=YdwgilAAIvhnquWDD73nSLREDEuo9R7yuWlqWGDnxkQl70ttTzJ
	uPX6kl1uKYG87SLXoQNbVPhamgUSd46fozAbqC4Lpsm1Gr8EZwOCiC/hTuoqYUc8
	cqJYkFbftEVKrbF1H9r+6FYRZIpi9EqZJrmqzcoGVoRiRG3jhM0f1RwSS3S6Fr6k
	60g/VX1g5Q4VzShBFNQr3MBOPH9DIr6VjAbzJOkJZLC80Nj6dRi8Ih5CZwU+njyi
	7GCvAKDZtjjYsW8seK0XPLu2lUrnuZm3nALZNeWr6bvgUHiSu9mtTGsiW+/z8YYD
	BCqIk1KGA3Dh6BS3HVRullpOMXP4I+rEGtw==
X-ME-Sender: <xms:ng9NaiVlrlWBOvEuLBvHquQLljze_Z4UdsO7BQi5WZIvgvyI637Rww>
    <xme:ng9Nalc1aZlR5eV-iQbEph3G-C6YhjwvN2QZzm-nsdJIimXYRcIcKIFo7X79Dv9bY
    k7b-gtaCLvBA8chJ51d6Vfr5K9xgP8BVC-waqiaECb3J5gBdfYzww>
X-ME-Received: <xmr:ng9Nauty_hhFrSfGpie6H2ZE_5w36R-5COUP0J9CTPsHq55W1DTnaxmw-J5JKBo4ULrbsyj0vAlybaCsEwrkWnPFAdY6yvEToPfX8HQ>
X-ME-Proxy-Cause: dmFkZTGs6o4Gj4AziBdYFcUqt81sgfCsVs/SGpSJjM7N+XUl6PesPE9s9REpxdCUBBIPtt
    dCVwOeqS1aUETrtvVSAqJv02Vs/41b5bjuW7W+BXtTlSORlLkAMLpyqXfpll4Aq6544PK0
    ogoR24tKnuhWcwtwWP4ZdT48ADlxcctLJ4JS9SE9FuIOsqUt2cryHZ32ebsIrISLTeh7+d
    3GYJ0BsHp2D4yb6hZt2B5ZFGJ4Z2/9x+nTvU7xupwy/nv6Z3kATNszn1lZWuLGdCWX5PUo
    XCBn25f+ALKE9U5cFpRAvW8JEZGh+EOIbtW+HPMu1jSqWq7NDVqipSs3HzHqr/1hvAm7Ot
    njmZUhZJTfGOX786olg/z4iZC/kCN75KD10cofI3bVbH92zdILPtqsYDNLosSFaEp66wtD
    W6rH5WrobIJFqep6hcxFSB1TYQGMBxuBBxHmDpEeLvJsMPdr76M6I1ZKAm1zB9socYPNM1
    oPjeRJlqy/irPupmLUDjPKdb3SVs13tW3FzZDLEG8lzLQCQvInvXc2ziX1ijAOZ1y3GxSN
    uyQze0S4IRrUyBHzTCRHbVxEu3ZlsCuk+pt+RU2WD4XOH86ict5CD9nhRI6VBHMiWIkjeo
    Tsaa8aCHYsXff07V/1ghDCDdO5aNWhm+hxJfTEUci5F8Sk0xtl3m/X/FGZ+g
X-ME-Proxy: <xmx:ng9Nak86238I1Ct7xHGxL-KDATK43fpbs4SIGuS_VvOAK-9uHll14A>
    <xmx:ng9Nap2KpN6X-7nFSYPx9VYw5oAUQFeOr33CLth8pXUwpCpYXZr0Bg>
    <xmx:ng9NapBsUJOh3LrKEFTATGfjUmu_JUVBzMf9W64otzzvWcJYN6urgQ>
    <xmx:ng9NalfhwEWpEvGVUDIVE6reyj6JNlGiKukzvkDw0YEP9KXRPVbBqA>
    <xmx:ng9NaqMGrn42rwuunF4Sto_1oCHz3tGVK2FcfepWwUu48p_GyNZCvzrR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 10:39:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/7] hash: use git_hash_init() consistently
In-Reply-To: <20260707050141.GA1288294@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jul 2026 01:01:41 -0400")
References: <20260707045556.GA1288172@coredump.intra.peff.net>
	<20260707050141.GA1288294@coredump.intra.peff.net>
Date: Tue, 07 Jul 2026 07:39:24 -0700
Message-ID: <xmqq5x2q984j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We'd like to add more logic to git_hash_init(), but many callers skip it
> and call algop->init_fn() directly. Let's make sure we're consistently
> using the wrapper by adding a coccinelle rule.
>
> Besides the coccinelle file itself, this is a purely mechanical
> conversion based on the patch it generates. There should be no bare
> init_fn() calls left (except for the one in the wrapper).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It feels like the "expression ALGO" in the rule should be a
> "git_hash_algo", but I had trouble getting coccinelle to recognize all
> cases when I did that. Probably not worth digging too far into, as
> the presence of the git_hash_ctx type means we should never hit any
> false positives.

Thanks.  May conversions do look simple and straight-forward, but
some look a bit curious.

> diff --git a/object-file.c b/object-file.c
> index e3c68cfb66..f292683c2d 100644
> --- a/object-file.c
> +++ b/object-file.c
> ...
> -	algo->init_fn(c);
> -	if (compat && compat_c)
> -		compat->init_fn(compat_c);
> +	git_hash_init(c, algo);
> +	if (compat && compat_c) {
> +		git_hash_init(compat_c, compat);
> +	}

For example, it is a mystery how Coccinelle decided to add a pair of
braces around this single statement.  It should be obvious that the
corresponding single statement in the original did not need one.

> diff --git a/rerere.c b/rerere.c
> index 8232542585..2e932439a4 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -438,8 +438,9 @@ static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_siz
>  	struct git_hash_ctx ctx;
>  	struct strbuf buf = STRBUF_INIT, out = STRBUF_INIT;
>  	int has_conflicts = 0;
> -	if (hash)
> -		the_hash_algo->init_fn(&ctx);
> +	if (hash) {
> +		git_hash_init(&ctx, the_hash_algo);
> +	}

Ditto.

