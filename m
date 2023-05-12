Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86381C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 01:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbjELBVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 21:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELBVj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 21:21:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEEE558F
        for <git@vger.kernel.org>; Thu, 11 May 2023 18:21:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso10464092e87.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 18:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683854496; x=1686446496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlSlqkquoCa4d9wwS/cH+E8J4Wp5JZ6llpDdctPn0us=;
        b=lASQJ4tOWqUlr+3ytDvAY3jk2KosVksaw09iOhe3wz5OpGFX9LUPmbUIv0JZKskMXO
         kgsSpQK1CqdeJiUFrH5CoFWm2NRkEshY9qOPMTqtpDGDZxJGAAL5e08uBMG8PNeenCco
         hSLlEfE/S5o6QWTQkaDDhhK+Dp20+3T5y0opcqKnjDkJV2c/q4IShUekgkIoPVCB+qST
         fK8hYuyvNp0kKyvue+TDo3gCT9zVNBjXO0T1JPUU9JZXCrRPujJ0YHnwTddPlFoZY0NF
         IKnDoq4NZd+GGZDeT4fE1ICr2yW7ACaD96DaOCZ6LR2pQ1WVcOmcIP15QyLBiLpzronf
         uZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683854496; x=1686446496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlSlqkquoCa4d9wwS/cH+E8J4Wp5JZ6llpDdctPn0us=;
        b=ShGkcke4Lno+NjWJa4wLwwJ/6sRFVEQWAMML++y3wpj5mjmhHkou6CyXsrqs/FIfwJ
         MdkBRhySX5FtIpQJ5GY7VwhTm0rpfiAZhFAzvBRaYni3FCvdpTrUv5CD22mtPMeXvSEW
         Zq/0KlKzyN+WRPzA6gbz8Zq2BKRdiKxazkt8TmL6QV1kHgzKJKZlvvrgU8yg6icj9E0E
         vSQao3XvI3UJ+azCxlXAn+SXm4mbJmokoKAuwbxpEj8rlaFHvRxGfLoKGmfd57M1r14B
         r4w5zZ+oOkcuYAXj7ztBOJnYbKbLb83aji6h6zkMUnwqO6MfsHXbM0K7KFQZ0i3a1V1A
         gS9A==
X-Gm-Message-State: AC+VfDwPIxCkYs6JEBhMHJIAH/qszSFdrCg+2EzPz6C9hqXzQJEC18Hd
        7jvocE9Ik1f3Yc4P16f65Y8moM42LdQC/0is77o=
X-Google-Smtp-Source: ACHHUZ6VY2ejSbN4vWI8BUlS6FSG+OKVAgFa3JHTxQ6CXLPKdT7q6eeYjyXvPgRx+Gz17x2JNTgcp3vdKDbA4+ZUOLA=
X-Received: by 2002:ac2:546b:0:b0:4f1:430d:ca5c with SMTP id
 e11-20020ac2546b000000b004f1430dca5cmr3688530lfn.56.1683854495708; Thu, 11
 May 2023 18:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
 <12a251f77f679123d01892109694f8ee19b96252.1683431151.git.gitgitgadget@gmail.com>
 <kl6lsfc2zjje.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lsfc2zjje.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 May 2023 18:21:00 -0700
Message-ID: <CABPp-BFT_aAmMcD7HKVuaZR3kkGND1mBF3R8OvisHimYWiX48g@mail.gmail.com>
Subject: Re: [PATCH 01/24] init-db: remove unnecessary global variable &
 document existing bug
To:     Glen Choo <chooglen@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 1:43=E2=80=AFPM Glen Choo <chooglen@google.com> wro=
te:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > This commit was prompted by a desire to move the functions which
> > builtin/init-db.c and builtin/clone.c share out of the former file and
> > into setup.c.  One issue that made it difficult was the
> > init_is_bare_repository global variable.
> >
> > init_is_bare_repository is actually not very useful.  It merely stores
> > the return value from is_bare_repository() and only for the duration of
> > a few additional function calls before its value is checked, and none o=
f
> > those functions do anything that could change is_bare_repository()'s
> > return value.  So, we can simply dispense with the global by replacing
> > it with is_bare_repository().
>
> I think the purpose of init_is_bare_repository is something different.
> But based off my different understanding, I can't reproduce any
> different behavior. I don't know if I'm just confused or not, but I'll
> leave some breadcrumbs here to check my understanding.

So, while my patch does not change behavior under any circumstances,
my explanation was slightly wrong.  More on that below...

> Reordering the hunks for clarity,
>
> > @@ -422,8 +436,6 @@ int init_db(const char *git_dir, const char *real_g=
it_dir,
> >
> >       safe_create_dir(git_dir, 0);
> >
> > -     init_is_bare_repository =3D is_bare_repository();
> > -
> >       /* Check to see if the repository version is right.
> >        * Note that a newly created repository does not have
> >        * config file, so this will not fail.  What we are catching
>
> Here, init_db() caches the value of is_bare_repository(), which itself
> reads the value of is_bare_repository_cfg, which can be modified by when
> we read "core.bare" via git_config(git_default_config) or similar
> (basically, any config callback that uses git_default_config). It is
> also modified in other places though, like setup.c.

Close.  is_bare_repository() not only reads the value of
is_bare_repository_cfg, but it ANDs the result with
!get_git_work_tree().  This turns out to be important.

> IIUC, we haven't actually parsed "core.bare" at this point. The
> git_config() call just above this calls "plaform_core_config", which is
> either "mingw_core_config" (doesn't read "core.bare") or
> noop_core_config (noop).

I believe this is correct.

> > @@ -231,9 +230,24 @@ static int create_default_files(const char *templa=
te_path,
> >        * We must make sure command-line options continue to override an=
y
> >        * values we might have just re-read from the config.
> >        */
> > -     is_bare_repository_cfg =3D init_is_bare_repository || !work_tree;
> >       if (init_shared_repository !=3D -1)
> >               set_shared_repository(init_shared_repository);
> > +     /*
> > +      * TODO: heed core.bare from config file in templates if no
> > +      *       command-line override given
> > +      *
> > +      * Unfortunately, this location in the code is far too late to
> > +      * allow this to happen; both builtin/init.db and
> > +      * builtin/clone.c setup the new repository and call
> > +      * set_git_work_tree() before this point.  (Note that both do
> > +      * that repository setup before calling init_db(), which in
> > +      * turn calls create_default_files().)  Fixing it would
> > +      * require too much refactoring, and no one seems to have
> > +      * wanted this behavior in 15+ years, so we'll continue
> > +      * ignoring the config for now and just override
> > +      * is_bare_repository_cfg unconditionally.
> > +      */
> > +     is_bare_repository_cfg =3D is_bare_repository() || !work_tree;
> >
> >       /*
> >        * We would have created the above under user's umask -- under
>
> Now, we're in the midst of the re-init. Expanding the context a little,
> we see:
>
>         git_config(git_default_config, NULL);
>
>         /*
>          * We must make sure command-line options continue to override an=
y
>          * values we might have just re-read from the config.
>          */
>         is_bare_repository_cfg =3D init_is_bare_repository || !work_tree;
>
> So now we've read the new config of the re-inited repo, which might have
> "core.bare" set to a value other than what "git init-db [--bare]"
> started with

Correct.

> so we want to _intentionally_ ignore it.

That's what the code does, but not what it should do.  If neither
`--bare` nor `--no-bare` is given on the command line, we ought to pay
attention to the config setting.

The fact that we do ignore the config regardless of command line flags
is the bug that this patch documents.

> We do this by
> reading out the cached value, _not_ by calling is_bare_repository()
> again.

Almost, but you missed part of the line you are commenting on.  We
read out the cached value *and* OR it with !work_tree.  The
distinction may look small, but it turns out to be critical.

> So it seems to me like this patch changes the intent.

Yeah, looks like it does.

But it doesn't change the result.  Note the critical thing here is we
changed from computing:
   init_is_bare_repository || !work_tree;
to
   is_bare_repository() || !work_tree;

Further,
   init_is_bare_repository =3D [cached value of] is_bare_repository_cfg
&& [cached value of] !get_git_work_tree()
   is_bare_repository() =3D [current value of] is_bare_repository_cfg &&
[current value of] !get_git_work_tree()

However, nothing calls repo_init() or set_git_work_tree() between any
of these calls, so
   [current value of] !get_git_work_tree() =3D=3D [cached value of]
!get_git_work_tree() =3D=3D !work_tree

So, both before and after what we are computing simplifies to
   <something> && !work_tree || !work_tree
which further simplifies, regardless of whether <something> is true or
false, down to
   !work_tree

So whether we are using a cached value of is_bare_repository_cfg or a
current value of is_bare_repository_cfg is irrelevant.  In fact, from
the analysis above, we can simplify this line to just
   is_bare_repository_cfg =3D !work_tree;
completely ignoring both is_bare_repository_cfg and
is_bare_repository(), and it won't change the behavior.  I just did
it; it passes all tests.

> Where I struggling with is how to make this behave badly. The lines
> above seem to be defensive in nature - we never use
> is_bare_repository_cfg past this point, but we want to guard against
> unintentional behavior in the future.

Not quite true; there is another call to is_bare_repository() in the
same function about 60 lines later, which does pay attention to
is_bare_repository_cfg.

[...]
> If I'm right (which I'm not sure about), we might need to keep
> init_is_bare_repository around _somewhere_. Not a global, but maybe
> as a param.

This makes sense, despite the other bugs present.  I'll make this
change, as well as split this patch into two as Calvin suggested, and
update the description to correct my errors and explain the bug
better.
