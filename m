Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DEF1F5608
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074678; cv=none; b=MqoO+pJuCQnCYKPE7lLCxzy/HpS94O4u3uAHch8W/5ti/wGP+WTABGsVV0tdilOa/M7wK4WIp8nucfJELzv9pTR3GikIarsgXd5gZvRt5M8PiNg0eoFFwL1f9TevqCu8FPjOlP2sfKamangEPUAaeeuLxWurZQuKSeimvUAe06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074678; c=relaxed/simple;
	bh=mRvuZVqjCMNe145ulc4elx8USwSIvcy4clNnffcIblY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWDUGlpwPvfgH62W6ccKmPWQoRQ+l09bBqEiZcazLpNdhPK8Lvhxl68Rgy7cKw6YJu7CKpdT7pirUQsd5Vq710lGjjJ9vh/4qLIsdLc4QrE76JJ88QFbtyOgqvtXLD9LOFSsBFpsudtWNmrUH1qYRE+TfXome+sW7S4wpywz41E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Lm9Xp3Y8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Lm9Xp3Y8"
Received: (qmail 9571 invoked by uid 109); 4 Mar 2025 07:51:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mRvuZVqjCMNe145ulc4elx8USwSIvcy4clNnffcIblY=; b=Lm9Xp3Y8FiABT+tot5NmaCeEL1n6IhKPLLz06/gLFZ2qdSS1cVxf9mlZw6xFd5lYnxbmK5gfCgBBbMlBRD+KDnvLXrXfuo0Gkc2bxEWJOxlotgOSS3M2g5PDlyl/uc5TFTtosVIqI/6kI5NNnrS8B9ehVvzzyd7RHLMcOkTUoyupzaAT2+nVNbn+rUonq4dgQSVvwLAtjfKohSOiUm0rf1aZkPHiOeXrh8ORziGnAzg4nkhdye7BxzFtx3hKfLB7K0JZUUs1kzPMfQZRx0aag8PZXisTDK/2SlWqObxRf6VachttllKPOiH2TUuOYLZyol5WQGsuIQZ+3mw5iX23Sw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Mar 2025 07:51:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22898 invoked by uid 111); 4 Mar 2025 07:51:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Mar 2025 02:51:14 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Mar 2025 02:51:13 -0500
From: Jeff King <peff@peff.net>
To: SURA <surak8806@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: The transfer.hideRefs of the upload-pack process does not work
 properly
Message-ID: <20250304075113.GD1283943@coredump.intra.peff.net>
References: <CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com>
 <Z8D/aiqN5e/aRSn7@nand.local>
 <CAD6AYr84KuBb5N-LVBQo-6Gq2Ms3JKQCk0gyO8i=N8gp3whe_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD6AYr84KuBb5N-LVBQo-6Gq2Ms3JKQCk0gyO8i=N8gp3whe_Q@mail.gmail.com>

On Fri, Feb 28, 2025 at 10:32:01AM +0800, SURA wrote:

> My previous description was not clear enough. The early hiding
> according to exclude_patterns in packed_ref_iterator_begin seems to be
> designed for git for-each-ref's exclude. It is different from the
> ref_hidden matching rule used by upload-pack.

From your reproduction, it looks like the issue is that for loose refs,
asking for_each_ref() to exclude "refs/heads/foo" will not yield
"refs/heads/foo/bar", but will yield "refs/heads/foo-bar".

And that was true for packed-refs, too, before 59c35fac54
(refs/packed-backend.c: implement jump lists to avoid excluded
pattern(s), 2023-07-10). After that, packed-refs exclude both.

So probably the solution is for the jump list in 59c35fac54 to be
pickier about finding its start/end points. It should insist on a
trailing "/" (I think end-of-string would also be valid, but it may be
easier to ignore that, and it is OK to err on the side of inclusion,
since the caller is supposed to do their own filtering).

Probably the logic needs to go into cmp_record_to_refname(), but I lack
sufficient brain power at this time of night to even attempt a fix.

The smallest reproduction for me is:

  git init
  git commit --allow-empty -m foo
  git pack-refs --all
  git -c transfer.hiderefs=refs/he upload-pack .

which shows "refs/heads/main" (or "master") before 59c35fac54, but not
after.

-Peff
