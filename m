Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5B0C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 10:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A97613E7
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 10:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFKKV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 06:21:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:39119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhFKKV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 06:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623406759;
        bh=GPpzNP+22l0Dn7eTCerwoSL5NcMZ7FYnZDIBXjO/gIU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DvEvp+TyolV3TxOgQzIFRtq7booiaJiqezIO8ch7Oa48dU87mrzBZnWEVNUBLexSC
         ByrVvVdPoVW/VMc92BuZ1D01ZnqiR6mgPrwMHwNg0sg2MPYcbLKq+mTr1LkMNRTmC6
         4IyBS9E7q+9T6yN6ltmQsr6UMMdd23968CFh6KGs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49h5-1l9Y500isT-01091c; Fri, 11
 Jun 2021 12:19:19 +0200
Date:   Fri, 11 Jun 2021 12:19:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Shumaker <lukeshu@lukeshu.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 1/2] subtree: fix the GIT_EXEC_PATH sanity check to work
 on Windows
In-Reply-To: <87bl8d6xoq.wl-lukeshu@lukeshu.com>
Message-ID: <nycvar.QRO.7.76.6.2106111213050.57@tvgsbejvaqbjf.bet>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com> <a91ac6c18938116c4a74e19466da456b67376fa5.1623316412.git.gitgitgadget@gmail.com> <87bl8d6xoq.wl-lukeshu@lukeshu.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I4poLVPfEivYh4+u7qRak0c+caahulUljwm6HSooVQHn8BpcMCT
 i3aK/kS8V+b6lN0bTNJ2+vPqOYmxxLidvx7o0Ge0tbwK96OnORJGOD6uYq9+hEMroQ54xbs
 Ngpr+/uLF4XVziJKDbFB909/jbI3OyYviYbM15Y6wTLI24AqroEltNX89T8UBDi/RCdFzPV
 DXY8W8x8VIHlKUXjHOAAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vauuTWmuq+4=:MkA/bnMJaV1tJ8yJ3NfRM2
 iaxq64mdhS0k2vDnQGe6ZTiCb/xOE+0cvSb9WIuuO9/kSxtt9gxLyGypYGsXUboBZqzOjBqHX
 FgIylYVRu6RijVdoHk1Ivo6nNYEsHWLaHzDMXXPmeikJ/2Snrng55+a1V/pHd2hD+4YmeeI9Y
 628ifcRQbl2sGDtlMERTv7UEmiMt2quatF+JuhiqUomOPTWcCsgWfd6h58E6P1odCOdKGaJiC
 4Prt0fZNyjlvg/m4gfuks8eBTUGIAmGRmGmfjRSe59y+fWxDPEHckSkASCS1jIP5t6bOqlDrR
 +0xmD/f+zgXqlJ2ZFg0d2FoCkGPhSMjPrS+++p6NI8igivxHrENj2Yyqk8d4lSnXrRj41fztf
 cwho+Q8CM1tSAE7XFojIlBOXGCwDHx9l5t2EOt9ESDPrGxxhRIwntK3LP6W3IbxVyEImiuPSM
 IhFMm3VQpJO2at9vU+fyNHrWZ+Et8bkk76TdvdeAZwUnR3VRoTXKCH1yeWQPdft3CqU2yntHb
 jysHFvIGHs/NfEEyEdNeoT30noH+FKFz1gihvj5yVv2I36cd+dvHjsF66tC+nS5eZee6JWkp6
 Cn5q+D99UhVya3/VBh4aLG1u70SLn7tkBsdAq4IuzIu5rQgSamQLO2cbMQY2h9ZSW2LQIwpJB
 Wggs5Eoe6L81GKAI4/udEJcMxF+BOkZJZVvm0XE6wM4ezd+ibb+v1j6TKfxwXhAJQQICHnusc
 sg4ljdzKuDCsD1YxxjerIX2UtJ3f60dMozDK1o5n2aKnD/ZcPwrXnU2luFNy6kfODqfEmUdc0
 HYoOhsVsOmg74wUgoHMFmn3333RXqrWgxEZ/6CZqeAsB/8L46alVWnpGNhMpOubfLticzsfzJ
 O0BIQw/nFQv/4IqSWe5CUifTvzpoYznk9e7OSaKELzsXR89XkUxC739EqlaKWEZ3UIFI6k5rI
 HNVQd8D7VTxJnx/Oer7j4au5OG46uiEOtRoDXNxyOsFLrYWUQignTQSymZbmTxK0C27zvuHA3
 zZHPSx1870nbEl1yqP2WsDHnPgKzrZ63u+nWEpxXkGR2G8PUfE+CQhLczXB0hSS04wBmDacs/
 Nccr73RgX/EQdezgjzBnogcdrtXxbbCHhMdOXFwtQi7+OXdlqEqOlxU1Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

On Thu, 10 Jun 2021, Luke Shumaker wrote:

> On Thu, 10 Jun 2021 03:13:30 -0600,
> Johannes Schindelin via GitGitGadget wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 22d550749361 (subtree: don't fuss with PATH, 2021-04-27), `git
> > subtree` was broken thoroughly on Windows.
> >
> > The reason is that it assumes Unix semantics, where `PATH` is
> > colon-separated, and it assumes that `$GIT_EXEC_PATH:` is a verbatim
> > prefix of `$PATH`. Neither are true, the latter in particular because
> > `GIT_EXEC_PATH` is a Windows-style path, while `PATH` is a Unix-style
> > path list.
> >
> > Let's keep the original spirit, and hack together something that
> > unbreaks the logic on Windows.
> >
> > A more thorough fix would look at the inode of `$GIT_EXEC_PATH` and of
> > the first component of `$PATH`, to make sure that they are identical,
> > but that is even trickier to do in a portable way.
> >
> > This fixes https://github.com/git-for-windows/git/issues/3260
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  contrib/subtree/git-subtree.sh | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subt=
ree.sh
> > index b06782bc7955..6bd689a6bb92 100755
> > --- a/contrib/subtree/git-subtree.sh
> > +++ b/contrib/subtree/git-subtree.sh
> > @@ -5,7 +5,13 @@
> >  # Copyright (C) 2009 Avery Pennarun <apenwarr@gmail.com>
> >  #
> >
> > -if test -z "$GIT_EXEC_PATH" || test "${PATH#"${GIT_EXEC_PATH}:"}" =3D=
 "$PATH" || ! test -f "$GIT_EXEC_PATH/git-sh-setup"
> > +if test -z "$GIT_EXEC_PATH" || {
> > +	test "${PATH#"${GIT_EXEC_PATH}:"}" =3D "$PATH" && {
> > +		# On Windows, PATH might be Unix-style, GIT_EXEC_PATH not
> > +		! type -p cygpath >/dev/null 2>&1 ||
> > +		test "${PATH#$(cygpath -au "$GIT_EXEC_PATH"):}" =3D "$PATH"
>
> Nit: That should have a couple more `"` in it:
>
>     test "${PATH#"$(cygpath -au "$GIT_EXEC_PATH"):"}" =3D "$PATH"

Are you sure about that?

	$ P=3D'*:hello'; echo "${P#$(echo '*'):}"
	hello

As you can see, there is no problem with that `echo '*'` producing a
wildcard character.

In any case, neither '*' nor '?' are valid filename characters on Windows,
therefore there is little danger here.

To be honest, I was looking more for reviews focusing on
potentially-better solutions, such as looking at the inodes, or even
comparing the contents of `$GIT_EXEC_PATH/git-subtree` and
`${PATH%%:*}/git-subtree`, and complaining if they're not identical.

Those two ideas look a bit ham-handed to me, though, the latter because it
reads the file twice, for _every_ `git subtree` invocation, and the fomer
because there simply is no easy portable way to look at the inode of a
file (stat(1) has different semantics depending whether it is the GNU or
the BSD flavor, and it might not even be present to begin with).

I was also looking forward to hear whether there are opinions about maybe
dropping this check altogether because there were indications that this
condition is not even common anymore.

> But no need to re-roll for just that.
>
> Do we also need to handle the reverse case, where PATH uses
> backslashes but GIT_EXEC_PATH uses forward slashes?

In Git for Windows, we ensure to use forward slashes in `GIT_EXEC_PATH`.

Ciao,
Dscho
