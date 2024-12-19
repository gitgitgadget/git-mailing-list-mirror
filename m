Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305235948
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633058; cv=none; b=bgwngeU5jB2uFcPjAHXtP+F2T6kI07WDIkuno3jc9w9PmuyUtKt+crRxlg5X0yBHLHfyEkMLJUb1EAd0oeLWvlTGhvS6TnEJZqlSszeK6dfak74WzF2aVdvB3eVkdxzxg3MIuotqBsTResQpJWOTVhKs/EG6MBUTLdFvwWMDnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633058; c=relaxed/simple;
	bh=jvX1e3ewC2yXv3p3yz/nDXpf3QU1owV0gFHPP/rt88c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=irKm6rYpzS2TPn/wQItGdHTNmkkz04DwxtJNTUl8u8Mh534InPreugnSi3qGqwIVj/eshFaaAsGb2+AmKw720Uf3x4gbvEYP/Q2bSc/7pOi9hc14L36X73gbNGMP7frN/5HYEE+k+zVleFgoYy9Z6IzZOBkOlCQNX8yg5KyM4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K1ybl3yf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f3SjfUIC; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K1ybl3yf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f3SjfUIC"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D0C3E1140186;
	Thu, 19 Dec 2024 13:30:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 19 Dec 2024 13:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734633053; x=1734719453; bh=ZEDyPR29HM
	8KytmhPHzqvpRYBo4+EJh9xGJG/POCvMY=; b=K1ybl3yf34t7yYCl11ksKCyEk4
	Ik/mjU7YRet0H36hX87aAEUOZdYSZQ8np8Bs6Ow2fCP01iPzrGWo9rwpNOl3zFbi
	6RsJDzNWprYiFwndRe1f0RaMV9iJaATLKPhxMdDfEITVIAOownviB79iwGTUToZj
	pDQ3yNVYGkzPDfTIEtBxOnse7AFRVu7D2mUkwkmgdULICpKXO4VrErrsi65XDUpV
	KHt73W/GlXMvTmx/4sfhINQ0uVn9wlb1qANeeqG/44gU7cZee94ZjjCxkhGNNR1A
	3QrmO4mzs7EmISYoisXQiRgLwypXV6MjecZPv6vVV8bfCu4WKRe7tKyH/ODg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734633053; x=1734719453; bh=ZEDyPR29HM8KytmhPHzqvpRYBo4+EJh9xGJ
	G/POCvMY=; b=f3SjfUICo6r4o9Ey+4z7NrLqtBRb20v22lyiUYtp3U1igjk2e5f
	tX/5QM0GEzlJRS8+r0YE1H8Q76IWxmhUYLN6ABe8CUsvCCIuLDJB5jvEACAnz3ZH
	N/VJxDm79GG/Vv5jqb7O1VLxDWoR+UkuWKj2pg1E+7vNX5vzMj818Xndr7f5ET+O
	WFJF+X0cQie9O4FOpgRdnCHOAR7P7aA7JPGigkyora+6YzCZD3I2wfVysC927aK+
	h/QbGCq9ENj19akIxvY+ZXJ8sbVjZRAZRlIigoa/bSDHIZWtdUrD2+dbYsyp+aoN
	SmuwVX+2Yh/Rw5EsE07HyJpwqpL3v/XVXGw==
X-ME-Sender: <xms:XWZkZ8Opxmp8jEkwIDc4Az7bDVbIgr34_Q4ilTGlEYu4lAyUTxzK9A>
    <xme:XWZkZy-W1dRgtTkrR7dt0dzjcXEEOd56F3xLPyDxn-DmcZfasoHQcgy8irGsiuhGM
    lgYxM90uuWLkR5Yug>
X-ME-Received: <xmr:XWZkZzSEk7CBYhPHknl_0VyOFoEafZA_VdvRhnWynBzcuML20U94npJkJIkYAS8uXpq3xNQdn5nP1IFWjnMPqkjfHY9TtnQJHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhhsuhgthhgrnhgvkhesshhushgvrdguvgdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XWZkZ0tuafRa8VZ8v65xhox7thEb4kCJz19XFWqpaq4-xVWyi0t1jw>
    <xmx:XWZkZ0ccY71fX2WRrMrM3a51dLS5klZOsdGY8eCm802vmXIKQIHZ2g>
    <xmx:XWZkZ41w9dLxIByaCJ-yY2A7WJ7kyUF-25c4C3jLkd2xZUmEZv0Mtg>
    <xmx:XWZkZ48rOdDSysmVnX0ujA3txZnHqIszW6qSwLqqimYWOPGcA2bhGA>
    <xmx:XWZkZysKHVXeIV0yJ-KCVMEq7oTaW43ZRTjJcVsdDQ6-3dR90XCPZKuh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 13:30:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] builtin/clone: teach git-clone(1) the --revision=
 option
In-Reply-To: <20241219-toon-clone-refs-v3-1-1484faea3008@iotcl.com> (Toon
	Claes's message of "Thu, 19 Dec 2024 12:58:50 +0100")
References: <20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com>
	<20241219-toon-clone-refs-v3-1-1484faea3008@iotcl.com>
Date: Thu, 19 Dec 2024 10:30:51 -0800
Message-ID: <xmqqh66zikys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> The git-clone(1) command has the option `--branch` that allows the user
> to select the branch they want HEAD to point to. In a non-bare
> repository this also checks out that branch.
>
> Option `--branch` also accepts a tag. When a tag name is provided, the
> commit this tag points to is checked out and HEAD is detached. Thus
> `--branch` can be used to clone a repository and check out a ref kept
> under `refs/heads` or `refs/tags`. But some other refs might be in use
> as well. For example Git forges might use refs like `refs/pull/<id>` and
> `refs/merge-requests/<id>` to track pull/merge requests. These refs
> cannot be selected upon git-clone(1).
>
> Add option `--revision` to git-clone(1). This option accepts a fully
> qualified reference, or a raw commit hash. This enables the user to
> clone and check out any revision they want. `--revision` can be used in
> conjunction with `--depth` to do a minimal clone that only contains the
> sources for a single revision. This can be useful for automated tests
> running in CI systems.

I somehow suspect that you want the mental model your users form
for this new feature to be "--single-branch --branch=<branch>" mode
of "git clone", not just "--branch=<branch>".  This is especially true
when you bring up the possibility of the "--depth" option.

The difference between "git clone" and "git init" followed by "git
fetch" is not just "the user does not have to type two commands if
the feature is inside clone".  That is merely a superficial
difference, and the real value is that "clone" leaves configuration
to make further work easier.

For the "--branch" option the user's mental model for this new
feature is based on, "git clone" gives the usual fetch pathspec
and the branch.merge configuration to make it build on top of the
single remote branch we cloned, i.e. you'd get

	[remote "origin"]
		url = $URL
		fetch = +refs/heads/*:refs/remotes/origin/*
	[branch "next"]
		remote = origin
		merge = refs/heads/next

with "git clone --branch=next $URL".  

But after "git clone --single-branch --branch=next $URL", you'd get

	[remote "origin"]
		url = $URL
		fetch = +refs/heads/next:refs/remotes/origin/next
	[branch "next"]
		remote = origin
		merge = refs/heads/next

After all, the user wants to work with this single branch, so we
only dedicate a single remote-tracking branch for that and ignore
everything else.

With that line of thought in mind, let's read on with this question
in mind: what configuration should this mode of "git clone" leave,
to make further work in the resulting repository easier?

> This type of shallow clone could also be achieved with the following set
> of commands:
>
>     git init the-repo
>     cd ./the-repo

OK.

>     git remote add origin <url>

Not a great idea, as it is likely to leave remote.origin.fetch
refspec that is overly wide.  Compared to "--single-branch --branch"
case, I suspect that the resulting configuration should just record
remote.origin.url but not remote.origin.fetch or branch.*.* at all,
or something like that, to make sure we won't track any refs from
there.

>     git fetch --depth=1 origin <commit-id>
>     git checkout <commit-id>

OK, but "git checkout --detach <commit>" would make it clear that we
are not getting any local branch.

> Adding this new option to git-clone(1) simplifies this not uncommon
> use-case. And besides simplifying this, it enables the use of
> git-clone(1) over git-fetch(1). This is beneficial in case bundle URIs
> are available on the server. Bundle URIs are only used on clone, not on
> fetch, so using allowing the user to use git-clone(1) here makes them
> benefit from bundle URIs if advertised by the server.

That reasoning goes backwards.  If this wants to be really a
one-time "git fetch", but the lack of features like bundleURI
support in it makes your choice of tool unworkable, we should be
adding the support to your chosen tool, "git fetch".

As I already said, we should sell "clone" not for the stupid "the
user do not have to do init and fetch separately" reason, but "we
can tell what workflow is expected from the command line options
given to 'git clone', and configure the resulting repository
appropriately, which is not something init+fetch cannot do".

And when you sell it that way, bundleURI becomes totally a
non-issue (it becomes a mere bonus cherry-on-top).

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index de8d8f58930ecff305f79480b13ddce10cd96c60..67498dae7c7d0315c7026b4ca2e822e48dcb7479 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -221,6 +221,14 @@ objects from the source repository into a pack in the cloned repository.
>  	`--branch` can also take tags and detaches the `HEAD` at that commit
>  	in the resulting repository.
>  
> +`--revision` _<rev>_::
> +	This clones the given revision, and that revision only.

"that revision only" sounds like this option automatically forces "--depth=1",
but I do not think that is what we want.

	Create a new repository, and fetch the history leading to
	the given revision _<rev>_ (and nothing else), without
	making any remote-tracking branch, and without making any
	local branch, and point `HEAD` to _<rev_>.  When creating a
	non-bare repository, the revision is checked out on a
	detached `HEAD`.

or something?

> +	The argument can
> +	be a ref name (e.g. `refs/heads/main`) that peels down to a commit, or a
> +	raw commit hash.

"raw" -> "hexadecimal", "hash" -> "object name", but otherwise looks
good.  A ref-name may have an example for tag as well, i.e.

	(e.g., `refs/heads/main` or `refs/tags/v1.0`)

> +	The given revision is checked out, and for any revision other than a
> +	branch (i.e. ref starting with `refs/heads/`), the HEAD is detached.

"--revision refs/heads/master~4" start with "refs/heads/" but I do
not think you want to special case it.  You'd want to always detach
for consistency and simplicity.  If they want branch, the will say
"--single-branch --branch" instead of "--revision".

> +	This option is incompatible with `--branch`, `--mirror`, and `--bare`.

How does this intarct with "--single-branch"?  It is obvious and
natural to ignore "--single-branch" as you are not going to create
any local or remote-tracking branches, but should this be made
incompatible with "--no-single-branch"?  I dunno.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 21721db28a12864621d27d2c70ee5c2598cccc0f..391757e5260a902a87bcf3b435fe39c6cd841b3b 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -69,6 +69,7 @@ static char *option_template, *option_depth, *option_since;
>  static char *option_origin = NULL;
>  static char *remote_name = NULL;
>  static char *option_branch = NULL;
> +static char *option_rev = NULL;
>  static struct string_list option_not = STRING_LIST_INIT_NODUP;
>  static const char *real_git_dir;
>  static const char *ref_format;
> @@ -141,6 +142,8 @@ static struct option builtin_clone_options[] = {
>  		   N_("use <name> instead of 'origin' to track upstream")),
>  	OPT_STRING('b', "branch", &option_branch, N_("branch"),
>  		   N_("checkout <branch> instead of the remote's HEAD")),
> +	OPT_STRING(0, "revision", &option_rev, N_("rev"),
> +		   N_("clone single revision <rev> and check out")),
>  	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
>  		   N_("path to git-upload-pack on the remote")),
>  	OPT_STRING(0, "depth", &option_depth, N_("depth"),
> @@ -684,6 +687,9 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  	} else if (our) {
>  		struct commit *c = lookup_commit_reference(the_repository,
>  							   &our->old_oid);
> +		if (!c)
> +			die(_("unable to update HEAD"));

This new error condition becomes necessary, because you have no way
to verify the value given to --revision until you see it here, which
is understandable.

What are the failure modes and causes?  Can we give a bit more
useful diagnostics, like

 - the named object did not exist on the remote repository at all
 - failed to fetch the named object from the remote repository
 - fetched the named object and it turns out not to be a committish
 - something else?

> @@ -968,7 +974,7 @@ int cmd_clone(int argc,
>  	char *repo_to_free = NULL;
>  	char *path = NULL, *dir, *display_repo = NULL;
>  	int dest_exists, real_dest_exists = 0;
> -	const struct ref *refs, *remote_head;
> +	const struct ref *refs = NULL, *remote_head;
>  	struct ref *remote_head_points_at = NULL;
>  	const struct ref *our_head_points_at;
>  	char *unborn_head = NULL;

Offhand I do not see why this hunk is needed.

> diff --git a/parse-options.h b/parse-options.h
> index f0801d4532a175b65783689f2a68fb56da2c8e87..72c62311b61f46152d66bcba9328de59fd300df9 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -420,6 +420,15 @@ static inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
>  				  0, "");
>  }
>  
> +static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
> +					     int opt2, const char *opt2_name)
> +{
> +	die_for_incompatible_opt4(opt1, opt1_name,
> +				  opt2, opt2_name,
> +				  0, "",
> +				  0, "");
> +}
> +

Funny that we had 4 and 3 but did not need 2 until now ;-)

> diff --git a/t/t5620-clone-revision.sh b/t/t5620-clone-revision.sh

There already is a topic in flight that uses 5620 for its new test.

> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +
> +test_description='tests for git clone --revision'
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

> +TEST_PASSES_SANITIZE_LEAK=true
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit --no-tag "initial commit" README "Hello" &&
> +	test_commit --annotate "second commit" README "Hello world" v1.0 &&
> +	test_commit --no-tag "third commit" README "Hello world!" &&
> +	git switch -c feature v1.0 &&
> +	test_commit --no-tag "feature commit" README "Hello world!" &&
> +	git switch main
> +'

> +test_expect_success 'clone with --revision being a branch' '
> +	test_when_finished "rm -rf dst" &&
> +	git clone --revision=refs/heads/feature . dst &&
> +	git rev-parse refs/heads/feature >expect &&
> +	git -C dst rev-parse HEAD >actual &&
> +	test_cmp expect actual &&

This validates that the checked out commit is the same named commit,
but does not see whether we are on a detached HEAD or not.  Even
after we change the implementation to always detach, up to this
point the test will pass (I am not saying it is great.  I am saying
that the test is too loose to etch the desired behaviour in stone).

The next line, however, expects that we create a local branch for it
(the design I do not necessarily agree with---if this is wanted, the
user can already use --branch with --single-branch to do so).

> +	git for-each-ref refs/heads/feature > expect &&
> +	git -C dst for-each-ref > actual &&

Style: no spaces between redirection operator and its target file.

> +	test_cmp expect actual
> +'

We should check the configuration in the resulting repository.  If
we do not care what configuration "clone" leaves, we are not getting
the benefit of using it (you can just do init + fetch + checkout
instead).  This applies to all the remaining tests, so I won't repeat.

> +test_expect_success 'clone with --depth and --revision being a branch' '
> +	test_when_finished "rm -rf dst" &&
> +	git clone --depth=1 --revision=refs/heads/feature . dst &&
> +	git rev-parse refs/heads/feature >expect &&
> +	git -C dst rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'

We are not validating if the depth did its task correctly here.  We
do not test if the resulting repository has it checked out on the
detached HEAD.  We do not test if the resulting repository has the
local branch of the same name.

> +test_expect_success 'clone with --revision being a tag' '
> +	test_when_finished "rm -rf dst" &&
> +	git clone --revision=refs/tags/v1.0 . dst &&
> +	git rev-parse refs/tags/v1.0^{} >expect &&
> +	git -C dst rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'

It is a good idea to verify an annotated tag, as you never want to
write anything but a commit in HEAD.

Again, the tests are too loose to validate anything important.

> +test_expect_success 'clone with --revision being HEAD' '
> +	test_when_finished "rm -rf dst" &&
> +	git clone --revision=HEAD . dst &&
> +	git rev-parse HEAD >expect &&
> +	git -C dst rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'

Ditto.  I presume that this wants to detach and without any local or
remote-tracking branches left?

> +test_expect_success 'clone with --revision being a raw commit hash' '
> +	test_when_finished "rm -rf dst" &&
> +	oid=$(git rev-parse refs/heads/feature) &&
> +	git clone --revision=$oid . dst &&
> +	echo $oid >expect &&
> +	git -C dst rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'

Ditto.  It is common across many of the tests that they are too
loose and do not check much beyond the value of HEAD, which wants
corrected.  My recommendation for the behaviour is for all cases
they do not touch either local or remote-tracking branches and
always detach HEAD at the commit (or fail if a non-committish was
given), which means the all the tests (other than the ones that
makes sure the command fails under some conditions) should check
that the HEAD is detached at the expected commit and no local or
remote-tracking branches created.  This is shared among the rest of
the test, so I won't repeat.

Thanks.
