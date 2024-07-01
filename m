Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909ED16FF48
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872745; cv=none; b=DlBcU+5DqJIMZjnKD1MWwHB4/9Bv/oFLwpL4WIVRtGjY04PF4e4lW5b88i7kcgs5dcT+g4KRLg2FDvrrttFai/pEb9Lmj+fX+7WhhptYdgAlBkygEpvqEk2Db7iSVHdmCfDBIZUa+ieI3sQzz+t9f+0gX8HwO86fdllsEFJ4xVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872745; c=relaxed/simple;
	bh=TDyiJlFdVz4PienHYUmG2AKwINdUZpS9CiZQH91MLvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9wBcV6dQkAVlVrfzvL5AN27Z8NVrONtUWgAk0jkcQLqt+z4h6j+caAK0LzHHzNsRji2qau1YbAxhbSEjP47x+vJtY2dol/cGPHhCVImBO7YB2VAaDtxqIT+R1L/JNERpGruEKocje3oAvBncdnTYAJJLEs6eVmfP6+kC0qNQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29701 invoked by uid 109); 1 Jul 2024 22:25:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 22:25:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18207 invoked by uid 111); 1 Jul 2024 22:25:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 18:25:40 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 18:25:41 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Wong <e@80x24.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	phillip.wood@dunelm.org.uk, Florian Schmaus <flo@geekplace.eu>,
	git@vger.kernel.org
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
Message-ID: <20240701222541.GC20683@coredump.intra.peff.net>
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
 <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
 <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
 <ae658244-877f-c5cf-8947-83b87b66d01f@gmx.de>
 <20240701181916.GD3199@coredump.intra.peff.net>
 <xmqqplrwvob1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplrwvob1.fsf@gitster.g>

[+cc Eric for some possible public-inbox wisdom]

On Mon, Jul 01, 2024 at 01:40:18PM -0700, Junio C Hamano wrote:

> > There's some more discussion from a similar case that came up a month
> > ago:
> >
> >   https://lore.kernel.org/git/20240529102307.GF1098944@coredump.intra.peff.net/
> 
> Thanks.  I wonder if there is a way to add this kind of pieces of
> information to old commits and discussion threads around it after
> the fact, and if it helps us (like Dscho who wondered why we decided
> if it is a good idea, and more importantly if we still think it is a
> good idea and why).
> 
>     ... and then goes back to see the original discussion thread,
>     with the "bright idea" that I could just follow up on 14-year
>     old discussion thread.  Only to find that despite what Dscho
>     said, the commit message does say why it is desirable ("to
>     imitate remote transport well") already.
> 
> So, I guess we do not really need to do such a post-annotation in
> this particular case, but I think after seeing somebody posting a
> message like the one I am responding to and finding it helpful, it
> would be helpful if somebody can post a message pointing at it as a
> response to the old thread that wants a post-annotation.

Usually I find myself digging backwards in history, following links to
old threads. But I guess what you are asking is how would somebody
looking at old thread XYZ know that it was mentioned much later.

And I think the solution is for the new thread to just link to the old
one by message-id (i.e., the usual lore links). And then searching for
that message-id in the archive could turn up the later threads. I don't
know how well public-inbox handles that in practice, though:

  1. Do things that look like message-ids get searched for in message
     bodies? I'd think so if you don't explicitly say "this is a message
     id".

  2. It's really a multi-element search. If I have a thread with 10
     messages, I'd really like to know of more recent threads that
     linked back to _any_ message in the thread. You'd probably have to
     feed them all manually. But in theory indexing could generate some
     kind of bidirectional "related" link.

I don't often do this with message-ids, but I frequently do find other
references by doing a full-text search for commit hashes, or phrases
from commit subjects. I usually do so with my local notmuch archive,
rather than using public-inbox, but I think you should be able to do
phrase searches there, too.

-Peff
