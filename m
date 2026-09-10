Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AC4CB8A7
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057245; cv=none; b=kjjyIAX0RMLOA7LcaoUZOhw8brlZa/p9l9gcX5prWydBmxzzp3LvlCHj5TzjQPlEHc2OwCDB/K1RjKmh84DRcUwqLjt5C9O1FNrvZF9vp2s5Aia0APFTHR9/LRmp37onhixw9F+bFTmTmhGAC0bDPeYyqDatVcDredg0JFtwwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057245; c=relaxed/simple;
	bh=2uVmPAsIGFtLgE5UxaF37fktiyI5sqn7s5zdI74bEto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P3yrHADUg4lyXi20PZoO4sA07N5QJELzWAbxqXPjbqS+FCG6SzhDtsD+PBKdDTx+xEGGXHMICqWfwTjESIQvsmszm05jUbecIMW23csu9W1pivfRWIVyHFVwqcP6J506hBClbVHTmKcJ3EKXn5TvXz/cdajEXT6PYtfU1OOdFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lm4kVKWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GnpFoGux; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lm4kVKWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GnpFoGux"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 155CAEC0393;
	Thu, 10 Sep 2026 12:20:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 10 Sep 2026 12:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789057243; x=1789143643; bh=88xWX5cIXv
	lA1FQKTStYCNxTXbAoy94iUoZLpqvWWDQ=; b=lm4kVKWokkce1f6tlSU56l42ox
	SU3bhwOLieZALduABFHIzg64yVYIyJJAKYQxulp6Yucqx09cDtdp7eJJp7bidifF
	23iLllaKJdbIrz2MT7Q89zNdLMcqfZTHMCQesMicCIwVe+Vsg6x9SZo+ggXffXcO
	5y9ifJJc2cZw+njKWAtJ2mLmt/JLOuMhHrwE/KNpytOwGrhaa650qS3Mw79yisrp
	Hb+dVETZPKIevf0sQvcUY+Pdq+pHK7PrZZV7m1IJfSpr4NpXdR4nntDWwT1afKPI
	O4rA2rLmmZhZSXCkL23T6CfMteYIeppJt4oBVX92E8U48jVyYuhVp57TXnog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789057243; x=1789143643; bh=88xWX5cIXvlA1FQKTStYCNxTXbAoy94iUoZ
	LpqvWWDQ=; b=GnpFoGux+zjf4wCk7AwCsYZ13zxMQEYA/eMmvQmB9EA2KSS01P9
	eo2P+GT0Numn3oZS0DeC3k8vagat+n1vVi3zja6UV8vrRlhWM9awmiJgjqp8u8lh
	V06cpljlDwVQLkGoc13xtu2Oo9Hg+S8ha07hncoJ4tmaIMfH1znxCaAU0RKYt0Ar
	YdAHQsk7rhFNiQLax2R14Rih8sisZXmYB0dzLXSSlP649DC2kLOo2OGgvBDMzGDz
	ICwOI69EFYovDZi+xgZU7XA8K4ZYCqO/6LAI5NKB536TViDi/RSsnEFLt148Eajd
	+J9UE31KppszPEuFZw2fgEGzqo76OQWV28Q==
X-ME-Sender: <xms:2tiiakgmKzdRK3sde_6jqIEmMq1K22v48KdOplQGMhmjtBCI1_grvA>
    <xme:2tiiags-lfMNPKwt9BWtXpbCJqhL0V-zp-PpyyO-La65SLtLC3VtIvBvqy9dc6G2B
    4MIX_GSI4pNWI1ZowRo6gBboyP_end7LCVoaKlH4CAagP89cP_tw1A>
X-ME-Received: <xmr:2tiial6nMNFtH7vcZd44-rS_XWnrTmobR8RO6pSgV2eIgFHjlgp_RBj3IRmFJe5AHWaW-U1UTRCmjyty2c1pnQ99kV22Q3GlfuGY>
X-ME-Proxy-Cause: dmFkZTG2U/qU3MHVC/FTjzM/cdsvED2c+b/Otn9BHBiV2jpOYQAcXrOxZUaPzFSqD7MOZ4
    GkOcALZ1PBE4uZQWvPhNV30gI8pdWRohh0tNRJv9F+t/HIYY9/nLN8eu/XuAxbfXAIpJlb
    ybGsv7LWNqNqxxdL308+nA3Q+Ds9zwrqW+vl4ikB8+kZ5oqNIrS09/eyq1Z0aQcmCzNy4u
    9qHxqyWMHjtu1QkjromgYIXtUGQVqkoQpukLLxb82ORJxDY9rgqmEc/YqJ7r0eUrEUap34
    pcMF7uQkVuAFv7rqAw2VcMvSgHD4CpBTqIl2V6jJ0Y7Su8dE5OTuVZfRcFznq7SKeUmYcF
    /PzqfUbriQytKYfeKEj5Vfg860wpvKhJzsf70GEEdHydW1Qtwsz7mP9oLLptw6PbLwsYDN
    qKje5j8gcVtGzLBODsHqJe4+6/0RGlvK6Cy0AdicyRYrTHlf/RAR91/ZYpAyHQpHqmu/I4
    Ge9dH/aIn6B8Bi0bt4w/RKPreRZD5awTWEzYQ5ROMaI7JJQnyVvSu0WqhSLi2yMMc7ZMB7
    FOfw5mu51L3/cfPiFGC9YYGY49GFN+OKtYYWlyu2B4hxmSrbdxmCrOhtQGAkw36SXgO9b0
    A91CQSH9DVSOvCXsqpNqQuNZgXCRNC2Rw+BikxmxPu6yPT3Eu8OlrFk6hl5w
X-ME-Proxy: <xmx:2tiiasMmq3omJqgA6bjcGuRwKHErJvouzwnltuRkqLxuupEGa84FhQ>
    <xmx:29iiajuC7DtzSKKSC8zpwQskHAQRT3-Pl-lvkoio533B4TBSyHzHgA>
    <xmx:29iiavaTSMhOMdr_viYmN_KXp7w0VQvYmJnM_kGptApSIUk5iffYWA>
    <xmx:29iialx6pkSANFUuhC5GswqRI3NNEdg5GH4gwD3JfH0CoYEAlPQaEw>
    <xmx:29iiaoIfrzsVALf7M25f63WBy-w69mNNwJvfO0O4jAZS1I7LEoQBADbR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 12:20:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,  Git mailing list
 <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3] builtin/history: unuse the commit buffer after use
In-Reply-To: <20260910160254.GB251185@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 10 Sep 2026 12:02:54 -0400")
References: <xmqq4ifxgree.fsf@gitster.g>
	<20260910150021.348548-1-kaartic.sivaraam@gmail.com>
	<20260910160254.GB251185@coredump.intra.peff.net>
Date: Thu, 10 Sep 2026 09:20:40 -0700
Message-ID: <xmqqv78df57r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I'm not suggesting a v3 with this wording, as I think there are
> diminishing returns to polishing commit messages forever. Mostly just
> food for thought for future patches. :)

I obviously agree.  I wonder what my recent favorite prompt given to
a nearby LLM, "State the same thing with 1/N number of words"
followed by the proposed commit log message that I found too long to
read, would produce for the v3 message.

I'd use N=8~10 for this one ;-)
