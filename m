Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97060322A0B
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519694; cv=none; b=WGPlC0WNTTkq7zPs7EvxxqswpYz84XrhW8paoJ9PFsGRCj7S1fHh61I1ne+cNEqyYCCNyRlLBUo/xfS+wzM0azHF1VqEEBTlDdOskFKnnu01S1Qd12ie6TZTX73LXjkCidq50Q67UsQP3icG7KC62D70078hy0nTqlvP/SawQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519694; c=relaxed/simple;
	bh=x8T9/GBoCTu7QC234dySxiZydjMa5H8ZtAkjaPFDL+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjE9MOJ7NIAt/W1cbIwV02rowYqlIBp/Q/xDa7/rY/WrprUwcIUCiu5Vz4B6YN4LUQokwhqgbXglyoOskQVV2MKlKRHxPkELP//FBlVDpUCbwRRaEIb7fNu4BtiSbla3+kdL55AY6pH6Vq5zLyHDreud9K9g+l5DwXnSMYKSqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=N31qltjW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="N31qltjW"
Received: (qmail 41800 invoked by uid 109); 10 Sep 2025 15:54:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=x8T9/GBoCTu7QC234dySxiZydjMa5H8ZtAkjaPFDL+E=; b=N31qltjW8CdvMV8jsbZwY4cGqnZ3UYkiVdDmyhIwz4pv2fuJOV3CIUHcXjv1g49tv56ANAViwLivWPuz0H49df1KDyMr/zHyjNmYNVAmTCqMmXvuLb8kRQamcdBermLSfQoikoa3TgERLlQx83biEnXYdkIo1eYocR/uq+M070PDe/cFS4tDIj+BufPfwC+XWCPyyYRZjDFYu9IXx4chWKa1z9fVBU7/CiUHh6+JMnWblj19ugnFupMIs73aDDnB98mFigC06yW4iAl0/GRLafiou09d9QPLtKrsUxnsLJB4olV4HQQwxoHDW3/IEHKTQ3nGAShBz2NwOn1GKP5tsw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Sep 2025 15:54:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67977 invoked by uid 111); 10 Sep 2025 15:54:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Sep 2025 11:54:51 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Sep 2025 11:54:50 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #03; Mon, 8)
Message-ID: <20250910155450.GA1135031@coredump.intra.peff.net>
References: <xmqqjz28v21e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjz28v21e.fsf@gitster.g>

On Mon, Sep 08, 2025 at 06:37:49PM -0700, Junio C Hamano wrote:

> * jk/curl-global-trace-components (2025-08-27) 1 commit
>  - curl: add support for curl_global_trace() components
> 
>  Adjust to the way newer versions of cURL selectivel enables tracing
>  options, so that our tests can continue to work.
> 
>  Will merge to 'next'?
>  source: <20250827080702.GA3572995@coredump.intra.peff.net>

It doesn't seem to have gotten a lot of interest. But we have to do
_something_ if we want tests to keep passing with the new version of
curl. The other obvious alternatives is to try to modify the tests so
that we don't have to modify the code to support the extra debugging
knob. But I suspect that debugging knob may come in handy at some point
in the future, and is worth having.

-Peff
