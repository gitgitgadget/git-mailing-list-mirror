Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED501BD034
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823083; cv=none; b=JPGKbYPCkAK+AX7wVE9s3FrmFmausXGtaxgHdnOQ6hv9gh6Zxo25d5u+uSPiGe+X24rjUc5UOtxqJbRpx9qPU+zOWB3exyS11dwWlJAPFWbNIfF6Kw5VFdZymJ7bmof9TLwgiVSouXju5MuP6m3QOQvOWQqFczB/BAzUowRt5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823083; c=relaxed/simple;
	bh=v4lqIMSRJgNJNDzNZS/fw48hG2BbyVCeZ4nSmD1Ap1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3D3bUc5uXVxcTMeb+I6pk5sIzLf2UbCH318lNiuezmfxSYtwPJ2i5ZBjy4CPyuw0vPpgt99c2UP2Ca7MpB30VGqRybnqGm8A30MDt5FpLvVDIKd7tEioDGwIFZt+1/BG+bqUe/8f6Z0U1KoAUNtUft56w7s8VuVJx0aokYqjBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=X2DnU6RI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="X2DnU6RI"
Received: (qmail 31146 invoked by uid 109); 1 Oct 2024 22:51:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=v4lqIMSRJgNJNDzNZS/fw48hG2BbyVCeZ4nSmD1Ap1E=; b=X2DnU6RIfDKELF3EbwXQidlyFUnLTEym0ONDZuP/3x4P1368wxpMlQIBkey2XfGrlNwD1dpKcZwceGxLd0bAU9EOFJDFiR2Q9khd6O4zh2PKhI2NCkimFXvoS6yLYWCznkwWjtv9X5QfRW8/VU3PPq816r+9lF+Nma+/yGeBiomc+M9wPHGHJp6xaRchmf8s+SFZxHtlBAOTWasjgjRMjRl64YUZ/PFqBFNrXO2ZFt0U+eddc++lFkLJJxTYaLUs4RqzE2N0z+pnj7e96XND5/lUouoCPrEhc90/lsKewULW+LSXn/xZFP70fbRH56owRuhznNdpeFnYP2Q1eqGLKw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Oct 2024 22:51:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30533 invoked by uid 111); 1 Oct 2024 22:51:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Oct 2024 18:51:13 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Oct 2024 18:51:13 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2024, #01; Tue, 1)
Message-ID: <20241001225113.GA2317071@coredump.intra.peff.net>
References: <xmqqr08z254d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr08z254d.fsf@gitster.g>

On Tue, Oct 01, 2024 at 08:51:46AM -0700, Junio C Hamano wrote:

> * jk/test-lsan-improvements (2024-09-25) 3 commits
>  - test-lib: check for leak logs after every test
>  - test-lib: show leak-sanitizer logs on --immediate failure
>  - test-lib: stop showing old leak logs
> 
>  Usability improvements for running tests in leak-checking mode.
> 
>  Needs review.
>  source: <20240924213404.GA1142219@coredump.intra.peff.net>

I think these got a favorable review from Patrick:

  https://lore.kernel.org/git/ZvVtcJOsbbrnWukB@pks.im/

Obviously they're not urgent, but it's nice for people working on
leak-fixes to have them as a base to work off of.

-Peff
