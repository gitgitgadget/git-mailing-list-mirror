Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A22185955
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764428368; cv=none; b=nJeJjYB0+R7jc1E7GSz88++pTARFcF34RXGLLXFtifsp8ksLDddtNtKSf8ORnkflN8uHFTCJPclQgFwPkRsLJij1xPtIbii7SJk9XH/xb+PVdktIMoGbb8SmFkMx2ou1MiEg/Cmwzh+BZmagYCqwRLaa7VEVpuLMJDok90brHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764428368; c=relaxed/simple;
	bh=0/a7DWHbpMYYSUA5u2yyGDBrpMCnTJgGfHI1eB5pCws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ou34Hyd/ipnfLnsXTsIgm5Xex6bVtqwJysvNOVXCCIoOSKEFK4WljuN94wlk4kXo+NdU1mKsv+bcIC2fTj9z/+Eqb7nBYKz4Jf7J73DArIVJH8liV7E5x6VuyRvBg5Oy+D5ggiRzq1fVuqxGKoh/i6i/ZelWCTwKmv/ywb4S8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P6OV+tAT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aX1ti+qz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P6OV+tAT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aX1ti+qz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A14A31D00214;
	Sat, 29 Nov 2025 09:59:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 29 Nov 2025 09:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764428364; x=1764514764; bh=rej3r8r0Hx
	qROBdSlzt814DSXZBF1feFMpLx2oqA+No=; b=P6OV+tATKtkCi3ufiYRWbGSA7z
	mPfRv7mVzgSMhS0amFfVc6GADQyE3NF4mjQEKX0B/QPncouCg2vRMfUCzpy4/YQJ
	CeR2VrK3/j+DoxHvDPRFUzByhJW8wIz1yoQOOY0rwGgD6h4Rp3GAvXfYFPVFhvD1
	ntfmRcIoKzu+uCErp/k3aF/DNLfO9Fp3Egq8v6caS4WqwbTTuKHE8rq+NjZBggzm
	xWi0fP6l8wpcWHxSuNvMrkaewMRncpBpUEV2O0bmQmD0Uz6IWyGy+qWm0WAYBgWO
	fPwzETnyP6HfxUssT1Gr3wwFvI61Kb1/lOIID3FEoLC1NraGq3SNvZFlPDuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764428364; x=1764514764; bh=rej3r8r0HxqROBdSlzt814DSXZBF1feFMpL
	x2oqA+No=; b=aX1ti+qzwenspmUQlxoPSAPvmGjS6mAoGBtR7Fsb22cBZs2Sg6n
	FiOFQ1Z38pDh4izdRGNNS4/csNBBpgEVvabB6wiEdzRLYLd0NyaS9kt+dbxtSFOX
	4sBjpRqAO/Xv5u7ivPNOt1jPZ/j59ipz2Sv5WMRFAzY9tJqx/sqqzXLU28aPfsfX
	T7PoGAOs+3UJ35ZzyMqOok/KqwL8Jnb0yGU/PawlOJ2GhYd+PLTiyyKUyRmX8qoP
	x7xtagsoWX8DwyYF4zrbdEetG2kT/9tqZNaHKj1hThilV9UKgRhrTu6oU2QOrwVD
	EUVx2XPoTgGb0FAndBK3jPJNvZiVQKtTETw==
X-ME-Sender: <xms:TAoradONVYZ-t4g4VNtfYBrLfF6pg2P4mounD1UBYj1LbT28srKd3w>
    <xme:TAoraTo2zr9ublXJnyBqd8bh04U4A73RY3jhWxJPitGDVTBBLyFKikaPZRcnhR58g
    oj3PMKdn7qHGiFBLwRbSGdaw6iDitNO4x_NFiw1sMOBESZpVpJEQQ>
X-ME-Received: <xmr:TAoraWGNwIHwajWknyG8g8JM0cOSQGDKr2PvqyauzJcOewOxykq3Xorq7EQD7IGay6KBdrLc0EK9GBdWSHlFn7VWr9geYE_CTXpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedvjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TAoraQrIWpXQgnlMM6DgeZO5ljB8NdRIXap_TPSm3K2pN-a5gd-f7g>
    <xmx:TAoraXb3DaPvCW3gUEhH14bxg-LRpjLpHnjho6dWRxfuegfoVWymTw>
    <xmx:TAoraRWAPv1880ai0VfKwHgEfp3EUP-L1Gi6QHo36n4ZhJYHLK23QQ>
    <xmx:TAoraY_dE1KZ-hSl9BZbxsPkONecbslUvw3Zm84MoutAi28GESKRSw>
    <xmx:TAoraRxL9aq6UDw1vbW0yrPZ3_iWI_V4QrUatk-YbljYRFnquYbLv_I9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Nov 2025 09:59:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH] Documentation/git-replay.adoc: fix errors around
 revision range
In-Reply-To: <pull.2012.git.1764391464952.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Sat, 29 Nov 2025 04:44:24
	+0000")
References: <pull.2012.git.1764391464952.gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 06:59:22 -0800
Message-ID: <xmqqcy50hol1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> There was significant confusion in the git-replay manual about what
> constitutes a revision range.  As noted in f302c1e4aa09 (revisions(7):
> clarify that most commands take a single revision range, 2021-05-18):
>
>    Commands that are specifically designed to take two distinct ranges
>    (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but they
>    are exceptions. Unless otherwise noted, all "git" commands that operate
>    on a set of commits work on a single revision range.
>
> `git replay` is not an exception, but a few places in the manual were
> written as though it were.  These appear to have come in revisions to
> the original series, between v3->v4 (see
> https://lore.kernel.org/git/CAP8UFD3bpLrVW97DH7j=V9H2GsTSAkksC9L3QujQERFk_kLnZA@mail.gmail.com/
> , "More than one <revision-range> can be passed") and between v6->v7
> (https://lore.kernel.org/git/20231115143327.2441397-1-christian.couder@gmail.com/,
> "Takes ranges of commits"), and I missed both of these revisions when
> reviewing.  Fix them now.
>
> There was also a reference to the "Commit Limiting options below", but
> this page has no such section of options; strike the misleading
> reference.
>
> It is worth noting that we are documenting existing behavior, rather
> than optimal behavior.  Junio has multiple times suggested introducing
> alternative ways to walk revisions and use them in `git replay
> --advance`, e.g. at
>   * https://lore.kernel.org/git/xmqqy1mqo6kv.fsf@gitster.g/
>   * https://lore.kernel.org/git/xmqq8rb3is8c.fsf@gitster.g/
>   * https://lore.kernel.org/git/xmqqtsydj2zk.fsf@gitster.g/ (item (2))
> If/when we introduce some new revision walking flag that implements one
> of these alternate types of revision walks, we can update the --advance
> option and this manual appropriately.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index dcb26e8a8e..d03235cca0 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -9,12 +9,12 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
>  SYNOPSIS
>  --------
>  [verse]
> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>...
> +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>

Glad to see this overly long line shrink by a few characters, but we
need to shrink more or line wrap to bring it below the acceptable
width like 65-75 characters.  That is obviously not the reason why
we are losing "..." here, and outside the scope of this patch ;-).

> -Takes ranges of commits and replays them onto a new location. Leaves
> +Takes a range of commits and replays them onto a new location. Leaves

OK.

> @@ -55,11 +55,10 @@ which uses the target only as a starting point without updating it.
>  The default mode can be configured via the `replay.refAction` configuration variable.
>  
>  <revision-range>::
> +	Range of commits to replay; see "Specifying Ranges" in
> +	linkgit:git-rev-parse[1]. In `--advance <branch>` mode, the
> +	range should have a single tip, so that it's clear to which tip the
> +	advanced <branch> should point.

Good.

> diff --git a/builtin/replay.c b/builtin/replay.c
> index 6606a2c94b..e6d6d28239 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -366,7 +366,7 @@ int cmd_replay(int argc,
>  	const char *const replay_usage[] = {
>  		N_("(EXPERIMENTAL!) git replay "
>  		   "([--contained] --onto <newbase> | --advance <branch>) "
> -		   "[--ref-action[=<mode>]] <revision-range>..."),
> +		   "[--ref-action[=<mode>]] <revision-range>"),
>  		NULL
>  	};
>  	struct option replay_options[] = {
>
> base-commit: b31ab939fe8e3cbe8be48dddd1c6ac0265991f45

Thanks, will apply.
