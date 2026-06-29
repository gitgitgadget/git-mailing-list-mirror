Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C43254A5
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765372; cv=none; b=WkXTaEr9n9mc2Zc1A13jI4der6hvpMd11qILDnQO4cyK/jMpsQISmCQAHOlQBj7FN9DsFaiQdhTHtaEvOAHYZzbKZJGu1P8msJOUGjwzx35vM6BlXNXCw1N39WN9RKgXkbV5JfHv0v7/E1Ks6+P8A7YcU/Qhj1/Gkq0xE7S/Ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765372; c=relaxed/simple;
	bh=qzUroYna9qXzVQeTLqHGMvMoivQEwOISHKQ66Wp0d9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVni7dyavB4Ko31ySnI/Qq7j8Vy+D664T257yEsRO973vI0z7TcB3VJgi0fgMCA7jVgJmzgt/2K9kc9NXYanKg7lPRn85WiDtGrQ/sPfOO8TNarNSBJWV+lec26efDnalpzipYdHTXv10viy4Bas0wJ2G1mXMX79GsAQHfWjVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZzG4rh5c; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZzG4rh5c"
Received: (qmail 67290 invoked by uid 106); 29 Jun 2026 20:36:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qzUroYna9qXzVQeTLqHGMvMoivQEwOISHKQ66Wp0d9Q=; b=ZzG4rh5ckFCG0yTzgpQTDxl0oHBnRZaO67zlUgWi7dU0GOBrFfrqmxetNfJIw6aBRPS3PvH3/b+Al3BmL2DCm/AjD/LMkmA2cWqZQ+Cp1d0fZzDkP5O7d7KBiZaLwZnFfMpXSpIEFdzK9Lwc2BILAb7wT9vjUprbqNuscv4qXk8KWCKhhEeL6r1CoX33OgCDYaViLd12zQrhIN+p9e553Nd3nZ7q6/GUv0n/Mq0drnNZpB+CDvAhK41HaxYgrodOHBmNhhVlmWXyLwyK5q0EgnV+nh9vZluH933MVhoO81F1Rfj5BBzfAC2C5an7ZUhn4UGlaFq2SFJs4ntnC8KUpw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jun 2026 20:36:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 135265 invoked by uid 111); 29 Jun 2026 20:36:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jun 2026 16:36:09 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Jun 2026 16:36:08 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo <mmontalbo@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/3] t5551: put many-tags case into its own repo
Message-ID: <20260629203608.GB1895313@coredump.intra.peff.net>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080345.GB107826@coredump.intra.peff.net>
 <xmqqh5mm1gsf.fsf@gitster.g>
 <20260629003434.GA1228461@coredump.intra.peff.net>
 <xmqqh5mlz9uw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5mlz9uw.fsf@gitster.g>

On Mon, Jun 29, 2026 at 07:42:31AM -0700, Junio C Hamano wrote:

> > Ah, yeah. It should work either way, but it is slightly confusing for it
> > to be non-bare. I'll wait to re-send (though if nothing else comes up,
> > it may be simpler for you to just amend on your side).
> 
> OK.  It seems both Patrick and you are in favor of using only [1/3]
> & [2/3] but dropping [3/3]?  If that is the concensus I can just
> tweak this one and apply before 2.55 final.

Yep, that sounds great. Looks like it already happened. :)

-Peff
