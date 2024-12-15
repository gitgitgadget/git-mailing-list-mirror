Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C082110E
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734295856; cv=none; b=TMU00+ifwQcLhYx+Gen+K+yRLC96oY3wg55aXl/hEjwInfeF2enFrctffTHec2V72WKdWv7l9XWh/HSGAXWuZWBpYyygA16QocDirFv5IDCBZ7yChn9ElfIEKkd6G2duVtSffrIy00lvTETH4K6AvnSwzcsrOC3uuqDhItJqcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734295856; c=relaxed/simple;
	bh=KfzZtp4/BCQ+X9wBvMdUKns5YD3NeYU/5F7u4EtUII4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lb0g3a/DgvRkGPMXqAd8Kd9ZyZrFsiRbTSqzs+RzyUNLK8etB/ph+A7gj9wozUk9CCtA0gM42O9Z+15fz4u7Csi1d+UrbsRZ8Eo3lj0379+CDktzd5YASntgRqnINHzFy7oAKnKFLYy60TdI1lWuNOperVIQHO7UwF7bEb2Zu+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kaYM524A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5eaaKs9P; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kaYM524A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5eaaKs9P"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B85B1140141;
	Sun, 15 Dec 2024 15:50:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 15 Dec 2024 15:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734295853; x=1734382253; bh=KfzZtp4/BC
	Q+X9wBvMdUKns5YD3NeYU/5F7u4EtUII4=; b=kaYM524AppPfJHPl556cM39y1F
	Rm5Rr+AyZAuuRBUn64IUHoRRGUIPRSXP0Bu2jH/VevJmv2QJJMx2hCPO4IloZ3eM
	TWnxv7+LG/BUtc1MxeU4R7KOVkoijYg+JtaPIo33c9PUyR0mggESKSmD4O6Ejfsz
	2RQl23FQl0sM+Lp0R83QoovMN4XRN1d0KnD/pwJErfJVSkmKYFy5694Y2OVEBajR
	NyMe586Fgu0CziUFq9jGkRwJQPUguFXRYM+5DapZRJjDED5OLB3Mct58NtbUAM6b
	n5rdbHN4u/EwN+Ik2xaSWwY+bfpIGvoNN/VXKjO4lpA3OguDrUSr398FwaHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734295853; x=1734382253; bh=KfzZtp4/BCQ+X9wBvMdUKns5YD3NeYU/5F7
	u4EtUII4=; b=5eaaKs9PFKlHkv1iaeEP1eGRm6Ysi+M7lrl6boilXUKbX0NouvC
	rq0Yyol6MIsh9/0QnuESlzkI7xfiy3c3RKDfnPNlUF5SH5pRKvDNIVS0uiirZ+KE
	wgsg00o5BXDMCWzj30L3F3pb+iHoRsAzQBIdna/JQ2C4SKMwsb6v2d8ifilAlDeg
	F21O6bH/9XLICWGaO2F7vLCuYmKWNhSgbujR0ivhm4GBLR4xv7opKFMBFihsf03+
	0Buja51/ZT5nm9XclrktuNCh8htfh4ujNiTuHqDmnLN65Q1DAK/Pc1o+H9CpcYHn
	Ai6EkFgDb7FIx+keQqHiyy/cH2cpyVslciQ==
X-ME-Sender: <xms:LEFfZ0NdRwmZVmpInj8cSEN3Fvd9OQktWoUu0zaT3k_329ZAjhTRJQ>
    <xme:LEFfZ68D52xKPBr9boqhpAD_QGsmlE6oyuitPR_uIIbPiaNX-etV08kPxCtjAtPa2
    NsoEpPmt6I_8zl_Zg>
X-ME-Received: <xmr:LEFfZ7QjYApUhb4RZpVoI2qDZqmyzxKlSiYr2raeDni-qxGswoXr-bn9wBlbPzXKJMwi8wDtamLRL-0hhme_lkvD92XSejnewRgeGPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledugddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopehfrhgvvgguohhmgegtohifshesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LEFfZ8tX1hHTDILjv0h09UTypDgHpMaXPUFWVm3wK4DtQcw4-_D1sg>
    <xmx:LEFfZ8eHi2Dyi1z_Uf3ojtvo0FC0CCOiKilVp2SiI-XwApYYnxUDWg>
    <xmx:LEFfZw02wLVy-s-IdfHIsnGXtEiJvMFdNih177dqKmGg6JFP4Lt3vA>
    <xmx:LEFfZw9DAKA6vT5fUODXH5fa_avdVA_ICvzk0DRcns7s4oZTuCObxw>
    <xmx:LUFfZ76EyyCOQzdXZEfA2lhQ75TQII7w2BhN_h5-tt_UFfBPt0sPn2eU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Dec 2024 15:50:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Oliver Blanthorn" <freedom4cows@gmail.com>,  git@vger.kernel.org
Subject: Re: Bug report: ":/[text]" revision reference no longer returns
 youngest commit
In-Reply-To: <ddc10a19-f8fc-4532-90b0-5485d5126bd7@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sun, 15 Dec 2024 13:25:38 +0100")
References: <CADFnu5sMEvGyGy7xH1r0NGBUZJBznCi0waJ_bJ3tSHQ5Y2yX1Q@mail.gmail.com>
	<ddc10a19-f8fc-4532-90b0-5485d5126bd7@app.fastmail.com>
Date: Sun, 15 Dec 2024 12:50:51 -0800
Message-ID: <xmqqv7vk8yc4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> This has been reported here
>
> https://lore.kernel.org/git/CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com/
>
> The patch is here
>
> https://lore.kernel.org/git/20241206-pks-rev-parse-fix-reversed-list-v3-1-d934c17db168@pks.im/

Thanks, I should have looked for the responses before sending my own
version.
