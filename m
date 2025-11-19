Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567711EB9E1
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569543; cv=none; b=IkJBN6evPJWfrSKagZv4PI2W+QPdX0SmfjBrkrWN1/yE5sn7QHhP4tZhji+6x2Pq2Xvrpqbv8hv9AU+nrZtsuz9hdYB+HR5z3RFgCLGLu+IwWkMwGg1xNoSxmlb2C0Y1al7r/WvMWXtkTZiYLZXFie+F2GXb+lv8qlCNuwJkQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569543; c=relaxed/simple;
	bh=+5QohKq4o9EWFyhiBOK/25QodGfCllmrDGCDCvbfNjg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iLiE3g7ZLrK3l+vJxTy2NfkdKsKIIbrS78h15/0Yldw8mOXUE3vCVzkSCU8vZoCNWftGlBQ21fhPMnnfidTMIMsEEL+k/ta6sis7WlFew8rb3d0VOrUzdyPaAlxqAGHoZIZGA6BbuRW00Yy4IjITvI12OPGKYcu4BXvmXb3iCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JM18ExWw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p5+Aue3U; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JM18ExWw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p5+Aue3U"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 647941400074;
	Wed, 19 Nov 2025 11:25:40 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 11:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763569540;
	 x=1763655940; bh=KlSenuelheSLCUG8XF0inxncYqsE9UcVsSwdcFH2+D4=; b=
	JM18ExWwTnRgP8gsHKzkIaJIgoR7IpmIQvF72KUKQCYDZ+PUjAJci1pHVS47jk/U
	AEOMuGQsMisc7Y2ZUTCi4LfatAHzBP5gUEBwQRgbQgqP/MqUdqeI6QaGrReWhX5J
	I1ketvQbAp0FBHpQy7Nd9yvabkiM8oXKJ11+tZDw8O2wjTv4l9Ah22sxdmDK6z7K
	EIjZSUjfT2AlzC2SLXvTJHuZqOoug+lp9HksAyhsj8k63AU9RliS6cFy8bDgNnP0
	p/XBylEI9TEZZuYHkGRcrbw7N9WPCLgZUVvWWg0A0tL8tKYZjaaAxXvUK6RAVU3B
	325ijFLUEkPEMmk4xKMlug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763569540; x=1763655940; bh=K
	lSenuelheSLCUG8XF0inxncYqsE9UcVsSwdcFH2+D4=; b=p5+Aue3UhVXXVKOw1
	45fNpnwKj/n5YBakjyD+ZZDvyizRHWpBuBaGRDZFvxqyIOzQqXK6va5r/8iRGkJP
	Ajo30x1292BnT29omOoQW+wukl2pXnPzTkGkNyVNpfPnlM68u1Xt/Lxkbd7R66xu
	1vCCPwdvYsh+65Dift/fXYLolUftSrtNMp02m5JDN/cSbNJecI4tz3eurcU6Xpyh
	rCSM3oPrZpwmc3uJAC4QxFyvH31F8fy47YSIs2RPXoWvm/SMI6anQJxeghbu03nt
	7fZPFevgFDyTvOa4ik88b2mmqNnNkqpGgdHM6Lvc7imG+vXlnWF5gCOT0Kj9EwcL
	2gIHA==
X-ME-Sender: <xms:hO8daZcK41EAn5K2_mLSlix8jaM0LuJVvsXSw3jFe_BJ7NOBrlKpFE8>
    <xme:hO8daSAA8mk-FDLCmfSrp5xP-4dsyfikK9-Ch26aXvo0DyBQtuAekzTNMPfnDz2Mh
    fJSf6yzTK2ZHUYoxHayOnRkbgITjJjXqdJOdRbg3a20k7qGamk2-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepffdtfffhfeffjeefffettedvtedtveefteehgedthedtiedufeff
    udelffelleejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgv
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hO8daYJFcfjK4h_g8OeQ5WFYzFSALRnqJIpoaMInfVN48p1K18sxxA>
    <xmx:hO8daWGtX4R_WK5UDw1GNohtkIs3Xt4uso_M-tODXmECYAPCIsX5AA>
    <xmx:hO8daQR2tC_pwM62TxIAcmX24rB8FobDG0D9oq_-yCtCavzWha3Zfg>
    <xmx:hO8daSHDJVPuvZ210TFz6ZQTVROE-DqHdZquYOjFnQQ8DsZed6QNcQ>
    <xmx:hO8daS8StYBDPEDO5DOWGCG_y3_Y0vnf_-hD5MAUQIOr6tncJ1Kk4XRn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 343101EA0066; Wed, 19 Nov 2025 11:25:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjEcWmrOR-Xg
Date: Wed, 19 Nov 2025 17:25:10 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: rsbecker <rsbecker@nexbridge.com>, git@vger.kernel.org
Message-Id: <94d81164-5af5-471e-a403-f2d544796d18@app.fastmail.com>
In-Reply-To: <003901dc596c$40bfbd80$c23f3880$@nexbridge.com>
References: <003901dc596c$40bfbd80$c23f3880$@nexbridge.com>
Subject: Re: [BUG] Test Failure 2.52.0, t8020.16,19
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 19, 2025, at 16:50, rsbecker@nexbridge.com wrote:
> The following two failures appeared on NonStop for the actual release. I did
> not see them in -rc0 or after (doesn't mean they didn't happen after rc0).
> To my eyes, this looks like a real issue not just on NonStop. It is 100%
> reproducible and is not transient. The build is with OpenSSL 3.4, but that
> should not matter.
>
> expecting success of 8020.16 'cross merge boundaries in blaming':
>         git checkout HEAD^0 &&
>         git rm -rf . &&
>         test_commit m1 &&
>         git checkout HEAD^ &&
>         git rm -rf . &&
>         test_commit m2 &&
>         git merge m1 &&
>         check_last_modified <<-\EOF
>         m2 m2.t
>         m1 m1.t
>         EOF
>[snip]

Also reported here https://lore.kernel.org/git/4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu/
