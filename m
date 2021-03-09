Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BAAC433E9
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5C364FCF
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhCIRKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhCIRJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 12:09:58 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD82C061760
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 09:09:58 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id l2so9197791pgb.1
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 09:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ggnxzcs/tD7MABIF3uIeXoJkJUWUYbNqx7T0xv3u/Ys=;
        b=fgNlDPJwxJ0ipnUFyF2dS1ec2bXRAadEzn0YZ3EdC222MdnumMhiZP3x3c71+j4WtH
         lC0VgUFy2m9qnK/OMJBfnmb81huQJyMqYSFJA0X/Z0qNsi9+Y4Bt/X59yTBt+le1UP9m
         cl6JL9njZP6DSCUc+ZaYPQr9dmiC3XeiUJH+tXHL4qd+PkyFonr1eiB7LIPkMoDcWgQO
         HW/K0FjDLjmlMF4DQ/l4PM2QTvnLHE3qZ+tdffcmDL48QY78MADwx0D7q6W6ieXjvv1A
         +Vs67bOO5KK22IjIjnksdvy9bUBKnY4F450JmdSE9abXCYTZgOWQSbNA+srrHrnvZWxF
         ZhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ggnxzcs/tD7MABIF3uIeXoJkJUWUYbNqx7T0xv3u/Ys=;
        b=cfVwrivZkV4E8d/ECSinsM1C8p1C5dKazVIilYoB73FU+f8UGn64u6EmN7+w4mjhqT
         Bbput+s2p0t8hQK1VFie0/wXJlVnU5KyEUcIuslmOHYOFXerag5msLuSEqu9/o2Niaga
         5rNj5yMQw7ZjMR/3YOdYvKgIoaGOvhSpDDHst6FISIyO6EpyLwPKm+VSoB37WOTrlabY
         ToXjGyEAtnYwu9O7n7G0rRQrTiGg+GDIK617P7pZxBoT2K1GEPV9I7H6nYRLF4FPcteK
         PEGJ0BM4c2zA576DgG4sUO1htUPOZLy+95PCYDzMzXmTkCSvq6s1+kYpXJSc9Tp29uvt
         Y1MQ==
X-Gm-Message-State: AOAM532EKt03ZH6V9rXjb9wmVUWwxxv7q8kUGCDwpDA2EgTeH4dCRWQH
        nwKYckEbEFzn1txUEKVLnSwKKZPbgmqxBx9B7oy7aET4zM8=
X-Google-Smtp-Source: ABdhPJwTS6EhcVtn6Fx/3omuKGTDT5bvCFBR6mc9K+e/SWHP/vFU5DZ+8U3X53JcL/Cfudck38p9S3E54uFuRLSyWWs=
X-Received: by 2002:a63:410:: with SMTP id 16mr9327565pge.220.1615309798022;
 Tue, 09 Mar 2021 09:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-13-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-13-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 09:09:47 -0800
Message-ID: <CABPp-BHKMxvWJno=4sUBDS3cC=gEC+utbL0=0gxMEibcb_k-4w@mail.gmail.com>
Subject: Re: [PATCH 12/30] tree-walk.h users: migrate "p->mode &&" pattern
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Change code that dpends on "p->mode" either being a valid mode or zero

s/dpends/depends/

> to use a p->object_type comparison to "OBJ_NONE".
>
> The object_type() function in cache.h will not return OBJ_NONE, but in
> this these API users are implicitly relying on the memzero() that
> happens in setup_traverse_info().

This is a bit hard to parse.  Perhaps just remove "in this"?

> Since OBJ_NONE is "0" we can also rely on that being zero'd out here,
> along with the rest of the structure. I think this is slightly less
> clever than "mode not set", and helps to get rid of more uses of
> "mode".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/merge-tree.c | 9 +++++----
>  merge-ort.c          | 2 +-
>  unpack-trees.c       | 4 ++--
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index de8520778d2..2de34c2d485 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -214,7 +214,7 @@ static void unresolved_directory(const struct travers=
e_info *info,
>         void *buf0, *buf1, *buf2;
>
>         for (p =3D n; p < n + 3; p++) {
> -               if (p->mode && S_ISDIR(p->mode))
> +               if (p->object_type =3D=3D OBJ_TREE)
>                         break;
>         }
>         if (n + 3 <=3D p)
> @@ -222,7 +222,7 @@ static void unresolved_directory(const struct travers=
e_info *info,
>
>         newbase =3D traverse_path(info, p);
>
> -#define ENTRY_OID(e) (((e)->mode && S_ISDIR((e)->mode)) ? &(e)->oid : NU=
LL)
> +#define ENTRY_OID(e) (((e)->object_type =3D=3D OBJ_TREE) ? &(e)->oid : N=
ULL)
>         buf0 =3D fill_tree_descriptor(r, t + 0, ENTRY_OID(n + 0));
>         buf1 =3D fill_tree_descriptor(r, t + 1, ENTRY_OID(n + 1));
>         buf2 =3D fill_tree_descriptor(r, t + 2, ENTRY_OID(n + 2));
> @@ -242,7 +242,7 @@ static struct merge_list *link_entry(unsigned stage, =
const struct traverse_info
>         const char *path;
>         struct merge_list *link;
>
> -       if (!n->mode)
> +       if (n->object_type =3D=3D OBJ_NONE)
>                 return entry;
>         if (entry)
>                 path =3D entry->path;
> @@ -265,7 +265,8 @@ static void unresolved(const struct traverse_info *in=
fo, struct name_entry n[3])
>                  * Treat missing entries as directories so that we return
>                  * after unresolved_directory has handled this.
>                  */
> -               if (!n[i].mode || S_ISDIR(n[i].mode))
> +               if (n[i].object_type =3D=3D OBJ_NONE ||
> +                   n[i].object_type =3D=3D OBJ_TREE)
>                         dirmask |=3D (1 << i);
>         }
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 4075d13aaab..4375027914c 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -668,7 +668,7 @@ static int collect_merge_info_callback(int n,
>          * setup_path_info() for tracking.
>          */
>         p =3D names;
> -       while (!p->mode)
> +       while (p->object_type =3D=3D OBJ_NONE)
>                 p++;
>         len =3D traverse_path_len(info, p->pathlen);
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 802f7771d75..92105135522 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -859,7 +859,7 @@ static int traverse_trees_recursive(int n, unsigned l=
ong dirmask,
>         }
>
>         p =3D names;
> -       while (!p->mode)
> +       while (p->object_type =3D=3D OBJ_NONE)
>                 p++;
>
>         newinfo =3D *info;
> @@ -1239,7 +1239,7 @@ static int unpack_callback(int n, unsigned long mas=
k, unsigned long dirmask, str
>         const struct name_entry *p =3D names;
>
>         /* Find first entry with a real name (we could use "mask" too) */
> -       while (!p->mode)
> +       while (p->object_type =3D=3D OBJ_NONE)
>                 p++;
>
>         if (o->debug_unpack)
> --
> 2.31.0.rc0.126.g04f22c5b82
