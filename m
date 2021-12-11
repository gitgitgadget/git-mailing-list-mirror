Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93F0C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 13:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhLKNqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 08:46:13 -0500
Received: from mout.gmx.net ([212.227.17.21]:33795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhLKNqN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 08:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639230364;
        bh=YH9i+cGE9KWna1g/6ovqfn4JlV/bmPdJzG0+M0BzRho=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SX1Jk3ubx1kjhzTcZJkEoDRORFhr/pK1ORae104jx7CBJa/FFxbqmqc9HbrJ7WbQm
         64CmcW0k6m42v+Od3u7teTYi6NcDR8rPpGoZ7MhxdLu/OwpgMee/BC7Kul9tOi+RlX
         qqwTNYg9F+dC090qquU1V9FgQ1X7cW+j4cg9JSsk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1msku83Cvs-007m8O; Sat, 11
 Dec 2021 14:46:04 +0100
Date:   Sat, 11 Dec 2021 14:46:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
In-Reply-To: <CABPp-BGt=AcCg-74SSpS7iPFOCKnWE7Q7+CruvALLxKnqXGRuw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112111445380.90@tvgsbejvaqbjf.bet>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com> <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com> <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com> <xmqq4k7nmksi.fsf@gitster.g> <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
 <xmqq8rwuv3i2.fsf@gitster.g> <nycvar.QRO.7.76.6.2112110044010.90@tvgsbejvaqbjf.bet> <CABPp-BGt=AcCg-74SSpS7iPFOCKnWE7Q7+CruvALLxKnqXGRuw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hyOIE7hBqw92bAdoU1PGcDD6jOO++Uhy9cWB52baL4yMiPbM0uG
 DxBm2id28j7B80z3YKNyVzJbt+4G4YFjtBMxxoy5K/nWcttbtr6oIoRq+X/qBdW8M4s+OdZ
 +iZJaaI0FsgGY52vovk7DUZAP8wzrldHvhTWI/QS+EzZbNb5/uW9FmOdSa2KeUQa99bUffN
 w0NH8LXhiLyAFbxmDxkhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j5xcjrm5WAo=:xVtp3uSvGc5YSiRGk1Q0Wq
 NAlLyjzS/y5Kz6OZRDl+3cTQvV4sfR3hZBdoraODfzUS9njGHpElR0Y6e47sDcFwJM005LMY8
 fQmVaB5tXkx3CkGidDbVqWj8JR7q2iVX/GTIv2y3lo5zzKaVPRISS7fBuXTwiQW7pQfoy6umr
 zt8At6Mh2+Yb27QlLV7WED52Y9KcDIROxZQv1PEosxO+5DtbxHPzpMw7+h0vgiMz/Ug1A6mk8
 Wxn5eoASnxCdJcLTfDwU3RPcRDshHWN9ZOuv+/wXvP/8VkQ4r1bcP0E/Un3LnaiqLMkcrYU0J
 x6cGbJq2Bk4hB+jb7IF6Q4aytgcxHDk2zfFNs8Sb6GJIpury22oC+KRX+iazcn+o/RPG6h0XX
 +FbOT4jlqXoMEsHG+m1wPWOVGPPvllnfIW1+FLYGsuG+CKCQojtagsUiwVBTkFFkSaVlshLXU
 o29SgRuVwPIVHHX9yGydhetYdglK1W5Xrjoq7mi0rwYis8Xz10RjFU02t1yxTWW9PMluMeVzL
 qm5DMELgSBRsx9kphQrWu2sh00mcPybHqL/K01QsX3DknsAvZAMH+q4ykh8/QS3eekRYZuGAk
 rS+wEPpvOIH1tVuewoFPaLcOtqE1FGyMoDHeFi14R/8V7rpMCTsqs19QCH4Ugcd0yEOCwrs08
 Uce0HSu72V32E0NNtrFXrC6oqmNg9kCCYOy6WX0IsGdno/5NXz+JtqGQY5k22nxsn2GSyepX9
 LXcbXdRAhIetj3H8aZBSPu8t6C0C7M00nwkjJq5HtfHetFPEYYwWyEgbmW/KiBmQ9UP/csjMq
 gAEikcy/84n0Ie+qhYXAZ+CJ0TZoRpASxzJfr1RuBdzcWwrxQvd38Wj3dqr34QV/dSmiozKda
 IahINqbiPpAp/pPZPC2ems9IQOO35lELXxMzOfPvfCpfQh5cu30KFSIjf270YyGC+gTMCHGgd
 EPOsqFHPtdhafqQDeDGJ5GqcDBJb+bDEktsJF2WrWA3Pj6Y5cFAQNjhvP4eKCZ6BeSHrj5ifn
 hsRiYzj1842RWN+vlk/bvJ/+YzXmAEb0UOi3WM10sXB2B16wL9NDcD3dkS/zjRF4L9xF62688
 8cZ07MVnaijSMg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 10 Dec 2021, Elijah Newren wrote:

> On Fri, Dec 10, 2021 at 4:29 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 8 Dec 2021, Junio C Hamano wrote:
> >
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > > > The Scalar Functional Tests were designed with Azure Repos in mind=
, i.e.
> > > > they specifically verify that the `gvfs-helper` (emulating Partial=
 Clone
> > > > using the predecessor of Partial Clone, the GVFS protocol) manages=
 to
> > > > access the repositories in the intended way.
> > > > ...
> > > > I do realize, though, that clarity of intention has been missing f=
rom this
> > > > mail thread all around, so let me ask point blank: Junio, do you w=
ant me
> > > > to include upstreaming `gvfs-helper` in the overall Scalar plan?
> > >
> > > Sorry, I do not follow.
> >
> > In
> > https://lore.kernel.org/git/CABPp-BGpe9Q5k22Yu8a=3D1xwu=3DpZYSeNQoqEgf=
+DN07cU4EB1ew@mail.gmail.com/
> > (i.e. in the great great grand parent of this mail), you specifically
> > replied to my mentioning Scalar's Functional Test suite:
> >
> >         > > One other thing is very interesting about that vfs-with-sc=
alar
> >         > > branch thicket: it contains a GitHub workflow which will r=
un
> >         > > Scalar's quite extensive Functional Tests suite. This test
> >         > > suite is quite comprehensive and caught us a lot of bugs i=
n
> >         > > the past, not only in the Scalar code, but also core Git.
> >         >
> >         > From your wording it sounds like the plan might not include
> >         > moving these tests over.  Perhaps it doesn't make sense to m=
ove
> >         > them all over, but since they've caught problems in both Sca=
lar
> >         > and core Git, it would be nice to see many of those tests co=
me
> >         > to Git as well as part of a future follow on series.
>
> This is me and my email you are quoting; these aren't Junio's words.
> I'm afraid my confusion may have snowballed for others here.  Sorry
> about that.
>
> I simply misunderstood at the time -- I thought there were scalar-only
> tests (rather than scalar+gvfs tests) that were not being considered
> for upstreaming.  As I mentioned before[1], I'm sorry for the
> confusion and seemingly opening an unrelated can of worms.  I agree
> that we don't need gvfs tests, or tests that combine gvfs with other
> things like scalar, or c# tests.
>
> [1] https://lore.kernel.org/git/CABPp-BFmNiqY=3DNfN7Ys3XE8wYBn1EQ_War+0Q=
Lq96Tk7FO6zfg@mail.gmail.com/

No worries, I am glad it is sorted out now.

Ciao,
Dscho
