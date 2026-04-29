Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744F33A5E87
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447817; cv=none; b=Tv62UAlfTXM3kF/fvxlhtEQCLhz9zWXajlKEGecNvmy3n7TqY9fWB4qqmSxP8nWKW/d1RgMYfddP2lWFtjkL9fHF6c0lJVY0roxLswOwFA53R4GeA2DILfPTjNJdT7uHmhrJPm/jSB8dnl+KeM+C3Wq1DdXbtxQF2OuVWzA5At0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447817; c=relaxed/simple;
	bh=IaWa0LDLxqg1AiQJMUQSQVzvi6pMZZN9LY3J3EPPU2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btoKLbcPDiqzsn9sRmc8wNlCueh/nIuur7tI61/GgZjrFEl5DwuHq28BAsa7kx3CL7aw/3RBJAl1MK9yBJL6Oqn0YLfu6cj9x2LOZdAbp4nqjc/NqlJG09/oILe7ZJUaFFKAxVM00cLfF6xt65OimQHrGRO29sm+3gw1tU1hlJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SJCryhSp; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SJCryhSp"
Received: (qmail 485705 invoked by uid 106); 29 Apr 2026 07:30:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IaWa0LDLxqg1AiQJMUQSQVzvi6pMZZN9LY3J3EPPU2I=; b=SJCryhSpq1b3R6C66PZ2yCJOgeXmsFGi9go63nbPfrVt8zhYfqqdo9nHdYTamImmzHrd8yGAxLlSHDqcDToBrcI7srGSfY8TfyjX5MSZWCuX3+ctJgdDh8s5liO+YXUYR/lvd9X5F1nUudAqB6Nu9b5o9W+RkIMUE0B6wzg5jIOCo5HAENJMg447QvmUDscavuo/VQu1N/1LH8xU2I3h9Cu4tNADwS4+YdskdCAbRfWaWOqQWgCDREydyMXKuEqi46VHCNAGzNPsCkvysMCzW0ui0oC4XEYYFjQ8yZT8Iiuebr0qeoZwKoMWahFU/QCAb4B5A5Lf70+SMruJY63UFQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Apr 2026 07:30:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1099371 invoked by uid 111); 29 Apr 2026 07:30:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Apr 2026 03:30:02 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Apr 2026 03:30:02 -0400
From: Jeff King <peff@peff.net>
To: Theodore Tso <tytso@mit.edu>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Simon Richter <Simon.Richter@hogyros.de>, git <git@vger.kernel.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: Re: Git generated tarballs and Debian
Message-ID: <20260429073002.GA717507@coredump.intra.peff.net>
References: <9030b26d-02ed-4452-b212-a69a4ff21e2d@hogyros.de>
 <afCLFJX86yEPKKfk@fruit.crustytoothpaste.net>
 <20260428115017.GA71700@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428115017.GA71700@macsyma-wired.lan>

On Tue, Apr 28, 2026 at 07:50:17AM -0400, Theodore Tso wrote:

> I know that in the past, using --format=tgz has broken based on
> different compression parameters used by git (and whether it used an
> external or internal compressor).  I also know that if $commit is a
> tree-id, this can result in the timestamps being not reproduible.  I
> also don't use export-subst.
> 
> There is also the difference in the prefix used by github and gitlab,
> but that's arguably not git's fault.
> 
> What other gotchas are there?  How is this likely to be inconsistent
> in the future?  How much work is there to provide that guarantee in
> the future?

The biggest unexpected change I recall was caused by a bug/compatibility
fix. 22f0dcd963 (archive-tar: split long paths more carefully,
2013-01-05) changed how some long paths were represented to be more
compatible between GNU tar and NetBSD. Lots of Homebrew recipes, etc,
were broken when GitHub deployed a version of Git with that commit.

I think there was a more recent one in 2023-ish caused by some
gzip-related changes (but it was after my time and I don't know the
details).

I feel like there was one in the middle, too, but I'm having trouble
digging it up (I think GitHub reverted 22f0dcd963 at the time and
finally reinstated it in 2017 after a warning period, so that might be
what I'm thinking of).

But I'm not sure how often we'd do fixes like that. Not a lot, as the
tar code is pretty stable. But is 82a46af13e (archive-tar: fix pax
extended header length calculation, 2019-08-17), for example, likely to
have changed hashes for some repos? Probably.

So I think if you really want byte-for-byte compatibility of git-archive
you have to cement the behavior, bugs and all, behind some kind of
version flag, and every possible behavior change has to be analyzed for
a potential version bump.

Though breaking some obscure cases once every 5-10 years is maybe not
_so_ bad, and we can live with it. ;)

-Peff
