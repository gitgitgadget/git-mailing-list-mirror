Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A76256C8B
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591315; cv=none; b=T/uKH1lmO6ACgYagIVVT154iA5TBiRUDpznGlR82SHiIFujLv7YC9BGuBbcnlktjckpQOxelEUKtEBNd9BAg4xVKp/7h9Ncj71mxxHFE12pf29Z2+5m0pVn1YO5rVE+1BpKanf3MpuKVU8mAz+XITWv9IFy72dnGUS21NUYTce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591315; c=relaxed/simple;
	bh=qKVjmMpL2OQAalWNrJjq3cQ52g3AhI7M/nMMDKqXwAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+vIJIIGlMPjb92Vm8dWDTtpsxdAWuqjpa6O4CVbXdNFGy1bBXl69edWoT0wD3hvuVlaPz3Ixag7s9BW5eS0nJYFM4EPjB/IShs6lTOhvfrKN9BeFSGOFZmSQl1wah0lWe3wtdlR0VfKnnmTUJ6uOWKaqd6Uyqi7itH4uDOsUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jwFGICzt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mwRZ8cdk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jwFGICzt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mwRZ8cdk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABA277A01C3;
	Tue, 19 Aug 2025 04:15:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 19 Aug 2025 04:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755591312; x=1755677712; bh=MtocFSEudy
	GC8CYpybqhg4JUKVupDPJB7PlA+rnAUZ0=; b=jwFGICzt0bHiozpS03gF/ZonCU
	q+FCSv3RGcKzdqyapeFuemTiklIKt/RevFwyQXdWcriY8iclXmt78D3AzgNXI4vB
	6WdeUyNdPSbCjJ4hgkrFAicxbe2yBU5SHbN3fUQlf2lO0mVeg/DXHLY7p1UOx5hd
	prKVZ4XNmIpg/ra6mPgnvpKk959tIYQpT7MtpDuuvD58vcYeqUuqBTOjGS6dS5Fl
	QDLleTpTaa8tTL76CIDdbF1uEuGlGpHULOY3J6ykMJeBtMjaNkMZUPsd+3Gbd2Z3
	l4iiLYxkoWPvbKNmRv5yO2SrTDM/HXUtmY2DlRyP2kyicumRykmYXw1Bb/KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755591312; x=1755677712; bh=MtocFSEudyGC8CYpybqhg4JUKVupDPJB7Pl
	A+rnAUZ0=; b=mwRZ8cdkdDKWfPybIC2+/uPFRHUh+ZjcUvOYTwoyrugqQKE2Ifh
	4EWrB7Ob+6YSff1/PMYDg2GrC3q65xnIWNZRfZDDiaBLQGeE5ciGgubodO77vUDy
	wv9NfiW6WCzceI7SSBCJMFeNOW0ygmeMXNtwNzEktzHMzGFtzGX9cGrhNpMGZcJe
	Ed4X3oYi1z/A1bwdrqVUIwWl/MD+CaDf3aMIl393Glkucr/9mIvH3jekT8jV7cqU
	UX9W8Hx6xWIQiwpQE3W8yCNxsiOrXNzUWMYmJJIpG1kmrzKRMe1576wbT36RjbJA
	usCT0NjlMXeUWrfC9tgMfbB6uFbIUR1PAeQ==
X-ME-Sender: <xms:kDKkaAs5uVKEyU5G7Bglm1tj-9UWGguZ-fyenCCgxSIE6aY90JYoHQ>
    <xme:kDKkaAs0v_ZwQXgprU6VdsQgsdyMnRWA2T1Drr4_3a2_2Y8_3PtIPB0BU_-Y4M8_O
    8Zg9d-JhV9b0b7ggg>
X-ME-Received: <xmr:kDKkaFOOGUXIPfeGm-o_STEEQZU0W6wwY7Ltler9yJJAiQF8dQB9NHOWzJEYh12tUM4WwLimLL7AcZJOJk5Bc6krgRrh-Wrh7rIonUfpkMxC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghrlhhssh
    honhdrrhhitghhrghrugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kDKkaO2mpfoUUAdwhCQo9aHJX1c2Gv9aRexfr468A-TyEahSVKc-FA>
    <xmx:kDKkaBOCjv-x8SCX4TCu1xovP8EGhUmhiDcUNJ_0NDoZ-2XWHcvfHg>
    <xmx:kDKkaO194anb0eQ20VSPufSIjGl6NkURgIND34UA-KRs4QJHsDlx8w>
    <xmx:kDKkaIFM0Ot6H-Fcf2FlQRQT9mlWaO0YC9GMQhx4cY0MOC-rzOuKWg>
    <xmx:kDKkaFUEDkpwocL5CeTfk7YZangepv9RJYvEqN7_nMwfPFoD5EMLr4q8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 04:15:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0acbfaf2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 19 Aug 2025 08:15:10 +0000 (UTC)
Date: Tue, 19 Aug 2025 10:15:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Richard Carlsson <carlsson.richard@gmail.com>, git@vger.kernel.org
Subject: Re: git may delete current branch on case insensitive file system
 (Mac)
Message-ID: <aKQyi7uO-6Ikyviw@pks.im>
References: <CANKG3zmtFmFfUDtARuOyAgv8Le+Rotwmdv-sWWnQ2Ca+7d0DRw@mail.gmail.com>
 <xmqqfrdstwwb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrdstwwb.fsf@gitster.g>

On Fri, Aug 15, 2025 at 08:41:40AM -0700, Junio C Hamano wrote:
> Richard Carlsson <carlsson.richard@gmail.com> writes:
> 
> > This was a fun one. I accidentally upcased the first letter of a
> > branch beginning with "d" instead of
> > upcasing the -d option as I had intended, with a surprising result
> > (Mac OS). Easily reproduced:
> >
> > % git checkout -b dummy
> > Switched to a new branch 'dummy'
> > % git branch -d dummy
> > error: cannot delete branch 'dummy' used by worktree at '/Users/riccar/...'
> > % git branch -D dummy
> > error: cannot delete branch 'dummy' used by worktree at '/Users/riccar/...'
> > % git branch -d Dummy
> > Deleted branch Dummy (was c32dfb2).
> > % git log
> > fatal: your current branch 'dummy' does not have any commits yet
> >
> > On Linux, you instead get
> >
> > % git branch -d Dummy
> > error: branch 'Dummy' not found
> 
> Perhaps you want to opt into the reftable backend before everybody
> else does?  Because it does not store each reference (branches, tags
> and their friends) as a file on the filesystem, it would sidestep
> the above issue case-challenged filesystems has.

Yup. The above issue is indeed one more limitation of the "files"
backend and isn't really something we can fix. But the reftable backend
should indeed solve the issue.

You can create repositories with that backend by using `git init
--ref-format=reftable`, and you can migrate an existing repository to
the reftable backend by saying `git refs migrate --ref-format=reftable`.

But note: you do need to have a recent version of Git (at least 2.45,
but most recent is recommended). And other tools that use for example
libgit2 may not be able to access the repository. There is a fully
working backend for libgit2, but it still needs to get merged.

Patrick
