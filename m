Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B401DBB37
	for <git@vger.kernel.org>; Mon,  5 May 2025 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429766; cv=none; b=Anq+J40gXpagb6Ayk+83nCQq/bOVfWDAhUC4s436XT9B9JIPIZeTAJBKmh+WdVDdEs70sq6v+RkDV+5uYqmXxW1uELztkWXxqlKrPHvchMxQ/C8TUhl3msEuIcBWf6wmzRDvt0y60SQrrjzhhWkhHyzVX2LNKSWTbiDmOGi1ED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429766; c=relaxed/simple;
	bh=HHQP34O+h7rYFHy9kVtS9ElsHL+Q553odGfp3F3M0DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHgpDF6ahyftN/vMztjNaW35Dx4h5hpvNewZjra8fCkc1zGr4eqZcQTAdO/+np1/CSjdbQrX0vzyVvvTh9x6OoKkb2udYcCmhb4gMrQvWQDTbYABHcprM0sFMn0/8wzakDuIB6oyBtlEXJ0e5LVDwyUweRYZvy/QA0VrmwPbk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bEVMAjtR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NaouQ8Hi; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bEVMAjtR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NaouQ8Hi"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0A34211400CD;
	Mon,  5 May 2025 03:22:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 05 May 2025 03:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746429762; x=1746516162; bh=N1PtxpMGpC
	cx22pnwR1ke6ACDVFY87bP04tdjp+fjOM=; b=bEVMAjtRZ8d5VK9Rp9gTei6BTs
	SMhuU1Zao3ox5SJCaJOLHGpsuC83bKfUQncg+2kc1s8dfJW4nZGq+vhizVWzd0Xm
	AUu49OIaE4z4X7I2qzibJ5msDb+G8Zw5pB+TV5zoFkt6phUph4g7PoPBTpUnxKoP
	rVFKyxOW9MKb5VoQq3bLY9o52T6JoG9cgZwqLCWGy0tsTqscvEaXSDPPIWTpTEIB
	YmIhqPr0O4b40BJV8dpmhrfXtK21EWfsUdEZVIAMOpCoOfNnzFuAqEPpHokOeneD
	eSCxXJ0VRnLHG+SouTo9Pe0scqK+7hbbNTWwoHK6bxiKz+c3DF/lC1U1ajQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746429762; x=1746516162; bh=N1PtxpMGpCcx22pnwR1ke6ACDVFY87bP04t
	djp+fjOM=; b=NaouQ8Hi+4LbFsHwC9KbyUU0iFR5vLkMewIuY7Qr1sv15QoN1e1
	K0zGHZcK12jx9A+htk9NRGTbb298ZHX/OZm7tz1AQAJ6wtMU+FWAnKO/FKBjCUEG
	UBVA95UtZsVNCK0/KVIHSgBV0Q0cUXchWjlK5IPxejvyNdnfMa8ZbRG8lEqAfVUf
	Z8KGyWAo+EUGXVQU0xAHl9sD5R+sJjpoIjlcK2hfapKI7eFIoAriNKHW7kRFw2GH
	rLP0uQYSPvtKi0+ug4OZPTjZNA5ZOI1giB0RUxN5wCByRAvr4A0mN10FOmq8tRAV
	Pq8DFBqdvzz2XNURjFP0UNRLqED4oo/tK3g==
X-ME-Sender: <xms:QmcYaKJzOwvSJSEot5J0WGWXi-vlkWSVQm4mq1ghfm13tQxdsow4PQ>
    <xme:QmcYaCLkgY-izO7NSn7Pu06-q4TrY024c68FYEcAWwjt-tGwkl5rOONM1L51YHc7M
    6yGnqaLqwzMcaHtXA>
X-ME-Received: <xmr:QmcYaKsG_Y8q5edQ4eNCGrGdL9p29T7NC-1eQx33uVA8RUL-FHVmZ52A3spOs6PctEk4_zsV02LtoZG2vODo1T9vrTfs1Xzo7rIeGTGUm0ed2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepudetleeijeeihedtgffhgfdufeekhfetfeffkedv
    kefgieeiheefveekteevieehnecuffhomhgrihhnpehrvghrvghrvgdqghgtrdgruhhtoh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:QmcYaPbkQFcLEFTCzt5515C85jUjKKnxgJknKSvfsJuCQfW0i3LNGQ>
    <xmx:QmcYaBZFYhdrGwHd3pmBQCTKJpSlOPt0RhvwouM9jQeeo_XBE5pSWQ>
    <xmx:QmcYaLDKF4Qo1jSL9qPfeo0izuB6n1AE0VVaatEM5NDnt4NdBSmtlw>
    <xmx:QmcYaHb-GIvipb9ILXurAMnwc50HEUiMzQZrcd7ZTcxrfXlsiHYMBA>
    <xmx:QmcYaF0OpU_AGd3SByz0U9nyrXBGqnP116ouJCTz8J5GYq94-KqxiibN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 03:22:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35cf3abc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 07:22:40 +0000 (UTC)
Date: Mon, 5 May 2025 09:22:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/8] rerere: provide function to collect stale entries
Message-ID: <aBhnOiHgfycVJhHQ@pks.im>
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
 <20250430-pks-maintenance-missing-tasks-v2-6-2580b7b8ca3a@pks.im>
 <xmqqy0vh1t96.fsf@gitster.g>
 <aBR9R3PxSCuLON6G@pks.im>
 <xmqqwmazug0i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmazug0i.fsf@gitster.g>

On Fri, May 02, 2025 at 09:35:57AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > We could also adapt this to be closer to the original version, where we
> > only verified that ".git/rr-cache" exists and contains at least one
> > subdirectory. This can even be combined with the above approach if we
> > set "maintenance.rerere-gc.auto=1" by default.
> 
> But wouldn't that be like always running "rerere gc"?  What would
> you save by checking the existence of at least one rerere entry?
> Cost to spawn "rerere gc" as a subprocess?

What you save is executing the rerere logic in case the feature isn't
enabled at all, but also in the case where you have eventually disabled
the rerere cache but still have a now-empty ".git/rr-cache" directory.

> Wouldn't it be a better use of the engineering effort to libify the
> logic of that process and make it internally callable in the longer
> term (or are you already doing that in this series)?

The logic itself already is quite encapsulated, but I decided to not use
it for now because we don't do so for any of the other tasks, either.
But I do agree that we should eventually refactor all of our tasks so
that they don't need to spawn an external process at all.

Patrick
