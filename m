Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CFC431A30
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142851; cv=none; b=chodB2uoZqwNk3nNBHJ5ytwwYMsPWhwYv8xH/ZHUL2tbDrTkyTh+Dq9G0xOy10VdjgWE5givIT1MGKDKbnCrHnVKNnwB39Hufipf/8hz787L7KXsGGuWdXqIlleew/BtkMtFoYRuGn9QwcnQTg4U28jqZzXoJnpkH1M5buPal6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142851; c=relaxed/simple;
	bh=T0TcBFR9KrNNQ13m6ABqserFPCHTPfP4TxsXJjsDFgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r9lX/3Ec3iyQOcisC2bg36ZTE5k4pqLYxDaGLrPvTR51iz695rhpkw5G7RuftcoC/xlPhVLSPegkCPgEQ9XjuRxcQaiKea195zSqf8GG/C81mHXfpcYMBtMG/pLxy3QbISBsiqKBbPfOTMemjvaKZ93MKMgi8IgOpnxRNLw8CEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mPrj16Cc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bDLoqc7T; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mPrj16Cc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bDLoqc7T"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBEE67A0118;
	Wed, 15 Jul 2026 15:13:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jul 2026 15:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784142827; x=1784229227; bh=OEX8tfJNzL
	S0HYXUnrVliqoLgv6xlfebbJXEIaNKR4M=; b=mPrj16CcFT0lciik0FFvVH1fJj
	4NIsvqO6gHIn9j/YPsqPQuItOHTo6k5UpX147T9dr4CRs2rX41174SKfI67DsOpw
	/rlrpel3UOGILZXgwix/SGPXCEKKs/21LSMr5O4yIoK9uW5v71s/PK+HOwdkuK4b
	vER5LrkE3HyaQHN0Qml8j0OTNQMdhxqrZEb+4CYXhsXtvNlZ66WShGnztE4QdU6e
	gSJZfF460jV8ra1uUX4fta2EzK/Zb3o7dJjlRn01cgaecRUV4JCoBl6Ik7eXg1BC
	X7hAlT9d+lfhWSBUxK0y866cEgT59fOxFOF3Zd2x4zgCAQIkaxhK9eeO2v1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784142827; x=1784229227; bh=OEX8tfJNzLS0HYXUnrVliqoLgv6xlfebbJX
	EIaNKR4M=; b=bDLoqc7TXzZnRJ5UlGwawohyWsEvNsaVqwhcGty5TOTDC83Jxrb
	kSzMyS0NyR5u3Nn9WiH2yN338UOQzAV1yOCafSKsvgSwP+2PMVoVWq4t8aUGxSJ1
	CNhRmceN+DQljg8UFtwXpp4sq8vc79SqjiS2LWchcL9Quwx+eMnSSbcftjF+TsPR
	0woTt9KSqbhzkFtGyuWDFMIVPlkUeXLpsqNKPZ52uyTLY4Sedw0kXYvsML9D2QV8
	euWN6ueS3ePP8xD/6Oxp/aRhLV4m9FXIm2bvrwy3+wUzcYODxXVIp+QYTrIAWuTq
	jAoXZnn5XexBNMm/Yr4UDrWzodEiYZU2V6w==
X-ME-Sender: <xms:69tXavy1l9w4kx3d2NwKD__yss-MFrDFGkPW5V0Nilud9g9E19FZNA>
    <xme:69tXahQCUvti9xkv7eJjAQ9ZMak3TDDNIb17lCo4Zg3V5jH3Vbu-EgGWONeqEE-o2
    o5Tz040gsHZVMg0MQrsPm8efM_1zQ5PuB--QizmrUvL3Ebx4Ktc8Q>
X-ME-Received: <xmr:69tXav9odxqoXGedqKjLB5TqFe65m4gHjec0RAtn7oh1BwcgbEUcI0wOKhWsGxSxnlsJDQslPY_kEz-IlfCFPbkFBuTSBlAq9cAqFog>
X-ME-Proxy-Cause: dmFkZTEAt1gO4flOoZYJqvl+pW+PHmVpEkiORgMYXjGe7L7EYPRFxhz+JnmqpV6UMSrGe3
    4K/DpDQwHIm7PbT2NMyeE0BV8H3kdsBX2xoeqyxcpddXcb2REExtvQhDp/Ckv1ka9IaiQR
    A/S0Lw3sR3iD0af1r5g7DMIB4g4UFIzVxFRhC4qjw9zUBlFumwUlDdgLHbuU/G2tdC+LJJ
    cx4gK0kW3LhDoHgrRT92K3DEssFUbyHlRFCl3x4MojqkVtMrgND86J1+B5oiR85ht7toGG
    zxMCeJve/dOPmh3M3knuQANQrYly0koCfUHWD9KVh0vL2gBeuzR5IYaJTWR9/Lpcr90PDd
    yawJr+xkZln5YgJck5HzjwtbgmVpp6iAmJZs2yaNMwUrnXjS/vRsYRZXoaOTewXqC/w59d
    07WJDmYg4bo+VwtWgGovWNy3RIqMMkkbeYItJ0eDjOVhKPMOq5EwqVSsD1TZmzPRoWTlyw
    m9+gxktue0rZOv9dUVBLMOHnw6jJajJf3rkn4u90eC5GotSbv2b9KxHiyTq0yCQOchBrd3
    ESa7AKMRAN+zG8gZQzD0qz7TkLd0VQ3w+z0llOOMDQdPd6OoYaRQovwt3pMy3E0Q4uZKoZ
    eI3A12aFGPGUF7DB25ahfBFsKy2WfjC1dGt1Ipj9j4hIutmgUe4ZEWzv75Xg
X-ME-Proxy: <xmx:69tXanvM-FpJSDBlDZLV7Hn4j9XvEHc4g_j1ZB1rKJYkIfmkuQ4xBw>
    <xmx:69tXavPizPH12wQiFxtsIATjmP0dzbTZW7fb3EuAzELbx0U0yuVwMA>
    <xmx:69tXasjT2iyMZah3lTzyGyakI8fZIH7i0Etop1qpIoWWHmoKC0q_lw>
    <xmx:69tXah6x7-ZnQ36739bXQIxnR3RsqHG7fHZQxmcB9b85SK6hFZPzFQ>
    <xmx:69tXarSGpEA-9L54iffKdwPnbwiZPmZLGit4uMXgWUH4UhKFYHETujhF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 15:13:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: git@vger.kernel.org,
  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
  Glen Choo <glencbz@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 2/2] fetch: add fetch.submoduleErrors to make
 submodule fetch errors non-fatal
In-Reply-To: <20260715103518.526326-3-paulius.zaleckas@gmail.com> (Paulius
	Zaleckas's message of "Wed, 15 Jul 2026 13:35:16 +0300")
References: <20260714132959.3368867-1-paulius.zaleckas@gmail.com>
	<20260715103518.526326-1-paulius.zaleckas@gmail.com>
	<20260715103518.526326-3-paulius.zaleckas@gmail.com>
Date: Wed, 15 Jul 2026 12:13:45 -0700
Message-ID: <xmqq7bmwm5g6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paulius Zaleckas <paulius.zaleckas@gmail.com> writes:

> +/* really private - use accessors below to parse and format */
> +static const char *submodule_errors_names[] = {
> +	[SUBMODULE_ERRORS_FAIL] = "fail",
> +	[SUBMODULE_ERRORS_WARN] = "warn",
> +};
> +
> +static const char *submodule_errors_to_string(int mode)
> +{
> +	if (mode < 0 || (size_t)mode >= ARRAY_SIZE(submodule_errors_names))
> +		BUG("invalid submodule errors mode %d", mode);
> +	return submodule_errors_names[mode];
> +}
> +

I am ranting here, and it is not entirely your fault, but I
have to mention that this is the kind of bad code that
"-Wsign-compare" forces on us.  We know that 'mode' is a small
integer used to index into the submodule_errors_names[] array.
Theoretically, an array might contain as many elements as
(size_t)(-1), but we know nobody needs to feed us a number
that does not fit in a platform-natural "int".

	Side note: submodule_errors_names[] is a horrible name.
	It should be submodule_error_name[].  Look for "Array names"
	in the CodingGuidelines document.

Working around "-Wsign-compare" has forced an unnecessary cast on
us here.  If anything, we could have just done:

	static const char *submodule_errors_to_string(unsigned mode)

and

	if (ARRAY_SIZE(submodule_error_names) <= mode)
		BUG(...);

which would have been vastly more readable.  To me, a plain "int"
is also fine, but if we must squelch "-Wsign-compare", using
"unsigned" is much saner than turning everything into "size_t".

> +static int parse_submodule_errors(const char *name)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(submodule_errors_names); i++)
> +		if (!strcmp(submodule_errors_names[i], name))
> +			return i;
> +	return -1;
> +}

And there is no sensible way to justify "size_t i" here.  Using
a platform-natural "unsigned" would have been much easier to
understand.

It is a disease to bend our code only to appease the compiler's
warnings; we should resist such temptation.

Also worth reading:

https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/

Thanks.
