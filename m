Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5B4A33
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762626060; cv=none; b=M+rAHVX20mkcwD+NaZTEtAga0ki/Lj8jzxQeaSTCDAGldDRckwcDh7CDDTNuXiGSHeg5ARb5dfYv54TCbpU0f9h6J8w0e8V7NRJGgFOlfijLTzIdhLKKa6hhND6iYzngA8p3j6tQDQb5JdpTZxDQYC6dVM6TCB7GeqOIybyPKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762626060; c=relaxed/simple;
	bh=EniWQiwAsHxM6mk+pNv13ajVLTFWR0kyB+uSbnkgJ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/xzCokmGBJ0L9Pg4au51KTLHoBzgqAacKD3C5AiLgTt2r5WakHIOmmGq8tlU1VB00e/2Wyh7LeGXlX+wuTDIjM5/cOq/39KKflE+LUhDqzFuFlfnF+9Vrb9iHziAzAroxyMqMk23KmIwft8v8puR2KDUyPX/eGe4OJd0mjVFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schrab.com; spf=pass smtp.mailfrom=schrab.com; dkim=pass (2048-bit key) header.d=schrab.com header.i=@schrab.com header.b=sXmpkd/A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBJd9UgE; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schrab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schrab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schrab.com header.i=@schrab.com header.b="sXmpkd/A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBJd9UgE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 405577A0102;
	Sat,  8 Nov 2025 13:20:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 08 Nov 2025 13:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schrab.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1762626054; x=1762712454; bh=mUra81oAL0
	EvAldhukTue9XN3g7bh81po2RpSpK3KNQ=; b=sXmpkd/AShIDWeZQ+W/VE5MeLL
	USmfFCfWMEhprDyzsv8AZBQJ/hGKsBKDR3oUMTM5fTmWdvWRZU7YkAgCSKDO/dKf
	le2QaDeWoHYxBa1zcQdquw4P1lraQ/RSNNzUKJhKDkr7/kDCepY12JHkY6peS7f/
	5sLzHTxtWBEu2uik5e8Kpc06ZPym+hSFVal9eO/WC5r1uEdg75b+nqMEjCdafIsV
	ZG7F6LS8VDB28BYR+wMMesWy5TeRIGoj6JSc6pBBNBJuP87pZUzUDaiDCf9crqos
	xPvmNYQiIi40aSx01UjYd0LteeVUpJInQ+smNUNWaYq4m15v1UeOOrdvnfPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762626054; x=1762712454; bh=mUra81oAL0EvAldhukTue9XN3g7bh81po2R
	pSpK3KNQ=; b=aBJd9UgEGqpFBDBiUwQamDrVL0dqBneL4LGyMsT2stTcTIeMADQ
	JdGKm9a5ahvK86Sk9wj8s2gUto7cEnSjfiBonUhv4cOu73nBeA/wBIRLbCPsWOxH
	CeSXa8ttL+i4LkSBaXeSc5MuAq5JllMVha8HrhUfZTHBcml8crGMWJkqo8iT9n8w
	T4DoFXLvA779waqyBKesZcmJ3P6rte3gBj7GDs6VDDqgTpu3OJq5oTOQJ1DFK+NM
	gpSv/S0+2CzKNMy2p3sLYQklVhlzLpThv4EH/pjBM9DcypqU6x1h35sOS+BPO+7Y
	z+TVV8N9mvxcxEXE6LY2DRuvvKgaNxJVjRA==
X-ME-Sender: <xms:BYoPaQ4WWyM5GCqrQvlfeoNLLBEqyRmtAefkaFS845IuqYwrLD-Msg>
    <xme:BYoPaaEI8x48crQcjmMwMQxAc1GL523XfYd4w4E2ENG6EcojKjyC73qZlhdF9ntnE
    5_JN7PUl8lHA6Cgfa4UCUj-noJIUiNYDxASrcnPkAny8mf6cvtm8yA>
X-ME-Received: <xmr:BYoPabAUIqPv32tCbcV5-ZnvlcTBH0c604BNVkGQEf_gdDWGFg7obwpQhTFiwg5iiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptegrrhhonhcu
    ufgthhhrrggsuceorggrrhhonhesshgthhhrrggsrdgtohhmqeenucggtffrrghtthgvrh
    hnpefhtdefvdeivdfhieehueeuteelveekhedvuedvhfffgefhieevgeekudevgeetueen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrghroh
    hnsehstghhrhgrsgdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehrug
    grmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:BYoPafx00SiDLWKA9JnjzEb9YkHL9ErrUZLVvu7akCr6qPSE7LqPZg>
    <xmx:BYoPaf565-fNhsaKgpCZESk_sQWV-lDA7pS9u3wdo1z4X_gDyJrpbw>
    <xmx:BYoPaQxlHFMzwyzOHxHmmOxM4NmsG-WXYzR_URRLlNuhJpwbUjTaZw>
    <xmx:BYoPaTfpukSiyWmu0wGSV1lZpYilccYtbEAXy8S8cDLLRyZBqYWyog>
    <xmx:BooPaf8ERX3xFY3y9rZPJ4rKjeO8cL20E5bCneI86RMtpo5dn4jRFpUz>
Feedback-ID: i1fd14616:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Nov 2025 13:20:52 -0500 (EST)
Date: Sat, 8 Nov 2025 13:20:50 -0500
From: Aaron Schrab <aaron@schrab.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/4] submodule: fix case-folding gitdir filesystem
 colisions
Message-ID: <20251108T182050Z.vbNv4y2kizC1@fnord.qqx.org>
Mail-Followup-To: Adrian Ratiu <adrian.ratiu@collabora.com>,
	git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-5-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251107150547.3272180-5-adrian.ratiu@collabora.com>

At 17:05 +0200 07 Nov 2025, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>Add a new check in validate_submodule_git_dir() to detect and
>prevent case-folding filesystem colisions. When this new check
>is triggered, a stricter casefolding aware URI encoding is used
>to percent-encode uppercase characters, e.g. Foo becomes %46oo.
>
>By using this check/retry mechanism the uppercase encoding is
>only applied when necessary, so case-sensitive filesystems are
>not affected.

What happens if `Foo` is added first and doesn't conflict with anything, 
then later a new submodule is added which would naturally get the name 
`foo` which would conflict and doesn't have any upper case characters to 
encode to avoid the conflict?
