Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A677433E74
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783296104; cv=none; b=hb7Ci3ThrXVfKHma7j9bhoTejWkNBMSStr1tN7zaB1n6E8C9oA30ZEQLyCLkTpTyZxdu0hVmYUvxjicUPDEhbn6BhzSajYgAfMxMgLYIFSS+tTy/dDC1LWSVPQ07ozufEo8yz7sP4WdBmpkjH+DnHFc2dfI4YnNrVwL1bVS0G14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783296104; c=relaxed/simple;
	bh=nezMj4rI6JcUvxABqquSbptREBW1AAtVLk7cwhxiXe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMf+yT0bDe674L+gzo3qWr9qicuJV/Fg5ZczaqJNyApYQ1HhDbPI9WCVH6LXrSlKsI9sVlu0RP0DFwxOv4+lPLCSMvOOe9KR59NjXyk6xkwOEQDj6mwJg1lS6a1styODA7uoict0d1JRp3zuuevtwRhBkHG+YMmXGCM9AHmyrNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FdsOsIpS; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FdsOsIpS"
Received: (qmail 2349 invoked by uid 106); 6 Jul 2026 00:01:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nezMj4rI6JcUvxABqquSbptREBW1AAtVLk7cwhxiXe8=; b=FdsOsIpSRxf7ay5ZcXbILUvqtGNVZJ9/hZAUeVuT9VZbOEffLtPyw2YdMooyuHha8TPHNseU3hTJUUubt0oERmY7SxOlJO6CkAbL80Hbn1kgjDxvOZEuIsCxIq+RFfz4knoV4lZJp20s+Ccl6nCxsX2pkeVVKj4OcfXhg+zM4+zXHyb+GqkABToRZxznlZARZ3c7VGJgyxOeNRgjECKPcqzb3WcW7FahDAwP117oyHAwfRtT0DqAsLy2BNAOeCP9flOWz86k7OfVAO+zVme8dMOj3Pey8WH03Uuts30RhZaotXhLXAw2EfIxVonsWYXCYkUThTLVGlivrpHVgF4IRw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Jul 2026 00:01:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3587 invoked by uid 111); 6 Jul 2026 00:01:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Jul 2026 20:01:40 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 5 Jul 2026 20:01:40 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 0/2] small leak fix in format-patch
Message-ID: <20260706000140.GB2301945@coredump.intra.peff.net>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
 <CAOLa=ZRX9fGPdtUKXhmJF-zm_+F0zDuXSV+w02ZPEzqXY6n1Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRX9fGPdtUKXhmJF-zm_+F0zDuXSV+w02ZPEzqXY6n1Fw@mail.gmail.com>

On Sat, Jul 04, 2026 at 02:13:52PM -0700, Karthik Nayak wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This fixes a leak I found while discussing an unrelated leak in another
> > thread[1]. As a bonus, this fixes some minor recent breakage of
> > leak-reporting when running the test suite under prove. The patches can
> > be split into separate topics if we want.
> 
> I think you meant to CC the other "Kaartic" :)

Yes, I figured that out about halfway through the discussion and hoped
nobody might notice. ;) Sorry to both of you for the confusion.

-Peff
