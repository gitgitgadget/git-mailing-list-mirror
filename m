Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665FB3A1D0F
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382184; cv=none; b=L/XCmxQjCj7u/0inpj2ShjtuJYAfJo9HhyTZl3ciptZW2oPldF5y6ZAFQluZbPUDBgqGLWd3ExjUP15gp1/jFZb1mxbbDUpHZMVol13f5HSX/PRTvwEAoqD91YOKgfe8OWRwIwXarnF/46IsVFD8Pluex2v55xKbnQhapwd4lZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382184; c=relaxed/simple;
	bh=aiqlGHmPNVQkKITSUp794Hjlvt6KMpHo8Et0NmhACQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvBKKTwitpQh8ca98e5ajH7H22KsQ5SyY98poRkyB9MssyxIt3SfKVd06XL7DwysaZw2ErwSd0dm6rAX+0kqtNk6GC7tHUUuOggC5zduDrBCNzxQr/b+/NIcocdWAxbzAXC1e4io1ysT8jiP3wpMVagTOberhimzhjRFnhd/Vcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DrcD5nfM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DrcD5nfM"
Received: (qmail 375161 invoked by uid 106); 16 Apr 2026 23:29:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aiqlGHmPNVQkKITSUp794Hjlvt6KMpHo8Et0NmhACQU=; b=DrcD5nfMZrrCmFAZC4M7PGLZoA8UPmFVZ+HETMHRNDsV8qOJxRuJlFxNYCP9y9p3FzclCUbqEONGVIRiXYhoEf9G3z78vzYOnQ78uhfYcCszxQju+/+aopcQ8w02dvNuNIOpbso0As6OjcxwxzoAyODcrEUFM+G5d3yPGPgpRC9sN3ReH0ae5le6U/vDeQWNi7l2/5451CxGvzRbym/FPryvwd2NRpNMbXEPgo9dw5Ivq1AfNqlfutHgb3e8KtgOLaAxcuzGL6Qew9RnuNZS/ljt9BIZItlRfI41aIvDXRvnhepf2wReAmpyMDmUP7mqLdsHs7tBLmAQfK4q4Vh4kw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 23:29:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 625503 invoked by uid 111); 16 Apr 2026 23:29:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 19:29:42 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 19:29:41 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
Message-ID: <20260416232941.GD1904316@coredump.intra.peff.net>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <621c9da9-2ec0-462d-ae51-0be5e0ca6ab2@gmail.com>
 <aeFF5s5m76Yz7F/Q@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeFF5s5m76Yz7F/Q@nand.local>

On Thu, Apr 16, 2026 at 04:26:14PM -0400, Taylor Blau wrote:

> Yeah, I agree, and sorry for the trouble here. A few thoughts:
> 
>  - In the immediate term, we should downgrade the default format to
>    write V1 MIDXs for the compatibility issues pointed out by this
>    thread. That would seem to be the minimal thing to do to make sure
>    that the 2.54 release is as smooth as possible.
> 
>  - In the medium term (i.e., on the other side of 2.54) we should
>    implement the changes that Peff sketched earlier in the thread to
>    make loading the MIDX robust towards unrecognized versions.
> 
>    Of course, that doesn't fix any old clients who don't upgrade and at
>    some point want to fetch from or otherwise interact with a repository
>    that has a V2 MIDX. But it does improve things for, say, users that
>    are on an eventual 2.55 if we make the V1->V2 by default change in
>    2.56.
> 
>  - In the long term (i.e., in 2.56 or otherwise in a release after the
>    above change is implemented) we should make V2 the default format for
>    MIDXs.

That all seems reasonable. I think the only question is how long the "in
the long term" period should be. Two versions is not very long,
especially for people who are using OS packages (think moving from one
Debian stable release to another). But that can be sorted out later.

-Peff
