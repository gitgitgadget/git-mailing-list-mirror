Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FC2C10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28B121D56
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8kJMOJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgCJT16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:27:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34000 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgCJT16 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 15:27:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id j16so14374877otl.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6f5eKdpv2Lf3NB/nRy2zgS92h+1oUXv4lN3CRy7jBs=;
        b=l8kJMOJ9o2+insDWlbPqqsIeS5jRgXIyJqkmF1sVUn8Q6OrVhWZEo2qqUXBM2sf9u1
         3OOaaeXLq3NnuCSi12Pw5bBGCslqNE2seLo4Fsdpk8gq60wmL4eDYS60ET6LC9MUIATH
         q3xEfDy8h7aGGTbkIVd3FWk45JMABrYBdkjq1B5OQKibynJW/nSAIc4W5JveVCi/spm4
         xU5YOUayH1Uap3YWs2eV2GYiRMlHzFX7dg8VmDgOOfu7r5Bf94/6cIJFUrYHzSgLaW2k
         G7vXbbI8FqLbCdvO50S60Sq4h7Vpx9rVkorfjWRJt4AkASIWgGssm4MYbt4IoJJJ/qsX
         Ldmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6f5eKdpv2Lf3NB/nRy2zgS92h+1oUXv4lN3CRy7jBs=;
        b=JVJ5UlPmC1662brgtYeh+EYz+F9AFDnVZZs41PSf6QCN5UXMN8s4+wPh/UgiN/nPAo
         iD+pNeDk/Ngb/oNl7NgTB6G8DxWMX98JKmK4V1D4pTQm/X0ZulK6hetYJu1fRuZq0KSl
         S6xuRRXRBw/tbuADWIu2t1zVF/o7lo2xp3QrfPJjQDs9RBlCSjy/1TFmU3TnyEmbMZ4x
         NpUvoSXAXzbLrX8EicHh32+87cCaVO+AWs27paL+jZDi1o9/86QoBObr+kt3EhFxJNY2
         ny918pOhiC8xKXI4+iviMTw+Z1HrSGaAB40a38GT651tmJSWEPVw6D9GHJlHElyII6x8
         CmeQ==
X-Gm-Message-State: ANhLgQ2dA2SUXpzYOG4RLvewYFbzHHY/f2deOb4/MPyzvY9R3gsjj4Yg
        +PBWEDRZabmmXPcm90T2BBz44Akod+IcC+Fltqg=
X-Google-Smtp-Source: ADFU+vt1umAT+r7QxRYHw1GP6qM6lDmWp9xgGNK4cdy9ipnPG1gKDAD8QqmLtG8Y7OQOy7c6TWYz5fmuimk6DOn18zc=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr18489015otl.162.1583868475938;
 Tue, 10 Mar 2020 12:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo8t4z29k.fsf@gitster-ct.c.googlers.com> <20200310174017.GA549010@coredump.intra.peff.net>
 <xmqqwo7shvt2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo7shvt2.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Mar 2020 12:27:50 -0700
Message-ID: <CABPp-BHSOkKOyH3GGs1hVjg1XSJBQfLXN12Wrc4cyEriKeSysA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.26.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 10, 2020 at 12:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > On Tue, Mar 10, 2020 at 07:57:11AM -0700, Junio C Hamano wrote:
> >
> >>  * "git rebase" has learned to use the merge backend (i.e. the
> >>    machinery that drives "rebase -i") by default, while allowing
> >>    "--apply" option to use the "apply" backend (e.g. the moral
> >>    equivalent of "format-patch piped to am").  The rebase.backend
> >>    configuration variable can be set to customize.
> >
> > I noticed a few behavior changes that I think are related to this
> > switch.
> > ...
> > Oops. If I "git rebase --continue" from there, I get "No rebase in
> > progress?". Doing "git cherry-pick --skip" clears it. I guess the issue
> > is the continued presence of .git/CHERRY_PICK_HEAD.
> >
> > As you can see from the output above (and the earlier snippet, if you
> > run it), there are also a bunch of minor stderr output changes. I think
> > these probably aren't worth caring about.
>
> Hmph.  It might have been way premature to switch the default, then.

Or perhaps a bit late in the cycle to do it, yeah.

> Introducing rebase.backend to allow adventurous to opt in early,
> while keeping the default backend same, may not be a bad way to
> avoid the regression in the upcoming release and to give us enough
> time deal with it after the release, perhaps?

Seems reasonable.

> -- >8 --
> Subject: rebase: do not switch the default to 'merge' just yet
>
> Reverts 2ac0d627 (rebase: change the default backend from "am" to
> "merge", 2020-02-15) to postpone the switch of default backend of
> "git rebase" to the merge backend, as there seem to be a few
> remaining bugs (we saw two reported on the day after 2.26-rc1---we
> do not know how many remaining bugs there are) that regresses the
> end user experience.
>
>  * When a rebase stops with a merge conflict, "rebase --continue"
>    after resolving the conflict opens an editor with the merge
>    backend;
>
>  * When a rebase sees a change that is already applied, the end user
>    gets thrown into "cherry-picking" mode, causing "git status" to
>    say "nothing to commit, working tree clean". At that point, "git
>    rebase --continue" does not let the user get out of this state.
>
> Let's keep the default for the upcoming release, without removing
> the configuration variable so that those adventurous can opt into
> using the 'merge' backend to help polishing it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-rebase.txt           | 6 +++---
>  builtin/rebase.c                       | 4 ++--
>  t/t5520-pull.sh                        | 7 +++----
>  t/t9106-git-svn-commit-diff-clobber.sh | 3 +--
>  4 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 8c1f4b8268..58bc556142 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -260,8 +260,7 @@ See also INCOMPATIBLE OPTIONS below.
>
>  --apply:
>         Use applying strategies to rebase (calling `git-am`
> -       internally).  This option may become a no-op in the future
> -       once the merge backend handles everything the apply one does.
> +       internally).  This is the default.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>
> @@ -315,7 +314,8 @@ See also INCOMPATIBLE OPTIONS below.
>  --merge::
>         Use merging strategies to rebase.  When the recursive (default) merge
>         strategy is used, this allows rebase to be aware of renames on the
> -       upstream side.  This is the default.
> +       upstream side.  This may become the default in the future
> +       once known bugs are shaken out of this backend.
>  +
>  Note that a rebase merge works by replaying each commit from the working
>  branch on top of the <upstream> branch.  Because of this, when a merge
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index f3036f40c6..37d2920620 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -100,7 +100,7 @@ struct rebase_options {
>  #define REBASE_OPTIONS_INIT {                          \
>                 .type = REBASE_UNSPECIFIED,             \
>                 .empty = EMPTY_UNSPECIFIED,             \
> -               .default_backend = "merge",             \
> +               .default_backend = "apply",             \
>                 .flags = REBASE_NO_QUIET,               \
>                 .git_am_opts = ARGV_ARRAY_INIT,         \
>                 .git_format_patch_opt = STRBUF_INIT     \
> @@ -1913,7 +1913,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>
>         if (options.type == REBASE_UNSPECIFIED) {
>                 if (!strcmp(options.default_backend, "merge"))
> -                       imply_merge(&options, "--merge");
> +                       options.type = REBASE_MERGE;
>                 else if (!strcmp(options.default_backend, "apply"))
>                         options.type = REBASE_APPLY;
>                 else
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 2f86fca042..e8d28e5e36 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -340,7 +340,7 @@ test_expect_success '--rebase with conflicts shows advice' '
>         test_tick &&
>         git commit -m "Create conflict" seq.txt &&
>         test_must_fail git pull --rebase . seq 2>err >out &&
> -       test_i18ngrep "Resolve all conflicts manually" err
> +       test_i18ngrep "Resolve all conflicts manually" out
>  '
>
>  test_expect_success 'failed --rebase shows advice' '
> @@ -354,7 +354,7 @@ test_expect_success 'failed --rebase shows advice' '
>         git checkout -f -b fails-to-rebase HEAD^ &&
>         test_commit v2-without-cr file "2" file2-lf &&
>         test_must_fail git pull --rebase . diverging 2>err >out &&
> -       test_i18ngrep "Resolve all conflicts manually" err
> +       test_i18ngrep "Resolve all conflicts manually" out
>  '
>
>  test_expect_success '--rebase fails with multiple branches' '
> @@ -774,8 +774,7 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
>         (
>                 cd dst &&
>                 test_must_fail git pull --rebase &&
> -               cat .git/rebase-merge/done .git/rebase-merge/git-rebase-todo >work &&
> -               grep -v -e \# -e ^$ work >patches &&
> +               find .git/rebase-apply -name "000*" >patches &&
>                 test_line_count = 1 patches &&
>                 rm -f work
>         )
> diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
> index aec45bca3b..dbe8deac0d 100755
> --- a/t/t9106-git-svn-commit-diff-clobber.sh
> +++ b/t/t9106-git-svn-commit-diff-clobber.sh
> @@ -92,8 +92,7 @@ test_expect_success 'multiple dcommit from git svn will not clobber svn' "
>
>
>  test_expect_success 'check that rebase really failed' '
> -       git status >output &&
> -       grep currently.rebasing output
> +       test -d .git/rebase-apply
>  '
>
>  test_expect_success 'resolve, continue the rebase and dcommit' "

Looks good to me.  I'll look into the regressions.
