Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC142048
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230881; cv=none; b=oh6oBHJ/4pGeCzKncY339GiGdMBDNOS1fl5JS6y+15qoAFlLSjWrAw/qQZe4T3gshu5+lTpYHvgWsq7JJKMGtEOmd5gL+WoAfX2GEW6ijAMvLFYg39oZNKYkZW2qrW25q66REVW3RD6jBH4EcZDLSWufqNx1AA+Yh8nEdaKdFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230881; c=relaxed/simple;
	bh=bgNH3mI3hD5opAtazd6cOIPpuMSHXXgrHi4zxyCd6vA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BRiub2b5WguTBKfeE3S3Jh4yggvpermap+Q98gQX3qqHLAMCdsnWOo9FGJAk8cC4a2EOLqCpKYziyXA39QaLlcmYA7DbWa/2RyFU6k9Qe3XRQGk3XU1lkg/6LIvXfDCJ0qOAQYa5SEr6ZcER6MWg9ZDhUfiIR0QsO3A8DlfIYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QEqgFP+Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CfSwEn0w; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QEqgFP+Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CfSwEn0w"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DE7F7A011E;
	Fri,  3 Apr 2026 11:41:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 03 Apr 2026 11:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775230878; x=1775317278; bh=uSynApQujM
	p45r2Zjy4Ah705XJHmKuwfDCKy929m0cU=; b=QEqgFP+ZC3x9Lzx10S7tC6qXi6
	isJBMCCmIXo7OYk7l7CGSlO1Js79Kr6k60AvGp9mbqGlO67SYmUN1RP7Dbc9OhZA
	qsjKkWHGrAwrUoHAPS5lCdlfxjQiu2S3MCPkmcCTBp6qJO7QjdRIL1lAnnXoXp86
	mhE1i/EjoI2yp2GHD/a90t/ThbzvLa1EgVcUy1DqxU2BURs08R6Ec7nyYZo98VuW
	z8oRdj15AGdA74g9VI7Ruh5j+GMSLpa44zTZsK7d+GEDLIV6GbK01VrlQWW7rviF
	KOCf0J3w+solHUl22GkggVj9tRV8SXdIv6c4sJiH2gOS7mXZl/0Z4SEU4CbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775230878; x=1775317278; bh=uSynApQujMp45r2Zjy4Ah705XJHmKuwfDCK
	y929m0cU=; b=CfSwEn0wYjn+CMQDzSa6SZZq7WRf3z2XIFptIZL6TnanJKDUbLK
	WTpnGQHjFkipSOmp69TRytbGbI+xwiSEAeMg+4OZ5pkDrmfnN/Ao3xuTl7+Q6uK2
	F8wcPoeKWMNcvyU5RmizHHYQU802xYFvQnE2OCjrl+nRH0KaDIE3NFFur3ekGkl9
	xTlfoakyu1OVMNDFAgIpRa4pJatDvnHTMz+XubXMKnOCsC1vYhJLdcAgCcDwDIMX
	8OXMKX+ZqLXhHO4roZcwmRkG9QZkP7yrHCOq9qWxCywVddg9bZkQn/i+7OjfuzFu
	OhOTnhC/2PKBK2WfDbwrWCiDn8ZkzL7AOCQ==
X-ME-Sender: <xms:nd_Paej4A4l6z9ml4mRgusfPg_xQQFPxKd1NeY3g3obMI5A97sYmKw>
    <xme:nd_PaWdiA0ACUNXeLdHYQbpkIXMzLx44-Apoyiqo5_pOhAd-ouQEhCn-iwUnYyL0z
    Z7gP-jx_cmOKO0tCWc7oMsqhAl-5ClM_-hlpZW6h26cG4_N-JCy>
X-ME-Received: <xmr:nd_PaTd4S4nFYnD4aIusZQ3cyj0gCPLlrsw3KsPk4uizwThIOlKLRKE5IgmTKC9oZSR3-BaDYxzqKHHqbbTmwJuPX4qoqN9x6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:nd_PaQ8dorDPzev1XF5zw2VEarsUI4cr5OopjWLqLQ2hl9EJ4X2ENA>
    <xmx:nd_PaflUVxHeWyab7UIjUiqJwxa240lMTam97EZXPTZnobc8pM6Dww>
    <xmx:nd_PaS9lpCYFK9J5NaOJkM6wSq2nGND3T5cMdJNgDgfDuJbzkka13A>
    <xmx:nd_PadlYDp4B7nnkqacQMBdlj1G3wj2d3KWUMG1-aQw2nLDt2ghmVA>
    <xmx:nt_PaekP-4hg_DFCKKGfJ8M2P6TmXa_MU7Z4rAHmaxPZfOCokuLFw_Sg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 11:41:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/16] odb: introduce "inmemory" source
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
	(Patrick Steinhardt's message of "Fri, 03 Apr 2026 08:01:47 +0200")
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
Date: Fri, 03 Apr 2026 08:41:16 -0700
Message-ID: <xmqqa4vknjab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this patch series introduces the second object database source type,
> which is the "inmemory" source.

I cannot read the word without a hyphen, i.e.e.g., "in-memory".

> This source may seem somewhat odd at first: it always starts out empty,
> and any object written into it will only exist in memory until the
> process exits. But the source already serves a purpose in our codebase,
> where some commands, for example git-blame(1), write an in-memory
> worktree commit.

Intermediate tree and blob objects you need while making an octopus
merge may also benefit from this feature, to stay only in-core
without having to get written out to the outside world.

I understand that this is not meant to be used as a "we create them
only for ourselves and they are available only to us while we work,
but once we are satisfied we make them available to others", which
is much better done by creating an on-disk ephemeral object store,
write such objects in them, and then decide at the end of the
process between discarding the ephemeral store and moving objects
from there to the main object store.

> Furthermore, I think that going forward it can serve more purposes as we
> now have an easy way to write and read objects that will not get
> persisted. I could see that this may be useful when for example
> re-merging diffs. But eventually, once we have the object storage format
> extension wired up, callers might even want to manually set up an
> in-memory database as the primary ODB for write operations so that no
> data will be persisted in an arbitrary write.

;-)

> Last but not least, this patch series also serves the purpose of
> eventually getting rid of the `struct object_info::whence` member.
> Instead, we'll simply yield the ODB source a specific object has been
> read from, together with some backend-specific data, which gives
> strictly more information compared to the status quo.
>
> The series is based on cf2139f8e1 (The 24th batch, 2026-04-01) with
> ps/odb-cleanup at 109bcb7d1d (odb: drop unneeded headers and forward
> decls, 2026-04-01) merged into it.
>
> Thanks!
>
> Patrick
>
> ---
> Patrick Steinhardt (16):
>       odb: introduce "inmemory" source
>       odb/source-inmemory: implement `free()` callback
>       odb: fix unnecessary call to `find_cached_object()`
>       odb/source-inmemory: implement `read_object_info()` callback
>       odb/source-inmemory: implement `read_object_stream()` callback
>       odb/source-inmemory: implement `write_object()` callback
>       odb/source-inmemory: implement `write_object_stream()` callback
>       cbtree: allow using arbitrary wrapper structures for nodes
>       oidtree: add ability to store data
>       odb/source-inmemory: convert to use oidtree
>       odb/source-inmemory: implement `for_each_object()` callback
>       odb/source-inmemory: implement `find_abbrev_len()` callback
>       odb/source-inmemory: implement `count_objects()` callback
>       odb/source-inmemory: implement `freshen_object()` callback
>       odb/source-inmemory: stub out remaining functions
>       odb: generic inmemory source
>
>  Makefile                 |   1 +
>  cbtree.c                 |  25 +++-
>  cbtree.h                 |  11 +-
>  loose.c                  |   2 +-
>  meson.build              |   1 +
>  object-file.c            |   3 +-
>  odb.c                    |  82 ++---------
>  odb.h                    |   4 +-
>  odb/source-inmemory.c    | 375 +++++++++++++++++++++++++++++++++++++++++++++++
>  odb/source-inmemory.h    |  33 +++++
>  odb/source.h             |   3 +
>  oidtree.c                |  66 ++++++---
>  oidtree.h                |  12 +-
>  t/unit-tests/u-oidtree.c |  26 +++-
>  14 files changed, 529 insertions(+), 115 deletions(-)
>
>
> ---
> base-commit: 3d05c3e2906489caa9f12f0af18dc233a6b8032c
> change-id: 20260401-b4-pks-odb-source-inmemory-7b17c83d9e43
