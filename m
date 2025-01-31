Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CEB136A
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738299117; cv=none; b=nNfkgJcHunC8L0StjwB2h94fjMjqC54D8r4NqhplhhwEI9Dy2xnJXAJo1Lm/M8cloGBZxPO5MiAfx3uA2Tlf2Hw7XkPQXJ5CeMMCL6zqVzHIRgai8Fsh6r9gUcYlHHJCTdgcnWylWM9CsBWRGw1lZ6Y7mjtgANMxxQ09xx9yw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738299117; c=relaxed/simple;
	bh=ONVkdVdH43PoQkk2OsHrZUOIgIjd5fT+gMX4XEhH2MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njCm3+w1epsN9SXSiJl2tD3uPFw4VkNJXU6emwrcPcs98R6zO5jf3k7ZGhN2W3M841ISmJyDst1ifX7qqTnsxNYHWEHOXfwdkjWJYTKrfbN0LuGk/z9uGHGYgn/PDdjlA68X83Iwbc1S1fba6kvdQGLIa+G/Om66z8iEWj2qgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=esHuAkqr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nyE8l38j; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="esHuAkqr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nyE8l38j"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8807D254011D;
	Thu, 30 Jan 2025 23:51:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 30 Jan 2025 23:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738299114; x=1738385514; bh=IfUTOvJW8F
	hUBiWkc1APxXjkefoHu/3jciX1rQe4QvQ=; b=esHuAkqrclSwNC0wFy26+ery+b
	b7+vJuuenzU8qu7JGQhTskoGSPMhwcq4oEWBFBIpIlBeH4HpTnDL1ATKPy24O1m7
	oE/8cwtVHKDAnD7yhyQo/MwPuyj2NLv2I1GF8vHwyxgC0tTFGsvArr4MIsI+hHIE
	HCQJfIYlLzR6fkWiOaoZ4d+4kcFhmLeQvme9DuTl09tPW8+fi3t6W7FIfUWiuV3t
	14WpjX21sGCzZ98Q3z1lBrwPAVMItbSWhe5oV+9fJ3dx8JMP4Cd8zJFGM3vBsSii
	Tsg2t5fOlMOl9FMflyn18DtNGdsbVS9VFat5shsiZXWUCA/bT36C/wYcZFIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738299114; x=1738385514; bh=IfUTOvJW8FhUBiWkc1APxXjkefoHu/3jciX
	1rQe4QvQ=; b=nyE8l38jETDJpbgbnRn1fhC75LbYRc4ml8WDBnSqeOn1w9MjjIL
	aVHviBRlg0ffVhqKIPT7+9B2cK5YPALlLzjP8fStlmgu6/8XgjbxVtF6Z/H8H1IP
	FvgtdEzL+cru8GpySTWLTvBKf93qjGuExL3AL3REgednC0fZAexeEz7u9JmoRt7m
	dgbAwnJFwelEjePwHvy/2N+9p4Bv7Jmyo5nWOAVLO/ISvmSiFZ0Uw6CSkx10sWra
	dLVmedRe7vmOJD4IJ8hS4HTTV/vQBZxvZ/9XcijQGpbhPVXX0/WbO/MVdpspfGdg
	BryTR1a5LBqGbyKrq/+Oi79KYfiPuG8d5yw==
X-ME-Sender: <xms:6lacZzXbK1nqk6se7JX-5z4P3k2m314drLlw_-WxarU4ki-r_5WkWg>
    <xme:6lacZ7kPcLHhORI0ZVmvuDDuvN431sqBN1SuDgyIKrMznTJQc9z-qnJMO31DU-iIK
    Pq-1LYRQW5z817Jxg>
X-ME-Received: <xmr:6lacZ_Y_wx7g6lb0kl_CjOUDXl9d1YN1nW_mEKhfgIJGfYnC69Y53uvDOtkCi4BZAiOC4DFFkoP7xPkjz7AFS8bO0gZues85EwMxR8eQxwXL5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrghr
    thhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6lacZ-WrRBSrp_rsrYxqO4WMgA7-zQhkQzQCiI6Zo81FOG9fRGd5Qw>
    <xmx:6lacZ9myDJ3AkVibgOgKPP8gzEnk1Up0DKEGzUCwH3pJUo_Pb-15Ow>
    <xmx:6lacZ7e4Cdb6tCgLUSmMs4b_NSItANVChwQT8zpuD-BfMoasU1KCjg>
    <xmx:6lacZ3GhaUvhlu8RVKtf7PqlKsOrmEYD_xNAUUdJjRfiqiTuu-99YQ>
    <xmx:6lacZ2CNKS0y5dKUplNdEoPHNsemWiup75ZhfxCWKpo2RfxGTkb3-oNp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 23:51:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 722c148c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 04:51:52 +0000 (UTC)
Date: Fri, 31 Jan 2025 05:51:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
Message-ID: <Z5xW57fsOCNcGViY@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
 <Z44u7od-mDiKcKVZ@pks.im>
 <xmqqr04vzyz9.fsf@gitster.g>
 <b784f612-4b6b-414a-9742-86611c50c55f@gmail.com>
 <Z5srHBSPKQlsuH53@pks.im>
 <xmqqjzaccdpn.fsf@gitster.g>
 <xmqqr04kaufo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr04kaufo.fsf@gitster.g>

On Thu, Jan 30, 2025 at 01:00:27PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I do not mind either word, either, but I have two small issues to
> > raise:
> >
> >  - Is each topic "owned" by some specific person?  Would an owner
> >    retires from the project, would the leftover bits go away with
> >    the owner?
> 
> I obviously meant "When an owner retires", but more importantly, I
> should have offered an alternative here, instead of just raising it
> as an issue.
> 
> How about making the rule a lot simpler?
> 
>     The expiration date kicks in _mechanically_, i.e. stale entries
>     are unconditionally dropped at the date, based solely on the
>     comparison between the timestamp and the wall clock.
> 
> People are free to advocate for its continued existence, and when
> such an effort achieves a concensus among then-active members of the
> community by the stated expiration date, a patch to update the
> entry's expiration date may be accepted, thereby prolonging its
> shelf life.  Unless such a thing happens before the expiration date
> comes, we will mechanically drop the entry.
> 
> Of course people _can_ resurrect an expired entry later as a new
> one when it seems appropriate.
> 
> That makes the decision to expire things from the list easy to make.

Works for me. Ideally, as any other topic, the retirement should be sent
to the mailing list as a normal patch series so that people may chime in
on the retirement and state reasons why they don't think that is a good
idea.

Patrick
