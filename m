Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19189BA34
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758605542; cv=none; b=oiATWk6HCA3lDcqOyXC6m9mYI9XT8wt12MG6N359diFjsZXnQmK8DPnSeTvZnQC6W88KJKMWgRL5ue3tJd2w7bPdFN/SA1vrPzjFNuZzyIsVEZdnNvMoHxDAfAjlOU89FM7VIbXJ3zOBzGezyoY2J1crE59KCS8WzBPHkodDWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758605542; c=relaxed/simple;
	bh=itLq1PA1DK+UtSJXBOKH5AFE591j1CJEPT5DhK33Pko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHGzjwHjtmKU2s6uuvqjgiw/hHi8aiL/OIjO4U3cP2eQzso2ZMmDAIAwUfRMJy6vUCfpYFCpHH0a9TfMSnnI5ODcwE3MM+7uT/jFHi1byVMJ/zJYIsYKwyHUm8Qp9iIquNB7SjkN9aWNp8VGagpQWMvETrX4w1x7rWzzjciF4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cD5CuPqI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F3zqpJhu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cD5CuPqI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F3zqpJhu"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 506521400089;
	Tue, 23 Sep 2025 01:32:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 01:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758605539; x=1758691939; bh=5h2m0sWBPm
	A+wTn2y4WnooeHvvF+S5M0ZB50daxWEQQ=; b=cD5CuPqIWZfvCur+ot0W+7O1CD
	QypMZV59lCBcDQMFSd1M7AfhjJUWfDaWv465W+NBQAJIrX5+6PjgEU4k/vG1j1yN
	H+p5x2OOkdfrXHIDaD1RXRcCwEw7LfpgpH+g/+J2QTxJ5GK3rRze1mmVHt7IwdJR
	dNFGU0bruHQBGxAFwrYdNQ/kMfZhmgSrLgYfe9HK8qe5j/kkOj1kQn/jGg/IXuia
	4OS/JloedwoM4YawBUzbqj6etbA7MrZBwe7HTFz6EsQ+fXhHj9Un9kycNqbhDbs4
	Wie3soMza3J8gpcVXF3u9MkNWA5y25U9sNYvopzLfMiKfjEh3eQiUNkshX/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758605539; x=1758691939; bh=5h2m0sWBPmA+wTn2y4WnooeHvvF+S5M0ZB5
	0daxWEQQ=; b=F3zqpJhuS8moLkkGMlCw9V2h84ULHscaFC1aF6h9daGIacvOpIG
	zxbfXvxRBa3XbnHXQFk2prFpwxIIlKSSQk9FuxS/RfEP+Q7Gpsf+4fY8gWexZD73
	On2dF4oSM4rMi5I1p2OEBTIwLObE1k9V55tXsqdRYn1fg4mMyEDmpPqIHenDP3fW
	W3UTWZBUWrBZcw+VksESyibl1xXVYd/uEdKCoG+QILgzBHAYRIBbOFUpaEcKJhxH
	80k1K4Mcw+UQACqY8S6g/ZDprmPkRtL81d6egLphOxLwiGWVqoJCQ1zEonf09mQE
	1WPXVoN0OQAu86A90cLXU8JvJetpLKF9eXA==
X-ME-Sender: <xms:4jDSaM1nSn0eXkoKNeXqN4vrz5VmdyHXueOeg_0M_16vpjYFsXvHSg>
    <xme:4jDSaDfgzOkVnqnvSUW5W-5H7LPpoJiR08gwt0XlMIKkL0kEVcKAu_pKybRH347MM
    mc6Cv9XmS8Rhqwfw1mzxQVgr9XX6msXgK6P59G54Q5wUnlisUh6NA>
X-ME-Received: <xmr:4jDSaJVyHEUMVYmOHGn7gi1CreGqUbMdTvodmkbqqU6FZb93cyV24RVOS89gC_zeFP--XifTh7qjOVY4N6tCHzZlpGFCqFbdtk0eGOPkfqSR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehleeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegvsh
    gthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegtohhllhhi
    nhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrd
    horhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:4jDSaD-8n1oxotMpqJuD_vlfrbaQe8MP0Iv6WD9YPq_RDQItEu2Hzg>
    <xmx:4jDSaLhg_vE5dGcnWDej01aeGZgIumJG0m4fysNDz4x6gukOt0IzAQ>
    <xmx:4jDSaHeiO2l8A2Lvuo9mnvJ0-pMZzUc8JualZjgtRnUfGlKVQvfq8Q>
    <xmx:4jDSaMIbOu48HAqdGLGCmHUkx594TB9Whw9U9kJC3HfQL0h43o1HXQ>
    <xmx:4zDSaEGejIlPmwzghtJC-W9LiXkuwd_EWprZJwCo4JwP4PPAo27Csqfv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 01:32:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d689ea0c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 05:32:14 +0000 (UTC)
Date: Tue, 23 Sep 2025 07:32:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 7/9] BreakingChanges: announce Rust becoming
 mandatory
Message-ID: <aNIw23JzQE1vz2JD@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
 <20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
 <xmqqldmmqa1z.fsf@gitster.g>
 <aMfwGHL7dh8dk2cQ@pks.im>
 <xmqqsegev4jp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsegev4jp.fsf@gitster.g>

On Mon, Sep 22, 2025 at 09:24:26AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> I am having a hard time imagining the practicality of this "hand
> >> over but we still review" arrangement.  Some of the security fixes
> >> are embargoed, and the reason why we are jetissoning the stale
> >> codebase is presumably because nobody is willing to work on it other
> >> than the "community support" folks.  I can imagine that we would
> >> qualify them into the git-security cabal and let them use the forum
> >> to coordinate among themselves, but then to what degree in the
> >> "community support themselves" process is our involvement expected?
> >> As long as we can make sure that they do not leak before the
> >> official embargoed release, they do not need an official stamp of
> >> approval from the project or by the Git maintainer---that is what it
> >> means to "hand over maintainer ship", at least to me.
> >> 
> >> In other words, I like what I see in this paragraph, but I do not
> >> think we can practically live with the part of the sentence after
> >> the last ", but".
> >
> > I think the most important part here is that this community-supported
> > LTS release should still live in the canonical repositories. We should
> > avoid the situation where we hand over maintainership to such a degree
> > that the end result (the tagged LTS release) lives somewhere else.
> 
> Why is it a bad thing?  The official repository can have a README.md
> with a single entry "maintenance releases for Git 2.98 LTS (most
> notably with no Rust requirements) are found at this separate site".

There's a couple reasons:

  - The LTS maintainer may not be as familiar with the Git codebase as
    we are, so they would benefit from the usual processes on the
    mailing list.

  - The LTS maintainer may not be as trusted as other regulars on the
    mailing list are, so we (from my POV) may want to avoid having a
    basically unobserved fork elsewhere.

  - The end result would still be "git", and users will come to us to
    complain about issues in the LTS release.

  - Initial releases of the LTS release branch that are managed by us
    would sit in our repo, whereas subsequent releases would sit in the
    LTS release. This will likely cause confusion.

  - We reduce chances of a hard fork of Git.

So with these in mind I think it would be sensible to keep the LTS
release as part of the canonical repository.

> > Otherwise we risk chaos and a plethora of different LTS releases, which
> > would be harmful both for us and those that rely on the LTS releases.
> 
> No risk for that as long as we have a single "go there" pointer, right?

It somewhat reduces the risk, true. I still worry a bit about
encouraging a hard fork.

> > And yes, that probably means that a trusted LTS maintainer should be on
> > git-security@ so that they are aware of upcoming security releases.
> 
> Absolutely.
> 
> And there should be a community of those who are working on helping
> the backporting effort around that LTS maintainer that ensures there
> is no "chaos and a plethora of different LTS releases".

Fair.

> We might occasionally update what is listed in "git ls-remote --tags"
> from our repository by syncing with them only for convenience, but
> the important point is that the community supported LTS should have
> its own official site, which is different from the cutting/bleeding
> edge.  Most importantly, a coordinated disclosure would say that the
> update to versions of
> 
>  - Git 3.0 to Git 3.4 are found $HERE, 
>  - Git for Windows 3.0, 3.2, and 3.4 are found $THERE
>  - Git 2.98 are found $COMMUNITY_LTS
> 
> to make sure that people know where to find their updates.
> 
> So, no, I do not think we should unnecessarily mix community LTS and
> the main project.

How about the following tradeoff: the community LTS is developed outside
of the usual Git workflow, for example on a forge, so that the LTS
maintainers can work in their preferred flow. But eventually, once they
want to do a release they send a pull request to the Git mailing list
and then the tag lives in the canonical Git repository.

It gives the LTS maintainers flexibility, but still makes the canonical
repository the single source of truth for Git releases. Furthermore,
we'd have a way to double check the results before creating the tags.

Patrick
