Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303D1DFDAB
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930492; cv=none; b=mJbStkOP1QaU9bL9zLD82Heq5NFH7tSBESaxXiiBwsHIBoABdJrKsFm5QW5EiEd9a1y07ulZodYJzAjCxZzIAFs02tuzbtGZkDhq7W0s7/hmhvF6fPrJ79qtfQN6bYfHVh8WldIlKw9LN/joU/84HyCMdMlcplSfmVcM71lTq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930492; c=relaxed/simple;
	bh=FYDVkKoz4LvMpv9UcbUEr3MJqhcyALTaWus05mBKTz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UZsKNC36372B++rvJ42P4G9rHX9DWk+9qMk59PREM4FRhVXaiGGHqRlWKtBWmvJY0UgBh6RFwGDSCw7TCAsal8TOvKtS2E4ClKjIqWansuIvpWWvMSp/CsQVuQ9tW4+bv6DIF98oxzJASVOhcuXTxZvxRkmSe4wLAGWAaX4AKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QELRIBnd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nmbmykb2; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QELRIBnd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nmbmykb2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AA6211D00085;
	Mon, 11 Aug 2025 12:41:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 11 Aug 2025 12:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754930487;
	 x=1755016887; bh=vy02vIzTSjZur2w/d8hkLwimzr/09z3V8dt47mdGr0Q=; b=
	QELRIBnd+AOkEbaRJWY5Rc4fFSLK6kz1H17rqQASYb1ho5Y9D6tE46DA/o0EEVpg
	sQGn6ybCpvCKXV1tNTJw2vd7fUbaCDSKGM9Gs/hvzP/NxvGhwXv5aatumlJJ6UEY
	LoTzdZ32ID2Z/PZ4+oU/rP0A7K+q3PZ03U1mIx21J0PMS7rLlpbLd84kTCuRQGdk
	jV/1JIB/ipitTu9oq5x0ghALLPnymlWTbbn4CLS0qk9j/mbA6B7Xg7y84Nt91iNA
	k2Hq6Ck3fHLceSpOEsoEqBZpueeSDoIyVebO0qZ2EUDipKnSTehfr8ocJDpdZDmv
	4rtjxEVH/4moR+3hm64rSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754930487; x=
	1755016887; bh=vy02vIzTSjZur2w/d8hkLwimzr/09z3V8dt47mdGr0Q=; b=n
	mbmykb2FZWYUL5+wmbLO8jWJI3++LzriZPuudBaWwgzd2sGb8Z9hPv0u+8rfyqR2
	nW9QCauL0exN3bDxEWk+SEqp0pfOvUwi0dAj5JytGVYXdg31tOq0uJju2kVsogxz
	oKcWMMTg3Xe6+7o5Ukf7joSL4MSc4xFawVuTbjsXC8ekLJvfn6oOlolUQi1a9+9N
	/CxwN/VE2XOFskCP3rI3WQJc0kw+KUub5Xop2s/Q63e/hLnj67nAytbLLEFHIePC
	OHay4HtzUqmwtYpcsq2hVKd13KAmKAUBS7hN4CkN+rI7DOgXjXhSjxa23m1gZCyr
	UC5eX1G8SnwvQIbvtKt8w==
X-ME-Sender: <xms:Nx2aaGU4D6xR5geQAi0bAhMQiskjootxEgM4jcJCvyGN14cekyQjsQ>
    <xme:Nx2aaOFTVCXNG9ZVGQhjiyksERoYD1mFyTWtMya1pSGQT_un8lRMxjfci4TP5lGbV
    xAZaJYdJVZGZj3fYg>
X-ME-Received: <xmr:Nx2aaA0HUZ99GYLqhLkfqWQmsZWHnppU40RMqj1QCB2hSNrJz0AY9Y-XlUst_rgwFlVNFJUykVRZqRTPgOK7nmX85ZBqM-1RfYHR4t4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeggefhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteej
    ieeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhhsthgrvhhordhvvghlrghstg
    hohhesghhmrghilhdrtghomhdprhgtphhtthhopehguhhsthgrvhhordhvvghlrghstgho
    qdhhvghrnhgrnhguvgiisehnvghtrghpphdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Nx2aaINr55wpqVd6jWTK8pBLuFJ-ApPpVbRi3mRYSjjnIcN2VWrqhA>
    <xmx:Nx2aaH7S4HMyaBd6H2V-JoWrR2aKfap96eHp9XVwhUSKRgwnKVsyDg>
    <xmx:Nx2aaK0bOPpHWc7ceEzR1Sn0sdqXQszwWnj7Kgsi3ML0bFvxmedTCw>
    <xmx:Nx2aaAx4rnO80wiH_TPTFmcbyaBD1wP2UnlaLIZwLZwy4zj9R4_N_w>
    <xmx:Nx2aaIvAWzoMd0KCJCHzNQAQYXBnCC40Qxq83ZZi2ivsQkliTuwAthT->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 12:41:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Gustavo_Velasco-Hern=C3=A1ndez_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Gustavo =?utf-8?Q?Velasco-Hern=C3=A1ndez?=
 <gustavo.velascoh@gmail.com>,  "Velasco-Hernandez, Gustavo"
 <Gustavo.Velasco-Hernandez@netapp.com>
Subject: Re: [PATCH] docs: update description for '--mirror' option for 'git
 push'
In-Reply-To: <pull.2028.git.git.1754922884439.gitgitgadget@gmail.com>
	("Gustavo =?utf-8?Q?Velasco-Hern=C3=A1ndez?= via GitGitGadget"'s message of
 "Mon, 11
	Aug 2025 14:34:44 +0000")
References: <pull.2028.git.git.1754922884439.gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 09:41:25 -0700
Message-ID: <xmqqcy913j62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Gustavo Velasco-Hernández via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> From: "Velasco-Hernandez, Gustavo" <Gustavo.Velasco-Hernandez@netapp.com>
>
> The current description considers only created, updated or deleted refs
> locally. However it does not address the case where new refs were created
> on the remote end, in which case, are also deleted.

Correct, but "they added, we didn't do anything" is a mere special
case of "what we have and they have do not match" and
indistinguishable from "they updated, we removed" for example.

And there is not much point trying to be exhaustive after saying
"... be mirrored to the remote repository."  If we are to improve
the test, we should think about rewriting the whole sentence
starting from "Newly created ...".  After all, they are giving mere
examples and cannot be exhaustive (think: which one of these existing
examples cover "we created, they created differently---their value
goes away and ours win" case).

    ... be mirrored to the remote repository.  This overwrites the
    refs at the remote by (1) removing what is only at the remote,
    (2) force-updating what both ends of the connection have, and
    (3) adding what only exists locally.  This is the default ...

or something, perhaps?

Thanks.

>
> Signed-off-by: Gustavo Velasco-Hernandez <gustavo.velascoh@gmail.com>
> ---
>     Docs: Update description for '--mirror' option for 'git push'
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2028%2Fgustavovelascoh%2Fgit-push-update-docs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2028/gustavovelascoh/git-push-update-docs-v1
> Pull-Request: https://github.com/git/git/pull/2028
>
>  Documentation/git-push.adoc | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
> index d1978650d60..9d543f823de 100644
> --- a/Documentation/git-push.adoc
> +++ b/Documentation/git-push.adoc
> @@ -166,9 +166,10 @@ already exists on the remote side.
>  	be mirrored to the remote repository.  Newly created local
>  	refs will be pushed to the remote end, locally updated refs
>  	will be force updated on the remote end, and deleted refs
> -	will be removed from the remote end.  This is the default
> -	if the configuration option `remote.<remote>.mirror` is
> -	set.
> +	will be removed from the remote end. Any ref existing
> +	in the remote end, but not locally, will be removed too.
> +	This is the default if the configuration option
> +	`remote.<remote>.mirror` is set.
>  
>  -n::
>  --dry-run::
>
> base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
