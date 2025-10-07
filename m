Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D33EACD
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845061; cv=none; b=YknjgWbFy9AnTz8Qe/HCIJsbSHfgzHGYfcGbj62m+a1Ra7XRqG+lhl14j9qKKJZl47FODNKey1R7Ew4Xh5I0OR2nf7vdzNdgQA6efK7snLml5s0ruYAKWI5NN+lIjNLH32QMUiemgfGZA/lsaXRYansQrxUWi9ShwGrd08+e53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845061; c=relaxed/simple;
	bh=mruW9CUk7g3uBzyT+bmvDXrkOKOG/Ccwz2G2f0Jsu/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcNPI3M9fFLch5CYzS3NaW7H5VJBbNspuFuX6GWVM9x7yHaNfYi8GrUHB5M13s+gbOpHBz9f9hdu5kjBIhd4yjbHW2tVu0ur84YfYyU2CqJYUYt+Sds8QVV5UiUrpLpJlh326FUmw/pw1DbEhahmek0dRAnAxN/nur7qY8RjSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nmovzSRV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CbxTQrUZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nmovzSRV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CbxTQrUZ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D48F14007CD;
	Tue,  7 Oct 2025 09:50:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 07 Oct 2025 09:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759845058; x=1759931458; bh=g0qB6aYRIs
	klY9IiVlFFavrXt32ZfwL1UNSYkhrj3fw=; b=nmovzSRVjePUdHC0L+HE4ZdUMG
	vKDgrixRbP/DmRwXTY8iI9JsBJNGLUAqwFBvQ9rCdbnCjf8HagOixtWuJ5vYgSqu
	6ILaoASb7j8ugz5svI1E0PuxIpIJRyWJ6LG/x6Q3lyj4/AsRvumd/6H+QsmOf6m0
	m0/kQYgHMbOLo59OVFdcbaxFdrQQTfRabeOSxZCMsbFuF0V+YwOhwdR38r6/udZR
	2DGXRhf5jSZESA7hwEVkWPWafNYi2ZxB1ccpxMx7lbsNcmHDrROJiq9ikW0cEIGj
	X273ri6NKKgarLmkhma4mOua8HElXY0q6IAvvT9szC000nwAv5YHglGWyKTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759845058; x=1759931458; bh=g0qB6aYRIsklY9IiVlFFavrXt32ZfwL1UNS
	Ykhrj3fw=; b=CbxTQrUZz0QQFEwANUqBaJEGX/Tbj1CxX2vA4KqqUltdFz+T4Qi
	rb2Vqa0mizBgHlEaQ9YgM6imB9ZCFp6iJaFzvDvPvjMeyiweOsWOBoF7qgWqMZV5
	mxAePicEKD42vz06sIdoxapD3WNuSQOKD94ajTjTOf4NQLM0Wv/qfOF0B8GOSVRX
	m8suo6J/ZAKrrSejNYi7/6r+NT1YSOKwryV7XOoENx3b3lWeMu4jMqyWGLvh10DS
	s7/JhhcXv0KJYeSBRKUNGJ2geuZxQWYIB7aSK6Kp+Ykl15LO/JcQ2YZdjrh1YPgK
	yd7Xv9zYl6gQoKJLg+Q5leYr6oKWkCS9mIQ==
X-ME-Sender: <xms:whrlaKdznBJS7IePlDDX52-mAeuspTgR-z6pb3HWC3GMLehjxDtATw>
    <xme:whrlaLEupgcRlC-Ff4BDhkma1yJyKAp20O5MBBJmHd3NhgDvsRlltjAClWEcJ95Uk
    SWqSp9Qnu-YRJ3Ft7Bt56n39ZFIkSgcEfeW_3SyNqE4z2x0lsUCKQ>
X-ME-Received: <xmr:whrlaD1687tljZ-UgdMFK0C7QOeQ9jUEdtTizji9_kkic6B6LNjWyRLgcXUMbniLoopmOVEZQ-6Gu2DmMFaSSPmn1GKZXym5VQiYSvgqvCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:whrlaDkEW-L7xBB-IrrupUeSMONQb6Ki9WwZfl5BWjr8iwdNTbSEdw>
    <xmx:whrlaD-_La7APc1Vsg4Y7CZZ40tCzGSdl4gt-w-ZMPYK0xs2SW2OlA>
    <xmx:whrlaIphXTd32uxp9LsD8kTZV9X6mECoraRzRyeQICgbz8NoSyAaCA>
    <xmx:whrlaMnL1WUdjc4R38ZvxiArSrP3RONG8-wQNeeWAYvLrICLTJBHVg>
    <xmx:whrlaPgfbwIJaFdWyfqRGnYxrPQr_G0v8S63c81FfcIbjzLfYSN9Wi4f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 09:50:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48ab2dd7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 13:50:55 +0000 (UTC)
Date: Tue, 7 Oct 2025 15:50:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
Message-ID: <aOUavBJ6kipuYcr5@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
 <CAOLa=ZT8TDiA=1cAsnS6RkHL-5J2+3YBorBjKsKWm38oaXt0Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT8TDiA=1cAsnS6RkHL-5J2+3YBorBjKsKWm38oaXt0Fg@mail.gmail.com>

On Tue, Oct 07, 2025 at 06:04:41AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Introduce a CI check that verifies that our Rust code is well-formatted.
> > This check uses rustfmt(1), which is the de-facto standard in the Rust
> > world.
> >
> > The rustfmt(1) tool allows to tweak the final format in theory. In
> > practice though, the Rust ecosystem has aligned on style "editions".
> > These editions only exist to ensure that any potential changes to the
> > style don't cause reformats to existing code bases. Other than that,
> > most Rust projects out there accept this default style of a specific
> > edition.
> >
> > Let's do the same and use that default style. It may not be anyone's
> > favorite, but it is consistent and by making it part of our CI we also
> > enforce it right from the start.
> >
> > Note that we don't have to pick a specific style edition here, as the
> > edition is automatically derived from the edition we have specified in
> > our "Cargo.toml" file.
> 
> One small nit: We should mention that `cargo fmt` is simply a wrapper
> around `rustfmt`, which also handles file discovery.

Good idea, I'll include this in the next version. Thanks!

Patrick
