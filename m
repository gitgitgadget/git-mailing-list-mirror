Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C51C2018D
	for <e@80x24.org>; Thu, 11 May 2017 18:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933836AbdEKSMy (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 14:12:54 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36112 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933826AbdEKSMx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 14:12:53 -0400
Received: by mail-pg0-f43.google.com with SMTP id 64so18337129pgb.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YDXlmWGlGA99/TLZOEH62AgEOF367KUy5ZAuODsrTyg=;
        b=bSrcA0lMLt5KjIxJV2MFi2L10/NIThmly6lKA8/XjxtWA3ShCW994T2riMSwxkWOJZ
         6UwcO73dHQ2SrGJRlQwOGGjtCQd35pBX7ETNisJzWHu+Yk5tW3/VaqVbFsulhdpWCND7
         q8/bWNYAGsu+2MAlUVoaYj6bR/8FjIIhYqDDuPQ1aCtUwkRYJT5rpx9YoiosJiiWZs0e
         cMYlwWD0dd5D2IhqHkCl+WWyOYNYbsKsb52uxwd0GWTL4jK2lvmIegzyz19eZb5O+q2X
         rOErYVfLPb0lxpqWR1KHQhq87aVaujMcw/sUD5JZ8aS0zv00cCqLqHrzS9jTIiTQV3Fs
         lzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YDXlmWGlGA99/TLZOEH62AgEOF367KUy5ZAuODsrTyg=;
        b=IN8borMcU0FuDQbjdwSnkr6AYn7HNesxPw/W/XSI/89I68o8EC/+PpkqDyWPv5crJa
         x6PN9vGxtioxQ5aVe4OaJQyx4iYHaGGrZlbnXj03cd1IQVHbW5Ahl1xmLrdT0rp7rNWM
         2c2+TcA4BAbExzEYFZ9Z7TRUdbGS28RRzhc1tBhwIcUK5IhazgN73ZPQD1HNVbbijMl6
         lIqDUWf8YNba574YOa0KTZl2ioLsyD9Z9sW/Koucyhr4976DjOD+mXpMkQMrS3YxtumF
         evH09347gMMHK8kt/2/vz5DD4WXaL/UNsL/ICO8ETV2DzJHpMNyd1OwHQX6n+VyNdIwL
         ilPQ==
X-Gm-Message-State: AODbwcBQdjM6GYBCdFAwxZ1/upC36OagTm+kKOmzsXHxIWiPJ++0NsRM
        E5f2JFa12+D133eb8u0//Jp6ZkUxSFeAQA5rCA==
X-Received: by 10.84.248.73 with SMTP id e9mr151027pln.76.1494526372866; Thu,
 11 May 2017 11:12:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 11 May 2017 11:12:52 -0700 (PDT)
In-Reply-To: <20170511172437.96878-1-bmwill@google.com>
References: <20170511172437.96878-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 May 2017 11:12:52 -0700
Message-ID: <CAGZ79kYYX_AMZm7Di8cUA_eiDS+SSAGnJyrDLcC5U7POk7WdSw@mail.gmail.com>
Subject: Re: [PATCH] pull: optionally rebase submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:24 AM, Brandon Williams <bmwill@google.com> wrote:
> Teach pull to optionally update submodules when '--recurse-submodules'
> is provided.  This will teach pull to run 'submodule update --rebase'
> when the '--recurse-submodules' and '--rebase' flags are given.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>
> Pull is already a shortcut for running fetch followed by a merge/rebase, so why
> not have it be a shortcut for running 'submodule update --rebase' when the
> recurse flag is given!

I have not thought about the implications of this shortcut, as opposed to
actually implementing it in C (which presumably would contain more checks).
Will do.

>
>  builtin/pull.c            | 30 ++++++++++++++-
>  t/t5572-pull-submodule.sh | 97 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index dd1a4a94e..d73d654e6 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -77,6 +77,7 @@ static const char * const pull_usage[] = {
>  /* Shared options */
>  static int opt_verbosity;
>  static char *opt_progress;
> +static int recurse_submodules;
>
>  /* Options passed to git-merge or git-rebase */
>  static enum rebase_type opt_rebase = -1;
> @@ -532,6 +533,17 @@ static int pull_into_void(const struct object_id *merge_head,
>         return 0;
>  }
>
> +static int  update_submodules(void)

Maybe s/update_submodules/rebase_submodules/ ?

> +{
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +       cp.git_cmd = 1;
> +
> +       argv_array_pushl(&cp.args, "submodule", "update", "--recursive", NULL);
> +       argv_array_push(&cp.args, "--rebase");

The --rebase could be part of the _pushl ?
Also we could set
    no_stdin = 1
we do need stdout/err though.


> +
> +       return run_command(&cp);
> +}
> +
>  /**
>   * Runs git-merge, returning its exit status.
>   */
> @@ -816,6 +828,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                         oidclr(&rebase_fork_point);
>         }
>
> +       if (opt_recurse_submodules &&
> +           !strcmp(opt_recurse_submodules, "--recurse-submodules")) {

So this checks if we pass --recurse-submodules to fetch and if it is not
a on-demand/no.
Maybe we'd want to use the same infrastructure as fetch does, such that
parse_fetch_recurse makes the decision. (Then "--recurse-submodules=TrUe"
would work as well, IIUC)


> +               recurse_submodules = 1;
> +
> +               if (!opt_rebase)
> +                       die(_("--recurse-submodules is only valid with --rebase"));

I wonder if there are existing users of "git pull --recurse --merge";
as of now this would fetch the submodules (on-demand) and merge
in the local commits of the superprojects. It sounds like a useful workflow
which we'd be blocking here? Maybe just do nothing in case of !opt_rebase,
i.e. make it part of the first condition added in this hunk?

> +               ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> +
> +               if (!ret && recurse_submodules)
> +                       ret = update_submodules();

Instead of doing the rebase of submodules here, we may just want to pass
'recurse_submodules' into run_rebase, which can do it, too. (It already has
a 'ret' value, so the main cmd is not as cluttered.

---
Before reviewing the tests, let's step a bit back and talk about the design
and what is useful to the user. From reading the code, we
  1) perform a fetch in the superproject
  2) rebase the superproject (not rewriting any submodule pointers,
    but that may be ok for now)
  3) sequentially:
  3a) fetch each submodule on demand
  3b) run rebase inside of it.


(A) On the sequence:
If in a normal pull --rebase we have a failure, we can fixup the failure
and then continue via "git rebase --continue"; now if we have a failure
in 3), we would need to fixup the submodule ourselves and then as
we lost all progress in the superproject, rerun "pull --rebase --recurse"?

(B)
As discussed offline this produces bad results if we have a non-ff
operation in the superproject, that also has submodule pointer updates.
So additionally we would need to walk the superprojects local commits
and check if any submodule is touched.


>
> +test_expect_success 'pull --recurse-submodule setup' '
> +       git init child &&

test_create_repo child

> +       (
> +               cd child &&
> +               echo "bar" >file &&
> +               git add file &&
> +               git commit -m "initial commit"

test_create_commit -C child

> +       ) &&
> +       git init parent &&
> +       (
> +               cd parent &&
> +               echo "foo" >file &&
> +               git add file &&
> +               git commit -m "Initial commit" &&
> +               git submodule add ../child sub &&
> +               git commit -m "add submodule"
> +       ) &&

Same setup comment as for the child


> +       git clone --recurse-submodule parent super &&
> +       git -C super/sub checkout master

I wonder if we want to keep these two commands in each test
as I noticed some test scripts are horribly messy others have
a pattern to cleanup after themselves:

test_expect_....
    test_when_finished "rm -rf super-clone" &&
    git clone ... into super-clone



> +'
> +
> +test_expect_success 'pull recursive fails without --rebase' '
> +       test_must_fail git -C super pull --recurse-submodules 2>actual &&
> +       test_i18ngrep "recurse-submodules is only valid with --rebase" actual
> +'

Side note: another place to add tests could be t5520 or t740*.

> +test_expect_success 'pull rebase recursing fails with conflicts' '
> +       git -C super/sub reset --hard HEAD^^ &&
> +       git -C super reset --hard HEAD^ &&
> +       (
> +               cd super/sub &&
> +               echo "b" >file &&
> +               git add file &&
> +               git commit -m "update file"
> +       ) &&
> +       test_must_fail git -C super pull --rebase --recurse-submodules

As discussed above: We'd also want to have a reasonable state here,
or some advice to the user telling them how to recover. Maybe in a
first approach we can tell them to re-run "submodule update --rebase"
after fixing the conflict?

Thanks,
Stefan
