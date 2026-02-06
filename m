Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B55FDA7
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410673; cv=none; b=H9MT7Mum93kpYA5gfOwZy4Asj1OmSQaXR/iqKckbzEW+w0nUTJZF+Rr+SArSB0n/MPlPC7Ojfwl+lCUtxPcWcBqdUQKwn7zDCus8tLn04Xtwtgv0gDW2v2qIY2hxHx4Le8W619pWDmAilwEOPUB6f7QhV7lkEF+cROwrltpgh7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410673; c=relaxed/simple;
	bh=DxqEK5S69uaVAmZpJRmlvx4Q8QcwAjOuC/uEOJckOlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QH2nXnP5hxmuZdaiWXEDOWe5RE+mvGniYYAZ8ddDvpN/1N8/4FF0vrYex68D0LxWOJWRQNBj28o15GIznqzz2ZNYOxTeyU9EdsrVU4WF0660T/q9V7cTjEt27NAfF9safYkAoUjfZfvUippu+O4ddfPa9ko16TavZ/ua3laGLYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MnYWGV+e; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MnYWGV+e"
Received: (qmail 304834 invoked by uid 109); 6 Feb 2026 20:44:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DxqEK5S69uaVAmZpJRmlvx4Q8QcwAjOuC/uEOJckOlA=; b=MnYWGV+en8/ektxj4oL2DKzjd9onGMi4LQKiye6enzFRsmEBZNInuxc+DVAEw3omE6xnX+9ktQrOWnbBjW2SpZpnEubtGsjHcpd6G4QwkGW4GdIjg6yHULtwtCkxg2r9aGAJW6/ayAWtMHHmMegtrisUyCNyeGQCKXDehYWOeV60D9+lWIl0/nYQD9z6dL0dz/q4inlgtxU+0swoxjILlHZ0VHp9L5IG3s31LfbdjIvQtz7HZpE/Et2I6UxNpjH4J9gGtsVRm6Rafr5ABCSvUPzwAchGuht6raCKyUhFgY4Av90HJbskud9n4eO9lC8IyGxComAr0BsdFadwm7GtfQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Feb 2026 20:44:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 608767 invoked by uid 111); 6 Feb 2026 20:44:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Feb 2026 15:44:31 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Feb 2026 15:44:28 -0500
From: Jeff King <peff@peff.net>
To: Ashlesh Gawande <git@ashlesh.me>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] t5550: add netrc tests for http 401/403
Message-ID: <20260206204428.GA2787536@coredump.intra.peff.net>
References: <20260106114029.763351-1-git@ashlesh.me>
 <20260107074724.13165-1-git@ashlesh.me>
 <xmqqms1mihqo.fsf@gitster.g>
 <20260206093840.GC2761602@coredump.intra.peff.net>
 <8ac465f8-6fda-43a1-8bfc-3e88f30d1ca5@ashlesh.me>
 <7583bd2c-4f2f-4a43-a36f-7e0698da8a57@ashlesh.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7583bd2c-4f2f-4a43-a36f-7e0698da8a57@ashlesh.me>

On Fri, Feb 06, 2026 at 09:23:18PM +0530, Ashlesh Gawande wrote:

> > > I think it is fine to check the 403 handling, but note that this _isn't_
> > > how GitHub would respond. If you try to fetch from a repository you
> > > don't have access to, it will return a 401 first (so you try to log in)
> > > and then a 404. The idea being to avoid revealing the existence of the
> > > repository to unauthorized users.
> > In the case of fine-grained access token such that the token has read
> > access to the repository
> > but not write access GitHub does return a 403.
> > (I think this is correct behavior as the token has read access so user
> > is authorized/knows about the repository).

Ah, that makes sense.

> So should I modify that test case to do a push instead for this specific
> scenario (and update the description)?

No, I think what you have is fine. From the client's perspective, they
know only that they got a 403 for some reason. So there's no need for
complex modeling of what the server thinks is going on.

-Peff
