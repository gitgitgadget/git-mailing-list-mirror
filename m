Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E337C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 09:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiAVJbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 04:31:02 -0500
Received: from mout.gmx.net ([212.227.17.20]:53631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbiAVJbC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 04:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642843857;
        bh=aIYu9PjacTkyN/IgAlFPMwBqGYvGCvs/TVTDyuiewlM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bfuKywtMUJBvzdsPOIBB/rTlpyGqhu5XHVKVg8cVB6HQeCuN9Bq2PcNfceohCXGzY
         2XrSEt0TyCPy0qfij5SpIPQUWYRNMC1e0fNYKHMl19zh5cakMZc55dNVh+iFKwJ2iY
         JNdPNFRMvRafBIG8SzCQTx6R7/7rgT/4sAygJwq0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMofc-1mudFt1jq0-00ImmF; Sat, 22
 Jan 2022 10:30:57 +0100
Date:   Sat, 22 Jan 2022 10:30:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] sparse-index: sparse index is disallowed when split
 index is active
In-Reply-To: <xmqqtudwbl64.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201221008330.2121@tvgsbejvaqbjf.bet>
References: <pull.1119.git.1642613379.gitgitgadget@gmail.com> <d5c1440d9a9c943bf195a9d158c4badbd9a022a3.1642613380.git.gitgitgadget@gmail.com> <xmqqtudwbl64.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N+e+9uurbc5FQx96SnWXmlN7fTZA1buwwgKIti32Fi4bTh5JXaA
 yOM+crqEdG9GgOkmn2it+ZDJORoKJbF6Cn77QbkrXhIz/3Ln/9jE/1LLxE2WWpoZmkTXkQo
 KuU/ltJvJyPQq56ot4cz/fjyuPjigkTq2TDJLOwF/zHwa13EIdGYM5RNZ1+y/wpRan/u7UY
 dPAIl5sC7p8E8p7WFIZYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rrDA0I8o0Qw=:3BemT4DXSx+nk2AgsoG79v
 5LfbPMvFSKDz6RkVP73PbhNOS+/Ki/o/0nk4ymNu7TPEVkridY3Pdvf+Cj4Pgx2G+L8KaZIwC
 iAk4KELeA7mPYXBUWfAdavDv9zUyiWK/Zrmm3eVOXuRLsmoI6rC3i40Xu+r1uoIgpFxM4oeD+
 v/tbCJtWAnCImWdcX1eEwl703U6SDpWQd/xAs08lwUXkeMY5sebBz7H2Z5yKBoyaDXSk42rU3
 4XE23uJPEq7bI4sPfX1QrKELmeEjfLZQ+qbsSY/lb+jUY7oDDLqy2xRQP/S6SZMOspbuodIWl
 ZhVym2lqlCCWrrPumk3o5CaHjOOtqbakZZJ4OVLDAZy9pZnVFG1ucff+ZI8cyFqwz5OKBWJAe
 4cDh9q9QetzTdlE5jBRO1fwoeguIGbEKnOi8rCcP5vLZo8ZFAtwdrtAetmCpE3j4MA6hIG3/n
 yUSQp0YGFJWOKBiuYLyT6qgD1ZtnVWBelEl4app6AXLnwwODLa2hLePWEpOT9fw61gD0loKVb
 J6msgpahf3No8JByj/2A4BPRYwZgfQ66wEfQIc6eANRlQSkrdMvY9l8DKU54misqHdhlzDKVj
 Gg7znf4IpLEki/YkEH2pZnYV6CxO/XzKRhDfHnPJ1rYRrHKqB4OZvHDa+1BtNABVJmXoYLoIU
 83CrTKgw6bUZMJ2KEYHfvA+m6UXOdj5K5Pghdmxi0oPWZQOzt81YvYLT2i2QJ+Z7PkS+9CWAb
 iArHOvF4esBIlDWmZ2hQQ21tyY8IwiNhqHJCJSGaJnY9vrU7dXHyoarMGNiupBOG+pcp2mmgr
 k2AOFIiYycx7gTdjMSsBF5eVNw5TCrJFEEfa9BOTqSfHcMcyD58QvRzkRr1d7JUTguj5cBXjh
 6ZCsUaLYPtdxlxYWRpzpTglpq71nrA+qLvbJBtgeSMrj/8CfZRe+f4jU8KDvUsLpwbY+nD2OY
 wbNitz+O6i1yOiRupoWpXXilQaBoy0ychsLxjDgYbqh/VbSK/3BePgHGrQBdZhVQm6hiIcMcv
 u8AwcenOO+j6BXLhwy8YBrkBmlHpthoyhflHsF9dRBepi+XWoY7JuimEyHZk/fYE9p2HQ8B0K
 3DuRTPlu3FYY58=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 21 Jan 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 6e773527b6b (sparse-index: convert from full to sparse, 2021-03-30)=
,
> > we introduced initial support for a sparse index, and were careful to
> > avoid converting to a sparse index in the presence of a split index.
> >
> > However, when we _just_ read a freshly-initialized index, it might not
> > contain a split index even if _writing_ it will add one by virtue of
> > being asked for via the `GIT_TEST_SPLIT_INDEX` variable.
> >
> > We did not notice any problems with checking _only_ for `split_index`
> > (and not `GIT_TEST_SPLIT_INDEX`) right until both
> > `vd/sparse-sparsity-fix-on-read` _and_ `vd/sparse-reset` were merged.
> >
> > Those two topics' interplay triggers a bug in conjunction with running
> > t1091.15 when `GIT_TEST_SPLIT_INDEX=3Dtrue` in the following way:
> > `vd/sparse-sparsity-fix-on-read` ensures that the index is made sparse
> > right after reading, and `vd/sparse-reset` ensures that the index is
> > made non-sparse again unless running in the `--soft` mode. Since the
> > split index feature is incompatible with the sparse index feature, we
> > see a symptom like this:
> >
> > 	fatal: position for replacement 4 exceeds base index size 4
> >
> > Let's fix this by avoiding the conversion to a sparse index when
> > `GIT_TEST_SPLIT_INDEX=3Dtrue`.
>
> Does [2/3] allow you to sidestep that issue entirely by skipping
> 1091 altogether?

You are right that reverting this patch after applying the next patch
_still_ works around the issue. That's because currently only t1091
exposes the bug where `GIT_TEST_SPLIT_INDEX` writes a split index that was
initially non-split (because it was just created).

My intention here was to avoid any problems in case _another_ test script
triggers the same condition. After all, we do have an entire CI job that
forces `GIT_TEST_SPLIT_INDEX=3D1`, and in microsoft/git we enable sparse
index by default. The entire test suite is therefore surface for the bug
to show.

> There are 4 hits of "if (istate->split_index" in the codebase, and
> this patch makes me wonder why it is suffice to patch only one of
> them.

I tried to catch only those locations where we run the danger of trying to
make a split index also sparse, or a sparse index also split.

> I also wondered why we test both split_index and environment
> separately, instead of splitting the index very early when the
> environment variable is set, so that the rest of the runtime does
> not have to worry about the environment, but is the reason why such
> an approach was not taken was because GIT_TEST_SPLIT_INDEX can later
> allow the index to be splitted, even if istate->split_index is still
> NULL right now when this function is called?

Indeed. A freshly created index will never be split, even if
`GIT_TEST_SPLIT_INDEX` is set. Only when we _write_ this to disk will it
be turned into a split index. At this point, we might have mistakenly
converted the index into a sparse one, though, and this here patch wants
to prevent that from happening.

> If that is the reason, it leads to another question.  Even if we
> ignore GIT_TEST_SPLIT_INDEX and concentrate only on real workload,
> if the in-core index can be NULL when this function is called and
> then later can become split, there still must be somebody who
> notices that sparse index is unallowed when (or after) such a split
> happens, no?  If there is no such code, then this patch would not be
> the whole fix and there needs more change to do so, no?

Indeed. Hence 3/3 which tries specifically to prevent the user from
turning an already-sparse index into a split index. You will note that
3/3 calls die() instead BUG() in such a case because it would constitute a
pilot error, not a bug in Git's code.

Ciao,
Dscho
