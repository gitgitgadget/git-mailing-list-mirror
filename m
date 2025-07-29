Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBDA1FDA8E
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753773179; cv=none; b=sinI+cV19eMaw3MC9/qV6h0KDON7HJEmSo7MlwFknIRdBWNw0paW7PzDg6rJIFrYQcnj/X8R2M+dbzkEpc3CUCspjnNo32cKiblF/vUpOxhPhgbTL5E3j3BYBp/O/9k9so9jISfEZz4joWkUrSfEnbgf3FqGMDFLYOc8erIQE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753773179; c=relaxed/simple;
	bh=emnlLjaXzkHSRy7hD7nnuUA3DYp1AM6bB2a2o/tjWjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3hXwIOF9Rwwws+o1XZ5sCYZWhVGz93HQlbrNGmV9sA++Uf/nuWun4O7hhDja0tIi1R+76BEO5iXasl8hIyDNIy8mRnwjr5EzdTOtVQCCCLWRfjQrZvNmH4NaxYDx4Y6ZFY3egI2Lhr+udF06sn3GHoP0tfK8AgvvejYdoRWYFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fZZLWk/B; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fZZLWk/B"
Received: (qmail 1992 invoked by uid 109); 29 Jul 2025 07:12:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=emnlLjaXzkHSRy7hD7nnuUA3DYp1AM6bB2a2o/tjWjw=; b=fZZLWk/BputkyDlSTYZpr2PNsDwj+lFjAfpVCcqGzMM4G+B2xciQt9cKSiKmJujwofp5D7U7LY0Cq79k2fcOyFDRHkAnnP4qPlX+Uh0hnM9KIzTA08P2t8xbOs02qjf7LeKqYN3DvrWz6+/ZE4RFpi+p1IL70ORLusihY6jdIcTz2RAah9S9XCI43E2PHx0OSy5DfXU+s7u03ipmFLx2syKkFHc505E1a8eYpRWTW2YuTobwdub4L+rVTCNI4sF92bLUWDv9lnQcMFtvGRskPh5e5os4pyGGq8nersldav5wKF2kTjVcYNj+gLEy4xAPHEU+sN+d1mtndpJY18TS2g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Jul 2025 07:12:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30409 invoked by uid 111); 29 Jul 2025 07:12:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jul 2025 03:12:52 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Jul 2025 03:12:47 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonas =?utf-8?Q?Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t7510: add test cases for non-absolute gpg program
Message-ID: <20250729071247.GA1426859@coredump.intra.peff.net>
References: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
 <20250722190922.51183-3-jonas.brandstoetter@gmx.at>
 <20250725043043.GA3002998@coredump.intra.peff.net>
 <xmqq5xfbuahx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xfbuahx.fsf@gitster.g>

On Mon, Jul 28, 2025 at 05:05:46PM -0700, Junio C Hamano wrote:

> > Should it be "/d/a/git/git/..." instead of "D:/a/git/git/..."? Which we
> > could get by using $PWD, I think.
> >
> > The earlier one using $HOME uses D:/, but this one is different because
> > colons are meaningful separators in $PATH.
> 
> Here is what I have on top of the posted patches.  If today's
> integration goes well, I plan to merge it to 'next'; the rest of the
> series is already in 'next'.

Looks good. Not sure if you saw the patch I posted in this thread. It's
roughly the same as yours, though I didn't drop the useless "env" (which
I agree is useless).

I did reference 71dd50472d (t0021, t5615: use $PWD instead of $(pwd) in
PATH-like shell variables, 2016-11-11) to try to give more explanation
of the two different sources. But re-reading it, it actually doesn't
really clarify much. ;) So maybe not worth worrying about.

-Peff
