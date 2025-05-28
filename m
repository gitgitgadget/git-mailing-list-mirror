Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B328C2B6
	for <git@vger.kernel.org>; Wed, 28 May 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447728; cv=none; b=b8YrYhKCz6n0u11+VfprypjjVHzu4me0nDt3Yp++nlXeH6veu1ACVGLFCqqFMzTkzcFrFZyPGW11wR28zhmOkEaZfAwDMagX/HiIdeGrgyhaSPUJswD/zndlz/5Fpf2pPgUsVKsBQeIJatGr3VCQWGBpP/XvwLCIglflqUPHD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447728; c=relaxed/simple;
	bh=8pBmuZXGkVm0wHFmIyn3RyVW64pWseotE6bvzdhFvYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4M9obeuW/JJywX908d/ZeeUoWz21iFdJDNze9SUzyV5eFKKKEsHuNCWVArNjlG3V0nzelk8rHUzRQup8h6zxSI7ZppcZyMXckwIRI8p+lhyXwgqLShSRg7SOYAbsNKO1+VbSjZ2mT0kY/HEvBj3Dz5UcQiDQhAENzyBVTKdKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X9cQVsRq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rCcZOUZe; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X9cQVsRq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rCcZOUZe"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E90401380B2C;
	Wed, 28 May 2025 11:55:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 28 May 2025 11:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748447724; x=1748534124; bh=sk7ZoVdQNU
	WLpee4eKQsHIdLBa/XGiSHDY9SHrCe/8E=; b=X9cQVsRq1n19MsYUfqVv2DU4JT
	JO517oKnwSYay1Zay26JhPL0AkZ5wnuRlk/ozb9R4XjyS024qWx33kVnDOXhljAh
	bIIjwPyaVAq1mohlHDF+DiOwkOsADp0AqwY0YnYRM2AYP9XspzPjNd6ecDOjHd1f
	lalC0MVWRoYeH0/gfs+IUQ0tsNfZ4MgDnViw4PW3KnvgCUx/eRuitk57ABNDEc0c
	8OKzHsBJLgVNFfhtesozO/u+ZEGu+i0TPX5P1W1Z+Qwylhz2Esq8jWp/7ooBDLWv
	ELX3o2D6AVikdgqVXFmdA/hGyWk7FQHJS3nY0biBzuxzf0E/uJk2yiGIIArQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748447724; x=1748534124; bh=sk7ZoVdQNUWLpee4eKQsHIdLBa/XGiSHDY9
	SHrCe/8E=; b=rCcZOUZehggSAtF+hTMPjHnSnbV5tIAS5KDImpIABlh0aeOdX+f
	Njvv3OjelE2C5uZPBSnFwQyt41Lku37mTkzRaw8PNkjk1C7869tEUjwZdCrXExw5
	7c/nfD3GscuvU62dbdW8HxwsMr+443ae5BmVFnLtvgojWZKNKY+QQRiiZKZVwM93
	Svxgdcm+kQSDtNYRij74W/l+jion7kYp34UvlzPRp5+mqsMDFmGzV4gqS7IxEApu
	cOs+a3fDd8c10iBtFi0tLRKSaxEgGdoL8GKnB0sdQnp/s4p8fe3vZBN7VmkWix3w
	wXU5JGXVEV0lUqAfrlydnIf7Gj8gck8RvoA==
X-ME-Sender: <xms:7DE3aGf8TOxi-ppVP_es81Yfqqez_yAFChbQ6bOO1MXSgd-eB9_lGQ>
    <xme:7DE3aAMedhBNn6-3VPnm7q80OvdBEEidRoY56LKqlZWRKCiAFgi3agnuP6wGhB9OM
    yp8iz6F8O0ZHVzEeg>
X-ME-Received: <xmr:7DE3aHjRZV1MIc9RxN2IFzzaK9XJJbQUUY11zepWcFY-P2d6Cu0nCqMAdsqbBQWHNE5QTrti9fqTbmIzOMwx92AOdktILUrYnuQTGqEjR64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfeeijeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrth
    iisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvsh
    drphhluhhsrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:7DE3aD9sD67c6Ogobsr6xuJwyjEQOJEZiQ6QkJfCOiLxGQLswf5rbg>
    <xmx:7DE3aCt1KaDBvzggVnXdWm7BN00YkKc9SCze_f-gEpkmca0zgfTTZQ>
    <xmx:7DE3aKEhdj8beGdEEw2FJ0w3jolTNnnfsNIo2qF3t6lnRUf6p5Qvvw>
    <xmx:7DE3aBOJjDhBMPtwUk7ax9keo2y9lrdnBlCMDgAUAL9WcNPG-G91nA>
    <xmx:7DE3aHiFD9aZF7ZxAId40wBTxMGbg5j3l2K77t5kcW7yM3K7QM58Q-3O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 11:55:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7effe9e8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 15:55:22 +0000 (UTC)
Date: Wed, 28 May 2025 17:55:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 2/6] t/test-lib: don't print shell traces to stdout
Message-ID: <aDcx6XHJxCurAxOB@pks.im>
References: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
 <20250527-pks-meson-tap-v2-2-ae360f77786e@pks.im>
 <xmqqh615vnt7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh615vnt7.fsf@gitster.g>

On Tue, May 27, 2025 at 12:47:00PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > We have several flags like "--verbose", "--verbose-only" or "-x" that
> > cause us to generate shell traces. The generated tracing output is split
> > up in these cases so that the test's stdout is printed to file
> > descriptor 3 whereas its stderr is printed to file descriptor 4.
> > Depending on which options have been given, we then end up either:
> >
> >   - Redirecting both file descriptors to a file.
> >
> >   - Redirecting them to stdout and stderr, respectively.
> >
> >   - Closing them in case we're running in none-verbose mode.
> >
> > The second case causes problems though when passing output to a TAP
> > parser. We print the test's stdout to the console's stdout, and that
> > results in broken TAP output.
> >
> > Fix the issue by instead redirecting the test's stdout to the shell's
> > stderr. This makes it impossible to discern stdout from stderr, but
> > going by my own experience I never came across a usecase where I would
> > have needed this distinction.
> 
> OK, so both stdout and stderr go to stderr, mixing everything into a
> single stream.  Do we need to worry about funny buffering making the
> test output harder to verify?  I mean, we only have to care about
> the ordering of lines within the original standard output (or
> standard error) stream independently, but now if the test thinks it
> wrote A to its stderr, then B to its stdout, and then C to its
> stderr, would we get them in the single output stream as A followed
> by B followed by C, or can sometimes buffered output can give us A
> then C then finally B?

Good question -- I think that the answer is yes, this can indeed cause
intermingled output. The redirect to the best of my knowledge would not
impact the buffering behaviour of stdout/stderr. I'm not really sure how
to address this though.

> Just an idle thought.  What makes me more confused is that the
> updated t0000 tests seem to say that we now check standard output
> and standard error separately.

To stdout goes any output that is expected to be parsed in the TAP
format, so all the "ok 1" or "not ok 2" lines. Everything else goes to
stderr.

Patrick
