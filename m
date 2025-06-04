Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A997139B
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072314; cv=none; b=DDKeJtjVdtADMBQ89EFaIgjDV5DEq6BP2dAYakLb92zlj0Jrqc94Cv9Y6tdiURl2EHJIBiOEnVnSeGZafnfkyftjBxAFfPxBu71APlSErflgkZvOa8ItnQZYmmYfjDNDpvHEVBhn0Inra+ctsANSAX2LnoCiekr131XG8VYzVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072314; c=relaxed/simple;
	bh=WDm0ii6y1CfEYDg/+r8E78PKXAt2D+oxBboYULgOiS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BSge9pOop4UTI/3rBrhrgJftBHUlz0oJVFg9Lz/OJOqWIna0SzR2bqGnbH8NpJyzr3iqm1iYXQ0wApKcbd9A9CPwLE8CEuRtpLScFcSWhwx13Gt/xGAHf1QgGlHTUIJ9x28rLSdS2Jnu/GxYRT2ipq1QgG4/VJJyyAZtFVNqTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AuoW3jqE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JZbk5l81; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AuoW3jqE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JZbk5l81"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C77B1380599;
	Wed,  4 Jun 2025 17:25:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 04 Jun 2025 17:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749072311; x=1749158711; bh=ns574iyHbq
	Rg9kEG77Fq0Og1ciZowwpPOuo8L001F4Y=; b=AuoW3jqEJsnXxccrFgo4hvR7gc
	D6nLYOrJNgHBSDVnu+KlBYKM4O50EUB5gZhdPICWkT+9NcdJ3+zp5vZvqK5ygQA7
	uXm3vmy0ji0lgp6SU+zLSX6o9NLokmUcNdT+ttgb5AjZ6HZy4WuMqgLsVF+BByCf
	+tOtfFr8tHnKXqabB61SIjVOz2Dzc359AZkZaSw0oHXVXn5b2Gaj0z7CEYnxUIXC
	Hc/WA8fYJ95ZJjjwVX1hodDa02UumsHk3OpwCHpkiOhxD/e8qXaEOckIlKRscebu
	swouXcqVSM/URMutIdkJpyqLs/3S/nQskzGGs2C1fHHI5uJbooFOZ3qaChYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749072311; x=1749158711; bh=ns574iyHbqRg9kEG77Fq0Og1ciZowwpPOuo
	8L001F4Y=; b=JZbk5l819TiFYY1cflCWeJ0YMoE1w33KAx/BepU4y7FhMHEiOpo
	82uLTaj65RsIYYBF2IR7Y3fDQ+wlPJkZLzHSYuVvzR3kG2Vig0fnFJQIWfwFjebF
	J0Fbbdpuvnm3c0mhpdA4Ls078U7DJ2iqRT8xHPx05tr5R1eBwRyEVqWip//IzRBe
	4rWZc+3AfCNfc3x/AR6cmXWwfJDvEih8/Xly9UDsszunA4e8np9kFXNfCjFtTk1g
	8Gwb+AEt8bSN45i+b1HItlzNvmDaNSJJ8kMr6fOrQ/6D+2JCMYEpK3AcINvNjQ+T
	+ukeQkRiZzGMr2yvsl2wTDjY1DIz1GZ5W4w==
X-ME-Sender: <xms:t7lAaMcVoEKM5b2sZ353mLJiLwEquoffSaxO2X7mqyt38bVx7V7j0g>
    <xme:t7lAaOMrJB8zeyOe2fZ9vkNSU7Tn3mwdAZG6IjER6PrMrpg3sL6x9nWCZvlXixHM4
    KGZwLRbkvF6H6bodQ>
X-ME-Received: <xmr:t7lAaNj5eAiHn8nv-Vz6ck6EhV9JLXCNRjkwhKtL6imQ0QoZblMNLPmHPa8ar_UBr5B28mDGzP2jFBkjyCpBiXacoNNJNnQQz1Dh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:t7lAaB_d_TOlizOq5c_5U2xQplpK6H8i50BqKCzMupNI-vKsl_1VJQ>
    <xmx:t7lAaIvEmC5veIhU8M9O_T_zvHCH-B6MuRe2lvSlL0NlJrHlf4rK6Q>
    <xmx:t7lAaIEtq1K_nv-u4BPaqrMsTN_bhpZXc3qXHixCm5OfOnWUEzcB4A>
    <xmx:t7lAaHPXTUFcCim1ix5w6_gJ6YuN6VVexBpodJAXDXUdApBxUsE66g>
    <xmx:t7lAaKoz_NRX06n1UlD3pDa-cqrzTtKnq3Pq-s1N_c86JujdUBZ2P-ul>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 17:25:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] curl: fix symbolic constant typechecks with
 curl_easy_setopt()
In-Reply-To: <20250604205622.GC1510819@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 4 Jun 2025 16:56:22 -0400")
References: <20250604205505.GA1510724@coredump.intra.peff.net>
	<20250604205622.GC1510819@coredump.intra.peff.net>
Date: Wed, 04 Jun 2025 14:25:09 -0700
Message-ID: <xmqq8qm7b3nu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> It seems kind of weird to me that curl doesn't define these constants as
> longs, since the point of them is to pass to curl_easy_setopt(). But in
> the curl documentation and examples, they clearly show casting them as
> part of the setopt calls. It may be that there is some reason not to
> push the type into the macro, like backwards compatibility. I didn't
> dig, as it doesn't really matter: we have to follow what existing curl
> versions ask for anyway.

Well reasoned, and I grew 100% with the above reasoning.

Thank you very much for putting these together.  Will queue.

