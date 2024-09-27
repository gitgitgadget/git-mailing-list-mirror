Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D0EAC6
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727397881; cv=none; b=PrXrOsqydr1I0Plt6DvyLjNdxolMAJ8MUA1+qDk6zIAtti2e2JFmjjaVHzyAI4BcKyWx1ImsuxCpEt2HBlRd/lQosmQ+/ZboWeQDNhBvEq5kY3Mw5nrIzZsORuF9amtYN752Duv0U85ZL/gEUgVDo66xDjDMrO730bD5cVTmPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727397881; c=relaxed/simple;
	bh=Ll2PV09XNPypwAIwQrk2XrhfxCAYKwEpV+6/HEL/Bcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fCZPHgXfkuxKCw8Smtp9ikDluCt5q1CtQIvKYEO+AiBWLaZUA2P3PiBAte2Ph9Kro1JC69Kro7wD7qzoo1XU74anWGMGMPZlSn5gdwAg6w6FY5nOn7XVKyWAwna9o4yX38vrcvbAd+OHdwcG2CcNqxS7zBUgJVcxcfmpebgXPdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MUsFPqZb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzvGFT2U; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MUsFPqZb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VzvGFT2U"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 88B011380240;
	Thu, 26 Sep 2024 20:44:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 26 Sep 2024 20:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727397878; x=1727484278; bh=4JY4gAaAyS
	kPD/29ZV/HfQKBdRAmIqT1iTgpt0aEBzM=; b=MUsFPqZb4mSxgkfC4ifJdaahG8
	Ps/XVgY86aysLWqKCBTyvmAawM02IN/gI/4Aci9Ul84iQpvxDkhZVtFuAF8UrgXz
	TSjuj+LI6XpmCE3O8kFcbuf226mgOFQdA9PUNJcg7AhxYFft/GcrStkW8TRVHZv6
	31fhYZOWgFYwsIU8lSKmLlgVmxSzj4gL/+M4fNvSPwVoI2RKpdfnaA3PXqMaM0Ke
	EOWnHGHcz1WNs9bQVnPaClp8iQEGE2HGVljdFvysq+U2r+HqdoHpwYtK6P3kPCzF
	VIXi0wrac8Rn6cTPtEF0i/EpVj93KJhWY5JoQTbrbq/Xio4z0oe7XYnCywfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727397878; x=1727484278; bh=4JY4gAaAySkPD/29ZV/HfQKBdRAm
	IqT1iTgpt0aEBzM=; b=VzvGFT2Uj9zB9sugYyFgRK+QQITaFpZ0exsIWjyAEXYz
	f9f2xOiPzPRVrU3JDx7qp2Q+n/QfTWXkanzuzuXVtjNQid1rsgQDKB7FxLstYWUw
	/FAxts9rZzLPI9NuvuhWUZyVulAkL66BT0R/rDFs11jnUhDYfYOiJ/jMOS2P6AAn
	oINYNrPKPkS5ZOZVPE2g20On3jXHIRftft/0C+WZgF+i0SYUGpkZbYNXymmrhNxa
	qdToGapQ02VdRcme+ArUqLcF6uK5aSzNRZG7r4nKTX5FCRM5D3H102LC+E1dWbss
	EUgtlsOI9MlTq6oDIFOK+6t+MueDthmnO2t9zosvRQ==
X-ME-Sender: <xms:9v_1Zh4kGrUAiJa5duxc4A8muAtcNEOgYAst-dyuMrZmLiJC399JFw>
    <xme:9v_1Zu5wMjAqr41c0KiiVUfx_r0wpBESQCTXl6B5VG34ZrUoDU4MBFNSyyelvlcB1
    P_lnJDDiosL3YXMKA>
X-ME-Received: <xmr:9v_1ZodBuE3KoX_a5JY52eO-hcC-otnsYBS_weIZ0cyqFJ1l4HrU-pV4rrsSfLm0wkvYLtY639wN35t7lsCgPJyxAPiCpjjJ_xuV_iY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtkedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9v_1ZqKcqmGwyY083yWatSyUsBrc4qLyqbEaxpEPxJ7FcJYAObefyQ>
    <xmx:9v_1ZlIB-vtp4qAmgfkhfs1ppZMdoQg_Ev4GITDiThWNvMIDrIz-Mw>
    <xmx:9v_1ZjzYILtd3fgA5jfGItonQaGLFXq56RE8E0v0NWPvNHBUyI_yvw>
    <xmx:9v_1ZhKLLwEKfNfZRkP5cS8DOFPs-Od-tUfb-iKNVF40sZemz-bQrw>
    <xmx:9v_1ZqoS8v8JcTJuoBbihBLOJKcFj7_6SEkcNzDtnJcIdDGuDMd5mXs8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 20:44:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/8] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
In-Reply-To: <CABPp-BH3y96DjapzLPJ+vCoChQiD_wR9uLc3QPsXqzSUr4AFvQ@mail.gmail.com>
	(Elijah Newren's message of "Thu, 26 Sep 2024 15:47:40 -0700")
References: <cover.1725206584.git.me@ttaylorr.com>
	<cover.1727364141.git.me@ttaylorr.com>
	<CABPp-BH3y96DjapzLPJ+vCoChQiD_wR9uLc3QPsXqzSUr4AFvQ@mail.gmail.com>
Date: Thu, 26 Sep 2024 17:44:36 -0700
Message-ID: <xmqqy13egc23.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Hi...
>
>> ...
>>     -    , and generate the resulting "clone" much unsafeer, in only 11.597 seconds
>>     +    , and generate the resulting "clone" much faster, in only 11.597 seconds
>>          of wall time, 11.37 seconds of user time, and 0.23 seconds of system
>>          time, for a ~40% speed-up.
>
> This round looks good to me.

Thanks, both.
