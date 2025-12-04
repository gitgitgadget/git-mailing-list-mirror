Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95DC329E7F
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836686; cv=none; b=hSPC6V+k6AKS8GC02IAm2wFJKvgifDUm1J3XThrT3cGhJEatj4cJuv/IOzfefa5uSZohnD59Xh1YVJdfauAajQZ/FmxuRQs+ZBrIgxNPXeL4yvqgmHPrR/Qm54t7PJGQe3MdOiaAYZRXyrmsMsG667FG8s2ywOxcr7qCuczhmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836686; c=relaxed/simple;
	bh=210UmzBNQBogZFznTBOoEGZsTxIxcv6nXdrkO20y3xU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jDb/g0gpxIgk6Wqgerf0jqa7IWpmXmb9/5JRN6D20sc10l11TNR+r0vZwpYW90KAR+6rviHF5SnAzpHuQjWGsWn/9aLuxX67F2HiJTXGYQ+nGOXbHIeSB8iRrKA8ku1pLKzLO1c0Q86wjqcMWbsLvaiSJ/AYzZEKniYK3lWgAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KUrYWK61; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GmBwiSs3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KUrYWK61";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GmBwiSs3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23B617A01C4;
	Thu,  4 Dec 2025 03:24:44 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 04 Dec 2025 03:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764836684;
	 x=1764923084; bh=210UmzBNQBogZFznTBOoEGZsTxIxcv6nXdrkO20y3xU=; b=
	KUrYWK61qJK+L4rCkpbt5FiWn5DbCzRa1Fh0fmak2reNMHLt+h/8qnAS2/WQTA1A
	y9BsWp4Im2anCIasQABcicmQM4O0INGIfA0zkDh1lMFH5Qn9M91neOrRahqLDaUA
	pVOAWmzFyx3SKilHNLWT8tSn/jLGG7WNShWXyhCvtOrjQmyAzhO+YHGE/N+P8ApE
	x9jxBo/5PKpOYYTX7fvyFUH/iraLUOI8WN2ZxTdraeu+PtpfRqN/xWb54bEJ1Lbt
	Lt/N2yVlW+0XeRxNNDbRVqpQUGbwMZrqaHDNSH3zX3740vetlH3rst0yPKaMgq2T
	z96I8+NdXc4mEXAZlWsCiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764836684; x=
	1764923084; bh=210UmzBNQBogZFznTBOoEGZsTxIxcv6nXdrkO20y3xU=; b=G
	mBwiSs3e+MdWQlNFr4QM2dYCn080mxErsrJCBRTNOm6xZxvrmqEvU8rSi0Dp8DWw
	fgmtMaivO3wrsgL7qgP7qoCCaPHNCs8LR22TABc4uQS5/V8DKkWjSMSw5imOQh9d
	uxElv7n9cTT6+9fT0XeXkLJ3vgnRvBpUnIsALfatmSIRPyVG8GH3OdbjqPMizw8W
	K4XeTTigyP+5q8o6+0WX7kK7Q0qGhLIULGsRE5aTO/rhomarsGT9MwBJZlpyjKvP
	cuMS9D0ojqFNaCrilHqnEIGKA7GPapF6PNbSygBHOMeYS7Oga6nxVF0kuf3ppAhC
	cWqNRueaBwP2exc+Cmp+w==
X-ME-Sender: <xms:S0Uxae68baCwDLtJ_NUz0A0IMNJQ37VrNVKHekhejz7cw3Hu-bczG-E>
    <xme:S0UxaSsZblH0tA6wZRizDU2opbHuwEUeSy8xziWjqYkGxB2hZZea4anGUSB0jS0_G
    b19vLhq2pntJ97kIAvXi0zM5TuqAJma0MFYahTyKNPAJAX3EtaBQZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfei
    gfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtsghovghgihesfigvsgdr
    uggv
X-ME-Proxy: <xmx:S0UxaZk7eW55ZCrSn1AVHzS6dgFaQ_Q8DW1rQFyOsTmW4cCU2YBq2g>
    <xmx:S0UxaSwfELwXkpoLgL6Y2tWWQFwmDjZNuquNAN14_2H_Db_8qcNu3w>
    <xmx:S0UxaXNLNV1Wx0khf0dZ1MUJ0xK68xxw6-nGtTIIz_Ddi373avMgqg>
    <xmx:S0UxaWRdFndAMKJ82Vn90N5_W0IhaamomrlayIRN47F6RY-p0vgeHg>
    <xmx:TEUxaRf9BxFerfIdtMu2Akr2GMYR3s9jZ0qnmIFWIS6mvLKfUsr_c9FK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D35FC1EA0066; Thu,  4 Dec 2025 03:24:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8kjccYucspB
Date: Thu, 04 Dec 2025 09:24:13 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org
Message-Id: <c3aeed96-01e2-4572-80a8-a9eef0cd1315@app.fastmail.com>
In-Reply-To: <20251203195424.GB13919@tb-raspi4>
References: <03643900-db0b-48b7-93a7-4d96632af57c@app.fastmail.com>
 <20251203195424.GB13919@tb-raspi4>
Subject: Re: diff: should warn about EOL when --no-index ?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025, at 20:54, Torsten B=C3=B6gershausen wrote:
> On Wed, Dec 03, 2025 at 05:26:49PM +0100, Kristoffer Haugsbakk wrote:
>>[[snip]
>>=20
>
> Not being an expert in `git diff --no-index`:
> It seems as if Git reads the .gitconfig and possible .gitattributes he=
re ?

Yes it has to do with my config or defaults. That doesn=E2=80=99t matter=
 to
the question.

> Or what exact setup do yoe use, what is the value for
> core.autocrlf
> and do you have a .gitattributes file ?
> Thinking about it: The warning may be not needed.
> On the other hand: It seems as if something in your repo is
> not as it should be ?

It=E2=80=99s outside a Git repo.

> Because the repo should be normalized ?
> And if it was, there would be no warning ?
>
> What does
> git ls-files --eol
> give you ?
>
> More information is welcome

The warning could be about normalizing the other way for that
matter. I=E2=80=99m asking whether the warning should be there in this c=
ase.

I certainly don=E2=80=99t want to subject people to iteratively guess wh=
at=20
my config is like.
