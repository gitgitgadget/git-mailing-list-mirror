Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC430EF9F
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596057; cv=none; b=lLGuQPXyKl4fn/VD1QZloK1xOJIfkdod6AZiAPa9s9QmM5WpTCh9Paxk5yOICkntrvW76rUN0KW6NC20xmpgjboLdpp+sZQRrbqizb+9+OZKs1Z96Yx/y8wByRBcePp/0I0fbbe7KftvTjRvrJ49fzuNG8Sl7NtFxQLr5mbPRZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596057; c=relaxed/simple;
	bh=EYWCZLIqsu+J2sLEWQZ7TOXSQwthcvZ+9Cw5rdTA+eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQLa04Mp+GEIAb7T4R+qGuCuk9VDbyA/nQGJ2AH4skxJOWb3c6jYpp33lilgUW4NCkmuK3I/AyZ4jgWuIppTIsOeujDwquEfZjZ3ngUbc02cNLp634UTGVgraZ9pe8fiheC5IbSbXFmREnWU1EI1AG3/2y5EGx6w2G+G69vzJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NlVjYBtL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0WW8P3R; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NlVjYBtL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0WW8P3R"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A880CEC05C9;
	Mon,  1 Dec 2025 08:34:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Dec 2025 08:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764596054; x=1764682454; bh=2g0mZQwpxc
	QImQ4FZB1Pcy69U5m7x/70wisDLfajq+w=; b=NlVjYBtL6LxbLJ8ZRLpnAYjBql
	qCxCI1NsAS7VuGhiR68Irs0YN7WqoswNcCp/XEX1unU7jSNnuYQarvHGinyBZOfj
	dRBe4LIvLv6k58jYWhXDZVAI1BUWRrXaZJtzzF/KPIApMo9e12zRQb3fh4eeCI1l
	T+uJpdcFFMcFWWACp4vKPBsXtk7E0I4CmxMJJUlRE/7B2tOvYYtZ9eJBhx0lrpuo
	kgodEaWMIhvZ25p8TBhpDSccJZl/TAwzBlbYDiibdBiclBKq0ZvdG/W4LoOXx/rI
	CsZOxezUFR+ZOiEmtFT72lShQTT0gQK9iacMqjNKROhQFzyU8g3sITtiUYRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764596054; x=1764682454; bh=2g0mZQwpxcQImQ4FZB1Pcy69U5m7x/70wis
	DLfajq+w=; b=b0WW8P3RKeko9n0pEy3XuiqJ5TCHJK+ButLxnjmpKb5RChzIJNi
	LsrhfH4H+ZfU2NI2IE+I20xNjmzYl+NniYCQJ3B9LJMYZkYud8fF2c59TqwQ1T/w
	06yO3YRda/scabRtpjJqHJi44IlPNI7/EXe06WA1umWzf3pE4B1ObmfC5IbIiU+O
	fnuf9GvJYVLSS/2rGIni711TGX6vVjzCB1aSBTeUZbtdr79sDFDMzf7d0hpVhaJG
	FtDt2NjGVW7jhJxOEpeK76RIdtf9Yo8JSwASXb13ol2mkLxBy7IRPDx4humKXZET
	fw2ClrMKfsEgi0fGmr0sXPi7XdhJ/s1d1aA==
X-ME-Sender: <xms:VpktaUFhmfknC2_IavZEqLVziGY-Dqg_yN1SCu6QRvrwtsIUokQMsg>
    <xme:VpktaUzGbMuEYCWd94tvhJnsZ4OSyLVhBvE-PqvyOVgPtNUdJVtqdMhvCK1fz28Hm
    crqpk25HsnRqXsQeilSrmQwi89ranm97-oGzbZ5D3kNtcBUYExwaA>
X-ME-Received: <xmr:Vpktabi-BkLk_N0r1q6BZcT7hTPSoi2CPd03DfVQZB010_bbvdlP7KdINEsxwCdviWRL3XGKANnSc8fRV2BrVDBnMOgz8WLeVqkA6NvT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgt
    hhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:VpktafwHo3Z7AdO4gITlv1Krt5CuEawq2_-db6B78DuDd3p6Ai99XA>
    <xmx:VpktaeJJSEsb55eJZqEBMQzCyqUBpdLaqmktzKhQ1VWIMzuT7XwERA>
    <xmx:VpktaWQCEiOsgjh8XOzAFg7c-f3VfuARfUK9eIPEPH0v21OQXICM1A>
    <xmx:VpktaWrm03bbENwbPpr-Lza3myv8ILBVVmgWu8Et3-lNDUeT2sbDZw>
    <xmx:VpktaSTigYf2VK7w1DDuoxLgVFuHML6tfU4lVq2jRyK_tvJWJVTvcmB1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 08:34:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3bad858 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 13:34:12 +0000 (UTC)
Date: Mon, 1 Dec 2025 14:34:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 07/10] t1006: accommodate for symlink support in MSYS2
Message-ID: <aS2ZUVfTf9XWCfI4@pks.im>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
 <8a7c68b629f64a3fd8c08f54b5e8693f6568885c.1764440906.git.gitgitgadget@gmail.com>
 <aS1kI0AR8TLVkm07@pks.im>
 <fff2c7d2-acfd-7052-5e7a-e617bdd1d2e6@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff2c7d2-acfd-7052-5e7a-e617bdd1d2e6@gmx.de>

On Mon, Dec 01, 2025 at 02:29:45PM +0100, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Mon, 1 Dec 2025, Patrick Steinhardt wrote:
> 
> > On Sat, Nov 29, 2025 at 06:28:23PM +0000, Johannes Schindelin via GitGitGadget wrote:
> > 
> > >  test_expect_success 'git cat-file --batch-check --follow-symlinks works for symlinks with internal ..' '
> > > -	echo HEAD: | git cat-file --batch-check >expect &&
> > > -	echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >actual &&
> > > -	test_cmp expect actual &&
> > > -	echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks >actual &&
> > > -	test_cmp expect actual &&
> > > +	if test_have_prereq !MINGW
> > > +	then
> > > +		# The `up-down` and `up-down-trailing` symlinks are normalized
> > > +		# in MSYS in `winsymlinks` mode and are therefore in a
> > > +		# different shape than Git expects them.
> > > +		echo HEAD: | git cat-file --batch-check >expect &&
> > > +		echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >actual &&
> > > +		test_cmp expect actual &&
> > > +		echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks >actual &&
> > > +		test_cmp expect actual
> > > +	fi &&
> > >  	echo HEAD:up-down-file | git cat-file --batch-check --follow-symlinks >actual &&
> > >  	test_cmp found actual &&
> > >  	echo symlink 7 >expect &&
> > 
> > I'm not quite sure I follow, so my questions may be dumb. Does this mean
> > that git-cat-file(1) fails to follow the symlink in this case, and
> > consequently we cannot execute it at all? If so, is this a bug that
> > we'll eventually have to fix?
> 
> No, it means that the symbolic links are not even created in the way Git's
> test suite thinks they are (or should be) created. The way those symbolic
> link targets exist on disk (i.e. the way Cygwin's
> `winsymlinks:nativestrict` mode constructs them), the expectations of this
> test cannot be met, no matter what `cat-file` does.

Ah, makes sense. Thanks for clarifying!

Patrick
