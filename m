Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA72E3366
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741844013; cv=none; b=WdkzwiOjUbopAve1D9B9GI61RgwNqyUrqm9nImeybL5oxswjJDXkIgLHMzNmm71S5JpkV4w8DhHtAfeeJ3dEq5HN9XkteRSTpS9IsqzVa5KTkvU9FqiqYxEU8viiVhwyxFQOP4oWNDt9ZdSaj/oO3S3DRSBGRbJjZky2KfEYVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741844013; c=relaxed/simple;
	bh=lLy1bSKVLMSXrLhlEDhPalwhaHrYIOTI5IZ9IRQWnOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tO40Ctl5WzZO9k1HARi1x5SLx4zqzRrV+vusPLbNuFspj5/xdiIpuitjdDkI9v+9yhYPZpQVni2DIwoh3BVKqA8gogg7RAbL++cU2VnPYl2lwqX86g0nYtgrtMD+5K5aaxhzPaucok7qPI3RfJzQcvTmmPSG+5vv5h4EPu1cs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XqBDZH+2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XqBDZH+2"
Received: (qmail 20762 invoked by uid 109); 13 Mar 2025 05:33:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lLy1bSKVLMSXrLhlEDhPalwhaHrYIOTI5IZ9IRQWnOA=; b=XqBDZH+2UpbV6boq5bJotRcxwC7sN8SVdQQQX0Ho5CmTtTmIuJKzBVs9w9YPMOXvrOaBtoWwxhEC4cO42AVv3kgqw35NIlTttsVGMKrPFbD58kjEaH0RLvhiCkteOl8I4gn3pcrmU9SvBbO7reVjwpy1tYNAaVarweENO67QzOI3VPevDo+QU9I19RsBtR333oYAuxy85BahcVoxBhf3pwwUg0wFXJbwByuq2nL81u0XZIY0gyjqcNrQsNH/SDcP4Y1xBNDbCNFc8WTM1z5+01lsEQgKk1nEbLctR/tKTIoqTKiUOslVTY1UNP/ks+ZfRGVD1OlPoYok1o/Rc1S0Aw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Mar 2025 05:33:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11518 invoked by uid 111); 13 Mar 2025 05:33:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Mar 2025 01:33:29 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Mar 2025 01:33:29 -0400
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <20250313053329.GC94015@coredump.intra.peff.net>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250311235720.GA73755@coredump.intra.peff.net>
 <sm5xvh7bipyrlpw45bptlctbuhey7v3qktpskal5dzexomt34f@wgfziyhcf3t6>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sm5xvh7bipyrlpw45bptlctbuhey7v3qktpskal5dzexomt34f@wgfziyhcf3t6>

On Wed, Mar 12, 2025 at 05:09:41PM -0500, Justin Tobler wrote:

> >      If it is possible to see some effect from "-z" now (I didn't dig
> >      very far), then it may be better to continue to let the diff
> >      options parser handle it, and simply pick the result out of
> >      revs.diffopt.line_termination. As your patch 3 is written, I think
> >      the diff code probably doesn't see it anymore at all.
> 
> As currently implemented, the early parsing of -z doesn't effect the
> diff options parsing in `setup_revisions()`. The early parsing doesn't
> remove the option and thus it continues to be set in the diff options.

Ah, OK. From the diff context I didn't realize it was not in the main
option parsing loop. That makes sense.

> Furthermore, revision and pathspec argument parsing is all handled in
> `setup_revisions()` so if we want to NUL-delimit arguments parsed on
> stdin with -z, we would still need to parse the option early anyway. I
> think it should be fine to leave the early -z option parsing as-is.

Makes sense. And I guess we might not want to have setup_revisions() do
that handling of "-z" for input, as that would make:

  git log --stdin --raw -z

behave differently (since it does not currently change stdin handling,
only the diff output). Though that does mean that these two commands
will behave differently:

  git log --stdin -z
  git rev-list --stdin -z

which seems...not great. My earlier suggestion to tie "-z" to stdin
handling was for consistency with other tools like grep. But if we
already have cases where "-z" is only for output, maybe it is better to
stay consistent with other parts of git. I.e., I was worried about us
painting ourselves into a corner with your patches, but we may have
already done so years ago. ;)

-Peff
