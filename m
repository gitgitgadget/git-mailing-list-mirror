Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220C170A37
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508906; cv=none; b=NY5lYzy1dKkAv55dgYGYkrbPEesWcWXASc4ggOGIKlGX1tMrhSqadHfuxB9G2lyrjt81CNAkxEclc/Rcv6p1iHJWvE9qJh5tbRnqbk/UTGQ3iRKrFCSikTEwcmGX8NsMW++2zCNLyc0yvBH47GYhSKGupWfsCk8erOK8sWvMmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508906; c=relaxed/simple;
	bh=X/gatpyfTz97qZOZuRwF0pzPZg8WAe5IAuKshcqvctw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhmQwOPV3i6AWOp+pkHoF8j1iukD6qENlbDseDZuSWYJvsv82kYRCNykZa5T8LraDR7U1poaL5i8XSyBqkTziPtBa4jqabyEMtywYsN9f5Gca7YYiZyVsWmUMNPpL2tIWhnJdqwSsFJ2A3jnPKdo+wPUlB86gDaPamYrWEMVERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19431 invoked by uid 109); 1 Aug 2024 10:41:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 10:41:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30800 invoked by uid 111); 1 Aug 2024 10:41:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 06:41:48 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 06:41:42 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/19] midx: implement verification support for
 incremental MIDXs
Message-ID: <20240801104142.GP1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <ad976ef4137d31929a0feef205396d7642de7da0.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad976ef4137d31929a0feef205396d7642de7da0.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:44PM -0400, Taylor Blau wrote:

> Teach the verification implementation used by `git multi-pack-index
> verify` to perform verification for incremental MIDX chains by
> independently validating each layer within the chain.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx.c | 47 ++++++++++++++++++++++++++++++-----------------
>  midx.h |  2 ++
>  2 files changed, 32 insertions(+), 17 deletions(-)

Another one that benefits from "-w". Again, all looked good but I have
to just assume that you touched all of the spots that needed it.

-Peff
