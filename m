Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8331E1F454
	for <e@80x24.org>; Sat,  9 Nov 2019 11:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfKILGo (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 06:06:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:54067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfKILGo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 06:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573297585;
        bh=XSAHAZrLOmSpRcR1g37piF1/P3awgu6nMZLcJBYz/Xc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Y1a2Rc0nQTFUWlDYWZHj0fRsv/jo70aqKJ0qhBmQ7xsLt/gZNv8PTP5+6s0CS9tCU
         SEpbhVwi5TJUYsGAxXQ58R97kR1CyzbRgLjdRJTdOL6l/ON+BatzzKaX8Gs1Qp1w0u
         ex7yp8oVMprA+gGj34MXYwwb3k51/ltEuvpatXs8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([46.183.103.8]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbRs-1ih9PK2sAA-00HAi6; Sat, 09
 Nov 2019 12:06:25 +0100
Date:   Sat, 9 Nov 2019 12:06:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/9] Start to implement a built-in version of `git
 add --interactive`
In-Reply-To: <xmqqh83fnfah.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911091154550.46@tvgsbejvaqbjf.bet>
References: <pull.170.v4.git.gitgitgadget@gmail.com>        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>        <ff59d2d0b3b8b591a806ef71b4bcfd350000b06e.1572869729.git.gitgitgadget@gmail.com> <xmqqh83fnfah.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:on5/PHb3Oh1Kv6wIZ8Qa8ToP8L1Gyn3Nwj925jc7AA9lbKOFhdQ
 bYywYKhUBNjFBqBXAGH+2HTXwAevdt0naBxKja1FYfnsb/NjtkjJHfjPFpPriP6XP2C6uDs
 22S+fPDEOFgPbvw/9sApWEPHB1QLsJ40Cwz5Bxs7e/UdqrcR2tdsZbW8Sj15GUNbT6ybQb5
 j/Eyqs1Uin8GKJ7GnzZgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kyty7DAZC0I=:Y9LXovlgvoYFKsxDGe9eHj
 sUyfRKohryIza7JiLSCVbeAybH4Eo5sPa0VS7+FhPUZ/kW02Dma4Fc8jyvIvvJpYjb0w8fHEP
 saXCElZIwXGFdZtfCIEsDIxuZMKDJ4loOkOdRcKO4+pU2W25DwtuTu0by1BIYoNGGw9Q0Q1c/
 5YEIMsSQ8FTYiAjgEt8Yp7aPpOwWGIAuXAoTHjrzM8Z6uKGvGARswPtXB1IPRoeaLMY95v64B
 2vk47uK3Ft92wZh23U2wurGJqcMRPwnA0gfnTfcvnciBwe1aa50l8jFFrHbTva5iTW/v5NA/F
 fzcIcKR4a/RxrN494dz38xwhBNTrN3Y6m+ljHc/Yss8YKV9JUUb0pLjaBf73wdyzfoc1NrCdZ
 kEd/kShLLNB19IxNv280g5PeSilnTwrpFaMplTJAWsbIyRe/Q9UEO1hHEu0uVo41e1UA1aFSP
 Cf1MP2zP8DRG6sUGHBXj6l9H649+SHiP6HCV4+gnpKiVLq9iRSaWW4+CGLe52RijjMnLm066M
 jKcwPrJ+BoCbBIyesCYHp6DVkMMFEL14dngklKumVT/ER6OXHt2JwuN9tPb+fQBdSnaYUTG8b
 imK9hoSyiRarig9POc5TA/16D92igBMkPaPamx4SV/wbqo39Q6TSKJ0ArJCdI0VQQnupc8T+7
 YY/g6Y+rpRFdKH5yV+udQ+4cbxpqFqpJTODP9+TY3CwGTvhKBANChqVL6N2jKXafLqxwS6Hf6
 b+3+mEXXJy+CeWswmNVg/DaQTZKBmImtT2F8Ge6hrTIGGs+uR+Akes0wIujYDygCXZL5Uc1xy
 U95lCzCMnj2z+7JFlJzrJ/SPRWIGVny1UtG7d14fWKec7EQ/9GB+lhn/1JOTnFj/p6XKINiu4
 NZMPfRGTf4aERNqf0qdWhDSbPD2wuGmXra5gL2hFn9Gcu5sykD5clp2VX/0zTc1R836XDPxFk
 62cAls+RpKNiqptKat5fvaTVQ2Xd+b4ZsH/sZAQRw30zV5KQ4xGGfttuPO4BtMnEo1LNXF0Mu
 zPTfPhn4TpFFHz2bmLWLzzGDo/U3MeEPMoMeJqstLNpHUM+Gg5nPJlxzpzYdbAfJvfiYAR3nZ
 ayOLQ2+nRkGqiTNI8dyFjv/gREk+Wte2Wkz7xvonoxEk60m3DVQYSRs/8pzciP+3M8Bxf/K+j
 sG6GHSNNoVqo4+NHLv08KaP80gWUvdAVASpq9fIcG+fpVX8hM4Pf52o/ALQ8eZbvfaisd01in
 VA6uHjJ9GvIpbjAdpwDvNHoALbgfzg8WeastFB0AOig2PRibyUtBmH9+LGVs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 8 Nov 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This is hardly the first conversion of a Git command that is implement=
ed
> > as a script to a built-in. So far, the most successful strategy for su=
ch
> > conversions has been to add a built-in helper and call that for more a=
nd
> > more functionality from the script, as more and more parts are
> > converted.
> >
> > With the interactive add, we choose a different strategy....
>
> This is hardly the first conversion that we took the "build the
> whole program piece by piece and flip the whole thing on with
> usebuiltin" conversion successfully.  Pratik's rebase-in-c series
> comes to mind.
>
> Personally, I do not think the first two paragraphs of the proposed
> log message do not belong here.  Cover letter is a different story
> and it may make sense to explain why the approach was taken there,
> but here, I'd prefer to see it more succinctly tell what approach is
> taken and go directly to describe what this step in that approach
> does to the readers, which is more important.

I reworded the commit message:

    Start to implement a built-in version of `git add --interactive`

    To convert the interactive `add` to C, we start with a bare-bones
    version of the built-in interactive add, guarded by the new
    `add.interactive.useBuiltin` config variable, and then add more and mo=
re
    functionality to it, until it is feature complete.

    This is in contrast to previous conversions to C, where we started wit=
h
    a built-in helper that spawns the script by default, but optionally
    executes the C code instead. The sole reason for this deviation from
    previous practice is that on Windows (where such a conversion has the
    most benefits in terms of speed and robustness) we face the very
    specific problem that a `system()` call in Perl seems to close `stdin`
    in the parent process when the spawned process consumes even one
    character from `stdin`. And that just does not work for us here, as it
    would stop the main loop as soon as any interactive command was
    performed by the helper. Which is almost all of the commands in `git a=
dd
    -i`.

    It is almost as if Perl told us once again that it does not want us to
    use it on Windows.

    At this point, the built-in version of `git add -i` only states that i=
t
    cannot do anything yet ;-)

Hopefully you like this one better?

> > diff --git a/builtin/add.c b/builtin/add.c
> > index dd18e5c9b6..4f625691b5 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -20,6 +20,7 @@
> >  #include "bulk-checkin.h"
> >  #include "argv-array.h"
> >  #include "submodule.h"
> > +#include "add-interactive.h"
> >
> >  static const char * const builtin_add_usage[] =3D {
> >  	N_("git add [<options>] [--] <pathspec>..."),
> > @@ -185,6 +186,14 @@ int run_add_interactive(const char *revision, con=
st char *patch_mode,
> >  {
> >  	int status, i;
> >  	struct argv_array argv =3D ARGV_ARRAY_INIT;
> > +	int use_builtin_add_i =3D
> > +		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
>
> Have blank here at the boundary between decl and stmt ...
>
> > +	if (use_builtin_add_i < 0)
> > +		git_config_get_bool("add.interactive.usebuiltin",
> > +				    &use_builtin_add_i);
> > +
>
> ... and lose it here (optional).

Done.
>
> > +	if (use_builtin_add_i =3D=3D 1 && !patch_mode)
> > +		return !!run_add_i(the_repository, pathspec);
> >
>
> Strictly speaking, we can bypass the probing of environment and
> config when upon the entry of the function, where patch_mode is
> already known.  I do not know offhand if rearranging the code to
> take advantage of that fact would result in a flow that is also
> easier to follow, but I suspect it would.

Okay. I changed it to:

	if (!patch_mode) {
		if (use_builtin_add_i < 0)
			git_config_get_bool("add.interactive.usebuiltin",
					    &use_builtin_add_i);
		if (use_builtin_add_i =3D=3D 1)
			return !!run_add_i(the_repository, pathspec);
	}

Thanks,
Dscho
