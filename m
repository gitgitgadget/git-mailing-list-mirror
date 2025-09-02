Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D7270572
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803029; cv=none; b=epUg2p++rzjPLxGvjJabvn8izNRoLRnwgSh0cxWAnvz/3Quw7RgBN+bxC6LjtmHoyOteSMI3eGYdGdao9RDUtkj0bGi0qNS/QGp+gSPvMp1U5Z8vKeRs7OeA38LCOwhJEdcJe4fp9j6oxLY24E02Ie1JTh/9xUaAtmjPT63ux08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803029; c=relaxed/simple;
	bh=0wHUGH52psTADI6Au2K/KgliKgUz7ZghwgMTW9lnrpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG2+CKDrftr6fBsrUWlLM1Mpjvr/RPVhimyFsWqvjv6FMbB1aRJ43LSZjNz4cwjHE2/E2+hpoPTRmq3HgjcQC3GtYfcHWuKj22fCFeQ59bZk5laJ5T0DsOYt3eIMU7Any2fjE7PkW+DMzA58mg8P3xuSd/pAjXXQ5Kuu4B1eReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y55fTai8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hBRk9r7a; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y55fTai8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hBRk9r7a"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id E14B6EC054D;
	Tue,  2 Sep 2025 04:50:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 02 Sep 2025 04:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756803025; x=1756889425; bh=7qedHkuTyX
	KJWGbBaX8RoO8mmckC9bw1nTIkOcI10a4=; b=Y55fTai86xuBdq6RUYiCr+ZX7b
	nIxWfSxjZiCQWwD3zjefLtlqFp1mMQ9RRT8/99t1Nv/hBU8BpO4RrgxL7kQBcQX7
	ktHz2q3MQr3eu/jB77eIr+kfq6tfB3NRReKMwnxgSfkJOPH0Yu29ig8nPS+IaNGe
	XRF8dr1rYiQWLZW5pP04lx+Wd6oyHfYo/IQqZv1D7Qax//VJFFh0vGoWj6dt6fdn
	qadJnZ05yy9cjvHuLkDoAWpfaboQWy64ONhgtaXMkJnAItVskRlwUvB96JXj2Pt1
	LmOCcwPpzufvitCmo0W9NXtcG3v2clCmRe//p44832i7jhOqsxi0wsKIvcQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756803025; x=1756889425; bh=7qedHkuTyXKJWGbBaX8RoO8mmckC9bw1nTI
	kOcI10a4=; b=hBRk9r7a4o4Fc4HWKQXqqnTyO2hqQRoCq0WqjF7PJE/6nZEsdYa
	vvYpLfyjc27JByG0gUagFEoH3/T33mPGw/9EeAM/p9gPtphMnSKFY+CPbmCl3VOX
	9uwGtMOUOv/vsy5DdNeOnFLFq3pAMX6r6P6uUW6XoJfS7wVFwRsuP7gn5kFOBG00
	p3m3OVb4QY5lg9zjRiSoh9rw6/a9251XblxztkVzvCBOWg4tF22gGNmJLlTeO9pX
	qiraD2fUZkjBKYdjrGgJdpuX+HWHe+LV+1MKnytGl6PuEpfvJaiue+6T8yHzrlOn
	ohZ81OPl9LaIfFjW21eZRcyGb2vj2zllDHg==
X-ME-Sender: <xms:0a-2aEgPI4XvpM-w26qhMGzOlYi35sBNhK2-i5_Udhi9Mw9aY1j0TQ>
    <xme:0a-2aHk_8iODbL9_Djkx019iDZThXiQZzfTGTANvWTIvxAucUu66SyAtcbaQzQRpE
    R57nNUci838vvxgcw>
X-ME-Received: <xmr:0a-2aIrK1z1FzI7nbwjfPxAJubPbFQxz2eMlDGSXueBav7-eg8gJtIfqOGXu0D-vBarPaBtGClh7N0NELntXBKnqGKskdGAu1l12Eoc9U-zptw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0a-2aIFuUkVkCBM4XQ8k3fLhk004fkjP0Hb_wPqyfWlIJ6yEWTgReA>
    <xmx:0a-2aMxA454euYmXOWb5_WYw7fyST3yRNE1q5SooTtLWHJ239Ilxeg>
    <xmx:0a-2aFry9P4NMWvCpEj1j9A666ONW9S-G8idzzptk08ZzZg2bzatiw>
    <xmx:0a-2aOjyLDIro08dduFbmFXsNPIV976R3y14CjKCm2tQpDjntsImpg>
    <xmx:0a-2aB4VR1eySgiAfeg78pz2Z5rbZtnEn1nJf6r63j0EQFrR5N0tbmLq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 04:50:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb3071c2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 08:50:21 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:50:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 06/16] odb: move kept cache into `struct
 packfile_store`
Message-ID: <aLavvRW6A1bWP__1@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-6-d10623355e9f@pks.im>
 <aK0R38bfUSzbnlb5@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK0R38bfUSzbnlb5@nand.local>

On Mon, Aug 25, 2025 at 09:46:07PM -0400, Taylor Blau wrote:
> On Thu, Aug 21, 2025 at 09:39:04AM +0200, Patrick Steinhardt wrote:
> > diff --git a/packfile.h b/packfile.h
> > index d48d46cc1b..74cea1a4a9 100644
> > --- a/packfile.h
> > +++ b/packfile.h
> > @@ -64,6 +64,11 @@ struct packfile_store {
> >  	 */
> >  	struct packed_git *packs;
> >
> > +	struct {
> > +		struct packed_git **packs;
> > +		unsigned flags;
> > +	} kept_cache;
> > +
> 
> This wouldn't be a bad time to add a comment here explaining what the
> kept_cache is for and what each of the struct's members represent. We
> can blame (at least one of) the author(s) of 20b031fede (packfile: add
> kept-pack cache for find_kept_pack_entry(), 2021-02-22) for omitting it
> in the first place ;-).

Good idea. I'll try to puzzle something together.

Patrick
