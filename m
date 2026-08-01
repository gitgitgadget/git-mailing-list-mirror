Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17D20FA81
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785592979; cv=none; b=rGRmyh6Z6imIM2w5oav+3nyH/LWvDJ0jaZLjjpjrBqHSp+TONr2v2aWyS4SB6BKw6wx+/BiiJeqhtv1hjpoRWuGHbhfHpYlM1Q/7J96Vene2BEMRFXdjIlsmMid3lI4+LxZ9SKh0FZD/5+6FFwK7s6r/sVLHjm9vGs7TIxE4Am8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785592979; c=relaxed/simple;
	bh=Vx1PJbQnF7zeTMhRaIvZy5Z07epCUFzg5xzm4UhVGSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmviqwXjUeBQYWQnEQNLzwac+516kJte2WxdRcCkV6Zui8TOVV6zTx7eXbQV/NeLibBMoJlcTcNJ7CoW1K27a7w3gMdlHcpiRYHfN3YqYtIFfzj0WAv+JnFDktipeNNaN6g8H/soOJh1smuwRdC+6QSlKE5usX3gk/sAlM9lasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=g3wPVSvX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="g3wPVSvX"
Received: (qmail 9629 invoked by uid 106); 1 Aug 2026 14:02:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Vx1PJbQnF7zeTMhRaIvZy5Z07epCUFzg5xzm4UhVGSM=; b=g3wPVSvXWRr+QumCmCXT4mI318RBzGwhBqpeAywIpg0ChFUZSy1XD81N0Yqc4BKEl4RTNtGdWykOoIwOhvGE+ODXHC+vHLjjAvSWxCUuTLBgeK8+o2GSM2bOgdfbxqIpNGt/OGCteaVJxyVvs9NGHndQv8iQdu+PZuDNAZIt50er4M1/xDyxRLtHjCxzK9SyBAYb52W6OLM0jfWTueKgm7I+vzV9TQU+IraBaGVTBU7JAdGocK4nFIFD8J6nMdP2VSAiDxo6bXhXVI/b8JUbqu9OZo1kBNTTCNAuvWyVKAFmuTEs0AJIhhnpppO8CjUQYrIfAJRKPwFJ6zCPjjsyhA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Aug 2026 14:02:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17266 invoked by uid 111); 1 Aug 2026 14:02:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Aug 2026 10:02:56 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 1 Aug 2026 10:02:55 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ted Nyman <tnyman@openai.com>, git@vger.kernel.org, me@ttaylorr.com,
	ps@pks.im, karthik.188@gmail.com, sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: Re: [PATCH v6 0/6] packfile URIs: support concurrent downloads
Message-ID: <20260801140255.GC2041176@coredump.intra.peff.net>
References: <cover.1785047139.git.tnyman@openai.com>
 <cover.1785111375.git.tnyman@openai.com>
 <xmqqcxw5o4m8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxw5o4m8.fsf@gitster.g>

On Wed, Jul 29, 2026 at 02:41:51PM -0700, Junio C Hamano wrote:

> Ted Nyman <tnyman@openai.com> writes:
> 
> > Changes since v5:
> >
> > * Split the existing double-close fix, HTTP 416 handling, generic
> >   concurrent-download fix, and Windows sharing fix into separate
> >   patches.
> > * Replace the FIFO-based concurrent HTTP 416 test with a standalone
> >   completed-partial test. Besides simplifying the test, this covers the
> >   non-concurrent interrupted-download case directly.
> > * Keep the final production code unchanged.
> >
> > Each patch passes t5550-http-fetch-dumb.sh. The final series also passes
> > t5702-protocol-v2.sh, and the overlapping-download test passes 240 runs
> > with 12 parallel stress jobs.
> >
> > The v5 discussion is at:
> >
> > https://lore.kernel.org/git/cover.1785047139.git.tnyman@openai.com/
> 
> Is everybody happy with this new iteration?
> 
> The design of the re-download feature itself, as far as I
> understand, was favourably accepted from the earliest iteration, and
> now the CI breakages were corrected with the latest iteration of the
> tests, so we should be in pretty good shape, I presume.

Yeah, sorry, I hadn't had time to look carefully. I just did so, and it
all looks good to me. v6 splits the patches in a way that (at least to
my mind) make the trickiest parts of the logic easier to follow.

-Peff
