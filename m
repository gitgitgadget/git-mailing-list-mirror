Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED02C1586
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774111295; cv=none; b=fl85jdatwvZQi51VWxAA1VxPPARFMKWyybkLPtwd5A6N8DGvUDyqioIesuS2GHGzTIuV4c2krsm5yrA6EwSEBWFjNS/7EfpRp3qjFXaft6QgwLNLtSTiOTFsPCRs70cSd60kt+Fxwba2ksLQ6SIWcmqes309Wen7eZ7AKKd4VQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774111295; c=relaxed/simple;
	bh=WslnzNo15MppDaGbQvTGzj3MgdIZ7+O0tx9ZHSdj8pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jj47mDvEdg6MBchblXllo2U4+foldPGTsNFXkdMSaHXZ0epu8ltNU2eVeyQv+V4g3Yps0Z5M7OGcK00maysW0yN/XiDgzWA2f/zSpPu6Bm5VVxP0R3G9gnI44jV+h1UpCZ78iHIMWIYWuwrjKNkHb5riQhURcuam9nPdUg1fmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ER7QhM6M; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ER7QhM6M"
Received: (qmail 85604 invoked by uid 106); 21 Mar 2026 16:41:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=WslnzNo15MppDaGbQvTGzj3MgdIZ7+O0tx9ZHSdj8pI=; b=ER7QhM6M5CKHSdUDnaUKgIPY9AoHuj9rH+H99rXZxucCSto7cvRyhxXoTBnA2A0qZ1n/RzmvO7yZrl4yeUPVAPcdGlpcDMnksbJYcnsNJcUgx7iF7Y0nuWuNo/By5c8g0i2zRbeCyzEnXMq9B4oyAZScz/qz1zWN1lpHsmVmXyML77GxDDvKgSqaU7Yvo8Mk7LajidOXuDZ/4v/0SdGPBE3rViX0MGBbWH2rg2zmPcFNOPhn7KhK3TvZhf+lkHB8F2j38a7srgfr2L/qAidJJ/v8TK5uD6mEmljxBChIon6hKuTgaDmsx4kLN6ULLHcZv9KhdMYpvgCKtVaUKNDfSw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Mar 2026 16:41:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 120421 invoked by uid 111); 21 Mar 2026 16:41:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2026 12:41:32 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Mar 2026 12:41:31 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
Message-ID: <20260321164131.GA717199@coredump.intra.peff.net>
References: <xmqq341wnvbk.fsf@gitster.g>
 <xmqqcy0zii0s.fsf@gitster.g>
 <20260319233546.GA3632561@coredump.intra.peff.net>
 <xmqqcy0zgtmu.fsf@gitster.g>
 <20260320041803.GA18125@coredump.intra.peff.net>
 <bed43331-ad9d-437c-a56a-94a50877f719@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bed43331-ad9d-437c-a56a-94a50877f719@web.de>

On Sat, Mar 21, 2026 at 02:14:51PM +0100, René Scharfe wrote:

> >           if (feof(fp))
> >                   return EOF;
> >   
> >           strbuf_reset(sb);
> [...]
> > I think the strbuf_reset() could go away even without any other changes.
> > We always adjust sb->len in the end to match what happened with
> > getdelim(), so there is no point in doing it up front.
> 
> Yes.  Same with the EOF check; getdelim(3) is (must be) prepared to handle
> that for us.  An early return at the end of the file avoids the translate
> effort once per file, but adds the cost of checking for each line.

I think you're probably right. I added it in the original as an attempt
to simplify away a tricky case before manipulating the strbuf, but we
have to eventually deal with those tricky cases anyway, since we may see
the EOF fresh from getdelim().

-Peff
