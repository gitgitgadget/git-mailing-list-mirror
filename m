Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D45415C145
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058289; cv=none; b=doK1910MqOvxC9dtX1eSUsCuYj+R2PAGO9M7h1XzLzRefHnj9OLDsX195msQjQFctdjFIILrmJGSgR83MFN6ZuIY6IFkRQLZgEUtc10m72JzBIrLCIDVQk9QZ8ud9JZen4wahY34c8a48dNw/nGVQOoxGRvcDDyW4ni2czer4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058289; c=relaxed/simple;
	bh=fsyk788pM+oRDpXoOJAunyWIphKw5pcsT2+LNCF+t7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul8T/vyfvAhovY7mVL9s3ty9/Pzc0dfC2LL4XNIsw6z5yA74RHT4GMk4x/y3A8q7oLqlRNdKO9Q7+em8Hskb/mXbTsxmBx421OjA48GqBeTylvZUDWsDl37oECVJGobVNd9910tX5HDFHoXyJ8GKt2GLfnd65BIW64IYfUtEv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tlQAuqZc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ssg/IUC0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tlQAuqZc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ssg/IUC0"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 42012138FFCD;
	Mon, 19 Aug 2024 05:04:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Aug 2024 05:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724058287; x=1724144687; bh=Hc5uhN2fgB
	yBfdcxv1N/iqkHDVHD778V745qu3oMYdI=; b=tlQAuqZcqQr6fts3NYzfuVYrjm
	SCJejlbFGNtD/jIDwVF2feHnxfIFzQC59zFKUWWsNseFxrvZM84M9kN3CSaefN9S
	P1lUP6lWmKHcXZyAETStAIVERQLKdNz9MU7C+E9zyJN07KIf5TSWeJTQnqL4f8WT
	1FzfeITRc4OKLEYm/ZFrKaMpLGSVZiIppasIv14xxhL9ahnWpkdPcugjwmaFCq2Y
	7QxVc2u5ipp67Pl69UDv2aaBA39PDIHfKYusOLvimci8LUb6QzS2LRbxFoRClP1U
	/olJjRDBt5u4jK3nsA9rPTpbUrJya9cWCW961W3cpphAGJie9MT71xabHgEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724058287; x=1724144687; bh=Hc5uhN2fgByBfdcxv1N/iqkHDVHD
	778V745qu3oMYdI=; b=Ssg/IUC0k9ufldUfLFzSS+VZK3/MI9Cur9sJtSvc/QWn
	q9NZ61CFtR7VjxXQjazIQF24TCl1UFUROA6rHWDPVI7dcxfpH5OhpTAkGI4AxTHO
	xDQChCSd1EJID1g/5tW54lolbfiUwZr2Z//CERmquV/gXnnmh3Xb+7qSX3RQ1vGy
	5yaROOaI8WF2mwNB/OVWdT/QEj+i3Orz6RZH/Of5aXjtgvzp3Q+AAU0EIIF+GpkA
	x3MH5rBGlRJU0VsU4rza26k5S3CMCZaV6VPu72JGtBC/h7czE78CkFbcrevb8jYG
	yP0p9Um75c6TXWvU13GfV7rJDn+SB1bgUWLT4970pg==
X-ME-Sender: <xms:rwrDZvxX6J_bLvqJWCISCpXPDJYvd7k_F8Lbs-D8M6Epkqy6QhcJxw>
    <xme:rwrDZnT6P8HlFJit9nrDriLov6rPhU8Tr0cP4hvRuaNAabdskLDi9O3L2lriLljLF
    cx3xSZrY1RE0924Qw>
X-ME-Received: <xmr:rwrDZpUzkjUd7RS5DXG2fGI2I4BUTfNcql6rBHObkmqvYSe-hWgUmqTOV327c8HVmBHFHr5uVbTLuLkZFkadHdFKGiW9UPVN0-XltTNVfZPRF60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudelueel
    gfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:rwrDZphA1zENL5_TASErhC5i_aQ0ej11qUbcRM-jCFU3nHnkwiY_FQ>
    <xmx:rwrDZhDVEjXek5ALCoZbOQYbN89dPDkA53TDuLsg-vF027VO86Fo-w>
    <xmx:rwrDZiK0F1Bu6Bye-LifrFDN8BfKMpgGP3q-9e0dEF1MQakiu7p3uw>
    <xmx:rwrDZgDQ42P6ZE0axmv2mrbMu-jB93kWQZ0ryK_KVuxkEmuanFajMw>
    <xmx:rwrDZrAJLYDgcjLgGl5cHGJC2zJnH07Zp2aj2bBqThxJ2cxE3OtVXnuI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 05:04:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f033d36e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 09:04:15 +0000 (UTC)
Date: Mon, 19 Aug 2024 11:04:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/7] run-command: fix detaching when running auto
 maintenance
Message-ID: <ZsMKpNMDTysNcreR@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
 <9befef7c1f7520d58af2b2db17174b8dbc493d56.1723804990.git.ps@pks.im>
 <20240817121424.GA2439299@coredump.intra.peff.net>
 <ZsLjcjhgI8Wk2tIV@tanuki>
 <20240819084614.GA2955268@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819084614.GA2955268@coredump.intra.peff.net>

On Mon, Aug 19, 2024 at 04:46:14AM -0400, Jeff King wrote:
> On Mon, Aug 19, 2024 at 08:17:22AM +0200, Patrick Steinhardt wrote:
> 
> > >   2. Having racy background maintenance doesn't seem great for test
> > >      robustness. At the very least, it might subject us to the "rm"
> > >      problems mentioned elsewhere, where we fail to clean up. Annotating
> > >      individual "git gc" or "git maintenance" calls with an extra
> > >      descriptor isn't too bad, but in this case it's all happening under
> > >      the hood via fetch. Is it a potential problem for every script,
> > >      then? If so, should we disable background detaching for all test
> > >      repos, and then let the few that want to test it turn it back on?
> > 
> > Might be a good idea to set `maintenance.autoDetach=false` globally,
> > yes. The only downside is of course that it wouldn't cause us to detect
> > failures like the above, where the concurrency itself causes failure.
> > 
> > Anyway, for now I'll:
> > 
> >   - Send a patch to fix the race in t7900.
> > 
> >   - Investigate the reftable concurrency issue.
> > 
> >   - _Not_ send a patch that sets `maintenance.autoDetach=false`.
> 
> That sounds like a good direction. I do suspect there are at least _two_
> races in t7900:
> 
>   1. the detached maintenance that we run explicitly, which causes the
>      "rm" cleanup to fail
> 
>   2. whatever earlier test is kicking off detached maintenance via "git
>      fetch", which is causing the reftable concurrency issue.
> 
> Fixing (1) should be easy (and it looks like you've already sent a
> series). Fixing the reftable code will stop us from segfaulting for (2),
> but I wonder if that detached maintenance might cause similar "rm" style
> problems elsewhere.

It certainly might. The only reason why I don't want to send that patch
now is that it feels a bit too reactionary. We haven't had issues in the
past with it to the best of my knowledge, even though it is an issue in
theory.

We can certainly revisit that though if we see that it indeed is a more
widespread issue.

> > The last one requires a bit more discussion first, and we have been
> > running with `gc.autoDetach=true` implicitly in the past. Thinking a bit
> > more about it, the reason why the above bug triggers now is that
> > git-gc(1) itself runs git-pack-refs(1), but does that _synchronously_
> > before detaching itself. Now we detach at a higher level in the
> > hierarchy, which means that the previously-synchronous part now runs
> > asynchronously, as well.
> 
> That makes sense. I guess we've perhaps been doing background gc for a
> long time, then, just not in the refs? In practice most repos in the
> test suite aren't big enough to trigger auto-gc anyway, so it may only
> affect a handful of scripts.

Yup. We should expect this to work just fine, because it can trigger
regardless of whether or not we run auto-compaction concurrently or not.
After all, the reftable backend even performs auto-compaction after
every write to the table, so any two concurrent writes may hit the bug
without even invoking git-maintenance(1) at all.

> Once the reftable issue is fixed, it's possible that the lingering
> detached processes don't cause a problem in practice (because they're
> not really writing much, and/or have finished by the time anybody else
> gets to cleanup), and we can just live with them. But I'm worried that
> sounds like wishful thinking. ;)

Could certainly be, yeah. I just want to focus on fixing the immediate
issues before we jump to conclusions too fast.

Patrick
