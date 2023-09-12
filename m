Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817DFCA0EF1
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 15:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbjILPDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 11:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbjILPDb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 11:03:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71FA1BB
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 08:03:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-502a4f33440so6318664e87.1
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694531005; x=1695135805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=donhvWbH5+iHVEUu/AUeAoccYr68Xcr7/z4fNTRPmBU=;
        b=riyjJmG+dc1egYElLa/ZiQxlPpRtT0o/KittWT6ujAGT8algoD4CvX6ak1t9t7mB2e
         C4cQAGTlxWeimmQojIFH0SJp+Z8kpmmi1vOtMvvWjJSzsQjAHvrP23eokXmhfy8thrjX
         GRyOOD5+0cNpBPWfqE23zwaTU5rEQvQqFePBtXdzn655xLet8Kh5D7ZWh6D2OGlC/NYf
         aR6SSEHjqaODBDJQba2igGbIyaJV2hSttkjl966bOqf8R0TFfj/40o7qAMJsWM6WYjak
         NJDEZ/IyP9exgmeBAAtSoPpahf2z0zJCtnFiI02dWTttQTsqUT+gj8xhIeddBDp1nbzF
         Dr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531005; x=1695135805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=donhvWbH5+iHVEUu/AUeAoccYr68Xcr7/z4fNTRPmBU=;
        b=a0jnbFUjaI6vi9SoeuukZCMzgfVQFxjgRNF/6WIZ6Ejovhqv+hloo6K0IXh9RYYwRh
         19uwn9VHYZmZjIaO9Iq/HZTTKYfjNBybvjLsH7HLgsgWus92ZXQHvLI9JtzUnpBhseek
         BVL7Wdg02azPM6AebQY97vfBgOMqPhBXBuq3cO4amL4YtvmAzOUraZIC7DsRIl78U5r8
         san4qrShBDm1uCtn7N8+iHDmBR4fYiGEc9G4eGp9jJw+i/Ev2k26QizhHBQAStNwP02v
         NumV6HGBM6Q2jy6wBoijV6uGOxxOASJ8bN6znTqdnsz5P/Y+VPKpmk/J6VAofPfB1FkD
         NoYw==
X-Gm-Message-State: AOJu0YyhqBeo0CT2FrS31ZJYlw7Z9+z7DZSZQetPqH9N1t86udkOVDns
        8lX8wxib6NPUBb0XgHZtQwkLFtTjYfmqMDELWy80ZbniHJM=
X-Google-Smtp-Source: AGHT+IGP8tUi86LKz+ookSHe2mbatXbKrTa4B8QQxkHwiPQkyyH0hAA/wzjU7T7XtnvzKWPQHrUMMv0ydhWREPevfnk=
X-Received: by 2002:a19:7b1b:0:b0:4fe:3a57:7c98 with SMTP id
 w27-20020a197b1b000000b004fe3a577c98mr6877783lfc.32.1694531004461; Tue, 12
 Sep 2023 08:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1565.git.1691245481977.gitgitgadget@gmail.com> <pull.1565.v2.git.1691818386345.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v2.git.1691818386345.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 Sep 2023 08:03:11 -0700
Message-ID: <CABPp-BG+MxZukNagJD90GgTOh1Te8Dk3pk86DOhSpxasAJViFQ@mail.gmail.com>
Subject: Re: [PATCH v2] merge-tree: add -X strategy option
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, winglovet <winglovet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for the delay in responding; I've been busy with non-git things...

On Sat, Aug 12, 2023 at 12:19=E2=80=AFAM Izzy via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: winglovet <winglovet@gmail.com>
>
> Add merge strategy option to produce more customizable merge result such
> as automatically solve conflicts.
>
> Signed-off-by: winglovet <winglovet@gmail.com>

Junio already flagged this line in your v1; you either need to correct
it or respond to his comments about it.

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

I know we already have lots of globals, and I'm partially to blame
since I also copied this style from elsewhere into this file, but it'd
sure be nice to get rid of these needless globals rather than add
more.  But, certainly not a blocker....

>  static int line_termination =3D '\n';
>
>  struct merge_list {
> @@ -414,6 +416,7 @@ struct merge_tree_options {
>         int show_messages;
>         int name_only;
>         int use_stdin;
> +       struct merge_options merge_options;
>  };

Probably the best we can do now, but feels a little icky to me that
parse_merge_opt() works on all of struct merge_options rather than
having a dedicated struct for the particular options it can set.  Made
sense back in the merge-recursive.[ch] days, but it provides too many
extra unrelated and unnecessary fields now.

This isn't something you need to fix in this patch, though, just
something else I'll keep in mind when I get back to working on
removing merge-recursive.[ch].

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

stragety -> strategy

> +       git checkout side1^0 &&
> +
> +       # make sure merge conflict exists
> +       test_must_fail git merge side4 &&
> +       git merge --abort &&
> +
> +       git merge -X ours side4 &&
> +       git rev-parse HEAD^{tree} > expected &&

Style: '>filename', not '> filename'.

> +
> +    git merge-tree -X ours side1 side4 > actual &&

Same style issue with redirect.

Also, why is the leading spacing inconsistent with the surrounding lines?

> +
> +       test_cmp expected actual
> +'
> +
>  test_expect_success 'Barf on misspelled option, with exit code other tha=
n 0 or 1' '
>         # Mis-spell with single "s" instead of double "s"
>         test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR=
 side1 side2 2>expect &&

I personally don't see the value in passing `-X ours` or `-X theirs`
to merges.  I've never really been a fan of either.  Granted, I
understand the value in making merge-tree support the same things that
existing merges support, so I'm fine with supporting it, but I'd
rather have a useful example for the testcase such as
-Xignore-space-change or something (or maybe use it as an additional
example?)  Not a blocker on its own, but just a personal preference.

Anyway, the general direction of the patch seems reasonable.  Not
everything I commented on needs to be fixed, as I noted, but there are
a few small things to fix up.
