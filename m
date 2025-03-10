Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C31B3927
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627707; cv=none; b=rVMtv4H2pwIYjKJjsIfXOS1GVQl7V7PuOYPCjZo3H6YKiHCFud0WBjvkfqbuRuj/yIbtx5I4Mgslyos/+A4+rHPU/ppvl22fn1iCU/ZGoKCTha3gNGcIilYvwxnfA92gvbuyXucL6AZN32BEZNrnuCXDw+D60Eydbg7vw3P6mwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627707; c=relaxed/simple;
	bh=YQSo/ei9Jr29mwJabnm4r4SRDrIAOYtZldVBiTUu8Jk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B3TAbzRR77HxZQ3SfOjyjDoFLf5a4k0uECgUEdZGeg59TB6tYPXBCuXhVioqel0GYQ6hDJojchv2HfMhV4rAQhvfXMtTBsWO40SVjbbedHCUdFu13ef7L73h8Cg90G7yTbwN92qfjh/paoy3EJgkeTgNv+QcFdUb3XzB9WHuOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ce5Qs89h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VMZUrW6J; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ce5Qs89h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VMZUrW6J"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9664B11401BC;
	Mon, 10 Mar 2025 13:28:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 10 Mar 2025 13:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741627704; x=1741714104; bh=uINygo8qW3
	Ne/pPhS3PgjLagm2Vu0kli/rstTV6JPes=; b=ce5Qs89h64YXm0xvhY1tQ7k+Iq
	WeuSbCkDx/78dbR0CCPcsH65zARR0fuQfNDYsFHFm1Aqqan5Zq+ZHCjhX0Wv1GKM
	ckihOxpGI5hbKD60NdfSdeoOyVilg1KjZnHyp9eFbWFcAhwYfUmjCsyvtjL0+pVB
	E2uxbSjkJv3ogDkpw11anvUCu5ET8AkI9h3QUY+6R7EXVQB86kQqc5AKi/8nHXq9
	3bhg7cLgNg8XVXL1JTerd7G9wMqGMIz6Qxv5YLmXDJbD4hR9/DX9IhzrfR9y2No1
	tXfl01vZccBqSOschI2ht+txUuIdfg+08jHe81CvrTkDWobzSEPAYhat7Opw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741627704; x=1741714104; bh=uINygo8qW3Ne/pPhS3PgjLagm2Vu0kli/rs
	tTV6JPes=; b=VMZUrW6JadkpotdeHbM8uNP8xKfZEe9/RZjhK74N+ynPCZPgEO9
	/kguH0zTetYAX2dl9NpVKf1Owk2GmmA8azH5SICjV2NriiFfRLJEw9Tt1SjIxMju
	GmW5Tk2Akq2dDpkipIdoj39w1rcYlnT+8e3GbGSBqRo6irjfzCIvtdtm5Cv8W0+w
	qD8/N6+unL03DlmDvIshfhLXYjv5ApFzS0lXrVYSQ32ddJV+97BEBtMReixwY6RO
	FyIwqJriBAXHhT71MC2PIOeAktFe17sDYGjQPONhLxBF9UIZgLEc4PYvgLgTiV3J
	5nESN+e6WqRykvm0slEjCqU3twO2VQpJu8Q==
X-ME-Sender: <xms:OCHPZxFw4DS1CI57B0wWKnmORLQXUqVpnM7GwoDoDC3uevLEmEppzg>
    <xme:OCHPZ2UZ4X0_w9_040LfdzTxN3y6QHyijlyB05BdcH5smvc-UuINmmyRyno0Y3Ije
    pT1eJRGoOTZVWZ4dg>
X-ME-Received: <xmr:OCHPZzLmJMw8j1fLTKzuNEFP8gUOIf4-ps_swqI3SUZheaYIofB9TT0kz74c3cSxPPbiHW2JdHrOHR_v120aR8Wet1UOf79L55NN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprh
    gtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:OCHPZ3FbgumgM7fCK40suX4sVSp_vo1eYy6FCtPYBSQQBGKldVN9SQ>
    <xmx:OCHPZ3U5GBFMhJ3e2IrrVOmmPncBh1e7nr6VhWKC8sLs3g4woB2YXA>
    <xmx:OCHPZyMxsvl_lfHnuobAYxAtnTDUAbEAgLHikogsD_WA-8JAAC2gQw>
    <xmx:OCHPZ23v5YGIN6jw-lfRuqurHZQGjw5TvzSbR-VjGygwUqYdlnHIDw>
    <xmx:OCHPZ4sDChgosSQ-cHCHRJPj9f7i_Djp1uhqJwQJWkchPMJIinAii9La>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 13:28:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  johannes.schindelin@gmx.de,  johncai86@gmail.com,
  jonathantanmy@google.com,  karthik.188@gmail.com,
  kristofferhaugsbakk@fastmail.com,  me@ttaylorr.com,  newren@gmail.com,
  peff@peff.net,  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 00/13] PATH WALK II: Add --path-walk option to 'git
 pack-objects'
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Mon, 10 Mar 2025 01:50:42 +0000")
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 10:28:22 -0700
Message-ID: <xmqqwmcw7q2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ... deltas across path boundaries. This second pass is much faster than a fresh
> pass since the existing deltas are used as a limit for the size of
> potentially new deltas, short-circuiting the checks when the delta size
> exceeds the current-best.

Very nice.

> The microsoft/fluentui is a public Javascript repo that suffers from many of
> the name hash collisions as internal repositories I've worked with. Here is
> a comparison of the compressed size and end-to-end time of the repack:
>
> Repack Method    Pack Size       Time
> ---------------------------------------
> Hash v1             439.4M      87.24s
> Hash v2             161.7M      21.51s
> Path Walk           142.5M      28.16s
>
>
> Less dramatic, but perhaps more standardly structured is the nodejs/node
> repository, with these stats:
>
> Repack Method       Pack Size       Time
> ------------------------------------------
> Hash v1                739.9M      71.18s
> Hash v2                764.6M      67.82s
> Path Walk              698.0M      75.10s
>
>
> Even the Linux kernel repository gains some benefits, even though the number
> of hash collisions is relatively low due to a preference for short
> filenames:
>
> Repack Method       Pack Size       Time
> ------------------------------------------
> Hash v1                  2.5G     554.41s
> Hash v2                  2.5G     549.62s
> Path Walk                2.2G     559.00s

This third one, v2 not performing much better than v1, is quite
surprising.

> The drawbacks of the --path-walk feature is that it will be harder to
> integrate it with bitmap features, specifically delta islands. This is not
> insurmountable, but would require more work, such as a revision walk to
> paint objects with reachability information before using that during delta
> computations.
>
> However, there should still be significant benefits to Git clients trying to
> save space and improve local performance.

Sure.  More experiments and more approaches will eventually give us
overall improvement.  I am hoping that we will be able to condense
the result of these different approaches and their combinations into
easy-to-choose-from canned choices (as opposed to a myriad of little
knobs the users need to futz with without really understanding what
they are tweaking).

> This feature was shipped with similar features in microsoft/git as of
> v2.47.0.vfs.0.3 [4]. This was used in CI machines for an internal monorepo
> that had significant repository growth due to constructing a batch of
> beachball [5] CHANGELOG.[md|json] files and pushing them to a release
> branch. These pushes were frequently 70-200 MB due to poor delta
> compression. Using the 'pack.usePathWalk=true' config, these pushes dropped
> in size by 100x while improving performance. Since these CI machines were
> working with a shallow clone, the 'edge_aggressive' changes were required to
> enable the path-walk option.

Nice, thanks.
