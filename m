Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116819342A
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539029; cv=none; b=Py4erRgqjlxYhtX4LHA0zDaYs7PXnhCz1Ub+INnbwBALTj929x8M3/j0Fa04i47W5xcCnAxRZboTRxE/XKPtDWzvq/KIjoqZIFDcJvxS24ztwCW1s1ld82XgXzRkC23hkIIFtXALcFB21Kh/uXhsOrk/T+UOWEO42jkzXdTsihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539029; c=relaxed/simple;
	bh=9YCPd3bOIBz8YaYPl54al4nJncA8v9rxlYl00pr3goY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVzjQI/TmRJJy1JV4tjI5d1DIF3nB6yn2lfkhb76xEGLn2aFSFUF/UE2F7cP4hmy3rIk4JErFkrzuxJG9CLnIlU/AIvDB33yesQnAV9296CEKojsMmUE0Rz/Y/8tN/WS8PVr4qgRNJ5EMEZX50wc5XrBbD1epk0yXdxVHIhqooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VFM58nl2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VFM58nl2"
Received: (qmail 19907 invoked by uid 109); 21 Oct 2024 19:30:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9YCPd3bOIBz8YaYPl54al4nJncA8v9rxlYl00pr3goY=; b=VFM58nl2sqrWZJmR8BSL6lKs2ILz4bsaGAitBfxptW5aiyZYK7ovIqbO90/TvOtbdNKgor21WWYQDValEwigvdFr+dDKD17+uxqDDU3axOYU4gTknw4OfO8zEHZrDCLn4fM5dQkJM62l6hydtL1ImJFUoOLsXlZUHJyohXM7ldOk+ZQP9ka8pNm8D2CIDlAI28U+B7iGVo9N25kYoZ41gM/slr0DqiJG+BVxx5a5pFEqAjHKVQIOcyisBqWsa/Umhvwvik8n7WTXawUTdOD7SPPFIfFzAL0TrPQSsKb6+v4iwC8sIlI0Xb/7YLV4AepfaaO3Xqv1RBT+S1o0332HBg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Oct 2024 19:30:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31956 invoked by uid 111); 21 Oct 2024 19:30:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Oct 2024 15:30:25 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 21 Oct 2024 15:30:24 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <20241021193024.GF1219228@coredump.intra.peff.net>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
 <20241018045155.GC2408674@coredump.intra.peff.net>
 <ZxHrIBCdnwdRdXAv@pks.im>
 <20241018052448.GD2408674@coredump.intra.peff.net>
 <ZxHylOLHaxP8crom@pks.im>
 <ZxLKLJCgiA3oY4Nr@nand.local>
 <ZxX4AsMRoC0Botcj@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxX4AsMRoC0Botcj@pks.im>

On Mon, Oct 21, 2024 at 08:44:01AM +0200, Patrick Steinhardt wrote:

> > Will it take us another 20 years to resolve all of the portability
> > issues which Clar suffers from (but git-compat-util.h doesn't)?
> > Probably not 20 years, but I don't think that it's on the complete other
> > end of the spectrum, either.
> 
> My assumption is that we'll iron out the issues in this release. Our
> "git-compat-util.h" has grown _huge_, but that's mostly because it needs
> to support a ton of different things. The Git codebase is orders of
> magnitude bigger than the clar, so it is totally expected that it also
> exercises way more edge cases in C. Conversely, I expect that the compat
> headers in clar need to only be a fraction of what we have.
> 
> I don't really understand where the claim comes from that this is such a
> huge pain. Sure, there's been a bit of back and forth now. But all of
> the reports I received were easy to fix, and I've fixed them upstream in
> a matter of days.
> 
> I'd really like us to take a step back here and take things a bit more
> relaxed. If we see that this continues to be a major pain to maintain
> then yes, I agree, we should likely rope in our own compat headers. But
> from my point of view there isn't really indication that this is going
> to be the case.

I'm OK with that direction. Just to be clear, I think you've done a
great job (as you always do) of responding to the issue promptly and
keeping things moving forward. And you're right that there is a good
chance that we iron out this wrinkle and never worry about it again. If
that doesn't turn out to be the case, we can iterate from there.

My thinking / response was mostly just: git-compat-util.h has many
subtle fixes we've accumulated through battle-testing. To the point that
I don't think we even know which ones are important and which are not
anymore. That's why our guidelines say that everything should include it
first, rather than trying to handle system headers themselves. Clar
violates that rule, and if it were original code within Git it probably
would have been flagged in review as such. But since it's imported,
there's some tension there between making the code as Git-like as
possible, and keeping it easy to track upstream.

I tend to err on the "fork and make it Git-like" side of that line, but
certainly there is an argument for the other way. Anyway, let's deal
with this wchar.h issue and then see if it ever even comes up again.

-Peff
