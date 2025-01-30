Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA71F12F9
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264759; cv=none; b=anmQD2NEMlqlSVDgVUA1WngdbI84iAPvi7slZfsBEms8B3/sAxwAPW6a/r1r+euoDCBPXAZrVhXZ3S0JWebyBzH4sa3wO7/LOTBZrvF4UEbWjacRmxe177k2S1VeyLJAjkvupP00HUHWlC2mGnu2c6cnj/KB/nn3fXeJSBWcFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264759; c=relaxed/simple;
	bh=dXr5kfmEzhLMppaYv9G91cbHl6OJzR0OQFLjoQAqx2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uJaCquEpinhp57814zalvVueckfCtyv5rm5II/G76kaydJfODekjK/3aIRTFqo7lRZZl7Blq/ev6I3yCoMrXGoX4iK+5oEYCSaeiXjmKdYhsJXkNewvRTUKjqqkyfJAnecmkl0aM3X+HTq1kJkMKsTdtMoo7EKmbAhaRUCVqQ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hmFdE2B9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r8E5oZxQ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hmFdE2B9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r8E5oZxQ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17809114011B;
	Thu, 30 Jan 2025 14:19:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 30 Jan 2025 14:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738264756; x=1738351156; bh=J7BCL5cGF6
	mEQ+jWQmgSD1PSMHM64S7QM21pN6TfD/0=; b=hmFdE2B9WPRtXS7UtpVSmrLVNb
	yVsbW1c/dmPy9dwDTVhdpTBsozruVuRKIKXjnlRqylAK3ChKqBp5Zt5dXpqmVEnA
	3cDIz7/sWK0LzHiql8mlnYDATOXMz4wX1eap2BGifH0Cs8AK0tOp/vzY1JJGw6vF
	1cHTWYkqh/yLIZKnHl1QAJegWfoMIMLeqxZwTiNcqH3Hu8OieUYLpld002m7Qbb6
	nBosSVe17b1q5xo5cB+a4g1BilDmZr8ofVx1n8pZINUvJC8RoiaKkMImrSWe/k4v
	0GatMtd298K46C8ZUKmL24dj2I2XfcYQGqgcCdgXYfqqCSPm5hHDo9eIjkRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738264756; x=1738351156; bh=J7BCL5cGF6mEQ+jWQmgSD1PSMHM64S7QM21
	pN6TfD/0=; b=r8E5oZxQSRe8MQ5qwKl4LKR+9X5OSQAypWTNLDZIc1JBj1kMPbW
	DF2kO+eYsCU8q/twtcsmvQ19Mq94YijmKteuEqhn5bwgOAtRwbhQSIPFGH9uNDBH
	PLht5Hfq9RJoFWZ5LuFNI5B/s5pkRN+C8u1GybQN3HpoFw8tez33d70HRT7yOqmP
	dC/CoTHQhPoCDxWyceERiWsy61fV3UoN8nK99Ve/1cIw2atrvibPUU57dOnCccNP
	PEGuEUqs0h67VMeVVazS4TPSlM9a9FAEuxWeoTdTX0UbTHIHqWTgM+XBtnhLtJT1
	arUSGr9AkOUhPpFra0HNnbbch/undprJp+w==
X-ME-Sender: <xms:s9CbZ5_aX2iERzPcZkX-vk-tVmQu4qnkqtaWU-8Wij40QzAEBQahpA>
    <xme:s9CbZ9sLxUNy3V198QW5rJNS-Q1MNtp4D2QksQ7o2XQpcjFOfbbmRWWCzDftKFvsp
    qXDM_MX2nUMBJPItg>
X-ME-Received: <xmr:s9CbZ3Am0bJu3YT8tZ18MS0yjLsajG5WfAaAEqehKSfrZBhUFNvXA15IzS7ntAus9Mcmmi1OxFWAZA77blClmfUtlsGuVapfCpEq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:s9CbZ9dpud-bw_TWoeupZs1OhlrhH6OAOvZsU-1svfAJvP4RCzmHOw>
    <xmx:s9CbZ-P-gBcoeKuYOlCeXfY2bUKZerSswJXKrvAnA9qDILSdpgpIVw>
    <xmx:s9CbZ_kUFzvmdxvOaANgVJ1eEwsqjHYIMh58XS6Ly9CyXZqppgEFsg>
    <xmx:s9CbZ4s11Zsh4d_CJk0mzVTmcKCf1XgYC0zTV6RPb5NNPW4CQbJA3g>
    <xmx:tNCbZ7rKxekRonMGMntTeAZ1J0BqkJgbRaU2XkF8yUVpdGDQj1I64SCk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 14:19:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] Plug two memory leaks exposed via Meson
In-Reply-To: <20250130-b4-pks-memory-leaks-v2-0-fc29dc7d4b19@pks.im> (Patrick
	Steinhardt's message of "Thu, 30 Jan 2025 07:17:37 +0100")
References: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
	<20250130-b4-pks-memory-leaks-v2-0-fc29dc7d4b19@pks.im>
Date: Thu, 30 Jan 2025 11:19:14 -0800
Message-ID: <xmqqfrl0cdot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I've had the need to play around with the memory leak sanitizer today
> and for the first time used it with Meson. Interestingly enough, a test
> run with Meson flags two memory leaks that our Makefile doesn't. I
> haven't found the time yet to figure out why that is, but this small
> patch series fixes both of these leaks.
>
> Changes in v2:
>   - Add an explanation why t0301 only fails sometimes.
>   - Fix commit messages to properly point out the `-Db_sanitize=leak`
>     option.
>   - Link to v1: https://lore.kernel.org/r/20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im
>
> Thanks!
>
> Patrick

Thanks, will queue.  Looking good.
