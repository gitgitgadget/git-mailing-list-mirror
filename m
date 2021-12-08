Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB4EC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbhLHSdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 13:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbhLHSc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 13:32:59 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59601C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 10:29:26 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z5so11457146edd.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 10:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hn5vm8zjhA+uOo7UfNopmTmsGByWW8vPcBAfVSdfrFg=;
        b=IHrPOh9LtNgRw4pbu2gU8wwJHIv64tOiXYS2siXOYD1CrbMu0qpYWwDRyEtXa/5tQ7
         h2iT9A3L9YF58VXY7VCRIjiybTjcLWRe6druDnHgYvAvguRaIRdX0xt5MR3/Zn6X2A1q
         A9hJpniDjnz7cz09FZ2GLPtjrh7lTdtLGtoH1JOPyOVBqHud/x1a8YLTuJwFiVGWpjRN
         apvPtsdiqUQYIXEbD4E2i5FYQ8RMi8AoxNptS482Bvf/HjETsOQPbekT59uH00UosibH
         TOaLq9SE6FAb8IQ6HzPPJKxyKUp4oka2pgdVQfofEe5O8PL2aQH4XF3CxkJG0Yt3o6ZK
         e3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hn5vm8zjhA+uOo7UfNopmTmsGByWW8vPcBAfVSdfrFg=;
        b=sTuhYVtCQasuk25GOBGXfPWev7jCOpvcb/jabgN/q3eaDcSRfmUzECgpenruCblV+4
         ITSTr9mWjUwfcOFFg8vfGrVDxqbA1TJHXTnw06AZGsGNhJEQN4xytPmdctZGWLXUM3iP
         INDCsPes81DtorVvdSkshjSl8PZqJ36pzsUGwQVEQLxsL0YdJqRc/Ls3wXPjgATFUASc
         PGA0OrItyc7QpggmOf9MxvTCMD/2Da0BdoXzhBgOCsNyl2arnemzVbeV9snwGw1LwSxi
         e9u83MteopwpCzz8hDbZC0o3y0k/g/Fmnokbqd7V3AKly94Zr+/YFt2/Fv5jhb7gR1OV
         YRsg==
X-Gm-Message-State: AOAM532CQqFtvqgxHaIUu2nc1+gFLaqyhO+77vogySUcl+odXazLf39q
        Uao72U2VRBpNu34c2tZyIpyESk/9R9mwlbetIDFBPiZXq84=
X-Google-Smtp-Source: ABdhPJxAH71iU5cGKdbs79240+OiRq9nxX8Zoktv3s9Gf9PxcUia4TY49ZYw+eJgGZ4mceYueTFW1SyziYyOIjW42IA=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr9884572ejc.74.1638988164869;
 Wed, 08 Dec 2021 10:29:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com> <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g> <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Dec 2021 10:29:13 -0800
Message-ID: <CABPp-BFmNiqY=NfN7Ys3XE8wYBn1EQ_War+0QLq96Tk7FO6zfg@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I know this was directed to Junio, but I feel like it was my earlier
comment that accidentally opened this can of worms, so if my opinion
helps resolve it at all...

On Wed, Dec 8, 2021 at 3:15 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio,
>
> On Sun, 5 Dec 2021, Junio C Hamano wrote:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > From your wording it sounds like the plan might not include moving
> > > these tests over.  Perhaps it doesn't make sense to move them all
> > > over, but since they've caught problems in both Scalar and core Git,
> > > it would be nice to see many of those tests come to Git as well as
> > > part of a future follow on series.
> >
> > Yeah, we may be initially queuing this without tests for expediency,
> > but a production code cannot go forever without CI tests to ensure
> > continued code health.  People make changes in other parts of the
> > system Scalar may depend on and unknowingly break some assumption
> > Scalar makes on it.
>
> The Scalar Functional Tests were designed with Azure Repos in mind, i.e.
> they specifically verify that the `gvfs-helper` (emulating Partial Clone
> using the predecessor of Partial Clone, the GVFS protocol) manages to
> access the repositories in the intended way.
>
> I do not know off-hand how entangled the GVFS part is in the test suite,
> but from what I recall, every single test starts with cloning a test
> repository. From Azure Repos. Using the `gvfs-helper`.
>
> Which means that the `gvfs-helper` would need to be upstreamed and be
> maintained in the git.git repository proper.

Ah, sorry, I was remembering this from an earlier cover letter of yours:

"""
But it was realized that many of these key concepts were independent of the
actual VFS and its projection of the working directory. The Scalar project
was created to make that separation, refine the key concepts, and then
extract those features into the new Scalar command.
"""

when I read

"""
One other thing is very interesting about that vfs-with-scalar branch
thicket: it contains a GitHub workflow which will run Scalar's quite
extensive Functional Tests suite. This test suite is quite comprehensive and
caught us a lot of bugs in the past, not only in the Scalar code, but also
core Git.
"""

and I was thinking (despite the branch name) that you had some scalar
+ git (w/o gvfs) tests that were interesting but not planning to
upstream.  I agree that if they're gvfs + scalar + git then they make
sense to keep internal to your work, though I hope that for any bugs
your internal testcases find in git, that you find an upstreamable
testcase to submit.  I believe Stolee has done exactly that in the
past, so just more of that would be good.

> Previously I was under the impression that that might be met with grumpy
> rejection.
>
> I do realize, though, that clarity of intention has been missing from this
> mail thread all around, so let me ask point blank: Junio, do you want me
> to include upstreaming `gvfs-helper` in the overall Scalar plan?

I know I'm not Junio, but if my opinion matters, I don't think that
needs to be part of the plan.
