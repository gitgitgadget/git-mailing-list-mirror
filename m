Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1A1946C8
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265065; cv=none; b=CricgaRN5ZZL43MKfCHal0rdgLo+At4jBBZlOGC+X849934geKbrkpWp68284Oggp9Ae7et6Hz3tUsDKX0aGqgVma6ym21EwztMkxJQbLR2rGU+UCEL0AHE6EqCabvIuDLfc6/F2pUVG818hJ1/teOQ5iE4NrpWPtvhvPc5fX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265065; c=relaxed/simple;
	bh=FbmRoNNDD5R0/o6dnLx2GGu+ureIdeEX09plkmmUqyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mfn57VXSNkHO8PRyxV9xLBPAPizNb+FcMhR9X6SQBpLT4L74aHQr0DgmuQioD+paWWtX77qlWH5QPa52SGbK8jiBWF5H4OnmGkGC41IftqcpPOOJrdSglF9VPNDXpAFJ58bU8huieZ/B/Zk/Cv4+VCZG9AN0PXP4VC27s2Cyec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D+o/Ozg4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EQ1HggZ3; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D+o/Ozg4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EQ1HggZ3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F1B71140195;
	Thu, 30 Jan 2025 14:24:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 30 Jan 2025 14:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738265062; x=1738351462; bh=nPIlZ+shgo
	H1l+HHsowOgtMWMG+SMK577WqCeSpM3cw=; b=D+o/Ozg4ETTEbj1BoCWiPCl6Kh
	tKZqcLF1MHHAVGEwIpfMicco4j7RftPxxIid9aBh9btA+KzftcLyqmdCDhUEJe90
	B1YVKnmDbJZqss9T4JsLL2M29TSH6diws0QKL5GSyCKTWcpWw9EZhWY7uyIYAAuH
	rawxQV+xquc7XnTHoFkcm2+tO85+XGgD0FvPlm2IRZLv/GR3ZUZqbD66sI3Y+MaT
	tUuNWed0McAWkwMQXYlmTySNOFFeLwvJZyCKcUJs17ta47ueYFtZqlmhBNoZeump
	Ot1okAEP0cQC0EzS5J210/Km+e8ElbRYd3RqM1tsc6mJ3f08G7Zoxw1ps2MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738265062; x=1738351462; bh=nPIlZ+shgoH1l+HHsowOgtMWMG+SMK577Wq
	CeSpM3cw=; b=EQ1HggZ3/Tag+GWb7N5L+sWSR6BMq+iraPnbCEUCMmr6pQTJotP
	GBo+vinoPpL9cAKd9IwffHBZDYs5eKLsZOGanpaQz1BLk9NCr7QoBzU57YTI3vEH
	ik/fT5oHH1mxmIRHzJLInS44EsH3g1IoM30Bf3E0G9qRlNKsbBahawiP9CEIJhEU
	9qEUkcLejCz0CQQEilib85ZSwU0/gu00XEn8f8L89sjcz702KjtyQiMo718T+5o6
	+/kiTU5HAhY8Xa+lHp/6vRl0sp9FpO9JWJVS0K3RGZnvvdwyBm099PiyOcG9SN0W
	sXQInh0B3Pl2M5Vg+Y1w3uVPaIqrQFMKVQg==
X-ME-Sender: <xms:5tGbZxGyYn6C_zrADPOjbb36LoxbiEkBF87UwvLR_lt32NBQm5J01w>
    <xme:5tGbZ2Uzo6mN2nT41HihtGol2o855fX6sAJ3fnQ1ElcvwRJKWaZ2UHQYezY12CRus
    NCoxQpytZllg_fu7Q>
X-ME-Received: <xmr:5tGbZzL4JcnADpcK34NoT3y2zAf5Sw9RTLtYrVDxxhCiR_2Y4TkcRabCwE6_gbLAjrebkaBPwkaMN9NLZ1Piw7qzYg9Hnm-Pzw8r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepshhovghkkhhl
    vgesfhhrvggvnhgvthdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:5tGbZ3EFIzHORRXxR_lGYognG_9jEIbdsveOLb96GOXMqCy9Av507w>
    <xmx:5tGbZ3WbPKExs_2VlafBibBMeXVCH0Z5AkoIFAmhigp7avU6YUvdWg>
    <xmx:5tGbZyPrO2E60zbP1S2Ppd5D3ybnrSAfz4R-0U-amamdRc2QY5G-Sw>
    <xmx:5tGbZ20hpszwHdoq9XxVRdXlAjwHw3rf9N3H7YiVCGpGY20o2RlACg>
    <xmx:5tGbZ5K9lJfsM974L-bkrJhEWefBMlGZO0rWK6CVDkGyc_nAn3jGhs2m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 14:24:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  sunshine@sunshineco.com,
  =?utf-8?Q?S=C3=B6ren?=
 Krecker <soekkle@freenet.de>
Subject: Re: [PATCH v3 1/4] add-patch: Fix type conversion warnings from msvc
In-Reply-To: <57031bce-6dc4-48a7-b4b5-1b837ea3ab8f@gmail.com> (Phillip Wood's
	message of "Thu, 30 Jan 2025 10:47:22 +0000")
References: <20250126125638.3089-1-soekkle@freenet.de>
	<20250126125638.3089-2-soekkle@freenet.de>
	<6a251603-25bc-415d-ab8c-ae698bd7977a@gmail.com>
	<xmqqsep1iei6.fsf@gitster.g>
	<57031bce-6dc4-48a7-b4b5-1b837ea3ab8f@gmail.com>
Date: Thu, 30 Jan 2025 11:24:20 -0800
Message-ID: <xmqqbjvocdgb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 29/01/2025 19:52, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> By the way, who is
>> <CAPig+cQ49Hdc_8=mRhhJDTny_Kqo6Wg6Nr98rsBN_YXmBrQ6kA@mail.gmail.com>
>> and why is such an apparently bogus e-mail address Cc'ed?
>
> That's the Reply-To address from the mail I was replying
> to. Unfortunately it does not seem to exist.

It just occured to me that it is probably added by a mistake and the
sender really wanted to add it to In-Reply-To: instead of Reply-To:

I wonder if this is a mistake we can do something to help users
avoid?  "git send-email" has the "--reply-to=" option and there is a
valid use case for that option, so disabling that option is a
non-starter.

Of course there are other ways to send e-mailed patches, but I do
not think of a way to misuse them with reply-to and in-reply-to
mixed up.

Thoughts?





