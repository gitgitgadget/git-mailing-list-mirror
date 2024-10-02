Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B361CF2B6
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872797; cv=none; b=ememipx0eX2zrR4fvQP3E9Pz0zOvvxprJZ99M3b7L27fDhqTfEzmm6q5Io8XnrHuH+66WKfdvVvmAuAd7MDm59SD8uwsbjraZZLSKOfuvzMfvkMBk3VgylR9vTkYucxK+r/XzUDp5rreb+Gm7YCt4Od92OLDjA+O7jodyQjcmxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872797; c=relaxed/simple;
	bh=FT+4vS1PFixO/VaszLk0YJye0PG4U9VLD1aUBR7BmCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxHSIsXrlfcPiFzYHJ9hvCsDldwsGNji/STciZOCiRGaf329gkSGBwPKG32gBiWhX1T+W+SYixzEHiZCEpM+V7awtNdYWAQYZ8++lruUbRQwp/QRTwleAfvsNX7Mh6m8o8iXrd5RVmAnBcvJuyc4ZbbrgOGzLCwz+WulT0rb6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D2lzS3Gv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BynFgPCr; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D2lzS3Gv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BynFgPCr"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 46A4A1140123;
	Wed,  2 Oct 2024 08:39:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 02 Oct 2024 08:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727872794; x=1727959194; bh=FT+4vS1PFi
	xO/VaszLk0YJye0PG4U9VLD1aUBR7BmCA=; b=D2lzS3GvlbDyr08WFOo97lJFFZ
	/Mj7JN6Vt2GHF7Mi50PwUlf8Bx17odDZcmvUdtC4tuk/JNAt9BvPjX4wsD8afO/K
	NBZG7nL+CXje1KAgZCULTYPINTo4iZRTuy5Atvv+PdtSvXCcIddRBQTSdJLP/QXE
	MDqCtFGFW//UQEl5ovmkJPVJ2vfA3aBbSaH6GpWekJMiluCGxSFiQKOr2gwFe1OX
	ZLUeK58bSzs9ElpHxq8l8QyP2OAH9AvO8L+Xh+08Px/969QMmnlpeuhYDnoVrapX
	vzUUC+98YwxLuApJUiBk87AnELihJfRxihll7wSd/dCCTRkQELB2J2x9ZC0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727872794; x=1727959194; bh=FT+4vS1PFixO/VaszLk0YJye0PG4
	U9VLD1aUBR7BmCA=; b=BynFgPCrIm6qUEzZ5hgFcoVOlBpJ2KRBkO3cJ78NKkID
	duIEadnpgSrSrToFAoKkTkx7GD1uexzv8Zr0ZsF7vqD8VlK/5zkIXdUcwJohsnSX
	tpCmIP1wSvsInna/jMGUXB5vMmOzc3/jWcgNlDx3TBsyr4BlnwruBcu2KBsu2bBC
	T5FBEX434cxkHmuFkMpBJNWpBn8eqHN+mkNeabpIFvwEE4xQyA6H8AkWlB7Ya8XV
	h1b8wpg/R9Z5xnD4dw5SWxk2jT6H26HU7EoY7ah6ISvwAXJfsclu3lKPz1Bighxe
	ONQvmanFIY1GY7eK61nVoJspriWFUaBEFfmLz53D2Q==
X-ME-Sender: <xms:Gj_9ZkOZ3pRMPyM9FGj6tN3oxxbljUjV6Nzlyx73KISn-huhn2RdJA>
    <xme:Gj_9Zq-PMwyZ0JEDHMx21srrfDsLzWV1iN8ecoYDc3wHillfXyn_MFK6lZGfjB6Vy
    NZPODVwFnTfMOu-GA>
X-ME-Received: <xmr:Gj_9ZrS_v7PA6_dx6Al6Zq2yo1DX_SRE3WeMMEnzTE0ol33JTWEWS_wEtOPM5fRI60uFr3cq_IBJYkvu8OnvCLCt6E7PrIfwOz6lXx6ci0z0SSoh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuuf
    htvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvefh
    ffejvdffkeevtdegudelledtvdekudeivdffgfdukeehkeffudfhgeduiefgnecuffhomh
    grihhnpehgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepnhhjohhkohhmrghlrghinhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Gj_9ZsvDs-WrTGPaDaqGlc_4F6WDb6PbTUUgoPRaKPBpAXBVhZorfQ>
    <xmx:Gj_9ZseD2hQNr3GH6W0YoObD96xrHBSP1Tz8A5_DjHzrFQgM9mPNPw>
    <xmx:Gj_9Zg2CycEPa4JXfOErpZarLs4oUQYj5sNLYid9V9LgFcGtdquTeQ>
    <xmx:Gj_9Zg-fPSqc9qZlFQTNaenqmeYuKwB2xd5hdSB-O0xFJzcFoE6EdA>
    <xmx:Gj_9Ztqikclampba29VGyo4bo6qtkRLrBubCw-8FgRelczW2oYe8toYu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 08:39:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09f64350 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 12:39:02 +0000 (UTC)
Date: Wed, 2 Oct 2024 14:39:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: N Alain Jr <njokomalain@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Outreachy]
Message-ID: <Zv0_FJVhnkkUKCS8@pks.im>
References: <CAECe19JKjsASasm4bxvsYxezj0L5_z=H=3VJ9CXzwdBCezRc+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAECe19JKjsASasm4bxvsYxezj0L5_z=H=3VJ9CXzwdBCezRc+w@mail.gmail.com>

On Tue, Oct 01, 2024 at 10:54:44PM +0100, N Alain Jr wrote:
> Hello.
> I'm Alain, an outreachy Intern. I am very excited about the prospect
> of contributing to this project for Outreach 2024

Hi Alain,

happy to hear that you are interested in contributing to Git as part of
the Outreachy projet. To help us mentors, could you please clarify which
of the two approved projects you are interested in?

Other than that I would strongly recommend reading through [1] and [2],
if you haven't already done so. They should give you some ideas for how
the Outreachy application process is designed to work in the Git project
and lays out the expectation of us mentors.

Let me know in case you have any additional questions!

Patrick

[1]: https://git.github.io/Mentoring-Program-Guide/
[2]: https://git.github.io/General-Microproject-Information/
