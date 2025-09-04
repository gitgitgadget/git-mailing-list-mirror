Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85718EAB
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007633; cv=none; b=FTsNfjNodCykbHr5GS06lWIlgYRCdNlZsddna3pJRIHFnQjJKgJdl6EO9PIOck5QCbM31zyE+hSn/rLv9Kcv654//fPknx7CJxGRci8FlYsscJ08akwwlk3Fb0f41dHHYwSeHwqFW/C/bXMLYeqWcOnHi/gGJ/H/qQqWAaS6xMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007633; c=relaxed/simple;
	bh=dFTLbdJ3Mwiuwl6YZPAruuYHQIxgXDZpycD3vk/P3Ag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O1vNdXBu8YvappcduEuk4Uoewa7KGlfVY+2qz4qyl5bZ7GdLBQoVcMy5qPTDhqRFYNErjhIuZg7nJPY4M+HKascJ1FbFCYd2JJ17qVy3KQR0kAyhXHhLMzPRKQ8DNl95v5ywnKRkVuxSBF2hj5+o4XLdxx686e4g0zx3KJ+9qjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pyjDqwKQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpA6Aq3I; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pyjDqwKQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpA6Aq3I"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 823CCEC034B;
	Thu,  4 Sep 2025 13:40:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 04 Sep 2025 13:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757007630; x=1757094030; bh=OpdHBlTqU2
	ugmpB34L3gKcwvcE1747CvkPhhelMnD9A=; b=pyjDqwKQ02Xfrk8dM35gv8Cg9Y
	MlPlbDKuDnH2I0uPpS+eFvIz3wzoIUgQdHzitjAvOEtwiMnKj/aHawleLlD9UkhY
	h0JtSYjyzV4atICgxlc9VPMXq85VhgPC3FB8XmEhfolcEdCpCLP2cG9Q1llLd6i0
	/I0jiUCerX7vCI5tCa9Z/VoY+H1T3d1p6VLxKy4KMZs1y0FU1rGi9q2jtSX+oSdw
	IcBaAvjjfGYGAM93Wfh2lyJF/YtxHWJ7w+nPyTXbZI64URdkxr6PZNNps6pzjfxT
	kSrYBvzENsRXPdPKk8XdCF7Dn1ukqznP0No0AxkFX2b5OXj4EgcZHmpZHfeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757007630; x=1757094030; bh=OpdHBlTqU2ugmpB34L3gKcwvcE1747CvkPh
	helMnD9A=; b=NpA6Aq3I7BqQBHZU2uPPNfQaoXKVHifOCzhTQH/4hrDy58c5KmI
	El9Xf42TM6WD/5SrH3vsoYWjYEGP8+tuBXAeXOu9aXik3qwp0cereRjLLaiUXWcx
	BppIYhyT6mHD9UCO+mCwp7RrQcedLvTHQkWbJFWfLLGvvPRH4hc6rJsJV1YkCXBZ
	uBQ1PLZUTu5jbv1Pp4dFoiMJgUHAzMillJmvwxxs0t7KKxZ8il2x/7hwWnr/O8FB
	HqJiP+41zHgIgqJRayhZUH+WhzEpz0K47m8lvnYeCvlmBMRc5baWu2JyECyaGLBZ
	ak7ZbnhiY/UxOiMy+n9xSGi+2GEeJKKIbgA==
X-ME-Sender: <xms:Ds-5aC3HqmPKlCibp941BXkL1fuy-E4PMjeUffYQQBiIY9vHPm0SjQ>
    <xme:Ds-5aNiW6MoItytNgLmcXBNAYtO4B3naJ87_sI8GBXRQVvGrNHUxPJISlwD9G4o_A
    BXhXvfS9bVYwoJi0A>
X-ME-Received: <xmr:Ds-5aLW5m5_5xEUxPogLaG8gOqXpZwxk4sgRpj3g5O4HSYDZmC98fWqFR8tuk8HtNUKLkSROz4hf0TyYN06j4Wtd_QUcC02-JlYv1sU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    ephhhurghnghhsvghnfeeiheesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ds-5aEV_eG3y6xaXtCJ6xJnN20HtgxCf1rt9Lo-TGdt0eH04KS0bVQ>
    <xmx:Ds-5aDhNcpej5mHvdTESN5U8OBvQuB7KdyRy-KPrD4Ebj_f6llgxFA>
    <xmx:Ds-5aHans_oU_wteSy2E7q_fgSlimZNehgmAmsZeur-Pf_sMYh0Kvw>
    <xmx:Ds-5aIpViNplXVLIWOvc8gBy8yfoHnS3BglN4HpJVC_d258rFp82uQ>
    <xmx:Ds-5aOnjlL-C4PW5dHLzLhOqWX2TfVUd0As94KH16YYAIGktLswJRqaB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 13:40:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/4] breaking-changes: switch default branch to main
In-Reply-To: <6986375dc379a646bb184be3cf7a018b2eb3eec7.1756992089.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 4 Sep 2025 14:21:29 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1756992089.git.phillip.wood@dunelm.org.uk>
	<6986375dc379a646bb184be3cf7a018b2eb3eec7.1756992089.git.phillip.wood@dunelm.org.uk>
Date: Thu, 04 Sep 2025 10:40:28 -0700
Message-ID: <xmqqjz2e86b7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> index f8d2eba061c..eb92e6f6a7d 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -165,6 +165,11 @@ A prerequisite for this change is that the ecosystem is ready to support the
>  "reftable" format. Most importantly, alternative implementations of Git like
>  JGit, libgit2 and Gitoxide need to support it.
>  
> +* In new repositories the default branch name will be `main`. We have been
> +  warning that the default name will change since 675704c74dd (init: provide
> +  useful advice about init.defaultBranch, 2020-12-11).  The new name matches
> +  the default branch name used by many of the big Git forges.

As I am not a native, this is a mere question and not a suggestion,
but my reading hiccups when I see the lack of comma after "In new
repositories".

"used by many of" -> "used for new repositories by many of"?

> diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
> index a0dffba665f..bab99b9b477 100644
> --- a/Documentation/git-init.adoc
> +++ b/Documentation/git-init.adoc
> @@ -77,9 +77,15 @@ If this is a reinitialization, the repository will be moved to the specified pat
>  `-b <branch-name>`::
>  `--initial-branch=<branch-name>`::
>  Use _<branch-name>_ for the initial branch in the newly created
> -repository.  If not specified, fall back to the default name (currently
> -`master`, but this is subject to change in the future; the name can be
> -customized via the `init.defaultBranch` configuration variable).
> +repository.  If not specified, fall back to the default name
> +ifndef::with-breaking-changes[]
> +(currently `master`, but this will change to `main` when Git 3.0 is released).
> +endif::with-breaking-changes[]
> +ifdef::with-breaking-changes[]
> +`main`.
> +endif::with-breaking-changes[]
> +The default name can be customized via the `init.defaultBranch` configuration
> +variable.

Good.  Both the text for post-3.0 period and the rephrasing of the
original for pre-3.0 period look good.

> diff --git a/advice.c b/advice.c
> index e5f0ff84491..48c49ee4145 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -51,7 +51,9 @@ static struct {
>  	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
>  	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
>  	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
> +#ifndef WITH_BREAKING_CHANGES
>  	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
> +#endif /* WITH_BREAKING_CHANGES */
>  	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
>  	[ADVICE_DIVERGING]				= { "diverging" },
>  	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },

Would there be folks who type "git init" to get a 'main' branch,
while trying to follow a recipe written in pre-3.0 days that assumes
the initial branch is called differently, and get confused after
seeing many commands written in the recipe for them to follow , like
"git checkout -b next master" fail?  Do they need a different advice
message to help them, i.e.e.g, 

    $ git init
    Initialized empty Git repository in /a/b/c/.git/
    hint: Since Git 3.0, an initial branch is 'main' these days.
    hint: If you need its name to be different (e.g. 'frotz'),
    hint: you can immediately rename it with "git branch -m frotz".
    hint: Disable this message with "got config set advice.foo false"

or something?  I dunno.  In any case, that will have to be a new and
different advice message, and defaultBranchName should not be reused
for that purpose, so the change in the the above hunk is fine.  I am
wondering if we need a new entry protected by the same #ifdef on the
#else side.

> diff --git a/advice.h b/advice.h
> index 727dcecf4a3..fc1dc872049 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -18,7 +18,9 @@ enum advice_type {
>  	ADVICE_AM_WORK_DIR,
>  	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
>  	ADVICE_COMMIT_BEFORE_MERGE,
> +#ifndef WITH_BREAKING_CHANGES
>  	ADVICE_DEFAULT_BRANCH_NAME,
> +#endif /* WITH_BREAKING_CHANGES */
>  	ADVICE_DETACHED_HEAD,
>  	ADVICE_DIVERGING,
>  	ADVICE_FETCH_SET_HEAD_WARN,

Ditto.

> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 01823fd0f14..a21834043f3 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -9,7 +9,6 @@ run_tests=t
>  
>  case "$jobname" in
>  linux-breaking-changes)
> -	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  	export WITH_BREAKING_CHANGES=YesPlease
>  	;;

OK.

>  linux-TEST-vars)

We have been very careful to make sure that none of our tests
implicitly rely on that the initial branch name will still be
'master' with the above.  Now we should make sure that none of our
tests implicitly assume that the initial branch name will forever be
called 'main'.  In the post-context, linux-TEST-vars arm has
something that forces the initial branch name to be 'master', and we
probably should keep it for a while to serve that purpose.

> diff --git a/refs.c b/refs.c
> index 4ff55cf24f6..149a8d1cec1 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -627,10 +627,12 @@ void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
>  		strvec_pushf(prefixes, *p, len, prefix);
>  }
>  
> +#ifndef WITH_BREAKING_CHANGES
>  static const char default_branch_name_advice[] = N_(
>  "Using '%s' as the name for the initial branch. This default branch name\n"
> -"is subject to change. To configure the initial branch name to use in all\n"
> -"of your new repositories, which will suppress this warning, call:\n"
> +"will change to \"main\" in Git 3.0. To configure the initial branch name\n"
> +"to use in all of your new repositories, which will suppress this warning,\n"
> +"call:\n"
>  "\n"
>  "\tgit config --global init.defaultBranch <name>\n"
>  "\n"
> @@ -639,8 +641,9 @@ static const char default_branch_name_advice[] = N_(
>  "\n"
>  "\tgit branch -m <name>\n"
>  );
> +#endif /* WITH_BREAKING_CHANGES */
>  
> -char *repo_default_branch_name(struct repository *r, int quiet)
> +char *repo_default_branch_name(struct repository *r, MAYBE_UNUSED int quiet)
>  {

And if we were to introduce a new advice to help people who still
expected the traditional name, this MAYBE_UNUSED would not become
necessary ...

>  	const char *config_key = "init.defaultbranch";
>  	const char *config_display_key = "init.defaultBranch";
> @@ -649,14 +652,18 @@ char *repo_default_branch_name(struct repository *r, int quiet)
>  
>  	if (env && *env)
>  		ret = xstrdup(env);
> -	else if (repo_config_get_string(r, config_key, &ret) < 0)
> +	if (!ret && repo_config_get_string(r, config_key, &ret) < 0)
>  		die(_("could not retrieve `%s`"), config_display_key);
>  
>  	if (!ret) {
> +#ifdef WITH_BREAKING_CHANGES
> +		ret = xstrdup("main");

... as we will have the same if (!quiet) advice sequence here,
protected with a different ADVICE_ thing.

> +#else
>  		ret = xstrdup("master");
>  		if (!quiet)
>  			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
>  					  _(default_branch_name_advice), ret);
> +#endif /* WITH_BREAKING_CHANGES */
>  	}
>  
>  	full_ref = xstrfmt("refs/heads/%s", ret);

Thanks.
