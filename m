Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC73B813E
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144189; cv=none; b=VxRRMXag/Za/boisxNol1j1kmnG3uE05YIYkKmfaGVv+z9R5tAD/pqNtsqfPeg32S36wQTJwp4UybYxGqXF6rm8WHjguUK9q7A4K4pe85EP1a6EAYV62sNDyy6K6rTwDdr2zmppWyVgFuu29nh0ZE3WoY1JKgHtaSgItxZ/BdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144189; c=relaxed/simple;
	bh=03iYF7Mg36PiLTONk9iUu+UivQ34dWxc7QZCs+l6WYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s/rLJN/JRhUOCmsKtbCRPHn1W9XwIKcq3VoMlTR5AdVk1VcZFI6KlvqwW9rHQHm8bfRfr62Pz9UJO23DGptBUoT0Jved9iFWrGg0QfCIOwRg6CN1OPrW80ELHRyiIt3nmVmcZcnkROXl/7OBbYeZZCMAYD65gXRWEvsiY0tTCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kOgof9rG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I1oSG293; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kOgof9rG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1oSG293"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C9EB140008C;
	Mon, 22 Jun 2026 12:03:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 12:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782144187; x=1782230587; bh=S+PMnDJKwB
	J9v/xc3YxPdgEJucYD7lcpIUbiP6BKh6o=; b=kOgof9rG9W2ODu/y59DYK9NDld
	2OAwVFcZu4FjDxJ6yWwWHJU6R/BLKG2SrE4UmPCLBQ+OHB9g/pFbJBtxW7d5/0px
	MTB9pnqb8aK+aO6iKvvou7Bwq5aliV7GLFmt1P9bTxuNGkb8Q/0/DPhWKoKyEOta
	CBYCPLhK/CYOWE69a5ETFQTO5DjanhKDacSIHw32N26rYWn3U4flKht8B0jQ666Q
	sZplb9xBOnnhb8XruUs1krOeLEzGpaaVexM3yRuIeOpf18+jDjDqcAMpMGBZnHoQ
	ce5ausZAdRYb2rBbrIEZMTxSFzv2qh255iBGZrATnidbl0ke8s3dMVd+Pu2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782144187; x=1782230587; bh=S+PMnDJKwBJ9v/xc3YxPdgEJucYD7lcpIUb
	iP6BKh6o=; b=I1oSG293ibPFgBVEgnB+gL7ZchX/17d7OMooi7zTwP/4RVT/Ecj
	zrB4dUs4XoaIdacqZW2ZfA/lZq7KjQ8ibAPZ97IKG5D4VzsUJQryqH58AUjsMUO1
	soFpF8sFF9XJExEV5uhCg90P/TUa1yELiHjGGJITSHU+r9GzHHDZEWPz5RpfrJJS
	71pvaWlHXjAgcYBwKNlbptAip4v3sgHk8GdhAPzwjcr76dMimTDt0sddxpjmN03a
	jIsx2qw0/cgN7+dSlaBLPbUoGy7z0Bt217epgn26IFl6c9InxXEa8u8IQtENxO7k
	2vtJVkBXhek5iIEgJvUd+jhVTeCd0ut5S3Q==
X-ME-Sender: <xms:ulw5alji7NuhT5y8kMm21p76rv_4A5O9VBD-ne8Yj-67KSxIOOdKlw>
    <xme:ulw5au8k5H04gDNdvAve7FeKmxWSmVVK3aC4TKVnvePf0suFpwbcJZ0zVj24ORbn1
    zDEMNq9XZTv8MYM0qOgqXJuN6gxOIYWiWRbxKsAMgIvhRho_YdkOg>
X-ME-Received: <xmr:ulw5apWjJmN3xaC5YGbur8ikWetNpjQwVEDr39a_SjRmK6pbDIJ7dL3iQIYsPHVo6L_slRVAovAqVafYzw9ncvimpf0Ie1ylvUsF65Q>
X-ME-Proxy-Cause: dmFkZTFvuGXu/WARgqhgCkOH/4ot+68mRCwqv7Wj7IswJ8jG+Z8FJVD51M9+CIyvfttuYg
    wKYb6OtmZhuXOlbyBq5R+GHaQHjXikuCfHJruXFQTp1l98SEk1ITHib2ii6ayOAmbbNi11
    0YR0gCHueJywNTMB5J8wJpUcp82zB8yKYCOYuWaznr+lrZ/Xgc7DpBEIMsiycjSdEofqAv
    UU78E+kiv6U0O7y0wKah2SOnPKKHwdGxVRMBN8n12cDoAEx9sCRBJE7SPzJfIsjgEgKN+G
    KTg7VZq/XmssBMeYP0n/Fdj+5ym69i58ZOAMVtQSnMa2CmsWOZxp57u/finqQRsJtAWwgF
    WYUg9no0ruAkX6ci9pJS0kfFC6xGtfGE6W4DC6ajEzIM4DfuxMNjBkgiBAp3U1kQeYw/kU
    Jgxdpn8LIQLMyhnmJQpYsIOSuUT0+JAOE2vR+mVexPixzzGyIUi+k2uNpy8HAgevXTPIqC
    ZWKtm1/lo58JDX7R+obvo/rvFqi0Ib3bLrMQP1tE6sgaEayCBk9l0kRUdm92fPp8RNGbHd
    +5T3lrlblE+YZUGySbawFZJM53XEHW0vzYOfdCl3lLJQq1Y2pxRKrk65M0K+7HsdJcesfK
    qlwZ3llqOPiOJXPAMdW6hu6AVIjOcEDpuSA77spI0x4UeIJ52iUTyB7KpAmg
X-ME-Proxy: <xmx:ulw5aqA6aQP8f4ioXPf_S5RSb3PSd9RctupaycbxTms1hffbzqZ6Uw>
    <xmx:ulw5amGyAJOSYL6bCtZTsb-jt_gmKrefO1C4B5_4pSdUp6u-he49wg>
    <xmx:ulw5aj4Axz6rFBl3EY5oFtjS6aJr2QdttS8AGr-e3YIoibIjEX6zvQ>
    <xmx:ulw5akkHwfUME9hbhLciFPQ6bVw4X_ZNS0ZGUie3qA3pOL8sjrUB6w>
    <xmx:u1w5akfLTM53SD1uyJutE99jNavLft28jOl0YDa5ypMtGJ7LS8q1GIur>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 12:03:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: a3205153416@gmail.com,  git@vger.kernel.org,  jltobler@gmail.com,
  kumarayushjha123@gmail.com,  lucasseikioshiro@gmail.com,
  phillip.wood@dunelm.org.uk,  sandals@crustytoothpaste.net
Subject: Re: [GSoC Patch v7 1/3] path: extract append_formatted_path() and
 use in rev-parse
In-Reply-To: <xmqqtsqv6204.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	21 Jun 2026 14:02:19 -0700")
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
	<20260621055534.46798-1-jayatheerthkulkarni2005@gmail.com>
	<20260621055534.46798-2-jayatheerthkulkarni2005@gmail.com>
	<xmqqtsqv6204.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 22 Jun 2026 09:03:05 -0700
Message-ID: <xmqq1pdy36me.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
> ...
> It is a minor point, but wouldn't it make it simpler to handle
> format_default first?  I.e.,
>
> 	if (format == FORMAT_DEFAULT)
> 		switch (def) {
> 		case DEFAULT_RELATIVE:
> 			format = DEFAULT_RELATIVE;
> 			break;
> 		...
> 		case DEFAULT_UNMODIFIED:
> 		default:
> 			format = DEFAULT_UNMODIFIED; 
> 			break;
> 	}
> 	switch (format) {
>         case FORMAT_RELATIVE: fmt = PATH_FORMAT_RELATIVE; break;
> 	case FORMAT_CANONICAL: fmt = PATH_FORMAT_CANONICAL; break;
> 	...
> 	}
>
> Perhaps yes, perhaps not.  I dunno.

I do not consider the above an blocker, but it might make a
difference if we are going to acquire more modes and formats, so
once somebody tries to rewrite the logic and finds the resulting
code harder to follow (or not easier to follow), I would be happy to
see the above discarded ;-)

>> +/**
>> + * Format a path according to the specified formatting strategy and append
>> + * the result to the given strbuf.
>> + *
>> + * `dest`   : The string buffer to append the formatted path to.
>> + * `path`   : The path string that needs to be formatted.
>> + * `prefix` : The directory prefix to calculate relative offsets against.
>> + * Pass NULL to default to the current working directory where applicable.
>> + * `format` : The formatting behavior rule to execute.
>> + */
>> +void append_formatted_path(struct strbuf *dest, const char *path,
>> +			   const char *prefix, enum path_format format);
>> +
>
> It is slightly unsatisfying that this function is defined to
> "append" to any existing value in the dest strbuf, rather than
> storing the result in the dest strbuf.  The original caller
> print_path() passes an empty strbuf to this helper, so it can let
> strbuf_realpath_*() functions to strbuf_reset() it (e.g.,
> abspath.c:get_root_part() called by strbuf_realpath_1(), wihch in
> turn is called by strbuf_realpath() and strbuf_realpath_forgiving())
> it freely, which means that use of temporary strbuf like
> canonical_buf only to copy it out to dest is wasteful and unneeded.
> But other callers we will have for this helper later may want to
> append to what they already have, so perhaps it is OK (on the other
> hand, we could say that preserving and appending is what these
> callers can do themselves).

This one we may want to consider a bit more seriously, but it is
entirely up to the future callers of the helper.  If it would make
the callers much easier to write for this helper to have "append"
semantics, I'd be happy to accept the semantics of the above as-is,
but otherwise, I suspect it would be simpler to use if the helper is
defined to replase dest with the result, instead of appending the
result to dest.

> Otherwise, looking good as a no-op bug-to-bug compatible rewrite,
> with a slight optimization (to skip xgetcwd()).

This part of the review does not change in any case.  The
refactoring looks good.

Thanks.
