Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C838887A
	for <git@vger.kernel.org>; Wed, 13 May 2026 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690993; cv=none; b=ut7VGqLoiBCRlg0Q1fLE2zvJI5BKc5WpfKqWD3FezyKQyX7V4yMjAErL4Co677B+QefvCFi5Lp8B2y6aXgYflBB2dfcPXYrTdAaE31b8ebExZEDqrr8bjYYRn1VA5xGsKSM80eaKzOoLXvYTVAK+xuKaUOfymQMxpILO/RGGQwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690993; c=relaxed/simple;
	bh=h07MvKQRbIVd6aXnUkMbKvQ+EdRlg9S/g/hvCZDsc3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGQzxcdjdGiLGK3SvUvE/bm/SFNfAREEKozD6do3e8ICl6sLCS0uYY8vY+k7+5iCuwu5SfdXfffNqy0efGon2+LH4gTmjtj1Uo8IbfJFKaC05sFbP/LxLv8SzfJJlt2G60zZ4PO0C+9VtkMhfvqjzlEW4CQ33ctP5WBMyrDoTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TRQkb1EQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TRQkb1EQ"
Received: (qmail 39232 invoked by uid 106); 13 May 2026 16:49:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=h07MvKQRbIVd6aXnUkMbKvQ+EdRlg9S/g/hvCZDsc3o=; b=TRQkb1EQdi7ElBtK+9+g5YChF4KcLNyCdmGGfjte41MD6sMlvCzqB0sD8pOmVWMrI0DycdsJLql517rQPpX27YnNsIxHCadkudpEOcQ58rox1C5J9C8y5mNtMQ25VyUglM6zNd5JKDv3PqpfG5LTlMs+KBiK90J++gRPP7XHKnKVEsNDewSng8Wn0wAsjf2d78xgE6sDVLDdat8mfqeLKohKO5603HQxoeuerW64/LCgfatr8U0qPX3PVHJSgBbpsRdp2rWlbPWT/nJ9Ws68Hei+WsqwEIyjXWuMzmQt4g7wpfeS0MQTf2noSqeiITrraIg+JyEhvTlrvdKUqwFlxA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 May 2026 16:49:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67397 invoked by uid 111); 13 May 2026 16:49:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2026 12:49:48 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 13 May 2026 12:49:48 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] strbuf: add strbuf_add_uint()
Message-ID: <20260513164948.GE103037@coredump.intra.peff.net>
References: <20260512115603.80780-1-l.s.r@web.de>
 <20260512115603.80780-2-l.s.r@web.de>
 <20260512184238.GC70851@coredump.intra.peff.net>
 <60b1ef2a-3b12-449e-be0b-cb206425c80c@web.de>
 <20260513162232.GB103037@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513162232.GB103037@coredump.intra.peff.net>

On Wed, May 13, 2026 at 12:22:32PM -0400, Jeff King wrote:

> I guess it is not too surprising that they all come pretty close in
> whole-process benchmarks. These are all micro-optimizations of a
> relatively small portion of the total work the process is doing. Even
> the strbuf_grow() checks are probably slower!

And btw, one final thing to look at if you are interested in
micro-optimizing strbufs: using intrinsics for overflow detection.

Right now we use unsigned_add_overflows(), and then do the actual add.
Using __builtin_add_overflow() might be faster.

-Peff
