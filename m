Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CE39769F
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643143; cv=none; b=mu/dlvZoQckBmQy8G1SHYb/50szqdyQmJ2jRAm0XfGaS0ZtBRvlmviEn5xqbL0/X1kx/UrICS+ER4MRWOPXnA4dg9QaEk9cCnPHkxnM1rwldIARvxa5deKCDaHwP25dYfbPC0dbSAA+inJcz21aWTY2ZWYNip4b8pJaJm0Kv/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643143; c=relaxed/simple;
	bh=mQdCaD27maXk1jiaACvgvWxBGfnhfnwYVeuLAPaUipg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2ABArF67+2a5IzfvvVeCzULBa5+6mz4gCU99XgNxRbJQKwSxLbMPS/qamFCGHOh+d7ScxkKHCFhK9n8kFx5mHIqDT2e1uo2E5qEb+bNk78CZcSq2vP0Xu2mw+D+VBMHoRFXSr+/wEf6v6rnB9VTY0HmDNIgRkOOEHS4CDG64yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fqzb2/Kp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F+aPow1T; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fqzb2/Kp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F+aPow1T"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D08B21400073;
	Wed,  8 Apr 2026 06:12:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Apr 2026 06:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775643138; x=1775729538; bh=CXYzj7ho5w
	wQA3SBeLnRsVt0S0RHdM4rMVIEOb0bWdA=; b=Fqzb2/Kp7kBccTcYkM/hajmayr
	6JEWq9irMnjHZPez8Rsgz9LqQtD5qTq0LaNqhaQsTJ8a+D3k2K3UA5RNY9KoUDK4
	b5xFCBkvYnQzO/aH/xN937AKaigF/0UDZvpIr3vtYv95mM0Xa5m6Pz7h8ATJkatM
	zQMAmWr3F1+M9KJ8vV1TslBJq+mmXywnTlh/swJ5md1deYwndKYwVw604Kef8uqM
	aW2KzFtZiQgW/wZKk2NHZ3QTI1zTUvC/dMT5802563no1UUKMsgOQQZDQDKtEP3c
	+/gjKINc7nrBgXtF1bwiOm1z4kTT6GzHul1nmRZIGq7R2SdzresWGPMzKdMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775643138; x=1775729538; bh=CXYzj7ho5wwQA3SBeLnRsVt0S0RHdM4rMVI
	EOb0bWdA=; b=F+aPow1TQVQZTovyqYIS7LVHeLhflA1pDBKDVsV/0uufjXEVUpg
	NxbR9JjFQ5biOnNHNR6WzImiDYeuk0goIOq7EW1F7dnPIEkmD9fTwTzfbtAQbmqg
	sWlFkYnPwTA5fpVWRd9siFJxwyWDqY1pmiA5/x97SYCeVBls6cyrsFDTvyuTmIwh
	hENoM8+G954ZckQRxeRwbjsOgcGdjADUJCD8A14nA6ai0MH7lvB/bBP6FnNUTDFx
	uRhenB0TatV+0nZZ53ykuDjwenjxNum0z/98Kr1UbmZHFSzsyNtBvARB4EhAyBXA
	Y2qtTl0bFF9y1BKqEqY1rA9zvZMjkusOnZg==
X-ME-Sender: <xms:AirWaSHLUpteIDgMmSAR3VL9ndDXahxypJ2kCBb4WFOkjSNKZyUI7w>
    <xme:AirWaaXjWsjAcz_2WtgS5kTOi6wQSiqdp4sHdtmNp-jF8uHXEelQGwUttbhoJBoWU
    rGmFhxNxBkNsFo9JyNISsYCSn-0VLWvlcjEyYssqbftOvY75jBs>
X-ME-Received: <xmr:AirWaRI5P1f_jU9FKl6rX2ee8xx7xqfi0ND5-ehYM9plgVSVVc8mN7aT1cguHJUc-lr25OgeAONUCjVb8Xr7LBraj85fKDWKLY3bGqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:AirWaa-G6QRDrBYyG5HlzI6IBQ9W-OPNqDpzMrryWI1HksBUbWmr-g>
    <xmx:AirWaULIBH_K8L2omLiNGoSlIIHwsb4O4v4eD_CYXTRYzrU4JE5AYg>
    <xmx:AirWafndYoiQ_H8apej18TX-fy4Df6CAMXCkX4bgsR9E4DVX2Zj5Kw>
    <xmx:AirWaYNM_fx-Y55qKkJRAjfEv1VI2FSmbTq7zXZI13Okc-ia7C-5rw>
    <xmx:AirWaT5Xs0hO0ecB-7ISgtFcVdkgZGs9l6dd3dImmfoD3LGFoWzKnwGL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 06:12:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1063a3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 10:12:17 +0000 (UTC)
Date: Wed, 8 Apr 2026 12:12:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 3/4] Linux: link against libdl
Message-ID: <adYp_l5-PxzQdqRb@pks.im>
References: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
 <20260403011249.4133372-4-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403011249.4133372-4-sandals@crustytoothpaste.net>

On Fri, Apr 03, 2026 at 01:12:48AM +0000, brian m. carlson wrote:
> Older versions of Rust on Linux, such as that used in Debian 11 in our
> CI, require linking against libdl.  Were we linking with Cargo, this
> would be included automatically, but since we're not, explicitly set it
> in the system-specific config.
> 
> This library is part of libc, so linking against it if it happens to be
> unnecessary will add no dependencies to the resulting binary.  In
> addition, it is provided by both glibc and musl, so it should be
> portable to almost all Linux systems.

Fair. I was wondering whether we should make this conditional on
WITH_RUST, but if it doesn't make a difference anyway I don't see why we
should.

Patrick
