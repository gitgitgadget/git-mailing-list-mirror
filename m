Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA31DF75D
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988309; cv=none; b=ilXzyAojlTlaaI6FBqsWhxznfuIBFEe8S+szSWQ3iEoqqknmBVQgFK+MD9Ec1bCL4ZQb0sWEIK5IDG8Cg3U9w7Jexat4Big9qTxt3bpdUO1GKl5Fb6wGl25pJYKqTBn6Fu5EHJYVJZHGjp2SDd+BvEPnKYCWvD1t+NMz5+XlTg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988309; c=relaxed/simple;
	bh=Vm7Lkg7SLnyAjHcEe5VTbivxi4ECJHmEZl57ZdUPZgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWv4WZuB8TVZHjuRWgkUFg0RQdudgNhEYJ9m11B9/tsTAwPC9340A12JWIrDqzVyYTw3oDa0YG2qR4c2e8N9UKBD0Fl1kiB44VXTXEJRi2JbBVgPCJnsc32mzYHw+VM09DDc9MO6Mg03uAdVcl0Dn495XJSAgvOktP1T//S46hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WLaWinZO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WLaWinZO"
Received: (qmail 174493 invoked by uid 109); 9 Oct 2025 05:38:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Vm7Lkg7SLnyAjHcEe5VTbivxi4ECJHmEZl57ZdUPZgM=; b=WLaWinZOK/3AXyNG81wxI7+8+976axKRzDjEGrxl5zyX6X6lp6TzT6Fxw0a3YO6DUgpgLlUjXDfXGsiW7PxqEDuse+d056sOEMzHTyOtuOe3lcgtFZC6QGLguwd/Y83vd6LY1XlwdPI2uqBCECbm5nCp9snz0qOK2Tpk3tQuiV9QKhh6r+ZM/aatwT0RHv9mNyybyY9hK37d2N13lRgwwhPC5wg4JX9wAba3Tl8695jn0gkUovBkdd5IVrdZEczSIt33wI7pB0s1zp1zMImhmFLb/4NKtmUgPJp1BDYo5lWsENq/0gsBunMwzjVIYbB2QQ1DRADT0V0QxRnd8HoXUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Oct 2025 05:38:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 265544 invoked by uid 111); 9 Oct 2025 05:38:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Oct 2025 01:38:26 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Oct 2025 01:38:25 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
Message-ID: <20251009053825.GB1614343@coredump.intra.peff.net>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>

On Wed, Oct 08, 2025 at 05:50:15PM +0200, Patrick Steinhardt wrote:

>   - Patches 1 to 8 refactor our codebase so that we don't have the
>     `peel_iterated_object()` hack anymore. I just found it hard to
>     follow and thought it shouldn't be too hard to get rid of it.

I'm really happy to see this hack go away. I've wanted to fix it for
ages, but didn't want to bite the bullet on changing all of the
each_ref_fn callbacks. The approach you used here to pass through a
struct looks good to me.

I do have one minor complaint, though: the name of that struct. I have a
feeling that the name "struct reference" may cause confusion down the
road because it's so generic, and because "references" and "refs" are so
common in the code. From the names, when would I know when to use
"struct reference" and when "struct ref"?

Could we give it a name that ties it to the iteration interface?
Something like iterated_ref, each_ref_data, etc?

I know this is minor (and will be annoying to adjust your series), but
I'd rather raise the point now than realize later that it's confusing
and try to change it then.

-Peff
