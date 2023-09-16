Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3418DCD37B0
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 03:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjIPDRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 23:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjIPDQz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 23:16:55 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5B119E
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:16:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-503012f4e71so282596e87.0
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694834208; x=1695439008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Qqo+/pQN9J68q6O8ahPJrnY8uGp8nr6Q+auGxMvRNQ=;
        b=FgfKm066bI1zpZKgaBjhVYzOknsNHHQReC/3kUg7oR3P34q69NNcMaG9k9DNb4mVRf
         0decdWaEeMiXfjY3GTZXSpw9Rj1bvqGSTadbFEd2H//VlRv0DWl8G3oEoGjPo8uqw1XI
         ZUYBcjEDA3Xbo8Y/FAr4DPmKUJY6gqC1/S4tk/U/1je0kEJu2XlSTIbDe/cGe35oT1Dn
         p3VTLRyuSU82SnpfQ1yUPxg/UcTs9U8sUEtny/DTt/S7wRgndh9IflrYbAhc3Zh6D/6t
         Iyxc3iTctPcJuSYL6CwlHKFKRTcqitXSbr8Df6wLTJ0mOXw/oTW6EK7fnxfNlF+s8AVG
         aeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694834208; x=1695439008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Qqo+/pQN9J68q6O8ahPJrnY8uGp8nr6Q+auGxMvRNQ=;
        b=coNs5ghlUmmcwrqkaZ4Zp4ScKa6dVT3btTJDkGqzhRQE6Uay/F+OlLHAmF7t4OYkE7
         pkEK6BIIQrugI2FEZUjY6Pz4/lvAtuCzwpnJkIdIYv3XQV/oofoZ3iTqUZIowc5fdZX0
         sNayWbjmPeD1rDSRkmKf/ej1pWoSGSKV8gFmz9At9YFNdo1qVTYxz25B8XpMvAj/t+Tq
         RiI7erPs2Ly1KQwuCtp2EohKIEnHDJo8+SDZYE+LXkj4WBXQ8lwGFjPjlXXouczpZuDp
         Jt5pulUgKH2bZFSCiBBvAMk8xUxEATn9i1/jPPtfN9HoKx/dFmi08yrIGBJ95SGxsIj4
         937w==
X-Gm-Message-State: AOJu0Yz9iXtg4anaHKk9AcJfZVhopbJobF2LdrtKYBw+JjZgmsUuaKRS
        e0Q/tG0oc6hb6bIulWAK6bBAOd3Dg+TZEK0RxcZEjoX3y0c=
X-Google-Smtp-Source: AGHT+IGq5l2wD3b8cjSOBJi4IbGDl5xdkDO+9PbEOl8xC6fyYujNPhPjeKHDkpwPi5KcrkaIPGUKxWqLe8IhqMDkE7M=
X-Received: by 2002:a05:6512:2396:b0:500:bf44:b2b3 with SMTP id
 c22-20020a056512239600b00500bf44b2b3mr1529799lfv.21.1694834207559; Fri, 15
 Sep 2023 20:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1565.v2.git.1691818386345.gitgitgadget@gmail.com> <pull.1565.v3.git.1694830462463.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v3.git.1694830462463.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 15 Sep 2023 20:16:00 -0700
Message-ID: <CABPp-BGo2UUJKm39Ljs+-Usf1F02sTej3phr84i8wiUSf_FB=Q@mail.gmail.com>
Subject: Re: [PATCH v3] merge-tree: add -X strategy option
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Tang Yuyi <winglovet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Sep 15, 2023 at 7:14=E2=80=AFPM Izzy via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tang Yuyi <winglovet@gmail.com>
>
> Add merge strategy option to produce more customizable merge result such
> as automatically solve conflicts.

s/solve/resolving/

I think "solve" should be "solving" here, except that "solve" isn't
really the right word.  It's not solving (figuring out) anything, it's
using a big hammer to make the problem just go away.  So, I think
"resolving" is a better choice.

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

Multiple style problems still here from V2:
  * There should be no space between the redirection operator ('>')
and the filename following it.
  * You have indented most lines with tabs, but the line just above
this one with 4 spaces.


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
