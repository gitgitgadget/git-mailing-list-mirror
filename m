Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0D13B5B6
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274042; cv=none; b=sV+1L906FYhohEzsnmG09g3Gax78L7yOReh7hcTEo8YD3cqAGDQ8JOJkGBiaKD+Y8/9+Fn9dZgzIOzryuDLbYpAtnGDVZjrhmFva+7XiJXWCxVY7GrtJ87yYR2Gy3t+t5SiF9mU+wgTZaq+PMoYHlyBkSEwOel78SilNOIkCzBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274042; c=relaxed/simple;
	bh=tfGsDdwA4gr9C154jiuqzqW5jnEHjifMR0zeOfTH9r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBbN+SCT2ukwUFYbg3yiOD0UNcG8afpQ2guWKc+20wOFgPRJn6RvLteYBu8AYt3MYPS6On8hkV/8JqlVNbvsS2ZcW9OOqHNJH40ez5h2uZMYq0+FQYZiuBJBDFULnjL92TCcGKtB/7iznXFU74AjzERjvIrUhl8nlhjo2F4rxL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lc8tcLYs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j1gdw9UN; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lc8tcLYs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j1gdw9UN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D699411401A3;
	Thu,  6 Mar 2025 10:14:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 10:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741274040; x=1741360440; bh=g9fccyrJ98
	5Y8lpJnT8xZD1FkXRp0k6ITcluO1U4w8o=; b=lc8tcLYsnKlIijXTpdj7HcLOjM
	HuIxlADz74sdXJg6eCTXPWRRZ2Io0Ual9CSmVyXRVxoV1CodxGGbnxdWuhcsrAqZ
	D86qVrEXSeoyUOH6KTCHj0Dn6H9+qpiKkLk6of1jZQft5QbS1Nr5+R4mZmpfhCb3
	+Is5DXqfnjKT1IiuLRHLYaNLFREIzjY4tPo2Esu+H5zq4/P+XRbMi8G4s+lidH3T
	SvtkoPjEbbP8JCa2Q6h25HjqI8tqPMjdfW9yQU/xif/rCYbFaWVq8F0voX0z9v4/
	JPum+8DfDyoqOCsdKmfYFCBdIcZQOoRu4Y9xzEehv5TQk50kWLr1G2pJCB7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741274040; x=1741360440; bh=g9fccyrJ985Y8lpJnT8xZD1FkXRp0k6ITcl
	uO1U4w8o=; b=j1gdw9UNHUFnIP9cezpc53hBrS2Q9+HlIGojIHvJwmelPPyrrIS
	fF5bm5kjfV9nRfwWbxIchkreu07NwcXjtVrUvY67AOXdnzTyFHfZymMpSFjZSlWU
	zlo+1OiC15uq10Y3QJKd6pqpSZM6Oikg9r7LpBs5EzjltvjFdxaxATGttkSoNvcj
	mNf3cFe06pPKNw/4xxCBUJAOU6O7v+iqdZSH3zsdIr+zkVdTZ/NF9w6PPxYU3ehk
	j91jhMSHutqEEuELiguSRak9nAMIOBGMTeVaBDK7GRmZOQ5cbNKgH5kVizAVSo0C
	2J6MD93MaxM40JCknUHG8vEVWlG/jsXmvEA==
X-ME-Sender: <xms:uLvJZ9ULv8hz8BQp4cBLrOPURwrnhBfWuiZ3XkZYaH4uoErAiIMV1Q>
    <xme:uLvJZ9mDSwQUJ-n6GwG8E--6hjd5HwXeqc_HTy3V0JrFrczLFB3otx1qEciUBUmGS
    a8TR9p2pBlewyPzCw>
X-ME-Received: <xmr:uLvJZ5ZxCF5BmBq5E10mSNBRDEZ0yfHIOr2AnJtTp-aIqaMPkiWSbBQF_hcb71IjyDpZIpc9zTgommpEjzvW4o2ZCV6Y50NuzbWCLHq3bDtb2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghr
    uhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uLvJZwWN0K749Ve81bH7FTG8Y2EuNFfdPho5QOvqXvHBdb6J8vApXg>
    <xmx:uLvJZ3lNXmDnlxUvrRPFTXTLFGi-L_k2B6ycAuuiSgcs1LnVveJnjQ>
    <xmx:uLvJZ9dONJxeY4wcZ6T78oCAs28cF9YNh09V9ikh3IpuEBBUiZbqjg>
    <xmx:uLvJZxFN7BM29bWCpo9JTXQKGv3oFEkL-A8IgF6px1hcYfn2pJGcCg>
    <xmx:uLvJZ1W28b6VNmoMebka8WfveDOFg5Mq6hDZgYdzWdrWWKJrjk9j4c1M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:13:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56effbd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:13:57 +0000 (UTC)
Date: Thu, 6 Mar 2025 16:13:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 05/16] refs/reftable: batch refname availability checks
Message-ID: <Z8m7s_tyfro8VaJU@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
 <20250228-pks-update-ref-optimization-v4-5-6425c04268b5@pks.im>
 <CAOLa=ZRUxYEOgsMOJCR1WGNFtkP2NU=PykRLCqYvQR=EnuUbUw@mail.gmail.com>
 <CAOLa=ZRg=qUV_9kZpUnx=pJ6nBhrPQjGaVHQRjwHSa2omx93fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRg=qUV_9kZpUnx=pJ6nBhrPQjGaVHQRjwHSa2omx93fw@mail.gmail.com>

On Thu, Mar 06, 2025 at 09:12:41AM -0500, Karthik Nayak wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> Refactor the "reftable" backend to batch the availability check for
> >> refnames. This does not yet have an effect on performance as we
> >> essentially still call `refs_verify_refname_available()` in a loop, but
> >> this will change in subsequent commits.
> >>
> >
> > I thought this patch removes it from the loop. Which loop are you
> > talking about?
> >
> 
> Looking at future patches, maybe this 'loop' is a reference to how
> 'refs_verify_refnames_available()' still loops over all references,
> which we start optimizing in patch 08 and onward?

Yes, exactly. I'll clarify.

Patrick
