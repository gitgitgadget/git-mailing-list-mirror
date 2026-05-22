Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37213655EC
	for <git@vger.kernel.org>; Fri, 22 May 2026 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779483256; cv=none; b=Dv/G97IMJg6BVI+ZgsSL4HebFwnxzxXA42xNkRv/SWwjQ/PWdxrIw3IzO2tPWOVuyLyXoF5DoLx1v5IBhK2pEVROu+y6e9xXaJEB9jXTmnnAWyv8vR44DDyrPYfWQKMNCMlB1eDJzN1UelvWLtxrznmYC2BrsvwS/n3dm4h46KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779483256; c=relaxed/simple;
	bh=A3Q0QdDj8m/L2pxfbaknyj9RJYYiBzrwVXvXSD+QJjM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BxHeY8j8F5ruckSY5ecw9+n5UFcNX6crrT7J0exYVghlYss3fsjZNtqFICkPN7Ki9nPX+2naCPCN4zeFsD7qOV6jkUx822coqPvmKrhsGpzVq+ocVXxPBw8Bq1dMAbmulXzXwxZNshsvE78wsBSgSHALQnBz8FG82braz2ER8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adamj.eu; spf=pass smtp.mailfrom=adamj.eu; dkim=pass (2048-bit key) header.d=adamj.eu header.i=@adamj.eu header.b=p4u/5cPs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cyPsparq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adamj.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adamj.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adamj.eu header.i=@adamj.eu header.b="p4u/5cPs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cyPsparq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3120EEC012D;
	Fri, 22 May 2026 16:54:14 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Fri, 22 May 2026 16:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adamj.eu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779483254;
	 x=1779569654; bh=TAGqFrDdjixaI4PA5DI0ScMoeLOXWMSKu7znEPUTTQ8=; b=
	p4u/5cPsxM6bN8eFackvYYhp3pekSktw1g0AgZKV/RU0Aqe559uB/WlxceMxiqxM
	KL5rd0sChi/4Oaq7rSqXKQgzjYRK50N9KL2048bOIjg3UaG7ueql2620uF0/z2Oy
	A+1f1S3TDNgm2KiA7Gp3pqz84AdFgWFblHjTwcsQk5/AzCumZ7526sYUdX5HaP4u
	nDeY9PxUWnDZ6OkYVEB5uHYQszqCDGJU5NMYsGwQ35ul23RoJJnWxLhCg4F9Q7h7
	bytTbaOAu+Alu7Cg05BF14TCj7pwlT5Owuyb+xPptaDEeVQmbVU3y8JAMPNU6wDT
	CEgQqKMHshuPz/N5nUJ5PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779483254; x=
	1779569654; bh=TAGqFrDdjixaI4PA5DI0ScMoeLOXWMSKu7znEPUTTQ8=; b=c
	yPsparq5arWaxm3tQmVeQ/TBV3VqlehALFGSoJPrYTrgml2CKv93IxbzlXxjv0Oo
	dzSrUIJtOWWhiMFGVG2sQWNhuuXU8RcNbG30zvCDrBl9KMKmKqzi0zHKfc4LXQcx
	V3r8G9AF/+FfBX4eygmc9qfMKUQ7tZIRZzBRF+TMb8uifsTsfQw2jpZq04B1zzOE
	2Uh4GkwzrSu1MGK+p2knDK+ILPg05Hi7kzyfQKbH/CbOKWMOrPAw8SElkMt5FI31
	2/w/8BECIpg1ZxRVfpPqCj8yZha1txQrlTRHhl0gYLohZqVtnUllZbdkIaTCKjYa
	+XHUj88t04GuBX/Sw2IiA==
X-ME-Sender: <xms:dcIQahtxCNspurpg95MLwib46N-KoWe_oMHCdCUt6G-T01ikyHtv4g>
    <xme:dcIQalQ-qWL-OAJy8Wuye3gcNmHps3EQP7PYfdzshqcwrIciiWwdkJN8aNpSS0ydl
    ahfE_vwPnNITM9UThwi857azkqjWxpF4i_joFNpijoJeGqdWmz1Ia6X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheduudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftegurghm
    ucflohhhnhhsohhnfdcuoehmvgesrggurghmjhdrvghuqeenucggtffrrghtthgvrhhnpe
    dvudektddtledvudfgieefvdegkeeggeduudfhgedtteeitdekleekveevgeduleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesrggurg
    hmjhdrvghupdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtth
    hopehvugihvgesghhithhhuhgsrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepthdrghhumhhmvghrvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dcIQarW5kRl5Q6MBmhGV1Cve2oZZRDRLZbrPH3Izjjukon6Uktl9DQ>
    <xmx:dcIQatoPDktivDrmGC0lW96GcIlR2lINJjiPCBeDdeOJFncWnwcbkA>
    <xmx:dcIQanT3DLRdqwu_sJwUxjIteZnOSLn745QneEvW0vdBlW7ihd1JfA>
    <xmx:dcIQan2PMJV0UFujf4ZHpFqQR3K42UpVzYZhpySsznlICitUyYLRSg>
    <xmx:dsIQapSdr58xbLswDyawc87aidq3AtLHojMzX1-KppoN0DT5NCNKzMJ9>
Feedback-ID: i8b3949f9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A49D9216008A; Fri, 22 May 2026 16:54:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoJsM15w4is3
Date: Fri, 22 May 2026 21:53:53 +0100
From: "Adam Johnson" <me@adamj.eu>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Adam Johnson" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Thomas Gummerer" <t.gummerer@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, "Victoria Dye" <vdye@github.com>
Message-Id: <9e2058b9-4c0d-4c4b-8a65-0eb4869a815c@app.fastmail.com>
In-Reply-To: <xmqqse7m6deh.fsf@gitster.g>
References: <pull.2306.git.git.1779194605735.gitgitgadget@gmail.com>
 <xmqqse7m6deh.fsf@gitster.g>
Subject: Re: [PATCH] stash: reuse cached index entries in --patch temporary index
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> I however have to wonder if simply replacing the external process
> invocation with "git read-tree -m HEAD" (i.e., oneway merge) gives
> a similar speed-up.

Good idea, I just tried this, but it does not help. The subprocess runs
with GIT_INDEX_FILE set to a temporary index, so oneway_merge
never uses the CE_FSMONITOR_VALID fast path.

The in-process approach is necessary because it lets us set
opts.src_index to the real index with cached stat and fsmonitor data,
before switching GIT_INDEX_FILE.

> What I read from the proposed log message is that the change is
> purely about performance and should not change any behaviour.  Why
> do we need a new test in t/t3904?  I would not have surprised if we
> saw a new test in t/perf/, though.

Ah yeah, my bad. I added this while iterating to catch a bug I introduced,
but it's not necessary for the final patch. Will remove.

On Wed, 20 May 2026, at 03:08, Junio C Hamano wrote:
> "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Adam Johnson <me@adamj.eu>
> >
> > `git stash -p` prepares the interactive selection by creating a
> > temporary index at HEAD, switching `GIT_INDEX_FILE` to it, and then
> > running the `add -p` machinery.
> >
> > That temporary index was created by running `git read-tree HEAD`.  The
> > resulting index had no useful cached stat data or fsmonitor-valid bits
> > from the real index.  When `run_add_p()` refreshed that temporary index
> > before showing the first prompt, it could end up lstat(2)-ing every
> > tracked file, even in a repository where `git diff` and `git restore -p`
> > can use fsmonitor to avoid that work.
> >
> > Create the temporary index in-process instead.  Use `unpack_trees()` to
> > reset the real index contents to HEAD while writing the result to the
> > temporary index path.  For paths whose index entries already match HEAD,
> > `oneway_merge()` reuses the existing cache entries, preserving their
> > cached stat data and `CE_FSMONITOR_VALID` state.
> 
> Clever.  As the fsmonitor_valid bit is in-core only, updating the
> index in-process would be an obvious and probably the only sensible
> way to preserve it.
> 
> I however have to wonder if simply replacing the external process
> invocation with "git read-tree -m HEAD" (i.e., oneway merge) gives
> a similar speed-up.
> 
> > This makes the refresh performed by `run_add_p()` behave like the one
> > used by `git restore -p`: unchanged paths can be skipped via fsmonitor
> > instead of being scanned again.
> >
> > In a 206k file repository with `core.fsmonitor` enabled and a one-line
> > change in one file, time to first prompt dropped from 34.774 seconds to
> > 0.659 seconds.
> 
> Interesting.
> 
> > diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
> > index 90a4ff2c10..4b3241c8cd 100755
> > --- a/t/t3904-stash-patch.sh
> > +++ b/t/t3904-stash-patch.sh
> > @@ -84,6 +84,24 @@ test_expect_success 'none of this moved HEAD' '
> >  verify_saved_head
> >  '
> >  
> > +test_expect_success 'stash -p with unmodified tracked files present' '
> > + git reset --hard &&
> > + echo line1 >alpha &&
> > + echo line1 >beta &&
> > + git add alpha beta &&
> > + git commit -m "add alpha and beta" &&
> > + echo line2 >>alpha &&
> > + echo y | git stash -p &&
> > + echo line1 >expect &&
> > + test_cmp expect alpha &&
> > + test_cmp expect beta &&
> > + git stash pop &&
> > + printf "line1\nline2\n" >expect &&
> > + test_cmp expect alpha &&
> > + echo line1 >expect &&
> > + test_cmp expect beta
> > +'
> 
> What I read from the proposed log message is that the change is
> purely about performance and should not change any behaviour.  Why
> do we need a new test in t/t3904?  I would not have surprised if we
> saw a new test in t/perf/, though.
> 
> Thanks.
> 
