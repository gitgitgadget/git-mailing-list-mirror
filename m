Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679B43637A
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320404; cv=none; b=dCa+p2ykAzZF0UyfM/43+INxKoh0oBkA9Kd0DJDzrRJdqxQ++x78ekjHZkJKyijRyTyBADHtkz023xwEp4e0Gy8mOxOgsvGr+1rfO/7DkFUVL8UcVpiG5yzRhjQRCsvoO+uyDz3FSCDHXM9gd9M866NbcUVu5gmhZH1bgtjiNRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320404; c=relaxed/simple;
	bh=G34KVDPblzQXYvxPxe/O0/HVu6i1RLSr7SPG+18kO+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4dCDrInVCQCjd/atBI4+Z/TR0wduayBArgF8doMagwSsW5hw+nM5uhDbjNylToYdC0W163AtLom3F1BNCBrNQwpqj4wSEJtcV85GFLD4/0U9LwinvRlydzpovHXihlwRnOSDtoYH9pMSoM2+ZFSUrdY48ORDZ7r3WFRJ4SM7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BUYftc2A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YuMyYli0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BUYftc2A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YuMyYli0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A6D067A00D1;
	Mon,  6 Jul 2026 02:46:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 02:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783320388; x=1783406788; bh=bnxh78FB7B
	t/Dg+nO7Jfjn2Ts1WaghEIzXIWqJnHGjE=; b=BUYftc2AxeMdClX2RXHSJp2v9m
	1JIaTrTHT/ak1fyY9asdZzf9f6GsjQscAp9RietyfJNk8iZOsUSPQbg+/17vNpaK
	3Zz1y3hZdVRQlF17YUU9pDFO3FHfdSm9tBR/liRxbRAGlx90cOFFiSCeVacNSzAL
	tB5mP477d0sFoUVc6Bh5gUT4Qj6/Q1MWos9rcS15zUj+7cwQ72Z/QsAweMyf/gBa
	ZtjOK2H2Dh7I7WAx0EI33qdjJV9frrObPk6b4b8P8IpHlhkbi+FwRs8YNVa94m72
	m0xoeklsRr3txCxa5zG1Ex5LxB3++o4sW8dVty7EPep08sazHlOpmdFtYPBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783320388; x=1783406788; bh=bnxh78FB7Bt/Dg+nO7Jfjn2Ts1WaghEIzXI
	WqJnHGjE=; b=YuMyYli0plkLeXr/hrzpVkLdx/mHEP+b1W8JTOkZ9nLeUr4XrLN
	KS3a8fLaaO6KoFH8PQBppnGrE5qU2Tvp7tKVqXiFwk2Pnk9Sgtl616IdLew/3A79
	e/A2e9WQL/682rXDUCHokaM2ChCK++WH8tmlfFNhqfgtVNI5Cuu7tSCB1PlnMCeM
	+5l25XZoK7lMFkedtsTzWiMwSn4SybhxIHp+Z8SwPYpOqajLskVsYJgLFCblsYOd
	pS1oAjJKh+wqK2FOlT+7AEinIAVODABgqT0qrTA8FYDGdLS27ZgNnv4hZKV6qu4i
	Ck2NIEY6Mnl1ubYv2iNe3UzARnKkDvhy18w==
X-ME-Sender: <xms:RE9Lalsb_-1OwMsltcxl8YKejWxnEnZwGWp-tjusdzfucskoqVasOA>
    <xme:RE9LalVOQ8WM6iLxOkgNFF587UJM4TvF1hkiDaIEgsZy0DSG45xu_EP4coQ8b0Yzi
    L25ORxm8XdqzOdrwTvKUdSLecZFHw-DcvasX8N_C3MStZJIy03MGg>
X-ME-Received: <xmr:RE9LahFLdwW5iUXy34giPzzs6EjMuez2fTi5OvO2eGddlRh9DQFhcCZ7haLon9_k0mrOXbbU0MyPoggeE3zG60awaar8BTR95yM4S41bztI>
X-ME-Proxy-Cause: dmFkZTGFKrt8GDxpPqF3Ftka3r7Z7RUYMxENTA2B3ASQ2g7wEwiluZ9pCdxksxLEfhnisT
    wFFMxtSZ28MvdwAVJDJlFzLUrx6/+xC6q06+LJFaM2P72W1nuZCLVBZ+gteTUXtb6RjZ64
    Lk9OaQO8j/lfZI2vZM5/oHiqYRph4cnvCHekeSRcq1YVU5hRjxnQyksSmYNkBTcRVuCd1W
    GCZmwOmVQg9DtnOH1FzjCGKWwJpwOrBpzMCKgG2RukQr2o3tuTmZsRHBJPpGjnEAaRTsv9
    8f41Bp9HWR4OxxpeUxy/oUF7t23lIQwZXMv0stM/dXQtp8XaYb061kShKLJWAniHEBJuB6
    RsZG31ET7YmMmQ0Tp7mcRWDYno0s0H0BFo+CsvewRLeLKaR0Cd9onc8/U9wPZgGCHNJuiO
    ZanfIfg1p/Thy59DkkTBCMtiHIyb57bFzKo/hBjietjIVZ6oT+dN5tWO1W+0BIDE7ZH5X+
    itqYbSZxv66kRCsfImqgefkP0Lr98jy0vTVTDGGxyNjX+DWO0xDCRtYVIKhFE9lI99wGVW
    uFHHTB+NQanLBb/qF2b6bZPcdCA4kAlBgqwrvNGo7Ebv0PpC80rMFCUX6aeNNlXpqclrkS
    J/5DsdaOptbL20oVh0+saPBVW5HG3Bu55cg/tSmBtjtXhIIRnwvecNfest2A
X-ME-Proxy: <xmx:RE9Lan1mifhfcrPBYFGgmXA6cZ7MIVfYIpnG-bXBkKNpgLGkRL_G3Q>
    <xmx:RE9LajOu5lqgAMGJf0MQwSMpVMjbq_yXPX8Xtl7fiEKPyBi2MfyxUg>
    <xmx:RE9Lam5Xusm65A_oM2JLF5FO8ocyS6mCEftUdamcG9YHH5l-PAlOqg>
    <xmx:RE9Lat1VhaL5MpQaPWHR-wmeCUHw1zYzyK3HUkzWiqv7_-AN4f3jVQ>
    <xmx:RE9LagcwZ2xl8_wQgHpTIsSNkii5j8Pjl7PcnorIM-fYDqH8gzdNl12t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:46:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5bc0a09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:46:26 +0000 (UTC)
Date: Mon, 6 Jul 2026 08:46:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Jeff King <peff@peff.net>, Michael Montalbo <mmontalbo@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: weird quadratic reftable behavior, was: Re: [PATCH 3/3] t5551:
 pack refs after creating many tags
Message-ID: <aktPP_aRI5Xfo4RA@pks.im>
References: <akIJQbOUbdBbkTef@pks.im>
 <20260629203527.GA1895313@coredump.intra.peff.net>
 <akOG0oMu2KTqqyW7@pks.im>
 <20260630234702.GA3759976@coredump.intra.peff.net>
 <20260630235850.GB3759976@coredump.intra.peff.net>
 <akSxCUfm2P7ocLJX@pks.im>
 <20260701080014.GA3748390@coredump.intra.peff.net>
 <CAL71e4PfXA-ixKR6r7fu_7_QmdzK+rTRs29mOsUYKaq+_a5q5w@mail.gmail.com>
 <akTm7BDohsy85sN8@pks.im>
 <CAL71e4OavgfXtjN7QxkvmctS3fTpb5MtDsi-iUg=2izZCG5yxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4OavgfXtjN7QxkvmctS3fTpb5MtDsi-iUg=2izZCG5yxg@mail.gmail.com>

On Fri, Jul 03, 2026 at 02:09:45PM +0200, Kristofer Karlsson wrote:
> On Wed, 1 Jul 2026 at 12:07, Patrick Steinhardt <ps@pks.im> wrote:
> > >
> > > I can send a proper patch if needed/wanted, but I might have missed
> > > something silly here.
> >
> > Nice gains. I certainly think it would make sense to polish this a bit
> > and then cast it into a patch.
> >
> > Patrick
> 
> I have a small draft here https://github.com/gitgitgadget/git/pull/2166
> but I am honestly not sure if it's worth submitting as a patch - the
> change is somewhat small, but spread out, and I failed to properly
> reproduce the performance win in any realistic scenario (I had to
> disable compaction to see the improvement).

An easy scenario where you don't have to disable compaction would be
what Peff posted: you create X references and then delete all of them.
That shouldn't result in compaction and directly hits the case that we
care about.

> I would want to rely on your expertise to know if this change
> would be valuable to discuss as a patch at all.

If we can demonstrate a significant improvement in the above case then
it would be worth it, I guess.

Patrick
