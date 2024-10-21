Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A91FBC9F
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538378; cv=none; b=HiV3I4Ai7QBqGkazJDXvN5OzWuBjaGgjy9fs61KC2F9Y384d40MieHsjRkuYX8U7s9fnUdCudj5rouVtfBZxuYRdB71GEDCN34qQgDQG/Rsdfue1RTUa0ov3woMCBOKzQcy4d7J56iTopaZRSEyndrZI74imjUyGD3IdDf5+uO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538378; c=relaxed/simple;
	bh=GfYNFQSoXg6yoe7sIHLs61EALJyw0kgQU8r9/hjBZbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7g05IG/INmwDKWb1nqxZ2dKAvVxKGGm+ac7bUpDOkyrDfsKxNwI4Rb0TOs2L9ORz8yQPJETt+u6uc16Av+2u7rG/w6X4Lxke2LbNAgy99sZPqAsYY1a/k/MFWS9qKFOxNRZlaokOOE/LD1w+mzN3GxocQ0lBAUlqNx0s3YqE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y2z4zg1o; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y2z4zg1o"
Received: (qmail 19670 invoked by uid 109); 21 Oct 2024 19:19:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GfYNFQSoXg6yoe7sIHLs61EALJyw0kgQU8r9/hjBZbA=; b=Y2z4zg1o9xG8z+BrSIkeQyz3rKPktFP1iGaeR8aMVDTNQjyCtrfbGIykcdY9WVWNzv0DW8f7Io53aCMYlI4pwZdGTtSov6ignay3FJpzn63ra1FaPPnOkSxK3dy2FHAMBUwrQhke6Tm0zWdrLAzix16cJUeetqgXxM2JcA2SCDn+ZYBDrbU/8hiqwi4kBii9JshijWDBh4at4d3bFNKVmviTN7toZmC2hergRP1gXcmTmEUM/QArfTIUFiKEvEJyesbC64FF30tjw1Kz5JgObFhJhjBtvnn6GNHEnAFvs26x3OkIpcnglG37W0WQp8BFbmZHXsFhqlJlhcTU5RiBwA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Oct 2024 19:19:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31853 invoked by uid 111); 21 Oct 2024 19:19:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Oct 2024 15:19:34 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 21 Oct 2024 15:19:34 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <20241021191934.GE1219228@coredump.intra.peff.net>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
 <20241018045155.GC2408674@coredump.intra.peff.net>
 <ZxLAC-c4y7_sQqzw@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxLAC-c4y7_sQqzw@tapette.crustytoothpaste.net>

On Fri, Oct 18, 2024 at 08:07:39PM +0000, brian m. carlson wrote:

> The difference is one set of systems has a minor incompatibility that
> requires little work to work around and has few practical effects, and
> the other tried to exclude major functionality from a tiny, ancient
> standard, the result of which is a wide variety of software that's
> broken.  (For example, ncurses normally builds a wide character
> version of the shared library in addition to the byte-based version.)

I think this is the crux of where we see things differently. I don't see
wchar as major functionality, since it's not something that Git has ever
used! It's an include that we pulled in via a dependency to implement a
minor feature that we aren't even making use of. We can just not compile
that otherwise dead code, and everything works as it did in the past. We
do not have to pass judgement on uclibc's feature completeness or make
life any harder for users on such systems.

(This is all assuming that we are dealing with a uclibc with disabled
features in the first place. I don't think we've seen an answer to
Patrick's questions about why the #error is not triggering).

-Peff
