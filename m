Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF1239E9B
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648054; cv=none; b=WolyNQyTLikw7Ly8czv1DDsqL5Mu9l9MB+KMDyWH02Q4dGFzxKZgCWLOk0AHQxezn+2S8lV1ANfl/xgOHSIRoI42MIkxg6egxca7aT9ozWaq+kSYNqxIiGtMY2lsmq2xYi/VTn+0JSXrW1aQMwaZaNFhEhx/t6oNF+0mpwkPQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648054; c=relaxed/simple;
	bh=Jt/2M6INGoBdUxqQS7NA5s76/Xf3GA0YTnOqT3rtWF4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dTA1/tXWxL97ePosS3VCD+d0GrL2tS1voh1VL1Xfglk7Bp6ik0lRm+bF/fSME/HcLZrwzkDuXWa3Qyr5+AF1dlotppgw63EVt9u54FUo0AFXONTcA//GGJaTHG423C/FVsJXu29kkRFv7HH/N1SOV8lEfh5PcehFT3JvzOV6OjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CDdqyqkB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ivbHPc+w; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CDdqyqkB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ivbHPc+w"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F22C7A00C8;
	Thu, 16 Oct 2025 16:54:11 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 16:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760648051;
	 x=1760734451; bh=Jt/2M6INGoBdUxqQS7NA5s76/Xf3GA0YTnOqT3rtWF4=; b=
	CDdqyqkByV++hlKahvLaODZrB7vHIe9NcfNkv208TYaP5WQG9Orbjl/mck15zX46
	hm7BDEEG5TcC2ZVjaPZfbf6jQo7Kx1duAlIBjhTWDvEfoQKX4KE6Lbhm3jVydOMc
	l+jF0kaDHreVATQIf4wdvuPVCxjZAXn2zZ5mKy5s8stpSz1IFdRZhttmEq5Su+wp
	1wZ2YCgl1P6xC5rIf6MrUOQDzV1NcoqeW1pOfmPO3tMyHFAU6RCh9rVvmb6688i+
	LiHZLsiKBEklZAbBl0/BcQeA2dG1dsOuEu/z1CyMhXssJn4mJ3BhzJi29dzpBOeS
	9NUcLn4dozvzewsyQTAJlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760648051; x=
	1760734451; bh=Jt/2M6INGoBdUxqQS7NA5s76/Xf3GA0YTnOqT3rtWF4=; b=i
	vbHPc+wHb4KVuXEEStMWRGlnCbtuUOOE/Mmez8AbVJPWqYcdN/9iJMfl0dOcOXpf
	00iFFVp94CfkoAXLRH1pvzHuQR3psT2aHplbH7S8EeowFjQjVRCqwxCZYWwx1tgf
	jv7ZdL5ISYbaBH/FsrP9cHXtPHi53voeYbSaYvooHutx0DSLqKdP27L5BG0YU5kQ
	Lx1mRWkvKgZrnM5e604ZmQsJjDXssoT/Kxhua1gzMZtajo8L6efR+76yfRzhJuqh
	w8fWzMNs2YgRUGTs1w8uxCEo2ZIY6trLUZz3Z+gbIS3pu4ibHoPNsdUT0jaw5k0H
	QrfuA3d1uOTUIDbkaXBxw==
X-ME-Sender: <xms:c1vxaHJbapPtIN1jOmir9SHIf8sp_CL-usKBLn3FCExXkXLgo0egBbQ>
    <xme:c1vxaF8vGFeviGyBGvqM0svuGi6YUQ2ofMjZzz01u309fvlj77Jn-Stpb9Yr6SIXj
    oXoCwz1oS5xGSBZl7pRXjFIo7bQdrVsOebvjUKo7_hvdkPGxJYkCJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehokhhhuhhomhhonhgrjhgrhihiheegsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:c1vxaLl5HPEUbBIPbDjTPpB6VYVXZgB-8efaDrtH98k5nsuSbR2d1g>
    <xmx:c1vxaGmN0stqUCOFw6VxfQBoJ5OqoMyt-92m0v1jHZlu6KPRonOmfg>
    <xmx:c1vxaEsH4MhyzQfEGchBJHejvHOj1SiXlYteY5OA0imUX58nP3w1gA>
    <xmx:c1vxaBn-pZts9JyYsQuVKm6FX4Zh0gNLC3v7ODsCCsgu6GNVDaKXKg>
    <xmx:c1vxaDGyFVAELVfUA1s4kxg0dBrFdxF06lnv79uwFGg5BzY1CtjH20B9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2372C1EA0062; Thu, 16 Oct 2025 16:54:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZBt6C3ai6vw
Date: Thu, 16 Oct 2025 22:53:49 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Okhuomon Ajayi" <okhuomonajayi54@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <5b52ee84-8889-4357-ac46-93ce5b6b100e@app.fastmail.com>
In-Reply-To: 
 <CAFpMFfBe7+pMUL8aaDkGkPUaE9RhCW25OJhJy69EcukgSFn9+A@mail.gmail.com>
References: <20251016184420.78268-1-okhuomonajayi54@gmail.com>
 <xmqq4iry4r3e.fsf@gitster.g>
 <CAFpMFfBe7+pMUL8aaDkGkPUaE9RhCW25OJhJy69EcukgSFn9+A@mail.gmail.com>
Subject: Re: [PATCH] gpg-interface: trim only CR characters that precede LF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025, at 21:38, Okhuomon Ajayi wrote:
> Hi Junio,
> Haha, I smiled at your =E2=80=9Cteh=E2=80=9D comment =E2=80=94 I mysel=
f often make teh same typo

But on the other hand I think the the easiest mistake to overlook is
when the article is doubled.
