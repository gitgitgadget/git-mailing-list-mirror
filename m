Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B802F60CC
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061533; cv=none; b=Et1zx63ZAqyntpfg5bKYUKraLcKJIL0GAfyrQ2vmChsyO7V4XA0Jqd48xhAcVy7jv6880op9uMRty4CTrx4L0nHV7iCZ4AehaxPj8RRetdA+CTKipxWVHBjkEAdqu9Jv897rZBXLHzmQMKpPU487Za9fbYZxoiRWVqO4EZoR6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061533; c=relaxed/simple;
	bh=fNJwc9hrUZnbizS8C5Z3TZ7+eQq3bxdqfvwSijC2Meg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zy1GrkQKJTmCYCQJI+v4m03SRtdOXRYNadv4mPoDTipgYbXiDjCMxNcEbZIhfHgA5HfFfeWGT4rZcyjp4vk0hFQRtqGLczX7qig6OYQU2qFO6B6hF3VlQOR7NiURBz4WTOUg3loO5aj3Kcf6mahYcWkTgCWucASH64CdpNoZPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=te7KGz5w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bqHqQcYe; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="te7KGz5w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bqHqQcYe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 509DC14001B9;
	Wed, 25 Feb 2026 18:18:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 25 Feb 2026 18:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772061530; x=1772147930; bh=kj9Vzi62Wg
	6SuA2mJPr4aQV9CS1us2FHGMK6jxWQk60=; b=te7KGz5wZ6zUsSyzUJSWL8BnZF
	X2fmgJeIo4YC9zlEU4P4AFx4Q5+bpRaN+KG5A57eaqnfujeEsQX3ZQMH9hvMgJDy
	cS1H47UqGAsZK5Syq+O/LUIiPBQJCWVE8KE5sZP+ekxKYuxNaZM57i5CP7PMUcFD
	ifEfUZbPV/PO7LAAWKqAv/Qf8/3u0YTtS4Acr/V4AzOuLhDW0av07wAgPFByygN5
	npeLtKlxlLIstfqcJVgbj/ooLEBjHvPz+00QR5z6F41RKrW5OXuw65yZiEEuYAJc
	EMNmcZRZKKr4g/efJW1jS2QTTetgBUNj70qwuRqR50bHFueiGDw6LZE2p3iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772061530; x=1772147930; bh=kj9Vzi62Wg6SuA2mJPr4aQV9CS1us2FHGMK
	6jxWQk60=; b=bqHqQcYeoGXppimgucxtWLwAAzXTdEcjgl/zOmeFhIoXNLuw6FE
	WnMt8A5S6iUal+lFRvbKXzUyAKmZL4NOWAdvGz+7EOG3FIGWsOBQ1x4Ig3QvUT4p
	KSUpasfjo0TsmkAwPkEqgaQHL3QGlUBx/BYPO2xHJ4X94CioHUbznBOspmacfLdP
	6PTx/gDUdUi1VF+xvxhQ0n1/j87V3gp23X8d6PvR3fTC7cXeoLt/hfCKUo96aBo9
	oWFCRpV5lhRMHGeXlr+Ff1bmoH20f+CyFVFGW6nmsm9mo5p1EFD/yJ0R3m8e0JCt
	HIBorzSzSEIut16KK5Z85BCWdGSOeh63epw==
X-ME-Sender: <xms:WoOfacneObhUYfo7lJnGkf_6BuUgYQ0Pbj24Db-elx_DmnSWuTQ8gQ>
    <xme:WoOfaStYRTnEg3gKwCDzrXRtTowmyDzxJYcco9LyTgA5mx2cI89JYuIwUW6LCX5EC
    4KVQmeMunlSta80xIpUxVOQgcH2JApTbvvoo-H6FDtwVfSXNuPyaA>
X-ME-Received: <xmr:WoOfaS-_c-SUtC5_FLrxyCubHv9R0hPxUAJ_aRpC8nJvRgZeo4NvR9BXYxRyK_pUbZ6qP-nTppf7QkH5YRr-8BuSHzHc8q4qzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeggedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:WoOfaUPLAcpL9Fw_Z_bvBT0E17NEQ91rU8h3FiquigzdOTb3CkNlFw>
    <xmx:WoOfaYF6O1DKM-7GbSpQpBMtStRiG2Dc1tHUptQ0oM8e8f0mfeO17w>
    <xmx:WoOfaaRoS2oQtI-sIrlD_0ylPLnbEGgVx-3ks0gQj1gakiwcj0ZB-w>
    <xmx:WoOfadstiAeRRWcR0UE6jmve4XtZxsOLpmD_vz2kSR2qklQ0-4Oo8g>
    <xmx:WoOfaWsU3GLotn9yOqLWVnDzaK0_R47xkfEwrI4q16tOdSRxlkUxjBDU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 18:18:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
    Jeff King <peff@peff.net>
Subject: Re: [PATCH v29 2/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <6a88f41fa52e7b24fdb75dda6cac692014cebbf6.1772056263.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 25 Feb 2026
	21:51:03 +0000")
References: <pull.2138.v28.git.git.1769112471.gitgitgadget@gmail.com>
	<pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
	<6a88f41fa52e7b24fdb75dda6cac692014cebbf6.1772056263.git.gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 15:18:48 -0800
Message-ID: <xmqq1pi876p3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static char *resolve_compare_branch(struct branch *branch, const char *name)
> +{
> +	const char *resolved = NULL;
> +
> +	if (!branch || !name)
> +		return NULL;
> +
> +	if (!strcasecmp(name, "@{upstream}"))
> +		resolved = branch_get_upstream(branch, NULL);
> +	else if (!strcasecmp(name, "@{push}"))
> +		resolved = branch_get_push(branch, NULL);

As one of the if/else if/ cascade needs {} around a multi-statement
block, everybody else needs {}.

If the current branch does not have @{upstream}, we will silently
receive NULL in resolved, and return NULL from here, which is
exactly what we want.  The same stroy for missing @{push}.

Sounds very sensible.

> +	else {
> +		warning(_("ignoring value '%s' for status.compareBranches; only @{upstream} and @{push} are supported"),
> +			name);
> +		return NULL;
> +	}

I don't know if which one between the above "warning" and
die("unknown/unsupported") is a better design.  In any case, the
warning() line is overly long and needs to be wrapped (my litmus
test to complain about "overly long lines" is after losing three
columns to the left for "> +" in e-mail quote like the above the
right edge of the line does not fit on my 92-column terminal, which
will never happen if you stick to the official "fit 80-column after
quoted for a few times in e-mail" guideline).

>  static void format_branch_comparison(struct strbuf *sb,
>  				     bool up_to_date,
>  				     int ours, int theirs,
>  				     const char *branch_name,
>  				     enum ahead_behind_flags abf,
> -				     bool show_divergence_advice)
> +				     unsigned flags)
>  {
> +	bool enable_push_advice = (flags & ENABLE_ADVICE_PUSH) &&
> +		advice_enabled(ADVICE_STATUS_HINTS);
> +	bool enable_pull_advice = (flags & ENABLE_ADVICE_PULL) &&
> +		advice_enabled(ADVICE_STATUS_HINTS);
> +	bool enable_divergence_advice = (flags & ENABLE_ADVICE_DIVERGENCE) &&
> +		advice_enabled(ADVICE_STATUS_HINTS);


You do use enable_push_advice twice so that reduces repetition a
little bit, but other than that, I am not sure if the above makes it
easier to follow the code.

Especially, the roundabout way these three variables are computed,
together with the fact that ENABLE_ADVICE_* are not really about
"enabling", but the caller decides that it is an applicable advice
(e.g., ENABLE_ADVICE_PULL is passed when the iteration over
branches.items[] the caller is making is on the upstream branch and
"you should pull" is the appropriate situation.  It is more like
"advice-pull is applicable in this situation", unlike what the
advice_enabled() returns, which is "the user wants this kind of
advice messages"), I find the resulting code below somehow harder to
follow than without these intermediate variables.  If they were
named "use_*_advice" (instead of "enable_"), perhaps I may find it
more palatable.

I find it a lot more disturbing that what the caller specifies in
flags and advice_enabled() is pre-combined in these variables.
Perhaps splitting them into two separate concerns, like this ...

	bool use_push_advice = (flags & USE_ADVICE_PUSH);
	bool use_pull_advice = (flags & USE_ADVICE_PULL);
	bool use_divergence_advice = (flags & USE_ADVICE_DIVERGENCE);

	...
	if (use_pull_advice && advice_enabled(ADVICE_STATUS_HINTS))
		... you should pull first ...

... may make it easier to understand and follow?  I dunno.


> -		if (advice_enabled(ADVICE_STATUS_HINTS))
> +		if (enable_push_advice)
>  			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
>  				    "git status --ahead-behind");


> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 0b719bbae6..aa9456bb61 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -292,4 +292,339 @@ test_expect_success '--set-upstream-to @{-1}' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'status tracking origin/main shows only main' '
> +	(
> +		cd test &&
> +		git checkout b4 &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch b4
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 2 commits.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status --no-ahead-behind tracking origin/main shows only main' '
> +	(
> +		cd test &&
> +		git checkout b4 &&
> +		git status --no-ahead-behind >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch b4
> +	Your branch and ${SQ}origin/main${SQ} refer to different commits.
> +	  (use "git status --ahead-behind" for details)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'setup for compareBranches tests' '
> +	(
> +		cd test &&
> +		git config push.default current &&
> +		git config status.compareBranches "@{upstream} @{push}"
> +	)
> +'

Shoudln't this be part of the next test, with its own teardown?
I.e.,

	test_expect_success 'check both @{upstream} and @{push}' '
        	test_config -C test push.default current &&
        	test_config -C test status.compareBranches "..." &&

		git -C test checkout main &&
		git -C status >actual &&
		cat >expect <<-EOF &&
		...
		EOF
		test_cmp expect actual
	'

> +test_expect_success 'status.compareBranches from upstream has no duplicates' '
> +	(
> +		cd test &&
> +		git checkout main &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch main
> +	Your branch is up to date with ${SQ}origin/main${SQ}.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'

That way, the tests can be kept more independent from each other,
and will clean after themselves, which means that we do not have to
assume that ...

> ...

> +test_expect_success 'clean up after compareBranches tests' '
> +	(
> +		cd test &&
> +		git config --unset status.compareBranches
> +	)
> +'

... this step will never be skipped or fail, which would result in
disturbing the tests that come after this step.

In any case, the design of the main part of the patch is looking
much nicer than the open-ended one we saw previously.

Thanks.

