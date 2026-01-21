Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B283B5307
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768975170; cv=none; b=rcjoZZHkk8kK+/wq9YNPfpgqNEIstRDe+Ugya2weOeRCIkkuBbFeYsp6qeiVfMwrVPZkbZqePcanJ1FaZTwooaOjkx2dH2OjbjZSO14E9sH1Nsr2GMZ3sn2RFncFb+NqZS/pbROFJdk/+rtQNom8wa76iaSFqn4pSO71AL7KzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768975170; c=relaxed/simple;
	bh=kGJw0lrR2M9blCyHUbihYLrw+Q5Y9IYnKY9jQN7TKGE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Tx+CXUz0qV6LuP89qfAmLc8cYP/FG2m6GHltZcLMvOeNC3ru92uNUfSAtxkCBLQoOEtn6RJdEa605BJWJRnfTvfWRFaCWlAjDSPzLImbE6IabA84dtfqRsNOpkP9FwdyIahZ/fvPllZ9o/diWIhR4DNwtZQllh6ZuO21KAbQTzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TqA2IEXT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C8BGQDpd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TqA2IEXT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8BGQDpd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FDCE1D00107;
	Wed, 21 Jan 2026 00:59:26 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 00:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768975166;
	 x=1769061566; bh=yI3Trah9XBjrMq0ChKg/r4BfkzZIzUA9oZ84upCR5FI=; b=
	TqA2IEXT9gaun7Q+HuiEqZEWiL57MN5P6B2bkq1Bp2dC4zKaHYqz5d/FjQthsmnQ
	8cMqvVeHFcfDTJhwrEHNp3nKHuXQAozENHcOxSdB82xLsO+8ihHsArG7waMkH5Fw
	epV1iPk5k+wDfLx2/Aj3DnxafwnUIFbKF1UtnsNY6PyP7QkUvvuUXzlDUsFQN4Ok
	yKQHSihoi7HTmBw2zW61KnjU1fGVy6U+4IiSAPolW0HPWS02M3JzldWsNRV0Z4LG
	yy823HMdOLX77/MSZqtAqAnPHMP+ymGpNUoRiMa3BPs6AFt1NgmMb1tjP+P3CSCG
	tSN88nHprExAM3UfIIdiXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768975166; x=
	1769061566; bh=yI3Trah9XBjrMq0ChKg/r4BfkzZIzUA9oZ84upCR5FI=; b=C
	8BGQDpdnVwPUR/K9K3x3iaVjz7uOi02AbeePD/7BOie73suyawNlGCTQ5VNh1IU5
	jffAQ/yGFlKLJek6KF3Y9r5jr8f6QgE5d8uS3BWfk1TT6+0LpvYasEOMT87DHFK2
	2Z9ycb8KMkOQCS3D8U7NZp93m4M3R7QD2HhrR2So6k4OA6NqHo18KKI6mrMZ3rnO
	stxxrOEK0n0cPgJyHsCa5cN/31DTK1vOTBNcdmvD2JX7idnqDtWQADXfyxNAeYRi
	/a4X+8lXHTSwFs5f/49tmlMZmdJn6qdeeILm7Y32o6dN1TGgilxQUt3dp62tI3cA
	kbf15OlLRcWT/I70aauzw==
X-ME-Sender: <xms:PmtwaZ_yEBBfQ-oCFwmbErjMvXZwSteReKuyTlOGpPOROrMhy2gqkYo>
    <xme:PmtwaYj7VHlb14RXH1njYvj19s_zDCWFWReb48Eyl3dMTP6ULSFjSATT_1tGeyJmr
    NiTZ1uuMKPAjht32cyEQ-_tw7FdN6yVtMBuCUopa_yun2G8eyNn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffeuueeiheeh
    ffejgedtveefhedthfevvdegudeltdffheejvdfhjeduffehgeelnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PmtwaYJyNubWfkl_X84FxuWOHHC15eU4xEfYU7c6Vax9-qWURunb5A>
    <xmx:PmtwaRHn4z-Zl8co0QHFbEtPt4bGIzZMvwpqPWcXSYOmjUDyBu0wiA>
    <xmx:PmtwaUTwhw3XXha9jNSzul6mj3rj1wwuPevKpUKgEM9f5oaFmKxxLg>
    <xmx:PmtwaVem31KF-na-kWWVaTvbsefEjbJErZCkv-jM7H4lT4rAbOoo0g>
    <xmx:PmtwaSwKKtbvAX3r3g1Iy_mhVti4Q4oZPcvQDJAljkqqhaP-jrJtTzWv>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E03641EA006B; Wed, 21 Jan 2026 00:59:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai8Eq8lg8y5F
Date: Wed, 21 Jan 2026 06:59:04 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Git Mailing List" <git@vger.kernel.org>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <8712ff01-aed1-4f74-9c8b-b36bc22eb56d@app.fastmail.com>
In-Reply-To: <20260120192424.GA3295894@coredump.intra.peff.net>
References: 
 <f10c3f680d58ca0abbf795ae8b0f2ad14ab85419.1768906910.git.phillip.wood@dunelm.org.uk>
 <5a4e7da4-d295-4beb-9f37-b2ce4e10df35@app.fastmail.com>
 <xmqqtswgywb4.fsf@gitster.g>
 <20260120192424.GA3295894@coredump.intra.peff.net>
Subject: Re: [PATCH] mailmap: add an entry for Phillip Wood
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jan 20, 2026, at 20:24, Jeff King wrote:
>>[snipe]
>> Or perhaps your "Yeah" is about "we've talkined about doing it"?
>
> ...yeah, I think this is the case. There's a proof of concept at:
>
>   https://lore.kernel.org/git/YW8A5FznqLYs7MqH@coredump.intra.peff.net/
>
> but nobody ever took it further

I have been thinking lately of a `.trailersmap` which has the hash on
one line and the trailers beneath for each entry. Because some trailer
blocks are unintentionally mangled.

> (I do still run with it as part of my daily build, which probably
> enhanced my confusion ;) ).

Cool!
