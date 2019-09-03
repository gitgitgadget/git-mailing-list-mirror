Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36DE91F461
	for <e@80x24.org>; Tue,  3 Sep 2019 13:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfICNeo (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 09:34:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:45645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfICNeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 09:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567517678;
        bh=CqD8NukKqK6EJHxrMV35jVH41wibp2pJHvYBOsiVjeI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eHW9jOfWIH8I7Zmj7sZaz/S96zxmt98mvK3UsZvH7qMNy62K8DCda54NIjuLYFehv
         ny7LiteBbksIwnTV7+hfGI/VFGnrqwX0aS4CZvexc5eYJYxD6T0GYLDjy2gAsxCifn
         XNx7bf4NUUhVYFg+FOhdqHzpzTgKLANUJ1/GLqTA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1iNN3o25aY-00zIks; Tue, 03
 Sep 2019 15:34:38 +0200
Date:   Tue, 3 Sep 2019 15:34:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 08/24] Ensure index matches head before invoking merge
 machinery, round N
In-Reply-To: <nycvar.QRO.7.76.6.1909030043460.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1909031532160.46@tvgsbejvaqbjf.bet>
References: <20190815214053.16594-1-newren@gmail.com> <20190817184144.32179-1-newren@gmail.com> <20190817184144.32179-9-newren@gmail.com> <nycvar.QRO.7.76.6.1909030043460.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2145648118-1567517680=:46"
X-Provags-ID: V03:K1:V3fsvhi4KWKqBeIyzRZylfNspOwTyhBy3gILd++eIezCAeCd5mH
 dMDvS8n/Zc/4eU/x1wR31QbbAGREsLk+6PdS6s9xmKpVNG3VeOBrIYFLY0QlyMr6kJyLdef
 cQQk6kq6G8S25/NWaSDuaMfi/adcDyif2LY5i75AGNFZV7kGWLy+l1oGVrvLfFgut01zKS1
 tFj1+6ryHxw613qTLnqzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SjYG3iKfsVM=:mb+uHbh6xngmIXWDP7POGN
 oh1aTRBCMtNFXEL4YRncnBRae8pLDnZFs2wvuZvcbX6+i9hxEuOVJ/l7HTZevnAIvmb3Vzrjp
 kqvNdi1uBvz1aptmM9C6fb1v7F8I4l6688rscO+GpNueHbg/68VPDKfuhZksgYpjbElBAEuNn
 dFHZ4CePbog3JoEmtiotiyGGy+Nr3DF1+GW5ump3b9whQjscIjfIsDPcuVhjtwZevyxe1SJ8B
 JLe9wYBxISv+xOc4jWDyrdNycVwUpJPtVZ94w8Hu+bnbfoOACNnK9gzvkUoF3eIlDKXDDdSoU
 IPkXyvAIs/CSe/5Al38MOzmO0J4XT0WPZSvfxtq50iGpKPcRQ/tZ9mHlyekTy67elyaXLgvl+
 0nYM0eEJHynU0Pgt/6oKR+mKJO1RI+t/AE2h6D38Gdz872gz2OfOiMZ8/a+WOfAPcMZhYn40u
 jjEilQpvHDLsFNIrx1X5VPmr238qh+TIva66sOXZQ8kUziPdY0bPFBwasAqpyzGWCRn7z3pqQ
 +k37vwj6mZEsRXiKSEwrIXdAtffskc88wwGW/voipzOlfyTDNuhmIYK9La3TwOu3xV8GPdhSy
 GPKFgs5VleneQC1PlMDN5uveEViH6EpjdzIp7gwT/CIqpEEqxTCLzhEpJeT3ON6dQ/g12Rfsk
 XoS4lKXpOSD1PKMg4cHovJ2Om2W9y/Of8L0V8lFvbteIT6eqcKeGRRvDuID+NHoPuNdLuAqPP
 TRUM3dPLg0MZmAyAgONy5QVeWdRH8l90Y3Dl5X52WXkyAiv0EiwzofSImTJaxWG2gUDBDbaKx
 HnI88KSXDHnNtDkpm5Z1RPyleK0H0xl/3S6ovJk3KgAW7MF71kYk2nUZoxMVHpE78rUd4QCTS
 EFdPRBhy9aPnH+xwYy50otyh5ogWcW0JUoYGPVf1I0nPae6vj7QWtdlWGzJ9zjYe6jF8Tuje3
 it4hLHiwIt98YeCbw+a/PWh+YjVraWJPGJCK8TpCPJMq1CSEUwGca1n5sZpJeLjasykf1Fvxv
 eHyNYviS3+nPh2/75MEE6/d/ZxZ6RbktmPtwMJtZYD+hQXPHBVAO6e8G4EnBnhj+LywzR+LVA
 MTj1TpWLlNkiJgu+uqZzlFJwAG5f5eMXwx1+/vBi41y6Aqssit2aWLtBrSIrYBenZpxWMZRbR
 UxguPlGFjjIIXjsVskXA+vFe1psI3lwwzq148GWNToEaQyzi63nDg1C7cW00iREYWQao4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2145648118-1567517680=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Tue, 3 Sep 2019, Johannes Schindelin wrote:

> On Sat, 17 Aug 2019, Elijah Newren wrote:
>
> >   * t3030-merge-recursive.h: this test has always been broken in that =
it
> >     didn't make sure to make index match head before running.  But, it
> >     didn't care about the index or even the merge result, just the
> >     verbose output while running.  While commit eddd1a411d93
> >     ("merge-recursive: enforce rule that index matches head before
> >     merging", 2018-06-30) should have uncovered this broken test, it
> >     used a test_must_fail wrapper around the merge-recursive call
> >     because it was known that the merge resulted in a rename/rename
> >     conflict.  Thus, that fix only made this test fail for a different
> >     reason, and since the index =3D=3D head check didn't happen until =
after
> >     coming all the way back out of the recursion, the testcase had
> >     enough information to pass the one check that it did perform.
>
> I fear that this test is still broken, it is a Schr=C3=B6dinger bug. Whe=
re
> `qsort()` is the cat, and the property "is it stable?" instead of death.
>
> In particular, at some stage in the recursive merge, a diff is generated
> with rename detection for the target file `a` that contains two lines `h=
ello`
> but has two equally valid source files: `e` and `a~Temporary merge
> branch 2_0`, both containing just the line `hello`. And since their file
> contents are identical, the solution to the problem "which is the
> correct source file?" is ambiguous.
>
> If the `qsort()` in use is stable, the file `e` comes first, and wins.
> If the `qsort()` in use is not stable, all bets are off, and the file
> `a~Temporary merge branch 2_0` might be sorted first (which is the case,
> for example, when using the `qsort()` implementation of MS Visual C's
> runtime).
>
> Now, the _real_ problem is that t3030.35 expects the recursive merge to
> fail, which it does when `qsort()` is stable. However, when the order of
> `e` and `a~Temporary merge branch 2_0` is reversed, then that particular
> merge does _not_ result in a `rename/rename` conflict. And the exit code
> of the recursive merge is 0 for some reason!
>
> I don't quite understand why: clearly, there are conflicts (otherwise we
> would not have that funny suffix `~Temporary merge branch 2_0`.
>
> The real problem, though, is that even if it would fail, the outcome of
> that recursive merge is ambiguous, and that test case should not try to
> verify the precise order of the generated intermediate trees.

It might not be obvious from my mail, but it took me about 7 hours to
figure all of this out, hence I was a bit grumpy when I wrote that. My
apologies.

After having slept (and written a long review about the
`--update-branches` patch), it occurred to me that we might be better
off enforcing the use of `git_qsort()` in `diffcore-rename.c`, so that
we can at least guarantee stable rename detection in Git (which would
incidentally fix the test suite for the MSVC build that I maintain in
Git for Windows).

What do you think?

Ciao,
Dscho

--8323328-2145648118-1567517680=:46--
