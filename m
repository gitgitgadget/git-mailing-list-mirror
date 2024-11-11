Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055B191
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 01:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731289604; cv=none; b=H5yO3wErscZYI4Cqm7nMmE9DSjWy0bMKocMjp8j/ztJ8Q5Z+Zz16JPJJuu7SVJoY3YGJ8+Aez4bLwWLrlk+uhyVw0V/VlgdsSyRp+wIFdTyk2UEvlXWiymYnYWYQ3S+f0PEHA0VjK6Jx5iv0WgA0AMjHxZaP/t2+y6pItYtA3x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731289604; c=relaxed/simple;
	bh=pcls5a/vpOPEU+K2++qMmDCtiQX81b6eZQZtlC6gQyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sz+MoVp93XMKtB+TyhJTZ6RV9eHYbLY+XnJClbSz7hOyUvB9q56oEm9wcI+V8UnPeoKvioWeU1c0Ai/DhrGLEXfSpFAtWzDL6MNnGD2nrXMR+SxcvfebAnqaCy0MKGmEpLO0R46Qkxk5TRHizwJHsMRGxO7HjElExEgsAPIdCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O04o+h9N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UJGrchg4; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O04o+h9N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UJGrchg4"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 651922540111;
	Sun, 10 Nov 2024 20:46:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 10 Nov 2024 20:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731289600; x=1731376000; bh=FCaL7QQfah
	IeS3ZUJPo5VCVporNeJcqURU3wFXjAbxM=; b=O04o+h9NtQsDVSYmJXBgaxkdSz
	PKipi3xo7e+KPYAuzzjLtEck9L9t2jbavWABVaqx3edAwheVYYaK2ieqsidr3vqR
	XEhq0zMIx3OS6rgmYiyucuaF7Vy6EjU3GzhVyu1LOfUuStUOn8ERdUmKJinMcAvI
	L+cgRpu7XTcaohJc4AM81dC82J82N7pZ91wpINmXqa119Ds/jjWltKxTq9yFMBXk
	oIk6s7rhHtw3GBxbgFItNXgr7cnzyWeMEgsbvW3FhW4vJyuboHzSu3hF9MBtVOxP
	8WG4Ucti9p8HBQCNv7u2B991t92xAl9Za1PDLIeqKHpdjw8kXR1l1EAZcNAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731289600; x=1731376000; bh=FCaL7QQfahIeS3ZUJPo5VCVporNeJcqURU3
	wFXjAbxM=; b=UJGrchg4qYRgjN8q4fum+09lGYoh2tqHc889oEacqfhHJHtL1/o
	42K1nXV45MZo8dfPniERXnUHZ9TgUziRNVK4u0sRRsllqbtTJvk97wFoHRwL+WSv
	JJta0n98Dzzx8zdQwuXJZuI7r9uP58PkXTgmYExGPF0vCoUzubAAWvgv9RDkun4H
	eWt6TrsZMIc/4kx0IjHzAkoJ03zR2Q+erfzA0jIcnt4S+cjl6cR0iOTcXbBjVm0H
	7hFNJS0wn/aIC6N6hAveLKfPV/NreLH0PlujCk3GyJgf11RWiImG0rTQ2v2Y/STH
	RFllSO+bh4nYf/LZyu2FDNApAL/MpHvE0TA==
X-ME-Sender: <xms:_2ExZ40fiJzWth31_tvSxYzT1VP9u3phh1C235MOeTrv3XFo8OlS_g>
    <xme:_2ExZzE5QJYW0r-hWtizUNnwP3k1TeB8tZMKpGLDN1ZZVpvgzB1Kcoj2RyWwTRgvq
    qld6CLT7ePjhtnR5Q>
X-ME-Received: <xmr:_2ExZw64RtusMpnjnTUZFX935KALsIYu0uEdW9-Ak1uHSJCgJ9COXj3U4bkIzC7mTMa7yiaHgNLAxdq8qGgF48S2825HHa6MULeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:_2ExZx1eRPwz6Xkaw40JO1ZvpdSpDXxTiOgF3KY3oqeYpOzTJ_v10g>
    <xmx:AGIxZ7Hkqfo-FvgYSVcDyU41bN3AsVhSCbLOIroHQSTXB6BMwZiT8Q>
    <xmx:AGIxZ68B4C_E5PaNyYIppYs71A6D2E7_LAr0PB019yxWYJyXHezBBg>
    <xmx:AGIxZwmD1WWmNs12hDKdHcJqp1q-5laMQJPjG-ySfma0PAeEO2dfRA>
    <xmx:AGIxZ61xXuNvJCadB2WRK90Kb5ESKB-I5iCdm_MgXHm63pnXIXGiv3pJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 20:46:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Elijah Newren
 <newren@gmail.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] log: --remerge-diff needs to keep around commit parents
In-Reply-To: <pull.1825.git.1731073435641.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 08 Nov 2024 13:43:55
	+0000")
References: <pull.1825.git.1731073435641.gitgitgadget@gmail.com>
Date: Mon, 11 Nov 2024 10:46:38 +0900
Message-ID: <xmqq7c9ak0e9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> To show a remerge diff, the merge needs to be recreated. For that to
> work, the merge base(s) need to be found, which means that the commits'
> parents have to be traversed until common ancestors are found (if any).
>
> However, one optimization that hails all the way back to
> cb115748ec0d (Some more memory leak avoidance, 2006-06-17) is to release
> the commit's list of parents immediately after showing it. This can break
> the merge base computation.

> Note that it matters more clearly when traversing the commits in
> reverse: In that instance, if a parent of a merge commit has been shown
> as part of the `git log` command, by the time the merge commit's diff
> needs to be computed, that parent commit's list of parent commits will
> have been set to `NULL` and as a result no merge base will be found.

Ouch.

I am curious about "more clearly" in the above, though.  Do we also
lose parents before a base can be computed during a forward
traversal?  Unlike the reflog walk, we won't show the same commit
twice, so unless we are traversing some of the history of our
parents *and* showing these ancestors found there _before_ we need
to show the merge in question, I do not think the issue would
surface during a forward traversal.  So the problematic case is when
we are not doing topological display, and traversing down to a
commit with skewed timestamp causes it to be shown (and lose its
parents due to memory optimization) because it appears much newer
than our merge, and there is an ancestry chain leading to it that
passes commits other than our merge, or something?

> Let's fix this by special-casing the `remerge_diff` mode, similar to
> what we did with reflogs in f35650dff6a4 (log: do not free parents when
> walking reflog, 2017-07-07).

OK.

> diff --git a/builtin/log.c b/builtin/log.c
> index c0a8bb95e98..a297c6caf59 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -522,7 +522,7 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
>  			 * but we didn't actually show the commit.
>  			 */
>  			rev->max_count++;
> -		if (!rev->reflog_info) {
> +		if (!rev->reflog_info && !rev->remerge_diff) {
>  			/*
>  			 * We may show a given commit multiple times when
>  			 * walking the reflogs.

OK, that's trivial ;-)

> diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
> index 07323ebafe0..a68c6bfa036 100755
> --- a/t/t4069-remerge-diff.sh
> +++ b/t/t4069-remerge-diff.sh
> @@ -317,4 +317,11 @@ test_expect_success 'remerge-diff turns off history simplification' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'remerge-diff with --reverse' '
> +	git log -1 --remerge-diff --oneline ab_resolution^ >expect &&
> +	git log -1 --remerge-diff --oneline ab_resolution >>expect &&
> +	git log -2 --remerge-diff --oneline ab_resolution --reverse >actual &&
> +	test_cmp expect actual
> +'

This is the trivially reproducible "show in reverse" case.  Nice
finding.

Will queue.
