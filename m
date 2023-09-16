Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96549CD37B7
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 08:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjIPIjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 04:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjIPIjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 04:39:16 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0AAE7F
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 01:39:10 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-65637c04014so5721036d6.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 01:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694853550; x=1695458350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQt0TUpy/A6TK1jSOVMz6x30WeRCgdnWycfS8133ftk=;
        b=b2s9x1D/tuXNKlvqSbp6qrQImu6lUF3pleSFBJuHbg7VlgAhuqvdaTIsxHIwqdrvr4
         ydQsTdwebDmxE9/VMEjuHU7J5rqkU9QfYi3N9ABQTc5GXTqYcnFcwbj6tGozALaEZmsq
         TybtGsjZc1aIEs5ZFIvUsmD4rE/HS6xXN14kqd/AUggPU86PJU4vW0bVANXFPlXt8+gU
         feiW8hKj1KyjoqZ3nRIV9IUY2wEAH6VzpFpE0jRpab2LvLLNwPDyT5SK6lA0qcxSS1tW
         Tl3VYUSHMrPGNQAG1aQN2q6FyiGzVO9Zqj8Ysmbk6HwVAnPbRPvmXpHOIA/CBITFHSPn
         f2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694853550; x=1695458350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQt0TUpy/A6TK1jSOVMz6x30WeRCgdnWycfS8133ftk=;
        b=Hr5qgDJi1bD6m9P9aRVfb0F6W+q24DpIdjxf+s8gt8SiL3dlg7s3rlDZUxPxVn7QLJ
         Cna//sLZYUkkaI60cOP7hc/EyLhisi/uX9TmDMMcNwuLvZZ78nI/drkC/uiYqdlnKRzm
         cLVPZVKlsFhvAwchSeSrJU9B11uS6e8x5Q2Z6x+uyyEul1UfQlXXu1XOsw32jHcLLS4Z
         k2zWxzNjyM4QE8kH4ug1a1nrnc4JU7kTG7yLllb3TiIBd2c53YG0hurUv5Ss01q/Cqvq
         FKv4wKwk14HlJDrLnrNgkFDJNpFRLg7BVOPostprU/y3nOJGK5963Jyr2/LRxArhUmS6
         Q9cQ==
X-Gm-Message-State: AOJu0Yx+AMJSXe32ihgAlDmXP4Wtaclw8pSLxtC/eg6bb1aoktSSpnq6
        1k4j9HETzT655eNC+hpqVLh08ofbbuFiRDUZ+rv2tCPE
X-Google-Smtp-Source: AGHT+IFVT4D1/SwmS9bd4PHPN0I3/Px5d6LexFz6584wPS2EqXPEYkljw4ZlqZFEe4ryTAB0pLTjSKZSyyAEwOqarvg=
X-Received: by 2002:a0c:e088:0:b0:647:3387:fe44 with SMTP id
 l8-20020a0ce088000000b006473387fe44mr3558174qvk.5.1694853549615; Sat, 16 Sep
 2023 01:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com> <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
From:   =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>
Date:   Sat, 16 Sep 2023 16:38:58 +0800
Message-ID: <CAFWsj_UhsK=M7ZL5OzP1n4+hPigjJW4wjHqXDcbpneR9cfvNSw@mail.gmail.com>
Subject: Re: [PATCH v5] merge-tree: add -X strategy option
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your advice! I've uploaded new patch.

On Sat, Sep 16, 2023 at 4:37=E2=80=AFPM Izzy via GitGitGadget
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
WingT%2Fmerge_tree_allow_strategy_option-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1565/WingT=
/merge_tree_allow_strategy_option-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1565
>
> Range-diff vs v4:
>
>  1:  d2d8fcc2e9b ! 1:  28d4282e0d8 merge-tree: add -X strategy option
>      @@ Commit message
>
>        ## builtin/merge-tree.c ##
>       @@
>      + #include "quote.h"
>        #include "tree.h"
>        #include "config.h"
>      ++#include "strvec.h"
>
>      -+static const char **xopts;
>      -+static size_t xopts_nr, xopts_alloc;
>        static int line_termination =3D '\n';
>
>      - struct merge_list {
>       @@ builtin/merge-tree.c: struct merge_tree_options {
>         int show_messages;
>         int name_only;
>      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_opt=
ions *o,
>
>         opt.branch1 =3D branch1;
>       @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_op=
tions *o,
>      -  return !result.clean; /* result.clean < 0 handled above */
>      - }
>      -
>      -+static int option_parse_x(const struct option *opt,
>      -+                   const char *arg, int unset)
>      -+{
>      -+ if (unset)
>      -+         return 0;
>      -+
>      -+ ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
>      -+ xopts[xopts_nr++] =3D xstrdup(arg);
>      -+ return 0;
>      -+}
>      -+
>        int cmd_merge_tree(int argc, const char **argv, const char *prefix=
)
>        {
>         struct merge_tree_options o =3D { .show_messages =3D -1 };
>      ++ struct strvec xopts =3D STRVEC_INIT;
>      +  int expected_remaining_argc;
>      +  int original_argc;
>      +  const char *merge_base =3D NULL;
>       @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **=
argv, const char *prefix)
>                            &merge_base,
>                            N_("commit"),
>                            N_("specify a merge-base for the merge")),
>      -+         OPT_CALLBACK('X', "strategy-option", &xopts,
>      -+                 N_("option=3Dvalue"),
>      -+                 N_("option for selected merge strategy"),
>      -+                 option_parse_x),
>      ++         OPT_STRVEC('X', "strategy-option", &xopts, N_("option=3Dv=
alue"),
>      ++                 N_("option for selected merge strategy")),
>                 OPT_END()
>         };
>
>      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **a=
rgv, const char
>         argc =3D parse_options(argc, argv, prefix, mt_options,
>                              merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTI=
ON);
>
>      -+ for (int x =3D 0; x < xopts_nr; x++)
>      -+         if (parse_merge_opt(&o.merge_options, xopts[x]))
>      -+                 die(_("unknown strategy option: -X%s"), xopts[x])=
;
>      ++ for (int x =3D 0; x < xopts.nr; x++)
>      ++         if (parse_merge_opt(&o.merge_options, xopts.v[x]))
>      ++                 die(_("unknown strategy option: -X%s"), xopts.v[x=
]);
>       +
>         /* Handle --stdin */
>         if (o.use_stdin) {
>      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Content me=
rge and a few c
>       + git merge --abort &&
>       +
>       + git merge -X ours side4 &&
>      -+ git rev-parse HEAD^{tree} > expected &&
>      ++ git rev-parse HEAD^{tree} >expected &&
>       +
>      -+    git merge-tree -X ours side1 side4 > actual &&
>      ++ git merge-tree -X ours side1 side4 >actual &&
>       +
>       + test_cmp expected actual
>       +'
>
>
>  builtin/merge-tree.c             | 11 +++++++++++
>  t/t4301-merge-tree-write-tree.sh | 23 +++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 0de42aecf4b..97d0fe6c952 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -18,6 +18,7 @@
>  #include "quote.h"
>  #include "tree.h"
>  #include "config.h"
> +#include "strvec.h"
>
>  static int line_termination =3D '\n';
>
> @@ -414,6 +415,7 @@ struct merge_tree_options {
>         int show_messages;
>         int name_only;
>         int use_stdin;
> +       struct merge_options merge_options;
>  };
>
>  static int real_merge(struct merge_tree_options *o,
> @@ -439,6 +441,8 @@ static int real_merge(struct merge_tree_options *o,
>
>         init_merge_options(&opt, the_repository);
>
> +       opt.recursive_variant =3D o->merge_options.recursive_variant;
> +
>         opt.show_rename_progress =3D 0;
>
>         opt.branch1 =3D branch1;
> @@ -513,6 +517,7 @@ static int real_merge(struct merge_tree_options *o,
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  {
>         struct merge_tree_options o =3D { .show_messages =3D -1 };
> +       struct strvec xopts =3D STRVEC_INIT;
>         int expected_remaining_argc;
>         int original_argc;
>         const char *merge_base =3D NULL;
> @@ -548,6 +553,8 @@ int cmd_merge_tree(int argc, const char **argv, const=
 char *prefix)
>                            &merge_base,
>                            N_("commit"),
>                            N_("specify a merge-base for the merge")),
> +               OPT_STRVEC('X', "strategy-option", &xopts, N_("option=3Dv=
alue"),
> +                       N_("option for selected merge strategy")),
>                 OPT_END()
>         };
>
> @@ -556,6 +563,10 @@ int cmd_merge_tree(int argc, const char **argv, cons=
t char *prefix)
>         argc =3D parse_options(argc, argv, prefix, mt_options,
>                              merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTI=
ON);
>
> +       for (int x =3D 0; x < xopts.nr; x++)
> +               if (parse_merge_opt(&o.merge_options, xopts.v[x]))
> +                       die(_("unknown strategy option: -X%s"), xopts.v[x=
]);
> +
>         /* Handle --stdin */
>         if (o.use_stdin) {
>                 struct strbuf buf =3D STRBUF_INIT;
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-=
tree.sh
> index 250f721795b..b2c8a43fce3 100755
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
> +       git rev-parse HEAD^{tree} >expected &&
> +
> +       git merge-tree -X ours side1 side4 >actual &&
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
