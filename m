Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923017BB0D
	for <git@vger.kernel.org>; Thu, 22 May 2025 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747948525; cv=none; b=deiY+Xjsi72f8cBWK7oXUdaa8HEH9TZjm5Ch0JpdsbdRwdNWte+5foOOnlXjsacs7Io9GAlzu2+PwOVyLXFe7j3XSbRpDIdcUcOeB+MAfSGzjv5FBG5bu88Vx/ucWz6N8SWonev+Iw55dnHGDEaYM0RwwyOM4sJL1fZUk9vB8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747948525; c=relaxed/simple;
	bh=vgGWDhV7meLP/3pptaS3W+2r5apdShuKIejTiKWNxsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eRPHcKRnY/ZDzaQ5RyhTvlhUCQJ9fqAZXwekYgPjxbd9idB6k2JuDUp9SwNjBgEi+IqeYhooPFx0Twde1rc4/HSP1RAnpUXA0vSStINKrkO2+wgFmVX9s7FYKBmKv3WlFI2PeBCwGlaiRq0EQE0hzgADdWWvm/57GF5xSooO3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oECsRZk7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2qaaHCE; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oECsRZk7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2qaaHCE"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1B4725400D9;
	Thu, 22 May 2025 17:15:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 22 May 2025 17:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747948522; x=1748034922; bh=O2/csuVaQk
	08la5NqrWgG+R2q9ncOv6hoXo1f9E3duo=; b=oECsRZk7noJW6BWIfiZwe8R6dz
	dL/lCyOCINvW2zsqZT5U6cds55TgpJRaacJMwGsZOVdz++FcJ3xWm8Tqgy5wS04C
	w7XfQzqUjPsmYeEQfW9qHuMzvalMqs16vxuDayQUjJol1uEnCWwLyfS1JtSckALe
	KCQ9jhVRsQzvg0fuoKj8Bth9iR2dXddmfIVgZ4tgvc/rukZsCfLo7cQ233hW07Yw
	OpBAasyaB39+dj8QDoUlb2BoqZtbSxg6L5hYkiDSLWiGcRaMAAQTHgMCbHKFPHC1
	Dc+4MVMB1TLExEiSr5TqMYHk3n9BSZoOJYpjgM/qDzIVQA0P/7RiPrVvF/AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747948522; x=1748034922; bh=O2/csuVaQk08la5NqrWgG+R2q9ncOv6hoXo
	1f9E3duo=; b=V2qaaHCENgUm2EKhKk7PtVF22uQXhQRGSELGB4s0/KmBsTRW348
	iH1qOwZ7msrUec+Lxab9/pfpoLP5kb62di8Vwwi5Cto+6imDV0UolSLQcyhoMidE
	fvGo8gTLh1+M/gJblS6EWkpzUWdvycyQOe0V5bSYA1KEoYOSu+iiNVoXoFDgY8st
	668TmNDb90rNwhHyLmdzk/ei5IKSmPKEnYyfK9HylmZqlWCuXuaqIFBesV9Ivl9g
	y0SGzSu8iGO4Ylkso2rI4qthzeaIIC4nbP/Vv497mAfjLJKXbfwp1jIQeBYOVm1s
	MePktmvsDgCYcwSqI7CYfLUt2xpXViVEZoA==
X-ME-Sender: <xms:6pMvaP9sMqjCuINw6GASyFrNS5eyKqt53la2qp-GBJSzjRoqrG7cug>
    <xme:6pMvaLueb9BL4WUQ3a97IdtXSjv7zhZaLNY1BLGu-Z0CSsTGcgEBM7iZxEgb9HSXy
    1QMe57SfFzCZCrnmQ>
X-ME-Received: <xmr:6pMvaNDv5n1YUeuV08HyL6Cb-shaXBZDQWcNVtOtB2POitkwypH487k8MR1tRwReMl44nWfKMggytOh-IGeztxJiyXjOC8noWoX4RUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejtdduucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhn
    ohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:6pMvaLdnbM_qMiYGBOs0sVlmNy48NUhI7TT8wmng1e4TomQV7UEPvg>
    <xmx:6pMvaENXTkFbfnE-7lRig_MANJTIjJulwrpeJZgQ-3-rxXqNGUZ2kA>
    <xmx:6pMvaNn1az024e1B_zjGEsWqsOhKRrCDz73EVczAGf_w5qBKT2VDyg>
    <xmx:6pMvaOs0gmpCEF0xlOetWDx0zdhU-rs_ZkbZdPP4BIzhqIqW4jTJAw>
    <xmx:6pMvaJgQFCYMGBgoCQMNpRTZ5u-3kdiYspcATuaZP3amiiBczaianPSz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 17:15:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Phillip Wood <phillip.wood123@gmail.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 5/5] builtin/stash: provide a way to import stashes
 from a ref
In-Reply-To: <20250522185524.18398-7-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 22 May 2025 18:55:24 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-7-sandals@crustytoothpaste.net>
Date: Thu, 22 May 2025 14:15:20 -0700
Message-ID: <xmqq8qmo4aaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Now that we have a way to export stashes to a ref, let's provide a way
> to import them from such a ref back to the stash.  This works much the
> way the export code does, except that we strip off the first parent
> chain commit and then store each resulting commit back to the stash.
>
> We don't clear the stash first and instead add the specified stashes to
> the top of the stash.  This is because users may want to export just a
> few stashes, such as to share a small amount of work in progress with a
> colleague, and it would be undesirable for the receiving user to lose
> all of their data.  For users who do want to replace the stash, it's
> easy to do to: simply run "git stash clear" first.
>
> We specifically rely on the fact that we'll produce identical stash
> commits on both sides in our tests.  This provides a cheap,
> straightforward check for our tests and also makes it easy for users to
> see if they already have the same data in both repositories.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I'll need Phillip's sign-off for this patch.

Let's Cc'em, then.

Ahh, it occurs to me that your pwodd may be a typo of that address?
