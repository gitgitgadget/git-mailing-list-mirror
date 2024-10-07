Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A913A8F0
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280036; cv=none; b=eX3saPRsmJyh2gxhPJxKodvsQyyc306uycqexgJfuDE1BeK7bPyUCG2ilg9phy98yZN5UREHINtpl8y/I5WLxQ6K1KP3U8FT3M21gCk+/QMLFfSasGi8vg4BIjG0o2YAt9xc60aSwd0Xljv2q6BKG2DgutiZq0J1c92fiWsR5Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280036; c=relaxed/simple;
	bh=AK8QV50PJUjkUuk1zvxElKjEOx5T8lrs0lTOf+zGDAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcM9UgcnPYJh7xYe4ZSTY7pDysG1oXHpA0cKGNkn9H2k289ikJ5LO1Cs2yIGt5fAjnva7CapRIWfkbre42J8vKcBpR+jIdQ5qVdzikc7BmSyl+hBmnXqd4BaYN8ICkAGVI9+fACo/4YbALe8TcwF+Ml51u2xpEQFlkHoDoTqle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K5uFUnLT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cv+vWeSM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K5uFUnLT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cv+vWeSM"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E98F911400A3;
	Mon,  7 Oct 2024 01:47:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Oct 2024 01:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728280033; x=1728366433; bh=bcXuwkdnCc
	j4eUIpd6Bi8zeGQeO4Kr/k5Q99UGAGiwk=; b=K5uFUnLTLqOqbToYnZfhgHhG8b
	7iBrWPeyzsugHkEch04hxyCSqN7LnQ3eo1iFxLdjpqu/+6R+D6DFlENsWp13I/Jl
	SIYGk9SN+SZUz7NNoXrni4qSYVovGdUg4LLwim36NFCpuO8bFAO8EKq6+5+fIg4C
	cIDIEpNch8KxdSIbhZYMIrQI2Muxz987hNMH0eNkcRdliMHhlBg0QwvYS038M/fj
	Xm5ftmMrtHNcKL8EB9xpMrN9FX3PCPKk0hoVxortQfAwXH5kDqkpjsrXhjFAZtsz
	fTe/qrcncua95zgqp12WdnGaEZ5vXj+RNz2W0gcGHdm9ozHYUxDqd7nR8PqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728280033; x=1728366433; bh=bcXuwkdnCcj4eUIpd6Bi8zeGQeO4
	Kr/k5Q99UGAGiwk=; b=cv+vWeSMioMhwN1CR9e/rjlbAxHQptS6yq0XjGU61S/e
	FJ4i9IY+j5ELX1HhDCWR6fd1DOxxvgyyyaVDwL/i0ubacAYq+tOWgL2nXptm9+L6
	LcbxM9B1m4mUmiuhJ/kFDtTugwC5VBtCsq0VFmpxVy3xlUtliw0rgzTbwuOgZIC9
	iRzAnDabdms/8Hbsk/WQgoqxZxQostWtVfzICQUnWVpzBZyo6bL4K3G405sDKmrR
	r3GEfGzC6ZrUEAYDzYa2TP9lE9zMZo/s02Vb/ccUrBQ6g0NHgfr6n4D2pdytMiy3
	Jt+D3UV/7HlMxpI6Z9HFrkwO+S81nwFw7mu4TEtZYg==
X-ME-Sender: <xms:4XUDZ7PSp4M6D-vFOSKk76uvR46gIYNBrEKxDw2Hv-2s6POXumTwBg>
    <xme:4XUDZ1-ku5Sf31_vGowDN_CIAI_DIb72mjvXKtMF42ZM190wzPqTpYqh2qMERVOa-
    il-bWoLU09bO5n7Hg>
X-ME-Received: <xmr:4XUDZ6SuhsqJ4F09-4rlxP10EYi8f-gzIdv_5iKpcmUCGTAEHT909FpLPkTLqYrkVvJ_tKEY9j0XCA9owL_RJJSXbouVqYZjoX5L5mPMEQdmiG3NMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjeevudeggf
    ffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:4XUDZ_sfU7g2wBTIi_IjxgT2cAxv7OjjLKcPmrJolgSrixulCVoIDg>
    <xmx:4XUDZzfkx4u5PRZwGjEkJvaGP2vkrXhOBIjYcK3nTZGcpJ0UATklZw>
    <xmx:4XUDZ70xwLB-CKbiJzg83q7pv-RFA8L3zg9reIdv6kclbbql1jI6TA>
    <xmx:4XUDZ_-MXiGxw81sDcK5PFZc7iV60LEcNg4L6nNTlRsJJm-q-9fPnQ>
    <xmx:4XUDZ64cjx3DZ_4LcZTh9jjErq3Th3fc1OGYtq0qvpEAMMr2aNnG-zt_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 01:47:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aba4f7f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 05:46:11 +0000 (UTC)
Date: Mon, 7 Oct 2024 07:47:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
Message-ID: <ZwN10b28Aaj3roz2@pks.im>
References: <xmqqh69thzd0.fsf@gitster.g>
 <Zv7aLRXwt9cfqW58@nand.local>
 <ZwAIM6GO3VtoG3ZM@pks.im>
 <ZwAYccsboGIhGVIx@ArchLinux>
 <xmqqmsjjereb.fsf@gitster.g>
 <ZwBtwFeVYmu6/Sc0@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwBtwFeVYmu6/Sc0@nand.local>

On Fri, Oct 04, 2024 at 06:35:44PM -0400, Taylor Blau wrote:
> On Fri, Oct 04, 2024 at 09:58:52AM -0700, Junio C Hamano wrote:
> > shejialuo <shejialuo@gmail.com> writes:
> >
> > > On Fri, Oct 04, 2024 at 05:22:27PM +0200, Patrick Steinhardt wrote:
> > >
> > > [snip]
> > >
> > >> There are two maintainership models I can think of: either a single
> > >> individual or a group of people would take over.
> > >>
> > >>   - A single individual needs funding. The ideal situation would be if
> > >>     that funding came independent of any of the large forges. Or
> > >>     alternatively, the big players in this context come together to all
> > >>     pay into the same pot to fund that person. In theory, the role could
> > >>     be elected and serve for a limited amount of time so that overall,
> > >>     the community is in control.
> > >
> > > Well, I think we cannot easily fund a single individual. It it is a
> > > full-time job, we have to also pay for the insurances. I don't know
> > > how to hire an individual in an open source project. But intuitively I
> > > think there would be a lot of trouble here due to the laws.
> 
> It is definitely true that the Git project alone could not fund a full
> year of the maintainer's salary [1].

Yes. As Junio said, ...

> > I think the model Patrick has in mind for the above is like how
> > Linux Foundation hires Linus Torvalds to work full time on Linux,
> > while the Foundation is funded by large industry players.

... something like this is what I have in mind here.

> > Git has become important enough that such a model may be workable,
> > and that may make it easier to maintain appearance of impartiality
> > by whoever is being funded.

Indeed. There's at least two large companies that care very deeply about
Git being healthy in the long term. So securing funding from those
companies should be a no-brainer for them.

> Sure, though I would add that my personal feeling is that it is a
> possibility, not a requirement, that the maintainer's funding come from
> either an independent entity (like the Linux Foundation) or from a pool
> funded by industry leaders.
> 
> I say that only to point out that while Junio is employed by Google, I
> don't think any of us would doubt his impartiality with regard to the
> project.

Oh, yes, and I've explicitly mentioned that Junio is doing an awesome
job of that indeed. But I see the employment by Google as kind of an
outlier here, because Google itself is not really competing in the Git
ecosystem. They do not sell a Git-based product directly to customers as
both GitHub and GitLab do, to the best of my knowledge.

> I think as long as the maintainer's employer does not unfairly influence
> the maintainer's decisions on their behalf, then it is OK.

So yes, I would probably be okay with a maintainer that is employed by a
company which I don't see as competing in this space. But I would
strongly disagree with this statement if the intent were to ever have a
GitHub or GitLab employee become the single maintainer.

Impartiality is only one part of the picture here. The other part is
that Git would start to feel like a project owned by that company. There
simply is too much political tension for this to work out in the long
term, in my opinion.

So if we do not have an individual at the ready that is independent,
then I would strongly favor a model where the maintainer role is shared
across a group of people.

Patrick

> Thanks,
> Taylor
> 
> [1]: https://lore.kernel.org/git/Zusxcweod1O88h7j@nand.local/
