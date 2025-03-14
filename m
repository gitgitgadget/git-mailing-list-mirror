Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E8E1F957
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920573; cv=none; b=AEky5UbMKVX3MhNVQMftgpwnb0srrN4bLVhe5OPzbGZa0UvIyV4V9dpv2c7fCPis6shPm9vYll/PNDBU0bmethsIUtpPmW+OzHPMgI+jXGCRGShL9ahBLy8L7kV8pLerRf6aWYTtmKb6OxhsRE6W20vMa6JHyLZjwix5qErPdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920573; c=relaxed/simple;
	bh=3Ff3vh7O0UbXmjvFdvKFLEND+4Ep51ouJWNMDBnJMwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc74A4rJ3fbLH3cZBzmxmAelgZLbf+fKzDZHT7vqfHGJRmMMfRYLjHwoQw2uqGxmtTIfFwuPbZVSu1O1M2z3JiUC1tShtoppJBiFLGsZ/SEiQMFm7JHZrDhL+TlbdOVqqFYwszjhDSiUbd5QQsTGsYl0UTM2N/1n0WEJctNRAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SrmNLkoQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SrmNLkoQ"
Received: (qmail 2057 invoked by uid 109); 14 Mar 2025 02:49:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3Ff3vh7O0UbXmjvFdvKFLEND+4Ep51ouJWNMDBnJMwY=; b=SrmNLkoQdyQQ1W6eWkSPejkx8K+SDEu0fFOKjAMUIrNeCb0gQu8XAEQuD1HhmqQcYrTJAnOf2D3vrn9KXdvjSPbjbXSV2WbnoiVJ/UpfD4I2ZfLvPeC+veI3FcFi7NYG4Lk9N5HQcdfqKJHnH48zFDPS8eGZ/PD2zutDuYgDmkq/SPly1qNWjwxL7Oph5eA53g8+hEF2iEdSD0IPSepw8VVOjepNmzI6IEeKtUPGDvMA+vab7Vid2iBGljOq+o31YhNFOIsFdW2gg9kVd6iVLSya8bnKbO7N2s1baGmeMzwyZ0pU5tiBm/zV5S95mC4UjiwdYVlSQHX+wCbK1FyrQQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Mar 2025 02:49:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27445 invoked by uid 111); 14 Mar 2025 02:49:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Mar 2025 22:49:30 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Mar 2025 22:49:29 -0400
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <20250314024929.GB114103@coredump.intra.peff.net>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250311235720.GA73755@coredump.intra.peff.net>
 <sm5xvh7bipyrlpw45bptlctbuhey7v3qktpskal5dzexomt34f@wgfziyhcf3t6>
 <20250313053329.GC94015@coredump.intra.peff.net>
 <qapd7sijizopaefpxh3slgn7g2ecwdtyhzqzufcypciyv6n3qm@turmldwzipwe>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <qapd7sijizopaefpxh3slgn7g2ecwdtyhzqzufcypciyv6n3qm@turmldwzipwe>

On Thu, Mar 13, 2025 at 11:41:56AM -0500, Justin Tobler wrote:

> > Though that does mean that these two commands
> > will behave differently:
> > 
> >   git log --stdin -z
> >   git rev-list --stdin -z
> > 
> > which seems...not great. My earlier suggestion to tie "-z" to stdin
> > handling was for consistency with other tools like grep. But if we
> > already have cases where "-z" is only for output, maybe it is better to
> > stay consistent with other parts of git. I.e., I was worried about us
> > painting ourselves into a corner with your patches, but we may have
> > already done so years ago. ;)
> 
> I think to some extent Git is already inconsistent here. IMO it would be
> preferable for both input and output to use NUL as the delimiter when
> machine parsing in git-rev-list(1) as that is the behavior I would
> personally expect. I also agree with Patrick's reasoning else where in
> this thread[1].
> 
> I'm open to discuss further though :)

Nope, I don't have anything further to add. I just wanted to make sure
my suggestion in the earlier part of the thread was not leading us
accidentally down a bad path. ;) If the inconsistencies have been
considered and we're OK with them, that sounds good to me (and the
option handling in your v2 does seem to faithfully implement that).

Thanks for all your responses.

-Peff
