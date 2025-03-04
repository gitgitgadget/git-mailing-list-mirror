Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D851F8921
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074709; cv=none; b=CkVwLEgaAL+Sh88S0O5t0r/ZtfW930D95A8Sa355JtWo5O9flTtFZplsW1HkPt6b7hPe3w1/aJ1FqPrpVUI+TpKMENi23YbfLvg55I+eANPimQVM+clVWyJnlPzQu8AXQi4TxOWVFFptI1zUGYPA9p6Kr8Ws0ns7WTfuCGsOfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074709; c=relaxed/simple;
	bh=YiH8IcCaCjzPJq1XsKZ5gC5+ZNHxQj/+lyN3E6GBBN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVRqTP5Xi4Af5RxRdtvDFLTaX3kkG9tsNyp9om8eZmfXx/GVOwyuNnbobr7gi3X+cQTmX5TwC2oQ+5FBHLuOp6EdWNJJQcGhk4HBwIbxnByA6dd8mEMShk9Eg+9GQEgsj2U+UVjIXZdiN4Dj/b1x3MBrjxCB+M7DWv9aGTELHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AIm+mzad; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AIm+mzad"
Received: (qmail 9583 invoked by uid 109); 4 Mar 2025 07:51:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YiH8IcCaCjzPJq1XsKZ5gC5+ZNHxQj/+lyN3E6GBBN4=; b=AIm+mzadAj2SH6H6miqeIN79B/AmCZcnD8bPBIukYrf+LVLd7gZ57uRF1tXZgKHgbBN6SYyGb6/MWv03zyTM42PChm37lN0udf+tIQMRSAu6ImPWd6mJlWEvF542/LaQHw2ZVRw9dwwp3iIs04/lOjzjKbX5IlVhtNrHIm6bcUl1/EQKHrKwWtXZj7N9XsoccUA7lsumIIA/co31SFH05ZwbC9BRM1epTfJEr9f96wJeG7Toii7bUYSmqJ6BFa1p0/1RgK12lQUXnWuCoST4G9BobiACtwFPJrgbHtYo7gy2nFGy6ZhPTG52HFx8Qc+jMpA0i8sWCvxWc1Y7umoL9w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Mar 2025 07:51:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22925 invoked by uid 111); 4 Mar 2025 07:51:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Mar 2025 02:51:46 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Mar 2025 02:51:46 -0500
From: Jeff King <peff@peff.net>
To: SURA <surak8806@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: The transfer.hideRefs of the upload-pack process does not work
 properly
Message-ID: <20250304075146.GA1297781@coredump.intra.peff.net>
References: <CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com>
 <Z8D/aiqN5e/aRSn7@nand.local>
 <CAD6AYr84KuBb5N-LVBQo-6Gq2Ms3JKQCk0gyO8i=N8gp3whe_Q@mail.gmail.com>
 <20250304075113.GD1283943@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304075113.GD1283943@coredump.intra.peff.net>

On Tue, Mar 04, 2025 at 02:51:14AM -0500, Jeff King wrote:

> From your reproduction, it looks like the issue is that for loose refs,
> asking for_each_ref() to exclude "refs/heads/foo" will not yield
> "refs/heads/foo/bar", but will yield "refs/heads/foo-bar".
> 
> And that was true for packed-refs, too, before 59c35fac54
> (refs/packed-backend.c: implement jump lists to avoid excluded
> pattern(s), 2023-07-10). After that, packed-refs exclude both.

Oh, and of course it would be interesting to know how reftables behave
here, too, as I think they recently learned about exclusions.

-Peff
