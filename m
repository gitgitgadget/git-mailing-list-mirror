Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4EC43457
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 03:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7C5222E9
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 03:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Mppn7Uxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391109AbgJTDSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 23:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391125AbgJTDSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 23:18:35 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA4BC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 20:18:34 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a9so249802lfc.7
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 20:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sw2Y7Pe9CCoL6+GfjDv3zv9bxLxP5zepCRZNztIucA4=;
        b=Mppn7Uxlbfac2lUNneniGiXI5iKN/kmy8o3FbW0owORS2mgEax2a2WtzDLemsXkeAG
         Tr0+zhv9CrkxpX5fRsKV1h3wUh14wcE4f+BIRebvRIsgIwXF/7LhT7VwsqzbQaThBljZ
         Q4gaMcr+3vlnaRb0CIjEMntpoxhICB4xeXHKLTPHjwe9dAG4iXNELQCwXc5ROUnccVdC
         jCSixIGvdBVAG1ZvwsDLRQ6eeL251Zmil0ceJFzMklTLT/SofUl2fHSIUco5lrVJLMJi
         v6kIDpPZqvXf0f/GlXSSOcySeWmb26c7HU7WbiJkeyMxVNkJ5xUHZdbGrr0z72hCP/Df
         rECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sw2Y7Pe9CCoL6+GfjDv3zv9bxLxP5zepCRZNztIucA4=;
        b=ByTUrhvjk8WGm4cp3FRVhrCQvSzSY0dzpZFe2Pd4xI7cTRPgwEqLp78u7+wywsHI7N
         r1m79hAikLVwpD8vCHR7YWmZmrIAknpb09v3Smn47RMNQdSiXVF4REg/k6R6UmtP1iSZ
         /yJixcGiaL4n3OUcn9u0NPppNOn4CmFTvKO/sullpTsf/Z3Sh7u/jZiuptX3Nw2QHMhT
         JPzM0fNJ6Qu9u1Ff3Iq3Ny+UQVhY74tHd+nE93qu5zYW1/Kmt+E0H3rf+0l8obi6cz31
         ftm9P7RkbM9I6kL40b3STrDYb1IFpGsYalKVTr004215RgjmBij3zm+ZVSSzv9kNmKYg
         cS7w==
X-Gm-Message-State: AOAM532BzhtuH3fNx/XuPJ7PZwPJc17+a1LDttmO5NwYWtlepQ9J30FX
        3CENWmYGFanFdnI8pKuaX5JcfLqQ1vgGbpwoQweRZQ==
X-Google-Smtp-Source: ABdhPJzEDoa8uVa1Lm3yvlM2XJmqGnQB7elcjNIsra1Eaxnb0nD14MpGpJ/T9qKKcnlmsxJmzEmxOm5fawRU5SHojfA=
X-Received: by 2002:ac2:465a:: with SMTP id s26mr209157lfo.125.1603163912726;
 Mon, 19 Oct 2020 20:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600814153.git.matheus.bernardino@usp.br>
 <64b41d537e68a45f2bb0a0c3078f2cd314b5a57d.1600814153.git.matheus.bernardino@usp.br>
 <20201020013558.GA15198@google.com>
In-Reply-To: <20201020013558.GA15198@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 20 Oct 2020 00:18:21 -0300
Message-ID: <CAHd-oW7=Bd+StX_t+6iuaas0SWzEdbQCj5aWgasoOYT2kfVw7g@mail.gmail.com>
Subject: Re: [PATCH v2 16/19] parallel-checkout: add tests for basic operations
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Jonathan

On Mon, Oct 19, 2020 at 10:36 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Matheus Tavares wrote:
>
> > Add tests to populate the working tree during clone and checkout using
> > the sequential and parallel modes, to confirm that they produce
> > identical results. Also test basic checkout mechanics, such as checking
> > for symlinks in the leading directories and the abidance to --force.
>
> Thanks for implementing parallel checkout!  I'm excited about the
> feature.  And thanks for including these tests.

Thanks for the comments and feedback :)

> [...]
> > --- /dev/null
> > +++ b/t/lib-parallel-checkout.sh
> > @@ -0,0 +1,39 @@
> [...]
> > +# Runs `git -c checkout.workers=$1 -c checkout.thesholdForParallelism=$2 ${@:4}`
> > +# and checks that the number of workers spawned is equal to $3.
> > +git_pc()
>
> nit: what does git_pc mean?

The idea was "git w/ parallel-checkout". But I realize it may have
gotten too abbreviated...

> Can this spell it out more verbosely, or
> could callers take on more of the burden?  (Perhaps it would make sense
> to use a helper that uses test_config to set the relevant configuration,
> and then the caller can use plain "git clone"?)

Hmm, it's possible, but I think we might end up with quite a lot of
repetition (to always check that checkout spawned the right number of
workers).

> [...]
> > +     GIT_TRACE2="$(pwd)/trace" git \
> > +             -c checkout.workers=$workers \
> > +             -c checkout.thresholdForParallelism=$threshold \
> > +             -c advice.detachedHead=0 \
> > +             $@ &&
>
> $@ needs to be quoted, or else it will act like $* (and in particular it
> won't handle parameters with embedded spaces).

Nice catch, thanks! I will send a patch for this tomorrow.

> > +
> > +     # Check that the expected number of workers has been used. Note that it
> > +     # can be different than the requested number in two cases: when the
> > +     # quantity of entries to be checked out is less than the number of
> > +     # workers; and when the threshold has not been reached.
> > +     #
> > +     local workers_in_trace=$(grep "child_start\[.\+\] git checkout--helper" trace | wc -l) &&
>
> Do we use grep's \+ operator in other tests?  I thought we preferred to
> use the more portable *, but it may be that I'm out of date.

Oh, I didn't know about the portability issue with \+. This is already
in `next`, but I guess it's worth sending a follow-up patch to fix it,
right? (I see we have a second \+ occurrence in t7508, which could be
changed in the same patch.)

> [...]
> > +# Verify that both the working tree and the index were created correctly
> > +verify_checkout()
> > +{
> > +     git -C $1 diff-index --quiet HEAD -- &&
> > +     git -C $1 diff-index --quiet --cached HEAD -- &&
> > +     git -C $1 status --porcelain >$1.status &&
> > +     test_must_be_empty $1.status
> > +}
>
> Like git_pc, this is not easy to take in at a glance.
>
> "$1" needs to be quoted if we are to handle paths with spaces.

Thanks, again :) Currently, this function doesn't get paths with
spaces, but I agree that it's better to be cautious here.

> [...]
> > --- /dev/null
> > +++ b/t/t2080-parallel-checkout-basics.sh
> > @@ -0,0 +1,197 @@
> > +#!/bin/sh
> > +
> > +test_description='parallel-checkout basics
> > +
> > +Ensure that parallel-checkout basically works on clone and checkout, spawning
> > +the required number of workers and correctly populating both the index and
> > +working tree.
> > +'
> > +
> > +TEST_NO_CREATE_REPO=1
> > +. ./test-lib.sh
> > +. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
> > +
> > +# NEEDSWORK: cloning a SHA1 repo with GIT_TEST_DEFAULT_HASH set to "sha256"
> > +# currently produces a wrong result (See
> > +# https://lore.kernel.org/git/20200911151717.43475-1-matheus.bernardino@usp.br/).
> > +# So we skip the "parallel-checkout during clone" tests when this test flag is
> > +# set to "sha256". Remove this when the bug is fixed.
> > +#
> > +if test "$GIT_TEST_DEFAULT_HASH" = "sha256"
> > +then
> > +     skip_all="t2080 currently don't work with GIT_TEST_DEFAULT_HASH=sha256"
> > +     test_done
> > +fi
> > +
> > +R_BASE=$GIT_BUILD_DIR
> > +
> > +test_expect_success 'sequential clone' '
> > +     git_pc 1 0 0 clone --quiet -- $R_BASE r_sequential &&
>
> This fails when I run it when building from a tarball, which is
> presenting me from releasing this patch series to Debian experimental.

Sorry for the trouble :( It didn't occur to me, while writing the
test, that it could also be run from the tarball.

> Can we use an artificial repo instead of git.git?  Using git.git as
> test data seems like a recipe for hard-to-reproduce test failures.

I think we could maybe drop these tests. There are already some
similar tests below these, which use an artificial repository. The
goal of using git.git in this section was to test parallel-checkout
with a real-world repo, and hopefully catch errors that we might not
see with small artificial ones.  But you have a very valid concern, as
well. Hmm, I'm not sure what is the best solution to this case. What
do you think?
