Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFEE2FF669
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002642; cv=none; b=sAe4P/LeCO+f3tMT7ltnvfI37FLZ2WBjMUd1kqOzu1D7qHG7H9OvpzSFRbIgkIEvpQWR3GuIgX8TPQJ/P3viKSCcjyn2mie7KXHeuN2LTW3cKIj7HWZxpPfIOge7sBmTAVXAqqDwppBfYHr8YrY5z5mOIb6FxXLPWpf3nzPo9yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002642; c=relaxed/simple;
	bh=guE1XNKC4Lsqum/T0uOEfmbbBUVwvFBEvUns7c9SSXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEHKah3tzZgzIsBvLgkniC2hVskHxiT4iN4SuxRnlpehIj4oyBopasWMdj16Suc3ZMYAhhFCXDZHNOfryivImcnZ82W0pg6YqQcZCIJcxF4pW5KT28CwnfdSjiPi1s13WYlMqcGpLXCvw33INrYw6aCFxt5NIyyV16S4FrYbYCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jJEmQt0z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DXImmsDs; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jJEmQt0z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DXImmsDs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CDAB3EC01E4;
	Fri, 20 Mar 2026 06:30:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 06:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774002640; x=1774089040; bh=SzN3aps0Ou
	LjhXBEOAFYefTV465J5zlEsgVWGCG203k=; b=jJEmQt0z5Mzei1oxLmnIfi9UEV
	Oji7cJ+zYhMUXPnPSBthGgZw4odC1pWfdYqoJnWiKezvWm2oWVdIOErwP80Zg5Nh
	F3Kp7FKrySi9EMUKZPzqZ5/3T7BQJl4O+kYbBIV6mNkA+N1Mp5+wslBdE0lDW4Gi
	c9z05p+UGlW7Rkx8NYm/M0JmOgkCw5FlwbQyAhFqtBfAAtQzeWOTp9S5KP4mN1ke
	R7lp6PvHadxB10XiD6cB/aHW7GFQ01xHywvaKh9GXsjO4Zhb6QxpQAKcMrxO2fPc
	N4TqttJCfVm0r5AAxLtpitORJyg1TVu+pixML8QOGMNCZjIqopn6lEsErz9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774002640; x=1774089040; bh=SzN3aps0OuLjhXBEOAFYefTV465J5zlEsgV
	WGCG203k=; b=DXImmsDsQL8V17ZSbL/uwAEnjsWU51RCHIyaEIBl24lFvNSO2It
	8nvO4Rzh77qE9aep8Fb5DO6vI/Pwn73MvFzlDO65f7Ng0CfHeNTUnbMeVayodPfQ
	/X+2VIo5oArvpK1ESaxaRZwXJ4aGsdrjj/b/X7Cn6WMoPRbG+oDIMHhp5W48mIN/
	+ycSfcyIkt8yjo5jB03ErycSvt0tqZ6upj62Zuk9IqKGkp2iNGjsMdbAACHpTuSU
	y2S2AANWvckEf6KBHlvL23s203QGo4RNkvCZPrfZtlha8/kwHFvAIGjOHG+ZYRuK
	4CG87vbL2qP+XBI36Cp11UKxF0VxA3mj/+A==
X-ME-Sender: <xms:0CG9aTZz-69B1429W9yCNpgQwMCujE1EkfMBex0M082NAorsbK4Yug>
    <xme:0CG9aZ2JLJNJy8glisKCy5jZhuBg7WG0RD3SjsiDGp5I2J-LqKylHvvKkxBMfLind
    C8_zT10DVacM8l-CLpxjD4kkN95WnAp6paS9dGbddiqL1q1f3iV3A>
X-ME-Received: <xmr:0CG9aTWu0-QyTDWL_bJTf-Be_LwXqcxVuG5HY_w63mBznIZexRzwALA1SVlMO5PU0ICswoQwZ6jBPUwrGBPkRnrhe-IFgZ3ClbKpvFGGcUo6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0CG9aTVOSxQqDZdvzrTh-yrCS3lHalz2pbYW37fX_QrINQlhjO4plA>
    <xmx:0CG9aSdmkcXb9uVSjVH5f48LMZnslorM5dxNyaFRPJykIeFnNKsdNA>
    <xmx:0CG9acUJNcmqQ_9ZQSPvsDCYf2WDW1bvbEv0XSFA0iTpuNSsS9eqKw>
    <xmx:0CG9abcwy5depIu6MMyN1KX4jXBvbuZkpa0h29QZGjlfMOzSW5gk9g>
    <xmx:0CG9aR16DsG7sNm2vDHk61waZwukObjLKkl8OJNP4gqVruLDDkyJ_2mC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 06:30:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f71b7a6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 10:30:38 +0000 (UTC)
Date: Fri, 20 Mar 2026 11:30:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] odb: generic object name handling
Message-ID: <ab0hy6AitZFMf3RO@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
 <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
 <CAOLa=ZSeMS2iKzgMUWix_Sx+e24863PsOazRLrqHtS5hYSUk3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSeMS2iKzgMUWix_Sx+e24863PsOazRLrqHtS5hYSUk3A@mail.gmail.com>

On Fri, Mar 20, 2026 at 03:04:02AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series refactors handling of object names to become pluggable
> > and thus generic. This includes:
> >
> >   - Disambiguation of object names with a common prefix. This is
> >     required to list candidate objects in case the user has passed a
> >     non-unique prefix.
> >
> >   - Abbreviating an object ID to the shortest prefix required while
> >     staying unique.
> >
> > The logic to compute these operations is specific to the backend, but
> > not generic. This patch series fixes that by moving the functionality
> > into the respective backends.
> >
> > This patch series may feel somewhat unexiting, but it's not. Especially
> > abbreviating object IDs is done in lots of places, so this functionality
> > is overall quite critical. So starting with this series, it is now
> > possible to do all kinds of local work with an alternative backend:
> > git-commit(1), git-log(1), git-rev-parse(1), git-merge(1) and many other
> > commands now work as expected. My MongoDB proof of concept [1] only
> > requires two commits (the object format extension) on top. And no, I
> > don't endorse MongoDB or propose it as a future potential backend. It
> > simply had a good C API that was easy to use.
> >
> > Of course, other functionality, especially everything that involves
> > packfiles, doesn't yet work.
> >
> > This patch series is built on top of ca1db8a0f7 (The 17th batch,
> > 2026-03-16) with ps/object-counting at 6801ffd37d (odb: introduce
> > generic object counting, 2026-03-12) merged into it.
> >
> > Changes in v2:
> >   - Document `cb_iter` callback.
> >   - Fix left-over conversion of `odb_source_loose_for_each_object()`.
> >   - commit message typo fixes.
> >   - Link to v1: https://lore.kernel.org/r/20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im
> 
> I only got around to reviewing v1 now, but the range-diff here looks
> good.

Thanks for your review!

Patrick
