Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867836C
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732478548; cv=none; b=L8F1brv60IPbbYFu2TCZ5otR8Uy+OV0JDRSQLPB0JlPfgLbiO2KMN6EoEYa4OcE81vnSL/SqjJq9FI5jV9b6ozuUu+ms8tci1mQFNQfbLVX4RTvsUwY11cl9xF8JqdInKs+AcgnDMAztfXvSG0HRlJdOk6gQO2fgfAW448gsiiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732478548; c=relaxed/simple;
	bh=tZ+DwxRUjuvp6113YMpOp6DEGZ+4nYJT8iiUFlAFds4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=afRPvZemHHYT+lCkpme7Wnx1o0NnoorIXwMHATHAjA+LeCRrUMuy/C3bQ1gzBcpP5D+K/CBInQ2gk+AjTiHuDgK8fi93clm8ni/EaeMFxiYXYgR7i+oKxMX+3P0+AajgQpuFknrcfPLC+TXS/AFPshp749z63xqYTA3HJqGZvRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=H2J4+oWW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqaZIpOI; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="H2J4+oWW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqaZIpOI"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B46731140076;
	Sun, 24 Nov 2024 15:02:25 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 24 Nov 2024 15:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732478545;
	 x=1732564945; bh=hnOKVcAI9KridYTf7qldPJL5zpWnc9EgTrpVguCtePs=; b=
	H2J4+oWWdC8xFgewXwqfgnNrj5gNO+z7LFRidrOyQyIsms+oBwrHMmMu0Dpz4p3Q
	Aeru1q08qxZ9bI4inwrdYn8AxU3UUeH3DzgRNmvs7rupUCK+XWNan1lQbsY97NGX
	2igcvXaC1CjsSfw33SbEPkKD7E8mLnsNcvodLg2DwpR/nimXiuiNwunws/6KjgrG
	PepniTQjD34m897Fl8YIt6NPLfARULxEU5OTcg0FLdWeFXXARB21wR/F355K/PEQ
	j8t4GJg6NHWryIKjmF139YbPUe2vIkTWupKfz4UuBVMw3EcKHXZtVAklylarEBSw
	uCBdyqzsoUY5fQzVJToO+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732478545; x=
	1732564945; bh=hnOKVcAI9KridYTf7qldPJL5zpWnc9EgTrpVguCtePs=; b=g
	qaZIpOItEuolc/xLXTQoBxtyQtcWU9z9vYtoXdAhxv25ZQ2VZJL+2zjoe5C5vH3d
	SuI/B8hsl3BC8O+KOJlUKAK/vuL2O4MNkt7dhmYXLzb29agh+qRIr09TizPFk2TL
	1sqKTBkKVCia0RknvO8wrcQE6nBv6LGpyLY4bBvpic8exFhpUn/OpYms6Ajvxr6e
	aIMk4v9DhGQiYn5rRCf8IXFLizIYLVvTDEFG48bO12sOG5xXl9AYwF27ntHITUwY
	17fhCtEaRcd+KWpT7/k3FpW422xIYQhkjSp9MfEzuxdCjcRO1pKyDBKuyU50JxmR
	UGBaJMipayJSlXaL3xr+w==
X-ME-Sender: <xms:UYZDZ1FcEZiZI8XzEjezyDjtvD02mMm3HeDOgoIo8ZyVvnMYGgEC71M>
    <xme:UYZDZ6Uw9_iR0Jw3T6wOjDRkbNEuaerbjFTmPdNYCQ1ulu_5JaFaTlXU9uhxvLDp-
    TgKgCQ6BBC0neTVKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeefgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhn
    rghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UYZDZ3JMcPyfL2IlXTj7LDIGwAfJyGo3vcNtWFxfvChmXE92l7OweQ>
    <xmx:UYZDZ7FkevrauHPaTS-f1xj9UFUcJfpfVOt8o43hQNwS-mohqjl_Jg>
    <xmx:UYZDZ7WpAyq8uioYn0qF3uzTZmmMMmGj6ePun3kZRJJ_I1TqjiC1-A>
    <xmx:UYZDZ2N8yhfm5a5x_HJ0SA6I4PG9XglGgGRnO3BOhPV39aqvNzPODQ>
    <xmx:UYZDZxeHjBu-6ypkLbGV9meAPor-q9POSpVGbj58X03UXnS4TfiedKrc>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0D776780068; Sun, 24 Nov 2024 15:02:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Nov 2024 21:02:04 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Derrick Stolee" <stolee@gmail.com>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <fcd421f7-9474-4dc1-99e9-39f92ba309e2@app.fastmail.com>
In-Reply-To: <5ed77fab-678d-4a06-bbd0-ea25462a7562@gmail.com>
References: 
 <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <cover.1731406513.git.code@khaugsbakk.name>
 <fc3b4438845e9fafd03fb608128099ce37ecd1b9.1731406513.git.code@khaugsbakk.name>
 <xmqqikss2b7l.fsf@gitster.g> <5ed77fab-678d-4a06-bbd0-ea25462a7562@gmail.com>
Subject: Re: [PATCH v2 1/3] sequencer: comment checked-out branch properly
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 13, 2024, at 15:47, phillip.wood123@gmail.com wrote:
> Or check the todo list shown to the user with
>
> 	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
> 		rebase -i --update-refs base &&
> 	test_grep "% Ref refs/heads/wt-topic checked out at " actual
>
> so that we are sure that line exists - I had a quick look and I can't 
> see any existing coverage checking that the todo list contains this comment.

Thanks!
