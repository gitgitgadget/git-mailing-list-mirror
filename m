Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D73A4AB2
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114245; cv=none; b=VZgBdp4FjVpKtizCvI+hrmnZSpmNyGpfVcszOyS9iKCr/TWr3XFkVp1FMPlc2cZiPvB2zILNjKQw3MnGESmJ8XSV9m94teBDVwJ/WB78Fxcmt6kTVTdIbvlD+eGaSrJBnaEsVmG3Ha+uQ8KP+4dBQWpL2e3/UH3ZpW4Sj2p3cGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114245; c=relaxed/simple;
	bh=c6SWmjheEIejd19Q3YoIuayiNEM/Uq3/bC2vBIwUEHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fi6XdHE9xw0wuKVT3zpC/bu3c+k5h6m/807+BN3Uiv9chnOX4ahz54eCKE2hzOs+noQFYEusoPZTJISmK4lAYWYIyNs1h/iuIM8GvyMi86fD5zObKz6+Y4diaATLrEcyMXJuNC3gvSaha5fvNm3hD0qzwJ8zVX6gYxn2/NVUNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=htXynMN7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xvhkxbp0; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="htXynMN7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xvhkxbp0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 246351400AF3;
	Thu, 22 Jan 2026 15:37:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 22 Jan 2026 15:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769114238; x=1769200638; bh=kyxVWqM3wY
	nKlzbWh7LGmI3X3/CYxb4OqIj0+93rg5U=; b=htXynMN7SXwBXQZGYB3QUUqi9p
	INiUvJJKHb4PcZnjp7mn4HGv59OF9R+0Y7V0dyp0eqq7HqTf3F8cvLvjfBvwfvrc
	bw9vhGQwXqsawh/H27vNA6HCO2QUl5L/8yoiKawpIEhgefpzmDQxwJRsaDbxe3Ik
	oB8Zp2P9JDXr6yVwnNOd7W3l7BcWoeBS2dKE1oB9O1TXp2sOUU+f6/yK6A6BnY3o
	QeQ0gCvXW+kVZHAwLpFznnXUrswTVXdyhmC7bgCDcjYM27f/TXhuABcFLCfBP2SR
	9Yx3tJxNzCvDQFCBBMhhj6b7m/iyT/Dx6incQaI7Oyh4qIb8UU9V++VvhKaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769114238; x=1769200638; bh=kyxVWqM3wYnKlzbWh7LGmI3X3/CYxb4OqIj
	0+93rg5U=; b=xvhkxbp0GJq4UrEArOYGA6h50RZWigPZgiF3U1PFW3ynGEUGmng
	OVePF9uOQcTUHDZOX7/4yVtaAwxWcWrtAoL25arKvSdQmwSwxozEUaXdJo0lx/bR
	joGitaB1BfBrquWTyAWrSDOHdqSAFxJSiwCHYHAk0EsDegxT1VDZ7FecLvWuJhGl
	TmShPFeoF6+kzIo6aCY1EeiW0tvI7jCEafV6DiXn0O+AULtZTboyEZcg5GN0VQMI
	lmxKEdJBDtTwFAE+b95erA2Yrc0suYkHel4+iIc9X2Xmon5NkD5+vquRk/75y18D
	uzNzuCGYQXZyUfdHsilDbonuoZqYkK9zLgQ==
X-ME-Sender: <xms:fopyaWjTqhL20nB3Ye87ZRQCluZaZTd7TtkbA_KE-uO3WOSJFEckVQ>
    <xme:fopyaeAzuuMNlTc3ARR1QSJ2lObgKHustVjVAvTxWJsvQ7HKj1rjyjdVQCTDHFi2-
    c1elzW0Bxr7FmBqf_e292vZ84B2MU4lj7VP3nqlMrJA8j42sV7gDqs>
X-ME-Received: <xmr:fopyaTFkTcGYsfmLPzqlqbhjpAIyhhzkVJVxd31d0Gprot8yTxH6mWwBpeZaMcnOZNyoU64pVQiVjl1lP1RAWJdqPHQ9RJPB6UAqLp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fopyaeK8Q4rVxSvKypiMGC4k9qdAJu7ayEYrMvaKdqcb-iSaMK97cg>
    <xmx:fopyafmtI4RSrc8XvvJQ2CVoD_YUCpXjKpZJW9JbsX-vljcXv_BwyQ>
    <xmx:fopyaeQWoe_-ZVrCTA-YBoEMic0S4rD0SjSXnEIeVUdrkkTbofyExw>
    <xmx:fopyaZKqQhwAzLznhPR8TsAIyNA1EhyOZyjGUoMoDP0Fa82coWoq9g>
    <xmx:fopyaalRNPjz4KtooqGjyYWzRk35z2FLqD7NR8hvxAjf8fCHiqw-bQGW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 15:37:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <0993420fc1185ec4a907a8c3bb52ca965e720c54.1769096240.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 22 Jan 2026
	15:37:20 +0000")
References: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
	<pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
	<0993420fc1185ec4a907a8c3bb52ca965e720c54.1769096240.git.gitgitgadget@gmail.com>
Date: Thu, 22 Jan 2026 12:37:16 -0800
Message-ID: <xmqq5x8tmlj7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/remote.c b/remote.c
> index fd592ec659..e256cc9b81 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -29,6 +29,12 @@
>  
>  enum map_direction { FROM_SRC, FROM_DST };
>  
> +enum {
> +	ENABLE_ADVICE_PULL       = (1 << 0),
> +	ENABLE_ADVICE_PUSH       = (1 << 1),
> +	ENABLE_ADVICE_DIVERGENCE = (1 << 2),
> +};
> +
>  struct counted_string {
>  	size_t len;
>  	const char *s;
> @@ -2230,13 +2236,53 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
>  	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
>  }
>  
> +static char *resolve_compare_branch(struct branch *branch, const char *name)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *resolved = NULL;
> +	char *ret;
> +
> +	if (!branch || !name)
> +		return NULL;
> +
> +	if (!strcasecmp(name, "@{upstream}") || !strcasecmp(name, "@{u}"))
> +		resolved = branch_get_upstream(branch, NULL);
> +	else if (!strcasecmp(name, "@{push}"))
> +		resolved = branch_get_push(branch, NULL);

OK.  Usually @{upstream} without anything before the at-sign means
the upstream of the current branch, but we need to force pretend
that branch were the current branch, so we'd need to special case
like this, which looks reasonable.

> +	if (resolved)
> +		return xstrdup(resolved);
> +
> +	strbuf_addf(&buf, "refs/remotes/%s", name);
> +	resolved = refs_resolve_ref_unsafe(
> +		get_main_ref_store(the_repository),
> +		buf.buf,
> +		RESOLVE_REF_READING,
> +		NULL, NULL);
> +	if (resolved) {
> +		ret = xstrdup(resolved);
> +		strbuf_release(&buf);
> +		return ret;
> +	}

It would be handy to be able to say "origin/master" (or even just
"origin", which is interpreted as "origin/HEAD" via the DWIM
machinery) and prepending of "refs/remotes/" above does help such
DWIMmery, but I wonder if it is too limiting?  Would there be
situations where you would want to compare with something outside
refs/remotes/ hierarchy?  

For example, writing "v2.52.0" there to see how far we came since
the last release would become impossible if we always force prepend
"refs/remotes/".  I wonder if we can reuse already existing DWIMmery
that uses refs.c::ref_rev_parse_rules[], which should allow such use
case, while still allowing you to write "origin/master"?
