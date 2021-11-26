Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45BBC433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 13:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353010AbhKZOAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 09:00:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:51077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238604AbhKZN6T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 08:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637934905;
        bh=7iwKkkLem7V/wQeLC1z8tMMJStn0+Jhh3pSoSfW7DeQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fzyno6aYX7jbGccL/ODnwk6GQCt1PyJQUYc6OnRu30pxpdu2xmMXFDvTBiYYONWnm
         bYsydCQdXJvSUzKSN0TtR0EHGBYNceXQW0xxxfWWg7YO0hUVot093ZMoz0/kt2e0J8
         PCnQ/LH55T/ExjcdwxSy2tar4Yx2cFfbOO7t9ltc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1mYVlO09eh-018Ivy; Fri, 26
 Nov 2021 14:55:05 +0100
Date:   Fri, 26 Nov 2021 14:55:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH] mingw: avoid fallback for {local,gm}time_r()
In-Reply-To: <pull.1142.git.git.1637817792914.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111261454180.63@tvgsbejvaqbjf.bet>
References: <pull.1142.git.git.1637817792914.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1033808245-1637934905=:63"
X-Provags-ID: V03:K1:fipRsAQLAL9Nx5HFBxM1TrweUgf8j9RHuKWw6YnSMW+mzTG0sTO
 DYFtugJXDxX7/yeRYSXQ3nZd3Jub3erGJdy1DUSo4EIWSFX1bcx7SHth9Ko8lM7C5Wm/tpk
 Q7b0tuyfKCO1S3COaKTrJg7d3tJIUhYpOCGyqogn1cricZYWopdZunVRYUn2FC6G+Z90SOg
 0ESEVD2yad2EXO6Cf2m3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ipF7W9EkdQ=:Qe+t5/nEIRe1IELnODfMwY
 fUskrW2OH0RwpOXlwMpdgU4VW9OG7UzBOW/gwsRfy+JDzFlvWwmZDQrJE4NXPBQKKjaf/oQMS
 gt5XolAJ3RbaD8rEosj/sOtq88H1NVyjcfim1H1OnuhzHjXJXC5+be/smAomQBXoM32sK+iK4
 TiBYz8xMDdhm2jpxZiYDcW4Fyo9PK7Lu+IgxnqFckM1t164G9r7iFECft7toqMet3SjrXgcys
 EBJV/wfi3tKm8vYdYE/ihVKVYtiaNCKkfXRBO7IzNxKAUN0qAysn2OwzvJeHsWPUB+AB0YEor
 vx++e2xiEwnJUwF69RpFkN1kVys9VsJtmfAbLDA2xyeUJyTzrl0qEoWrkh4GNo7guNgDqeoWR
 JM9rbayOyJ/Z7ByFxIad1B5mO/822xTOwhiSSsCsyGnfRaZWXSrEU8+94qet0J8wCaD7sfTJB
 fa3Cp4DeTSy7w3UVZosPlwvnToemMIfWKNSHqqvLapLpi8EzJFqjKOUBrpLQV4YX0U7n7FI8o
 yvETc1cwJ0mn1zH2OhyueQ0nHfatiLY8hphBvFF4lhJ1It30+1mcSv01vRnrHsga66HTMdqd3
 FLWWJ6x2YSZi0JfozZFfwrF/EiM3JXP+qNKonp8MNLqXyVTWaFILUKWQg+/2CVfYEYWB33eO/
 DJvas38Q/8kJx6Ox3kPe0liSEe4u9XBtWZ0cCjbMkmVgV1YD/7dKgt+TlLxrWfZKg/VII0eS2
 CaM2YwBuo53XvZjgL1EzyyER9GfjhNiYN+suC1FOhYXTY9LuUDRO+G9dNwPEz5JPcqwb56UCa
 itj9M5bTqu2ZlMnnUbd0FkLfUTP7uyuMfIhKQdiLk5+PPGQbmYHnTK6bPhD+mtlut7QK8TZXa
 2x5HJN+QvaoKgQJVynK0CETzyow+mXu/LNUEwgVukP+hosvIEL8ovrDk7K/GbtqTGzntVWpfa
 trexeGQkQ/ykfDe2oQt9ufXYXJwFU7+SZ8b4+VDvwQ/o+NL51hztkhLuyPAz9Rn+wrR8wu/q6
 vdsJWJBiqIUo4ewFEVMbtiiDOJIqWTQ+Spxl6T3FD+0JvM7eaIZm1bmk+W2DWk7VJ+G6qnwrZ
 m3acu/YTbw2ZDI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1033808245-1637934905=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Thu, 25 Nov 2021, Carlo Marcelo Arenas Bel=C3=B3n via GitGitGadget wrot=
e:

> From: =3D?UTF-8?q?Carlo=3D20Marcelo=3D20Arenas=3D20Bel=3DC3=3DB3n?=3D <c=
arenas@gmail.com>
>
> mingw-w64's pthread_unistd.h had a bug that mistakenly (because there is
> no support for the *lockfile() functions required[1]) defined
> _POSIX_THREAD_SAFE_FUNCTIONS and that was being worked around since
> 3ecd153a3b (compat/mingw: support MSys2-based MinGW build, 2016-01-14).
>
> the bug was fixed in winphtreads, but as a sideeffect, leaves the
> reentrant functions from time.h not longer visible and therefore breaks
> the build.
>
> since the intention all along was to avoid using the fallback functions,
> formalize the use of POSIX by setting the corresponding feature flag and
> to make the intention clearer compile out the fallback functions.
>
> [1] https://unix.org/whitepapers/reentrant.html
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Yep, this patch works well for Git for Windows already for a good while.

ACK,
Dscho

>     mingw: avoid fallback for {local,gm}time_r()
>
>     This is a cherry-pick from git-for-windows/git@adf0cd8, that is need=
ed
>     to be able to build recent master with the Git for Windows SDK or re=
cent
>     MinGW64.
>
>     It was discussed recently on list[1], and might need further
>     adjustements if the 32-bit Git for Windows SDK also updates their
>     winpthread headers, requiring a similar fix, but since without it a
>     plain build from master wouldn't work in Windows I think it is worth
>     reviewing on its own merits, and had withstood the test of time in t=
he
>     git for windows fork since it was originally merged there late Augus=
t.
>
>     [1] https://lore.kernel.org/git/20211005063936.588874-1-mh@glandium.=
org/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-11=
42%2Fcarenas%2Fwinbuild-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1142/=
carenas/winbuild-v1
> Pull-Request: https://github.com/git/git/pull/1142
>
>  compat/mingw.c    | 2 ++
>  git-compat-util.h | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 9e0cd1e097f..e14f2d5f77c 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1083,6 +1083,7 @@ int pipe(int filedes[2])
>  	return 0;
>  }
>
> +#ifndef __MINGW64__
>  struct tm *gmtime_r(const time_t *timep, struct tm *result)
>  {
>  	if (gmtime_s(result, timep) =3D=3D 0)
> @@ -1096,6 +1097,7 @@ struct tm *localtime_r(const time_t *timep, struct=
 tm *result)
>  		return result;
>  	return NULL;
>  }
> +#endif
>
>  char *mingw_getcwd(char *pointer, int len)
>  {
> diff --git a/git-compat-util.h b/git-compat-util.h
> index d70ce142861..c8005db3fb6 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -127,7 +127,9 @@
>  /* Approximation of the length of the decimal representation of this ty=
pe. */
>  #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
>
> -#if defined(__sun__)
> +#ifdef __MINGW64__
> +#define _POSIX_C_SOURCE 1
> +#elif defined(__sun__)
>   /*
>    * On Solaris, when _XOPEN_EXTENDED is set, its header file
>    * forces the programs to be XPG4v2, defeating any _XOPEN_SOURCE
>
> base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
> --
> gitgitgadget
>

--8323328-1033808245-1637934905=:63--
