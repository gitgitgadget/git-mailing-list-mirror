Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9DAC388F7
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 17:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471EB20781
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 17:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t9oxDfPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKIRws (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:52:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64265 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIRwr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 12:52:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85EC690D2A;
        Mon,  9 Nov 2020 12:52:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PL7nPBv+NBdETjNMqYWYisRJimg=; b=t9oxDf
        PRejhAtoL66a0iBtvl2zOausfPdfYFOSEnBT/PMrR9UcO5n7+ConQ7wUPTWjHnxu
        EJc5KhFkI2SULweB0E0HOuN34OvNJbSWCsvFK3EUhqV1wjxoqTW1yg5SjcCBSGqK
        F8EdbgFQE0ba2EoPYupzH1UjzjjYGXs83He+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lZHONaTmDMaOcHi+HK1mknkr2ZFhONWw
        xc6GlnQBCquBWqYZ4eX0PfLeoES2q0nXnYF720y/30R+GY8ae37o+WWR1XUTgTJv
        hHBw9uKcrIbhZ7fMESMN17gd/w2UVQnuu1svcC9xWi96NsJ69yxm7Con9WDq8sFC
        aB25fYE1hBE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A39690D29;
        Mon,  9 Nov 2020 12:52:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F2E3F90D28;
        Mon,  9 Nov 2020 12:52:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Kaestle <peter.kaestle@nokia.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [RFC 1/2] submodules: test for fetch of non-init subsub-repo
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
        <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com>
        <1604910829-49109-2-git-send-email-peter.kaestle@nokia.com>
Date:   Mon, 09 Nov 2020 09:52:39 -0800
In-Reply-To: <1604910829-49109-2-git-send-email-peter.kaestle@nokia.com>
        (Peter Kaestle's message of "Mon, 9 Nov 2020 09:33:48 +0100")
Message-ID: <xmqqk0uuct94.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C21DD04-22B4-11EB-96AC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Kaestle <peter.kaestle@nokia.com> writes:

> This test case triggers a regression, which was introduced by
> a62387b3fc9f5aeeb04a2db278121d33a9caafa7 in following setup:

Minor nit.  Please refer to a commit like so:

a62387b3 (submodule.c: fetch in submodules git directory instead of in worktree, 2018-11-28)

That is what "git show -s --pretty=reference" gives for the commit.

If you have older git, "--format='%h (%s, %ad)' --date=short" would
work.

Instead of saying "if you follow this complex thing, it breaks and
it is a regression at there", please describe it as a regular bugfix
log message.  Describe the set-up first, explain the operation you'd
perform under the condition, and tell readers what your expected
outcome is.  Then tell readers what actually happens, and how that
is different from your expected outcome.  Additionally, tell readers
that it used to work before such and such commit broke it and what
the root cause of the breakage is.

What commit the set-up was broken is also an interesting piece of
information, but it is not as important in the overall picture.

Also, it probably is a better arrangement, after explaining how the
current system does not work in the log message, to have the code
fix in the same patch and add test to ensure the bug will stay
fixed, in a single patch.  That way, you do not have to start with
expect_failure and then flip the polarity to expect_success, which
is a horrible style for reviewers to understand the code fix because
the second "fix" step does not actually show the effect of what got
fixed in the patch (the test change shows the flip of the polarity
of the test plus only a few context lines and does not show what
behaviour change the "fix" causes).


> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index dd8e423..9fbd481 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -719,4 +719,42 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
>  	)
>  '
>  
> +add_commit_push()
> +{

Style. 

    add_commit_push () {

cf. Documentation/CodingGuidelines.

> +	dir="$1"
> +	msg="$2"
> +	shift 2
> +	git -C "$dir" add "$@" &&
> +	git -C "$dir" commit -a -m "$msg" &&
> +	git -C "$dir" push
> +}
> +
> +test_expect_failure 'fetching a superproject containing an uninitialized sub/sub project' '
> +	# does not depend on any previous test setups
> +
> +	for repo in outer middle inner
> +	do
> +		git init --bare $repo &&
> +		git clone $repo ${repo}_content &&
> +		echo $repo > ${repo}_content/file &&

Style. 

    echo "$repo" >"${repo}_content/file" &&

cf. Documentation/CodingGuidelines.

> +		add_commit_push ${repo}_content "initial" file

If any of these iterations, except for the last one, fails in the
loop, you do not notice the breakage and go on to the next
iteration.  You'd need "|| return 1" at the end, perhaps.

So far, you created three bare repositories called outer, middle and
inner, and each of {outer,middle,inner}_content repositories is a
copy with a working tree of its counterpart.

> +	done &&
> +
> +	git clone outer A &&
> +	git -C A submodule add "$pwd/middle" &&
> +	git -C A/middle/ submodule add "$pwd/inner" &&

Hmph.  Is it essential to name these directories with full pathname
for the problem to reproduce, or would the issue also appear if
these repositories refer to each other with relative pathnames?
Just being curious---if it only breaks with one and succeeds with
the other, that deserves commenting here.

So far, you created A that is "outer", added "middle" as its
submodule and then added "inner" as a submodule of "middle".

Although it is not wrong per-se, it somehow feels a bit unnatural
that you didn't do all of the above in the working trees you created
in the previous step---I would have expected that middle_content
working tree would be used to add "inner" as its submodule, for
example.


> +	add_commit_push A/middle/ "adding inner sub" .gitmodules inner &&
> +	add_commit_push A/ "adding middle sub" .gitmodules middle &&

And then you conclude the addition of submodules by recording each
of these two "submodule add" events in a commit and push it out.

> +	git clone outer B &&
> +	git -C B/ submodule update --init middle &&

And then you clone the outer thing (which does not recursively
instantiate) from A, and instantiate the middle layer (which does
not recursively instantiate the bottom later, I presume?)

I _think_ the state here should be minimally validated in this test.
If you expect 'outer' and 'middle' are instantiated, perhaps check
its contents (e.g. do you have a thing called 'file'?  What does it
have in it?) and check the commit (e.g. does 'rev-parse HEAD' give
you the commit you expect?).  If you expect 'inner' is not
instantiated at this point, that should be vaildated as well.  If
anything, that would explain what your expectations are better than
any word in the proposed log message.

In any case, i presume that up to this point things work as expected
with or without the "fix" patch?  If so, the usual way we structure
these tests is to stop here and make that a single "setup" test.
Start the whole sequence above like so, perhaps.

    test_expect_success 'setup nested submodule fetch test' '
		...


and close here.

And then the "interesting" part of the test.  

> +	echo "change on inner repo of A" > A/middle/inner/file &&

Style.

> +	add_commit_push A/middle/inner "change on inner" file &&
> +	add_commit_push A/middle "change on inner" inner &&
> +	add_commit_push A "change on inner" middle &&

So you create a new commit in the bottom layer, propagate it up to
the middle layer, and to the outer layer.  Are these steps also what
you expect to succeed, or does the "regression" break any of these?
If these are still part of set-up that is expected to work, you
probably need to roll these up to the 'setup' step (with some
validation to express what the tests are expecting). From your
description, which did not say where exactly in this long sequence
you expect things to break, unfortunately no reader can tell, so
I'll leave the restructuring up to you.

> +
> +	git -C B/ fetch

And from B that was an original copy of A with only the top and
middle layer instantiated, you run "git fetch".  Are you happy as
long as "git fetch" does not exit with non-zero status?  That is
hard to believe---it may be a necessary condition for the command to
exit with zero status, but you have other expectations, like what
commit the remote tracking branch refs/remotes/origin/HEAD ought to
be pointing at.  I think we should check that, too.

> +'
> +
>  test_done
