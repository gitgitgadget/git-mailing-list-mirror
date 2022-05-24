Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6CAC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241829AbiEXVFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbiEXVFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:05:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485516220C
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653426337;
        bh=u1IFCxrz5vgEYiw2GU0HkYLTMOzzuq78wMzsuys+D28=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LoLxiNF8tXfPbC8xXfNDrDXzl8YpPyEJ5KXBkMjgmeF9MboV+5gvvakEogKjMc5Aw
         3u23kR2yRQnhiGw6LoLgv9zmUoxISf9J1H/iZmuXH4F2xGco83fBtkslRXwvlUL96W
         p+bFD12CKA3e9EM/iEWbZtGsgfHy2LuNLVEFAY/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1nW8ni3pOs-00pOPq; Tue, 24
 May 2022 23:05:37 +0200
Date:   Tue, 24 May 2022 23:05:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] dir.c: avoid "exceeds maximum object size" error
 with GCC v12.x
In-Reply-To: <220524.86k0abxyqa.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205242302020.352@tvgsbejvaqbjf.bet>
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com> <365889ee96e37dc9dcbe60d98880eb256dae90ee.1653351786.git.gitgitgadget@gmail.com> <220524.86k0abxyqa.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-593497758-1653426336=:352"
X-Provags-ID: V03:K1:va2Q4oAT17RX/nYTuiF4vvInYCYLpRJg2iPdbWE1T+IDYHAWQPS
 IRfBoCfUAW8L11nqhU4N4MaRzbYpYJbyre/cPHaiVIQDK8aTQqElTZwldOOKCbw/IP9/BkH
 Adf66x/toPI0Edvgrzua6fDl+TWX6etgfFmyYrzvT3Gcc00nBAawmDvawyxNtGHS3ePGgO9
 CLw4ztqyVpQWKUcgF+l/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EnaxAdf0i+Y=:46eWpiNXV5kJa7h7bpYV81
 M/hPl0KtzjPwbqPN9SFAI/720RS+PZkOhbeM8PHlWPbuNIPvl4yTu3fD8iNmVjvbhHkDCdz+a
 VpwYGzjdG6QznVzU72bIMCzqSIFeVa9njbP1GDpVqq2dnom0+Ge5Juckr0tQZYNwvMyWWGr0L
 jyChBnEwH9ehsNPcROlMGxrjzV0rXR3YFdA1NYiaV1Caiw9Bo6y/lOnQK/wWTpBiLfBGNlhbu
 zPVi8PA0Okj64yGA4HClUM7uY0x9skjxDjGaZ7SW6ds6blQfa4U1jFkO/YxW0rIi2LzfC31wa
 MzZyioOzl7BZlEnOmenryx6DXPROBvO3ZftPcDJxFEXl4A80g9WSpLupLXNm8167OMM2KTHCk
 +LQYEnCP+Z8UrJ0EnaQMVYo8mfboWVfD76IqK8NW0ayONefC0Dxarx2BVKGpiy8JlvjLaE0yS
 L8sALHCTUDaXyV/qeZz0t/5BsCyBA8Q2qR9CKCyoUtDck99ohfsMq0o21UXys1+20zp6nP9xF
 7NarKIzT0qZHAMcMm+X3jXk0UtdbPgUQtt+e+/1ctjTfnnW5Z+fA4UGs3Zo6ao5S0DVy05F7r
 ghjwlNpPpuhl7GnLtr+W8FGAuPE0rivfHXvxUPOvmqZUlUWM/n3dGi75b4DC8hLpwxiR5uH1h
 t5Bm+5H3uoNAqz2gVm7DD8zzAuUnzbU1xQylR6rU4N82Oyr5Db9yWF5Ar7GdvqZiwjEea3ulE
 YEax5Ad/ZRC6gq0LLviwvtfj+xOBVVyJAZmYu/DmFqWZBHSH4Bv6SZMK0FpupJOkqBAhAgpso
 6FpUeRtFPNrou4cAso810EEf+kEzrmYUNQ/ZXOZUsjqaMd2NEVE6gcJims2JkDlDh+oFiCg5h
 qICPpM+P7qDmSe9wsplZ+RWYNIWYwI8+38GG2fIPgRkHBjE3zSAuahFCzala8i7ya4PP6EU4S
 zla7kAR/hFOPpTvQtrWwGpSWCsI/7mIJQFLzh2tcXMH4zhPad/mNO0ZoXqiTdPNTdgnfEcob9
 hQUJta4ixADvMN31dArlSn24crfB0tIWAoDoU/yuSAZjfEAA+HG2gxRVrTtIJ1mq2ifDhX0TQ
 DQHoFj7W59O9QTzjvy3OvGUia41YA5/ZaEWe854HE3giy5AalfVajDC/w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-593497758-1653426336=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 24 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Tue, May 24 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Technically, the pointer difference `end - start` _could_ be negative,
> > and when cast to an (unsigned) `size_t` that would cause problems. In
> > this instance, the symptom is:
> >
> > dir.c: In function 'git_url_basename':
> > dir.c:3087:13: error: 'memchr' specified bound [9223372036854775808, 0=
]
> >        exceeds maximum object size 9223372036854775807
> >        [-Werror=3Dstringop-overread]
> >     CC ewah/bitmap.o
> >  3087 |         if (memchr(start, '/', end - start) =3D=3D NULL
> >       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > While it is a bit far-fetched to think that `end` (which is defined as
> > `repo + strlen(repo)`) and `start` (which starts at `repo` and never
> > steps beyond the NUL terminator) could result in such a negative
> > difference, GCC has no way of knowing that.
> >
> > See also https://gcc.gnu.org/bugzilla//show_bug.cgi?id=3D85783.
> >
> > Let's just add a safety check, primarily for GCC's benefit.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  dir.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/dir.c b/dir.c
> > index 5aa6fbad0b7..ea78f606230 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -3076,6 +3076,15 @@ char *git_url_basename(const char *repo, int is=
_bundle, int is_bare)
> >  			end--;
> >  	}
> >
> > +	/*
> > +	 * It should not be possible to overflow `ptrdiff_t` by passing in a=
n
> > +	 * insanely long URL, but GCC does not know that and will complain
> > +	 * without this check.
> > +	 */
> > +	if (end - start < 0)
> > +		die(_("No directory name could be guessed.\n"
>
> This should start with a lower-case letter, see CodingGuidelines.

This message is copied from existing code later in the same function.
Since it is a translateable message, I do not want to edit it because that
would cause unnecessary work of the translators. Especially given that we
do not even expect this message to be shown, ever, but we only add this
hunk for GCC's benefit.

Thank you,
Johannes

>
> > +		      "Please specify a directory on the command line"));
> > +
> >  	/*
> >  	 * Strip trailing port number if we've got only a
> >  	 * hostname (that is, there is no dir separator but a
>
>

--8323328-593497758-1653426336=:352--
