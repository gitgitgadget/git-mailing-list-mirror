Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17942147F9
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536764; cv=none; b=kfZRlsveXw4p0LepXDKhvMsoc9ACPb2Fo/RSnLFV9LUNr+yVWpBWIm7JB6QK4Z4r4K3S9DYUYFx60ZNmNPg8pTBfrnDS25VTw7lbNxesKnAd4L/4zuTRP1veEap7/Y2heHbouuK6y5BjWnDRX5WSit0buR+30mHIDeHjGIST2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536764; c=relaxed/simple;
	bh=Kis3levFO1Gd0T7SoF6OBh5cFftfg+EeIkfky441OxY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D6pMaKP3ox0OIrO/gycXcO5sA/Z1Hk1c7bapjiYgp1ToTb+vV6mqhgYfnq+I/muonLbyEKYGh5OVM0a3CxbVOxzWNCbwXlwUCLZCNS6lFvzm6jkIuMpT8zqhX3bEK9V6Yjr584DJuW5viL7GFfYeJWGIkj9F96X1Mkc/gF3yci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=p2bbsYqU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZELHuFmr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="p2bbsYqU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZELHuFmr"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 028FA1400234;
	Wed, 15 Oct 2025 09:59:22 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 15 Oct 2025 09:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760536761;
	 x=1760623161; bh=IheW9DMdj/rKYyczT/AJHtOpRlZV7/xsl9vYqLoRdaw=; b=
	p2bbsYqUuapoJml4bAgghroyIAowIyp6gbK7X0b/bh6jN2gNoKihZVqLxPPmrKGj
	uuiGw2LYw4ILXkuGEpmTrnsGiWcNAscGNfQeqv/Q3H/l5vTWU3ASoqUroVDNUD0i
	M8ojVx1gATocIRmLoPZ/Z26919rRX7NOn2NIepz+FpVCLdOedIGSkvnYEzEzSsyw
	TTOpHgrPL6IRD0eCQn0WW8J2wxtwKjCfHizPm79NplXUMi10/pl87Z432aMAdyZn
	zkOH4bFnyeHL4pFDcw0Fo8++gups8edCaotDn3+eTrLEPiecBBGQDC7R7S8MjTvZ
	l3uLs6hA/gUTA7rkKYYVlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760536761; x=
	1760623161; bh=IheW9DMdj/rKYyczT/AJHtOpRlZV7/xsl9vYqLoRdaw=; b=Z
	ELHuFmr7yd2LjhM7Ho3Z6Gx3GWUCOFo21jUUX+qdiQXcdJ67bXwbIBOQMjV24K4u
	u0mnRbu96HTsFKxfU2xNPSkKSgMo3WLrwH5FcbzdKHtCdxph0kaWQPzyaWSLaCj4
	6jlTQ/2YLS8zPUX/OWyeXNd9zPOIUQHBSYufpNhrlWokB4Q1WX3EuRm1RkoepPqg
	+5kGwdbA58iWFVm3n2s69dJkUv1BI8FrEb0pzaTP7KAOYR+c7z8Tvc6/l3jsqh4O
	VthURTMEafAonTCk87OJSDt8DjQdl0K9TtWgkhPpYxjZwLUXnKw9Y43ORkvuYsbx
	6OksIssbzEaEMPz3l+/cQ==
X-ME-Sender: <xms:uajvaBV2aa50GyuyFOGq0WhIcitC-Euph28Ek13tMAqNH6-2HmmWhpM>
    <xme:uajvaMb46O-TFARSw8qXiHg4p6miY9nxQm3XMNXiwlbDv7OwOWCmCsz1kNSoBsCQl
    -uyeYmPHbuA3AtoCviQZNMrLGOR6__Epq5ndkssL0TPoCSoxn-C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehokhhhuhhomhhonhgrjhgrhihiheegse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uajvaO8Kf33ir-e0NSgO4WSuC41Mb86uV8mKfepm8NadYuHTTFLt2g>
    <xmx:uajvaMhvXsIWpul-m3XxYO2ssXYpkgEpIsgZQQYsuKQIsrc-s1BLzw>
    <xmx:uajvaOd9RMTJQm_IZKk4JaAGyfZZd3wlhpnL4FXGo_kXWTpi5OaiGg>
    <xmx:uajvaDpz0csCGP0dziK1BEc9YLuIVVo5vnhW-nA4R4mPqUz-CPWP-w>
    <xmx:uajvaB-v8_-TVFgPVpnxRgpk1v5l5sZPFxskNtxjtyDgsvyf038J94Ri>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7EB971EA0062; Wed, 15 Oct 2025 09:59:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4P9OLY81YfV
Date: Wed, 15 Oct 2025 15:59:00 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "Okhuomon Ajayi" <okhuomonajayi54@gmail.com>, git@vger.kernel.org
Message-Id: <0ebb19d7-b8a5-4792-841f-fa5a6b9c4d63@app.fastmail.com>
In-Reply-To: <xmqqbjm8waki.fsf@gitster.g>
References: <20251013174658.236940-1-okhuomonajayi54@gmail.com>
 <aO6-LBqhW87GWD-5@fruit.crustytoothpaste.net> <xmqqjz0xw20h.fsf@gitster.g>
 <aO7Tgj4OJVLhFASW@fruit.crustytoothpaste.net> <xmqqbjm8waki.fsf@gitster.g>
Subject: Re: [PATCH] [PATCH] [Outreachy] builtin/patch-id.c: clarify SHA1 usage for
 patch IDs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025, at 15:37, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> Given that context, I think allowing the specification of an algorithm
>> would allow people to say, "Yes, I am in a SHA-256 repository, but I
>> want SHA-1," or vice versa, which would work with your use case bette=
r.
>
> That is sensible.
>
> In short, the automatic choice is to use the repository's hash
> inside a repository, or use the then-default algorithm (which comes
> from the preimage of the patch we discussed in this thread) outside
> a repository.  We want a "Use this hash algorithm, ignoring the
> automatic choice" command line option that overrides it.
>
> If we were to do configuration variables, we may need two.  One to
> replace only the fallback part (i.e. outside a repository, instead
> of using whatever then-current algorithm, use this one), and the
> other to act as if the above command line option is always given.

I=E2=80=99ve been wondering. Why does a command which in my impression i=
s only
useful for scripting have configuration variables? Shouldn=E2=80=99t plu=
mbing
commands in general avoid that since they can end up relying on
configuration state if they end up in scripts?

I want `--stable` so I always try to use that, not the corresponding
configuration variable.

>
> But as always, starting with only a command line option would be a
> prudent way forward.
>
> Thanks.
