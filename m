Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FED1E9B07
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763754; cv=none; b=IN4m/ouucRjxjeRYew7IbWLXtzZUid+mQRJVs0am632+m8bWSF+b36XwB75NTlq3y9K7NI1HKuf5bOy70KF4nuI7Gvf0YeskLYuGR4eMPmw0nmC0QAp0Wcx4QSGVJeGuDY4eQ8G6yUtpfoQD1gLwPdwCVByhA6vmEWO5J1yxSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763754; c=relaxed/simple;
	bh=AJPPz5EQks+Y5v8SsP97WKBY5T8IJFMU5u8HZH2s/Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuYPmNz8mn3Bf2TCq5dci0u0Om/8kOkwtkdH/5KS1wL7GQ8zVhHm+1p7pWLTIa3voPACk3HOeDFmMah15ukJfOma9tj59HaS9I4tEc1Kq8uLXp56sGKFLU0PmMiioIl1t7B9NcUu8A5LR858iZ7mRoxfYCiiqpdU0E/QpzU3J3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mjABpBV5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oAMwzs85; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mjABpBV5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAMwzs85"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C5AF11402B4;
	Wed, 12 Mar 2025 03:15:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 12 Mar 2025 03:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741763751; x=1741850151; bh=y9+01ZvDFg
	RnphcAquCjYHaToHkrwcK5yIq3So3q9pI=; b=mjABpBV5WGS4IurpimRz/BVbHf
	WBxn7kkdMoWQvyWAvnAetKn7BbxiohALVgshGsSOCanyXVYYm3nqFGHfpZWsq60b
	xfOgPGcWLCq3ERi5SGxG7Xo1bd5Ie3v5V9ulIUqvt0C+V7eN5XOTtz+PsNTcxwO7
	ZKUFfU9/Z3TTQX4m2AmCs1ImSmw90wvMOp40a3BUxe+DvG45+JcbvwhCCJDkNmVs
	y6Y196LfZfBJSVUG/uw7ouNigRJC3UUz7iCFIzi+6ZZiHQFyoRmScwFWCzYyor2F
	ef5Ip7+FmbqXrhKxuN5ii4SidoXtPyEjNcmyp3IFLNMDwJ9voVSehvNL4Kqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741763751; x=1741850151; bh=y9+01ZvDFgRnphcAquCjYHaToHkrwcK5yIq
	3So3q9pI=; b=oAMwzs85g/VECrneEGzG2b+NjwYY/oOJB/GoX32S4bQpc9CjQeY
	bMrHQ3r6jab8t0CzawazqNrpNrM87dW3JCwnS6A/GBf/3avLU8mddlQIZq79Vn+G
	NgXOrQs39f5Pg3t1mPsARM//SMjfEMLDN+MY70HQCKQin03jFfVTlAan1D8Y06+O
	KWUIQlArbK/1lhSxhCfvGUMWRV+2ddDnGPDGBoAdMQqCOEWmWOxTkIUnn/1eiP0O
	cTLVHyyMYICKwwNCGF09nBeTD2DUDvr/Ad11uoTNEVdnGhlDyc4x9eb+FcsByfsK
	6JhtJl0ifdgXgIlR/5X+aRe0xx+w7H4y8FA==
X-ME-Sender: <xms:pzTRZytsStXCkHNJns9z26lqLhfvaj3S8TuyU3y6lhKFYzl6DC162g>
    <xme:pzTRZ3fMePf4AQaSm-njqlhFZ8WnaFfGnPQgzLVj87b3Le8tCPb9OSUgpbUz_VdES
    2sQiPCxNO6twuhuHg>
X-ME-Received: <xmr:pzTRZ9xQNo2HjD3yZT4Pfet4Jyt27vibv0GCCkVS1eN2RcBl9WJznkmKDBIpFgP14thm0-M266br74dMo3-oo0q5At0Xld5xk9rN-aHGZnAGVEaP3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeggeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pzTRZ9OBeYRvngpP4A1It_DzxgfHvG9FxIg_GyJBEel49OQbeP2N8g>
    <xmx:pzTRZy-dJ3e-PBqfrdctYqGOpVhd1De8CAgG_0kUrYTRKTZlhbS5pQ>
    <xmx:pzTRZ1XDUH0-0R6YAJv6_ZMyqP4pNsajNytY_FYgawUGZXbLu6EEKg>
    <xmx:pzTRZ7ca2yWlrcOy52O_cy1cyRdNhmGHjRtXhdkSdXiBvM_2el3_Aw>
    <xmx:pzTRZ2apOtHnW6a9Y3RrizFPcw7W1rYz0fCy71p-QkSck7ebE7uEVzXB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 03:15:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ad0fa27f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 07:15:48 +0000 (UTC)
Date: Wed, 12 Mar 2025 08:15:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: Re: [PATCH v2] reflog: implement subcommand to drop reflogs
Message-ID: <Z9E0oDgGOM1R-4mI@pks.im>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <20250310-493-add-command-to-purge-reflog-entries-v2-1-05caa92e0bfa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-493-add-command-to-purge-reflog-entries-v2-1-05caa92e0bfa@gmail.com>

On Mon, Mar 10, 2025 at 01:36:25PM +0100, Karthik Nayak wrote:
> diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
> index a929c52982..6ed98ddaef 100644
> --- a/Documentation/git-reflog.adoc
> +++ b/Documentation/git-reflog.adoc
> @@ -16,6 +16,7 @@ SYNOPSIS
>  	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
>  'git reflog delete' [--rewrite] [--updateref]
>  	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
> +'git reflog drop' [--all | <refs>...]
>  'git reflog exists' <ref>
>  
>  DESCRIPTION
> @@ -48,15 +49,19 @@ and not reachable from the current tip, are removed from the reflog.
>  This is typically not used directly by end users -- instead, see
>  linkgit:git-gc[1].
>  
> -The "delete" subcommand deletes single entries from the reflog. Its
> -argument must be an _exact_ entry (e.g. "`git reflog delete
> -master@{2}`"). This subcommand is also typically not used directly by
> -end users.
> +The "delete" subcommand deletes single entries from the reflog, but
> +not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
> +reflog delete master@{2}`"). This subcommand is also typically not used
> +directly by end users.
>  
>  The "exists" subcommand checks whether a ref has a reflog.  It exits
>  with zero status if the reflog exists, and non-zero status if it does
>  not.
>  
> +The "drop" subcommand completely removes the reflog for the specified
> +references. This is in contrast to "expire" and "delete", both of which
> +can be used to delete reflog entries, but not the reflog itself.
> +

I guess this paragraph should also moved between "delete" and "exists"
now.

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 95f264989b..cd93a0bef9 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -449,10 +458,58 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
>  				   refname);
>  }
>  
> +static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
> +			   struct repository *repo)
> +{
> +	int ret = 0, do_all = 0;
> +	const struct option options[] = {
> +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
> +
> +	if (argc && do_all)
> +		die(_("references specified along with --all"));

We should probably use `usage()` instead of `die()` here.

> +	if (do_all) {
> +		struct worktree_reflogs collected = {
> +			.reflogs = STRING_LIST_INIT_DUP,
> +		};
> +		struct string_list_item *item;
> +		struct worktree **worktrees, **p;
> +
> +		worktrees = get_worktrees();
> +		for (p = worktrees; *p; p++) {
> +			collected.worktree = *p;
> +			refs_for_each_reflog(get_worktree_ref_store(*p),
> +					     collect_reflog, &collected);
> +		}
> +		free_worktrees(worktrees);
> +
> +		for_each_string_list_item(item, &collected.reflogs)
> +			ret |= refs_delete_reflog(get_main_ref_store(repo),
> +						     item->string);
> +		string_list_clear(&collected.reflogs, 0);
> +	}

I noticed that `git reflog expire` has the same arguments to specify
which reflogs to expire:

    [--all [--single-worktree] | <refs>...]

The only exception is that they also support `--single-worktree` to only
expire relfogs from the current worktree. Supporting it should probably
not be too much work, so do we want to do so to have feature parity
regarding the reflog selection?

> +	for (int i = 0; i < argc; i++) {
> +		char *ref;
> +		if (!repo_dwim_log(repo, argv[i], strlen(argv[i]), NULL, &ref)) {
> +			ret |= error(_("%s points nowhere!"), argv[i]);

As a user I wouldn't know what this error is trying to tell me. Does the
reflog exist but it's a symreflog that points to another reflog that
does not exist? Do its entries point nowhere?

How about: `error(_("reflog could not be found: '%s'"))` instead? And
seeing that you copied the error message from the "expire" subcommand
we could also adapt it in a preparatory commit.

> +			continue;
> +		}
> +
> +		ret |= refs_delete_reflog(get_main_ref_store(repo), ref);
> +		free(ref);
> +	}

The code is correct, but do we want to maybe wrap this loop in the
`else` branch to guide the reader and make it blindingly obvious that
the loop does nothing `if (do_all)`?

> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 388fdf9ae5..251caaf9a4 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -551,4 +551,71 @@ test_expect_success 'reflog with invalid object ID can be listed' '
>  	)
>  '
>  
> +test_expect_success 'reflog drop non-existent ref' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_must_fail git reflog exists refs/heads/non-existent &&
> +		test_must_fail git reflog drop refs/heads/non-existent 2>stderr &&
> +		test_grep "error: refs/heads/non-existent points nowhere!" stderr
> +	)
> +'

One edge case that I haven't seen is to try and drop multiple
references, some of which exist and some of which don't. The loops you
have seem to explicitly allow for deletion of only a subset, so it would
be nice to verify that the logic works as expected.

Patrick
