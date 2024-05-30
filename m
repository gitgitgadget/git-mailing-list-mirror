Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346814C5B3
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057701; cv=none; b=iSXBt6/DNnm7aQBqR662/R1FxlPE1qhcgf58pC8evnmCJ9VpOFv3f/YiHcDJMlgu46Pk3uuOW5DWTMpGLGxhZmUnz1BDi/sicLAsvTTfzFfeBI1evAak+juJ+06y6s4KFfLHNxJtQkjby50PGYp+UlZfYpsE2gWubXPp/ULfrc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057701; c=relaxed/simple;
	bh=0MsuYIxqYv662rFFoReJca3k2HchQ94Kk+LqYC+C0vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7+D0IZUUBKOM3doI39ze4XFFTIATVJq7ZsUNNB0h5QRdGfUUCwoZmNkXP6mMkcUMHNmrgSDc/rOXnQTrVM79JNVuZsuQ6XGHLL+/ywtjgHsYai0y51r9H0NJ+dY4Gdi6++ASNlwsbVRfwQ7ICB/R/D+tmSDOPWq6Rs7rT1cUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17452 invoked by uid 109); 30 May 2024 08:28:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 08:28:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28687 invoked by uid 111); 30 May 2024 08:28:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 04:28:16 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 04:28:18 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/5] mv: move src_dir cleanup to end of cmd_mv()
Message-ID: <20240530082818.GA2668158@coredump.intra.peff.net>
References: <20240530063857.GA1942535@coredump.intra.peff.net>
 <20240530064422.GC1949704@coredump.intra.peff.net>
 <Zlgk_MMDGlphfO9U@tanuki>
 <20240530072159.GF1949834@coredump.intra.peff.net>
 <ZlgpsrKN7N38V2GP@tanuki>
 <20240530081512.GG1949834@coredump.intra.peff.net>
 <Zlg2nWhRaZxpO9fm@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zlg2nWhRaZxpO9fm@tanuki>

On Thu, May 30, 2024 at 10:19:41AM +0200, Patrick Steinhardt wrote:

> > The (messy) patch below gets it to a leak-free state when applied on
> > top. Do you want me to do another mini-series with it, or do you want to
> > just roll it into what you're doing (I won't be surprised if you've
> > already found some of these).
> 
> Well, with all the leaks that we have in our codebase it's not all that
> likely that we actually work on the same ones :) For the record, my
> patch series is 29 patches long by now and makes another 76 test suites
> pass. But none of those fixes touch any of the code you touched.
> 
> So given that my patch series is already way too long, and given that
> there shouldn't be any conflicts, I wouldn't mind if this was spun out
> into a separate series.

Sounds good. I just wanted to make sure we didn't end up duplicating or
conflicting.

-Peff
