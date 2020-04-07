Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7137C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A8C20753
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9gE8tah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgDGPFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:05:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41391 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgDGPFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 11:05:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id f52so3419504otf.8
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E54YoPFtlrwOqrnK7rqePZoUYZ67eklN8VHu6baczXA=;
        b=N9gE8tahHVfzdf9J7LAQjlLLm2qFJf06jSAa4JaZYelgOq0B7SM3osUhU1GTuBqPJ3
         rAmWt5A1u6Dox+GEyBOdoZrI75mpWdULvcNjdao+dqF+a4Kn4k4M9Sunj0/egtP+pDTj
         Zic14KerLvg2mxBmmqZFm9HU1V7vREkMoK3bHiOKI61XWJt+cEsvg2BwayH2g1THgaXe
         19o0JSmbvJWMHaXkxCMdEg3x1/tjgi0OR0mfVVfIc+Khy3yBiSAeuK58/pG4OToxPqv9
         bP4I9XwP652mzE3pB8qvuJZ3Hw1HLE01tmc/2Lf6nNTsWtcq/Avxf2KEoaZgq125rhb9
         wGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E54YoPFtlrwOqrnK7rqePZoUYZ67eklN8VHu6baczXA=;
        b=tyH6D3cVFlsYnVB5p3lC4529LjsIA8dxFPx13nEO6JQs+Df+3jjWmfvEr32up/F54P
         Hp5dxVA+pdsL42XJqNPirdGJ5Vfj327GeOjfuwdqVnhpSWQ02fEpSJkdflPyOmqDCwVo
         y65Y1p/Y6JIEdJgsl44/U40SZl9nxWSQFip5OrhwW8g3J6R9X2xel8EbUsshmvGZM/H3
         HeZdpfvrH8nI9g80vW0QMpXZVQqtdhDVRGdv1Fcidm2FMpSIeth/FJkeexQcGFOgE3Fs
         +ysyMvysCq3Wj40QfFwYwXWZzoEX5s/UrDlYFZgukk1u1jMuZMZxKiy0L+fvdUyILhBl
         crhw==
X-Gm-Message-State: AGi0PuZ5mhoz+czOTxNAYRZRLQ46apOpc/iT/xamCAaqLsD1UrZUpRUl
        DJJtqZ027wk+7FdVPKKOyVp6ZS3LpXVk6ZiUbAw=
X-Google-Smtp-Source: APiQypL5JKofmQRX+YjGBWJyVEGXZ6WEF7iWmZapP4m75iLc0BrY4nGAYZcPZ6qjvRPnGACfj/F3NbyFYRES9F9L+wc=
X-Received: by 2002:a05:6830:2428:: with SMTP id k8mr1993459ots.345.1586271928416;
 Tue, 07 Apr 2020 08:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200407141125.30872-5-phillip.wood123@gmail.com>
In-Reply-To: <20200407141125.30872-5-phillip.wood123@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 08:05:17 -0700
Message-ID: <CABPp-BFu0mgNnxcuZZ_kBJ3WWXxCNSZAFdmq9zKT4H9i47sNsA@mail.gmail.com>
Subject: Re: [PATCH 4/6] rebase -i: fix --committer-date-is-author-date
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Johanathan Nieder reported that `rebase --committer-date-is-author-date`
> failed with the error "invalid date format: @@2592000 +0000" when the
> backend was switched to use the sequencer [1]. This is because when we
> read the date from the author script file is already prefixed by '@' so
> we do not need to add one. This did not show up in our tests
> because once match_object_header_date() fails to match because of the
> extra '@' parse_date_basic() strips the prefix and a date with more than
> 8 digits is parsed as a number of seconds by match_digit().
>
> While fixing this I also noticed that we were not setting
> GIT_COMMITTER_DATE in the environment when forking `git merge`. This was
> untested. The tests we did have used commits where the author date was
> the same as the current value $GIT_COMMITTER_DATE in the environment so
> they did not test that we were actually using the author date when
> creating the commit.
>
> As we have already read GIT_AUTHOR_DATE into cmd.env_array we now use
> that rather than re-reading the author-script file. I've moved the code
> that handles opts->ignore date so that all the code setting the child
> environment is together and changed it so we no longer set
> GIT_COMMITTER_DATE twice when --ignore-date is combined with
> --committer-date-is-author-date.
>
> [1] https://lore.kernel.org/git/<20200110231436.GA24315@google.com>
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c                             | 68 ++++++++++---------------
>  t/t3433-rebase-options-compatibility.sh | 29 +++++++++--
>  2 files changed, 52 insertions(+), 45 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 763ccbbc45..56f6e49289 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -880,17 +880,6 @@ static char *get_author(const char *message)
>         return NULL;
>  }
>
> -/* Returns a "date" string that needs to be free()'d by the caller */
> -static char *read_author_date_or_null(void)
> -{
> -       char *date;
> -
> -       if (read_author_script(rebase_path_author_script(),
> -                              NULL, NULL, &date, 0))
> -               return NULL;
> -       return date;
> -}
> -
>  /* Construct a free()able author string with current time as the author date */
>  static char *ignore_author_date(const char *author)
>  {
> @@ -909,16 +898,20 @@ static char *ignore_author_date(const char *author)
>         return strbuf_detach(&new_author, NULL);
>  }
>
> -static void push_dates(struct child_process *child, int change_committer_date)
> +static const char *author_date_from_env_array(const struct argv_array *env)
>  {
> -       time_t now = time(NULL);
> -       struct strbuf date = STRBUF_INIT;
> +       int i;
> +       const char *date;
>
> -       strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
> -       argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
> -       if (change_committer_date)
> -               argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
> -       strbuf_release(&date);
> +       for (i = 0; i < env->argc; i++)
> +               if (skip_prefix(env->argv[i],
> +                               "GIT_AUTHOR_DATE=", &date))
> +                       return date;

Is there any risk that GIT_AUTHOR_DATE=<somedate> will appear twice in
@child->env_array ?  If there is, should we read through the whole
list to make sure we take the last one?

> +       /*
> +        * If GIT_AUTHOR_DATE is missing we should have already errored out when
> +        * reading the script
> +        */
> +       BUG("GIT_AUTHOR_DATE missing from author script");
>  }
>
>  static const char staged_changes_advice[] =
> @@ -980,31 +973,19 @@ static int run_git_commit(struct repository *r,
>
>         cmd.git_cmd = 1;
>
> -       if (opts->committer_date_is_author_date) {
> -               int res = -1;
> -               struct strbuf datebuf = STRBUF_INIT;
> -               char *date = read_author_date_or_null();
> -
> -               if (!date)
> -                       return -1;
> -
> -               strbuf_addf(&datebuf, "@%s", date);
> -               res = setenv("GIT_COMMITTER_DATE",
> -                            opts->ignore_date ? "" : datebuf.buf, 1);
> -
> -               strbuf_release(&datebuf);
> -               free(date);
> -
> -               if (res)
> -                       return -1;
> -       }
> -
>         if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
>                 const char *gpg_opt = gpg_sign_opt_quoted(opts);
>
>                 return error(_(staged_changes_advice),
>                              gpg_opt, gpg_opt);
>         }
> +       if (opts->committer_date_is_author_date)
> +               argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
> +                                opts->ignore_date ?
> +                                "" :
> +                                author_date_from_env_array(&cmd.env_array));
> +       if (opts->ignore_date)
> +               argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
>
>         argv_array_push(&cmd.args, "commit");
>
> @@ -1014,8 +995,6 @@ static int run_git_commit(struct repository *r,
>                 argv_array_push(&cmd.args, "--amend");
>         if (opts->gpg_sign)
>                 argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> -       if (opts->ignore_date)
> -               push_dates(&cmd, opts->committer_date_is_author_date);
>         if (defmsg)
>                 argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>         else if (!(flags & EDIT_MSG))
> @@ -3615,6 +3594,13 @@ static int do_merge(struct repository *r,
>                         ret = error(_(staged_changes_advice), gpg_opt, gpg_opt);
>                         goto leave_merge;
>                 }
> +               if (opts->committer_date_is_author_date)
> +                       argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
> +                                        opts->ignore_date ?
> +                                        "" :
> +                                        author_date_from_env_array(&cmd.env_array));
> +               if (opts->ignore_date)
> +                       argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
>
>                 cmd.git_cmd = 1;
>                 argv_array_push(&cmd.args, "merge");
> @@ -3635,8 +3621,6 @@ static int do_merge(struct repository *r,
>                 argv_array_push(&cmd.args, git_path_merge_msg(r));
>                 if (opts->gpg_sign)
>                         argv_array_push(&cmd.args, opts->gpg_sign);
> -               if (opts->ignore_date)
> -                       push_dates(&cmd, opts->committer_date_is_author_date);
>
>                 /* Add the tips to be merged */
>                 for (j = to_merge; j; j = j->next)
> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> index 132f577fc9..8247d01442 100755
> --- a/t/t3433-rebase-options-compatibility.sh
> +++ b/t/t3433-rebase-options-compatibility.sh
> @@ -71,15 +71,15 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
>  '
>
>  test_expect_success '--committer-date-is-author-date works with am backend' '
> -       git commit --amend &&
> +       GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>         git rebase --committer-date-is-author-date HEAD^ &&
>         git log -1 --pretty="format:%ai" >authortime &&
>         git log -1 --pretty="format:%ci" >committertime &&
>         test_cmp authortime committertime
>  '
>
>  test_expect_success '--committer-date-is-author-date works with interactive backend' '
> -       git commit --amend &&
> +       GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>         git rebase -i --committer-date-is-author-date HEAD^ &&
>         git log -1 --pretty="format:%ai" >authortime &&
>         git log -1 --pretty="format:%ci" >committertime &&
> @@ -88,13 +88,36 @@ test_expect_success '--committer-date-is-author-date works with interactive back
>
>  test_expect_success '--committer-date-is-author-date works with rebase -r' '
>         git checkout side &&
> -       git merge --no-ff commit3 &&
> +       GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
>         git rebase -r --root --committer-date-is-author-date &&
>         git log --pretty="format:%ai" >authortime &&
>         git log --pretty="format:%ci" >committertime &&
>         test_cmp authortime committertime
>  '
>
> +test_expect_success '--committer-date-is-author-date works when forking merge' '
> +       git checkout side &&
> +       GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
> +       git rebase -r --root --strategy=resolve --committer-date-is-author-date &&
> +       git log --pretty="format:%ai" >authortime &&
> +       git log --pretty="format:%ci" >committertime &&
> +       test_cmp authortime committertime
> +
> +'
> +
> +test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
> +       git checkout commit2 &&
> +       GIT_AUTHOR_DATE="@1980 +0000" git commit --amend --only --reset-author &&
> +       git log -1 --format=%at HEAD >expect &&
> +       test_must_fail git rebase -i --committer-date-is-author-date \
> +               --onto HEAD^^ HEAD^ &&
> +       echo resolved > foo &&
> +       git add foo &&
> +       git rebase --continue &&
> +       git log -1 --format=%ct HEAD >actual &&
> +       test_cmp expect actual
> +'
> +
>  # Checking for +0000 in author time is enough since default
>  # timezone is UTC, but the timezone used while committing
>  # sets to +0530.
> --
> 2.26.0
>
