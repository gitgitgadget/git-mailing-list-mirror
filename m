Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16F2D5C8E
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342183; cv=none; b=HD0srvEjEh2R1HQdkPYtnmkSIzR3mmnhutE2X5hJPr52/4duJpQQrm8bK7r85UUh/Ev9TLZoX16ClNim0o/z2xv2/jyY3+8d262u5IWJ951uJ38lgWi3X+zDzrQ8KbfuWUN8RtnEnjX04X+1CG0n9Hl1U3/RVC2HeQqa+fqivGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342183; c=relaxed/simple;
	bh=LkmewSDpXrjOj+pK2wzoIml5n++YcYZekiCxPN25Rj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOGfBowmIrDmr+y9/+CnrJeYkYE4ZUl56MSPFik0sT5T5fulHCnhFQV1zDTq+BboVfQ2gngGC+9+TTfWEULkAD+ghH3RWTASJxz/zuTCeyubmUoZITYUI9K2WQSXqMlcAM2AMmSQgvcf0/W2sNBQoHtRVxPwEIIW+rTsGqRY8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eH6cIeCJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eH6cIeCJ"
Received: (qmail 476484 invoked by uid 106); 28 Apr 2026 02:09:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LkmewSDpXrjOj+pK2wzoIml5n++YcYZekiCxPN25Rj4=; b=eH6cIeCJTKUVG8wVJzCHKZdbRcWhcRcCY8+Ab43YYQAGAtmwzjmwZHI49kIepHHNWEHXqbeHt+7PiKVo0gEb7rUmFMXwM1BO68Lr6hPuzEFcaEdVS0OPZAfAO31rbh1lYlGPad1bw00PNXMOaCbHnuZcATRvGbRJwq1VTOKd0G9xJNpvrGg8lciCky5EIN+JNgR9hTOs04u2ftdMTXvJ4HZSIasWvMKOu7eS61r4+bm95wHN7x7+F0mEvlmwJNbCElV2cjuMh6G8/ACcJdqGFWb4sBGlg+4GZ9UxzMVr/M2FGGj4A6JxsMq+Q1X+aDvscf+tCjtHWSDierr8whNLBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Apr 2026 02:09:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1080574 invoked by uid 111); 28 Apr 2026 02:09:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2026 22:09:33 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Apr 2026 22:09:33 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>,
	Scott Bauersfeld via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Scott Bauersfeld <sbauersfeld@g.ucla.edu>
Subject: Re: [PATCH] index-pack, unpack-objects: increase input buffer from 4
 KiB to 128 KiB
Message-ID: <20260428020933.GA660154@coredump.intra.peff.net>
References: <pull.2282.git.git.1777058098756.gitgitgadget@gmail.com>
 <xmqqldeb9w8e.fsf@gitster.g>
 <c19a0e29-1218-4239-a362-df514153b5ff@gmail.com>
 <xmqqecjz26wr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqecjz26wr.fsf@gitster.g>

On Tue, Apr 28, 2026 at 10:46:44AM +0900, Junio C Hamano wrote:

> The application may have produced only 2kB before it issues a
> "flush".  Whether the buffer size is 4kB or 128kB, such a flush will
> only write out 2kB, and the larger buffer size does not help at all.
> But if the application has produced 90kB before it issues a "flush",
> the larger buffer size would give us a great improvement.  With 4kB
> buffer, before such an application level "flush", we would have seen
> 22 = floor(90/4) calls of write(2) to flush the buffer, plus a 2kB
> write(2).  With 128kB buffer, we would see a single 90kB write(2).
> 
> So the apparently lower improvement than I naively have expected may
> be attributable to the fact that many application level "flush" was
> not large enough to benefit from 128kB buffer?  How much of the
> total number of bytes written came in large batches, vs tiny ones?

The input to index-pack in a fetch is going to be the demuxing of the
sideband via git-fetch. So it's probably flushing 64k or less each time
(because that's the max size of a packet), and unless index-pack is
going much slower than the input, that maximizes how much it will read.

Depending on the source, though, it may be possible to go faster than
index-pack (which has to at least update the pack checksum for every
byte, and may even zlib inflate and hash the object itself if it's a
non-delta). In which case the sideband demuxer would start filling the
pipe and index-pack may get larger reads.

We could actually reduce the number of syscalls further if index-pack
did the demuxing itself, and we just handed it the descriptor. That
probably doesn't help all that much in this case, though, if the problem
is not raw reads/writes on pipes, but rather ones that go to the slow
FUSE filesystem. And as long as those pipe reads/writes are "wide"
(allowing the eventual filesystem writes to also be wide), then the
exact number may not be as important.

But the demuxing may also explain why the total number of writes did not
decrease as much as you expected, since those ones will probably not be
reduced by the patch in question. So the improvement is a percentage of
only a smaller portion of the total (but not necessarily half, because
they may have been larger writes in the first place).

-Peff
