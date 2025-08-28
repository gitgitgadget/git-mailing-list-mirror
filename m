Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D272DA779
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423328; cv=none; b=ChzGvd7SvLGaL8YV5Q8wEviXKqwznVTlJO3qsTPoZqx52q6aAXjFvVLgE9K+plZQCYbppytMyDUE79jg9hcOrC7bO8xgU1u3AO7ufAB2RLXwagiTWsHwnBqOh2VSuavCfJiAgWF7igElrud5qFMiH2+SByUkeTBfeMKovwRs36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423328; c=relaxed/simple;
	bh=7+TNXHTsMasSkLGDjDjXPJUU9BbsxGopwjJXpPIr1PA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AjgUegMZ4XV0uyD16dX+c3VApfRSV/58rJZjAQwa4lvp8Fz297PJqN/E++KhUuUlP1uF6h74wAo82+dUD0hQ7q9G5okKFKBqPlrX/rXiFat+PfO3JPH7LUX2rFG1GayVBnzU6v7DXgW7aq0BacBWu9NU5sexKWf47AYZL4i8PIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uoQLpNKG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dA1rUwxG; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uoQLpNKG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dA1rUwxG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D8A71D000B4;
	Thu, 28 Aug 2025 19:22:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 19:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756423325; x=1756509725; bh=+pmWab91gt
	8BvwS3rkkl4TbN+3Rl/gqt4gK0CsqTdc0=; b=uoQLpNKGrSLDKz+/WQZydyPAXm
	8nqIx4wu19SRzj44YXeKAzJOIMvOGY4IuU2DF+dAY8wCcyMumaHV256JrUNvpMp6
	CZriIS9PCFVyta4VwnhjSUZ80Jp9KxzsgbOhJ8YPN1gqW0YF8a6l+zHCsbnNLlMM
	rG4T2DJgDa4ovQFAfH5dZE2dEkyb6IaoijKjq+SXsB1Nr+FMDw9Qyasu26r5WIZf
	6T+firGv660at0Z6+RNnnzVlA7vAgxDooPK+UyHKvffrwkOvnD2aebDVPjwdjZPr
	JM/00HnYzWrncEKZCdwseJHAKkFlI088n0RgusG80PH5cdWL5MB4x2/LUJsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756423325; x=1756509725; bh=+pmWab91gt8BvwS3rkkl4TbN+3Rl/gqt4gK
	0CsqTdc0=; b=dA1rUwxGRWeQZacThV6wzCevLXQ6u22qN0LSCgegGwBXI6VfQHm
	13m93BWn0NTaWIogv84nNjGW+ilMDbbsCykTqIFgykKgMRvt5E3m/LZdinHCZ1+8
	+QQxJlst5rxmn9POiUftnpLgU664cJxBil6yu5groGA/Pd/IsRnpxHT1EmZtJesm
	7fpSG5evaTUj/cclGT6ipkvyoKSnhsc0GKbHuzWL/j+rUtR1ozvIoue9L3tqZ8Fa
	HMr6DJy7N6vEHUPj/1t0WuqN6GgVIN70zZGCr8UIm/fWKm1r+kg54a69ucCwqriB
	XOKM4hwqU0tMiQZZTALdsV7iXUNYA4Sa6Kw==
X-ME-Sender: <xms:neSwaNVmG7ne7V-ulBpzfVWNVf4aq8ROFvHNNComzO0CoQ5Edzedyw>
    <xme:neSwaGCBLTo0gdBPlES2m8EqDaFHhyv-jHj1Nnztt6LH_iCdPyCabTgVbXrE1g9_z
    muBEPWt95miGYjxWA>
X-ME-Received: <xmr:neSwaJ3FCRA2ylURF6RcAqlO0iMET7X9wst3i1moET7I4bBahLw-xzW8w4lQXI9HCx8P7d7h4KXm0iyMEJL8cv8JAGEalrhmetc081Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:neSwaA0B5lRwFSh3cuh1A_cQKHsttPWZpE6oQJdrWV6fiI-rtY0XtA>
    <xmx:neSwaGA_DJidM9DUfKgSVu0V3cCWmcHm-eNMDeSxBJ80n-3LONP-aA>
    <xmx:neSwaH6yr3hoTKCe5koaTtyqvtgORMmmxb4wqkl8GslmFoYyV3NfLw>
    <xmx:neSwaPI3IgyEr6cdhTlBuEsNQ0mHZpnRrWRoeln4TxxTXmKBEQmr-Q>
    <xmx:neSwaLVxoUtIUJGpI3mjnz4R8h84lviaC2vvPE1nPlDG1ktEZqMw0kdP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 19:22:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  Patrick Steinhardt <ps@pks.im>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/8] sparse-checkout: add 'clean' command
In-Reply-To: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Thu, 17 Jul 2025 01:34:06
	+0000")
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 16:22:03 -0700
Message-ID: <xmqqzfbjqbfo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This command uses the same '--force' and '--dry-run' options as 'git clean',
> with integrations with the 'clean.requireForce' config option. There are
> some concerns that this isn't an obvious way to work with the 'git clean'
> command, but I thought we should be consistent here. I did change the error
> message to point users to the necessary options.
>
> This option would be preferred to something like 'git clean -dfx' since it
> does not clear the excluded files that are still within the sparse-checkout.
> Instead, it performs the exact filesystem operations required to refresh the
> sparse index performance back to what is expected.
>
> I spent a few weeks debating with myself about whether or not this was the
> right interface, so please suggest alternatives if you have better ideas.
> Among my rejected ideas include:
>
>  * 'git sparse-checkout reapply -f -x' or similar augmentations of
>    'reapply'.
>  * 'git clean --sparse' to focus the clean operation on things outside of
>    the sparse-checkout.
>
>
> Updates in V2
> =============
>
>  * This series is based on 2c5b5565981 (environment: remove the global
>    variable 'sparse_expect_files_outside_of_patterns', 2025-07-01) to build
>    upon those cleanups in builtin/sparse-checkout.c.
>  * The --force and --dry-run options match 'git clean'.
>  * A --verbose option is added. It does not link to the index for
>    tracked/untracked/ignored/excluded or clean/modified/staged/conflicted
>    status, but instead gives the full list for information.
>  * To support the --verbose option, a new for_each_file_in_dir() method is
>    added to dir.h.
>  * Tests are added to demonstrate the behavior when a sparse directory has a
>    merge conflict (fails with an explanation). When adding the test based on
>    the previous version's functionality, I realized that the behavior is
>    sometimes less effective than git sparse-checkout reapply even after a
>    sparse file is committed. To demonstrate this change, the full test is
>    created on its own and then a code change is added with the impact on the
>    test.

This seems to have a few comments that haven't been responded to
(plus a "This step looks good to me" or two).  Can we get it unstuck
soonish?  The topic is from mid July and I do not like to hold topics
in 'seen' for longer than a month without any activity.

Thanks.
