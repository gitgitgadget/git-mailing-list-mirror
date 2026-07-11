Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8847E38E8CD
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788166; cv=none; b=pF3Yt3b92ZA/lBaMfr32qByso34XsnDWsGBOZ+no2YcBmo1U17lBrf6mkqSvOZcexI9szNYkVZI4A79/GGtLZCkaP9/LgsUzsQzR+CBM+mdiLLC0JXCGiJ4YTaYmWFtvXfNyGoUL4//yZ+i4K0SrwEH9/embwLWlT+gQMVTNYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788166; c=relaxed/simple;
	bh=ykW15ldMfqVViEnW4CYSYTMlBvV3R5Q3qC7Om9oufFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C9nwMxXJH6HPKJ1sIF1HGfK6Zj0bvi4OhUFCwCTn9ZrjthW1KSjAwV8wXU5Fb/08bc8WNiqrWqJEaJFWc+iIsvQBsrTUa6pkJFb4QeBkIPEj/Lo12pULo+HxXyoDxq7KJOA4naT5pwMae+z/iK8mNCNSO64GCIiJohOPb/rdYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SdNBZkJ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dWRkRgyW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SdNBZkJ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dWRkRgyW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DF5814000E2;
	Sat, 11 Jul 2026 12:42:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 11 Jul 2026 12:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783788162; x=1783874562; bh=AtcTGIyI32
	FdfBpFS/mXJN3dhr7xPWcJsMzDDApTB6w=; b=SdNBZkJ+RQnEwD6aLXSOF3XRU0
	ZVqcAKjSW7uxMGrlEMV5jGkYCTg0s+X8GJEia+5GuLgZl1lGGfdw5rDBdedV5Br0
	jgqaNMuNvSAZQag+TV8FRMfT26XFYDC2gFO7CdbkpGCfgMzUP35udmgU2jRobTrv
	MyrT+G6IHLKyqhDisg6onP0iQPSCK85yZd7hhcGkFmXme3vY7qtQ/QlNmUfTegfd
	Ic+TIDgbERETjKZYSxPM8plkcA+xk21w/EtZ9DxL0PtEx+G57Rg5ATCit2LPvAQc
	M7wQgeebMxSRuXuGhfKOoMihQXH0N9+606rRDgkkgnYkZMROxUe1Z77KBWIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783788162; x=1783874562; bh=AtcTGIyI32FdfBpFS/mXJN3dhr7xPWcJsMz
	DDApTB6w=; b=dWRkRgyWJADaQsshDZmLhLgkFQDSXlnB+pLUhgtWL882uNw8piL
	A5dP/tfU+D66Htuit1eWt0RPD0chBlAWYNCAy+0SBDXYnGPDs4y3BqCPdq9WXnQW
	zNkFB3tBCcSB1djAsdRpj7SARoq3grG4xEDlAaHZyJh8VF7qicS8TJwlGGZ9Tvvi
	93ga/NP4wGAdv7v+yu9ktcI9MDzLlCiZq8TlZTXBwyVhtbhRlLBsRr8Y+gHr4JfN
	2eTpDzLpeDxPvbus+B1OZe44TlimS4RfjXL2tvRwjhg6HQscizo7KY8diFlg9dzR
	tVkOYAghGfeQlSfhEx7VPWSpRVVumv5ncPg==
X-ME-Sender: <xms:gnJSaqp0_k73_j-w3L4DKkpFkKAf7TbfPzcNoemV4emO2bxiZj57Lw>
    <xme:gnJSavhODVOHVjLRflGo1lYGO2APkp_kCnOO2Hr3aTRQrnfBJv2iTw3u7OCQAOcHp
    q5wr4kNum1puIixTx_3koMdTgGrG5nBG2_iGBx4I0Bry8Q5ZfcVcQ>
X-ME-Received: <xmr:gnJSangCUNHdjSl8m1KzGl6Ac3-w435T2fqcydf2zVdX9XssDcRYB40vEtiug08wLLjiDDVFErpJjGozS2xMTIhChcCKFb0t5RMmpLY>
X-ME-Proxy-Cause: dmFkZTES/s0BWdihE8sGd2d0rxn9PcDVl3qBVEb2eVVl0U9nVgNidVD67UpSI4y9ukZrQw
    ZgJJTfprtETimF8M0B03LE4ZsP4ju5PiR8yZfP/IadQQ42E8AZcC1cCc2Lgyrj8s0brAzu
    rE8kY0EFeDseg5J6bIVUOYvQ6OnEGNKe0iR5eaP/2uYlcICyo8aJwTZadw336aeMi1rYjF
    Imjvz7JLnf3KlCofn2krrI+MGz9QQ+JA3P6z1ZesXCJUkAXEyiL0XUoWDegZ0KSaVmFHgj
    MWL3JQL33tpuAllc2v5nANF4A8Gs2Ei5VlpiybCne5QUwauZ+zfao+FnRxKit+1rKTJGtD
    wH8vmjrLcPm5mR39hoesSbePBOV01P82ppESFJUzj9iJkR4vWPr7iwT9NSvBHHiy9VLW+c
    mbH0z8X5Fu6D9XHnIkOntxtCIb3D9PsPG29iB8Tc+2Z38UsxThFaX5zb576QV2y5/ImFPB
    Vxiabb2YMxFKpq8GIBXYuRWw3vOmkmZ09av8N1TtYt/psICphMAiK8v4Nlz0gNl61pkvwr
    meyPbdJk9PUL5xNqAyL7qLOCwGjE3PdVaDFYFiWDtmzDY6Jam9+Peha3+mdKFchuR5CrXc
    VAFDIQs6+Ncbg7ME3Q9T49JtCj2nTW6O28nRybUjF3scrZ7ARaeIovIrjBFw
X-ME-Proxy: <xmx:gnJSalgHit0VM0qhmgtn_HT0t8qJtu6UEVCkdPyVWv2NeJkmsHPbOg>
    <xmx:gnJSanLtk6CJ4_I-qoBdrvbueJY6tc9AhmM1g6-_5Ux_1Gej1p_evQ>
    <xmx:gnJSakHfZAtATXqXLYcWdhvCVUCcUJP6JQrg19KHz9BaLupaHvPoBg>
    <xmx:gnJSarS8rP5kMdyJc0vScc6ewJ5pZWYE5uwSpiFKpfXzHPiN9Rz07g>
    <xmx:gnJSamAyanRptr8SEsJy0l3O0INXLFklw5IYOuSaVDobCZId-qEgxlIL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 12:42:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v2 9/8?] pack-objects: drop unused return value from
 add_object_entry()
In-Reply-To: <20260711075811.GC1457061@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 11 Jul 2026 03:58:11 -0400")
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
	<20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
	<20260711075811.GC1457061@coredump.intra.peff.net>
Date: Sat, 11 Jul 2026 09:42:40 -0700
Message-ID: <xmqq8q7hbhq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Jul 10, 2026 at 10:48:52AM +0200, Patrick Steinhardt wrote:
>
>> The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
>> 2026-07-06) with ps/odb-drop-whence at 8a7ad23e11 (odb: document object
>> info fields, 2026-07-02) merged into it.
>
> Here's a patch doing the cleanup I proposed upthread.
>
> -- >8 --
> Subject: pack-objects: drop unused return value from add_object_entry()
>
> This function returns 0/1 to its caller to tell them whether we actually
> added a new entry (or if we considered it redundant). But nobody has
> relied on that behavior since 5379a5c5ee (Thin pack generation:
> optimization., 2006-04-05).
>
> The extra return does not hurt much, but it recently became a bit more
> confusing. We have a sister function, add_object_entry_from_bitmap(),
> which had the same return value semantics. That function recently
> changed to always return 0 (not void, because it must conform to a
> callback function interface). So now we have two related functions which
> both return an "int" but with different semantics.
>
> Let's drop the unused "int" return from add_object_entry() entirely,
> which makes it more clear that the two functions have diverged.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I couldn't reference the commit by its id, since Junio has not yet
> picked up the v2 sent a few hours ago. ;)

Heh, if you do intend to make this a part of the series as 9/8, you
can just say "earlier in the series" with its title, and that should
be sufficient to identify which patch, as I never make a
fast-forward merge when merging topics into integration branches
(which means that Michael's "git when-merged" works well).

And if we ever see v3 of this series, you and Patrick can work
together to see if it makes sense to squash it in, or move it
earlier in a series to as preliminary clean-up, etc.

Thanks.  I agree with the reasoning upthread that led to this
change.

