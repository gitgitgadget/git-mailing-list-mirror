Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F01C8630
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759962813; cv=none; b=o7hdnNYrbWxqZq1bYhHl0YLtP6zODd0XSs022DG7WyudQuZ5VhBIrc1UpyXU/QnYzgbIgoR+3a99MG5m81eRsLwUmAdG2uidxaqQgdg5+Z+X3csx7P+WX0gq6DLUjhWUAs2tAHhwndBuTYrh3BUgGaFhzDwabegYfK0CDj96ZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759962813; c=relaxed/simple;
	bh=9lwXnHnMYpTIu7KXxvBRtwukuJtLBs6kR3ButESo2m8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KggW/pUd6WiasDKvQHVVossJ5hW2lb4z/7q7R6n5MtRlMgxdmpiyaUbyqHd09aHO3x1DjICvvIE8TJik4JX1+hbxTzHuzBXa0IRU2EHZbWkRfWVCOVBsjAsKBZ9AzKzYFrd2t2mZ1Cx6tF541O95mm8TW0NiDC2miumGwa89Ffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bzSSrHbx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pkJXCm9q; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bzSSrHbx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pkJXCm9q"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD1C97A0300;
	Wed,  8 Oct 2025 18:33:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 08 Oct 2025 18:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759962809; x=1760049209; bh=ilC/hB1okb
	b1EQYWaITwcumBT81B4Jqu/iy6n8gdJjM=; b=bzSSrHbxBRqap0sQtPkpMRfRD6
	oAE8eQeGfz62QbnpczLjW1wJM6iy0UL7OKBmhEbRMrSIVPotim/zcTo3Wu3/Bgqb
	s1x4EZBGQUiIbVT9UOvq0Z4t9hA7BHxdXO/bwc1d8zyC6vSWpst4VKUD8JZNI12s
	Pgj+2+iEv6BCmwE1sOZvuoFXa3OEy0Ym0w7nCHqPdw2ZPZKHYuz85mXyJAfN0SrN
	cX7AEeJyKABXg+kghbgskAZJYYdhMyqrTBmPzGS1Z8ZjCV1o+vfRAOII4J/a3dnl
	k9jDoud3Vcj4P7vcHRaTe69NqH5qtYePB19/KmGDGoIR+0evudWeJLTzDvFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759962809; x=1760049209; bh=ilC/hB1okbb1EQYWaITwcumBT81B4Jqu/iy
	6n8gdJjM=; b=pkJXCm9q0lZdKGGOXjo3GJ81oKMCLhnl2uojIOTllgdjoXFF6Et
	tHXi1VsqTVgH1RrVnEWDGeeQ3xWyKtxkck+tfEYCRS2WkyuCOhBBxJbpV4xoOAt0
	XW6X2X9bftexzhU883iSPWvOzyMxzoJYCYjdHZ6DspNygEDBPpjdb0Z95n0Di5hX
	wSmNfWzziPWeIBPWLgZ6relcQsWgJRL94smfSTQOrn5+P8GZ2FjHuVdnX2GPuiy6
	yAkjs6TYfOcGa/g/Wx8jfBHQYiQ2TcCbdZ7fD7+fg6uHXe56/8v2eAJKULr91Cia
	dKlu/YmWnnaw4s8JhmZW0OYpcGn6XQ7f55A==
X-ME-Sender: <xms:uObmaG4NVkmKset8lk_3gfNp9SwJGWxfvPkt6yYIgjPIq95tsWebzg>
    <xme:uObmaJP7CTNVtuOR-PN5iPzTFbL8s4L-3yHinb__useZsLhR1FrU3oj2msEI2Tw-x
    51HL77NWR2frplrfCSEODan1UpZ0_jp02T0m-Xr3D0WAzRbdr4jiQ>
X-ME-Received: <xmr:uObmaMv-P39CA7oY5DJgWNgrzz1_GUd8Xg8VPPsycna9ai0DMnQa8WV9F6Ji2YSf_vQ2fQGGa7JRIWG9o-pEQ0obIIu7KefY67sv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uObmaEb9fSktrxvMs06mNpJi64HUNI_q3D9dPaVbg8kGCKJY6RIufQ>
    <xmx:uObmaGwxwhoD94wSewNLhwRFG5E3L_mw5Brz2uulrpeh6UdCiDUfPw>
    <xmx:uObmaEgXdBPjiTzcxcsFnM5c5IUyzjaj0lLDk6jKmBtk8gJbUpT21w>
    <xmx:uObmaKl1_GZyjeNdm63xvyHmCcrpW99z9VR9iOiUEu8beRl-XweMcQ>
    <xmx:uebmaG1siKSCYZ_td8NiZhMh5VB2MSzY6qXrsMR2CZAF8medgcT6Wcp3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 18:33:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  GIT Mailing-list <git@vger.kernel.org>,
  Elijah Newren <newren@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/4] doc: add some missing technical documents
In-Reply-To: <3286707e-8cc0-430e-a2d3-546352d50b6d@ramsayjones.plus.com>
	(Ramsay Jones's message of "Wed, 8 Oct 2025 23:01:18 +0100")
References: <https://lore.kernel.org/git/bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com/>
	<20251002221233.541844-1-ramsay@ramsayjones.plus.com>
	<20251002221233.541844-2-ramsay@ramsayjones.plus.com>
	<aOYImjMXcFkdwar5@pks.im> <xmqqfrbtfcbv.fsf@gitster.g>
	<3286707e-8cc0-430e-a2d3-546352d50b6d@ramsayjones.plus.com>
Date: Wed, 08 Oct 2025 15:33:27 -0700
Message-ID: <xmqqms61dnwo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Since patch #1 is already in 'next', do I effectively create a new
> patch series out of patches #2->#4, plus this new patch?

That would be great.  Your original was one patch with 3 RFC patches
on top, so they are queued separately already on two different topic
branches.
