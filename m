Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A97C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 02:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E254613B3
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 02:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhD0CbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 22:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhD0CbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 22:31:03 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ED3C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 19:30:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id o5so33393931ljc.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 19:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MT/OlpZj9NraHsWocJA9IVNe9rHq1qHjdUaaQ1JT/Z4=;
        b=Np0N2R+7YmOHb96OO5nUEp5JRJKVjcSnvXLusL64XYsqB6o9xRJwt2F1TN9dNjaXd1
         ksb11227JNEblF85143GVKhF3k5VBolLA/Rh1Eu/V9owhk7hu6zUQ1H1A19UceyQJ5sh
         am7+/dLcRUrE0BT/Nzyfxo/LiKx+0pJ9sn+44SsskSqcrMK2H2qxzzGRnW0bATorM1YM
         GsegQzepteKEasEYzNADETmElbRwgzSKGHxiVVEfaxq6kytZp7SButejuUgyc5FodJiG
         iCSIPlBA3POc4rHiT8MUakOHPmmeHGZX4Pgw1a5OYoTG1Xh+PCKe4TwSpMRLDZmKn+UE
         uN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MT/OlpZj9NraHsWocJA9IVNe9rHq1qHjdUaaQ1JT/Z4=;
        b=Bjdx04IxFX4TFRAkRzCccB+H9Z2+hF5t18aapPjQqbR+uJwNZU+o5AAB9ZzneZYRpI
         bKo8K/t2X+L0jR5Cpid+Qkg+S2+bIpdjHo09yskQH5fKndqges2mSsL1c2vSF9ZSNMlF
         jSqkd44rQURGPAVMxJPDzuHrjBwMme/VAORO5UrBu/GXueA+ymX2T56lCgquNTgVfwwH
         BLiBnegFkiOqCyP/N0za0z5G1VXG2I7Ep4PZSCoapZheTphzt+g/Y4rLbBXWn+SLWgCx
         bguSNTK8T5VW7ivMy2FYHtrKYMUVcUn3Aq7ujTnWL9mHIbvedJgiggzrKfz4TPcjyHA4
         Ejsg==
X-Gm-Message-State: AOAM530TMfXKv7Hqwa9+NtFkeOSKsWMi0OqKaWai4lnwG866k7Mbff7F
        0yKghaYfsRy4AaHNQexabgcv5IdtFPAPncZrXHMxTw==
X-Google-Smtp-Source: ABdhPJw12mUcKoutYBI5Q0qO4fpp7GgritP3HhtMKyMZPk+7hQVh9x2iYN18iCBDri8kqeUKcmvdBv2LVQcrcA9THFs=
X-Received: by 2002:a2e:a71e:: with SMTP id s30mr14653968lje.137.1619490619208;
 Mon, 26 Apr 2021 19:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619104091.git.matheus.bernardino@usp.br>
 <6379b8df6a59361dd44733e379880a11c6cd977c.1619104091.git.matheus.bernardino@usp.br>
 <1b1cdef5-7d90-c6f3-ea8d-e1c9d472ffff@gmail.com>
In-Reply-To: <1b1cdef5-7d90-c6f3-ea8d-e1c9d472ffff@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 26 Apr 2021 23:30:08 -0300
Message-ID: <CAHd-oW7-Lv9hZZGDjVHjvDKvYpJ0wektVVPNrazZ441K25SczQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] parallel-checkout: add tests for basic operations
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 4:18 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 4/22/2021 11:17 AM, Matheus Tavares wrote:
> > Add tests to populate the working tree during clone and checkout using
> > sequential and parallel mode, to confirm that they produce identical
> > results. Also test basic checkout mechanics, such as checking for
> > symlinks in the leading directories and the abidance to --force.
> >
> > Note: some helper functions are added to a common lib file which is only
> > included by t2080 for now. But they will also be used by other
> > parallel-checkout tests in the following patches.
> >
> > Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
>
> Is this a standard thing? Or, did you change the patch significantly
> enough that "Co-authored-by:" is no longer appropriate?

No, I think "Co-authored-by" is appropriate, let's change this trailer :)

> > +++ b/t/lib-parallel-checkout.sh
> > @@ -0,0 +1,37 @@
> > +# Helpers for t208* tests
>
> I could see tests outside of the t208* range possibly having
> value in interacting with parallel checkout in the future.
>
> Perhaps:
>
>         # Helpers for tests invoking parallel-checkout

Will do!

> > +
> > +set_checkout_config () {
> > +     if test $# -ne 2
> > +     then
> > +             BUG "set_checkout_config() requires two arguments"
> > +     fi &&
>
> A usage comment is typically helpful for these helpers:
>
> # set_checkout_config <workers> <threshold>
> # sets global config values to use the given number of
> # workers when the given threshold is met.

OK, I'll change that.

> > +
> > +     test_config_global checkout.workers $1 &&
> > +     test_config_global checkout.thresholdForParallelism $2
> > +}
> > +
> > +# Run "${@:2}" and check that $1 checkout workers were used
> > +test_checkout_workers () {
>
> This simpler doc style works, too.
>
> > +     if test $# -lt 2
> > +     then
> > +             BUG "too few arguments to test_checkout_workers()"
> > +     fi &&
> > +
> > +     expected_workers=$1 &&
> > +     shift &&
> > +
> > +     rm -f trace &&
> > +     GIT_TRACE2="$(pwd)/trace" "$@" &&
> > +
> > +     workers=$(grep "child_start\[..*\] git checkout--worker" trace | wc -l) &&
> > +     test $workers -eq $expected_workers &&
> > +     rm -f trace
>
> I wonder if this should be a "test_when_finished rm -f trace" being
> recorded earlier in the step.It would also benefit from using a more
> specific name than "trace". Something like "trace-test-checkout-workers"
> would be unlikely to collide with someone else's trace.

Good idea, I'll change the trace file name.

Unfortunately, I think we won't be able to use `test_when_finished`
here as this function is sometimes called inside subshells, and
`test_when_finished` doesn't work in this situation :(

> > +# Verify that both the working tree and the index were created correctly
> > +verify_checkout () {
>
> Add usage of a repo in $1?

Sure!

> > +     git -C "$1" diff-index --quiet HEAD -- &&
> > +     git -C "$1" diff-index --quiet --cached HEAD -- &&
> > +     git -C "$1" status --porcelain >"$1".status &&
> > +     test_must_be_empty "$1".status
> > +}
>
>
> > +TEST_NO_CREATE_REPO=1
> > +. ./test-lib.sh
> > +. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
> > +
> > +# Test parallel-checkout with a branch switch containing file creations,
> > +# deletions, and modification; with different entry types. Switching from B1 to
> > +# B2 will have the following changes:
> > +#
> > +# - a (file):      modified
> > +# - e/x (file):    deleted
> > +# - b (symlink):   deleted
> > +# - b/f (file):    created
> > +# - e (symlink):   created
> > +# - d (submodule): created
> > +#
>
> An interesting set of changes. What about a directory/file conflict?
>
> Something like this might be useful:
>
>  # - f/t (file):   deleted
>  # - f (file):     created
>
> in fact, it could be interesting to have a file conflict with each
> of these types, such as the symlink 'e' and the submodule 'd'.

Sure, I'll add those. (But we already have the symlink case with 'e/x'
(file) and 'e' (symlink), no?)

> While we are at it, what about a symlink/submodule conflict? I know
> it makes the test bigger, but doing everything simultaneously through
> a carefully designed repository helps prevent test case bloat.
>
> > +test_expect_success SYMLINKS 'setup repo for checkout with various types of changes' '
>
> Could we split this setup step into two parts? Once could
> set up everything except the symlinks and would not require
> the SYMLINKS prereq. We could then have another test with
> the SYMLINKS prereq that extends B1 and B2 to have symlinks
> and their conflicts. The remaining tests would work on any
> platform without needing the SYMLINKS prereq.

Good point. I think we might be able to create the symlinks with
`test_ln_s_add` and completely get rid of the SYMLINKS prereq :)

> > +test_expect_success SYMLINKS 'sequential checkout' '
> > +     cp -R various various_sequential &&
> > +     set_checkout_config 1 0 &&
> > +     test_checkout_workers 0 \
> > +             git -C various_sequential checkout --recurse-submodules B2 &&
> > +     verify_checkout various_sequential
> > +'
>
> I see all these tests are very similar. Perhaps group
> them to demonstrate their differences?

Makes sense, I'll do that.

> parallel_test_case () {
>         test_expect_success "$1" "
>                 cp -R various $2 &&
>                 set_checkout_config $3 $4 &&
>                 test_checkout_workers $5 \
>                         git -C $2 checkout --recurse-submodules B2 &&
>                 verify_checkout $2
>         "
> }
>
> parallel_test_case 'sequential checkout' \
>         various_sequential 1 0 0
> parallel_test_case 'parallel checkout' \
>         various_parallel 2 0 2
> parallel_test_case 'fallback to sequential checkout (threshold)' \
>         various_sequential_fallback 2 100 0
>
> > +test_expect_success SYMLINKS 'parallel checkout on clone' '
> > +     git -C various checkout --recurse-submodules B2 &&
> > +     set_checkout_config 2 0 &&
> > +     test_checkout_workers 2 \
> > +             git clone --recurse-submodules various various_parallel_clone &&
> > +     verify_checkout various_parallel_clone
> > +'
