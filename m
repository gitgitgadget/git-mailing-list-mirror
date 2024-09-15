Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6BE946C
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726398438; cv=none; b=df6bd3jUWSCRF0IqJWLS6O6unHywHt3Xboj4Duf1mtBqfZrkTpd8esg+3xhWoCxDWp0AsrpN3zC1eKwVLNSjTLvvW9ZHdtkp6f2yEPjE+aTp0K1/fkLxqUBVEPa0LQKG0IVK6r1jhqRRCxdkrYqB7rS/Z7OYatmy2G3kTs7/lws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726398438; c=relaxed/simple;
	bh=dKu6OBEkX4YbrUJHrPuS8IoH5ODUuukqJaoY5nSDGzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcEGcQ6LdzSDxuoI95fU5AqscfLaDzfD+UpAb4a6O83Uf9DTwTTXdGMta24H7DElcFgHblxCaa/7xCAr3NveFfOhYVIdqb+Zr/2pqmUnAJsTpqDgbEvRKTi2HxWu6JSYIcarDa4hNcQQIQrjYhyqnc9Rb9coLEBXdq63qYUwKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8041 invoked by uid 109); 15 Sep 2024 11:07:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Sep 2024 11:07:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22002 invoked by uid 111); 15 Sep 2024 11:07:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Sep 2024 07:07:06 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Sep 2024 07:07:06 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(linux32): make Javascript Actions work in x86 mode
Message-ID: <20240915110706.GA2017642@coredump.intra.peff.net>
References: <pull.1790.git.1726274559928.gitgitgadget@gmail.com>
 <20240914072932.GB1284567@coredump.intra.peff.net>
 <xmqq34m2tasj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34m2tasj.fsf@gitster.g>

On Sat, Sep 14, 2024 at 10:17:16AM -0700, Junio C Hamano wrote:

> Each of these approaches may have its pros and cons, but I somehow
> do not see that the newly proposed alternative is 10x better than
> what was reviewed and queued already to be worth the effort to
> replace it.

That's my feeling, too, but I'd reserve final judgement to see Dscho's
response; it's possible I am under-estimating the 32/64-bit confusion
risk.

I'd also note that his patch does not require bumping the distro
version, which would let us continue testing that old version in GitHub
Actions. That might be worth considering.

-Peff
