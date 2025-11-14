Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D672F6195
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763106097; cv=none; b=aRUDju2YbUe6WUZ2EIbJPkK//2fIam+CY1MCHgWWyEvkVrwNo0GkW4acjEH48+gaNlnaCPqJHAi2G44Ol2yeJmhcI0koroQgW+NBSekwfpNbuqEzWsI2/tBi1+PuogDuy0jikiouguC12ov2jxeqmkhC7sufXeQrHMP2nRB+JGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763106097; c=relaxed/simple;
	bh=b7Ozhei6o0UOSEjO0IEhigwGC6RNcdyQfGWhIu+MKj0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=On9pxsYrfVMYOwfSuFeVuh9V6X4nY0tUJK0DeW8dSw5CsFEB96yfmYPy4T/oS6zA5fequ7U6AFLM6DqwDI9sr00wMz55hkxez261YIe49x+O57QdPqNdFvRfQJhxx3VEdezyrbGMmGeegIqFClHItjRJixXDmQjB6o8TYOQ/m5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PT4Z7smj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gBs8nT6X; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PT4Z7smj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBs8nT6X"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 928317A01A0;
	Fri, 14 Nov 2025 02:41:34 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 14 Nov 2025 02:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763106094;
	 x=1763192494; bh=5FL59GiUg00ow9Djqxz9GfZJ+PetjzuoJAK7W0PxtCA=; b=
	PT4Z7smjLRGosytyFiJNPoW/YucsPJFe1whBUlptuxiswQlaD2P9kmRFcYUBIVxf
	XKVL9Q/C34xCpnJidZ89S1YViFUQkEB669B2SKTF5/5/+lnp0IJMsK9tnQ+BQrfL
	uSpMm2kMlX+/4OZEcTYv0/YexIrmXUA9bFk1nrKyzXG10VM2G3LWxgmSCSk1TToh
	hHR4MW0fBe+w1TXvn2KdR6OM1b8xI3jxgqKZrD1ib4VFXjWAsl1CIwLRYQLilZJt
	K3DXgcBwj1IvVsD2UYF31qDTYbys/W2CoKnB5CjMt4JXKmOIbWQEo15zOAP3RKj8
	ccdY0olBH6iIXqWk6O0tzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763106094; x=
	1763192494; bh=5FL59GiUg00ow9Djqxz9GfZJ+PetjzuoJAK7W0PxtCA=; b=g
	Bs8nT6XomQH4gll7K/qki/YHmyUoBZi2eXB+imjQ8ApGr19pwIAnHSJu9ZCLFOfm
	Mjqyrk99VDTfCgaR6pAcNY0raHRhzEM63DnXkTa5MyGlOvYCNLM+x7DxYbGxESCG
	yJOAMhkEQ/qsNy7/vWGOy8nRDRSIKWyzaqmpE9PlmCrlpUXSm20JjgFyWRnFjj//
	omzCoZZIKJoq8a6jwBJ1mSqxTGTIMN72VtdpgfZlwrf7ABwLnHmUOLlE0uN68UMj
	MFhsBCaZ5ArP7jlVJcF/VZQfvr54q7MzMgwjNmLZdwzNDLEThM2pvELBdWkdGw8l
	IYyZa1cKtyxcHzna0jFDQ==
X-ME-Sender: <xms:Ld0WaRyvQZRPfVLggISKoQVX64ogtQb6h1ivANn6l9FGkW5oTXY7sbM>
    <xme:Ld0WacGKqbQB1kvHBF4GLEgQo_BgG0t2Jjq7irGQzBbNdbE5Qj1TMjngmaYzx5HaB
    KkmnIWFTEmQ_eVvij2JUDE7GMwN4nVQPR15Oj6KLX9VZlIkOOWuBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepieehgfejtdej
    feegieeftdeihfekfeeuhfevkeejieekteduhffhtdduveekueevnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghrkhestghhohdrrhgvugdprhgtphhtthhopehjnh
    drrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegsrghgrghsughothhmvgesghhm
    rghilhdrtghomhdprhgtphhtthhopeguhihrohhnvghtvghnghesghhmrghilhdrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehm
    ihhkvghlrdhfohhrtggruggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfigtoh
    hmvghrmhhinhgvtghrrghfthesghhmrghilhdrtghomhdprhgtphhtthhopehprghnleef
    geduvdesghhmrghilhdrtghomhdprhgtphhtthhopehrrghlfhdrthhhihgvlhhofiesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:Ld0WaZoPLNlMUoAjn2WAWJVqU-fA_rAfMlWo5TJtGgrvLNskp_DxNg>
    <xmx:Ld0WaXeIEBDivHecSxtN0i-UwV1jXIsSaVryW-1dfB3iVe1AIu552g>
    <xmx:Ld0WabtC35B6iCNTDV_-8kzmWm_YRgBd1RcmTVu_P0WsImGLOT7eOA>
    <xmx:Ld0WaXWHY2mi31NfhZ2jRZQV6L-7UZCyQUTUow_2us1BHcX5Cq8l2Q>
    <xmx:Lt0WaX5LpSQziktHqv1THKgqKCfxIIHTZOhL4VokRJXk2fukAJXj_LFw>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6CC331EA0062; Fri, 14 Nov 2025 02:41:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5ssN9b_EXxs
Date: Fri, 14 Nov 2025 08:41:13 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jiang Xin" <worldhello.net@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Git List" <git@vger.kernel.org>,
 "Justin Tobler" <jltobler@gmail.com>
Cc: "Alexander Shopov" <ash@kambanaria.org>,
 "Mikel Forcada" <mikel.forcada@gmail.com>,
 "Ralf Thielow" <ralf.thielow@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Bagas Sanjaya" <bagasdotme@gmail.com>,
 "Dimitriy Ryazantcev" <DJm00n@mail.ru>,
 "Peter Krefting" <peter@softwolves.pp.se>, "Emir SARI" <bitigchi@me.com>,
 "Arkadii Yakovets" <ark@cho.red>,
 =?UTF-8?Q?V=C5=A9_Ti=E1=BA=BFn_H=C6=B0ng?= <newcomerminecraft@gmail.com>,
 "Teng Long" <dyroneteng@gmail.com>, "Yi-Jyun Pan" <pan93412@gmail.com>
Message-Id: <8cb5d668-783f-4400-89b4-35054a6cbea0@app.fastmail.com>
In-Reply-To: <cover.1763098804.git.worldhello.net@gmail.com>
References: <cover.1763098804.git.worldhello.net@gmail.com>
Subject: Re: [PATCH 0/2] Fix misaligned output of git repo structure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 14, 2025, at 06:52, Jiang Xin wrote:
> While localizing Git 2.52.0, I noticed that the output table from git
> repo structure becomes misaligned when displaying UTF-8 characters. For
> example:
>
>[snip]
>
> BTW, I used two AI coding tools (Claude Code and Gemini-CLI) to generate
> the commits, and added the "Co-developed-by" trailers in the commit
> messages by using one of my opensource project:

Is `Co-developed-by` supposed to have a different meaning than the more
common `Co-authored-by`?

https://lore.kernel.org/git/xmqq1pq7re7q.fsf@gitster.g/

>
>  - https://github.com/ai-coding-workshop/commit-msg
>
>
> ## Changes
>
>[snip]
