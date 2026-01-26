Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED02BD02A
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446712; cv=none; b=rgg64OiAq59c49J4zBo5PIPLqp77aexkoJelbIqWFl8lc/A7cGXyuK2WOlz8MWRYncWwvirbYjiUkxTr5XOuRtdiLP76d6uKJV0uwlYkDwgk4mHZToeBEiTVyndeQq/niiDYXtlB/3JzPiUOIWy50qm9jgzdfP8vbHb1dPnlHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446712; c=relaxed/simple;
	bh=zej3n2Jq98Hlj8Uq7OrnynhMadVyPNyhYUYSxOLAkF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZfEVqnT4jKlx/sT7bhJsDNyeiHUC61ctylGlf5j8pd4NVTaSp+H2VFNW8IZXdVxbeEO5wQMKOgJserRVAK2XqWxZUqFWHWsgVff8i6DvdIWzNi13k0fwfRka1IrL7nRaFwgfo7ABtgrPWydK1zfowo8DM5zuyKkC0p+fGWK+uE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oy51sHBb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sAkcgV+J; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oy51sHBb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sAkcgV+J"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 671057A012B;
	Mon, 26 Jan 2026 11:58:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 26 Jan 2026 11:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769446710; x=1769533110; bh=OOE2gV3Xku
	HtfLJpccCAsxlTCye3ZVI7a5ZPgGBYxPI=; b=Oy51sHBbYA05f6XUQRuT6yhUoh
	NK0fQTTxx1YgNCkEWzxRk7lYTSl/c7t3ApqeIIm5hLhI33A+K2OIo2LJmA8EzAsA
	ck0SgNBPMCGktkAsO9q5vWbW1QCayEv8S+2gKj2dJourMTEnT48U8PSxja53lVpK
	VsdGG7qE6bimmq3yWUMphsZGTl3RGGh3Og/2WDW1hDC5m+21yE87vKd/Kwi4vrQE
	dXVt8IDao8KXaNSdJBXd4dWK5rAuJGeNphf+mHMJljP1tnlKBJskqYxJRC52DaMp
	IEHosXLFBUt7viu3X2R5Wzc1TtmDFArknXS2pcuEs4K6lDMnZ951vtXOpIug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769446710; x=1769533110; bh=OOE2gV3XkuHtfLJpccCAsxlTCye3ZVI7a5Z
	PgGBYxPI=; b=sAkcgV+JssuJAPKU2q5fn9gHw7wIcAmWV4LvLTCb9xvBKBXyb+c
	7ZLthutf6fF0wPjmhvhfw9OtSzVWUvcDQfScYfFeKcDl8R55xH71F3BzS6bgC5Zp
	Vnl8wNQKxyD5Reifo9ZDIZwJTQXrJMIZVpva6DCVP+ojAmqYoQJaOTWPJ0/axkZe
	AzBRog5PrERxdijnXBwRpoYGQ1Bxv0ldHZOjpCfntm5YcrU8+bKXE9P9iZetoGFJ
	PxiFrIPGQOMuWsBSBlkLGqellmkwtElCGFm2AIbDYn36EOf5981W7B95qjJGeo9T
	KKYOlmQ/GYrSoQyrtHnXM+pI+4617HciSWA==
X-ME-Sender: <xms:Np13aRzHyhphmu6t8X-VyLx7UlaNM5cppRwFt1osc75VHThkQfOjvA>
    <xme:Np13aYvm2x7NI-9R_P_AvOrg1ACfIuatxjHwmwKDpY1N7GDrJcZVN0glESvhETGSp
    yLyPOyFyuB6TVhEMzXESKLDC8s2eADzn78lB-AjNoszUKQWmEHR7A>
X-ME-Received: <xmr:Np13aYsTZPuIs0qC3G8FpUhSZ_cs7LwxZfnVWqo4qsVdtZgBwYDvtjCrExMnd4AT5RNGN9pjihsMtj2Ad82gbGoSJOGFqu7r3In5XXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:Np13adO3GWqwuC-XcWGTFAmvWZhIWHC6vI8HK4EGuGrqV3flaAtY3A>
    <xmx:Np13aW1SACM4O9SRpfAfry15DGoDrHjokcpdTvE04KqO2TaUVnML3Q>
    <xmx:Np13aZOHPr72VZYOJhatbpGXQ7Nyww7UskPxyZ2sQfgjglXUlKbiDw>
    <xmx:Np13aW3VxBE26P_d_N7cTUmz08mB53LJHWvmky3mKYKWkrVGgPLv4g>
    <xmx:Np13aQ12vHvzsNLpsGjkJhwsKAPQHhDtzMmVCHce9HzxVdlLU31K3LS9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 11:58:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] odb: drop gaps in object info flag values
In-Reply-To: <20260126-b4-pks-read-object-info-flags-v1-3-e682a003b17c@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Jan 2026 13:17:43 +0100")
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
	<20260126-b4-pks-read-object-info-flags-v1-3-e682a003b17c@pks.im>
Date: Mon, 26 Jan 2026 08:58:28 -0800
Message-ID: <xmqqa4y0jop7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +enum object_info_flags {
> +	/* Invoke lookup_replace_object() on the given hash. */
> +	OBJECT_INFO_LOOKUP_REPLACE = (1 << 0),
> +
> +	/* Do not reprepare object sources when the first lookup has failed. */
> +	OBJECT_INFO_QUICK = (1 << 1),
> +
> +	/*
> +	 * Do not attempt to fetch the object if missing (even if fetch_is_missing is
> +	 * nonzero).
> +	 */
> +	OBJECT_INFO_SKIP_FETCH_OBJECT = (1 << 2),
> +
> +	/* Die if object corruption (not just an object being missing) was detected. */
> +	OBJECT_INFO_DIE_IF_CORRUPT = (1 << 3),
>  
> -/* Die if object corruption (not just an object being missing) was detected. */
> -#define OBJECT_INFO_DIE_IF_CORRUPT 32
> +	/*
> +	 * This is meant for bulk prefetching of missing blobs in a partial
> +	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
> +	 */
> +	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
> +};
>  
>  /*
>   * Read object info from the object database and populate the `object_info`

I wonder if this series can be restructured a bit to demonstrate the
benefit of moving to enum a bit more prominently.  For example, even
at the end of the three patches, odb_read_object_info_extended()
still takes an "unsigned flags" parameter, but it is meant to take
this new enum, isn't it?  If we do the "#define to enum" conversion
(without renumbering) first, then "unsigned to enum", would it, with
appropriate compiler warning flags, already reveal the existing bugs
that happened to be working OK as potential problems?  And with that,
fixes in 1/3 and 2/3 would demonstrate why #define to enum" is worth
doing very well.  And after all that, we can renumber the enums in a
separate and final step.

Exactly the same comment applies to odb_has_object() that still
takes "unsigned flags", even though HAS_OBJECT_* constants have
already gone through the "#define to enum" conversion with an earier
f8fc4cac (object-store: allow fetching objects via `has_object()`,
2025-04-29).

In any case, well spotted and nicely done.
Thanks.
