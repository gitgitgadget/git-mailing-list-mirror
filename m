Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E5AC4167B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D2022C7E
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgLDWmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 17:42:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:50987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgLDWmh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 17:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607121662;
        bh=NMwMnP2yfl7Lr2FC/E+w15off0DoVyNGeNCRYGccRcY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JxM/OMTtFrGJZY+a2uTtef7vbrdvoz/mgzs6wSfsqNU3SSepgK1GFCK3IPiq033j0
         9sWCef4RG/xlKHW8Yr3Gp27arIF1helqajLGRcNr1Uet1PHsCnTRT4YwgODoFrdOKH
         egMSlKlSI2REQmZwKK+6k/zC9aiR7J/MjBUkOLks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1kE9jC13Iu-00g17N; Fri, 04
 Dec 2020 23:41:02 +0100
Date:   Fri, 4 Dec 2020 23:41:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: determine list of extra built-ins dynamically
In-Reply-To: <xmqqczzpe3i6.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012042338580.25979@tvgsbejvaqbjf.bet>
References: <pull.807.git.1607110436367.gitgitgadget@gmail.com> <xmqqczzpe3i6.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:g0t0i2dXK/6EYJGNCGpUXI9RvDyzUOE0PeKbbeEOY/924+r5kBo
 8LY9uxZY57NBAkaXTbKybNfQwGNqfuQ56QYKYz0KJ88a/+ZP9GtoxIZd5y1lucp36so8+ue
 fPIfQI62VA39W8+ffuJcTLREzox/rQxdxPO6v8FwQ43lBP69VryWH52nsdtIRtJGIAIIbEW
 o2HBwulnEd9S4FwsXanaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w46K6yOLEQY=:Y9OFjLJKTTStCqAxAjRJCv
 dBB/rTC9Ei6UjOwC2ebXXOQNitUOQkzowU25v3FZhQfo1rLTdTe0tNl117V6Mum+D8S2uxyr3
 aizuETFKYwN2mg1QChETpAYkieWS5PDneSL9Pf6MWVJhhgbD0yGKKLcjoCkqXJjVM+D2u/xfI
 b+DTOMoaf/WYWPR/5ixKCPu/e4OX7jAg3aQo134Dyt5DNAfTE02pNO6IOKyJLXHAV6oqrjhhj
 yHH6G3RrJ5zfL6M+59qQSoJhZ3skWZ7F4mxVEnbMtNqikWCJCJWWOEJBdpdnvvMyET62uCRSz
 GGEieGQx9IbNP7mv1cHegwgY9BPscpxGp82EjeGljw6C7vCUGoet8cXPd1yp51tI+h2hrnvI4
 N9+ZI6kd8/yZQHHQpQCSsWNNqMFwJJ9+rWr29zearACvkABdNlt1BikUwyuzuq+AEIYGO1J+E
 r4xwm35c9DNwGuK57v1e2asccDgcRDcU2/PwsKm+mZ6vEu3PKr/I/KZchy+O7lWcq79NZY6V7
 ffnbKGjn0oTD0wkp6pS1paH5+iFSizs5g9lSpEa6m52ZCoszXuAYLY7l2T4bfKpMLG+DP2TSJ
 effmWDksjlD0lT05xoTzKKQj5fEDE4PWzS8MU0svF4d3QmONHwoD7YbZSlP1mNzRJqyeDEkar
 Wmh1Zxyg97/kka/1/WdR0bwfpyOmybwZMjIojsqvBbMlaFrplkhCLsffQ2ddv1qdNdhPjSrzB
 t33svXO9Vd3BvCy4OV+ENHnVpviPtgJ41fFOld/Ai4xv60O2QR79bxgRlQDIXlD50iWSMxrNb
 s8uphTfR+oBSjpKX7f4mcEfXiFoq2Lzq2lbO9DInKDsQM6Z/kTJc3VEmzWqEWY4msHvHlsMSr
 /05RcRtMZf8HUUWPPYY6cawB21SzKxanhX3gxtWpU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 Dec 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 0a21d0e08902 (Makefile: mark git-maintenance as a builtin,
> > 2020-12-01), we marked git-maintenance as a builtin in the Makefile, b=
ut
> > forgot to do the same in `CMakeLists.txt`.
> >
> > Rather than always play catch-up and adjust `git_builtin_extra`
> > manually, use the `BUILT_INS` definitions in the Makefile as
> > authoritative source and generate `git_builtin_extra` dynamically.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     ci: fix the vs-build job after adding git maintenance
> >
> >     Together with https://github.com/gitgitgadget/git/pull/805, this s=
hould
> >     fix the vs-build job in the CI build of seen.
>
> I suspect that the breakage 805 addresses affects even 'master'; is
> the breakage this patch fixes limited to 'seen', or affect everybody?

I haven't checked `master` yet, but `next` definitely was affected. I
_think_ the problem was introduced when Peff's patch added the
`git-maintenance` tool to the `BUILT_INS` list in the `Makefile` (and
hence we try to `tar` it up with all the other build artifacts in the
`vs-build` job) but wasn't added to `CMakeLists.txt` (and therefore
`vs-build` would not generate that hard-link).

Ciao,
Dscho

>
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-807%=
2Fdscho%2Fcmake-and-extra-builtins-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-807/dsc=
ho/cmake-and-extra-builtins-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/807
> >
> >  contrib/buildsystems/CMakeLists.txt | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystem=
s/CMakeLists.txt
> > index df539a44fa..c151dd7257 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -114,6 +114,16 @@ macro(parse_makefile_for_scripts list_var regex l=
ang)
> >  	endif()
> >  endmacro()
> >
> > +macro(parse_makefile_for_executables list_var regex)
> > +	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${rege=
x} \\+=3D git-(.*)")
> > +	string(REPLACE "${regex} +=3D" "" ${list_var} ${${list_var}})
> > +	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading wh=
itespaces
> > +	string(REPLACE "git-" "" ${list_var} ${${list_var}}) #strip `git-` p=
refix
> > +	string(REPLACE "\$X" ";" ${list_var} ${${list_var}}) #strip $X, ; is=
 for converting the string into a list
> > +	list(TRANSFORM ${list_var} STRIP) #remove trailing/leading whitespac=
es for each element in list
> > +	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
> > +endmacro()
> > +
> >  include(CheckTypeSize)
> >  include(CheckCSourceRuns)
> >  include(CheckCSourceCompiles)
> > @@ -673,10 +683,7 @@ if(CURL_FOUND)
> >  	endif()
> >  endif()
> >
> > -set(git_builtin_extra
> > -	cherry cherry-pick format-patch fsck-objects
> > -	init merge-subtree restore show
> > -	stage status switch whatchanged)
> > +parse_makefile_for_executables(git_builtin_extra "BUILT_INS")
> >
> >  #Creating hardlinks
> >  foreach(s ${git_SOURCES} ${git_builtin_extra})
> >
> > base-commit: 898f80736c75878acc02dc55672317fcc0e0a5a6
>
