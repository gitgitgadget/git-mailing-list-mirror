Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0CB165F1F
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724064600; cv=none; b=d0iiJ1bKreApfgBZysPmguNEc2McVYOEzNHYDwHwhPncRGMgh48tizVllkhnyi35WDSZrK96XjMsbDbJ1j1Usl3nQaw/ubvTHjyKVM/ftBXk2OC6VYGmY3sg5PRg/wYUsxmU7+Xaf1Ie8PlqTSDnP4j3SmGgpl+IqPCQc0b7crk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724064600; c=relaxed/simple;
	bh=hytJ2PoIYvSEnebAfNnI2KRrpCrmzSwyCseqksQ/37M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKhch0YUm0fy/TNQ6YiFujMwl+6t8/whapMGReBhgi9nUOXYLBpqgE092NktXZZIPnbkptnk1MllxMPuGHWrCin/FinWQHzDVzNSudlEvtSWavUjr33teFcXx4JYSh0iP4RnScaeiASBpvAnHEWPKCDFYVMMvDgw5dt7XifPlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TDb43g5T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFGismu8; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TDb43g5T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFGismu8"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EFA82138FFE3;
	Mon, 19 Aug 2024 06:49:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 19 Aug 2024 06:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724064597; x=1724150997; bh=4xjDqqqvbK
	+uewtr16/0JfuLfrwiJc4MZwpgXjwrxoM=; b=TDb43g5Tx3BSPN9l8veXhCVQzC
	IvUT2q/hFL5MkVLkpyU/msMVqua5sCgl2eU8H2l5l5KyoTAV+Xe6zDPxJ2d/8dNA
	46RDJuPtE9V7E/RofEq26o4SNobovu925CiLB/RFyfpISVtq1SjZGS2BmvZZFynk
	wiwuDe2Z+hw8QrOX3QAgmh7S15FiVrKa5HWDeMkmJrvVerZoQm8jS34kgLysyPjt
	NycDMyi8NfPmTIMrDXgD++nTrabOLB+W+VlEiDRHxApt2lo9nQFhyJOQL4fOXvCZ
	HS7k7qYd5jQDKGzYM5zPZnHeWqkbSNNOYDD5qKq3U7vxPvFP8uu8CyJOnsVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724064597; x=1724150997; bh=4xjDqqqvbK+uewtr16/0JfuLfrwi
	Jc4MZwpgXjwrxoM=; b=OFGismu8+t7CGgvBkKFZfeQay+A9qwsw38ZfDgQzNRzj
	5IwYBQgA4CyJBVe92JUxqoGsjCuaKm5AS9jG8uYdS/+IcmBuVgkVJOGWZO0hR0Ge
	gKRgosJp33qO3o9NR7ZIEJLJxGpUDahsF/xwvrgmxvY1yNo7cJgxm40YHHguD+pO
	TJmeHzF3rw0dk5NlQy1YcGN0jrxjvF70p1wN3xaRk8iacN/8A6l9s0QMOVHZChUg
	+09G8BOjwIyKXSNxyNeqtjtlJCkAdPhqS5Y4e0k8l0ZPVl6xyuD5tUzQBUcamHNy
	18repKANXzk4nPy4rZp5/08vT4r9nEJ/MKfJOJJb9g==
X-ME-Sender: <xms:VSPDZj2SFyW7PRDFIcgyCgdon8q-iFGEF4xKSklelLSw-IIFhkAgYQ>
    <xme:VSPDZiEunvZ1_C2xwzwptwli0KOjYNvcD3ib2EvdZcNXdUnOoHIQhHdU5ZW6JYRbz
    N1CKgM5-bCcwJQX0A>
X-ME-Received: <xmr:VSPDZj6ilzr_9GgbCR1JqO1nXz1SZn8QXZmIzcOywrvQ1XvGCpP0RXjSAgiTC3JWM7x7WQ-Afa_KPQuBqt6BCAgrNxj6MFXI1htaRt0pJvq9bwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmvghssehjrghmvghs
    lhhiuhdrihhopdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VSPDZo00X8jA6MqM0TC0lZ8o7NfKpKZDY8GfeXaP5IGE3ere86iQUQ>
    <xmx:VSPDZmHS_83OyKdXqzHhg9EIe2K3Du0ZQ4u1Wx6CrOWzL1DY8E5_Qw>
    <xmx:VSPDZp9VQh0ChqE070XT0GTESVn9zstMCDUwFdbW8PG-y4gDMt6L0g>
    <xmx:VSPDZjngXFGhHP_j9u7ORXUsfbNIKlVdusThpnOVLEmOPDsAzZn5LA>
    <xmx:VSPDZp2C4xNDgkolGG0LwFcXJM_wtfph8sGK6prjW9WqqvtQcFVQ6Xwq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 06:49:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3117b723 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 10:49:24 +0000 (UTC)
Date: Mon, 19 Aug 2024 12:49:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/7] run-command: fix detaching when running auto
 maintenance
Message-ID: <ZsMjSi8AqA55Rp_X@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
 <9befef7c1f7520d58af2b2db17174b8dbc493d56.1723804990.git.ps@pks.im>
 <20240817121424.GA2439299@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817121424.GA2439299@coredump.intra.peff.net>

On Sat, Aug 17, 2024 at 08:14:24AM -0400, Jeff King wrote:
> On Fri, Aug 16, 2024 at 12:45:17PM +0200, Patrick Steinhardt wrote:
> 
> > Fix this bug by asking git-gc(1) to not detach when it is being invoked
> > via git-maintenance(1). Instead, git-maintenance(1) now respects a new
> > config "maintenance.autoDetach", the equivalent of "gc.autoDetach", and
> > detaches itself into the background when running as part of our auto
> > maintenance. This should continue to behave the same for all users which
> > use the git-gc(1) task, only. For others though, it means that we now
> > properly perform all tasks in the background. The default behaviour of
> > git-maintenance(1) when executed by the user does not change, it will
> > remain in the foreground unless they pass the `--detach` option.
> 
> This patch seems to cause segfaults in t5616 when combined with the
> reftable backend. Try this:
> 
>   GIT_TEST_DEFAULT_REF_FORMAT=reftable ./t5616-partial-clone.sh --run=1-16 --stress
> 
> which fails for me within a few runs. Bisecting leads to 98077d06b2
> (run-command: fix detaching when running auto maintenance, 2024-08-16).
> It doesn't trigger with the files ref backend.
> 
> Compiling with ASan gets me a stack trace like this:
> 
>   + git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 --refetch origin
>   AddressSanitizer:DEADLYSIGNAL
>   =================================================================
>   ==657994==ERROR: AddressSanitizer: SEGV on unknown address 0x7fa0f0ec6089 (pc 0x55f23e52ddf9 bp 0x7ffe7bfa1700 sp 0x7ffe7bfa1700 T0)
>   ==657994==The signal is caused by a READ memory access.
>       #0 0x55f23e52ddf9 in get_var_int reftable/record.c:29
>       #1 0x55f23e53295e in reftable_decode_keylen reftable/record.c:170
>       #2 0x55f23e532cc0 in reftable_decode_key reftable/record.c:194
>       #3 0x55f23e54e72e in block_iter_next reftable/block.c:398
>       #4 0x55f23e5573dc in table_iter_next_in_block reftable/reader.c:240
>       #5 0x55f23e5573dc in table_iter_next reftable/reader.c:355
>       #6 0x55f23e5573dc in table_iter_next reftable/reader.c:339
>       #7 0x55f23e551283 in merged_iter_advance_subiter reftable/merged.c:69
>       #8 0x55f23e55169e in merged_iter_next_entry reftable/merged.c:123
>       #9 0x55f23e55169e in merged_iter_next_void reftable/merged.c:172
>       #10 0x55f23e537625 in reftable_iterator_next_ref reftable/generic.c:175
>       #11 0x55f23e2cf9c6 in reftable_ref_iterator_advance refs/reftable-backend.c:464
>       #12 0x55f23e2d996e in ref_iterator_advance refs/iterator.c:13
>       #13 0x55f23e2d996e in do_for_each_ref_iterator refs/iterator.c:452
>       #14 0x55f23dca6767 in get_ref_map builtin/fetch.c:623
>       #15 0x55f23dca6767 in do_fetch builtin/fetch.c:1659
>       #16 0x55f23dca6767 in fetch_one builtin/fetch.c:2133
>       #17 0x55f23dca6767 in cmd_fetch builtin/fetch.c:2432
>       #18 0x55f23dba7764 in run_builtin git.c:484
>       #19 0x55f23dba7764 in handle_builtin git.c:741
>       #20 0x55f23dbab61e in run_argv git.c:805
>       #21 0x55f23dbab61e in cmd_main git.c:1000
>       #22 0x55f23dba4781 in main common-main.c:64
>       #23 0x7fa0f063fc89 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>       #24 0x7fa0f063fd44 in __libc_start_main_impl ../csu/libc-start.c:360
>       #25 0x55f23dba6ad0 in _start (git+0xadfad0) (BuildId: 803b2b7f59beb03d7849fb8294a8e2145dd4aa27)

I haven't yet been able to definitely tell, but I think this is a
lifetime issue. We create an iterator, eventually notice that the
reftable stack has been rewritten, and reload the stack. But the
block sources used for the old tables are still referenced by the
iterator, even though it was closed. As such, the mmapped memory of the
table has been unmapped and is now invalid, which causes the above
invalid reads.

I'll work on a patch series that introduces refcounting for block
sources, but guess that'll take a bit.

Patrick
