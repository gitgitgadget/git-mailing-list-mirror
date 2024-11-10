Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A43F9DA
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731225614; cv=none; b=BT+E8Dhznhq2u2AYCY+Ira4DXzeic0TZbsVXsuZ3FiSzVTBOl4VSNAgwLCdO7yfNajTGNQsVy65Y7EKqdmzNLCWNgnMUEG+vEzwIKrBO4CRsHfghNQsLYYE7XM9+vKWVHU5yK9Yvwur/HotoJ/zYryVa39btunzoUc17izWiMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731225614; c=relaxed/simple;
	bh=AUrFUE0KHHHFApEIRi/NGvk98q2K+JpYMeG3Drn7ubo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GJgvDFEMiySxpJx4aIkemEIFQP/zUGRSsEqqMbU3m6nyzU7JmpYwMWn+v+SqMIJGqZ3UT3k5B4H3trKGiDVnQfjnwyQVKD/sdHEnnEzpujETDU5DCjyzmUrXo0HwJzovwp9+5wnQzn2oEqKt71m5SRSSCcxwXU+w/MsE+OF6eOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jiCO1xsv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OEOHY0vR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jiCO1xsv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OEOHY0vR"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 700951380256;
	Sun, 10 Nov 2024 03:00:10 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 10 Nov 2024 03:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731225610;
	 x=1731312010; bh=o+G+gcBwDy0z05j8ewZ4UZw0nAnz58embZdUa4y8ZjQ=; b=
	jiCO1xsv+Dm3qgXLBA24/Dt00e7w5ub9YWbqVG5RJUs7cMihXGm8LwilLbZAV1Ux
	e8U7zXVhBTuCgxzYQ+4JqE7Duk0eRn1/9wLiaTY4ABZSeV6IF4KsxQ60XMUcgTRA
	lIkKBrBHSKo3EQi3m2ydo7h4QOC/8sDkUnxDxlnJXk5zolp5G3/dF+Ya4proP8aX
	gdzyL7bXhdzZVVHUbUkhcQJsru9D7gI+hMkk2QoMTntsH6QB3gYh7tIXZJ5mezu0
	raNJWVJWDbm+2a6gd+Da/5T73+KfnYloxy861NjRXe4x6ufkehRYkPbQkJiXXxJ5
	YgN8qtrTdnKfXA2LDQld6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731225610; x=
	1731312010; bh=o+G+gcBwDy0z05j8ewZ4UZw0nAnz58embZdUa4y8ZjQ=; b=O
	EOHY0vRx2GiQA7WD7Px5ck013teL9uO6Ma3SR8mr9JuHinMTB7BCW9Ooh3oy/DPw
	kTyMZpYXb2TLEocdWLa0qpBzHlf+z8q5joTk/TSnbRoC23iYnwbZwfaJEiVv27l7
	RG96S/PEQ78jPqT5BKUcDYKrLNJ2yrGDhEjLFscjzDvILWefU0nR8EHm13pskVoZ
	+vKM0dsJpvdrjtosTYfetX5BsFmyXUM5kfQOyzK4rShzdmYN/Pn5bHcQnMw85mzW
	6oHYSe3B3nZ6bkKT/hLVfXGSx1Rsp7dnFxGEeYaXDMNOlbiYVBHYpBtroEDWHVks
	Kulv6W0jwNus8YjdHxnXg==
X-ME-Sender: <xms:CWgwZ2nlPZraSroKRIIH-uS-wCvGvtCZJ4OILMl8wpQSqFZdQ-DUEUc>
    <xme:CWgwZ90fORsuivAjGMum8_yT0EzzB69Rm_7R-TDaFGYgqLvcD4NU6yZJICoGtF9PU
    v4yODI2Pi7lbycnpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdelgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmtggvphhl
    segtvghplhdrvghupdhrtghpthhtohepmhgrrhhtihhnihhmrhgvvdehsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CWgwZ0p3D-cbv8b-xlcnrZepmFeP77ppjiSfCqPxUBeG49EPQoLGeg>
    <xmx:CWgwZ6my3a9T4LTj06owdEgEnl1yLmwPVqruTYG2lx_-Kalh7GiI2A>
    <xmx:CWgwZ02s-I3M7IOfq_fnefWrWw5nFBmCHuMcfKgQVPOX0nTRH4XxwQ>
    <xmx:CWgwZxsnkfvUjVMjE3cTy8LCqHFluBB-HhxEgmeQdbN9ExvorN9aNg>
    <xmx:CmgwZyAW_jaUgn1CS_BJCqvhbn2HMSABsrJ7sNwRaaUbYTORCqLuBufe>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 96151780068; Sun, 10 Nov 2024 03:00:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 10 Nov 2024 08:59:48 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Martin Imre" <martinimre25@gmail.com>,
 =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
Cc: git@vger.kernel.org
Message-Id: <7c1cb2ca-308f-482c-aaac-5ca30b47da2b@app.fastmail.com>
In-Reply-To: 
 <CABg7He0upi8kmagGO13UMwSWOLeHoryZQU5CGsfbhgqedBKw=Q@mail.gmail.com>
References: 
 <CABg7He2asYQbdRvSvfh1YZ2FRPchVfvta8yBv4PFdVNnhzX6Ow@mail.gmail.com>
 <D5HQH12Y4SWF.2W70SKEDB7HBF@cepl.eu>
 <debabf92-7d23-4d17-bb0e-36691c94430a@app.fastmail.com>
 <D5HWL26B3HOT.1ZVXUC37BCGL@cepl.eu>
 <CABg7He0upi8kmagGO13UMwSWOLeHoryZQU5CGsfbhgqedBKw=Q@mail.gmail.com>
Subject: Re: Feature Request: Interactively pick fixup revision
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024, at 08:55, Martin Imre wrote:
> Also, out of curiosity, how do they achieve their binaries to be
> called as git commands, ie, why can I call the binary `git-fixup` via
> `git fixup`?

They don=E2=80=99t do anything special.  Any script or binary that you d=
efine
yourself will be treated the same.  `git` takes care of it.
