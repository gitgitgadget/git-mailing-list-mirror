Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0D2D5941
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480354; cv=none; b=X49tWhJjwhp13RWdjuaBGZfUPd+xTQDAPkn4rEYYDSgkPG7KeQ4tiPIHpw3tIEyOc3nX27A9kZngzZhUUxAI8vYiThBpKOqyWzcKcy+XTNiRj32kjn1hXTUN1ClA4l91abpRHJBpeZRdbvfohYs5NT94+DvFBBU3ZV7l2cG0a4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480354; c=relaxed/simple;
	bh=qwqgO1sZfzifhBTR6xreQ32JFfrAgvErdkPtpkCgf1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVsB8Pkb1OLx5y+UPH3XMwLR7Hfv/tk4Nd3kCx/yisji41eQXPuXE0nzR+phB96HSga6M6FJH0QZTjwBKM73ENkl/hFJk4JEvUlUzXjKdLpqN5y9J6x6UzWG3zWyo5yJNialuaBXtuD1iXaqQwx31Wz9VLxCC9o2nFEDTFHXMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=cNN2JIJQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="cNN2JIJQ"
Date: Wed, 3 Jun 2026 17:51:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780480347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qwqgO1sZfzifhBTR6xreQ32JFfrAgvErdkPtpkCgf1I=;
	b=cNN2JIJQhs3a5K6Ae8a55IEcKk06KWPkZFa1pn1Kn392+qyktyeL1sv3adlHmNN0RAPumL
	eYuQWPx0nHLtkGYkLW7gK+0Q6PJRLr3baO4WPR7D6Y6qoN9sb4GKbDmOTKye31Hyvc6rib
	dPAUw4Nmj0O+z3F21t/9evKBb+lNGiwEfK1d0s0updswMjVgyuUdzSk8plWNZtrFUZU0Jy
	a2uHpKDoxWNHyo1igj0c8lPaI5OUYp7l8nxb5kVelGipufDXzaPykzqbUrtaUIy2d5zcMs
	vR/lUARjXKc1RrnHX+LUqC5E9Wg920U+lkgcCK2EqXQH+ea0ddat/7DVZhra4A==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <ah_5PBRZFgQWvkjj@wyuan.org>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
 <20260602170955.Z4b7y%taahol@utu.fi>
 <ah-Nhr2PboWUq6eU@wyuan.org>
 <ah_PyDwO1Sffr5yq@pks.im>
 <ah_c3kgmfRh3bXns@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_c3kgmfRh3bXns@wyuan.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 03, 2026 at 03:51:21PM +0800, Weijie Yuan wrote:
> On Wed, Jun 03, 2026 at 08:55:04AM +0200, Patrick Steinhardt wrote:
> > So this quote is definitely at odds with the configuration I have
> > proposed. It's actually quite surprising to me that we recommend deep
> > threading -- I personally find it extremely hard to navigate as the
> > nesting eventually gets way too deep.
>
> Sorry I'm a little confused. The example thread at git-scm.com:
>
> https://git-scm.com/docs/MyFirstContribution#ready-to-share
>
> Isn't this actually supporting shallow nesting?
>
> > It's actually quite surprising to me that we recommend deep
> > threading -- I personally find it extremely hard to navigate as the
> > nesting eventually gets way too deep.
>
> In my understanding, deep threading == --chain-reply-to, so can you
> point out where do Git recommend deep threading? I always thought Git
> supports shallow threading.
>
> Thanks! And please forgive me if I am wrong :-)

Ah, I know you mean the deep nesting of cover letters, sorry, now I
know.

Thanks!
