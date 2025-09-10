Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D42DAFC0
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538212; cv=none; b=T+K1nVjhEcP/tq5pS+4piFo8Y5XCBlgULX+hbCrVmKwcvB/KkD1OJfcgWMbkavNFrA5E5r7v5tMTtmVZdRXF8BXQtN7XL2unJ26v7smZpsZT++Uue5DQOqHLgunjn8SDLI66Y/PbN3SR0W9heofIdTf2E443vjElnyeeJEEh+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538212; c=relaxed/simple;
	bh=kgxvI+bMHJm+G1Gw2uuGJ6sb98m0fyLLRBIQqkZVIdo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P2qZq2i5M86FfWtn1oYKAeTV8hjNduB+G8g8JnkVPhnIfD4HBRPvxlArgEv7EMITcm0fy+h7oLV5kCRIPoCz/Oz9V0q1r4qF7BDHtou4GI9zK3EimXCMtrQTry2LEPfDSF4EPXD2mHBDwFh2QGLdwZIi735OYcktv5i6WWahhWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GIUJoNSH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hLodBTyW; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GIUJoNSH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLodBTyW"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 64DD77A017D;
	Wed, 10 Sep 2025 17:03:29 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 10 Sep 2025 17:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757538209;
	 x=1757624609; bh=kgxvI+bMHJm+G1Gw2uuGJ6sb98m0fyLLRBIQqkZVIdo=; b=
	GIUJoNSHJB0Mn532Oaar2FckeKrK9aK/c8ifg7+Rp+GPf8Gvg9iFbmQjDuHJbxPG
	fTr8lnJewAOZS5jwbtL6px/ukfMnOCCtISdSHH+AnP5mw71J/xluUWydGnjwO3xW
	dXef5si2vUIbt0JR02yOp59Pxcn/hl6VNaE1wMl3+zdNpLFcxtT7KWykidmDvEav
	JXKp4QtdqQpRe6do0CiItYizaXvit641DNfudhI8Sz+CuK6G0Bg2PSZKbgIniSB+
	sz30vKhyXfF7mMBGK3QObvfh+eBoUnjtPe6lYYVAjOdJF7KaDIgaXTERA5q+M9fd
	vl+FepBectUNnr316ET3Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757538209; x=1757624609; bh=k
	gxvI+bMHJm+G1Gw2uuGJ6sb98m0fyLLRBIQqkZVIdo=; b=hLodBTyWRGYPv3kp2
	XRFG25Sebp9QUQD/cUgPuLuo+lhas8hV7RFpDgkcagwJUsoIc7d4+okO7SDEj2XL
	5SFKBZUUL0E9FnMjdMc71gIqdM9+iKPBvdxmNd5XkbeA7nJax9yrEmNje2TLU5FA
	SBckMt1kq/IhEKgrUdYqNX3ZlSHuaxXUAz3+a0NK6m6fle+EZwNTJWYpHdrcaudT
	V3pZt8EZodg4BfNph8hvPYPl1Y847kqWRxLop7pEW4oyn/vInIUwfsa0QaWIYCkY
	KQQVGmppbHngy667kst7nEmK9ePhGWCbrFilBK7eO4HjbYCJ89oQ+VytQ9nnyh52
	TxZNQ==
X-ME-Sender: <xms:oefBaHUIZ7owGzhPxPYF2l4pubauFreuactq7rEfD3ww31MVbWDFjt8>
    <xme:oefBaPnTSXm-fjw9ZqdUUr4NMxabWqrRIVHGqCFVgH7SMMBU4VsB9kWAxTQngzXMa
    IF4Y7cW8nUE5qMcrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeffieeftefgheekgeeitedujefgveehvdevieelfeeiiedttedtgfdu
    hfejiefggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehjohhsvghphhesuggvvhhjjhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oefBaHVOpL45wHNBK5I9OosiXkhkZOpltYqDjHwPYw_3ifrrVjj4-w>
    <xmx:oefBaD5x5jG04PxwqBhvL3UBbgfb0enwUdc1OkZiUSUzRg8CXUDNwg>
    <xmx:oefBaCiemE2xn2VSHdtHM7geZ8-rThSwRaF5c9Dyxq60apigMHUImA>
    <xmx:oefBaKc-xVZ1mUcgJ49YDzR2XtcHStbNfLMBRz_kT7BkhpN3VBck1g>
    <xmx:oefBaElE9FKM04anhLuvFqf_138sYEstzuBWcA6AaRkHr3uhSmOxGndZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F21301EA006B; Wed, 10 Sep 2025 17:03:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOAeA2vjOVbV
Date: Wed, 10 Sep 2025 23:03:08 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jose Jaramillo" <joseph@devjj.com>, git@vger.kernel.org
Message-Id: <acc2d65c-a050-4792-be3c-83a00810f105@app.fastmail.com>
In-Reply-To: <2d12d261-ae8d-4cff-8c46-b81172fe6c77@app.fastmail.com>
References: <2d12d261-ae8d-4cff-8c46-b81172fe6c77@app.fastmail.com>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Sep 10, 2025, at 22:49, Jose Jaramillo wrote:
> I still use this! ~J

You can replace it with `git log`:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

And get basically the same output.

Or you can use some more modern options to git-log(1) that are more
likely to be suitable for your needs:

https://lore.kernel.org/git/xmqq8qimrrxo.fsf@gitster.g/T/#md4350a5c8cd15=
dc5515f140f8a4d65cd86843584

--=20
Kristoffer Haugsbakk
