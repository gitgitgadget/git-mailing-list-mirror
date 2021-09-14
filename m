Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CBAC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D57610A6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhINDoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 23:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhINDoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 23:44:01 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591C5C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:42:45 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso16493500otu.0
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSljQ0UmcdLTo3Dfk2MsIbEbOHV5/aYFLvu71tB6zRE=;
        b=jcxQEGM0O82FYRFKOrhJ0HnGSGvj4MdzXkmsXpaM9ce2+DDEcZQOJXVDemytogncmm
         sH38vmDwUr7Ne7nyj+sN5pmFnGTwXu7h4SVixbawKqZE9B23AhPPXCdxffwBu4XDoGli
         0ShHKeLs+wCMq7mUYdGslWaoGwDB7WF2wKa/HRZCoHGKCQCxL0roe1djcq+atIQJIvLX
         pZlJZuUundKLeKHMZIdPXHjZTXNuqj9qwwMYgc0bBi0Mr9Jupf8sKSq6KIxdDBu/saYj
         kpUpSQxfFdpTMF2M6aRj5E3olP4iVoMYiqk/aVNj1OJ8MUmFTCLBl2DuEQBhCNhJA4MN
         UaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSljQ0UmcdLTo3Dfk2MsIbEbOHV5/aYFLvu71tB6zRE=;
        b=cdZjoczP7TBJJd4PqS3KKEBIjp4LclZ9eBjGYgIIp1+XkiApllKX83dG33e5T6pRzF
         FOvX4BCIYvKNUej9XMxSpyIC+3zkDiNx9GjJyIgGAQk7hRKV3rksI++gW+L7kOVRfjnc
         erxmsCFpMs3Si4yktM1erzAO1McQaCjEaJfaSx7YXoycvFm38wQ3qhnVnE4XPETDe+lk
         2/f86gzpY7szyqAUAGwl64XPSChYkGZRvvuG1yksQqTp+LjTtHvMeABeXknEuuGRW1Wb
         bImLp5wioHKGg57jSNVQfqxjdsntOR2U35FXza9i2nG9lzApIP1VaYOy3J97lpoZk8IQ
         svcA==
X-Gm-Message-State: AOAM533BrU39Kxw/2cScnFQk0K0rVGuEq22RTIquCDApg4UgDhnLUsYs
        x/6bP0rrjEtnfKKaWy/CETEYgspL1qKVYILSiqA=
X-Google-Smtp-Source: ABdhPJxFLGEQVW0hfHYG4o/WPb4cWsbn1HYlGOyc+iAssmaACK2+XKzLu3PRg13F/T9WXf+vxglLQ3O3Fd/+mqwnwlU=
X-Received: by 2002:a05:6830:2b24:: with SMTP id l36mr13147602otv.25.1631590964550;
 Mon, 13 Sep 2021 20:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com> <951de6bb1992773cda60791c4b7a09867b5e0f19.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <951de6bb1992773cda60791c4b7a09867b5e0f19.1631546362.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Sep 2021 20:42:33 -0700
Message-ID: <CABPp-BF3BPA77NUyhJ5OGxoBU3=NBD581xWeg0PO1zqV-nkW-A@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] rebase: dereference tags
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 8:47 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Aborting a rebase stated with 'git rebase <upstream> <tag-object>'

s/stated/started/

> should checkout the commit pointed to by <tag-object>. Instead it gives
>
>     error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD':
>     trying to write non-commit object
>     710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'
>
> This is because when we parse the command line arguments although we
> check that the tag points to a commit we remember the oid of the tag
> and try and checkout that object rather than the commit it points
> to. Fix this by using lookup_commit_reference_by_name() when parsing
> the command line.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> ---
>  builtin/rebase.c        | 14 ++++++++------
>  t/t3407-rebase-abort.sh | 18 ++++++++++++++----
>  2 files changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 74663208468..2b70a196f9a 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1903,13 +1903,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                         die_if_checked_out(buf.buf, 1);
>                         options.head_name = xstrdup(buf.buf);
>                 /* If not is it a valid ref (branch or commit)? */
> -               } else if (!get_oid(branch_name, &options.orig_head) &&
> -                          lookup_commit_reference(the_repository,
> -                                                  &options.orig_head))
> +               } else {
> +                       struct commit *commit =
> +                               lookup_commit_reference_by_name(branch_name);
> +                       if (!commit)
> +                               die(_("no such branch/commit '%s'"),
> +                                   branch_name);
> +                       oidcpy(&options.orig_head, &commit->object.oid);
>                         options.head_name = NULL;
> -               else
> -                       die(_("no such branch/commit '%s'"),
> -                           branch_name);
> +               }
>         } else if (argc == 0) {
>                 /* Do not need to switch branches, we are already on it. */
>                 options.head_name =
> diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
> index 162112ba5ea..ebbaed147a6 100755
> --- a/t/t3407-rebase-abort.sh
> +++ b/t/t3407-rebase-abort.sh
> @@ -11,18 +11,18 @@ test_expect_success setup '
>         test_commit a a a &&
>         git branch to-rebase &&
>
> -       test_commit b a b &&
> -       test_commit c a c &&
> +       test_commit --annotate b a b &&
> +       test_commit --annotate c a c &&
>
>         git checkout to-rebase &&
>         test_commit "merge should fail on this" a d d &&
> -       test_commit "merge should fail on this, too" a e pre-rebase
> +       test_commit --annotate "merge should fail on this, too" a e pre-rebase
>  '
>
>  # Check that HEAD is equal to "pre-rebase" and the current branch is
>  # "to-rebase"
>  check_head() {
> -       test_cmp_rev HEAD pre-rebase &&
> +       test_cmp_rev HEAD pre-rebase^{commit} &&
>         test "$(git symbolic-ref HEAD)" = refs/heads/to-rebase
>  }
>
> @@ -67,6 +67,16 @@ testrebase() {
>                 test_path_is_missing "$state_dir"
>         '
>
> +       test_expect_success "rebase$type --abort when checking out a tag" '
> +               test_when_finished "git symbolic-ref HEAD refs/heads/to-rebase" &&
> +               git reset --hard a -- &&
> +               test_must_fail git rebase$type --onto b c pre-rebase &&
> +               test_cmp_rev HEAD b^{commit} &&
> +               git rebase --abort &&
> +               test_cmp_rev HEAD pre-rebase^{commit} &&
> +               ! git symbolic-ref HEAD
> +       '
> +
>         test_expect_success "rebase$type --abort does not update reflog" '
>                 # Clean up the state from the previous one
>                 git reset --hard pre-rebase &&
> --
> gitgitgadget
