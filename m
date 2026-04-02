Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6F36B061
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 05:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106711; cv=none; b=JG0kGnQAzCBzndOxpMT3ttQfSEXDDjhiHS+ZU4UZLukuMXojOiaKh0gPuhiNN4ss5TkyGPWdnxge0ud2UnYbHf+JQg/0UWLwkCDgwWYZHXyZKTwSvV9L45DSooNMyn1znI7zOyVowdMyJkQmd8owNrRpD55IrGJ0pzc3BhGUnGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106711; c=relaxed/simple;
	bh=3knY8tZMccQuU2n77vIcdew4oJfIZejd7raU0R1qYZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=No6O0bEPBRgHZtJnsVQ60M5cI1EmUtV+EP/VbL80nZzXiS0uR74dnbG4dBitBBG7tDkmgBhwcniZh97YTBRUFKIVJydddI6T6WVcZXEGliYeORFb7A2H4aUXOcJ+EnKt24CS+3JRlJhJVxKxnJYGRTrjXAEmq3wQ8JdjjVepg/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dq5U/+Mv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vsh7Rit9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dq5U/+Mv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vsh7Rit9"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 446B7EC01A2;
	Thu,  2 Apr 2026 01:11:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 02 Apr 2026 01:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775106708; x=1775193108; bh=0NvbC9TeMb
	FDKOgUwn3SzTJVF6MhClKMIL8lmUa7woI=; b=dq5U/+Mv9RQxfEbvWMMwI8v+Ex
	GwzuCXIavzJL0TzOBfLkYG1oZ005K2gGXvY62CquDMkLKcLbtRGKdTA/YerGZ2w3
	pLRWz6nJo9f3czOfQ48yk8DBbywY+Lac8R4QUEfBEPMe1feY2rWpqngGKPjW1iWL
	AJrrWjkKsiIkOO0edcAcaezwVPztw1c8Q+nYch13VGyc6F0Xxa7VKX+QRZ+mWLVF
	/pox4LU1Agt7bUkVifTYZ2BX11Y2hoTFgYnne+ObTESOjnA1e7zASrCnN7As0QzX
	2EaylJ6NqgdFLH0aqm65zY+N4F1FH37piUpMQ5F4XML0l7IsKd1BezOsf5mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775106708; x=1775193108; bh=0NvbC9TeMbFDKOgUwn3SzTJVF6MhClKMIL8
	lmUa7woI=; b=Vsh7Rit9mAqReLLRvjVN0VtopUvTzXlywnUww9qVH/MZ+M8lCSU
	yyK2qeLW+3f5QfHQCifnVPZPt4EyWCDJjs5pWu9gQM2Lu1GmV3MGmFLTsC13bGoG
	aR6rOslrnAOXrEnWoNCqTkHQEVza2xg5MR7AZAulEie8QgvU6lTzK2l+dCrLZWio
	xlgqoTsnTw5Z80VKZVmlzg4Rkho6fO039NWnPtSh14wqkTnkeLTUKPUuee7vttyA
	wB3K2nhQRXs9WXoHEN32ZaZ2lKfiqb2ObUx35/vJmxn2sHWs0ZR1oAwBlZnwcnM9
	GOuQdSjUFfD/XJxNENwJDd+6nrFEWBWsong==
X-ME-Sender: <xms:k_rNae-paJ7XlgGYntal7to8EK0sySXTGYX61RG9Ag1qRv5Rrm-S-w>
    <xme:k_rNaSZWAl07XNUE1TqERN7LIaVzDfck0KOu6bK_Sn8BqO5wetAn447FHZ8EoDke2
    fdQcoRtvpJmZbDumywBR1eAWr0OC-dVDK_SXGqiX9YrfdgI73Z90g>
X-ME-Received: <xmr:k_rNad0sMFv-HMuf4l4yAyjgFLWXTK-xNaiF5295AzgNFuL-PiqkqrsgqUAvayRLcdebjlN4BeWr_hUttwT_DGrEyqJLAsIXiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehgrhhusghigidrvghupdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:k_rNadYXewEhFctlwGHI8FrWzW_cyrijoz1R0JgGhqyxY_0DTtU3nw>
    <xmx:k_rNaVI5kSwg_cKAFyRiQ3GLYYU-iRvTXny6OLQ2juM8iakFngrxwQ>
    <xmx:k_rNacEyHfalzPWt9TGKpuP5h-ZLMlcKuW1OcygW_7JPdNBMPTbbZA>
    <xmx:k_rNact4_DsU8QBOEgY_lXKcS_OYa-5iQRJEW4s27xWFkMwp3ATfLw>
    <xmx:lPrNaUb_ZCqZbrBLKcwpJizvgnovx3JBJ81j6FLaHvjkKIqnufpUN7eJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 01:11:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Collin Funk
 <collin.funk1@gmail.com>,  Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v2 08/12] skip_prefix(): check const match between in
 and out params
In-Reply-To: <20260402041507.GH3501239@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 2 Apr 2026 00:15:07 -0400")
References: <20260402041433.GA3501120@coredump.intra.peff.net>
	<20260402041507.GH3501239@coredump.intra.peff.net>
Date: Wed, 01 Apr 2026 22:11:45 -0700
Message-ID: <xmqqeckyt08e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> +/*
> + * Check that an out-parameter that is "at least as const as" a matching
> + * in-parameter. For example, skip_prefix() will return "out" that is a subset
> + * of "str". So:

Sorry for not mentioning earlier, but I couldn't quite parse the
above with "that" immediately after "out-parameter".  I am guessing
that you wanted to say an equivalent of

    Check that an out-parameter "out" is at least as const as a
    matching in-parameter "in".

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
> +
>  /*
>   * If the string "str" begins with the string found in "prefix", return true.
>   * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
> @@ -479,8 +494,10 @@ void set_die_is_recursing_routine(int (*routine)(void));
>   *   [skip prefix if present, otherwise use whole string]
>   *   skip_prefix(name, "refs/heads/", &name);
>   */
> -static inline bool skip_prefix(const char *str, const char *prefix,
> -			       const char **out)
> +#define skip_prefix(str, prefix, out) \
> +	skip_prefix_impl((str), (prefix), CONST_OUTPARAM((str), (out)))
> +static inline bool skip_prefix_impl(const char *str, const char *prefix,
> +				    const char **out)
>  {
>  	do {
>  		if (!*prefix) {
