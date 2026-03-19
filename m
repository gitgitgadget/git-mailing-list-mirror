Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4F01F30A4
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773880719; cv=none; b=eJgMnxY0BNKuY2ljELK+dsbpmVKQGZZ3qelFnHOeJsrcN9FL/e9Vr8jsoI+HC/KDEXq0UxHLISLFQJTAAdxJEaFOTI7bqo0isIZXzD7dHNPfWvpWNnO5pbgwWHd8eKCmWd/vmHYjSrHu96H5wA0TjRZcXv/CNX//kWiF2+TeZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773880719; c=relaxed/simple;
	bh=id+ma0TYIpKAWo5CKPNeoj33Tb0vqYogZSWLzFMkcBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju62bbqM2RLr1eG7eXngVCMzUK1rrUKAWaYAEmd0oI2D365Y7Gs8iLa4WABA6SPcH2qvfzrvTH6xVuv9Tojc3YuOqFkE2e4LGR3xpz7qw9X+phSTrrb+uQWJVfHwuCgoIbtJm/yuQSTdOxqXnUvGjJtdEG3T5OB9AJdWyeOo4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AJSVL3Bt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AJSVL3Bt"
Received: (qmail 48335 invoked by uid 106); 19 Mar 2026 00:38:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=id+ma0TYIpKAWo5CKPNeoj33Tb0vqYogZSWLzFMkcBs=; b=AJSVL3Bt4IxKYL0NpZ1YtHsHGZr6GZP0W0FjXFL9osW/C5LOOgo2iFz+sTHn9A/sR3xomakxFtHRtwnlt673wYSU93eboNvejNT+f2PEypiecCDu36hZxqLpzLs/Ff+uT0oM/WIev5tnxjY7n/T2lEvgjKz3ag+nXBBvmnrGmzUiFC9ktfSKrdTuvSdBInb99QCONy/MuW4zuw/rmbjgIXw1NfappzGQLoa8vexmnQCricKZffJVa4mmJYQfxItrjTfLBM3wd1C2yKAZAy7Ht03sUcMGVModHTll6qd6sL+HXP6GHRhlYMekqAXIaeOKIQT1A6ubiyOi56TNn4GYpQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Mar 2026 00:38:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71619 invoked by uid 111); 19 Mar 2026 00:38:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Mar 2026 20:38:29 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 18 Mar 2026 20:38:29 -0400
From: Jeff King <peff@peff.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: git@vger.kernel.org
Subject: Re: git grep failure?
Message-ID: <20260319003829.GA3530301@coredump.intra.peff.net>
References: <7bbcda60-dad4-41d4-b994-c19f83f37e2f@infradead.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bbcda60-dad4-41d4-b994-c19f83f37e2f@infradead.org>

On Wed, Mar 18, 2026 at 04:28:17PM -0700, Randy Dunlap wrote:

> If I apply the patch at
> https://lore.kernel.org/linux-doc/c5bb61cf789df1ecb32facc29df9749987c7ddfc.1773346620.git.ljs@kernel.org/
> 
> Subject: [PATCH 02/15] mm: add documentation for the mmap_prepare file operation callback
> 
> to the Linux kernel tree (e.g., linux-next-20260316), it applies cleanly.
> 
> I noticed a typo in the patch ("struct vma_area_desc" should be
> "struct vm_area_desc"). When I run
> $ git grep vma_area_desc
> the output is empty.
> 
> Is this expected? (but not by me :)

I applied the patch and git-grep does produce one line of output (the
instance added by the patch).

Two possible differences:

  - are you sure the patch application succeeded?

  - are you in a different subdirectory? By default git-grep narrows its
    search to your current working directory and its subdirectories. So
    if you are in arch/ or something, it would not find the result in
    Documentation/. You can do:

      git grep vma_area_desc :/

    to search from the root of the project.

-Peff
