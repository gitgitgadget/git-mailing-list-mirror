Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88119CC0C
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773784903; cv=none; b=laEJX33fyVx13phvsZJFz0uGY17RMhtrTda3lnzBTWtILdMHqh608kFM+4E4+d8AcQA9pvPiM70Yc7AosYO7p1p8tkxkSn01ppHeoMpqYQ7ip2qySq8re9xKFBvDEMA8deGCjP7ks3rCk+0bdXnoGFOTEuwhe7SY5tHhNL31sGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773784903; c=relaxed/simple;
	bh=8jFqtPjDED2ROLoeaCMWmGfzH7SDEV+oFu4Xp46gMLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gA8++j3RNUiyr5aTXsPbvVkszdZV3qzGB/OxXGTjUZJ1eHrZgfCEq4y60qtCy/b+R7Euy+g9MxZSzAGiPzv0OIlrhteYKozTDmbqgce/m7tqg2rqzWx0cMvTOnYvHmEBBYsotwAyfvbVLZd63u/CGTdMLNEQM6QUd59RyhNljOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ePVHh0mx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FcT4tl3S; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ePVHh0mx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FcT4tl3S"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E69B1D0018F;
	Tue, 17 Mar 2026 18:01:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 17 Mar 2026 18:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773784901; x=1773871301; bh=6Nt1VuOjvE
	yJINA3R2z2DAVVF8c2jOjNtDhvtPLvJU8=; b=ePVHh0mx8AEBxWa2jiF9s2r6Nf
	OuYZonlM6D81zG2T9dPeroN+TIndHMs87d6i6XTdQKw5eOPWOCfyN8ktgl1EZyNr
	T5eCj06oAbKWYJPQNUNfGv+MiCg3q5240C7F2WuK58Os+rjvsS5VPwClnA98GfhF
	nqLYqZI4xLMB5/pR2xdOjlESyEWePqa0R6iO1bRGMSCpK6Ro9PPhvmmc8M1CHV48
	tZE5oi0NI7AaXZX8Jf+LjlbEgOGhxBlyV6oLjyclwlI9pT56cPBa6u1Lb/HKl9+Z
	e5e2o9g0/8p1N7KrirkVYedx6NUNKVc0BUO1vPMgM5ynPFgC8GPj7xsQ9AgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773784901; x=1773871301; bh=6Nt1VuOjvEyJINA3R2z2DAVVF8c2jOjNtDh
	vtPLvJU8=; b=FcT4tl3S07VANJ0Pz+qmilveNfqp8hlfN57FROTKYEKGki2/iNX
	druHWT7sUITRh4FFI42UAWsegVq74ZmoFvhvWK9Pp3DvSJfI79WPp8PS6NU2+xNK
	7/3PQgj5mEIfPF1/03uwarJ1F0X2tWxR4zHo+hQUR+WvHhEOEP1AaRBQj5mZZV1A
	8pAC3nhdkwVw9Y0skvcylRyFQXr/gKMxEpFSuOblifT3OS4kxf8GZVzY93Y+VnMF
	3DdaM/JJQGH+fgLvH3+4c7Fno4OjgnS9WMR+H3ih70TegYUjvbHXIwf43dVVy1a3
	WDUPT2DAIoI5O2c+e7GpXUJ6X5jgzbKps0A==
X-ME-Sender: <xms:RM-5aQVHcHh-4K11yoGKoEniLBfH8xgRGT5KB6mEF-dcNGl_RU6xUw>
    <xme:RM-5abl7Z1nxPrZTipgzrDag0cqmB2DZXG-7cm7cmY4uFe1hxZ84RWv61PLLXyaD8
    E9rAHN8aTEg7UsveFvAMHfhmtVheAaE65_D2C6F-vMZDpi6NmfAXIg>
X-ME-Received: <xmr:RM-5aZbxrfQCLbKL0GHZ-dI1SORjZj0nOXqbdN4qMTxY8AwBWbAquR0sUo5L2O_5tfQXEMi1Bhu6_NMlM02gGg_-W5I684Ap-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteffueffleduvdejjeegudektdehkedvkeeuvdevhfehueejtdeugeehfeff
    feelnecuffhomhgrihhnpehpvghnughinhhgrdhnrhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Rc-5aeOuhBiCahqjN1La0zeFFHBeSt2YlnA3MQlxq0ut4emY1GS9xg>
    <xmx:Rc-5aWaeI2ZoEQQpGIliF7W4EndmHgZEnC3_0vx06CwtoWBE2SrWVg>
    <xmx:Rc-5aU1jGEbkiv7ojmPsZZ-ttnaQOwFqfFNT7xqE9T3SYDkbsQPLZw>
    <xmx:Rc-5aUeJgJpdMz1sbqQZgpZXhPBLglTwvk-n4Sni56gcFmzKiewTNw>
    <xmx:Rc-5aU6vQF7wWA5xzD7G7btFoyt1M21PquPTPJ9h9GUustNnOm3szn49>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 18:01:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/5] backfill: accept revision arguments
In-Reply-To: <dc6652c84c8d37b124eb76c2a9cdfdc4db4a149d.1773707361.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Tue, 17 Mar 2026
	00:29:19 +0000")
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
	<dc6652c84c8d37b124eb76c2a9cdfdc4db4a149d.1773707361.git.gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 15:01:39 -0700
Message-ID: <xmqqy0jqi08s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	repo_init_revisions(ctx->repo, &revs, "");
> -	handle_revision_arg("HEAD", &revs, 0, 0);

So we used to "cheat" and did an initialization without even knowing
in which directory we were started ...

> +	/* Walk from HEAD if otherwise unspecified. */
> +	if (!ctx->revs.pending.nr)
> +		handle_revision_arg("HEAD", &ctx->revs, 0, 0);

... but by initializing the revs correctly in the caller, we would
be correcting it.  Looking good.

> @@ -134,7 +135,12 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  					 builtin_backfill_usage, options);
>  
>  	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
> -			     0);
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT |
> +			     PARSE_OPT_KEEP_ARGV0 |
> +			     PARSE_OPT_KEEP_DASHDASH);
> +
> +	repo_init_revisions(repo, &ctx.revs, prefix);
> +	argc = setup_revisions(argc, argv, &ctx.revs, NULL);

OK.
