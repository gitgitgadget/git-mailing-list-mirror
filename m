Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A284E1C
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141257; cv=none; b=UsW4Ic1et38OOYuxnZRySUAy2DLc+2XY6Xnh/IizhJRk8Zvtexg3wr0X3IMEKm6epSLNDXm3WEdyL8dUS+P8YjnZU7qCRiEOSTYGEXZnkqcl+KLiIIxUH4EKTC+V6hpM/7ofOBiFf8wNbZL38pXb9kILXJcYR66ZFX9tgIrrUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141257; c=relaxed/simple;
	bh=DDSAQ+xWUw0TYM3tCdt4YJgfFzFCWpsw4cnICk8hvOc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dRHVs47qgAga0VA9UMiS01zo2boI4fhHBaWeUpO45RAki3L5069789CldlkPBwjTmIlMjF6lwjKSbCVRcCLfOanFipJiasp8axix6cN6gtQEvsUdaeQw7+69cEAuOfcwPJcmS9yyHzAkZfxRLmWtu3R2RKPu2wk34LcDJHcb/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ls+DPXrH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NBhqCMFS; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ls+DPXrH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NBhqCMFS"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4706E2540106;
	Thu,  5 Jun 2025 12:34:13 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 05 Jun 2025 12:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749141253;
	 x=1749227653; bh=DDSAQ+xWUw0TYM3tCdt4YJgfFzFCWpsw4cnICk8hvOc=; b=
	ls+DPXrHjMWLjaLZFKTSKT7J623Qu/fg1mIvU/628uaWuD+pXxR03Gjo97hnvxq0
	mc9/w+waGf+SnykhewjGMmCT4oJ3UHb1hHCsL6uGYNPz0oko2c677NWLkXWAQJpb
	V4t78GREK/xvmLx0Hz4xLb+hSZ/I/lw7owHKVE8EOioTkgSe3p0ZQ0FEUw59ZMnv
	Ma+JYDzeJjjnbP4Ma6qfun7rYIrOu42PCIb4e17rpGEEU7yaZXWEUSoH2FUmU5DN
	1p4zRKq8YCH6eci2Yj+GaVfMPcO7nkF5BMt56rmVylGnYXRO5UbbTvI6OV1XkSs6
	bTZGeRxkRsiEnhmrsnnIHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1749141253; x=1749227653; bh=D
	DSAQ+xWUw0TYM3tCdt4YJgfFzFCWpsw4cnICk8hvOc=; b=NBhqCMFSfCdiyFcZy
	PnN86JE1P7GB1ZOgEAS8GzuVwF3Vsjr8l1fbR0efpueg/AxpA0S0qKQSi9VKr80o
	1v+9ctYr4r3v7xQcr/J95cEp1ThI6fELs1TGJgypX5cdDNAOJnXoTUBdy/VdT0gu
	ranU4Sw1H6YRIDrysvEIlxO+jf61c5UJz8Q8peySswwtrwh4NWE/8q5Dpa+83uAY
	Q2V8ebU64IqpKT+xacn7f7TlcWTruTgbvjPuRNzaF9S1qdgUaHlXvu5opohuKAc2
	NGhmVMiYi7OKp5oY+10qMlPlWdVEU9YTW7aHQFbXdgd+dm07UKJM1aeur64tEBco
	MmmZQ==
X-ME-Sender: <xms:BMdBaPTWuJI-G5A0goS10fkTrRxpV0W3LUu6jF-EUdJHztX63h6V5rQ>
    <xme:BMdBaAzauJJYNssVLtYpn_vdNiml0QLbJy0-Ye6NS8GFSgEfTVu4hEx2kxpuHnhAv
    -ITCJINCyhQwWpwpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeejvdfhjedvgfevhfdvjeefleelteffgfeuhfeihfeuuedvfeevteekteeugf
    ehtdenucffohhmrghinhepghhithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgsihhrlhesthgvmhhplhgvrdgvughupdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BMdBaE33C--bdhhIC4UmhfoZgihLEoArZ1ko_5s6QKME44N9f7M2Dg>
    <xmx:BMdBaPDlJo4Op-z024tEXbMtwl1Zpuz8PitnmQ4WsfksGECppfbFOA>
    <xmx:BMdBaIhLqc7OUjsHDuOnjWDsjdt_MQEOcc-2Ks8OPgZLQcoqkNbZkA>
    <xmx:BMdBaDr1Nyp802_fJ4cXu63eeOSztT2XL-ZyKljrmtVjJ6mSUBFdhg>
    <xmx:BcdBaB2xc55WyZPfsOc_FmxcZBL3zVKRJQ9LASWevXWm6Gmw7Q1YvVNU>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D4CCD1EA0061; Thu,  5 Jun 2025 12:34:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tfd188fe2d88815e3
Date: Thu, 05 Jun 2025 18:33:41 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Scott Birl (Temple Univ)" <sbirl@temple.edu>,
 "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-Id: <d2829090-de29-466f-b17a-734c5e8bf59a@app.fastmail.com>
In-Reply-To: 
 <MW3PR11MB47638E3211C195DC1C032DB9C36FA@MW3PR11MB4763.namprd11.prod.outlook.com>
References: 
 <MW3PR11MB47638E3211C195DC1C032DB9C36FA@MW3PR11MB4763.namprd11.prod.outlook.com>
Subject: Re: "git config get" returns "error: key does not contain a section: get"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025, at 18:16, Scott Birl (Temple Univ) wrote:
> Hello all:
>
> Debian 12/bookworm -- git is already the newest version (1:2.39.5-0+de=
b12u2).
> Trying out examples from https://git-scm.com/docs/git-config.html#EXAM=
PLES

That looks like Git 2.39.0.

> [...]
> $ git config get core.filemode
>
> error: key does not contain a section: get

`git config get` is from Git 2.46.0.

I get the same error on 2.40.0.

You need `git config --get`. That=E2=80=99s the old syntax.
