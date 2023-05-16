Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3E2C7EE22
	for <git@archiver.kernel.org>; Tue, 16 May 2023 03:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjEPDJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 23:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEPDI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 23:08:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CADD131
        for <git@vger.kernel.org>; Mon, 15 May 2023 20:08:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f25d79f6bfso9592515e87.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 20:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684206535; x=1686798535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVLjKpzRQd1+Kqgyol46ECNe+yzzgKOM9qSFyA4dGkE=;
        b=Y4Rgq/4UyaBPr52S6X7zyOH0DSwBVXUocW5uIKqlsjr91sjsQyOn2D59bp3GYHFNHS
         KetEvLa4q+nLh1Lugdt0Kt66KZJcvbBVsZUNZYQ5I7rbLvvboO82kYTd17XxGRLb0O0X
         ygpncIdMJtkL6Qq5yuwEseCj+IWK7TDeUL6pmHSeLykWPhnt978BCgMkcFDbEFSEKPCd
         4w8QSdiyY6GOlXshUhaiWEzG5I3G9ZdAvY8VqLAHVoYnvfuQjLTv0ID9hISsnFk0T+eP
         Y1xYd/n3yWiNw6py61L171SIaKvQx0dh/yYrU/440LMrIQZ/7/pU3H3FEPyhOUnpuT5z
         9QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684206535; x=1686798535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVLjKpzRQd1+Kqgyol46ECNe+yzzgKOM9qSFyA4dGkE=;
        b=hDLUETMSH4eowYUPjBmYU1L+FkuZ2wb31LAMzkQbzcQ0JJVIq/QhGmj01mVLFa34VS
         sbtxU7mHFtBdLJ1/95KMhTOqcoEcgtqkhiJVViw791F8LFhJgX/O2VqQP0fAa8MIKnyV
         cXNiaY1sbg9ex+2uUIP+3JIE5p514mHtLwzLA3QuKeJy3k+evNzb41BsrLo4xnEM3L8q
         o4S+puDmjGBpR3bH8RUm9Y2VpQIn0qcdHGqz2lBFoOjSzzvqHi97NDCzORXbRliA6qnZ
         B57B4ZNSwlbpQ8qZhqOGooqpg9qfkH31xJ46HIJpnhWfxBAZ9cjk1/mbhfjw+y3dg2LZ
         2e3Q==
X-Gm-Message-State: AC+VfDxVgM/H78pmObnZvWbM/fgNfQr6xPW1+tyrP7uKL1uvELD+K5O5
        ewpMbdh36HUmZfNGC2N2yQo18Xylko/IKr6WT6p1l2+ZYB8=
X-Google-Smtp-Source: ACHHUZ4atO2/JQstDAL0KlzVxQhYIwi+GRmW0Ye6lLAQLDE6nxY58rdQ2cZA3EEQQBWKhveIYIGEtGaNPFfUDmhv3h8=
X-Received: by 2002:ac2:44cc:0:b0:4e8:3fca:4927 with SMTP id
 d12-20020ac244cc000000b004e83fca4927mr6579927lfm.58.1684206535397; Mon, 15
 May 2023 20:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <f7ee69e7e687e8cbdead070df644c5bca23d7578.1683875070.git.gitgitgadget@gmail.com>
 <20230512213441.1127721-1-jonathantanmy@google.com>
In-Reply-To: <20230512213441.1127721-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 May 2023 20:08:43 -0700
Message-ID: <CABPp-BE1dEjcMnKyfgpMG2dS46ujrbkggDNoQiEEY11eyOkJWg@mail.gmail.com>
Subject: Re: [PATCH v2 01/27] init-db: document existing bug with core.bare in
 template config
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 2:34=E2=80=AFPM Jonathan Tan <jonathantanmy@google.=
com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > -     is_bare_repository_cfg =3D init_is_bare_repository || !work_tree;
> >       if (init_shared_repository !=3D -1)
> >               set_shared_repository(init_shared_repository);
> > +     /*
> > +      * TODO: heed core.bare from config file in templates if no
> > +      *       command-line override given
> > +      */
> > +     is_bare_repository_cfg =3D init_is_bare_repository || !work_tree;
>
> This patch moves this line down a few lines, but that's fine because
> set_shared_repository() doesn't modify any of the relevant variables.
>
> > +     /* TODO (continued):
> > +      *
> > +      * Unfortunately, the line above is equivalent to
> > +      *    is_bare_repository_cfg =3D !work_tree;
> > +      * which ignores the config entirely even if no `--[no-]bare`
> > +      * command line option was present.
> > +      *
> > +      * To see why, note that before this function, there was this cal=
l:
> > +      *    init_is_bare_repository =3D is_bare_repository()
>
> This is in init_db(), indeed.
>
> > +      * expanding the right hande side:
>
> s/hande/hand/

Thanks; will fix.

> > +      *                 =3D is_bare_repository_cfg && !get_git_work_tr=
ee()
> > +      *                 =3D is_bare_repository_cfg && !work_tree
> > +      * note that the last simplification above is valid because nothi=
ng
> > +      * calls repo_init() or set_git_work_tree() between any of the
> > +      * relevant calls in the code,
>
> Yes, the only calls are check_repository_format() and
> validate_hash_algorithm() (as can be seen in init_db()) before
> get_git_work_tree() is called at the start of create_default_files().
>
> > diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> > index 1b6437ec079..c02fd64793b 100755
> > --- a/t/t1301-shared-repo.sh
> > +++ b/t/t1301-shared-repo.sh
> > @@ -52,6 +52,28 @@ test_expect_success 'shared=3Dall' '
> >       test 2 =3D $(git config core.sharedrepository)
> >  '
> >
> > +test_expect_failure 'template can set core.bare' '
>
> I would have preferred a test_expect_success with the exact failing line
> documented and prepended with test_must_fail, but I can see why someone
> would prefer test_expect_failure.
