Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E272E40E
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759184626; cv=none; b=HWY4r4Z72qA8yBQOaihgMeHPM/DUBqHVswa+rlJHAE86K9vgLMA3dznb3jnEb58g9nsvSBT8k8KAD5IK/mJ5Y0rr5XNblt809oRx4M1QwZOZSIwu6xaiBE3hRoJSkQFGX+lTHBnszS+It9u2NbQAjW1Ppdb4iGDJZ1BLE/Zm7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759184626; c=relaxed/simple;
	bh=0Y//ElLXb1JwvJLZTbE4W1A3TE6eKrwugqqLibvJhZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0n2QI6u4i98r+286fhh+oKZcoKW5icqkDkiB3zKAgWJVukMSlko6WQKvXxlFU27aV8Xujqb/CZum+Oy99MXLfA80DtUoGoRG378fLfuFDhAWnQ0wUuOFmuRVgvEYQjz7iSTTcvWjj40oN3ARHWpmgVKB9p7MKsVSLsFQbRqrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z16xMPC8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fz4H1Qrm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z16xMPC8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fz4H1Qrm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CBBF9EC02A9;
	Mon, 29 Sep 2025 18:23:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 29 Sep 2025 18:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759184623; x=1759271023; bh=DS43fLzeYO
	26IRad57a8bhgzIk1w0FgsZRFY5Ej+f+Y=; b=Z16xMPC8ZHs5YzXlRHxcpkuONv
	7IoFgSrheHcFjPopx7S17c5k/Ffe54kWc3PnswjKK69bXoh0eg/h8dre4vwOVML0
	7hTKUjN6WP0VZ6WsOMUmv+v8Rm9FRlfYjmJ1iSSzCHfwnjmjR1fXyMCbYets5fcy
	cScSCUbHR097iRHuDM20GEtBWjY01I54R80HQRHgDSr4Ef1GjmiPriUAVHf1J7y0
	itD3Oagm14G5sZsPmD4FLpVIraIpHhRUXwVvrzaLTbXVNpvbh1skaNy6V6dQHyMU
	u9kzlH3AhRtWeCv/sqF3VV/4MsuT/zA8md1BWuy2j83e2WOmBbcjZ8PfA2mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759184623; x=1759271023; bh=DS43fLzeYO26IRad57a8bhgzIk1w0FgsZRF
	Y5Ej+f+Y=; b=fz4H1Qrm4ahXT/IK+MpvMUGovPIBeTvRjA3w4n0ZODwKAMer9kl
	iAXg5h84ywBuhLHa1RZ+Dl713ApPsw0Wt0ChmKZtB9o497CHlHjfsy/WlBuiwJjB
	D2T+RhAGs9HARs6NLUi/QpwW3eDIA5g03pKA1odyr/Xqi2cS0gVxZlGLlTqyDQOq
	RnmOW/Dta5D42caQ6EMq8TNe9dMiHv+fq+Xxao4+HNOkZcwB/KAglv86vbPk1oHE
	ndGJbN0FGDslOdQlVS9juE2swiQIodW7kiFep+6kSLyLbW1qiRZddh1NgOyE4DWm
	eGNl51RFl+VCxLpPZ1coASJcHvbGG3duwog==
X-ME-Sender: <xms:7wbbaO_vtXq9VRc63SprqO6DMyjqf33NuwhON1EWe0SC8fw6U2b9bQ>
    <xme:7wbbaGLaLdlgbK72cJyVbCeQFIjKI5Xr3s8pXtHsne0LBNm95Q_Y36Jfgnp8SefjQ
    MDcrk_T_Z71NfuUFuE7DlZPc4NIH9zJF3Ky739q84anTYdMhXNd>
X-ME-Received: <xmr:7wbbaBYQkC294WZlnTElf9YUITP_YNdnrni6sbub_cKpsIBZKDfX2TcIX1GdU1cGBDzYUB4edk1HsWE7LZYwTUZcpExUVfcpkGixEUXE9pE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejledulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:7wbbaAIh3aUK8x01fx_k5p2VGZTimCz4mCuwKwBaliSpp1rAAGIITg>
    <xmx:7wbbaHBVCN-9LERNiPOxzr1scH9yz51pBK0Q03gTDKep0yEid9f0Hg>
    <xmx:7wbbaNqBIGGwPv7BUIqFtuxK62lGEJbrHBaJ9hllWu1mEbUm0LLMcA>
    <xmx:7wbbaKgvTL5M3z2QMn6-vGaZcKlgF3ju-_B0yJQu2viM9bIKBKhBEQ>
    <xmx:7wbbaD2bW8YdRu8-zwn1VQZexhXLVX6KfaT8TyoaR4IUNDqH5bz7OGB1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 18:23:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a685a780 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 22:23:41 +0000 (UTC)
Date: Tue, 30 Sep 2025 00:23:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
Message-ID: <aNsG5Jd_YLgrwarI@pks.im>
References: <xmqqldm0am4b.fsf@gitster.g>
 <aNhX9AJ/zq4IYhmW@nand.local>
 <xmqqseg777k8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseg777k8.fsf@gitster.g>

On Sat, Sep 27, 2025 at 05:19:03PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> > index 86ca7f6a78a..789febefff8 100644
> > --- a/Documentation/SubmittingPatches
> > +++ b/Documentation/SubmittingPatches
> > @@ -506,7 +506,10 @@ After the list reached a consensus that it is a good idea to apply the
> >  patch, re-send it with "To:" set to the maintainer{current-maintainer}
> >  and "cc:" the list{git-ml} for inclusion.  This is especially relevant
> >  when the maintainer did not heavily participate in the discussion and
> > -instead left the review to trusted others.
> > +instead left the review to trusted others.  Patch series must receive
> > +a positive "ack" from at least one contributor other than the primary
> > +patch series author in order to begin integrating it, subject to the
> > +maintainer's discretion.
> >
> >  Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
> >  `Tested-by:` lines as necessary to credit people who helped your
> > --- >8 ---
> 
> It would lead us into ugly awkwardness when we start clarifying what
> exactly "contributor" is in the new sentence, though.  If a person,
> whom none of us have ever heard of, sends their first message to
> this list saying "Ack", does that count?  If an active developer,
> who is known to be sloppier than others, sends an "Ack" to somebody
> else's patch that was posted 3 hours before (hence there wouldn't
> have sufficient time to think through the issues), how much should
> that "Ack" weigh?
> 
> Perhaps rephrasing it to "those who have helped in polishing the
> patches with their reviews and discussing the issues with the patch
> author" to tighten the language a bit may help?
> 
> I dunno, as that would still give the "ack right" to a random
> noisemaker who threw a drive-by "review" that did not add much value
> to the patches, if the original author responded "Thanks" out of
> courtesy.

Despite the potential awkwardness I have to wonder whether this would
even help us with the goal to speed up the overall process. To me it
rather feels like there's another step now that a patch series has to go
through, so my naive expectation is that it will rather slow the process
down even more.

Am I missing something?

> > I am not sure the idea of adding more maintainers is a good one or not.
> > Since I am not sure exactly what you are envisioning here, I think there
> > are a couple of cases:
> >
> >  - There is a quorum of maintainers, who are all collectively
> >    responsible for building 'jch', 'seen', 'next', and 'master'. Any two
> >    of them are required to agree to move a topic down in order to do so,
> >    without needing the other maintainer to weigh in.
> >
> >  - There are sub-system maintainers who are responsible for their own
> >    trees, and who send pull requests to the primary maintainer to
> >    integrate their trees back into the primary maintainer's.
> 
> Git is not large enough to benefit from the latter arrangement.
> What I had in mind was the former one.

True. The other problem I see is that it might also skew the rate of
patches towards subsystems that have more active contribtors (or rather
subsystem maintainers). Other subsystems that don't have the luxury
would then potentially be disfavored.

I guess this is especially an issue as the most active subsystems tend
to be the ones maintained by hosting providers like GitLab and GitHub.
Drive-by contributions on the other hand tend to be more cluttered
around different parts of Git, and here it's unlikely that we have
enough people to serve as subsystem maintainers.

Patrick
