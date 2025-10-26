Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00B1D5AC6
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493399; cv=none; b=tK+P9ypLptsgJfy96Mvd7zloMQRIvGuTeedix4Xab0QIutRTPINth2yrE1raYhu0XRmMEMOGTmVuaszLNUa7HZgXZOzRWh/5ebujCcR+z05Yb1VFHCPAmzPV3z1qLvnf8LJblOb1wNZ0W84iikcZWWnMibZLqgc6102cJHe1P0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493399; c=relaxed/simple;
	bh=Fjr1YEBH4FVUEhGP6iTqqRkjQmFOgtEO9oSZVR3PTy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeI3gbesQunuAOaHLLIaq2WzIM3E3XBn8moVnWOTN0UvuCoFEvmzqEGyznYapT3O8iZFEAfT8N3yRG2B/496tK1zWfy6BLe6e2QrFG2lo3HdxMibojVZbY/LFWlc8VyApU7JSCzXTr+SyclUsGVhcx92CgmtHDJevX3CIXKJf1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=W7B5eEir; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="W7B5eEir"
Received: (qmail 346961 invoked by uid 109); 26 Oct 2025 15:43:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Fjr1YEBH4FVUEhGP6iTqqRkjQmFOgtEO9oSZVR3PTy8=; b=W7B5eEirsKfpBx3jg+t+ODxyXyVmpMAQftmfXNYD7OAOAUnbf654LJvadlgMUuntyn+pPFAhbt1Ur0hv9RDNraBD/WkZST6X138Sox6V2IDeIWvW8ydlgNF/VwM1uBDbMHDKGdZfu1rlYEq5Tl6TXVzFnHJV1XYhza8AC5hf4K2ZmSwgOYQb2SDe624dzFl1h2pBBT4/6xRuyNo3qAVOWxW1w+Y7svwYcO5thh6yoGX84ebDRjBZxz6KjCimi4GLkvsAwgC72YwV9FylIKRVSOAmijed+zQ3WTzd6qgBdhPRuA19HKS3kRmp9uHlxOrX2Hv3k24K/cpOw3gk/E+7pA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Oct 2025 15:43:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 542568 invoked by uid 111); 26 Oct 2025 15:43:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Oct 2025 11:43:17 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Oct 2025 11:43:16 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #09; Sat, 25)
Message-ID: <20251026154316.GA2728880@coredump.intra.peff.net>
References: <xmqqo6pun0ml.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6pun0ml.fsf@gitster.g>

On Sat, Oct 25, 2025 at 02:16:02PM -0700, Junio C Hamano wrote:

> * jk/match-pathname-fix (2025-10-13) 1 commit
>  - match_pathname(): give fnmatch one char of prefix context
> 
>  The wildmatch code had a corner case bug that mistakenly makes
>  "foo**/bar" match with "foobar", which has been corrected.
> 
>  Will merge to 'next'.
>  source: <20251014003404.GC1507@coredump.intra.peff.net>

I just posted a small re-roll based on your comments. Hopefully you
haven't started the 'next' integration yet. :)

-Peff
