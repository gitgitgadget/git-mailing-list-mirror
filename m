Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11951C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E322F61163
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhJFUpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:45:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:49985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230062AbhJFUpX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633553003;
        bh=pZMWZHiDLsteFKQddA9AizRamg0epzxMKCtmea1p1nU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=arohr/X0tHI9Z7XSm1gp66qA5tRv8Niu8l8x9t5bjIG+OLcCZ+EOIjoXG3sJPSTIb
         FMvtk34QUszIDNMtrBFznb19C/SUUE6+svV4KM4UwVQstuI3J23z5I4JR5PCxAXPKY
         QqtXt+CLfQec0aBOiy8PVe6itfc8InzgiLoY5Y2k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.23.42] ([46.183.103.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1mDO1G2xlE-00Kvqd; Wed, 06
 Oct 2021 22:43:22 +0200
Date:   Wed, 6 Oct 2021 22:43:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 11/15] scalar: allow reconfiguring an existing
 enlistment
In-Reply-To: <CABPp-BG3FwBVO67ZVPCLokA3xh5=fLiXYe-K2GiRa7ELFvQkEA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110062241150.395@tvgsbejvaqbjf.bet>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com> <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com> <ada242c7c8c1f530231f97e76c97fff18e368ff5.1631630356.git.gitgitgadget@gmail.com>
 <CABPp-BG3FwBVO67ZVPCLokA3xh5=fLiXYe-K2GiRa7ELFvQkEA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:juE6a52h42mP1URJKuQuQrh4Ao6C+L1sEDOA4Yoih0gfAL2XBvf
 Lm9tJrWxbEv06yBrp7GyxD2YISo2MShfghzIzweP3pi4HJc2Iq/xzR1hQLBjAHPG/jG10XD
 zQzQa5lvB2VlL2QNqRzr1DK7X5GXcwiBy6gnVnWGimo+szKVnObBjaT5cTR7oWCvHTjXyYf
 MV/qGr6tchGtKzoAPBBqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0LlbeWT3i3c=:I5xD4d+sUqjQmLbdVsd5fJ
 3KfDFiBLwxfacbtx//rCNlnSiOEcbkhNuH+v3HPX9oN4V5C8C+zJHkUO1thENiPcyhGm02dC+
 MWO9v33X8YQ2HLHdbK4Dy8tQuVRSniA/iwJQycgryCSBrLSDIVOg4f+ED8AQG73XReIyl7cqN
 kJWyj2DgNo7a9N9SE7pghzrb+UuNwPc2RQxovv94RUTDay3rkSXQOVrmS5TD11LKlWo3KHq2h
 S1Q0dn4VEFNy0Im4LChvMryw8fDqM2VZINI0xUJzQAzFO/Fkgm80Ivw2ZHJqmwMDV3ktRK9KX
 J0Vs7QwYmQM81TCtxdZ38hWrDkNqHpo3nLxJbVB1QLp5KJC3XHdwjvhprRNvdZEy8Z8LOPSeq
 IGhfUcRzRT84qnXFhwMyLOF0Ni9sjEqdcYZXTr6GIzhNbS1XyyI6bekpiUyD8B8W750wxWei8
 0Y2myX515d6lvNxtqW97MukN61fpxlcxjHf7KDaKrXlU2tKSx97W/1Rdq2YMFD1FpLnd1ycJ6
 vfeNhNVurOeQ/o9tAz7oPMGu1tb7qVTop6NL3bNfMF1hO2J43m4E6QF9t5e9fjYvIc5AFsjXJ
 YtpL2GPvS+xljC3p8ME+DK66U8Tw9TrUum0IsWmzV66uQiACS1Uk4lkXVNCh6EBRNH7fOcJoI
 OF0xyUXdXCuWuhcRQUg9Y1HC0SJtP65hKuXGIghLh25XMl1C3dTPE1Eg+VX8xsaaXnM/otdu3
 znzFcMBWguIqwXRfXeb0vjuo98mHV95HVl5alNrt/KHy56YRjlAv1r8kmrymnlVNZrUKbs0hw
 tKl429HUftKZTDYskR7jw/jI7UBSnuuSRF1AkbzFMLmr+viMDqQwxVzbNFlc8csXNK3tXGQQi
 45mk1Y2Stp5TLZ9xPLInI9xpYHaPuP9sJiuIqyqBUfgUA46uZHJFm/w25FXQit+xUEG/d/09p
 3TuuNRTJQCGHqCWgJfZJumK/EzOJW63fudrts8V3n5H8eBZwz+0ftbXkl0MEt7QvAaOXkrOyr
 nBte5Q+tnwthi6oGuqTLwfc2GjxsqQrt4Qv3e2uXxEj9JyG8HWFhJ0vVMDrzIjFcPdArXOl46
 vgv/5nNRuRpV04QZj/DOQ0IGyaxvvPpIXes
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 27 Sep 2021, Elijah Newren wrote:

> On Tue, Sep 14, 2021 at 7:39 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This comes in handy during Scalar upgrades, or when config settings we=
re
> > messed up by mistake.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  contrib/scalar/scalar.c          | 79 +++++++++++++++++++++----------=
-
> >  contrib/scalar/scalar.txt        |  8 ++++
> >  contrib/scalar/t/t9099-scalar.sh |  8 ++++
> >  3 files changed, 67 insertions(+), 28 deletions(-)
> >
> > diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> > index 8a11f390251..1fff7eb7c12 100644
> > --- a/contrib/scalar/scalar.c
> > +++ b/contrib/scalar/scalar.c
> > @@ -115,18 +115,20 @@ static int run_git(const char *arg, ...)
> >         return res;
> >  }
> >
> > -static int set_recommended_config(void)
> > +static int set_recommended_config(int reconfigure)
> >  {
> >         struct {
> >                 const char *key;
> >                 const char *value;
> > +               int overwrite_on_reconfigure;
> >         } config[] =3D {
> > -               { "am.keepCR", "true" },
> > -               { "core.FSCache", "true" },
> > -               { "core.multiPackIndex", "true" },
> > -               { "core.preloadIndex", "true" },
> > +               /* Required */
> > +               { "am.keepCR", "true", 1 },
> > +               { "core.FSCache", "true", 1 },
> > +               { "core.multiPackIndex", "true", 1 },
> > +               { "core.preloadIndex", "true", 1 },
> >  #ifndef WIN32
> > -               { "core.untrackedCache", "true" },
> > +               { "core.untrackedCache", "true", 1 },
> >  #else
> >                 /*
> >                  * Unfortunately, Scalar's Functional Tests demonstrat=
ed
> > @@ -140,28 +142,29 @@ static int set_recommended_config(void)
> >                  * Therefore, with a sad heart, we disable this very u=
seful
> >                  * feature on Windows.
> >                  */
> > -               { "core.untrackedCache", "false" },
> > +               { "core.untrackedCache", "false", 1 },
> >  #endif
> > -               { "core.logAllRefUpdates", "true" },
> > -               { "credential.https://dev.azure.com.useHttpPath", "tru=
e" },
> > -               { "credential.validate", "false" }, /* GCM4W-only */
> > -               { "gc.auto", "0" },
> > -               { "gui.GCWarning", "false" },
> > -               { "index.threads", "true" },
> > -               { "index.version", "4" },
> > -               { "merge.stat", "false" },
> > -               { "merge.renames", "false" },
> > -               { "pack.useBitmaps", "false" },
> > -               { "pack.useSparse", "true" },
> > -               { "receive.autoGC", "false" },
> > -               { "reset.quiet", "true" },
> > -               { "feature.manyFiles", "false" },
> > -               { "feature.experimental", "false" },
> > -               { "fetch.unpackLimit", "1" },
> > -               { "fetch.writeCommitGraph", "false" },
> > +               { "core.logAllRefUpdates", "true", 1 },
> > +               { "credential.https://dev.azure.com.useHttpPath", "tru=
e", 1 },
> > +               { "credential.validate", "false", 1 }, /* GCM4W-only *=
/
> > +               { "gc.auto", "0", 1 },
> > +               { "gui.GCWarning", "false", 1 },
> > +               { "index.threads", "true", 1 },
> > +               { "index.version", "4", 1 },
> > +               { "merge.stat", "false", 1 },
> > +               { "merge.renames", "false", 1 },
> > +               { "pack.useBitmaps", "false", 1 },
> > +               { "pack.useSparse", "true", 1 },
> > +               { "receive.autoGC", "false", 1 },
> > +               { "reset.quiet", "true", 1 },
> > +               { "feature.manyFiles", "false", 1 },
> > +               { "feature.experimental", "false", 1 },
> > +               { "fetch.unpackLimit", "1", 1 },
> > +               { "fetch.writeCommitGraph", "false", 1 },
> >  #ifdef WIN32
> > -               { "http.sslBackend", "schannel" },
> > +               { "http.sslBackend", "schannel", 1 },
> >  #endif
> > +               /* Optional */
> >                 { "status.aheadBehind", "false" },
> >                 { "commitGraph.generationVersion", "1" },
> >                 { "core.autoCRLF", "false" },
>
> Now you have optional settings...but index.version and merge.renames
> aren't among them??  Why are those required?  (...and to go a step
> further; should merge.renames even be off in a merge-ort world?)

I think the idea here is that they are required so that a `scalar
reconfigure` will set them, even if the current enlistment had been
created by a previous Scalar version that had _not_ set those.

And yes, in a merge-ort world, `merge.renames` should probably be forced
to `true`, again because it is in the "Required" section.

Ciao,
Dscho
