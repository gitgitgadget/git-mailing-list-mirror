Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A912CD8B
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082107; cv=none; b=lnVob4WCmw5JYPOodmsD+pWDy/Dm1ozTp9ULcApzqW1bn5rF/E4k2LyUWpLUyrOlJAzcGIpDacGgG5gD3Vy3f/e0sjSWdM7bbarq4AZvuXp4GsOlYtQzCsYGooQn4zAQGeXHzx6R1abFznvQ5NZS1LEmAJaOS7GF5o2Pgf9LKe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082107; c=relaxed/simple;
	bh=/Lrxf3eB8zWiLbZJ9/MSCMgjXL0vM7j5M0pcRf37GjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqpimZkmyIwHuAQMZVqCp9HMrbsF2/wMeP3UpltESGdBOlSNGyqdM8hJO6pcvoajD6GB+O2oaTG5rs0ejsBZtZ6npYY9T/gry9kOErZ+LfanOQ6xTJXI0b2q04JMOf2NwtGQ/zJDrQwxzjjm3FMcGbIFw5BxSuP+LW4k/FnE6JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gmWmA+3j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G84obe04; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gmWmA+3j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G84obe04"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4A457114EC82;
	Mon, 19 Aug 2024 11:41:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 Aug 2024 11:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724082105; x=1724168505; bh=4c708IhetH
	BDjxbAd1XdeGv9S8nnAsqefRCv1cPC8U0=; b=gmWmA+3js6gsMXf9YbIIPMtitd
	OsGu8K+v+sskUZ/+vdi67GdozpTja51Kpu+30vWJTAmCtbjJ3c/G6cEyZZIHaL+E
	LSJ0uyT7me0Wo+9nI3av8knXX9u/4v76sSbHqMQgbCd/C/dFiTgBNF2DtFfgk0oc
	4t91kwSMGyj9A9SAWL+2l+smX/DFIkRe/Il03TrFoAVABJMRjJQKr75Fu5Rkqo1K
	kbkbk0LNWi0BHJiqLcma6C/z8k2gGmrE3YijTyCo/nbRd0HhJMTkNwgJQdpZndYC
	6ezStLjy7Id0rOCwYiIkYbpeDUH/CZez2Qm+dGMf5bP1szFrKeAtf3Do8Wkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724082105; x=1724168505; bh=4c708IhetHBDjxbAd1XdeGv9S8nn
	AsqefRCv1cPC8U0=; b=G84obe04Px+JpUFKIlkfWdRC5vy2duv4wmdn6zAAmRtD
	BdaLXGO3uKUh1+U+oBDP9QYZ/fX6t8+d+1TvOkS4/NuPxU8Axt20PA6wR2pVBGwG
	gg4tNl/r54VlY4DH3Abe177T9+YVdqQH9De4jsr2Y/PisrRNZRNF0ObYJ5pE3cE6
	+PZBJ3/H2e+7baO1K9Q7pta4b2A+mH1Q8ZTXPuEbIBlY/qNxFCr59LZGFnHDQxSj
	lz0bC8su2y1jvyu6p6kHlzq8MWwbGxr/igAoQlA2THVFYM1VsrAbg1NBU7RLDwch
	1PrcOPqxm1RDu7q2YCh6NSJ8GM4PKEK7JOBAMo+XEA==
X-ME-Sender: <xms:uGfDZp7w_7M8sHRbiEufIUO4txZWXiMDnmm2OZNHvd-9MYmTzTkmVg>
    <xme:uGfDZm6DxbNX0Xi-ljwIgEY9FZ-AleUQazNvhoZKcCt6mHTLilKeWd0kIYN5inO4v
    T1TVaXRMmEhthelNA>
X-ME-Received: <xmr:uGfDZgci9oN51WmqkRngwoA3mGDcCvJ6VQ3Aujyz_jUNvjJy86tvErya0BdXd9MSUHA_Nb8H55-hPWndUfJpdT9FHL_ZRSm8qeQIq3x9hAIMD2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgvshesjhgrmhgv
    shhlihhurdhiohdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:uWfDZiIztgfv3DenDtDrqyjxBlYEQo8YQceB0O-WSEVqIjgb8vi5Tg>
    <xmx:uWfDZtIVINYCUEy7jZ7elTxjmasC_n6Wr0xEDmuN7Wz_aRm9REgWQw>
    <xmx:uWfDZrySwrlRN6BuYfErZk8PyJuO45JcSQoomAOftZXvX7THIiRsAg>
    <xmx:uWfDZpLzmqdKTC6XrCdfKdbhYIfelqwUOgFppPmdNx7aFfJg8NN26w>
    <xmx:uWfDZirFbvA9h0WOWuVXe_z4lnz8CxDsbrbrerfztXpw6gDnDHEVLndI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:41:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ccd2bde (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:41:13 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:41:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/7] run-command: fix detaching when running auto
 maintenance
Message-ID: <ZsNnsx_J4Te9cxCu@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
 <9befef7c1f7520d58af2b2db17174b8dbc493d56.1723804990.git.ps@pks.im>
 <20240817121424.GA2439299@coredump.intra.peff.net>
 <ZsMjSi8AqA55Rp_X@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsMjSi8AqA55Rp_X@tanuki>

On Mon, Aug 19, 2024 at 12:49:52PM +0200, Patrick Steinhardt wrote:
> On Sat, Aug 17, 2024 at 08:14:24AM -0400, Jeff King wrote:
> > On Fri, Aug 16, 2024 at 12:45:17PM +0200, Patrick Steinhardt wrote:
> > 
> > > Fix this bug by asking git-gc(1) to not detach when it is being invoked
> > > via git-maintenance(1). Instead, git-maintenance(1) now respects a new
> > > config "maintenance.autoDetach", the equivalent of "gc.autoDetach", and
> > > detaches itself into the background when running as part of our auto
> > > maintenance. This should continue to behave the same for all users which
> > > use the git-gc(1) task, only. For others though, it means that we now
> > > properly perform all tasks in the background. The default behaviour of
> > > git-maintenance(1) when executed by the user does not change, it will
> > > remain in the foreground unless they pass the `--detach` option.
> > 
> > This patch seems to cause segfaults in t5616 when combined with the
> > reftable backend. Try this:
> > 
> >   GIT_TEST_DEFAULT_REF_FORMAT=reftable ./t5616-partial-clone.sh --run=1-16 --stress
> > 
> > which fails for me within a few runs. Bisecting leads to 98077d06b2
> > (run-command: fix detaching when running auto maintenance, 2024-08-16).
> > It doesn't trigger with the files ref backend.
> > 
> > Compiling with ASan gets me a stack trace like this:
> > 
> >   + git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 --refetch origin
> >   AddressSanitizer:DEADLYSIGNAL
> >   =================================================================
> >   ==657994==ERROR: AddressSanitizer: SEGV on unknown address 0x7fa0f0ec6089 (pc 0x55f23e52ddf9 bp 0x7ffe7bfa1700 sp 0x7ffe7bfa1700 T0)
> >   ==657994==The signal is caused by a READ memory access.
> >       #0 0x55f23e52ddf9 in get_var_int reftable/record.c:29
> >       #1 0x55f23e53295e in reftable_decode_keylen reftable/record.c:170
> >       #2 0x55f23e532cc0 in reftable_decode_key reftable/record.c:194
> >       #3 0x55f23e54e72e in block_iter_next reftable/block.c:398
> >       #4 0x55f23e5573dc in table_iter_next_in_block reftable/reader.c:240
> >       #5 0x55f23e5573dc in table_iter_next reftable/reader.c:355
> >       #6 0x55f23e5573dc in table_iter_next reftable/reader.c:339
> >       #7 0x55f23e551283 in merged_iter_advance_subiter reftable/merged.c:69
> >       #8 0x55f23e55169e in merged_iter_next_entry reftable/merged.c:123
> >       #9 0x55f23e55169e in merged_iter_next_void reftable/merged.c:172
> >       #10 0x55f23e537625 in reftable_iterator_next_ref reftable/generic.c:175
> >       #11 0x55f23e2cf9c6 in reftable_ref_iterator_advance refs/reftable-backend.c:464
> >       #12 0x55f23e2d996e in ref_iterator_advance refs/iterator.c:13
> >       #13 0x55f23e2d996e in do_for_each_ref_iterator refs/iterator.c:452
> >       #14 0x55f23dca6767 in get_ref_map builtin/fetch.c:623
> >       #15 0x55f23dca6767 in do_fetch builtin/fetch.c:1659
> >       #16 0x55f23dca6767 in fetch_one builtin/fetch.c:2133
> >       #17 0x55f23dca6767 in cmd_fetch builtin/fetch.c:2432
> >       #18 0x55f23dba7764 in run_builtin git.c:484
> >       #19 0x55f23dba7764 in handle_builtin git.c:741
> >       #20 0x55f23dbab61e in run_argv git.c:805
> >       #21 0x55f23dbab61e in cmd_main git.c:1000
> >       #22 0x55f23dba4781 in main common-main.c:64
> >       #23 0x7fa0f063fc89 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
> >       #24 0x7fa0f063fd44 in __libc_start_main_impl ../csu/libc-start.c:360
> >       #25 0x55f23dba6ad0 in _start (git+0xadfad0) (BuildId: 803b2b7f59beb03d7849fb8294a8e2145dd4aa27)
> 
> I haven't yet been able to definitely tell, but I think this is a
> lifetime issue. We create an iterator, eventually notice that the
> reftable stack has been rewritten, and reload the stack. But the
> block sources used for the old tables are still referenced by the
> iterator, even though it was closed. As such, the mmapped memory of the
> table has been unmapped and is now invalid, which causes the above
> invalid reads.
> 
> I'll work on a patch series that introduces refcounting for block
> sources, but guess that'll take a bit.

This is being handled via
https://lore.kernel.org/git/cover.1724080006.git.ps@pks.im/.

Patrick
