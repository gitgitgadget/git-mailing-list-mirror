Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69D27F4CE
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758870804; cv=none; b=SyUG8unFAtO8GrhaFWB+CbCjNBlOEw/yEGXs8H27umLFEAAm0pZY5UIhv/kbNi7lTZIPHk9i3onPghsgyjRNtDYJ6BUpA2ABJw3mAmJtSDEanmHPWBTZxcpSPRLRxU63BNFGWAozM6PP7L+f6vzKR/E+VDXYBg6PCJVv7NVKXsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758870804; c=relaxed/simple;
	bh=0fKNq3k6jnQGusXDuhpsQh3Ra3SlLaEsZIBr62or9XI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QwIuCGjPGA86JBWhqS9Mk5c0qX7BpHjb07X1pdZsc51kecAx44+ikavBCSfHfX4u/2/mPNrKEI2C8VdVOtWl8YHhVS/GJX0C/YUkuaCobK42ce/6+VpGSWkPRwBe8zHDDh7AEprLhLiax1OaH4o1akAg3OGbxdoLOatW+fnNJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pNeYqvZ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rphYGH7K; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pNeYqvZ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rphYGH7K"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71C4E1400062;
	Fri, 26 Sep 2025 03:13:21 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 26 Sep 2025 03:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758870801;
	 x=1758957201; bh=0fKNq3k6jnQGusXDuhpsQh3Ra3SlLaEsZIBr62or9XI=; b=
	pNeYqvZ0fotImJZt8OlT+wPgvEQEcJEkTpAvsP5Et3QdHRTTeecOoGTOFHbY3RxS
	5vjK/7nXL9frIVr6hEc7jSHJ8We5AJcBe8eGL7GCOr6fjrGDcz7MHO2jDOr/otM2
	gH+mvDeZ6wJb/AQaoS7gfsTczJvjrn7WbI79fIyQOdAQ/g5qtcBU+Jjk7ecBUYdT
	Htjreqh0tN0dTryxNa0f8fuUBeSdzrSbdifSxeqQTDzjkqlZIdKkCsDIYJgyw27z
	bgaDZQkJkJLkBryW1GihcSIVZYB2AEx9CXVX1EbUToG9355bEgfAlso08W95k07k
	+Jsm3x2R2RA4XraYoX8F4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1758870801; x=1758957201; bh=0
	fKNq3k6jnQGusXDuhpsQh3Ra3SlLaEsZIBr62or9XI=; b=rphYGH7KDCTD9bauw
	lqSDBU9C3DI4YYqi0rYfKWhRmn+ONlYKshFRSBBZZ2iAh6jwhIg6zAVOeG3ni1CF
	mqQIOL9cKTXy88lyhL2AfcNgFxT42W8ch5PDmIcWrJ6Q4TcRtf+FdktT+IPS0tvN
	duwUuK3eahBpyiVUJpgAd/cyTWJejwIF9Z7t0sM/f1EjHYJtWj5NLYoZywBboztV
	FtnsNuE0DGKC2bMpeK7pXFZvG/03ojk1JBSi7SFdfsyMfzxtNOva2WC1KWTVRAni
	80eRNAZXlXdacYIQbI/ieU024W2+UY5VphK33wWMply6hkAV8wTjY51M5bztaVDS
	Uxw0g==
X-ME-Sender: <xms:ET3WaGlw7jUWqbrbWA5tdLqj5aVM006S81-zl8INeWVCtAhEuc-M15k>
    <xme:ET3WaIoG37myNdmV0GYb2u2yyy_AK4PKOMMt1HCpAVIIhVOF0IdpklaBPtnuCG5Gm
    b0JCFez2i3djBYGkdJB-sm1IoV9vhL9hUqDi9XsHoOrM9SqYOwpKXs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveei
    ledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvlh
    htughofihntdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ET3WaNTDSdkEZ2lSICErrdH5mWEZink5xE15ZrN_ksu5o1XGNRcAww>
    <xmx:ET3WaEsio1FvkM5QvRC2MSst6BLGxbyLHI-reu0DHr0cw5CHRMvXiA>
    <xmx:ET3WaKZ5L-Qj-mnLuJ-cUvyHbT0AdRHpulcbuEHhD4589bMUYPOdUQ>
    <xmx:ET3WaBvbIYZiY-GQtyssJHBCteDNIgyTdNKjNLdMZy6IuBf6Al7lvg>
    <xmx:ET3WaFaXgEJBXuM1wey9kpk2PFJ0IzV2qeZOruzKN8HHUQZd-PHxTdwR>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 266871EA006C; Fri, 26 Sep 2025 03:13:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A85bjPg_JiWc
Date: Fri, 26 Sep 2025 09:13:00 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Neal Miller" <meltdown03@gmail.com>, git@vger.kernel.org
Message-Id: <7e3a5da4-0ac2-40ae-a96e-0e9a88a68d7e@app.fastmail.com>
In-Reply-To: <19a81573bf1ef7c544106e8fa7dd3b2db304c4f7.camel@gmail.com>
References: <19a81573bf1ef7c544106e8fa7dd3b2db304c4f7.camel@gmail.com>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good morning

On Fri, Sep 26, 2025, at 03:00, Neal Miller wrote:
> --i-still-use-this

You can replace it with `git log`:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more use for
`--stat` or `--name-only` rather than `--raw` if you are only reading
the output.
