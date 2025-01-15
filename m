Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646114A630
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963352; cv=none; b=KsJzLlLyUYf/FVvc1QMC2/GteLbtq/7BXxc+jWvOt3dZ3DggB/+U1Twqg8fKpmPqM26WdlR2trM39XG2aVouA2TaobhLXcAoYWeE9r/vSUIUyzUAUI4npaFQfRxI5ImvrRNCbzLbHvhfdGBu7200VykTPpqXmh6RYBnxLdrN3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963352; c=relaxed/simple;
	bh=yab6HdBQrjaJgwVU5tk+ZGqw4E4XSjpvl8WQXPMP4n8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HaBzog/5drt3Yfc5sXC8vxQOvk2ir1+ArqhxTnbzoQmyuEgtzi++WVteZA21eylBn2C4GOl7HlroamRdfz/4QHogUyQAqpL14Xf8jJjivWdcin6vsI11sTB1zM//tzk0p/R7e4bIDAIPeo7WDYrby0lHxfGvsfwkRhjelfZqScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VD9aQopt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r4Tls0vr; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VD9aQopt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r4Tls0vr"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F9D325401C6;
	Wed, 15 Jan 2025 12:49:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 15 Jan 2025 12:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736963349; x=1737049749; bh=yab6HdBQrj
	aJgwVU5tk+ZGqw4E4XSjpvl8WQXPMP4n8=; b=VD9aQopt3Dyca2u+qEV2g/r9d4
	2gki6dqr8ALym+E3ozPkyRtbXtcrTs+2ibzWsQmO1w+GWX8EWd4sTMxvt570PVFY
	EeuTZEDTKB0zERRbeSuLYLQ7XMbvD9F73VexLexBU/pS8WekYTb3u1e73tN63sGZ
	hzBn4upwQc8cN7udZJDW7AJQAQPEOp6E/nZgUe/s0Bk+nJZPoeN8aLTCP2DCzegk
	e1uzM6vC5Y38Fz9PUy2V9gU4Rz57gGeqhGaPBIna0TAfRIKc7ZgjnRY7KnqpvGXU
	XrJEWbAD1JSCVoz+lOO6LQMoFKKIOJGJuWAcEW07+SkTTxs/NLWnprgQRqlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736963349; x=1737049749; bh=yab6HdBQrjaJgwVU5tk+ZGqw4E4XSjpvl8W
	QXPMP4n8=; b=r4Tls0vr5EhNtsGGb/RpuPM4pTbqPka4GpwaLK/uKb7Y2xQXh1P
	Oyv7vXY8XyX7Ac1YreyJAZRcJU8AdFmPmgPjCe2UYPPTGfycugzOMtrLXlWuJ1/s
	+DGMtb25k+3GJgOZhxegzdYZ0LFtIw3X5iLcseZzAFAoneEZ2mTpFLft6exSC8Tx
	5vFTz5pmAmkujC+srsI5N1CsUabBoDPoiSunETI19IEBa3SZAyMG8Gvrc40Tv/OB
	KAfvNW0eeZbrDpr+xHC9RS2k46TBlj5x/ge5dt+FGCCXJRHPR067WnHV+qo4B6RI
	+KExMDX+pKsovgjSpda7fjj7KXlL8vOloYQ==
X-ME-Sender: <xms:FfWHZ6JYTsLtMCnOi1C37-OVN_jiafIuzSKe69QMc7xrsSfk6WooEw>
    <xme:FfWHZyJlS5hmQ4Hz-NMnDOID2-r51plzfzoPRvq_90P25Rq_FUbyJjQOQm1CcA7dI
    5D2Sp6Zg-7CMtg4yA>
X-ME-Received: <xmr:FfWHZ6vzrkPv6VMCswiRpweTdjEf75G-vMJdrSK6Ngy6bSbnCsjynpVt0fPeljdh7n3xtKNQCBBdt_D6QxtFIP1AnNJ9sJZn1NlK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehmtggvphhlsegtvghplhdrvghupdhrtghpth
    htohepjhhonhgrshdrkhhonhhrrggusehunhhiqdhmuhgvnhhsthgvrhdruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FfWHZ_bN8DBLAato62kusk2k379ZhQcAja9O4iI73EJ7Ix9vC4x8Hg>
    <xmx:FfWHZxZ6np49Ksu9TC6r0wwTCKShyQy1kypk6jW2mQ4nfjnMTgL-Sw>
    <xmx:FfWHZ7BbWAzs6xHHcl_hksm02KRGcXXJ6DLaU-C5C7wd12k5QP-9Rw>
    <xmx:FfWHZ3a73DyylwIpQx3EmsWvNCxRiQtVKOqp6IuR0tAeW6fcxy4RiQ>
    <xmx:FfWHZ2Mqa4fGmULx6014DXRQhSstrI555fNPJQEqTcqLflerS3pZNuoG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 12:49:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?t=C4=9Bj?= Cepl
 <mcepl@cepl.eu>,  Jonas Konrad <jonas.konrad@uni-muenster.de>,
  git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <20250115171423.GB57018@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2025 12:14:23 -0500")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	<20250115171423.GB57018@coredump.intra.peff.net>
Date: Wed, 15 Jan 2025 09:49:07 -0800
Message-ID: <xmqqtta0x90s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But there are a ton of commands, as you saw, and handling each one would
> be a pain. So it would probably be easier to just introduce a variant of
> usage_with_options() that writes to stdout (the underlying _internal
> function already does so, we'd just need a one-liner wrapper).

Yup, I was looking at the code involved and came to the same conclusion.
