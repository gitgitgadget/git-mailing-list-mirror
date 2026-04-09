Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C798372B27
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768987; cv=none; b=rg1+ZejN5oQEXJaIHjrmlJAN20zP8Jd1R+0y9uYuW6u+/XMVy1UddPhKxRF4aDhccRgYBKSJegym5lXzv0mim/5vWKzzXkrQCylmOMDz+r2LTspA/UdYUJ/fJGHziVkzRLliv5Nxudr//IOiR5kSzQbgl0ZSCCP0ntU+DQtYgPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768987; c=relaxed/simple;
	bh=fulOTVzjLOQ7ng2J27NPdHIA2s29OsqNilUm/ke8j60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZPzeIOGQsIMdnahiWysTctwgfatw71w+jpbtghboxx5OsijO6QSwNDts/uDqgzd+VEOxjpgo16nVgEn630hLLCofrie/YJR7X9LJ8bX/lmCl6vBy8IiuPPJUBS5EsiHLz/p7OY4wIQrlTxPGRue7JEtEYymQGuSle5PTX/4ZjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KCIk7kKB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m2AlDl0n; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KCIk7kKB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m2AlDl0n"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 207DD1D0024F;
	Thu,  9 Apr 2026 17:09:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 09 Apr 2026 17:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775768984; x=1775855384; bh=8YY8PmnCEF
	VNehWmG6aCRz6PZLS2OTfQKadF8fFUGtc=; b=KCIk7kKBRg/8I5otRfHyWAKadL
	ouUMZeYRqZGC/E0Zma86lmj1X9u3/o4vUuWEMfC+JP2I2FHZBwxu9i2ZQUIYLe76
	O1/uxqmmuqY6eSD1yM6qwIiLA5zQo2RQzf1sZmLwD7w494fxAZCA1/VykZ65wlWd
	TkHdCe1LkYAj9b2dpQoOblq+2oJfn00cHWqCdQ4GMeAVMCij3zcuAT2jj7leNXsE
	wZPlAGoKJOKEyV6DP759dsRNGTGdi+gQlbKqHy/FNWlJLE9qnd75uyqoBqWvWYpf
	Uti+JijqWHuZmz1KEkPbtsYeVaOgOFLLqu0Rkqi6xyc6eMmpILTQNPM7qvCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775768984; x=1775855384; bh=8YY8PmnCEFVNehWmG6aCRz6PZLS2OTfQKad
	F8fFUGtc=; b=m2AlDl0n6q0VjLIKNGV6XlrsvZ9Z7axqNfhw+0vgb1CZmCtW5HE
	p0+7Du8Pr6sHPsKL7zjPmn8E815I0hK5tPYl+MKTmfKRnSO5+NqrvdbKHhTJ+pZM
	olUN376Xd7jJH7XSikok8Q8Jn8ArSIkDDXUUJi4nDMpHTStAW+duszeuRWf6ksBm
	CC+DynxfsxMGlXM7E3fFCqL4Z54Iboi7gjW+JZ0cv/ix14vsjQO8iminZIr5jwb0
	XmQR0aBKQk7RJNBDp4V+fQPmsq82Q/bzZ1CTyznS+TulYNwv9cMTecuos15xtPl7
	DasVgD12DJRF9MUekSwhYw/o8derZFZn3Hg==
X-ME-Sender: <xms:lxXYaS8fHuLGNpGa0dVjgPJqGvPOpv2gttG2Rso3u63HHA3sSQsRPw>
    <xme:lxXYaTbv2mbHqMU18Il9pOh5ZUTJGH9oO9oYOL6g3g8ad1UGUDJrfIWS1A0PntcOr
    CU7QghAuBxswezLPlFVxuVl04pFh51DTiupPtY9QJ6jy345Z4VK-g>
X-ME-Received: <xmr:lxXYaWMynx8aDgTj7gKqRxcAsfiAmOfV9oeFVLrRl6amZuBqMK5Aj0pPfvJ2VY6JHFVUHP6GyjQj2QHkJ_qnaGKCPcdcyhQ3rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgt
    rgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mBXYafDFnh0V2GyiIQlkCAPNFBmWrWBxaF5JPN-Rp6D5uiVXnuZmgw>
    <xmx:mBXYadJCik-loB9BpcxaZybodnWO6xwkeku0LAvxvsR3EdqX6XsOog>
    <xmx:mBXYaYMa6FkJ2ERxp9bplad2_R2drHLhBuKWmiGl4MRFIqHT0uRkXw>
    <xmx:mBXYab659W3dbzGOcfLV4stVcu8GavNuTj-p6qkM6i8gaF1I12zG-w>
    <xmx:mBXYaTFZFQOZYSSJOrUOVygSBtsoM8JvzXJACgZM8olejxfCJZIlUxo->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 17:09:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] wrapper: properly handle MAX_IO_SIZE in `write_in_full()`
In-Reply-To: <20260409205928.GD3076846@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Apr 2026 16:59:28 -0400")
References: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>
	<xmqqika0ultp.fsf@gitster.g>
	<20260409202329.GA3076846@coredump.intra.peff.net>
	<xmqq5x5zsw8r.fsf@gitster.g>
	<20260409205928.GD3076846@coredump.intra.peff.net>
Date: Thu, 09 Apr 2026 14:09:42 -0700
Message-ID: <xmqqzf3brgbt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Apr 09, 2026 at 01:40:36PM -0700, Junio C Hamano wrote:
>
>> >> As the width of ssize_t in bits can be a lot smaller than size_t,
>> >> the above "unsigned_add_overflows() triggers way too late for the
>> >> check to matter, no?
>> >
>> > I think it is correct as-is.
>> >
>> > The real check against ssize_t is later, when we compare total_length to
>> > MAX_IO_SIZE (which is clamped to SSIZE_MAX). So this is just making sure
>> > we do not overflow size_t when counting up the total (and if we do, we
>> > _know_ we are going to overflow ssize_t, which must be smaller).
>> 
>> But then what happens after it breaks out of the loop?  We cannot be
>> at i==0, so let's say we have a reasonably small iov[0] and iov[1]
>> that is so large and makes size_t wraparound.  We break out here,
>> and then send the iov[0] with writev().  But have we checked if
>> iov[0] is under MAX_IO_SIZE in that case before calling writev()?
>
> I think so. Either:
>
>   - We completed the first iteration of the loop successfully (and i >=
>     1), in which case we added iov[0].iov_len to total_length, and then
>     compared total_length against MAX_IO_SIZE, but did not break out of
>     the loop. So we know iov[0] is within the limits.
>
>   - We bailed at i==0 either because of addition overflow, or because of
>     the MAX_IO_SIZE check. Either way, we will bail to xwrite() because
>     i is 0.

Yup, you're right.

There is no addition overflow at i==0, but I do not think we can
construct a case where the sum is not checked against MAX_IO_SIZE
before the vector is passed to underlying writev().

iov[0].iov_len that is slightly smaller than MAX_IO_SIZE would allow
us to keep looping to i==1 at which time iov[1].iov_len is so big
that we may trigger unsigned_add_overflows() check, but then what we
send to writev() is the first segment, which is smaller than
MAX_IO_SIZE, so we are OK.

iov[0].iov_len that is slightly larger than MAX_IO_SIZE would stop
us moving to i==1 at the end of the loop, and directly punt to
xwrite(), so we are OK, too.
