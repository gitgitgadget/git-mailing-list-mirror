Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E74635
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735344045; cv=none; b=epg5yTxDgLwS8wfHYi8srQ3xf04kx6U7eDjZyVnDk5gqIi7sEtQjATTGr3UHYc9jYnzhgU7YG+h/3VecAO4rSeLGtDyHHXgjlRI8x/urtGDv0obahS3paRtundGXc1zL9d1kiqyHD3s8OkbEr1IDryuw+e0aC2wQ302YURu9ndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735344045; c=relaxed/simple;
	bh=GoCcyPcfSU6ooAw7OEfMr2eWVa1A09VySkZpk4Lp9dQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cyqrmK1pGhmSYwy/fpd/07W3zpk+Lr38NdknWOMAVj1/D/DMR3d+wGC8iOrg71vPdW/dcGM6KwYFc4CTcpYUJ1UBC0cmUsA8N005hb4mtqLBRb/XhCs3iIhoy9EFwx1b9MZYBv0aq+7uh7o1TarM5/Bwy+Z+I9h3IYYKy/fShvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sW9weoz3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IppGoFH5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sW9weoz3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IppGoFH5"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8ED9C13801CB;
	Fri, 27 Dec 2024 19:00:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 19:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735344041; x=1735430441; bh=iOCU0+rRvU
	fJAfdnSSI3S7mFyf+Kid9tPrR6NbdTy/s=; b=sW9weoz3R6qnK9Y0Ue3d5HlX0q
	M7MtJXvCP8uxWy134UuPg9lZ9wtlRDKI1dJoyGWu2fGGDFGIaDspmBvIg47ytBW/
	DO6PR0keDUV5m8cyCVCGW0S3XMaH2HiMl9f6gQLgmpJjPyy0KXxUBPljKaEG8unl
	8DrcgF/SP5XVH+xfdNIGOl//9ADX5bwipvO2xP4p1SeG/s+un2QjPMcJdt49JoRg
	DlcuSwlw/M5ERPDO3OfE6kYujIBOu6I5JLFyZKGSeWRmIIhXvlWCh+1h2mGgaSyj
	5pzsgCN+44MApuT78xi07j2fXRdqd9jX9YLFmpS+HCJKHzghj9680TKvqjsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735344041; x=1735430441; bh=iOCU0+rRvUfJAfdnSSI3S7mFyf+Kid9tPrR
	6NbdTy/s=; b=IppGoFH5p3UiKWUM7Iw6vCUIbXxyUbY56ndmqEJyegCuxeZWWOC
	lKglb91yVOr3w90jJGE1FziOlwTOZHG299Js9iWavk0OQN+djtXKEmyk5smHaVKm
	VIbq4fRYfJGQwJ0O2pHLSV017sWBBbJgiI2ity4YzXduN1p8KLJi4Zc4Q2mCyclM
	+AkNc1M6GxxyzzcxTzZrzSMjbIJ8okSji2zUjYD0QUx8ARalyH6sDY43g0bnugXn
	uRxM34ZZcwQX4IINEJz4+1rn4TskGdqDnFpfXaJhw7W+fnKLfTQmBfp7z2h+bikA
	FKMj0L6zzNoRBzCaStGEcAocy2+Nq0BPMaw==
X-ME-Sender: <xms:qT9vZ9wkxvQIj2JZE6Q1gPIY0T4ubYlgXwmr2HLzZmP-WEWHq2nyOg>
    <xme:qT9vZ9R1QUhswM3YXCCjPI3iAwPwy5jy5KmVlEqOWrAAvVXBO4vU3gYWlzAFhzB9u
    6rrnScy4n9Vq5-3Cg>
X-ME-Received: <xmr:qT9vZ3X7iwLv2JWDWhH7hi0PkgPo5jcbArQgZKavGgAzTM3XukDc0MCxH6ciVtdrfDIGxsQtdAj3U-Aydf4emR3nLng5q6KxLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvuddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:qT9vZ_iaRGSsfhZXMG-0Cw-tltsUXZaHj0kUGti4XBgB87viO7pq3g>
    <xmx:qT9vZ_CPVH2YUCdR9E3qs-ozhykD2pM3R6Um1JeggoQlkIHriOM1YA>
    <xmx:qT9vZ4KFeaisq9ZmJ6Vs9pED_5S2v4pyIVRXz1qABELHRKxHcTTHug>
    <xmx:qT9vZ-A1JiyDfnx0HjUEcU44oa7csLNPxZZCAVG18_zzYd46dvu9WQ>
    <xmx:qT9vZ6-gtKr2o3BeX6RFUi7702TpcP2TSjlkT3i831Ricardg_8_d9MW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 19:00:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/9] commit-reach: -Wsign-compare follow-ups
In-Reply-To: <xmqq7c7kubx8.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	27 Dec 2024 12:08:03 -0800")
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
	<xmqqbjwwucvy.fsf@gitster.g> <xmqq7c7kubx8.fsf@gitster.g>
Date: Fri, 27 Dec 2024 16:00:38 -0800
Message-ID: <xmqqbjww65i1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> So perhaps something like this would help?  We are no longer making
> a comparison between two integers with this rewrite.

... and this gave us a first "pass" of the tip of 'seen' for all
jobs since for quite some time, like a few weeks.

