Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490B2F7ABA
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086652; cv=none; b=g16yb9zBMzq4ZQ8FeGeMTZKqlqX02KP0DKhkf0CTeFFWU0tIXwM5/neexuNlw4rXkZAAGTG9PVtPMjwQzxeC/TlzvcuBPJff/fQL8aWelnSvhYPTOE0Mx9pqHwgJBwke8+ey6L66ugcE1T0GrRkrYsrSyjhMJZ5Kh9urvDV+HOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086652; c=relaxed/simple;
	bh=MJZb9WgtR26ibaCX09lOT9hjMA4Z8tTr4ZXRgwwKmtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AC1jzD+0CWJ6DynfL0PbFUJZ370RjmSswEfDbtg3eskvLSxpl65ooCjWuOH6TgnMaJbgADfR3COqEcMDkrfaSS2Di1AebWzI4qhw6hZfiXZrK7GFidjVpZp9Dc00eTrXtw0vVx3dDlPdkO/LFFLOUI2O8EVRXG/97Lp1wgyXmsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2ieVHICY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jX9WV7T7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2ieVHICY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jX9WV7T7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6507314002A8;
	Fri,  5 Sep 2025 11:37:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 05 Sep 2025 11:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757086650; x=1757173050; bh=kWmy6meMx+
	pAXv5lEJkb24QvaplPwvl8I4dpu14ggpc=; b=2ieVHICY9pRoKW8MI0uIuw5OO0
	8s6WUdD2im8M8SdHHv4nOMcE5mLNMpjcGvGlXcO55Heq7nHC7xCMtE0YKRwpDPm5
	2shxLetA5rI04Pd/4pBwn/xDLyVoSKyBKtmrvd5UwMcEkimlEq0dzg6Fg+OU+jBw
	+YoTY82TVkO6Lj0LyN0/YHeDE12YR/+UqKn0yL67NBpyv8vlAiKfIETESWHQZlhY
	U+WQl0wFprLgkUGbZuIZKXLTYOJbjE1InX7eWD1g4HlXUtvRBOyFZs7XeYVlvrs2
	8Q4gVJEmaBVCE4+DtaQWv4Pakc7T0hi+27vuVbhalwOx6IgqAwvMwRs4BrZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757086650; x=1757173050; bh=kWmy6meMx+pAXv5lEJkb24QvaplPwvl8I4d
	pu14ggpc=; b=jX9WV7T7hCj9Lh2NN8pL1wq1jah9yaPZtHrrc+EMJqz7WCCBPRU
	gAhb3ggPAjSH3V4kK2iv8crNHCD0vnFmj+Arr3kkWVyN4WEyniIguY0zC+VCZbu4
	vrK4uazC+j/ukahZzOpm/FnSjjbEr610UOqXWNW51VRq5l6cEP2JAFV4v/HOYivB
	Cl85AWneIcHEn9Oz6fYadW3xuWae2VkgfqMD4SCTis9cXmjNnfRm4iHoVSmmWCC1
	3GnEmdJXA6GStXFji5Lwohj5jHX91wNYbByGre66ZPLtdAdKLR5q92gyBf7wQ0pK
	CiLOt7Vm0nfR6sFMgGSQIcN0EhLZzXvSC/Q==
X-ME-Sender: <xms:uQO7aJqZg_0aofrO_BTOCJSie_DABlFa-v4P06gJtL16MLxVPf5r0Q>
    <xme:uQO7aGbTLKt_EnSwPoji7zljaGizzbtVc2m3HZzWPeyz3jWNVERI6gptq2Dmx7bix
    epup3rHaHk56pZwnQ>
X-ME-Received: <xmr:uQO7aFF2rorz9MVWhYZJ0Zja_wIqYeawE1pMzp96qh84EdNO-m1KolQ8MQSmPxKmA7hDP285G43y6xCTu0wnOmKDRroDiLMj_0Qvbg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uQO7aLp_ibfLBOYQe_qTEoD0vDWfv10baiFJMfeCH0_rpXtyOsBgiQ>
    <xmx:uQO7aJnF7oezH5tVSH59i8J9vslkhE7YqGxjw88cinvO_-515lzZbQ>
    <xmx:uQO7aAvY-oVtKJPJkw5YHH09aQhAquX8dbpxfd3tZlp3UlBUK-u_Aw>
    <xmx:uQO7aIfv549MfEBtt2sOSh9aRkDgl0p9kZYvxVwN43a8tlDgII0s0A>
    <xmx:ugO7aP66jXTQAx4jrmtwHhd2oTIpIjPBiojTuqr1Pl_xucZh7N9h-M2Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 11:37:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  "brian m. carlson" <sandals@crustytoothpaste.net>,  Taylor Blau
 <me@ttaylorr.com>,  rsbecker@nexbridge.com,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Josh Soref <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Brabandt <cb@256bit.org>,  Eli Schwartz
 <eschwartz@gentoo.org>,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,  Sam James
 <sam@gentoo.org>,  Collin
 Funk <collin.funk1@gmail.com>,  Mike Hommey <mh@glandium.org>,
  Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Josh Steadmon <steadmon@google.com>,  Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
In-Reply-To: <ba386547-10e0-45e2-95ad-c47e84919abf@gmail.com> (Phillip Wood's
	message of "Fri, 5 Sep 2025 14:14:43 +0100")
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
	<aK5mJI1NfVQDmDXN@nand.local>
	<01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
	<xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
	<xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
	<aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
	<aLfU5sEa-RE3X4G2@pks.im>
	<aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
	<aLl6iFXeAvL_hvqR@pks.im>
	<CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
	<ada227ec-94aa-4563-800e-05c116a361a8@gmail.com>
	<ba386547-10e0-45e2-95ad-c47e84919abf@gmail.com>
Date: Fri, 05 Sep 2025 08:37:27 -0700
Message-ID: <xmqqplc43o7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>     This release introduces an optional dependency on rust that is
>     enabled by default. Platforms without a rust compiler can continue
>     to build git by passing NO_RUST=1. In six months time we plan to
>     make rust mandatory for building git. From that point git 2.x.y (the
>     last version that can be built without rust) will continue to
>     receive security updates for three years.
>
> To me the important elements are:
>
> 1) There is a short period where rust is optional. This allows
>    (i) Distributors on platforms without a rust compiler time to notify
>        their users that in the future they will only be able to offer
>        security updates.
>   (ii) Distributors on platforms with a rust compiler time to adjust
>        their build procedures to include rust.
>  (iii) The git project time to gain experience of using rust and writing
>        the necessary bindings while building with it is optional.

Good.  I am not sure "short" should be an important element, but
having a known and agreed-upon deadline helps.

> 2) Rust is enabled by default so platforms without a rust compiler are
>    made aware of the problem but have an easy way to continue to build
>    git while rust is optional.

Obviously there is nothing to disagree with here, as it is the
definition of the word "optional" ;-).

> 3) There is a period of a small number of years where we continue to
>    provide security updates for a version of git that can be built
>    without rust. This is intended to  allow a realistic time for
>    distributors on platforms without a rust compiler to port one or make
>    other arrangements for providing future security updates without
>    placing an undue burden on the project to provide security updates
>    for niche platforms indefinitely.

I am not willing to see such a support for multiple years, though.
If the first item is 6 months, this backporting stale releases
should be on the same order of timeperiod.

If it were "3 years of optional period, 18 months of backporting
security updates", I would find it more realistic.  It would give
those platform maintainers enough time to robby, fundraise, or
otherwise campaign to bring Rust on their system.  I personally find
that 6 months is way too short (if we are _only_ looking for an
excuse to say "we have given them ample time to react, and now it is
their problem", 6 months may be good enough, though).

