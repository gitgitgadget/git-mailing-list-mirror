Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B1174EEB
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506869; cv=none; b=Fb3MzvTXlcxct7Nvgz331VcI/qgqDAcKsCO4YGGcb6JiKfbEJneIDL89aVvhUkSxtOBq+T9TNVqyjKSLSOnztnXFTKGie2TycXMleBWzOP2kwHFRqPtmJ9ruxEmVU2ZuGSbHsektFhARnEqu2JnE7WXqFAUjgE3LfT4TELAybhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506869; c=relaxed/simple;
	bh=X+d3EAwv+g24O1AZWukqka91wwOvZJzDvtOjuw6ZECc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHKQBWMaaK6FD1LH31cE0kOUv5xW1c7LNFy+6AHxhdojTSwy+TwUpEomxhXRqzvAeu3UuW7WYSjJ/d6zkSX6Ewy+U37hqWhZJvA2MDQbk3lt8J9YAy5goOgU3XCMypy9xXlfPovyTBWd0cJJkPT3AvNhleO0OCk5tlTmrvGVL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18922 invoked by uid 109); 1 Aug 2024 10:07:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 10:07:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30413 invoked by uid 111); 1 Aug 2024 10:07:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 06:07:51 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 06:07:46 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/19] midx: teach `bsearch_midx()` about incremental
 MIDXs
Message-ID: <20240801100746.GH1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <38bd45bd24436d3404b089dff5c3d85f4026da97.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38bd45bd24436d3404b089dff5c3d85f4026da97.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:19PM -0400, Taylor Blau wrote:

> Now that the special cases callers of `bsearch_midx()` have been dealt
> with, teach `bsearch_midx()` to handle incremental MIDX chains.
> 
> The incremental MIDX-aware version of `bsearch_midx()` works by
> repeatedly searching for a given OID in each layer along the
> `->base_midx` pointer, stopping either when an exact match is found, or
> the end of the chain is reached.

OK. I think this could have just happened in the last patch, but no big
deal either way.

-Peff
