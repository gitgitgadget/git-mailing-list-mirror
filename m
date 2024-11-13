Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E51DFE35
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504290; cv=none; b=S+/UkAW/h1EGZg6ZywNapWS4ChhgqylMXD41Jrk4S8GvLllf+uEVKP5rQHso8v2nsJkNEPDlpJPdlEMS++m48iCGUArXYXlj0ZS2z+FP2wc0v/+ocY72NboXyIWotww26AEC4iP4dr8dxquW9nePNnJ2IDAL2VzoCj30xhi5jVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504290; c=relaxed/simple;
	bh=j8rSF2HBswnDb2MpC68Ji/pBdBYNKcQAW2b+kYV6t00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2CcVc+81wShCpN022f7jqmHWYb4SBSw+2IahgZec5UWTyndfY1dqBB0BeQJGGjqVZmRLhzJi7Bkz4Bcat6BvZU0BunYlixM5rX1G8OWlVrLMDJYvOnsFQJZ2aJ5RFDQ5MKJ676RD9PJQiqughekVj8rWY252LTn7t6wLL9qKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dRyIdgZM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LY6kw/Zf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dRyIdgZM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LY6kw/Zf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F32BD13805F7;
	Wed, 13 Nov 2024 08:24:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 13 Nov 2024 08:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731504287; x=1731590687; bh=Pgef/iyqUV
	HspiNrWmbYHqUKIA1hztruPTA3L2BWOOQ=; b=dRyIdgZMPgElUf+6nd/1Jk+3E1
	uNFprGCEVQQ6XDFvE4lYL+mvFwtEm6qZYxOv7TuRogdIlBTHi/qwMFjnS0i7Bpep
	dU32Jtvgfk/h1hpxZhdxxsiLPQoEWZM5gGHrD2TG0XrBwsxFqAxFI3GqkVZHA24J
	TPCi8Jk3v3i1Z4AVD2wym1y4IhrSt01a+76Ampetq0JHvF+E+FpyomMoFF9aceJu
	nQXTsDlVua439gYPRp3XIPGv1R4TXcNgLYO9NvFxk5WdqF3JIx/hdD7atLgV/Rac
	y++8oZDV2EDEclaTzOlXjQ5ij/QTKNZEkNjOKkZzA3P9ovUfKjLtqcKlZl3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731504287; x=1731590687; bh=Pgef/iyqUVHspiNrWmbYHqUKIA1hztruPTA
	3L2BWOOQ=; b=LY6kw/ZfqSvSifxfgqQBuur7CloA87lB0WSsx1z6U3m+BP3LCa2
	90TLUJ3948obp2PwE9pU3PdOgk1HoRtmNhxdQRLOwMv6Jtf6lpGF1FYNiTWVfC9g
	UrwT8U4PLsvfbBsOQR9SyzWU0X+x0nmABN41w6Pmm/chs9JWuGlx55mXkKUfLR/q
	BriVhpbGhX1TMns2Z9ESjGBIhn1OFjhOl2lxZci8A4wJPwqhtuwDo0CHouL1sqgN
	mRTfhfyT347ZBABSi8XkwHHHWgOyzeAQw7zxPFlu0AJm2kbThECMrphAQRsfFZgy
	OQqAUYI2mDMLD9uJwN3hraegC+1k1LBoTEg==
X-ME-Sender: <xms:n6g0Z08aUdhxYYbbuv00O1spC_G9OUF_hlMFWFnO5Vsq_a5UPzpLyw>
    <xme:n6g0Z8tJ9QJ_w3m5beZo6LjJCA1RsrSRLrguFaJPD3Mxq0fqR90u_-qddNsl4rMGy
    jJDj1KjtpAgeTlZIA>
X-ME-Received: <xmr:n6g0Z6AlQat8TqwkDGW3PTtX_NCdPnr9RH2yblP8xUeJMeSo-NB5DUOI5spLKONMyQiC3XGPPtJs3ytOdeI_oeax12eDtDxLpnLTVgTN85PCPOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:n6g0Z0cx7iZCAhye7RnOW8K3gHq3E8nU52GSaUBJ6VEYb-FnivJoUw>
    <xmx:n6g0Z5OJaM-kEvL6G9l2zYWE4Mk2Q4bbbzhB3RiJXW24d5p2oXepMA>
    <xmx:n6g0Z-lBhwkNMHeUf1BesY3u8xZBR1zk3wHes3QvvJEwqjVWjAz6uQ>
    <xmx:n6g0Z7v3N9f0h-eqwAKoKx2Yb8xV-JFHJyTlXLXLE3CaHRCR_8l5jw>
    <xmx:n6g0Z8oxHtALUomvIVfNEIXFNu_XyHX9rnU-UgvvOorAF90HgYz60S5V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 08:24:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2cd2c399 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 13:24:06 +0000 (UTC)
Date: Wed, 13 Nov 2024 14:24:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC v6 18/19] Introduce support for the Meson build system
Message-ID: <ZzSolMgK7tHMeosH@pks.im>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
 <20241112-pks-meson-v6-18-648b30996827@pks.im>
 <xmqqiksr1vfo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqiksr1vfo.fsf@gitster.g>

On Wed, Nov 13, 2024 at 03:47:55PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +#      # Disable features based on Python
> > +#      $ meson configure -Dpython=disabled
> > +#
> > +#      # Disable features based on Python
> > +#      $ meson configure -Dpython=disabled
> 
> These are dups, right?

Yup, fixed, thanks!

Patrick
