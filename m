Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9933033FB
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 04:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783140467; cv=none; b=Zd5dtyTVApVXFIwK5p18Q7Uhmuh5nwh9KsYrvvyANKzAsvG9gKXWfth+6ybetOtScxCt4ITT6AphdOI5IBZc2JSp74OY0x1DwBrhZDascBvdAG0kOjMTzfxcOyfkrLeIvJooWNmhYHyyaS9CvlGerUsakpKX6N05r1bDquzIDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783140467; c=relaxed/simple;
	bh=wNnexDXo2pGdQ1Z8ZRv8WTMSf7biguaIKG6xTHw3Qbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzZr75hSIpW+guI7mQsVKhJBU37S4s4F9QosEAERBnMloiN2zT1BM4G703MEpJrXqtzIuouyFWb2Hgi2CpB0SekOyDv9uJA2+W/pnX9magve5RQ6TFoCiXYSY7dEgIBpFGcoY3TZRYjKadCYJVEUP5Ht8kZxdzN9F5WHn14b3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iCi2z9Wv; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iCi2z9Wv"
Received: (qmail 99088 invoked by uid 106); 4 Jul 2026 04:47:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wNnexDXo2pGdQ1Z8ZRv8WTMSf7biguaIKG6xTHw3Qbc=; b=iCi2z9WvGvvAG2RVpZibNOuCNcTS2VKSX0K9eNxWk9V1maWbS4hpsCuK8qQNHMv99EKm+2+LowTr64vaIjr/onLS9UZcF8NeReoh6e2GVLaOHHk7QUM5pMBKB7DM2qASl3nIU/jKeYntCXF/JUe5jB0af0c36J+udzbcAOHe1mkzJFKMae/L+mVmhwxIa++yvTADNxu9ctfS73xRafJy3wXGae/qfb0kN0XKR1fMErWKKkNKHjy9VU19jSprgOIqoC8qtEXOHraHV0UbGiMsyjQHbNdHbFwXu5qdB0XDOZA/t7a2GteBbXEprciBlOEJtgP6+AfHYoYI03Zrcs235w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Jul 2026 04:47:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 207679 invoked by uid 111); 4 Jul 2026 04:47:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Jul 2026 00:47:43 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 4 Jul 2026 00:47:43 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] t1517: skip svn tests if svn is not installed
Message-ID: <20260704044743.GA2255427@coredump.intra.peff.net>
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-2-sandals@crustytoothpaste.net>
 <20260702053724.GA3437623@coredump.intra.peff.net>
 <xmqq33xzize2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq33xzize2.fsf@gitster.g>

On Fri, Jul 03, 2026 at 01:36:37PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > fed to perl (no quotes around 1.1.0). We sometimes catch these cases
> > automatically it results in an extra argument to test_expect_success,
> > etc. But here you are unlucky enough that it does not (and anyway, we do
> > not seem to have the same safety check for test_lazy_prereq; we'd just
> > ignore the extra arguments).
> >
> > And of course being perl, it doesn't complain. I'm not sure how it is
> > interpreted,
> 
> I happen to know ;-).
> 
> When you have more than two sequences of digits separated by dot,
> like IP address 192.168.1.1, you are telling Perl to interpret the
> sequence as a string, each byte of it is the number denoted by these
> digits.  I believe this was invented primarily for IP addresses, but
> it does not have to be just four digits.  To wit:
> 
>     $ perl -e 'print 65.66.67;'
>     ABC
>     $ perl -e 'print 65.66.67.68.69;'
>     ABCDE
> 
> Of course, 65.66 is not AB, but a floating-point number that is
> between integers 65 and 66:
> 
>     $ perl -e 'print 65.66;'
>     65.66

Ah, thanks. It is both exciting and horrifying that in 2026 I can still
learn new perl esoterica. :)

-Peff
