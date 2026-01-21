Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9C436355
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033088; cv=none; b=m6+pAs0lYA1cIJkf5TEXGtA57Jj8ddqnTKU/j9D00WjX4kFxu+ocV0GOzfEc29cKgzI++qoHr0VIkk3zcu9n56Sd1C7sWF+P5B4ULdHnE37nu7zKkWbwNP5RmtCoCN2mDzCV+/KOdYnVROm5GRy9sxadiHGppY0YLRUhN3Sj3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033088; c=relaxed/simple;
	bh=rDF/OAgt1NbTJ+v2zT0hmILN06bP5538neoix/bDgIM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hxiiMQfEwW5BDhdGrDuciazUo6ZcxB8U9m4GiK+e/W++UsUlRHUM8R3vSllAz689XgxYnrhbdgjcw4uPNBw0PGpvew2lHvxyMk2VZ8Z+rF9qYfsbmqaldljSraINnQy1GEG0/gL1KDbXojCb6tnBbLUyUDdGxg91OfK3fzQyaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eyaAilIX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XiWXjXl3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eyaAilIX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiWXjXl3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 577D91400075;
	Wed, 21 Jan 2026 17:04:45 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 17:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769033085;
	 x=1769119485; bh=rDF/OAgt1NbTJ+v2zT0hmILN06bP5538neoix/bDgIM=; b=
	eyaAilIXGj5qU8/Fz1RvJtIIPkhcBcsx2pa48FLxM0UqoCCfWDX0U9pzdr+wJHcT
	PD8zM90ShBhFLHZASDhhrjyENrSN7HT58V1DCeKZX3Sywq3etegawKZeVZgv88dY
	ukhKpAAZ9/SRUpDeHU+XNj3+b18IX+M5lG2wlHfxOh9AjFNuCXF72ALGxCNZaur1
	Yrcsy5aIWXvnmj4LwZaKUAxgfqAABp0Fb5QlAhlKfQMCNSemPWZzTvWEVdPpRHf/
	iBvhe8BtiWuXzZilk+MiTO/P+fTPIeeED0w71BA2Ff4yH+ymuIq+My8pDvfxZ2nJ
	4CXHnk/kn1UjBS68NYXowg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769033085; x=
	1769119485; bh=rDF/OAgt1NbTJ+v2zT0hmILN06bP5538neoix/bDgIM=; b=X
	iWXjXl32BhMnpIhmHChUR8QIT1u1oNayG93RSfA9AAqSFiTpOKHprf3hQkHHaFvB
	0I15eeGB/zsWIFNd053bga58Rh+PgnjsAcqqkmShVSwiA+swqYyeAvSZn+QAHSxU
	lSxBhcxSNDU6+yqXTC3MBPpMiEniCDJEuN6sjl5k7AatLh0JI/6IUqKDF0AIkA69
	RBYxUqvOzWFH7izvNpYNXlib6uafKFHQCImqPqWCUqbIkxLvbuyi4hUJH6G3yMMV
	PMNHUwS+O9fsEtPMoawRDUbIoBmu3hCO0+0JHlcL17WKqSTG5zVI31yG9WS/Svfm
	SSlWEiRFobDNkqbrMmpnw==
X-ME-Sender: <xms:fU1xaa-r55v0w1W1oreyukX09c2NblGqnvUyfqumbaa_cmqnTEmz4vs>
    <xme:fU1xaVgnxmiihdzIrzMkcS2rIE4jqGSq-yYTdqvRFbp2r3TC_HBZ9c82uaWEKVjBa
    R2fmlNGlSkQgH3y2oaGSxQSqWDVWNBlwQFwNhoeFc-zluDo1Utx9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeggeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhl
    rggsohhrrgdrtghomhdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fU1xaSXIVEuAoyHCoI-z0Z3twdUFCnZEy_LbyDjH2ZSLv3FFpUTFOg>
    <xmx:fU1xafTjtWWYoJyqo6bqq2BpXQCsEjHJzhrv3uEe1mlOe9RZx0wCig>
    <xmx:fU1xaUkb5L0DQTGS90fY6FG4dm2vaXw_3-iSb8nfmY0f4OcPdAgUVA>
    <xmx:fU1xad6TPJKvg4oXCLtKCBMBYSDiliYAE9qUvcXJASLFY-dPlHZ4ng>
    <xmx:fU1xaTJ9_1zM5xGeJu39ROxphX7ZXpAjT9RQdUoS34NWBXo5Fjcl9png>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 05F3A1EA006B; Wed, 21 Jan 2026 17:04:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aiqq_gQBYgVF
Date: Wed, 21 Jan 2026 23:04:24 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org,
 "Jeff King" <peff@peff.net>
Cc: "Emily Shaffer" <emilyshaffer@google.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Josh Steadmon" <steadmon@google.com>
Message-Id: <ba1444a7-0c61-42ea-94dc-cd1670ebf3fa@app.fastmail.com>
In-Reply-To: <20260121215436.1473800-11-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-11-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v7 10/12] run-command: poll child stdin in addition to stdout
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jan 21, 2026, at 22:54, Adrian Ratiu wrote:
> Child input feeding might hit the 100ms output poll timeout as a
> side-effect of the ungroup=0 design when feeding multiple children
> in parallel and buffering their outputs.
>
> This throttles the write throughtput as reported by Kristoffer.
>
> Peff also noted that the parent might block if the write pipe is full
> and cause a deadlock if both parent + child wait for one another.
>
> Thus we refactor the run-command I/O loop so it polls on both child
> input and output fds to eliminate the risk of artificial 100ms
> latencies and unnecessarily blocking the main process.
>
> This ensures that parallel hooks are fed data ASAP while maintaining
> responsiveness for (sideband) output.
>
> It's worth noting that in our current design, sequential execution
> is not affected by this because it still uses the ungroup=1 behavior.
>
> Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---

Thanks for rewriting the commit message to include some user-level
behavior/symptoms.

>[snip]
