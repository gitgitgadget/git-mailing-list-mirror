Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD815B10C
	for <git@vger.kernel.org>; Wed, 29 May 2024 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974436; cv=none; b=FV9yB8F4fI5O4cGJ0QkPNK7FSt+2q2W6Vrq3fvuKQSdHqr51OKEZaob42rvgWqO3kE6ayMxgr4rpaaI78WsBQWoCrdoRnxge/E8Bcf8H6gubKEB+2x+6Kk504R/nqvn4jcKwOpx+Uz7tNSSbOM9Un5aSu9dvnwB4gPWk7RhuJyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974436; c=relaxed/simple;
	bh=kKXgMTOzJX7ya23YhqkubXtkzBSzHC7YrTuNRh+HHOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M34/VEWxibnRJ6W/1o41Eg7lEUp4+TDSwWWYNkTlsP+myt+hnGFSKg1zPjp+0asx87FSF/+uG+lbAPFE5Tuouzuonnc859p1NAg/tyRSgHoSDtVDHCFGSU+S+Bi+W0MeC8hTHdLuQRdGypBxFZeFTorhBJGc/t/zlAgf3h070rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11456 invoked by uid 109); 29 May 2024 09:20:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 May 2024 09:20:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18317 invoked by uid 111); 29 May 2024 09:20:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 May 2024 05:20:30 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 May 2024 05:20:32 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/21] config: plug various memory leaks
Message-ID: <20240529092032.GC1098944@coredump.intra.peff.net>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
 <70e8e2651306e9d221e5e472720a7610947580a7.1716541556.git.ps@pks.im>
 <20240525043347.GA1895047@coredump.intra.peff.net>
 <ZlQsKp2IHt2wankn@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlQsKp2IHt2wankn@tanuki>

On Mon, May 27, 2024 at 08:46:02AM +0200, Patrick Steinhardt wrote:

> Indeed, I had the exact same observation. I've already got a patch
> series that enables `-Wwrite-strings` and that adapts our codebase to
> compile cleanly with it. I'll send that series once this one here has
> landed.
> 
> So my proposal would be to leave this patch as-is for the time being,
> but revisit it once both patch series have landed. Does that work for
> you?

Yeah, I can certainly live with that. One of my biggest concerns was
that your patch would invalidate the investigation and work I had
already done, and I'd fail to follow up. But if you are putting it onto
your todo list, then that is even less work for me. ;)

-Peff
