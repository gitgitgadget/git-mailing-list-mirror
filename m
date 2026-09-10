Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985839AD51
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057886; cv=none; b=FWsf0dIe1ZDmfrR/PecmniyBh//Jzh/7xVPGk0KLnMIPglX02/NfAjNxo191hiOitvLj1ZeTX4FurJNmDZ/Dy1gun/y6WGtDjYSr+Iznw9ltcAJek4I2K+JpP4ip6QzcSCMncLchOggwtEBIOOISwQ299GECVMoa/fasMRFH6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057886; c=relaxed/simple;
	bh=efGBCczhare3B757q2GP1woPRfnBt2fOLKC5+Ad7cuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLebWzqZG3BfhtJxXPBLELgQXpTzL4GzqBqFuCD8DsdmU3JUAjlIOrPCUVOKVzBETeN/XBnLnULYLJ8FCf6OwJFk5OtP529Rfd59k1omKvzlrKkt7zJfDxFQ6DE5YimXZ+Mh57IzxSXxGjc2lWkxstMvzADhNWCBwpj9Z/Ljdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K77L/8W4; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K77L/8W4"
Received: (qmail 31296 invoked by uid 106); 10 Sep 2026 16:31:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=efGBCczhare3B757q2GP1woPRfnBt2fOLKC5+Ad7cuA=; b=K77L/8W4+dPvPsNF3os3f+P/qCsfjjWkb8zIPQtkLmidWHRcvAKsjUT7lr74u18Upe/yxsEqu/u+maaO0ly6t9aFe3NWE3cJ/cIN2kZsL3hAPV9MGpcICcpZVQv+oqY48WdmhppOacfb1VxOylsffgJJo+zmdnOTLK7JQGgC4FDueDoy3NHPTTWz282FPbHOaK0qa0cpwu7w03a5Pm7u5njfEafihqBOZLRt7WOrG5zYcAYE+6ZZmuWnVMH+56yG0Vsed33FSrHPd6Blt+OOZagiyqdU1t+PmZI4Ajv99tdUOa00TrecRnbhtf/88f1STRJg4lqfJoIjilFczV/LZQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2026 16:31:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157495 invoked by uid 111); 10 Sep 2026 16:31:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2026 12:31:21 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Sep 2026 12:31:20 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>, ben.knoble@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH] advice: use global config for default branch name
Message-ID: <20260910163120.GD251185@coredump.intra.peff.net>
References: <xmqqik4fyaav.fsf@gitster.g>
 <20260908213840.37833-1-ub4nal@mail.ru>
 <xmqqik4fwoz5.fsf@gitster.g>
 <20260909155440.GA94069@coredump.intra.peff.net>
 <xmqqv78eqmw8.fsf@gitster.g>
 <20260909195132.GA182066@coredump.intra.peff.net>
 <xmqq8q594tvs.fsf@gitster.g>
 <20260910043356.GB241223@coredump.intra.peff.net>
 <xmqq1pb147w2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1pb147w2.fsf@gitster.g>

On Thu, Sep 10, 2026 at 05:18:21AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But I think the bigger question remains: if we did this, would people
> > find the extra lines giving the turn-off instructions ugly/overwhelming?
> > I'm not sure.
> 
> Well, if they find them unnecessary then they would want to turn it
> off and the instruction is already there ;-)

Well, it would certainly increase my desire to turn each one off. ;) I
guess you can set it to "true" to suppress the turn-off instructions
(but keep the advice itself).

> More seriously, if an advice item is found as such, then the item
> either must (1) be beneficial enough to be always shown, or (2) be
> so rarely shown that the turn-off instruction is unneeded.  It would
> inherently be case-by-case basis but I do think we would converge
> between unconditional advise() calls or advise_if_enabled() calls.

Right, I was wondering specifically if there are items in (1), but you
said it much better than I did. I guess we wouldn't know until we try
it and see people's reactions, though.

-Peff
