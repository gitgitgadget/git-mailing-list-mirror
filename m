Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE02248B3
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600474; cv=none; b=utmhPIM8v6dKa/q0ITWHtMeIXqLgc7ZQYiRia2CCor7oH6JVHtrKcZZafcuY0pxMm4ApXLl5LgKEN3wxiSWxrp3AdXG6KmRgD+FEnimFfZRhF/JF3Kx+Qe+tBEc7/MEwX4B/MWtvgSSwJx7bCmakfAtsyT2KJWhGTpy/ujtfpEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600474; c=relaxed/simple;
	bh=TiD8BCyKST9dYXZ+xFh6YDUj1Wt54MFjzyZbIzeb7EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPCkAKjYLKAR5MhcpBb6vhmY9LLqcBFQ4pWes0CTBJJQYV9/FeyqTZmmZJkPdvshiFBi/7QpIk9lAJBjkDwca0cYe44dLqMg+aVX6GakPesTAINDkQDLbgqmFje0sJLM0eovX4NCDH6n4ZEeZPoNlOz45nSyICQYGCQL4T4lYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oVyAh7Cy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RJe5hero; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oVyAh7Cy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RJe5hero"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 854A91D000D8;
	Mon, 28 Sep 2026 09:01:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 09:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790600472; x=1790686872; bh=azemjEx4+/
	kiBxgD9qsHwUdXrlbYwD2mT9L+oNNLs1Q=; b=oVyAh7Cyy/f7Cr72ctOk81PF08
	OCCjPu0CgwlIJfxCE7hOhjsqfddSYTIy1mgRehO8gkhwyiQID1RvmMNytOwqBynM
	MPDOGZV3rAOvQaUvIOsZsY2iUVFkGRgO/2J8O6t4F7Bsh6bq8sdSJESGbQo1kHlv
	299l31YPzEZ3981PEJkZbwCj8sZuzT0jmW1CEABsXVKGNnyAfrNCdK+6uww8mDkE
	Y2/D/KOpteKwG1wLK2HO2p+Q6yZedh6/GWyxoIJrvGw3Bq95AYqBFucW0l1VZ44l
	SHZk7vnGxHQH4kRYzsTa/nxVrA9GMu1UsjMvxmzZ+54hfr66AI8+G126DP3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790600472; x=1790686872; bh=azemjEx4+/kiBxgD9qsHwUdXrlbYwD2mT9L
	+oNNLs1Q=; b=RJe5heroQllK4fXbu4MaxczgA4HCIyde7xob9q7bxu2Rffn7Ct+
	NUHr4Y7hpQHez8M2yV7snrHcu3GFTz95f4Nce0Nr9f9LLH5mSV4zWp/yrUH3yKSF
	1hpPBMFoKyoSYIACJhAW/AQIWYI+2NcJ/nKpNy+9WPN5kau/EpGG2XIv1D2ryvlO
	FTTybPYkKdebiR2P7Uosde03zNE1onmZs93XGpasyC2u7R1Z1hH5Fg81dhFQAk3K
	X2fKqMsdoY7058G43a9aUGB6elJcDNN0TY4r23gJMPp3LrcyPqopq17qBX0fMrBo
	eWHRZjIdhWzf5mBqy+cThKtBH/TP3ss3VPA==
X-ME-Sender: <xms:GGW6ak4jm93xv-FxlfQhQwoUWPWyq8ibe3HaQUC5RPMbTbKKtIF27w>
    <xme:GGW6ar67QcVPiqBlB6X7mXHmkifviNixPa2dFqkd3CaWSDLyUISg9c8nn_OQcKuhQ
    bYKiNxlEjo7rf89lBTL-6taIqG3-yv53xhiXZmxraoOdsPaUge7SA>
X-ME-Received: <xmr:GGW6ahGaGhdrucba_U3TqgWeyNqZmXeoItNc8UIA2DiVkFjdmLeWWw>
X-ME-Proxy-Cause: dmFkZTE62ogcG6MHxhTHzqz+g0mOsyJ+C+qMbzsXH+EIUKUh+GAfQa4qobNMvAnbENQcG1
    yBul7LLv8i0+2iVkJzWn5bLzMj4ZbAWczU6/DRGgBgq9SDiPdtTTXxxM9ChB2jwlv+3JyB
    BDcP437dWhXLw7ApZMuIV7TmzLz6YM7zvjsSgqFhSU7CVIih2krm0kb8rf6BexL9YU9wBW
    2jHrU6XswfNOJX42q2d368FKG/K19kowyJegB16doH15SBgT9qKK9L1IQZFv3rMBLwbF+P
    ZMNXnErowbRBrzTCQ1AciWNBrzNHN4uSvkZ6rm6QA02Q4LZK1C+L5zysWjCovwY3h4ddHL
    tQ70rKLnR8gOBsO8RGJMAp1Q9+e/VhRwyOkEtV8sLWyB46UbtH+nkBZyQeIBPioueMzXq2
    U0Kep9J4+QHVKMNDWnZ+vPsvRuSPzPj4+CCJYIOm8XNj4jBbEsw3zxBAw8SfqxELesCuCU
    rGL4wQGi9H3imOzbhde9iomsK2N0h4HGj9qX5i2Pa1NDXguoHa9y+YxhS7zM6+K5c7YDzK
    y5+vLHapesqu/KnTCIkl6UA0xPPwpK1i9Qz3B/OzF0EHP2yguIwS4bYB8dgySIE41/VTLx
    xn9ou5KexYppQvrAmIVQgzuMeAaljiwjr4K2J2ditUctMWPb8Osu1bcvZXDg
X-ME-Proxy: <xmx:GGW6akQoRaqHnKTl7vl2SLw38nZ40OfS9NEK6H1U3N5slMH5rlCQoQ>
    <xmx:GGW6aqu6FaJHk0W2_YMvnOm_7PzZB85gY5mvr1viLS-cfuDsYt3C6Q>
    <xmx:GGW6ajwIMoa-4vOIxawD3y6AXSjzeOQgfC3Zmx42IhiLlT2JAQCSag>
    <xmx:GGW6ak4cmJH0Y0k2IHcTjUjvgpy3yLoHjx-7fGip73ODfM7oFnRCeQ>
    <xmx:GGW6avZRBwfdXBt5DGrN-bQVQiCRiCvYOPZnaA4cny-DYLkcH07mJy0D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 09:01:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9fa3225e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 13:01:10 +0000 (UTC)
Date: Mon, 28 Sep 2026 15:01:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] http: handle curl stripping creds from effective url
Message-ID: <arplE8-5jD-rZiyu@pks.im>
References: <20260928040149.GA498186@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928040149.GA498186@coredump.intra.peff.net>

On Mon, Sep 28, 2026 at 12:01:49AM -0400, Jeff King wrote:
> When we detect that curl performed a redirect of a URL we requested, we
> update our base URL to match the new location and flush the http_auth
> credentials. This goes back to c93c92f309 (http: update base URLs when
> we see redirects, 2013-09-28).
> 
> We detect the redirect by comparing the requested URL to the response
> from CURLINFO_EFFECTIVE_URL, using a simple string comparison. This has
> worked fine for years, but a change in the upcoming curl 8.23.0 adds a
> complication. If our URL directly contains credentials (like
> "https://user:pass@example.com/foo.git"), then as of 7a6bd027d0
> (getinfo: make sure CURLINFO_EFFECTIVE_URL does not contain creds,
> 2026-09-21), curl will strip the credentials from what it returns (so
> just "https://example.com/foo.git" in this case).
> 
> This breaks our direct string comparison, and we believe that we've been
> redirected. We flush our http_auth credentials, and now subsequent
> requests will use the reduced URL, causing us to re-request credentials
> from the user. Notably this causes t5550.15 (among others) to complain;
> it tries a clone with credentials in the URL, and fails if the user is
> prompted at all.
> 
> We can handle this new behavior by doing a more careful comparison: if
> the direct string comparison fails, we'll strip out the credentials
> ourselves and compare. This is a little extra work, but in practice it
> should only happen once per process.

So in my own words, we want to detect the case where we have been
redirected and, if we have been, we want to strip credentials. But this
logic is about to break as curl starts to rewrite EFFECTIVE_URL more
aggressively, and that makes us detect redirects in cases where there
were none.

> I've used curl's curl_url() interface to do the stripping here, mostly
> because its behavior should match the stripping it does internally. And
> also, though we have code to parse a URL, we don't have any to
> reconstruct it, making a single string comparison hard.
> 
> One alternative would be to parse with url_parse() or similar, and
> compare the individual fields (skipping username/password). I think that
> would probably also work in practice, but it seemed to me that the
> simplest change would be sticking with string comparisons.

It still feels rather roundabout to compare URLs only to figure out
whether we have been redirected. I wondered whether there is maybe a
more direct way to get that info, and there indeed is
CURLINFO_REDIRECT_COUNT, which allows us to retrieve the number of
redirects that have happened.

Is that interface maybe a more direct way to get what we're after?

Patrick
