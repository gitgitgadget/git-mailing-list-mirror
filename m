Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733432548B
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560941; cv=none; b=Eg4xe6icMK0q9ODTbD505qx6n9YaqZaoXLVKrSxhqMhewvudOpE5HQFn/ShiHiffNetQJHkaekp81t1SeEzH8FVcPozDNVD/+pTfKIHUgfi1Ns+fbPFHZfW6qtc/1+wKyIjfMf0LKLQyFGWEftS5lkgbS+fculEr3mSI9cdpnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560941; c=relaxed/simple;
	bh=1syDT3GX2rtdhX7m2aWDax9xFpTSglrafhtAF87VK0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XrtN49lOU9zOEk9npEP9vWu82U5hDwBgKYUp8thgggvJiwlyO8b+7xOQLiL9c6VUmGhwH4V0DGqDwPdlWnMD0c+why+JheJMljQjsyzU4H1iynyyFvXnd8X6u3FsGofK/TiFcUurh14FXCCtuiOS6U2qnwk8c52ILlMS7tzlaQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O1kn7EWG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XcewXfbm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O1kn7EWG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XcewXfbm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A931EC01B7;
	Wed, 15 Oct 2025 16:42:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 15 Oct 2025 16:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760560939; x=1760647339; bh=gKkzJqvpIw
	OLjwk9DZgk/plcigTjNt9GLVgif8LHgQw=; b=O1kn7EWGZUa1b7uEBVh7o8Auop
	tLKbBHxSFaBtcjTKT7wJhlVgGG6ZUB+hH+aQMULjQJT2JWM2gxM9Ysob/skYn6ju
	nz6AIBMJmEnsVy73oI2GAnyhoBe4TuR/KvQpNnyMgKz3iap6L9HeaW2a40Ji/Bbu
	G9mWBALYvgPTENQMRIfJOF3r/fqAECYrWkgDnmxhHaq5vo81gIf2UuRBacyKIPde
	CThCKlxV1DqSRDwoiYo+TD++KDq08jwHlz6UhOIp3JpXxR78oaRprg0VLqshSxQ+
	FUB9UtIhPbxGm+ZSzLKxjFCmXeL8HonrUfsyaaA/k6r4V8rPWakpLF6zh9yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760560939; x=1760647339; bh=gKkzJqvpIwOLjwk9DZgk/plcigTjNt9GLVg
	if8LHgQw=; b=XcewXfbmeKIUTOLl5PA+/sznUc82VDCvU1AtNR2jg6ksu8e70AD
	MAEu5PsMNdist1KMSkKrzvKXFXi0svX4L7JgqxIscsI03JSVCE99Cvl7M4Jv6brp
	+1pmfnrKr3pKBxFEKcigaQL/v6dzfT13SgOWUe3TjmYA8nH/e7w1a6wnJGwLZXwA
	61c2ik1EAyAZ9lOuhCaK2RpqxzUrxhLfByis8KIXXnSDv5m7693kYcdZgL3ZfqT7
	Jjl4Ue5iSbGRTHfc6/NAJ6xPRarASSXifc7xUr30FkwjSNs4q/Y+ZE72RjZuuy1M
	CLBagnElAS+dqjBTyda4co1T7z7anOffq9Q==
X-ME-Sender: <xms:KgfwaCTzvJGUKjWAs__SZQOgZZWKtlNZn7v5i3nUL3AAXAc8BpaGdg>
    <xme:KgfwaKDi4yvWWs6XAcrOzOH3W1GE9suE0kEglNzskSvYZNOswtc4cICmxOrdDSmyo
    r8tc47OK5-rQrZUx_bEzbn7H92OAVOWWUItv8cTnZV1OHYoJxSL2Q>
X-ME-Received: <xmr:KgfwaCEaZwSJVL4AWO-VOppZBfNoAXa2JDunA1VS15a9Mj8hJytbuopVJapzB6URFTYXFgZYgz63O_hz_fLHopn2TqRhnKFs4WXB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeggedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KgfwaEA0e8RnPiMm2AgpMf5K0Rphjau6bjOMOPpYK-1gCLIYIpPZrA>
    <xmx:KgfwaKWTG0wRJh3wha3Su7UapdXfrNAPw9lcY8GpMpcgdBX3pudTEw>
    <xmx:KgfwaAp7zbLFimom3YFZeHGcrS02vr8bAAbKNotxDYs44gpu1nY8IQ>
    <xmx:KgfwaOS6GkvjH-HBWR3qG--kI4TWer-YCDO9DcNKdW5gXLruv4Uc9Q>
    <xmx:KwfwaM2fUhM1TNY3jYGydNxnE9Bynx_vlT8CAgYwVoQ5Y2awYZCEoJ2t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 16:42:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Patrick Steinhardt" <ps@pks.im>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
In-Reply-To: <353916d3-c977-40e5-9251-1535b226cc9e@app.fastmail.com> (Julia
	Evans's message of "Wed, 15 Oct 2025 13:20:30 -0400")
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
	<pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
	<aO8-NtJPNBAM2tVn@pks.im> <xmqqsefkuqkv.fsf@gitster.g>
	<353916d3-c977-40e5-9251-1535b226cc9e@app.fastmail.com>
Date: Wed, 15 Oct 2025 13:42:17 -0700
Message-ID: <xmqqecr3ucba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I'm still not clear on why you think we shouldn't mention that how
> references behave depends on which filesystem you're using.

Simply because the main purpose of this document is to give a
data-model.  A case insensitive filesystem limiting the set of names
you can use depending on what other names are in use is a quality of
implementation issue, which I view as a mere distraction when we are
giving overview at the conceptual level.

Thanks.
