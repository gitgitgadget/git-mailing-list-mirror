Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A25D3A4AC3
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408272; cv=none; b=pRXyvB8T09gVD8PAqvxbARxEor6JfSFEPbgNaWILncBvFKQ7T9Nx3dI2r3DB7aIweTwEmnkEo07NMlex28dALGksxTi5oyni9//fDkaaSixcH//o1AJqpK2Ste+xK/caTyiUe3BdnMH+0H1UqTRdAucMaJsQNoZ+St0jP5sWXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408272; c=relaxed/simple;
	bh=iWBYv/fX/FgacuLOcK6IeIRL80aTal3MVPqYfnacsgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKEKSNuR67YNEfjsCdXCj28ndSNiDOsGnjLdP9Z9AiVGCkub3NixkCrR9jf2x/K31tvTFg+UWbo3+glk2G3xczFV4a/bT5UKaUML/Pah25P2EH9YqZ1IWHhqguDUrxlgsGzbbPE3teF5XomseGyyk5wj/CENqdp/xkiZI1e0E30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IhwR3D6D; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IhwR3D6D"
Received: (qmail 40004 invoked by uid 109); 14 Jan 2026 16:24:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=iWBYv/fX/FgacuLOcK6IeIRL80aTal3MVPqYfnacsgk=; b=IhwR3D6DMtZKvJJrygHkijvyVu3Y8i8lkkXLu/ihVFofZ5Vgq+2bxAXQ3H+MmjDGqiZ1Dpzfz5CgbO6tT53lvCJYI760vQwEM+f72BeSTJMKRJBXca/izoWQehAsfw+6iJVyrEwH7qlzWu+iC4tXQ8Yn4Q8fhH0cnQPFVlexQNU4cTdLSGx54U2EqSoBEpAhorZMyulQqZGkRvcUcgKExiKCC6LM3mFIpnQdcEbrPKyymOq0ZmExOpMYMMeL8JYzgKMKDDeXVl4AarehcFNg/aUAbxfV1xNim1T1UoVd8jBgsyqP9krWhY3LQTUJx9XXfbz5JHCYWaCVR+pjDOZAtA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 16:24:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 66415 invoked by uid 111); 14 Jan 2026 16:24:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 11:24:28 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 11:24:27 -0500
From: Jeff King <peff@peff.net>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: Triangular workflow
Message-ID: <20260114162427.GA885771@coredump.intra.peff.net>
References: <20260114023408.GA858378@coredump.intra.peff.net>
 <20260114075309.32911-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114075309.32911-1-haraldnordgren@gmail.com>

On Wed, Jan 14, 2026 at 08:53:09AM +0100, Harald Nordgren wrote:

> > I could (and in fact the script names the remote directly already,
> > because you can't pass refspecs without specifying the remote). But I do
> > occasionally push a single branch with a bare "git push". Usually this
> > is the integration branch, when I am trying to trigger CI manually
> > (e.g., when piling hacks on top in order to debug a CI failure ;) ).
> > 
> > So even if I only do it infrequently, it feels weird that a bare "git
> > push" would try to push to the upstream remote (which I don't even have
> > write access to!).
> 
> Maybe ’push.default=simple’ or ’push.default=nothing’ are better settings
> in your scenario. Then you get explicit pushing because no push branch gets
> set. And thus 'git status' reports not additinal status.

If I did that, then the occasional "git push" (without arguments) that I
do would fail. Likewise, @{push} would not be usable.

> > Yeah, though @{push} is usually not explicitly configured in the same
> > way @{upstream} is, but rather a consequence of how push.default and
> > remote.pushdefault interact. But it was added for exactly this kind of
> > triangular workflow. I sometimes will do stuff like:
> > 
> >   git range-diff origin @{push} HEAD
> 
> I imagine the same thing could be achieved with
> 
>     origin/$(git rev-parse --abbrev-ref HEAD)

Sure, but:

  1. It is a lot shorter to type @{push}. ;)

  2. Using @{push} works everywhere, even on my non-triangular repos,
     because it takes into account the push configuration. So it's a
     much nicer muscle-memory to acquire.

-Peff
