Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61524E4A8
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993889; cv=none; b=gRGlh4pFO6MNivzj29ebihMo9gsYDYrco1VEjYkDllnW1hu+BDvs+dkwndzzi+lyrhG3NXDlzHihlfurE5ltKrEuzKjkCKyX1+hJSV676eehTyFY9cFEdzXQTLDT6y1cu/ollELYpJfTPHw7nh0ndQ5z9xY/aiIrd7u7SOtcYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993889; c=relaxed/simple;
	bh=xqpjAdtNDKIbxJuzJLQati5+Ma8784XKqQZOqX5N7Ho=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NiQ8jXCScM9syMm+13xvr1vlhxZdzM/KbmCEXx+ImB964+0LoId+qvsZrSzggUkI6UT4FTCDEINRBsvjpKyy6kjmUxoJChzxObbwZtS3rQ6Lh4DWkGkZuaY7sOSV/C8WMNp8dXggVzTUFHnfYn2d/rY6p0J1I4OCv4gLtd+WsEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OgFZYoWF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bC3ggkuP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OgFZYoWF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bC3ggkuP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CE35140017E;
	Fri, 13 Feb 2026 09:44:47 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 13 Feb 2026 09:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770993887;
	 x=1771080287; bh=EzYyqIgOWwZJXEdSUF6p8Z+LFhgc4Q+MZJ6nMEQp9n8=; b=
	OgFZYoWFc0F+u7t7fIeJsadmg5wGgd+uJ8w1FTfWNgJQG5Ko9pGljnoY5KbgCaGk
	xiODKtvih6vMHpw2zCVVJXGfydi7maWo9kfjilrgtks4DRdbP73Gevg/1jeaAhXi
	aswuXQ7YRuVh9ZPnB2ebXuGcTF5v3NPs/2M+mIz7oBK6lmywJ4SrYd4PKu8G/++e
	qkhdRZd82GiF+xTiFJDYZ6BmZhOOxgSRc+A4UXaUrVELal2ZioI2IyLWGbLUuETB
	k3+ba6jEkapLI2NKwJOB/sKNvZeCVmSDa66bRB5weygOfdOJ6qMcSxrYQGw4Lwl4
	AHkkhuZ7XYNIbOorwZfIEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770993887; x=
	1771080287; bh=EzYyqIgOWwZJXEdSUF6p8Z+LFhgc4Q+MZJ6nMEQp9n8=; b=b
	C3ggkuPuKdAZXfS0GX4673IRNcsM/Q+OxTaARxuCc+gkhfcD2Zl0cgjkaCRnCyB+
	S7o41+sKza33E3l4rjbAQwBgh9/pY+Y893IbjCpMNdisQAzuQkhhIvOYh0u35ig+
	n9Z9kvz8JT4KZbc5RR/BjYzNmY4eJzsr3Zi5lZNFqDYUBGQvz84t4f6s2t/0Hq8H
	zUasOgJIBDKeI9cZWoLVdxM/jb1ib4oOPuRpMG4R1X5LBXvhj4dJC4JkPthU+Fy7
	+dnvkDGz5FwRgEJA0pshGwRHDhq+XP19Du9lXFnEgopu0HuDHYFPC7hpPRC92MzR
	gLpNDq/uupGEfkeQ/AHag==
X-ME-Sender: <xms:3jiPaS2ab3xgApxeHBDBCcQuTAnhtd93WMYQDM_wIznxcvdXKvX0Y24>
    <xme:3jiPaf7mE0NhhBApeCjzMuE3GaxCdl-7qs_gnY55HDtszhdFt3x0iOnL2jkn1Nrrf
    JuJfo1Z3hxkuz5xnILTBaBWeCCDBM0pe6rPbZ1Ur1gscMg9A48dKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeelpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmrghilhessggvhigvrhhmrghtthhhihgr
    shdruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhkpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhuughgvgdrphgrtghkhhgrmhesghhmrghilh
    drtghomhdprhgtphhtthhopehmrghthhgvuhhsrdhtrghvsgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrlh
    gvshhthihosehstghivghnthhirgdrohhrghdprhgtphhtthhopehsuhhrhehrsehsuhhr
    hehrrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3jiPaXGNBnh4rUauqrTtkZeFqbnKBWbISnWLEUoSAB2xLQ3ODUe8zg>
    <xmx:3jiPaUx1q3G8s6QFt5VwwzwM0jDdmiOV9Cu_M-2V6YFI6-491_EUCQ>
    <xmx:3jiPaZ01ekSDfLPFtXNknISRd9g7rBxbOSCJVZDGyBQXthIFr4i_Hg>
    <xmx:3jiPacrIu_4jgSzVI0rU8jq7uRfzDMwXqB4PTF7MlYVkYIoqGsGeFA>
    <xmx:3ziPaXelAQXkT30sZjbycGryGAzcGkTyVAi0bMlCj_Gq40rFEo0yE6tT>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 52B031EA006C; Fri, 13 Feb 2026 09:44:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AR3KWUyIzV_Z
Date: Fri, 13 Feb 2026 15:43:29 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Matthias Beyer" <mail@beyermatthias.de>,
 "Christoph Anton Mitterer" <calestyo@scientia.org>,
 "Matheus Tavares" <matheus.tavb@gmail.com>,
 "Chris Packham" <judge.packham@gmail.com>, "Jakob Haufe" <sur5r@sur5r.net>
Message-Id: <11522ecc-689d-4136-a7ea-864e1243c2e8@app.fastmail.com>
In-Reply-To: <0484697e-4c1a-4f23-9cd9-079d92dc8bfd@gmail.com>
References: <V2_format-patch_caveats.34b@msgid.xyz>
 <V3_format-patch_caveats.354@msgid.xyz> <xmqqtsvllfdc.fsf@gitster.g>
 <0484697e-4c1a-4f23-9cd9-079d92dc8bfd@gmail.com>
Subject: Re: [PATCH v3] doc: add caveat about round-tripping format-patch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Feb 13, 2026, at 15:41, Phillip Wood wrote:
> On 12/02/2026 23:19, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>>
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>> ...
>>> All of this is covered already, technically. However, we should spell
>>> out the implications.
>>
>> I've read the new text (without formatting, I have to admit) again,
>> and did not see anything questionable.  Nicely written.
>>
>> Shall we mark this for 'next'?
>
> I'm happy with this version - thanks for working on it Kristoffer

Thanks for the helpful reviews, Phillip and Junio. :)

-- 
  Kristoffer Haugsbakk
