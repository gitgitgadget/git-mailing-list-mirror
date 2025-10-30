Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3C2192F5
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853859; cv=none; b=ejqX1+h3w9kRpQfGi7HPVsz3nIj+uHLg+9spZ+9lMmeJN+07raEV4FoNuazksM8wcZhtd8j8jooKCfWvNoJH6gtFlCyCyPX7a7CoS4Zc4fFZJaZV40lm06c9Nkp6cHYSMoa3tSDsmxm+OLJzOj7HMjnftG2vx2C+u+d98Jc7YRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853859; c=relaxed/simple;
	bh=CioHOsIO25/KlMVqQ/SfDPsG9rvGuiPrjYCQ9P/aydw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OpFxFIf8+aJCEiFgt1tC5A7dspEknyktJk3dol4OI13HaqXNpHCrQABhfndTH+Plc3xZRov4+oy9EaP8T1LnY+yUUv257JOOGUNmTFJMGFZyZBvrCAJr2R/s9oLhHMwqiXAZFg0e+QI7IYprfFzfrPQGPFpOVBVeSFJfFZoK00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k/NgZCB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWjiMh20; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k/NgZCB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWjiMh20"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B32341D00149;
	Thu, 30 Oct 2025 15:50:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 15:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761853856; x=1761940256; bh=uO124wP7eE
	2wkP0VPZXOMPsR+hAaEmIDOskZInmdyJA=; b=k/NgZCB8uBEWNnVe1C6UKiehjR
	eVNYIXyLZQnoTEnZrmg4ccHgpOTOIkpgNi/iHSf+IKjZcucT2SMMqsZlAS4X2L1T
	78aSE3RhYXOXTnttjC25eWc4uM2PM+z/xpjVzjCq4a/J/NachS9mdGoy18pRcayp
	Up14Woi71vaZhucnbgS3UTMEhfMyzX6mkUPkaIlqlm1NyJPv4fgl5kBV7k6XBY//
	jAx+VIv/KaZJYv4BKaBJWrVYeVwW3bw3Zfcj9G5xI+B7lNlAUqRq35YLLiIeBSJw
	dg2iHW6llrCK/R+hjn6DB0ZqhQBPn1Gx413WzyJBqZcBRW8EUcpfNiMJ5O7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761853856; x=1761940256; bh=uO124wP7eE2wkP0VPZXOMPsR+hAaEmIDOsk
	ZInmdyJA=; b=IWjiMh20SuXxmKG7g8LmVDkn0P0yVsS2Ywm4xlLSj/BCiJxWIWf
	0hoRfELBNLlJ9XVE3Omft2diHwbqXV5D109ySlHG6Fu7+Xg980Y3VUbxJ48+XFQE
	O0Gi2njqOVoGusbvr+rPXT9spXFDIbqbSY3lkODh8Ev2JAvkFFZUF4zlK437A5KZ
	aHbP01BBMbTNBBtzhXOTfAHYrD4Qkk+u97rCupw8pEtVhd1rTX8vRebNdoF8Cqe3
	axq40RFhj1MoD0WFUSZ4Ju2im8pIT5lw/5F0ifdwJpuz5KMlMH/pnRyLzqkDLgD1
	pNrd11Kbbvyons7N1Zhep6itUi3mw5sHoaQ==
X-ME-Sender: <xms:oMEDaceIRZNZvoF_eJuXhWN7SylHgHnoDd_RfRBYdmrvxGGZ4KSr5Q>
    <xme:oMEDaVr-w4iuuHoNvyEyJXAQchzxXWCOo-9iX_zbJu32X-iezzKTSV92iFzjRb-Y-
    dAYHC7Lww1DfxY6X4BpCHQRUi1cBTRn_ZRUztkBNeALzWFTytKAuNM>
X-ME-Received: <xmr:oMEDaa4wbg2i8k3uQRZCw-H1AeI7QP9ojx7Cc0gUj0KLKnjBeTptv30MH0svq-LwQbCRVPBLKQ2QvloOSEjYSmgKEGcW3tHhVYTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifrghrfhgr
    nhdvtddtjeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oMEDabqR2WRLlnWlu8Zg89fFfKcMY81P9_6V4AHUcWofZdqha3KV_w>
    <xmx:oMEDacijaXfvT4hpWgbaHlQEM801az9RDb85o3eoG7kxVa17o8qkeQ>
    <xmx:oMEDaVLtETjW7LF9K9_7Oa36avdvCaaBYGZhapw2ThvQf0237Sw7tA>
    <xmx:oMEDacDBRExIySk2gllWPjX1UQptmZrxSYLdp_RiFGtrtLFcYu8Dzw>
    <xmx:oMEDaRpd4w1VxIOhEqkXboIjJu6ESVFxnI_t4rXZIB9EJEDOKlpDRCyL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 15:50:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mark Bauermeister <warfan2007@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Cease and desist for companies and government agencies misusing
 git
In-Reply-To: <CADanQgA3h52hax-mdSTBV-tNDGvNRSxLU217aVygj7Cs7Lu8Bg@mail.gmail.com>
	(Mark Bauermeister's message of "Thu, 30 Oct 2025 16:27:10 +0100")
References: <CADanQgA3h52hax-mdSTBV-tNDGvNRSxLU217aVygj7Cs7Lu8Bg@mail.gmail.com>
Date: Thu, 30 Oct 2025 12:50:55 -0700
Message-ID: <xmqq1pmk5fts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Bauermeister <warfan2007@gmail.com> writes:

> Is it time for an online campaign ala "Merge commits considered harmful"?
>
> I have nothing against a merge commit being the result of a successful
> PR but people spamming merge commits are ... something else.

There do exist people who make pointless back-merges into their
topic from the trunk, just like there are those who pointlessly
rebase their topic every time they notice that the trunk got
updated.  Both are bad, even though constant rebasing would hide the
fact they were rebased and what was integrated at the end was less
well tested than what was originally written, so in a sense it may
be worse.

These people need to learn that they can make trial merges every
once in a while so that their topic can be used with more recent tip
of trunk than where they forked from, and that they do not have to
keep these trial merges in the history.
