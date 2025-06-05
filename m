Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926B1A76D4
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749100909; cv=none; b=tJ4FiVal97F1SNdk9feSos5PgnLmmTH49nNVL6E4rBgW3hP7O7gURnLCpnL3AK58RNQNPjP3nDzg7CL4sOJRZoyIBGSQZpKuhlvmrCb8jGzINgjDQUsmaFs0V7URP8cA35wCfOWAI+gcnrI5ddeQxObeqBBceeDGNXTpM8bmsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749100909; c=relaxed/simple;
	bh=gENuRg9fs5zFHPcKBj/3ivgJRJpTf9GH8Sqh066sta0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLmfkjUcn+XVVzvKZQCkPvj+J/Hk39yhvXuCHef6t0b25tG95aAMtZFu4NGNYk+Q5oqpvLuRPiVY1a1EiTPEccEMJXLZ8qsZZwKKAgzDy4Wlrz+XYW5pxqFHiFfNfJFbD5OJTbkH5UMJMlx1/ylFNFyHJFL+ctoegmB7hle/Ppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=apbzxgIy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OiIVTJc8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="apbzxgIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OiIVTJc8"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 104971380456;
	Thu,  5 Jun 2025 01:21:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 05 Jun 2025 01:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749100905; x=1749187305; bh=akilIgS8re
	79csBy+Em50+0KNNaF9lgrnNv9pWt/BAo=; b=apbzxgIybnBEWXwCZJ/mjNFPHX
	yeRxFrQrr3Ix83/WL9veu9AptPAvz3lFaBLBGpKjNZWHRZ47x2zoCBwU0l7jZAKo
	W4Bo0JxZryf4xsyOp+vtvX5zGfbkJ0fMJWFWaKZcI/vu1wEJJhCMKiNJKDPXMdzs
	i4NghvF5WbBB7jqKYo7r30ioteD8qqT2bfTztDEDOOcPMBkfb5VPw99Z2xbXw0EN
	EmkgDJ/WE5nG/OQ3vMJDLeJDpMNyk55MA+xyHQko0nDzA8ZSuYdKou+18ooWcEkq
	LIOHLTx9B4Tb59ZjwgEu6ZAFBGDAQTMBZle2L+o6BS9f00k1n4zQyGIvvycg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749100905; x=1749187305; bh=akilIgS8re79csBy+Em50+0KNNaF9lgrnNv
	9pWt/BAo=; b=OiIVTJc8Ih9NH+S1rYfWXN3BKfOCj0OXgmc/VPHMmKhjbR494Dy
	k0Csv7un7W8wkoWO01cgFcNEPCsji8V4rZ0bmGzYAnqtrfhIuY8NEK1fKlzuqHhO
	yj8wGwIrnqhddz+FRxDSuHkFcDCgwijbD0Vk7M2XideE6UonlzRG5j8TvTB5c3kW
	C5u2MQrtTxiyiilN4LmEC6mKBmXDoQ9FBNWcgppqevcGJ/OZOMKpCw/Eh++Q1GVI
	xle1kC7C5Hw76lxGy8YwLCvZ7Y+jEmn9DDDGtdJ0WAtLRkOTaPxayUebz2fgfakL
	oO5pH3cP1vrLDGpUJRLPqesfKzn+K6Q+00g==
X-ME-Sender: <xms:aClBaHYdWdwAzYqKw801_2u9nrKQrNVbXAA6TE0q5mDVe86m-uonUA>
    <xme:aClBaGarJ6fLasVi9Sh5JrUy0pxVovzy90sL1-o8x5jco_6WdiVFP9dnbRaAzn2A3
    f6NT8mbkAYqbYORqQ>
X-ME-Received: <xmr:aClBaJ_2ST24ouHpD9kgNltdO-HQFHZ5lt1-riDN6Rka3tPD6FuYiE3_aYKo4oFZO_i0qRC84wJBWXGZJmZuXMB7MS3oAPOlR2V-BcAO1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:aClBaNpHiA1vyTFIPvg0o0aCSue6_BSbbC1F5KaCj6tXlD3XTX4Qmw>
    <xmx:aClBaCo40LjNImEhaW4C71UsNkBOKtUauqosiDSLEP7GMH185GI6LA>
    <xmx:aClBaDRCvHb5POGqsIzubTcr30eBBo-gFOuLhyol-Nhu8AysNs21Gw>
    <xmx:aClBaKp5MERNzfeIQwrzW7deOWT5vkLvafLIiKixYbQNXxOOm8NMPQ>
    <xmx:aSlBaHhBcTm2r2qO-9u2CjeTjCfG4HysHk38hzG-AATUxPWJwr7-LMFs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 01:21:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac3981d8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 05:21:42 +0000 (UTC)
Date: Thu, 5 Jun 2025 07:21:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] silencing warnings with curl 8.14
Message-ID: <aEEpYQsE36skWxk5@pks.im>
References: <20250604205505.GA1510724@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604205505.GA1510724@coredump.intra.peff.net>

On Wed, Jun 04, 2025 at 04:55:05PM -0400, Jeff King wrote:
> The new version of curl (which hit Debian unstable a few days ago)
> causes a bunch of compiler warnings because we are passing regular ints
> to curl_easy_setopt() instead of longs. Passing longs has always been
> what you're supposed to do, but the new version is better about
> generating warnings with gcc (I think the type-check has been there for
> a long time, but I gather it was broken and recently fixed).
> 
> I split this into three patches since the solutions vary slightly (well,
> the last two are the same, but my pontificating on the solution varies).

All of these look good to me, thanks!

Patrick
