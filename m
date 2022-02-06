Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882E5C433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 21:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiBFVZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 16:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiBFVZj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 16:25:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790BAC06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 13:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644182735;
        bh=Z715KaLeWFEsAgEYOHOtosPk0JSTAWeV9om00GlAmLw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lnAKapV2zy2vEDTlnElOgWrCaJW+HcyyVpGZrUiqYMZdwUXud3jfDQp2NWYlK8La0
         7NyQzqHlf9+/xi2Xbwh6BTEQLtG6ZlwakqPmneqjjJhTk+f6eGssqv2MyjEKgpE9q8
         61NUAWegdi6jnk9QVl7MP9WCn76z53vO0AcCdOCg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.212.206]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1oDIoV0iwO-00wTkk; Sun, 06
 Feb 2022 22:25:35 +0100
Date:   Sun, 6 Feb 2022 22:25:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 4/5] scalar: teach `diagnose` to gather loose objects
 information
In-Reply-To: <CABPp-BHeLzinXkX3WgqBNYntJwY_ZAm5D7VdOR7KQahvLOuV=w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202062214110.347@tvgsbejvaqbjf.bet>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com> <213f2c94b73f90fc758c2e3872804cf640cb2005.1643186507.git.gitgitgadget@gmail.com> <CABPp-BHeLzinXkX3WgqBNYntJwY_ZAm5D7VdOR7KQahvLOuV=w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QlZ3UAKPk3UyrIncSgxdIExcQlr3Pwl/gmBb2eZ+t4BlLn4y9fi
 UAZHLg0icS1CSInr12pzX5taWsh5YD8oiNUb9BzAdDzK/p0VTMqqs5/5nbtd5bSSVZUKgg8
 g0s/pRWF2w5FNtlnwX7As0xa5mpRqSzHgCMPX14IqHdH+Z+5aMD1DepBbNOB1QXAy5KNefX
 qAzA4h0XwgMw/ks54w8/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cdT1b9h+goI=:Q/A3bilSj9j3G/47yp0MWQ
 4gozaZQqbprUgouEPKfeScx9qoOMYDxRTF1z/iK0+1iF6u1kEbKeKJ2TiVToEzqlmAcOy6CMM
 i1B2WHIbJq/M6ZXPW5DjusdT2Kv5iOtJMBrH0fFvOf3Ny847JbLp4Tig+FdIJ77CKZVmtFeOW
 5/y0Pc5xWwbv4ggw89hLvTHiLMmCY/3yVD4rgD0KUw+EWju6BF4gUfjqb7fV9VGT57MEOg1Eu
 0znDHkJXwT1YD+zve9AzPBC+Hm0TTfIm2bUfBLuMW4iqNODx6Z9zWPx+O2p1aYZmIC3qBCN2j
 12HiEzRhFGBo6xHwDKKqlIh0fBKhWmbyohWIU7T1koTH74UOtCs9adNwuQWdJMbBxfa0a1+nf
 mshqEybwSMrVg02TVjz0S0B9MoOZHzT2pvXnaeOoRUtVgvwHeMsjPS6t9QCLM2p+ca+g/89ua
 zH9sqPQ7SwXRombkTPCfuCweMEq6LhV1p1YnAwpZwabe1VKNGGa7+ZslJWfLBiH71J5OjVB1e
 Gv3zi3gBqkfLTBEbnkQ4eZUHz4SMpuGma+Djj8EhBXdTAlxtGTBWvF/Vp7V9Eeq5vfAbR1kOb
 nXevbGNQmNK10ZAUJh1Xabz1wXtUj5rUMX5w0H1Co/AOL6vHPLHUgdpny37X2IYk7T1PlMCUm
 0oZJ0fX19D9r60Pd2ImH8z30PO6UijzONkR5fK2VQm9/+OENFYWMZ3/6JkOjiMJym/dBcYTSb
 hoCFB3D+Vmq1w7zypQyX5/qAzRFJjtg/RMWqEs9x/JKOqHzZUdEyZ2rMGKaCvmjKZweRZnd6v
 68OdHRV4oz23l1mY6K2yTQtqEWYyPnY0lHabp3aCQxpXDFmR3HgXmLq5/pLPn2KTEhKGeeooT
 Zw20F9oRQt1xX5Vb/NL8yo9m9ATkrzuxHuGZd5Jx4twBVhAs8DDZ8lc4UC9BHXHxSzXujd7P9
 attT3e+PFFCQThVEcSMcbJpTdev8HojyMzShqqeRJSclkUQDFKa6AAhMRha+zrITHXKIMIIbE
 7YdX2+eTjxO2d1Sv7wUjOWY6DyTaOvGWjyrYnYJRMCkUywuTJSgCGr98RYoVoKOjQikE0/ntX
 tCSQLCWapvUMKA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 27 Jan 2022, Elijah Newren wrote:

> On Wed, Jan 26, 2022 at 3:37 PM Matthew John Cheetham via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Matthew John Cheetham <mjcheetham@outlook.com>
> >
> > When operating at the scale that Scalar wants to support, certain data
> > shapes are more likely to cause undesirable performance issues, such a=
s
> > large numbers or large sizes of loose objects.
>
> Makes sense.
>
> > By including statistics about this, `scalar diagnose` now makes it
> > easier to identify such scenarios.
> >
> > Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> > ---
> >  contrib/scalar/scalar.c          | 60 +++++++++++++++++++++++++++++++=
+
> >  contrib/scalar/t/t9099-scalar.sh |  2 ++
> >  2 files changed, 62 insertions(+)
> >
> > diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> > index 690933ffdf3..c0ad4948215 100644
> > --- a/contrib/scalar/scalar.c
> > +++ b/contrib/scalar/scalar.c
> > @@ -686,6 +686,60 @@ static void dir_file_stats(struct strbuf *buf, co=
nst char *path)
> >         closedir(dir);
> >  }
> >
> > +static int count_files(char *path)
> > +{
> > +       DIR *dir =3D opendir(path);
> > +       struct dirent *e;
> > +       int count =3D 0;
> > +
> > +       if (!dir)
> > +               return 0;
> > +
> > +       while ((e =3D readdir(dir)) !=3D NULL)
> > +               if (!is_dot_or_dotdot(e->d_name) && e->d_type =3D=3D D=
T_REG)
> > +                       count++;
> > +
> > +       closedir(dir);
> > +       return count;
> > +}
> > +
> > +static void loose_objs_stats(struct strbuf *buf, const char *path)
> > +{
> > +       DIR *dir =3D opendir(path);
> > +       struct dirent *e;
> > +       int count;
> > +       int total =3D 0;
> > +       unsigned char c;
> > +       struct strbuf count_path =3D STRBUF_INIT;
> > +       size_t base_path_len;
> > +
> > +       if (!dir)
> > +               return;
> > +
> > +       strbuf_addstr(buf, "Object directory stats for ");
> > +       strbuf_add_absolute_path(buf, path);
> > +       strbuf_addstr(buf, ":\n");
> > +
> > +       strbuf_add_absolute_path(&count_path, path);
> > +       strbuf_addch(&count_path, '/');
> > +       base_path_len =3D count_path.len;
> > +
> > +       while ((e =3D readdir(dir)) !=3D NULL)
> > +               if (!is_dot_or_dotdot(e->d_name) &&
> > +                   e->d_type =3D=3D DT_DIR && strlen(e->d_name) =3D=
=3D 2 &&
> > +                   !hex_to_bytes(&c, e->d_name, 1)) {
>
> You only recurse into directories, ignoring individual files.
>
> > +                       strbuf_setlen(&count_path, base_path_len);
> > +                       strbuf_addstr(&count_path, e->d_name);
> > +                       total +=3D (count =3D count_files(count_path.b=
uf));
> > +                       strbuf_addf(buf, "%s : %7d files\n", e->d_name=
, count);
>
> This shows the number of files within a directory.
>
> > +               }
> > +
> > +       strbuf_addf(buf, "Total: %d loose objects", total);
>
> and this shows the total number of files across all the directories.
>
> But the commit message suggested you also wanted to check for large
> sizes of loose objects.  Did that get ripped out at some point with
> the commit message not being updated, or is it perhaps going to be
> included later?

No, there was no plan to include this information later, as the original
.NET implementation of `scalar diagnose` did not provide that information,
either (which I take as a strong sign that we never needed this type of
information to help users, at least not up until this point).

Besides, it would be kind of a difficult thing to say conclusively what
makes a loose file "big". Is it the zlib-compressed size on disk? Or the
unpacked size? Should there be a configurable threshold to determine when
an object is big? Should `core.bigFileThreshold` be co-opted for this?

Together with the fact that there was no need for this information in
practice, it makes me doubt that we should add this type of information. I
actually suspect that _iff_ information of that type would be helpful, a
more complete tool like git-sizer (https://github.com/github/git-sizer/)
would be needed, and I do not really want to subsume git-sizer's
functionality in `scalar diagnose`.

I rephrased the commit message.

Ciao,
Dscho

>
> > +
> > +       strbuf_release(&count_path);
> > +       closedir(dir);
> > +}
> > +
> >  static int cmd_diagnose(int argc, const char **argv)
> >  {
> >         struct option options[] =3D {
> > @@ -734,6 +788,12 @@ static int cmd_diagnose(int argc, const char **ar=
gv)
> >         if ((res =3D stage(tmp_dir.buf, &buf, "packs-local.txt")))
> >                 goto diagnose_cleanup;
> >
> > +       strbuf_reset(&buf);
> > +       loose_objs_stats(&buf, ".git/objects");
> > +
> > +       if ((res =3D stage(tmp_dir.buf, &buf, "objects-local.txt")))
> > +               goto diagnose_cleanup;
> > +
> >         if ((res =3D stage_directory(tmp_dir.buf, ".git", 0)) ||
> >             (res =3D stage_directory(tmp_dir.buf, ".git/hooks", 0)) ||
> >             (res =3D stage_directory(tmp_dir.buf, ".git/info", 0)) ||
> > diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099=
-scalar.sh
> > index b1745851e31..f2ec156d819 100755
> > --- a/contrib/scalar/t/t9099-scalar.sh
> > +++ b/contrib/scalar/t/t9099-scalar.sh
> > @@ -77,6 +77,8 @@ test_expect_success UNZIP 'scalar diagnose' '
> >         unzip -p "$zip_path" diagnostics.log >out &&
> >         test_file_not_empty out &&
> >         unzip -p "$zip_path" packs-local.txt >out &&
> > +       test_file_not_empty out &&
> > +       unzip -p "$zip_path" objects-local.txt >out &&
> >         test_file_not_empty out
> >  '
> >
> > --
> > gitgitgadget
>
