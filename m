Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF89C4320E
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 21:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF15460F48
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 21:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhHNVxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 17:53:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:35141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233141AbhHNVxo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 17:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628977988;
        bh=xrf6c1kq6vKI/EHY9YfvI2fQ/uMZ9c8AQg7Y6tVL6sU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KBVDGPCXrK72gfBvG+QNDYu4pQatl4h4alxQO9JlaVQ9c4wWh+G/DdEqu8il0Hhm0
         +go6ZD5bmNGdbInRzpgzlc3kwwoDq1TETixfp1lW7n1HHHmL/7/l3O03fjdOL8H32y
         wQlaSJxGRkJa7qyQw0GGlFseCq/AgfYjaD82PYAg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.179] ([213.196.213.229]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1mHiEI2ZFS-00FyR9; Sat, 14
 Aug 2021 23:53:08 +0200
Date:   Sat, 14 Aug 2021 23:53:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victor Gambier <vgambier@excilys.com>
Subject: Re: [PATCH 1/3] t3403: fix commit authorship
In-Reply-To: <3b438e42-488c-e4ab-d1fe-3d0992ef0619@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108142350420.59@tvgsbejvaqbjf.bet>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com> <7559781ca92096f89a6dcbfeeaa4d2b4d7b98094.1628587917.git.gitgitgadget@gmail.com> <CABPp-BFFTLgtrs_m9Gp7tSRwpBnAEoArhMZhhJcuzqNS_g8sUw@mail.gmail.com> <xmqq5ywddtsn.fsf@gitster.g>
 <3b438e42-488c-e4ab-d1fe-3d0992ef0619@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I+4fcWxOwgBOlA0lG4ceWjmbWDsbIWlruBiJPrUQ45qYH6ANm7F
 0G8MAKwxd5tRh22bHhQLASCBry1vGgMHvn4H66iBWiXySgrk0VouugDUT0h5+N+WnbIKgju
 UM5qe5h91v6k2OGMKJijmN3ZZgqp+3EbAcFH78A2NrJNNGVwJzTIeeGjv1HpNSO1wRqyeRU
 IwWzGYlW2i5hRZK2/nCng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wlyLT1H/H/Y=:MUzsesr0LoQQjvZaOENqXc
 PwPj3i1KU8DiJ6gRNRFi6qo2fR23H6Y7Xy/RJdCBp3c50kmiyzgkFwTN6zMLfmCY131ip+YfD
 q+MFiN37f/1nWnV878IaOV0mb5IX9KdCsnmCZkJ4QxLQaRAZKagF0TzydmaU5c5kOvseMq+pa
 zwS0pLohaFTadXz01dHi6NooH8BmFviwuxldNVmyDaBD8yv1Kw7G+xOvPdk8FWVWFuvPno5T+
 gAQ4AdSYCAsGqQXmuA25QeTxnXa7z3hR9DCCCNiGYMCG5WP4Svno0582b8+JkmW05sz3Jx66k
 zG4WxB45jMF88f8LYHC9ZUx1kygDadIhlcGiW0sH+k7+Q9hh/6eizEhuojH4EC/JnC3/n4nMF
 ZDBfIB3fbAgGcKZ2SdVqz0VdbPIHyuSUEu2zjDLNG8aABPhZaZPWy/+64OKh8Y8/dFXWOQtET
 fMlFeYUe7/o2ydzYHoAFN94yyLZxloQ9tgGOybnM8Mlga+UKg8oGfCyye2ls6S/26Y1GwEM3W
 FGMmekFbLjaIwHFzwwqD99dkM+wtmS5yCwHaLYooo2UjerR8y6YmTAXMler+dYNDIH9Rqexi4
 S/S46L5xWK1FcEylfXrlIQftj/IFcYRCiyPCYvLPOzsQDUR+JQderxhhtdKIdPYT4wqOTvBUj
 wc/7Bc0f/f9nv8p/duiHNg0pEKD/FnPHFrjNE5TzI+VxV1nA1zmyUx8KvSnVZnAtpU96+QigQ
 CRzGQZIT6DxGqXbTD8FngND48ZUFDEAaRV90SerD0K9dSE2sFNVyR434dlzz1qHAe7pDFZIBm
 k1zcq/N1JquSDS1Y4vLfqk6I8qyabMoXRogvyHZLi04RRyKvb7smH5ApFrLF/AKua2tkTF7hM
 WwrXPwot1pQKqR+ykcvNhmoH09Sn5Vr4BpGbkuSAKXWbLzV1E/Q5nL8PUk0lV6b64CncGy5qT
 kFMQpdpRun5ywj+Dz3UGvdl4jA7ytId42itnMAjoKRzeeqb4syIiZcyNbsipbEzlc94lvwj6n
 XFRLaJeZsETEbM1Zezdl8QtRyCVG8CwfELiTRFGQReip8LphRp5hmc0+Lt9ZnIvY4/1GDz0ok
 yQaZKZHGagJRuyeHjNQFU6OmFZO5l6QPeHwaUtD6Pglc0EFAT0el1rM2Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 12 Aug 2021, Phillip Wood wrote:

> On 10/08/2021 19:43, Junio C Hamano wrote:
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > On Tue, Aug 10, 2021 at 2:32 AM Phillip Wood via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > > >
> > > > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> > > >
> > > > Setting GIT_AUTHOR_* when committing with --amend will only change=
 the
> > > > author if we also pass --reset-author
> > > >
> > > > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > > > ---
> > > >   t/t3403-rebase-skip.sh | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
> > > > index e26762d0b29..6365c5af2f7 100755
> > > > --- a/t/t3403-rebase-skip.sh
> > > > +++ b/t/t3403-rebase-skip.sh
> > > > @@ -36,7 +36,8 @@ test_expect_success setup '
> > > >          test_tick &&
> > > >          GIT_AUTHOR_NAME=3D"Another Author" \
> > > >                  GIT_AUTHOR_EMAIL=3D"another.author@example.com" \
> > > > -               git commit --amend --no-edit -m amended-goodbye &&
> > > > +               git commit --amend --no-edit -m amended-goodbye \
> > > > +                       --reset-author &&
> > >
> > > Makes sense...but doesn't the fact that this test worked either way
> > > suggest that the specifying of a special author name/email was total=
ly
> > > superfluous and could just be removed?  If there really was a reason
> > > for specifying a different name/email, then is the test faulty for n=
ot
> > > checking for it somewhere?
> >
> > Good point.  The commit tagged with amended-goodbye is later used in
> > some tests that ensure the author ident does not change across a
> > rebase.  If this commit gets created without authorship customized
> > (i.e. before Phillip's fix), we would not catch a possible breakage
> > to make rebase discard the original authorship information.
> >
> > But with this fix, we now can catch such a breakage.
>
> I'll expand the commit message to make that clear

Maybe you could even add a `test another.author@example.com =3D $(git show
-s --format=3D%ae HEAD)`?

Ciao,
Dscho
