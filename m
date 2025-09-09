Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1A631D360
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451702; cv=none; b=RdSn6ACfkiiV6k0x+x5/4py3fkITMSSE5eM7zttEegG1AbAcw7DZkaBfVF3HBDqE/vYl9YzDduc/ubFptWxiqgy0G3WvYi3+t+ayI4GF0NH0iVeua2BbaFD0dIBwajHgvqy//X4HIRb3sU0mWTshS3HiIaQXh6sE4i31JQPgMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451702; c=relaxed/simple;
	bh=y2HvnNTC7COBxBjgT9rOJ35hgDx41mcHlxB8khzCcnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss89vLP9ICM5cOMjzCN3trxvxyTMrO0egTVve/nY/Y0X5gPFBYFPtlrXf8ijlQ6DsTacoG3iFEwbB1D03pEt4zILsqHiwoZOXz0jxER9yMHJbCJoMzQquk2nuShWONl9j5KyMpjxOoGz2UFCXFXZRO3+Qemuf2AptDeWLln7Kfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AZar6rXz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AZar6rXz"
Received: (qmail 33687 invoked by uid 109); 9 Sep 2025 21:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=y2HvnNTC7COBxBjgT9rOJ35hgDx41mcHlxB8khzCcnY=; b=AZar6rXz1S/EMI28v876KWV2q8ckrrBIXRDUzJ9wvBV/whUPiGyuW7iKtLaeodLVkvtUMOPfX9OmEupOH9+DW67GAxNBe/r+kLqKJAa/9JR70CR8HUFpykjRcY1wVjJxCI6Io08qB7SAxQ7J8n4gRxmDuB0Ink9srmmaxS9yOkaxN334AgBus+MG4iu2sPG4mTGd8jOZC3HSE8I/U0U6TNaHrPNtEticNJO+/SZ+QDUT73WL0/68kvg3qGG76HaI31y6JQ7cofDJGRYrHR/MqJ4zd0iJCURRvjxSD8EZ/pgEsg8lQ1ZXFU30ESQHdvct6acs1kcm/0tFwPKYYVhslA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Sep 2025 21:01:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 56054 invoked by uid 111); 9 Sep 2025 21:01:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Sep 2025 17:01:39 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Sep 2025 17:01:38 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
Subject: Re: Is Git Add Supposed to Work Like This (git 2.50)?
Message-ID: <20250909210138.GA1922525@coredump.intra.peff.net>
References: <63045080-74d6-4835-9d9c-4d3558acdbfb@gmail.com>
 <20250907233456.GA1281511@coredump.intra.peff.net>
 <b8df3605-7afe-4121-ae50-095dfd671df9@gmail.com>
 <109prte$j8b$1@ciao.gmane.io>
 <20250909184231.GB1912898@coredump.intra.peff.net>
 <xmqqsegvtkgm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsegvtkgm.fsf@gitster.g>

On Tue, Sep 09, 2025 at 01:55:05PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Oops, I think our mails just crossed. I don't think --ignore-errors does
> > quite what you want, though:
> >
> >   $ touch foo
> >   $ git add foo bar
> >   fatal: pathspec 'bar' did not match any files
> >   $ git add --ignore-errors foo bar
> >   fatal: pathspec 'bar' did not match any files
> >   $ git status --porcelain
> >   ?? foo
> 
> The option is described like so:
> 
>     --[no-]ignore-errors  just skip files which cannot be added because of errors
> 
> I think "because of errors" is meant handle a sequence more like this:
> 
>     $ date >foo ; date >bar
>     $ chmod a= foo
>     $ git add --ignore-errors foo bar
>     $ git diff --cached --name-only
>     bar
> 

Yeah, I don't think --ignore-errors is misbehaving, and I read that doc.
I just meant that it would not do the thing Jon is asking for. That is
more like --ignore-missing.

-Peff
