Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E620338F5B
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621359; cv=none; b=JKHlMqrFcZZUi2OP3gAB0VZS81aVJu6LKOyCMlxlQ4Rp8xLQ929+Hd+7T4TiEn36jhMUT+IDongbYxfHQ0kq8HqrHCNP5b2QICjsL9jdVqikHT8Sn7us1nazEq0qDesHvB0e1FjaJthUJMGsmbWx6wnMVrEg6sTaJNXqJBXu8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621359; c=relaxed/simple;
	bh=x1gIpK3pbz3pJpMVf7OvpuBfP3Sv+9whWjAnF9d+lWg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pUmgkQNJGKIvAr6YFMF2XSWP0iaR0y6zP2m5VVCm2ehmniC4HU5qgjVZvgEkITIXST/g6ntYsKiv9Ten9VO9tz+48AthUNVcPLno4JXrrCPUEue+oaq58BBirIE1tBuefV6axWSeaoOlYySnmtn3vm1u3DSGbc/cLntAZyKZz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gSlEszdc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gD5u074N; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gSlEszdc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gD5u074N"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 487A8EC0320;
	Thu, 16 Oct 2025 09:29:15 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 09:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760621355;
	 x=1760707755; bh=j3DQRz9PT107wXtbTatvhnje2++BXH7goE7iMQRs5qQ=; b=
	gSlEszdcMpSBZo2tFws2WegEHO8EoVJS9XGshQxhkwL7a0izCHdtGdHaoHgc9Kd7
	nB7P+jnDH3UnfBWkDJ7Uj9/v/Fg84F/FkWjg5zPjNNjEqlwaM1QFhUjIw4OLLzEY
	QXdk+SAVE+okOV7E1GmBuN2pHPgKkXb02ftbENXRzQlIzhVNhYNjonOQjtp3/FPA
	3xLwcbUYVOLePt01jFcq5HO62UzBCgPzBehg0fLs95R8ixLpifwBP92692wRauyc
	yzi83vQTQmnqXsMA3lvbTeLPB3Du5EIzDO793a7mACJ6YypRgiZnODmMCyb8i3da
	YXE4Dsvu5vvkekeCyNbEKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760621355; x=1760707755; bh=j
	3DQRz9PT107wXtbTatvhnje2++BXH7goE7iMQRs5qQ=; b=gD5u074Nv2gsK2FSi
	zJhPfcDAVlV3DoCm7af+9BB4Mv5lPeP/7TE9sEl4zY8aW+Qbw1Z/yWN1Bwje9jYB
	+A6HkEAZ0xNd3H797qTkshRMm6f6M3jhugxowznSx5pmirBGsGci0dewIkasJrcw
	V+1j4iSEYeZnqk82WNzsfix69BLNW68MKE93LpN5uLjoF4hRCm9r/N83pICjv5Nv
	3u5iPQh6GnAJL6TO3CxMIpkCM18LE/zCzhyUlhDG1MTIm0jVz4T9vfZI4o429djU
	AIR4an4mzcE5z+cAYkCyqQOPwfauL07i7x38aBTPMn7RrcRzceJ35U52uvZp/mor
	m4YCA==
X-ME-Sender: <xms:K_PwaAGX1DLRjDfpr6EY0xSQgii1N3uEeTXFs-hTbS6djvetIFDl7XM>
    <xme:K_PwaEIFqpJyNeKH7K3a2IgWMRGvjxFZq_AeXP6e_KcWwKemqySjJeyNpR-zGgKe_
    sw9xuZjBvvt0wVJKmHMOpTaTPPE4_MzzWnUXEQ7JpgE-j_V7diFhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeigedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhulhhirghnsegtihhphhhtrdhnvghtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:K_PwaGzA5lj8_2pW8EcsWDztQyri6BXOwmR4Ae2rezNUy-cjU71jxg>
    <xmx:K_PwaAM_i15LVmFzadf1Rq8ZKmjIVvIx1g8BHj2rGcgORxh-E3Uhaw>
    <xmx:K_PwaP4DcfZBkCgO6nP3x0qz3XoX9NKSBMo5f5-x9ekPi3EBHoYESw>
    <xmx:K_PwaJPSdAdGnSIwVhUfdU1tlewxUhv6GKeU97LCHEIOxw24U5pc7g>
    <xmx:K_PwaP4crhLk7xTHMmcIdJWMHTMxs-sCdSsNsOd15x2Z8jL-woLoFWzy>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F18971EA0062; Thu, 16 Oct 2025 09:29:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADbSztqS9g3R
Date: Thu, 16 Oct 2025 15:27:42 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Julian Squires" <julian@cipht.net>, git@vger.kernel.org
Message-Id: <da3d0baa-d473-460e-a9b4-4b4042e6cafd@app.fastmail.com>
In-Reply-To: <184a164d-aafa-4ace-a858-8814aac058a5@app.fastmail.com>
References: <184a164d-aafa-4ace-a858-8814aac058a5@app.fastmail.com>
Subject: Re: git whatchanged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 16, 2025, at 14:16, Julian Squires wrote:
> I still use git whatchanged.  I know there are reasonable invocations
> of git log that replace it, but it is part of my muscle memory.  I
> guess when it's finally removed, I'll have to setup an alias.

You can set up an alias with that name on Git 2.51.1 (and later Git
2.52.0 (not released)).

    git config set --global alias.whatchanged 'log --raw --no-merges'

You cannot do that on Git 2.51.0 since you cannot alias builtin
commands.  But you can alias deprecated builtin commands on 2.51.1.

> Normally I wouldn't send an email about this, but you specifically
> asked.

-- 
Kristoffer Haugsbakk
