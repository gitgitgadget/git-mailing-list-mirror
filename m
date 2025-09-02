Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180D28D8F1
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816779; cv=none; b=lGpJAUq0dMl3AxbNj6Gw017Kb5idDpLWC7wRNe/3/QITokM0fylmGRm/7WzMK/pVhhPpYbZg4BPMcaOgQ8DOYbix4Iw/VDtYhZ84XJOWWvrx3toRzWGePuGDExYz01mXT5/lLJJpttMKR/nxFOEqNyQ35of8/iNl0h2D1eyIcCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816779; c=relaxed/simple;
	bh=e5/+EQ7s0qgiJHayoaelVJc692U+iB4bOq25ZnwXFM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX6pQavvHP2AsS8m8/bMKiZ1AUttZa2+w9+kbNCHs9NNk52xlH8CQJhq3ULdOzkLrrcbgZixPGk9k/qTk6PCHsASYv8dFRUVnS6uXoSlEMn89gt4dLKtycO1mxZDnkArndFDAP/8EYcKJgLqL6mj3bYKKOtKMPlWR+e46EgO6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VE4tZ2Cp; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VE4tZ2Cp"
Received: (qmail 185124 invoked by uid 109); 2 Sep 2025 12:39:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=e5/+EQ7s0qgiJHayoaelVJc692U+iB4bOq25ZnwXFM0=; b=VE4tZ2CpRRFo5gJkvSUebjjGAUxTlsau7AtF2yuRdTBEDSRcEDGE4kIQTyPhewdxZS0ESA/Xr8E/0SHfGK+75DpEp/Bo7jEnfOqbL3Vl9uDEvFKVbzrEqN4EYpHCa2ugczF1CefDP8WGCtRuVYQcuUM8hkmtx3dUQZ9oBu+9EaTrr4Hf0PRANTCvBrEkuAopw8+DgVGoSrA9bbj0Gd6SME1kCVgAs38Sr5usKqOV0fBYWlOgNPZN665jcBqExH73jOQx+Sn+ROzAz6QJzgJ6K/gCYVmxi/VHHWJZIBFyi5SPbGjyiesbUer7qN5gHk6QnmhX/r1Hwg5cTmu8KW5r5Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Sep 2025 12:39:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 324462 invoked by uid 111); 2 Sep 2025 12:39:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Sep 2025 08:39:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Sep 2025 08:39:36 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #12; Fri, 29)
Message-ID: <20250902123936.GB711442@coredump.intra.peff.net>
References: <xmqq8qj1n71s.fsf@gitster.g>
 <fdee7ee5-21ef-4c5e-92e7-eb92fe07251e@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdee7ee5-21ef-4c5e-92e7-eb92fe07251e@web.de>

On Sun, Aug 31, 2025 at 07:29:30PM +0200, René Scharfe wrote:

> On 8/29/25 11:37 PM, Junio C Hamano wrote:
> > * rs/describe-with-lazy-queue-and-khash (2025-08-24) 1 commit
> >  - describe: use khash in finish_depth_computation()
> > 
> >  Instead of scanning for the remaining items to see if there are
> >  still commits to be explored in the queue, use khash to remember
> >  which items are still on the queue (an unacceptable alternative is
> >  to reserve one object flag bits).
> > 
> >  Will merge to 'next'?
> >  source: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
> Please keep it in seen for now -- Peff's proposal to use an oidset
> instead looks promising.  I'll do some more measurements over the next
> few days and report back.

Thanks for digging into it further. I am not terribly opposed to what
you sent earlier, and most of my responses were veering pretty far
off-topic. But if we can get away with using oidset here for the same
performance, I think the simplicity is worth it.

-Peff
