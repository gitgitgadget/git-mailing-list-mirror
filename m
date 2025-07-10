Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD4C274B2B
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161596; cv=none; b=ZmZLo0M6pnMovE99t6kQ4gbqD1e5algcKRhuCIrVjwip9X3hUqz7k8EAqi1OuyZdcuYZNZIZSC2r1QrBZyOSXHxzEjRKE4OapYx2FqcWPEi9szLw/ZZncQoSLHq1X+4SamxqBUsszBeiScePK2LAaKcbR00qXW7qysX5535c0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161596; c=relaxed/simple;
	bh=xFaDIRMr9ChTIu+lsRhprx5mRFzhROmijFedft9B0BY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PjxdeKBjSOoSALQri2sIIhLEPUPkLKhjlDyIWxprHyqPvCOOfjOvZmRo32NCKeZyvrS01kwOxrH/NFY3+wgCRvkfKqrU2JIhZezgdhxeluPHN9bTRskx1RD8QrNJzLa3Dpqn2eTa88YjwmFFSw6DIc51ida5fzo+V7cLAjS+vy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fQ0e3rv9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dd3PBr62; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fQ0e3rv9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dd3PBr62"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3BF151D00105;
	Thu, 10 Jul 2025 11:33:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 10 Jul 2025 11:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752161593; x=1752247993; bh=c/YmGkSz3j
	vx+Bvgb7Pc1/uIv4h4pGsyCEuCPxx4zJc=; b=fQ0e3rv9k83JDmFoC2m4OXQO+E
	0V7g8d91QMeRIGCph7HIGE1WEd0e52tdNyi65XroAC39IqLNCsYw3ooeNKyREpX5
	6qxmp+wmdgDE+m7otb/5fOSc6omPD0u7A33asdfzncb9hILeLpdPCGmSEnzsC66T
	rrYfvTc7UA+OlD+FCya5RKb+lTH+ANRXh9WGfEka8Xgx1yhR74b1h4Hrnu6vmnGE
	k7IQjziJVq0hqpzKIKwGJDChu9HndCh1rInBq0mVGPSBY23PzrqNs9oGXBuLZkoc
	/1dx9BrrDzkl56K5A2GvJuSqQJpAXNRXNUKvRHIP4PTRF2q6s8Kza7u/Z2hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752161593; x=1752247993; bh=c/YmGkSz3jvx+Bvgb7Pc1/uIv4h4pGsyCEu
	CPxx4zJc=; b=dd3PBr62M4V3w6B8y1RCFgwU5yDyGnI6SPLoRwAZYDHu4RTt8VO
	pboNyUS9Yc1Aukn0q8fWi8hWJUHUx/yOc8l1Z88oCjdeyL7/5y3S6R26o92zZNw/
	d95+bi3e1YS4eCt3A/tF6ELLw8qrslQ8SQ1US7ukGMSDQgB3ZG+5PblnhCWD9Nkz
	foObiQn5FrI4DrSk/QRS1jmTBdavNO8gcb0W7cx+lklQ7xMByTjLGQVCte9lbY8M
	1QQWh7a8W71s8ToqQg3/FLdoPXtcBflvlC0wYBCcyk0LHCY1NkeakVOuBvFsz9KL
	nWtOVCR17NRik+vcOR2iVKP70uMg6BgcUvw==
X-ME-Sender: <xms:ON1vaBpENzx7xUT1zbGHT1PGcWpezQsarm7sgo1qa1kDNXner09UpA>
    <xme:ON1vaAgwzSVOkULqfiBJa8vejsUvIVYBh7dzop6ZtZyZMVH8JX1S5YSlc2aJqE58t
    BqycksEd5xoTrJFSg>
X-ME-Received: <xmr:ON1vaN9YcbZEsn8z54xDkA-NhM61CiovclN71SV5mAFybBeDobxma4Gae_46NkAHXDwtTlUGwXUJ-3VGIcryQmSRZZBY8st7RKvF5c0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ON1vaMVgL1VVRS-4dtBW7Qy8dv2YEeNRRLyQC4VdaojG7OhqrMUo2g>
    <xmx:ON1vaBDoWvPZNF3VuZmrxqhX_-3eAy_ZF558th4a17dTMmNzDsw0Bg>
    <xmx:ON1vaBEr-uGPA48oqbe5FRwvrxUOU7jYtwBremQhOD-xXfrcCtqgBg>
    <xmx:ON1vaC6DreN36f4_2t8QTgGL_oZjdOoE_kZK1LzVuOgPCkoDUdz6hw>
    <xmx:Od1vaBn-6rGlfM0vZAo9hBmDKXY8KElTU9PAL2AZn4tacVsfeKeNSmwW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 11:33:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
In-Reply-To: <aG94-0A6Qz35ekFh@pks.im> (Patrick Steinhardt's message of "Thu,
	10 Jul 2025 10:25:31 +0200")
References: <20250618151821.528627-1-christian.couder@gmail.com>
	<20250619133630.727274-1-christian.couder@gmail.com>
	<xmqqbjpv1ucb.fsf@gitster.g>
	<CAP8UFD223ja7jKU+wb6TiGkc9frh5dt1rCJkOkk+O+J2MPokrw@mail.gmail.com>
	<xmqqwm8jxoj3.fsf@gitster.g> <aGy82TiRFcij5V_9@pks.im>
	<CAP8UFD1A+eV9hbmp4P3pC71+oSTrtLgxtWGyt++J8a+bk497qA@mail.gmail.com>
	<xmqqbjpuwsbm.fsf@gitster.g>
	<CAP8UFD1mgKT0AFuoYfisHMinP6KEDahcXCwiK6-wRFBKKymfsQ@mail.gmail.com>
	<aG94-0A6Qz35ekFh@pks.im>
Date: Thu, 10 Jul 2025 08:33:10 -0700
Message-ID: <xmqqldow83ih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> There are always going to be exceptions, that is of course true. But I
> also think that long-time contributors that are employed to work on Git
> are somewhat special and don't (typically) fall into the mentioned
> groups. From my perspective, it's especially this group of people that
> should lead by example and encourage others to behave in a way that is
> good for the overall Git community. And leading by example in this
> context also means that they should encourage healthy discussions.

Thanks.  

I do not have very much to add to what you already have said.
