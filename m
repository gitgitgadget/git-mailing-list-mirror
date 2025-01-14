Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35922960F
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850682; cv=none; b=LjAwE7cS4qHM5B1Goet4pGcCEAsVhzy4uiWVrNI1o/eBXOKhTFcpxyv+HiHTwctOeCMWGo2lDXVNWDxKwlkUP4qJXfaj0mlO4/ygtS5eeYF44qvwDzFYXwUzFuDq3ytZpx+DGsmEw1mSIjn/UGEG8dFHk5S58vPenZKxHr7dyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850682; c=relaxed/simple;
	bh=bSwBC+ks2CYn8kGt9oymImeme5LhtxovGN+JsUOXViU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjW48tEF2ObvF2xKaB1PneE/QG7ac1L/3umKnuMi0+Pq/nXnJrlbP7pputLbSUFsM6ZeO3HCYbfLyRLPFn88UT77kCa5Y1IBJArMiOnDe0iDrlu5BXbEBV8U32KH8B2ztFtWbzhANCSzeJ9I6+FEMdjJ7VIZR+XKMXxL+HOA5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dFj7kxqB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QmKfNotr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dFj7kxqB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QmKfNotr"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7941011400DA;
	Tue, 14 Jan 2025 05:31:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 14 Jan 2025 05:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736850678; x=1736937078; bh=CVhOhLnABK
	85Z+R1ULiaqfdSv2nGBnbBgV+4BsdakrI=; b=dFj7kxqBckelks0KPiiy4b9pa5
	Pt0PxTU3Cqk78N8DKzhYImz8UmsJwfy8mLOKYbZzIvF/vqrsjEG0vn6YO+0gyKdA
	AHBYZgT0kP7oI2OGM9MzOVIElYezta/r12QSmEyyM6CYRNFhbJiDwwVQIuCz0foa
	qWYcEtigQ9pj3Zda2FmeNYL+BJO7bI9LgwWSSCnQVdV3nC4bmC5R8BuqHyhxQ/mA
	rCtd8EUEgQxI+WwaC0UQjuwcBtkfObZPFUBO8dYMjohqDhTMXXfMX92R7Ufqc+LD
	xRFg1mQdRAUs5CeZCP0JjG/SN6/4YnFsLJIEvjQgUleYzBj42m71jtg5NC3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736850678; x=1736937078; bh=CVhOhLnABK85Z+R1ULiaqfdSv2nGBnbBgV+
	4BsdakrI=; b=QmKfNotrM+ZVTo+hNGoM3uSGeEWCb/nVRr4BBQXbOrTZExWDLcc
	UXHSblJGBUTjzh57vq9vCr8go9EAwjQ4/UEXeiha/M57Rd/vX1asUUUEN2dpBnq1
	f4HAEn/BFzxEtF4jRGh/rwsbMLyy9LkGEzDbhaKl8oys8RICx8of813+Evx8RecE
	NgOoXFoaiA9xrXXzdnfiJgBR3gewsr8+ZJxDoo6Ni34fVQP6kpgVbbWzOST9Pmgc
	LJlYgcd5Ax7MeaCk93TfUFd5ifMNEQdQE80c3ixUjLSfg34M+War1dRSxEtL78BX
	8NcUxRzeRlIkvJRt3BtTkEKVPoYOpIQcDNQ==
X-ME-Sender: <xms:9jyGZxzWlHW3JTsBNv3MFk30iOF40g_kmqm0zNPlMxOdkV6acS9lxA>
    <xme:9jyGZxRugroOO2SHs38iLFnDyO3Q-RKno1G7LVJdDJZO3eEfsldbD_z6MnIJJlR0K
    S4cWN8LrI0gA8-f3A>
X-ME-Received: <xmr:9jyGZ7UuP2KDKnEqGQ6mg06EAYJKkjZQRRCHX4xTs3jV5YvE7eUHTWCFNUCGX3xZfBBPuUmRkb3woqM0Dyy1_C8RQF6BBRabOV-ujDotiCOjMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:9jyGZzjtnOJA1AMYxSGPiKKykggB3Rs8dIksr3e5uhM5Ez4LuhV7yA>
    <xmx:9jyGZzAV1fUSDPz72yAriEAtcXGcFdsPAUUkDY0xendSAxEAf-U5Mw>
    <xmx:9jyGZ8LB6cXlK9ktEfkGhGTPpf24ObGMm2mKvODlLWs75YMkSQYVYQ>
    <xmx:9jyGZyBdEZaA88h8UPjO_vMc_jx945SQj80Bc-SGz8icqqKxXWgPzQ>
    <xmx:9jyGZ-5Ynv6C5bBgnxhloPTnz6RhkVAA14K8QsM7xWGeAqFUeu06BXb3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 05:31:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2919a95c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 10:31:14 +0000 (UTC)
Date: Tue, 14 Jan 2025 11:31:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Evan Martin <evan.martin@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 6/9] meson: wire up fuzzers
Message-ID: <Z4Y88UW7j_GRvbta@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
 <20250113-b4-pks-meson-additions-v1-6-97f6a93f691d@pks.im>
 <xmqq5xmia9m0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xmia9m0.fsf@gitster.g>

On Mon, Jan 13, 2025 at 09:48:07AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Meson does not yet know to build our fuzzers. Introduce a new build
> > option "fuzzers" and wire up the fuzzers in case it is enabled. Adapt
> > our CI jobs so that they build the fuzzers by default.
> 
> Nice.  We have shipped a feature release with bunch of meson.build
> files, but it has known holes we need to fill, and this is one of
> the missing things.  Let's make it a goal to achieve feature parity
> within two releases---if we can do so in one release cycle, that
> would be great ;-)

Yeah, I already had a couple of features planned for this release cycle
anyway, most importantly static analysis. I'll have to take a look at
which other features are still missing -- hints are welcome.

One of the known omissions is most of "contrib/" and "gitk/". I'm not
sure whether these should be included or not. For the former I'm leaning
into the direction of not doing it, but can do so if others disagree
with me. For the latter I'd leave it up to Johannes to decide (cc'd).

Patrick
