Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C12264AB
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935610; cv=none; b=AMHenLnr1oUGPArk0ztaW8bUjDU9kb7+ceHZMU2cCNzXwR2aa1SOwIZUarmoJtv1Jlh2PcrLEDS2Xh3M7lCDXhWdMiu/JK2RjQ1vu3bw7UzDS8RDBqxxn+OgHVlWBDSvwaBzpBCKTyLJREMVCTXgbLZ6+ofexFzJH+HZ7KT+KLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935610; c=relaxed/simple;
	bh=2kquumPFZYNQXzhAcICbiwL1cWiABQUFKY+0OxFq3bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMTDr6y3f0zWN+r2dblbJYgoeO2FpEXIFRI7FH9sdByEI5Om4ZcqsGDE3P0bnuFNSSlkYr+egFf9XIZhfiTpp1XjAU+zqL5JKx2M6+CI45JCmD9LZdV7B0XFjH1yDGAtlKr6bmHLcwMvR20Wvz2mqjXs5CP0a2CegQW/UpX27h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QPBWiCf/; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QPBWiCf/"
Received: (qmail 55958 invoked by uid 106); 19 Mar 2026 15:53:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2kquumPFZYNQXzhAcICbiwL1cWiABQUFKY+0OxFq3bw=; b=QPBWiCf/FT2bPBCcedKKtxf4197uW8V1TtpIfuE0JHJAVeelyai1urZrki16zyKnTA0UltnY+KQD0z6qyDnPDj/1EsJI9LRNxTn7zT9CuskcQGtHPvlwU4vWh1ZXYmi2EIrVNTA/7G6RAuHAqFbSbYYQJlVtPosCgKtVU0vh9Gmz50JTeFZBs0AakUIYbgxhQxuYt2EVGJZkM041lF3N+CT5l5fg8uHBWrPnLA8kiJIP+8r++7r74a3vq5Jptdng060F46BD6Nx16di0ZZtQKgeu6n/kimyN3zMxply1EjgCXjRTZ1KJ8OViSWpm3C4AK+ayYowYLIc0xKyJiCDobA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Mar 2026 15:53:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 84322 invoked by uid 111); 19 Mar 2026 15:53:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2026 11:53:27 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Mar 2026 11:53:26 -0400
From: Jeff King <peff@peff.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: git@vger.kernel.org
Subject: Re: git grep failure?
Message-ID: <20260319155326.GA3611913@coredump.intra.peff.net>
References: <7bbcda60-dad4-41d4-b994-c19f83f37e2f@infradead.org>
 <20260319003829.GA3530301@coredump.intra.peff.net>
 <2c943182-d5d7-4f72-ab97-8d07bf4ed216@infradead.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c943182-d5d7-4f72-ab97-8d07bf4ed216@infradead.org>

On Wed, Mar 18, 2026 at 09:42:23PM -0700, Randy Dunlap wrote:

> > I applied the patch and git-grep does produce one line of output (the
> > instance added by the patch).
> > 
> > Two possible differences:
> > 
> >   - are you sure the patch application succeeded?
> 
> 'git apply filename.patch' succeeded AFAICT. git status shows one
> untracked file (the one that is added by the patch).
> Do I need to do 'git commit' also?

Ah, I see. I used "git am" to apply the patch, which made a commit using
the email as the commit message.

As Junio noted, "git apply" by itself will not mark the file as tracked.
You would need to "git add" it, at which point git-grep would start
looking at it (since it only looks at tracked files). And then "git
commit" if you actually want a commit.

But at that point, you probably want to be using "git am", unless you
don't want to use the sender's commit message for some reason. (Though
even if that is the case, I'd probably use "git am" and then "git commit
--amend" to tweak it).

-Peff
