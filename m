Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189C5C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 12:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbiFCMSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 08:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242164AbiFCMS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 08:18:29 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A926ADB
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 05:18:26 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2ec42eae76bso80198887b3.10
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 05:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gjx4elszOhThlg8Xgtlqs0lyaNIg/XsuqsjAZR9W6DI=;
        b=HajTny6cbL5Vs7ohMPUUi81GeKSUA3G3Er23ipyALqKiwQO2AU1I4olgj0S5wOA4vA
         oM05+g+ouHCJHnsFYUaE7OnDY385mlUnmXMx75o+QHDVuVnwHS34TsQm1erppCR7Uvqx
         Cx6rgCvfsnId5ZSPfDn2TlNleFcm2RIRLYgz4T6cHlX/QG+SS2pz8AMDP+edUsUUzHHT
         qMk9QoT6uV2PebrD9Rzw+tFWAsPQGRJDOpqlHa0BMcdCvsibTSlWsQoewj2QZ/VM+B7I
         ChIWNc6ThMQWzxj6byu7UyhOuU8M4G+64yFL3SorQ12Tj12E80ojqaw/y75cAifZ/3TY
         3DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gjx4elszOhThlg8Xgtlqs0lyaNIg/XsuqsjAZR9W6DI=;
        b=2SQVX1duiAPwOPq5OuqXQyhKRmJWLABHzFWpPb5sMA5yl6KxJrwk/7MU3ObWHR7KgU
         sIRcBAnrTv88pw/RJ78qInhYHwikRc3JTyDqQSg76Y5P52JsPTKOAzrW3hQauOn9Hfjr
         OFZnbEbcRjTZXUCH/sT13abJe3oVw2esqoUnAbC3qrdvxX7PlO5s0jSm7UVEoM1WehQg
         CYBa2GvTaeHZFLkgSizhrdO7Zd4Soc8Ht+iXuhXRUDI1npAVbE+R6sM6xyzfZ3Fp9Gmo
         HD5jeubgW8t1qU+OPPtrkd28UWPg92RrzyXI4DipSl9AN5LyUe2NKVWOHFM6NJXNt7lJ
         tU8Q==
X-Gm-Message-State: AOAM532peYfgFz7y0dRjTv3p/gCt/yI2SVK7DpQyNJpI2LluNcTl0NxA
        nkXvdijk8N+FI5HP3uTJO8wMCUFiGadWRn+ueIXs+YdtoDfSgg==
X-Google-Smtp-Source: ABdhPJxJt+YClRlpZhvUmv36Pbpe52oVu8ty5p/mU/YtFT2Ju5YL8qUWiRJroLhr8Ww62xYAKRz3RMYP+SgPvLf6Wvc=
X-Received: by 2002:a81:5d42:0:b0:2ff:152d:2a2e with SMTP id
 r63-20020a815d42000000b002ff152d2a2emr10902806ywb.302.1654258705693; Fri, 03
 Jun 2022 05:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
 <Yo68+kjAeP6tnduW@invalid> <8adba93c-7671-30d8-5a4c-4ad6e1084a22@iee.email>
 <CACMKQb3exv13sYN5uEP_AG-JYu1rmVj4HDxjdw8_Y-+maJPwGg@mail.gmail.com>
 <0201db28-d788-4458-e31d-c6cdedf5c9cf@iee.email> <AS8PR02MB730274D473C2BC3846D9FA3F9CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <20220530115339.3torgv5c2zw75okg@carbon> <220530.8635gr2jsh.gmgdl@evledraar.gmail.com>
In-Reply-To: <220530.8635gr2jsh.gmgdl@evledraar.gmail.com>
From:   Aman <amanmatreja@gmail.com>
Date:   Fri, 3 Jun 2022 17:48:14 +0530
Message-ID: <CACMKQb3_j+iFcf5trZEcWoU7vAsscKv+_sLaEqg_qfazBPTo+Q@mail.gmail.com>
Subject: Re: About GIT Internals
To:     Git List <git@vger.kernel.org>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Philip Oakley <philipoakley@iee.email>,
        "git-vger@eldondev.com" <git-vger@eldondev.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone. I sent out an email here last week, asking for a list
of resources, so I could better understand the workings and design of
git. I really appreciate everyone, who gave the links and their
advice.

I have been reading about GIT for some time now, and have looked at
almost all of the resources plus some others. I think I could say, I
now have a decent conceptual understanding of how GIT  works
internally.

(Also, I understood the chapter about git I read in the book I am
reading, Architecture of Open Source Applications: Volume 2, which I
didn't understand at all, the reason I started this thread). Although
there must definitely be a lot of details and subtle things I may not
understand yet (like branches are nothing but pointers to commits,
wow! btw)

Now, continuing this discussion, and talking about the implementation
and engineering side of things, I wanted to ask another question and
hence wanted some advice.

Though I may understand the internal design and high-level
implementation of GIT, I really want to know how it's implemented and
was made, which means reading the SOURCE CODE.

1. I don't know how absurd of a quest this is, please enlighten me.
2. How do I do it? Where do I start? It's such a BIG repository - and
I am not guessing it's going to be easy.
3. Would someone advise, perhaps, to have a look at an older version
of the source code? rather than the latest one, for some reason.


Again, I would really appreciate it if someone could give their
thoughts on this.

Thank you,

Regards,
Aman


On Mon, May 30, 2022 at 7:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, May 30 2022, Konstantin Khomoutov wrote:
>
> > On Mon, May 30, 2022 at 09:49:57AM +0000, Kerry, Richard wrote:
> >
> > [...]
> >> > > 1. I haven't had the experience of working with other (perhaps eve=
n
> >> > > older) version control systems, like subversion. So when refering =
to
> >> > > the "control" aspect,
> >> >
> >> > The "control" aspect was from whoever was the 'manager' that limited
> >> > access to the version system (i.e. acting like a museum curator), an=
d deciding
> >> > if your masterpiece was worthy of inclusion as a significant example=
 of your
> >> > craft, whether that was an engineering drawing or some software code=
.
> >>
> >> I'm not sure I get that idea.  I worked using server-based Version Con=
trol
> >> systems from the mid 80s until about 5 years ago when the team moved f=
rom
> >> Subversion to Git.  There was never a "curator" who controlled what we=
nt
> >> into VC.  You did your work, developed files, and committed when you t=
hought
> >> it necessary.  When a build was to be done there would then be some
> >> consideration of what from VC would go into the build. That is all sti=
ll
> >> there nowadays using a distributed system (ie Git).  Those doing Open =
source
> >> work might operate a bit differently, as there is of necessity distrib=
ution
> >> of control of what gets into a release. But those of us who are develo=
ping
> >> proprietary software are still going through the same sort of release
> >> process.  And that's even if there isn't actually a separate person ac=
tively
> >> manipulating the contents of a release, it's just up to you to do what=
's
> >> necessary (actually there are others involved in dividing what will be=
 in,
> >> but in our case they don't actively manipulate a repository).
> >
> > I think, the "inversion of control" brought in by DVCS-es about a bit
> > differet set of things.
>
> Re the "I'm not sure I get that idea" from Richard I think his point
> stands that some of the stories we carry around about the VCS v.s. DVCS
> in free/open source software was more particular to how things were done
> in those online communities, and not really about the implicit
> constraints of centralized VCS per-se.
>
> Partly those two mix: It was quite common for free software projects not
> to have any public VCS (usually CVS) access at all, some did, but it was
> quite a hassle to set up, and not part of your "normal" workflow (as
> opposed setting up a hoster git repository, which everyone uses) that
> many just didn't do it.
>
> > I would say it is connected to F/OSS and the way most projects have bee=
n
> > hosted before the DVCS-es over: usually each project had a single repos=
itory
> > (say, on Sourceforge or elsewhere), and it was "truly central" in the s=
ense
> > that if anyone were to decide to work on that project, they would need =
to
> > contact whoever were in charge of that project and ask them to set up
> > permissions allowing commits - may be not to "the trunk", but anyway th=
e
> > commit access was required because in centralized VCS commits are made =
on the
> > server side.
>
> We may have tried this in different eras, but from what I recall it was
> a crapshoot whether there was any public VCS access at all. Some
> projects were quite good about it, and sourceforge managed to push that
> to more of them early on by making anonymous CVS access something you
> could get by default.
>
> But a lot of projects simply didn't have it at all, you'll still find
> some of them today, i.e. various bits of "infrastructure" code that the
> maintainers are (presumably) still manually managing with zip snapshots
> and manually applied patches.
>
> > (Of course, there were projects where you could mail your patchset to a
> > maintainer, but maintaining such patchset was not convenient: you would=
 either
> > need to host your own fully private VCS or use a tool like Quilt [1].
> > Also note that certain high-profile projects such as Linux and Git use =
mailing
> > lists for submission and review of patch series; this workflow coexists=
 with
> > the concept of DVCS just fine.)
>
> I'd add though that this isn't really "co-existing" with DVSC so much as
> using patches on a ML as an indirect transport protocol for "git push".
>
> I.e. if you contributed to some similar projects "back in the day" you
> could expect to effectively send your patche into a black-hole until the
> next release, the maintainer would apply them locally, you wouldn't be
> able to pull them back down via the DVCS.
>
> Perhaps there would be development releases, but those could be weeks or
> even months apart, and a "real" release might be once every 1-2 years.
>
> Whereas both Junio and Linus (and other linux maintainers) publish their
> version of the patches they do integrate fairly quickly.
>
> > [...] it also has possible
> > downsides; one of a more visible is that when an original project becom=
es
> > dormant for some reason, its users might have hard time understanding w=
hich
> > one of competing forks to switch to, and there are cases when multiple
> > competing forks implement different features and bugfixes, in parallel.
> > One of the guys behind Subversion expressed his concerns about this bac=
k then
> > wgen Git was in its relative infancy [2].
> >
> >  1. https://en.wikipedia.org/wiki/Quilt_(software)
> >  2. http://blog.red-bean.com/sussman/?p=3D20
>
> It's interesting that this aspect of what proponents of centralized VCS
> were fearful of when it came to DVCS turned out to be the exact
> opposite:
>
>     Notice what this user is now able to do: he wants to to crawl off
>     into a cave, work for weeks on a complex feature by himself, then
>     present it as a polished result to the main codebase. And this is
>     exactly the sort of behavior that I think is bad for open source
>     communities.
>
> I.e. lowering the cost to publish early and often has had the effect
> that people are less likely to "crawl off into a cave" and work on
> something for a long time without syncing up with other parallel
> development.
