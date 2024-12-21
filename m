Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE31F190F
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734781881; cv=none; b=kJQa6d8g5rstFar5z4MFmSn2dbkYlgRwU9zZpIWoxIr3Lb3HZ2HkmoQRyLg1FT5Ce5VTJYWb5Ks5SG8PDQIRy32SNcnUdGkFHK+s7ABEpHllS4WbuHCunYZeFQYSvSLOjJmpkzuwkUo3NIsWfGLKyV57ckZTDoHS+peDBkYwenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734781881; c=relaxed/simple;
	bh=WcRhQxRRKPP8dE2kJ1B9itGRtKwnW+MY0MfCdXTy+WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7qvD6QcON9QGSaaZ+KhfM78pwnudd1AIDJ4W2zN75q6SAx0QgNymyiIK5wQN+7PagKb9mubomZ+OTBaUYikoXuiTjyVbXF0ieeaFwmaxFxB4iYjnNeqstfzUwh5mORAAOD1NfQg0+yWcMnmRtssvovcsTz/1X8xzP/z6UPeh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CBeVHLde; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CRR/0qQX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CBeVHLde";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CRR/0qQX"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E6F1013801CB;
	Sat, 21 Dec 2024 06:51:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 21 Dec 2024 06:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1734781876; x=1734868276; bh=nJrHyi1YwZ
	sxO6ElILBkjsQzMYoyd/ZxV+uM1AQ70D8=; b=CBeVHLdeifIDGoTIkw+DzTexqu
	LkcFPECMpNi/PlIZ0ZQWUeZY5WZASL9i7YX7lE/SQ6iboYl37lIPWDLnKxOGA5Qr
	wn8Uc+qeSM5Zv0N9vxrbVcDBhtPntnvRNZUObJiEpNPifnVNQnWxTrL1uxxuaugV
	CgWV+/4sfegDxFgK5P1CGLAxllf6Bs6NWvfgG6TEyVYXrZr+lmuzd2882R/N5J1+
	fC6Tgt+AcScZhiIkj0ZKeIGIOZPpZJc8mZt6NalcHHUCbDpu52D811xeYAvdKYXk
	TnMJLy3ApiQ1bhbY08ke9ym9dNIpVknotujPdydFjm8iq0fv1JhWgrMC/K6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734781876; x=1734868276; bh=nJrHyi1YwZsxO6ElILBkjsQzMYoyd/ZxV+u
	M1AQ70D8=; b=CRR/0qQXrFpXPryKI6wq5f/IQITSYI+74cppwN2QhXGblntAEuP
	MFYVDxP1Ked0dPaepy3np9fcNPJ/karuwZpckBgsNv9na2HBtJHUosq9752DyYp0
	6xIp7z4dsQhsGQfVXfdFLei43bQ/zJ69g6nrXjPkAB0EqtLoonve6qIivaUq7F7h
	7ZBOHQBad7/UXlc8BmOByWFo8+G32SBw3U71f40AqGnIv0lj1crODI+0dDHbVOb8
	dPWuQbvr9jNox1rm0nkKU0bdhNulaL0geK7R5r/Ogc0gNcUls2J+LvZV61djud5u
	gJOM6hjiyRtQsQl6awBUBupo8/Kgmu9we0g==
X-ME-Sender: <xms:tKtmZ8WAFRHH0hy05-lMKDCn3QIcpYctcSgaz7cc31vcfAZIt7HPIA>
    <xme:tKtmZwnuamvUxe3qlgZEz1XKXiYwxCQWFHZyYKSKk1AEOs55g1hR9SmhvDsHq5wv3
    WAByrOCYoXe8w5cUQ>
X-ME-Received: <xmr:tKtmZwbIDwRGs3BHlgT2UPCLw4w4CcxTumfkbfTcOtNOdO9cuSSTCWCLL2oAlKhjB_bBq__F1GDqVqQ_dnpJS0u31YL28LAyOzpPHroJhGNB4zJBGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsg
    hrihgughgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tKtmZ7X62MYDoDQBj7x9ekI3R2XvhX0ElyclA6mDSg_UhrfetWDkFA>
    <xmx:tKtmZ2khwex3n1qmxA-bcy_T_PV6F18VGzqp8GM8qu3pqLYpzgmJ0A>
    <xmx:tKtmZwcs8q2kECsqzYZapDZ8F3RXhCcUHl51hh7mSrHa38to3oAMPw>
    <xmx:tKtmZ4GavL4LH3U6JMzsoYODso3suPa__2e8PufdcltD999Vy3ScWA>
    <xmx:tKtmZ4hrO3GIWsX6-6MqvM_Gvp1YN1pCJhdyBFaxP3xlAaYRKflCJ78t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 06:51:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d7071b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 21 Dec 2024 11:49:20 +0000 (UTC)
Date: Sat, 21 Dec 2024 12:50:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.48.0-rc0
Message-ID: <Z2aroitgFL97dIbZ@pks.im>
References: <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com>
 <Z2EC9rq3F0rTljff@pks.im>
 <010a01db508a$4544d750$cfce85f0$@nexbridge.com>
 <015901db50b5$e3a7f6e0$aaf7e4a0$@nexbridge.com>
 <Z2JyFB3CddYM_LP4@pks.im>
 <00ca01db5257$12708d00$3751a700$@nexbridge.com>
 <Z2UX2v8sc-DELaVm@pks.im>
 <015501db5314$b61ac2a0$225047e0$@nexbridge.com>
 <Z2XHfzLEBUfqygBq@pks.im>
 <016b01db5325$34c0fd80$9e42f880$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016b01db5325$34c0fd80$9e42f880$@nexbridge.com>

On Fri, Dec 20, 2024 at 04:21:53PM -0500, rsbecker@nexbridge.com wrote:
> On December 20, 2024 2:38 PM, Patrick Steinhardt wrote:
> >On Fri, Dec 20, 2024 at 02:23:49PM -0500, rsbecker@nexbridge.com wrote:
> >> On December 20, 2024 2:08 AM, Patrick Steinhardt wrote:
> >> >On Thu, Dec 19, 2024 at 03:46:20PM -0500, rsbecker@nexbridge.com wrote:
> >> >> On December 18, 2024 11:07 AM, I wrote:
> >> >> >All tests, actually.
> >> >> >
> >> >> >$ GIT_TEST_DEFAULT_REF_FORMAT=reftable GIT_TEST_CLONE_2GB=true sh
> >> >> >t0000- basic.sh --verbose -i -x
> >> >> >error: reftable: transaction prepare: out of memory
> >> >> >error: cannot run git init
> >> >>
> >> >> Any updates or hypothesis on this? Our test system has loads of
> >> >> memory
> >> >> - I cannot figure out where the allocation failure takes place.
> >> >> There is a limit to how much memory can be allocated, but it is
> >> >> very high and our virtual memory is extensive, but this is a 32-bit
> build.
> >> >
> >> >My hypothesis is that this is caused by ps/reftable-alloc-failures,
> >> >but I
> >> am unable to
> >> >tell where exactly the error comes from. So I'm dependent on your input.
> >> >
> >> >Could you please bisect the error? Finding out where the error is
> >> >raised
> >> would also
> >> >be quite helpful. It has to be one of the reftable functions that
> >> >returns REFTABLE_OUT_OF_MEMORY_ERROR, but other than that I do not
> >> >have any more gut feeling right now.
> >>
> >> This is what bisect shows:
> >>
> >> git bisect start
> >> # status: waiting for both good and bad commits # good:
> >> [777489f9e09c8d0dd6b12f9d90de6376330577a2] Git 2.47 git bisect good
> >> 777489f9e09c8d0dd6b12f9d90de6376330577a2
> >> # status: waiting for bad commit, 1 good commit known # bad:
> >> [063bcebf0c917140ca0e705cbe0fdea127e90086] Git 2.48-rc0
> >>
> >> git bisect bad 063bcebf0c917140ca0e705cbe0fdea127e90086
> >> # bad: [2037ca85ad93ec905b46543df6df4080f6ca258b] worktree: refactor
> >> `repair_worktree_after_gitdir_move()`
> >> git bisect bad 2037ca85ad93ec905b46543df6df4080f6ca258b
> >> # bad: [6a11438f43469f3815f2f0fc997bd45792ff04c0] The fifth batch git
> >> bisect bad 6a11438f43469f3815f2f0fc997bd45792ff04c0
> >> # bad: [f004467b042d735a2fe8bd5706b053b04b1aec65] Merge branch
> >> 'jh/config-unset-doc-fix'
> >> git bisect bad f004467b042d735a2fe8bd5706b053b04b1aec65
> >> # bad: [e29296745dc92fb03f8f60111b458adc69ff84c5] Merge branch
> >> 'sk/doc-maintenance-schedule'
> >> git bisect bad e29296745dc92fb03f8f60111b458adc69ff84c5
> >> # bad: [5b67cc6477ce88c499caab5ebcebd492ec78932d] reftable/stack:
> >> handle allocation failures in auto compaction git bisect bad
> >> 5b67cc6477ce88c499caab5ebcebd492ec78932d
> >> # good: [31f5b972e0231d4211987775dd58e67815734989] reftable/record:
> >> handle allocation failures when decoding records git bisect good
> >> 31f5b972e0231d4211987775dd58e67815734989
> >> # bad: [18da60029319733e2d931f2758a8e47b8b25b117] reftable/reader:
> >> handle allocation failures for unindexed reader git bisect bad
> >> 18da60029319733e2d931f2758a8e47b8b25b117
> >> # good: [74d1c18757d1a45b95e46836adf478193a34c42c] reftable/writer:
> >> handle allocation failures in `reftable_new_writer()` git bisect good
> >> 74d1c18757d1a45b95e46836adf478193a34c42c
> >
> >This is missing the last step for git-bisect(1). Right now it could be
> caused by one of
> >these commits:
> >
> >    18da600293 (reftable/reader: handle allocation failures for unindexed
> reader,
> >2024-10-02)
> >    802c0646ac (reftable/merged: handle allocation failures in
> >`merged_table_init_iter()`, 2024-10-02)
> 
> They are there, it is just that Outlook wrapped the lines on me.  The
> 802c064 is not in my repo - I bisected from 2.47.0 to 2.48.0-rc0, so may
> have skipped a more recent commit than rc0 has.
> 
> >The first commit seems quite unlikely to be the root cause. The second
> commit is
> >rather interesting though. I wonder whether NonStop's malloc returns a NULL
> >pointer when given a size of 0?
> >
> >A quick stab into the dark, but does below patch on top of `master` make
> things
> >work for you?
> >
> >Patrick
> >
> >-- >8 --
> >
> >diff --git a/reftable/merged.c b/reftable/merged.c index
> bb0836e344..7ae6f78d45
> >100644
> >--- a/reftable/merged.c
> >+++ b/reftable/merged.c
> >@@ -244,7 +244,7 @@ int merged_table_init_iter(struct reftable_merged_table
> >*mt,
> > 	struct merged_iter *mi = NULL;
> > 	int ret;
> >
> >-	REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len);
> >+	REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len + 1);
> > 	if (!subiters) {
> > 		ret = REFTABLE_OUT_OF_MEMORY_ERROR;
> > 		goto out;
> >diff --git a/reftable/stack.c b/reftable/stack.c index
> 59fd695a12..1b6b8cc9ea
> >100644
> >--- a/reftable/stack.c
> >+++ b/reftable/stack.c
> >@@ -1612,7 +1612,7 @@ static uint64_t
> >*stack_table_sizes_for_compaction(struct reftable_stack *st)
> > 	int overhead = header_size(version) - 1;
> > 	uint64_t *sizes;
> >
> >-	REFTABLE_CALLOC_ARRAY(sizes, st->merged->readers_len);
> >+	REFTABLE_CALLOC_ARRAY(sizes, st->merged->readers_len + 1);
> > 	if (!sizes)
> > 		return NULL;
> >
> 
> The fix above does not appear to make any difference.

Indeed, there was one more issue in `reftable_stack_reload_once()`. I
could now reproduce those errors by adapting `reftable_malloc()` and
`reftable_realloc()` to return `NULL` pointers when asked for a
zero-sized allocation. This removes any implementation-defined behaviour
of allocators and allowed me to surface the issues.

I've sent a patch series now [1] that should address your issues.

[1]: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>

Patrick
