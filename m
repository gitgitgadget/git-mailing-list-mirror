Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D52E173D
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648366; cv=none; b=irGjKu20uzZKCxK7aQMy4GSaDCmIMzDf0Kr+LcsL39cAryVNbdSjL/uXN/c9LjlKD3YMFaDHYhHyxV4IzPxKlcMVqmwt7vUmIgmF21J1f2HPTiKG/c3XJVICgBiMO9uijj10mzK8LJrr/VWFuGiozzm95B799s+rNVJl9NgUq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648366; c=relaxed/simple;
	bh=EitiRaOhSn+3nS5uUaSf3vApvyo4qM0DsRrbUouRTmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DUj5Pp1vIpNjx1bYk0I436aJnY2DwmC3OA9kQeVwJVsLyIkJFFo+Q9PH/Do6SqJkocrnrcIOzI4tfS2ztFUv4FzCK9ri8xLcOYYfEcQ9owzeSHDSggoTvWYnibywRHmqFj93ZkL5kyufZKwtKu0XvX+f2H2hkbTpGeK2Qi9HFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WzliZUMn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bNdj8cHP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WzliZUMn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bNdj8cHP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B3760EC019D;
	Thu, 16 Oct 2025 16:59:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 16 Oct 2025 16:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760648363; x=1760734763; bh=EitiRaOhSn
	+3nS5uUaSf3vApvyo4qM0DsRrbUouRTmo=; b=WzliZUMnshgEavuzE//h7cZc6A
	jCrFSB/nNKRRG2tQ39MYwH+8lCYO+YkWWYBC2gZBZGqpBYvYWk9oY8HWwt3ZaYfH
	4XCxAG8XNIU8VyRhN1piRThq2haa9tGop2tyOUgcxQrmGZC4As2mZuwQQnj48Eot
	/EE5MifDbX/R0jxZZbdnVDEWU3YLeWueM87W9tBHiI05EaPVqKTw4H/yiiV8g3SF
	N3zOeZr9XM89YowQaUSpE0UBv4q34sTzkqGjpi3+7VMEc4ZygXgJSRA3C6V/rqA3
	tCWRbHoAQFkjzpX3N9b16KsuW4dyDTnbaCSe5IroXYOtpUvbg222rUzG6Kig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760648363; x=1760734763; bh=EitiRaOhSn+3nS5uUaSf3vApvyo4qM0DsRr
	bUouRTmo=; b=bNdj8cHPMNP9CQ/+lyDohgxTvRcUvL7CnfO2F8yUTj7LNHA6ZRF
	rnU9VWm84+Oo8gXEsl8lS4E3qI7gCxFNvlequnQ8pnKZN6vr441cBfbCgTL7lUXe
	S7GCtkSfluBiWDl2n7X8AVE1HJ37Y/PAFgZtKk6wx15zWj9rNH/OokgLJqsTXVG0
	+jANE7aGZIQYWU4KzOmCYL0w40N+IVQUlH7tkqvSGGW7DUOvBtJyq/98CphLCdr8
	YoNVOzobBxKNGN5AaVSnkQUUczg4noUpMBIp7U40Nk0NWPJ/OmjqSwN/chscdSO7
	jMsmAyVkvwVnJlYA/M6UNJ/wKSlnyQHwJpw==
X-ME-Sender: <xms:q1zxaE5Qlfz5kdWj6WAscka4U1e-_hqqpJkQPEh8V0B-tbU092iMww>
    <xme:q1zxaMwrznj_uVYdReOzfzhW9XETPwech7yCiBw7NMq2qooQi-7ezoqv5anejdPXH
    YMZZLfQ7xd1f7JuLzP1qf6TdVxjKRGqR8EXo11aDi56BlnnKLnw_w>
X-ME-Received: <xmr:q1zxaLyARJYosu0i1buD69IVfqQjACjPNpf2H9Qyg4ICwfl4-MSCyfqaNOnGBovTTka0NRy44Xdx8iIzBssJL7o_iqufO7bW0ZFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q1zxaEzixMEyWAfEJcTmSWVB5jarHT7NiOm0y-woapUUSvZzcSHE_Q>
    <xmx:q1zxaFZfSh-cX2TkTx5qyHdmsddMDUVcgGn_bRDAFLQJwYnGn9PG-Q>
    <xmx:q1zxaFU1lp8DcmnszXKp9KYkcK7ZCw1krGXLAT_trlpoFi2_L8qCoA>
    <xmx:q1zxaDhbdB25JHLN679vp9AGj_9bBV2dv-WPZ3kHbyBejM4InX5r9Q>
    <xmx:q1zxaJIuDNOFefsQ5jKLJFZXxbgeUITmX-pGsKkJxg6XSnKWAI3bFYRY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 16:59:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH 2/8] builtin/gc: make `too_many_loose_objects()`
 reusable without GC config
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-2-18943d474203@pks.im>
	(Patrick Steinhardt's message of "Thu, 16 Oct 2025 09:26:33 +0200")
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
	<20251016-pks-maintenance-geometric-strategy-v1-2-18943d474203@pks.im>
Date: Thu, 16 Oct 2025 13:59:21 -0700
Message-ID: <xmqq347i36mu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> To decide whether or not a repository needs to be repacked we estimate
> the number of loose objects. If the number exceeds a certain threshold
> we perform the repack, otherwise we don't.
>
> This is done via `too_many_loose_objects()`, which takes as parameter
> the `struct gc_config`. This configuration is only used to determine the
> threshold. In a subsequent commit we'll add another caller of this
> function that wants to pass a different limit than the one stored in
> that structure.
>
> Refactor the function accordingly so that we only take the limit as
> parameter instead of the whole structure.

Trivially correct and makes perfect sense.
