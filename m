Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356924A04
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726785971; cv=none; b=Taw+xJEvXdTM0q5mUKzd9wi3OO/VrgFNwRZpAmx9xtu+5PhLeMlHZy3rJqXfytg2wlbAGZ7+UDWwR5U2RXdAX7WJFHe89rc0C6eGB6MYhgz3SEHxdJW7vjMCZf92VrusNjYU0WvFM7ubg4qw4n/Y/GYaPLpMXqMhGywG5AZrvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726785971; c=relaxed/simple;
	bh=O1iSBO1AVUxGZ0VCmbHI75RJJr+bK0yu8D67AqCiFes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FlX93OmBCc/X4Q96PF2mImccAaxoTMbNSCWa62s4ZI6PYhthKq9So/e+cmcsH8G12pTrdmVD6MSLHrYtyV3HebvjWFEK36jiN+CAPewKPe8tmWFv3nUmO5FyYnCGqDwrUkSIDReiPHXVWDxLsstNtBVyJhb3zged8c692cLyGkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vy9WyJFD; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vy9WyJFD"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B6ACC2D8D4;
	Thu, 19 Sep 2024 18:46:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=O1iSBO1AVUxGZ0VCmbHI75RJJr+bK0yu8D67Aq
	CiFes=; b=vy9WyJFD/P/S04eMcZUkU3+YZBdbPxOsAM2Z+YIs0hQxftsmiY9oef
	28lW8s/2sEG9FZNCHjDAekPE0r0oKPyOk33UC74UZgojznSSNC25ct8Rh01P6Vcp
	iVMU6dSK0bUvhrDa2QMt3bhetYqsESVoJpoSPN8p1QNJbLoRG4gBs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AD4942D8D3;
	Thu, 19 Sep 2024 18:46:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C280B2D8D2;
	Thu, 19 Sep 2024 18:46:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, 	Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] update_symref: add REF_CREATE_ONLY option
In-Reply-To: <20240919121335.298856-2-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Thu, 19 Sep 2024 14:13:25 +0200")
References: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
	<20240919121335.298856-1-bence@ferdinandy.com>
	<20240919121335.298856-2-bence@ferdinandy.com>
Date: Thu, 19 Sep 2024 15:46:00 -0700
Message-ID: <xmqqtteb45zr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F213E966-76D8-11EF-ACE0-9B0F950A682E-77302942!pb-smtp2.pobox.com

Bence Ferdinandy <bence@ferdinandy.com> writes:

> Add a new REF_CREATE_ONLY flag for use by the files backend which will
> only update the symref if it doesn't already exist. Add the possibility
> to pass extra flags to refs_update_symref so that it can utilize this
> new flag.

If I wanted to create a symref that points at A, there are three cases:

 (1) the symref does not exist.  
 (2) the symref exists and points at A.
 (3) the symref exists and points at B.

I'll see a symref that points at A at the end in the first two
cases, and my request is silently ignored in the third case.

I'd expect that the caller can tell the failing case apart from the
successful case with the return value or something.  The caller
might want to tell between the first two cases for reporting
purposes, but I do not care as much as I would care about detecting
true failures.

Nobody actually passes the flag yet, so we would not be able to tell
if any of the added code is buggy from this step alone.  Let's see
what happens in the next patch ;-).

> diff --git a/refs.c b/refs.c
> index ceb72d4bd7..7afe46cadc 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2085,8 +2085,9 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
>  	return peel_object(r, base, peeled) ? -1 : 0;
>  }
>  
> +
>  int refs_update_symref(struct ref_store *refs, const char *ref,
> -		       const char *target, const char *logmsg)
> +		       const char *target, const unsigned int extra_flags, const char *logmsg)

While it is not _wrong_ per-se to mark an "unsigned int" parameter
as "const", it is a bit unusual in this code base.  The only thing
it prevents us from doing is to mutate it until this function
returns, which does not help all that much in making the code safer,
as opposed to marking a parameter of a pointer type as a const
pointer.

