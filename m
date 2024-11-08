Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A915B0F7
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086774; cv=none; b=sAEvKUvQIo8WKUnuqTylNrkr7uHwyelxYoIrhhM/rgEVJx4zSLGRqWrMNhHWFh+74oT76asa2z3bd0mp+cRnUrwpruYQLhuCImBI98oO9/OTSxZFBTySW5x00TW6rc8RlTiMygkU/3tmk9BaB6fgE7KAl8EP4vdA9yQIuilN480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086774; c=relaxed/simple;
	bh=pqSjsDS6BPWSjspv5zjP6/i+WVNi02sentLdO76niUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsoP9ZI1F3VtsNj9a8w1B/VHl2T01hwOQlWaN7HQ0HQvGBp4QDMxpqopw9ZAWcHkLb23wd2wDLV4nWTSoRU+EOjEyJCjn+2nPDBpCQ9pBGFiRs0OxVyDQDlOfv3koT2ZOm/+9VHtefpktb2UfMXeAMgCcTggmjSdTchNH5vgUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VMUpuYa6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VMUpuYa6"
Received: (qmail 13960 invoked by uid 109); 8 Nov 2024 17:26:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pqSjsDS6BPWSjspv5zjP6/i+WVNi02sentLdO76niUI=; b=VMUpuYa6cIoqoLTeDIhsU7/TkHU93+wh4oi29kWTucut6mVUV/HebPbotYWtJ9tjI/jsHilAbgGZRh4jcZ5EnR66otfOH+ZarxR8tuLCLH+SMB5o559ZimllkayEkw9uhd1mDGnO2LB2ZeTef3/Y2Na73rijCftiXUKFutvNJhhBux1uz/gWJWUtgFJST0mp0LtYrz806i+7pNWPVDkU+E4Hi7ExL1X2bOer7l+8+rBqRYnEze6ouzxCNe/VEFHOdpigl4ghfw2F6WOs/Lg3H3BR6xHiR6/skdVCRHHNmqEAE91wBojQ2LJlIT9NTSnVtai8DfQgy6tb18HukM0lPQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Nov 2024 17:26:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30050 invoked by uid 111); 8 Nov 2024 17:26:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Nov 2024 12:26:11 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 8 Nov 2024 12:26:11 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] t/helper/test-sha1: prepare for an unsafe mode
Message-ID: <20241108172611.GE548990@coredump.intra.peff.net>
References: <cover.1730833506.git.me@ttaylorr.com>
 <0e2fcee6894b7b16136ff09a69f199bea9f8c882.1730833507.git.me@ttaylorr.com>
 <xmqqcyj9qgyf.fsf@gitster.g>
 <ZywOWn08cGBnBWM-@tapette.crustytoothpaste.net>
 <20241107013915.GA961214@coredump.intra.peff.net>
 <Zywcr2lMM_Ij8suu@tapette.crustytoothpaste.net>
 <Zy0xfVqtOXhEVDQB@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zy0xfVqtOXhEVDQB@nand.local>

On Thu, Nov 07, 2024 at 04:30:37PM -0500, Taylor Blau wrote:

> > Yeah, I don't have a strong opinion one way or the other.  I think, with
> > the limitation I mentioned above, it would probably require a decent
> > amount of refactoring if we took a different approach, and I'm fine with
> > going with Taylor's current approach unless he wants to do that
> > refactoring (in which case, great).
> 
> I think it does buy you something for real code, which is that you don't
> have to remember to consistently call the unsafe_ variants of all of the
> various function pointers.
> 
> For instance, if you do
> 
>     the_hash_algo->unsafe_init_fn(...);
> 
> early on, and then later on by mistake write:
> 
>     the_hash_algo->update_fn(...);
> 
> Then your code is broken and will (as brian said) either in the best
> case produce wrong results, or likely segfault.

Yes, true. I sort of assume that all of those calls are happening within
one function (or at least a suite of related functions). Just because
there's an implicit context of "I am computing the hash for an object"
versus "I am computing a checksum".

And if we ever do move to splitting those further (to have crc32 or
whatever for the checksum), then having a git_hash_algo for that would
seem even weirder.

-Peff
