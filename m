Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF47081A
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078790; cv=none; b=SOnqwIWgMJ0Ene7Eqf7CTL1M3lh6RnV+J5gTyu+Wlc3nQwx4tqFpCQKZwFuvwWxrQ+WcWSBB9zcvMMlxPIpZt6czvgxeSvGxcSOubFa0mFIswFVGR9x7uNAUXJ/GbhC8wE9hOZv/r0jlxwNRt3JyUaLDcbKixoJmHYhdbz8DTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078790; c=relaxed/simple;
	bh=i6JxCjadE1HRvsgKh4KR1u1s35kvuAbjvQD9J+WPI+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXL3IWNoNHSCmX5IYoCSFFzMTRmf/niMgijj1iPZ+CZeZLhYM/PSSYeIn1MPUhPJWHFTL2GfJRP4P3Y8AoijvaA2UZcFr8UPH+kNzUjKcB4VkCrFY3tx/ouTwHY3ChFeOFjPgDcPYCBP+0YD89Zb72RvI3Z/7smbbfRNKSnprf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Qj3SiLlM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Qj3SiLlM"
Received: (qmail 208735 invoked by uid 106); 21 Jun 2026 21:53:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=i6JxCjadE1HRvsgKh4KR1u1s35kvuAbjvQD9J+WPI+8=; b=Qj3SiLlMoPWJLy87giHj42NHFue7SJPNtyYzAla6k3mWQ1fSpeWOsjLvWy8GOcrFHRZYdGNaoI6E78rBnr2Y7oEY7tCau5lweAL4Kzy+xV99vosS7sF5AEZzsE7EEQpG48/Z+OiZPxPlzOnkU5AExs88SvKg19typVD9tnXgtR4kgncVHECWF5ODo/OHV00SfldfszGq64RWWTNwCTYR86NHELoCSS/EJ9ydbeGWVq/mK5daoOpc3kaTs0v0wCpgJuk5UuMxZdXFA0o3tIgSWnWAMy2AXSQMrx8sO+MQ8uQu82+iIP5ltvoFJt6B3A5oXi1vUPXODaMHAQ27nR0skA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Jun 2026 21:53:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 526888 invoked by uid 111); 21 Jun 2026 21:53:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Jun 2026 17:53:10 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 21 Jun 2026 17:53:07 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Erik =?utf-8?Q?=C3=96stlund?= <erik.ostlund@gmail.com>,
	git@vger.kernel.org
Subject: Re: Pinned references?
Message-ID: <20260621215307.GD2297179@coredump.intra.peff.net>
References: <CANE2Nt_LP9odF9tVsy8di54eSH=QJxif2WQfHC+TQGGFeVcjvg@mail.gmail.com>
 <ajTx9vLIWK5wvTHM@pks.im>
 <xmqqeci2lcpc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeci2lcpc.fsf@gitster.g>

On Fri, Jun 19, 2026 at 09:25:19AM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > You can already kind of do this:
> >
> >     $ git rev-parse v2.54.0
> >     0b13e48a3a30cdfa94e8ef842e24d6045ab3d015
> >
> >     $ git rev-parse v2.54.0-0-g0b13e48a3
> >     0b13e48a3a30cdfa94e8ef842e24d6045ab3d015
> >
> >     $ git rev-parse v2.54.0-0-g95e20213f
> >     95e20213faefeb95df29277c58ac1980ab68f701
> >
> > This is described under gitrevisions(7), `<describeOutput>`. The only
> > gotcha is that this format will not verify that the tag and the object
> > ID actually match. But other than that it gives you the ability to have
> > both the human-readable name and the machine-readable commit ID in
> > there.
> >
> > As said, we don't verify that those two revisions actually match. So in
> > the case where they don't the result is certainly going to be lots of
> > confusion. It certainly is one of the more surprising syntaxes that we
> > have in Git.
> 
> It is very unlikely we would change this, but it is a fun thought
> experiment to imagine what would have happened if we insisted (i.e.,
> verified and then died if it does not hold true) on the presence of
> v2.54.0 tag and when the "hop" count is "-0-", we also insisted that
> the hexadecimal part exactly matched the contents of v2.54.0 tag, or
> when the "hop" count is not zero, we insisted that the hexadecimal
> part names a commit that is descendant of the commit v2.54.0 names.

This is somewhat related to the thread here:

  https://lore.kernel.org/git/CAFb48S8LDz4kiWsKSCBn8J=AHyQ5SVPFH4GY=z+8=DntT=PyAw@mail.gmail.com/

The problem there was the opposite. A name "foo-gcc14" was taken as a
describe name (for object "cc14") when it was not. But one thing I noted
there is that you probably can't be too picky about having "foo" when
you see "foo-g1234abcd". Part of the point of putting the hash in the
described name is that the receiver does not necessarily have your same
refs!

So insisting that "v2.54.0-0-g1234abcd" have both "v2.54.0" and
"1234abcd" locally is probably going to cause some regressions. We could
quietly accept it as "1234abcd" if your "v2.54.0" ref is missing
entirely, though that is perhaps missing the point of the original
request.

The discussion around this patch series might also be relevant:

  https://lore.kernel.org/git/xmqqed1i4pga.fsf@gitster.g/

-Peff
