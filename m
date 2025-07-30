Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D790F8BF8
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 05:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753852879; cv=none; b=RGPeXrN2KwLnghyJChvn1R3gmYIKsgJ3ULlbJzDuUN0KIlCrJ5fJm4bcRfAlrMkZ5i1mjEgNOTcLLTtFJpWWtKq10+5pixXN2Ad4UNs2X14+YtFmIRxNNpZedNxIIoeh8oVC4yxersWKIsBGPqY+33Q4c/AbiGsPTCkl2m5dpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753852879; c=relaxed/simple;
	bh=++ZWRYbD/amAK2xgsTA7E4Lmxak9HD1X/jFv6SPiIJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9kmXEDBdVUnOkKzKVenoGhSwP79Tvfgdqi7+vsuPIlI7TlgmWWzwLgvklCrO9TBuuMwx/B+7zB7yL+CbCgP5o7B86npffbhGAeRxtMzjjQ0R0TUMoReMIOEXKOrMBaAK9DBMOsJLg8xVkyo+uiMnz6N0NIIUNINgNAc6a3taYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e+/G2YSR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nUvg+ta3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e+/G2YSR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUvg+ta3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 810D81D0017B;
	Wed, 30 Jul 2025 01:21:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 30 Jul 2025 01:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753852874; x=1753939274; bh=UABkWXLSn3
	tRVl6j/jngGzu213yVM4VQ5EDKXuXtTXk=; b=e+/G2YSRgQfk2ZoHbotwwBd+HF
	xY05yqxU8rsXgShQCAxGPE8hn/XsAk7CRdfUC5e/cBQahNOlmnfuyIic4mxU5SG1
	jZ5L2THLmddCUv3ZMiyQh5mjfWjCEfm3DldkHfJodFC+o9/iuAg3LjfUefu9EYpr
	Dtuq31GvXz/V2VXC+lWBdKL5T+vo46S+M9fbjcvJzG+p5+Htjni1V82TXdDIJ/LQ
	6/BcYXSNuET+ng6/4KV0Cu3RnHiJ4yVXXj/OXpJ6/VSL06nAxua82lSzZROAong8
	ni40bBaHM/SyjQz19AUKTzM6UXlUHosNlk1CQXad0pHiu6/SzAUmSDpV35Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753852874; x=1753939274; bh=UABkWXLSn3tRVl6j/jngGzu213yVM4VQ5ED
	KXuXtTXk=; b=nUvg+ta3ckdlc2+2Pgkk5WSeDkoNemq62aTB2NjBDGrwaklYOVn
	vPhDveVwwzwfIgAqvLFQQJxbbdYiIUs17E1xQ1mju0IZg/LxVrg9R4oMavvJipOy
	qeHUJIf7O7ykZtOc4pjEo2omaof3xXI4UPFTSYYr8ux1S2f0VLeJHhDM0KgxdJ+v
	W3EGnGZOH/mJ4giof6CYCu2BIKj/B3u+EU65dhYGdIR7b43GMJDyBZHAxeUiZT8k
	8Th9tXVj2jdu/kAzxxGqwYSmBdLtfe91QQO8aWLIIHsC0fDqY8kdzul/ANlKKdev
	pL+Gq6a4XGF+KhxLO7pd4NNeg6piB+uxjuA==
X-ME-Sender: <xms:yquJaASy7G94Whu2bphX-aTlPZ0A8ZxQyxPYRFl6kcHhjs634RNJig>
    <xme:yquJaBBs5Rdu8Ox6VHN6K955gaKDCJR83WtYzB4qvdliBAV_-4qLwMuzSHk7gnHY4
    SgmlT3Wwecv_lwLHw>
X-ME-Received: <xmr:yquJaHTmT7P28i3ZPvRta1fBkiUMlzPwCaTX2oI7HsddTiEsLcU6qtvxSvnA84d-iQtx_ZsDmTYx9qFwgUNRzIvA0GuAIQFdRqJLCpYT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:yquJaPrSYpd15LvU0w6C-UcvKvnkQlewdfJ4gXPpbFeFjl8dGbbJgw>
    <xmx:yquJaJzxqZODafYn-nfiCdMGBguzcl-H_5NyejnRey5Gv2QhcYuELg>
    <xmx:yquJaEIREQDo4CLJ1op0wMS9dybmyhEV3nW38O6U4s8cAnRv3qr-Vw>
    <xmx:yquJaLJlzOT018EgnxVCVrnRwRDetvhvtqqr-Az-OygVpPs_2AteXA>
    <xmx:yquJaF1j4WwhAGJN3gypg0PaPt3hZH_Ahk4Ktp15_-qTSLUvALN6bnd1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 01:21:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b27429c2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Jul 2025 05:21:11 +0000 (UTC)
Date: Wed, 30 Jul 2025 07:21:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/8] midx: stop deduplicating info redundant with their
 sources
Message-ID: <aImrxAk3PGdUSfYe@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <xmqqwm7qonhq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm7qonhq.fsf@gitster.g>

On Tue, Jul 29, 2025 at 11:33:53AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > this patch series is a follow up to the recent patch series that started
> > to move the MIDX into its object source. It refactors the MIDX subsystem
> > so that we always read and write them via an ODB source. This ultimately
> > allows us to store a pointer to  the owning ODB source in the MIDX and
> > thus dedup some redundant information.
> 
> "Stop deduplicating info" in the series title is probably a typo of
> "stop duplicating" (which is the title of the 7th step)?

Oh, indeed. Will fix in the next iteration, thanks!

Patrick
