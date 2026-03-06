Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841F29BD9A
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772794592; cv=none; b=hAsFwIucU6zum9aadGhETQrIVTlipfUrDM1mLO0/q485MKTV9s7T2sef+0ASpg3HECZU46okFR00NdK0gs1jesIgEOmdTVOmGqe/mZpyxH7ls+fk5Q+UARo9j4yBwiWi26MdrXPZqrjdp9QE8ThhVchj15awmV4oUxwQU5+J0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772794592; c=relaxed/simple;
	bh=wRjxlWD1RRyghHi+KzwpgJtNCD/vRzsx1UuOQHSh0Es=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=I8ERH23LTpjSV7V2VlqS4J0jLxx7LSiXeDHcXaA3U71zrn7UdWW4iHFCqS+Y+qaTFRHgRf86VrtzvpFIWExy8lZpFdrlDwoRcbczSw6MLxbYLZHXrEBy6bxbSf2YEbm5D4ecXU6HqG3nXWAIjpvOsUUCYsRO0ERiaBD/bkdKKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TGFZFGbd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sZQeEzn/; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TGFZFGbd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sZQeEzn/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AEC8D1D001CA;
	Fri,  6 Mar 2026 05:56:29 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 06 Mar 2026 05:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772794589;
	 x=1772880989; bh=iZ1f498o8dD89/obUvUQy/iyUbGGlIqSvCvIjLoNsBY=; b=
	TGFZFGbdYL1YOSjukwYgoYVnoF8skhPECAqpmo+XNQkqiZS9TFQwrYFpXxQrC652
	a66wa1HokiaipNtq6uLax+dQPtm/PR20L93XsePppFwBXPGMTDa7tadR8zmxUrRw
	KjJw+aGbaGYflCp39C8hnhd12NYZPWxYpr7zbXcm2xnn3Eo/Cy19y3+TNY9je3k/
	IvF6jMppDEH/u/SH40zEYwrk4cdWk3JVI1IW+DNwPsnkh3rQ1a2P3witBV3TJB8G
	4FEkm3QpPR7utzYxcn2XzlZ7s4MlGRbEt/jZxy31XiGIQC+vxhc8dhdMQco8r8pJ
	E7xhaUY24cNLBu+FMtww2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772794589; x=
	1772880989; bh=iZ1f498o8dD89/obUvUQy/iyUbGGlIqSvCvIjLoNsBY=; b=s
	ZQeEzn/50bYzUwG0ydJ9tOFxHEeV7RRM5ZidMv+JX/CYsIaV61Dmqu1LWnGOTmeU
	lRTLM5SCxrvUf9lJ5AY89kaEpLRKjEHoGp6ndfeDFkZuBWpp2qQ2Xg8qBc+lyCRq
	ZimWy3M/3xTnDskv6fmtwnV2/OUMkLYtHhggzqJLeD7ax6kvjr2G3OoQceihU4xZ
	VOSqrXbh+ojuVS+Pokttb2aK/VYz37aEm0j13N9PnSwgOnEQ0tpyd7u+d44U8u2b
	Jyzw969h3w6xAlNOR/Q7JsF/Hv6g4fQCDwDACZ2bIlTnhtCShyZ/yjUUabKLyoHF
	eal4R6Q4WZwfBZ9SUJTYw==
X-ME-Sender: <xms:3bKqaXe4jZFVUXZUtpO521OfqSlEOZNvEWt93P6yOZvZZM_ZmwEbF1o>
    <xme:3bKqaYBIVWhUtrgKKD4RNSADXNtSoxyKFVPXN54_vfsZTP4uYJh__aqaWjDdxrZSD
    DUjtkgaocEL6Q7PIkMegalzjgmQZw96nKt1Lst0OwERhlvTeYI0Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeludduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3bKqadYnaiKT4GWVeeH86iBGwviDi4leSzZBCOUvm26kB-MlnBunXA>
    <xmx:3bKqacK9Dz1pmel8odtCQMvbpqh5ShcuDZIqwkDA5M2xQpILscKQaA>
    <xmx:3bKqaTCTabmPInkqkBZ8HemWMbdBH76uiSM7dSFVXACzgKfWt-nk-w>
    <xmx:3bKqaZpMAiehjE0NeeUhuxPhT-4EGwUZ7iiAUAG0WAAVYErVmJ_l3g>
    <xmx:3bKqaaVGEr_fgl7u3wlB3WzY-stotI8bTvGzPaA9NJwUQ8KwFtptxjTG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 32F861EA006B; Fri,  6 Mar 2026 05:56:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APO20d7PITeo
Date: Fri, 06 Mar 2026 11:56:08 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Justin Tobler" <jltobler@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <a61453ef-d3af-429e-8f2e-5a9ae3d47df7@app.fastmail.com>
In-Reply-To: <aaowCeEMjpztZpti@denethor>
References: <20260305193836.973122-1-jltobler@gmail.com>
 <be9cbba2-883a-4ef8-838e-0941b75eee6f@app.fastmail.com>
 <aaowCeEMjpztZpti@denethor>
Subject: Re: [PATCH] Documentation: extend guidance for submitting patches
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026, at 02:48, Justin Tobler wrote:
> On 26/03/05 11:27PM, Kristoffer Haugsbakk wrote:
>> On Thu, Mar 5, 2026, at 20:38, Justin Tobler wrote:
>> > +It is also a good idea to check whether your topic has been discus=
sed
>> > +previously on the mailing list,
>>
>> This is at the start of the document. =E2=80=9CThe mailing list=E2=80=
=9D footnote
>> (git-ml) does not get mentioned until line 535.
>>
>> Although there is the initial mention of `MyFirstContribution` which
>> prominently features the address at the start.
>
> We also mention "the list" several times in the surround bullet points
> prior to the footnote too. If we think it matters I can move the
> footnote up.

Yeah that can be solved separately also. :)

>> > or whether similar work is already in
>> > +progress.  Prior discussions may contain useful context, design
>> > +considerations, or earlier attempts at solving the same problem. B=
eing
>> > +aware of such discussions can help you avoid duplicating work and =
may
>> > +allow you to coordinate with other contributors working in the same
>> > +area.
>> > +
>>
>> This seems useful to cite. It seems less useful for people who go to =
the
>> effort of reading this file themselves. They presumably care enough to
>> try to get the procedural steps correct. It=E2=80=99s difficult to im=
agine that
>> they either think that their idea has to be unique or that there isn=E2=
=80=99t a
>> history.
>
> Ya, I agree that most folks who feel inclined to read this document
> proactively would likely also lookup previous/on-going mailing list
> discussions. I do think this would be useful though to include so we c=
an
> point contributors this direction when needed.

That sounds good to me.
