Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97103E8C78
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112017; cv=none; b=u5nhZMFjTbm7yDL9WeiNq70FFL+/IXNO25ylF4IPfm1La+2/Hbn3doQWkdvfjPsB8ZwVslwU8pmmJfSBMDuQLLiYlDna4iZMogS5BiEaZfy81MO4bzQZB6uWBfqCgA4ypKL/y47cG7kaU2aDose8lUPJ9gftAzOyOpFf4nrB7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112017; c=relaxed/simple;
	bh=vndFp5S32NTLYpDfMcXLnfHiXsOIS9FKu2KVko+ZVVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MdZWIWderloZjA8wnbJdBpfxxNdSdK38R5AE5o4epWuy6u/pq5MiBEkkTeD+NIvhYu4sF84fE2L+cpGZ8mxjaHLJdgXn04I2yHkz9cP3B/t7Msn8VJcCiQ2kl9oOpw953CYAuw5OaiYR8rotuuy2554XSRQEfr0pvMg9fL+hcn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YhR99itj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jc04LE2R; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YhR99itj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jc04LE2R"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 89C9DEC0246;
	Tue, 22 Sep 2026 17:20:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 22 Sep 2026 17:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790112007; x=1790198407; bh=irM3kqj7tA
	WgBIqr0xuptn9d6zD345FVyM+AB3iRGIw=; b=YhR99itjyUePuj8cOd8U0vxFwR
	2vOMT5E3C9gfcOGsR0feRQQh0PZ7Y8ap0fE0yFtgHlCNzunEqcKx3m+TyVikub5C
	8cX0dwfJOtmrogmNDknfMgjjL0exDj+HgfJc8PlTYIGb0RJwxI7wtrefWxvm9OlY
	ZYVaBD06FthiDheHwX6AZfuwSUxPmWFKxgvMDgdq+CY+eCwd90mea1AQ32N9MYXw
	H6KXQGDM4PYPMpatv/CUetwgAsFO7EG6zNfwOyQn1sHrwDGiPDrVw+WiZvF9Z7tJ
	RadeTvCcBQSVKss1maD6TLawf1wuBreBC36pL3C+DR9ZrTqIORr1E0GF6ZOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790112007; x=1790198407; bh=irM3kqj7tAWgBIqr0xuptn9d6zD345FVyM+
	AB3iRGIw=; b=Jc04LE2R19zTNEfJp5iqu8XEMQnvchWqqQY7JoTcv3jiKpadCHQ
	p8pYvCq0aiipIp8YZ2Gj8bWRdyCllb+rA8BAJFVtsudVHafMBWwLrRyxCpV7P+15
	FRzOAAC0PNOKQEKGcTHGJlQnkhpXRJKoJIXbIgUAkjxOe22dPYZWIB1ab+0Ct1GC
	smTc+2AASrO+Qsdts1BwAEDQgLhp+mDgnnyJH208z5CRfX8qRmqZrGu48Ah8Tgbi
	f0yh0JaOAA93lS+dVC+/2npBrB+CiOaZ8up3C7Gq9kjis1LAubBkZzfqty8/dVKV
	K3eQsfSFI3FVuSpR8rVKwLFfosT5dQPeupQ==
X-ME-Sender: <xms:B_Gyat5MSSpYjbIdO4yEb4Su9I-Blt545rMyaKLiu5GBNJdDHSJH-g>
    <xme:B_GyahwVGlhCFIb6sR0m6rLYKXDNIMtqLzFZiY61zqNNQRT5maKbO8DNQvM2KBkBX
    UwwESQ4k829CzTs19UEvs_rJptDGbJF4xJlpvmmTrw4BaFPj4pZIIM>
X-ME-Received: <xmr:B_Gyasy39FLTsX1Siyvol9VB8VbGxhiBAFiM1KmTIq_fJ38LQ9h3kCKeCDE5IysJteQJHLULSVVcV_ukhvYOz32OtYrlSAqqCuIc>
X-ME-Proxy-Cause: dmFkZTFCMNtDeQznR67lHvNFfat36/z4+kRf4OWw0lGs0Ve4YjgeuJMR64+QiFDo8SzSoG
    NOZYIVuEbd9mmU35RSmKf4UAm4czfKPC9OI/uW98rj4Yqn0/9yenwce/2iOiYzH7LUrq1C
    98li2XsX7DZV8jEl78kR2Rm8lrG0S6YQz3h9RgiW6Y9j5H2KXKgWa+wcwFtWUmrpqj3GaC
    oacC79fB8ZLT3Y4NGKx3GctNnrvS2tJl9B9ZhNSiF9WNvAXKmzVUTMNiB7iyXzD0Zy2CfD
    rUQuJOxmJNRLmymNCyM6k/fHJsvZ5PxSKIEVhdrT/bzc5UfX4nylGRY7LFBFvgPH8My8A7
    PXlf3bPRIjqmJOjlYnvdTPCqzz9V+u9dtuc/ggJrjDxyIOgl6ThNjvlUD4TpKyR14Q484L
    Q62pzVaBNiT5edTKHzRCu+J9/aOtmTgHgjebd2VaJ6yo/y4pAyZCm2flTFUl0ddM4nJhtr
    kgBTzzKe6x7jimJjx98yYAZXqtZc3ugLPwi2q/dfD0ob0KYgJZEJhsq5awNzOGotWJgu/l
    +OvwTRG7qlau4Ka0ffIDVaCRTcblTRgOyVLvlkwxOz5uuakukZF9zs75Zkr0NJWMY7v2oI
    cpELYmCOpSJGlpifPHmA/hS9Lh/lcQ0QzD9aT2tT0hbvP97f7lD0cIY1q8xw
X-ME-Proxy: <xmx:B_Gyahy0BA3MoqWsvEjsyznzulVORvEwe-h8CkQDM41GEb0XCbeudQ>
    <xmx:B_GyauaUt0s_5kXg59fASqI3N_quoV6FlQR4db20b44HP2RPZ7gsmw>
    <xmx:B_GyaqVj9egpms25jtfFSUQVAhBQKLbF6sVXVZ5jFmRvC3CH4DW6lw>
    <xmx:B_GyakjzVvBL-IwipRxjFeA2zlr1zPRMCi0qJ9F_dHTwCdS1Pu2mCA>
    <xmx:B_GyalDR5nuJGSo6fU1BmpdmqJPTkrTq5E0xU9opAEvTrcXAIOM-CixV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 17:20:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] shallow: advise when a walk stops at a shallow boundary
In-Reply-To: <pull.2413.v2.git.git.1790084326913.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 22 Sep 2026
	13:38:46 +0000")
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
	<pull.2413.v2.git.git.1790084326913.gitgitgadget@gmail.com>
Date: Tue, 22 Sep 2026 14:20:05 -0700
Message-ID: <xmqqo6dpc7ay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index 350b35c556..22a40c7d28 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -47,6 +47,7 @@
>  #include "commit-reach.h"
>  #include "promisor-remote.h"
>  #include "range-diff.h"
> +#include "shallow.h"
>  #include "tmp-objdir.h"
>  #include "tree.h"
>  #include "userdiff.h"
> @@ -396,9 +397,32 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
>  	cmd_log_init_finish(argc, argv, prefix, rev, opt, cfg);
>  }
>  
> +static void advise_if_log_stopped_at_shallow_boundary(struct rev_info *rev,
> +						       struct commit *last_shown)
> +{
> +	if (!last_shown)
> +		return;
> +	/* a plain "git log" running out of history is expected */
> +	if (rev->max_count < 0 && rev->max_age == (timestamp_t)-1)
> +		return;

"git log -999" may run out of commits because the history genuinely
may only have 20 commits, or the clone was made shallowly and we
only happen to have 20 commits at hand.  The same is true for "git
log" that does not get any count.  So I do not quite see the reason
why we want to give an early return in this function.

> +	if (!is_repository_shallow(the_repository))
> +		return;
> +	if (!commit_is_shallow_boundary(the_repository, &last_shown->object.oid))
> +		return;
> +	wait_for_pager();
> +	advise_if_enabled(ADVICE_SHALLOW_HISTORY,
> +			   _("'%s' stopped at %s because this repository is a shallow\n"
> +			     "clone, and might have more history upstream that was never fetched."),
> +			   "git log",
> +			   repo_find_unique_abbrev(the_repository,
> +						    &last_shown->object.oid,
> +						    DEFAULT_ABBREV));
> +}
> +

Anyway, sorry, I regret opening this can of worms X-<.  It is not
that your implementation and design is bad, it is the problem being
solved that is bad.  But ...

>  static int cmd_log_walk_no_free(struct rev_info *rev)
>  {
>  	struct commit *commit;
> +	struct commit *last_shown = NULL;
>  	int saved_nrl = 0;
>  	int saved_dcctc = 0;
>  	int result;
> @@ -412,6 +436,7 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
>  	 * retain that state information if replacing rev->diffopt in this loop
>  	 */
>  	while ((commit = get_revision(rev)) != NULL) {
> +		last_shown = commit;
>  		if (!log_tree_commit(rev, commit) && rev->max_count >= 0)
>  			/*
>  			 * We decremented max_count in get_revision,
> @@ -437,6 +462,7 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
>  		if (rev->diffopt.degraded_cc_to_c)
>  			saved_dcctc = 1;
>  	}
> +	advise_if_log_stopped_at_shallow_boundary(rev, last_shown);

... the "last shown" commit may or may not be at shallow boundary.
It may be a normal root commit, yet there may be truncated side
history that we stopped traversing during the above loop.  If for
example we had a history like this (time flows from left to right):

     ()---b---d---e	(side branch)
                   \
                    \
  a---------c--------f------g	(trunk)

where a side branch is much denser than the trunk, and shallow clone
truncated the history, hiding the parents of 'b', we may see that
our traversal goes 'g', 'f', 'e', 'd', 'c', 'b', 'a' and the last
shown commit may be 'a', which is a genuine root commit.  But behind
'b' there may be hundreds of commits on the side branch that
eventually leads down to 'a'.  Doesn't the user want to be notified
that they are missing tons of history behind 'b' in such a case when
'b' is shown and we stop traversing its parents?

That was the original motivation behind the issue I raised during
the previous review, and that is why I say I regret opening this can
of worms.  If the commit 'a' in the history had parentes hidden
behind a shallow boundary (in other words, 'a' is not root), then
from the same traversal, we would see the "traversal stopped at
shallow boundary" advise, which means that we sometimes see it and
sometimes we don't, even though in either case we are showing 'b' as
if it were a root when it is not.

I do not think of a good way to solve this, and showing "your
traversal happened to have ended at the shallow boundary" only
sometimes in an unreliable way is probably counter-productive, I am
afraid.

So please forget what I said in the previous review.  Even though it
may be a good piece of information to have somehow for the user to
know which commit has its parents hidden beyond a shallow boundary,
a regular get_revision() traversal loop is probalby not a good place
to do so.

We might want to show the information by enriching "log --graph"
output but that is totally unrelated to what you are doing with this
<rev>~N topic.

> +test_expect_success 'shallowHistory advice accounts for depth already present' '
> +	test_commit shallow_partial_1 &&
> +	test_commit shallow_partial_2 &&
> +	test_commit shallow_partial_3 &&
> +	test_commit shallow_partial_4 &&
> +	test_commit shallow_partial_5 &&
> +	test_commit shallow_partial_6 &&
> +	git clone --no-local --depth=3 --branch main --single-branch \
> +		.git shallow-advice-partial &&
> +	test_when_finished "rm -rf shallow-advice-partial" &&
> +	(
> +		cd shallow-advice-partial &&
> +		oid=$(git rev-parse --short origin/main~2) &&
> +		test_must_fail git rev-parse origin/main~5 2>err &&
> +		check_shallow_history_advice origin/main "$oid" \
> +			"git fetch --deepen=3 origin main" &&

Would wew see the same output if we asked for "origin/main^^^^^"?
Just being curious.

> +		git fetch --deepen=3 origin &&
> +		git rev-parse origin/main~5 &&
> +		test_must_fail git rev-parse origin/main~6
> +	)
> +'

Thanks, and sorry about the ill-defined feature request.
