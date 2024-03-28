Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308012FB2D
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643432; cv=none; b=TyU3vhhed+PcJqf/cKh3eLX6+In00D5xEpN7ORokzGFsZ0v24WQxZ/TqRy3jz5oR2nZpfjWOUmsRCvBoDaahPTnFmb/dJQhrRGurzdCA5aC7yPjD3kg/fbWXym0dJ9HhwDe7cZzXnXrPBHewXO3NsXPIboX4B4ItQdXE3ig35Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643432; c=relaxed/simple;
	bh=QCXruFZOO526R3fi7zIgA4oKfvXYJveTfZyz5fu+Azg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNQbwcrl1haxwZLtQJulRSxKYoryPmImJG16Qxsm8Qtv0Rcuvfq6Xum6DJmyt3a0uoF2hq37sSRksI0LO3+n36g3hva9NrZEtafX6WxrbNqx4gzVmqGXxZqeta6qDdbERVv8heyTYBH7gZCwzgyzjiGcQi5MeY3b4/7gd+eGqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7249 invoked by uid 109); 28 Mar 2024 16:30:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Mar 2024 16:30:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7490 invoked by uid 111); 28 Mar 2024 16:30:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Mar 2024 12:30:29 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 28 Mar 2024 12:30:28 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han Young <hanyang.tony@bytedance.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] quote: quote space
Message-ID: <20240328163028.GB1403492@coredump.intra.peff.net>
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
 <xmqqttl2qml9.fsf@gitster.g>
 <xmqqfrwlltjn.fsf@gitster.g>
 <xmqqsf0bz5oj.fsf@gitster.g>
 <20240328103254.GA898963@coredump.intra.peff.net>
 <xmqq34sawcqr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34sawcqr.fsf@gitster.g>

On Thu, Mar 28, 2024 at 09:19:08AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> With the following band-aid, we can skip the test and the output
> >> from "sh t4126-*.sh -i -v -x" might give us a clue that explains how
> >> such a failure happens.  Unfortunately GitHub CI's win test does not
> >> give us insight into a test that did not fail, so I did not get
> >> anything useful from the "ls -l" down there (I already knew that
> >> sample patches are empty files).
> >
> > We package up the failed test output and trash directories for each run.
> > You can find the one for this case here:
> >
> >   https://github.com/git/git/actions/runs/8458842054/artifacts/1364695605
> 
> What I meant was that with the band-aid that (1) sets prerequisite
> so that Windows would not fail and (2) has some diagnostic in the
> code that sets prerequisite, because the overall test does not fail,
> we do not package up that diagnostic output.

Right, I meant that we could look at the run without the band-aid (which
is what the link points to). But I guess maybe you realized already that
it would not be helpful because of the "reset --hard" that the test
does.

-Peff
