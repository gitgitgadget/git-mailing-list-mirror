Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A121CF8D
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432713; cv=none; b=svtsDuiODknEn6ilQ1HjFeIXjBZSvujJbbvA/a3Bpa4UcqaKfzAwaGrwV4SXcovaAmxVTqd8KPSvkTewZOBVCwm6Fe9/VhNXfnfQcSf6R+uv/LviVWGd/M5JIREXSq8DnDkiP+plCM4veTDJ+jLZ2MgweiT0jzwMYXwPPY8x96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432713; c=relaxed/simple;
	bh=E9+8liXGCKobH2SK99wOAMxf56wCWYmgN1KI8nsTLFU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aC8aD/72dBU63zjm8faHrxtCzG4+wJGqjml8tF86ILwAbPD1W1Zj/Onh9D85CdnmQYqxnGsNsTDVFEcm1GhqnIeLfqr8HGzHWSDfjh4PhihWpBRTmHnUSdPxV98WqNiVFXNLPw7Ymmcvu5Y/r0EwPT5Zxhmvcpdjf+P3EaCMpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=taCP9tC7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k6f1Swek; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="taCP9tC7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k6f1Swek"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 79A321140149;
	Tue, 12 Nov 2024 12:31:50 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 12:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731432710;
	 x=1731519110; bh=B2tzZheDMUMFujW8jgR0Wh+KlaBW1zoMsgk3v2ns/8k=; b=
	taCP9tC7u6Oiemp50bNEcb7u0yBfJinunr5tSBX16ArrtylsjxbArvomiZ2TtmTP
	w8VYPzDYHMvAk1+IF5A5nyMRGRA7uF/GBeCds9oelZ9MyEL/iCJIpIuQ92ilPtrn
	XKomV77bdG1DhtMVAEkEWX0SCfifCSUVwoCIOEAmu/4XgFCb6rxluv+BPWGJDfTC
	Ul4OXdccHD5fwoqriQPCrIMv3kFson+yCkY+9ftUEwbZlmNYa1o3cNGizW+prwi7
	HQkeXg1L+Q2EM45OgmwDVTiAU0O3vHvt+s2B8pZLUoDr9ZUp3MiK8gCAfpWDB2Qw
	TTokHT9FyfQQ9ygt22xIhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731432710; x=
	1731519110; bh=B2tzZheDMUMFujW8jgR0Wh+KlaBW1zoMsgk3v2ns/8k=; b=k
	6f1Swek4hl3utzHFLEPCD2zf9MqzFggEFZXtY6IsZ9mJgwW8TMoNJkE2ISvQVlG3
	8gVUZzyxmDAZ5FB8SfeFJxgLLxffrecO4NaeGPaRO2fQcMoFmlJ1XTLhW1DiyXAj
	OQtVTCZbg0AVVHQc6Ejb6j0EnOKLCgThqaVVDQDtWQsa5KG5R7Rv5/XinSOQTTlA
	HTUi8Ibek8sQhBtrzLAf2opZJDnXHyMxK6Na2IaEudcpqYCylm6CextRK8fBCDMr
	4B+elQwn4+n2RZtthnxTbz6eZJNzlTszGnQ379P23ewkV5AZEW3X7uKceGYVA6g6
	bBksqzuw+1y0xt7S0UVbA==
X-ME-Sender: <xms:BpEzZ41O8w5Vb74JIpekMsiOyFAC2k-jrCKAQWwbbUlO_7WJQqBLhsk>
    <xme:BpEzZzE8He6FhmQNy_BW_SngIZq71dbscVikdCHTMWBaKHWByIXpnnb1WEbi0CoH0
    htoPXsLSNSwuckusQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    evkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeek
    leeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BpEzZw7_EpmwNKtF0SD-Hjoa1mNEYkJ8UDb0fQBB5yHLyaP24ZfuHg>
    <xmx:BpEzZx2ZCMiH7cpgkSHZMwCmNWY8nMOIBKNu7DmBA62ZrrFkQuJKcw>
    <xmx:BpEzZ7EDOW6CZ_YijySgnJiy0AquEpQTO5FzEZMfxZx11eq6DNgcGw>
    <xmx:BpEzZ680qo0NtuqmwWvDTNnew8fSEUSOEeQevtJtWLohAQ_NkI6X3Q>
    <xmx:BpEzZ_ig8G7iXYJIM1SwZ12MSle9S5J7YoUGrMGR0Y6J9bLsv_tV3gQ6>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1FB97780068; Tue, 12 Nov 2024 12:31:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Nov 2024 18:31:28 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
Message-Id: <aeb7acb2-792d-4ec5-bcdf-da2eceb49c4e@app.fastmail.com>
In-Reply-To: <d9b1dac0-5b30-47c8-af47-190f4ed96748@app.fastmail.com>
References: <cover.1730234365.git.code@khaugsbakk.name>
 <cover.1730979849.git.code@khaugsbakk.name>
 <b222c6787a79c852442969721dadc629ca84cd5b.1730979849.git.code@khaugsbakk.name>
 <xmqq1pzmqy97.fsf@gitster.g>
 <d9b1dac0-5b30-47c8-af47-190f4ed96748@app.fastmail.com>
Subject: Re: [PATCH v3 1/4] Documentation/git-bundle.txt: mention full backup example
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024, at 20:38, Kristoffer Haugsbakk wrote:
> On Fri, Nov 8, 2024, at 03:01, Junio C Hamano wrote:
>>> +First let's consider a full backup of the repository.  The following
>>> +command will take a full backup of the repository in the sense that=
 all
>>> +refs are included in the bundle (except `refs/stash`, i.e. the stas=
h):
>>
>> Are you sure the "except" part is factually correct?

Okay now I get it.  Your git-ls-remote(1) example is correct.  But I did
something like:

```
git clone backup.pack ./repo
```

And `clone` will not transfer `refs/stash`.  It=E2=80=99s there but it d=
oesn=E2=80=99t
seem that convenient to get *out* with a porcelain like git-clone(1).
Maybe it=E2=80=99s possible but I kind of want to say =E2=80=9Cokay just=
 pop your
stashes and make regular commits/branches=E2=80=9D.

I=E2=80=99m not sure how to formulate that.  Seems clumsy:

     refs are included in the bundle (also `refs/stash` but that
     particular one won't be included in e.g. a clone):

Would it be too drastic to use a footnote?

--=20
Kristoffer Haugsbakk

