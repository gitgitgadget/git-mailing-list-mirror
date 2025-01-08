Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267DB644
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353282; cv=none; b=SVb3Civ/ckSO4oDyALexr2elL5GONnP390A+fEKpTFEtTtA/NqfIMyQUIxf/GgodwvojUNmgx55w65UvOOGw9vuBpN0vxA6S085CLIkRmq3Ssf99ehrWTBw+eSo4HThco0d2ReG7OwMCmbDWfNzmvDOGPjCX2XQVGg4miheBjfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353282; c=relaxed/simple;
	bh=AJxkP49q1jnB6lwREfZyDAUUxbvpLw26gSBwZchUQPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlnWOHDTYKw8ADEpXDjoG12sqofslYNHlD1OHn12tBIgMfgyv+JnAMZpABudYa+oekYArxsNUeBO8ge0dVb2b3CeQIlWPSjYt0xAhlMdETdFf9wCXT6EnHZnc0V0dzZyxtyAOn/HC7r6AmSKrd2jGyNd7fsgn9f/0MmuOQn3Yyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rzH4oKAu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rxf6iU30; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rzH4oKAu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rxf6iU30"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F31B138028A;
	Wed,  8 Jan 2025 11:21:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jan 2025 11:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736353279; x=1736439679; bh=ke3DpJwa5J
	c8hzauWBfXx2z+O2iXFPPgsjpyJlIJdus=; b=rzH4oKAuW9SeGIWj/czNVI1HUX
	c+AXSs6nsD4M+DIHFbwIljeyrX70gMi4uCsT7K4BnPG6Hx+svrByDWpL5V8RhdTs
	zbh2jPJoTzlbh06XzU13RC8k+ud+47nM6ntnIAXzFsnt5yHioHjqSPCP0IwDhVxk
	NRb149vyWKqmvYLziTm9z170ywbOxn/gxeFxGsk0qyd6QWM8SF1kVbTjfl8GBmcE
	MCUM0M1DxIUiHvAZ/l2wD+j3pSxPAQuU9+ovlJcfrcQnd7dYBwARqpBUQG5S1/+v
	ySg+fZe6bQYvPx5lJuNK3Jb7AofSRzpgCmD4dy41NTdeZ5FCcwxC7FvWgtyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736353279; x=1736439679; bh=ke3DpJwa5Jc8hzauWBfXx2z+O2iXFPPgsjp
	yJlIJdus=; b=Rxf6iU30F8X0197MBAVfuYMkW6024Lz9GVbvrGLoxmi0vk3in4j
	V0N3nelJ3uifBD9ywd+E2mCBcOFHegsN/5XAGKRvsY/LFsY15qTjY8Ni8uSD2WhZ
	MDQF/rtR+PRuRqlN/SKKMdHPj/7DLUlp+lfDuT3O9jmQFJpt0hWo22mWJQ7O+FIa
	M4HQCbfkh+/azPCLwpx/6DVFaGqwUd470MeGCH4avwR5UhITrIEADx2etp/57QhA
	R4PiFw6yk07eVqTm9Uu4LE/Gmep0mHcuA+SnFMl2ykL15NdAXbfD9BVviAmsh6id
	NW1zvg7MB3t9ydcLktiIdWLYpQyrZ69fhvQ==
X-ME-Sender: <xms:_6V-Z6VQPd38ovC7Pn842rOEZ6ztejJuwwvflcaNQAnGfEVZ9JuskQ>
    <xme:_6V-Z2mwof-wgg16JllwjOioFXEDB3igAzSfneE_ZLDKxKpLCnfLM3Fqgsq94i5nh
    42HvmMbz5-WHPKPyA>
X-ME-Received: <xmr:_6V-Z-bKgsJj3ycipP3r-zafsHMFDFrPGdxk29RTdwNINPUfOa4DLPc8UsJDqIehaH9k4u_0RKB7r-DJEu3T22wC3QkBu2B431mq0_voMOcLUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekhfetgeffieekjeejieeuhfeujeffuedvvdeljefh
    keehuefgffelledukeeinecuffhomhgrihhnpehlihhsthdrnhhofienucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghnug
    grlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:_6V-ZxV05hhjchxNoxK6nTUgBgtoxOhdta3kNpfHlmX68iikOZRPcA>
    <xmx:_6V-Z0kPChzMHoMtwR2ILrlJ1zO-rJHU4ymHjS7m9IdQfNWDngaSLg>
    <xmx:_6V-Z2e0NuApWX_aaxOZYijSI-y1rfO2emsCsNCjE9OUWFK5nE-Eog>
    <xmx:_6V-Z2Hr8LB9xaqpW5g5zmGMnzwPY2Ob8gjda0p7Xreb5sgQ0BYlfQ>
    <xmx:_6V-Z-ifpNJXvIfS5ok6dhqS4SRBuCItLTySeOgAo1TLsKm35tsOWGhd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 11:21:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 251a460a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jan 2025 16:21:16 +0000 (UTC)
Date: Wed, 8 Jan 2025 17:21:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 2/2] reftable/stack: accept insecure random bytes
Message-ID: <Z36l--QUjaYYb6Uf@pks.im>
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
 <20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
 <xmqqzfk2qr62.fsf@gitster.g>
 <xmqqv7uqqqu9.fsf@gitster.g>
 <Z34gfa-_dSbWD19h@pks.im>
 <xmqqr05dnwli.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr05dnwli.fsf@gitster.g>

On Wed, Jan 08, 2025 at 07:39:37AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> It may still make sense to drop the first hunk, and consider how to
> >> proceed when you further want to reduce the unnecessary dependencies
> >> for external users of the reftable library, though.  Are there
> >> correctness implications if git_rand() in format_name() yields non
> >> random results (like, always using "rnd = 0" instead of calling
> >> git_rand())?  I seriously hope not.  And if there is no correctness
> >> implications, perhaps we can replace it with rand() or even constant
> >> "0"?
> >
> > No, there aren't any implications on correctness in that case. Sure, the
> > randomized delays not being randomized can lead to more contention. But
> > even when the randomized suffix for tables is deterministic we wouldn't
> > have an issue as the files are still distinguished by their update
> > indices.
> 
> OK, so they both can be turned into a simple rand() that is expected
> to work more reliably especially on more exotic systems (meaning:
> the ability the system providers can test their rand() is much
> better than our ability to test our git_rand() there)?  It would
> help us solve the immediate issue reported, while removing one git
> specific function from the reftable library?

Hm. The problem is when Git dies in the middle of a transaction:

  1. We write the temporary table.
  2. We compute the not-so-random suffix.
  3. We write the temporary "tables.list" file.
  4. We move the temporary table into place using the not-so-random
     suffix.
  5. Git dies before updating "tables.list".

Now we have the temporary table moved into place, but "tables.list"
hasn't been updated yet. When the next Git process comes along and wants
to update the table it would result in an error if it computed the same
suffix.

The reftable library knows to clean up such stale tables when not
referenced by the "tables.list" file, but it doesn't do so on every
write. So this would likely still cause issues in practice.

I already though about this scenario when writing my mail, but didn't
really think about it as "correctness". But I guess it is.

Also, based on the feedback from Randall it's not only the reftable
backend that has issues. It's a more general problem on ia64, where many
tests are failing. So even if we fixed this one case, it's likely that
other cases would still die when running low on entropy.

I dunno. It feels like a platform issue, not like a Git issue, when the
RNG cannot provide us a couple of integers. The OpenSSL backend seems
unfit for use to me as none of the other backends have the same issue.

Patrick
