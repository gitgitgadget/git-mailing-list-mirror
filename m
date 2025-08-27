Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66571A9FB8
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326374; cv=none; b=XoFvd5kJe0jYjVTnPrSQiT5jTSn6kijUD9TgiBCGpWrpEUKaeN86rgL3XXzeV3wLpI89d4BwEBEEGAanR9JpEyt5Y+fdh2nKz9iqz1wKLnUON1ckZBgacKKkAdQf6hVEUEiUTUvCl6FYq5ARJawrRL5EP5l6MrwvuYVunI2Z4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326374; c=relaxed/simple;
	bh=fIdy2WZBf0K1WLS7idAC/v85q9HAX+baTFnxz4/FkMM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kpJiQo7qO3331SI0UTyO8EX1qx5zrwT9cnrr3ZXLv286gr4en8nRiw+uzb9IhXDo4jjgnMbvEd/lDg4mp/SMX5YSi8Nc3+Tcj07Bw75RhHyfP/uNQB4Q3pjexh8tPXcm1Vhu5ivPZrsrRAyOKtu6d7a2jjYvqLjTqU6cJlz0ROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QYFbG90+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQgzxAIY; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QYFbG90+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQgzxAIY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D598E7A0136;
	Wed, 27 Aug 2025 16:26:10 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 27 Aug 2025 16:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756326370;
	 x=1756412770; bh=fIdy2WZBf0K1WLS7idAC/v85q9HAX+baTFnxz4/FkMM=; b=
	QYFbG90+bX1LDFQPhM2rH3tMz7FbCsHkJESBsOBIGjapuIZ3r5IqZ6IJjWGSfSsL
	RjUdLtkgrM1PUuxZ6I5o6idHaXNchXffMr6shBm3V3unzT5+d3u3b/DU4slawrGs
	vojn1EFk/YNrZ0pbg7eAn4X0s9a4lYa0vHIv+Ji6AeB1MfmWz8vPqRIHm31P6G7o
	UDKLvcCIITYgN6gH8Ar64rhAVsVC4S4GC+l7F5+JzjnRBnwGha8MUsQw2mOg+8pa
	LsxqxT+QlK9i45ctFfgeWAFJ7hyAzQPsLlG+4KZLmVHPUL3rpI3nF5/DRgOkTKpE
	MlpdJ8fFSDLeI7Ey1eAgmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756326370; x=
	1756412770; bh=fIdy2WZBf0K1WLS7idAC/v85q9HAX+baTFnxz4/FkMM=; b=a
	QgzxAIYxfF+q1jSfCbo1NqToh4q60LSEFV7f6Dh2iFPDNmT9JMZaKatnP0ed6Y/f
	z+VGQSNlx9l7wUb7a88McSbgZBwpw6XwHPIEnRzEiPCgM1bm8LIMpGPknYQui2Y6
	FLFLw3OKJ5670NFqXEIkKU1j17YEVHSykzWNBCoW251wzZYe/JhFFAG/Vq1JkpEM
	6PAWpmapwpi1StVNoDJbDAGYefJb5vxHIao00C74buVBeIt9yoH3FZdkkegVfKKR
	LttD/pvFDYVng8liSBbieBo4pNF4aNSwbzbgGjA+QfnDVIgXqkvhJWUPXnLkUjNT
	QBLJDWGwnIuHsCxD7uF2Q==
X-ME-Sender: <xms:4mmvaI-bDQlErnBpw6MOt_ljyfTGmPoq6rXVjf1a5vjw8MVNHfvTtJg>
    <xme:4mmvaAvSV8aEd7YmOG4gosAKisDMywU73bWbH31gF-vW-wJj-jy05Ia8v9kQWrM-D
    gUBBdAWt49lF_zNww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeludduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehrphesrggsthhiohhnrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4mmvaBkkBLBsMLeiyT36eVD5QWfixRjWITGRBSnkVxSxyGnaYKYy-A>
    <xmx:4mmvaDtQnwmN1yqEBL5VVw7AMBiDAfbKe2_Ciq6imTzMK0n0Yone0g>
    <xmx:4mmvaEms32V3xTT-TYKwurASOWBawWPFYBlY3Ma6D6dF9G35IlexPg>
    <xmx:4mmvaOv6JOSd7skTf0E_6yEwczTMXhmDMVuLYE0Rt3r92VIlcMbweA>
    <xmx:4mmvaEn8S7GehYwc3Orgh7-XFCvE4k7xRxc5WQiHswPBhLO0-KSiCBgm>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6A70A1EA0066; Wed, 27 Aug 2025 16:26:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAZOnxJ1Pc8V
Date: Wed, 27 Aug 2025 22:25:49 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Rune Philosof" <rp@abtion.com>, git@vger.kernel.org
Message-Id: <dc0651fb-4059-41a7-817a-a68c8736ec70@app.fastmail.com>
In-Reply-To: <xmqqwm6o1zab.fsf@gitster.g>
References: 
 <CAL8J5gbKu7qB8Byg82CGqtrYK0gm4gf5V=qrc7npzAoF+kAXJA@mail.gmail.com>
 <a0c393df-a23c-49e0-8985-4748e1769a62@app.fastmail.com>
 <xmqqwm6o1zab.fsf@gitster.g>
Subject: Re: Feature Request: Add comments to commits
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025, at 18:53, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> On Wed, Aug 27, 2025, at 12:29, Rune Philosof wrote:
>>> Git commit messages quality is very important when you investigate y=
our history.
>>> Often it would be useful to be able to attach comments to commits
>>> messages for instance to add forgotten information.
>>> Those comments should be shown when `git show`ing a commit.
>>> Could be implemented as commits that use a new field to link to the
>>> commit they should be shown with, along with some index to make it
>>> performant.
>>
>> git-notes(1)
>
> ... together with "git log --notes[=3D<ref>]".

I think that=E2=80=99s covered well enough by the man page. ;)

--=20
Kristoffer Haugsbakk
