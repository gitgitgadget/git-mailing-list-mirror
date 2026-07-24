Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F5C4908DE
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930061; cv=none; b=bjGB0Da0bKVauM/Ib4/zez6/aff/l4nkRBxPpP/vlswLQKYVdv0x6nKPCuS8Zw/qlwEzi81PRk+LyOZR6Tii2UgEypIV6WwaGEx8Fe/BuHINhYNOPBo+C4bM9aAL484pLbmEhVl4zAMykhXf0zB2yf1b0Alfo5+rUI9oe9Bs/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930061; c=relaxed/simple;
	bh=f6EBlGWUgBmg2t2AFMtCLAIQaZlIelF3lcS9FczpCqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lO0uPgJdFiMBvi87V+gwk9jlMTHmgIQXgA5B1FxRBqPCNlY8qv/2Fv6pxQ+SZPmwEARebvfd2qMspuqUsD6RAWqaNt9afPWImykkWumSGznqdQp9LqqJuq8X5HJaPHscaKwpmfYYlCzVgUs8E1cjB+Mdd07irrrn2nTnCRJMc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nH65KIHi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNiZuiCw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nH65KIHi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNiZuiCw"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 67D651D00432;
	Fri, 24 Jul 2026 17:54:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 24 Jul 2026 17:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784930059; x=1785016459; bh=qkm38/PUxg
	823Ks2Fqjxis/sntP41DTFEiN8fTeR84k=; b=nH65KIHiN354NpgFtO39gUWNgh
	LHQdD6gSkMRVh6xuBHJyGqbUhxQWM70kMI0mSKaAUvHE760EHqdBtEHmTlk413Vo
	i8hbwvAm5le6mn7xWFOvmdCI9kj1G2k51Ks6tpz/hBci6dbHRs8mLyn0uSBHlkV4
	H0Y77CAWOq70E/hvQpuVqPb3KP35ELkCJRPn1NbcZsOSh6HfILYfVWA/QXo1H1JJ
	OVfv5dKOOBKnB/sse7yItbY/cFyD1wsfHlNqwkGXifntG6gFzptJa7/uxaMt3Xga
	sVU3Z/S4RdYfg2XRFrM9i8fz4lg97DIbHcvFLFPcrwplpNXf9jZabxyYMV+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784930059; x=1785016459; bh=qkm38/PUxg823Ks2Fqjxis/sntP41DTFEiN
	8fTeR84k=; b=LNiZuiCwlxnmseGSw3PceHpkFTT0bS9K9cTZCLpJY+6MpjLv6md
	uY/+gZDHmFddjh2G5O2oIpLUxKw0EbJaPcL5bH4rQAiLV5IRiQj8pUuZpYVPBlqW
	J0n5ufuuQpYEb18Sc9cUJT6MSG0TcAD4vhcTCp56+L6WciXJb/gidy4TcxSAn2Bg
	87OzKC1NSs/HOmhIeCdWyqtiL1eQW00FGIzfm1jbVR81VzoN8LbzV498c9JuBdce
	VS45QEZHmvDi1DUwi8CXH8Hv0oZwpI7AAczM54An4U4Z4IMYCuq2yaJUxfMICs6L
	23oQcU4C9s/iseQOYqScJWTDZntY8tQuX/Q==
X-ME-Sender: <xms:C99jau6bM4ZY317RccKQMKcXzVRZHU_1ZUpdu9YwDTRZYBe-0XH3FA>
    <xme:C99jarJA99k7H0yk6-rvwm_8fIjly7azaZnyL3q_sl99MhK3BQepxtiR2I6xsEqOf
    WsO4ydkvXZ25hxDA9aHsffwJWuTFUiJhfWd-_UVBW7gKiALI96TjA>
X-ME-Received: <xmr:C99jam77SNtfcLDY1gquYfDs984iQwCq5B5-92WIkJjrueoQqOmCNvYrbaZVrV7kThE2bfCyLuNGAwlG9M4LTDvE_41hiq3EyQ>
X-ME-Proxy-Cause: dmFkZTGvpp+Uydjxtfp5K7hmdkhhlijqDjiUXdObrs3PaBGzuAJgchWoGGtdhRbP8UaveK
    9uqhArcB43IVnMJ9dOc1M+1bbeynRv7UGRAG0eL3TWPd7RDMRd9aiNLIyMCCnFlE1+chY5
    x3bQTM+eujC/8Oe6OgBKf8UbojFe1kOmXeCGsSGA1KpcteHBaSarLzMIqvMAD2ypR6LqvH
    MQ8sqwmHgQ6WagfdwnqTtst/yg7j5tfJKVfweGtQnF+raWTCE6flvE2r7v4guNdQHL9V8H
    aV9qeKdJbP9yoB3xg99dg4CcRRyYQ6k1zvcatVMwtwk0BDh3sjwTW+fL1h9W0P160jBNVf
    kJkIGHEhcR0Zr/BwuJaFKI//CeNYcrijAX7Yki3Mw4ulzNpnOUvV27csXPH7qZe4cXZkPl
    Vtpa25wUv7LHVPL+nhCBA7KzH1kn3xpzCYuLvufPYWCe6Y/0DyZd3qyBcN5fAddEVh4own
    5gZmssEvW6o9KoHQaEJTQlqQgFFh0yAhJ4e8U3CZNZiBZPQSBTeLWD/uVq4KbGH4sf5k8z
    VPNU/SgcO5yN2RQqeY5BvqXTzjO7qGoDrkfgisXdscLOSxNfSHvslhwSJ6UaST/XkDZG63
    N4pd7RuTh52uqS4fcgypmob1WAvZPtIh/eJ5Q0evuLfh33FkrXJPogR06D2w
X-ME-Proxy: <xmx:C99jamxdwYfu7rn3ujYWIXqsMGpd958oIikdU8GAJUUwptKtwn-DHQ>
    <xmx:C99jaiZQZVkn6J4HiFJVremztYNwQ6lv59ljxfMYdPL3lw_x4i2KQA>
    <xmx:C99jagROAFsaiG_OCoK9GiZqDDNOU9VYxog0jgOkjCQMPfG9QSkAag>
    <xmx:C99jakyQF8zb3zmpZjqFcNmlduKRnvJyAtwg3GweqqG6EoL7c7ujqw>
    <xmx:C99jarzHDnyWjCl7nU7GpGcowQEEofq3rnC8Ad0cE7KZdRauGVujMolC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 17:54:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] packfile: harden handling of packs with duplicate
 entries
In-Reply-To: <cover.1784927134.git.ttaylorr@openai.com> (Taylor Blau's message
	of "Fri, 24 Jul 2026 16:05:44 -0500")
References: <cover.1784927134.git.ttaylorr@openai.com>
Date: Fri, 24 Jul 2026 14:54:17 -0700
Message-ID: <xmqqecgs3vg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <ttaylorr@openai.com> writes:

> Packfiles containing duplicate object entries are unusual, but Git
> already accepts them outside of strict indexing.

That is looser than what we intended.  "unusual" -> "invalid".  It
is just like Git does not immediately complain until "git fsck",
"git repack", or otherwise "git" tries to use the object if you
corrupted loose object files under .git/objects/??/ directories.

Detecting such a problematic pack early before the problem spreads
is a very welcome change.
