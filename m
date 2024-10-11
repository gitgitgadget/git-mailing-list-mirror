Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0B199941
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664980; cv=none; b=nlI6t1zaDp855NDfXBhvDvViHGJHI45la8cTXtdLAMUCcJqeyKUJKOc65aQWxYYNKYzFmpdpL6aGhnzFrg/wFV9D+axeAmdoJ4Qv7ikoXKcoJ3F9MtDxyo2DFwrRdOvKhjVQO5jazgXdwzTJwog70YEqApmJ1Y5OMqR63MbUFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664980; c=relaxed/simple;
	bh=LG/cfMgYzBju2e9q1IJjLvzODXIuJyHvbz1Y1lA3B5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KU0QFiYX67AThOmufzz2mGPyc0n3OzdgdpEWtSKbGjo/GiVu17riqxR+KsJt+0oueec3mm+n/7vaDtzXbMRoNDh7K8cL76yW4VU9sDzJa4ig8u9oJYVaxoqr5OtjoVC0KQ3Mi1spRikQFxBia0IJN1gWe/jmwaZ0LMLOFGbaqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jVZXAqBY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2r4Du5j; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jVZXAqBY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2r4Du5j"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E79371380277;
	Fri, 11 Oct 2024 12:42:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 11 Oct 2024 12:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728664977; x=1728751377; bh=LG/cfMgYzB
	ju2e9q1IJjLvzODXIuJyHvbz1Y1lA3B5M=; b=jVZXAqBYQSuJzDQ8uFYbcZYsHa
	2duH9ljwdCG6TAooNYhMCi1ZQ6jDLfI6uB0tji7pqIxNUOHVgciSFrLqDyANXtFa
	9iTCOg0F0EP4pg1vFJnVV1FtAij8aF4aWsHuzp0sOpEwhfRyjGbfBEhDV4OugxD7
	v74zV9k71PtNBK+0FxMaKJEL6nX2VauhU+QHkqxOfwwT0gfhqDJLAyD9ZBXyYGen
	iI4Z21/6Qhcm5x8OLQSfCRIuUvomAbTBask8n+0I4AmVru+t/MGVP79xV17eZuUG
	V8e6Jh55HGixp5/Cx+5NeIOH5rvCulL5LM5TiBBkThsof11n/YFwFRsXTbzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728664977; x=1728751377; bh=LG/cfMgYzBju2e9q1IJjLvzODXIu
	JyHvbz1Y1lA3B5M=; b=a2r4Du5jmQdfd80jhbf7HcgKibibi8T8y2e86A8kRBHc
	aBlKtM8ScXmF0fmXrYmMCzPlkaNNn7cpbLjMZMzdYZ2sQ+Zln7vy94/jxVShmmQt
	Rl8wsAc6fcievzyI3SK58TvcerQEWSiWffuW2nS06JzSwMgAdnRwlMuS+Y+O/32d
	6ZhHAN4V6ROci5BhetPC/gs/8sFWIpdjMr3fbgD0tOEVojM8FFaKK4FMJikBrtQJ
	zTcF8Bti4S1fu02g1tqy+cGJXHGDxD0tmcOgG0BPpiYXWBYHm7QxCQi2HYan7pcT
	bnNCDKh3KsFxuwU4YBxo2gSEyVmPy6MDKMUGLNBvSg==
X-ME-Sender: <xms:kVUJZyaf2d68BDrl1gJp2kCjTy-V_-1k14h85ZtTn43bTkV5h5OZww>
    <xme:kVUJZ1YDo1rBgadinKbYKiFqVosuSaxZNdIF6SpFgwSzxPdLd01u4e_2FOR7qX5_i
    cmfOE1DWsXUuoNXJw>
X-ME-Received: <xmr:kVUJZ88HEKsOmzRZQg2Jm9ufCSR9a0caq2xgtFXS0Zxa_wfzHsLIPo_Q-DJnZzDhMcAvQiDquqeC7lC4oEIiopHVXSQKcMc8GH89_W4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:kVUJZ0q5jjYSZoMKERBMrBszC5iWldfC5puwbZ1cMzJc_QicXMCQ-g>
    <xmx:kVUJZ9okua1eG9fwbE7YrSNCxSBqCWueivNVdQqqgH3wx5eZRT9YPw>
    <xmx:kVUJZyQpz9QLOXpmfu4dr93kcAYsKSgn2m58xrh2uXptXDpJEOZpog>
    <xmx:kVUJZ9pt-FJKKfkbnMzcLBNe2l2lIl1SbmLDJVXx1hmaXbKtJqmVHw>
    <xmx:kVUJZ-kdtJmZM2cod697y4danAGFUHPI0r_YiYwKaAR2nYDR7F7O2Cr8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 12:42:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
In-Reply-To: <20241011074022.GC18010@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 11 Oct 2024 03:40:22 -0400")
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
	<20241011074022.GC18010@coredump.intra.peff.net>
Date: Fri, 11 Oct 2024 09:42:56 -0700
Message-ID: <xmqqa5fah9pr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The libcurl changes all looked OK to me. I was a little surprised that
> we could move to 7.61.0, which is only 6 years old, since many long-term
> releases target 10 years. I guess the ones you looked at have had point
> releases with updated libcurl?

Likewise for me, as 10 years was the random number floated around,
if I remember correctly, back when we discussed the platform support
policy.

> But 5.008 is so absurdly
> old that I find it hard to believe anybody would ever notice the
> difference.

Anybody who find that the update from 5.008 should be to 5.10, like
I initially did, should feel absurdly old themselves ;-)


