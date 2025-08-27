Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8667207A0B
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320067; cv=none; b=AwLbsvVZoldwMV+XLmncLzAdbRXUPGp5cxpHsXjtVMIiK0UztI8o3yxkPr+7d0skYC7fa2LecaHOzpoGFjfenrPUTtK+RJJGc/+ufHIF8K5l8OLbTZd4Hz6FP+82EuKbMYkGD4bn8iPiOmhiIoZTO/+L2YY4fGFwxEujaDHGN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320067; c=relaxed/simple;
	bh=kZCxeWk3OjYWMcV5eD9Lz8e9hl9w5apP7zjl4e+YK5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CKtoCJzboAbkufXdN1/3mQk5r0dlACHcUbVEW/ZUwcSP/iI5nMs1osez8Sbc+wULIlKPriU7DGQ4fTQRRrF86Y4vlJrGTnvMdODUBhWCy//5fdsxlwutWCxHqsojpi15b7CdmaLVZ+MFlAdXVi4mc9/8sF1s72TR9o0MQ6dcZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vdCOxz2+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJUmvrN5; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vdCOxz2+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJUmvrN5"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF8337A0061;
	Wed, 27 Aug 2025 14:41:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 27 Aug 2025 14:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756320063; x=1756406463; bh=tvYCRgVf8C
	zRkxgRG0K5pNB8Vli2VUx9lOesSCjh1So=; b=vdCOxz2+1CLQaZWP7uk4YA1Jm5
	40coSMs0AYpjObOOH9xIEY7iRnRbTAqupKWe+16QN54cLi8dznW1S/mDeEMOpNbU
	b8RO6EfqyT3dkgYJogEVfts8uOZl1TeUKk/vxDSHnoFJ2E/7USYbr2QXBy3TPyX0
	u1roH8odDMNuSL8Y0ryn6TM+iOx4Nh0dYE4wwiicuX1GQPDCJVGi3e6hu/g2e93c
	yL+TKRBz8mp+hR7Gt5Dv9QVRBKwBFIX3/QdYz3T1m8bxxZ9sFRUWP9OTSF6HVLY/
	zAQNfSvzsJEpWG/3MUeWuVQcj4gLiSi4sa2U1/LV1vdQfdkwxd859L1zKP9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756320063; x=1756406463; bh=tvYCRgVf8CzRkxgRG0K5pNB8Vli2VUx9lOe
	sSCjh1So=; b=bJUmvrN5QkL+OVmsUCdD+Fc/S/Mvg9JDvcdu3TTv5unZwNun0zz
	ZEb/BRCQeU/fDM0R2+EJziJ0V2abuXUxkF2kZdthBWmlRSKOMjWb+IacfW68e9CZ
	5Fp8VaxlS2r3pXpzONCChAbSBROzFmx0tiFS3VPuO8zhgdtl57UfHoHHwLFkL8dw
	PJBKKP/xHwxkmprIAGstcIMPtKf5f6PD8bWx0kH73UukDYn8UlTj+yv42bYcAR4Z
	n3+uPbzf9Q5GtIiutOzXMmicT7uIPrWtzy4G1W51+lbziDmgV4/31rYxrqKq/Mbu
	+6BDE+Q9HTzQh2YC2UGejnqOCa9RFJWu4hQ==
X-ME-Sender: <xms:P1GvaK6wa8AUeFsjhO8oWIJ8nl4eSbqwrz8uJB0Mateap_o1EMCWmg>
    <xme:P1GvaPYgERamFPLLxCdnYYch9OZH_o4r2sqKGXHnAubHCJyxRrSApFII3l5KTfygI
    kInccxiOWFkhvEUsQ>
X-ME-Received: <xmr:P1GvaP42UQWQ7VXXfgvQHPNsTzKRhoIS9wk_1AmP18RhzUqBkuGsqrn-IQmPWhOaHf83SZgpskxfTYvXQ9X0drE6jMh1_-0uf4_9hgM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpth
    htohephhhurghnghhsvghnfeeiheesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:P1GvaCBbOmZODde8E0lkKMXhcBSeYYb47EHQrQC9ZnPldzqP2MfMiw>
    <xmx:P1GvaFfmM7qvP3sfVqrmFHHBPq7g9WEQePTmb2oPAQo5yyk0_uEuSA>
    <xmx:P1GvaBKFeAl0Tahs9cGUdxuAa2vMpkzHfvDQ598pdJYs5QBWvQhh6Q>
    <xmx:P1GvaA0W6I9WraezqndfCEnN_j9scjnlMEawfmmnld8vfdKGG1hwxw>
    <xmx:P1GvaJdpEzVpPalTVlmrpDXNzcExI_RLqunMDw_iotQHm4Hw5UAbwVEU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 14:41:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH 6/6] breaking-changes: switch default branch to main
In-Reply-To: <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Wed, 27 Aug 2025 16:24:50 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
Date: Wed, 27 Aug 2025 11:41:01 -0700
Message-ID: <xmqqplcgzjya.fsf@gitster.g>
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
> index f8d2eba061c..93922299321 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -165,6 +165,11 @@ A prerequisite for this change is that the ecosystem is ready to support the
>  "reftable" format. Most importantly, alternative implementations of Git like
>  JGit, libgit2 and Gitoxide need to support it.
>  
> +* The default branch name will be `main`. We have been warning that the default
> +  name will change since 675704c74dd (init: provide useful advice about
> +  init.defaultBranch, 2020-12-11). The new name matches the default branch name
> +  used by many of the big git forges.
> +

Good.

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

Good.  We might have to change it back to "(currently `main`)" again
but I do not see the need to prepare for such a re-rename.  As we do
not have the "currently", we can say

	... to the default name `main`.

without parentheses.

> +The default name can be customized via the `init.defaultBranch` configuration
> +variable.

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

Good.

> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 01823fd0f14..a21834043f3 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -9,7 +9,6 @@ run_tests=t
>  
>  case "$jobname" in
>  linux-breaking-changes)
> -	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main

Questionable.

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

Good.

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

Questionable.

> +	if (!ret && repo_config_get_string(r, config_key, &ret) < 0)
>  		die(_("could not retrieve `%s`"), config_display_key);
>  
>  	if (!ret) {
> +#ifdef WITH_BREAKING_CHANGES
> +		ret = xstrdup("main");
> +		(void) quiet; /* Silence -Wunused-parameter */
> +#else
>  		ret = xstrdup("master");
>  		if (!quiet)
>  			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
>  					  _(default_branch_name_advice), ret);
> +#endif /* WITH_BREAKING_CHANGES */

Very good.

Thanks.
