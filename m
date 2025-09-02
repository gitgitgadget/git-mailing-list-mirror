Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D25150997
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812993; cv=none; b=Jb1MmW9dr9C2D33VMIhj/ZaGC+OpqxgtjgeXJgcerMi0dC9ZewWHruNkC8769J3Kgfx6ETa3xTUHMlC3pUEFevIAkPDPTrhSjXS47tqmJn/9NokU0c4fP7Ky+5ZvDEI6uxYvuYB5SH77V9Aqn9I5OW+wnjVcnLPlEz1qKv7ehgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812993; c=relaxed/simple;
	bh=LbN3JaYl+EevCm6clbJp0IVY/dRcLy4DDziygf/ZEGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm45zR4elfTYrDxyW/i0iNOZ+IHvaJjddLVIezhH48l78aLOflGYYrBa0hH2fG0ZriqeEXx89tOJ1DiQZFU/e8spyPPLnrnzOGypFGEEEU7msHbOAc2lUlaptheIzonTrUW3fhEKY9Xt8YYxZMSPHQ0KXxVWqCWhW45GUhX0J9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f9UhGr4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMwAwvNW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f9UhGr4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMwAwvNW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B1BFC14000EA;
	Tue,  2 Sep 2025 07:36:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 02 Sep 2025 07:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756812990; x=1756899390; bh=tnflWkggMn
	sf03hPSbSRGP9pZiPUWhs8GHjMl2VzfeY=; b=f9UhGr4UyXQ1C2RSgmmo5Ewlan
	Ie3OzwJmNOVrlQUXlm2WSzG4HRfet/vme/39/Q2cZSawwU3lw3pZKcafE1Qj1w9y
	oK0oEr4YfIzxUrxtwTpUJS3rxdwS03hNAxpBOX9B9DUEptONUHRt/1XE70Tc6G93
	h6EGghCoJhybbKE2ztvxHCDh2DEFuenk65wUYvHgXK2PiPJYP5ZAN6aEtreaMUJq
	FZUnPT8KHYnDI7YbEH41Yah3ghOZ1o4zNQJBR9gaYXZ8WBPYCiJ1q2m0m8QKTtrz
	EPxIaSp65zhy9XRSWPQTQ4W6K6Vd85lwuE2rDVgzx/dFoaesmSeCtvdVZ/xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756812990; x=1756899390; bh=tnflWkggMnsf03hPSbSRGP9pZiPUWhs8GHj
	Ml2VzfeY=; b=HMwAwvNWTInnFvOJq9fZIG6sEqVofkTVFje99TA4Hi38uW7aHDY
	gCWzN/LYA55pZpberUKTeZ2FJmW1bzD0f1VJ2/B2/jM9pBgms9SDK9ZuPm4WcR5n
	+5bPyJu3ysvEws2CuPMltfD5Ex+o66lOzqytVShAY+Bj4a49uXWaxvi/2wggUrAU
	2tEG89zYvWzrBNvyMJdjdClWgnQZgd7FPu3zPhHHko1tV9X3FI9b+YNN/E9O6+Wd
	3limHfbTDxa/VXLbzLW3FgOu5BPMcRz7/XUPDrMr1bWUj3+41ZNCbuZQfSQg0uFI
	cmNa5fiPKHDD2bM0yD9D6rOz0UKEa5xp4wg==
X-ME-Sender: <xms:vta2aB8UFtWm9izlZtntecrUeaMXz5Fun86f06bif0qROET1vwI3yg>
    <xme:vta2aC0oJDSg1AW1IXL0BweW0s7l4jN_9UL26L6tgs_kMRH-rIbbmQQVi-npfqOWx
    xhMd3ffFJWV8VCL3g>
X-ME-Received: <xmr:vta2aODi9cJQ9n7BMIM04ShkLV7u2i77fpZheEQsdX2KNOcNQm5zZHSAE4SvZC0hZhWVzUxfDeGq2M5uMYGltvXdJi3xZlzn7txMU0ROMOywNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtd
    dtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohephhhurghnghhsvghnfeei
    heesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhi
    nhesghhmgidruggv
X-ME-Proxy: <xmx:vta2aGchQKmnXCUEXvDiy9j5239Mf2k7fYbzkbYhpmaI8yHY_dCIEA>
    <xmx:vta2aD4EtsJ9INwvu_CZCSFCHH7DipuGmhSZCoA1ckplQzVwDOTqsw>
    <xmx:vta2aBXdOmU-70zGc4B-JG_k17NCuXpHBpnMDu8GRSx66DB-5PNZaQ>
    <xmx:vta2aK5v-uV6fN2VengYNZMK5QTvJMI688xnZCYTybZ-OVzz16ho8g>
    <xmx:vta2aPYoits6H6O6CUT38ETrztso4WjKZzczrdp0gTO7B64CxeMb7hOn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 07:36:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c73cc1d4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 11:36:27 +0000 (UTC)
Date: Tue, 2 Sep 2025 13:36:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 6/6] breaking-changes: switch default branch to main
Message-ID: <aLbWuGQhriQCMFbO@pks.im>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>

On Wed, Aug 27, 2025 at 04:24:50PM +0100, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Since 1296cbe4b46 (init: document `init.defaultBranch` better,
> 2020-12-11) "git-init.adoc" has advertized that the default name

s/advertized/advertised/

> of the initial branch may change in the future. The name "main"
> is chosen to match the default used by the big git forge web sites.

s/git/Git/

> The advice printed when init.defaultBranch is not set is
> updated to say that the default will change to "main" in Git
> 3.0. Building with WITH_BREAKING_CHANGES enabled removes the advice,
> changes the default branch name is "main" and removes support for

s/is/to/

> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME. The code in guess_remote_head()

As Junio already mentioned, I don't really think it's necessary to drop
`GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME`, making much of this commit
series obsolete.

> that looks for "refs/heads/master" is left unchanged as that is only
> called when the remote server does not support the symref capability
> in the v0 protocol or the symref extension to the ls-refs list in the
> v2 protocol. Such an old server is more likely to be using "master"
> as the default branch name.

Hm, that's probably fair.

> With the exception of the "git-init.adoc" the documentation is left
> unchanged. I had hoped to parameterize the name of the default branch
> by using an asciidoc attribute. Unfortunately attribute expansion
> is inhibited by backticks and we use backticks to mark up ref names
> so that idea does not work. As the changes to git-init.adoc show
> inserting ifdef's around each instance of the branch name "master"
> is cumbersome and makes the documentation sources harder to read.
> 
> Apart from "git-init.adoc" there are some other files where "master" is
> used as the name of the initial branch rather than as an example of a
> branch name such as "user-manual.adoc" and "gitcore-tutorial.adoc". The
> name appears a lot in those so updating it with ifdef's is not really
> practical. We can update that document in the 3.0 release cycle. The
> other documentation where master is used as an example branch name
> can be gradually converted over time.

Agreed.

> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> index f8d2eba061c..93922299321 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -165,6 +165,11 @@ A prerequisite for this change is that the ecosystem is ready to support the
>  "reftable" format. Most importantly, alternative implementations of Git like
>  JGit, libgit2 and Gitoxide need to support it.
>  
> +* The default branch name will be `main`. We have been warning that the default

Let's explicitly mention here that this is only going to be the case for
_new_ repositories. It's obvious to us, but for others it might not be
that existing repositories will not see any change in behaviour due to
this.

> +  name will change since 675704c74dd (init: provide useful advice about
> +  init.defaultBranch, 2020-12-11). The new name matches the default branch name
> +  used by many of the big git forges.

s/git/Git/

> diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
> index a0dffba665f..39d4db6bccb 100644
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
> +(`main`).
> +endif::with-breaking-changes[]
> +The default name can be customized via the `init.defaultBranch` configuration
> +variable.
>  
>  `--shared[=(false|true|umask|group|all|world|everybody|<perm>)]`::
>  

This is ugly indeed, but we cannot do anything about that *shrug*

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

Okay. I don't really think it's necessary to conditionally compile this,
but it doesn't hurt much, either.

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
>  linux-TEST-vars)

Nice.

> diff --git a/refs.c b/refs.c
> index 4ff55cf24f6..e73f63ff6b8 100644
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
> @@ -639,24 +641,32 @@ static const char default_branch_name_advice[] = N_(
>  "\n"
>  "\tgit branch -m <name>\n"
>  );
> +#endif /* WITH_BREAKING_CHANGES */
>  
>  char *repo_default_branch_name(struct repository *r, int quiet)
>  {
>  	const char *config_key = "init.defaultbranch";
>  	const char *config_display_key = "init.defaultBranch";
>  	char *ret = NULL, *full_ref;
> +#ifndef WITH_BREAKING_CHANGES
>  	const char *env = getenv("GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME");
>  
>  	if (env && *env)
>  		ret = xstrdup(env);
> -	else if (repo_config_get_string(r, config_key, &ret) < 0)
> +#endif /* WITH_BREAKING_CHANGES */
> +	if (!ret && repo_config_get_string(r, config_key, &ret) < 0)
>  		die(_("could not retrieve `%s`"), config_display_key);
>  
>  	if (!ret) {
> +#ifdef WITH_BREAKING_CHANGES
> +		ret = xstrdup("main");
> +		(void) quiet; /* Silence -Wunused-parameter */

We have the `MAYBE_UNUSED` attribute that you can apply to `int
quiet` to avoid this cast.

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f593c536874..7223a98773d 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -868,7 +868,7 @@ test_expect_success 'overridden default initial branch name (config)' '
>  	grep nmb actual
>  '
>  
> -test_expect_success 'advice on unconfigured init.defaultBranch' '
> +test_expect_success !WITH_BREAKING_CHANGES 'advice on unconfigured init.defaultBranch' '
>  	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git -c color.advice=always \
>  		init unconfigured-default-branch-name 2>err &&
>  	test_decode_color <err >decoded &&
> @@ -883,16 +883,17 @@ test_expect_success 'advice on unconfigured init.defaultBranch disabled' '
>  	test_grep ! "hint: " err
>  '
>  
> -test_expect_success 'overridden default main branch name (env)' '
> +test_expect_success !WITH_BREAKING_CHANGES 'overridden default main branch name (env)' '
>  	test_config_global init.defaultBranch nmb &&
>  	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
>  	git -C main-branch-env symbolic-ref HEAD >actual &&
>  	grep env actual
>  '
>  
>  test_expect_success 'invalid default branch name' '
> -	test_must_fail env GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME="with space" \
> -		git init initial-branch-invalid 2>err &&
> +	test_must_fail env GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
> +		git -c init.defaultBranch="with space" \
> +			init initial-branch-invalid 2>err &&
>  	test_grep "invalid branch name" err
>  '
>  

Should we also add a test conditional on `WITH_BREAKING_CHANGES` to
verify that the new branch name is `main` as expected?

Thanks for working on this change, I'm very much supportive of this. It
feels like the ecosystem has already been moving into that direction, so
it's time that Git catches up with that change.

Patrick
