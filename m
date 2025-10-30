Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F234D90C
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817840; cv=none; b=KDZdHNJy4h/pEeZZMAWyKZsoEOnuTgTfjfG9bvRQf1iOynoViKvJS5YsOjfoPF+vGUkgTrOnrnhSx8LzatKas+m6EFSuNSKAktxC0gqHSrdedbTuS2kXNILpShOwkI1HmugvkxV3M+z8uPGSdWe/eN8I3TCwe1gxNuv3FKYvt7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817840; c=relaxed/simple;
	bh=BGJoT+e3bzsSGdCuTbjVQUJli9pq51V7a89167+6JQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUSZmzP9LoioRaQMJQVISNHGi5VNhgPEGpV/hxH5gR35ZL2CDvbcg6tjMX7chc/sjICyLAQPR1X4LbSboNkDB2T946MTsVpvXIjX6B1DngRAm0mgHfvedMZZ+77R3Nhmd7eF5tRPaysv+FgNnDBmCxukZOndSd8HBlAksuYFPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S7bOHv6o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWhWzoFd; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S7bOHv6o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWhWzoFd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCEE3140018B;
	Thu, 30 Oct 2025 05:50:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 30 Oct 2025 05:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761817836;
	 x=1761904236; bh=fqpxVMeQw+6pXF2tgMgCOsNvyCgP9K2YUbliSrcua5c=; b=
	S7bOHv6o8NaoFHGAVEOLpJhiXvqsV9AJ73itfOp9TqSQTzyZzlPEZ4OwgDBReZ6q
	mB3l73bIpizRG557JmpUcNfV0vTsF4DF5c+oO8AQcYqFHYti411noUZdF196+Wrf
	272osbseh5KAfvmQTdvsjDwl37xJdJYGu8NSjogNeMyezhZJXMYmjRF0tyInSrmg
	ykxnwTjUxCZtQtSUI98eJ55ZyV7sTACaok8ljU4Yhdpc4DPWw00o91OAchCyXfZk
	vUOPs9SZ9V5bvx8KynLHKbfIcr2mFRNHXTQCiYR9zHghyn5+/UoWb94aVObWlf29
	jFLKZTdMncqfb2dRyop7Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761817836; x=
	1761904236; bh=fqpxVMeQw+6pXF2tgMgCOsNvyCgP9K2YUbliSrcua5c=; b=T
	WhWzoFdTX234yrgS338aaFcEIehvxz6Qi0JdlCTVsVWuONB7u70ydbzMTySWPRNC
	X8YkSYcUNudUGUvsyir+xnIpdIJZ2Pp7VU3MsFjE6s2bNjPYU3EJpl5ErbjJeRv7
	vfZsZ639bKRdS+d0CIR21xmDIDaYrCGSYtXUKtmDC0ykMnANtvjWydnNYFR0GHXA
	C236+XqafGrLVrs2dki/AycPSPsw5/RyDUX771W/2Cv1rqXJIT83QKgak8Idlbg5
	gRrltU8YEam9oTGXS1KTts0x2u8V72m+aT9RDfWcxPUQDZg7+0iTWGSsdMHK5r6p
	C1JI5DzyiyOuaMx34aikg==
X-ME-Sender: <xms:7DQDaU4MVsuI54WPiQpFv3vw_67VHoS4ks1BKeFm7bXmgdho81IF3Q>
    <xme:7DQDac4RyEEDD6Jk3hWK55oDi2xakVCSEdvzCa4UB1645K9tAS2dtmPAf6lYIn7ag
    aiVbhTbjEKdtSnk3-GI6rMF56pGEZyFnw7DDHOca2ZlWR1ipHN3uQ>
X-ME-Received: <xmr:7DQDaYe2AD4X6FbhBAOlJl1JtCi9ySUcp057SMEB9ffb79jbLlHzjRrqnr9TrV8RdOXLQ4XPpQ1eYj4VpY3eDEczpe-ltbt4hVkjYsw3_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeivdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvgiivghk
    ihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7DQDaYAP3zlOIstX8wASl_4udc-sC_SohUwiMEHAHcQTbEH_nCiu3g>
    <xmx:7DQDaT_PJwOWgYJA7W3LZfW5054beqUotQVdPSq2lGQo9ClcEwC4_w>
    <xmx:7DQDabIl0BqTRk87VUJNElPra7zOfhp_ZorwCNial2hQikjTqXjl0A>
    <xmx:7DQDaUgMgRCFxwk1sUF7gOksCzRC8NCFRFMuc3uWfBdj4sUlh1yPGg>
    <xmx:7DQDacJx3rhkYuAFO9b4DPue_Gmd3h95FpibOvZRbDmIeX-8QIk7kjUl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 05:50:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 628045c8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 09:50:34 +0000 (UTC)
Date: Thu, 30 Oct 2025 10:50:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
Message-ID: <aQM04h0H_SplfsQo@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
 <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
 <aPsepOtUf92fqDL-@pks.im>
 <CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
 <aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net>
 <xmqq8qgvfyq0.fsf@gitster.g>
 <CAH=ZcbDzkACjFsT+z9WJ8MXwivWQczMRhEnV2MOpJ8r3zDc-3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbDzkACjFsT+z9WJ8MXwivWQczMRhEnV2MOpJ8r3zDc-3Q@mail.gmail.com>

On Tue, Oct 28, 2025 at 01:11:53PM -0600, Ezekiel Newren wrote:
> On Mon, Oct 27, 2025 at 10:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Given that the stable/trixie was released on August 9th, 2025, we
> > still need to go by oldstable/bookworm, which has Rust 1.63, if
> > people agree that your rule to decide the floor version is sensible
> > (which I would say is OK).
> 
> I think that 1.63 should be the minimum that Git supports. I think
> 1.49 is way too old. It was a bit of a struggle to get cbindgen to
> work with 1.63, and I don't know if it will work at all with 1.49.

I think cbindgen 0.20 should support Rust 1.49, but I'm honestly not
sure about this. They simply didn't specify a MSRV before 0.21, and in
0.21 they bumped to require Rust 1.57.

Patrick
