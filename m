Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF53D5C32
	for <git@vger.kernel.org>; Tue, 12 May 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604735; cv=none; b=Xo8BUYBY1Lelzs/RoA2Pee2shJ5jhd6U+i8PB2W286552LmJB8RFwk+uc0ReUsOFHSD73zPv42Ezs0zEmVq3C+0zZeMe+ouKStYXsFrPRsnri+VvjUqvNl0u6KDFn3aU/yFlUmz1V2cRK1bQ77KWESp+kyDjh6mhZWNo9r/QIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604735; c=relaxed/simple;
	bh=P30cJfni6iR/tpU3xB019xxqXHwmkGelTckI4lNyzi0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fNgc+ulMJbH6c6mDoQpY7TJp7JaGuUHyLoLeRWaIcdJabDLWLQsu2KUhh7rQSBHNRyWHY/Nc5OCuDG6Og3xM7WaYiPBJ3UDI7zII06lUjmf7YBivRzfWw7RlNB2x4nNHX68G1wogrc9eb/9jMaoYdIf0aYqHhdcIblJgizNtlwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EkidZcR1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CqJJyRpc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EkidZcR1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CqJJyRpc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 760FE1D00073;
	Tue, 12 May 2026 12:52:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 12:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778604733; x=1778691133; bh=6mr6ICxkqC
	oBsvEhLyY0QoTOTAECh1xQ+L5OTbMJSX0=; b=EkidZcR1T1rSXKrRQfqhQK1tTh
	7PpLqcIWPDTdp76GhPRPFJfGrVytE3YfA6GUhGX0HixFphSUGAtsejs4oQozzX0i
	3JMpCBLliLcnDMb8swOY0iEOmflus00RBk6Q1ffZMCZjSDYZCwh/4O4UQ9iDbX12
	7Eb84YHlWfQGqnOPjwVrnYP0BwIsHrB7BhCAwveWX7ou3dfcF5JIpjwzmurzlV+H
	IzVoRE3Ef0hXSu5RnesnGzFfFYv56jyEq9mQBG3ZGQ0Uv6Jh+DQqfd6JPLNgNZaY
	DDRgCjqIFr4L96SMe/E7eDGgo08ASjAf8NlE1ZUPz1swSNBrRYdpl/iXL9OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778604733; x=1778691133; bh=6mr6ICxkqCoBsvEhLyY0QoTOTAECh1xQ+L5
	OTbMJSX0=; b=CqJJyRpcwFyuTgpRmmU2k1ahfV5Ajb2C5/OpQ+7lYRhuvZzQXNK
	c5tqNdgryAQOxeMxgnuyBecPEfKRahg3AkPZCZGFrhNDFnQVvnwo/mHILwKw9s9K
	d1PhFVCvJzzXhsQzopXOYIH/NRsjYceaTINfSA3nScxlO3gW6jPCkPY0kSAPaadg
	fX7EV1Ma/bw3bnOZTg/O7eO/+oPRfD0PvzjIn2d+VtnVxZCfz899xn6AxPf5hmTH
	86cDwInDCDZTFQ4oJPgcRsf3IZwh63JrgoNNAT5bTmOhE2nUAcT29Am/SyB2+wKJ
	oKvXiGyvJK46wzgcBGRPQyURN9/ku8W2xzw==
X-ME-Sender: <xms:vVoDalDQN1J01L4D_8CKVDBJrOTaGvR9KMZJqhoVpuqynxV4ga03bg>
    <xme:vVoDaqhS2vNYZYL93ZXaXzn8HkLH5TGovXhflD7jaVTnxQpb7H_Pip23LdwCwMJm4
    0_h59B_7qUVZcOw1ZIf9cPfhGcEGCcvl0xE4PSw7ivqMtPr8baYFss>
X-ME-Received: <xmr:vVoDalkvAktT8KvkOnV9Q8g1Lq7n34jXt0H1qdde4VZ7dt838WTSnf68TNdI5LgHdoEmD5Z7O7pcqE32sFo69ibgsH87OeGP9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtrg
    grhhholhesuhhtuhdrfhhipdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vVoDauospJNFXOPTMuQxTqbRP3pxbhxXm-j8QIaXB-ITJ6mTIMRqFQ>
    <xmx:vVoDamGROl6UEjYWxOvcx15IB6w2N2rrx0Slta96696ZEK6jFDZ_zg>
    <xmx:vVoDaixajy-8lIR7FYMin93xYWVJ28F1wzM-UdOzHJZkcGGIuC1DYg>
    <xmx:vVoDajoAiNstEioCP69lLIpuWeJhAcXPvcpzS-zeYdJ3DZsJS-LBIQ>
    <xmx:vVoDaqFleLDpDo5XVVpH9PeDFM70MSROwNAgTmYOQZM1VPow4BYOjgYN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 12:52:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] approxidate: make "specials" respect fixed
 day-of-month
In-Reply-To: <20260512145430.13212-3-taahol@utu.fi> (Tuomas Ahola's message of
	"Tue, 12 May 2026 17:54:29 +0300")
References: <20250318180201.3653-1-taahol@utu.fi>
	<20260512145430.13212-1-taahol@utu.fi>
	<20260512145430.13212-3-taahol@utu.fi>
Date: Wed, 13 May 2026 01:52:11 +0900
Message-ID: <xmqq33zwlgec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> The special approxidate time formats, "noon" and "tea", wrap
> to the previous day if the current time is before 12 or 5 pm,
> respectively.  That holds even when an actual date is supplied;
> therefore, "10 May at tea" and "last Friday at noon" can cause
> the date to be set to a seemingly wrong day:
>
> 	now -> 2026-05-12 11:00:00 +0000
> 	10 May at tea -> 2026-05-09 17:00:00 +0000
> 	last Friday at noon -> 2026-05-07 12:00:00 +0000

It would help readers to say that Friday of that week was May 8th to
make it easier for them to see why this is a wrong answer.

> 	One year ago yesterday at tea-time -> 2025-05-10 17:00:00 +0000
>
> The last example is from Linus Torvalds who remarked in 2006
> that the answer was "just silly and not even correct." [1]

It may be just me, but it was hard for me to guess if you are
justifying how these answers are correct, or you are presenting
examples of wrong output.  Perhaps starting the paragraph with cases
where the "wrap to the previous" gets right to set the stage may
make it easier to understand?  Let's see...

    The ... 'noon' and 'tea', wrap to the ... before 12 or 5 pm,
    respectively.  So for example if it is 11am on 2026-05-12, then

	now  -> 2026-05-12 11:00:00 +0000
	noon -> 2026-05-11 11:00:00 +0000
	tea  -> 2026-05-11 17:00:00 +0000

    which would work well when you ask for "git log --since=tea",
    for example.

    That hold even when ... seemingly wrong day:

> As "last Friday at noon" is mentioned in the documentation
> (date-formats.adoc) it would be nice if it worked correctly.
> Let's fix the glitch with a simple patch.
>
> Check whether we already have a specified (non-negative) mday
> and make date_time() stick to it.  Add a suitable time offset
> to the relevant test.
>
> While we are at it, add "today" as an alias of "now", so that
> "today at noon" will do the right thing, too, and assert that
> with a new test.
>
> Links:
>   1. https://lore.kernel.org/git/Pine.LNX.4.64.0610101102560.3952@g5.osdl.org/
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  date.c          | 8 +++++++-
>  t/t0006-date.sh | 4 ++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/date.c b/date.c
> index 17a95077cf..e48cc2a4d7 100644
> --- a/date.c
> +++ b/date.c
> @@ -1132,7 +1132,12 @@ static void date_yesterday(struct tm *tm, struct tm *now, int *num)
>  
>  static void date_time(struct tm *tm, struct tm *now, int hour)
>  {
> -	if (tm->tm_hour < hour)
> +	/*
> +	 * By default, "tea" and "noon" refer to last such time in the
> +	 * past, be it today or yesterday.  With a specified mday,
> +	 * that logic is overridden.
> +	 */

Again, this may be just me, but I happen to find the version of
comment in Peff's review on the earlier iteration of this series
much easier to understand.

> +	if (tm->tm_mday < 0 && tm->tm_hour < hour)
>  		update_tm(tm, now, 24*60*60);
>  	tm->tm_hour = hour;
>  	tm->tm_min = 0;
> @@ -1204,6 +1209,7 @@ static const struct special {
>  	{ "AM", date_am },
>  	{ "never", date_never },
>  	{ "now", date_now },
> +	{ "today", date_now },

Hmph, this may not work very well for "git log --since=today", which
you may want to stop immediately when the traversal reaches a patch
written before the most recent midnight, instead of stopping without
giving anything back.

>  	{ NULL }
>  };
>  
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index 5d66267672..e01d093514 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -186,8 +186,12 @@ check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
>  check_approxidate '3:00' '2009-08-30 03:00:00'
>  check_approxidate '15:00' '2009-08-30 15:00:00'
>  check_approxidate 'noon today' '2009-08-30 12:00:00'
> +check_approxidate 'today at noon' '2009-08-30 12:00:00' success -12
>  check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
> +check_approxidate 'last Friday at noon' '2009-08-28 12:00:00'
> +check_approxidate 'last Friday at noon' '2009-08-28 12:00:00' success -12
>  check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
> +check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00' success -12
>  check_approxidate '10am noon' '2009-08-29 12:00:00'
>  check_approxidate 'January 5th yesterday' '2009-01-29 19:20:00'
>  check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' success +48
