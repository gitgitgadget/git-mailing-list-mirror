Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC4A21423C
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801480; cv=none; b=e6TvfWM9VB9k6YCYl7m07gHXjnQ+d5k7O7j2JVlz2gz8aUEl3l4bTE0L9vPv2LgErZjjHetv1Rom4JjbQSv8P5zn3eirFy1b8XsqWqV3Sw6w+GwPFvPKDTa2gDRhnd1dSPLJbMrhmTJQrLJY6zDpweuxEuokr4HAwzDlJsdaIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801480; c=relaxed/simple;
	bh=DL9GrFV6MTAFy/HXwE807zTuypLokfofgBuTX/5RogE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHzPNN/cWaY84eSxnXfpr/AUBhK33LWAraroE1ViLJeCjBTph/jv6TSuXDfnpeteF9OM7COJaapB4zBOz5vz2cAniWr1GTrnx2itKmcC7AuXUdouH78kJBNuJt/EVjOnb9+gzESnWpydyM9sN66+15VFTwBtI4muAyLR/Tuv39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GDCbGnDh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GDCbGnDh"
Received: (qmail 36495 invoked by uid 106); 18 Mar 2026 02:37:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DL9GrFV6MTAFy/HXwE807zTuypLokfofgBuTX/5RogE=; b=GDCbGnDhXiHxohL3r055TlGPWnEUd9LXa2YkNTWMpTOuRYpuO1P/MUx3xFbapA3Rk3qlaTQ4R0JxQts+e9KvM7sqM1gogo6U15d6saNvkf2KCXOsZ24paJPufVXPsO9fW11JyqnPfKHe0MBCiEeWY3dXNRDpkdfoZCIlnocFaDgDf1+QoGbfgI6hAdEyO4Pe0z8DTVhMUAgTImxKHmFGutoYBLjvhakzWRdsCmbn2D9I7VEd4zCBcwt8ZnlNDZqDlVyR5sYk8Y1ibzTfGVNJjHIrAchPaGiLQXQhqvqxmBrNaQnJuc61op93bgA8XuVdMdhYUgFoOFNi7mi+86rsag==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Mar 2026 02:37:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 55263 invoked by uid 111); 18 Mar 2026 02:37:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Mar 2026 22:37:57 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 17 Mar 2026 22:37:57 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
	git@vger.kernel.org, sunshine@sunshineco.com,
	pushkarkumarsingh1970@gmail.com, christian.couder@gmail.com,
	karthik.188@gmail.com
Subject: Re: [PATCH v2] t0410: modernize delete_object helper
Message-ID: <20260318023757.GA1925517@coredump.intra.peff.net>
References: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
 <20260313025852.30010-1-r.siddharth.shrimali@gmail.com>
 <20260313045825.GC3753825@coredump.intra.peff.net>
 <xmqq3423928q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq3423928q.fsf@gitster.g>

On Fri, Mar 13, 2026 at 08:29:41AM -0700, Junio C Hamano wrote:

> I am tempted to add this to SubmittingPatches::[test]; the first
> line of the new paragraph appears several lines before the pre-
> context but without "`make test` from the top-level".
> [...]
> +After any code change, make sure that the entire test suite passes,
> +with `make test` from the top-level.  We say this twice here because
> +it is important.

Seems reasonable. The other mention of "run the whole suite" is buried
inside a big paragraph.

I have no idea if people read the document at all, though.  I certainly
don't, but I am also not a new person trying to join the project. I've
usually read, if not participated in, most discussions which lead to
changes in them anyway. ;)

-Peff
