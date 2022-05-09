Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2304CC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 21:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiEIVIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiEIVIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 17:08:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6D4268207
        for <git@vger.kernel.org>; Mon,  9 May 2022 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652130287;
        bh=yLhO4YZdRQEpO2tv7l9Zw+O7LQaH8hngL56RZZtYg9w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jtix7W5bMgPZF0KYqSluCdFJLsrgwA9nJgLflO2sEGWB7lNfbL111rOV20nQJLFyb
         l8zSKxlAPhy3BU9lHj3v40D2WZut+OBPwsDBUEXAmXjOXDydyUlsClzu4LaQZTmsDf
         YsGzKefs8reW/15Bxq+mCdr8fG54MMswzncprywg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.31.72] ([213.196.213.50]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXFr-1nakHv43cH-00DYoM; Mon, 09
 May 2022 23:04:47 +0200
Date:   Mon, 9 May 2022 23:04:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/7] archive --add-file-with-contents: allow paths
 containing colons
In-Reply-To: <CABPp-BEpA52Zq=43j3D=io7h4ooSVGd-644iJkGU5+MmsJjDZw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205092302550.346@tvgsbejvaqbjf.bet>
References: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com> <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com> <ce4b1b680c98d0f55d4d307b8c746a81d90ffa06.1651677919.git.gitgitgadget@gmail.com>
 <CABPp-BEpA52Zq=43j3D=io7h4ooSVGd-644iJkGU5+MmsJjDZw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+FfN7xz7h8X8h8BG9qqe+HwjimyA9hskEQi62LXKlTL1xcy5Ll3
 /N7mynZi+AKwTTlzS9h09ggsfSiDcTatUbLbklY6cXVbQ4KklT7hlKe/JYgLcCkpZpdvWKP
 auqHZxrk4ZYZk9hB82wI+dAQbrCFaxc99OfP8OmGsoEgS109AsOIXwqXCmHJrL4ResvElgq
 hIWEB9XTUy5IHIZNYxOSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ks8Kp0gZ+E4=:FGegmqA1RJnxLUskfvObof
 GQdw0NYE8emDEL/GnuRBl7me3a3aHum2ej8zcuxpsTxhsmBtw6zclKkYMKWg+9rbfazXgYfAk
 PHDikAWasH72yepS5iogReH3UhxTIC0OxQ1DRH8b5nJ3qF3rEW0LZdV2G73pu259WUhFayGgK
 lfPn0pp9k9aD90JRYij+/uxFeMlyb0yN9c/+TMsftDu5hJ8PemQJnuosLI9f2TZKIMsJ/baer
 lslmKjsm5vzyn61iMj506bFr0LWACNF8//GraNVv4vLQzdw9AzRPODOTUMaHfcZ2T5EX2ryfd
 WN/96Z3xZhqKcpUHIp/qcc/3nSQGjjWB5TvBASZl09RPB4o0reBzR8cG97JDaVDx7hTmcnQGi
 5W85n8KDtC+XJeTwmL4gk7UJM8jvGvnRKNgaNmb4dHwWIQZY8SNEI7o3txaflkxTl8lqw71OK
 1V5TP62icEgesENDd2GC/6ZFvjXYZ2MW7F++LcBPLsJy2eQTnNvnV9rwxiV9YY3bEI6qIbRu4
 TPKd7ZT8rPizk5bzXIKwvSV5zGinyaPL8shdwVGwRnGVjj7Xc+YOgFVRwjHLVjBsmc5uWBn1i
 4RKh2GbPl4PDQ8VFK3WrvIF3UVt0Tr94Vk38zzBC4sclGr3lJku8s2WplTkce1nq8DGPbl9aR
 aVQOACwKu9vNgDSZb8F4cI8CrqvHDVKgGQPAvnHmLRYTTieLXNpcf1bkEUnE3C6Z28YWtRsTP
 Dogzclo9tw6WLBUoQj+hE91bjYmeBuPVA4yFNzUt8I8un4XwcpuP21BF4LkGUTwdolbrA7LVe
 aGL9iox89B/F4TwzdqGVu9zvXKPVZXAaUTsjy6KM6sjBlkhueHp4I+VwbKepibMBhYt5NoNPe
 P6aR2XX9JbAe5eYrd3oxR00X3SHwqhU+igjLmrx+4gYqyhA7Wz9EEcbnzVRKc3PprnLmGrLCQ
 J2DxoFrpR7hQB/7Po1tqBYU9tkG5LvBgEBoBw7cPeIUu3sXt3SYCGhwWnXFETk5bsiq8tX3uc
 gJypZeiiRO0yBNjZpmef2AGpbORe5WUTZ5WadMaST+anISDPrQtKdE44/dvBQYuNkS376itKI
 8tn9lS7r4O1y4A=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 6 May 2022, Elijah Newren wrote:

> On Wed, May 4, 2022 at 8:25 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > By allowing the path to be enclosed in double-quotes, we can avoid
> > the limitation that paths cannot contain colons.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Documentation/git-archive.txt | 13 +++++++++----
> >  archive.c                     | 34 +++++++++++++++++++++++++++++-----
> >  t/t5003-archive-zip.sh        |  8 ++++++++
> >  3 files changed, 46 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/git-archive.txt b/Documentation/git-archive=
.txt
> > index a0edc9167b2..1789ce4c232 100644
> > --- a/Documentation/git-archive.txt
> > +++ b/Documentation/git-archive.txt
> > @@ -67,10 +67,15 @@ OPTIONS
> >         by concatenating the value for `--prefix` (if any) and the
> >         basename of <file>.
> >  +
> > -The `<path>` cannot contain any colon, the file mode is limited to
> > -a regular file, and the option may be subject to platform-dependent
> > -command-line limits. For non-trivial cases, write an untracked file
> > -and use `--add-file` instead.
> > +The `<path>` argument can start and end with a literal double-quote
> > +character. In this case, the backslash is interpreted as escape
> > +character. The path must be quoted if it contains a colon, to avoid
> > +the colon from being misinterpreted as the separator between the
> > +path and the contents.
>
> The path must also be quoted if it begins or ends with a double-quote, r=
ight?

True.

> Also, would people want to be able to pass a pathname from the output
> of e.g. `git ls-files -o`, which may quote additional characters?

Also true.

> > ++
> > +The file mode is limited to a regular file, and the option may be
> > +subject to platform-dependent command-line limits. For non-trivial
> > +cases, write an untracked file and use `--add-file` instead.
> >
> >  --worktree-attributes::
> >         Look for attributes in .gitattributes files in the working tre=
e
> > diff --git a/archive.c b/archive.c
> > index d798624cd5f..3b751027143 100644
> > --- a/archive.c
> > +++ b/archive.c
> > @@ -533,13 +533,37 @@ static int add_file_cb(const struct option *opt,=
 const char *arg, int unset)
> >                         die(_("Not a regular file: %s"), path);
> >                 info->content =3D NULL; /* read the file later */
> >         } else {
> > -               const char *colon =3D strchr(arg, ':');
> >                 char *p;
> >
> > -               if (!colon)
> > -                       die(_("missing colon: '%s'"), arg);
> > +               if (*arg !=3D '"') {
> > +                       const char *colon =3D strchr(arg, ':');
> > +
> > +                       if (!colon)
> > +                               die(_("missing colon: '%s'"), arg);
> > +                       p =3D xstrndup(arg, colon - arg);
> > +                       arg =3D colon + 1;
> > +               } else {
> > +                       struct strbuf buf =3D STRBUF_INIT;
> > +                       const char *orig =3D arg;
> > +
> > +                       for (;;) {
> > +                               if (!*(++arg))
> > +                                       die(_("unclosed quote: '%s'"),=
 orig);
> > +                               if (*arg =3D=3D '"')
> > +                                       break;
> > +                               if (*arg =3D=3D '\\' && *(++arg) =3D=
=3D '\0')
> > +                                       die(_("trailing backslash: '%s=
"), orig);
> > +                               else
> > +                                       strbuf_addch(&buf, *arg);
> > +                       }
> > +
> > +                       if (*(++arg) !=3D ':')
> > +                               die(_("missing colon: '%s'"), orig);
> > +
> > +                       p =3D strbuf_detach(&buf, NULL);
> > +                       arg++;
> > +               }
>
> Should we use unquote_c_style() here instead of rolling another parser
> to do unquoting?  That would have the added benefit of allowing people
> to use filenames from the output of various git commands that do
> special quoting -- such as octal sequences for non-ascii characters.

Yep, let's do that. I somehow missed that function while glimpsing at
`quote.h`.

Thank you for your review!
Dscho

> >
> > -               p =3D xstrndup(arg, colon - arg);
> >                 if (!args->prefix)
> >                         path =3D p;
> >                 else {
> > @@ -548,7 +572,7 @@ static int add_file_cb(const struct option *opt, c=
onst char *arg, int unset)
> >                 }
> >                 memset(&info->stat, 0, sizeof(info->stat));
> >                 info->stat.st_mode =3D S_IFREG | 0644;
> > -               info->content =3D xstrdup(colon + 1);
> > +               info->content =3D xstrdup(arg);
> >                 info->stat.st_size =3D strlen(info->content);
> >         }
> >         item =3D string_list_append_nodup(&args->extra_files, path);
> > diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> > index 8ff1257f1a0..5b8bbfc2692 100755
> > --- a/t/t5003-archive-zip.sh
> > +++ b/t/t5003-archive-zip.sh
> > @@ -207,13 +207,21 @@ check_zip with_untracked
> >  check_added with_untracked untracked untracked
> >
> >  test_expect_success UNZIP 'git archive --format=3Dzip --add-file-with=
-content' '
> > +       if test_have_prereq FUNNYNAMES
> > +       then
> > +               QUOTED=3Dquoted:colon
> > +       else
> > +               QUOTED=3Dquoted
> > +       fi &&
> >         git archive --format=3Dzip >with_file_with_content.zip \
> > +               --add-file-with-content=3D\"$QUOTED\": \
> >                 --add-file-with-content=3Dhello:world $EMPTY_TREE &&
> >         test_when_finished "rm -rf tmp-unpack" &&
> >         mkdir tmp-unpack && (
> >                 cd tmp-unpack &&
> >                 "$GIT_UNZIP" ../with_file_with_content.zip &&
> >                 test_path_is_file hello &&
> > +               test_path_is_file $QUOTED &&
> >                 test world =3D $(cat hello)
> >         )
> >  '
> > --
> > gitgitgadget
>
>
