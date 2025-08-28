Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C97082D
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423522; cv=none; b=nBnTL1TxgTnylXl+MGDEchqhvqo7tecA2CjIPpvoJ1akQBm9Lz5+WWYFSzJVdwp6DAZkVqvCYpoME3Dgif7z+iCYf5TOxAuxcEgI9IcJm1jip1H4D+yHdTukawblypbTXh1NkIUj7dkKkqx5hb4kZ0ZUGjs0mcpn1DiwtvHDTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423522; c=relaxed/simple;
	bh=t6JWua0zem6zX45WIutjfW5cZrwgBXpf1xkrt/Ij9x0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pUKZ4/hpgy4slKIoQ/Dg0j+AcDjnBong2dwyV+KJCDRziCozN8V8TgWnjy+Dp5g90uKkqDGpCTprEtt1DEJfWwhSzZ/lryc6YhCKULNO4KQ+QucaNsOhy9YUETGl55hCRlXYLgKuQMxiIWAI00cXdqjon3OxJSBuGsdtOksUksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=asy6ojkO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLSxumsq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="asy6ojkO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLSxumsq"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E5311D001C6;
	Thu, 28 Aug 2025 19:25:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 28 Aug 2025 19:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756423519; x=1756509919; bh=UuCW6Azu4J
	wiHfF56h7zkxUSL83xeYilrZiOswZmicM=; b=asy6ojkO7yb5mCz4mPCh97+xVV
	bq0kzxQQ3ANtzouUUQlyQDxdWx91GQjp51VGChbTFH0/CjPNXDuF8mr2MIy38jsN
	UdtP7+ONaVpWsn2NEr8suYdP9X5KJ9++L1P9IeXPr3yORZF2RGl23qp5KMEZ4eqf
	rmkurqxtT2mVEzIVZEvFhhor3aFOF393bvO7ndrudlYsMkVhKGUgkYQ+bAFmoK3+
	t8u+jgm+S1oMgS2jzJMxND/4Qa7xDHd1RtoFX5IENzYRcSQMIxsKahm4607uqJi2
	HVLqz4rD2ir34eNH0pb9J8cAF8mUhfS0je5VmKCKz6Vugr6wa3Yh6ZS8lJzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756423519; x=1756509919; bh=UuCW6Azu4JwiHfF56h7zkxUSL83xeYilrZi
	OswZmicM=; b=fLSxumsqyr9R7+8I8pbcnXjUm8kLGbH6gy3g76yUzVm6ek0FiGg
	TG8ozRku+9ecTpdP1sXFq7IgWqId/uPqv/Xtc5wwFg2BAX6oin33x2HsSEWCTX2o
	euFJHbT5ZFd5Ukb+0TBlBc4eFZKF9/f1m9hfBHe9BUCRMhS78XJAlmg/e42VeofN
	DYPU2q4QhHmW8MtnIUtKEpUlarkWOxePU+6OoLvOUdZRk6BOaLSIPRQdpwP6yfpC
	0IPoFqzMldekK/GIs1mgn3yR5KDBlHn3E4CjtRDqL/Roa8+PZyBOxJey7EM64Oal
	y1mfANGdvN5pewxN0bM9yoqZdVUXt3VKoCw==
X-ME-Sender: <xms:X-WwaCsV2jVPGeISHJaZ4Ltpeg0Jf0IWxeVJCgQmK9qC3mR5RdSeIw>
    <xme:X-WwaC84lk0mzi1qfwvZSVR8mFpmYufbwtpnnUPuMsiw5xMwgcLOo698UrOBvYspQ
    uv0YHtTDTF2OqqydA>
X-ME-Received: <xmr:X-WwaENQZRLnWXycGvEB5ZdxED9pzu-r2pggDzZVKAgis18zK3aXC8KA6XZ6w_fZRBt0rTn-hOwAXa5I-SRkQqmyJfdYNmnVs0uqOLU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:X-WwaIEbGShLv7Jbt_AHdHo8-WJ07VNHqeOfLf-HUOcLq0wNCyn6bw>
    <xmx:X-WwaKT1Tt7CVy1k94oEWXEWU8yHKGZNVpJlJXpyIhvoLCuDkMD4Jg>
    <xmx:X-WwaNs2uZn6S08zOA5ImAMxDingiIU4wMTZXwWDyTJeN5A66dh2pA>
    <xmx:X-WwaKJeek5awmlS9CNeHxGlORVvil3MbExWHkhivHpAsCDyOvtv6Q>
    <xmx:X-WwaDdoaxnSIKke-pOCNWREsAPOPHfpRB9fH7_lKuQskBDgB4mfTy0P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 19:25:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 4/4] midx: return a `packed_git` pointer from
 `prepare_midx_pack()`
In-Reply-To: <aD92wu6Mk/S9Qm4t@nand.local> (Taylor Blau's message of "Tue, 3
	Jun 2025 18:27:14 -0400")
References: <cover.1748198489.git.me@ttaylorr.com>
	<cover.1748473122.git.me@ttaylorr.com>
	<e3e21db673f3ae6e574333d4678a0450fa44fb9c.1748473122.git.me@ttaylorr.com>
	<20250530065034.GC1321283@coredump.intra.peff.net>
	<aD92wu6Mk/S9Qm4t@nand.local>
Date: Thu, 28 Aug 2025 16:25:17 -0700
Message-ID: <xmqqv7m7qbaa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, May 30, 2025 at 02:50:34AM -0400, Jeff King wrote:
>> ...
>> Is this note still valid for v2? It looks like patch 1 adds
>> nth_midxed_pack_name() and tries to use it everywhere.
>
> Yeah, we should get rid of this. I had written it before I wrote what is
> now the first patch in this series, and neglected to remove it before
> sending out the latest round.
> ...
>> I'd have thought we could call it nth_midxed_pack(), but that seems to
>> exist already, with the caveat that it never prepares the pack, but only
>> serves what's in the cache. I wonder if we could simply replace that
>> with what prepare_midx_pack() does, but it may be more conservative to
>> leave the two separate. So I guess nth_midxed_pack_load() or something.
>
> In general there aren't a ton of in-flight changes in the MIDX code at
> any given time, so I think we could get away without renaming it. But I
> don't mind erring on the side of caution here, either.

The topic went dark after this message.  Are there still unresolved
issues, or do we want to get it unstuck?

Thanks.
