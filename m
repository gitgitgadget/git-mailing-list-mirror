Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAB20E3
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880143; cv=none; b=Cv1bG1PvzehTZXEfExOuJbc6FeBbdDrzcGDkpN1Sc6d1r7W8qSALsaFPXTFa3F+ocE5DlAU7RduBDJ0JYrwupaR1qbUKqYDmv0+fbULWSEINo0DDIEjGYt0RKmBz0x3CGw40ruvNzydj6yf+9gnH7TWF6n2cLfsAXpF5mBGs0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880143; c=relaxed/simple;
	bh=pCg8sZceehQHTzMWGSb9tQOQ8x0VHTWUd7fyc1+XnR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTS6rrvjpBKhcNaVWAOX5vcy2e3V6eDjOd4mANuSp6Zi5C9qFET9naHq5MzVMwkPtdB8nGCeGOwmQIlbnZ9Ght6C14U/yu3skgVDLaoRh8DTUFSfsSMHtwaRuFnAeeW3KnyBgdsPwJcmj541RyRkmHk0gbxRtjazYi2FqHZqjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=SsiNTTr+; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="SsiNTTr+"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2934A1F7BE;
	Tue,  2 Jul 2024 00:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1719879593;
	bh=pCg8sZceehQHTzMWGSb9tQOQ8x0VHTWUd7fyc1+XnR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SsiNTTr+RRyjMptiLjUsen3XPJCkiJ1AzuU7JWQnU4yVNegLvZK0nfkL7u2JlfdJp
	 7qH1DuYpT2yJlaq0sxFMlSMEnRPcWBn7qNhIZoT7kZMMXBQr5fw/K9qJHHJs6ptxFM
	 VPRe4jHnggVzJR2pT2FDqLbpELN6SlncWijb+5zc=
Date: Tue, 2 Jul 2024 00:19:52 +0000
From: Eric Wong <e@80x24.org>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	phillip.wood@dunelm.org.uk, Florian Schmaus <flo@geekplace.eu>,
	git@vger.kernel.org
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
Message-ID: <20240702001953.M35917@dcvr>
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
 <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
 <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
 <ae658244-877f-c5cf-8947-83b87b66d01f@gmx.de>
 <20240701181916.GD3199@coredump.intra.peff.net>
 <xmqqplrwvob1.fsf@gitster.g>
 <20240701222541.GC20683@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701222541.GC20683@coredump.intra.peff.net>

Jeff King <peff@peff.net> wrote:
> On Mon, Jul 01, 2024 at 01:40:18PM -0700, Junio C Hamano wrote:
> > Thanks.  I wonder if there is a way to add this kind of pieces of
> > information to old commits and discussion threads around it after
> > the fact, and if it helps us (like Dscho who wondered why we decided
> > if it is a good idea, and more importantly if we still think it is a
> > good idea and why).
> > 
> >     ... and then goes back to see the original discussion thread,
> >     with the "bright idea" that I could just follow up on 14-year
> >     old discussion thread.  Only to find that despite what Dscho
> >     said, the commit message does say why it is desirable ("to
> >     imitate remote transport well") already.
> > 
> > So, I guess we do not really need to do such a post-annotation in
> > this particular case, but I think after seeing somebody posting a
> > message like the one I am responding to and finding it helpful, it
> > would be helpful if somebody can post a message pointing at it as a
> > response to the old thread that wants a post-annotation.

I think adding code comments referencing commit OIDs and URLs
with Message-IDs can help.  I've noticed many people (usually in
other projects) haven't learned to use git (log|blame) :<

> Usually I find myself digging backwards in history, following links to
> old threads. But I guess what you are asking is how would somebody
> looking at old thread XYZ know that it was mentioned much later.
> 
> And I think the solution is for the new thread to just link to the old
> one by message-id (i.e., the usual lore links). And then searching for
> that message-id in the archive could turn up the later threads. I don't
> know how well public-inbox handles that in practice, though:
> 
>   1. Do things that look like message-ids get searched for in message
>      bodies? I'd think so if you don't explicitly say "this is a message
>      id".

Yes, encapsulating via double-quotes to turn it into a phrase
search may help if the Message-ID contains dashes and such.

>   2. It's really a multi-element search. If I have a thread with 10
>      messages, I'd really like to know of more recent threads that
>      linked back to _any_ message in the thread. You'd probably have to
>      feed them all manually. But in theory indexing could generate some
>      kind of bidirectional "related" link.

You can also join a bunch of Message-IDs (or any other query)
via `OR' elements to ensure you don't miss things.

<https://xapian.org/docs/queryparser.html> has a lot more
details on combining things which apply to notmuch, too.

> I don't often do this with message-ids, but I frequently do find other
> references by doing a full-text search for commit hashes, or phrases
> from commit subjects. I usually do so with my local notmuch archive,
> rather than using public-inbox, but I think you should be able to do
> phrase searches there, too.

Yeah.  That's fairly easy to do for Junio's git <=> git@vger
mirror.  It's more challenging to make work (and presentable)
for hundreds of kernel list archives and linux.git mirrors,
especially on my 15 year old hardware, but progress is being
made since I'm resorting to using C++ for Xapian :x
