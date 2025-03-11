Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A61F09B4
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736189; cv=none; b=UkCd0mU1D51Y1CaQGfX40fGw8Noru3g8NyIgr1m54AaMumpdSwJYH7B7uUOMaT3VoEwlFTpgzbuFnZh8/nE5353TceoorNxhvkrt8gLXJxlV2Gs2/pOGjLDSnsgUm2N/BZZt7W/Lv2A3Ge58JnY6D/IhOsaxFaVG2HUnLiIJdRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736189; c=relaxed/simple;
	bh=h2vV6OXol2+o5S6LrENYZXc/I8fHHkCWNsGa5eDqYoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N9MfkeVF3K72drw4af9GFrr4zkH0s/sJvxzZnTH7uWSWOLQc1BS2HGE8RjYKdoAgQ/iuNqXvXstnrImoqccWS/ZOlUgfeT7aLK2VlrTNc+kykR1A99Q8cg2bQIfVMIYxkdpX/sBG507sEsIErGk4IIWHJXTjVcI1ExqBd0O0MCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fqjf+OMH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p4UcV/1m; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fqjf+OMH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p4UcV/1m"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D9D9C1382DF8;
	Tue, 11 Mar 2025 19:36:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 11 Mar 2025 19:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741736186; x=1741822586; bh=dPJAZFkcKu
	t166t5h95voH6Ue/Xp/Zn0GtGUyjT0nfM=; b=fqjf+OMHOto1dnMONosFHw5sP6
	OWHJ64CCcdEnfwvoC+zj/cFA2WWwfwTOvVhFx++7c31S7fwbMXpAtDFSvricVIUT
	T/FK3Cpjq6koYj28/1qLOJnWPNGAq7OKL+/owJgYRPNZvkFuT4v+VZpiojesJnkX
	UmfkmmIGKSRiZ+EV1ptRDFq0xwhn5pqF7ZnM36In11XmiiwgYrqMPd1VB3sGXTr0
	VxB+qSoHecNW8AcQ10FIatrCtO2/b3iSTkEfRZB3TdlsXDdvttNrdzcppBFZbxD7
	ZN7YsLv8Qw/ljQWgzYj2UcHcPWtbgrbktn9WCdy0nrhyTxEDHNSiwjikE+sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741736186; x=1741822586; bh=dPJAZFkcKut166t5h95voH6Ue/Xp/Zn0GtG
	UyjT0nfM=; b=p4UcV/1m6LD++AQ6PsYEoWYt1acnEiugYHHxzNJzjr1eCJ/xEqf
	y8dJWO8zCtlGgfAm0oOpdZ9zB2/HRVLEv4emSbIczTYb0XN8oTf94TykEwRexU0S
	UerEHPOYTSgcW/ncB4y+zp5/dKR+WGBOFMeB+nTz/Av1vXPcIlHGtH2WYUQLttd9
	wK064wfQ2y7n4XwsD29mbZlyuCvvJKKigXsN/gwiqigM9QC+JokflNyP1aqy8/NL
	Bk260iHU+j72CqN8sLcetegMxZzbo4gm+N25MtHmwYWXHncWe1yUwUMIqn1y57Gs
	+iEL/Ruu8tD72UTLudk8ZGTW9T6Cu6GwxyA==
X-ME-Sender: <xms:-sjQZ8QKvYYrqlkNNx5C19hy-bsHbhpyKR-jmqHrfYfGG3b-Um1NPQ>
    <xme:-sjQZ5zJz2ItH51Lgj52-g7gRp8wenKxp5DJ5wXNdlWgmv9Rnrcj1iHi9OzdtuTr1
    0_LLxvr_PvlR8ppHg>
X-ME-Received: <xmr:-sjQZ51Xy9w6_EuNscYWOPocAEd9Pyp2oFQnuDCVDKjFjMyyo_l8DmIfVi4KtyJ593RV3qo77sMU5k08fMcKxsK_Q27jYi59q_fa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:-sjQZwDI6uLvsWyZ8cCW0Sgw7kRctyqJ8x_JwtqyX0UFERZfvr6K1g>
    <xmx:-sjQZ1js6ilmWtowf3or7J6pcUkV5hk8Q_Qvy0bPCzPUoz6RV2A9Bg>
    <xmx:-sjQZ8pNZJu44XH5vBfANM3jvoBAVHPZJUAw6WrUrvXdOLVwkZK5yA>
    <xmx:-sjQZ4gsbpyURRfKF9hLd04K1ivfyIHIJQHYZvCi4ypRfT_wNOoiDA>
    <xmx:-sjQZ-ZenmgR48Uq3psXQxAJrmEywWxBGGLHZQ_t00J_O0o8Xu_FH0uc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 19:36:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] promisor-remote: fix segfault when remote URL is
 missing
In-Reply-To: <20250311230601.GA72712@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 11 Mar 2025 19:06:01 -0400")
References: <20250310074053.1886097-1-christian.couder@gmail.com>
	<20250311152413.1059343-1-christian.couder@gmail.com>
	<20250311230601.GA72712@coredump.intra.peff.net>
Date: Tue, 11 Mar 2025 16:36:24 -0700
Message-ID: <xmqq5xkf2l8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Is a configured remote with out a url key really a missing url, though?
> In other contexts it defaults to the name of the remote. E.g.:
>
>   # make a repo so "foo" is a valid url
>   git init foo
>   git -C foo commit --allow-empty bar
>
>   # configure a fetch refspec, but no url!
>   git init
>   git config remote.foo.fetch '+refs/heads/*:refs/remotes/foo/*'
>
>   # now fetching will use the configured refspec with a url of "foo"
>   git fetch foo
>
>   # and git-remote will report it, along with its url
>   git remote ;# shows "foo"
>   git remote --get-url foo ;# also shows "foo"

Yeah, that does sound like a more natural way to look at it.
