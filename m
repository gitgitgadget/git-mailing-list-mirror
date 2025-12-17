Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AA22D738A
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765952331; cv=none; b=l+fqcUpZ7kPEd+F7LtUDSw+VH7zmaBHXvWDTQ0STZrSjdzaVjdBDTnKcL3765i+xOH+ZvjDy+xWNA5LrKR+/wyuCOT35UBg0Wm2b2XlAGTHtaljLDi0hSr00/LuOiOj8wF5FCG70Thot8jyi/pGS4uyI/nj7rTURZBFvUzmR2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765952331; c=relaxed/simple;
	bh=TFRGcV6TcupYYCRUt78OaSFVCynSD5N7SmhWCu0fI+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knf0jDj19txo8nlhntc80WUYq2iNpwF+NjuPkH2kdfTwXXXz6NJiaH7kyFUVBq41oGTE7zE8t9QZYbYBZNoe95mOvAK3nEpOUAIPaNhwr61SorVlpFj59jCmBAtcgPxHN6I5R8dFT7QaoTTYG06N00HYgIUssilXLNnTgJ1xKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YB/OZnqj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YB/OZnqj"
Received: (qmail 375446 invoked by uid 109); 17 Dec 2025 06:18:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TFRGcV6TcupYYCRUt78OaSFVCynSD5N7SmhWCu0fI+k=; b=YB/OZnqjdnPnbLHmb/b4/plnJYjMGh7Cu2FMN7yD5OaS7f1j4DjZMKgm47ZQKRHQPtFp6poyzQ4V47iEh7L+xRc+KuG4rxAwGjQB9S/hCj2Eb76Y8fc9IKt5cxW3d2wMgTTU+CMXsmVFrHPAWKuE99xhiLLoHrWNSqPu2N74ErPtw6qY6rw/jiZtTBW1RXy6AFmM8IIk7UXZFe9VIHy8EMJF7+VQprp2QzPoAvYkls2oZwG0Zjvbk6f5m7nxxjjVaY6omxAJ+kw/3uNbKbKA+3g5FMmgEN1oFpqItlhb2rYvgPu5efznETsrP0NjA5nKUSijyWltSVYF+NAJIf85Yw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Dec 2025 06:18:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 505179 invoked by uid 111); 17 Dec 2025 06:18:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Dec 2025 01:18:45 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Dec 2025 01:18:41 -0500
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2025, #03)
Message-ID: <20251217061841.GA1472759@coredump.intra.peff.net>
References: <xmqq4ipwc7y2.fsf@gitster.g>
 <93afac3c-c532-4183-a1fd-7e2322ee912f@nvidia.com>
 <xmqqecot3dm1.fsf@gitster.g>
 <9a318697-4bf5-4ac9-ab9f-f9851da7c54f@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a318697-4bf5-4ac9-ab9f-f9851da7c54f@nvidia.com>

On Tue, Dec 16, 2025 at 09:20:05PM -0800, Aaron Plattner wrote:

> > I can see that the end result of applying the v3 patches match what
> > was in v2, and v3 separates along the lines Peff suggested in his
> > 
> >    https://lore.kernel.org/git/20251208202812.GC216526@coredump.intra.peff.net/
> > 
> > so that's an endorsement enough, I guess ;-).
> > 
> > Let's mark the topic for 'next', then.  Thanks.
> 
> Thank you, I appreciate it!

Sorry, I'm a bit behind on reading the list. Yes, v3 looks great to me.
Thanks for working on it, and for pinging for review!

-Peff
