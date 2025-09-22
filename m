Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24363112BB
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557764; cv=none; b=SE3mAt03Z9nkUQ5z30mdGK61e1tlDX/WJCnAyjYAGlxJyzltKbse7ZwpHSqjEEf5gv38UdgRqyJbsj/UNzBqMh+byE5ct8d9kKXG4KyHNiHPUZzrO2ljL//mRLDtcQkT34k91QbeUAs8v8GItCrmov//onaMb0M6Gz9igkH11es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557764; c=relaxed/simple;
	bh=12QvPj+XGogzbA8aytkmyB73yrVL3XmFScvlkGoM4fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdNqn+8mO6U9ss16AqGfFaYGhKVz0PiQjt7vmX8EA9F0ujPeVXQU1o0slu3mjqRxwRyP5wCll1ZKrON6DOb1uejH44ObXt52Htklgp49cKnL4njHMO/hA4lPsuz8mUg49sSR89oiAhAMXu4BSCW45IIZFQrI5GqUwch4MmPWjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YVNDnILq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fcdxepdk; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YVNDnILq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fcdxepdk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C67EA7A0149;
	Mon, 22 Sep 2025 12:16:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 22 Sep 2025 12:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758557761;
	 x=1758644161; bh=R9XESX7+gtOGH2POjrway/DHvaLl1y9bT2LNQKDIWog=; b=
	YVNDnILqAiraf5mnZiyvrgAgyigoDUAFIZ3P6DMtSc0PQPK/tjnvBU3MQJSrasRr
	3tnISBgcBCPp2ECSEodr/PPFnims4mshgg0cqDr9jdeHbiFwlPufuy236SnxU7d9
	u2LSv7iHJbrjFE5/Y85hpKcJ4+LGBdzkAfTFSCnNiqtRGhA+DCdD65hztH11GuGT
	aAWPSde0ZQiD/eDK1PRRFw0DnuejXnSkIqVmSQpVoXroEBV1wqrFHKP7u3ey8RyY
	Do4G9M/NiRDxjcyIyqdCdqdKkB2GMKxiscMC3hSEX3j1B27CZrtpVTK89QMpKGLZ
	y+WUtwiI4Y02iE0wQnhv1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758557761; x=
	1758644161; bh=R9XESX7+gtOGH2POjrway/DHvaLl1y9bT2LNQKDIWog=; b=f
	cdxepdkEF2IWSxIgLl03PdmEVhSRJ6fKhkr/QhsFXKBsoUgpVSjwtTfozfQvF4/e
	ndfXKjALz/qYsDiu2VtID3SiAhgNHCmouHZSErPLzXCjAAsGTNxTsLklgJ3aDckS
	gRnA+0InabMj7VZRri0028F25lcMwuNdlu0cpbcxBxzx1W5peOTp4ofkp09v7y2G
	E65xb4jyqOZAhONvcKnBlRBe7mer2ZD63wuDBEaUXCLSxhKZtkzYIRMNWnll2DGW
	R/S0PcFsEp+XssZEaetIgJapKDXf0ezrKta9NFH2RVwoTHvSjvV2ZLx5xc/VYAvo
	vC4385sLGbHeGZyZ0TxNA==
X-ME-Sender: <xms:QXbRaBZaykYm9Fg5nNSAR0qTSLJPBvLVwy6-nTP4KhE7F5JtJpbFqw>
    <xme:QXbRaPQFjSxOHtraCb_9vZyRobJe19tI9jtu-oFjMbE8jKZ7rRWiFBNqaGYwpeck5
    oMowAuoM2hDKIdTTCBTOmIXfs8_kalsa_dCzyFPF3aooSYOWfdRj0Q>
X-ME-Received: <xmr:QXbRaMRTZ2OSqmWOgOhMJk7uUNhi8puogFR1Go6omhdMZ3V2VWBXlHe6FocZyN1dWQpU8TmWOYzOn4RbGkqqATAXXfuHf1mxUGHA6VvRjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteehffdvtdeltedtteeuueekudegteetuddtgeeuueekteehfeeuvedviedttdevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvii
    gvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghn
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:QXbRaLTskd4u4T20pRwp2b-t3uWoT9rpltHQTEhhXxFnxaS25dQqWw>
    <xmx:QXbRaJ490WELsPfPnc3ZE6jtF4FQfPuz_vgaYi3Lk8cPI_2TMh9zUw>
    <xmx:QXbRaP2JF3lIW6siYbwtPRvtkQmHDRCG_poAZNqTLCIDDRdNfM7dtA>
    <xmx:QXbRaMBWdKZHucxWrAp2OyG0TVAi5suYPqFJJY-17uSpeDfI3V3aVw>
    <xmx:QXbRaOi3XwWsIdAgpdBdPydctx6r_Zw1669gigQH9VNdZ2NH9CAYMpw5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 12:16:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20ae2533 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 16:15:59 +0000 (UTC)
Date: Mon, 22 Sep 2025 18:15:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
Message-ID: <aNFz-0rO79l7crZ5@pks.im>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
 <xmqqcy7pc8ix.fsf@gitster.g>
 <CABPp-BHJUkSERQon6xx=sHrhN7i=6ekv+Hz1+P+2mh0=Xw15Mg@mail.gmail.com>
 <xmqqy0qcae6z.fsf@gitster.g>
 <aNFIwFD6E6Lngy5M@pks.im>
 <CAH=ZcbDkDfc6j_gQCt_q9RLP_ozYqr09i1-xe2mvhSQRgf8MGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbDkDfc6j_gQCt_q9RLP_ozYqr09i1-xe2mvhSQRgf8MGg@mail.gmail.com>

On Mon, Sep 22, 2025 at 09:18:14AM -0600, Ezekiel Newren wrote:
> On Mon, Sep 22, 2025 at 7:01 AM Patrick Steinhardt <ps@pks.im> wrote:
> > I personally think either (A) or (B) would be good choices. I would
> > slightly lean towards (B) just so that we have something that we can
> > already play around with while building the next steps.
> 
> I'm fine with B if you fix the wording in your Breaking Changes about
> Rust being introduced in version 2.52. Rust was introduced to Git in
> 2.49.
> 
> Elijah points this out in 1 and 2:
> [1] https://lore.kernel.org/git/CABPp-BFXRbaHk9U3BX+d12bZ+ryGOp+btR0ODMw+HtD7xd+MBQ@mail.gmail.com/
> [2] https://lore.kernel.org/git/CABPp-BEiK49f_UB5UPe3qM9O7vQGGFJ8Nshw1f6W_6Lw7HRL6Q@mail.gmail.com/

Will adjust.

> > By the way: I'm also happy to change attribution of some of the patches
> > in my patch series to mention Ezekiel as author. I don't care much who
> > is listed for the initial patches that introduce Rust, but would retain
> > my own authorship for the "varint" and "BreakingChanges" commits.
> 
> My only other concern is with varint. You use usize on the Rust side
> and then uint64_t on the C side, but I'm ok with fixing that later as
> it only breaks 'linux32 (i386/ubuntu:focal)' in the github workflows.

Oh, this is actually an oversight, good catch! I refactored "varint.c"
to use `uint64_t`, but then forgot to adjust the Rust side in the same
spirit. Will fix.

I suggested in [1] that I can change authorship of the patches that
introduce the initial infrastructure into Meson and our Makefile (so I
guess patches 1 and 3) to instead list you as author and myself as
Co-authored-by. Is that something you want? Given that you have
kickstarted the whole effort around introducing Rust again I wouldn't
mind that at all.

In any case, I'll send a new version of the series tomorrow.

Thanks!

Patrick

[1]: <aNFIwFD6E6Lngy5M@pks.im>
