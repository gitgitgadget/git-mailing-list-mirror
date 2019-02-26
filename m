Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E70F20248
	for <e@80x24.org>; Tue, 26 Feb 2019 03:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfBZDs6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 22:48:58 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37260 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBZDs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 22:48:57 -0500
Received: by mail-it1-f194.google.com with SMTP id z124so2067876itc.2
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 19:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GCry8TecnQYzumQ6bu+BU3XRyXBwXIIzAQIHd2GMe58=;
        b=qNKIv+GuYB4T70TbbEd3zf6ZQ60dpWZ5LuuYZHH1c4kV9/zf9CGdKbaHyVKsl9PB3z
         yBSP6N9xf5JykHzLccw1cwMg0Y19JGTzuyir9PAgZUqe/kEKuF58beawzre/8onxJ8DG
         B8/fqACKein/OEaIIJEDzOpcjBMylbLeTYa/dSNiEMwVLHqZy5D3209n0dmx6Q5fu+s5
         MFlyPa8hjVC4lkWUvCeL78CaUAnEHI5r0qMOsBJ3lIrxpLtcmGSEanbY1YESHLX7YMkA
         DG26mvk7TSI854ZT07bAIvOt6xMQ5EsxGg18RgarI0NK8mXUyupTrF2EvuKyPP6CFOM1
         mwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GCry8TecnQYzumQ6bu+BU3XRyXBwXIIzAQIHd2GMe58=;
        b=TzVCuH3Hf/waZjCme555PNNXsl9hkJQe9Jnj+eZaWEgQyUlwORSZDh5WqgQPrewd1t
         1K3+nHNTzWtyM5FDBZMr0n3fb/8EbyRQZckf3rvuTV4+k47eegOGfY1k1FUIbp6ikdN3
         B2vFjCtJ1/008mpCxx05WS1KOF5JDExVoFbu0YTbgjNTlJNn4FNqSx94yTbxomuQ1tfH
         JC1OqPEgaYsT26vgqkFGPd1gpzkuNkw+7eVgSj00Q1nkJxsN23hldkAPcg+ZWGF/g+cp
         2Eth3HMPjoHABL6YkQieghIxrHrk9T4Z2E2gKzZChHkStcc+R+0ST6+rEaDa7uazlgcO
         PV9g==
X-Gm-Message-State: AHQUAubEeycvg+OeRoC82WruUpfe9jpyOPW+/TqNRjn83LvE5Lj12fOw
        wikcWE4bjdIUUdE3Gqc9LqzmAxnBPbw8H3xH3K5s9w==
X-Google-Smtp-Source: AHgI3IaO4MJmAHhtg+moOl1fKaOWUkh8fp6zRt+DSDHDMUxQs0dYtbp6hMCzhvj82vwc+iqJ/FSN/LbX2zokRytc870=
X-Received: by 2002:a24:b8c6:: with SMTP id m189mr1233657ite.72.1551152935946;
 Mon, 25 Feb 2019 19:48:55 -0800 (PST)
MIME-Version: 1.0
References: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
 <20190226002625.13022-6-avarab@gmail.com>
In-Reply-To: <20190226002625.13022-6-avarab@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 26 Feb 2019 00:48:44 -0300
Message-ID: <CAHd-oW7HvhkORZogjb0nPioe3KWmXDDACF6Tu-Kmayc7=1z7nA@mail.gmail.com>
Subject: Re: [WIP RFC PATCH 5/7] clone: use dir-iterator to avoid explicit dir traversal
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 9:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> From: Matheus Tavares <matheus.bernardino@usp.br>
>
> Replace usage of opendir/readdir/closedir API to traverse directories
> recursively, at copy_or_link_directory function, by the dir-iterator
> API. This simplifies the code and avoid recursive calls to
> copy_or_link_directory.
>
> [=C3=86var: This should be bug-compatible with the existing "clone"
> behavior. The whole bit here with "iter->relative_path[0] =3D=3D '.'" is =
a
> dirty hack. We don't copy dot-dirs, and then later on just blindly
> ignore ENOENT errors as we descend into them. That case really wants
> to be a is_dotdir_or_file_within() test instead]
>
> Now, copy_or_link_directory will call die() in case of an error on
> openddir, readdir or lstat, inside dir_iterator_advance. That means it
> will abort in case of an error trying to fetch any iteration entry.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/clone.c | 55 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 862d2ea69c..c32e9022b3 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -23,6 +23,8 @@
>  #include "transport.h"
>  #include "strbuf.h"
>  #include "dir.h"
> +#include "dir-iterator.h"
> +#include "iterator.h"
>  #include "sigchain.h"
>  #include "branch.h"
>  #include "remote.h"
> @@ -411,42 +413,47 @@ static void mkdir_if_missing(const char *pathname, =
mode_t mode)
>  }
>
>  static void copy_or_link_directory(struct strbuf *src, struct strbuf *de=
st,
> -                                  const char *src_repo, int src_baselen)
> +                                  const char *src_repo)
>  {
> -       struct dirent *de;
> -       struct stat buf;
>         int src_len, dest_len;
> -       DIR *dir;
> -
> -       dir =3D opendir(src->buf);
> -       if (!dir)
> -               die_errno(_("failed to open '%s'"), src->buf);
> +       struct dir_iterator *iter;
> +       int iter_status;
> +       struct stat st;
>
>         mkdir_if_missing(dest->buf, 0777);
>
> +       iter =3D dir_iterator_begin(src->buf, 1);
> +
>         strbuf_addch(src, '/');
>         src_len =3D src->len;
>         strbuf_addch(dest, '/');
>         dest_len =3D dest->len;
>
> -       while ((de =3D readdir(dir)) !=3D NULL) {
> +       while ((iter_status =3D dir_iterator_advance(iter)) =3D=3D ITER_O=
K) {
>                 strbuf_setlen(src, src_len);
> -               strbuf_addstr(src, de->d_name);
> +               strbuf_addstr(src, iter->relative_path);
>                 strbuf_setlen(dest, dest_len);
> -               strbuf_addstr(dest, de->d_name);
> -               if (stat(src->buf, &buf)) {
> +               strbuf_addstr(dest, iter->relative_path);
> +
> +               /*
> +                * dir_iterator_advance already calls lstat to populate i=
ter->st
> +                * but, unlike stat, lstat does not checks for permission=
s on
> +                * the given path.
> +                */
> +               if (stat(src->buf, &st)) {
>                         warning (_("failed to stat %s\n"), src->buf);
>                         continue;
>                 }
> -               if (S_ISDIR(buf.st_mode)) {
> -                       if (de->d_name[0] !=3D '.')
> -                               copy_or_link_directory(src, dest,
> -                                                      src_repo, src_base=
len);
> +
> +               if (S_ISDIR(iter->st.st_mode)) {
> +                       if (iter->relative_path[0] =3D=3D '.')

I think it should be iter->basename[0] here, instead, right?

I also have a more conceptual question here: This additions (or the
is_dotdir_of_file_within as suggested) are just to make patch
compatible with the current behaviour, but are going to be removed
soon after. As this would be kind of a noise, wouldn't it be better to
have a patch before this, already correcting copy_or_link_directory's
behaviour on hidden dirs and them this?

> +                               continue;
> +                       mkdir_if_missing(dest->buf, 0777);
>                         continue;
>                 }
>
>                 /* Files that cannot be copied bit-for-bit... */
> -               if (!strcmp(src->buf + src_baselen, "/info/alternates")) =
{
> +               if (!strcmp(iter->relative_path, "info/alternates")) {
>                         copy_alternates(src, dest, src_repo);
>                         continue;
>                 }
> @@ -456,14 +463,18 @@ static void copy_or_link_directory(struct strbuf *s=
rc, struct strbuf *dest,
>                 if (!option_no_hardlinks) {
>                         if (!link(src->buf, dest->buf))
>                                 continue;
> -                       if (option_local > 0)
> -                               die_errno(_("failed to create link '%s'")=
, dest->buf);
> +                       if (option_local > 0 && errno !=3D ENOENT)
> +                               warning_errno(_("failed to create link '%=
s'"), dest->buf);
>                         option_no_hardlinks =3D 1;
>                 }
> -               if (copy_file_with_time(dest->buf, src->buf, 0666))
> +               if (copy_file_with_time(dest->buf, src->buf, 0666) && err=
no !=3D ENOENT)
>                         die_errno(_("failed to copy file to '%s'"), dest-=
>buf);
>         }
> -       closedir(dir);
> +
> +       if (iter_status !=3D ITER_DONE) {
> +               strbuf_setlen(src, src_len);
> +               die(_("failed to iterate over '%s'"), src->buf);
> +       }
>  }
>
>  static void clone_local(const char *src_repo, const char *dest_repo)
> @@ -481,7 +492,7 @@ static void clone_local(const char *src_repo, const c=
har *dest_repo)
>                 get_common_dir(&dest, dest_repo);
>                 strbuf_addstr(&src, "/objects");
>                 strbuf_addstr(&dest, "/objects");
> -               copy_or_link_directory(&src, &dest, src_repo, src.len);
> +               copy_or_link_directory(&src, &dest, src_repo);
>                 strbuf_release(&src);
>                 strbuf_release(&dest);
>         }
> --
> 2.21.0.rc2.1.g2d5e20a900.dirty
>
