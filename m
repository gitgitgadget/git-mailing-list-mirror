Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB22C0F64
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575434; cv=none; b=iSjIWas4dxBSJSl8NnZHmyO7BZGnK1l8/bEpWQrP5K6AfXVcZbh3ctoy5NJbxALm75r2Z7IgBlAm9+WFMdKUO6a4FvBzu7KZXkkFEEHfzKbV0Oy5GXB86l8G4uupicDG8YAECGkn4cjwqs+xobzjToQfVh7m+1O2WHfslM6Foro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575434; c=relaxed/simple;
	bh=RWXIU6+LgwSLPsKbFS0X7cQpgfz+jsJb5dxmdTcRBOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyWoJx8GX8tknBffK4OK+iTPo6iivy2aF/mzmFaMMdZphgdglt/SjP00iD92WM3McAnpuX3/SYsLzLNQ2IEEnzEp+N338/iofWbRybuluYw/y8yAGWZnBCJNwsyBzFMzxRPg5C3BiNbqRpoAHK3FwEa5GfmIyz105aI0B7tZLFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fACp3Rzs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fACp3Rzs"
Received: (qmail 357690 invoked by uid 109); 27 Oct 2025 14:30:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RWXIU6+LgwSLPsKbFS0X7cQpgfz+jsJb5dxmdTcRBOE=; b=fACp3Rzs3QBHQESCOvlyLrFgAf4cfnZ5/Q0TzX/MvQm39FBhlpCUf04XWVSh9Aw2iaebH1yz71WFcqxP+CnqZ8a70EXWx2fvGKq9UoIGmLChOd7ZBo3JSl5kjk4+ly23bb2Tv3QVVaq1vERvnwdayX55P0EFTFpkn3ZCt3Q6Ot9d03nXrLb96htT3v5Z1pBnO6CYbMFZaeArjPfV4v3LXFlaSbp1JpHcgu045HOE8XS6eDHz4A9U491vxN8pUrrczgqf7f3jyweu/h0hAfkixS4yQt7wHYQ3j8rnq5uxmhkwsLq8vnAzeotJ+2hyP9V4hTfYR+jx4nRLIA0H7fnidA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Oct 2025 14:30:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 556343 invoked by uid 111); 27 Oct 2025 14:30:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Oct 2025 10:30:30 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Oct 2025 10:30:30 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #09; Sat, 25)
Message-ID: <20251027143030.GC2758515@coredump.intra.peff.net>
References: <xmqqo6pun0ml.fsf@gitster.g>
 <aP8wEEZa6_DgdKwG@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aP8wEEZa6_DgdKwG@pks.im>

On Mon, Oct 27, 2025 at 09:40:48AM +0100, Patrick Steinhardt wrote:

> > * ps/maintenance-geometric (2025-10-23) 11 commits
> >  - builtin/maintenance: introduce "geometric" strategy
> >  - builtin/maintenance: make "gc" strategy accessible
> >  - builtin/maintenance: extend "maintenance.strategy" to manual maintenance
> >  - builtin/maintenance: run maintenance tasks depending on type
> >  - builtin/maintenance: improve readability of strategies
> >  - builtin/maintenance: don't silently ignore invalid strategy
> >  - builtin/maintenance: make the geometric factor configurable
> >  - builtin/maintenance: introduce "geometric-repack" task
> >  - builtin/gc: make `too_many_loose_objects()` reusable without GC config
> >  - builtin/gc: remove global `repack` variable
> >  - Merge branch 'tb/incremental-midx-part-3.1' into ps/maintenance-geometric
> >  (this branch uses tb/incremental-midx-part-3.1.)
> > 
> >  "git maintenance" command learns the "geometric" strategy where it
> >  avoids doing maintenance tasks that rebuilds everything from
> >  scratch.
> > 
> >  Will merge to 'next'.
> >  source: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
> 
> Note that I've sent a minor reroll to address a CI flake that Peff
> reported in [1]. I don't think that we need to fix regeneration of the
> MIDX for now, as this is not a new problem. But it's something that we
> may want to address in the future so that we don't regenerate the MIDX
> in case we know it won't change anyway.

Ah, sorry, I hadn't seen your re-roll when I wrote my other response.
What you wrote in v4 looks like a reasonable band-aid to me.

-Peff
