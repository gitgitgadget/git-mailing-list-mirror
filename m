Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCCD3385BE
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964023; cv=none; b=fOXNcc2kuF4oCjk+eW2gN3v0RiNsYcA7LQdTigi4X1J4HCi/6VQpZB4rlUkFRCWBEkAh16PqKyEOGr7TsRzqWKvNpvzt68firItwrCylZq51lRy9pecS8AwdcgwWIbb6EyHpuLOr+rPjo63lWHeFQVcD5NoF71if9zkbhR5wdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964023; c=relaxed/simple;
	bh=Vva0wx2zTyBn/QJbh8R2qLVxKt79+ItY3/JB7bam3BU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AJIPQJg/diPiO4AhJKlysQx8xrLlzWY6LogLlnbQC8ocD4WNe4QEjhHPsh60bx48WP9mwAZL2zTU0lMK3CVUu5Se+ApeviuD/EeI7yKe/d4wGDbOOW7dZDGJePqo1SmxLJeeLXS2NnuQHykLKXKzawhJ85mnQwBviGPVeD0FxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PGKSSCe7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BiSHnHdm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PGKSSCe7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BiSHnHdm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 222621D000B0;
	Wed, 12 Nov 2025 11:13:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 12 Nov 2025 11:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762964019; x=1763050419; bh=ncPfq7BXyv
	QJSEJIkAat/eA3YKlJaJ2+nqK7nuTHhNA=; b=PGKSSCe7UANfSb6jg8Wa4eP+71
	7oRVGjbWqrVIHpnoYnsxJNiIASm7kuFQIVEbFn2xY6ndV7yyLsEXFZVtkh6JZseM
	V6tvKz3yOhzgwJOufNYTLCb18wpEafYbWuvDdMKrRGvz4nf/cKhJOIoFyukW+1at
	YY9aeMSIHVp72W50QIRUHv9eJc7jxSQUxcKSu4kkiHG2IhRPZF4A0KFag7MrGFLp
	xVrAKv7bqd6l7jN6pxXDXHdarCsMbGQjQNjnV+V99KDzb/qYokPoYSoQT4lBic4D
	wsM4On4sxx7pCxgf7DQXUpnuYtUHWpjfJYpgSP7taOSHQfma8kcmHLopPxXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762964019; x=1763050419; bh=ncPfq7BXyvQJSEJIkAat/eA3YKlJaJ2+nqK
	7nuTHhNA=; b=BiSHnHdmXiIeibQ2MHm44v5ky4w8ZZGpQ3fCWlqYeqVSWM8R4ng
	KJtuy9vs3s3c6CxolXYO+eMaij/KZqG3WIczQDQ2hTcmZk3eSpBmfz+vcDCy43t6
	hwJs81rqURhmPr0L+Zlj7Aw/tAVB2bZhDoa2Quz0pBgiB69Irn1VoJWALwOXpvSH
	R33mF7VmX3zXFNhBhggfqArqS4bikpLcSiEm9+168QHfB8OBGgOjE7YPkjhRJzeg
	qOPK9JOfAjghu8uVSPVIcocjL0Lq5UmVDit8ZzEhAXBB6erhU6c2gzJepqAh7PbF
	Ts9DKI1aoabVXCZKL/7WzkUIaoZFw0kaF1w==
X-ME-Sender: <xms:M7IUaeXxagRGvZL4W9bjUtTZRIk2Ttp4kTNiWyMBy-A7tj80nMy62g>
    <xme:M7IUaRl9J-8EzB4VxLEVPwZTtYmm83wmoPuZTIZ2as0G5ICsowZcGUzsLyytkacpV
    JP14GE94I7vh4-LYfLOTV9479yC_9skp4Qf4Gw6zwmRckJfdatF1w>
X-ME-Received: <xmr:M7IUaXbHKr09cN0PgSJGKjBmq5mJmiXu-XbjHrhZjHehdvlecTl8eEq18D-cacVKC08ku0hQnp453krSczXBC_LwRlI0ySwxxCMm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeghedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:M7IUaUP_UggpuMawlgY0il4s3eyCxIlT-YcV-8Rd69b28Qek6bgHTA>
    <xmx:M7IUaUYXsjWD4WdJgExDuEfBWwstvpXnQViMXc_eaxrB8R5Z4vodRA>
    <xmx:M7IUaa0a21SXGyN8y0HHVEHsiLRhX5W9D1rIN7Fn9RZohKQhm16N6A>
    <xmx:M7IUaSfdqCBWxCZ7zu6xmvCGBsDtBmnupuFExfzo6Sa4Pyv5XMBi_Q>
    <xmx:M7IUac8GcLUZGauuGQ68Gg-3TXeh6QaeePmZJWLoEJn99wQVS2VaR_Cy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 11:13:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Nov 2025, #03; Fri, 7)
In-Reply-To: <87jyzvwgs0.fsf@iotcl.com> (Toon Claes's message of "Wed, 12 Nov
	2025 13:56:47 +0100")
References: <xmqq8qghfz8x.fsf@gitster.g> <87jyzvwgs0.fsf@iotcl.com>
Date: Wed, 12 Nov 2025 08:13:37 -0800
Message-ID: <xmqqecq3tej2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * tc/last-modified-active-paths-optimization (2025-10-23) 1 commit
>>   (merged to 'next' on 2025-11-03 at 9ab444edfb)
>>  + last-modified: implement faster algorithm
>>
>>  "git last-modified" was optimized by narrowing the set of paths to
>>  follow as it dug deeper in the history.
>>
>>  Will cook in 'next'.
>>  source: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
>
> Do you plan to include these changes in the upcoming v2.52 release? I
> would like to argue to include them.

I plan to exclude, especially if it was not merged to 'next' before
2025-10-30, which is one calendar week before -rc1, to give the
topic the usual cooking period.

> Maybe it wasn't very clear how I phrased it in the v4 cover letter[1],
> but without this patch, some results are wrong:

Indeed it was unclear.  With respect to the output, the only thing I
recalled was (I just went back to the thread)

    One thing to note though, the results might be outputted in a different
    order than before. This is not considerd to be an issue because nowhere
    is documented the order is guaranteed.

and the patch came with a single test that gives a much later than
before in check_last_modified output, which does not clearly
demonstrate how the old results were wrong and the new results
correct them.

>> As an added benefit, results are more consistent now. For example
>> implementation in 'master' gives:
>> 
>>     $ git log --max-count=1 --format=%H -- pkt-line.h
>>     15df15fe07ef66b51302bb77e393f3c5502629de
>> 
>>     $ git last-modified -- pkt-line.h
>>     15df15fe07ef66b51302bb77e393f3c5502629de	pkt-line.h
>> 
>>     $ git last-modified | grep pkt-line.h
>>     5b49c1af03e600c286f63d9d9c9fb01403230b9f	pkt-line.h
>> 
>> With the changes in this patch the results of git-last-modified(1)
>> always match those of `git log --max-count=1`.
>
> So this patch speeds up git-last-modified(1), but it also fixes some
> buggy results. That's why I consider this a bug fix and worthy to make
> it into the upcoming release. (which is by the way also the first
> release that includes this subcommand)
>
> [1]: https://lore.kernel.org/git/20251103154726.26592-1-toon@iotcl.com/
