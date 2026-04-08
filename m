Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B639E183
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643138; cv=none; b=dCpjxrkMXvQOFUfGfWNV0IiR3xDLIA9wdpDSujXtKVcFm2VA8Lc6+fBIIpPlPTjqfkDBQvtkS7IVa3Xd6nv8qsBC1RUfVShVyveW2i9AkTdZXjndY22yYkY//lAmgtez4MtuMS4c5UTLwSPLlBLN7wNs1CoAocV3wBhv6F+KzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643138; c=relaxed/simple;
	bh=JRCGlzOA9Xf9BlMKCPD33UVpQveB9lKfR9u/NJbWfUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcLUPX1/keUStsq5A2WnCMbga9i8W5bFwhXG+8nKYoyGH/vx9fVrd6712xyG0/ZOYRYaZXCiFTt0rSFXc97i6CjmEtcmr3wO3FhtCsWo70l4Htb1AWz1HCIRivtj6mVouR9kkpR9xGlNJRsYg3LhJ4t1vH/Et5NHf2+LvlI0jts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DRsxFqQO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dGrhFYit; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DRsxFqQO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dGrhFYit"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B63C114000A2;
	Wed,  8 Apr 2026 06:12:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 06:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775643133; x=1775729533; bh=JRCGlzOA9X
	f9BlMKCPD33UVpQveB9lKfR9u/NJbWfUo=; b=DRsxFqQOGmy70aVRcUKp2uWAl2
	ENvqcjU0P2w1rrM0PM8iPICNluiW/W0UFdyxEwWpm2d9I4wMgRBb36fDkw16mJ6i
	rjrAxyU6oDuw7LJzn6KuvkyIj8iZYJzZkEcdxh7BFdjLAhWAyo7Dhk9Xgq9KH0a3
	rgQBEHkh9XDyj0/ohskZnjOgN0LsPnmoJh6ESC1Qdmu+lcIRmWoQ1ptLiH34qqgB
	Ca+2KcRJ5M1vBIBWCc96OeivG/0hangNxfQvTihX3c0WqNTv/qLZRZYRi4tGJ5I7
	eQKzIartr7YpcHLqkwSIATeLgKGaEfP9d5mrSR7k+4ZHvEBR2vKvJB0I485g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775643133; x=1775729533; bh=JRCGlzOA9Xf9BlMKCPD33UVpQveB9lKfR9u
	/NJbWfUo=; b=dGrhFYitaJwLlTY5RzFTduz7xKPtATtieDh3tblRizJOab7naKA
	lZ47dKtWBPY7oioppgKYPaU+twjhHGAywddedYlO/qmq3z1brKov9Qt/DL+J60L+
	fYlatABqdVjLZ37+Vx9QMTWplkRyTVZuyTd1Agr14mZJgHrbBBrqnL6IZko1Ad0Z
	+xHCshoTz6m8ezTVXk2G2ntgg54WI7Na2OH6cFHuiMThlcn2XulMETHwHvUqDiip
	j64I0ehWDnYTan/3OPCQITFqPfDVF3ZdMGu7jQEk9PV6aYDXYzszXJNRymgugrtA
	R1YJ7aah0Ye4mWeADm4wEuYlrQUfvWwRZoA==
X-ME-Sender: <xms:_SnWaf_xUw9GBcsbvF5FiWrCo8BSsqRZxUXxB8W2rYHs1IxnyJrS_g>
    <xme:_SnWaSvka44YTSbs2gCOAxIhoitTtPkutaTF5VVGlt-l7qZNOL_r5cIZkGVq9ky_c
    GKdJz5vgTeq6l_wrx2Dtm8m_cMyZ0K0CeEiDRNN9jIh8x7JDbeUFw>
X-ME-Received: <xmr:_SnWaSDWfKL0pQ-7soYvv0kMU465cLHyNkOErdtxvRLNsqWfLjjII3Lzgg0uExe3Z0bo7bs9z4b871w4m2Q-xnvrHwN3M0b41l-dddQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:_SnWaaX5J1aTzwPGoMQ3y7uZGLxUbCUpWYYB-P0ShLyoNcafd6aMgQ>
    <xmx:_SnWaQC_rICVyVkXXVioPuKw33nSJ8BzSs3MfVyEfc9m1hCKrSOe6A>
    <xmx:_SnWad-gvV86Y8OYd8nAcXEO7Eg7XSL6N8hZPBQn2VF1uGx0_5FBaA>
    <xmx:_SnWaXHsxFmT8nla1L9ob3Bf51ClDlZQSKq8gSnK17xsbEOUyOYq7Q>
    <xmx:_SnWaVztxTEdECPmK5xnF4KhF9Fl-_aJ2JjSMDVMj8oWg-5iP0ixMfkm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 06:12:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0a73fe9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 10:12:11 +0000 (UTC)
Date: Wed, 8 Apr 2026 12:12:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 2/4] ci: install cargo on Alpine
Message-ID: <adYp-I_VLV7S8RQP@pks.im>
References: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
 <20260403011249.4133372-3-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403011249.4133372-3-sandals@crustytoothpaste.net>

On Fri, Apr 03, 2026 at 01:12:47AM +0000, brian m. carlson wrote:
> We'll make Rust the default in a future commit, so be sure to install
> Cargo (which will also install Rust) to prepare for that case.

Do we have one CI job that runs tests without Rust? If not I think
we should have one so that we can verify that Git continues to build
just fine without it while it's not yet mandatory.

Edit: I see you ensure that we do in a later commit.

Patrick
