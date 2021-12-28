Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0C2C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 23:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhL1Xp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 18:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhL1Xp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 18:45:58 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0A6C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:45:58 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m21so80769521edc.0
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=J3k8oxdlS/zILcIuGtEBLfpyBhb3JKq5n1g5nOZ6jWE=;
        b=ixvEmotm/3LtJTrGLvtcMgnsjiUsdNEuebzfF4JT7u69RwhLi1mla/32VE1JnX9Bin
         ItZUlzF2DImOpSHQKAdwrf3zkF2rbMc9cavXhJdvqg2kX3ujrDHOpJ1qN+mRd8xtUspO
         tHeyQvM84JlNrv6E7F9Eo2/qPsQHJUgpB2eRMrXTjp/CQ5FS3fWZ5eAZ7KAQLVLtCIw2
         4/OS0uw3XhnX9HgKmtjUpC8ZC2+MDFoMEV/zBx7Gh0gBvCLV08CToWPtAIZG2AW/tzwo
         PWMjcvEJJeewg7paOFt8EJnGYiLJWmImCPaXR/oWqtSAWHviGGvE337PL0Zr6E5hKeoD
         6pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=J3k8oxdlS/zILcIuGtEBLfpyBhb3JKq5n1g5nOZ6jWE=;
        b=y/o7L8D32fOReOCNc1It9zdSb9a/RtInMCZ1oWU8EXQRi2n8KNQhBJCHHsMobEIHIM
         Bp8YkW/A7DULrZmeywduhhT7M69ACgjkDuUQr72B6sNyYX/vjV4o0ajI2uh0MTkOp0lV
         MKYz8GaayiNSZAbNELBkh4b9wutx7vjH7PHDLTtLilNEAJikyrRwjGMSJFFOWoCedVsf
         ppWhzY+IQlU5cVqbQop23s9w7/Drv6C8UmZ/eA3KAb6L5ZAwOTv79G6WapoJ3JZmTPwS
         3jObNY9JPIm9gWw3gYEwnAiNmy/6yF2D3BcxLo2OCN+SMg+kBF6IoYRvszlHNd2YiSF3
         es4Q==
X-Gm-Message-State: AOAM532UYfD/jIf7LcaBAyqW0gpJoHm8UZk7ac6VuWutEA81+LKNqZNT
        sXkiopIYkEdCE34u4jvAFxslT9xvyAeAhZxaV4I=
X-Google-Smtp-Source: ABdhPJyUl1h+2DfoXGUJPjzerXLUC3/ZBnwLmWLatUfHiZzyR0IOl6WawV6R7723b3zisIXavKyTukLtUWSatS3THvs=
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr23186090edd.228.1640735156658;
 Tue, 28 Dec 2021 15:45:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com> <b3ae62083e14aecdfe909735b4daf0a36fa5e48c.1640419159.git.gitgitgadget@gmail.com>
 <20211228105600.h32jl5iwot3munww@gmail.com> <CABPp-BEJ+RiripJSonrOcJfRWKZDeoL83PDqE6beWwFqs1HxTQ@mail.gmail.com>
 <YcuXQQHsl8iVdK8R@camp.crustytoothpaste.net>
In-Reply-To: <YcuXQQHsl8iVdK8R@camp.crustytoothpaste.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Dec 2021 15:45:45 -0800
Message-ID: <CABPp-BHtnFWLpPxXF56BbMSayDOp9Qm1GhL3xCz7pQPcEJZ2Nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] show, log: provide a --remerge-diff capability
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 3:01 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-12-28 at 22:34:03, Elijah Newren wrote:
> > CC'ing brian in case he has comments on the sha256 stuff and whether
> > he thinks there's a cleaner way to make my tests work with sha256.
> > (brian: See the very end of the email.)
> >
> > On Tue, Dec 28, 2021 at 2:56 AM Johannes Altmanninger <aclopte@gmail.com> wrote:
> > >
> > > On Sat, Dec 25, 2021 at 07:59:12AM +0000, Elijah Newren via GitGitGadget wrote:
> > > > +test_expect_success 'remerge-diff with both a resolved conflict and an unrelated change' '
> > > > +     git log -1 --oneline ab_resolution >tmp &&
> > > > +     cat <<-EOF >>tmp &&
> > > > +     diff --git a/numbers b/numbers
> > > > +     index a1fb731..6875544 100644
> > > > +     --- a/numbers
> > > > +     +++ b/numbers
> > > > +     @@ -1,13 +1,9 @@
> > > > +      1
> > > > +      2
> > > > +     -<<<<<<< b0ed5cb (change_a)
> > > > +     -three
> > > > +     -=======
> > > > +     -tres
> > > > +     ->>>>>>> 6cd3f82 (change_b)
> > > > +     +drei
> > >
> > > nice
> > >
> > > > +      4
> > > > +      5
> > > > +      6
> > > > +      7
> > > > +     -eight
> > > > +     +acht
> > > > +      9
> > > > +     EOF
> > > > +     # Hashes above are sha1; rip them out so test works with sha256
> > > > +     sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
> > >
> > > Right, sha256 could cause many noisy test changes. I wonder if there is a
> > > more general way to avoid this; maybe default to SHA1 for existing tests?
> >
> > Not "could", but "does".  And this is not something to be avoided.
> > The default testsuite we run in CI involves a run of
> > GIT_TEST_DEFAULT_HASH=sha256 under linux-clang.  Making these tests
> > SHA1-only just reduces our coverage and makes the transition to SHA256
> > harder; I think that's the opposite of the direction we want to go.
> >
> > These changes I've made here are sufficient to make these tests work
> > under sha256; you can see the test results here:
> > https://github.com/gitgitgadget/git/runs/4646949283?check_suite_focus=true.
> > Under "Run ci/run-build-and-tests.sh" note that there are two runs of
> > tests, and the second has "export GIT_TEST_DEFAULT_HASH=sha256"
> > preceding it.
> >
> > There might be a cleaner way to make these tests sha256-compatible,
> > but this seemed like a pretty simple way to me.
>
> The question here is, do we care very much about testing these specific
> hashes?  If so, then we should use test_oid_cache to set up some OIDs
> and make sure they're correct for both SHA-1 and SHA-256, and then
> replace them in the code with calls to test_oid.
>
> However, my impression is that we probably don't care very much about
> what the specific values are, and in that case, this is completely fine.
> We do similar things elsewhere in the testsuite.

Thanks for chiming in.  Your impression is right; I don't care about
the specific hashes, just the general form of the diff content, so
I'll keep it as is.
