Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD663D47CF
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939150; cv=none; b=Ahg2CxqF9Esnp0nho30VTy1cgBz7mVjdVtaZRC44tGwYWs1T+/Ch1BB4rQy9s0Q586MU5wWW3+6MooCyyvND4uptZYxzPM0JB73MBfWJKmv94ygIZ8WwnKh72zl5S8dqj9pqSLafPUZeL4SkN02V+pjxbY2CgX/fsu7hJ120ZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939150; c=relaxed/simple;
	bh=Y6DO/xDisHMpC2nURlsIiMjSK5xaSOQ1jYLPT6ytXds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OMEWom4wWzNsBen14d5Yodu0aazTWkgCEZCd40+qo3qbma97pUqtGkdUQ/jIn8w94+WUmM/0LZq6blFBYS71wPYyAvHaLcgdqXzUu0A/HHyjl7/HKWTw/f9RojXSL2yUy57j2BAtev1Wje64PSZvLe7aN4BugQQZf+gkO7Xm/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bl+wCMyO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZ4Uobmr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bl+wCMyO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CZ4Uobmr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D604EC0190;
	Mon,  8 Jun 2026 13:19:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 13:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780939148; x=1781025548; bh=Y6DO/xDisH
	MpC2nURlsIiMjSK5xaSOQ1jYLPT6ytXds=; b=bl+wCMyOJecDr4ZJPOAdT5yK+9
	gI1M71x6troooCSPL5D4thA2AOQwVc3h4PrxPYlRzKd0T0gwMK4ndYdxQyyBXVsk
	xO/cpICI7YIZRp3eA14Lu6E9alXMosos8cjDsSmJcGTKmI3mKE7qQX3x/uukw2rT
	SMizaMxhCDAo/bBcALuVqCnFhKmeHDhf8180CrLmwyZHHbFOCo3V6/lREHPiWIK9
	Tve5hDeO4xm3iMf+q+OqNqXQM+0VTis5yv4XoQbpTBCUbRHqDjHEdcBwLjVuH1FU
	eT26Ze9t8IdmFPE/6Mf8uC43ftYuDQjPn60b9SGkrosIsd2fe4QJQ70cEMsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780939148; x=1781025548; bh=Y6DO/xDisHMpC2nURlsIiMjSK5xaSOQ1jYL
	PT6ytXds=; b=CZ4UobmrDEPh2JbHqI4UG1rL8/g5fZqT2OWmTLVCt2Hm7C461Zx
	SsHkSopeJuJH50Op7U9sGojQ55LCL6xba9QlgZzZQcBbxrRrGECpWA4ZY8GLgqNm
	cwXAhCIkuh7QrxeXdB61OXFy4VeBfMoJov9hvzfpBhGZxi8xGAkeGnJgReOi14a7
	EB5cuX5cYXa+RyKv4A21I1JhoicYvkGz+wiNcLbYaO/BnaqLTtg226+JOSfKOWsq
	kv2DDb1LLLPGjoejNtcMuFlge4d6fm/HNxMVsE7SkqMfBiLSg7CUti/leQ5YvMaj
	Aepymp/ODznjHCzMuWm61qm14PrGuwTR4sg==
X-ME-Sender: <xms:jPkmavirrnVCI-A_jvHvb6b9RJtC3PJ0IhBrMQl8rJ5tHHG3YyE29w>
    <xme:jPkmai7vrL0IzNSUpxI7Fy9_1TjvptauqJfy_xn9z6kdWhVjYjuGRN5n_Y_mGNJp3
    VpVX6WSNh_nw9QDpWDy6rH7PpevJyy02O_WyXXL5NWg8wQbLlqgs3c>
X-ME-Received: <xmr:jPkmana9_yYNbtNEjifo18HIsmiceWpqmjUB9iBt8o44lvVFsOmowuplwW9iaTUVQ4IoMeWmY_kMt6ohJVj7-t44dO8WGsn2Sr_u>
X-ME-Proxy-Cause: dmFkZTEv1A0+DXVvKVCT1/KJg8nxeirTxpAMDxGgdUCUx3M32dH9o93umjvT+d4rrFFV+a
    Z5ur4pi+PtjlsvlKnbZ6xxLni2gFCvG+OXc4QxrJTjmmK11wH5srqMPCIGe+BV6ouxKqBw
    +FaNCVaKcN6JIoUUBmS+GwC2IuzocGZod73LnyKpvYRXpoDulrzXQNReu4vncjVO+d1mU1
    GkYKfEF2T/TAkU8zxFMV/+n3++onkSrY83pEw96GFrxW3EjRMpOQ7aEGIlVA5HtREe4sKQ
    4lyHg5vzXBQDz8MsaAw91eo2aHBqBw3RTjodTlISVA+6dCrl611J75rHrSmenqMKiuy/Ga
    Pojht+y0eFMgmdOnW5YpN9jm4XYDMMAXLvrG+NLPy50dMT3Z+2034G1ePeSomVJhY4rTbT
    /7bENjBHVG9ZtcgHc3ZU9rNBlORhBLJzMvXi76oryfDi5dybqtrnECVEuyhoK2njjf9CtM
    mP7LWcu4tqfqLqyIQSAR4e/ugqzGbTwwNXs27iroBtxvuDHk747tYmIxc+s1XW2YAEHnv0
    5Jkl7ul1RM5MMkdDhHsZqPQhmruJJk9RaORjSXxtLoJ65KfU1FM/wZubdfcu0TN87EhPks
    ukiuVk1aZRztLB4OCY7w48wjMzVWWeZiiioz2WeKvj0s6Q5zdi5fPBgs7BXw
X-ME-Proxy: <xmx:jPkman7ZhOH9IxsivswxCiJWN4f1l_-_5GNOCmCp2LC8iquD8bcyTQ>
    <xmx:jPkmaqCLNVoajf9unzrsmxupDQgb5W18X5EzkQeR9Tt7rzNZV4YUaw>
    <xmx:jPkmateMuv8X4GN2sosodz7jBeS8iiistY5_c5pml4W9cmcOe-wexw>
    <xmx:jPkmapJpZBuWGcUvVpRZxh4zYZ3DWS6tEZN6XqufbUEUspMKCA4-iA>
    <xmx:jPkmauQIvb9sSsg73qQ6C6FocP4JFxiBl_Bl7WBa_Beh_EmRTTJvW-7O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 13:19:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Michael Montalbo via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] diff: add long-running diff process via
 diff.<driver>.process
In-Reply-To: <CAC2QwmKNA6wv-jG07fgJj7Xj2J+dzzWEiqV5Q+8HJpjA_GtkFw@mail.gmail.com>
	(Michael Montalbo's message of "Sun, 7 Jun 2026 13:36:32 -0700")
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
	<d044fa0ee5c9cda7dfe4f663f34443103521ef43.1780087700.git.gitgitgadget@gmail.com>
	<c7987f11-9181-3975-552c-14e74abb2c97@gmx.de>
	<CAC2QwmKNA6wv-jG07fgJj7Xj2J+dzzWEiqV5Q+8HJpjA_GtkFw@mail.gmail.com>
Date: Mon, 08 Jun 2026 10:19:06 -0700
Message-ID: <xmqqa4t5vtkl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

>> So the conscious project direction has been: fold pkt-line test backends
>> into `test-tool` and drop the scripting-language prereq. Reintroducing the
>> same shape in Python would walk this back.
>>
>> Patrick's careful effort in 27bd8ee311719 (Merge branch 'ps/fewer-perl',
>> 2025-04-29) has been another clear sign that the Git project is actively
>> _removing_ scripting-language dependencies from the build and test
>> infrastructure, not adding new ones.
>
> Now I wonder if the extension / addition of more Perl test infra with my other
> series:
>
> https://lore.kernel.org/git/pull.2135.git.1780559158.gitgitgadget@gmail.com/T/
>
> also goes against the project direction w.r.t. removing scripting languages.
> Maybe I should also re-evaluate the usage of Perl there. I am leveraging
> existing shell parsing logic written in Perl, but maybe the preference for
> Perl-based lint rules is a mistake and should be avoided.

That sounds prudent (even though it is outside the scope of _this_
topic, of course).

Thanks.
