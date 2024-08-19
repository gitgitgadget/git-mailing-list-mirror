Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A6DF53
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724048253; cv=none; b=eb8JG9BdGN54xH4xwaTJvIP9vztMWnZRjW593ETvWVSZzvotvgMmSkF8LlgWgzrz4E5H6UuKhuqM+Sv+11QRSCdYx2PjJSKJ2zj9zVrsNGKmeG3Qy03xR9Yj06KlGUbiwfU+heM27ypdiYXrmsj7f5X17IJFM7uJi//baVHnS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724048253; c=relaxed/simple;
	bh=yt7oyNtA3Zc1t9BxkJihHb+dlKBKZftI4zW08YWDYtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZqv6eKa0c3Z+le10hQEIMp7V42eRbqJa3FEmYNPTkovcEFcBAV9yWvz5n/QVwSbEtxTUZRQHA3jgt4jHiX+7uCBWtvc/3uaFgFpYkIqj06PpaiUj2ht7aJPXAWuu2hdhH0fk4JFLM5RXKmyk+p7ejHJ7ZnaPtGQbySRWyJHseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PrIv+jkk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f28J9yUo; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PrIv+jkk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f28J9yUo"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E2F981151863;
	Mon, 19 Aug 2024 02:17:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 Aug 2024 02:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724048248; x=1724134648; bh=z2zg58EqZE
	nODVF62tDFtBPn9PS08uUQY1m+4YOZ4Bg=; b=PrIv+jkkUWXy+KfWK8fvRUP0O/
	BU0rwEkBRLPTSRT8JcxLpLB5IN+i7g7TwNQ1IdkATL2cOB/kJaTMz3xBcjYsAW2L
	40iQxkAEn+aVzfxMG+tiJmdz07AO0OEvO1j9NdrPGciIsRfD0oBQERTlZV/KXI0k
	U+domWJRsXz9W6dVG2Yn1fOrQ3pH0GRgB/m5fgi2fIumrcS4HbPBcqtLyUOKb6S7
	HgQdH+vCsKQdj+3JbCxeLFAfIElwFvB1BOYa82Jyl+Z4JmUFJs6Ai5akSDkgJP2H
	y6wYNgwn0zbtrcSQjyAU3ZAL8Rx17Pdwo3M78VdmW6slP0gklne9fQg4yeeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724048248; x=1724134648; bh=z2zg58EqZEnODVF62tDFtBPn9PS0
	8uUQY1m+4YOZ4Bg=; b=f28J9yUoT14XsWDf6yS7TpNX5dnI4fNFuXcOV+65NpvL
	Fu/SuYNDE0RI2yohHGnVKYGYsovqCaOf3JMLU1c/BHggtxzGrbJvKSYMFyGglHej
	MRLZj42Lq4v4T5CwFLZCnrTkyZ6rKcKHkDPiWrg+iDYQy5kquuQAKhngF5ZnNiOf
	EU9NJUnDcLyMK1UqUe4ZoPGV5WffsgDIAoC7ONrruVi2fVevL30T7og+aU8/fhAA
	+J7NVEPLV7cLzlYpMafxbMiEBHeFjyKjPbSD1Gr0/pFJf21KfIblczsHhLUMIhh0
	LNfPPaMJvkFqsBrOd3bNBmiAVdB1ArRywHS3ooNcBQ==
X-ME-Sender: <xms:eOPCZkfGPjR8t6tZh3mmREfIH7XfxGc16kLgfiAVkSa2-0qMxg-HiA>
    <xme:eOPCZmNSSEhksh0_DJ33iELN19Fg0Y1WTMZU-HGvIaP_svOIbax3ttiKMGqXIGwZm
    wi6pMjd_cn8v0lVNQ>
X-ME-Received: <xmr:eOPCZlhedIV6YVJNSOhWlOe2UkkVi0GrzRV0I9KtjVCtjxo_-kv6mr0lAJCTIutcfdQ2Q79hf-DjPv7PtPg_AJWm4EzrpnYxZcR6Eh0zkbjqPNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddufedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvdeg
    ieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    htohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    seguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhl
    ihhurdhioh
X-ME-Proxy: <xmx:eOPCZp-nUu0zMDI-Db4ed51aMefqRC3UxTJ_BEm4UXAb2HZdpkG0nQ>
    <xmx:eOPCZgv9ofODerjkq1VE0NvQuO3jqfbCTmjeyQVL4OrC-wYYdEaunw>
    <xmx:eOPCZgE8W5b-D5VzR8o3_wOmwnxtIzw8VtWCLZm9GSBz0NzYnQSoFg>
    <xmx:eOPCZvMDS54oGtK4gEqlU_iRk9g1ek1Uimcm4Hg_ci8fSWpN7kHhsA>
    <xmx:eOPCZl87R1IdfFyoPUF4aaxXepRdHosqde9u0efcnZ7J-86el6Pe-XlI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 02:17:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5585c899 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 06:16:55 +0000 (UTC)
Date: Mon, 19 Aug 2024 08:17:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/7] run-command: fix detaching when running auto
 maintenance
Message-ID: <ZsLjcjhgI8Wk2tIV@tanuki>
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
> 
> My guess based on what I'm seeing and what the patch does is that now
> maintenance from a previous command is running in the background while
> our foreground git-fetch runs, and it somehow confuses things (perhaps
> by trying to compact reftables or something?). So I think there are two
> problems:
> 
>   1. The reftable code needs to be more robust against whatever race is
>      happening. I didn't dig further, but I'm sure it would be possible
>      to produce a coredump.

Yes, it certainly has to be robust against this. It's also where the
recent reftable compaction fixes [1] came from. In theory, it should
work alright with a concurrent process compacting the stack at the same
time where another process is reading. In practice the backend is still
in its infancy, so I'm not entirely surprised that there are concurrency
bugs.

I will investigate this issue, thanks a lot for the backtrace.

[1]: https://lore.kernel.org/git/cover.1722435214.git.ps@pks.im/

>   2. Having racy background maintenance doesn't seem great for test
>      robustness. At the very least, it might subject us to the "rm"
>      problems mentioned elsewhere, where we fail to clean up. Annotating
>      individual "git gc" or "git maintenance" calls with an extra
>      descriptor isn't too bad, but in this case it's all happening under
>      the hood via fetch. Is it a potential problem for every script,
>      then? If so, should we disable background detaching for all test
>      repos, and then let the few that want to test it turn it back on?

Might be a good idea to set `maintenance.autoDetach=false` globally,
yes. The only downside is of course that it wouldn't cause us to detect
failures like the above, where the concurrency itself causes failure.

Anyway, for now I'll:

  - Send a patch to fix the race in t7900.

  - Investigate the reftable concurrency issue.

  - _Not_ send a patch that sets `maintenance.autoDetach=false`.

The last one requires a bit more discussion first, and we have been
running with `gc.autoDetach=true` implicitly in the past. Thinking a bit
more about it, the reason why the above bug triggers now is that
git-gc(1) itself runs git-pack-refs(1), but does that _synchronously_
before detaching itself. Now we detach at a higher level in the
hierarchy, which means that the previously-synchronous part now runs
asynchronously, as well.

I cannot think of a reason why we shouldn't do this, as the ref backends
should handle this gracefully. The fact that the reftable backend
doesn't is a separate, preexisting bug.

Patrick
