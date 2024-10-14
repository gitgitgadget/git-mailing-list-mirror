Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9B33998
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901009; cv=none; b=Eqhc0cTJMJxzI1dtdyK4muv2rsW99ZchMLS2xs680A5bmoCRkRp7Qw9N//GlWp+AEi5c8nNmI+s6DaiIOh+zek9X0zICaRmQ16LW1HBBc88ODrBHfnbQMgI97i2d7krRhqgkMl9yRFkkzM5FSqlK7MdJIIcpwvtASl6PQ4pmmhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901009; c=relaxed/simple;
	bh=Gui1UQaKr5Ld9Ekprx+2E4MnoAfmef6bD1MPomOgTR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQGFJ81TaRPsIJxE1t+BXgIjLdnrR7hn7bzMNeinNsZcejP0AlTY3xnxildco8KPqxQP+I1u0JHDWPr3H5Akpwo7in/UD8eRkR/ffrrabHeDrfPNjpn1vlobjTUWmae58zVC7eDCrqGsaLxnQSkZCVmOmeZyvnWLrvmyc+GrLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JadSvfPo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4girCHh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JadSvfPo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4girCHh"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 9165913800D0;
	Mon, 14 Oct 2024 06:16:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 14 Oct 2024 06:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728901005;
	 x=1728987405; bh=MLJA16trmPHlj9Bu0SfdGl/NlV0qOah+te1l5I4VWLo=; b=
	JadSvfPoN13R3+yQZvd10lQIuGlERuHKDtwBj9Nt6Uwjr0uNoQEUIaUveQAdjD+B
	ZX3VNioUO6M7txWtQICSk33doaq3n1V3WW2sBWlgNbMe4oGldZmj5UR6TUGi0sKh
	JSUl2JMXwF1ScasqyC5hv2DfWq3bpOv7DuLpFvaosWr/AghWGetAOzP63Vuse/Xg
	8vfLly+1ylGBCozqXfPadi286S7WQlNChC/WgT3aU91cSyffRNJKCA2JSgBESYi3
	KASf4c2ZiLUhp38eRGJdIhV+XgDkx7yUX5G0o4RbgLnbuUnnSm2BV9ERsF7gncBh
	mX5clzU5OehiCQagfF9dMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728901005; x=
	1728987405; bh=MLJA16trmPHlj9Bu0SfdGl/NlV0qOah+te1l5I4VWLo=; b=T
	4girCHhRUzf41Ajt8skrSNIc5GMdN4/eZRKyHaaKz08K63jhyUOlwQ5xlbPH2QHw
	ewl8c36CSkebu8pxPb3ZvkueEqz78ToiqD92zQ/M+jYqxUDDXvxGjlbeR64nB4h/
	2hnncqm0E74LN8lJT6wx0ZDOP6lyVxWHASUi91zm1LDSOpucev4AK5LVgaW2u01O
	sd+2mcxKVj8+i6LEr5XXat1XxFHvNhPwLdft43a3SCmHREQUxSIwoIVMe1heTf8M
	9CvRyBpiMFAR+jJAnvnCkd1D6ZGwQRTOIPbrhcRk7MYNSUjhzsJcuDJ3bUQHzjyD
	vaoeSDxzxK6pHB98EPY8w==
X-ME-Sender: <xms:je8MZ_tudXG9iZrhnv-MuRbxx0kRw4vLElFVrx_9-1-3OT_yX9qz1Q>
    <xme:je8MZwffDxJQTARllgdfBQrvGXDfIgaBDkXaFO2XScCuY0DKCPaQdJ4s4O_rULiYQ
    bdgAGPOcHH5YblACg>
X-ME-Received: <xmr:je8MZyyY9pZTqSNgxCcUM-wn28MMBI41ITdZ1zTJ6SaSnsCHl8ZDJsEPs6FCyVR_2L03XjSGtg7qDB9HhGrbLq2Dh0IeNssXnv2w73m-IoknZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvedtgeduve
    dtveeggffhteevkeffledvvddtteduhfetgfejtddvjefgteefieeunecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpshhtrggtkhhovhgvrhhflhhofidrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhg
    shgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:je8MZ-O-KYm8tsUau8gAah2MsANZC0k-39-hGUadtz7iSZ4-PpJsyg>
    <xmx:je8MZ__8zfexGfhhORVbwuQfDIvQXR3GpxC5SVZZVZtHfgNjq-J0vQ>
    <xmx:je8MZ-Vu_HFNDCnykSrdwyNKf5-bDWjV13ber0YDnNijdBLbsbynpA>
    <xmx:je8MZweH1pfEJKiWDUQQliCRzzf_9rKmECXgkFOodkamxXm5eY9psA>
    <xmx:je8MZxILVpBfek2-M9jZIXFI_Sp_4thb99--0aZ0ML0LHO7VuVPsylya>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 06:16:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4bb27fd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 10:15:29 +0000 (UTC)
Date: Mon, 14 Oct 2024 12:16:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: =?utf-8?B?V2hhdOKAmQ==?= =?utf-8?Q?s?= the intended/reasonable
 usage patterns for symrefs?
Message-ID: <Zwzvgby2_oCjQpii@pks.im>
References: <174f3704-6319-48f9-955e-b36a25836e3d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174f3704-6319-48f9-955e-b36a25836e3d@app.fastmail.com>

On Sun, Oct 13, 2024 at 09:57:23PM +0200, Kristoffer Haugsbakk wrote:
> This was posted in 2011:
> 
> “What's the definition of a valid Git symbolic reference?”
> 
> https://lore.kernel.org/git/AANLkTinsJkzYggMtNrLRv-qNxRncrXSe6A46Z=d8xkw7@mail.gmail.com/
> 
> And the answer said that:
> 
> > Emeric Fermas <emeric.fermas@gmail.com> writes:
> >
> > >  Once again, by reading at the code I can understand how those commands
> > > currently work. What I'm trying to achieve is to understand what
> > > should be their recommended usage.
> >
> > There are only two valid kinds of symrefs right now:
> >
> >  - .git/HEAD, pointing at somewhere under refs/heads/ hierarchy;
> >
> >  - .git/refs/remotes/<some remote name>/HEAD, pointing at somewhere under
> >    refs/remotes/<the same remote name>/ hierarchy.
> >
> > The code may be prepared to resolve recursive symrefs, symrefs other than
> > the above two kinds, symrefs that point at elsewhere, but all of them are
> > outside of the design scope of what the mechanism was intended to support.
> > What the code do to them (without crashing) is not the design, but simply
> > an undefined behaviour.
> >
> > This won't change very much if we decide to reorganize the remote tracking
> > hierarchies in 1.8.0.  The former won't change at all, and the latter will
> > start pointing at refs/remotes/<the same remote name>/heads hierarchy
> > instead.
> >
> > I vaguely recall tg abused the symref mechanism to point .git/HEAD at
> > funny locations; it may still be doing so, and if that is the case we
> > should extend the above list to cover that usage.
> 
> https://lore.kernel.org/git/7vsjvpq0jk.fsf@alter.siamese.dyndns.org/
> 
> This was motivated by a StackOverflow[1] question/thread.  Which should
> maybe get an update if this thread reveals some new information.
> 
> 🔗 1: https://stackoverflow.com/a/5000668/1725151
> 
> This seems overly restrictive for this day and age though? No?

There at least is no technical reason to restrict this from the ref
backend's point of view. Neither the "files" nor the "reftable" backend
enforce any restrictions except the restrictions we have in place for
any other reference: a ref is either a root ref, a pseudoref or it must
start with "refs/".

Now the only reason why I'd say that you maybe shouldn't create weird
symrefs is that tooling isn't prepared to handle them. But that is not
sufficient reason for me to say that you mustn't create them.

[snip]
> Is this okay?  And what can you reasonably do in general terms with
> symrefs?

From my point of view it is. As said, though, depending on what tooling
you run in those repos you may run into bugs if that tooling does not
expect symrefs at all. It's basically the exact same issue as you have
with symbolic links: they work mostly fine, until they don't because
something isn't prepared for them.

> Just as an example of something that is probably not fine: I’ve read
> that symrefs are dereferenced only to a depth of four.  And then you
> don’t want to create some contraption which relies on many levels of
> dereferencing.

SYMREF_MAXDEPTH is defined as 5, so yes, there is a limit to the level
of recursiveness we allow.

Patrick
