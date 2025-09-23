Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2972045B5
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635941; cv=none; b=c9xH8J16PkD8HQMPJiOszhyE3etz2Gb9T+mjaLDEtWHfQKj1K4eLvhR1yu7pva0x5ixNg3pOye825SF5PnyWy9Ml6C0UvXRk8+nxMxF8gbw0ZKm/lDjze3DjfYzl0HOHUy6fTS92tiWcClE7BBdchMp1dY2LsvPferkdDhzGGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635941; c=relaxed/simple;
	bh=s7kp924JLNXvBmY58THR5ldHZpn/kJtLrCoPYbeMz6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcC8a2EIWXNhiFA27LHyDMDKTPa4v6P3B//KNsJXJTVy7GcdXGQHjZU+vowOtqLvkDPh3550nkAfygXGGq70VV5EBsPiZmIOOYsjBtmqmj3qVSf0MPmaQrVvMexoaAytTmxKEKwsWSxkxDhVx8BhvTNx7qRwwxBNSAvEgSsS7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KIZy+Vl0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=czzC1Zsa; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KIZy+Vl0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="czzC1Zsa"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE6687A02E6;
	Tue, 23 Sep 2025 09:58:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 23 Sep 2025 09:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758635937;
	 x=1758722337; bh=r9CFWIzgB9KUTLqZxCV1H8GwLLV2GTyZIGMrxHX7Q8k=; b=
	KIZy+Vl0MEhhC+sadBZBPxz8urrKa3MHIWT/9wFgmE7+9KuZ3Inq/DV7Shr4KlmZ
	mdj8moWLJbxp4zbHLdUrRvLzqR3WvAvBfieOy9WHSzFuaXN9QiiNJ4EqnuUvfW58
	CynACTW4uos5cxiwxa0JLSF4Rua1eDNMq5oymMq4PzGVMkLiUoPs4ye7YdY6YLtP
	xwzvkRCPymXcPcmmdgPgmN2xPosOpVjEfrln4F6IY9VX1HrffEcn9O+9KayU+AAJ
	/Dbg9zJVPGxIW9GDDZTlQvU9+s6j0+8VMOEXB4rdgMedPFRNrfttQ0+XHXIaQHgg
	G4yokxrRcSIdlEmTkEybnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758635937; x=
	1758722337; bh=r9CFWIzgB9KUTLqZxCV1H8GwLLV2GTyZIGMrxHX7Q8k=; b=c
	zzC1ZsaBaWFH/01BClTp1xEemCtpVNy4tJjtUQtvoAebI0xq8Z0l1atigTVsJg9h
	CPvdLd7c1OXQbFVPP5FHqWsSaw6P5llzVT4jCOim64LIGrs7fxqhx0RNoT66QHgo
	Boh7+KkdckAPN/gdC0Tk9D9PNmgyuOBTsEw/tPpEiebnhctqltGWkmhnOsOEtBfy
	1Dv1ciSJozsGQ093SWg/czjJVbeXLy5xQG2Ms53rxVLofXlMGIx4iZKqPtM0IRcN
	1/cuZwAI69LAUzlFd0eTC3UIJxvsEzxH0b6cq4S9XumKMlDYtrTSWbfDf51i/Dfd
	TpdjuMEteKsgmVlkR8yNQ==
X-ME-Sender: <xms:oafSaMvoK0dD2mfyrbAcHmsLUdrx8ip1crQkSyJ1WOoGXFN_7wnyOg>
    <xme:oafSaA54zhcUveIJqdrPDmiYLxyHr2u5olaZzDot_nU_rN8U_Y-MewSLdbHoDoSN_
    vfnrrQSPDl2eA8aSqjsVupXSk0SmLQsR-InuUXPiSCICTaFlkm8LNg>
X-ME-Received: <xmr:oafSaFK6K6gomabgGB7G0bVD4tfxCfoLzhZhEwxW2PnIj_m5fnW2TnQCOQ96Mu3NTYio5RapEOc5BN7ztbSY8QbUY4syHc0BwmUva11acs1h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:oafSaI6EZqyxzZC0voFI32lUMbfRzfkYqrdLze73FrOl9f_rkevjXA>
    <xmx:oafSaAyAB0QdVVbk_IWuHUTzHAa7cGiUtUYy43-kKND3Pe7Iokw41g>
    <xmx:oafSaEbO3TGNkORBdP5cdggmbYG63cTtZTfK6FPeu_r31_awwIMtow>
    <xmx:oafSaKTBHs2HgZ_ye-EJDUzRhsLbcfQrngFDbPwGVtjo-lkkwo0RMw>
    <xmx:oafSaM5_73KbxUEcJOEDR42laf5INkaQwfMbA6UlAU1plaHUV3kycQn9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 09:58:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2d40334 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 13:58:54 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:58:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] doc: check-docs and WITH_BREAKING_CHANGES
Message-ID: <aNKnmxtcrWH_GlAV@pks.im>
References: <aNJUUxfhM7QYDQGj@pks.im>
 <DD6B592F-005D-4F36-9585-003C1C4ADAE5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DD6B592F-005D-4F36-9585-003C1C4ADAE5@gmail.com>

On Tue, Sep 23, 2025 at 09:30:28AM -0400, Ben Knoble wrote:
> 
> > Le 23 sept. 2025 à 04:03, Patrick Steinhardt <ps@pks.im> a écrit :
> > 
> > ﻿On Fri, Sep 19, 2025 at 02:33:33PM -0700, Junio C Hamano wrote:
> >> Shouldn't we do something like this for breaking builds?
> >> 
> >> Documentation/Makefile pays attention to EXCLUDED_PROGRAMS to
> >> pretend that the git-$deprecated.adoc files do not exist
> >> 
> >>    -include GIT-EXCLUDED-PROGRAMS
> >> 
> >>    MAN1_TXT += $(filter-out \
> >>                    $(patsubst %,%.adoc,$(EXCLUDED_PROGRAMS)) \
> >>                    $(addsuffix .adoc, $(ARTICLES) $(SP_ARTICLES)), \
> >>                    $(wildcard git-*.adoc))
> >> 
> >> but nobody seems to put the removed programs on the list.  
> >> 
> >> The dependencies around Documentation/GIT-EXCLUDED-PROGRAMS is still
> >> screwed up, I think, but this may be a good first step to straighten
> >> it out.  If "make -C Documentation" runs lint-docs by default, for
> >> example, we may want to tweak the Makefile down there to make
> >> link-docs target depend on the GIT-EXCLUDED-PROGRAMS perhaps.
> >> 
> >> diff --git i/Makefile w/Makefile
> >> index 893070be76..711cade8fd 100644
> >> --- i/Makefile
> >> +++ w/Makefile
> > 
> > Curious, but what's up with the "i" and "w" prefixes here? :)
> 
> That’s « index » and « working tree » from diff.mnemonicPrefix

Interesting. It's amazing how there's always something new to learn
about Git :) Thanks!

Patrick
