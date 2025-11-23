Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC11DF75A
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763881768; cv=none; b=jUILblwSQ7D1R8RTaOo+65Ci8wujWHGAdkR2Y9v2RL2fyAIyag08mFQjx2OYEX0XHJ6Nw/ohJ5i0zca5NbWhl7qtLcrmJIcWOk80rJgOBZz+svBW/7KUhwYl2oRGSCBjSSysbUKLhvOBCAWFLtXz91EI+wbpmvIi1NZ0AfHRELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763881768; c=relaxed/simple;
	bh=h4Oo/3lnPb1dJHgCTpGriEifsVVvB0lkBrSYADm3u6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SBnev6AA/MPuw7y8nCKLDa1HKXp8eZlmfw01F3PFx4cU4xx2rAT1b4dZ2g3WyDIbM3QVTmJxYOYRJURTEi6WVjONLKHJ/9Jhu+OIi06XpSCo58KBlDXHctHVmI8R2fS1Cr9+tcUV1pRwhWrE3QwI0KgUrVVyN2/n+BO4LVYKVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QaJsFyQd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xfTO1DJH; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QaJsFyQd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xfTO1DJH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E8D9F1D00106;
	Sun, 23 Nov 2025 02:09:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 23 Nov 2025 02:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763881764;
	 x=1763968164; bh=9DXXUgmdtxivfhUKLMky7QXBk3skxW4K+KWYQzjTzNA=; b=
	QaJsFyQdwUoz6KpggpdMiRnzm7XUfzV+8rmRTewI2pfsoQch2hcwxwIHWYeo/9PH
	rVIk0lSXJnKki0MkAGyhtO6FJZF2s6HqT3l++luNZqcWLVhC1gaKYPSM2LGgqvO9
	X2UEC+OJQyQFJQHXuEvEtU7OHRr0hzkG80hZELPVG/zDM3gOYQC4haCTfO6TWgLC
	btV/wmFtKTfiLOe+sRs7E+7I07lINwf1pU6TryAVYIOlfX/kZeBKDKNXiNd44rX0
	6bTFGKC0ql++3blCXRbs3zO8PjVkxRdMOQc5bux+CNgxqqOU1yLUNZoc6Ut4pXbl
	sLMOoO53pTFMfD+HV7v29g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763881764; x=
	1763968164; bh=9DXXUgmdtxivfhUKLMky7QXBk3skxW4K+KWYQzjTzNA=; b=x
	fTO1DJH8QM9RxIpXmszJr57pVYfy6fQshpGjnP7dbLkcVPvF6CAOlIxRZ67t8xYH
	HyVbGl//OxIKnuM/AtbTkuTK57llb3KsS1lN4OT43NAkNdqEdhslCb6KpI3g6t8p
	bDxIF/XdEdIrlKdqi3Oun3byqMjjkLsrBu84reK7U6zfxY4jSDpB2DkR6phPd6uH
	LULe2mWDZoVYeb5iTOfLbkBbeHtASAwgMipfN+ZWk/f0MhL/9VM+ietPIlPrmIZn
	Leh3uKl4rrSCd8XycuseYT69xBtngtXNFLVE5kbbVkC5I5ZTWa6UXlr8LxrjUr9X
	s6cej7KnIb8XFtebDVH9Q==
X-ME-Sender: <xms:JLMiaU8OQ5qU0Ap5hFflWEiEwfakNVSIAHt4eIP-Fj2_rb71aRtp_g>
    <xme:JLMiaWCBKYSkFci5v4W9dNFV3STvT4n-82blmoTmkw_Y1Sv9q57yL3XWj3yoKMxDx
    YjYTLyujvt2pRkDJ1gdbgc8hkiC0KliO5IYmP8DlThL8uNeAdHP>
X-ME-Received: <xmr:JLMiaRQl3noTuG5iFPC2XdiItOBpxdmZYAC4UscQBZSwkhQvQdnFClqaZejuq1sRKe_AyfI9kdZv82UMirFloWVOPa-bMfs8Wl_y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeehtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JLMiaVvghfsvDrAWonS1OLe0Tqhbq7zK6V7R5MyfppEqsaVpJq_vqg>
    <xmx:JLMiaV2_fiuouM1nyKM5NNCZHKY5HxUEKZ2OGYbSH35whYBpNHkJPw>
    <xmx:JLMiaeUMb3NpUnMoaVdFJ9jbjBXEM45GcQhpXqB4PPjVoUNriBfKeA>
    <xmx:JLMiaYIXPlA-ig08p4Wqf8PEwFu4TvChJ3GrqVu9xUtKyeuph2YXIg>
    <xmx:JLMiafoZK2_utxdc4ef75IhUHOWDXk5hlNZJmmSx_GiwZ28V_peDrnE->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 02:09:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Jeff King <peff@peff.net>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Git
 <git@vger.kernel.org>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] diff: disable rename detection with --quiet
In-Reply-To: <8cc12ef2-1d2c-4924-b130-bd740a975ce0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 22 Nov 2025 22:44:59 +0100")
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
	<8796cd59-2335-4674-823d-d682ce7b7f8e@web.de>
	<20251110175408.GB76603@coredump.intra.peff.net>
	<8cc12ef2-1d2c-4924-b130-bd740a975ce0@web.de>
Date: Sat, 22 Nov 2025 23:09:22 -0800
Message-ID: <xmqqpl99z0m5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> --- >8 ---
> Subject: [PATCH] diff-index: don't queue unchanged filepairs with diff_change()
>
> diff_cache() queues unchanged filepairs if the flag find_copies_harder
> is set, and uses diff_change() for that.  This function does a few
> things that are unnecessary for unchanged filepairs and always sets the
> diff_flag has_changes, which is simply misleading in this case.
>
> Add a new streamlined function for queuing unchanged filepairs and
> use it in show_modified(), which is called by diff_cache() via
> oneway_diff() and do_oneway_diff().  It allocates only one half of each
> filepair, ...

It's a misleading thing to say.  It allocates a full filepair, but
because a filespec is reference counted, it can reuse the same
filespec to hold both preimage and postimage, halving the memory
requirement without leading to double freeing.  And having a
separete helper do so would make it almost trivial to avoid setting
the has_changes bit.

Cleverly done.

Thanks.

> ... which has a measurable effect if there are a lot of them, like
> in the Linux repo:
