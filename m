Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E913C8E8
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142020; cv=none; b=QTch9OH4BRDrBNZ0T73MtyYRkEiI1MKlN969xNFR8w6w8QsRwVg6nEBKLiRQlh5JNIUPFHIKPqfrUEm2kmpBnMYp+jY475zuxsvBpdRc1byO/UwCyjVEx9d2pTazIAM2flsMcTMCMU/KROpkRMxLfVSxBEQZgMnZrlqYG10avYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142020; c=relaxed/simple;
	bh=vc0iXTmWqRaMh3F2hOmEvZU2oiFx7zo2sqZb/2dAvHI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aNJfgcV5KoH4/3dADSNpLqn5QqXFIQ2rt5oiv4z4M9pUCVEm7Stw0Pic/MVo+4MUm/SRUWj2Dm9BKFwYmsAhhsy7Ridkf7AQuLRnR39yWRM7b346pqzC1dlT/qdcSRQHnQTRFTvdU0diHb0MSXlvq3LnJxBAjyqwR2YSYp00ObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=J4bfdkgE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rAql1o7m; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="J4bfdkgE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rAql1o7m"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 036A01140145;
	Mon,  2 Dec 2024 07:20:16 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 02 Dec 2024 07:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733142016;
	 x=1733228416; bh=heluaGGUDBGxPBahQDnuidJsHLQ7Y7At2mreUe13U6w=; b=
	J4bfdkgEZQBqS0+H85tViitd+61iLh/NJWplr7s+Gxk4gL0id8tt6b3sM+Nln3LM
	+tgKi0E922WY4RE0h7zMJQv0iZqHkQIyyOFgJlkCxTA25C8SBwk8bV1f2+yYyH6I
	mVSKTp67HxKF1Lw8yanhoOdv/TeGgWui68IXIVStur4zoTZyuqQdscrCwmVHyrxj
	wHtG7M0OO5Y2h82zeDYxY4PUGlG/CY4ipKJN25YzpEwXKmEt0aprwL2UucqbY60y
	6//YvWdnD9jPd3tfksLnHnOBKazxdhrWpnwpf14gwy3bETcnPrQqT5zcXPn87G0B
	u72GZM5suPstwjQU3XlEPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733142016; x=
	1733228416; bh=heluaGGUDBGxPBahQDnuidJsHLQ7Y7At2mreUe13U6w=; b=r
	Aql1o7mjkeF9YPhusO99qHR2ZQnDmocZee+8wqcUUNODCV1hHv3boPHD7hnN2Plv
	j2ilVUdHHVEL0VICRwBPzEedhHQDogJ31J3VN6AzySI9kSa/YIWl/ZT1O8/Frdyd
	7gEHATIqLMxx8dOfM1GBFxI06/8ki/ozfO4JFPgZSuvZ4OU/P1GVvqzDPaqsZ10D
	hSoZkLjj904MuSJy+zC41rVTRUJXrw5NLD9McQBwmM2oY0cR+xWlQenDNiq3RUWF
	V2KnihoN8raIVSGkarzTi13+r2LOvRRyh+euxdQw54tKKdCAsH8AbDfZ8DL1Pju4
	xM0CtzYG7Wm9q+78lfoKw==
X-ME-Sender: <xms:AKZNZxSllsttjfMDNnV7QCCilRRN5JiMUF5HseJ0IdulxTBLkq8fvYo>
    <xme:AKZNZ6xd2tUfNwzTsdkviOidr6yoahhe6BJu-6M389yQklzn-FqWW6ci4zDLwWsgX
    vHDIUniizFEHQ3L4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    evkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeek
    leeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtsehjohifihhlrdguvgdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AKZNZ23CErgDBNweDZ1zPTC2GTYPqBkebvTV9uHNKt-oIa2K0BVlsg>
    <xmx:AKZNZ5AiCkIvieRfs58iWfDsJM8mFJi9GvWdiNt6X4lCktTWsUhqrA>
    <xmx:AKZNZ6jbYTKFZkh4Baoxv7pcznxnq39W3ti1XrkyjECwc86i46c2MQ>
    <xmx:AKZNZ9oSyg4PurLLtenrzkgMRdsh369RpSNlZMvJIRXZmvIgZyJG_w>
    <xmx:AKZNZ7s57G53-pMnWKVaSC1jxqCQALcaqaNLP-8fTYPTX-s_kpN_pdYq>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 93223780068; Mon,  2 Dec 2024 07:20:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Dec 2024 13:19:56 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc: git@jowil.de, "Jeff King" <peff@peff.net>
Message-Id: <477f0dbd-60ed-4f73-b945-cdbdaf9f510a@app.fastmail.com>
In-Reply-To: <20241202070714.3028549-4-gitster@pobox.com>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-4-gitster@pobox.com>
Subject: Re: [PATCH 3/4] t5604: do not expect that HEAD is a valid tagname
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024, at 08:07, Junio C Hamano wrote:
> 09116a1c (refs: loosen over-strict "format" check, 2011-11-16)

Nit/confusion: the abbreviated hash is only eight hexes long.  I=E2=80=99=
m used to it
being 11 for this project?

Does the age of the commit matter?
