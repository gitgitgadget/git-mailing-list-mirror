Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD411DA5E
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808770; cv=none; b=HPYnf/y9OOZbZUpvUiuqDcA5zzM44Vq0b8PHS3LDi9XsdnRpMPslz1p8BgYHvAnq07J0l4JVcK1MV1GMMTS3vhwSO/M4fO1h8WLHj3Oe0Y5oik+wt+sAYwG3oP12OhRNyDBg6SdLEHMNJuIPA2ZYW0Wp+CfLT3SZP4SXA/b8XEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808770; c=relaxed/simple;
	bh=otBdSWe5UU2NZJXUWMvO8SahU7zKfhHcAVrvy8H2oEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7+Ms57PUBYq2/OdEfXijS16PyLCsKuitU/hS1N3j//66wPpNGBFjUk/w4d/M3R8QiobdGwWrMCUew6X5I/iicFCEP4Yvw6Pvq2u/CYbz9+MSV0ndznFhyN9NdqrC+zM+2/mUaBQk/YVMOwzV3Mds37TBgJj9M/t7irlGwUL4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 10173 invoked by uid 109); 19 Jun 2024 14:52:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Jun 2024 14:52:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22159 invoked by uid 111); 19 Jun 2024 14:52:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Jun 2024 10:52:46 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 19 Jun 2024 10:52:46 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: 'Dragan Simic' <dsimic@manjaro.org>,
	'Christian Couder' <christian.couder@gmail.com>,
	git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>,
	'Patrick Steinhardt' <ps@pks.im>, 'John Cai' <johncai86@gmail.com>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Advertise OS version
Message-ID: <20240619145246.GB957055@coredump.intra.peff.net>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
 <0448495385b009f25a66b0712afb28f1@manjaro.org>
 <20240619134533.GA943023@coredump.intra.peff.net>
 <04b714d3e949c30bae0e26231e923fc4@manjaro.org>
 <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com>
 <4ba6dececcfb3dcec5c8b7e64657a1ff@manjaro.org>
 <000001dac256$d804a510$880def30$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000001dac256$d804a510$880def30$@nexbridge.com>

On Wed, Jun 19, 2024 at 10:41:54AM -0400, rsbecker@nexbridge.com wrote:

> >A configuration knob that would allow it to be disabled entirely, or
> >be enabled with more details to be sent would also be fine with me.
> 
> While in the code, can I suggest including the OpenSSL version used in
> the build? This came up in at a customer a few weeks ago and they
> could not answer the question of what git build they were using.
> Turned out it used the wrong OpenSSL header compared to what they had
> installed.

At the point you are dealing one-on-one with somebody, I don't think
protocol-level messages like this are the best spot for debugging. But
it might make sense to teach "git version --build-options" to report the
openssl version.

-Peff
