Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C13EC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 17:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbhLHRIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 12:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhLHRIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 12:08:05 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E9C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 09:04:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so10671446edd.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 09:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x60ehEPA88DdOCK6zM9ut+WBMu/JI/t9U3E6sOEydS8=;
        b=CgxeWI1C3Gr8bZ/Yj+GHIsY8vMfPehjXB64Ug9iGMjntsi/KcMCL3+Q6SEvFrRMNIk
         RYJHnns683nUHecJ5v/pF1d71/3wO7k1g2ar2jVhMLhd8McrVDtWPFyTpy0n4x/Dkgkp
         QMZ3i8RvSTQFqDcoQojU0L0UyfFBpoz8qSyqwfrx2etB0VGN5pTrv/tkLrSalj4acuTG
         qLQ7qIER5QHoz6TWLiWJKhqnlf0dOzFWLqS6Pnulz3SBrEKPiu7SIpq1CuiYqmtO6+jf
         dtucwn3XM6LePtLbM14uLyqTM5C+9R+hxD3cDyaQ+jbiiWroWY2lj8jE1CQBmqOHvDEP
         C0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x60ehEPA88DdOCK6zM9ut+WBMu/JI/t9U3E6sOEydS8=;
        b=RZlmZX5ttGX3JH0iOBU14BdRLz5l7H8Y+KjOACIS+VHaaRjg9KfP51iYNKfq4ymH6g
         i7s1B8VYQJ5EIPY6aEtTXQGgFKv32hKiT+QuAsN/d4ruJAdqDF5jVQWphpir5pLYZXQd
         NIik/GJpvrHmgf3YLsKUhcYh8JnqJPY5bYHJrZVuvRVRUehlAkpAKcxykY4WO0cca8IH
         pzJYq+CYpyPv8Eauu7uPaNtILrVWzgca6vA8ypnE1Ti+PiJSooHMzX0JyOzmc5IW81C9
         w+wgvgNoLdvxScqo5x2wr47rMv74ybEpYJOZon+38o720fA1env+qqlGmdEqLYASz/g+
         KJ3A==
X-Gm-Message-State: AOAM532Iqk6mZzgmNCevh8QNiLCrQbwf0aFrvh4FNRXCicmutrLdv/SR
        qnUyTVohHstj2xdfOGyCSxnQK0lz0Zn1f1ej7ZOz1iF1
X-Google-Smtp-Source: ABdhPJwv0K5e0P3Ry5vGvP5eU6CQa97B2GZBwStwl+xJLmm8ERcYbNDawbq+G6u7wpN+VK6g1ICaUkK8T0neacuQjDk=
X-Received: by 2002:a17:907:75d3:: with SMTP id jl19mr8976288ejc.520.1638983070286;
 Wed, 08 Dec 2021 09:04:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
 <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com> <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
In-Reply-To: <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Dec 2021 09:04:18 -0800
Message-ID: <CABPp-BGJJM757CoOPjP=XBK-cMMGJemaeruxXSN9TEGmk+NKvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 7:14 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/22/2021 9:07 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > On Tue, Nov 16 2021, Derrick Stolee via GitGitGadget wrote:
>
> Things in the dependent topics are starting to simmer down, so I'm
> back revisiting this topic.
>
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >> [...]
> >> +test_expect_success 'ls-files' '
> >> +    init_repos &&
> >> +
> >> +    # Behavior agrees by default. Sparse index is expanded.
> >> +    test_all_match git ls-files &&
> >> +
> >> +    # With --sparse, the sparse index data changes behavior.
> >> +    git -C sparse-index ls-files --sparse >sparse-index-out &&
> >> +    grep "^folder1/\$" sparse-index-out &&
> >> +    grep "^folder2/\$" sparse-index-out &&
> >> +
> >> +    # With --sparse and no sparse index, nothing changes.
> >> +    git -C sparse-checkout ls-files --sparse >sparse-checkout-out &&
> >> +    grep "^folder1/0/0/0\$" sparse-checkout-out &&
> >> +    ! grep "/\$" sparse-checkout-out &&
> >
> > I think all of this would be much clearer both in terms of explaining
> > this change, and also for future test relability if it did away with th=
e
> > selective grepping, and simply ran tls-files with and without --sparse,
> > and then test_cmp'd the full output (after munging away the OIDs).
> >
> > I.e. the sort of output that's in my just-sent reply to the CL:
> > https://lore.kernel.org/git/211123.86lf1fwrq5.gmgdl@evledraar.gmail.com=
/
> >
> > We really don't need to optimize for lines of tests added, and having
> > ~30 lines of plainly understood diff output is IMO preferrable to even =
5
> > lines of tricky positive & negative grep invocations that take some tim=
e
> > to reason about and understand.
> >
> > I.e. something like:
> >
> >     cat >expected <<-\EOF &&
> >      100644 blob OID   e
> >      100644 blob OID   folder1-
> >      100644 blob OID   folder1.x
> >     -040000 tree OID   folder1/
> >     +100644 blob OID   folder1/0/0/0
> >     +100644 blob OID   folder1/0/1
> >     +100644 blob OID   folder1/a
> >      100644 blob OID   folder10
> >     -040000 tree OID   folder2/
> >     +100644 blob OID   folder2/0/0/0
> >     +100644 blob OID   folder2/0/1
> >     +100644 blob OID   folder2/a
> >      100644 blob OID   g
> >     -040000 tree OID   x/
> >     +100644 blob OID   x/a
> >      100644 blob OID   z
> >     EOF
> >     git [...] ls-files --sparse >actual.raw &&
> >     [munge away OIDs] <actual.raw >actual &&
> >     test_cmp expected actual
> >
> > Would test everything you're trying to test here and more (would need 2=
x
> > of those..), and would be easier to read & understand.

The loss of checking for trees would be bad; the point of testing a
sparse-index is that it has tree objects in it.  However, the basic
suggestion inspired Stolee's variant below that does check for trees.
So...

> I don't think it is that hard to understand "I expect to see these
> lines and not these lines" but I am open to more fully verifying
> the full output and demonstrating the change that happens when the
> flag is added.
>
> Taking your idea and applying it to 'ls-files' (without --stage to
> avoid OIDs which would change depending on the hash algorithm), the
> start of the test looks like this:
>
> test_expect_success 'ls-files' '
>         init_repos &&
>
>         # Behavior agrees by default. Sparse index is expanded.
>         test_all_match git ls-files &&
>
>         # With --sparse, the sparse index data changes behavior.
>         git -C sparse-index ls-files --stage >out &&
>         git -C sparse-index ls-files --stage --sparse >sparse &&
>
>         cat >expect <<-\EOF &&
>          e
>          folder1-
>          folder1.x
>         -folder1/0/0/0
>         -folder1/0/1
>         -folder1/a
>         +folder1/
>          folder10
>         -folder2/0/0/0
>         -folder2/0/1
>         -folder2/a
>         +folder2/
>          g
>         -x/a
>         +x/
>          z
>         EOF
>
>         diff -u out sparse | tail -n 16 >actual &&
>         test_cmp expect actual
> '

This actually looks quite nice, though the magic '16' is kind of
annoying.  Could we get rid of that -- perhaps using something to rip
out the diff header, or using comm instead?

Also, perhaps 'dense' rather than 'out'?
