Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561E23C4F1
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311271; cv=none; b=Wep0dvmZRPTVUwgEJTLp9uJqLRocYCFF1hLMMLfe1xpSiuO6MHsb7wNmE+7pbk9FZ2Gs529f1j1YZUCHSO+z7lHU7PKooJWabP1LN/209i/y+5RQm3vq2yoQDVUQLovy7BQyZEVusWtlPvzzsTyV9cAaT715N/ejwadp2STMFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311271; c=relaxed/simple;
	bh=v+6A95RvkXiyJd3MzAqkuWHCj2y1AtLq1CxhnVZONA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ou+KyjG1R+iMIUAcPawNY1yGg+Rtn97sLs77XSdHlpvi+jEJsEv/FX+jzq4bbJfWujK7zMUNUuQ/OYk1rCFPR+qpDkL9BkTm8y8B8e3T+sXiES+O5eBnBZU9fLXTEzxfjhtMCbr36uE+Wl2pCFr/Q6XPtZBcHeUsRrfPkwHuDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rzxdn+WP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OMy/r2lR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rzxdn+WP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OMy/r2lR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8224E1400156;
	Wed, 27 Aug 2025 12:14:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 27 Aug 2025 12:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756311267; x=1756397667; bh=l6mwFRMHut
	uOzMctONR4mfaMgVX5dpgeJsBf8Khpkl0=; b=rzxdn+WPGri+o7JQAJRXzrg55A
	SGp/d3mwhG2Sl5LAw/OD8zBtGrf1M5amMmuSUmfpeYWDxVVmygVA/7E2JBgneCQK
	swKDiMGi+F5NQVp8UYYVTx6Bwh4PWWmjVA/CLWQYrclKrPeZjGh2uJMwZpYLvo51
	opzZP7ntzgpKuDpzpPHlSOXwTL90ShRV2R+MYnhYes3aaZnzqJ0h9gQD6y+fzOXu
	lZfjcVlm6BuypoF60pij/uSmChMw+LLWMoFCS09zV1V7fAfaZr/y1/IC60d0SAGD
	voxLKMVJj/uRWUqMCEG/XdQExkmOrtP2SE4K/kiv26qRiKu9xUqQUYShY9Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756311267; x=1756397667; bh=l6mwFRMHutuOzMctONR4mfaMgVX5dpgeJsB
	f8Khpkl0=; b=OMy/r2lRoqniDEDLV1x3ZBb/h1yWaQ4eOfKfEXfFW/Kk0nxsTcZ
	bGhVcfqffmvYrr4z5YwdLxN/7a/F9aRcxd4SgJcm4oQpZshQjw92M6SJrFypMD7y
	12ouK3W1JeDMMqtjn2Wc4q1LqiZJgOwQs6CvFzhSYbKGhUCRzd4MAAReYQtgw9k7
	AWMrviuS3CdT7hrqX8QQHIBSkJqxhVUsG0agNc0cobLditkWpDhP9m8uVwNCTy28
	oIww798mBddoRVx/WLrhM8WdULldXmgu/xgN6DfAr9avVGjx8y7L77aO97s83NBj
	pyj3tzXkk1fpeebN7NTQns/MSGpkZ3Hh5JA==
X-ME-Sender: <xms:4y6vaJs4ZU-4hx-bNC-kO8ULZl2srYOMUfFhBQk6Z-eZWlxQnqQt4w>
    <xme:4y6vaPkY7ox_Z1bynrUZW4310Ih9dchLDQ1Y5iYhaR5MwP1MaIs5MLCV4FJE4iNgK
    tPyGFNweKhSNqJjqw>
X-ME-Received: <xmr:4y6vaLyxWOPJsAoubRhEw56VHn75UlT58FhBFNTV6wwdNFFTStRQB9RdzjBG_39uUHGgkk6YpPBbBwdXgCyCWzB92WJsqMKHLq8ULo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhgvfiesrghjrdhiugdrrghupdhrtghpthhtohepvghmihhlhihshhgrfhhfvg
    hrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:4y6vaBPd-7N_lGbDRL4IJNCeFay_Zlvzi4y7ZyEvl6s622gHHEZePg>
    <xmx:4y6vaHp00SlfgUwhfsUWdRU4-OjMuMw9uS6in1bUjAfCHJVkL5y50Q>
    <xmx:4y6vaKGOD3IwlxeKbAyO5EJrqbqvuuUGsbCLEl_G1fOeWcWKn0zWNA>
    <xmx:4y6vaErQHYko-w47H_BM5fe_3WU5lDLXtdsmOJN-bCBT-UUNH-tnaA>
    <xmx:4y6vaEahL1IzZTd1vZWHypw-hfkMrCegHm8VkQkg3ZyT9duel1EEMfQW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 12:14:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Andrew Jeffrey <andrew@aj.id.au>,  Emily Shaffer
 <emilyshaffer@google.com>
Subject: Re: [PATCH v2] doc: document rev-list opts in revert, cherry-pick
In-Reply-To: <pull.2042.v2.git.git.1756279345929.gitgitgadget@gmail.com>
	(Emily Shaffer via GitGitGadget's message of "Wed, 27 Aug 2025
	07:22:25 +0000")
References: <pull.2042.git.git.1756279041881.gitgitgadget@gmail.com>
	<pull.2042.v2.git.git.1756279345929.gitgitgadget@gmail.com>
Date: Wed, 27 Aug 2025 09:14:25 -0700
Message-ID: <xmqqjz2o3foe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> In f873a273d1 (revert: accept arbitrary rev-list options, 2010-06-14),
> we added a handful of new options to `git revert` and `git cherry-pick`,
> but did not document them except by example to `cherry-pick` only. We
> have a nice shorthand for adding the rev-list documentation, so let's
> add it now, to both commands.

That's a blast from the past.

> diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
> index 42b41923d5f..03848aa9f21 100644
> --- a/Documentation/git-cherry-pick.adoc
> +++ b/Documentation/git-cherry-pick.adoc
> @@ -174,6 +174,8 @@ fail unless one of `--empty=keep` or `--allow-empty` are specified.
>  
>  include::rerere-options.adoc[]
>  
> +include::rev-list-options.adoc[]
> +

Are there options that rev-list family of commands take that are
nonsense in the context of cherry-pick (and revert)?

The rev-list-options.adoc[] file is designed to be included from
different places, so for example it omits certain things from
appearing in the output.  E.g., by doing things like:

    `--ignore-missing`::
            Upon seeing an invalid object name in the input, pretend as if
            the bad input was not given.

    ifndef::git-rev-list[]
    `--bisect`::
            Pretend as if the bad bisection ref `refs/bisect/bad`
            was listed and as if it was followed by `--not` and the good
            bisection refs `refs/bisect/good-*` on the command
            line.
    endif::git-rev-list[]

and not doing

    :git-rev-list: 1
    include::rev-list-options.adoc[]

we can exclude specific parts of the rev-list-options.adoc from
inclusion.

I know that the implementation took a blind^Wstupid route to allow
everything, but documenting them for unsuspecting general public
would make the harm larger.  They wouldn't have even imagined to
type

    git cherry-pick --graph master

if they weren't told that the command took such a nonsense option.
Have you reviewed what is in rev-list-options.adoc and thought about
excluding certain parts when the file is included in either
git-cherry-pick.adoc or git-revert.adoc?
