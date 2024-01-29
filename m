Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C23F9FE
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552410; cv=none; b=HtKeTs9rSDQQklFKatqFy0BchRybcw01wvJFvrNZ68nR/DTyM6GxJvQwCf8wunzSa3XAlalUJ5i8YYRab6dX1QsrVkSgP3uCsSlex4VqQCCh1Rznh1CemI2GTnN8se90iRMPSIDOSrNcfhaw22nQw+yqDbuZr0q2TV3FSV9usMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552410; c=relaxed/simple;
	bh=t3xwR/5AmwlCDRtXG4L6dxZdKoSCp+SLNUvC/40+xHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJQgTekORIyDoQDneewNIBIVsIF9V9J/9DOwVEWZvmxn22++WX5HqPLQZyVytsGShSTCVLlIlL8Trh2J98Vgmy+/gAC0U0i/8EPhcjiL4REyG9jik+DLZl479ouqmhHkjhlkbQX8OS4O+Yb5uRm+SsA6rObVY8P17Cdr7x0phls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 325 invoked by uid 109); 29 Jan 2024 18:20:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jan 2024 18:20:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23696 invoked by uid 111); 29 Jan 2024 18:20:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jan 2024 13:20:07 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Jan 2024 13:20:06 -0500
From: Jeff King <peff@peff.net>
To: Sergey Organov <sorganov@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
	git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
Message-ID: <20240129182006.GC3765717@coredump.intra.peff.net>
References: <87plxr3zsr.fsf@osv.gnss.ru>
 <xmqqa5ouhckj.fsf@gitster.g>
 <87il3h72ym.fsf@osv.gnss.ru>
 <xmqq1qa5xq4n.fsf@gitster.g>
 <87ede56tva.fsf@osv.gnss.ru>
 <87a5ot6tos.fsf@osv.gnss.ru>
 <xmqqzfwspmh0.fsf@gitster.g>
 <87ede4fg8s.fsf@osv.gnss.ru>
 <xmqqzfwrjdul.fsf@gitster.g>
 <87jzns7a8a.fsf@osv.gnss.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzns7a8a.fsf@osv.gnss.ru>

On Mon, Jan 29, 2024 at 12:35:49PM +0300, Sergey Organov wrote:

> >> I'm still arguing in favor of fixing "-n", and I believe a fix is needed
> >> independently from decision about "-f -f".
> >
> > Even though I do not personally like it, I do not think "which
> > between do-it (f) and do-not-do-it (n) do you want to use?" is
> > broken.  It sometimes irritates me to find "git clean" (without "-f"
> > or "-n", and with clean.requireForce not disabled) complain, and I
> > personally think "git clean" when clean.requireForce is in effect
> > and no "-n" or "-f" were given should pretend as if "-n" were given.
> 
> As a note, I'd consider to get rid of 'clean.requireForce' anyway, as
> its default value provides safe reasonably behaving environment, and I
> fail to see why anybody would need to set it to 'false'.

Please don't. I set it to "false", because I find the default behavior a
pointless roadblock if you are already aware that "git clean" can be
destructive. Surely I can't be the only one.

-Peff
