Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA442D46A1
	for <git@vger.kernel.org>; Wed, 20 May 2026 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244562; cv=none; b=SlLu1cAceFI7IjN4SD0YVGosIXdP+Uivh5U81JEbqyxPrPCKt2x5hlhfPkonAnd8mrFZ3T2ichtBx0Ix3ptey1+ruWvzaOsGMgdaKrfSq3/ivEHBBYQ5n4iOkCNl/i+XOeXL37/CjAsdu1JQrnGvQYxg776LOkKU2X9eGrz5KAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244562; c=relaxed/simple;
	bh=wjEmdD1G5Lrysvx3C0Z2m+b5SdDWj5TMsslYSZyKw04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B7jUb1bThjSLHOIpcCDqqv7LQSAExFquCYJVt/HWjx3cb+V1nKsip+FtLrYcentJoMHlBWKu/WMgxnClTA7N8Y8XmBy5cM+fZoakQeCKCH/upw2Il7U8Hg6VwNE2rzWqkzu2/dvbSJlLoSecHZzKoNrcr9H2QXTWWLS3/7fFqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kJJ0SD6L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mjPe8ebn; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kJJ0SD6L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjPe8ebn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 188EC7A014B;
	Tue, 19 May 2026 22:36:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 19 May 2026 22:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779244560; x=1779330960; bh=reuQ271ElM
	9pgLUoMxX1tQQdg2i9nr6+fgJykP3a97I=; b=kJJ0SD6LiFl181wj4Q+T74tRGf
	r+PIMNWQyGxt1/vHnGZKDIUz+rxTBx+sSk4Ef0UC4JsSdYK9nIkljfbFZpjV1RRl
	XvhwH2vcV67H17Bjf37qnMAUtcvSwtzUALwP1TYIL/IygtazEZHyBm45+MscO8Ve
	iKNcpQLY0ddEdSXvPkFTcp0E6mQWLrDV/xfni+LtmIGAKCtV5nJ76Hd9tPkl6KnQ
	r/HI4j8JFS8BCUin4M5HPjmxy8AoHFyGzWPmiDojyKi2p95Juwawcr9E2TEVW/lz
	xF1LCmPt7ZahSnD9Ww9c55z13K7GEQHh9WjtKc4oFepZxmIFI5B+W16VueVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779244560; x=1779330960; bh=reuQ271ElM9pgLUoMxX1tQQdg2i9nr6+fgJ
	ykP3a97I=; b=mjPe8ebnf950GbsgucbEjttB8HurYhh/foFAj8P7O6lb2zP+YJI
	0oKajDM1j5P/tz7ivahHHFyEQ4PxKDbSguRm15Lx4kldqtCZSHC6ARjmwncTQLl9
	tJwkI+tFySH5QTXfyvxmj2aGfEp5ydf/wqd606lUTDvDe3ZYtYkpRp8K+DqAhuoe
	gACywNt3G3Zv/Y864oYAfXWnUJGowMMcO9VYhiMNb5gRRIG0wx9H/qbpocot6zfh
	8+2NQ1rdbiLEXVRq/k7FbTFZZyLEnzENbQOtUAsOUFU1Vqpqws8pJ/OWTJwNRDqj
	9s2WeESF/1Ukw8ooYLssQhaMet/1um0tvMQ==
X-ME-Sender: <xms:EB4NajtyKh9rTcUFlmAnFVEiYgvdR1eLtzhphApIhWYKsfRfCbWS7A>
    <xme:EB4NardlRkPlRhRAQR2Ka7bIzftEe-L9wdg1q7lZZKpQiqPQEoE9qf31pWnWh-8Ja
    _2bSh8d3N5qjBA2pOhLC2w2WKdk48hJKoa_DvAScprBeeH1uIIeu44>
X-ME-Received: <xmr:EB4NarzG-cjhuhN7s6KOw1hunzjUKYWNvFoBk0_6NQJqFXVY6RmCATh-f-rqQITnHZJfJdM_siBi3yMvsTSnM78GBbMOQQP9uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EB4NahGUVhGfhpZdxCCYSwln9bAibxbM39vl4i0XFSF7o6QJMWwi0Q>
    <xmx:EB4NavyG0RUqhZbREaixEl1NHePvmN-jC2O4zicmdN609_twLxTQoA>
    <xmx:EB4NaisvY9BrjKE2zNzAaoAtCfVDshMgioIxemqghPwcp7YQ-xGuVA>
    <xmx:EB4Nas3KKiRoKNjFzsKvFzhL8hZZdQvDm8MoC-oQNsEqKrFXI-s55A>
    <xmx:EB4NavQv1n6HNYsr2OOF8M_Ys4gDbZDqBtKXD1AK7pyckQJBOlQONwH7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 22:36:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #04)
In-Reply-To: <20260519191941.GB2269222@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 19 May 2026 15:19:41 -0400")
References: <xmqqv7clbizy.fsf@gitster.g> <agyPJa3E2lPI9K/G@nand.local>
	<20260519191941.GB2269222@coredump.intra.peff.net>
Date: Wed, 20 May 2026 11:35:59 +0900
Message-ID: <xmqqcxyq6c4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, May 19, 2026 at 12:26:13PM -0400, Taylor Blau wrote:
>
>> > * tb/incremental-midx-part-3.3 (2026-04-29) 16 commits
>> [...]
>> Apologies, I didn't realize you were waiting on these until seeing this
>> WC report. I sent an extremely tiny reroll
>> 
>>     https://lore.kernel.org/git/cover.1779206239.git.me@ttaylorr.com/
>> 
>> that addresses the two outstanding comments you linked. They are very
>> minor changes, and queueing either version of the series would be
>> equally fine IMHO.
>
> I peeked at the v4 range diff, and it looks good to me.

Thanks.

I went back to the list archive to check, because these "cf."
entries are not meant to be exhaustive and "I've addressed only
them" was a bad sign in general, but it seems that the latest round
is in very good shape.

Let's mark the topic for 'next'.

