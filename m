Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913DA41
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284812; cv=none; b=lrAk+v5j4d0ybfNtE6md/HGFyMp82TliRsyXuqoqCxulsJgeM3IKt7Cxgi3FX1ZybG045Eb+69LdM6wBaVgsRbRhQiTR/JMhyN4OaCQbt+Qix9U2KADDFyQOADOpUKMnML3ZT78aTQtA3vn8CV0X8mFxisB+m8nZdb6IjA8ksQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284812; c=relaxed/simple;
	bh=pp/4i+sJ+tcb7xm5Qal2LHGxRGnQW/bYiuGfyEqWsmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCumdLvyhxtZOhGTkALQ4RJT3jewKwGvWylPVDtpAnTlz6GW0J94sfjWkSmX0I4B5/uNeXBPHHRkayiYu1ICf0Kd4TGhLhzY4erTkEzllmu3ezphRO53+96THWgKQ7+LbLAw6Klc0HW/kAcYsJtCeJ0ra99XFgn1UKCzsb+S2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WyazXlaJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qmVZDbbK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WyazXlaJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qmVZDbbK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E3B7DEC025C;
	Tue, 13 Jan 2026 01:13:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 01:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768284809;
	 x=1768371209; bh=453uyyTtmLcMyyJU2KsoTk4nkrlcWe9Ka2PJU7pmopI=; b=
	WyazXlaJpPGm4ouG1LM0nPTAHORge37Wm30WvegWX5M+spYsJg/Rw4IHUknKNYfc
	78HlMOWkxMLi+X4QgLss1ul4AZkX2hjPvTAp6QLAfRz3jod/IjkamtC1l1d5mX2I
	bkJuYDjk/FBYKLv414xWVyIy+dDaGJ/WJQY9ErCn59r27NjFaF4941tce3FuYHVw
	PnA8axh9hoSASKvjAC9vOaWO993i7yfL4/4Hsno1rv2IDulRma5cl6ZcI4+oE4yN
	FGJ5JZzJJmgg9CRWPfY6x6RD3gIMJwpY3AOt9ha5wfSm2t3FMQs0FdpP+Tej7L8T
	LHgjz9/smxbOdt6Dl6WyyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768284809; x=
	1768371209; bh=453uyyTtmLcMyyJU2KsoTk4nkrlcWe9Ka2PJU7pmopI=; b=q
	mVZDbbKyubzqCS2p7IxgBHbM9Tb8w81+LGu3vFNHh3sHtOZeNKWkgiklPEKQ3JjZ
	Adv2uIFaQwjArgeQAMc+88sZMfpWPqMmsuwADUM7a7+2g94MHK78+9CQ6x9ZScra
	iNAtqjk2tYCELq6yDTozYPKnE7eHEKvnmsuFWl7zuDLB91r+a4V4sVuSzHy+DHOh
	uPzcc7SUzXrlknFnZbZeV+Ldt0jAD3Yg4xsf9+DyziK9nOt+yS5eWeXwP8DnhSLZ
	xEvjHVesULa95OWvAYCXILcPYKM1J2UVx9FzmxRSLWgxF1b95oq/VKDZCzn+j7dr
	0UHkOqcsKEl57+JHLjY/g==
X-ME-Sender: <xms:ieJlaUwMj5qLVrNZEz78E_YmPsWuKfLpPZYf8ULHuFyME01JWx3ciw>
    <xme:ieJlaft71kMc8gFp96ZLNvZcpS10hNaYnGLe4_rfTkBxp1xUKu6ov8PaR6DVLFTrc
    4VHdIluXn-oRctZf7kqaQz8ajE3XSwRJnXUAAp-Qln7hjqu5iTTsw>
X-ME-Received: <xmr:ieJlaTtUmL-0yri8YclVYSGtuKDXbrrEI-3bLfNmoTxsWoNMcsXEqUJUwIOIMVf_xNbEE5J7LiUXAVVTMSf3-AGquCmf1SRlOIVPweAAhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ieJlacNitygpFLNM386QYUlXH1wthd-J8QZ4cr84f3Fz97ZYoZgJfQ>
    <xmx:ieJlaZ269agzZOdZy6E63Y1234x2wk5XcyDvNQ36DK8ZnSDtJuRT1Q>
    <xmx:ieJlaQMEl-8KLYZWTwrGCkvTs7Mf3uAS1717yxFypU43lPXVdZfvVA>
    <xmx:ieJlaR1xfmsqvyZRiAPbi56ys_qB1Uawz3Mjp_9PiqIym6DU8ujAaQ>
    <xmx:ieJlaWVyIOYjFQBvApeN4XTlCkSJ7vcerwFThuz_d9aW72FVCJK9tz8n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 01:13:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a3fddcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 06:13:28 +0000 (UTC)
Date: Tue, 13 Jan 2026 07:13:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 09/10] tree: stop using the_repository
Message-ID: <aWXihQ3ETjQfO6dz@pks.im>
References: <20260109213021.2546-1-l.s.r@web.de>
 <20260109213021.2546-10-l.s.r@web.de>
 <aWS9Ll8CQ3eILx3z@pks.im>
 <xmqqh5sqoqr0.fsf@gitster.g>
 <aWUMn6G0C1cHA4qY@pks.im>
 <xmqqms2in9hb.fsf@gitster.g>
 <aWUTNU7WGTwHt6Ks@pks.im>
 <89e23323-7e0f-42b6-9a89-dd8a682644dd@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89e23323-7e0f-42b6-9a89-dd8a682644dd@web.de>

On Mon, Jan 12, 2026 at 08:37:03PM +0100, René Scharfe wrote:
> On 1/12/26 4:28 PM, Patrick Steinhardt wrote:
> > On Mon, Jan 12, 2026 at 07:20:32AM -0800, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >>
> >>>>> In any case, I'd propose to move the compatibility macros into a section
> >>>>> that says something like:
> >>>>>
> >>>>>     /* Deprecated wrappers that will be removed once Git 2.53 is released. */
> >>>>
> >>>> Please do not take release schedule hostage to one particular fix-up
> >>>> series of patches.  Thanks.
> >>>
> >>> The intent isn't really to take anything hostage. It's rather intended
> >>> as a hint that once a specific event has happened, we should take
> >>> another look at removing these wrappers.
> >>
> >> I am OK with a comment that records the intent, e.g., "let's work
> >> towards reducing the use of these wrappers", with the plan for the
> >> next step, e.g., "and once we have done so, remove these."
> >>
> >> But the comment you wrote is forcing people to make sure we remove
> >> the code that uses these wrappers and unless we finish it we cannot
> >> release 2.53, no?
> > 
> > That's definitely not my intent. It's really only intended as a hint
> > when those should be removed at the earliest. Maybe something like the
> > following instead?
> > 
> >     /*
> >      * These wrappers can be removed once Git 2.53 is released. If you
> >      * see this comment and that release has been published then chances
> >      * are high that we forgot to remove them.
> >      */
> 
> Forgetting to remove the three macro definitions is very cheap.
> Forgetting to remove their Coccinelle rules is a bit more expensive.
> Can add a reminder.

True indeed. We have a bunch of Coccinelle rules that are not needed
anymore. We should probably do a spring cleanup of those.

Patrick
