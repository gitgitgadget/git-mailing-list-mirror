Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E90201266
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620663; cv=none; b=AFQ+T8mfhfkXx7NJEv3bv5UeVbRKyr1rCRi5L1l4gDY5SB9XtMpASUHnGDbSU+kMlRpt81+TQ/lP62bMvr/cBb/Jqtv4MR8Gf4XZoS9bA0DR+RR6nlyCZY97y2HK3yZ1YF2IAP/DZLIHdi56ujwGeQO4i3NEl+qP82J1vSrIGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620663; c=relaxed/simple;
	bh=/lA5qzOTuNWSsZt2wTrCDc4SO0VI/KHFvEsWSTBKKtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lKjkcLBUIegk0jLMVONc+iTuYQdiNFuZWAQoZs395DNfLO19t4t1l28b+8zEzYmVpN3sBQNPwMJR/elGSaSiZcmvZJKuXjP8+p9Wdit8nbsEwMT1ytjuS1cDcfLXjbVVQyrn4hzY8QVjjeZUXxnO6ydnbIMcJ9iri6sFf123fsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=clOtamU/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g45EoC68; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="clOtamU/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g45EoC68"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id E3A3B1D001CA;
	Tue, 19 Aug 2025 12:24:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 19 Aug 2025 12:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755620657; x=1755707057; bh=6nTv8sCHJu
	Wytuv7Hdmime+UhaqnLzg3z2nkVC7Y91c=; b=clOtamU//40kdy6xBpqtf30WZ8
	xgxHdJj1JI2KYBNeFsfdE2QSsxg2LBLSzwYcmkNlHwqariTO4Ts0KCNZuA4l91UD
	tEBf7AF3uqDDzdscs+6mBIgtoTvAv5DTx+XO+7Mb4wmWSJFdafRGDWV54SIuzHia
	W+n6lg/C+5IlvsMFUYvZZ1SJyILI1bLj6ZQg9vlnEmqRVoQsymEfxNlPkN9K7Sa1
	ib3tE0tJnt2Lm1Nvff998sLoTXJtB7D58n+yemceu3L96sMii05fv+O8dgWTEwwq
	fDa7h/QBYul9sOL8wYLxVqZpWqOg099ardDRyIbpNM+S4GZPiWXW3MYzX0Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755620657; x=1755707057; bh=6nTv8sCHJuWytuv7Hdmime+UhaqnLzg3z2n
	kVC7Y91c=; b=g45EoC68Ciz2jeghWKG9C3aDbEmCfbLzRcjZxNu3SpH8Po1qL6i
	jQyf749Tnuwr5tUMWFiWjgVxzz4mGIBp03GB4mqg6PSFui9EI+0hErfodAvbqeka
	kPxI7RsFxvgwT+Usy0zdmndz6u8dGvdxiTbUP/IyOr39HWFXox0B5UXOgSYpxcPO
	qYVk0stpWixYyBdwQN2MdLpn4+p18kul6IInN4rMVljjb1bmionfI1Dohr+WhKI/
	VW/5TBxJO4sNnvhUj+FgFnAn5ymhUyjSfkXfnfdJkUz6EKy+iIxdzjqh2a9CLq7S
	t8OyjD0WpWAoqrc72SE2mm5XR75NmgRnk/w==
X-ME-Sender: <xms:MaWkaHwUFMA2-JLneyXY_h3kYzaFVNQfYGe3_MYf40hErjmikfa_6w>
    <xme:MaWkaJ0uLquGJhnvVKolpA1TZJFDI3FkJHDODA8flrGPmkGc3IZVnzqyU_Hjjha7y
    7tETEEl9xfgysDkqg>
X-ME-Received: <xmr:MaWkaN70ZljCC2Y17YDARbu9Vq87lmd26SCSwKhZh49pdZDAgnr78zT3gDkewmb1W3upCjl6Z9sNxu9Gu7AZpndvlY3y-dM7iBWS0y4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MaWkaEXsvhEP1Bl7QsT18rgGlnVJWZ5MYSYyH5olbppRQQ5PcZZHYA>
    <xmx:MaWkaEDlwgrOYExt_loF8hPaqSlh6Ii1wEHEOfDd4n53SabVjdrQqg>
    <xmx:MaWkaL4v3g2RNNlk65h6MaBpnamkfNWEMiTEym2nqC5GBpupZ_bLUQ>
    <xmx:MaWkaHzu02gVksNYadsMXKkHOijEXdpvYzAqcigG0iXA1rkVBkYrSw>
    <xmx:MaWkaCikh7l05K6ur2nSUXc3SKh-moGKwxq6nnc7Dslk_RsLc1TPLV5Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 12:24:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 03/16] odb: move initialization bit into `struct
 packfile_store`
In-Reply-To: <CAOLa=ZS4vBPp=2=X98DwEk48qgFMHvM4BecUPayGAK1Wasd3=A@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 19 Aug 2025 02:57:54 -0700")
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
	<20250819-b4-pks-packfiles-store-v1-3-1660842e125a@pks.im>
	<CAOLa=ZS4vBPp=2=X98DwEk48qgFMHvM4BecUPayGAK1Wasd3=A@mail.gmail.com>
Date: Tue, 19 Aug 2025 09:24:15 -0700
Message-ID: <xmqqtt23e0uo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Tangent: Also this is something that is only mentioned in the
> '.clang-format' but not in any of our documentation, should we add it to
> the documentation? Usage seems to be around the same for both types.

It merely means that whatever .clang-format does is forcing changes
to half of existing code base without any developer input, let alone
conseusus, doesn't it?

A quick look around does indicate that with spaces around both sides
were dominant in the code base early days (like 1.0.0), but that
dominance eroded fairly quickly and by the time 1.6.0 was released
it was already half-half (24 among 43 are with spaces).  As you
reported, among 216 hits for "^[ ]*unsigned .*:.*;" in header files
(in 2.50.0), 105 of them are with a space after that colon, and the
rest without, so it is really about the same, indeed.

I think it is a good idea to just pick one for new code and stick to
it, and if we can do without churning existing code, that would be
great.

I have personal preferences, and usually I'd like to hear from
others first before mentioning my preference, but for something this
small and does not affect readability very much, perhaps I can just
pick and dictate?  I dunno ;-).

