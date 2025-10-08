Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0E1799F
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 04:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897715; cv=none; b=YpGkwAMlaIQo0/5cpgGFHVZ21AtsEuPbb0nK5YNcwZtSa58EzHWyzHqOSBzLOs5Du848t6Dz8CkyAMFS9z6IBC1Xk2VJOJdoDId7QOZYGNVAtTYs6kPiKbN+RjkAcJ2n5RYzJqvr18ya6M2/DxZRh32LyN+59Kd3AZS/nFLaYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897715; c=relaxed/simple;
	bh=DnwWIHadH8pODn7axAY4NtwDoxEGMXb8L9XeRkozn3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOTTklLsnA+fChKlOAF2kte7y+k1KD3EokigvYKDQAhKNL4cEKjwsTMaXwlGYGqx0dBuYNt4ufx9D57FlN84st7zDjMfAcZvbhnaR5eVzDceUWyU2CwPR3WrsQME0THZSczVbd5tT/N3R/p/yb+2jJhXfelGAih6mhI1/BbsE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bwSznurr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SfazEBUZ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bwSznurr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SfazEBUZ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB20D7A0134;
	Wed,  8 Oct 2025 00:28:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 08 Oct 2025 00:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759897710; x=1759984110; bh=KcEtHu1sH8
	sASMsr8VueyEPZ/mGd5rsAfAttWqWyoQ0=; b=bwSznurrSjT+o9ohSiY2Wxxy6X
	kO0c1XMaNOmaAFUq62jhgTm5gy5E94DZKxPRIJIwkGILHanXGOWtsASIdCBQH2dC
	nhsLU1Ogmz9QYQBsOXAndBpg/gxnTz66X9vCslnEDbQ/NIFZCFHIWI9OYc/tFsq7
	0trkGNe59IB6AjJTZGq/OPalRGVpQk9Q62mhrJBQW0qdXzeahZTb48RaQijd1ql3
	5cGEKuDW+DNQ6VWq8V3/bjbatO1yKjf25jSrL1o1TOPe5N/72c+Wgvlpdj/pNuph
	zY5771YhwtvgDx+ASEKS9up6WMR7RfrJAhpC5aAtMN5fR+uGLYDz7pP8Kg2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759897710; x=1759984110; bh=KcEtHu1sH8sASMsr8VueyEPZ/mGd5rsAfAt
	tWqWyoQ0=; b=SfazEBUZF9gZRC+mTXtjOctf0zqrRXrxDRO95Bx4uFyT7ZTfVom
	w7XXuhAlPXGJIjxCkKwvFxxbMWSyi8gdc5oqpMMJfzm0IxHeLANXcZYtJmHgEoLO
	f55x9naumx04UQJOjRDgq/tw8dx5UWkDGz7rn7n8XmjaclhUQsqiLWIWlC+tHCz+
	7AK/erSLQHzod1Wmo7G/zMfV6J1hNHH4yY5srnYIWAMVTsanFIg1+oFkvz+24SyU
	93q4HZ1YnUAmY2TTzMABM6SRZoRyTzjGYgeCjHQX7QIHJ1uDyYURO6k6PeJ4fkUa
	2gEI4wPu7Ctxn+NoT9eURHKQ+k21ck3WoAg==
X-ME-Sender: <xms:bujlaCYrz3LL_GKdAjNz7zoeVP6yJwI5wE-0wuPJY9_Xfe4LHuDn-Q>
    <xme:bujlaJHEcrWTJk3oem6qDXS8MNxXiVNtfNqE2f-h-rlvK7eUziU5SWo6obLY10kcY
    YqpB3khKpAorzvve3Pup7UEQKWcUim8Pfx1abTbSlnpKte1MyGTbw>
X-ME-Received: <xmr:bujlaGxS55oIqgBcknmRLubpo37TkCAopik9vdXJUM5dd9dKeBBCZ-AUYLXKxTdEW4Tp-juSeTbsBlWcOLl9OHpDbrrvNkbTloykdgtF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bujlaLmPCFClXnPcylKYyKw37OrkoC7idQ9k-rs9mpz_7OI8zbjpMQ>
    <xmx:bujlaPk2xxdvC9dn-VZxNet4kvz45SRw4APMyKleM7WDldsN60VXkQ>
    <xmx:bujlaNw88kVqn-4bmfjlCHGY2AhjXDCWnVr36ed_HQS1tFO4PbQgFg>
    <xmx:bujlaEoIqlvv1nT2W2m_2loFlku6oafpljlc1U0pa28osr2nkznmHg>
    <xmx:bujlaN1C5fHFjDbUE94Ib-y9lndjdwuKfZeTRbzbzBNJIwhe-sr2Z6F2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 00:28:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c500a672 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 04:28:28 +0000 (UTC)
Date: Wed, 8 Oct 2025 06:28:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 21/49] builtin/repack.c: factor our
 "generated_pack_install"
Message-ID: <aOXoaNYoauCg0CpV@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <96d27261e75fd2ae46d9633b3d4eff243dbcc187.1759097191.git.me@ttaylorr.com>
 <aNsUiho56-S4MQZg@pks.im>
 <aOV3cuZhab7xOdez@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOV3cuZhab7xOdez@nand.local>

On Tue, Oct 07, 2025 at 04:26:26PM -0400, Taylor Blau wrote:
> On Tue, Sep 30, 2025 at 01:21:46AM +0200, Patrick Steinhardt wrote:
> > On Sun, Sep 28, 2025 at 06:08:31PM -0400, Taylor Blau wrote:
> > > +	for_each_string_list_item(item, &names)
> > > +		generated_pack_install((struct generated_pack *)item->util,
> >
> > This cast should be unnecessary, right? `item->util` is a void pointer,
> > so C should do the cast implicitly.
> 
> It's unnecessary, but I dislike implicit casts from 'void*' to any other
> type. This makes it clearer how we're supposed to interpret the value in
> item->util, but I'm happy to change it to use the implicit cast if you
> feel strongly about it.

I think it's common practice to not have such an explicit cast in our
code base. But in any case, I don't feel strongly about this.

Patrick
