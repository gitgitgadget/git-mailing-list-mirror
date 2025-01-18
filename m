Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADEC747F
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737160437; cv=none; b=AkGI4RhYv/Lx/2zCVBAQGm35UxOoF/a+xJg2KEWh00w6OYPCfzdV5N0n+DtWDN3TQbiM4EQGYWoaRIfHWAeghVJRhDvcmgHRPTZoYAaLA7E9jckHRI7qKIo7+FZ8SA90arN2bfI8vS/QksxEx/fM6AZhke5CEnJr8eT0hNTR/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737160437; c=relaxed/simple;
	bh=qR6+zEGXjOGnFoJmNIc60MEbYP9D5o54Td0/XvR7zWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IEv04f5ksI8XD1bJfXZx+u8SdYCo8u8WmMfBloOdEqNQjaTf5Ct49un5HHbBe6kHp7rmyuS52bSw0tPoqglgtp2nkatsDiq7RR8J7Skh8l5O/IwstafMbB/1DZBu+pzCylSpuuhcSfAfSIqWGM+ctWRf6KLI2RLxloI/MUQGK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J5WY4iyr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ll3vBBRn; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J5WY4iyr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ll3vBBRn"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C5AC1140102;
	Fri, 17 Jan 2025 19:33:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jan 2025 19:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737160434; x=1737246834; bh=xg72ZYmlkr
	Zyac2+wvMv7m5uYBoD9XiKZ8wr2J22TXs=; b=J5WY4iyroHFxqys6D2EQX+u2Uz
	joXZJtiC5u64/WhWFQ6jlXxdcff4hoMVJPQIZ0M5ea8rmuS25GjsdVCneQp76Lf7
	A12JZLpgi/vn84CFJ6YikDDNFORJYZnJD37BqFwX1Kua9WTlnY8rEKFxwsLtr17G
	wcodtfy70VCFXEpbW6womZQAbh907kRZanMSvqdejejgMA29QICIxvFG3m0mMwac
	AsHIUhLpj9RaJYOb5j/JPHJR5TwnZID0ULqasFQGpQ3YsHJ1ji1iCozAg1EG+0nx
	9MWf1t7w0YyxkvJJ9p3fM6lxa9OTkv0CHUBRPRH61YovmdOtk/mK3McqmXqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737160434; x=1737246834; bh=xg72ZYmlkrZyac2+wvMv7m5uYBoD9XiKZ8w
	r2J22TXs=; b=Ll3vBBRnlAWDYE6mNUCTdw5jAg3dr8BpRIuekFpw5KBsNvIZdpG
	diKlfZLVNAsal+frwFUAAFxyNZWVVOd5VidbfoEIwTQsXusCxK27KyhNDKxBRVWD
	lR9FCtOi6tiqX4kE+bslq8ieS6+N486fA+HpzBV1Xe8NO15i9zGHW/qGyEs1IPqf
	ULraarEUnWzCF/G3H/ADcV2Epn6e/gHV+/EAiCKk0LIJQU+JcYvUgpzy7P333Jd3
	DDe3RYUlNEIo0ZN/F84tRyDaoFmVIZhp8AkqwnqMrAwyZYVdRzQ/NQVF32nQNo1Y
	xHT+GtxteaO3BWDEzHnqfiNmu7S+fUO41Pg==
X-ME-Sender: <xms:8faKZ-DyDn4Xe0xEarEphdI_Zmjl2Dqvoj9l8arO3xkPfdCMCi_ZfA>
    <xme:8faKZ4jFCIkifoq00-8H1Auz5nWkQbM-f2MwM16L8xUTSiMzEjHGS94pUrpXoWi8r
    B2iV9iJApVLZTkwwg>
X-ME-Received: <xmr:8faKZxmj9DqRaB5nUbAv7bIrdoY-LkaMEF0PukgNErCGwavZhTlKqJdjyhfuoTahz4Vscxnd4zQp_9c_EwXaYZhTG1VcdxR03-K_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepfihinhhksehsrghvihhllhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:8vaKZ8xToTJZoO7Ch4EtLqiBUMzVGLsTl9XaqBRA9ph5Ik4SPwi5Nw>
    <xmx:8vaKZzS6TeRv-0xj18KW6PZlSd_ktDz7BxuWq0zWUbWuBJlMc-1znQ>
    <xmx:8vaKZ3acOUvRErMJGID1pD_GJIM_dZXG5i_h-xlQEyWQQU8UY9wGHA>
    <xmx:8vaKZ8Qzf80f6UnB1u9D6iMEgS7akxPAk0rOCMXlidjBSzuAUtkUlg>
    <xmx:8vaKZxP30QoQ76LniDxemGUY_mtqI0VT5ux9hcfM5oN6LutgE-jL-ovv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 19:33:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>,  Wink Saville <wink@saville.com>
Subject: Re: [PATCH 11/14] tree-diff: drop list-tail argument to
 diff_tree_paths()
In-Reply-To: <20250109085156.GK2748836@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jan 2025 03:51:56 -0500")
References: <20250109082723.GA2748497@coredump.intra.peff.net>
	<20250109085156.GK2748836@coredump.intra.peff.net>
Date: Fri, 17 Jan 2025 16:33:52 -0800
Message-ID: <xmqq4j1xhsen.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The internals of the path diffing code, including ll_diff_tree_paths(),
> all take an extra combine_diff_path parameter which they use as the tail
> of a list of results, appending any new entries to it.
>
> The public-facing diff_tree_paths() takes the same argument, but it just
> makes the callers more awkward. They always start with a clean list, and
> have to set up a fake head struct to pass in.
>
> Let's keep the public API clean by always returning a new list. That
> keeps the fake struct as an implementation detail of tree-diff.c.

Yes, this is much nicer.  I've always hated these code paths related
to "multitree" optimization, but these clean-ups make them more
palatable.

Thanks.
