Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20802222C7
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876791; cv=none; b=hwmztdxvaHZO8gGOxa6ztMlZuoT6kGq9lNuxTKVHDNEiJY80NiSmwzTra/+CmqHHe+8I2BwNpq2bVg5hYSOxY5Nkc+UzqYl6nyDCoWJraB3WElIxEJxvsY1/x5ufYmgK/xy35hr7TXd2gF/G6zSCVjoquXEFHrhDm5jLtXcd8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876791; c=relaxed/simple;
	bh=LJElhgkCn0K5qhdzXRaqsmER7Atw49JqCIzg0yQ3jy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iKXai1A/MEGOqbsdmsKurVof5J6BiW0hTw6o6jBvU4Dtx7F9uOIdCpsVEAuaXb2k+AfYe4axJY+h99l9SDjcO0dcHHlHOlXSocxDtjeYrwAJTRcnC+t0HeULWjqxQFDep8SlC5C1RRLOqVU4SGPRcs4MmLxNh9cbVY6trau8Av8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mUHtEM2R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbS3us3i; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mUHtEM2R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbS3us3i"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EF2E7A00AA;
	Fri, 18 Jul 2025 18:13:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 18 Jul 2025 18:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752876786; x=1752963186; bh=5PkdNuqb+/
	6Fkl3IyH62qh4uXNLb3LjkEtGK8jvDRtc=; b=mUHtEM2R0Q7m8Q7gPhJoEKptl3
	nvJEY3ScjzMYfT602IZeLxJGkRnope1IcCjBjpJkihLL21ABoEF8y4iRZFrCUimd
	ppg1JzQfmlj9qYaUsvJSLqUXrXK55UZsOQaQ0qrangJq4zuH6yESV0EDC13xSzdL
	THPSuh4YTKR9Ra/6AWQ5F/9vqou7/t/ZVYPse3WMR8cC3C6snBEULhmKzlmZ18VW
	AZUSgc2xrwtAKiOE2S/2qVZguUC3w53tPamzcCOhDY5MUEC3agrnyKT9weDJB7b2
	HhApfo9yNk8EAF2FtwTLXbjc7pc+Ksh9ty3SQAgFKe2GE+ZhBsPPi3vmAC8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752876786; x=1752963186; bh=5PkdNuqb+/6Fkl3IyH62qh4uXNLb3LjkEtG
	K8jvDRtc=; b=TbS3us3imDKmSzUQq7Olf7KvGZKWSrVbwjFEssMCLaJjxsiMnHg
	dYsCsVUBs6x4ksHaseXDFOGtoxLApWj9qjgHSyIoKjOt4wM3zU3Jdml/rdlcL5nH
	Vudfybrq4EOzNors6mvRcjTJ0k/2rufSXo+igDGZpC70KJL4eE7+/6RQh9aNin7i
	/fU39IR8GVC2mnWxeKdahCs/jgWjmVrsUnp3Hl2fjcSiR5L6K2v8ztiYd0uyWqeB
	7Ng8cS51db6CGDU6cLtO6qkhSvyIBFzFWIKPtaDH1ISrVVOi+PRw7WjMsOjY/V2M
	Dzku038wypx4x5Gy5+iwmtGkA0Sl3dOgQWg==
X-ME-Sender: <xms:8sZ6aEedePXc6KGVzTgfXUA_YtOmvkpCcYpVz4slRI_sj2OXc_J0qA>
    <xme:8sZ6aBtULxQM2CHlS6u1aUADr0zC6SpCf0pX6KZteiGjeAhzn2ikG1HD2vMfY7v4r
    3CLupLhAvsgXtqDwg>
X-ME-Received: <xmr:8sZ6aL87PJZRcyRIsLyHkOtdFLQiVVx-0tvA0Babdz9mk5Cxfa5cQefNDx5Cpuy4Dn104ETSBj3RMMB6gkRpeY5au-AOuitMvhhR9sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihlughhohhm
    vgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehhiheslhhoohhpihhnghdrmhgvpdhrtghpthhtohep
    jheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:8sZ6aE3HfAD7QL78DmODljAH7uFOVXXUZ8YztLY7dymermoFmcjCkA>
    <xmx:8sZ6aIBjKNUVvfZ6XlCJohZsYiDh5sd-tZraSRKp2WrafVCRmsbX7A>
    <xmx:8sZ6aIel0BubCYCLqeaXACzzRSF4_Ztj1AMI6ZuaRrZTEybNuNGObA>
    <xmx:8sZ6aN4Fc-6QJ2tMNVSZs2qLjeci3D8O7tzrEU0vyVoZpoERp9mPYA>
    <xmx:8sZ6aNm-m-VN6ue8BSThyQayX2yE4GqLx3Z46fIV9mmSWhbjYJqJY-zk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 18:13:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  hi@looping.me,  j6t@kdbg.org
Subject: Re: [PATCH] pull: add pull.autoStash config option
In-Reply-To: <20250718035221.2293-1-yldhome2d2@gmail.com> (Lidong Yan's
	message of "Fri, 18 Jul 2025 11:52:21 +0800")
References: <20250717030732.75106-1-yldhome2d2@gmail.com>
	<20250718035221.2293-1-yldhome2d2@gmail.com>
Date: Fri, 18 Jul 2025 15:13:04 -0700
Message-ID: <xmqqjz45172n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> Git uses `rebase.autostash` or `merge.autostash` to determine whether a
> dirty worktree is allowed during pull. However, this behavior is not
> clearly documented, making it difficult for users to discover how to
> enable autostash, or causing them to unknowingly enable it. Add new
> config option `pull.autostash` along with its documentation and test
> cases.
>
> `pull.autostash` provides the same functionality as `rebase.autostash`
> and `merge.autostash`, but overrides them when set. If `pull.autostash`
> is not set, it falls back to `rebase.autostash` or `merge.autostash`,
> depending on the value of `pull.rebase`.

Very well reasoned and described.

> diff --git a/Documentation/config/pull.adoc b/Documentation/config/pull.adoc
> index 9349e09261..3aa1e67923 100644
> --- a/Documentation/config/pull.adoc
> +++ b/Documentation/config/pull.adoc
> @@ -13,6 +13,17 @@ pull.rebase::
>  	of merging the default branch from the default remote when "git
>  	pull" is run. See "branch.<name>.rebase" for setting this on a
>  	per-branch basis.
> +
> +pull.autoStash::
> +	When true, Git will automatically perform a `git stash` before the
> +	operation and then restore the local changes with `git stash pop`
> +	after the pull is complete. This means that you can run pull on a
> +	dirty worktree. If `pull.autostash` is set, it takes precedence over
> +	`rebase.autostash` and `merge.autostash`. If `pull.autostash` is not
> +	set, it falls back to `rebase.autostash` or `merge.autostash`,
> +	depending on the value of `pull.rebase`. This option can be
> +	overridden by the `--no-autostash` and `--autostash` options of
> +	linkgit:git-pull[1]. Defaults to false.
>  +
>  When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
>  so that the local merge commits are included in the rebase (see

The new text is inserted at a wrong spot.  This "+\nWhen `merges`"
is a continuation of the text that describes `pull.rebase`.  If that
is set to `true`, one thing happens.  If that is set to `merges`,
something else happens.

Insert the text for `pull.autoStash` immediately before the
description of the `pull.octopus` configuration variable.

As to the text itself, "you can run pull on a dirty worktree" may
not be what you want to say here, for a few reasons.

 * (pedantic) Even without the configuration variable set, you can
   run "git pull" in a dirty working tree; it just will refuse to do
   any damage until you stash the local changes away yourself.

 * If your "git pull" merges, it would work even in a dirty working
   tree as long as your local change doesn't overlap with what the
   merge would bring in.  This is quite useful for a maintainer with
   "upcoming" change to GIT-VERSION-GEN always updated locally in
   the working tree and not having to worry about pulling from
   contributors and submaintainers who won't usually be touching
   that file, for example.

 * Not limited to this instance, when you have to say "(This|It)
   means <<B>>" immediately after making a statement <<A>, I would
   like us to think if we can just say <<B>> without saying <<A> at
   all.  In this case, it is not so, which makes me suspect that
   perhaps we do not even want to say <<B>>, as it may not mean
   <<B>> after all.

Here is my attempt.

    When set to true, automatically create a temporary stash entry
    to record the local changes before the operation begins, and
    restore them after the operation completes.  When your "git
    pull" rebases (instead of merges), this may be convenient, since
    unlike merging pull that tolerates local changes that do not
    interfere with the merge, rebasing pull refuses to work with any
    local changes.
+
If `pull.autostash` is set (either to true or false),
`merge.autostash` and `rebase.autostash` are ignored.  If
`pull.autostash` is not set at all, depending on the value of
`pull.rebase`, `merge.autostash` or `rebase.autostash` is used
instead.  Can be overridden by the `--[no-]autostash` command line
option.

> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 63c9a8f04b..134da2185c 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -472,6 +472,96 @@ test_expect_success 'pull --no-autostash & merge.autostash unset' '
>  	test_pull_autostash_fail --no-autostash --no-rebase
>  '
>  
> +test_expect_success 'pull succeeds with dirty working directory and pull.autostash set' '
> +	test_config pull.autostash true &&
> +	test_pull_autostash 1 --rebase &&
> +	test_pull_autostash 2 --no-rebase
> +'

Most trivial case.  No command line override.

> +test_expect_success 'pull --autostash & pull.autostash=true' '
> +	test_config pull.autostash true &&
> +	test_pull_autostash 1 --autostash --rebase &&
> +	test_pull_autostash 2 --autostash --no-rebase
> +'

Command line override specifies the same behaviour as the
configuration, so we cannot learn much from this test.  It still
should keep working, so the test is worth having [*], but I wonder
if makes sense to combine the above two into one test, i.e. set the
configuration variable to true once, and then try --rebase and
--no-rebase with and without --autostash (four combinations).

    [*] In this review, unless I explicitly say "this test is wrong
    and expects an incorrect result", they are not wrong, even
    though what they test may not be as interesting as others, and I
    am not suggesting its removal.  This is one of these tests.

> +test_expect_success 'pull --autostash & pull.autostash=false' '
> +	test_config pull.autostash false &&
> +	test_pull_autostash 1 --autostash --rebase &&
> +	test_pull_autostash 2 --autostash --no-rebase
> +'

Configuration should be overridden by the command line option, which
is a good thing to test.

> +test_expect_success 'pull --autostash & pull.autostash unset' '
> +	test_unconfig pull.autostash &&
> +	test_pull_autostash 1 --autostash --rebase &&
> +	test_pull_autostash 2 --autostash --no-rebase
> +'

Another most trivial case.  Shouldn't we already have an existing
test for this, back from the days before pull.autostash got
introduced, since the command line option has been there all along?

> +test_expect_success 'pull --no-autostash & pull.autostash=true' '
> +	test_config pull.autostash true &&
> +	test_pull_autostash_fail --no-autostash --rebase &&
> +	test_pull_autostash_fail --no-autostash --no-rebase
> +'

Configuration overridden by the option, opposite of what we saw
earlier, which is another good thing to test.

> +test_expect_success 'pull --no-autostash & pull.autostash=false' '
> +	test_config pull.autostash false &&
> +	test_pull_autostash_fail --no-autostash --rebase &&
> +	test_pull_autostash_fail --no-autostash --no-rebase
> +'

Uninteresting test that does not tell us much; we cannot tell which
between the configuration and the command line option caused us not
to auto stash with this test.

Two cases that may be worth adding to this test immediately after
setting pull.autostash to false are:

	test_pull_autostash_fail --rebase &&
	test_pull_autostash_fail --no-rebase &&

> +test_expect_success 'pull --no-autostash & pull.autostash unset' '
> +	test_unconfig pull.autostash &&
> +	test_pull_autostash_fail --no-autostash --rebase &&
> +	test_pull_autostash_fail --no-autostash --no-rebase
> +'

Another uninteresting case that probably should be already covered
by existing test, since this tests "what happens when autostash is
explicitly declined from the command line when there is no
configuration variable to intervene?".

> +test_expect_success 'pull.autostash=true & rebase.autostash=true' '
> +	test_config pull.autostash true &&
> +	test_config rebase.autostash true &&
> +	test_pull_autostash 1 --rebase
> +'

OK.  Perhaps make sure "--no-autostash --rebase" would fail while at
it in the same test?

> +test_expect_success 'pull.autostash=true & rebase.autostash=false' '
> +	test_config pull.autostash true &&
> +	test_config rebase.autostash false &&
> +	test_pull_autostash 1 --rebase
> +'

This is more interesting than the previous one, as we make sure that
pull.* trumps rebase.* with this test.  Perhaps throw --no-autostash
specified on the command line into the mix?

> +test_expect_success 'pull.autostash=false & rebase.autostash=true' '
> +	test_config pull.autostash false &&
> +	test_config rebase.autostash true &&
> +	test_pull_autostash_fail --rebase
> +'

Another good one.  It might be intereseting to test --no-rebase and
make sure it also fails?  I dunno.

> +test_expect_success 'pull.autostash=false & rebase.autostash=false' '
> +	test_config pull.autostash false &&
> +	test_config rebase.autostash false &&
> +	test_pull_autostash_fail --rebase
> +'

Not as interesting as others.

> +test_expect_success 'pull.autostash=true & merge.autostash=true' '
> +	test_config pull.autostash true &&
> +	test_config merge.autostash true &&
> +	test_pull_autostash 2 --no-rebase
> +'

Not as interesting as others.  Throw --no-autostash given on the
command line into the mix as well?

> +test_expect_success 'pull.autostash=true & merge.autostash=false' '
> +	test_config pull.autostash true &&
> +	test_config merge.autostash false &&
> +	test_pull_autostash 2 --no-rebase
> +'

OK.  pull.*=true trumps merge.*=false.  We test the other way around
next.  Good.

> +test_expect_success 'pull.autostash=false & merge.autostash=true' '
> +	test_config pull.autostash false &&
> +	test_config merge.autostash true &&
> +	test_pull_autostash_fail --no-rebase
> +'
> +
> +test_expect_success 'pull.autostash=false & merge.autostash=false' '
> +	test_config pull.autostash false &&
> +	test_config merge.autostash false &&
> +	test_pull_autostash_fail --no-rebase
> +'

Not very interesting.  Throw anothre that gives --autostash from the
command line in the mix, perhaps?

>  test_expect_success 'pull.rebase' '
>  	git reset --hard before-rebase &&
>  	test_config pull.rebase true &&


Whew.

I did not spot anything majory broken (except for the location to
which the new documentation paragraph goes) in the patch.  Nicely
done.

Thanks.
