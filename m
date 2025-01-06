Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EF1CF5EA
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150221; cv=none; b=KzK0qyBTAFlg8m07o6NWXh6SXpFPu3Ek9M2hgSll5EbNfXnCrHmEK9OFbZ/2s2vLB73ixRe46/kV1+Hbr8SV1Ee137cAeC2kl6Sus+RqtJ95PsEj+DguXo0ezesfVATBOtic+CoqkOWwsnK81kp3Fqmzu2ye5l/YNHJ1lrrto/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150221; c=relaxed/simple;
	bh=zIRM1ycaPTb1tRPaFBt81SDCtdfIVsogQRYhRRDZVWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZyIPKnzal9/s1cXUFXcn7PvMwyBImQvfwWLoBh8tBxfUB7dG+IyHFIKjECoPpt35/Fyz3BG8eO5ZzIUqoQObLe/6UyyWD512V9svtKc1lEZEz7RH5s/jvkQlh++s7mzja45gXf4Sjz2vKCua2cVLa+3rxPIpi/eStA3EOFeitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LmvgKZME; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lExuK/Lh; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LmvgKZME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lExuK/Lh"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E11D114011F;
	Mon,  6 Jan 2025 02:56:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 06 Jan 2025 02:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736150219; x=1736236619; bh=zokAv1Y3VM
	9yxiv1e1cNOQUOe0sL/WKeTTZWfsj9fbg=; b=LmvgKZMEknZONdXu85/Cr3oLlf
	FhoN2Ry3LDfmI8VXVnycguoBuU1mCsGwRERp0uOT3Obbfe5nlYnRPVvDvI7vCTEI
	U9m4lvoP3NTmkjoyH6aaxHQtuF02Kjih9l4XMshMqFvSMe/yCrdj1CYubDGlB0Ci
	HRiJdNWnhIbdHABD6wmJ/r2zFNiG6gXR/ruRm0DncQdPh3JmBOMWOGeNs4+kgm4g
	GKcpt8OaPKiAcHR5xzlO+35GX65MdS9bxeVBMyJPlydrp9WVbh+9fvC3y14FojbZ
	C0G7adXZgg0hDl3nfhPRU8dN6Hd60y4pmPB4IQQUiye8kQlrF9MOyu9sxixw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736150219; x=1736236619; bh=zokAv1Y3VM9yxiv1e1cNOQUOe0sL/WKeTTZ
	Wfsj9fbg=; b=lExuK/LhYkQT4ACkSZYW1TucfiRjA1z/EVsa7W6uEZ+Qr7ueqWM
	MyWQhikwyvzL7sz4zHidHVWS3cj7CZXfVFhh8pd7wefM+qnY+8NaWD7fj1AzdP7A
	6vKlTeywwM88AevLfXp64rT3wnasJkTHg/VN8pL3rFnHUA2P58NZExGRcqfmsAxS
	LylKDgLzh/bhYWwmzk02RUr98ychI4GUUg8AjJO9N2/iyU+18L6e4DKAdV7y3rR4
	ztYdS1GKQ5qNN6jxzhT+s1aNI0uJ9unX/MiQvTZ1MAuUQ7koR0PKtd6PETpk4a1m
	0eLqALLJqyE8qLbJqyyrEVOw4rr/wAA7yqw==
X-ME-Sender: <xms:y4x7Z_sEcDYpa2wANe5I4QElxszP08IWGPRPZIjgEycuj2zL6RjACg>
    <xme:y4x7Zwe9hVudcziDZw3wtqCvk58dIF6LjxHGynrhtnsHrCj0JWU48V-p6drGsXkgq
    ygBCgzicc95DbV9aQ>
X-ME-Received: <xmr:y4x7ZywemmtZ6Trgs69c5yZvRmITFZxsvzI5RQffKI4hgj4F-CObaCE1fRxKcEyqW9h2haVMUrrDZyzMHamAMTAr7sxbAoI_LYoTwFv54CoUOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:y4x7Z-PMLYUizGpLtG9f_fhB7i7GnAIMaJq0ta6y7s2O5ABPKBPc4A>
    <xmx:y4x7Z__yG9J-BVnDsc6I21OFI6KVpFQT-q6AvjqXFlunQ-edG8Ms6Q>
    <xmx:y4x7Z-UsMjgQMbrMexL7yd8EqXbS-B7HNXn_bkNRfyrTYBmnM8G_xw>
    <xmx:y4x7ZwdtbG1HK15xflO2AGwXhVHTh174h7-GA-xD-fyAE9xVZGiZgg>
    <xmx:y4x7ZyZqGwbNNbz5S3LWc11miRv92L7pUTBDi_GGv64RIr619mSQWJTn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 02:56:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dbd2d261 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 07:56:58 +0000 (UTC)
Date: Mon, 6 Jan 2025 08:56:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/6] test-lib: simplify leak-log checking
Message-ID: <Z3uMyQ-YfQFI8qmH@pks.im>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
 <20250101201721.GD3305462@coredump.intra.peff.net>
 <Z3fSmSYoWs-a6afW@pks.im>
 <20250103202410.GC3212696@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103202410.GC3212696@coredump.intra.peff.net>

On Fri, Jan 03, 2025 at 03:24:10PM -0500, Jeff King wrote:
> On Fri, Jan 03, 2025 at 01:05:45PM +0100, Patrick Steinhardt wrote:
> 
> > On Wed, Jan 01, 2025 at 03:17:21PM -0500, Jeff King wrote:
> > > @@ -1181,8 +1170,14 @@ test_atexit_handler () {
> > >  }
> > >  
> > >  check_test_results_san_file_empty_ () {
> > > -	test -z "$TEST_RESULTS_SAN_FILE" ||
> > > -	test "$(nr_san_dir_leaks_)" = 0
> > > +	test -z "$TEST_RESULTS_SAN_FILE" && return 0
> > > +
> > > +	# stderr piped to /dev/null because the directory may have
> > > +	# been "rmdir"'d already.
> > > +	! find "$TEST_RESULTS_SAN_DIR" \
> > > +		-type f \
> > > +		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
> > > +	xargs grep -qv "Unable to get registers from thread"
> > 
> > Can't we use `-exec grep -qv "Unable to get registers from thread" {}
> > \+` instead of using xargs? Or is that unportable? Might make it a bit
> > easier to reason about the `!` in the presence of a pipe.
> 
> I don't think that saves us from negating, though. The "grep" will tell
> us if it matched any "real" lines, but we want to report that we found
> no real lines.
> 
> Plus I don't think "find" propagates the exit code from -exec anyway. I
> think you can check the exit status with more find logic, so you'd then
> use a conditional -print for each file like:

It should. Quoting find(1):

    If any invocation with the `+' form returns a non-zero value as exit
    status, then find returns a non-zero exit status.

>   find ... \
>     -exec grep -qv "Unable to get registers from thread" \{} \; \
>     -print
> 
> and you have to check whether the output is empty. The easiest way to do
> that is with another grep! Which also needs negated. ;)

Yup, I didn't mean to say that we can drop the negation, but that it
makes it easier to reason about what the negation applies to (the whole
pipe or just the find(1) command)).

> I think if we really want to drop the negation, we'd be best to flip the
> function's return, like:
> 
>   have_leaks() {
> 	# not leak-checking
> 	test -z "$TEST_RESULTS_SAN_FILE" && return 1
> 
> 	find "$TEST_RESULTS_SAN_DIR" \
> 		-type f \
> 		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
> 	xargs grep ^DEDUP_TOKEN |
> 	grep -qv sanitizer::GetThreadStackTopAndBottom
>   }
> 
> And then you could switch the initial "grep" to -exec if you want, but
> there's no negation to get rid of, so it is only a preference of -exec
> versus xargs.

Yup.

Patrick
