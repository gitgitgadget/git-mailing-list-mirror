Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11188187FFA
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523206; cv=none; b=Wrnnd4YvuXtIGqIDnYgmarZbM/+1Krl27OE6OLc2cv457lSrdPz8hXdjiCvqYfkS1MmpZl6BMnUbdNzApY/p/POUHOH4lih6yfpvAaayUgPg5RhAH/PNdVA0aI23HKhqOuqLY7SG+Gn8uF5MrvvINIqwBLQdC87IKyugPm0kcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523206; c=relaxed/simple;
	bh=XzLK5eY5quIFvU8U1lit6GDmlO6uHq31EMFODCn8vCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwGXwY8NKgVgToGHzrDHXup4YUrWZzPkugovpJFoPLxNXWIqsOLX5h8yDtRYQ4+CnMmMpp+PsOeDma5PjkHbToEvtqLMUioEb4snRmpiPxKbXK3ihwRsVduTtZtUwiotjjR8iaf14XOIZ6atpAXOO0ixENxrfY/stcE3t7kn4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ft7Qt395; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PiK9A+KW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ft7Qt395";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PiK9A+KW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 07825114016D;
	Mon, 25 Nov 2024 03:26:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 25 Nov 2024 03:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732523202; x=1732609602; bh=PMOneN1MGC
	n4e4IuvRBClfV37exINaKZS+FImcd9m/8=; b=Ft7Qt395LkWkHnvJr4pPPh5vxM
	+txqysOS6XSrq/MqFgLhSsllHbhKUTz7KhDXR7a5bets8DKVUivtlVJGqttRAahc
	SjkwM/p+KXm7aCfjkiy0llPsqlo6FrUQsdRDuAU1Of6NIJ07LYsFjnWolqjeD93A
	ZF/r5tcy6jOFfDax5FFPS//pdpF+aGykZ5e7J+SNdG6tP7JZfZXxwyXf1bPqYs3y
	uAFLJZzaxxRcij7ZV7OOgQfvXlfEsjSHW2QmAqzCbIgjxm77ICpmzz8s26/cqm8l
	g1CkAy+pRhW84boXNIMBwcfzhGhL2U2QytmwIA8/IwQnmbKuz5ViTkD8++jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732523202; x=1732609602; bh=PMOneN1MGCn4e4IuvRBClfV37exINaKZS+F
	Imcd9m/8=; b=PiK9A+KW317Nb50zyCtBGhPmHennsqGPWHIQ4GuflmkPZpt/wFJ
	ikILn0AqeZe94KCYU4m6FUbpDCG2MXNcf/8elyYQGysOD7UnwEMFIX5JNY7NiY93
	StqCYB5beSqbIVWWwK2AglrCbi4RMetkC5LRQeImsQNIep3gNBtDXioHK0hwo/Cc
	uHv4Agso6n2lPILE6vVxVerf4/E3/PVcOaRirOAlo4ZsBGT75tWP75uVrlvSF530
	vlhs3JrVy5FKHVhTJ71wFUkFiP/aNVdFjWpwWlB7U1uLkzfBliGr4wVSwWgJZWJQ
	G4eKoNJyJQ5Q51oeUpuI0ZiWXVwdUwu1W2Q==
X-ME-Sender: <xms:wjREZ2i6rtzEIG6lA4KDcqSprsJrhObKpwsEWEpQIYjbGW6_EWYgwg>
    <xme:wjREZ3DqtEGjhZi_q7wPnSZJfK6XUJ5mgLF8UP1BnBtVqNB-Zkn4Kr8loIdAcVL9m
    TlN1D1rZZ6EA40cBQ>
X-ME-Received: <xmr:wjREZ-HJSLt7Vr3sTFf-Urfgx-SdRq_bg8BRE5tTeGFQ4Rx3h_i71svbGrQUf1_pl3miwQ2bT1YtO4tkDI4z7ZSl3j4eqnPR9VbihW34vLZMig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopeiihhhihihouhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtoh
    eplhgrrhhrhiesvghluggvrhdqghhoughsrdhorhhg
X-ME-Proxy: <xmx:wjREZ_SGraFSF0qL67Wr_QKMaUbYw6mnC5LOJvN94zcQnegw1Ngy2g>
    <xmx:wjREZzxyVftte17YAdNnV-70SrEi1Ddt0brKLNsEGA90q-U6cm55ng>
    <xmx:wjREZ94nOqD6flpNaoX30ZXzcUEZaZJVZ9i5V1K7HCOLSQpZebv7Eg>
    <xmx:wjREZwz_2S_aNeG2fTFRlRmjFsyo4ztpybWaWU6ICnqDhlQzNAfn9w>
    <xmx:wjREZ1vjLzYeQCZN3f7X5lXnGGOpRuCJdOAjFIWcZmuCSTbwfBfId2pp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 03:26:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 125d7f9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 08:25:40 +0000 (UTC)
Date: Mon, 25 Nov 2024 09:26:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v2 2/6] push: fix the behavior of the Done message for
 porcelain
Message-ID: <Z0Q0tY8y58yNivFR@pks.im>
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com>
 <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
 <9dfea9953c2a671600beebbaa0692a1e68afea34.1731603991.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dfea9953c2a671600beebbaa0692a1e68afea34.1731603991.git.zhiyou.jx@alibaba-inc.com>

On Fri, Nov 15, 2024 at 01:15:33AM +0800, Jiang Xin wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> 
> When executing git-push(1) with the "--porcelain" flag, then we will
> print updated references in a machine-readable format that looks like
> this:
> 
> To destination
> =   refs/heads/noop:refs/heads/noop [up to date]
> !   refs/heads/rejected:refs/heads/rejected [rejected] (atomic push failed)
> !   refs/heads/noff:refs/heads/(off (non-fast-forward)
> Done
> 
> The final "Done" stanza was introduced via 77555854be (git-push: make
> git push --porcelain print "Done", 2010-02-26), with the following
> behaviors:
> 
>  - Show a "Done" porcelain message if there are no errors.

It would be great to update our documentation so that we spell out when
exactly the user can expect such a "Done" message.

>  - Fail to update a ref in a --dry-run does not count as an error.
>  - Actual rejections in non --dry-run pushes do count as errors.
>  - Return a non-zero exit code if there are errors.

> However, the behavior of the "Done" message is not consistent when
> pushing with different protocols. This is because the return values of
> transport->vtable->hush_refs() across different protocols are

s/hush_refs/push_refs/

> diff --git a/send-pack.c b/send-pack.c
> index 6677c44e8a..4845f63737 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -630,7 +630,7 @@ int send_pack(struct send_pack_args *args,
>  				reject_atomic_push(remote_refs, args->send_mirror);
>  				error("atomic push failed for ref %s. status: %d",
>  				      ref->name, ref->status);
> -				ret = args->porcelain ? 0 : -1;
> +				ret = (args->porcelain && args->dry_run) ? 0 : -1;
>  				goto out;
>  			}
>  			/* else fallthrough */

This feels weird to me. Why would we ignore an error with `--dry-run`?
Doesn't that mean that the resulting behaviour is now different
depending on whether or not you pass `--dry-run`?

> @@ -760,11 +760,12 @@ int send_pack(struct send_pack_args *args,
>  
>  	if (ret < 0)
>  		goto out;
> -
> -	if (args->porcelain) {
> -		ret = 0;
> +	else if (args->porcelain && args->dry_run)
> +		/*
> +		 * Knowing a ref will be rejected in a --dry-run does not
> +		 * count as an error.
> +		 */
>  		goto out;
> -	}
>  
>  	for (ref = remote_refs; ref; ref = ref->next) {
>  		switch (ref->status) {

Same question here.

> diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
> index 373ec3d865..5ff901454a 100644
> --- a/t/t5411/test-0001-standard-git-push--porcelain.sh
> +++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
> @@ -73,7 +73,6 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
>  	> To <URL/of/upstream.git>
>  	>  	<COMMIT-B>:refs/heads/next	<COMMIT-A>..<COMMIT-B>
>  	> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
> -	> Done
>  	EOF
>  	test_cmp expect actual &&

77555854be (git-push: make git push --porcelain print "Done",
2010-02-26) seems to cover this case, where it mentions that a
conflicting ref update does not count as error with "--dry-run", but
does count as error without that option. And this change here seems to
be in line with that.

Whether the documented behaviour of that commit is reasonable is a
different question though. I find it to be of dubious nature to make any
runtime behaviour (other than committing the actual change) depend on
"--dry-run". The behaviour should be the exact same, as otherwise the
dry run becomes useless if the behaviour differs.

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 331778bd42..b133ab6ffc 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1207,7 +1206,7 @@ test_expect_success 'push --porcelain --dry-run rejected' '
>  	echo >>.git/foo "!	refs/heads/main^:refs/heads/main	[rejected] (non-fast-forward)" &&
>  	echo >>.git/foo "Done" &&
>  
> -	test_must_fail git push >.git/bar --porcelain  --dry-run testrepo refs/heads/main^:refs/heads/main &&
> +	git push >.git/bar --porcelain  --dry-run testrepo refs/heads/main^:refs/heads/main &&
>  	test_cmp .git/foo .git/bar
>  '

Huh. So this is the dubious part I mean. It seems like the push would
fail without "--dry-run", but because we pass it it does not indicate
that failure via the exit code. This behaviour does not make any sense
to me. There are more cases in your change where we stop failing now.

> diff --git a/transport.c b/transport.c
> index 47fda6a773..9e03a7148c 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1486,7 +1486,18 @@ int transport_push(struct repository *r,
>  	} else
>  		push_ret = 0;
>  	err = push_had_errors(remote_refs);
> -	ret = push_ret | err;
> +	/*
> +	 * The return values of transport->vtable->hush_refs() across

s/hush_refs/push_refs/

> +	 * different protocols are inconsistent. For the HTTP protocol,
> +	 * the return value is zero when there are no connection errors
> +	 * or protocol errors. We should reference the return code of
> +	 * push_had_errors() to check for failures in updating references.
> +	 * Since failing to update a reference in a --dry-run does not
> +	 * count as an error, we could ignore the result of
> +	 * push_had_errors() when both --porcelain and --dry-run options
> +	 * are set.
> +	 */
> +	ret = (porcelain && pretend) ? push_ret : (push_ret | err);
>  
>  	if (!quiet || err)
>  		transport_print_push_status(transport->url, remote_refs,
> @@ -1503,7 +1514,7 @@ int transport_push(struct repository *r,
>  			transport_update_tracking_ref(transport->remote, ref, verbose);
>  	}
>  
> -	if (porcelain && !push_ret)
> +	if (porcelain && !ret)
>  		puts("Done");
>  	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
>  		/* stable plumbing output; do not modify or localize */

I'm not yet convinced that it makes sense to ignore either `ret` or
`push_ret` in the above two hunks. Making this dependent on `porcelain`
may be okay if we want to report errors via the output, but making the
behaviour dependent on whether or not we perform a dry run continues to
feel wrong to me.

Patrick
