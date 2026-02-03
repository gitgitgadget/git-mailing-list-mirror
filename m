Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3928DEE9
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155639; cv=none; b=NCUo1mfSYx7J1RiKdH0Qrb0MwxCcqmTubcUhlmytMK7F9oicAbgk/DiEgCaMV9374lz15OqaS6P/CYdleP2u2kgOFKOW6IGlKxj10lkhEypDJM3pYBuLsAjsK5AMPLw8x2GBHG+9q+QA9nmshXqLPuJYu0ghVKc/iS70m9nyy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155639; c=relaxed/simple;
	bh=lkA3x7APm7CEfc/Un/Pyifk64iZboB4hvqKQaSISqcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upA9651SD1/n4CWQgjMIQyhGONouysB6+jD9Hvn4nMo1DXDGAgSJn+3Rtm6M9Ts6ZHjjIobmpPoAATWHgaKKCDozEF/YjP6y9ecY2+/XSKTbA/vH7t0sw0K/Ij0QTq0mBbB4mOmfDjaq085Z83X1ZqR7sAMXOcYed5pc9DpdwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RIwYdMKn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RIwYdMKn"
Received: (qmail 269999 invoked by uid 109); 3 Feb 2026 21:53:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lkA3x7APm7CEfc/Un/Pyifk64iZboB4hvqKQaSISqcc=; b=RIwYdMKnW0PAZQYs2wtWiSshPzvBADuY/eAVGAxMSsQtJX5FVkuEeA/NH5B5nVUTVlNxKbz/rJIB8M7FKs8m+QvpegRXXL1MERrtY0HK7f9dbVmRsHFr21bOYlPEf7YUDTubnF8mYNE+N88/hv2WwGIWDJWxfeIbcBvBhNqh/0LQCDbEotO+uGI3aeh0jQwYh6NUkSdaAE7Yz1ZlIxAl6r3rIXAwW/52BP2gPUNWATeSOzgZTwUCILEm2EnYduBhOwkuWXN1Fcb0aG0mpAvoCQ2zwI96EdanqGhjtOPomqELL4uJlijAiEKSnwMXve2m1AI5NRwKXQnnXSFAjyjmLQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Feb 2026 21:53:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 535263 invoked by uid 111); 3 Feb 2026 21:53:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Feb 2026 16:53:49 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Feb 2026 16:53:47 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFH] adding test coverage for contrib/ in CI jobs
Message-ID: <20260203215347.GA340210@coredump.intra.peff.net>
References: <xmqqh5smdejc.fsf@gitster.g>
 <20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
 <7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
 <xmqqjywuyhu9.fsf@gitster.g>
 <xmqqsebhu9nn.fsf_-_@gitster.g>
 <xmqq7bstsemv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7bstsemv.fsf@gitster.g>

On Tue, Feb 03, 2026 at 01:26:00PM -0800, Junio C Hamano wrote:

> ----- >8 -----
> Subject: diff-highlight: allow testing with Git 3.0 breaking changes
> 
> The diff-highlight (in contrib/) comes with its own test script,
> which relies on the initial branch name being 'master'.  This is not
> just encoded in the test logic, but in the illustration in the file
> that shows the topology of the history.
> 
> Force the initial branch name to 'master' to allow it pass.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks, I think this is a fine solution. In such cases it is sometimes
nice to remove the dependence on the branch name entirely. But it looks
like it would be a pain to do so in this case, and not worth the time.

Most of the other instances of GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME set
it to "main". I guess one day in the future, post v3.0, we might drop
all of those and decide that "main" is here to stay. In which case we
might also want to drop these outliers and just switch them to "main",
too. But I am content to punt that off to another day.

-Peff

PS As you might have guessed, I have not run these tests in ages. I'd
   only do so when actually changing something in diff-highlight, and
   that hasn't happened in a while. In fact, I rarely run it at all
   these days; I usually use the third-party "delta" program in its
   "--color-only" mode, as it does a better job of true intra-line
   tokenization and diffing.

   I don't know what that means for diff-highlight. I'm happy to
   continue to review patches for it, and I think it mostly Just Works
   and doesn't need active maintenance. But I'm also OK if we dropped
   it.
