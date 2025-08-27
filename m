Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDE227599
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 00:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253150; cv=none; b=sStfRuA0LNpUk9RfCOf1toYM5FKpcdm4k0keILIe0+I7bBHzU3rNDGIh+zCUK3krKjydHc92HUnFXw/K+q+E/ysBuiXQz7LOWzeHugrJfQNB/+anwH7PIO89cd6LkBoWr4LDVty39Kw67LOZqyZjIjw4z1cjV+wKNoZ4V7kooOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253150; c=relaxed/simple;
	bh=/MZxpmDpUj8OyyM1U4C8cmFyOXFAgaOImYynuBMwyJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mSPobGwJ2yITG95AIcehzID8/aKpK/oHRyvcqXI9yAvJFwho6LT3vYeckRFrXu+rlCz3sWqBLkea7j0V4OpyVw/19Ax6wcijiCP2D5EnfOIq5HYEMVrMiRxbTK48Wp5M8v9qoKoKz6LUaX2Rx2N4BGDrsmKAkgUDJM3zVUKFsg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iiYqVs7Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ogx7aqNb; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iiYqVs7Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ogx7aqNb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9205AEC0361;
	Tue, 26 Aug 2025 20:05:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 26 Aug 2025 20:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756253147; x=1756339547; bh=Nfy8JkWm+T
	GBCFuBJifl76uRf1qlwF0PY+DRdfQcX70=; b=iiYqVs7QqVgpFLenPXw0EvXN0C
	F/YjXcJXB69/sbVhHQe/TAZJw55kvxZ1o+x0o6Vte48ubVcLWbYK+iwVRFTTVXsu
	c3RsWNcWFfxw6stS9fwkAWTXWEAy+6EoVKcoo409L0XVSZQaCTjTH7UU8CSTzoCa
	2ppgpFd1fxL4L1k522dJ823W8PlwBjjRBGYjEmmyWKkG+FFXD7IGMDJnk1RqQmCh
	4mWp6NYiARCVBmpvKvVzuXBXLOzVn9y8iVisy9nUjz7f7UE5x0z3acabvsQUdX6/
	PYpcnW4g0b24qppjqUzmQZpboMtcgmj3DObL07CqKQQl06J8TrTGNcGnRILQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756253147; x=1756339547; bh=Nfy8JkWm+TGBCFuBJifl76uRf1qlwF0PY+D
	RdfQcX70=; b=Ogx7aqNbH2wdSft8jkWGO3zloH4dL14JQ03QydEBX4ZEvRfkqNx
	Ehum1PYNaNZYFbIKHH6hsVRoDC+S/oJZsNh8HAbllHNGFzLzh24RfYGVaCwqWchx
	nvcVEsbD07opbTjWIhu5EhOqJJX2HQ7Lqed+m5Ui0l2vAbuFy4va4Cs4w1YbriOz
	OFqvI1iKGCDsPpwpp1FVeq4MCPkmK9+AUgkGKrCt8KSiCcLI78GaUWjYMaoHzB4y
	WirAv/TH8FTZuPQMMw7MXq91NIeJcCarjrQsk/zB9hxpnBvvgXzufbYcapQuw4j2
	WUE+jmzGvgt8s39VTD/NoYHuMK9+touP0sg==
X-ME-Sender: <xms:20uuaJgTFOjaFvycUR4o52sSi4ffDULMHbFHdQ6vHbhn1tV5W4BaDA>
    <xme:20uuaIn1MCiWNRMRFSEjG7h0TRBEVzc8k3OU9F0eOnb9Hus1AKcTdGKKOCUwWb4cc
    jXVHk_v7TbtCfq8Ew>
X-ME-Received: <xmr:20uuaFqv3RrOKHh6GEjKYo7EmMwJbSNCKxB7VBTwzeKKVLUeEE_eLw3bW4StJHajZORkt20-ySnAAduGrgqyXrMopLY8ydMTB3UrZxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeiieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:20uuaBG7J_zGcdwJkKyB8Hh-qLtmTJIMwqTHt1HS2XXrZYsY9roH3Q>
    <xmx:20uuaBw6Po-ksJ_oST2rUvdf02bJwCww2-Gp7nf22NSW6DgmTA6jNg>
    <xmx:20uuaGr5bkfa32HfnezOz7dtW6-pQnHRUrdj0Sn2GUBxspL7vaiV0Q>
    <xmx:20uuaLhUOhMgj2zxyjkP9D1qnLB8lMNK3yfWSum3vQJsD0RHovBHcA>
    <xmx:20uuaKTRxe2PnnK5zmgFPO8uTO7pqWTK5-O7uJFUqjVGt2mOVvD7TGPv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 20:05:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 2/4] doc: git-push: clarify "where to push"
In-Reply-To: <36112c30bcf881f48c3de23dcae2b74e31d9a565.1756240823.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 26 Aug 2025 20:40:20
	+0000")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<36112c30bcf881f48c3de23dcae2b74e31d9a565.1756240823.git.gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 17:05:45 -0700
Message-ID: <xmqqcy8hfx2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
>
> Be clearer about what we're describing ("which repository" instead of
> "what to push"), and start with a positive "try X, then Y, then Z"
> instead of a negative ("if X is not specified..").

Since I like this simple rule so much, if it is generally applicable
everywhere, I'd like to have it or a variant of it in one of our
developer facing documentation as a tip to write better
documentation.


> Signed-off-by: Julia Evans <julia@jvns.ca>

There is some funny ordering problem with the commit log body and
sign-off.

> ---
>  Documentation/git-push.adoc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
> index e73b64f61fd0..5c934486c33d 100644
> --- a/Documentation/git-push.adoc
> +++ b/Documentation/git-push.adoc
> @@ -22,10 +22,10 @@ DESCRIPTION
>  Updates one or more branches, tags, or other references in a remote
>  repository from your local repository.
>  
> -When the command line does not specify where to push with the
> -`<repository>` argument, `branch.*.remote` configuration for the
> -current branch is consulted to determine where to push.  If the
> -configuration is missing, it defaults to 'origin'.
> +To decide which repository to push to, Git uses the `<repository>`
> +argument (for example `git push dev`), then if that's not specified the
> +`branch.*.remote` configuration for the current branch, and then defaults
> +to `origin`.

Very nicely done.

>  When the command line does not specify what to push with `<refspec>...`
>  arguments or `--all`, `--mirror`, `--tags` options, the command finds
