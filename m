Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6133A0B38
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381898; cv=none; b=Q0LFbspzeBtFUv8w8ONt8KR/CrBwpzpcThy9yMkXhaV5+IN2Lvt4au5q2zeuvwxr0aZ1xTTqe2jOOHULlPf1lKqCwberGq+7a9uEaYD3M8KQ7si83UnIvK87BwR5M9jkFEIx+Xh8e7XZ+P5ZP91B6nFgp78KPAPHB49X3PcVMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381898; c=relaxed/simple;
	bh=mc5590Qt647ljJJONfNqy+tzYGEk/azqPrbESDMqzsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYzRxV8XjpXAVraF66Mu8jN7aNzAHJJRG16IkDR8BKuJWsgN9oZhIP1S94jlxOgau2E9a7l7bvxa9RMdYa/DNFaaJqbEBayYpJJKD5m1fnAwpGfyMGuH89lsP/0kbwCwgDQE5TtHpP1yH/1nJHOUn0kaCqn8H7mwLq7/a+FCktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Bhc+zr/u; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Bhc+zr/u"
Received: (qmail 375097 invoked by uid 106); 16 Apr 2026 23:24:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mc5590Qt647ljJJONfNqy+tzYGEk/azqPrbESDMqzsk=; b=Bhc+zr/uDuUCnbWmfV38oBJA2k0tqn3JLeeVsoMfcSoBTAHhIjz1dn8ZUjaJ8DhY671iYQ6GRgzhw/cHex7eW00RnPQlAKPlfs2NPJHZU8umJKR6CSShg7K+pOuYK/iqVq7BZgacXHeYq41I2Sx8lw58L5LI2lKv7tEIK3J5tCl7451BqNLqK8nba8/CCqJ1uanMQyelS+g58FCs4/K/nE2VbVStoeFFr9xFcERtReLFeL/QFwnsXd5b6xtng1SayiXXF94lkD5E7LE5u2kYOp3VilNqSYvHYPgbCGcQ1fw2BqoRk76Sfd4etGdG7TUe06/hcvuurB1it0i31Wa7/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 23:24:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 625363 invoked by uid 111); 16 Apr 2026 23:24:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 19:24:55 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 19:24:55 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MIDX: revert the default version to v1
Message-ID: <20260416232455.GB1904316@coredump.intra.peff.net>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <xmqqldem22uw.fsf@gitster.g>
 <xmqq8qam217m.fsf_-_@gitster.g>
 <20260416200659.GB1887222@coredump.intra.peff.net>
 <xmqq5x5qzktp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5x5qzktp.fsf@gitster.g>

On Thu, Apr 16, 2026 at 01:55:46PM -0700, Junio C Hamano wrote:

> > +	ctx.version = opts->flags & MIDX_WRITE_COMPACT ?
> > +		MIDX_VERSION_V2 :
> > +		MIDX_VERSION_V1;
> 
> Just a sytle thing but I'd prefer to see this written like this:
> 
> +	ctx.version = ((opts->flags & MIDX_WRITE_COMPACT)
> +		       ? MIDX_VERSION_V2
> +		       : MIDX_VERSION_V1);
> 
> because you do not have to worry about the precedence between & and
> ?: with an extra (parentheses), and a ternary split into multiple
> lines is easier to spot if you write it at the beginning of the
> line, with ?  and : aligned.

OK. I like the "?" at the end of the first line, since it makes it clear
from just that line that it is a conditional and not a direct
assignment. But I don't overly care, and if you want to mark it up as
you apply (if it is not already too late), I am fine with that.

-Peff
