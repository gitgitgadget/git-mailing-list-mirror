Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A962B9B7
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033901; cv=none; b=tvSbOzSw1kqGkakjtb9dbsQS7EZtIKqjenlYb1OE+ysVBSbm0B6efz6ebZckkaBDeoVG5BXHgGnsoZZfrtOArFqTLJX2qKNmDJelirdck3hNCHBGf8no4v16LnuQb4/qW4LqWh8r3Pg3vl1jQhfKv0s7O3C9b3LTvX+mbGh0cSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033901; c=relaxed/simple;
	bh=+8i0O444F2s+PCZwXXCBfM7jm7z3kF6VdlQSGQYjMko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MwUOpH/6D5orDHqdMCiqq5Ihw6y6mgUAReSt1l8m6yfXszlnuV3ylTVTf11jvtsv8Xb8c1aWujjS9kT4Pj3YsjPpfHcwc51IpK/PPI6JBbSFja+5zU0l/VLVz1XnGwsWQk6d3BGOLfZwKPmD4DkOxDR224TLnSw8Tc+0ts+sMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cfqgInvY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xy4j0dGz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cfqgInvY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xy4j0dGz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 034E7EC01E8;
	Thu,  9 Oct 2025 14:18:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 09 Oct 2025 14:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760033897;
	 x=1760120297; bh=JJWAwRM8l/f6DeMBTNbp9YCxrOH02EMM0TVRwr9qaVA=; b=
	cfqgInvYZYXopvGdJ3jI9BxKeij15Yb4tqRfrl8eBFjFu1YP4V7HyW8WS3cHVkiz
	/f0TjLJ3FuEG+sJqZNAasuvZ3od5JhDyty1ES5J1GxYkoPWgNXm80UXAWnm0NU7y
	vJgQNUZGvBrZtXBqqr3+RKE6Of/gRxkiorndRDOPre2/UiJ4I8NlvBZQ4TuBuWGe
	VqfTv2j/M4SX07gRZX589xp9DVUo3T6XDGmIoR2uDCC064ujJvkL+qiMvtlEQPef
	UxV1iWF/GKYhL8N39MtIiIvIFR+YdrkwQhL0atwT6UDHD6LJQ3j/NKwh4p+Qxxs0
	+jQv94HH0T7vx1JMS0zRPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760033897; x=
	1760120297; bh=JJWAwRM8l/f6DeMBTNbp9YCxrOH02EMM0TVRwr9qaVA=; b=X
	y4j0dGzim2UDTnV9h4wCw2HOBaedkvhKsYf8wiSf3oTV1HKjJZGXK+Hf7ONGnA+0
	FffmNTXMe/2AcnyhuBu8PiNtanl+sOu94eBxrv7LTrGwtlV+Q4Y7ekJE8nUgh13K
	NFWDWSqwDZYoULKXaksFN18dppGtaYl9J7gwuJdUng/RU3zQmYGB089dRHPsnDOL
	miQLiQb/g5/9TwZc5XEqb8yHOt4NRKqFu5BDrIeYULX3m+nuMZpIfFUpx/o6P77s
	F32kbJFRjznQoXHyAgwn/fh+GJp4eGJJ5lBsxma6xV1GBlTPqF5XNXjpNtRMiLMa
	LYqE+YVQeCe142aZLu+Jw==
X-ME-Sender: <xms:aPznaPiamxw6Nn6Z4xMLYh0jkKJnyiMhXOF4iZPohp502NipjTEIZw>
    <xme:aPznaLuNlnEtcY8IdE4Y9069DfGiF0J9cURLGy9A6cQXMqAbnROQ9B1vIdHMpuJpV
    I-gHipv9vVqEsWo9vlgfaoRva6pjmjlHLLNYlkOquSSUS_NYHFaIw>
X-ME-Received: <xmr:aPznaKvgTNUlpVXEz38F2hZTVSa1IlQyjPialyqep2CIJc22YWo0K9A16etPc3EVjZ4s7qrTGtP9qjCy2GVahVFDSwgVbFpIFYJS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeikeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtth
    hopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegthhhr
    ihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggv
X-ME-Proxy: <xmx:aPznaIGOh0KNi4lnExRc4CMFo8UH8C22l2Wi90Tri87hQ7NDtVGNlQ>
    <xmx:aPznaNNlkFEXLe80gPKE42FKGu1qAge8JlACFln8yXAjyJi4r0zkjQ>
    <xmx:aPznaPIHRh4HfZxZEVbRTRJDJoJO6UgSslrlLyP2M08HnPj6a_zQcQ>
    <xmx:aPznaO84Prs_k6b2v3bdqKGtn6D_TXMIOPqKp6em2iZ1dwPdK7vK2A>
    <xmx:afznaPNz-UdZXmMA4kdem7NpvyqnFcG7tmnS7pt7pNGC0Zv-iPQVZSHu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 14:18:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Collin Funk <collin.funk1@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/5] lib-gpg: allow tests with the GPGSM prereq first
In-Reply-To: <aOcfzgxOwGemReNm@teonanacatl.net> (Todd Zullinger's message of
	"Wed, 8 Oct 2025 22:37:02 -0400")
References: <20251007122958.1089680-1-christian.couder@gmail.com>
	<20251007122958.1089680-3-christian.couder@gmail.com>
	<aOYPTKG9t4ZB_Mbi@pks.im>
	<CAP8UFD2VRfZuaycCdWt4kpVpRv_UhNHdzqJ2vL8uyKJusUttnA@mail.gmail.com>
	<871pncdfrw.fsf@gmail.com> <aOcfzgxOwGemReNm@teonanacatl.net>
Date: Thu, 09 Oct 2025 11:18:10 -0700
Message-ID: <xmqqecrcdjml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Todd Zullinger <tmz@pobox.com> writes:

> I sent a series long ago to fix this issue¹, but it wasn't
> picked up.
>
> Fixing the issue exposes broken tests which use the gpg2
> prereq.  That breakage turns up in our CI and other build
> environments, like Fedora's, but I was never able to
> reliably trigger it locally and track down what was broken
> about those test.
>
> I believe I asked about it again a few months later and it
> did not gain any attention.
>
> I simply apply the patches locally and then disable those
> tests -- tests which don't run reliably are not worth
> running IMO. :)
>
> ¹ <20240703153738.916469-1-tmz@pobox.com>

True, the archive shows that the two-patch series got no attention
from anybody, it seems.  Perhaps nobody was looking at the list at
around the beginning of July last year?

Let me pick it up belatedly, but I'd appreciate an extra sets or two
of eyes while the issue is fresh in our minds.

Thanks.

