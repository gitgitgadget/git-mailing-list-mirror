Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615916A956
	for <git@vger.kernel.org>; Wed, 20 May 2026 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779255886; cv=none; b=FmeiPWr3rfBbU0WykuuZmd79O/86oDoHmE0DvcJ8wBWgyxXKbqlSqpfq/VdJEvyG/vmYoczBQLxEgA4SUcHAf9YWfubwk1BDsbDaOITR/OrJB+H49ICKIiCpx+adaUxI2wrQza9/xnqN2Ybgpsr8CgHgbymID8F6Hpm6OKX+mic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779255886; c=relaxed/simple;
	bh=Plxw9u7hEw/5bPxS73VxL7RYVN51DgDaSPy0gJxEBIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLSpWjkPVYFmoNiNw9L0JY77Jy74YUbhCwvJnyA9ycBxs+DjY0quxK84rPEBOs/94Hkr2ewrV6KfIFfSfkcD5j+pYMh/Nm1PeM8fmek3OOWTbERWSwldSk6QLbhy60CUGormFvVqfjE3wQXm8I6Ri5C1vchXozpRuXS++WIo7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fGQOaedP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fGQOaedP"
Received: (qmail 27430 invoked by uid 106); 20 May 2026 05:44:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Plxw9u7hEw/5bPxS73VxL7RYVN51DgDaSPy0gJxEBIU=; b=fGQOaedP9lqxRBFsYJ7rdeeS1i7rgtbMq1jGCX3CkAxqDK69K9RdUgSgBekYx62ikxKZX9bslYk9giBs3llORktkz24X8ZIBYXuhjlcuAnyu4PHeOIALl7a5bgiP0cfQXy3oSl6Nl5/PCaEqWO1eRdKO75UItFTslzfrDRGhfFrachngTTgp3j2SN/BBgooEEWjxAZEbV+j8/ybEYIZb/gicxK2fImVKujAxdaPpbKx/9DTcQ8wPDogkF5EJ5C8iexYtCdxxNnTKSPD/Fn0eQhUDNAV6uMxV6iKq/H4wR7fVUzVhKUcAVcx4pAxbqiQPBBTWRydY50PmsPFezZxHGg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 May 2026 05:44:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 63871 invoked by uid 111); 20 May 2026 05:44:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 May 2026 01:44:40 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 May 2026 01:44:36 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #05)
Message-ID: <20260520054436.GA3849892@coredump.intra.peff.net>
References: <xmqqo6ia4q03.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6ia4q03.fsf@gitster.g>

On Wed, May 20, 2026 at 02:19:24PM +0900, Junio C Hamano wrote:

> * jk/commit-graph-lazy-load-fallback (2026-05-18) 1 commit
>  - commit: fall back to full read when maybe_tree is NULL
> 
>  The logic to lazy-load trees from the commit-graph has been made
>  more robust by falling back to reading the commit object when
>  the commit-graph is no longer available.
> 
>  Will merge to 'next'?
>  source: <20260519050513.GA1635924@coredump.intra.peff.net>

I posted an updated patch in response to your suggestion to use
parse_oid_hex_algop(), but it looks like the topic in your repo has the
original.

-Peff
