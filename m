Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523B18EA2
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737965203; cv=none; b=pDYQLuBvjvIyTkXmHAkypc6OgJSeZrXwByoG0ng/TYvXNjhtjVHeRQzx3OLzBW2cT+USJBPTD5DO/W/9c6XmUxXodORphNTK1UinXc/YdxNDWceD9dISGUHvO1A6ZkxUTz9OS5rJvm7g3+PHerYmOPnUYn0JH4QU7a18NjbQ/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737965203; c=relaxed/simple;
	bh=+Whq3aZq40k+YhMLFgtbH2febOYHP68lsY0aVlCAzsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu9ZAJ4J1786wrMwLr55MHFQVEMW8G7ei2FA3lRWdvatbejn0Y6f7+vT9lEhSu9hMPJPUIgSnJBpZg/5Fx2IubLrWBnoaX/GORaZV89OkWemE+JKL0SAQ62m3EJUc+0s8fDz6+Um8u4QdDLR0lFWNdZ+KpQa13OZherPmt9YoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ICv/NK3J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UC//iEJv; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ICv/NK3J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UC//iEJv"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CA4BF1140188;
	Mon, 27 Jan 2025 03:06:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Jan 2025 03:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737965200;
	 x=1738051600; bh=SqOc/zHLEIkSiAqd6MpYUXOJAK/dIDh59fBu20orM4Y=; b=
	ICv/NK3JeZ7NgfPXfu9jrvau0y/b1XIFr2ilF4nbyOvTrED895pTmOn+WeFSX5/Y
	wSR0DfOdGd5oFntcexdzOrqCUYgMjphoPkyt/nrJ9gtgDfEhiKNy/nAvkb+AfaC6
	P1O/t0uV7J+bTTmqphOXxYu6tlSqASgSRumSolMYS6t/jL7NAAGbN+ncA2FWdHAc
	L+DDfcXWb+F7aPnknkhakNbo42eqVODCc1Fjh+tbvmuoxrUHF90Rp2XhVqS3W3am
	KpUuXWsDqO5EeE2RUc1C0a1bxkuvS7aNBYBY4AkrEtR9XbqFXvUTvptm6vVf0f9w
	Zgt05WxSLtae+EXwOl6Cqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737965200; x=
	1738051600; bh=SqOc/zHLEIkSiAqd6MpYUXOJAK/dIDh59fBu20orM4Y=; b=U
	C//iEJvgxVijRIpcM/lY3vG/D6/cSHf+a3Q3rofijtolQnwwW5MUMVE0HBb5r0CT
	OVetmBAjjo0YKvNTa8yyY2UvTFGvQ8VUi58pSpzDLfnOp3gInAm09nN1XnRjeBBk
	XTgqqv2FrmJCN+UE1TcKOKc2gOGBthCw6S1iTZlKbd+3vb/bmawRh8veyReeqsN9
	W29/+WeFy6xX2ftKkqp5FGvPX3nHPTcayO7WOcwsGpSKlAgc372MnM/Lp3r7oIsC
	M3OEWOFvYZ2X7loLVGtvOmRDfZc+pCIV50htIVlHaItlw6krZTUFCSHjQg+S4zEj
	moPSX+Vr4xuJ0wbcQbclg==
X-ME-Sender: <xms:kD6XZ8X5xESRo1I2HUy8LldJTCnPuzr2ThDeZXZVnvNxEJRFUN1gmw>
    <xme:kD6XZwlz15-pFFmIw5VOg01DjL8_wIwrpjIeicx9qdng-U-C2YfuDVO_bYXJj8qlI
    5yNUpGRZhE_-DzdtQ>
X-ME-Received: <xmr:kD6XZwZpwnEZ7V__8ZD2WlhcD3AlSryJMhRSeZsOo00n9fGVU8glCsVQAoW3NX7uow6AsLJJrJlsMjXZUJRAUe1zNDTu36s8tb4T4Ge13Fz3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitg
    hkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhn
    pedukeeuvefgkeduffetvdehgefgvdehuefgtdelueekueffteejteffhedtgffggeenuc
    ffohhmrghinhepghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdu
    keeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kD6XZ7WHjWQJoUTHVAfS29meTdHYVKKSNME787ieyp2v-0rSPxBdRg>
    <xmx:kD6XZ2kqT0VKYm4xB8v5KU_I42Jgsth5oJJcrrBwrmOSZcILT0Ww8g>
    <xmx:kD6XZwcBgkp2W8BqTGyy1QKmvOLPAvy8LL7Dbdd2p6Am7aextziyzw>
    <xmx:kD6XZ4FLWP0tTz_ZyQT7ToziJaSsRViuxBRCRqEOTO2iHGqYbRk_xA>
    <xmx:kD6XZ0ZaqLjZVI3qWOE22H3LXUphtGyR94u_fWb6m5qjrm4W6W14xMZ0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 03:06:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e820d33d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 08:06:37 +0000 (UTC)
Date: Mon, 27 Jan 2025 09:06:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: karthik nayak <karthik188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	shejialuo <shejialuo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
Message-ID: <Z5c-jFA9OAT9x5s7@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im>
 <CA+ARAtqfXo75PzzB3cQjDbvLxwytUK=xJiGG=VHZ1sNCcfyktQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+ARAtqfXo75PzzB3cQjDbvLxwytUK=xJiGG=VHZ1sNCcfyktQ@mail.gmail.com>

On Mon, Jan 27, 2025 at 12:19:26PM +0530, Kaartic Sivaraam wrote:
> Hi Patrick, Christian, Karthik and Jialuo,
> 
> Thank you very much for your interest in volunteering as a mentor!
> 
> On Mon, Jan 20, 2025 at 12:37 PM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > I'd be happy to mentor this year again. A couple of ideas:
> >
> >
> Thank you for suggesting these ideas, Patrick! I've incorporated them into
> a draft
> ideas page for now. You can see them here:
> 
> https://git.github.io/SoC-2025-Ideas/

Great, thanks a lot!

> Kindly suggest any corrections to the description, project size /
> difficulty as necessary.
> I've mentioned potential mentors based on what I'm aware of so far.
> 
> Patrick, Christian and Karthik, kindly mention the ideas that you're
> interested to
> mentor.
> 
> While I have not included them as of yet, I wonder if the following ideas
> which we
> had last year[1] could still be retained this year:
> 
> - Implement consistency checks for refs. The idea could be about
>    implementing further ref checks which Jialuo appears to be helping
>    out with. We could leave it if Jialuo prefers to continue working on
>    the same in a flow.

The biggest omission right now is the reftable backend, but that one I
plan to work on myself in this release cycle.

I'll leave it to Jialuo to decide whether there's anything else in this
context that would make for a good GSoC project, as he's been the
primary driving force here.

> - Refactor git-bisect(1) to make its state self-contained

I'd rather remove that project. It would be nice to have it, but it
feels too risky for a GSoC project, and we have better ones.

> - Implement support for reftables in "dumb" HTTP transport

I'd be fine mentoring this project.

Patrick
