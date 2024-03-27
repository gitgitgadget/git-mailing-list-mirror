Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCE036AF6
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528755; cv=none; b=O0+sIDKcl/cppXPDZAkzxnzAyEi+K2zDtpnAsUhdY+kZU8IPiOouPiHvO8v3nLfwIIxX4a8swTN/O9mL8U2TdB+lIF6x1461WFeEutd/IwBHwbEbBu0IQBXXFDzguGtujZuQaEh5aHGvG5HxbCp9Av0Q9duobyk3/my3wLEXCHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528755; c=relaxed/simple;
	bh=oYY8MthDYjnvsEbV+KgQXVaryV3ZTBumkcx1tTrWSZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhQgdaD1pHJwUS94KQ6czboOo48SUtgz9UsN9uX2dGuMnURDh9NNEQ53w2eicXiImRkBVzsZ3KsyjXXlCgpU3gqYSzkf32UFkBymmUOOA+/pk76hr6XEEgv/g6BTVCMgIK85PlbcDRreS8W5vTDlM0yGkC9GIuEY5XdWLS0aidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21703 invoked by uid 109); 27 Mar 2024 08:39:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 08:39:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24425 invoked by uid 111); 27 Mar 2024 08:39:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 04:39:17 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 04:39:11 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] midx: split MIDX writing routines into
 midx-write.c, cleanup
Message-ID: <20240327083911.GD830163@coredump.intra.peff.net>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

On Mon, Mar 25, 2024 at 01:24:11PM -0400, Taylor Blau wrote:

> This is a small-ish series that I worked on to split the functions from
> midx.c which are responsible for writing MIDX files into a separate
> compilation unit, midx-write.c.
> 
> This is done for a couple of reasons:
> 
>   - It reduces the size of midx.c, which is already quite large, thus
>     making it easier to read.
> 
>   - It more clearly separates responsibility between the two, similar to
>     the division between pack-bitmap.c, and pack-bitmap-write.c.

Yeah, I think this is a good cleanup. Like Junio, I did wonder about the
piece-meal movement. I kind of wonder if one big patch moving everything
would have been just as easy to review. But I'm happy either way.

The other refactoring patches all looked good to me.

-Peff
