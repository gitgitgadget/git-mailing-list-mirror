Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9638E8A0
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027358; cv=none; b=nuvx3xiUx3ZXQjeCH9GPu+FqbSf+y05APNVadIARh/mBoJM8/BhyFUSp8vTiL9urRERbYZaIM8w7MC0d2H74mxWm3nz+OInkUYkwNl5p+rXrBarZpxyuyS1WfSK3l0cjKgI36A6Hl/eZ3uvY4et49SF28/rz+MuTkE8Royuszjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027358; c=relaxed/simple;
	bh=DHUFyMMeX2OQ+wQPp66up28BeousZpO/WSXYpiwNEgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI4cqvG8LigCYgSonVoLfWBnpVdCrSXRfi6DBFeTmM3O/GdL83EgxQ/dS3YkYRM4cKCSv3qZUeM2V7iSyJAYd0+jKtWuPprxtqtAjW1QGJmbebTZSf54QTlhnzV7rsJLpuMnyvS0C3Wp6qOPrtfcazQrNYLmVntGJtdYNMWuOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DEhzGfD5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DEhzGfD5"
Received: (qmail 88846 invoked by uid 106); 2 Jul 2026 21:22:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DHUFyMMeX2OQ+wQPp66up28BeousZpO/WSXYpiwNEgI=; b=DEhzGfD5sK6c3Ooc9bmaQ+nBqLfcYtLLRRakepiDjCpyR7PZ8SFPJoLLkzkmlWqMsaCfkeRBpidllfPg5XLjze3/+HCGz7nxYC+URdG6phhD70u5NggMuBkkHDLlUU0vQg1mkRzU/btuXbA1bEVy4xYd+hEa2Z8szL8YBcgGyOELChzdtliPcP2SGs+nJlChvscjTaKi15ohz5proykB28yANalQYUg0CAvErqrzxwdcT2ZPaYoJzVgz+DC7s8va70tmf66/vFqcSi1EVrKDzBrIiS2zexVyQMzEcBOjR5MkQ2D/R9cBBRCAcv7YyDzKcs2BIlIfssWFpwBYTlmgUw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 21:22:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 187960 invoked by uid 111); 2 Jul 2026 21:22:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 17:22:35 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 17:22:35 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/9] t7508: skip EXPENSIVE test that is broken without
 SIZE_T_IS_32BIT
Message-ID: <20260702212235.GC2051171@coredump.intra.peff.net>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
 <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-5-76b4d7bab3d0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-5-76b4d7bab3d0@pks.im>

On Thu, Jul 02, 2026 at 02:00:58PM +0200, Patrick Steinhardt wrote:

> This test has also been blowing up in the "linux32" CI job in GitHub
> Workflows since 7a094d68a2 (ci: run expensive tests on push builds to
> integration branches, 2026-05-08). But that job doesn't only fail, it
> also hangs, and that has been concealing the failure.

One thing I don't understand about this and a few other patches in this
series: I've been getting passing GitHub Actions runs, including
linux32, even after that commit turned on the expensive jobs.

From your description it sounds like it should _never_ work, but it does
for me. It's possible there's something going on in my CI builds that
would cause the expensive tests not to run, but I don't think so. Am I
misunderstanding the problem? Or is there something missing from the
analysis?

-Peff
