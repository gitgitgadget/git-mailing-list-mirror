Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD423A99E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862853; cv=none; b=jWr0VFj7O7sY8PN9D4TTrRQ/A5MzhbFw/Pv8ftRtmmJUPmc/A8IEdIoGZlQppCOp/ODRZAn/1CtJ7KDbGzeFpQY9gRlgxpFqOFBMG3aeQGZzDOZKJHoUVmJo0tCJ9ePFSCMQ0m9ghQVQf5P4PYDIznrNiW/UeipL+2xV92Xhzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862853; c=relaxed/simple;
	bh=pBOD3PNBm7JASFuSFyF6L6pWqzTXfhGvnG+xRiuoTkA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pKgLyMPUDexB4KQOCIuD9gWuTiBYpMM6OCXVvOo1VupffGkmeawmlDD0lhufSfdsLtsG1ichxPvhZ5+OtJSCdnZFQn1vIbr3nxIRYqP4bx4HSpVlzXQaSyWIi4x/P9ZrVgXWJPMyTgJEtSPQnxFZK4b5tzPERq3lr4DIGxPWAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ru1Y1gV2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tPgxRdF+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ru1Y1gV2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tPgxRdF+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59CFE140016A;
	Mon, 23 Feb 2026 11:07:31 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 11:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771862851;
	 x=1771949251; bh=Z3tsRfCYzRq9AXDRSUWmpkTYcFt6t/ZOh+I/G4reNvw=; b=
	Ru1Y1gV2PyMA/Sl2WSw7aQgc3hFc1CGTlAFGrdHzfPbLEkDudnTjp/ETS6ec7mdv
	gP2zYpQSA/4LpX5yXnJWHRXb2cbvzp2ddi5BM00Uhb8PBjxV0M9PkO4OpoQNdxKj
	CjRq4Cgj3CGeFT/+mHJJj1pLVnXB7kxLJbR+gjoE+no7d+UzKfBoUSQ9ZE1lerCK
	NIQleYmtY04orynWAW1+Px0Ih9sp+muGD/jpLqUwuf0sUZwWvNF5UoHBEjkntT2P
	96K/F+eLoRWj4fcItdRvHxI3SioLI21PuKvNszMajA4flksnG95RPJTboGolk8ES
	kn8inzA8Sv8tqofJNLlptg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771862851; x=
	1771949251; bh=Z3tsRfCYzRq9AXDRSUWmpkTYcFt6t/ZOh+I/G4reNvw=; b=t
	PgxRdF+VRI9Pw/nGcys2wW7K8UHz5z8wedDR+KV27ciFmeM0LkQIJedNj3hjGm51
	Ljh/YM0RWJXWWB0nyqFNk7oIooIPoolUivhogbgVCLcz7JE7AmEg/OdKFcyGObEg
	KgKNxPPuvozQsqbrsjvx4QnIF+aAk5exyhnnNePiEr8gvlfsOS+3SLu4pMsKOPk6
	MfJ7ycHKD0kSdP3KERu5FQelbbzuW9BnprV/hjalqIgV0MmeZ0EYttgW4tmEEixD
	0dWmPkc/5P7q9+5fhY29aJkzLdZcJ8AVSkmsufse/WOU21AkwBGwdWnFS6zh8OHT
	dz02SeI74OEe1M/h6KXTw==
X-ME-Sender: <xms:Q3ucaSblulbcNPgfuCb5Z26Degs-b5MBiWiyuSvPohvJEVc1IXIE2sE>
    <xme:Q3ucaQOJCuaxIacj0o1FG7gCW1vdzSEji-RYpw2rt0X62-9ml19z82Ua41J07qAvc
    iBK6rIO1rgFcwrJY8TAxRzqHa2YQg2DXCBEdWREQO4QiARn5l09>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q3ucaaGz0XmqISoosleJCJZJOHep-iJaf2PITYjjE0ilyU3ydwTPkg>
    <xmx:Q3ucaUqRBWAZMzunH3-_CsIxw4GZjkIMqBdTUJ2zj6Xzh3Tm4eskjQ>
    <xmx:Q3ucabYnlWXJcbZstxX5x10os2ASSQlCisgNqKcEtw_n1oEg9GOqUA>
    <xmx:Q3ucaVWLJ0EMgs_mago6WXxddy-c59aOwpBnpaeuSs3z7BN33R10gQ>
    <xmx:Q3ucackGo3HUsLTeP-IrqRp1zBIYuBw0k_ggAq21CETtKxysEG0rFNER>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0F6FA1EA006B; Mon, 23 Feb 2026 11:07:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdFosU1OfSzV
Date: Mon, 23 Feb 2026 17:07:10 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jonatan Holmgren" <jonatan@jontes.page>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <6706edc2-04c7-4bd0-81ec-33710088f0bc@app.fastmail.com>
In-Reply-To: <112cccfd-ee04-4c23-bc5e-fd269ebc6c1f@app.fastmail.com>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260210183110.1151072-1-jonatan@jontes.page>
 <20260210183110.1151072-3-jonatan@jontes.page>
 <112cccfd-ee04-4c23-bc5e-fd269ebc6c1f@app.fastmail.com>
Subject: Re: [PATCH v2 2/2] alias: support non-alphanumeric names via subsection syntax
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026, at 10:29, Kristoffer Haugsbakk wrote:
>>[snip]
>
> The HTML output shows the list continuation character (+).
>
>     + Note that the first word of an alias does not ...
>
>>  command. It can be a command-line option that will be passed into the
>
> And there are two more outside this context which I suspect are knock-=
ons?
>
>     + If the alias expansion is prefixed ..
>
>     ...
>
>     + * Shell commands will be executed ...
>
> See `Documentation/doc-diff master next`.
>
> =E2=80=A2 master: 7c02d39f (The 6th batch, 2026-02-20)
> =E2=80=A2 next: 4a7958ca (Sync with 'master', 2026-02-20)
>
>> diff --git a/alias.c b/alias.c
>>[snip]

Sorry that I just replied to the first hit that I found in my
inbox. This applies to the latest version which is in `next`.
