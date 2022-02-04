Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB60C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbiBDXMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:12:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:33137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234597AbiBDXMq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644016361;
        bh=+1mhkcWDgUfpO41aBR8SvH3dfmb7BXGgiDF1s64vRPI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eNdzlAYcBUSaMG4aefma6gpptuVALl0IsuGkeov0XH1GEOzYY23k+4yLR+8sRz7w5
         wPz7oQcjZDRqmtxRR7LSmdaSjZHZ3VBxSRuOUaJT2uErEIOMwqafxP0MV8l6EnTJ2F
         UjUPSF1PquyNHeJsK/r6aug+IUg+2nGiFqTcrFyM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.215.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1n1VIS0txF-00EcCM; Sat, 05
 Feb 2022 00:12:41 +0100
Date:   Sat, 5 Feb 2022 00:12:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 09/12] merge-tree: provide a list of which files have
 conflicts
In-Reply-To: <CABPp-BEn=fvmTyYEzjSfvKkYyHj0te=6ck6WF+Jor+L1jKrVkg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202050011350.347@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <fcbb087fa8865ac05e20473d822cd9795590ee38.1642888562.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201281755200.347@tvgsbejvaqbjf.bet>
 <CABPp-BEn=fvmTyYEzjSfvKkYyHj0te=6ck6WF+Jor+L1jKrVkg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Cks4Ed+kZiGL+enagyqro3z2+SkNcXQ+OZ4KkzNaUMUApvWfRaB
 Xe0g8qHxSm5lQPUMeyr0pB3wUWUKjSLZXkzCJlU3c8Z5/SgHvvJKZmTGEorB1a84MTNIi9K
 jUurDiWnQjGmGayayhkZzYc+8Y0mM6vD0x2rDqJ5FU0YSgFTTswWVkhPoPJ76alYESno8Fz
 MbdzzS+AXEOBfyW2ny5wA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yCSMGXgA1CU=:H7k8+NqMUd9uRtN9zKgC5S
 z0xkwRnv/8qm1vDBPrwxAVVUvoMEn0PKkVW0xTGi0rFP+nSzdfNEmsP4n9jbS/KZQqMbzMQHR
 jfWiDHTbKLQbMhQmxgWFpESlYzucLgRxIauPY8GwSO1Ab4xfut7WUR5fZBCMFdL7bCyHCWFR8
 vUYw4xXTxvYokp4ufyK3TYjqmWxlFcCScU5YF7S5lDAfB6Od+m1AISn/o1wOUbY2C+DZTpXFh
 cc1OEjxtT4J15GAhx79KwY2WSrJ05I6xtcCZSys5Axyg0y92vhrB7uKqmDbBEy/YGW1Q2Pw4B
 mtFYa3FcUA4z984vH1+Di53t7FWY+aestd4AszZMLgxHeWzMkJxhjC91rgf+Lws8ayzREFI3T
 GUsHCMVbWnVzGhWFzr2VMiwvlL1LmkwAO+S6bPZFQ+8LKOii8b9NbSGm31MT8ubWdRvjc/cUN
 uh5GpvSTP8LU4EzFE/z32XUSbBZyO58hBg6fA8wNP5oL762uG+q2kLQeNSDMOjZF052zOECul
 sQfGApo7AmWbXXffsgWG8KRcQUK2YIpgHQkrrHl5u/ndpNu09+PmI2HgPrxSVTFwvPYt4BOuL
 28jojoe9Lh8qAS9SrKNkXh3MkcgHIilcnfToSe3/Xm/5eJlekEsFJZOuau4oVuH9exTgE/1S1
 13uKj5Evf/pf7aoSYhjVC74op9zK0ioL2gaPNPzfnPhkbmnWnlIvWDFwZp0iVAt+3/qEcKoZE
 fwJHHiW+J8sTDHbt7qjS7T0+1hQrVXsvIQGAKEDpsPF1CrWjtxhgutbZHhIGEJ/xlGMJp2/zH
 l+iHP6+ALzpmWw9WefpZsRv5zGW99WAof7SNHmvqx/j1e7UvcLHhtNWoiL/kK5StBZXojNfiI
 Z450rT4DddJt5ff8URtLbM7K76lr6dA6xA06iUqdNRtv1HWasxgN56KZOiEwNNO1VPHXP1Ako
 tc65kP3uHC3cwxoaT84FDXBirb/Uq5IoqJb97fPZUIMY1FIxiYC77mVTh2ZW+p2DXHusIhd3E
 1pb/b2QbSl+NPc2XQrpubHz9rBdAEYMEL38MhC8gvNRSnuBZpFmCP4xTr76oOGjaVs/5Y0aNc
 oZfFzZTX6eYmkA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 28 Jan 2022, Elijah Newren wrote:

> On Fri, Jan 28, 2022 at 8:57 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Elijah,
> >
> > On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:
> >
> > > From: Elijah Newren <newren@gmail.com>
> > >
> [...]
> > > diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-me=
rge-tree.txt
> > > index fd7a867de60..041a4ac2785 100644
> > > --- a/Documentation/git-merge-tree.txt
> > > +++ b/Documentation/git-merge-tree.txt
> > > @@ -58,6 +58,7 @@ simply one line:
> > >  Whereas for a conflicted merge, the output is by default of the for=
m:
> > >
> > >       <OID of toplevel tree>
> > > +     <Conflicted file list>
> > >       <Informational messages>
> >
> > To distinguish between the list of conflicted files and the informatio=
nal
> > messages, I think it would be good to insert an empty line, as a
> > separator, like.
>
> Yes, I agree; that's why I did so.  :-)

My concern was that I did not see this empty line reflected in the quoted
diff. I would have expected an empty line between the `<Conflicted [...]>`
and the `<Informational [...]>` line.

Thanks,
Dscho
