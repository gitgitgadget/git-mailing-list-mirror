Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D11E2858
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782636499; cv=none; b=HvGQEAODBr9ZmiPyu7w6DCAEISvKxzrdNlkc5h7nGW0KWgG9/U7qawRVFxWyKJMDD6cP8jMKzNySD3C3Fzer5sgBsf5LcjiTpby1z1Vl46I0PGRXlL82267UtZ9ItQd/RlCvmarFXjer965zUUHjvqpXk1iqNsZMP9u8KrokndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782636499; c=relaxed/simple;
	bh=5keS487J3qf/PGF++o3rLtEg0Tu/Amnj8aqfkI2CpkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYxOzi+HSzik2Yiyj7i4V0ZwoRQh2rFRw7tSev+6DHbQ9Z3TvO7s726E7cyoQnFjD5EfPmtgE+vPDHJTI5mBZ7Hd5JJOez+/XbjfJ0P08jrpaTFmkiqB20H8YKW3uJYVYTroO6E8do+jGwb2wQMyi7dpux3Gu1y9oxhfHj1Kvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FMYoxYhT; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FMYoxYhT"
Received: (qmail 52514 invoked by uid 106); 28 Jun 2026 08:48:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5keS487J3qf/PGF++o3rLtEg0Tu/Amnj8aqfkI2CpkU=; b=FMYoxYhTbd7Z1FwqUqS8Az6gBEjw5zcZ6UwRb+q0HwRGtkAa9bgXxJdIDRVn0AdJrREwO/rqSwPxA6145K98fPw0YQ/haY7wR6pbI6MMTa33JgQ3R1B1/r6//60JsmgpbsaHEOA3jDpbicLVnQrnKH/l9XFZy/5KcgpoOYhuHjD493bt0WJk1uwTiN2FQO+SEUQWroI6i4wgNr/v+Z2b60eCIDlL7GZX+6eXjtFKgLWfKFZZD3K4p/CRkaRHNbzRXzTmpmBIo6+aY3xJEgOzwE9x+aHb8J2TPDgoZuuRuy1X3yDWWqNyE12D9VpQ9f6ArOjPCC0RZF+kOb8PHNAOCw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Jun 2026 08:48:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 111826 invoked by uid 111); 28 Jun 2026 08:48:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jun 2026 04:48:16 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jun 2026 04:48:15 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
Message-ID: <20260628084815.GA111587@coredump.intra.peff.net>
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <20260621174934.GC2206349@coredump.intra.peff.net>
 <ajjuoS5Qc3K0nCRl@pks.im>
 <20260628081806.GA3594700@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260628081806.GA3594700@coredump.intra.peff.net>

On Sun, Jun 28, 2026 at 04:18:07AM -0400, Jeff King wrote:

> I tried with a vfat mount, and it also works: we don't have nanoseconds
> either before or after. That makes sense, and implies that modern Linux
> will always be OK (because it limits the cached VFS response to what the
> underlying filesystem can handle).
> 
> So...maybe this is just a non-issue these days, at least on Linux?

Oh, I also ran across this old thread:

  https://public-inbox.org/git/5605D88A.20104%40gmail.com/

that implies similar:

  * In-core file times may not be properly rounded to on-disk
    precision, causing spurious file time changes when the cache is
    refreshed from disk. This was fixed for typical Unix file systems
    in kernel 2.6.11. The fix for CEPH, CIFS, NTFS, UFS and FUSE will
    be in kernel 4.3. There's no fix for FAT-based file systems yet.

I also tested with CIFS on my system and it is fine. It looks like FAT
systems were fixed since 2015. ;)

But there is another interesting question raised there, which is how
different implementations may interact (e.g., two versions of Git
without and without USE_NSEC, or JGit which may have to use
millisecond-resolution APIs, etc). It should all work correctly as long
as each implementation consistently uses its own resolution (so JGit
would have to compare in millisecond-space and treat ties as racy). And
I think that is _probably_ what is happening now, since we already store
nanoseconds unconditionally (and only use them with USE_NSEC).

Though the opposite case is a performance problem but not a correctness
one: if JGit writes out an index with milliseconds and USE_NSEC Git
tries to read it, we will consider everything stat-dirty and re-read the
contents.

I don't know if these would be a problem in practice or not, but it's an
interesting potential gotcha. And one that nobody may have noticed,
because probably hardly anybody bothers to build with USE_NSEC now.

-Peff
