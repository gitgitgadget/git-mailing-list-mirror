Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B215530C
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315761; cv=none; b=A8/+cD+vpzCbZSawFnuLk/5QJ9nOBCApWUQm7Rd3yjyXOnHFwLUi2gy8Zj4R3bpb1NXHJ76w8TiAottxxRP7V4w8sZzUH7CbFsaSiKBRP3tCFog8CoajX09kzyaTRKo4ybZm2zC7GC+uVqMLsuszyMlpSY7nsVplABK6Y2kpqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315761; c=relaxed/simple;
	bh=6hh88aBYrAOzrDe7/gWmq3srvEtRtTL3pk+DJ0+1RTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZyH2ibiaNYvHue8O2n5NSLgJQxL8+Y+BuJtolSwtZdlPl2v40+MkmlDQOdtZXhBE0KtV9SXaV6J1O2uDMHLQFiOxLv9rAP95c7T7JVBF6m1+UL1nESieP87nr6tVoy5S49l6RpcUiUyqpREoppjEMncVap2kzB7+nInJNbNsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n1BvF8/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ptxg7ew+; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n1BvF8/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ptxg7ew+"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3152B25400E2;
	Thu, 15 May 2025 09:29:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 May 2025 09:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747315757; x=1747402157; bh=mLNGx3sHv3
	9BqP6qR5nu5HTrlefMIAzSsqraPTQIfzg=; b=n1BvF8/NLdWqjJ0YdvXyGthkMV
	UkjY5xFGc9Zs/eUMQmrDn37iX5vsuNzFtB51gDXiYQ5aUxlKP8aYdMync+j+hFry
	23LUvBWG+8JWuWSKu5NWU9V+pWiFz8wXIwJiXBU9xhPzwgz1yTWOMUY74Lb8uJjx
	OOUsGsiHtJKED9A3gEivtc5rzewn3jBBG47DWPflM4RmK57SZ+uXC4f8SnGFw9F6
	NzBEoNtm/CPbZWzTUFX7Wy5kYYIX2U6zz/xV8li6SKoUsnmM9aifpNiWYuxmrWi8
	n4zVIi1e332u9+t9O1UORH22tDsLb9ftTjBWVV4XItX9NROP69HJgqMYsTMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747315757; x=1747402157; bh=mLNGx3sHv39BqP6qR5nu5HTrlefMIAzSsqr
	aPTQIfzg=; b=Ptxg7ew+9AvZGrcc2la9jkyZyHL3ge41djUqbGSErHGYDESCdzk
	h+LViuIAljvWHWfueQCs+qM0N/A6QpvCNcircwurxTeM46nGcErPUgqoxFW9NNJZ
	GYrb6M8vSIYWBe1hIptUzc3LF+kT4u7DmSw5wxd9O0pWUUPtKPNtFd/l+ZP8efy7
	D7ydCN98PAl8Op2dA28clkuhbNIn8/8hPjzF3v+Ug53/s68P4Fj6EH1fBkekSoC7
	N4T3GZSEzSzqCjw0OfpiyJiql9lT3vwgBnGUZZApEXfaxhl+Dhm/hKEn3SN+90qH
	9HAaZQBCN93Mb08H+kxk3lo++JKBB6wKVgA==
X-ME-Sender: <xms:LOwlaOK81iwUo-kOboNWdXgx6bZYUCdDPBHxIE7FE3HF1yuK9PSqcA>
    <xme:LOwlaGKUb2mPf7NEzc8kOp5ZFQhXBk04EQ_pRoWQA-SXzZ-bIStskfXhEcUOvMvE_
    EQbc3UE0xsxmTwzoQ>
X-ME-Received: <xmr:LOwlaOuRiuFjHZ8eaO0YvYx7E1J7kTjGTPJ1y5UbADHoU_j1ZP_0QZtswxUGgZqvGipuOypQUXGP2ea4mLtlH-3QdkIQoUaZ6gtBPmtO0CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepmhgrrhgtnhgrrhgtseig
    ihhplhhinhhkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LOwlaDavoBpMUF7kUJCC5YvlNbGJwuk4WgyaQ-55mEOtgxYjAddeOg>
    <xmx:LOwlaFbi4ElU6rGqTz8F91wSpYePYnquDUy9G9695N_HktyK4bGn5A>
    <xmx:LOwlaPA-SDyyv0xnOKF6_3d3LrHBYuxHZnDg9pLgyl_hc7TlCMkDqA>
    <xmx:LOwlaLb9KytjdawfuGVUarktROhwz32wRHsQ1OP6x2gxs_i3zVB-5w>
    <xmx:LewlaD-yr-YZQn8xrA0QGdydomYwsoPcbocTD1HAntkcFkb2Of57pDzz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 09:29:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2119792 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 15 May 2025 13:29:13 +0000 (UTC)
Date: Thu, 15 May 2025 15:29:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
Message-ID: <aCXsKHiP4uIzCMrt@pks.im>
References: <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com>
 <87ecx0ijqt.fsf@iotcl.com>
 <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
 <xmqqjz6sb15u.fsf@gitster.g>
 <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
 <xmqqldr789gr.fsf@gitster.g>
 <9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com>
 <874ixnjltf.fsf@iotcl.com>
 <xmqqy0uz7zzh.fsf@gitster.g>
 <0f491261-bbe1-474d-a240-0ddbf22cc754@xiplink.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f491261-bbe1-474d-a240-0ddbf22cc754@xiplink.com>

On Wed, May 14, 2025 at 05:15:30PM -0400, Marc Branchaud wrote:
> On 2025-05-14 15:29, Junio C Hamano wrote:
> > Having said that, I personally do not think of what "blame-tree"
> > does as "blame" at all, and there should be a better name for that
> > operation that does not use "blame" or "annotate".  So a separate
> > command that does not even hint it has any relationship with "blame"
> > (because it doesn't; in my mental model, it does not do any "blame"
> > at all---it just does "git log -1 path" for many paths in parallel)
> > would be even more preferrable.

Curious. Isn't it exactly the same what git-blame(1) does though? Taken
the textual representation of a tree object, we figure out when each of
the lines has last been changed. That to me sounds like exactly the same
thing as git-blame(1), but just for trees instead of for blobs.

Sure, git-blame-tree(1) goes further than that. But conceptually it is
exactly the above thing, isn't it?

> I'd also be happy if instead this came in as a new command without "blame"
> in its name.
> 
> How about [[consults thesaurus ...]] "git ascribe-tree"?
> 
> Or maybe fold it into ls-tree, e.g. "git ls-tree --ascribe"?

I think anything that needs a thesaurus to come up with probably isn't a
good name for non-native speakers. I personally had to look up what this
word means.

Patrick
