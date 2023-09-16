Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9865C46CA1
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 04:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjIPEFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 00:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjIPEFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 00:05:10 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CD31BCF
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 21:05:04 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-656351b6d74so6541536d6.0
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 21:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694837103; x=1695441903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lnlfg3THNzMs3CpaiBA+qHuZNV0zUEB80vjnsiV4fc=;
        b=cBFu30Fns2FiRUMVdSV5+TjuzmDHRmd3Upg9F/d1VEdgExqHHVh0dfQ3wPSns9w9/X
         AdammJxNlnFhvyhflSuLaTb5dkIfn+nACWq8NNezMYa+9gzTXgLXLzZG/f6h0R6Fvgsw
         24fdL3PG5VP5btc2r3WT26fhsQSK2z/PxEdkih3ls/Ab6pZPZS03I/lFgQGaGlA3HXbh
         Oo3uxQXjNKLdiDVQJJMvmQoAhozzx3UMMC4YAN7ypourzzCRUr7Q32quO+AuN52833wc
         h5bH9/eVZl9qtkzbMtNofuXbHY8cfp/vYww/Q/xipKO0mupMp3TLYQPz2UuEvFcQN+JL
         gmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694837103; x=1695441903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lnlfg3THNzMs3CpaiBA+qHuZNV0zUEB80vjnsiV4fc=;
        b=onAmzcEt5xBMdITm/YPsHV3bxA4HiAFuEjEJstxoCO52TbvlvTztkO3QAbuNXZaCbE
         cgA+Y02MKDbdDbrk4Y1oafv3b2zhAi0DfHtIzPMelnI7vq81pmLFwePSZeVk6a+cZYSB
         v1DDkgHu9aLxNy85QnhxBaSa1NT3UJ2Rbh7TGQqKgntAAWYX8EfhZM8kOIPoaB1xsv3W
         ZahtQr5d73SqDrZkmD6Evoehh5xxtWa7iCi//PRFYFYQvgjo+Kg0j8rZZf5E2teA1qzY
         MAaQTslOs7rK5XxmGcN/q6ffOEUDUYkNl8+QWMntgASWlILuK06iBXSdhTn0JycSgdH5
         7d8w==
X-Gm-Message-State: AOJu0YylarHglmouobWysiedGx+RRVKvQBoY3JsnQ67ZWe82o1tVHwSj
        uptM4iMsxTNr5q9pnq1eopKLqxwfJRHk4JlSI8lfBh1ip90=
X-Google-Smtp-Source: AGHT+IFU3zfIDJ8GrTQ4yMc/gF4gPDo/7Cs5U6RGhQVdPqVJdXQNIIClhJuYHoLa0/l3IBll+Quf/KgcYj7I+IuTc9Y=
X-Received: by 2002:a0c:e14b:0:b0:64c:1937:716c with SMTP id
 c11-20020a0ce14b000000b0064c1937716cmr3693505qvl.55.1694837103513; Fri, 15
 Sep 2023 21:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1565.v3.git.1694830462463.gitgitgadget@gmail.com> <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com>
From:   =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>
Date:   Sat, 16 Sep 2023 12:04:51 +0800
Message-ID: <CAFWsj_W-p7kqJbCApZXjGv6Ja0xLjdgVZLVhetwLSiZr-sJA8A@mail.gmail.com>
Subject: Re: [PATCH v4] merge-tree: add -X strategy option
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, what we want to do is to compare two patchsets' diff while
providing capabilities like normal commit diff.
The existing range-diff command provide an effective solution, however:
* The output isn't suitable for machine processing
* The command take's number of commits and commit messages into count,
while what we really want is merely the content diff
* The command doesn't support features like word diff, ignoring
whitespace changes, etc
So what comes to our mind is to simulate user behavior. We first merge
the old patchset into the new patchset's base commit, then use the
merge result to diff against the new patchset's source commit.
By doing this, the diff introduced between two patchsets' bases won't
be shown. Thus we get the 'real diff' between two patchsets.
In the first step, we use git-merge-tree to produce the merge result
since its performance's better than git-merge.
However, sometimes there's conflict between the new patchset's base
and the old patchset's source.So we need automatic conflict resolving
- only use content from 'their' side specifically.
Hope that makes sense.

On Sat, Sep 16, 2023 at 11:47=E2=80=AFAM Izzy via GitGitGadget
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
>
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
