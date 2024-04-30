Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2E12CDAF
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473933; cv=none; b=KNNAV7MxXeefTFQ60fw9Vp+x2TZP1Y+b4hrz2Ocb1OfyiMW3N3xDbUOKdAytY3wBAn5yz7vQHLJ8/FO6La9MjRzj31aXO6ASmq/58lRQUll/+w1Gf/mB+Y9AM+5lEmnM6ZShJESmVg6FSibvlPjZHLy5Z1j2xAdlzuHWU2SZZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473933; c=relaxed/simple;
	bh=J9pur1L29R7Hp8m6buwbtjtLsuZ6PWo7ynBoIk02CUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5+vSR/vyIgm3JnOAxW/ADtEEzDzpuRwcRsmBGFmW8mxgXgFZR854icNnZXlqDaeq1X0LNCado+Grl6DjBuxNYFHa+xgVxymR13Z9rvGaZ0JRHBstyHLijQj1jUF6RsMLKOgQZVcqK3TcSo7GFZdWDSBHN2iUQKN92+Md8f9leQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3648 invoked by uid 109); 30 Apr 2024 10:45:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Apr 2024 10:45:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5814 invoked by uid 111); 30 Apr 2024 10:45:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Apr 2024 06:45:30 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Apr 2024 06:45:30 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] tightening ref handling outside of refs/
Message-ID: <20240430104530.GG1279403@coredump.intra.peff.net>
References: <20240429081512.GA4130242@coredump.intra.peff.net>
 <20240429084238.GA242085@coredump.intra.peff.net>
 <Zi9oRuknlhfG1-WX@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zi9oRuknlhfG1-WX@tanuki>

On Mon, Apr 29, 2024 at 11:28:38AM +0200, Patrick Steinhardt wrote:

> On Mon, Apr 29, 2024 at 04:42:38AM -0400, Jeff King wrote:
> > On Mon, Apr 29, 2024 at 04:15:13AM -0400, Jeff King wrote:
> > 
> > >   [1/8]: t0600: don't create ref outside of refs/
> > >   [2/8]: t5619: use fully qualified refname for branch
> > 
> > You can probably guess that I found these test cleanups only after
> > writing the rest of the series and seeing them fail. :)
> > 
> > It turns out there is one more spot that is run only with reftables (so
> > CI caught it, but my local testing did not):
> 
> Yeah, that's an issue by itself in my opinion. It's ultimately the
> reason why I change this to always run the backend-specific tests in
> [1].

Ah, I hadn't seen that series. Yes, I'd be very much in favor of that
change.

-Peff
