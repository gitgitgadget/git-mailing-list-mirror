Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366F92F2D
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290301; cv=none; b=iktQSm2/tboG0VW5QIrrTe5ISYiTey7uZFoDpkGS5YMbUsEsBh4F/rhcp2e2WuvLStvlig31U9R6S6QqspT0pgvs0QEkCgeAIEUQtJGkqLvHAW9RIiyaHs2MXwpvZWuQErKLfZTp93aEnwqOPIEA0ufMm4kp6A5dUH7xylXUwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290301; c=relaxed/simple;
	bh=Ca2yQbLFHZ+EJnGDI1IAcaVMDJdrtkQagwR2VRvRAZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G32ZT3mPbAeRndGOuhDdfHcMb4SZ72JyNET+7v5Io0bXpfdTAjTKm6OxHxI2YkBPtSNsRxIJvf5WQcq/fGSjNHd4HxYAFqUe8IW31EIVrR64cIi9PWsogQBL5NoiOedcfWTVr8gkRvzQGfHM1DdQurHxs77YXlHyg21Dhg5xSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jb+r3XC6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hT9ZxSUh; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jb+r3XC6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hT9ZxSUh"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2726C7A00A3;
	Mon,  4 Aug 2025 02:51:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 04 Aug 2025 02:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754290299; x=1754376699; bh=+EPPmelWzu
	pRyLRm9a2oUiC+1MjZuo7akBQ9a2HlrPA=; b=Jb+r3XC6uKWfZCPCW7ebFLbAgZ
	BewLDq0Ub95GguaZRX7iMew5UZsgkcn+uISX3mWUbw+73zNF4jxGVsH1T/pXfEoY
	ODNCsQ06pIFW0W2jXrP8Msv6qMcGtgCaS0NeDIy5AmTsqUvQb8nOhBo9gvwUkWGi
	eqnYZjGmNv7RYXZD7JxpHOOExcAWIYBDWPdPnN5kRDv0baYEDp/9rzew5pYTrK+P
	Y6sGu+yhZCxl9bzstnV5JYCUfcLFOFndlzvuTPQqSZL6jKJHpXGfBKYQV1nCcMAQ
	sw2FqGhWRVVZwjXJk2uIlW7hB1m3tzEXb2aBNOPGsAs7FWOA1U5er9L/U7mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754290299; x=1754376699; bh=+EPPmelWzupRyLRm9a2oUiC+1MjZuo7akBQ
	9a2HlrPA=; b=hT9ZxSUh4g8NE7o1i1GgvaQgW1FrQ86IsWyrEYLlrq0ZNB6yLkk
	L7xiaGL+MGE+hZe/I9cMhuE/CtxWuIIPofH2wyxeiL1SyNmwEyTWHzmS4taYfMa8
	m/KfzpXsc02BUaJAPFAHwtBSSsZQfAJnjzqiIbLEwELj0jkN1VKiNavsjjtmHohu
	lGjjVPL2RDKife2ZMYrP/vrDfZIS0uVP7ycbDiC/YdqVLEg/UBYPIu/PLDiCTLr+
	zFm/hvCSMsYq8G3XHUJRsCSNppVwFLjzM7IaXZThTJ6ES1J5EfQkxKPkmWbbMxbg
	UuyBtabgtwaBszEML57psBCRFJF+J/gDT3A==
X-ME-Sender: <xms:eliQaFRhKV0TY2wTGQdWKSOL7KjqGSyBVyalxcdRgUqQ9BhTsW9D1w>
    <xme:eliQaHNDQ7LrId7WilRUDHQlfoqJLxvsoFGYdgfuYo0FF4Au0Dd0vBadP115N9obg
    D0Z8h59XB4oP9PjqA>
X-ME-Received: <xmr:eliQaLR5LiGXY1uvCxpn86DayCDJp8pxJ9pbMTsoIep2v40qDSBOl-qcpWrPJiGKjfMpBnf7HnwfdDrDZNl03r_Y7yV2cytnnCYZ8M-gcak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhhtggrrhhltdekudeg
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:eliQaNhYh5IyFtDPkaLcZif3t0GIqdSodCJUy5zQTiaVMfxtt_T8Ug>
    <xmx:eliQaM8Cw8P3cnxuG2kdtFxFa-50Z-TSAGGMlQM_IzGHzO54ZQUStQ>
    <xmx:eliQaMGiarXVi6F31o2iIUGnfefd7f-uH1XZmtJM_OWkchfTyfSo9g>
    <xmx:eliQaHm2WnNvi58cOYDTKbNIujxNesIQN3n4avUHYVicmFvNA8Eglg>
    <xmx:eliQaLvB9aItAEIUYzbD10De_wD8tqzYlM6eRyPWt_tSxL7Dxl7iofaN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 02:51:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67e9c1e5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 06:51:36 +0000 (UTC)
Date: Mon, 4 Aug 2025 08:51:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Han Jiang <jhcarl0814@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/6] builtin/remote: rework how remote refs get renamed
Message-ID: <aJBYdBqmPtfS-ocR@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
 <xmqqcy9gqiht.fsf@gitster.g>
 <aIxJrvqLvEl8qM7V@pks.im>
 <xmqqpldfm1ps.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpldfm1ps.fsf@gitster.g>

On Fri, Aug 01, 2025 at 09:43:59AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, Jul 31, 2025 at 12:15:42PM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >> 
> >> > The series is built on top of e4ef0485fd7 (The fourteenth batch,
> >> > 2025-07-24) with ps/reflog-migrate-fixes at de7cc0782a7 (refs: fix
> >> > invalid old object IDs when migrating reflogs, 2025-07-25) merged into
> >> > it.
> >> 
> >> I'll use the newer iteration of the other topic that ends at
> >> f0fde561 (refs: fix invalid old object IDs when migrating reflogs,
> >> 2025-07-29) instead; that was what was used in the version in 'seen'.
> >
> > Okay, makes sense. I'll adapt my local base to match then.
> 
> Curious.  You had sent v3 but based your other topic on v2 and
> expected the result will merge well?

Well, the only reason why this series depends on the migration fixes for
reflogs is that the renamed reflogs for a remote would have invalid old
object IDs without it. We basically hit the bug that this other series
aims to fix.

There shouldn't be any textual conflicts between these two series.

Patrick
