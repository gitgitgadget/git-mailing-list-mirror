Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F7224F6
	for <git@vger.kernel.org>; Fri, 16 May 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413415; cv=none; b=QALvErkvgAVG4lixM8rOy84EMXdrfW46mXhHf1o3K0BB452lBBAb+JUpv03UHOMIY8PqrQEzcGXrLUG9uw7yVrv8OC9pfaZI1GmP/d/aLpmABrFY9xS/WA3YhTa5P8Ixx3vn1UqBC7RCN3dWUMExRYK7AilnLxbI1SalLXfiOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413415; c=relaxed/simple;
	bh=FKQLh4RAWmIOY6NLE8PmxkJd2nLgZPRNjiuel3vosZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hzgqzSQwJIWUrO+PI14Zj5ZxCg9v7mNc9fZkHsXZk8AETScte9FqnyuF6Engf3g7BPs3KlPVBqkHhw/xj25F2KswSN3HeFodPJBwtCBv6KzdFah+++C8Qw1f15LRRwrCoC0OxTkVpz1hKt84gtn6lHaop78SDxPA1CtZr//PIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YgzYnw6/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r5JBJI1O; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YgzYnw6/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r5JBJI1O"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0602213803C3;
	Fri, 16 May 2025 12:36:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 16 May 2025 12:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747413413; x=1747499813; bh=0Jw7GMMxUy
	HUoSHr/SNZnMieg27XNoHjdGJ7kcUdb8s=; b=YgzYnw6/4xgvQxzVfW8Qyxxuzs
	tW0yyeqCWGfULats+azWwyd13u8C9bbmJfnpc0qQ2Zmo+b1W+uonfJr5u/F76rGz
	7eq9v6gt/C6n0SOjvWV1b2Zb0/OwaETCI38H72PYTcNeqcLfpuCFTX4pgYCwaQhk
	Ra2xh9PsWdEEsiCoAwCO0VdjZ4yZjjRcBS5dWd547jxyfRbunjXZ6mFnfHYbeXEt
	3T15Lj1lAeY3l1tCBYdBfPG0jqd8VL/r6E8+qfxfp+L5xhH+awpoPRTke2V3ALzf
	lS2jCsnJSLaNbGrm3KQdCBMEW14W2hI/umt6KYPmrbZBuEiNg531qmJ1wiwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747413413; x=1747499813; bh=0Jw7GMMxUyHUoSHr/SNZnMieg27XNoHjdGJ
	7kcUdb8s=; b=r5JBJI1OpAyiZcKz2BASO2gQ8tjFJlPs3Xlc+AmNsdAw68/Eakc
	WKR6ql/CVBxLOAa6Bxo415r/5FbA70Hk/GjZfnO8HWcOQ6ynICUB1e2+oV5FMXZO
	a8rbxXypcJuUp0kpnKDiOPQGGKbv7wByKUXFVL99djNLIvJiZ2yDM+EWtk7Ibzzh
	zrR0ckTS8KSxuXou+YgV9hjyyXcR3XeqKr/WfDp/xRiKSZyiOh31DxvmYaULJWgO
	g49XJVChLzbOY4a8ZiY7I4/nbsKA6d1k98xwT476CZM5bL1N6xmDQ3U2i8rTiids
	ZjFIKOyRH9oniXUvDGOxkZFKcRAzZMZ/bqQ==
X-ME-Sender: <xms:pGknaLELA0R77fM4aHUBAXVdYpa_ax5y-BSkhZJv_VCaWf8FG9rniQ>
    <xme:pGknaIUc7z54Egi6aSZ31XnMjxYW4DUC19SM6rTiYzK3hYpSGnSEmU2P2RO8kMfSQ
    se04BSS1NiKXeqXng>
X-ME-Received: <xmr:pGknaNL6ajcoMEgLlYkpYuacnglKkExpi0zdpyY5qCtB96wQj4q0qd1dBjsqIs8RBchG3ghz6-HLa9q3_k2qYJ5GRgLyodRLKjz7gMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:pGknaJHjYFDHawGwpdgrS9dfsR319ayYGQbmIuSZVD2O9K7ExZYLsg>
    <xmx:pGknaBXvpAm_V4q2R0VLsnIXqI1VABVSCXYaJgPXcrZz_XOZVWX72Q>
    <xmx:pGknaENGSWg_TQz2mrVWf8xn4WchJcKjt-VJ2tjTIHumNB1ZKdE98g>
    <xmx:pGknaA2utI6cpYpd6mEsA0jVp6tD0tBuL73U_a6_Qhc3z7-FesBRBw>
    <xmx:pGknaIzvyBqqENJS23tsI3sPSj5fumgiZKIjV4k2aZDxLF5yv7eAb8Xh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 12:36:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/13] dropping support for non-standard object types
In-Reply-To: <20250516044916.GA21985@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 16 May 2025 00:49:16 -0400")
References: <20250516044916.GA21985@coredump.intra.peff.net>
Date: Fri, 16 May 2025 09:36:51 -0700
Message-ID: <xmqqcyc8wlzw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> While fixing some bugs last month in c39e5cbaa5 (Merge branch
> 'jk/zlib-inflate-fixes', 2025-04-15), I noted that objects with
> non-standard types are not really usable. You can get their size and
> type, but nothing else, not even their contents. And you can't transfer
> them to other repositories, as packfiles have no way to represent them.
>
> We've had that code since 2015, but beyond using it in a few tests,
> it's never gone anywhere. So I'd like to consider the whole direction a
> failed experiment and rip it out, which simplifies some of the core
> object code.
>
> IMHO this doesn't need to follow the breaking-change flow and wait until
> Git 3.0, because what's there is not really usable in any useful way.
> But others may disagree.

FWIW, they weren't for exprimenting to see how feasible adding more
types to the object system at all.  Rather, they were primarily to
help testing how the production code reacted to unknown object type.

So I am all for removal of the support.  I didn't know its fallout
was this widely spread across the system to need 13 patches to
remove all ;-)
