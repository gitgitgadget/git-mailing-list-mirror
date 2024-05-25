Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A21862
	for <git@vger.kernel.org>; Sat, 25 May 2024 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716607538; cv=none; b=OZ6F8nrTNW13/zmj6IczcP9Y1ppffLnFgU8yvlztDep1N+0RRmNFsXzP63aHevpOFlSHo35QltwEtJXq4+S5h/2f0OVEOHt6a8v5Phal1h+KbsbfCGS5KwdaAv3vhWbKem3J3S6+7FLWRLOf4kdRMQPGORV1w0oROfEhy70/GQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716607538; c=relaxed/simple;
	bh=4C774s5vvv1Bgqq+rBP/4k7NYBf0oEWKZV3RpGSNk1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMCgB9sv+llhSiAClGZQSEKFfi5C4uMB6eYSPxxctpr+GRr+cW4k5A3HHyYpDtjTOkaBFlnT0KqrJhhJizuWiyJm4cO9Jnj+wQ1SWC/jvMIcrUYwRzTqPQevyMq9u9RosJdz0No+CO19+xaqNTGgawSres5hogi9CZggslZUl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3899 invoked by uid 109); 25 May 2024 03:25:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 May 2024 03:25:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15404 invoked by uid 111); 25 May 2024 03:25:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 May 2024 23:25:38 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 May 2024 23:25:34 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 19/24] t/test-lib-functions.sh: support `--notick` in
 `test_commit_bulk()`
Message-ID: <20240525032534.GB1890223@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
 <936f6d1b7e392367bb87a755d014633d7171f0ab.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <936f6d1b7e392367bb87a755d014633d7171f0ab.1716499565.git.me@ttaylorr.com>

On Thu, May 23, 2024 at 05:27:08PM -0400, Taylor Blau wrote:

> One of the tests we'll want to add for pseudo-merge bitmaps needs to be
> able to generate a large number of commits at a specific date.
> 
> Support the `--notick` option (with identical semantics to the
> `--notick` option for `test_commit()`) within `test_commit_bulk` as a
> prerequisite for that. Callers can then set the various _DATE variables
> themselves.

Looks good. I expected to see you add "--date" _also_, but it looks like
you just set $GIT_COMMITTER_DATE yourself. Which I think is fine for our
purposes here.

-Peff
