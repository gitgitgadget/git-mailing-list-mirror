Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5C817
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466774; cv=none; b=Wl23RQqjYO2ayyUWK1VXr9PcnL/Tq+WGfOYA26ieTumWATaqJZPXFXt+hkEKcOtfxdbZRf0E+CP9WgbxpWhGZ6dbjf8D+lWBI4jxyUTfmAmw6/YLNkvgMxDuxEwgKPVn/aqRvq/KjHR3aEWmgPvGhvjSkFhC2Fr93JyJQXHTS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466774; c=relaxed/simple;
	bh=Cm4ZjKlg9p655sTKsIICuA2ybLD0uWgUI7GrNNedVZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb5xDnBNbkwkb/rM/FLDveriJ+yENEpuuhoUKx0Bzkf8eVOTI7qvAdB+6tyjADnkkt2nSKnUeLZr1yvTLbw0UrurluZRBIAndKVTXBW7QIQCI79Td6HDaj8XZWw2kUy/WkX+Ph1OB69dJKPWiyGLTipzWzoLPkFLFLx1DmVLFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gxiHgG1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KCCyhw2o; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gxiHgG1t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KCCyhw2o"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DF0E138047C;
	Wed,  9 Oct 2024 05:39:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 09 Oct 2024 05:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728466771; x=1728553171; bh=sgku+dvSuU
	pTLdiBX+/YB8LLcasf+zecYKt3ZJnKvGE=; b=gxiHgG1t1p5AS53IsNLrbgulpq
	wg+uLR8XmOp+bg59n+r8rYqkF4RsY95mx0DUirvoTQeUYSmhDn3aH0Tdx1DyugYN
	9JCFr1IMPmUXZV8NbLYDUSUW6W7QlKp4wOAzDm4t58zlDD2SyXC5HvrQT2lnYznY
	azMtsEQu8Kz8u13iuD7unAuMeULnGW9v3c/SsFo42xgkbM9GYG3p8L6ZO7BbpKUT
	ZaIoU7YphFyL09zvZNZYFaM8+YRpTZIYu8wTc4NI8iuy19yudADlJHqVEeone81i
	3rYhTjLG7b8KxODIqZa7x4yDL5vLCpLopgbbC9kZ0BllZzMxUaMud3qJsa6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728466771; x=1728553171; bh=sgku+dvSuUpTLdiBX+/YB8LLcasf
	+zecYKt3ZJnKvGE=; b=KCCyhw2otmoSE6GNE8XWqKVwziPaxdoESg2Cj8Gwu2Bj
	lh0HdMV/ELRWOoYu/euqC9EdHBHaHGZZEXQl1NJjD+3JzxQeR6fOmHW4XXOJtRSK
	MAg1KrbVPeZ/3vlvFf+YYgxdY62rDfwMzcXYDzQJGtKqHLbuqyi99Vf6A6d5nbRq
	VdqDFZEzgtlC4jv8bj7Q+1XguluQSNgj5hh/URpYwlqCSp2DKhtetTJKD8dkcY+E
	G9/fs0IYNeF3gCDEiYg++87uS4PggxKeM7UTIbQfRe1yKwAx95Bq+Y7mucsZFLgW
	eMWQaqOiZ8kMfL9amLbU6TGNudL/z15nInItwJdwKw==
X-ME-Sender: <xms:U08GZwf3eby4iYFUCP7RD_w85UlMYcrn03Cv9ASk56RU29HqDT5h_g>
    <xme:U08GZyOUSOjsQ9h0YtAREVlNC1UKZ2nJGd8OuQGTjaeLms0kO2A61-q8i98lywyxT
    W1uQ0HWFRZl9p72Ug>
X-ME-Received: <xmr:U08GZxjdov1Zg7Qctt3lRrEtbR_38UTGVSFgruL9his-fbble43KXUxuHQI4kFLKtVqHyCedlWay_IYw9bCXY2CrAw4bDqp63-yCJDWrgeEjwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhnuhgv
    thiiihesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:U08GZ18f_zekxlMvyWMhMQPfpDQpqTSu51SR_aD6k15Jyg57rEAiiQ>
    <xmx:U08GZ8t5p5eo9OsdAFdYssiPMyVii4PxKTu4Zv2jPeUdCjXqbg_XlA>
    <xmx:U08GZ8HZxdsaVNIMgSKAbWEsVbHdvPPmdEunF-IZOt3guHWeMCAwlA>
    <xmx:U08GZ7OuauPVcTZGQfNbZW5NOJEzb9RQmoM1nz_e29cDHQElVFAsmQ>
    <xmx:U08GZ-JAElVmC8H9qR5I2__C1Px3zP_y1iNAMRXQ_cjjDbPONkF4MiAW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 05:39:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4941496b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 09:38:25 +0000 (UTC)
Date: Wed, 9 Oct 2024 11:39:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Gabriel =?utf-8?B?TsO8dHpp?= <gnuetzi@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
Message-ID: <ZwZPSA-J1RFQKYrw@pks.im>
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
 <ZwOVy4FltrEjxHn_@pks.im>
 <867f42bea10de470532d2f30eacceafa2b03d8de.camel@gmail.com>
 <ZwO-j0C59vuYsEnt@pks.im>
 <a8807b44026458097267932f429ef61d5b77aa4c.camel@gmail.com>
 <ZwPEwL-fKHBkUOcm@pks.im>
 <xmqqiku38w51.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqiku38w51.fsf@gitster.g>

On Mon, Oct 07, 2024 at 02:02:02PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > `$GIT_DIR` _is_ defined during hook
> > execution. So in theory, if git-rev-parse(1) behaved exactly as
> > documented, it shouldn't even care whether or not it is executing in a
> > repository.
> 
> I've always considered "git rev-parse --git-dir" and friends were to
> verify the validity of the repository before returning "Your GIT_DIR
> is here".  Otherwise there is no easy way to ask "I have this directory.
> Is it a valid repository you can work with?".
> 
> So, I am not sure I agree with the above.

Well, I'm not sure either. I was merely pointing out that the documented
behaviour is different than the actual behaviour. Which of both is the
more sensible one is a different question.

> For what is worth, I am skeptical to the "solution" that tentively
> creates a bogus HEAD file while the repository is being initialized.
> The code today may ignore certain bogosity in such a HEAD (like the
> ".invalid" magic used during "git clone"), but there is no guarantee
> that a random third-party add-on a hook script may invoke do the
> same as we do, and more importantly, what a repository with its
> initialization complete look like may change over time and it may
> not be enough to have HEAD pointing at "refs/heads/.invalid" to fool
> our bootstrap process.  If we were to go that route, I would rather
> see us pick a pointee that is *not* bogus at the mechanical level
> (i.e., "git symbolic-ref HEAD refs/heads/.invalid" would fail) but
> is clearly a placeholder value to humans, soon to be updated.
> 
> Let's say if we were to create a repository with the name of initial
> branch as 'main', we could create HEAD that points at refs/heads/main
> bypassing any hook intervention, then call the hook to see if it
> approves the name.  We'd need to make sure that we fail the
> repository creation when the hook declines, as it is refusing to set
> a HEAD, one critical element in the repository that has to exist,
> and probably remove the directory if we are not reinitializing.
> 
> Or we could use a name that is clearly bogus to humans but is still
> structurally OK, say "refs/heads/hook-failed-during-initialization",
> ask the hook if it is OK to repoint HEAD to "refs/heads/main" from
> that state, and (1) if it approves, HEAD will point at "refs/heads/main"
> and "hook-failed-during-initialization" will be seen nowhere but the
> reflog of HEAD, or (2) if it refuses, we stop, and the user will be
> left on an unborn branch with a long descriptive name that explains
> the situation.

I dunno. It all feels rather complex.

> A much simpler alternative would be to simply ignore any hooks,
> traces, or anything that want to look into the directory we are
> working to turn into a repository but haven't completed doing so,
> during repository initialization, I would think, though.

That could work, yes, but it would limit the usefulness of the hook. In
theory, you can create a full log of all changes in the repository from
its inception. If we didn't log the first item, that log would be
incomplete.

We have another solution that is even simpler: just do nothing. I do not
think that the behaviour we exhibit is wrong. Unwieldy? Maybe. But it is
merely stating facts: we are executing a transaction in a repository
that is not yet fully set up. If you don't want that, either don't set
up a global reference-transaction hook, or alternatively handle that
edge case in your script.

Patrick
