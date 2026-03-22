Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3471F30AD
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774143873; cv=none; b=Cbv8nVZblXI32r5pV+mhOTCKFxAhvKxAaxOqFhTVVyjooqt1MAQvVaF/Bap3p3kma++91ABLGfBtMBl3UM16UCmzUAmzdHOOBmUUixRwLtWmZibSbF65ha43C4Tc9WkQ7lZTI7Tpqx+Csd5qmGEB4RuaTueIizeX0C4qP1/l7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774143873; c=relaxed/simple;
	bh=QP5Oc8Brpbnm8vAIagpXRp9C0Hdht/IqDVcvLSfgYQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/UOw6Tyvxq6pkUwqQRWTzBpOkS2T+405gA7L+m4cuyIVXLc/uuduYuqVXjqKOMeJ36f/SgPTGe9MA9nqN0qX9X0QaKJzOevS0N5bzO6kTS7h37P2l5yMuHt/v1iZkjDk7MJBT9dzdaSfF57C1GVd3I3YHZJTexEbG3kX8A0Ncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MmcjxHeO; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MmcjxHeO"
Received: (qmail 92158 invoked by uid 106); 22 Mar 2026 01:44:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=QP5Oc8Brpbnm8vAIagpXRp9C0Hdht/IqDVcvLSfgYQ0=; b=MmcjxHeOfWr5GhFnLI2sFuVOOLS9ymMnCqGrrForkrDwQRkSqHM4zBkwYScAoX2dA/GIjvU/aiuFEfoYHqdsy3vlV6wf1itWwHrGwW4qpGFPqA2d1rV3CN5edNJ7XWKhinpYDndLdyw7t/QyH9uOrpcoPju03Zj47ph9NoafxBWPlQ9Z7Ad10rrjkgs6wYaoEoHyDyjj+iSUoHL4lMZvekAmqgkFBfi913unv9yvcuWAl5PtO9tmCF6XLt4EV2ahJRUvhsv0eOlvTXtvDUlA/aEnWL1St8Pq/h7ixsOxIeMz/xKqj+SE1GSYFCFO7+sPKe4HaZNaPz73rZAYZEAqoA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Mar 2026 01:44:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 127001 invoked by uid 111); 22 Mar 2026 01:44:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2026 21:44:30 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Mar 2026 21:44:30 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
Message-ID: <20260322014430.GB816875@coredump.intra.peff.net>
References: <xmqq341wnvbk.fsf@gitster.g>
 <xmqqcy0zii0s.fsf@gitster.g>
 <20260319233546.GA3632561@coredump.intra.peff.net>
 <3e387439-c066-4e45-b28b-43f77c8824d6@web.de>
 <20260321211828.GB736981@coredump.intra.peff.net>
 <ca9fa6c7-f693-4b85-a17f-8deeb05b45f7@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca9fa6c7-f693-4b85-a17f-8deeb05b45f7@web.de>

On Sun, Mar 22, 2026 at 12:41:04AM +0100, René Scharfe wrote:

> >   - make a noop read on an unallocated strbuf retain the unallocated
> >     state (your example above)
> 
> That makes the function conform to the convention of rolling back on
> error.  This transactional behavior is a bit easier to understand.  The
> non-getdelim(3) version doesn't do that, though.  It returns whatever
> it got and leaves error checking and rollback to its callers.

Yeah, I didn't look at the fallback version. They definitely should
match if we are going to change the behavior on an unallocated strbuf.

> getdelim(3) doesn't allow that -- it has no way to indicate the length
> of partial reads.  If we are OK with throwing away partial lines then
> we better do that consistently in both versions?  Sounds a bit messed
> up to bin perfectly good data just because some other platform has a
> fancy function that goes quiet when it stumbles.  The alternative of
> having inconsistent behavior seems worse, though.

I'd expect a partial read via getdelim() to return the number of bytes
read, and set an internal flag such that ferror(f) returns true (and
return -1 next time). But that is based more on wishful thinking than
looking at the implementation (and the details may even vary between
implementations).

To some degree, one you see an error on a FILE handle, all bets are off,
and keeping or throwing away a partial line or not is not really
important. You can't realistically go back and retry.

-Peff
