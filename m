Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190653382DC
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477663; cv=none; b=beog3O9kpNrNzX9rOUfz0okhffgLvaCBveJZXFp0ZDYO/Lbg7N6rgicrdyn00pL/GyfAzEhUenI4v+/GzDvLJuQEb1BNROp4sSFjU2IqvgEskFcPPIEkSGqfnF9lF59JczhIWTyAh3eGI4k5micNdR/0sX9VyqgoIMFamVcH4SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477663; c=relaxed/simple;
	bh=T6LrIb0+mTO+Shhw/GoaGDXKojikHW06QPSyiwdbY+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OvYXx5wWBXnnlFEwhyKCtTCTVpyDxx4otMYVGXtCEax340KAlJBLJ9NYXgT9r/CQPdY5FZh6yp37jM4thLt5XdOt0iJsOfDpWv4T2fhvXEtR6LFpS8hW+wfnGflztPSOdXRyr0JWj9rM6YWAqXKbkxhhtgqnsKDiQxTLYUWUOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZctzMyEN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bcuu2QHp; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZctzMyEN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bcuu2QHp"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6030CEC054F;
	Mon,  2 Mar 2026 13:54:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 02 Mar 2026 13:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772477661; x=1772564061; bh=jyZtim6hkC
	eDI3cz8yl9UA9ESlo2jR7MoasQfxcX3yk=; b=ZctzMyENncv7mEk5hLubsI52BV
	gC4RyC4BISWIv4aMe3PUdLo54NhmqlHvlkrtgOA4LaXXUjoN+hQTyz/te8tq7H/f
	y0bxur74J46mG/VE3CO3/3yEOOViowaVYi/pX8rdR/cbTi/DfhVaaZAupaBZUwHr
	1Q1XtoSd4Me8Iw6K/4Bn8pXFHtvd6XLJiVJsP/54os5AQAHR9P8jJ5JW+e+2Yvh+
	bbGRuMSb0HbtJwIDG5gkdS5xVcAV4rAa5TNGm8oInBZqwY0cTXFDdVdkw41rJJHo
	DuoSQyN4lwbaeO45xHjzFaUIHzLwPLqgoJ7GfcGoaJ0SwPouHo19JVZeftZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772477661; x=1772564061; bh=jyZtim6hkCeDI3cz8yl9UA9ESlo2jR7Moas
	QfxcX3yk=; b=bcuu2QHpVS4pNNQZ01VcY04Y5W3I6JAQLYlKnz8Q1/zJ2ihmXD8
	HlaHdzSYU0TenCkUjoXBG1eG7/i4SkNYgebR4IeYv6OjPjLvYd2ZMK1X+cVunFdq
	xHfGNfeLX5Oam3kQnIZM1w7TYvizr6wQCaMdG5RYyBZXACqRKRMpmcHglCd8LY9W
	6WpRC7vGQhkL5OUKr9FS8hLwEwLgK74aSijerVV7bnHYgeWHpG1VBQLk2YE2Etvu
	emc13NLlyVYu7LD99UN3mRuXomm5bkkOG4V7YdVwSlcQFzjSXFKTB+zthbnPPfED
	b7XDOLoqsU6+IxBPVjgZxm4uoJhn5sxOpSw==
X-ME-Sender: <xms:3dylaSbDLe_sBzYZrMuplpmq5M1ovt1ycGM1QrOFmV5TMl4zhDdWag>
    <xme:3dylacQhBeqM-yR95Do0JciGf2oFpUdpTSgJLXTiClvZaxUzSQrkNOb0FjGC27upM
    q7yvvN9Ha2vTXLJCBo1rZZ6XiJh8MM2jTRkHwvp1pGNbE0XZjtd>
X-ME-Received: <xmr:3dylaVQLSPyTv_2Ftr6qr4VJ5yeLrzRVYlv3TRJYbR8X8DIIj9GkwVHAgSRp1YB64UNzL3ymqgpzriL5pESD7dTe4g6rRXcILg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3dylaQR16_OdtQ0_x2tvJtoV3oX3TVeSLdcsU7EQshcGbdalxvZ1sQ>
    <xmx:3dylaa4nKPMr-Vmw-zIILqYjVH4fik4Qbt5w92RVsFckuVKylUv34A>
    <xmx:3dylac2SIxh_Ev4zXdZL3Gjh7FmsFCAGWWqqr_yGfDQ2nsUhpHftrg>
    <xmx:3dylaVD3Pq4JYtrh0AgCq9-bthLYnr5jnz6KgKDfLFa0E9WKVato5A>
    <xmx:3dylacHM3n6Zco_JUOsIgwSaUDQ1Vqg8_Rpd9SzSuCF6iPEHhjjvpmsw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:54:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Jeff King <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: Performance regression in "update" hooks
In-Reply-To: <87wlzu5cug.fsf@collabora.com> (Adrian Ratiu's message of "Mon,
	02 Mar 2026 20:02:31 +0200")
References: <aaU5lZwEuR4OrxCl@pks.im>
	<87bjh673o0.fsf@gentoo.mail-host-address-is-not-set>
	<874imy7220.fsf@collabora.com> <aaWeSu-d1FMz_sW8@pks.im>
	<20260302175052.GA28275@coredump.intra.peff.net>
	<87wlzu5cug.fsf@collabora.com>
Date: Mon, 02 Mar 2026 10:54:19 -0800
Message-ID: <xmqq7bru12qs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> On Mon, 02 Mar 2026, Jeff King <peff@peff.net> wrote:
>> On Mon, Mar 02, 2026 at 03:27:22PM +0100, Patrick Steinhardt wrote:
>>
>>> > > I don't have the benchmark setup and it might be easier for you to
>>> > > confirm?
>>> 
>>> All you need is a normal development infra and hyperfine. The
>>> benchmarking scripts in the repo I linked should then "just work" with
>>> the above invocation.
>>
>> Thanks, these were very cool and easy to use.
>>
>> Looking at the patch, my guess was that the problem is that we are now
>> setting up and tearing down the sideband muxer for each hook invocation.
>> This is expensive for the "update" hook, since it fires once per ref.
>
> I independently root caused it and came up with (mostly) the same fix,
> so this is a very good confirmation, thanks!
>
> Please wait for my patch because it needs fixing it 3 places, for 3
> hooks which spin up/down no-op async threads. :)

Thanks for working on the problem report and coming to a fix so
quickly.

