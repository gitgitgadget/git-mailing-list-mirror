Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103F915ECCC
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419710; cv=none; b=qfDYK8CtEcEf1qd1Qt1qhgYudDa45B4+jVZZ8Eso5lKyn34P5lMe64ftTMHV1CcvlJZZho7GdX3ciJ9LtM8cXKOM81C/FG1nChqF9S89QekPub0+EgFRlhLu5L8Pk5VDxqyMezfPW5UUmn5zoG258wNUaOUUWQFdZPcnoy5k1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419710; c=relaxed/simple;
	bh=fbn99mWxBWoJcf7K+MLa3alQy5TUsrWCF7xsuW9aKgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEznEZ5viF3EX6n3E9oNvOyTq7QdgVrKGdGGJjikCAxzfcaDKulwYB92AFGsZ/1ccWuPe4NtYipBwKP3NxLsFwdZ9BdWMq03A7EXCV0POvCpBDfCr8g5X+Soc07scSft6UQI0arIr2a5uwFBxrjW6FHXePOaajEQiISgLXLJJLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RHewHHAq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RHewHHAq"
Received: (qmail 16000 invoked by uid 109); 5 Aug 2025 18:48:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fbn99mWxBWoJcf7K+MLa3alQy5TUsrWCF7xsuW9aKgU=; b=RHewHHAq80DJdKxZc0bBELRYIs5zlkTXCKU8mTANqpzqMjn1iqtudiocfeqmzBScUgvwNBJ8b6PXZZKMZXI1ewMbcE5DEDoR2umrqBn0g35U3E+v5hzkC1pJG0KW+0q6odSNdeslC57o0Li7l583t3TpAFC+iQNAnIM8UDuvWEuWWJUT2BPzKRyQhgS11TbTmDxMbupvxuB3nf5kcvk+hi3mg8HISRUvUsryt9qbmekmeAI2wmunkVCNvYFcSOVWAjqc8UpIRWxbkRPVtwUH9+ssHUP9bHYAMZiE44HvjkpV3IL9osatJLlVhHQ34+ADWWM6ersGH2rG5VNQYiGRjA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Aug 2025 18:48:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11018 invoked by uid 111); 5 Aug 2025 18:48:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Aug 2025 14:48:29 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Aug 2025 14:48:27 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
Message-ID: <20250805184827.GB1345110@coredump.intra.peff.net>
References: <xmqqms8fbilv.fsf@gitster.g>
 <aJCBlnHp-db4Nd5w@pks.im>
 <xmqqqzxr88jg.fsf@gitster.g>
 <aJDI16RBR9QKdtW9@pks.im>
 <20250804154129.GC109984@coredump.intra.peff.net>
 <xmqqectq4ne9.fsf@gitster.g>
 <20250805125120.GA1291837@coredump.intra.peff.net>
 <xmqqzfcdzof5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfcdzof5.fsf@gitster.g>

On Tue, Aug 05, 2025 at 10:08:46AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think I don't think it's pretending that nothing bad happened, though.
> > The user did not ask us to update HEAD, and we are able to fill their
> > original request completely. So there really was nothing bad that
> > happened.
> >
> > To me the options are "try to do the best thing in a racy situation,
> > even though it almost never happens and will be complex and somewhat
> > untested" vs "do the simple and stupid thing that does not happen enough
> > for anyone to care too much".
> 
> OK.  I still prefer the latter ;-)

Yeah, sorry if I was not clear. I was just quibbling about the framing
of the discussion, but I think we all ended up in the same place. ;)

-Peff
