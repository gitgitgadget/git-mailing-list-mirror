Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B92D1936
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761934; cv=none; b=tpRhgIcE/KFaY0QAZDjS9mPM81pFr1qpCRTyoSE93RI9ncX4NdjVwsEKXswnNNzxDf0A/ji4db7I4zGJzZsFOiT8FUGPy46X+RjYVmsae5yJ1DA+O17OxVB6dTTRAdxnXDwrccwWI6WSInMK8+ryRqJOrtxxgt0lpqJk/wXaVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761934; c=relaxed/simple;
	bh=RqOLKX5PG5PBUsSij49YTSu9KzyDulnCHk9HvNFsgx0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dYyA4yEwG8g+Dwdn8iErlKIa3ywmZeeu5q/EU9qVqb3zG0Xyhvu1IIw8a/8vGCfBhdxDuViv9rjgyWx+MuyFvEgocleVWPJiNcWBEqYZJaqkHGSh4DnEq34j0Nso/TnbjdoxDtNzMu1JxJMkAmTI9jnFE3VGw+4/XvXEm87zTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IG0ybXzh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dnLOyUL8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IG0ybXzh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dnLOyUL8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D15514001A1;
	Tue, 17 Mar 2026 11:38:52 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 11:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773761932;
	 x=1773848332; bh=RqOLKX5PG5PBUsSij49YTSu9KzyDulnCHk9HvNFsgx0=; b=
	IG0ybXzh//HwUZr+UyFxZnGOz6QlGh7Z6aKG8RT1/kR/iCHSqom//QxLL3UVc2ta
	ReivZxNyfd7DKWuFEp5eM0gBF8f8xufgzo+gpbpEeW4gzGDWHnD9GRrQiAdhrEdS
	PnjFDdYCyT6v8y+yUBneJEQjOTAk+jYpQQf1aThCib8lF4SWCF7mkCXzEdPvRL8Y
	4NS7zA5qZZvwtHOl0Ki4KvrdPODN9VyK+QVhTYwomq/byX1meglDN8mT/ZEQURVz
	g+wfqy3IojtRDCtDhcMIrUvT8IIGct6moQJ5UQ0YpmoobCF0xDsCMi3187mWTur4
	RFjOesP6TN6ulGzriYF7oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773761932; x=1773848332; bh=R
	qOLKX5PG5PBUsSij49YTSu9KzyDulnCHk9HvNFsgx0=; b=dnLOyUL8xgPUQtppq
	ARpcVrlr/mgISSJsTvPf4vsZ8o7DMivXe01f+QFHEG2zIARz8fucawBFiBgL2PD+
	uYAwRL8rgBmj0qpsUb8XXmcqQsilR27AFTP21ZkvB9P+4t0cgwg3zjJDEA8prSbr
	XlY+EOHwPWP8469wpT4g7G/f8XAkwQl+3sBfE7zfFravhYr1bO/f4i0IM/uPsemS
	lIyMHWebMI4MjoDESngngskGanPSJM9p0wrPAFIiGSrZz92etmDTwWssaUHVDslJ
	XikDJDEBsh+ORLFuAfKc5RcstDGmw6d1uc+eRPqtdwylsQ6qWN+JSVK1R/+wYbiH
	3xGEA==
X-ME-Sender: <xms:jHW5aU4FoDdn-W0e5WqitDOBX4hXr8cvgNx2rabdRBFVoM4Zsb7it9c>
    <xme:jHW5aQsqXddaFn32EvEmxWwqTroUSmOtT03oL4qg0FWDqoczgUeEvMyNhIaX4N419
    vBxA2htNw9L-iw4osgX5p9i96g14R5r2GFCu7dy83NJvNJYVDK1NiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jHW5aflbTgLxcH6euVL0h6oQts4k0p4yCsVMePC279iiGQkDe-MMNQ>
    <xmx:jHW5aQwoZUH4hG2fkgaws1kWZK0xLoCz0YqHfnNs4ogAHvs8W0ymeQ>
    <xmx:jHW5adNS4_ZenwFyIEGfRVYXcmySJNz1y1xcWRft2SzD8C5IcUYh4Q>
    <xmx:jHW5aUTBT034PppsHIUQmDPTE62ShmhmAFX8tkGxuLIQGfMa3TI-mQ>
    <xmx:jHW5afcnlwQSYDUJNSJdv6uqRU2G2WQfiYYbOiDG5VDt8FScIX4F96By>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E571F1EA006B; Tue, 17 Mar 2026 11:38:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-yuF0zS-0kB
Date: Tue, 17 Mar 2026 16:38:31 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <6b8e418a-cac4-40d0-8f1e-762b15911227@app.fastmail.com>
In-Reply-To: 
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
References: 
 <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 10, 2026, at 18:52, Patrick Steinhardt wrote:
> In the next commit we're about to introduce a precompiled header for
> "git-compat-util.h". The consequence of this change is that we'll
> implicitly include that header for every compilation unit that uses the
> precompiled headers.
>
> This is okay for our "normal" library sources and our builtins. But some
> of our compatibility sources do not include the header on purpose, and
> doing so would cause compileir errors.

s/compileir/compiler/ (or /compilation)

>
> Prepare for this change by splitting out compatibility sources into
> their static library. Like this we can selectively enable precompiled

s/Like this/Like this,/ ?

> headers for the library sources.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>[snip]
