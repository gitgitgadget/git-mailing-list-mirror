Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81252C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 03:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5357D205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 03:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBVmhQbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEMDy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 23:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725898AbgEMDy5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 23:54:57 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8822C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 20:54:55 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id t3so3182259oou.8
        for <git@vger.kernel.org>; Tue, 12 May 2020 20:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhnOD/5UpjgdUn3WFC2fmwm0Bxe+sJModsTswde1/Yc=;
        b=VBVmhQbrFh5VDCU9YlVZlWPUvBNHbMRHGpFi2VdRjrK+b5bqmbahbPUllaTTbDf0+i
         TYRPNXGndoA0Ek9wwI3w7Vxdtq4C+QLL5SYFnuPLvRe2lHXLsg8s//ncUC8vgHjD0p+b
         L19uxU+hyZBzOadAOCA/WSff02Ds0SSbMPrNrxvzVWXiVxfzXs5glfpYEwbqfRYU406t
         MmHmByO0rcnF1KXFDLCFQAHOANY6gEaRw5N01zSl7U8LoPXTpJcNmjEsvL8tnnK7fUIv
         IXG1dBOjw9nN+h6+Uv0aFgHfPZiu4mvZOwQ31UOQD05IDxEVWjg57AJYiB2fez06eQsY
         nFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhnOD/5UpjgdUn3WFC2fmwm0Bxe+sJModsTswde1/Yc=;
        b=Tjyk6lmT5QH0UGQIYKDYKYg141hItqhjtkpoO1sL2hvvy/wudEslcWCHQaCZELYmb6
         Yxr7BvjIl/L8mC733td14IFWPWx2qw+8s77SNk81AwcRYs4Bfbq2iuTQIEMm/cuz3T1l
         O0Kz7Bz7U09B1w1BdDGfbNl180jgrm84OQGkQjzNDC7v+fWV8X2GQ02TXPFPNJ13xqDY
         7HAI2r74rh0hJPImLdBjxfWcTOuOL7J+vbRWA66jfaKtnEGeYjSJjA1H8auZQHqjDwnu
         j9A6W5wg3EXxkXIyGCQZRcym3pbE1NSg60lwhwOm4O35N5MFXr+qwnEhNGNT6YLfuVx8
         R3XQ==
X-Gm-Message-State: AGi0PuZP0HzywT3WpgmKuBPKIixyl4u38hGZlsXXhazPI6FCj9xVGzVQ
        JoocbZUdClFa14ogUwwGYaACrSII2TM3Mw/8hZ0=
X-Google-Smtp-Source: APiQypJ+ZdSJfymg2h0X3ugscx8WoWxZPiBIPlY9SPK/s8Bfs8V3G9Q3dCOgUHckVJ/Cgtw7PgBYlY6guZpoal3ee6w=
X-Received: by 2002:a4a:a11d:: with SMTP id i29mr12205740ool.7.1589342094446;
 Tue, 12 May 2020 20:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200429102521.47995-1-phillip.wood123@gmail.com> <20200429102521.47995-2-phillip.wood123@gmail.com>
In-Reply-To: <20200429102521.47995-2-phillip.wood123@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 May 2020 20:54:43 -0700
Message-ID: <CABPp-BG+nWR9S9fw=_0XV8GA5JRAKaL2TZUU578PQkW8f_z7ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rebase -i: add --ignore-whitespace flag
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for taking so long to get back to you, and thanks for pushing
this forward.

On Wed, Apr 29, 2020 at 3:26 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>
> Rebase is implemented with two different backends - 'apply' and 'merge'
> each of which support a different set of options. In particuar the apply
> backend supports a number of options implemented by 'git am' that are
> not available to the merge backend. As part of an on going effort to
> remove the apply backend this patch adds support for the
> --ignore-whitespace option to the merge backend. This option treats
> lines with only whitespace changes as unchanged and is implemented in
> the merge backend by translating it to -Xignore-space-change.
>
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-rebase.txt           | 12 +++-
>  builtin/rebase.c                       | 19 ++++--
>  t/t3422-rebase-incompatible-options.sh |  1 -
>  t/t3436-rebase-more-options.sh         | 86 ++++++++++++++++++++++++++
>  4 files changed, 111 insertions(+), 7 deletions(-)
>  create mode 100755 t/t3436-rebase-more-options.sh
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f7a6033607..d060c143e6 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -422,8 +422,16 @@ your branch contains commits which were dropped, this option can be used
>  with `--keep-base` in order to drop those commits from your branch.
>
>  --ignore-whitespace::
> +       Behaves differently depending on which backend is selected.

I still don't like this wording; it defers answering the question,
implies that the difference is intentional, and most importantly
provides no context about *intended* behavior.  I tried to communicate
this to Rohit multiple times, but he seemed to fixate on and highlight
the differences in a way that made them sound like they were by
design, rather than highlighting the intent we want to move towards
and mentioning that this patch gets us most the way there.

As far as I can tell, the --ignore-whitespace and
-Xignore-space-change were always meant to do the same thing: ignore
differences in whitespace when doing so can avoid conflicts.

In case anyone isn't sure about my assertion that these were always
meant to do the same thing:
  * apply aliases --ignore-whitespace and --ignore-space-change; they
meant the same thing
  * commit f008cef4ab ("Merge branch 'jc/apply-ignore-whitespace'",
2014-06-03) says that apply's --ignore-space-change wasn't behaving
consistently with diff's --ignore-space-change
  * diff's --ignore-space-change goes through xdiff's XDL opts, much
like merge-recursive does.
Further, the original commit that introduced these xdiff options to
merge-recursive, 4e5dd044c6 ("merge-recursive: options to ignore
whitespace changes", 2010-08-26), it is clear that:
  * he only cared about ignore-space-at-eol and implemented
ignore-space-change at the same time only for completeness
  * it wouldn't matter to his usecase if whitespace-only changes were
stripped, thus he wouldn't have spotted the bug it has
  * the wording also suggests these options were picked to match
options of the same name elsewhere in git

I would rather we said something like:
    Ignore whitespace differences when trying to reconcile
differences.  Currently, each backend implements an approximation of
this behavior:

> ++
> +apply backend: When applying a patch, ignore changes in whitespace in
> +context lines.

Maybe add something like:
    (Unfortunately, this means that if the "old" lines being replaced
by the patch differ only in whitespace from the existing file, you
will get a merge conflict instead of a successful patch application.)

> ++
> +merge backend: Treat lines with only whitespace changes as unchanged
> +when merging.

Maybe add something like:
   (Unfortunately, this means that any patch hunks that were intended
to modify whitespace and nothing else will be dropped, even if the
other side had no changes that conflicted.)

> +
>  --whitespace=<option>::
> -       These flags are passed to the 'git apply' program
> +       This flag is passed to the 'git apply' program
>         (see linkgit:git-apply[1]) that applies the patch.
>         Implies --apply.
>  +
> @@ -572,7 +580,6 @@ The following options:
>   * --apply
>   * --committer-date-is-author-date
>   * --ignore-date
> - * --ignore-whitespace
>   * --whitespace
>   * -C
>
> @@ -598,6 +605,7 @@ In addition, the following pairs of options are incompatible:
>   * --preserve-merges and --signoff
>   * --preserve-merges and --rebase-merges
>   * --preserve-merges and --empty=
> + * --preserve-merges and --ignore-whitespace
>   * --keep-base and --onto
>   * --keep-base and --root
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 27a07d4e78..5d8e117276 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -86,6 +86,7 @@ struct rebase_options {
>         int signoff;
>         int allow_rerere_autoupdate;
>         int autosquash;
> +       int ignore_whitespace;
>         char *gpg_sign_opt;
>         int autostash;
>         char *cmd;
> @@ -108,6 +109,7 @@ struct rebase_options {
>
>  static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>  {
> +       struct strbuf strategy_buf = STRBUF_INIT;
>         struct replay_opts replay = REPLAY_OPTS_INIT;
>
>         replay.action = REPLAY_INTERACTIVE_REBASE;
> @@ -126,14 +128,20 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>         replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>         replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>         replay.strategy = opts->strategy;
> +
>         if (opts->strategy_opts)
> -               parse_strategy_opts(&replay, opts->strategy_opts);
> +               strbuf_addstr(&strategy_buf, opts->strategy_opts);
> +       if (opts->ignore_whitespace)
> +               strbuf_addstr(&strategy_buf, " --ignore-space-change");
> +       if (strategy_buf.len)
> +               parse_strategy_opts(&replay, strategy_buf.buf);
>
>         if (opts->squash_onto) {
>                 oidcpy(&replay.squash_onto, opts->squash_onto);
>                 replay.have_squash_onto = 1;
>         }
>
> +       strbuf_release(&strategy_buf);
>         return replay;
>  }
>
> @@ -539,6 +547,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, options,
>                         builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
>
> +       opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
> +
>         if (!is_null_oid(&squash_onto))
>                 opts.squash_onto = &squash_onto;
>
> @@ -991,6 +1001,8 @@ static int run_am(struct rebase_options *opts)
>         am.git_cmd = 1;
>         argv_array_push(&am.args, "am");
>
> +       if (opts->ignore_whitespace)
> +               argv_array_push(&am.args, "--ignore-whitespace");
>         if (opts->action && !strcmp("continue", opts->action)) {
>                 argv_array_push(&am.args, "--resolved");
>                 argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> @@ -1495,16 +1507,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                         PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>                 OPT_BOOL(0, "signoff", &options.signoff,
>                          N_("add a Signed-off-by: line to each commit")),
> -               OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
> -                                 NULL, N_("passed to 'git am'"),
> -                                 PARSE_OPT_NOARG),
>                 OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
>                                   &options.git_am_opts, NULL,
>                                   N_("passed to 'git am'"), PARSE_OPT_NOARG),
>                 OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
>                                   N_("passed to 'git am'"), PARSE_OPT_NOARG),
>                 OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>                                   N_("passed to 'git apply'"), 0),
> +               OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
> +                        N_("ignore changes in whitespace")),
>                 OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
>                                   N_("action"), N_("passed to 'git apply'"), 0),
>                 OPT_BIT('f', "force-rebase", &options.flags,
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index 50e7960702..55ca46786d 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>  }
>
>  test_rebase_am_only --whitespace=fix
> -test_rebase_am_only --ignore-whitespace
>  test_rebase_am_only --committer-date-is-author-date
>  test_rebase_am_only -C4
>
> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
> new file mode 100755
> index 0000000000..fb5e747e86
> --- /dev/null
> +++ b/t/t3436-rebase-more-options.sh
> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2019 Rohit Ashiwal
> +#
> +
> +test_description='tests to ensure compatibility between am and interactive backends'
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +# This is a special case in which both am and interactive backends
> +# provide the same output. It was done intentionally because
> +# both the backends fall short of optimal behaviour.
> +test_expect_success 'setup' '
> +       git checkout -b topic &&
> +       q_to_tab >file <<-\EOF &&
> +       line 1
> +       Qline 2
> +       line 3
> +       EOF
> +       git add file &&
> +       git commit -m "add file" &&
> +       cat >file <<-\EOF &&
> +       line 1
> +       new line 2
> +       line 3
> +       EOF
> +       git commit -am "update file" &&
> +       git tag side &&
> +
> +       git checkout --orphan master &&
> +       sed -e "s/^|//" >file <<-\EOF &&
> +       |line 1
> +       |        line 2
> +       |line 3
> +       EOF
> +       git add file &&
> +       git commit -m "add file" &&
> +       git tag main
> +'
> +
> +test_expect_success '--ignore-whitespace works with apply backend' '
> +       cat >expect <<-\EOF &&
> +       line 1
> +       new line 2
> +       line 3
> +       EOF
> +       test_must_fail git rebase --apply main side &&
> +       git rebase --abort &&
> +       git rebase --apply --ignore-whitespace main side &&
> +       test_cmp expect file
> +'
> +
> +test_expect_success '--ignore-whitespace works with merge backend' '
> +       cat >expect <<-\EOF &&
> +       line 1
> +       new line 2
> +       line 3
> +       EOF
> +       test_must_fail git rebase --merge main side &&
> +       git rebase --abort &&
> +       git rebase --merge --ignore-whitespace main side &&
> +       test_cmp expect file
> +'
> +
> +test_expect_success '--ignore-whitespace is remembered when continuing' '
> +       cat >expect <<-\EOF &&
> +       line 1
> +       new line 2
> +       line 3
> +       EOF
> +       (
> +               set_fake_editor &&
> +               FAKE_LINES="break 1" git rebase -i --ignore-whitespace main side
> +       ) &&
> +       git rebase --continue &&
> +       test_cmp expect file
> +'
> +
> +# This must be the last test in this file
> +test_expect_success '$EDITOR and friends are unchanged' '
> +       test_editor_unchanged
> +'
> +
> +test_done
> --
> 2.26.2

The rest looks good to me.
