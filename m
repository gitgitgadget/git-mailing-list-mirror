Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946EEC3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 11:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjAOLxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 06:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjAOLxj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 06:53:39 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DF9EC42
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 03:53:37 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id o75so27410082yba.2
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 03:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ROE7DkiesSIOr2/AlM8IbmKneK0RijjM4/HM1StBU4=;
        b=WJT8QDYqCapRilj5TPncbfmUzGHmtayGXs73LhmYyAhVw/mKE9rGiqZikAFOns5C/B
         lEAjs50czLcGiyAcZ+ZiCLKBGBBToYViIUwVTsnwunAyG6TKoYtEv6eo/Fi41kUQqS5o
         Mvt3YL5idQUFh9DpPd9j0F9zUzU2Tz0OitBvqtpxxDLTLfTHPCoPxAWkV61N1OtjPmRr
         3u3vxI6P3jy0qIS9GlzbLuLpxCNUloymud5iUvGInr6k8q8tUu2VjTIaMrVD6Pr5/6J1
         Qk/66wSm61aEQN3rOn7lgBoZAkSv56EvF+uWWfEjohAmmnyukGw+ob3cuV05uhgVOewE
         vf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ROE7DkiesSIOr2/AlM8IbmKneK0RijjM4/HM1StBU4=;
        b=DKxXj+miggS6iipPyhyxWCt6W4/AfkfcEeYXi3YMfa4q6dF///5Lb4qCxQL6KeS0xF
         rUt49pVbPIsFPziZ6QcULvXb3GRFOSE4FFWiJ1yywv/mO4gPewiEN6JLQ4Moo9mUm2u5
         Qgw6L4hEfrUO6TgbOOMCMkHzfDNRQCMU/VADieO3DAVcH41lO5/OyyQ8ZOP8yCIsT8Kx
         dO+jZa+jULHEL6HU8RQB3Mpl5Q9ZtLoVQi9ku5FN1UM97Ztb5XcoybVmXLnDIRxCuKI1
         fM0ZMKrNlvsLGfCO8HGQNSXwHhebLYpfEPY12HNPCjt9VDUnzcz4VknOWgQcuM9jtH/u
         vZBQ==
X-Gm-Message-State: AFqh2kr7w6mMN8PMZ3BnWn3gvuFDEgXMuyEL39JYIEDD+hEK1lQixPLF
        khWPiyMXzDfE84180DK1bHeLrdCgxCbONR/jxFVoywbTP3s=
X-Google-Smtp-Source: AMrXdXvKDG/T9r0a++nFz0WimdF8jPeFeGp+Xx7167yGap1WVaNIWCeS6uufT/I1bhJ4TAjOtNSqFAuQKKtfXm8biKA=
X-Received: by 2002:a25:6dc4:0:b0:75c:55f:b0d4 with SMTP id
 i187-20020a256dc4000000b0075c055fb0d4mr8557761ybc.13.1673783616539; Sun, 15
 Jan 2023 03:53:36 -0800 (PST)
MIME-Version: 1.0
References: <d0f9520d-9ccc-a899-609e-fbbb4529e005@free.fr>
In-Reply-To: <d0f9520d-9ccc-a899-609e-fbbb4529e005@free.fr>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 15 Jan 2023 12:53:25 +0100
Message-ID: <CAP8UFD0pKZT57jpUOg7gckcr4stoq24YDB2Fu0-AwbGPrEweqg@mail.gmail.com>
Subject: Re: Segmentation fault within git read-tree
To:     =?UTF-8?B?RnLDqWTDqXJpYyBGb3J0?= <fortfrederic@free.fr>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Jan 14, 2023 at 11:22 PM Fr=C3=A9d=C3=A9ric Fort <fortfrederic@free=
.fr> wrote:
>
> Hello,
>
> I am doing some tests trying to do a sparse checkout of a partial clone
> within a subtree.
> However, I get a segfault when trying to run git read-tree as is done by
> git subtree internally.
>
> Maybe what I am doing isn't supposed to work at all, but I suppose it
> shouldn't at least cause git read-tree to segfault.

Yeah, it shouldn't segfault. Thanks for the report!

> Here should be a MWE to reproduce my error:

I reproduced the issue using your steps with a few changes.

> # Run this to create the repo that will become your subtree
> git init subtree.git
> cd subtree.git
> touch x y
> git add .
> git commit -m "first commit"
>
> # Run this to create the repo that has a sparse checkout of a partial
> clone within a subtree
> git init repo
> cd repo
> git commit --allow-empty "first commit"

I think the above command is missing '-m' before "first commit".

> git sparse-checkout set "subtree/x"
> git remote add origin-subtree git@my.server:/with/the/subtree.git

I reproduced using a local remote like:

git remote add origin-subtree /path/to/subtree.git

> git fetch --filter=3Dblob:none origin-subtree
> git rev-parse --verify "FETCH_HEAD^{commit}"
> git read-tree --debug-unpack --prefix=3D"subtree" FETCH_HEAD

Yeah, I get the following under gdb:

Program received signal SIGSEGV, Segmentation fault.
debug_path (info=3D0x7fffffffc880) at unpack-trees.c:1395
1395                    if (*info->prev->name)
(gdb) bt
#0  debug_path (info=3D0x7fffffffc880) at unpack-trees.c:1395
#1  0x000055555587d917 in debug_unpack_callback (n=3D1, mask=3D1,
dirmask=3D0, names=3D0x7fffffffc3b0, info=3D0x7fffffffc880) at
unpack-trees.c:1417
#2  0x000055555587dc48 in unpack_callback (n=3D1, mask=3D1, dirmask=3D0,
names=3D0x7fffffffc3b0, info=3D0x7fffffffc880) at unpack-trees.c:1491
#3  0x00005555558779c2 in traverse_trees (istate=3D0x5555559f3b00
<the_index>, n=3D1, t=3D0x7fffffffcb50, info=3D0x7fffffffc880) at
tree-walk.c:536
#4  0x000055555587ef85 in unpack_trees (len=3D1, t=3D0x7fffffffcb50,
o=3D0x7fffffffcd90) at unpack-trees.c:1979
#5  0x000055555562ab45 in cmd_read_tree (argc=3D1, argv=3D0x7fffffffdc90,
cmd_prefix=3D0x0) at builtin/read-tree.c:263
#6  0x0000555555575a4d in run_builtin (p=3D0x5555559bf8f0
<commands+2256>, argc=3D4, argv=3D0x7fffffffdc90) at git.c:445
#7  0x0000555555575ed2 in handle_builtin (argc=3D4, argv=3D0x7fffffffdc90)
at git.c:700
#8  0x0000555555576179 in run_argv (argcp=3D0x7fffffffdaec,
argv=3D0x7fffffffdae0) at git.c:764
#9  0x0000555555576764 in cmd_main (argc=3D4, argv=3D0x7fffffffdc90) at git=
.c:899
#10 0x0000555555682dfe in main (argc=3D5, argv=3D0x7fffffffdc88) at common-=
main.c:57

From a very quick look, it seems that in setup_traverse_info() in
tree-walk.c we do:

    static struct traverse_info dummy;
...
    if (pathlen)
        info->prev =3D &dummy;

but then later in debug_path() in unpack-trees.c we check
*info->prev->name which segfaults.

I am not very familiar with this code and don't have much time right
now, so I think I will leave it to others to investigate this further.

Best,
Christian.
