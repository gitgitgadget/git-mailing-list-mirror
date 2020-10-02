Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECB6C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 11:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B531820708
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 11:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ktNPugFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgJBLEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 07:04:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:43203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgJBLEE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 07:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601636631;
        bh=tQSHjN1+hYo6n+Va1L3SMbQqaHC3PpRMH33iVC1sBaU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ktNPugFulqjdu8Uhh1FDDYC5ejykcV4msrq/rkpZX7cV3yEJ1q8itr+VJZ2szb6iD
         ss+qsXTZjdF5iDNEWDF6wRcOsMNsjpZHRuqt8LtvC4j7uEiEEFfUiNUqYdj5q+i1c6
         RkupCh9v6LNpu14JTLFUN5HNKfM4mPW4NuDRu1Yg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.8]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1kCnbJ194c-00G1Tv; Fri, 02
 Oct 2020 13:03:51 +0200
Date:   Fri, 2 Oct 2020 09:53:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows
 compatible
In-Reply-To: <xmqqa6x6gajn.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010020952330.50@tvgsbejvaqbjf.bet>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com> <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com> <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com> <xmqqk0wdliuc.fsf@gitster.c.googlers.com>
 <20200929003519.GB898702@coredump.intra.peff.net> <xmqqa6x6gajn.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rm8xA16R0JK4Sz8E2RuGgdErSLqkMK9zQ3MOQxArzL7jiUHTfmP
 1Ovcc1dS7c8tjD7/40ckcNyQdHFPbf2miWMV0GbljMYp4AAqy973xUKlDFwyHeT1+JpTPSq
 3MzEm5ghjHkkectMK5PY0rBPshh50flPBkqY7Z4SLv9X5g3NTIAqE7ITXh7MpJClDeXcMOD
 UgYYNmfTcbDEEa6la1g0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aNN3Ec9bIwU=:SDakq/UyJvMFPRPV6mCuvQ
 8U/X3H6Lc/JT8mJ7j3VPCiP2MWO69ic3jZhrs4xK815fKQBahSWmB4rNBN1vuW7i/b7/HyE6o
 14hH+aXCumt+ceEu6KE4o76vhv7ZRtRyfOu8Jxj9/G2RF/y55Fhd7zax0DA7yIw5vjYjPMccq
 loOgVqbC+zuzvCWjZ8BfNu+DATuWaiiv41NPLlH25oneQ56cEVy0PfRLVeTB9vwVZI6FRnUfX
 HSsOw2KPKz24loQ/pgnuuqEtFTpTpmbHR4ZXLbG4TWTpSzqEUA2Fzo+p5zF9COXmqtXHzGLnU
 KO/Isqn11nDVrXKNaSpDAGxJPEYh2BVttWzws1OH6wEnCbWOoDm/23rOOaP+aIHz+jQxR/m5T
 oazzK1Pu81h9WJpEZ6ENRsMZZAhXPiewPjOJUfrbsLqXJjPaLW8NIwvTeCcqMobICyY71MLfL
 xNVbuzIGLugfwLArv2QkrdXRHKuWZaZWHYsBAU6IiQ3Ek7KlU+NDMQmfHqFAsv576ZaZq/nAx
 5+CBexA7gPwqLfqqbUV8qLzM2cd78QDQ3J477dIeuvWTaCIyopQdXsqAu9kYwVK/0jzGOKPpx
 BOHLQfEINDRQR0gLTFjNwWqArc55od/DiRUX9LVyyobknKC1dhwEU3oT7yA/V108H0VsMHLZG
 zfpvLlCPDeZUC2mOytyZrQYC+rCe7vWNVgGzS0KkaQl0Vdv1uhQWPU9IejOGdj29lcBlXvzgq
 UF3Wo/srWRBL1FAjjs2/+MHhw7+kXQ8cMLko38nEJD96CEv10eYF9txL3ULZgR9g6E0mlEURe
 P9YtxyXjEA2Oel6q01Seub0+UOtBV8Yq+YXtcnkNDWeX8GvYPHdXyAbQEL4rD9SN/ky41ljMt
 vYIltu68jTaOswk1GnB4oEF+kwbDmoPccnR96vO3zOxe/qHjUHaWR0JmgpxaN7SPVeIt+vk2w
 GisHD/QqXGVCCumYIGTALKBO8G6B8JUzg7Uwd+wlpXOHTU+XPTNCyAUT8hqRptpjdYnr03HDQ
 hi3jdoK5IHb38ILSiKPrhoOLt93g0CPjsQxuKFgvVjZ3zoDsoRts2rxgMjbQdCHQrfTOF1zI8
 h6x51LDWfcYtbVn3tGu2Pm+5Dshxvcy/ZJMN/ygQhax8AsaD3/rprHeiQbdecQXGliwPYUJt7
 l9voZmz50FPXrAn+PuF2fHlA6YP4EuaUWov4ReyqdvhRuU7QMy+TFW72MfQbBYBWJaI01lTVb
 NYo8UjfFV8+bh7SdjTKApgG8LPMAut9ki+33zsA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Peff,

On Wed, 30 Sep 2020, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > On Mon, Sep 28, 2020 at 01:58:03PM -0700, Junio C Hamano wrote:
> >
> >> "Nikita Leonov via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> > From: Nikita Leonov <nykyta.leonov@gmail.com>
> >> >
> >> > This commit makes reading process regarding credentials compatible =
with
> >> > 'CR/LF' line ending. It makes using git more convenient on systems =
like
> >> > Windows.
> >>
> >> I can see why this is a good thing for "store" and the two updated
> >> pieces of the test script demonstrate it very well.
> >>
> >> But it is unclear why and how cache-daemon benefits from this change.
> >> That needs to be justified.
> >
> > I suspect it doesn't need touched, because it is internal to git-daemo=
n.
> > But it does handle CRLF for some lines, because the first patch
> > modified credential_read(), which the daemon builds on (and which _is_
> > user-facing via git-credential). So there's perhaps an argument that
> > these calls should just be made consistent, even though the only one w=
ho
> > would write them is our matching client. If that is the argument to be
> > made, I think it would make sense to do so in a separate patch, since
> > there's no functional change.
> >
> > (I'm also slightly puzzled that anybody on Windows would care about
> > credential-cache, since it require unix sockets. But maybe in a world =
of
> > WSL people are actually able to mix the two. I confess I haven't kept =
up
> > with the state of things in Windows).
>
> True, so some, if not all, parts of these changes start to look more
> and more like "I change LF to CRLF purely for political correctness,
> even I know nobody sends CRLF in these cases (or "even I do not know
> if anybody sends CRLF in these cases", which essentially amounts to
> the same thing but may be worse)", needless code churns.

Indeed. I did not make the connection that `credential-cache--daemon` uses
Unix sockets internally (and hence if you try to use it on Windows, you
are greeted with the message "credential-cache--daemon unavailable; no
unix socket support").

Will drop this part from the next iteration.

Ciao,
Dscho
