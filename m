Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A04288D2
	for <git@vger.kernel.org>; Sun, 12 Oct 2025 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760228138; cv=none; b=Q4JiD4z1iFpk6yMeazioZgbpacXyQwnv6pYxflgDaJA0WxI244cPx0D4PABmeyf/uCU8VrOEEVHxAdPP3IAggzp6r74eJss6yzRA/NvAYQRWi48XRRQfpnN8GjxA/xY/eKX6yksMpNlMKZ5h9+EuynrHtmcbVfC21tec9Pro5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760228138; c=relaxed/simple;
	bh=mwx8NJNwSnGHvod545KEenMfjtJgFPrL2wDEHr9T5uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWAzuwUA5rHeQd6kUv9qWcBH0e8cOP6WMMjIfOKQuuSsNtz+7P5WMsvnHXjMXANERgHjHY1FT/cYBfB3XtLFpqFDuRwZhQtH/X+AQg6bsd3DGh2QICs6w6nsBsDSBj6qrZR+kMmY+LQovdi3+bY7YQ8CvnmesusXgUe+O2nA68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aT0b00Xe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ocPL3jJu; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aT0b00Xe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ocPL3jJu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 783331400068;
	Sat, 11 Oct 2025 20:15:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 11 Oct 2025 20:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760228135; x=1760314535; bh=9F8f2MwtmG
	16eJ+fwg1b8jep9kt58WRk84mdw2ZbgMM=; b=aT0b00Xeke+yH4zK4GPfE30AMr
	ABVNpu5CMqkXghNOOXdzw/8s1kIEIf9XEjKHJZ6TWECDnNzVHiXdX6n1sGe47JG1
	jQHAspo+CzE/TIbxm08mt402BKnVgOzBE26AYcCKZkQBrzuu8XMht/c8TQnX9grl
	rrNHlUmhwJZhm4UnsIMbICTgFHiucm0Njo8g4YccUH4ZufmdQFoMvDi7ShBbF4bf
	CGwwOYoiHrXuwnS2QtYHRB1R7d9trXNPMkvPnTA+/3i5fNl8+PD8w6iaerSBoVB9
	P9XIBhZLXHP7tRYAG1/pz6xY3TJb5SZW2MuK1ZGYUyhozLYGITKIq3OC633Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760228135; x=1760314535; bh=9F8f2MwtmG16eJ+fwg1b8jep9kt58WRk84m
	dw2ZbgMM=; b=ocPL3jJuyRBvZWaESmDjv/jeXWpp7wz0eBWHzxOmYt3SKAQ9n76
	ZpcPBLoI+CZATCSnXQl/UgY4AQTo5RpAm7K37wW/4SfEAp+XA0ybKP8IFpcGh72z
	m7YWJZSDODOfjW4RcPBUWiXMIy5O0Di1IxpYmQMvmbMX1yCt+3XmGQVL514e5SXJ
	DMaVC77tTvdA1vfsqW+ZY35nqXk7YTeHRGnqRTlue3eb6etaRmI4KA0KS/quGMWI
	VJNM/D2oZi2eoDwCA0Xd2M+GJMzsQG6oeFxBx8xsg2NVk67moLCtZoePUYtDbWwC
	vRMSnObcjuFKJ6VuaLIHiUDdwqvTij9Cf3A==
X-ME-Sender: <xms:JvPqaNOipRB1nrX5KaQsxlWQ8iITlzadSh5aPWmLKhO2HRome5PV3w>
    <xme:JvPqaIL2xb1ZX6Kpcu-mQPUFxlICZuXyinfqk0WLX1WO9LCE-EPjhZatl_IJmD-TS
    ShVtdxG5mZbjoGA2y-TVHB58jdYfEMxFl0j7IB3JCT63AxgQXp_5eY>
X-ME-Received: <xmr:JvPqaH2DFS5_lnShl3QeIjos0W6RoonrbyOTIhMt_2GrlJ6c426orTfNEbf17SDP8JQjQ1HYqt5g-2HzZMwiOBCWDEkUqMmUlBnt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeffeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:JvPqaEXQ__KFsLGMoErmURN8Y8inM6Yt41jW9shNhsKQ_WyWqW0_kQ>
    <xmx:JvPqaBPv8xgwhjeJCdqMpy_4vijsvrfPbAU4gYtZQwV_a0yEbL97sA>
    <xmx:JvPqaP2vEJ_bZ__44mJZK7Od5OeJSoIUgBxjqRBcjCQnK33LtLPkWQ>
    <xmx:JvPqaNRXPys5Pqqjr2y7p4EXrDdsMrR1U-Js1yoVQE3JieSixDAeMA>
    <xmx:J_PqaFT5FpWUJ84H4dMZPKom0rrVA-_pdvt7OSzG1K3HT5MVa6XGSfNW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Oct 2025 20:15:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <christian.couder@gmail.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Collin Funk <collin.funk1@gmail.com>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/5] lib-gpg: allow tests with GPGSM or GPGSSH prereq
 first
In-Reply-To: <aOm9fLW-8_oJQZy9@teonanacatl.net> (Todd Zullinger's message of
	"Fri, 10 Oct 2025 22:14:20 -0400")
References: <20251007122958.1089680-1-christian.couder@gmail.com>
	<20251009122457.1273701-1-christian.couder@gmail.com>
	<20251009122457.1273701-3-christian.couder@gmail.com>
	<aOisaq-rSdwjwo6b@pks.im> <aOkTs7G2GGLKajUf@teonanacatl.net>
	<xmqqbjmeafqm.fsf@gitster.g> <aOm9fLW-8_oJQZy9@teonanacatl.net>
Date: Sat, 11 Oct 2025 17:15:33 -0700
Message-ID: <xmqqa51x561m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> In my recollection, they fail all (or nearly all?) of the
> time in our CI runs and when I was building git for Fedora
> infrastructure, they failed consistently on the Fedora
> builders as well.
>
> They fail rarely (if ever) when I run them locally, even
> with --stress options.  That made it rather difficult to
> work out the issue.  I thought that it was a timing problem
> for a while, but I wasn't able to find a way to demonstrate
> that.
>
> Thanks for the willingness to suffer some test breakage to
> see if it can flush out a fix. :)

Or I can just revert these two patches if nothing happens ;-).

> I suspect there are folks here who know the test suite and
> code being tested well enough that it may be really obvious
> to them.  Whether there is an intersection of those folks
> and spare "round tuits" is another matter.
