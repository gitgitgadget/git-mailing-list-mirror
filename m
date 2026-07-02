Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CA3B9942
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030742; cv=none; b=sPF5KCqljrhDCeNS38278XwBNoQEE/ufZxMVE7Znl6OWO48P7ul4bki+smDzEnGGHOoxR3HQOJXDREwRuOU0mn52ggpVn2MbIQfUtzgWN0dfJY1FZ5IZDaTEMdKck8OdL41/uHYzKrAaIFn8rhygZ7UoBGXAOgNzAOc9zDPTzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030742; c=relaxed/simple;
	bh=CUWl+EF6dU/bOpf7XPFF0dxNju166y6XrBuEAMlzhqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3UqK7uB2T9YWT8rH55RtuUqEjwiPs+41pQD56jdw2XDXm86ewWbz77YPATCBKgKAyOqnxh9Z3inbHDoOSIKcj7ZDLMd54SThS5Nmv5i+rJok26wDSQal1ody64bQhcp8mLayCItrqKXiyJmxgdQtvRuKpcLCugH0hIWsRTykj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EtPQusAk; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EtPQusAk"
Received: (qmail 89028 invoked by uid 106); 2 Jul 2026 22:18:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CUWl+EF6dU/bOpf7XPFF0dxNju166y6XrBuEAMlzhqE=; b=EtPQusAkgRUy3KZCYGI5fh2DDdaO28lp2KQVgZvYzoBZhzovDAFGbIzk/nRX/WouFIi+5mPfnrJypBUlL2OFPA9xPQoSp4QZLjALF4i/VGYLPBGozDpfTtjce2qpbvx3Rc3F1Owi/OnqusRRNjH6riWJnqBm3/40khigdYjnyQnB6HJVRlUDFGm2X2KWOpDeT8wVrQfDo3WEw1WDkEKQjCy/Cbd/N4P8h8h5T3Q49S5FFPAsdX6Ef5KkuIR0Qk5flpGwrYIGr0hUkSheS/2bKElG+cNCgnmamfL704BQtWGapTTt55My8hZ0XLUA/4FqzYJ5KnX+jlfiO5cIDRcLEw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 22:18:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 188806 invoked by uid 111); 2 Jul 2026 22:18:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 18:18:58 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 18:18:58 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/9] t7508: skip EXPENSIVE test that is broken without
 SIZE_T_IS_32BIT
Message-ID: <20260702221858.GA2068937@coredump.intra.peff.net>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
 <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-5-76b4d7bab3d0@pks.im>
 <20260702212235.GC2051171@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702212235.GC2051171@coredump.intra.peff.net>

On Thu, Jul 02, 2026 at 05:22:35PM -0400, Jeff King wrote:

> On Thu, Jul 02, 2026 at 02:00:58PM +0200, Patrick Steinhardt wrote:
> 
> > This test has also been blowing up in the "linux32" CI job in GitHub
> > Workflows since 7a094d68a2 (ci: run expensive tests on push builds to
> > integration branches, 2026-05-08). But that job doesn't only fail, it
> > also hangs, and that has been concealing the failure.
> 
> One thing I don't understand about this and a few other patches in this
> series: I've been getting passing GitHub Actions runs, including
> linux32, even after that commit turned on the expensive jobs.
> 
> From your description it sounds like it should _never_ work, but it does
> for me. It's possible there's something going on in my CI builds that
> would cause the expensive tests not to run, but I don't think so. Am I
> misunderstanding the problem? Or is there something missing from the
> analysis?

Ah, nevermind. It _is_ my setup. We run the expensive tests only on pull
requests, or when pushing to some specific branches, none of which match
the name of my particular integration branch.

Given all of the headaches I'm hesitant to "fix" my setup to run them,
but I probably should. ;)

-Peff
