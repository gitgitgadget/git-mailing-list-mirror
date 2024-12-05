Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE72391A4
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391199; cv=none; b=NFs8vZ7OlCe+OJdTNFapytkPyxr66IugmEK3KbMMRi3dHeliZ72cTXd2RmUPGxtmAkHGSQlTFUx/kBL2lUZCX168QxrnONBKZYUY8EicLf5aDyhJX+axytOPMCocqMlEcv4zOyxHROVyXbazrhujKwuBaWrAaoqFLLvZvRjtGQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391199; c=relaxed/simple;
	bh=zgqeF0JOESd7BRhTdZQ1x+SGkJzjvHngGteFjT81dek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdX6AwJEvxKYK8Y3I3PiZFg8IDkvN37MmvDgwdxGgJMRTfHhNg4pQeVoRM+42ar1NbduT67n6ZXVawU6kxqWaMFWBzKn51bOyvIYc+F7HxZr3uyrdiXOdF+pZveKLvoeFD7aHaV83WGnZRPitec46g5jMml1g2gy4/ZeTaH78aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nsjPbgnM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X2P3YnWm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nsjPbgnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X2P3YnWm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FDFE1380975;
	Thu,  5 Dec 2024 04:33:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Dec 2024 04:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733391196; x=1733477596; bh=QB7sNtOz76
	OeFDvNuLrQn8PDVhCtVGxc3ft1KENr4ds=; b=nsjPbgnMy4diLfen5+mKbdD26J
	mcBb35oAFp8KwozDgwyM7KJNGPNAy2BF6gN86VIHRfpoTu5Fa+iRtvivU3DjLdoj
	ijaZDD5V0XzXI35LTxhtBPrNEiOTzi1MU1bTT4FrrlwuFZS8BIS/HjMkWZidvxyf
	Gf7NYMkFUfg5PVzR6/iHgP4PGJ7b75FjQgmRjs1Z4h2f8MQp1D04zJ8tqNwCrlAu
	O/1Kf/ZyW72BMWQYrlgT4SQfDCGXtDuINMPW9kj5NH72+t15u/8xn/KtTjpyut+5
	+AyXNfI4QOv/YDOpnuWP+JnMjlN8i4o+8sw9NzGD03qIPvgsOJip/Etl8ysA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733391196; x=1733477596; bh=QB7sNtOz76OeFDvNuLrQn8PDVhCtVGxc3ft
	1KENr4ds=; b=X2P3YnWmeXR4K8frTmUNcRtRmBIc5kVJo21k4hoIWeK3DbwZl4E
	bY6Zt/hRWN/3JCrgso2DRh1W3by3At3FmBr3/S0O5nqYHBvW1/v8zDyRmw1ahAfL
	VjYQSTsN/cpqOhQE6DwHezgxAV+Xxu7heLHaJ1Md7xBn52WyCJCEHUTBn6uI6Esh
	yTVFlFrc2gG+6aK9e7lgVZgTJ8vshBezItxA8GGITdNi+Z0nYBk9dsOsL/gqgppK
	/zEf3T/11i63jD1EVsSfzAk6kBYbSuzO8DLogedVh7fcvkd55gwr2p5xWJyyGQtU
	WRqPflcnr6XJo5rg9WJ58jdocHVJnAvwizA==
X-ME-Sender: <xms:W3NRZ7A-2WwqUlLnatXpj-rMWiSm3vf4NSXxECJtblMjtSS8yrWzgA>
    <xme:W3NRZxjtBzmjiy30xjztQqYh-oqrFILcffmtb69La2J7Apfoizu2_Ld5BNjcypYxg
    EUNoZ5A-InagbJ7RA>
X-ME-Received: <xmr:W3NRZ2nb48CQBS0ARW42x_w8cL_LazCIekh2ayRzp_MoR5yjRk6gMV762opaWgrVj-pFTDuegilLmOacuILQbZdpN3iVpdokKx1cM5pj0eElLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XHNRZ9wt1G9NPTtrpTR9s0CJgsq_1L0nb4-Y9NARJ7SVJU6wc9EZlw>
    <xmx:XHNRZwTznomdZ_tpY4Vl7GZdru3JduCjvYA5wxTs_N-SxJ0SUW80HA>
    <xmx:XHNRZwatmWe7MlOAXtt4YGkfS5nIWvgknd3W1hnVyCShYYvC_OoG-A>
    <xmx:XHNRZxShB1Z9h99evd7UxFA7VDa1sN5f9qWcj0rKBB9uIrPmKttdXw>
    <xmx:XHNRZ2O-3NwuOY4g68lvQdvhCbpuE6XYm3_ZVzXBkA2Dl2pFzgSOzBQ9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:33:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d7a71c07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:31:50 +0000 (UTC)
Date: Thu, 5 Dec 2024 10:32:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, shejialuo <shejialuo@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] sign-compare: 32-bit support
Message-ID: <Z1FzRa-At2a1YsWi@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
 <xmqq4j3k3sph.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j3k3sph.fsf_-_@gitster.g>

On Wed, Dec 04, 2024 at 02:47:22PM +0900, Junio C Hamano wrote:
> On 32-bit platforms, ssize_t may be "int" while size_t may be
> "unsigned int".  At times we compare the number of bytes we read
> stored in a ssize_t variable with "unsigned int", but that is done
> after we check that we did not get an error return (which is
> negative---and that is the whole reason why we used ssize_t and not
> size_t), so these comparisons are safe.
> 
> But compilers may not realize that.  Cast these to size_t to work
> around the false positives.  On platforms with size_t/ssize_t wider
> than a normal int, this won't be an issue.

Thanks for the patch! Will include in v3.

Patrick
