Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10871241697
	for <git@vger.kernel.org>; Thu, 22 May 2025 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747948948; cv=none; b=jBomEA7X9Wea/f7J2HAwbAJqVMNa9LSyXGeBWPb3PlUEmB7uo4LlKVHUYx67Mu8zj8mzBHs7/g7dJb6N/dQq0BZmSuVPxOVpkyaul4f6IoZ2ji3Jyl8XyxbEzj48dSnyyAC9qajmIGg1GF91a+v8oGpq7giZOLLLPMr9JxoG5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747948948; c=relaxed/simple;
	bh=YgQ9n8xvr8oeKHkQCcVLIP0lZxVuny50woOAFBwiKRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L535AtRkwG60CorVk3KG+zZyEWCky8V5l1WT2jVVtNSi0jBzH3BucBC/yuRkaZCQeN37CMWO+qpvUL5tNawuTWc8J+KA2hfHXaMWNRG48QB2hCJVYzy6a85SwqyMsULTGkBCV3ZJa5mPbmUYcv9nZuzgmIqWNIvWjUYlTo0zHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jxkCt/hs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aCatY+5p; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jxkCt/hs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aCatY+5p"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E31F911400E2;
	Thu, 22 May 2025 17:22:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 22 May 2025 17:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747948944; x=1748035344; bh=i6LFBTKv7w
	rbBD4JEc4tV34wmBlLgK4YVerAY4yl8TU=; b=jxkCt/hsKpbdlNhqMomVuD43c5
	Uleb1mSGQVaAVoUh+e6HWjxIAKL4Y6PcRsjIlxXoKWNmdtg3KoZmHzcVnRCohAps
	3hYsgUB/+Rl/aEUsh1Qf5neNOhElzQirtuL7w7Ih3CylOSmN5c9/gGvTY7oR77/m
	gKVOTU74RtO6y0Ka4vEi4IUtyW50cOWq10FKLogZzgk2LUzb1HUanNI2a5HJmR0l
	H3C+IMziBoV/mIehfAuqbq07tKoiNY2bmowJ6gv8KiW3tajEPmjeyx/s6wPj3MTa
	eDn9/sdomlB3KxN/r7EQ3ltTC/DLYWIop71N+KOrmDlA+k7q4NCuaASzwxbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747948944; x=1748035344; bh=i6LFBTKv7wrbBD4JEc4tV34wmBlLgK4YVer
	AY4yl8TU=; b=aCatY+5pPnEzuYlnYpxaoEH2YcVyTlAcRIVs27BpJe3nwv/b3QN
	EKJY8N3KcZ/qZjzbF+kK8GTBPgS+7nW+VmBTpGwLw5aJVSYcR3t2L+mQ5VFQHIML
	rfkaC+8bq0XhQ/dzafw70Mv71wrwTR/ZqP60+poXiVAfag4CLoUtcq9A0VKXP1FV
	f1hesmRu8Z2Qd8/PicdCkb9opJRJtiiLDO0se0wilsFCuz1XSVHexwZly4n1toVV
	tZGVq8q6x0sRS3dnGanIYsza0DJ/g1brrCPqnh8zcF2pcp0lxU04QtNE6aQ3/1z6
	4MEHtGpjQBIiRM1GqvFXXnS7ezZv/Jfa+Hw==
X-ME-Sender: <xms:j5UvaKPkOXEAXOv3A8cuJCNb8qalr-9Oc-QS1Fgii3ZIh4ntFmts0A>
    <xme:j5UvaI_nSqHT7fwb7sI3G2uJE3RW0_BWnlk_cY1ksiN2M0xgy98y28Dk7lBeZ4I15
    SagnQPycvOlaz1eMw>
X-ME-Received: <xmr:j5UvaBRqI2oYHk84XJkSm8p4bnM4osfuUyAISMA-uNVql0xoe6NTqRhON9lfQSdhx0rnx5eZN5mN6R0M19bIsMFqoUVABT04we9_Xb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejtddvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeeh
    tddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:j5UvaKuOtWnv5BdOSRXNf88qzMXalnoH3uZXDaURvomgnu9e8kmesg>
    <xmx:kJUvaCclYyyiNiyH9CK5LCZulhcG5YCf-XK3-TkBVGz3GT5b5LWWng>
    <xmx:kJUvaO13cox9wTgV_VpcwYntgs5oEfVMlUcbfLE7Oqa198SQMxKcWw>
    <xmx:kJUvaG-PlSu299FkBsnZyT4YuSzs0iiz4nRipyJ5p2HMBb1ZXdN4EQ>
    <xmx:kJUvaNnvPFjpZC3T2RJYdjCkheGhEOg4qLKypXnMakqUhMdMhCYO7ITG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 17:22:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Taylor Blau via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2 2/3] pack-bitmap: fix memory leak if
 `load_bitmap_entries_v1` failed
In-Reply-To: <aC5nxa0uTb+ieiML@nand.local> (Taylor Blau's message of "Wed, 21
	May 2025 19:54:45 -0400")
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
	<pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
	<b515c278a8fec6c2ab9d11a49261f44fe0f37bf5.1747732991.git.gitgitgadget@gmail.com>
	<aC5nxa0uTb+ieiML@nand.local>
Date: Thu, 22 May 2025 14:22:22 -0700
Message-ID: <xmqq4ixc49yp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, May 20, 2025 at 09:23:09AM +0000, Taylor Blau via GitGitGadget wrote:
>> Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
> This commit forges my Signed-off-by, but I am happy with the result
> here.
>
> I do think the series is structured a little awkwardly as a result of
> adding this patch to it. That this and the previous patch have the
> subject "pack-bitmap: fix memory leak if `load_bitmap_entries_v1`
> failed" make the series not quite as clear as it could be.
>
> I think there are a couple of things going on:
>
>   - This patch is a bug fix that could be applied independently of the
>     first one. The rationale there would be that we shouldn't be leaking
>     the EWAH bitmaps in 'b->bitmaps', but we are as a result of NULL'ing
>     the pointer in the "failed" label. That patch can stand alone.
>
>   - The first patch (yours) is no longer fixing a leak, at least after
>     this patch. But it does delay reading the bitmap until we have
>     validated its XOR offset for sanity, which is a good thing mostly
>     from a performance perspective.
>
> I would probably swap the two patches around so that yours applies on
> top of mine, and then rewords the patch message in yours to reflect that
> it is no longer fixing a leak.

Sounds like a plausible structure.
