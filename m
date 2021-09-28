Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B6EC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E9360F4F
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbhI1AbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbhI1AbU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 20:31:20 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D766C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 17:29:42 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id e19-20020a4a7353000000b002b5a2c0d2b8so2299236oof.3
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 17:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ig6/9lmSYNpy9hHNGnR9zU6DAsu0nVZlVzI+KCoeI4o=;
        b=c+huVYpC0RVD4+KCnH/4IjTWTT2Il0fxK6Xytyn7hnUOXhzNvtYOKReLA6QyBhSbSt
         gsGzgYB0D3eDeoUBJoiE97UyY5xmr/W9z8YAZ65aGPg60nhnjfX79t6Pi+OyOLYeUNsZ
         W1GTjbZ5icv2X3Fjoc99BjYAIIR6yMGV3qJnNJDZKhxLS9VtnLr3NL+p3gpYYL6nIYRj
         sak8844JOgaOpuPR4g75MLBwsBptTNrqk6N+q9VgPcxDjkFEQjg43HRHfXZtb3LkGA9K
         /bJs8/55KtM0QriBRYjpDzAo8XGIH3/GjrotYTSyuRIHtkr6IvXbR8uCfXYSLV9CwexG
         nm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ig6/9lmSYNpy9hHNGnR9zU6DAsu0nVZlVzI+KCoeI4o=;
        b=ZeB/5cpsW4CZODnQ2TXWIHGV1NPl7It29D6ITLWVyyPEKr0cMqfJnUDdL564mhBXCj
         a3oAjAvx8f3mlzoFu4VxBYz6uu04Kzmyctd+h4SL4pGSX9P79lms+HYgAPqv/cfe46A7
         B42JDuHDJDuDvPhtqEh0W0KWI5yg7IYt1WiFuAI3pQOmaU8Ho0q3WKPoUpWrdqeGWj6Q
         jWmwt373DBH1FY+r6kk8Ogl2h6ORA/h4NI0YARZ4nAR/42WUpXylaBCrxL7yRQIl04pi
         kHRsk6HCgIH38yxzp2CjFSLCJB/FbGo9ADFD3BOSyYlmZQ5Y28T+D1q+Ts9SRKxJ8Jw7
         /45w==
X-Gm-Message-State: AOAM53056S9HGanKHxsrCKFyvIhJs2jwHlf+MGGHze+tzHJjZ1lKf5RJ
        riiVyB+K4JotCoILRlLdeKtDdhQO8AaCjOkT8y7QnyLePc8=
X-Google-Smtp-Source: ABdhPJy0nY8d6DW0ykj583J824BLg7+nFvlJlrL4gKEWjKQXnDgz6LvwalbFYzYjqyD6LOza7S5da3jlPb+t2Oj/bI4=
X-Received: by 2002:a4a:c18d:: with SMTP id w13mr2405815oop.15.1632788981298;
 Mon, 27 Sep 2021 17:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <0655a321bd9630736d6853437cc8d11a5cd012b6.1632242495.git.jonathantanmy@google.com>
In-Reply-To: <0655a321bd9630736d6853437cc8d11a5cd012b6.1632242495.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Sep 2021 17:29:29 -0700
Message-ID: <CABPp-BHRxwd7V81xB4djrvxnpO2YrKqZDTEoUJOJ-3zsJMkiDA@mail.gmail.com>
Subject: Re: [PATCH 5/9] merge-{ort,recursive}: remove add_submodule_odb()
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 9:52 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> After the parent commit and some of its ancestors, the only place
> commits are being accessed through alternates are in the user-facing

s/are in/is in/, since "place" is singular? ("the only place...is in
the user-facing")

> message formatting code. Fix those, and remove the add_submodule_odb()
> calls.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  merge-ort.c                | 18 ++++-------------
>  merge-recursive.c          | 41 +++++++++++++++++++-------------------
>  strbuf.c                   | 12 ++++++++---
>  strbuf.h                   |  6 ++++--
>  t/t6437-submodule-merge.sh |  3 +++
>  5 files changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index b8efaee8e0..a4aad8f33f 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -628,6 +628,7 @@ static int err(struct merge_options *opt, const char *err, ...)
>
>  static void format_commit(struct strbuf *sb,
>                           int indent,
> +                         struct repository *repo,
>                           struct commit *commit)
>  {
>         struct merge_remote_desc *desc;
> @@ -641,7 +642,7 @@ static void format_commit(struct strbuf *sb,
>                 return;
>         }
>
> -       format_commit_message(commit, "%h %s", sb, &ctx);
> +       repo_format_commit_message(repo, commit, "%h %s", sb, &ctx);
>         strbuf_addch(sb, '\n');
>  }
>
> @@ -1566,17 +1567,6 @@ static int merge_submodule(struct merge_options *opt,
>         if (is_null_oid(b))
>                 return 0;
>
> -       /*
> -        * NEEDSWORK: Remove this when all submodule object accesses are
> -        * through explicitly specified repositores.

This removes a typo too.  :-)

> -        */
> -       if (add_submodule_odb(path)) {
> -               path_msg(opt, path, 0,
> -                        _("Failed to merge submodule %s (not checked out)"),
> -                        path);
> -               return 0;
> -       }
> -
>         if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
>                 path_msg(opt, path, 0,
>                                 _("Failed to merge submodule %s (not checked out)"),
> @@ -1641,7 +1631,7 @@ static int merge_submodule(struct merge_options *opt,
>                 break;
>
>         case 1:
> -               format_commit(&sb, 4,
> +               format_commit(&sb, 4, &subrepo,
>                               (struct commit *)merges.objects[0].item);
>                 path_msg(opt, path, 0,
>                          _("Failed to merge submodule %s, but a possible merge "
> @@ -1658,7 +1648,7 @@ static int merge_submodule(struct merge_options *opt,
>                 break;
>         default:
>                 for (i = 0; i < merges.nr; i++)
> -                       format_commit(&sb, 4,
> +                       format_commit(&sb, 4, &subrepo,
>                                       (struct commit *)merges.objects[i].item);
>                 path_msg(opt, path, 0,
>                          _("Failed to merge submodule %s, but multiple "
> diff --git a/merge-recursive.c b/merge-recursive.c
> index fc8ac39d8c..6e8fb39315 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -337,7 +337,9 @@ static void output(struct merge_options *opt, int v, const char *fmt, ...)
>                 flush_output(opt);
>  }
>
> -static void output_commit_title(struct merge_options *opt, struct commit *commit)
> +static void repo_output_commit_title(struct merge_options *opt,
> +                                    struct repository *repo,
> +                                    struct commit *commit)
>  {
>         struct merge_remote_desc *desc;
>
> @@ -346,23 +348,29 @@ static void output_commit_title(struct merge_options *opt, struct commit *commit
>         if (desc)
>                 strbuf_addf(&opt->obuf, "virtual %s\n", desc->name);
>         else {
> -               strbuf_add_unique_abbrev(&opt->obuf, &commit->object.oid,
> -                                        DEFAULT_ABBREV);
> +               strbuf_repo_add_unique_abbrev(&opt->obuf, repo,
> +                                             &commit->object.oid,
> +                                             DEFAULT_ABBREV);
>                 strbuf_addch(&opt->obuf, ' ');
> -               if (parse_commit(commit) != 0)
> +               if (repo_parse_commit(repo, commit) != 0)
>                         strbuf_addstr(&opt->obuf, _("(bad commit)\n"));
>                 else {
>                         const char *title;
> -                       const char *msg = get_commit_buffer(commit, NULL);
> +                       const char *msg = repo_get_commit_buffer(repo, commit, NULL);
>                         int len = find_commit_subject(msg, &title);
>                         if (len)
>                                 strbuf_addf(&opt->obuf, "%.*s\n", len, title);
> -                       unuse_commit_buffer(commit, msg);
> +                       repo_unuse_commit_buffer(repo, commit, msg);
>                 }
>         }
>         flush_output(opt);
>  }
>
> +static void output_commit_title(struct merge_options *opt, struct commit *commit)
> +{
> +       repo_output_commit_title(opt, the_repository, commit);
> +}
> +
>  static int add_cacheinfo(struct merge_options *opt,
>                          const struct diff_filespec *blob,
>                          const char *path, int stage, int refresh, int options)
> @@ -1152,14 +1160,14 @@ static int find_first_merges(struct repository *repo,
>         return result->nr;
>  }
>
> -static void print_commit(struct commit *commit)
> +static void print_commit(struct repository *repo, struct commit *commit)
>  {
>         struct strbuf sb = STRBUF_INIT;
>         struct pretty_print_context ctx = {0};
>         ctx.date_mode.type = DATE_NORMAL;
>         /* FIXME: Merge this with output_commit_title() */
>         assert(!merge_remote_util(commit));
> -       format_commit_message(commit, " %h: %m %s", &sb, &ctx);
> +       repo_format_commit_message(repo, commit, " %h: %m %s", &sb, &ctx);
>         fprintf(stderr, "%s\n", sb.buf);
>         strbuf_release(&sb);
>  }
> @@ -1199,15 +1207,6 @@ static int merge_submodule(struct merge_options *opt,
>         if (is_null_oid(b))
>                 return 0;
>
> -       /*
> -        * NEEDSWORK: Remove this when all submodule object accesses are
> -        * through explicitly specified repositores.
> -        */
> -       if (add_submodule_odb(path)) {
> -               output(opt, 1, _("Failed to merge submodule %s (not checked out)"), path);
> -               return 0;
> -       }
> -
>         if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
>                 output(opt, 1, _("Failed to merge submodule %s (not checked out)"), path);
>                 return 0;
> @@ -1232,7 +1231,7 @@ static int merge_submodule(struct merge_options *opt,
>                 oidcpy(result, b);
>                 if (show(opt, 3)) {
>                         output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
> -                       output_commit_title(opt, commit_b);
> +                       repo_output_commit_title(opt, &subrepo, commit_b);
>                 } else if (show(opt, 2))
>                         output(opt, 2, _("Fast-forwarding submodule %s"), path);
>                 else
> @@ -1245,7 +1244,7 @@ static int merge_submodule(struct merge_options *opt,
>                 oidcpy(result, a);
>                 if (show(opt, 3)) {
>                         output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
> -                       output_commit_title(opt, commit_a);
> +                       repo_output_commit_title(opt, &subrepo, commit_a);
>                 } else if (show(opt, 2))
>                         output(opt, 2, _("Fast-forwarding submodule %s"), path);
>                 else
> @@ -1277,7 +1276,7 @@ static int merge_submodule(struct merge_options *opt,
>         case 1:
>                 output(opt, 1, _("Failed to merge submodule %s (not fast-forward)"), path);
>                 output(opt, 2, _("Found a possible merge resolution for the submodule:\n"));
> -               print_commit((struct commit *) merges.objects[0].item);
> +               print_commit(&subrepo, (struct commit *) merges.objects[0].item);
>                 output(opt, 2, _(
>                        "If this is correct simply add it to the index "
>                        "for example\n"
> @@ -1290,7 +1289,7 @@ static int merge_submodule(struct merge_options *opt,
>         default:
>                 output(opt, 1, _("Failed to merge submodule %s (multiple merges found)"), path);
>                 for (i = 0; i < merges.nr; i++)
> -                       print_commit((struct commit *) merges.objects[i].item);
> +                       print_commit(&subrepo, (struct commit *) merges.objects[i].item);
>         }
>
>         object_array_clear(&merges);
> diff --git a/strbuf.c b/strbuf.c
> index c8a5789694..b22e981655 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1059,15 +1059,21 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
>         strbuf_setlen(sb, sb->len + len);
>  }
>
> -void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
> -                             int abbrev_len)
> +void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
> +                                  const struct object_id *oid, int abbrev_len)
>  {
>         int r;
>         strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
> -       r = find_unique_abbrev_r(sb->buf + sb->len, oid, abbrev_len);
> +       r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
>         strbuf_setlen(sb, sb->len + r);
>  }
>
> +void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
> +                             int abbrev_len)
> +{
> +       strbuf_repo_add_unique_abbrev(sb, the_repository, oid, abbrev_len);
> +}
> +
>  /*
>   * Returns the length of a line, without trailing spaces.
>   *
> diff --git a/strbuf.h b/strbuf.h
> index 5b1113abf8..2d9e01c16f 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -634,8 +634,10 @@ void strbuf_list_free(struct strbuf **list);
>   * Add the abbreviation, as generated by find_unique_abbrev, of `sha1` to
>   * the strbuf `sb`.
>   */
> -void strbuf_add_unique_abbrev(struct strbuf *sb,
> -                             const struct object_id *oid,
> +struct repository;
> +void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
> +                                  const struct object_id *oid, int abbrev_len);
> +void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
>                               int abbrev_len);
>
>  /**
> diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> index e5e89c2045..178413c22f 100755
> --- a/t/t6437-submodule-merge.sh
> +++ b/t/t6437-submodule-merge.sh
> @@ -5,6 +5,9 @@ test_description='merging with submodules'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
> +export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
> +
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-merge.sh
>
> --
> 2.33.0.464.g1972c5931b-goog

Modulo the minor grammar error in the commit message; this looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>
