Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54830C601
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341362; cv=none; b=hB9WDV0Yz1kcq1wbNI1o4dwKl1L6NVA0y7ys7v61ZcYrSCf4V0YFrwzgsSHPwUAyZwsuIW9y8OR8T992LBr3Qbj8drQdNJ9BebhE3ZONFvonxVj+VNwqEWwlXsaMOkjMUDF1OWSa4HOjgoUX3qeT7KCPNUHrW7LKDp6qwgVxcfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341362; c=relaxed/simple;
	bh=WhEfhvacQYBD2ypOIVl1PG//XVuh0C5ET3rhhwPc++0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KR5P9GfsEOoK12k4HOXUT1DMWyR90jtMNWTNUnPiYvUffUl95xtWaFzVBzkWYKYkBqvjaogh9WWgohlpR63/GhPfaKd92bstgJqtC+K9CapgoLtTj5vK8hkZqQrPWiHBCS5UD/DS3ZrFlvBmru+7EnD6Ol59bHqeOlYdsCfUqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=T8Ahv8JC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCHdus5u; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="T8Ahv8JC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCHdus5u"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8BFC1400126;
	Mon,  8 Sep 2025 10:22:39 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 10:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757341359;
	 x=1757427759; bh=jUZR64Ss0Js/BevP/PoyzCBkiGzYwrlylbqtpj/7jx0=; b=
	T8Ahv8JCEfYyEzg1Gs8wybIOHeF3MlFXxGt9WGFsNfLq1uYguyykVCTPpYQGI0Kd
	scl6xW4swDhHcgvDccgmT4yolS4WZBwqjpR9lr9nhUV5dYCw0DFebivLTCzTBKov
	CTYQRCqU4vrHKPoeLNc3r0A58pvwNCxVjcUdYJD3wPJ5FZ70rUCyTJ/0c1OclaZZ
	nfwyEdMhmPPrNvAGHF6/bTjI6U4zqLBsXlh7I7BBiK3nKnU9qZfrvgnLcHR0SuZh
	PIZYU8KudATwWUD3XGJ/bUYJbXH9++jwFLGZq4SRwtl4wVyR0gHJM+S8iSbSUYci
	p/xYgvlNomPOh5wd/7of3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757341359; x=
	1757427759; bh=jUZR64Ss0Js/BevP/PoyzCBkiGzYwrlylbqtpj/7jx0=; b=c
	CHdus5uO1CRog5YAfz3YPtjltP9nHrPtQ28QXCzBZ4FawmrvKYs6w1QYFHJGBDnU
	oPB9443tkePnyyN7Mv+rdG1cnrnH+bdtirPxY3TKTqEU6j7nFcrwtN7vqV3OUlk1
	mHeamaHpPPbRZ0w7jwUzHgEJZW68oBheLrpRq86jOKrteJzBwRo+rd4iJoCqbObn
	N6csxuIjg3KAXoTDTZcmOoEOUiE80Qi0t18vQqMMV04YrDMgA4j+uphFs+CpA4Cq
	RCmPlK6UIVP2CdnSTv5ESZmZuxwaBsRIaXpD5GBewkaJvu8smS27nVlnmDQ+Of0m
	zx3hTxDKYrJlAg5Kdw5DA==
X-ME-Sender: <xms:r-a-aG2BDM4w5U902K5VFXEZksl5kW2TnPjFWAY7_BOGt3EAC3ZI_84>
    <xme:r-a-aJElDRb8wTIQg8S2tHXQ95Z8gRrLezivw-uAqX9wt8ckgXLiFt25PGexfzAbF
    6AgrKQGiJFrVHQsKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepudeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghp
    thhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtg
    hpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhm
    rdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtg
    hpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:r-a-aB8EplgRo8-SkzhnAnJTcp7wR3R8Lv8CYzWZ8435IP5ixP7wPQ>
    <xmx:r-a-aNmloq95e9nvJ4a9W-Psrq08Rjs4p9ghpO93h7imb1ImdpfjMA>
    <xmx:r-a-aObyAK_VAt7g_v1esiq1pLFyl35xLtriLim5I3m56NWJjvYBzQ>
    <xmx:r-a-aNOX-9EvifB1TFQVD2o_blNUfDf1ggRy1ik7L7bMWFOQyIAwpw>
    <xmx:r-a-aIft3oXQChdHT20Q-1Y4-8UpU2i5GTplGcNldjJnR60JRvyKb2oc>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5480E1EA0068; Mon,  8 Sep 2025 10:22:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A87zienxWkCR
Date: Mon, 08 Sep 2025 16:20:53 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Christian Brabandt" <cb@256bit.org>,
 "Collin Funk" <collin.funk1@gmail.com>,
 "Eli Schwartz" <eschwartz@gentoo.org>, "Elijah Newren" <newren@gmail.com>,
 "Ezekiel Newren" <ezekielnewren@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Pierre-Emmanuel Patry" <pierre-emmanuel.patry@embecosm.com>,
 "Sam James" <sam@gentoo.org>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <c63c64f6-da6f-49a4-b317-9417cd1cfff2@app.fastmail.com>
In-Reply-To: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
Subject: Re: [PATCH RFC v3 0/8] Introduce Rust and announce that it will become
 mandatorty
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 8, 2025, at 16:13, Patrick Steinhardt wrote:
> [PATCH RFC v3 0/8] Introduce Rust and announce that it will become mandatorty

s/mandatorty/mandatory/

> Hi,
>
> this small patch series introduces Rust into the core of Git. This patch
> series is designed as a test balloon, similar to how we introduced test
> balloons for C99 features in the past. The goal is threefold:
>[snip]

-- 
Kristoffer Haugsbakk

