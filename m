Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A903EDADB
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028700; cv=none; b=giQrLXJgAg31pfo5pxseDqXo+Iu6awWVSIgKNbv5JmN0Vv72Je9/4tNTCm52MCzQ3vRQgvk5TCVDmcpWlUG+6yAiF8YoBrnzxdHAsAajcwJhmXX4hj2TAxRmI/sEaHxvinCykNp+ce/YuhADPQi0Y9cmo5GE4FlvBwc5GzPpOvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028700; c=relaxed/simple;
	bh=gdSKK9YI2K8ikCHxZCV7q0QRlJz2I2nLT0KS6GJeMho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VvSabJGvHzqyRgHUBI5KAXz/lo4dpWk2EwyS4CqYz++jN0DfZCnTGlJxU1tNfQIGLas9+mL+eWaXMN7T1Bvp5jdTwwJvpzwfvcxztmF4MsEXe8ZiXE9PjjkqkjGffkSm1mkqXlHhBUxXz8hOJ2/lzfgymBziZzLGF5G9l5HEO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QzKsRDnC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Byp00M1w; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QzKsRDnC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Byp00M1w"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 949DC7A00EA;
	Wed, 21 Jan 2026 15:51:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 15:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769028696; x=1769115096; bh=wOl3RHr0Wc
	VZrPQfM07ldRX+ny2Dqh5BGxX6Uz8tW3w=; b=QzKsRDnCEwxgyl32H1RRrlz5tE
	DncbhY6hEb8iUv+5iqbGyRE/FuIayUNREixYra0g1MoX+WP5MUzPNJc2meUJCsk4
	yqJVApFdveMO0m6OSCM8LlDMwzKSdh19U9F14VyhlOInuITtFAU51X4+STWGJcpY
	hfUmPuvgZ0q2puXL9scTERL6eN2ZOXyy49jzQUnvGZFN3P9VuaxWEAKKRkNa9PjU
	iFnoTLUOM8qGMDNZDf2rQZohd/FmfPVuluG8xR5lueWqafL1nQ2wifTKvO0ZmqBA
	L3njPqVQq35nTir8A1BGAmIwUVUp1bSoGm40zJiSYgHrOw/WV0QLgPM5GaPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769028696; x=1769115096; bh=wOl3RHr0WcVZrPQfM07ldRX+ny2Dqh5BGxX
	6Uz8tW3w=; b=Byp00M1w2z3LL2YJr1Y0UdFBlI2HzptGBg3C1pJwWYIIcw7Mk0S
	uXQurmqTRJr261xBllq9q9F2L7hB5jiPPsUpLPHjmZ7gcwDPAWbSaZjRID6PiYJe
	uKG9io53IEx+A1L6XKOeHYC9aGUL14GqCkkGZDwFNReIyUHUlphNT7ZeQYiR1RQv
	/nmF1H+tn64bKFOs6S629KCrln+VDPFYAqPFs/KXkq4KJbS9DGlNrM1P42ncz58H
	6tQTGZw+dNw3Jqq4oMWsXBowilWQFjn8BJQp7A6f/+u5esiSNy2aw8u5EHN6ht0L
	TfOmj6YcLuofrRt9vnVcdQQp9qZFTEc6+tA==
X-ME-Sender: <xms:WDxxaRcnFRj_cT6RMTz9_fcltwAB613UlVDGMZ6vTzSwStGGPsBKog>
    <xme:WDxxaWMPg6DIloDMpaxsFUhPCsOj2ZywyakkSUADtmt7xcq1NvqSY9cVgNc43Ya24
    uiHJ8afulm62i65KzqDf-cGGzAogT92Hd0E91tOOKpdsvXjsACg>
X-ME-Received: <xmr:WDxxafiMzo7rRiaXXybI9l92Gsd5TNtt0eePJjpGRF-1yTCHVuG1Ht_LNQ16Yp3zSM_RsL11bEVZd9J0zU0SQ9mfvxR2Ujv-pA-JSD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihtghhihhnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:WDxxaZ3jWD7mn7jXaDnVIMdnoUOQWgZZtTXXa1gzLKBSQ-Ak72JiNQ>
    <xmx:WDxxaZgtVRCgZOAtbywPdmmiQorw_rI8CEUOJ4asbUWUKJsVuJNGvA>
    <xmx:WDxxaZdH8aGUQ4wmb-dbBlZqRI_kR6yaBnnvHMt9g-wT1sYTcc6s9w>
    <xmx:WDxxack4LDMLMFZYGP6jHjoIFn1mLO8c_0-WBgyUfbqVuAfKYBEDDQ>
    <xmx:WDxxaTCZTnDUxKX3RImgXLt_TH4ZBCzeJva5kNUBzJnjDONp5wR6iE53>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 15:51:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using
 histogram algorithm
In-Reply-To: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com> (Yee
	Cheng Chin via GitGitGadget's message of "Sat, 06 Dec 2025 20:51:27
	+0000")
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
Date: Wed, 21 Jan 2026 12:51:34 -0800
Message-ID: <xmqqikcusn8p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When using Myer's diff, the algorithm finds that only the "x" has been
> changed, and produces a final diff result (these are line diffs, but
> using word-diff syntax for ease of presentation):
>
>         A A[-A-]{+x+}A AAA

And patience gives the same result; as you noted, it uses a unique
line as the anchoring point.

> When using histogram diff, the algorithm first discovers the LCS "A
> AAA", which it uses as anchor, then produces an intermediate diff:
>
>         {+A Ax+}A AAA[- AAA-].
>
> This is a longer diff than Myer's, but it's still self-consistent.
> However, the compaction phase attempts to shift the first file's diff
> group upwards (note that this shift crosses the anchor that histogram
> had used), leading to the final results for histogram diff:
>
>         [-A AA-]{+A Ax+}A AAA
>
> This is a technically correct patch but looks clearly redundant to a
> human as the first 3 lines should not be in the diff.

So true.

> The fix would detect that a shift has caused matching to a new group,
> and re-diff the "A AA" and "A Ax" parts, which results in "A A"
> correctly re-marked as unchanged. This creates the now correct histogram
> diff:
>
>         A A[-A-]{+x+}A AAA

OK.

> This issue is rare in a normal repository. Below is a table of
> repositories (`git log --no-merges -p --histogram -1000`), showing how
> many times a re-diff was done and how many times it resulted in finding
> matching lines (therefore addressing this issue) with the fix. In
> general it is fewer than 1% of diff's that exhibit this offending
> behavior:

In other words, without the fix, we'd see 1% or so commits with
suboptimal (or "funny looking") diff that will trigger bug reports,
which sounds like an unacceptably high failure rate.

> @@ -915,6 +919,45 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  			}
>  		}
>  
> +		/*
> +		 * If this has a matching group from the other file, it could
> +		 * either be the original match from the diff algorithm, or
> +		 * arrived at by shifting and joining groups. When it's the
> +		 * latter, it's possible for the two newly joined sides to have
> +		 * matching lines. Re-diff the group to mark these matching
> +		 * lines as unchanged and remove from the diff output.
> +		 *
> +		 * Only do this for histogram diff as its LCS algorithm makes
> +		 * this scenario possible. In contrast, patience diff finds LCS
> +		 * of unique lines that groups cannot be shifted across.
> +		 * Myer's diff (standalone or used as fall-back in patience
> +		 * diff) already finds minimal edits so it is not possible for
> +		 * shifted groups to result in a smaller diff. (Without
> +		 * XDF_NEED_MINIMAL, Myer's isn't technically guaranteed to be
> +		 * minimal, but it should be so most of the time)
> +		 */
> +		if (end_matching_other != -1 &&
> +				XDF_DIFF_ALG(flags) == XDF_HISTOGRAM_DIFF &&
> +				(g.start != g_orig.start ||
> +				 g.end != g_orig.end ||
> +				 go.start != go_orig.start ||
> +				 go.end != go_orig.end)) {

So the idea is to remember the original values in g and go (the
location of the group in the file and the other file) and if
shifting up and down changed any one of the four ends from the
original locations, we always take the fall-back route (if we are
doing histogram)?

By the way, this appears after the if/else if/ cascade that has:

	if (g.end == earliest_end) {
		... do nothing case (case #1)
	} else if (end_matching_other != -1) {
		... do the slide-up thing (case #2)
	} else if (flags & XDF_INDENT_HEIRISTIC) {
		... do the indent heuristic thing (case #3)
	}

Am I reading the code correctly that, even though this new block
appears as if it is a post-clean-up phase that is independent from
which one of the three choices are taken in the previous if/elseif
cascade, it only is relevant to the second case?  I am wondering if
it would make it easier to follow if the new code were made into a
small helper function that is called from the (case #2) arm of the
existing if/else if cascade.

Thanks.


> +			xpparam_t xpp;
> +			xdfenv_t xe;
> +
> +			memset(&xpp, 0, sizeof(xpp));
> +			xpp.flags = flags & ~XDF_DIFF_ALGORITHM_MASK;
> +
> +			memcpy(&xe.xdf1, xdf, sizeof(xdfile_t));
> +			memcpy(&xe.xdf2, xdfo, sizeof(xdfile_t));
> +
> +			if (xdl_fall_back_diff(&xe, &xpp,
> +					       g.start + 1, g.end - g.start,
> +					       go.start + 1, go.end - go.start)) {
> +				return -1;
> +			}
> +		}
> +
>  	next:
>  		/* Move past the just-processed group: */
>  		if (group_next(xdf, &g))
>
> base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
