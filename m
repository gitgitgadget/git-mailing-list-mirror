Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6D48C8C1
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159903; cv=none; b=TJ0AzPP5yCwkiw6SrOy+ITXnAhWSEK4Um+rHOqiYpk6Y0s8ec7A05QUmqxCwarXIh/MCzZ4SLl0y/WWghpJGpqzEmxy0rsNsK4OcfbaGVnVTp35FacMRiXOwVkrU2KiMX2ug110buGduRlUD2FBPnltKJUHT4PoDaNm6WvUDRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159903; c=relaxed/simple;
	bh=+bSbdvaD5IQVHMs/mQZ1rZ9MGnONoSf/h0W+kHFMUbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fv8HL1VkLRbHL6WDsQ84Ic+21Z1KNwyCaxZM9iHwsubfQeG95cwCLvuao96MW5d5kv00NNUTIqmIXK/QZ2ZJUMYO4snvIENZ+xbj8SEYrKGOQSSAGbG9eBzch68zGtplQUJYPJD208iGrJkTF4kBRs2JfMetqLlTmfdGMPJ2q/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pbzn1d91; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YFn8KnXC; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pbzn1d91";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YFn8KnXC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B2E461D00136;
	Wed, 19 Aug 2026 13:18:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 19 Aug 2026 13:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787159881; x=1787246281; bh=5d9GMSKaI3
	amcqeEfCXd20ynPYCPlFPuVdt0Yl2LwzE=; b=Pbzn1d91SetypJZGv4hEtiZqJD
	uUj4wy4RJmRMv31TgyAvuCTA8xjOOSbUiOscJmoRgRUaLElT361uxZOhXJ0v0Uu9
	4nMRDArod3LRQlgIFbeplVb+Izam5Qi/qqu77d7KJuIc0AvsOmiW9x7ilgdj+bbT
	8SM0N1pJnKmlBvct/zmjVf1b5cTbGq5DBWngze5W2m23iCGhGmuhQkfE75lyPplO
	h5qCWe0XKPSVVM9BtAwvmYubzqU97TyZ0sPDUDfr5MnRMnML73XGnUcbSrAH19cg
	w3H0mMpj1P1U+RpPjuBRuzkuEPOM+QcwToaig8HpMwcsqswyi49tPzn2Ddow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787159881; x=1787246281; bh=5d9GMSKaI3amcqeEfCXd20ynPYCPlFPuVdt
	0Yl2LwzE=; b=YFn8KnXCbGw3ZOd8rOJNeK7SQMBA2ydo0dm4rxP6HTkVkfOLgID
	kjFBS7yUlVJridniFesxFBgjJ0/NuWftxfEIPOM2Q0KgzfPEZhH8ltY8jIdO3Fzn
	hvC0cHYZHsOMbB6+GDR/jyE3Bpk2ZN2H/2CAyOXSaVy5SuMdNS424+ClJwp1m4nE
	pGcgdbXYp6vqAhWmpM+oHzDVVIuf61NLVdvz/jTHEiH1YiUOAHfz6QO3SS8+rJhf
	4bh3bX+AkkSENWSb6WZn0F6tJQnou5mO8eIskhXdkdmYUnayTCx3cJtIWXSlYPqq
	55s8fZ6hx3h07+Jsr5akxEWot1gTw0w/UFA==
X-ME-Sender: <xms:SeWFaoD8_BSdNxICzyuAFj-ocC_f6p6Jbi2EE_JTc-IZOAa09zTHmw>
    <xme:SeWFah96ZLKy10vukOVYX2zEZaJ9pyHU5J86FB9RBqITSK8DCheRM7o6crd1CZgAs
    r4JiBqLFo3IBLUJAvalXRubw6MxaBlRjpYFzGRxkylptReYQDHW-g>
X-ME-Received: <xmr:SeWFao_hkeU6Kgab4xIElL3Xu6foxubmGnAqbweltiIbiIDJtqJ2WEd-6eF3kFGFevdJMYqbOxPVPN3boBPNnm94NTeHIk5dlw>
X-ME-Proxy-Cause: dmFkZTE7ajTD/KYZqLLHRSH41V9fmr3Jv+Xo8f8vHgdKzhL+193JvTR7JejC96IByWIDOu
    Jinsx4Eikye5jnQRf4gB+RoKLQyRnMYDc/rLzUlfd23Qt7Mv6tcAhQ2xzE0IhXp7SE6mYD
    UQ1Pl3FSFrw6HmYlsm6sVK0np5/HjPnhTy21t9mdDsNcwbIqpP37/rEkHIWkI8kIRQssMt
    PipWOMI1o4a2jsY3OUmv9Z90CIAbIXQ5Ox+PzeGNr1NuU54GaooLelW2rZLK6gBKFpdpOO
    UYMjnmJZBNyA2JbTMpjkyfsWg8RvpS72tJv0yuXjXAZ4PCrjqFV14tn4SXYOI9iwtPCEtU
    Z8yZnKjyM0q2iG60wqNPzYRYfeIDkap8uLpfe0lgQQtdxpC+9qtshsYuY7bhuArApD6pi5
    gyVT25fe+fkwdMYTF2H6yh/dMFbAJf4zeJotc2PJoc8GgYFUlaHstWSTGik4udM4ry0AEt
    CCxV8eEXSHFeLXREpR9YfFlb9IppZ48GxIfJ5DhwA407OjqyKhOimP7r/lILu1pcsGjx3g
    hk7aa85mRMTisGROtgK3aQ7k92C1NHbAmfnSXij9TQngC01wM5C1199xB42HX6tclanyVh
    TSo3r0f4XnLQ99SntycjfmZUWPHb3GG+7SQkOYrWWpg16kNpYwp9b8WMclxA
X-ME-Proxy: <xmx:SeWFaocHYqrtrVWM2RT9LYXblDvY4R8bucfZqeQ0EQGelnJ1_CsFbQ>
    <xmx:SeWFahH6VQv2qjCULIT3xkhNLex2q9JJIUOh-boeEi3ypQKm9_-mAg>
    <xmx:SeWFamdAhGItD5-9qywMkxl7ROGJCJUAjkIUQp_cZJtzM5k4yNHncQ>
    <xmx:SeWFarH_8uItya3uBkk9wX7CS3yZ671TgEFnCekXc3oKRsZalCRnBg>
    <xmx:SeWFah9hpRWzsFD0Qh4uKqUcljzIVs_ogaD2mf_FNprVFQJDhZZLenhm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 13:18:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] reftable/stack: move list lock to `struct
 reftable_stack`
In-Reply-To: <20260819-740-optimize-reloading-the-reftable-stack-v1-2-6bf5305d4e43@gmail.com>
	(Karthik Nayak's message of "Wed, 19 Aug 2026 15:19:38 +0200")
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
	<20260819-740-optimize-reloading-the-reftable-stack-v1-2-6bf5305d4e43@gmail.com>
Date: Wed, 19 Aug 2026 10:17:59 -0700
Message-ID: <xmqq33wavxko.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The struct `reftable_addition` is used to modify a given stack, as such,
> it also includes a `struct reftable_flock` used to obtain the lock to
> the list file. While the scope of the field lies within this struct, it
> doesn't allow for optimizations to be made on `struct reftable_stack`
> itself.
>
> Move the field to `struct reftable_stack`, allowing us to make a simple
> optimization around avoiding a stack reload when we have already
> obtained a lock. While this is currently possible in the write path, the
> write path also contains multiple branches to reads which only work
> on top of `struct reftable_stack`, and we would miss the optimization in
> such paths.

As long as nobody tries to open a nested or concurrent addition on
the same 'struct reftable_stack', this should be safe, but do we
give enough tools to help the API users avoid doing so?

I may be misreading the code completely, but when a caller already
holds a lock after calling reftable_stack_init_addition() on an
instance of reftable_stack, and then adds another reftable_addition
on the same reftable_stack, flock_acquire(add->stack->list_lock)
would fail because the lock is per stack now, unlike the original
code where the lock was per reftable_addition.  We jump to the
done: label and call reftable_addition_close(), which would release
the lock, which is now shared with other reftable_addition
instances that work on the same stack, which in turn would get the
holders of the lock into trouble, no?


