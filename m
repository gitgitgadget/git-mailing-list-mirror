Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9E335066
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293491; cv=none; b=rOsM4D6Od5KTtQPdXAH2F32bPqiptLMVOJGr2DheAIDSJKSSyTZx6M2IsRiPjl1lqLytyAwc61l0H55LurnCAIZpfJHXQ5z2K+M41eQ/MBUl6t8SNa/zeZtsSTw5k9RtvIGvwAKHVHUVW8B3ujhHOIPty89G1pJk2NK+OSqLK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293491; c=relaxed/simple;
	bh=ELXNLx6PYwEKeKmlLYFlU4YYDIeIaGal6FRSySxgdNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYz+fRaKG86IaQuwloGKDeKl/lm6LCpYDUcNUxFPu8KhPAd62BrcGHw90EUDt77tMzAhWn9zlrYJr/QUbs2ssvfYbNoZSaeIGseSta5tnRbxxEOujkToRXMuZM5ilKfY/0Sp9BwxleM48kz3rnkC4dyEwGGYh9JrziHPaH6fxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MpWB6KOO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbIaqly5; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MpWB6KOO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jbIaqly5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24CC57A0276;
	Mon,  1 Jun 2026 01:58:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 01:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780293488; x=1780379888; bh=SD2sDDyveO
	cES2KB5NyR59ZIgvMyCP7XZr4HkgWtUXM=; b=MpWB6KOOoNb4Hkphd6oQ+T6SyW
	UgT2ejWHGLcPDeNOxbDbiq2kmI7Pe8pOA4sHb1fxzFc2WajUAmuSK7R0GEwW2lLb
	AbeyJKuEnFzdsoK4ng/aIHe6rpvau91CCqemnRPhWtLsGz+8vVPO8SZ0wReRPRL0
	GwDgONqBXbcxC+vh2XhvrHAiIHAJDaktIu7rmpUro/IEl3ZsVjnTgzyR+Xalz0PW
	4DtJV9nNwyHu/22oQRvH/fLXiSEqAIYPWthSDIZ30Of30U4fc3Z9q2IyJ5MC9aM+
	GJPaXru2rvk452vDlOTItoctbmePcO4pwBPv6kgZtH9T2H0qQUPzvaZL1KrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780293488; x=1780379888; bh=SD2sDDyveOcES2KB5NyR59ZIgvMyCP7XZr4
	HkgWtUXM=; b=jbIaqly5ZIYx9w2SQSJotOors35QeGmdLoRC7kIR4QbZZZkCQwJ
	uWReb669oGj/+0oMogZgF4U5C3i9Txqj4xG1Hdc0lFDsNcZzsM6UjzaM4ln8FAM4
	Ktn8Y0OiqcwXg1Hw3MVc8KoPQvZ7rp3s5U4hiXNs/HBBaDQQViNukrb58zlrNcmv
	Ij0IvYkW8q9lf/0fQVKgDEHneQFnvtZiy3yXSUvyoB0Q3b10+1h0UC+6jX41ihDQ
	NOeEUrS9nu4gXrfHBKlkUDFxI4IJKpYPHI2Mkz4BgkjQfWnsdD8Xw9DwJ1++w6mi
	BF9+i88lF4KkZWLm3AXBgrMy+bk2e+pUTQA==
X-ME-Sender: <xms:cB8davyGXELSWriZOzmdtLvUQCWmd699S3rm8vWT9ZdCbCVFeslUrg>
    <xme:cB8dauLHKHZ7PN09gOZZVTagaltswnvaXmmwqvbBBnxXIH8JjdBpWE75SjoAN_QdH
    fj8Urnm-6weGGFCOJcg4AbeVdS-PesyEsxhVJhepCnEFXYEcB0PLQ>
X-ME-Received: <xmr:cB8dahq6XNZGVWh0G1liI7MfUoENB06UPUTUYI3op6Q0eFkQf42i--PySkfX09MChAUNagi0fCoaKnkSbT-7npqEFP7THXQgMwSYdf-SBFH4>
X-ME-Proxy-Cause: dmFkZTFV3DMoqnMSy0i0pmksdAbWZJPMZMLvRlEEdKIlIVnCN1IX5I0nFbTGuBbHFYVy3T
    NEyn+Gxzdpv1nIO7QDhQKKE7V0f6AUnfw7rCnzcBINLpMfp/ck601AEHMOakAeNlMiCkrV
    dAWCdshVWL70/w03nAb4C9g0i+oUuQSPrDwo5Y3TzPetS2a8W9Hf+AO5mozqOYks4JAuNR
    kpIVgNaa5bBhOJqQWpHHI9zOZLEP4A6lNSLnarw3LQthc96BP+rJCWZyc4TkGs8cWQioFu
    DPoz//a0DOwbc+j/iJTFnrN0lhuOsXTJ5fef+aBZc7z8ZuJtnHc+eEMWSbzPfUj0s5Y4lw
    ppuNqqtzLpzjszvsHL43Og8iYSGAEtiut64wbrNWtk3gXKYSpCT8N7x2gVqkYDpU40hc1A
    oc3eL/ZTK4its61mPuCmNJC0DB74OhWz0Z74Xar3EU9bohgUcSjtkW6Y1i6VPS/Q2NVD5t
    eA+W5slEltJaTDPZJ17YtR6b0+nk/4WTen2TkSWXuP86LQvV6VXdpzcZqx6n8uzqb3cXDG
    8fhR78l/s+BQ6xjBYDd+qZZS219s1+6JB/kEF6GCAQ1OvI0SxC8iR/P8Hu6S8YCZem9lCi
    M85t4EsTLXNb/1nAbaBTS8FS4Ce74Gz5sbSBEc9Kvub7T9k35Jgelijk5CsA
X-ME-Proxy: <xmx:cB8dalLDRzYpNlyG9egWzZElZTwDWhYUpfjefEsBMDFuYAmr2BsT2A>
    <xmx:cB8dauSSt_bz5vc4zaHTn7X5qwocgY-diasMcu4Zrf4w6QA1iYrlyQ>
    <xmx:cB8dasu8TiCj3Pj-ZTl-q1C0P3v0ekaEqrEUpjNE95XE1lCGZqn9VA>
    <xmx:cB8danYMguqAJSQOQVik99GqXJWuChI2esn87m8hf-83Z1KN2cPCXA>
    <xmx:cB8datydwYURIukOOzLTrPCj1htsE0Pde99D7qKh9hU3kovQCqQG10UA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 01:58:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c22b758 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 05:58:05 +0000 (UTC)
Date: Mon, 1 Jun 2026 07:58:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: kristofferhaugsbakk@fastmail.com, Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] commit: remove deprecated functions
Message-ID: <ah0fahsc-a6JvYi-@pks.im>
References: <CV_commit.h_remove_deprecated.714@msgid.xyz>
 <V2_CV_commit.h_remove_deprecated.732@msgid.xyz>
 <20260529083716.GE1106035@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529083716.GE1106035@coredump.intra.peff.net>

On Fri, May 29, 2026 at 04:37:16AM -0400, Jeff King wrote:
> On Thu, May 28, 2026 at 09:00:09AM +0200, kristofferhaugsbakk@fastmail.com wrote:
> 
> > Topic summary: Remove deprecated comments that were slated for removal
> > after Git 2.53.0.
> 
> This looks obviously correct to me, but the whole topic made me wonder:
> was it worth retaining the old names and deprecating them, versus just
> removing them back then?
> 
> Topics in flight would have needed an update then, but they did
> eventually anyway. So it feels like the total amount of work done is
> larger, compared to just fixing them as the topics were merged. Either
> way the compiler tells us, and the adjustments themselves are small.
> 
> Not a huge deal either way, but just pondering for future such
> situations.

Yeah, I'm always very torn on these myself. I guess ultimately it's
always going to be dependent on the actual refactoring: the bigger the
blast radius, the more it makes sense to have a transition period so
that we don't break in-flight patch series.

Where exactly that line is is a different question of course.

Patrick
