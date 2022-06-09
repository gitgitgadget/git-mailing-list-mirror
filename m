Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE50CC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 13:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbiFINmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 09:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343956AbiFINma (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 09:42:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A344C43F
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 06:42:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n10so47589491ejk.5
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 06:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6aVQYajMw3NQ3FFINfeLv/VZ4WkFyqvwmb7P9PX6QXU=;
        b=JrR0j2QxsBC/kHZB8TcgMG0Q9YwTvYFM4MXDNaFl+VeqNQ8R1wYmrGb0NDJMIHLE5J
         uAasdfTJ9mP4R7waYzyeKZzV9QbxEP1OcZB6HwH/vYR/ydlhjjxd5yLoHjtXHV/SqQub
         sDymU0z/URWevhSjH/n1MlNJgtPkRce1JFbH251IuXPSBc5cGsjJ/UQIhc2RaXO8tMay
         C3bC7QGBxamcvgNRc6yn59cEdKE0N3r/ZOIUQL7KTuE+oKsVFjsUZ4MAUrNxwg0L8PRk
         b0MnC4jnArkDUJH63zcbJ9P3cfIB8mcs0bDxEXkYBex4GK1/9ETH0ZuPORjeybEl3MAK
         A7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6aVQYajMw3NQ3FFINfeLv/VZ4WkFyqvwmb7P9PX6QXU=;
        b=W43NaNNpkfSfHQjurvsIYCbnCk7q5ZmjJO25cv3Ig7MR6audJkTKHJsxAywCthgfRW
         e8J3kACJCiqIA/xA5Ne3Djh3B1SYPlmMBR8OUfDkaLLwuWzlxQb13BU4KkrWzl5El8CN
         GyWy2swlyIAnp0WPZf3YxQUgyNJ5i220CtsFYmRnriutVKyr4hdQu2dah+7hiQogWhDx
         2qsiCf7p1/P3mYxOfAGG4F6HRBhk0UDxmGtHzzqALnBtU5kjlLUkXaDQjJ44RL16ppc3
         VjA/Y3Qg8DjckezQhPxFPtYgfLSwNIvuGKEAFOxWTxsYOFr9BkSAgJxZ/S3wo+UkaFXT
         wPtQ==
X-Gm-Message-State: AOAM532V1UdMLPFbKZA/Odl0t9jy2mlF9mMxg6jR9gtRJHwByjs8LQh7
        v9ulI+cW51qUwylYUsC6DBUlAZe3wgc=
X-Google-Smtp-Source: ABdhPJwtEWtOt4WKlqs/oddvW3wU7bJVqGXq+yzP//jA1UsNCibnhgip5XJV5ihzCM6NxV1qVqqZOg==
X-Received: by 2002:a17:907:94c3:b0:711:8b08:e7e with SMTP id dn3-20020a17090794c300b007118b080e7emr22990622ejc.451.1654782146731;
        Thu, 09 Jun 2022 06:42:26 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z11-20020a05640240cb00b0042e17781fc5sm13249273edb.49.2022.06.09.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 06:42:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nzIQb-002uXj-FH;
        Thu, 09 Jun 2022 15:42:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(github): bring back the 'print test failures' step
Date:   Thu, 09 Jun 2022 15:06:43 +0200
References: <pull.1252.git.1654684998599.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1252.git.1654684998599.gitgitgadget@gmail.com>
Message-ID: <220609.868rq6t0la.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 08 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Git now shows better information in the GitHub workflow runs when a test
> case failed.

This commit message should be more on-point. "Git" isn't showing
anything, and it's unclear that this is a regression fix for fc5a070f591
(Merge branch 'js/ci-github-workflow-markup', 2022-06-07).

> However, when a test case was implemented incorrectly and therefore
> does not even run, nothing is shown.

The *report* came about because of an incorrectly implemented test (of
mine).

But the real issue is that your recent change to the CI output is
implemented in such a way as to hide entire classes of errors that we'd
previously show.

The test being broken is besides the point, of course we'll have broken
tests. When we do so we should be showing output relevant to the
failure.

The selling point of your js/ci-github-workflow-markup topic was that we
*could* accurately summarize our failures as to make browsing the raw
logs unnecessary. Quoting your
https://lore.kernel.org/git/pull.1117.git.1643050574.gitgitgadget@gmail.com/:
	
	I know, and I do not expect any new contributor, not even most seasoned
	contributors to know, that I have to patiently collapse the "Run
	ci/run-build-and-tests.sh" job's log, and instead expand the "Run
	ci/print-test-failures.sh" job log (which did not fail and hence does not
	draw any attention to it).
	
	I know, and again: I do not expect many others to know this, that I then
	have to click into the "Search logs" box (not the regular web browser's
	search via Ctrl+F!) and type in "not ok" to find the log of the failed test
	case (and this might still be a "known broken" one that is marked via
	test_expect_failure and once again needs to be ignored).
	
	To be excessively clear: This is not a great experience!

As before we agree that it's not the ideal UX experience. But I don't
see how this isn't worse, especially for the proverbial new contributor.

I.e. when js/ci-github-workflow-markup landed we'd gotten rid of the
ci/print-test-failures.sh output entirely, because the topic argued that
we *could* accurately summarize these failures, and that any remaining
issues requiring that step were so obscure as to be left to the
artifacts downloading step.

But per my report at
https://lore.kernel.org/git/220603.86fskmxd43.gmgdl@evledraar.gmail.com/
(which b.t.w, would be useful to link to in the commit message) this
will fail in cases where we'll die early in test-lib.sh itself, e.g. due
to a syntax error.

Now, I haven't fully dug into what those cases are, but a regression fix
really should take the time to do so. E.g. if we fail in a prereq that
the test needs (with exit and/or BUG) do we similarly fail, how about
e.g. chainlint, or is it just if "eval" itself fails?

But getting back to the point, because of that we'll now be asking those
using the CI output to view the default GitHub Markup'd failure, and in
addition knowing enough about its implementation to know if/when they
should be opening the "print test failures" step as well, in case it
over-elided some output.

As an example, the output is now with this change, and a change on top
to re-trigger the reported failure:

	https://github.com/avar/git/runs/6808880749?check_suite_focus=true#step:4:1757

I.e. per the report above we only show a cryptic "Error: Process
completed with exit code 1.", but we do have a "print test failures"
step now.

And here's the version with the "GitHub markup" changes reverted:

	https://github.com/avar/git/runs/6808882949?check_suite_focus=true#step:4:1719

Which to be fair isn't much better in itself, but the greater context is
that *usually* this step would be sufficient to view a failure, but some
of the time it isn't, and you need to know enough to know when that's
the case. That's new.

> [...]Let's bring back the step that prints the full logs of the failed
> tests[...]

Except we still have another bug in js/ci-github-workflow-markup where
bug in it altered the raw logs themselves. To be fair in this case you
can see the failure itself.

Here's what we used to do:

    https://github.com/avar/git/runs/6808882949?check_suite_focus=true#step:5:579

And what we do now:

    https://github.com/avar/git/runs/6808880749?check_suite_focus=true#step:5:445

I.e. the former prints "expecting success of 3105.36 'setup:
HEAD_short_* variables': " followed by the test source itself, and then
the "set -x" output, whereas the new output only has the "set -x"
output. Both of them get to:

    t3105-ls-tree-output.sh: 20: local: --abbrev: bad variable name

So it doesn't matter much in this particular case, but we'll have other
cases where browsing the raw logs is really useful, and having the
now-missing context of the test source is even more useful.

> , and to improve the user experience, print out an informational
> message for readers so that they do not have to know/remember where to
> see the full logs.

I don't think we should call these "full logs" while the bug above
remains unsolved. Perhaps "more verbose logs emitted when running with
--github-workflow-markup, omit the flag to get the full *.out logs"?

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 3fa88b78b6d..cd1f52692a5 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -119,6 +119,10 @@ jobs:
>      - name: test
>        shell: bash
>        run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
> +    - name: print test failures

When ci/print-test-failures.sh was last in this file before 08dccc8fc1f
(ci: make it easier to find failed tests' logs in the GitHub workflow,
2022-05-21) there was no "name" field, that's an unrelated change that
shouldn't be part of a narrow regression fix.

> +      if: failure() && env.FAILED_TEST_ARTIFACTS != ''

We likewise just had "if failure()" then, is the distinction different
in all these cases?

> +      shell: bash

...and you've made every single one of them run with "bash" instead of
the default shell, which is another "change while at it" that isn't
discussed.
