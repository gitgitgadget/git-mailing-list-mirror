Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDEBC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0596E20733
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Fg3FfhsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLQLQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:16:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:52181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfLQLQN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 06:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576581359;
        bh=KCOZP5ZHLUw4dTIVAHKcBoB897OieBwZVmiKcmf7VEM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Fg3FfhsLhRM+49W5WCKF4RR2TWmrT7GnWbFO/V4l5RHBfYpNyaarUsASXK62dHhZV
         AdwIjHUBt8TxmC0WQd0OnsQwazrL2G0jDqO9jd5IrBrDp834QB9LxrRHESfITHnwVG
         bODinOw0HmCRQMevV69LoydrxOKy8YsbbOpVjRKM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzay-1iHMTN30IU-00Qx0u; Tue, 17
 Dec 2019 12:15:59 +0100
Date:   Tue, 17 Dec 2019 12:15:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
In-Reply-To: <CABPp-BGFRMNAgeyTvDQ3F5nH36ERn+ndjrwaXuLUE-Uto_RBdQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912171209170.46@tvgsbejvaqbjf.bet>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com> <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet>
 <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com> <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com> <nycvar.QRO.7.76.6.1912170101230.46@tvgsbejvaqbjf.bet>
 <CABPp-BGFRMNAgeyTvDQ3F5nH36ERn+ndjrwaXuLUE-Uto_RBdQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dfCT4S3m6/2jN8Yeawsc+MsoYsgPa31bbAt7HtV45fA/lRTiOnQ
 2T+LyBNVGq6BIaLU+N0/4OqW083CFWY5L2GnZAAkcikkcZe76kg276Q8FrXnsTlnzp12R8G
 gKTkt8XG+ApRb63qUpzTj45hT98aDCdi9PDyQdRBE6DROfr2NC4LNBjEUN2ysr8Hb4o/EuZ
 hDLusolzcv1QlCbgDbZFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D0WKZYOjPZk=:m4XTL7TykLBbhxZh7PXUOM
 k/efDiD9FibjrQH5FapLL4M6PNEWpi6maipljqi0c6tR9+wbbN9OmqpD9ZKHwSqLtxfhk8Kgh
 nxcKtuqq5T1p7n59b7acpBr0wXN8Nq71bZaBsRnMyaJs5VaIepmUwhqVbSdWA6w5+kWHe95++
 YjsOuFRbweylh0LJDyN4j2cWdwOZyE5SSnoM0cibfxur5b2SQntUMc0K8KZ8ZKtJAQ+sTmIvT
 7x20LRwsO7+exNW/LLblgbGZp4ur5QLUVyVLUmbJ6CCqpeNZD4lRdRWgHCsX5UxRbFWuJBadC
 ig1AmBgybjmWE9FiDOBMQH7tZtEZHr3qNPtF2TPdNgnOqhQQJV5FRGnobjDKDtw/so5KBXDD5
 hFREtewgPY721rDEjFvJCPgUYrPc5UEzG7Nxi/XlUInPRR08MJGFSR7dfpSs92y6nZnxYdCZJ
 KWrfqF9GVDptDotLJw5JwVvSI02DjyITWJOvThPEAdcYCSoETs9yxt+8xYwrIv2BuPEBD+IGr
 zu4IGCEAebfDwqsqzzqS8vwvJL/8i0pTKbQj9pcTeUY39IZrya4AYKE5tRegCuVtA7xZSczfN
 CfdR7h3/bXieJ60WkiaSpDMWQbnGdRFJXXboCqYulMsFzzAPWSFYSlDpElxAJhNyRVqysOp2V
 z8zyn+sxopFTM1q+5wG4BCfuSzaYLckZsuWjq3jcJm7nEcJfyXdMiyA7H9xXBTotF9krXTaFM
 ga3CpVZxMnLBvhzXrqARYZa4tyALWnLx688oey/dTNDl6HeUVXerD1CcHzohn2mWRxbUUtJ5N
 yn0kmZZEwrxj4RSAPLzmjngNZPilv+6CS6mxmZ05RlkOf67Qq3EWyrmUYgZOwnD526xd6Rqlz
 JI10iT7VIDHjopCONxJyBmMrNPQKJWvSpqB8vA5O3tL9IJXg7kFqGpcGPOWtmqCxXa9CC0x77
 34ZaZzhOfiGTOg/sSi7KTha/zxwlVzaPrkGToHt2dTfAGYUhoT8Ssl6g/wlLZU+85VmYFswiF
 /B8LQ0Uel/eARD/EKGLJChWkpINBBjkiMJo/WgvtEncEu+8lnRtkobZTQF2lr6WQUmPKxozKx
 HKpp2Qfh/sAq3vTfGUSzc93jNfG6I+J/aSDG2NSWm6ZdDq7s2KNhROvHhl7fx6ElhmIBt3aW3
 qUt2GjX3gwsyGG3RfGo3gME7ClbCerA6zQ5bwdM4UYly7uK5iSvCVDKEf4mu70Mx2wC8ywsAx
 ohym+swovNlV4aZNwg7h0Do3qjrFW7+8cyzlN+13/++AW8SV+30GISINeZsQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 16 Dec 2019, Elijah Newren wrote:

> On Mon, Dec 16, 2019 at 4:04 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 16 Dec 2019, Elijah Newren wrote:
> > > On Mon, Dec 16, 2019 at 5:51 AM Elijah Newren <newren@gmail.com> wro=
te:
> > > >
> > > > On Sun, Dec 15, 2019 at 2:29 AM Johannes Schindelin
> > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > >
> > > > > Hi Elijah,
> > > > >
> > > > > I have not had time to dive deeply into this, but I know that it=
 _does_
> > > > > cause a ton of segmentation faults in the `shears/pu` branch (wh=
ere all of
> > > > > Git for Windows' patches are rebased on top of `pu`):
> > > >
> > > > Weird.  If it's going to cause segmentation faults at all, it woul=
d
> > > > certainly do it all over the place, but I tested the patches on th=
e
> > > > major platforms using your Azure Pipelines setup on git.git so it
> > > > should be good on all the platforms.  Did your shears/pu branch ma=
ke
> > > > some other changes to the setup?
> >
> > Not really.
> >
> > >
> > > Actually, it looks like I looked up the definition of dirent
> > > previously and forgot by the time you emailed.  On linux, from
> > > /usr/include/bits/dirent.h:
> ...
> > > and from compat/win32/dirent.h defines it as:
> > >
> > > struct dirent {
> > >         unsigned char d_type;      /* file type to prevent lstat aft=
er
> > > readdir */
> > >         char d_name[MAX_PATH * 3]; /* file name (* 3 for UTF-8 conve=
rsion) */
> > > };
> ...
> >
> > If you care to look at our very own `compat/win32/dirent.h`, you will =
see
> > this:
>
> Interesting, we both brought up compat/win32/dirent.h and quoted from
> it in our emails...
>
> > struct dirent {
> >         unsigned char d_type; /* file type to prevent lstat after read=
dir */
> >         char *d_name;         /* file name */
> > };
>
> ...but the contents were different?  Looks like git-for-windows forked
> compat/win32/dirent.h, possibly in a way that violates POSIX as
> pointed out by Junio.

Yep, I messed that up, sorry.

> Any reason those changes weren't sent back upstream, by chance?  Feels
> odd having a compat/win32/ directory that our downstream windows users
> aren't actually using.  It also means the testing I'm getting from
> gitgitgadget and your Azure setup (which all is really, really nice by
> the way), is far less reassuring and helpful than I hoped.

Yes. I was ready to submit the FSCache feature to the Git mailing list for
review some 2.5 years ago when along came Ben Peart, finding ways to speed
up FSCache even further. That is the reason why I held off, and I still
have to condense the patches (which currently form a topology of 17 patch
series!!!) into a nice small patch series that does not reflect the
meandering history of the FSCache history, but instead presents one neat
story.

> > And looking at
> > https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.htm=
l, I
> > do not see any guarantee of that `[256]` at all:
> >
> > The <dirent.h> header shall [...] define the structure dirent which sh=
all
> > include the following members:
> >
> > [XSI][Option Start]
> > ino_t  d_ino       File serial number.
> > [Option End]
> > char   d_name[]    Filename string of entry.
> >
> > You will notice that not even `d_type` is guaranteed.
>
> Doh, yeah, I messed that up too.
>
> Anyway, as I mentioned to Junio, I'll resubmit after gutting the
> series.  I'll still include a fix for the issue that a real world user
> reported, but all the other ancillary bugs I found that have been
> around for over a decade aren't important enough to merit a major
> refactor, IMO.

Hmm. I am really sorry that I nudged you to go down this route. Quite
honestly, I'd rather add an ugly work-around that is Windows-only just so
that you can fix those ancillary bugs.

I might even go so far as to adjust the FSCache's internal data structure
to _store_ `struct dirent` items, then the fast `readdir()` implementation
could be even faster by just pointing at those items.

What do you think? Can we strike a deal to keep those bug fixes?

Ciao,
Dscho
