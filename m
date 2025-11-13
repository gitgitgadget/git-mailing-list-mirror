Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4A2E06EA
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763075489; cv=none; b=W0oGNyfpXdSF/SkDIlxQxmnrquzHodBgpOnZD9PLHC34qMbpoabDUOezvwjoeBEYF4g1mLNKvJCNVdWFB+/phvP3fr2DLG1sBeU3NZjU9agqeo61331nqCi78llJIglcxMUncZbs4lE3/qxMm3c1aWhKnIO/eqTcr/WnMDUv9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763075489; c=relaxed/simple;
	bh=Em0o4ZjCZAuZkdMA1hoXM1g9f//23QME9METNwss2fI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=freSAd1KIVA852ho7F53j3Ch3faeWoTJMc1ZiEqauP14iy84dLEMk+udq4sh8WXyl6dCaYVAKFwRFq/avNxDOz8DUBmCdkv1rNJJNMymykG6z34mThOmA6VLUCmRWzyxEpSqxAx/u6ctaHnKTFVlnEObsOiNyo+COv6+FL7SsGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YxU4XgFq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EFfomo/7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YxU4XgFq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EFfomo/7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E64214000D0;
	Thu, 13 Nov 2025 18:11:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 13 Nov 2025 18:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763075486; x=1763161886; bh=i8xtNlrkKt
	4jBa4qnL2QcdParwgU6UrA1ciwR886Nak=; b=YxU4XgFqxT1eZGX9TgPLIO1YKx
	58n9v6092TpCv1gnyCnPSQjJxMTMAjWD7eGbHozm28CkfTWzEkPLnUC2VerP92ZJ
	CAh+rCP0GHoFIYcTt/omiG0bTyfmcdq8a5CphOIuk/SW0XYuB9Y8bKrLRFLZBM5s
	PCZMeAsbUxWeT0Oe+rNvmtFu5QVg9FJgRvcJmQ2mtXqbGwOPWui658jwuC0v1lIY
	2y8NEN8X4OaMF1oleIHvRobr1XURZfRHR6ukL2v9RXJ1nVMZWya0E8yxwNQ6pIKw
	hXQD3jjJL3u/G7TKEX2H6au2VPaHLjxHOE3UNNOCSpfMShNGQxd6AFR4z5sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763075486; x=1763161886; bh=i8xtNlrkKt4jBa4qnL2QcdParwgU6UrA1ci
	wR886Nak=; b=EFfomo/7GNCg/kZN+zpIYNUMEyfnzDSd1t9zJU/vHwcbI9rhMMb
	LD0Y3lP7iUK0iBhfYSvJGsTnO8VbPaN5Y7gt4hg6gAoZ2P61W7A2jcVOvo7jymkd
	PtJCpDV/4TfDgx/qGNrKWcViFpIpO2huJUxqx4Qte3tSGARfTzaiXPFu4M2sb2s2
	IMPD4j2a4phcJox7sNiUrTCoVP00RFTEKPMwiaAvYrUAQVJ721y6DyJEoEeWHziG
	lvTddMy141yyxf3NPh6byEHDIXDjJgmj9tOKRCdskv2CDb54qm0MTt7M3KUysCq/
	jUrELjQ6MwJWAOlPlhp1gmYDzcF99w4jhtQ==
X-ME-Sender: <xms:nmUWaUIABYI3PrwzSEZQjHUeLvfHLiqNmGNfxsuyOhF5fEY1-0rMSg>
    <xme:nmUWaWZsAlLmREN1VsfFJUB-gTSWgLQjV-hOlPc42MnHv30-RU9CWFLtn7QYoKUkR
    A0cWAhjMd6UG098bkMlX1icvI-xMQ_3xtgoPAA5qK6At9xUFdSY>
X-ME-Received: <xmr:nmUWaW-nt2XYQHoCDjOC5uQtU2IsTaffxx6P3gzcReZv0CGvDyPoOp43Ebh1T5WUl7JcXT80MLUv5fvnJHMXnc9-EBUlyjtbO06D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdekvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nmUWaXZyo3o2QR_QXAaAGF6FBcktU4d6kkrIpd4do3kQbAU5ydnwpg>
    <xmx:nmUWaaOU6jDNiwhbjvim7rKEUI3tOXocgNlENOjgsZsfs0w48W-wgQ>
    <xmx:nmUWaTAb_UdnqX0h1cQN8IzKcsRjqltcGTdPjZJYyWQ369cN1RKGdA>
    <xmx:nmUWaRIPTDEPLjDlfN6NyV4JSE5hBAjgKaiuGzhRz50CMmGQ594hBg>
    <xmx:nmUWaXOrV-Du3cy1xQy5emEA50gFwiVkgTgBNrVYULgP_okTei-7VYk_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 18:11:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
In-Reply-To: <160ef4a8-8e9c-4034-9607-2f268fdbf29d@app.fastmail.com> (Julia
	Evans's message of "Thu, 13 Nov 2025 15:18:25 -0500")
References: <xmqqo6pde90w.fsf@gitster.g>
	<D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com>
	<xmqqa50v4x8n.fsf@gitster.g>
	<150f3442-93a6-4469-9c25-5bca24accc80@app.fastmail.com>
	<xmqqfrakyj0w.fsf@gitster.g>
	<2474339d-67bc-4a68-9f26-fe7edd172ec4@app.fastmail.com>
	<xmqqa50rqcy1.fsf@gitster.g> <xmqqo6p6q32v.fsf@gitster.g>
	<2265ecb5-b0ba-4a28-904f-186ef5318562@app.fastmail.com>
	<160ef4a8-8e9c-4034-9607-2f268fdbf29d@app.fastmail.com>
Date: Thu, 13 Nov 2025 15:11:24 -0800
Message-ID: <xmqqwm3tjzoj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> So I'd prefer to keep editorializing about what a branch "means"
>> to a minimum.
>
> To immediately contradict myself a bit: after sending this I thought to
> look through Mark Dominus's great blog posts about Git to see if
> he has anything to say about this ...
> The idea there is to talk about how a branch might be _conceptually_
> "a line of development", but that Git doesn't have anything in its data
> model to track what the "base" of the line of development is, so any
> time you want Git to think of a branch as "these 2 commits" you need to
> give it a way to determine the base.

Yup, that is why you need to walk a fine line between what is hard
and mechanical "bits in the system" data model, and the conceptual
goal human users build using the bits as building blocks.

Aside from that "branch" description, the rest of the document has
been polished well enough that we are quickly approaching the point
of diminishing returns, I would think.  Should we declare victory
and mark the topic for 'next' by now?

Thanks.
