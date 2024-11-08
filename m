Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5881E907A
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086639; cv=none; b=QNBQWBuVrPYO15e5f8rSbN1LR/uF70EmBw4eNGJgazsF+zMLVyL1XRURHr6HX7DBJQF9neSB90LO9LBcA+xcPw6FWzoTs7mHHW1wFbM0dI+RcGN//VNp7AmIEjG6Spg/yNzf4LjAUqBjKE1p5A06QjQJZK4m3iY5piM0IBHftCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086639; c=relaxed/simple;
	bh=Uz+cFHwXbwM4wMjG3TEZupC4AnFn79Eqko3HEcDkYRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAxRzYD2mNm/gqbTCC0NkXXBJHOXYJd2UoABwDQk6Pem9hevlsCjIkwvKzAdb1Qoi+8glcJuQbR2c6eEEYsgMv610msziH5241ECRE8GhUsaz8OMMSNaKSZ7+44X8Hhbm+DSv3Hyw9UmMRsqROyS7lB08k/Hl21kKOVecoiiI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RVzOITT8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RVzOITT8"
Received: (qmail 13812 invoked by uid 109); 8 Nov 2024 17:23:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Uz+cFHwXbwM4wMjG3TEZupC4AnFn79Eqko3HEcDkYRs=; b=RVzOITT8trzIcRHDhUbCNURfE4QIjHtD6ShgOHJOw9g0EEPCy7hkop1NOp3WGsOnS1TnoO+3uxbhm2EflNLsFldfNB2R8UOUeQfIgB5SsNWjA/CE6L8mxqVoYhlQKcHi1IhOdvTbSrcrCBINuNyINZ8QSVoixRYSzmYKJr4n7SXhwIvxt5Th9utPpSFKHzvstKkXUScrAnVkBYyGz5PSZgxY1FLDN8VW57jqHwrrS/HoCgdj6kY2FJjm1eYgOuLh5Jsuy8QUF2TuMaQ5cksY8DMshp02Yg9o8OR/PCEvwRNfZIBEmBCnhs0P2s+ge5y3ufsqvPzem9sXx29gTyhhUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Nov 2024 17:23:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29997 invoked by uid 111); 8 Nov 2024 17:23:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Nov 2024 12:23:56 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 8 Nov 2024 12:23:56 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/2] t/helper/test-tool: implement 'sha1-unsafe' helper
Message-ID: <20241108172356.GD548990@coredump.intra.peff.net>
References: <cover.1730833506.git.me@ttaylorr.com>
 <20241107014737.GB961214@coredump.intra.peff.net>
 <Zy0yxDIgEmKtec/0@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zy0yxDIgEmKtec/0@nand.local>

On Thu, Nov 07, 2024 at 04:36:04PM -0500, Taylor Blau wrote:

> > So I dunno. None of those are the fault of your series, but it is piling
> > on yet another test-tool command.
> 
> Yeah, I think there was a fair amount of interesting discussion about
> possible alternatives in this thread, which I am appreciative of.
> 
> I think that if nobody has strong feelings or issues with the current
> implementation to add the sha1-unsafe test-tool, that we should do so
> and take these patches.

I'm OK with that direction.

> In the future we can consider other things on top, like dropping the
> test-sha1.sh script, having an unsafe pointer embedded within
> the_hash_algo, or something else entirely. But those can be done on top,
> or not at all, and I don't want to hold up this series for them.

Sounds good.

-Peff
