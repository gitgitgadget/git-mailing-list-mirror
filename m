Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7F25393B
	for <git@vger.kernel.org>; Wed, 13 May 2026 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690845; cv=none; b=eETd7fNXQDX7xH3LkJeqYMPXkcnJU+05rEllEmEtJeptygzEYG//V4OTr9VTExjLdNSiXYkjVPvsGPpU1B6zaAtI0tuYVoVnIKxJO68CDgKy60WU1U0L6iDVx1/8904r+wjC5dhoIY5AbXCPulMW6gFxCTkqGV7Y0V9+t8r7dkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690845; c=relaxed/simple;
	bh=jAStT8fQuQVsX1iOX3Rg8uaENsm4k4H1M5YHRh1aw3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0RQmPAmJP/oqWADFdSnu8YtIBvX3nJm92ST4hYBktmdDYl5wFy7q6CWwQv2bn3uM9VXlIxXDDb1NaZzGBF0JjfsafiDN/+rCzGBi8BR7PckoYdsmj/CkyjBgx/x75UWCzh05di6fcWT/mIyJVYn36Efo4XKP8UnTT8Hkf6C0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JqXOzrcI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JqXOzrcI"
Received: (qmail 39211 invoked by uid 106); 13 May 2026 16:47:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jAStT8fQuQVsX1iOX3Rg8uaENsm4k4H1M5YHRh1aw3g=; b=JqXOzrcIiSNX9978u5VRJYs4HWUyT3NFkuIIONMfgK0MvyhYRLlgcYxiDL8XL367YtZ8cCPkjDhxUTRKno1Ok2tJeMrsTmprEgGi17S/GCbCVt02i6H3v7V338yPPBPYBjGLMVhUxiovdBxAgrKHfVh0tOfPiLENO6ZabaIRNrETzEy3+OwgkYlSMiJB+1vxEuYZIehwBmC4V0yWjuYjY5NnbfaqSGbOiXeBq7cQKyT5Mv0cmjlRu/sTUequBbbGtsFTsUkZloBOT4bTuaQraQ+5cdxhVPLelv7cfmrBMwdXjkszev7myJ/7U3Cc35RzyrN8vobStjoC1dQ9ineXkA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 May 2026 16:47:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67353 invoked by uid 111); 13 May 2026 16:47:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2026 12:47:22 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 13 May 2026 12:47:22 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] strbuf: add strbuf_add_uint()
Message-ID: <20260513164722.GD103037@coredump.intra.peff.net>
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

>  void strbuf_add_uint(struct strbuf *sb, uintmax_t value)
>  {
> -	char buf[DIV_ROUND_UP(bitsizeof(value) * 10, 33)];
> -	char *end = buf + sizeof(buf);
> -	char *p = end;
> +	unsigned digits = decimal_length_u64(value);
> +	char *p;
>  
> +	strbuf_grow(sb, digits);
> +	p = sb->buf + digits;

This last line should be "sb->buf + sb->len + digits", of course.
Naturally that was the part I wrote by hand. ;)

It doesn't matter for the cat-file test, since we're always formatting
into an empty buffer, but it does for the ls-files padding one.

-Peff
