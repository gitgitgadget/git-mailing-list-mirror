Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B3AC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 13:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0DC20707
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 13:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="M+lfUIDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgFRNIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:08:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:57751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729979AbgFRNIa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 09:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592485694;
        bh=aCZ9GdWLS2WXU4JRCVdF69FFB7wGpVZpD+XdtJXpbGU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M+lfUIDCB2zvwEe2NSizVx73CAQomeqMfQd/2iKsS9aLG8yI7F0+KrN1gReelNqvn
         Nc/etL4czyuooZsjL9R0Ip/H+t375sSf6Ets0uuvo/sLFxhTc4GFFw+dlhqoI9Mphy
         yPCic4/pIrBamqeDu0T3gXSI53dHUpX+kwoOtvSw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.49]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fis-1ik9dG31fE-0120aC; Thu, 18
 Jun 2020 15:08:14 +0200
Date:   Thu, 18 Jun 2020 15:08:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
In-Reply-To: <20200616124739.GD666057@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006181507370.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com> <CAPig+cSnEvVB5vsffFXidG1-XNxDX10u2XhD9NqV3pwh8zyxxw@mail.gmail.com> <20200616124502.GC666057@coredump.intra.peff.net>
 <20200616124739.GD666057@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y1c+KKzUevpH+T4tb7TIkapu4H0oWKgN2/nAMOS4yCK4T9ZiG9+
 KSM9+aLpwpvl4HCipsAefvL4XtP2mDm7GJUMBXPSSKRz1Arj9HlMauH93EPiicUEBK+XE3I
 nKx4IUXm6fDwwoUC/jw2vrCJ/ZgHZBuxpLGNDxDBBJw2ILBWnpRPp+520UWSnhoQWxG0gcs
 4X/diMcdvFEIr0zOqfGLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bCgnNv6q1Ao=:BD37mmreuR+UUYWowgREWT
 EL4NfkC5tslHtBRJvxXD2LzN8i6FZ8RHBUc6guzEcWyTx5h1vq0G3NTwhO0YmTVidRNqUqOMa
 eNnSSJ2hFYLpgdhzeBk8qHMkxN5BwMGtrF74eYgrAskS7obIMBuxSa4keuIXUxPgyuFRYTzpj
 5T9lNa29uErL+A1ERpU/CF21RqJhsoLMqsV6KAqTXLZ5Is+DL8dr1K19G7e8NCIDJsFO9I12i
 glwEV2PWm0NrAZf9dneC1Kyp0ralfsz5LU6/J8TK3HZ/M/YW8mWZScBUWfbfRsRCsPBJf5IE+
 maYhPwvKdogUA+c78r+CYND6A5XbeZo3JcieAuO4T6UzMh96NXB0NII71H2lILIx3B+dPqdNY
 adPLcHeMOid/phF6PST/RwBS0UblybD/CXRBeBz42u240laLjSrDZejn3i29L78X/54v2Y/jS
 2fdk3iSGLU93RMvHGqT9GkwDiXOSLb8mjCpbLAK20dApKav1JZIfU16bI8oxfdJlHXUwfqjZ2
 Z1hT8YCvg/viQoH4W+JXSzNDzi7ccyWEw0XMCQiOBmOjFuY6YrrWIVvMaxkF5TyAXtRmKdn1F
 h5EdYRKHAmbxZXdBzk55V7y15ynvhXkYgiHSdMvgn/FfqdyJK7osDL2xFYIGFoKfa6Yp9L9Pf
 QYIQkY0XqB42GjU4JrnJuVK7NcvOaCbKxzf5u0ViyYKhP0T7EgrZ8RfAztoB2aaHpPIRAEB1u
 7aCnND3yannK7KNCWtXesX28vMaWvyndyfd6Wv7wE9fTR7cZ6TGdYswkdAl2ImutsYPyu1LoD
 yVqMsSR0v40N0sFdA40hYhCNRAW4uhRx+o/ZwGMNzQzquP+iki1RFrsDSGVKuuMinu6Kwr0+1
 V7lBWRUbFBCFhSdeKLiPEA/2chaqIEHrqXyL/sZxMLExDWWzXkI28t/Vq14j/4KnnSlWgyIBX
 2tJmDgteAsDqiF/lNjGgFmEP7khbFTsJaNOELK1zStYk7B+dDrY1km1V0GHykkPM2kjokmTnB
 rG7g7TyXamUQcOABP5N+kF1mLTWxQiIVW3Ml7hl62fLSAObEOgZCf4iRaT8d0MTt3S3onbOW+
 jK5LhVNzI+F5mJz6bLGIiX1kMgm0BmzVtxKllsr/DvxkfJySn1EPal4eYLyhzdjWsmGUEO/o7
 2zH0oofVfMxUYuewMa+Ra7to61NjQakGyBvt34G4j06KAzWEji4HZaTUDVECkDTNM7FMTSKiy
 Assx4+vBhoBXR9gFi
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 16 Jun 2020, Jeff King wrote:

> On Tue, Jun 16, 2020 at 08:45:02AM -0400, Jeff King wrote:
>
> > On Wed, Jun 10, 2020 at 08:16:38PM -0400, Eric Sunshine wrote:
> >
> > > > +/*
> > > > + * Retrieves the name of the default branch. If `short_name` is n=
on-zero, the
> > > > + * branch name will be prefixed with "refs/heads/".
> > > > + */
> > > > +char *git_default_branch_name(int short_name);
> > >
> > > Overall, the internal logic regarding duplicating/freeing strings
> > > would probably be easier to grok if there were two separate function=
s:
> > >
> > >     char *git_default_branch_name(void);
> > >     char *git_default_ref_name(void);
> > >
> > > but that's subjective.
> >
> > Having seen one of the callers, might it be worth avoiding handing off
> > ownership of the string entirely?
> >
> > I.e., this comes from a string that's already owned for the lifetime o=
f
> > the process (either the environment, or a string stored by the config
> > machinery). Could we just pass that back (or if we want to be more
> > careful about getenv() lifetimes, we can copy it into a static owned b=
y
> > this function)?
> >
> > Then all of the callers can stop dealing with the extra free(), and yo=
u
> > can do:
> >
> >   const char *git_default_branch_name(void)
> >   {
> > 	return skip_prefix("refs/heads/", git_default_ref_name());
> >   }
>
> Actually, one small hiccup is that the config option specifies the
> branch name, not the ref name. So you really would have to prepare a
> static-owned copy of it to turn "foo" into "refs/heads/foo" to get the
> refname.
>
> On the other hand, that would also be a good time to run
> check_ref_format(). In the patch as-is, the "short" return does not
> check that the branch is a valid name.

Legit.

I will work on this.

Thanks,
Dscho
