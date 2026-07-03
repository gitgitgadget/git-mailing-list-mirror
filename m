Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E2288C30
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111132; cv=none; b=ey+Q4jwxfy46svHVc4C646nrpUwPHJJxl9UwP8xDrvDmUdVOW4Uv/NdwnYrbNjeX56+i4wX84893BvI1ZIif9JhwAK6ik3WKGZxqycWndvCOAqeJHbHTAQ5s9KnOpBiCmNe2YP3nwU5WZDkYRC6yPrUiGqF6ls8qoviOgcGfXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111132; c=relaxed/simple;
	bh=iXYnw9FT8ud5Nwjsy+sDdAkpzlJibkfXy1blYeOd/DQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bFTPxNbunzIn28td7A3pTQUohBYDj/FLZoClcP+GLkpPTPre8Jqy8MTmnJDcjltpsMROei7i8YXWPmrxg96iLattBshxTJshDXSLva5Aa2a6QN6OYWUL4YiGTd7vVB1i4+dlt6iOWOIv5nOW85zWDZO5z310O57jf1KCLZZebsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xUTXD917; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IN9jmWLH; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xUTXD917";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IN9jmWLH"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B3BEC7A00E5;
	Fri,  3 Jul 2026 16:38:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jul 2026 16:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783111130; x=1783197530; bh=ud9tZwWWoJ
	u1f/xtQf0HdEJvjlWouUFApeFN+FqRpsE=; b=xUTXD917QPDn2FV8vgKdn3uLiI
	BoYBuUAOrDvzmpDG2LSayRh9sFfKHkabybcTXPqVawhWaUeaas8WMtBsiSb5qt/F
	8hSxvozOmGMTVkgmlOJ5U4jDZIwTdRz5UiSa5BdL+GAqXidGXGW8+qpF+6nAKYsF
	NARJ9knVaQ331+hOLKx82yE8cuOu0L1F5WK/aIvPc8miL6KG6yPraS7hANYajO/h
	9BWxRdjMzGDzuUbTRSeQ1kyWDNXNaW8m+q/Y0Rv4Uy1nLM+6vYYRkBnHA+3rF4cx
	Ar/YxbmPQLE0XEvou8NDUSDXJyGEMzCquuA4KLFc/6cyHpKhnMq1KIeGLRsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783111130; x=1783197530; bh=ud9tZwWWoJu1f/xtQf0HdEJvjlWouUFApeF
	N+FqRpsE=; b=IN9jmWLHU59579CfhFiE/vlhRaIdvFhaI0t5aEyB6z5Hpht3cqa
	yIQC+CrRNsNzGRbg9z/yhaivLJCqiiePJYZVw3PBMFGrzybb4qXpfMPpI2YAr9Is
	ZonR39cHpAbJfAJospvDMDGHHtObLyhoLKr9Xt7O2A1YpS9DPyISDgVf2q2LD81q
	rV+DsLAc+Bf9nqcnirxzsQ8Lq5w/epdIhXMcAIAxOYD5ycByYJLsOzJ4tXdgSyl0
	BlGikjle5ORdC94LdTxYVyxKdLHxeA3Hfao8mAoFhgLjsntSfoTsUL8RGzCCfPB/
	u4TXqv+Rq+Ves6X/3KOBSFqndUmEbwxKfEg==
X-ME-Sender: <xms:2h1Iaiz6lWObdRSZu_9BFeL0Sg3lHLEJy74kq8C6RedilPQCwZdS9g>
    <xme:2h1IalTNXVFl3rLZeWpeEbvm5s0xsbGF-0kzS2unCUfObU38JAJQRPAjFQz1kz3gr
    kzPbJw6S9mLg4wsOx0S4rslENCvrvzJFjZFhxHXmXyKoY4Fn-KM3w>
X-ME-Received: <xmr:2h1IapXyw3r1lGJBHVLJq3ooVv56fjTZwwM0mh-HYy0Zg1NtzdIQbt8GsVk7bOatETtbO7rDCzCa2a6MwjtD7IaIlqlZUsixbVK84LA>
X-ME-Proxy-Cause: dmFkZTGb/2JNlfC2EKQXCTu9De0qTteV11NcgmJKucjo890Cx/4DK86A7Z/at8G6u5BQWy
    SC4bBghIqd1cq+kd9vB5437deEHscBhR7PRyFnRwzwE8PWuuOJ35SMVOeYrpWaHNGjFjWL
    Qh0FXyaoosUdUDGbSDum09XORDWJ5nWpi4LcNgD9QWCG6jlHXn5Qe45t2GwEtBO3kxNlGv
    00SjAahRv5t69zTs72bu5YEy8GQUaBKTHrqPcu0lBhhyA8eoKw/T8cyb1t5V/aht0qTj62
    5aeh4ABp9Qke7qSfEw9LfOJy7nV0HibnqrR8I8lQyg3YHumqptMy3PkSUZTd5dyCjdhGoF
    N3UhFqmidhMQMpx25tBkbmjy7HC3U067lvuxUoIGEZc7TCGzfoyvFZjB6LpMmye96jVyGf
    uNRJGC7MHY0ZWTe3BfEbjli9Tg1bbmlWeW/7mF0fkw+1bm/BQ3T/hqEjQP/wdf5efJ4Sqg
    e74gCPcwX+QlnjtyH8RnDMYr25QxkjnrsA1vjyH8CaAP7ABsCcxxsDaKgfOnZ8dA5CrxYG
    bJwdx8O2b5UHNNiGY6CZ72TmfCMTLKYw7aTX4KF7xlO7rrJV4cnQnvGllZOXvKh88gjv5m
    pDkYvIFUxppzi+4tVOrxVcXzOGkZxx0V5cwdMTgwDBBDp6z34EemG0UMeBlw
X-ME-Proxy: <xmx:2h1IanY13AH5TAlQnHgQHRAoSnWXeeyXLF3efpZsIbouJCg2fNvQlQ>
    <xmx:2h1Iav380-xS1ZKHAV_WgTHKXm_WiGfqzr-YbGUfpQocqWmKmgGvSw>
    <xmx:2h1IaphTYDmkWavgs_D1e1yX0JYvFId6cYR_5ovOxarJYwBhOqA8Bg>
    <xmx:2h1IajY7KWEwsg7uOGohr0R92FkDfssBWnTwiVOVCrrL6IL3ymyobA>
    <xmx:2h1Ian1cLhasMobCsISrgicXBp3npHG_DzCxlEEYbMZRjnpF0I7ncWTd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 16:38:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] rev-parse: exit 0 on --help
In-Reply-To: <20260702084519.GB481298@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 2 Jul 2026 04:45:19 -0400")
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
	<20260701212442.1430084-1-sandals@crustytoothpaste.net>
	<xmqqcxx6mkjn.fsf@gitster.g>
	<20260702084519.GB481298@coredump.intra.peff.net>
Date: Fri, 03 Jul 2026 13:38:48 -0700
Message-ID: <xmqqwlvbhkpz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The other issue I raised in the earlier round is that a script like:
>
>   cat >git-foo <<\EOF
>   #!/bin/sh
>   git log --my-options "$@" >output || exit 1
>   do_something <output
>   EOF
>
> when invoked as "git foo --help" will now call do_something with
> nonsense input, rather than exiting from the "error" returned by
> git-log. This only affects hacky little scripts like this that are not
> otherwise parsing their own options, but sometimes those are the most
> common. ;)

Yeah, I agree that the above is a much more likely breakage scenario
than I imagined.

> I'm not convinced there will be much fallout, but it is possible.

True.
