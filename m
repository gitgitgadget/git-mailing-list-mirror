Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183E194ACB
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527446; cv=none; b=J17IvqEFQcK9lxMSnWn1Gkgtj+Yy5q6NCJFTLjBYBpdstdNRirjv6gMH4yLelz5IIx3/AF32CBUsPPhMuvlSBsQhz3n2w0L5VFOxi4V4RWismj38jrD7TaWYXdOv8CzhcsFrK7nT5lFm7Ni6wpNCktzbDtbES9wSm1Av3c1tE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527446; c=relaxed/simple;
	bh=DCClc2mUaISKe7tfjz66OZElfAKuQFlK2A8zXNuHp0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0pIKDTJe9n2zuid7Jn72y0Boi2KjzUh0P7qldLi9tBJytjK7ShaWr6yDCyK/zFpMpc4SSq3jDTRxyUWe+dBk3qhqqLx7PWymF+9mzhr3TfTTRhOaEGR0ceHa+K7MzDbBKXWcu1U8zTwDr3ni+HZixXYR592oU3pNikrgZxnbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5810 invoked by uid 109); 5 Sep 2024 09:10:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Sep 2024 09:10:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7210 invoked by uid 111); 5 Sep 2024 09:10:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 05:10:45 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 05:10:43 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] pack-objects: brown-paper-bag fixes for multi-pack
 reuse
Message-ID: <20240905091043.GB2556395@coredump.intra.peff.net>
References: <cover.1724793201.git.me@ttaylorr.com>
 <xmqqv7zb8cys.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7zb8cys.fsf@gitster.g>

On Wed, Sep 04, 2024 at 11:56:27AM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > This series fixes a couple of issues (some cosmetic, others less so) in
> > multi-pack reuse noticed when rolling this out over a few real-world,
> > internal repositories on GitHub's servers.
> 
> I cannot claim I got all the detail that went into steps 2 & 3
> right, but I was irritated enough that the topic was left in the
> "Needs review" state, so I gave a look at the tail end of the
> series, and they were pleasant read.

Sorry, I'm probably the most qualified reviewer here. I read through
the early patches, and I think the fix is correct, along with the
preparation in patch 2.

With the partial disclaimer that I helped with the early debugging, and
my blind flailing at suggestions accidentally led Taylor to the right
answer. I don't think that biases my perspective, but maybe. ;)

-Peff
