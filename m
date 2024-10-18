Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7513AA3F
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 04:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729227119; cv=none; b=ANulJqZTVdn6kk+bvN/XFap78w1uhZgsYUVZGb2ANIZG3yHG3UstLjCGAa6vDhtPSKdJj/A2EaQemPjplvNvaByBIqMauuIhwjElpgbHzicK7+kcdTKzZTxSGRRhTVw0no9KC97SXmikN8g6zvb9tSC/L7Yf9sp4byzM8SzGW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729227119; c=relaxed/simple;
	bh=dNw+4GO62BfUmICic8pm9OlEPRWJhK1caoKTFWlWvik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw0JMSnl5aSI80CtKRYssWG6rnFPwies6k0cHT9ulZPdA4sMfKJABcNARVnO3mLsSG/uwhWc7WOzBdD3nqLd+DAzQUl/nwNy5U0R659fXSQ/J2QR6yIt2TBaGwcv8HcilSavMs/8HyqooQ+R7tnQz6cg1XmKS2OQ0subhnl/ong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PKc+xqwc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PKc+xqwc"
Received: (qmail 32278 invoked by uid 109); 18 Oct 2024 04:51:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dNw+4GO62BfUmICic8pm9OlEPRWJhK1caoKTFWlWvik=; b=PKc+xqwc2SMhECuTwH+4FMCnh2151TZGC2B5ccanIhm9TRqlyfv5i1vkLdvlN9n/0liXwxlvngB7Ce9g5CDZkHbnmoH2yWsuaGtaKKE4pW7WN1V6xRpFwo+U79re6oxYnHRaJeN0rUTQ7f+d/w8ri4VtjIi4Udmw+jnbnAijet4wOToJqobX6VlWS68ktb/hlf106B0J+QLO57AQ1ECMKOMnlNR0STMX1CjpWuQh3RNPMJp5koEOWiePTV00okkj8T7PjkgWPVGrLWqJp0A0XDte4WCRqKJJ7uaCdr9DFZ506W5m/OPu7721/s+VXQF82TVdRMPST+oCI4AUZ22HOQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Oct 2024 04:51:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12778 invoked by uid 111); 18 Oct 2024 04:51:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2024 00:51:56 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Oct 2024 00:51:55 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <20241018045155.GC2408674@coredump.intra.peff.net>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>

On Thu, Oct 17, 2024 at 10:21:43PM +0000, brian m. carlson wrote:

> > We unconditionally include <wchar.h>, and your system does not seem to
> > have support for it built in. So why doesn't the `#error` trigger? It's
> > also not like this is a recent error, it has been added with 581deed72
> > (The obligatory forgotten files..., 2002-05-06).
> > 
> > We can do something like the below patch in clar, but I'd first like to
> > understand why your platform seems to be broken in such a way.
> 
> Yeah, this is definitely broken.  We require ISO C99, and according to
> the draft preceding the ratification[0], `wchar.h` and its contents are not
> optional.  The similar draft for C11 also doesn't appear to make these
> optional.
> 
> I think users of uclibc will need to compile it with full ISO C99
> support.  I expect that a wide variety of other software will be
> similarly broken without that.

Perhaps, but...don't the current releases of Git work just fine on such
a wchar-less uclibc system now? We don't use wchar or include wchar.h
ourselves, except on Windows or via compat/regex (though it is even
conditional there). This is a new portability problem introduced by the
clar test harness. And even there I doubt it is something we care about
(it looks like it's for allowing "%ls" in assertions).

Our approach to portability has traditionally been a cost/benefit for
individual features. Standards are a nice guideline, but the real world
does not always follow them. Sometimes accommodating platforms that
don't strictly follow the standard is cheap enough that it's worth
doing.

I think more recent discussions have trended to looking at standards in
a bit stronger way: giving minimum requirements and sticking to them.
Certainly I'm sympathetic to that viewpoint, as it can reduce noise.

But IMHO this is a good example of where the flexibility of the first
approach shines. We could accommodate this platform without any real
cost (and indeed, we should be able to _drop_ some clar code).

-Peff
