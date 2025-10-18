Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113226D4CD
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781030; cv=none; b=rXFi04o1PVB8wsbePi57zcAzFWR1oObZI0hlDKZt4A6/ShQa0NnCN1v5scrGTL76q+2DDTy0sq7bBdUKoPfcBDMpELR8P/Otp42zKaZrfyk/arE3mlv+N+OS5JiZU2IupUiLi+U7JVlx42LDkiVVyKGQ4yP/HqVRqSAUpzljqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781030; c=relaxed/simple;
	bh=ggM32ZGK+W3dybIttjtzMcz4vnZwbk/LwRFI0YdR7uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW5PaTMy7+XSm7Gg3qfX+NX9Vn9IIn2N/W5YZadYQ1g+3hG7RMcCeIYFEZaENlWVxL+xq5CYRlxK7Y9VcQBw9axrAkHt/xQ0nGyMGxpx5aVW4Ta+pDYWxq48u9G5FOAe300WQNBjvCii1hqoxMB/eFbf+CHGHtUKRJqF5Bj0bkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Z4ZJNB4r; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Z4ZJNB4r"
Received: (qmail 261240 invoked by uid 109); 18 Oct 2025 09:50:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ggM32ZGK+W3dybIttjtzMcz4vnZwbk/LwRFI0YdR7uQ=; b=Z4ZJNB4rXWZoveaKS3O5VGhktn4O5RmRt6tqM5nMrvPNVxmDeafah62u9GGFDzPmqKOiGPclE/5Jpoz3PRUdT60Y617a5hTqitiVXPkUs6vp+Bb93utRyJarnvOBoYWMHbWQECUsd7Awql5Dch56S9C2qnq5QMLmJMs97EB4uxBIbI5MelnIr34o2tVKvPzEpZejopfML/Jgr7SyJlmjiaPC9gXRO5m7BtBE3Ug8C9WgiQIyrno2DDyE6ZR+i62xsUroCPvDC6kZjOxwBMHxnXhT3wjUeE4bst1/5woAGrRD8XxxLYlue8WxUDchN8lroEg2ndfeBeMJyJBbiKBBZw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Oct 2025 09:50:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 409760 invoked by uid 111); 18 Oct 2025 09:50:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Oct 2025 05:50:27 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Oct 2025 05:50:26 -0400
From: Jeff King <peff@peff.net>
To: Langbart <Langbart@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH resend] status: make coloring of "-z --short" consistent
Message-ID: <20251018095026.GD1060824@coredump.intra.peff.net>
References: <XCDlwEkTlgoZIyIf_8BfOGl1C3C63Ioxeib4BRNJ9Jm_CtYWKT3qu-pDaeXVtS1Ifq6E4pT9G0yDbIS_nSwN-uiBuBNAlMyrOv0R1RyM7oc=@protonmail.com>
 <20251007082920.GA3349249@coredump.intra.peff.net>
 <20251007203406.GA4028057@coredump.intra.peff.net>
 <20251017084455.GA4096702@coredump.intra.peff.net>
 <5y1mZIuIa13McbaoEhdBCm8CNMyjkJ6UE39s0kB-rYSmAmuPFnAof5fNVatncDUXIRoMvlpdbId3nFn2dnwU8NwNk78XArUYCf3RncWHu6c=@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5y1mZIuIa13McbaoEhdBCm8CNMyjkJ6UE39s0kB-rYSmAmuPFnAof5fNVatncDUXIRoMvlpdbId3nFn2dnwU8NwNk78XArUYCf3RncWHu6c=@protonmail.com>

On Sat, Oct 18, 2025 at 06:01:07AM +0000, Langbart wrote:

> Thanks for the patch. Agreed, Retaining the colors is very useful, 
> allowing me to pipe the colored output to other tools.
> 
> git -c color.status=always status --short -z | fzf --read0

Thanks, my intuition is that something like that could be useful, but I
didn't have a concrete example. That one is perfect.

(If anybody tries the above, note that I needed to add "--ansi" for it
to look nice in fzf. But I don't usually use that program, so I imagine
there's a way to configure it to do that by default).

-Peff
