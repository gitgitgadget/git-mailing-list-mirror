Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42A61F42D
	for <e@80x24.org>; Tue, 27 Mar 2018 09:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeC0JEV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 05:04:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35576 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeC0JES (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 05:04:18 -0400
Received: by mail-qt0-f195.google.com with SMTP id s2so22934203qti.2
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 02:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DpMjF1BeJlBEBaY22C9IOu4n9a8yQXjbTf/QKooMswM=;
        b=WbWjJjiTcjcVHUp/SlZIQJPEhJ7+ZPQd835VNyK6J6j7Pg4QRijrB4FTdDKtCWNs7W
         t5rUfLFGP4OONmDcFzgvRxCKLgx+35V4+eu22FBOv+rhV8e7XjdmsbU1nvj5xClQUeCO
         87WmFfvZrRN+9oTYJG+GiAOQu+Mg9wUNcUs5B/u2aSlElkckzlvAQ4IcJTTQ7QZIiEJ/
         hjIexKE0oqGRN8gEqoR7oFjMbc9G6aEDI5kM0v8M1wrIhYXuxKxdXsaB7bH/zNOKAoV+
         NrJmuH+z6c/MRXf1b8s8Eh3BE0WmMAHlgXdQa9/nPzpl9o8ZvGU+Iq3zqmqJSp8RDWQT
         C3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DpMjF1BeJlBEBaY22C9IOu4n9a8yQXjbTf/QKooMswM=;
        b=QfdlfTezdyUBg2S9CUdEpeFGnLz1fosQLCMg26j4Mh7mux1TbSBSGvRzDNrYKgqhFv
         L2h7g0LvVitEZhc7M77VY3mnavHdgCzHXjLyc4Dk7PtdAwotbsQLg8frSq1OD6VXVXBT
         8ppgziuUBRY3bdC39XgbkZCzDNKNr7aeJRsNXLBzOzgryDgBpR3F44RvYA7yW63LYAXv
         ljLUhS4ZZNTP52yd3ndR5Ph27wnIuz+Vv0lr2LyDrWtQcZzG7hhGh7Va0PaumNatDA8s
         BkSGAm9IaRrCcwwohmxIqyVcgCd3Zw9RkPZVgammdWM218tQeO+Eg2hrIA5wW6Fu+r5a
         cC+Q==
X-Gm-Message-State: AElRT7EXQmSsSh276sthSNhfiAN2vdevtLkJQoPU+7T1OzeVAnr46pAR
        x+0sZrxjgL4l7dVR3gZ2TmB5pEvIh1bPWyQSGdI=
X-Google-Smtp-Source: AIpwx4/fATXukoOSAu5vIUZRpWNf0qwOWP0yAC4PNgfJe9zrN7/OkU9CyJRDRCQgfGvyMt7WykE4fLu58KZRGbwz4Vs=
X-Received: by 10.200.69.131 with SMTP id l3mr5005822qtn.50.1522141457239;
 Tue, 27 Mar 2018 02:04:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 27 Mar 2018 02:04:16 -0700 (PDT)
In-Reply-To: <20180325134947.25828-6-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com> <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180325134947.25828-6-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Mar 2018 05:04:16 -0400
X-Google-Sender-Auth: mc-kGL1L-C0RlviXFzHFnRjNMdM
Message-ID: <CAPig+cTmGvkGkcdH45mRO6uwEK2UyR1FQ_fiD=2wgz8Pt_WeOg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 9:49 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently 'git worktree add <path>' creates a new branch named after the
> basename of the path by default.  If a branch with that name already
> exists, the command refuses to do anything, unless the '--force' option
> is given.
>
> However we can do a little better than that, and check the branch out if
> it is not checked out anywhere else.  This will help users who just want
> to check an existing branch out into a new worktree, and save a few
> keystrokes.
> [...]
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -317,7 +318,10 @@ static int add_worktree(const char *path, const char *refname,
> -       if (opts->new_branch)
> +       if (opts->checkout_existing_branch)
> +               fprintf_ln(stderr, _("checking out branch '%s'"),
> +                          refname);

This fprintf_ln() can easily fit on one line; no need to wrap
'refname' to the next one.

Not worth a re-roll, though.

> +       else if (opts->new_branch)
>                 fprintf_ln(stderr, _("creating branch '%s'"), opts->new_branch);
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> @@ -198,13 +198,26 @@ test_expect_success '"add" with <branch> omitted' '
> -test_expect_success '"add" auto-vivify does not clobber existing branch' '
> +test_expect_success '"add" checks out existing branch of dwimd name' '
>         test_commit c1 &&
>         test_commit c2 &&
>         git branch precious HEAD~1 &&
> -       test_must_fail git worktree add precious &&
> +       git worktree add precious &&
>         test_cmp_rev HEAD~1 precious &&
> -       test_path_is_missing precious
> +       (
> +               cd precious &&
> +               test_cmp_rev precious HEAD
> +       )
> +'

Looking at this more closely, once it stops being a "don't clobber
precious branch" test, it's doing more than it needs to do, thus is
confusing for future readers. The setup -- creating two commits and
making "precious" point one commit back -- was very intentional and
allowed the test to verify not only that the worktree wasn't created
but that "precious" didn't change to reference a different commit.
However, _none_ of this matters once it becomes a dwim'ing test; the
unnecessary code is confusing since it doesn't make sense in the
context of dwim'ing. I _think_ the entire test can collapse to:

    git branch existing &&
    git worktree add existing &&
    (
        cd existing &&
        test_cmp_rev existing HEAD
    )

In other words, this patch should drop the "precious" test altogether
and just introduce a new dwim'ing test (and drop patch 6/6).

I do think that with the potential confusion to future readers, this
does deserve a re-roll.

> +test_expect_success '"add" auto-vivify fails with checked out branch' '
> +       git checkout -b test-branch &&
> +       test_must_fail git worktree add test-branch &&
> +       test_path_is_missing test-branch
> +'
> +
> +test_expect_success '"add --force" with existing dwimd name doesnt die' '
> +       git worktree add --force test-branch
>  '
