Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40579125A0
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041365; cv=none; b=aoT1R3Htz16Zbri6RBrfJ9HYyepoGSZY97GLf5guB8rBzUzSKcom9LJ383Dr7IzJK909RniuqQabwmqKY7DS27AJiZ6/QXJk5tRudMhA7Ply2/krAcm5FOU4ZSsYGao5IVDct7qys+xStPv3tJUN4RYlKPnjpJxwD8zVFDObBoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041365; c=relaxed/simple;
	bh=zsbvwTp9TOK8t7oNhe+7coTSX6i1r0qnZTR1grRqwFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf/CCht1u+FgeNXWWOJkl+GfY09kRRztzd5IdEMRiY6hfy7Sa3vV2K8X3dqWAy3eemEPHmdYnhiBZS/HCARFGyKfnqMmx/s14CUdfBQ3rufMOLzcUaz+SWSZyVbojnoQICVDahW4kUpa0oknWdFdmMNcJYS6i33bWPaAS52tbfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Rk6Z+xf+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Rk6Z+xf+"
Received: (qmail 100473 invoked by uid 109); 16 Sep 2025 16:49:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zsbvwTp9TOK8t7oNhe+7coTSX6i1r0qnZTR1grRqwFQ=; b=Rk6Z+xf+k6zC3GJNBinCZiwcaAF1dBz15xjUopC4pJVeDIMJ5+eAL+XjQnuj7m1qjWoK8qkVdEoOo6Bqma9ogZR/EBREFr8qG2/6c2P7h0jdbXr7ywZRaHifh8PY5LpFFtJDm/UA0VFyq61wBLCVHFxoUMUkghUHjEqq6vi9ocr/K1gLznH1XfRmz6R5gnTsbCcbf8owphKfmzpPFynzqKW9ltJ3Y5WAN13vQUqEalYsv1Xh9IoSNh7bZ+7Rvl8W7eXsa+FeeNDfPpPRYO7+3mXC/Av5/n0dP0jos1SInf6n9Z4+lFPaXrSFlLEwk6vEzqqRLS3Tj8ldnP4dCKWt2g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 16:49:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 164029 invoked by uid 111); 16 Sep 2025 16:49:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 12:49:12 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 12:49:12 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #06; Mon, 15)
Message-ID: <20250916164912.GA15474@coredump.intra.peff.net>
References: <xmqqtt13frqm.fsf@gitster.g>
 <aMkJVMbSmeA4cIAy@pks.im>
 <xmqqzfaunzjo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfaunzjo.fsf@gitster.g>

On Tue, Sep 16, 2025 at 09:16:11AM -0700, Junio C Hamano wrote:

> As this makes it necessary for that file to eventually include an
> extra header, it sort of makes sense.  I am more wondering if it
> should be a separate commit (i.e. give it a proper log message
> instead of fixup!).  If we were to squash, we would need to mention
> why a seemingly unnecessary change is included.  "In anticipation of
> another topic that adds a call to function Y, whose definition this
> topic shuffles around and makes it necessary for its callers to
> include header X, we pre-emptively include header X that will become
> needed for the other topic to use function Y when merged with this
> topic".  I agree that is certainly awkward.
> 
> Adding the extra include to the other topic is not any cleaner.  It
> didn't have to include that header to make calls to some functions,
> and it is only because another topic shuffled things around that
> made it necessary.  "In anticipation of another topic shuffling
> headers around, we pre-emptively include header X that will become
> needed to use function Y when merged with the other topic" would be
> such an extra commit would say.  That may be slightly less awkward
> but it still is so.

I think adding the fix to ps/packfile-store is reasonably clean. It is
subtly depending on a header file having included repository.h, and that
assumption is broken by the other topic. But it was always a slightly
dubious assumption.

That said, it is not really that big an issue and I am fine with any
fix. If you want to document how the history unfolded, then I think an
evil merge shows that (neither topic had a problem on its own, but when
merged we needed to adjust the result). And it is probably the least
amount of work. ;)

-Peff
