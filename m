Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7112CD37B2
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 03:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjIPD41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 23:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjIPDz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 23:55:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23BB0
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:55:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b974031aeaso45494101fa.0
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694836552; x=1695441352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OUVesfcM21W9bWEWhaQNIWO7bltbGprsMIrAFChJ3M=;
        b=J5n/1eqaT+qAE18QQtpPxaS+kJGB6vFCdux7Zi967lST0CXmuGZteoSiWbRcvg8Iuu
         HWXsZOc3bs5mavtFZDf3C6MuTvyG/wVKxh1LAeij0YouhJ9d5KFjJFqQl7PaSmn+fpSl
         X7ncBOneu4khy047xYU+genycofU1zq5ZQh9RfxILjvMLGyEzqylKCHoz11Y34SrFqIw
         OBy7BU2tfsVnq6UmI2JfkRoXCzXidcp7mddiLRePx6b1RxT/3vYrZ8HuHzg7k4iNHyCp
         7DdYMPxs/zJajNi/0UyREw0rO9KwCOwEc2FEu4lGynwsjqXy3agjRZ8szsARxhyyun09
         NJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694836552; x=1695441352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OUVesfcM21W9bWEWhaQNIWO7bltbGprsMIrAFChJ3M=;
        b=tfPJT9dTjKl051FQhp11xSB6Cz8Z3LAUWX0KQAxyj9ycf8yrf3YPXWoM4rsY2DjhnL
         rVapy4b/+VujZ9JEuZUnLYoD8JyWC2W8/xEevE8WHDRy8pMOdKZHswPH9sBFCiLlPPWD
         1IPFFigVa2r7ICLsWwjgq0vTSDc7Re7wUmPlolgDELhRAlut2bhMl5SQtehs7YGpw+52
         HsnI6m/vrtyPQSrDKlOOfgH4h9EIJH0494e1k9uJG8aVxgOpALNNZ10dqaycnPrBg8Z1
         YAGPvAT7rYRi3o6Nowmct4tSd1msT8opquEGtm/BZG0XQiS+g376h8aSRYRuXXyPV+vJ
         Vh8w==
X-Gm-Message-State: AOJu0YwV1WcmxcTU9o6KA1q4JAAp5CqnVKv87SpatCeKXMit/+KzU9KH
        Dx0BozsH2jft07BfBurVGE/ihAXyy119aNAQ/ZSdhVLholQ=
X-Google-Smtp-Source: AGHT+IECz/+yB99OMOV4B6LY9/Y/3Ax1e9tEbiMMGoOCYDhzY8dP/0ldnI9sg1+76TwXCl1j16KfMJtyrB4nUBRD+mE=
X-Received: by 2002:a2e:a178:0:b0:2ba:6519:c50f with SMTP id
 u24-20020a2ea178000000b002ba6519c50fmr2995304ljl.52.1694836551819; Fri, 15
 Sep 2023 20:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1565.v3.git.1694830462463.gitgitgadget@gmail.com> <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 15 Sep 2023 20:55:38 -0700
Message-ID: <CABPp-BGLdKMLL96XdF2bEppa-jbWFbC4m0AtSHPb-okavj3e=w@mail.gmail.com>
Subject: Re: [PATCH v4] merge-tree: add -X strategy option
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tang Yuyi <winglovet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Sep 15, 2023 at 8:47=E2=80=AFPM Izzy via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tang Yuyi <winglovet@gmail.com>
>
> Add merge strategy option to produce more customizable merge result such
> as automatically resolving conflicts.
>
> Signed-off-by: Tang Yuyi <winglovet@gmail.com>
> ---
>     merge-tree: add -X strategy option
>
>     Change-Id: I16be592262d13cebcff8726eb043f7ecdb313b76
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1565%2F=
WingT%2Fmerge_tree_allow_strategy_option-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1565/WingT=
/merge_tree_allow_strategy_option-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1565
>
> Range-diff vs v3:
>
>  1:  d64a774fa7c ! 1:  d2d8fcc2e9b merge-tree: add -X strategy option
>      @@ Commit message
>           merge-tree: add -X strategy option
>
>           Add merge strategy option to produce more customizable merge re=
sult such
>      -    as automatically solve conflicts.
>      +    as automatically resolving conflicts.

Thanks for fixing this part of what I pointed out in the review.

>           Signed-off-by: Tang Yuyi <winglovet@gmail.com>
>
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

Please fix the problems in these last two lines as pointed out in both
of my last two reviews.
