Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F895CD37B0
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 02:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbjIPC1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 22:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbjIPC1K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 22:27:10 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D91BF2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 19:27:01 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a81154c5f5so1675892b6e.1
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 19:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694831221; x=1695436021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL8TFfbwDJcZQveWOOEcOZpuNPT32LnQLk8iHljdv6Y=;
        b=ZtVe8CvUJr22YIpJpFROdmerWIbB18WhryswdyYvSDpnv21fCQ+jWmVrVAkp3WrOJ4
         iodOq6DD9M0mLBwUI7VMNxcMgkbPdRJl52E/qUBESdV8NbHeK+lxfQRTRLzkXgXm3HQR
         yjs0f9kanhqhKLCaMuMnREsQ4PpVuHwiObAV15xGEUnrS2f0SitIUGK+vVJF0+/TqO+y
         1Q3AY9v4v0Rs08D4a4Ly2HHJU3sYOukcFrTPkF0rXDMYEZBr9x0s9wszEyTe1Zs5+m6y
         8hYEnje2V1l1psgGNKWRZujSO9dc9Vy51qi270pQ0awNZ7CdpqEMpUP6L7M1QKIJM+bh
         f1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694831221; x=1695436021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL8TFfbwDJcZQveWOOEcOZpuNPT32LnQLk8iHljdv6Y=;
        b=Uc6NtvZmLTbnjj8OaFtKxgjBqPtSoLxik0e+wExrFlpwYQ2pQ1LhEDovmewoZPo728
         XzcsOJqZ0Vt9woi347SRQJu7ecHaQUt6KEaR7dvKPuUvuhIjDz9ASnKWyLXv/fDI/VW/
         UNyQ8Oqe/GR4jVtuN8dRSyqNQQJYZAZJYetFbIUqwGlTGBVFn0/+M4mGwHMxn2yYvTDM
         exila4l88U8oNQKDrhB3ef5NVo7XNidBV3MHvXqFUw9tBTkiZy9ViHg4gh4+PManFiEo
         ieE10+QaZ8YUI8jO28VWFrI0KIh+KGISOiBNC++hQqmIdJXsv3aRj6rgQPK0cfSZFmWf
         y5iw==
X-Gm-Message-State: AOJu0YxFOqx7LlPwkqChC5gRbJkaJYDprx0w7czDIDC9VpsgTISwzlJp
        QDbqD9NMVWPaxcc/Rje6ZKIF5YpXURFtNfpD1gSlZbLj
X-Google-Smtp-Source: AGHT+IHz/qTPQWwBav8ON5pmSQyZ1fAadJ9MvYQLQteXAV0JBuxQEflXG4+KuAU3z7z3YxCMwJCAEmRiyjN6thlBz2c=
X-Received: by 2002:a05:6808:64c:b0:3a7:36f9:51aa with SMTP id
 z12-20020a056808064c00b003a736f951aamr2949557oih.17.1694831220852; Fri, 15
 Sep 2023 19:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1565.v2.git.1691818386345.gitgitgadget@gmail.com> <pull.1565.v3.git.1694830462463.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v3.git.1694830462463.gitgitgadget@gmail.com>
From:   =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>
Date:   Sat, 16 Sep 2023 10:26:49 +0800
Message-ID: <CAFWsj_UeK-5uyCtBfLYeRZXRMdAD_eFassxEo6FvgeVzmwqLNQ@mail.gmail.com>
Subject: Re: [PATCH v3] merge-tree: add -X strategy option
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your advice!
I've fixed those blocking issues.
However, regarding the global variable issue, I'm not familiar with C
and git code and don't know how to solve this. I think perhaps we need
something like closure to parse opt into a local variable?
Our usecase is to achieve something like 'range-diff', we first use
merge-tree to merge new patchset's base commit with old patchset's
source commit, then use the merge result to diff against new
patchset's source commit. So we only need to make sure conflict's are
handled automatically, leaving other diff features to the second step.


On Sat, Sep 16, 2023 at 10:14=E2=80=AFAM Izzy via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tang Yuyi <winglovet@gmail.com>
>
> Add merge strategy option to produce more customizable merge result such
> as automatically solve conflicts.
>
> Signed-off-by: Tang Yuyi <winglovet@gmail.com>
> ---
>     merge-tree: add -X strategy option
>
>     Change-Id: I16be592262d13cebcff8726eb043f7ecdb313b76
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1565%2F=
WingT%2Fmerge_tree_allow_strategy_option-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1565/WingT=
/merge_tree_allow_strategy_option-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1565
>
> Range-diff vs v2:
>
>  1:  7d53d08381e ! 1:  d64a774fa7c merge-tree: add -X strategy option
>      @@
>        ## Metadata ##
>      -Author: winglovet <winglovet@gmail.com>
>      +Author: Tang Yuyi <winglovet@gmail.com>
>
>        ## Commit message ##
>           merge-tree: add -X strategy option
>      @@ Commit message
>           Add merge strategy option to produce more customizable merge re=
sult such
>           as automatically solve conflicts.
>
>      -    Signed-off-by: winglovet <winglovet@gmail.com>
>      +    Signed-off-by: Tang Yuyi <winglovet@gmail.com>
>
>        ## builtin/merge-tree.c ##
>       @@
>      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Content me=
rge and a few c
>         test_cmp expect actual
>        '
>
>      -+test_expect_success 'Auto resolve conflicts by "ours" stragety opt=
ion' '
>      ++test_expect_success 'Auto resolve conflicts by "ours" strategy opt=
ion' '
>       + git checkout side1^0 &&
>       +
>       + # make sure merge conflict exists
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
> index 250f721795b..4125bb101ec 100755
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
> +test_expect_success 'Auto resolve conflicts by "ours" strategy option' '
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
