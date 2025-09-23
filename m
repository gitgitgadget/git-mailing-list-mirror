Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F730DD34
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 05:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604292; cv=none; b=jpj0oxo3m/ich88eawp14/PVyslySrE8Eazt5yA+ABAnrhPAuiYY2CwslQvnItlxVpZFGSwE7mz3shvD+VIm9G67Dc7dCqlRm4YT6B9MAUa2HQcX0+LStghWysy8XXQkeQ+4mOGcxSjK6jbyX6+A3EG+ZocQRcF4SwMxsUPE7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604292; c=relaxed/simple;
	bh=uOmMZzHF8R2qYMkqZMmEfaYzAytE2as9ngKNH51BoFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCPLXF474Fi3hp4Q42m2LoZDg3mRvd2uTbghGlt20AKhfl2XlRUOalwW+qT/ayUgDYIXOmq9YZ/WVYTkmEtSdIE+GggRRA5PIzW2jvQCe9DRuqL7umfbI4qzmUyC/PHmV+D9k8iiYtJoaq1a+lRJFOASfhSnZGEggo/rm8jrj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M6zPXyvn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=keNjVpSH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M6zPXyvn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="keNjVpSH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 24A5B1400088;
	Tue, 23 Sep 2025 01:11:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 23 Sep 2025 01:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758604290;
	 x=1758690690; bh=AEgNpQiBV7bv6ie12aAeakuWBeKvJdktksyIsW+5iGo=; b=
	M6zPXyvnkKIAmCk8+AVw3WI9fS5OBZP3JiZEMrRJaY28n9UlK3K86jymsS8AX7TB
	hOE5KgAuRUC4TZBW3CzYiaWl5fx5y13k72HzZTSdkLYyvxwmhqG0M38beRWKY6Tv
	U9mSVq95RgRUPfHRILBuL8vnOn7VOottrS5wQBYl6Rxqmgh1AFKPVReXRNfelJGs
	wlsWmq172zJSVeXVk9u+scfEY7ApgDGxdBtKOfe7gxFcRF9umii9hpekCtFIGlI/
	0PEOcgdbF/lEs3SZ9FqDnIV3aoFr9U52UUXdJs5enBj6NjichGQLQCZKCn6y8Nbq
	JPsAkZDM3o5IMFaahrvzwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758604290; x=
	1758690690; bh=AEgNpQiBV7bv6ie12aAeakuWBeKvJdktksyIsW+5iGo=; b=k
	eNjVpSHD6tPu/nkEVjzGY+znBwnqxsrPb9RRIZsgWXCVFeL9qm6Z0S5jo9EHdVb/
	+0DyzTqLKmt5H12+5SIUbRAGXUynCrP6kIVIB/r3dW0t2aIAIUbC18PWf9F9yN2C
	ghi3LsKtLnLsseTRI+xm6YoLdZ18ZH996O/9RC4MJAoN6qyZS/Dc3udNsNLDEzey
	uH5crdq53koPNHPtichF1n244ZnYQ9RGs+kOdcRLtIEK7kvLovr1uIIoOPXZAAnW
	s7unz2uU44v0Tl64rhjsPuWHEgN/q1dndXJB/zHwxVlDndUWyvVvsPn8+ivZaKxr
	M/wIVRTl1CS77wY8dHAEg==
X-ME-Sender: <xms:ASzSaPNiOHJ8aVFdnWJT9AaMe41cwWh3I3YKuy5p3xe8Y0838ssClQ>
    <xme:ASzSaA1aGVgWKwdPSRggA9_xcUV513RQ-BWDm90mb-hxW2ZUB81CgeSQuEN5JUi5Y
    86cCVw0LnaiHscaWJNaNVeIVGJduJf2d_xDTPlg7rYUkGKkf_uZ>
X-ME-Received: <xmr:ASzSaGmYwTaRD6amnXj7lqHGhqxjD_euWvUX5kcbyi_spcuFQ51HIqnulGeJL99wCQDFVTLUJETrqiKdJuwxCnmS9bKII0SJThoerIQua3FU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehleekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ASzSaPVkyVOoZ2sgZY2IrqNNgP_BRT7yFpT_0pQC3y47d17CJHG3pg>
    <xmx:ASzSaEvXZVpXdmRyAp0jhg_JDskGyYKBjoOjaexSVhZhJGv4rwQYNA>
    <xmx:ASzSaKZm6oNkjq8T77dW1TEPxDtOYObdVXuYLQgwRmOxIId2Wi7wYg>
    <xmx:ASzSaLUgSK768b9eLI-pDPwxouDL2BB5nhxFxQj-_3-qfvBVnkZ6nQ>
    <xmx:AizSaGmrptpx_vIrOkmBprL2vr-jxDtR5iPyl9vxjSxmKp7sljUIyG-i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 01:11:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79259ba1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 05:11:27 +0000 (UTC)
Date: Tue, 23 Sep 2025 07:11:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
Message-ID: <aNIr_P6HMEvwERUL@pks.im>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
 <xmqqcy7pc8ix.fsf@gitster.g>
 <CABPp-BHJUkSERQon6xx=sHrhN7i=6ekv+Hz1+P+2mh0=Xw15Mg@mail.gmail.com>
 <xmqqy0qcae6z.fsf@gitster.g>
 <aNFIwFD6E6Lngy5M@pks.im>
 <CAH=ZcbDkDfc6j_gQCt_q9RLP_ozYqr09i1-xe2mvhSQRgf8MGg@mail.gmail.com>
 <aNFz-0rO79l7crZ5@pks.im>
 <CAH=ZcbB_AZ7a=kQ_tHRtm7jPD6h_7AAiQYyaMQrG+ijj8Dyvrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbB_AZ7a=kQ_tHRtm7jPD6h_7AAiQYyaMQrG+ijj8Dyvrw@mail.gmail.com>

On Mon, Sep 22, 2025 at 10:27:32AM -0600, Ezekiel Newren wrote:
> On Mon, Sep 22, 2025 at 10:16 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Sep 22, 2025 at 09:18:14AM -0600, Ezekiel Newren wrote:
> > > > By the way: I'm also happy to change attribution of some of the patches
> > > > in my patch series to mention Ezekiel as author. I don't care much who
> > > > is listed for the initial patches that introduce Rust, but would retain
> > > > my own authorship for the "varint" and "BreakingChanges" commits.
> > >
> > > My only other concern is with varint. You use usize on the Rust side
> > > and then uint64_t on the C side, but I'm ok with fixing that later as
> > > it only breaks 'linux32 (i386/ubuntu:focal)' in the github workflows.
> >
> > Oh, this is actually an oversight, good catch! I refactored "varint.c"
> > to use `uint64_t`, but then forgot to adjust the Rust side in the same
> > spirit. Will fix.
> 
> You also missed updating varint.h.

Hm, am I missing anything? It does use `uint64_t`, and if it didn't it
would cause a compiler error due to mismatching declarations.

> > I suggested in [1] that I can change authorship of the patches that
> > introduce the initial infrastructure into Meson and our Makefile (so I
> > guess patches 1 and 3) to instead list you as author and myself as
> > Co-authored-by. Is that something you want? Given that you have
> > kickstarted the whole effort around introducing Rust again I wouldn't
> > mind that at all.
> 
> It doesn't make sense to me to list myself as the author of any of
> your commits, but I would like my name referenced in your commit
> messages.

Okay, will do. Is it sufficient if I say something "Based-on-patch-by"
or "Inspired-by"? Don't really have much of a better idea for how to
include it, but please let me know in case you have any preference.

Patrick
