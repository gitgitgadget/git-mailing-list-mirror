Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0D45023
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609616; cv=none; b=WMiRHVyEyv6+SysPJpEIsy095v8iQO4lAhiBhQPbzLOgaOMAfwUByxnSybDMUa4YmrZKGAEcAmHfcI0mABlEGNNB/op8Ze875haI30DxcrbzVuAdGgW0tDeVlA7Cvxy616e66CbRE5aUV3BRzXzwTQ/iq6md1+ddozmS/CqZerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609616; c=relaxed/simple;
	bh=oo+J5yzpqq+FC+byAi8EQKP9zWcB3ZAieycbEBT10co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1RowxxoOdmc3e4IJEfzphYUOxjfIvSh+c1VaW+c8iMYT0YrCloSNHfK18xVkgc0p9WDgjD2GgJ8FaEeG2nyEE22r4O0Xu/gSxjrmzGkYDV2F/xQ7aXkIp19zZAeaIpGbTzEOhsz3ZT5H4TG8QLimv7GaWVu7w1D3FrC1vEeicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pHdQwY9m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C6dWENis; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pHdQwY9m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C6dWENis"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B8061380798;
	Tue, 26 Nov 2024 03:26:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 26 Nov 2024 03:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732609614; x=1732696014; bh=NdiouOegya
	R7Jakk1P0jYjxmM3/sdj4aD+4A19pEduU=; b=pHdQwY9mGfKdNqLgvsgsRi4ItY
	KGyq4WwOgd/lASBQYNrRQ+EkoTwRux8GIGm+lN6hGqngCvLuTnvp8cwBKSYUPgE5
	CNfeOm14vpY1EDRviChb8xHgxIadIMVBk7MltiaFvb15E5C8kSt/Jxwj036P+9p7
	cO91GDe7htJNzJ9yiU0NhLPYgSHGj3XWewsRZ/HKSdI+i/WJGswUeIEZDiuZl/Cy
	jb0YzS1tqlpRoJToMhzPxCX3Aj/jQ0lq/7D7AeDIptRIYKrZi7scfN/oJ3EU5bN+
	7gO8qHZWjx2nCllLHFVcjiussUOKdrUIWTYnHcAwBvtAIwI787Ji1M5zjz3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732609614; x=1732696014; bh=NdiouOegyaR7Jakk1P0jYjxmM3/sdj4aD+4
	A19pEduU=; b=C6dWENisybe5xy6BTpxIkKuWaWNTQHRXZ3mqU1I8NixiNo//viQ
	YLy+P0CleeHx9qmJ8+VRoNhVmmqxVtGUcJSQaC1Ie+zA6v9nPc1cQ1jz1q2HptHo
	X1fBVs2mhJMG0RU1QoWApgnEjQhSVXRny+iG7AN75KQBz27Bso0RAr0zu3WPGbBu
	rvMoFpj2hhi/209DxSzKRLzS0pjzO5lr9laqZrSeUv7ApDkpD1f6FXw2J6pNrqig
	gvBDHuWBAGyrkgonHCNkKnZvBNlAFrvAub3X4aZ9NlwMF0aNGaMg9O2+Jf3/ehAv
	zFWoi3kVrUT+IkZ3BDQ7FFN7hO6VLtkuFJg==
X-ME-Sender: <xms:TYZFZ82WSEVeO9yJXK4vc6WyCajZpwkNDv7HwapId-lokgL0j0IryQ>
    <xme:TYZFZ3F_VsoaSFKJ1Vxfc5CAqa5TSnO0DTNhbML_DKK6tnqYOGAjpCiExqmBhfCx3
    lYgbeydmQ0ZLAA8Fg>
X-ME-Received: <xmr:TYZFZ04h4E5mwo02HZmSSd815-SW5drdGO2SWHDAjSCI23Enhc9xR2U226t1oirOwoRrxOvHpzRJugZPuSC_FFsCfa-uGmBJIQ18BBhJw1SjFFp7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhgt
    rghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhi
    nhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:TYZFZ12uJZDHWHA2Z-ZnFUpo92wqoLILp1XXAvrz25pCXEx6hulYgg>
    <xmx:TYZFZ_GPstojWGG3ssPgR3bibMpwzJO2VcJRgXD3jR65oCkxVNROYA>
    <xmx:TYZFZ-9rbLyRZyNDp9aKRdFLnE-ojWWM78sUMS58gnV1zS_HxHO8Zg>
    <xmx:TYZFZ0lAFNhK0BPYR8cqvFofkwergUnDA8Up1b9LGYPDLf3VV4hMFA>
    <xmx:ToZFZ2AgJ-RjydqfWhCs1rdN0PuOHmdGsI7TeVOj7lyXpLMcH_XoxuR->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 03:26:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0bd490c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 08:25:49 +0000 (UTC)
Date: Tue, 26 Nov 2024 09:26:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/7] pack-objects: add GIT_TEST_FULL_NAME_HASH
Message-ID: <Z0WGP34itCSCdYk6@pks.im>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <259734e0bcea952c2c09b0fb3a017e139922b975.1730775908.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <259734e0bcea952c2c09b0fb3a017e139922b975.1730775908.git.gitgitgadget@gmail.com>

On Tue, Nov 05, 2024 at 03:05:03AM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index c53e93be2f7..425aa8d8789 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -516,7 +516,18 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas' '
>  	# Exercise to make sure it works. Git will not fetch anything from the
>  	# promisor remote other than for the big tree (because it needs to
>  	# resolve the delta).
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
> +	#
> +	# TODO: the --full-name-hash option is disabled here, since this test
> +	# is fundamentally broken! When GIT_TEST_FULL_NAME_HASH=1, the server
> +	# recognizes delta bases in a different way and then sends a _blob_ to
> +	# the client with a delta base that the client does not have! This is
> +	# because the client is cloned from "promisor-server" with tree:0 but
> +	# is now fetching from "server" withot any filter. This is violating the

s/withot/without/

Also present in copies of this comment.

> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 0f0c86f9cb2..03f8c976720 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -1094,6 +1094,8 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
>  	) &&
>  	git clone super4 super5 &&
>  	(cd super5 &&
> +	 # This test var can mess with the stderr output checked in this test.
> +	 GIT_TEST_FULL_NAME_HASH=0 \
>  	 git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&

Nit: This line should now be indented.

>  	 test_must_be_empty out &&
>  	 test_must_be_empty err
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index fc2cc9d37be..e3787bacdad 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -309,6 +309,9 @@ test_expect_success 'no bitmaps created if .keep files present' '
>  	keep=${pack%.pack}.keep &&
>  	test_when_finished "rm -f \"\$keep\"" &&
>  	>"$keep" &&
> +
> +	# Disable --full-name-hash test due to stderr comparison.
> +	GIT_TEST_FULL_NAME_HASH=0 \
>  	git -C bare.git repack -ad 2>stderr &&

Same here.

>  	test_must_be_empty stderr &&
>  	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
> @@ -320,6 +323,9 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
>  	blob=$(test-tool genrandom big $((1024*1024)) |
>  	       git -C bare.git hash-object -w --stdin) &&
>  	git -C bare.git update-ref refs/tags/big $blob &&
> +
> +	# Disable --full-name-hash test due to stderr comparison.
> +	GIT_TEST_FULL_NAME_HASH=0 \
>  	git -C bare.git repack -ad 2>stderr &&

And here.

Patrick
