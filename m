Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD02BD5B2
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879120; cv=none; b=Q4t8ku5Ph6d4f5YEN+7d/SWIjL1OMCKVgePeiIVTVSSuKWtSIGRjOtfggenVIjeXcT4vD6XAlRE7KIAmrHXlYs3ug98ADIeaHhqaRv35f5M1n902QDQ+jFXw18o2BIhDfiHJ6yfvdLx7im9EtA7E+sZZP4/VqPs5YNI2I5YSeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879120; c=relaxed/simple;
	bh=l4Myl/H801zPBkY8UZvhGSws21YWCjbsiyT8+tlrC/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOQkXNudcbfbLuFCPezmmPClKXIpzFipNQ5LTbt0a+6EhWb8dorFxA8olxs16E0d6TkS2fa1e79lE0p8L1XCQfIpuC6v+GuBcYbHtWigmXAOOtbiKH5fzLaMfBEyMLXLaa0xQmziznWWn01/ludWrqLGlQsxCdE48PMKeB8YTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hNZ9DH6T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5PWpM8E; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hNZ9DH6T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5PWpM8E"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 04251EC033C;
	Wed,  3 Sep 2025 01:58:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 01:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756879118; x=1756965518; bh=zh+o9M47n6
	eiS6SXfkfg8pi3fZRpNKeR6rmwiueELqk=; b=hNZ9DH6TgXdbZEebuNNFkahOJ1
	6V8uiwFKkc7CYMVWBBmFY4Xah40EAVv2lfbggK+y99yIw/VR7GzKekCYLT6QQEKO
	NQdVxPJI+bzhsCrzG2/ke0Ho4Ktn5o9Ti6OvDAjettsMzKYb8h43nh+4ThC9JK0V
	6mWnat0/2iDrXwyEvi+r9SFP2SVNLcxYhDTZWYCHu5wVcH7/KS0Jt+hH2RK/ep2C
	pSgAyJMCKn+q42kDrrAFjpolAS6aKWsXgVrTsFX2MlofbRpIfpSzZAxnx9jOSyFw
	uXNVXpY2znF2RJaj8PL0YqtowhPF2cREpskXvT0qQ/dVEZ7wrwPm0UBuk8mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756879118; x=1756965518; bh=zh+o9M47n6eiS6SXfkfg8pi3fZRpNKeR6rm
	wiueELqk=; b=W5PWpM8EhLnSVDRm81zr2DWDmMP5ejVEFD/mLMU+TrAZeaPiLRS
	H3ezuAbzbttBfKg3AhKRVCSUWvIr02dM+IQY447TOs9fXHoXEuAi3toxN1/sBYO9
	7bfdlLavrJEIR1K1mSbNlKfNSMcAWgSOfuYpw+egnmgo1jDEXtFFpS7C4uDontuW
	14LyVF9jPpFi6wOltG+8VQ0GLoQWIrx7s2KI8yiLBBtykj7LRRItuwxkiHSLoKnT
	zGT704OhgTGEpi/ifxVXC4MUdPkUmZHtDNt7XpMPNOtsJKJdHPweY2awPbnZJstg
	xNWxVnB6HkWeMak5O1Ui8lpt0OxOWv0zcOw==
X-ME-Sender: <xms:Ddm3aAcAtioJN7TGSYSxlZEOtpYTnaITWSFIc73R-qPZcuMO99Jh0g>
    <xme:Ddm3aNvfCm-fOc2d6_DyyA5KhgUWlFUq8IhGb3AYWeKsfxJ1pyfIhNE4Udt7-tKEX
    0Vya8uY3N4Crz0afg>
X-ME-Received: <xmr:Ddm3aH88RdrhQjrh1Djrc6_wRjxdDTMbq_bdjHNSOY-jSIyAcjE5PwXJC-1dioZf81Clp-bVyF3YwYmTqVMoJOLu39mzjDHsX2swZSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Ddm3aA2Z_j_cCpMfB-3EFkKbbVOdXFOU4vajsGa4S85L9QuQAM3GLA>
    <xmx:Ddm3aEAy4V5jo-NHtFP0A2k16IUROa-NX7Aaryk3Dfzw1JAOblDJ9Q>
    <xmx:Ddm3aEctQeLBPMMVYBVlCY5geeCCRu68uIBPF104IjwsioxBiPaC3A>
    <xmx:Ddm3aJ5SUyvz-8szuRiHGEN6Uqh-YPVktfaKnZkuQp5M6prIa4vGAA>
    <xmx:Ddm3aEAFoupL2iQ5Rn0GsFiS5b_C9ltrlONH_BQl7Gm9vahRfSU2Ujht>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 01:58:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 611d2562 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 05:58:34 +0000 (UTC)
Date: Wed, 3 Sep 2025 07:58:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/16] odb: move list of packfiles into `struct
 packfile_store`
Message-ID: <aLfZB9L_jvxt7U94@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-2-d10623355e9f@pks.im>
 <aKz0/WNu/GRYh3/W@nand.local>
 <aLav4UAcfQjvNzMF@pks.im>
 <aLcngI6vm9DmqUeI@nand.local>
 <xmqq4itkkaym.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4itkkaym.fsf@gitster.g>

On Tue, Sep 02, 2025 at 10:42:25AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
> > So I think in this case, the CodingGuidelines would suggest that we
> > write this as:
> >
> >     for (p = store->packs; p; p = p->next) {
> >         if (p->do_not_close)
> >             BUG("want to close pack marked 'do-not-close'");
> >         else
> >             close_pack(p);
> >     }
> >
> > , which from our discussion here seems like something that we both find
> > more readable than the original.
> 
> Yes.  Technically the "if...else..." is still a single statement, so
> a rule like "do not use {} only if you would place a single
> statement in it", though.
> 
> I would actually write it more like this, though.
> 
>      for (p = store->packs; p; p = p->next) {
>          if (p->do_not_close)
>              BUG("want to close pack marked 'do-not-close'");
> 
>          close_pack(p);
>      }
> 
> The first two lines in that block is a glorified assert(), and
> without a programming bug, what the loop wants to do is only to call
> close_pack() on eacn and every pack on the list.  Not using "else"
> conveys that much clearer.

That reads even better, agreed. Will queue this change locally and send
it out with the next revision of this patch series.

Patrick
