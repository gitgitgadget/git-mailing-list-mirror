Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B7BC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB41920878
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VDTiZANg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464524AbgJWP47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:56:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55695 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464509AbgJWP47 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 11:56:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A300F09A9;
        Fri, 23 Oct 2020 11:56:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kH0lG+JuL1mC+JIcCj766R/dBRQ=; b=VDTiZA
        Ng756BZiHx4Iq8x+0lnfVHfRrBW3Oxk09GJlBwshKD6Vh89og+EJqdklCehRxlkD
        Y2Gtcj0UGQxnplJdRi/+atYZF41CdGaX63EZyWuQiNyEpDdwGdwdeqLeBexIh8lr
        xFgrDN9+Vs1AK2bTCI7F2pYI7FddRHREww3pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ng5uZnMeGTlqiqqlUeutVeiqHfoUeUb2
        JJM2rtuByP583P3ID+AMWvluX4Kc2i9mHOyKa+r+uP1BASd8K6bxznVm8w8/Q7Yy
        2FEE6afKRNb54TgAoMzH0zFwQGFI/lpUMxfQt3vjg/ewrB0vtRiBVuNKUMsupgu3
        GDo5zIyojzk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 019B4F09A8;
        Fri, 23 Oct 2020 11:56:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3D0D7F09A7;
        Fri, 23 Oct 2020 11:56:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta Jain <sangunb09@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] diff: do not show submodule with untracked files as
 "-dirty"
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
        <20201023111711.38739-1-sangunb09@gmail.com>
Date:   Fri, 23 Oct 2020 08:56:51 -0700
In-Reply-To: <20201023111711.38739-1-sangunb09@gmail.com> (Sangeeta Jain's
        message of "Fri, 23 Oct 2020 16:47:11 +0530")
Message-ID: <xmqq7drhhr5o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E86CB96-1548-11EB-AE10-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta Jain <sangunb09@gmail.com> writes:

> From: sangu09 <sangunb09@gmail.com>
>
> Make `--ignore-submodules=untracked` the default for `git diff` when
> there is no configuration variable or command line option, so that the
> command would not give '-dirty' suffix to a submodule whose working
> tree has untracked files, to make it consistent with `git
> describe --dirty` that is run in the submodule working tree.

What happened to the first/introductory paragraph that was
excellently written in the previous round?

The usaul way to compose a log message is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

The first paragraph you had in the previous round was a good example
of the "observation".  What we see above is only the "commands"
part.  To those who have been intimately following the discussion,
it often is understandable without both, but we are not writing for
those who review the patches.  We are writing for future readers who
are not aware of these exchanges we are having, so we should give
something to prepare them by setting the stage and stating the
objective.

> diff --git a/diff.c b/diff.c
> index 2bb2f8f57e..5a80695da8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4585,6 +4585,9 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
>  		DIFF_XDL_SET(options, INDENT_HEURISTIC);
>  
>  	options->orderfile = diff_order_file_cfg;
> +	
> +	if (!options->flags.ignore_submodule_set)
> +		options->flags.ignore_untracked_in_submodules = 1;

I think I already touched about this one in the previous review.

>  	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
>  	if (ignore_untracked)
> -		strvec_push(&cp.args, "-uno");
> +		strvec_push (&cp.args, "-uno");

Noise.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index ca04fac417..98e46ad1ae 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -761,7 +761,7 @@ test_expect_success 'setup different kinds of dirty submodules' '
>  		echo dirty >>initial &&
>  		: >untracked
>  	) &&
> -	git -C for-submodules diff-files --name-only >actual &&
> +	git -C for-submodules diff-files --name-only --ignore-submodules=none >actual &&
>  	cat >expected <<-\EOF &&
>  	dirty-both-ways
>  	dirty-head

Hmph, it seems that you chose to give options that are no longer the
default to command invocations, so that the expected output from the
previous world order before this patch can be reused, but is that a
sensible way to go?  If we are changing the default behaviour, shouldn't
we rather be testing that new behaviour, I wonder?

> diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
> index 537787e598..78cd86be3a 100755
> --- a/t/t7064-wtstatus-pv2.sh
> +++ b/t/t7064-wtstatus-pv2.sh
> @@ -503,6 +503,31 @@ test_expect_success 'untracked changes in added submodule (AM S..U)' '
>  		1 AM S..U 000000 160000 160000 $ZERO_OID $HSUB sub1
>  		EOF
>  
> +		git status --porcelain=v2 --branch --untracked-files=all --ignore-submodules=none >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'untracked changes in added submodule (A. S...) (untracked ignored)' '
> +	(	cd super_repo &&
> +		## create untracked file in the submodule.
> +		(	cd sub1 &&
> +			echo "xxxx" >file_in_sub
> +		) &&
> +
> +		HMOD=$(git hash-object -t blob -- .gitmodules) &&
> +		HSUP=$(git rev-parse HEAD) &&
> +		HSUB=$HSUP &&
> +
> +		cat >expect <<-EOF &&
> +		# branch.oid $HSUP
> +		# branch.head master
> +		# branch.upstream origin/master
> +		# branch.ab +0 -0
> +		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
> +		1 A. S... 000000 160000 160000 $ZERO_OID $HSUB sub1
> +		EOF
> +
>  		git status --porcelain=v2 --branch --untracked-files=all >actual &&
>  		test_cmp expect actual
>  	)
> @@ -582,6 +607,33 @@ test_expect_success 'staged and untracked changes in added submodule (AM S.MU)'
>  		1 AM S.MU 000000 160000 160000 $ZERO_OID $HSUB sub1
>  		EOF
>  
> +		git status --porcelain=v2 --branch --untracked-files=all --ignore-submodules=none >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'staged and untracked changes in added submodule (AM S.M.) (untracked ignored)' '
> +	(	cd super_repo &&
> +		(	cd sub1 &&
> +			## stage new changes in tracked file.
> +			git add file_in_sub &&
> +			## create new untracked file.
> +			echo "yyyy" >>another_file_in_sub
> +		) &&
> +
> +		HMOD=$(git hash-object -t blob -- .gitmodules) &&
> +		HSUP=$(git rev-parse HEAD) &&
> +		HSUB=$HSUP &&
> +
> +		cat >expect <<-EOF &&
> +		# branch.oid $HSUP
> +		# branch.head master
> +		# branch.upstream origin/master
> +		# branch.ab +0 -0
> +		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
> +		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
> +		EOF
> +
>  		git status --porcelain=v2 --branch --untracked-files=all >actual &&
>  		test_cmp expect actual
>  	)

OK.

By the way, in builtin/describe.c there is an invocation of
"diff-index" without any --ignore-submodules=<what> option.

        /* diff-index command arguments to check if working tree is dirty. */
        static const char *diff_index_args[] = {
                "diff-index", "--quiet", "HEAD", "--", NULL
        };

Would the behaviour of diff-index invocation in "git describe --dirty"
affected by the change of the default in any way?

Thanks.
