Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9573C001E0
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 05:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHLFla (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Aug 2023 01:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjHLFla (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2023 01:41:30 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C791
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 22:41:29 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-64189370a63so10732866d6.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 22:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691818888; x=1692423688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDILIHIonCfpoSi2qQQEA8w9Hd34d7ARhNeWWddWSMI=;
        b=sXM3NUwq5R8AtaLEbhIFKJ98vWUUe5LrjtAIbbRKEZjNISWuRbbqN86BQXRODaBjzl
         8zZTDWtMHWsXQmUVK+bPNJoDbxRiPt6OpLXNV6hXNAyHru2iT9/FEW+MnNRwUU+VY6RB
         3Oyl67EdnTejAmzu+GAfx/1tyZDjmiMFbFL5F5auU4Viz7k7H2q1lejmK3wYHLUFfQpD
         YFT+pDPoWXB+igwTTaGGVX0o/WGLjJbFo01fHD/naqZoFIPDtUU/U2J9jC6UQutTDspK
         P8hseRZeghzofJqYhLqfL83waJYk29waDvwucMdlPsL/MZOnBqclf9hgjqJUWxfL/Kuo
         +4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691818888; x=1692423688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDILIHIonCfpoSi2qQQEA8w9Hd34d7ARhNeWWddWSMI=;
        b=aevbXfBhZ+Z9M9VX4KCrSZvDtg/55pJbnWgUj5bCCyvQFDsTWHp3ggjmtKP/udcwc/
         rcCVBAN4q8KJwkyySk5Y93JlA3BcrO25SmlO6E/dSV9tumcWGLlBLTdwiuyyLVKyyqkC
         mJe5MzFSdBQT+Hywc4xgnWByD0CtudyBWo2ZV86p1TJ4sZXsHKbCxcrqoZChUxuenT6Q
         oOgi3LE8fc516Jl5PiY+if5Kiruua3+JQnF8UHeqCL6MyuWm4f5fbnNX6an2dadMQWV3
         cpJ+dfhuYw31UDjU44idealVlt9RHEoJltnfN3ZjlG6NHDWo/QJu/3JD+RWVf6ZNNivi
         /SsQ==
X-Gm-Message-State: AOJu0Yz8hQr4CC8lfwW+uzay4UgJUsWHiyDKdTPYzb0+bwKK07NkSQLJ
        PRURReDuC4F0QY2Qr3cII7jddPmEs8mRsb5Q457fuagCGYc=
X-Google-Smtp-Source: AGHT+IFG68bPpcA8neN9TFPPBPOxM3mUCQSU9HS4xL5XOI/PuwzCs7UdLBnVpDXIG0bx5dyvF6V+WJ2HOEa6M/glt2U=
X-Received: by 2002:a0c:f303:0:b0:644:7155:d282 with SMTP id
 j3-20020a0cf303000000b006447155d282mr2229646qvl.5.1691818888269; Fri, 11 Aug
 2023 22:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1565.git.1691245481977.gitgitgadget@gmail.com> <pull.1565.v2.git.1691818386345.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v2.git.1691818386345.gitgitgadget@gmail.com>
From:   =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>
Date:   Sat, 12 Aug 2023 13:41:17 +0800
Message-ID: <CAFWsj_X=_PVyLcRgy77PL+kisjFqRSTCojB61B5cSK=6YROajg@mail.gmail.com>
Subject: Re: [PATCH v2] merge-tree: add -X strategy option
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your advice, I have uploaded a new patch including tests.

On Sat, Aug 12, 2023 at 1:33=E2=80=AFPM Izzy via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: winglovet <winglovet@gmail.com>
>
> Add merge strategy option to produce more customizable merge result such
> as automatically solve conflicts.
>
> Signed-off-by: winglovet <winglovet@gmail.com>
> ---
>     merge-tree: add -X strategy option
>
>     Change-Id: I16be592262d13cebcff8726eb043f7ecdb313b76
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1565%2F=
WingT%2Fmerge_tree_allow_strategy_option-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1565/WingT=
/merge_tree_allow_strategy_option-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1565
>
> Range-diff vs v1:
>
>  1:  b843caed596 ! 1:  7d53d08381e merge-tree: add -X strategy option
>      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **a=
rgv, const char
>         /* Handle --stdin */
>         if (o.use_stdin) {
>                 struct strbuf buf =3D STRBUF_INIT;
>      +
>      + ## t/t4301-merge-tree-write-tree.sh ##
>      +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
>      +  git branch side1 &&
>      +  git branch side2 &&
>      +  git branch side3 &&
>      ++ git branch side4 &&
>      +
>      +  git checkout side1 &&
>      +  test_write_lines 1 2 3 4 5 6 >numbers &&
>      +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
>      +  test_tick &&
>      +  git commit -m rename-numbers &&
>      +
>      ++ git checkout side4 &&
>      ++ test_write_lines 0 1 2 3 4 5 >numbers &&
>      ++ echo yo >greeting &&
>      ++ git add numbers greeting &&
>      ++ test_tick &&
>      ++ git commit -m other-content-modifications &&
>      ++
>      +  git switch --orphan unrelated &&
>      +  >something-else &&
>      +  git add something-else &&
>      +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Content m=
erge and a few conflicts' '
>      +  test_cmp expect actual
>      + '
>      +
>      ++test_expect_success 'Auto resolve conflicts by "ours" stragety opt=
ion' '
>      ++ git checkout side1^0 &&
>      ++
>      ++ # make sure merge conflict exists
>      ++ test_must_fail git merge side4 &&
>      ++ git merge --abort &&
>      ++
>      ++ git merge -X ours side4 &&
>      ++ git rev-parse HEAD^{tree} > expected &&
>      ++
>      ++    git merge-tree -X ours side1 side4 > actual &&
>      ++
>      ++ test_cmp expected actual
>      ++'
>      ++
>      + test_expect_success 'Barf on misspelled option, with exit code oth=
er than 0 or 1' '
>      +  # Mis-spell with single "s" instead of double "s"
>      +  test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR=
 side1 side2 2>expect &&
>
>
>  builtin/merge-tree.c             | 24 ++++++++++++++++++++++++
>  t/t4301-merge-tree-write-tree.sh | 23 +++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 0de42aecf4b..2ec6ec0d39a 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -19,6 +19,8 @@
>  #include "tree.h"
>  #include "config.h"
>
> +static const char **xopts;
> +static size_t xopts_nr, xopts_alloc;
>  static int line_termination =3D '\n';
>
>  struct merge_list {
> @@ -414,6 +416,7 @@ struct merge_tree_options {
>         int show_messages;
>         int name_only;
>         int use_stdin;
> +       struct merge_options merge_options;
>  };
>
>  static int real_merge(struct merge_tree_options *o,
> @@ -439,6 +442,8 @@ static int real_merge(struct merge_tree_options *o,
>
>         init_merge_options(&opt, the_repository);
>
> +       opt.recursive_variant =3D o->merge_options.recursive_variant;
> +
>         opt.show_rename_progress =3D 0;
>
>         opt.branch1 =3D branch1;
> @@ -510,6 +515,17 @@ static int real_merge(struct merge_tree_options *o,
>         return !result.clean; /* result.clean < 0 handled above */
>  }
>
> +static int option_parse_x(const struct option *opt,
> +                         const char *arg, int unset)
> +{
> +       if (unset)
> +               return 0;
> +
> +       ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
> +       xopts[xopts_nr++] =3D xstrdup(arg);
> +       return 0;
> +}
> +
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  {
>         struct merge_tree_options o =3D { .show_messages =3D -1 };
> @@ -548,6 +564,10 @@ int cmd_merge_tree(int argc, const char **argv, cons=
t char *prefix)
>                            &merge_base,
>                            N_("commit"),
>                            N_("specify a merge-base for the merge")),
> +               OPT_CALLBACK('X', "strategy-option", &xopts,
> +                       N_("option=3Dvalue"),
> +                       N_("option for selected merge strategy"),
> +                       option_parse_x),
>                 OPT_END()
>         };
>
> @@ -556,6 +576,10 @@ int cmd_merge_tree(int argc, const char **argv, cons=
t char *prefix)
>         argc =3D parse_options(argc, argv, prefix, mt_options,
>                              merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTI=
ON);
>
> +       for (int x =3D 0; x < xopts_nr; x++)
> +               if (parse_merge_opt(&o.merge_options, xopts[x]))
> +                       die(_("unknown strategy option: -X%s"), xopts[x])=
;
> +
>         /* Handle --stdin */
>         if (o.use_stdin) {
>                 struct strbuf buf =3D STRBUF_INIT;
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-=
tree.sh
> index 250f721795b..2718817628c 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -22,6 +22,7 @@ test_expect_success setup '
>         git branch side1 &&
>         git branch side2 &&
>         git branch side3 &&
> +       git branch side4 &&
>
>         git checkout side1 &&
>         test_write_lines 1 2 3 4 5 6 >numbers &&
> @@ -46,6 +47,13 @@ test_expect_success setup '
>         test_tick &&
>         git commit -m rename-numbers &&
>
> +       git checkout side4 &&
> +       test_write_lines 0 1 2 3 4 5 >numbers &&
> +       echo yo >greeting &&
> +       git add numbers greeting &&
> +       test_tick &&
> +       git commit -m other-content-modifications &&
> +
>         git switch --orphan unrelated &&
>         >something-else &&
>         git add something-else &&
> @@ -97,6 +105,21 @@ test_expect_success 'Content merge and a few conflict=
s' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'Auto resolve conflicts by "ours" stragety option' '
> +       git checkout side1^0 &&
> +
> +       # make sure merge conflict exists
> +       test_must_fail git merge side4 &&
> +       git merge --abort &&
> +
> +       git merge -X ours side4 &&
> +       git rev-parse HEAD^{tree} > expected &&
> +
> +    git merge-tree -X ours side1 side4 > actual &&
> +
> +       test_cmp expected actual
> +'
> +
>  test_expect_success 'Barf on misspelled option, with exit code other tha=
n 0 or 1' '
>         # Mis-spell with single "s" instead of double "s"
>         test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR=
 side1 side2 2>expect &&
>
> base-commit: ac83bc5054c2ac489166072334b4147ce6d0fccb
> --
> gitgitgadget
