Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8E1A6814
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863232; cv=none; b=RfKYBBGWvB3nxcU7nEfDKcvuUulLsOhgSSb9dOqCt2qv3HR/AeZq7Tdvp3Adi7QoERCRaWpjWkcbyP/eI73qaGnDJ1+udKp29DqgJpP+2k7eiHK7lDN+Tj0rD3EgWg3ZkzP7rXJRwV4AGCJmfbNCkcIlF4NW6So2JdleWrrELHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863232; c=relaxed/simple;
	bh=apTq8oj9lUC0Lga6DzsXcQy2GiHZfvsdGZ4nN33tffg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnJyJNI9auXg1iBHO4/I9r190DylmUZFjC5Xa0a1n9CZnYnyg8QLEhafgiiEU4gU91d1kEjqAI0AdZZaZAiEFiYu0IH0iMdjzAAWSN1oEtmRwSS+oatDgyC0Dt2DcywinNnL5vILnaDmSGBUYnE2qlpZQYvFBR9uj7tbJeBi1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TSzU8UTM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TSzU8UTM"
Received: (qmail 74498 invoked by uid 106); 30 Jun 2026 23:47:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=apTq8oj9lUC0Lga6DzsXcQy2GiHZfvsdGZ4nN33tffg=; b=TSzU8UTMaYwVLBPS2b+cc7D0QisKSMoJ1dqWx0j4WdGkRQT8FG2E2FHxf3Pz3+YiSa3Cor2BVzctjcoRkeAORMbNhqtYn8uwwOF7TVCDJqlOjYJME9Dshg7DMod7dn3l2+XnZyq5D3MpAtmrYz6DAnpdPIk05VWNcCVtLgW+FFq2qDM0sVmDoyCoThib2d2r9sZVeKTvmalLFg4bqZ0gz7ylrAb7EwaiFE/aMEjLsBstRuFlNrtQMPt+FC8eCzDT4hZE8Pxi25fftuXAsLOQvV7eFQsJ7R5VtzXCtjeLIUBF0Da9MSgU46Usbf0oePU7IPWqwBgdQNbjC9EPhZ1z5g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2026 23:47:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 153261 invoked by uid 111); 30 Jun 2026 23:47:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2026 19:47:03 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jun 2026 19:47:02 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t5551: pack refs after creating many tags
Message-ID: <20260630234702.GA3759976@coredump.intra.peff.net>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080710.GC107826@coredump.intra.peff.net>
 <akIJQbOUbdBbkTef@pks.im>
 <20260629203527.GA1895313@coredump.intra.peff.net>
 <akOG0oMu2KTqqyW7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akOG0oMu2KTqqyW7@pks.im>

On Tue, Jun 30, 2026 at 11:05:22AM +0200, Patrick Steinhardt wrote:

> > We make 2000 fstat, which strace claims takes 85% of the time. I suspect
> > this is over-emphasized because strace inherently makes syscalls slow,
> > but running with perf also highlights it as a non-trivial cost.
> 
> Yeah, this rings a bell. If I remember correctly, this is because we
> call `refs_resolve_ref_unsafe()` to verify whether the target already
> exists. And as that function is generic, it wasn't easy to optimize it
> by reusing the already-loaded reftable stack.

I think it's similar to that. I dug down and got some actual performance
numbers below for eliminating the fstat() calls, with the conclusion
that it's probably not worth spending too much time digging into it. But
details below for completeness.

I was wrong to say fstat() before, it's a regular stat(). The
interesting backtrace is:

  #0  __GI___stat64 (file=0x555555ab0bf0 "/home/peff/tmp/.git/reftable/tables.list", buf=0x7fffffffd630)
      at ../sysdeps/unix/sysv/linux/stat64.c:29
  #1  0x0000555555832ad6 in stack_uptodate (st=0x555555ab0ae0) at reftable/stack.c:575
  #2  0x0000555555832c5c in reftable_stack_reload (st=0x555555ab0ae0) at reftable/stack.c:625
  #3  0x000055555581f690 in backend_for (out=0x7fffffffd798, store=0x555555ab0900,
      refname=0x555555aae178 "refs/tags/foo-1", rewritten_ref=0x7fffffffd780, reload=1) at refs/reftable-backend.c:283
  #4  0x0000555555824957 in reftable_be_reflog_exists (ref_store=0x555555ab0900,
      refname=0x555555aae178 "refs/tags/foo-1") at refs/reftable-backend.c:2266
  #5  0x000055555581393a in refs_reflog_exists (refs=0x555555ab0900, refname=0x555555aae178 "refs/tags/foo-1")
      at refs.c:2995
  #6  0x000055555581f730 in should_write_log (refs=0x555555ab0900, refname=0x555555aae178 "refs/tags/foo-1")
      at refs/reftable-backend.c:301
  #7  0x00005555558224df in write_transaction_table (writer=0x5555569abe30, cb_data=0x5555569ab820)
      at refs/reftable-backend.c:1511
  #8  0x000055555583354d in reftable_addition_add (add=0x5555569ab050,
      write_table=0x5555558220f0 <write_transaction_table>, arg=0x5555569ab820) at reftable/stack.c:902
  #9  0x0000555555822b2b in reftable_be_transaction_finish (ref_store=0x555555ab0900, transaction=0x555555ab0c80,
      err=0x7fffffffdbc0) at refs/reftable-backend.c:1633
  #10 0x0000555555813161 in ref_transaction_commit (transaction=0x555555ab0c80, err=0x7fffffffdbc0) at refs.c:2769
  #11 0x00005555556956c9 in update_refs_stdin (flags=0) at builtin/update-ref.c:789

So we are asking about reflogs for each ref under the "only reflog if a
log already exists" rule. Which means we can easily disable it by
setting core.logallrefupdates to "always", giving us a way to measure
the impact. So we can try:

  git init --ref-format=reftable
  blob=$(echo foo | git hash-object -w --stdin)
  seq -f "create refs/tags/foo-%g $blob" 50000 >input
  cp -a .git/reftable reftable.orig
  hyperfine \
  	-p 'rm -rf .git/reftable; cp -a reftable.orig .git/reftable' \
  	-L config true,always \
  	'git -c core.logallrefupdates={config} update-ref --stdin <input'

which yields:

  Benchmark 1: git -c core.logallrefupdates=true update-ref --stdin <input
    Time (mean ± σ):     128.8 ms ±   1.5 ms    [User: 97.1 ms, System: 31.7 ms]
    Range (min … max):   126.4 ms … 131.3 ms    23 runs
  
  Benchmark 2: git -c core.logallrefupdates=always update-ref --stdin <input
    Time (mean ± σ):     195.2 ms ±   1.7 ms    [User: 182.1 ms, System: 13.0 ms]
    Range (min … max):   191.9 ms … 197.6 ms    15 runs

So we saved all of those stat() calls, but writing the actual reflog
entries adds much more cost!

Sadly there is no "never" option for core.logallrefupdates. I hacked one
in and the result took ~96ms to run. So that tells us the cost of the
stat() checks: around 25% of the runtime.

Which is a big-ish percentage, but a small absolute number. It's 0.64us
per ref. Perhaps not worrying about too much.

The other interesting thing I noticed is that we seem to write() entries
individually with no buffering. Probably we could get an easy speedup
for big cases like this by using stdio in the fd_writer abstraction.
We're again pinching pennies to some degree, but I expect we may be able
to drop the 120ms case down to 60ms or so (just guessing based on the
extra reflog writes adding ~70ms).

There was one other oddity I didn't quite resolve. You may notice the
gross reftable.orig stuff in hyperfine. I originally wrote this as:

    git for-each-ref --format="delete %(refname)" | git update-ref --stdin

but for some reason that causes the subsequent update-ref to loop
infinitely on merged_iter_next_entry(). It does so reliably, but I can't
reproduce it outside of hyperfine. Super weird, and I'm sure I'm missing
something obvious.

-Peff
