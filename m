Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F412C49C
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906483; cv=none; b=h/cPCqkh86XIZD/XJop2lRgIXeijINNiKXwCjQ5tGI0ln77Fz38oepRAvJ1b3xILs2AT8pRWpsT2D85rLy/pJUpUG3ckPXhGSAG7pZe3I48uZ66Qy+anxGVAvNK7MDMunrfhSb5Kyd8qMbqzan2BwDfl9Q8EVNyXmGC3mva9nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906483; c=relaxed/simple;
	bh=pHpZDO9/27IvSma9g+rfdON0NGmo/HvEiOKyyb66Aic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meir6nm4ZjntTwvvgthR3ZTSYGBsvbdlYspEn3O83EFB2Qmm7trwIFpRlnxOjCjCzhlFsIUcJ6RZRNC01YSb19yC2IoE8hswbe23Onx83F1ANEKxXABlUJGsKVBEIejHW+dWqZSvap58Dxku2Md2D9+xpgMcO3/VI2cBZiVYdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QVvbkTIf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QVvbkTIf"
Received: (qmail 9953 invoked by uid 109); 2 Oct 2024 22:01:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pHpZDO9/27IvSma9g+rfdON0NGmo/HvEiOKyyb66Aic=; b=QVvbkTIfWLlg+WBcfTf/hZYR0BfHFckXZWNR+cBfmYVgd9uUZwEmEavrctOuUz2HmdlRW5dNF3leMK7um0JQjI1PBgviih2wpaNR8nKVmhvATQkBba0sWPr9i5sRKmbQSlPTTmF4WrgCpAgX5omVC9cLRm3gu5XG+KNogRKahsM7dRjLMvqqI/5fIMZFytQSZFvGstCTFBb2pLGjlACwUc4BYJ02GuK+5pGoz3vT63Nui1HStzMbZsVCkFNZicCTFZx+vpmZKbxtPpBqdDig3PbleDlsTa6nJZx8nziacGN7i7VdmqCyTDLtxMPYvRVxDH+NNOY/VMe0tE1uT7+RNA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Oct 2024 22:01:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9889 invoked by uid 111); 2 Oct 2024 22:01:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2024 18:01:19 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Oct 2024 18:01:18 -0400
From: Jeff King <peff@peff.net>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Fix unused-parameter warnings with NO_ICONV
Message-ID: <20241002220118.GA2892418@coredump.intra.peff.net>
References: <cec3d068-38d3-4802-b2d0-77644dd425c3@app.fastmail.com>
 <20241002200140.2123584-1-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002200140.2123584-1-mh@glandium.org>

On Thu, Oct 03, 2024 at 05:01:40AM +0900, Mike Hommey wrote:

> The jk/unused-parameters topic enabled -Wunused-parameter. Some code in
> some non-typical configuration lacked annotations.

Thanks, this looks good. I tried to catch compile-time variants like
this, but I was mostly limited to what we build in CI.

Out of curiosity, what platform do you use that needs NO_ICONV (or is it
just a preference)?

-Peff
