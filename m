Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8C2C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 16:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349922AbiA1QFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:05:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:42523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234788AbiA1QFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 11:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643385932;
        bh=pQ2mktuVqAw8NSjguEngTg6+P9y9QTBvI34X8UEgXXE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R7MKujK6z+jNMc2kueZ3vAuvxMNvGJk4mZEppvExOkb6Cly9AhbuRbL5ELyAJto6L
         QZL3hSom2iXj6NftP7c2Pxs/5Guj+4fhnEZ3XN/PJv5vfsxk85lFF0onKwhaKc6Ol1
         tQzliz14D060uHMcXhg910UZ+oBk9ilseM0MIZ3Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0X8o-1mHMrI2b5Q-00wXaE; Fri, 28
 Jan 2022 17:05:32 +0100
Date:   Fri, 28 Jan 2022 17:05:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/12] RFC: In-core git merge-tree ("Server side
 merges")
In-Reply-To: <CAP8UFD1iJs0iGe430_Y=S6_nadS8AfBr_w0MuX-0H4ObcwDNdg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201281647361.347@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com> <nycvar.QRO.7.76.6.2201261250380.6842@tvgsbejvaqbjf.bet> <CAP8UFD2qFmZ2Adk71SQw9xtq5keZ=d2hcMwF=fs9OtW4==0ZYg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201281343360.347@tvgsbejvaqbjf.bet> <CAP8UFD1iJs0iGe430_Y=S6_nadS8AfBr_w0MuX-0H4ObcwDNdg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jA/tTc17ggGx5sZZiC/Xm2rxtvZrooRHqvo7Lqhjeebq3oGj8h6
 VPPj/NoN4kGUoWTRwQtkYhTPQSDuNCBTbapE3zP6eKXwgEKh81VGRI7CpV9fCdUzMATYU10
 fB6rvo0LXEyixGPLFXNvmg3ys2AnBbKM6lbUM9z25JLgzVMgXj4dPKw0zerk5wKeVkF2PFQ
 4MLBnfrVDWaDM0ntUrgpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/bmjgIvvqx0=:+yFuxgxXIv/cm3GI2qtlwF
 k7Ojdv0GfzkSXMr5HpK6meWytuG4V73/+bccWOJE/sC0Y12EAt2PjnS2VrO6PJ/wY/WOjy17v
 gP/KusWB9VRegr8wDNdvn5lGNOUYd+aloPmQxITx1qsQPWRNDlpyAmhFSDhviUB0JdWYS1FDV
 xX2Me7lg1K+KLF0kOaUuB81hfzyrxAyDrkYmTyYHcMpCOYc1bqj9jtxMb8Rx1MNP3ZVFkTwnO
 1zR/9oPFXOx78PiWLtjIGyVOGGTvcnJb+B50J4WikTQ2KdstopYTLtOKowRAKbrVAEMvtNIKp
 Gmc1VqQE/nNSw8GZQXt40ivLR/EypgAC8OdknSi7oIS/wcmp0gIAG1r/X6ATx2rC7DBkI9JqQ
 XQz8SUDUE1UhFq4varSH9oLf6r/sKBixuDP3+THDLQ+bVk0LgHkHxWxNiNLvqKAvho79KUlRZ
 /PDgGLnBPkpqeH/ep/ETYPSqKLqvuz0XtZNFRe5JrfxHETdxo8IlSQsMxML9I27Cg2beQHYgY
 /PHOapxPDrBugklfINV4PG8nN1wGPBiTPVFPZOu1McRt/TeGH8wlnk88EJONy/MtDDtQtewaI
 WgBxhDIgnB2vgoLu7kVlq0zMUjEffrdTnhdD9rQ8hkblfLi69e8u03YfD7kdRGbyBTF64m8cu
 73ZW3Ro6OKNGZhjpbzWEL8E8tjEyjqnR//1IeEnxKeGYvHR9Sd/QDVk8z4oMjoI0D228uzDi6
 CDPsmgtpVZI96StYsGcU3pAuwOHHcRhGs7iGJlk7kKR67b297mBouZLR9FSzv6+E1A2jeFXZ+
 Jpq+BOEbxbEu4kzB7n/u2ypTNrFmncQSfci3OXpYlYTzQ8KOnqcrc4rlEZvqqI67YCX4rh/8w
 zg+xXlufh/u5FJhsR3En8WW618hbkRCJw8zgYrvMBL7BMMQodRDjP+IxbRBwhHMYIDoFYuWXB
 ymT/cARD0qUR8vOnLNS/AiNmPa6ml/hUQBAmlHzSZFumO0loG2YLNr9gNMhqPC2KWtgpOiV78
 s7ynXGmRTQISlzdg7Sq8WJQuTHRkhmYmv3q4NxnY+KoPltWsc5hE/UzUE0czGh1wtRl681HqU
 aiKujFMDhy4PX4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Fri, 28 Jan 2022, Christian Couder wrote:

> On Fri, Jan 28, 2022 at 1:58 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 26 Jan 2022, Christian Couder wrote:
> >
> > > On Wed, Jan 26, 2022 at 1:03 PM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > On Wed, 26 Jan 2022, Christian Couder wrote:
> > > >
> > > > > The reason is that I think in many cases when there are conflict=
s,
> > > > > the conflicts will be small and the user will want to see them. =
So
> > > > > it would be simpler to just have an option to show any conflict
> > > > > right away, rather than have the user launch another command (a
> > > > > diff-tree against which tree and with which options?).
> > > >
> > > > That assumes that server-side merge UIs will present merge conflic=
ts in
> > > > the form of diffs containing merge conflict markers. Which I don't=
 think
> > > > will happen, like, ever.
> > >
> > > Please take a look at:
> > >
> > > https://docs.gitlab.com/ee/user/project/merge_requests/conflicts.htm=
l#resolve-conflicts-in-the-inline-editor
> > >
> > > As you can see in the image there are conflict markers in the file
> > > displayed by the server UI.
> >
> > Please note the difference between what I wrote above (present merge
> > conflicts in the form of diffs containing merge conflict markers) and =
what
> > is shown in the document you linked to (present a file annotated with
> > merge conflict markers).
> >
> > There is no diff in that page.
>
> The server UI could just get a diff with the conflicts inside instead
> of the full files with conflict inside, as the diff would be smaller
> to parse than the full files. So even if it's not shown, the diff
> could still be useful.

You really need to get away from talking about this in hypothetical terms.

> Also just above the section of the link I sent, there is this section
>
> https://docs.gitlab.com/ee/user/project/merge_requests/conflicts.html#re=
solve-conflicts-in-interactive-mode
>
> where one can see diff markers in the image.

That's a side-by-side diff. Git cannot even produce those.

> > What's more: there are not only conflict markers in the editor,
>
> You don't see the ">>>>>>>"?

Yes, I do. And not only that. I also see that the editor knows very
specifically where the conflict happens.

And since any file can contain `>>>>>>>` _without_ it being a conflict
marker, the editor most likely does not parse the output of Git that
contains a conflict marker. At least I hope it does not because it would
then very easily be confused by strings that look like conflict markers,
but aren't.

Think about our very own test suite, and why we specifically set
`conflict-marker-size=3D32` for those files. Same reason why the server
backend cannot simply ingest files with conflict markers and then hope to
figure out which `>>>>>>>` are real conflict markers and which are not.

> > there is clearly a visual marker next to the line number that
> > indicates that the editor has a fundamental understanding where the
> > conflict markers are.
>
> Yeah, so this shows that those markers can be important for the editor.

Of course they are important! That's my point!

> > In other words: you are making my case for me that `git merge-tree` sh=
ould
> > not generate diff output because it would not even be used.
>
> The other link above in this email actually shows that diffs are used
> right now to resolve conflicts.

It shows that Git was not used to generate the diff, is what it shows.

I see that you are still trying to guess what the server-side needs
actually are. It really is time to stop guessing. So I will keep
challenging you to actually look at the GitLab code, to take a stab at
teaching it to use `git merge-tree` to perform merges. And then to come
back with what you learned. I guarantee you that that will be multiple
times more useful than talking about it in hypotheticals.

And you are in such an almost unique position to contribute to this patch
series, to provide that very valuable feedback how `git merge-tree` could
be improved to support actual, real-life server-side code that is
currently in use! So why not make the most out of it?

Ciao,
Johannes
