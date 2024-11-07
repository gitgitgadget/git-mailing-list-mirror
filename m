Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C44C6E
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945294; cv=none; b=NJvDw/otEZI8gt1+hUZJECbBtnT615+u7clBbEd5jpkHSuGpff5coZnD2SAy0llkYaeS1djdIzfqaurjP8MQwwTJimG9O05J36lmRsrGBexfb0jrPRQma5bb0TATjDPoFO4O4tlDM5VeFMvv62Jgrrj3YZftvUsQN+fWDznoWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945294; c=relaxed/simple;
	bh=XNfP1fOVZEL1gJYcZsfXxbkSxCDccCfEpjCJEIAx1jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYqZeMK/ogyvcNMiPTKU6sSP7rI8K0FCcby3kd+HhOO1pmEkeFgq8YvZkzEg8mjrgcASqUU0wGlaSaAgrXc9cHyco2BobPYO10LPn4v4U5DVdpiIQbcu7uCMngElgPO8jOi6MfJPtuHWoHWfVhMvK5IbfSXeY3EMsAxneH7X/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WQqDEIIR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WQqDEIIR"
Received: (qmail 17686 invoked by uid 109); 7 Nov 2024 02:08:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XNfP1fOVZEL1gJYcZsfXxbkSxCDccCfEpjCJEIAx1jE=; b=WQqDEIIRaHU7AUpvEE720z38/4K0npmsUPw79tf+GkADuMlHfvanbjRYqqi5SAE//JsSL1Rup+qAgdW0TCpOCvy4IRXJHmCPcJ0loU8uqZwX4KBNyidoE3hZ1ztiJJxXycSA7gPe0KrElESDjbux5kw0sEDVECv52zSuN/1dJRNlAnrucoIx/KAOkZLFgsnnqTYJ4db5U+tufsMMbVlaJOrAIsUj2/WTLtVPzn2JxGQxkPhGHISzpNga+Ju2RtU8E7u/IEtMjp3v/RsTJJ31pWGQyRpFQRa007J/1dDVZ9cEc/2b7pvU+byRFAhINt9/y47Yn4XMmTVmBe2LwI9zAw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Nov 2024 02:08:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10517 invoked by uid 111); 7 Nov 2024 02:08:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 21:08:11 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 21:08:10 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] t/helper/test-sha1: prepare for an unsafe mode
Message-ID: <20241107020810.GD961214@coredump.intra.peff.net>
References: <cover.1730833506.git.me@ttaylorr.com>
 <0e2fcee6894b7b16136ff09a69f199bea9f8c882.1730833507.git.me@ttaylorr.com>
 <xmqqcyj9qgyf.fsf@gitster.g>
 <ZywOWn08cGBnBWM-@tapette.crustytoothpaste.net>
 <20241107013915.GA961214@coredump.intra.peff.net>
 <Zywcr2lMM_Ij8suu@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zywcr2lMM_Ij8suu@tapette.crustytoothpaste.net>

On Thu, Nov 07, 2024 at 01:49:35AM +0000, brian m. carlson wrote:

> Ah, yes, I think that approach would be simpler and nicer to work with
> than a separate entry in the `hash_algos` array.  We do, however, have
> some places that assume that a `struct git_hash_algo *` points into the
> `hash_algos` array (notably `hash_algo_by_ptr`), so we'd have to adjust
> for that, move the function pointers out into their own struct which
> we'd use for `unsafe_hash_algo`, or be careful never to call the
> relevant functions on our special `git_hash_algo` struct.

Yeah, I wondered if some code might be surprised by having a separate
hash algo. Another weird thing is that the sub-implementation algo
struct will have its own rawsz, hexsz, etc, even though those _must_ be
the same its parent.

If all of the virtual implementation functions were in a git_hash_impl
struct, then each git_hash_algo struct could have one embedded for the
main implementation (which in sha1's case would be a collision detecting
one), and an optional pointer to another unsafe _impl struct.

And then you get more type-safety, because you can never confuse the
_impl struct for a parent git_hash_algo.

The downside is that every single caller, even if it doesn't care about
the unsafe variant, needs to refer to the_hash_algo->impl.init_fn(),
etc, due to the extra layer of indirection. Probably not worth it.

> Yeah, I don't have a strong opinion one way or the other.  I think, with
> the limitation I mentioned above, it would probably require a decent
> amount of refactoring if we took a different approach, and I'm fine with
> going with Taylor's current approach unless he wants to do that
> refactoring (in which case, great).

Me too. If we were fixing something ugly or error-prone that we expected
to come up in real code, it might be worth it. But it's probably not for
trying to accommodate a one-off test helper.

-Peff
