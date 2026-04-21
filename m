Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFED2DE6E6
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740467; cv=none; b=Zviu7Tx9PZ1ATWSoCxZLjta4v9C8El8l9slD4NWMvZMn69KZ3NlWdHPh0DcAEHRasByyD3lL4IBNxGTTOppv/8lNj/V2It3e2FyFC/mymE7P0PR3PigR/5137EAn0DHucJ1RYF+vxUaP88/ByXP9Dph8FXM+jEDuyLuv6Hxc0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740467; c=relaxed/simple;
	bh=cEcTC/LRvhyOoUjQ6AYkAzzJ3Z+l3+NXQXWaMZvg6y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy5wQApIejRpbgD1u8XkNijpwlIQ050o+HqjOcr7kkZY+fwnAEB0HJJf38tRWnyI960IlhK5SrXbmkDWCGiX9wue0zIY3oTLfZpfaOv5iPhF0zrx4ljm0nmi9wb/EyGeuFx22LeXgs8WP2VCbPycdAv60vPOOSA+Oks7JoQCFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cVaQVhnD; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cVaQVhnD"
Received: (qmail 411274 invoked by uid 106); 21 Apr 2026 03:00:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cEcTC/LRvhyOoUjQ6AYkAzzJ3Z+l3+NXQXWaMZvg6y0=; b=cVaQVhnDgs3ChHmVkpaWLKTUjh5Y3m/riKXUdWchCGOtgISfR/luKOS6pMvaOzd8ivAwQ+ABBODAVrxjgXNyw4KPnPsHUBvdtcCTXyDwTOTi+WHZt2myJ4WlUPJTrNvbXqyrgwmd5QR+T3o+17tOPe5s7DJwForAe6GAtqoGgOIHYCLOzejz46caINiHWhV7UacKAVGKP9F4/JUUxTgpRe7sZl5gikWwI7ez9g6rksF2tvjBMeZ7x2ycoHbG7vFNWMFOCi/X/1Y/LkImDmjHEjJC1lXqpWdzEGkdzkVmkJtK/LTDcN80i22yBAwEhuM8CNdMrX5eflgDlEqpT3YeIg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Apr 2026 03:00:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 941176 invoked by uid 111); 21 Apr 2026 03:00:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Apr 2026 23:00:45 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 20 Apr 2026 23:00:45 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 00/12] t: detect errors outside of test cases
Message-ID: <20260421030045.GA1870557@coredump.intra.peff.net>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
 <xmqqfr4pr4e7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfr4pr4e7.fsf@gitster.g>

On Mon, Apr 20, 2026 at 09:19:12AM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I've created an MR with GitLab [2] and a PR with GitHub [3] to verify
> > that these changes work on both platforms.
> >
> > Changes in v5:
> >   - Allow opting in via `GIT_TEST_USE_SET_E=yes` and enable this option
> >     for Linux CI jobs.
> >   - Another fix for a potentially-failing command.
> >   - Link to v4: https://patch.msgid.link/20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im
> 
> I agree that the explicit GIT_TEST_USE_SET_E option is a good way to
> go, as it would be clear which ones are (and which ones are not)
> using it.  I am not sure why we have check_fsck() thing?  Wasn't it
> determined that this would fail only with a broken shells, or is it
> futureproofing just in case the function is used without being
> tested?

Yes, I think it would only fail on a broken shell. It's not _wrong_ to
protect against it, but it's the tip of the iceberg. There are many
other spots that rely on "set -e" being suppressed inside test snippets,
not the least of which is every single final command in each snippet
(because it's at the end of the &&-chain).

So I think it is better to draw the line at things that actually trigger
with working shells.

-Peff
