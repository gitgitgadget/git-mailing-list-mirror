Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A61C2BA16
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA4720659
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="M4bXj5Vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDDNsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 09:48:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:57905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDDNsD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 09:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586008078;
        bh=21YxNaumUF1NWhaJAXR3nvsFsyR7K6HaYWm/tH/Gt84=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M4bXj5VwEbAx6Txt69z7+WqlyMGn9jvRuZOXdGFFcbQt40GsKLSdwZtFHQmvq2dyM
         Srf3i4cg2T07/b5IYHuhI9WHTyQhTsL9VJhKMj8bM3/FUBqP5HwIPV/TM7Forc3P/0
         ABtlBFcC4MSvzvNde3orThGn+B7kR7JFCGJcdr/k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.7]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2f9b-1jKT690mkh-0048hf; Sat, 04 Apr 2020 15:47:58 +0200
Date:   Sat, 4 Apr 2020 15:47:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Norbert Kiesel <nkiesel@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: GGG Cc: bug, was Re: [PATCH] pull: avoid running both merge and
 rebase
In-Reply-To: <CABPp-BFgwcGjvwFsHzgf8bvR6dY2EocpUbn5-on5sdeRqkw1jw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004041546290.46@tvgsbejvaqbjf.bet>
References: <pull.739.git.git.1585345900763.gitgitgadget@gmail.com> <20200328155627.GB1215566@coredump.intra.peff.net> <CABPp-BFgwcGjvwFsHzgf8bvR6dY2EocpUbn5-on5sdeRqkw1jw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bcWAmvf3wr66kUoC7FYnANtpWLVNFtExGQpJWJtoWEh58HTltMp
 MykzhHESd9HW3WQQbFlWNTpfBBZW5ogB3WtH6PFaiAlTZmDzFKqpawXI8wA9cusZiW8FYrz
 b1+pHuihKw9UAT+Uy39RUBToiBkEILQ/T9RHlTx3juRxNiEmE8QI1liV68nfd3JK8/TUbwC
 IV1u9v4rNdqiuNkQdSnww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q2bIlpYkT3I=:IaGVOmF0wT2WYxs0VwGPM9
 mhJmRxEqaim9L9497E9vRgTcvy/+BUzucExWu2LC4W+sA6yi83aBkeOY0cJdVHdu3nipWxokv
 RP2iV0WzZGMZ2mcnF78dUiADKOq2kJUy+Jli4wx3YEE1uyiYlcis+sW6OjYlkp7qufLPX/EU/
 Dr7xHdzt2KXr3E/lgdSkJ0OK1UwGIN3iQ3FZpXcpn+0PNj0AR8/kjg0vn24WtIc1YvzW3ydV1
 9adFBZH4CN9vqejj2iHT0H6ST2y+D9HjWqBEh1JSsS+QuJnrkmzAA8O+0U9NOh4ezVux5p0oJ
 LPkK8Yx2EZq2BR3WlMFYArHUayH4vVAem5M5+U7HsJYQ/yc4T+3N6D0tET5QN47S4I6+RCThO
 EHPOuzp2MXpoE0pkDQbmIkrzL0VNqtUcFk7RrpL3z5Rj6A8LVXvV/gH1xdbvmw3V1Jb1reA1O
 RssXc+hVnVcAPR1nk0qaPxxGzGqJ3SB4b1aUAMFJNb2ScXiseHJBteFF/wnn6PPQr/JE8qdaS
 fjhygUmwhbId9lZJKqovyWzZI01gy20lpOKKXC6pcr5NqtW9tkWzdm6IQabBwaizbzhcfhxX6
 heQhI5f5uVtNZ1uy3d86+fT2KxOqyM5fRR8QWiP5jZNusaqQ7nbxv3u4F7nmLg+7MEmR1VKHb
 BkXIwOnGqlHCW4wj94UTPs8zA6p9ZYYVKng6h0EtvBRPw0m8YeTjCEuzer7JZlgEvOcuB+CNX
 n35/AWPF5/rTQ29rbe05Q9a5VGqUfmB7sEMlAXHSHB3J1JKoVDuCWqOC3DSAXXkzn7HN5pl51
 0vZ+8zXIt4iRWqi6X/T6zPOA9Y8ZBjCTmxRqGzuxud5F3AJsMSRjiY4IX3HfCDtV7K7FRsvt3
 LYPI34V9J42AOd0q03FkuQspcs4SU++nofNgAM1hy7AlfNXN4v3yTcBnYWCsC0e42IMW59bdC
 SInhDVn+WM3k/kIbNC0RALbeuc84TqJdt1Nb/E6pYIcLLqCjur8X8sgdqgw83tKxoYa/Lz5l+
 qlMu99nFQRGmivKRGM/WyQNY5ce+nKqVwe9yuF8QdCgoFhrhLXb9Lte6nfsQEWT0Sl3DJfFH0
 DkkWW/uXoJkY43M/Ox9hWlb9LqKnJ8lObcG9u8wQLPFddgIMwR+GZ2iaFdyVFjj5ZXQS6c5RG
 BXvYblpMsTTb95JWHVTuaRT8XEOpmEigwe+1mQOgKOR3SPeYUALLSqrCs+L6hk2NIxixSB430
 GNQekrc4k2gVRpjUL
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 28 Mar 2020, Elijah Newren wrote:

> On Sat, Mar 28, 2020 at 8:56 AM Jeff King <peff@peff.net> wrote:
> >
> > On Fri, Mar 27, 2020 at 09:51:40PM +0000, Elijah Newren via GitGitGadg=
et wrote:
> >
> > > When opt_rebase is true, we still first check if we can fast-forward=
.
> > > If the branch is fast-forwardable, then we can avoid the rebase and =
just
> > > use merge to do the fast-forward logic.  However, when commit a6d7eb=
2c7a
> > > ("pull: optionally rebase submodules (remote submodule changes only)=
",
> > > 2017-06-23) added the ability to rebase submodules it accidentally
> > > caused us to run BOTH a merge and a rebase.  Add a flag to avoid doi=
ng
> > > both.
> > >
> > > This was found when a user had both pull.rebase and rebase.autosquas=
h
> > > set to true.  In such a case, the running of both merge and rebase w=
ould
> > > cause ORIG_HEAD to be updated twice (and match HEAD at the end inste=
ad
> > > of the commit before the rebase started), against expectation.
> > >
> > > Signed-off-by: Elijah Newren <newren@gmail.com>
> > > ---
> > >     pull: avoid running both merge and rebase
> > >
> > >     Cc: Norbert Kiesel nkiesel@gmail.com [nkiesel@gmail.com], Jeff K=
ing
> > >     peff@peff.net [peff@peff.net]
> >
> > I'm not sure how cc is supposed to work with GGG, but it clearly didn'=
t
> > here. :)
>
> Yeah, I clearly don't either.  I even looked up another submission
> from Dscho (https://github.com/git/git/pull/728) and attempted to
> mimic it, but still managed to get it wrong somehow and I don't know
> how.

It might be a bug in the way I implemented folding the cover letter into
single-patch mails. I simply might not pick up the Cc:s there.

However, I am seriously under water right now and won't be able to work on
a fix for that. Would you mind opening a ticket at
https://github.com/gitgitgadget/gitgitgadget/issues/new?

Thanks,
Dscho

>
> > Anyway, the patch looks good. Thanks for following through on this.
> >
> > > @@ -992,10 +993,12 @@ int cmd_pull(int argc, const char **argv, cons=
t char *prefix)
> > >                       if (is_descendant_of(merge_head, list)) {
> > >                               /* we can fast-forward this without in=
voking rebase */
> > >                               opt_ff =3D "--ff-only";
> > > +                             ran_ff =3D 1;
> > >                               ret =3D run_merge();
> > >                       }
> > >               }
> > > -             ret =3D run_rebase(&curr_head, merge_heads.oid, &rebas=
e_fork_point);
> > > +             if (!ran_ff)
> > > +                     ret =3D run_rebase(&curr_head, merge_heads.oid=
, &rebase_fork_point);
> >
> > It feels like there should be some arrangement of the conditionals tha=
t
> > doesn't require setting an extra flag, but I actually don't think ther=
e
> > is. And anyway, doing the most obvious and minimal fix here is the rig=
ht
> > place to start. We don't need more regressions. ;)
>
> Thanks for reviewing it.
>
