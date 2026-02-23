Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066E2C11D6
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861601; cv=none; b=rP+V8vmqIXLnVfNLO3bBjZba9C9oF8oD6nGbsIf9S0XXII0S/ICAGgP7QC4dBZcCUfmmra6cfoN5TpdWUROo5C7hwvt+feTiCxC9EOtB2kBeY0mtaXRezyGojtvlw+G+NLlj0zNhJykYIQaQGAPNPtekBFVtz19Xc9LskWk9vpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861601; c=relaxed/simple;
	bh=es0DdT9C8cveCtv/uz1ap2R+lc+YqWMWkeVq7BZYz6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFvS2xpKqoD1vUj+ZG5wCE7diNsRvUJU0R6doQ/TQN9L0Nhxdnm/+FYTxt1GNCLej+XlqaDlV28p004SxpHxGfVrrKJ9QuvcyV8YD5JZvyYfcVWK8QfAcssgUXbmM7y5uHxeR1SPlzcNXsSotPYg+RLw+o1rvqB0dwuSptNKVYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pyWMwQSm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVokKSuA; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pyWMwQSm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVokKSuA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E5B2EC03A2;
	Mon, 23 Feb 2026 10:46:39 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 23 Feb 2026 10:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771861599; x=1771947999; bh=toDSdRBUv2
	x8opul3Z9XExbHwh6qV22QMmJWJ3YEmMs=; b=pyWMwQSmjVc3TK6eDnQH+UT9Hd
	/JlofkcOKtj2s5nkg9v6PJgLSma+2+KT6JZBiFum0CPzxTPtCVdQsgVLkKJuRdLU
	xBi/Wpy1gsiWa686L9ldKBfrx+pVF/ZiZsF4Iz6V3npw4DS4BR51XC+pXG0cN6z3
	eSXVHf2b9nlatTikvC3eGe/MvQnhtLTH0koCDFYVHkcxApz4zc503abEMSiO5ybN
	Gw3f3V5G1W7irHi8wn8RdCh6fQvFgpx4A8+bkA87PiaMH02MccMobN/dGxrcd1Vf
	GV6CPoENj5WO0GIHhI7CI6IbMmXf/WAoAVo8xj1Yf8J0e5zc2jzY6S0qTDkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771861599; x=1771947999; bh=toDSdRBUv2x8opul3Z9XExbHwh6qV22QMmJ
	WJ3YEmMs=; b=VVokKSuAGdeHP1xIh1+zq1jOwjx9fHTHuDZQEwDYVRNW3I9bYs/
	4zAIpD3jxDbCmJHlqJxPj2S3WjFSuItRT9Dc/6nLmeMok4UoryZ18xPu/IN2mnSx
	I2fRGF8p4PYxmEyYGBaYjCtxbkaQV7H9sL4Nd2F7/BiwRkvFIp7lsXKsbj2D+DGF
	PLXx5aAXke0/L1wSdX7wBUFwwb5vAWT4IT9blhuu7laSdUlGii6QQlkDx4qKmh2z
	XK32Jad6okZotYAgGqhNdOzpQiyoYrdkDHni8ZYcgD17z2wZMK+TMc1MkxF1O/nb
	CnF7BrXEOUvt+31W6g6J5rUhdwPlgyUdidQ==
X-ME-Sender: <xms:XnacaYG6RaTdKoQLBxvlnm94mXnJuaxzqVVEmqYrstYNR-5vLpNDyA>
    <xme:XnacaYM1WX-WlKgWYmxDWEkY2Abdpkwq-aGiO8zLSpv54nGp9n7FCQEC2NKnGHqNc
    mce3tpQ2MdNsRMQUAiVbRT14QWllNgOsZHe0wYsYJRDG5iM563XFg>
X-ME-Received: <xmr:XnacaacN5vAqVF91I_BNbMaMJCas3QnIv1VTjc9TGqkkAP3jeNh3nzPYOHy_bGPhHymCtZjeRqPmtqMwNcGv1iHCTbcqD94AKjtKQ44AyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdprhgtphhtthhopehgihhthhhusg
    esphgruhhlihhsrghgvggvkhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XnacaVsEzS_CJfAhm5xR2Bm9XFCGw2oDIvrB2jIcfpoibglChmK85Q>
    <xmx:XnacablZLq8PYbeuKVlPoQ4N-Fg1fp1JHMJftFpZyGHEusDNc5dEXg>
    <xmx:XnacaXzD4GMbeuBQ4ABGPNZG6u8j7mWTn_A_lTR6SCtWeY5O5rs-SQ>
    <xmx:XnacadPr3YrhKibY2_xjg6MKnGGLkkPPBxakU28rdeGRv6soBcIHiQ>
    <xmx:X3acafKdDJxxyQxsy0apRFLvAHpiL-svlCQE2El986DbufRVz5krEK-z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 10:46:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cbaf4e45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 15:46:35 +0000 (UTC)
Date: Mon, 23 Feb 2026 16:46:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Paul Tarjan <paul@paultarjan.com>, Paul Tarjan <github@paulisageek.com>,
	Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v4] fsmonitor: implement filesystem change listener for
 Linux
Message-ID: <aZx2WFMtQUB0jIfM@pks.im>
References: <pull.2147.v3.git.git.1767099302592.gitgitgadget@gmail.com>
 <pull.2147.v4.git.git.1767202894884.gitgitgadget@gmail.com>
 <aVuplzNaoCHlZG3S@pks.im>
 <xmqqikbrvz2l.fsf@gitster.g>
 <CALvWuB70kwPAnQ+v4ch1TKMDxbUQgi5NP8NX7tbCZRqivJ=vig@mail.gmail.com>
 <xmqq1piet47r.fsf@gitster.g>
 <aZv02KjfheyFlMfb@pks.im>
 <xmqq342rpiuh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq342rpiuh.fsf@gitster.g>

On Mon, Feb 23, 2026 at 07:42:14AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Sat, Feb 21, 2026 at 09:07:52AM -0800, Junio C Hamano wrote:
> >> Paul Tarjan <paul@paultarjan.com> writes:
> >> 
> >> > I'd prefer to take you up on the offer to send the meson support as a
> >> > separate patch.
> >> 
> >> This part of your message is one thing we needed from you to unblock
> >> ourselves, I guess.
> >> 
> >> Patrick, do you think you can help making this into two-patch
> >> series, the original one being the [PATCH 1/2] and update for
> >> meson-build in [PATCH 2/2]?
> >
> > The changes I sent should be sufficient, so I'd propose to just roll
> > it into the v5 patch.
> > ...
> > By the way, I haven't yet done a full review of this patch, I only
> > chimed in to help out with Meson. But I can have a deeper look once v5
> > was sent out.
> 
> OK, so it is not quite clear to me who is doing the v5.  Is the
> "offer to send the meson support as a separate patch" still valid,
> or we expect Paul to squash in the earlier patch from you to prepare
> the v5?

I'd think the latter, Paul squashes my patch into his commit. I don't
think it needs to be a separate patch.

Patrick
