Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56934C150
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872821; cv=none; b=iPDzKsMrLm9ijTFHLtpCiVIYBV0nJNYjrgQxNOn+pJTGuHG63tGbF1qDJQA/0pRW1RBs4z1B5UYBj4FdTeN6eUVjFIUHM89gEOcc0nHavAfcNIFObAtx7q1PECC+TLs5cZlvZqjoLE4v7i22nb4aeUR8Q0s3jo8iyEk2l7ofjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872821; c=relaxed/simple;
	bh=ups9iTJ5041d/lm1CLWVtAU1sdLdmu3EueJFHp55lFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2vANyBYVnRDSAOUWvFDxnxLk4PCbXIvnZwa+BlhZ+4eDWsDf7YMdX4sWLsun8UT35d8XsxARr+ePBjt/ibCaBq/ovxlBLoNSmsoJldmPna09HW2rdBaEBjh5W728AycvsHtAI70vwyhoclH3caDMcsrvJ1bdCj5dX64S4vryD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S3rZqpnw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QkzSL5b6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S3rZqpnw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QkzSL5b6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 46B007A01D3;
	Tue, 16 Dec 2025 03:13:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 16 Dec 2025 03:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765872819; x=1765959219; bh=ZUi7hAYfYq
	LV5lplNsB73OE2q53kWoitHOzh8Z3ubII=; b=S3rZqpnwu9VaKaYM5QO1gj/TgO
	83A9N0i1CF2fiOYDEAk3g58BZWkaVLLmvSyzuTSzwpOyO1fl6AjfF8jMQoiQgy2s
	azyHLkFMQKZ4Yc/OYQTD7ZSLZUNN6oTidX0AtGRmL/RDtN1XG6txZZ3GHnaOuabq
	eQIMjkN4TPt9wzOMxNL8VP8JK4Pj2GsYd4pzPXN7le35oNiBdhOT/ThnGxgc3M8a
	UW3oZCp4FkpMoPmx0kHVOn1Q3J7z7JROtKsTeISm+4AML9uSYbP6elsSYracgHfB
	n/ACB/fBcT/WgcbvW2UXIROO2GZ7vafeuHKHzQ6/qkeYy7oaiiq/akGK2SSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765872819; x=1765959219; bh=ZUi7hAYfYqLV5lplNsB73OE2q53kWoitHOz
	h8Z3ubII=; b=QkzSL5b6qraqyp8eMaCrHAy9tPjxcIiyoo+d37T0I9BC81fiTfw
	gG9QzVfdmvuBXz48PDYLswpyQjwYCXlyRYHEptgq2n0njn0YgrnDhGAHxcxYSQNx
	1pKOvjFLxrLgLGZoHzfsK/0GkA1HIEAsPJCRls7ZeCwWS0vLNMlLbah6N/r320uI
	ve1eJHTsq9yZvq5D/3qu0OywqiQZpGZo6MBYq2egH7eqLaDjsgpgblE/IfqpWb57
	+rDzs23e1DtTy81fBsX2f69FYJGUDMkglQO4rph+nSOPv41thswJ6w5rfM9JkPrr
	SMNPEou/L5H7+RSHewMeyNt7XxwMeo0o+Zg==
X-ME-Sender: <xms:sxRBaaMgZczGK55SF1_xxtBGUaF6clsjCiJfM3AmFU6HvyZli2iT5Q>
    <xme:sxRBabg3WYV7qfVyFY3gCl_kGoZyKZ9-1kzLwX7FobtByveZBDTbCYwsmnhmilF-q
    HNhE-zkNNIJxdlqGObgwYgkw4fv4Iy_CKmw5xxvhFOrSkG8PzrXaA>
X-ME-Received: <xmr:sxRBaU7eyWOD87tmC6S4JofatGjtH1Kg9ysD3GzGEDsFu1bbwXHfTxZuAOSLVyJ0b5jSt2oPFzRM6coNk2-JUvKFGJe0deSKCZZxBpa6VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhgurghm
    rgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuh
    estgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:sxRBaa1wInxPONmlPKcj3Ljkku0YPNSftHA2mgZ-hJCA3trZIuUFqw>
    <xmx:sxRBaXuX4TL494ea76WH8qRohNaXov9KVURR6mwvhu4Xr2mxYIT5tQ>
    <xmx:sxRBaY63K7n_DEQWIDZ4P-alwfNjGHTTgChvFhmkxVCpOENQm0177A>
    <xmx:sxRBabe3dUJzznDaR-MsoNUFMi6beR2AeD8u9W6K29SdZ89caAk6cw>
    <xmx:sxRBaUDe0w_bJGsoRHcz3AMyo4yMyu0VRiK7-AArV5E1kaxcCl0EguDV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 03:13:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b682f34e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 08:13:36 +0000 (UTC)
Date: Tue, 16 Dec 2025 09:13:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org,
	Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: What's cooking in git.git (Dec 2025, #03)
Message-ID: <aUEUrXFaAfgzSs12@pks.im>
References: <xmqq4ipwc7y2.fsf@gitster.g>
 <87ldj6x1ys.fsf@gentoo.mail-host-address-is-not-set>
 <xmqq1pkv5gpv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pkv5gpv.fsf@gitster.g>

On Tue, Dec 16, 2025 at 10:59:56AM +0900, Junio C Hamano wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
> 
> > On Fri, 12 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
> >> * ar/run-command-hook (2025-12-04) 11 commits
> >> ...
> >>  Use hook API to replace ad-hoc invocation of hook scripts with the
> >>  run_command() API.
> >>
> >>  Will merge to 'next'?
> >>  source: <20251204141535.1986263-1-adrian.ratiu@collabora.com>
> >
> > I think this can be merged to next, since the latest iteration has been
> > sitting for a few weeks with no more feedback and all tests are green.
> 
> "tests being green" tells us that with the current coverage we
> didn't see any regression but not more than that.  Especially, it
> does not say anything about the quality of new code (and test) and
> if it is in good shape to build on top.  
> 
> It also is very hard to tell from "no more feedback" if there is no
> room for further improvements, or people are simply disinterested in
> the topic and are not tempted to spend their brain cycles to help
> improve the topic.
> 
> If there is no more comments, I'll try to see if I can block some
> time to read the topic over myself with a pair of fresh eyes before
> deciding.

Thanks for the ping, I've now did another pass through v4 of this patch
series. It looked mostly good except for one question I had. Depending
on the answer I think this should be ready to go.

Thanks!

Patrick
