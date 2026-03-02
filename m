Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD46B349B16
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495574; cv=none; b=iuE9S3P06ZyWX3z5Y0tz66Y92XInqppYE2F1mGYNeIBaOAskVdcb6MsdyOKbswMhL0cCfaNitfKcWjfAMsc3fvLvodvX8EiOR9ayurg0QJLxy3SN6i+qXcDl6ubcWRDrjX0WSQAHM7YQF2jGXyaw5NEuBx/6NW71kKdjvO736A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495574; c=relaxed/simple;
	bh=Vp40/bEs90MUwUSw9OlKzZgvFnPCXcrnh4/ekSAXnSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G92utgp4aasr+SOe+JfIolWJzo534nYDZ8vdkw3n0xS9tyjll7tSHkhiRQqRVirW3XgiL4ZFBecYsdXPcUALwqF7rq3GGzyGfgz+IPNeBpOT22a0pX/BLJCnADiWoZFWjDuRUa7o4Y4MQoFuLvoQvM5hGK0hvWGwMjAK0Wj4dmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DdLF4Pw4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VIfltX46; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DdLF4Pw4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VIfltX46"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E63B140017E;
	Mon,  2 Mar 2026 18:52:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 18:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772495572; x=1772581972; bh=Ld/rVCqI8o
	X/EVyEm0chmyR3ESJNMLf5P1Zz3Gm5Lx8=; b=DdLF4Pw4xkO5hcQeipD3O4OEtG
	zCEjxoKFLVEiV7FVZbaFPQBkXyATayWICsiNOyYP5NGTNIA6zGjThAXwgnF8xFjw
	IRptuRqHwEMTEUSZyszsQ6CuvyYxUuBU3cbf17Jpul8Ncbzq4O9AVX32ZhoEYOdW
	AHPQrSqfNfTaa5Al5KPbJM2wdCa9EfNAH22N+TiNuW9FPJJdq3kdUVs/Chkg+48I
	vBgyStnFhSm6Fy3R4ukweXi3VioN63lBL8Y34am2FE8AFuAAb9JDRd4HuU9cyFh0
	lhYg1QWL5+vqMj50use8QhR8qsvo5KxBzgd9duD1n4a9vz+CP/0H8jEhOFzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772495572; x=1772581972; bh=Ld/rVCqI8oX/EVyEm0chmyR3ESJNMLf5P1Z
	z3Gm5Lx8=; b=VIfltX465ij8I6Lf3HbCtqEl3/8a1u65UOT0Eghw8YuSUOqSu7b
	D+DgVPnvmGYgem8g/Ko0qCAOAoVKytIKftFhZ4VhBMd0O10WTCBEuzMPTqmsfZQG
	GDclhtGy4lR+OLHqE5Gk2IKp+05jBt4JabkeEzsNM0i1udjosjjoNQjLF3FVlwoA
	gexmm7ZbXZ+8waxMmBBTX+y9K3J2BiBhwRLAsAHs9eecn1lqgS+w6cxq3CEbMnoZ
	u9CORL4D71d7/EgX2scnqdeSj2muqSrtPbEYlPcq7x9pfoEY5qwvKtqMuEaCwtNq
	xwY+XWfStzpt0uXWLa4G1JDwEAWLrZjXFRQ==
X-ME-Sender: <xms:0yKmac8RUX6Lw0CPAzpScRHSCJcD1WTaMrKCXxAFhyMUR-Cak1dCHw>
    <xme:0yKmabtPh-4rhz7fPk96behIKAq6ZWB9eDdcyb3RqnVfQrEsQAeCds10I9ABQM85H
    e_X2ybVZhoog01WRlLyGVTPH-Si4OeV6qct4k0HOseMkDCHT-40Cw>
X-ME-Received: <xmr:0yKmaXACjTkf5s44HbBROd04d-o4jE6RNUX4If-ZO3kmapH7iJsVCS244xSXMT0PeTmTvtBUEU9hOG4tzwylVMWSkLoNFbHJBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeltdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0yKmabW3mmkkK9Qtj8BzmXui1tNSmApao9p97BuzcQ0XEhtqFXZZsA>
    <xmx:1CKmadALCvZrGHeGKitO1a_8wIjg_W9gZUpVWWCG_5nC24a2bY3evg>
    <xmx:1CKmaW81Olvfuu6ZywSWVikWax0MoGmK_U3SJYWvVCnA2v4dfZxyng>
    <xmx:1CKmacGNCTCwqzZuu-ITx5LEihht5D2j9hB4MWAEu0Mzj8LDNOE5Ug>
    <xmx:1CKmaaiUMb3dacqaTpBEpK9Vf8PB6sRFLWMu9gzpuU9RFw72e0t1IFtI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 18:52:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v30 2/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <501bd402944146aa02fb5515783f6745eede28d3.1772102022.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 26 Feb 2026
	10:33:42 +0000")
References: <pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
	<pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com>
	<501bd402944146aa02fb5515783f6745eede28d3.1772102022.git.gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 15:52:50 -0800
Message-ID: <xmqq1pi1wzzh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  t/t6040-tracking-info.sh         | 310 +++++++++++++++++++++++++++++++
>  3 files changed, 447 insertions(+), 28 deletions(-)
>
> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 0b719bbae6..c24f545036 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -292,4 +292,314 @@ test_expect_success '--set-upstream-to @{-1}' '
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

The above two uses ( cd test && git $command ) to do what it can do
with "git -C test $command", but the rest of the script seems to
mostly stick to the latter.  Want to be a bit more consistent?

> +test_expect_success 'status.compareBranches from upstream has no duplicates' '
> +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
> +	git -C test checkout main &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch main
> +	Your branch is up to date with ${SQ}origin/main${SQ}.
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'

We see only one because... @{upstream} and @{push} are both
origin/main and we can dedupe and there is no extra advice needed?
If @{push} were missing and only @{upstream} existed, we would also
see just one, so this test feels a bit under-explained.

> +test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
> +	test_config -C test push.default current &&
> +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
> +	git -C test checkout -b feature2 origin/main &&
> +	git -C test push origin HEAD &&
> +	(cd test && advance work) &&

One thing the "advance" function does is to call "test_tick" to
increment the mock timestamp, but the incremented mock timestamp
would not survive beyond the end of a subshell.  Not that it matters
too much to have commits with the same timestamp in these tests, as
long as things are made more reproducible by use of the "advance"
function.

> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature2
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> +
> +	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'

Very straight-forward  If we ask for @{upstream} and @{push} that
resolve to different things, we would see two different reports.

I am curious what should [jc: not asking what the code happens to
do; wondering what the sensible behaviour to help users is] happen
when the user configures the variable to "@{push} @{upstream}
@{push}" in this case.  Should we see just two entries (one for
@{push}, the other for @{upstream})?

I also am curious what should [jc: ditto] happen when @{upstream}
and @{push} point at the same origin/main and our current branch is
ahead by 1 commit.  The pull side would say "you are ahead of
origin/main" and stop wile the push side would say the same thing
with advice to push it out for publishing?  Or should they get
deduped?

> +test_expect_success 'checkout with status.compareBranches shows both branches' '
> +	test_config -C test push.default current &&
> +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
> +	git -C test checkout feature2 >actual &&
> +	cat >expect <<-EOF &&
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> +
> +	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +	EOF
> +	test_cmp expect actual
> +'

If the previous step succeeded, we would be on feature2 branch in
the "test" repository, so this checkout is a no-op-only-for-status
checkout and we expect to see the same thing as the previous step.

Good.

If the previous step failed, this step may break, but that is what
"cd t && sh t6040*.sh -i" is for ;-).

> +test_expect_success 'setup for ahead of tracked but diverged from main' '
> +	(
> +		cd test &&
> +		git checkout -b feature4 origin/main &&
> +		advance work1 &&
> +		git checkout origin/main &&
> +		advance work2 &&
> +		git push origin HEAD:main &&
> +		git checkout feature4 &&
> +		advance work3
> +	)
> +'
> +
> +test_expect_success 'status.compareBranches shows diverged and ahead' '
> +	test_config -C test push.default current &&
> +	test_config -C test status.compareBranches "@{upstream} @{push}" &&


> +	git -C test checkout feature4 &&
> +	git -C test branch --set-upstream-to origin/main &&
> +	git -C test push origin HEAD &&
> +	(cd test && advance work) &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature4
> +	Your branch and ${SQ}origin/main${SQ} have diverged,
> +	and have 3 and 1 different commits each, respectively.
> +	  (use "git pull" if you want to integrate the remote branch with yours)
> +
> +	Your branch is ahead of ${SQ}origin/feature4${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'

Very understandable.

> +test_expect_success 'status --no-ahead-behind with status.compareBranches' '
> +	test_config -C test push.default current &&
> +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
> +	git -C test checkout feature4 &&
> +	git -C test status --no-ahead-behind >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature4
> +	Your branch and ${SQ}origin/main${SQ} refer to different commits.
> +
> +	Your branch and ${SQ}origin/feature4${SQ} refer to different commits.
> +	  (use "git status --ahead-behind" for details)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'

OK.

> +test_expect_success 'setup upstream remote' '
> +	(
> +		cd test &&
> +		git remote add upstream ../. &&
> +		git fetch upstream
> +	)
> +'
> +
> +test_expect_success 'status.compareBranches with upstream and origin remotes' '
> +	test_config -C test push.default current &&
> +	test_config -C test remote.pushDefault origin &&
> +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
> +	git -C test checkout -b feature5 upstream/main &&
> +	git -C test push origin &&
> +	(cd test && advance work) &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature5
> +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
> +
> +	Your branch is ahead of ${SQ}origin/feature5${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'

OK.  There aren't much essential difference from what we have
already seen so far, which dealt with remote tracking branch(es)
from a single remote repository.  Instead of origin/{main,$feature},
we are now dealing with {upstream,origin}/{main,$feature} but we can
only pick one for @{upstream} and one for @{push}, we do not have to
worry about all 4 possible permutations.

> +test_expect_success 'status.compareBranches supports ordered upstream/push entries' '
> +	test_config -C test push.default current &&
> +	test_config -C test remote.pushDefault origin &&
> +	test_config -C test status.compareBranches "@{push} @{upstream}" &&
> +	git -C test checkout -b feature6 upstream/main &&
> +	git -C test push origin &&
> +	(cd test && advance work) &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature6
> +	Your branch is ahead of ${SQ}origin/feature6${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'

Ah, I guess this example hints the answer to my earlier "@{push}
@{upstream} @{push}" question?  The user can control the order of
entries shown by tweaking the order they list things on the
configuration variable.  So we would see the one for @{push} and
then another for @{upstream}.  We can show the one for @{push} again
after these two and claim that it is working as the user told us to,
or we can stop showing after showing @{push} and then @{upstream}
and claim that we are deduping.  Either is fine, but we need to be
consistent and we need to have it documented.

> +test_expect_success 'status.compareBranches with diverged push branch' '
> +	test_config -C test push.default current &&
> +	test_config -C test remote.pushDefault origin &&
> +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
> +	git -C test checkout -b feature7 upstream/main &&
> +	(cd test && advance work71) &&
> +	git -C test push origin &&
> +	git -C test reset --hard upstream/main &&
> +	(cd test && advance work72) &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature7
> +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
> +
> +	Your branch and ${SQ}origin/feature7${SQ} have diverged,
> +	and have 1 and 1 different commits each, respectively.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'

The same as before, I guess.  Nothing unexpected to see here, or in
the rest of the patch.

So td;lr is that the tests in this step mostly look great.  It is
just the semantics of "dedup" is a bit unclear, without a test that
makes it clear (like the "@{push} @{upstream} @{push}" one), and
perhaps a bit more documentation how having multiple tokens on the
status.compareBranches variable affects the output.  A (n easier)
half of that additional documentation could be as small as the
following, but I didn't attempt to deal with the "dedup" part.



 Documentation/config/status.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/Documentation/config/status.adoc w/Documentation/config/status.adoc
index 15ccd0116b..e2c4a014a4 100644
--- c/Documentation/config/status.adoc
+++ w/Documentation/config/status.adoc
@@ -34,7 +34,8 @@ Example:
 ----
 +
 This would show comparisons against both the configured upstream and push
-tracking branches for the current branch.
+tracking branches for the current branch in this order (as that is how
+upstream and push appear in the value of the variable).
 
 status.displayCommentPrefix::
 	If set to true, linkgit:git-status[1] will insert a comment


