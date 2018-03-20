Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194EA1F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 08:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeCTICx (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 04:02:53 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42449 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeCTICr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 04:02:47 -0400
Received: by mail-qk0-f195.google.com with SMTP id b198so668100qkg.9
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 01:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=q9HHExAOHklqwcdVQriG4Wl7ouDbadSV3t4Pehvs9xc=;
        b=MUlbVIHvjbXXrwSxsPxwc9qAFJ3BmbtEx8X8RuFdh0IAYfxdzVkxetaJ8L+vUmcvq9
         EIvIr1CvybNwioIs7zPyeTe+qZUbrAl0J6EGmpbcKz93A0w+xMDI5oeYconfd87Tgarx
         5LnEoaeFfrwWin/565G9DQsE+qVsUPPjqVm5B7q1eHK1/TaccZLnVVs/rWQ51Cg8Vavm
         cgFRBsaT3yWvXQZpsS5SguBpe+XSRxt69lY/fdMc1LaKVm1ARD2rIpYPudLcmIdK8uTn
         ndFsULAL0Ykmdtc9M/O3RSoXK4z3CXtGTS1CLkBZ7XGs/cebtaBct4WzK88gST7hggVJ
         5g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=q9HHExAOHklqwcdVQriG4Wl7ouDbadSV3t4Pehvs9xc=;
        b=t/jqVgAugHZd07H+bSInhxHPQhbUfQXegPQfRl+qbX3TRUDKNM2RINwNn4nNKe0vL4
         shx60eZPy3yQhHJbBTScj7z06+vD6Itu9/ie5PDXoLVaoTH6tnuy01MaiX3/XoZMtoxQ
         ESUErkTuvGGrTDcBpf9XbUlFdgOlR2IFyEIa6by+BlbNraZwLKGbvyCSr/p9aex18iDi
         983WCBob31zBV66cx7la+1ckEgyO8HAJ8i77zH4RFu4GiJDz12Aq3aDSd39ivAwB7p1L
         /FItYWRrqMMz+tJrm6H9NtAa2ercwvilkE9+T7PiQKu3ag0pFnD91ZVYfT0y2owqFDs8
         9+IQ==
X-Gm-Message-State: AElRT7G8wzaPQ3O5qHKPwcMcI3cSX3GE28aQIhVDxaWkl2P5u6HD0bI/
        QDVw39EWGKterOgv82F1MJkZVRhvkaJBtsAswlU=
X-Google-Smtp-Source: AG47ELtBwWwdP2eIA/bmyVJJykSsxGYLzDa3wdXjIYcdHe17PqTXdGzX7rMV4NWsL585Ex71Ex99EIbfkKM9VKSNUZo=
X-Received: by 10.55.159.140 with SMTP id i134mr18841797qke.220.1521532966039;
 Tue, 20 Mar 2018 01:02:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Tue, 20 Mar 2018 01:02:45 -0700 (PDT)
In-Reply-To: <20180317222219.4940-5-t.gummerer@gmail.com>
References: <20180317220830.30963-1-t.gummerer@gmail.com> <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180317222219.4940-5-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Mar 2018 04:02:45 -0400
X-Google-Sender-Auth: RcaOv2tOgKR4uWUcawf2_4o9q9U
Message-ID: <CAPig+cToFeHniMmqhx8HZrtrzqyht=1a2zbx1yQar=WVt2yF1g@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 6:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> [...]
> However we can do a little better than that, and check the branch out if
> it is not checked out anywhere else.  This will help users who just want
> to check an existing branch out into a new worktree, and save a few
> keystrokes.
> [...]
> We will still 'die()' if the branch is checked out in another worktree,
> unless the --force flag is passed.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -61,8 +61,13 @@ $ git worktree add --track -b <branch> <path> <remote>/<branch>
>  If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
> -then, as a convenience, a new branch based at HEAD is created automatically,
> -as if `-b $(basename <path>)` was specified.
> +then, as a convenience, a worktree with a branch named after
> +`$(basename <path>)` (call it `<branch>`) is created.  If `<branch>`
> +doesn't exist, a new branch based on HEAD is automatically created as
> +if `-b <branch>` was given.  If `<branch>` exists in the repository,
> +it will be checked out in the new worktree, if it's not checked out
> +anywhere else, otherwise the command will refuse to create the
> +worktree.

Should this mention --force?

    ... refuse to create the worktree (unless --force is used).

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -29,6 +29,7 @@ struct add_opts {
>         int keep_locked;
>         const char *new_branch;
>         int force_new_branch;
> +       int checkout_existing_branch;

As 'force_new_branch' and 'checkout_existing_branch' are mutually
exclusive, I wonder if they should be combined into an enum to make it
easier to reason about.

> @@ -318,8 +319,11 @@ static int add_worktree(const char *path, const char *refname,
> -       if (opts->new_branch)
> -               fprintf(stderr, _("creating new branch '%s'"), opts->new_branch);
> +       if (opts->checkout_existing_branch)
> +               fprintf(stderr, _("checking out branch '%s'"),
> +                       refname);

As with "creating branch" in 2/4, "checking out branch..." here is
missing a newline.

> +       else if (opts->new_branch)
> +               fprintf(stderr, _("creating branch '%s'"), opts->new_branch);
>
>         fprintf(stderr, _("worktree HEAD is now at %s"),
>                 find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> @@ -198,13 +198,22 @@ test_expect_success '"add" with <branch> omitted' '
> -test_expect_success '"add" auto-vivify does not clobber existing branch' '
> +test_expect_success '"add" auto-vivify checks out existing branch' '
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

This test is no longer checking auto-vivification ("bringing a new
branch to life automatically"), but rather branch name inference, so
the title is now misleading. Perhaps retitle it to '"add" checks out
existing branch of dwim'd name' or something.

(The name "precious" is also now misleading since it's no longer
checking that a precious branch does not get clobbered, however,
changing the name would make the diff unnecessarily noisy, so it's
probably okay as is.)

> +test_expect_success '"add" auto-vivify fails with checked out branch' '
> +       git checkout -b test-branch &&
> +       test_must_fail git worktree add test-branch &&
> +       test_path_is_missing test-branch
>  '

Should we also have a corresponding test that this "fail" can be
overridden by --force? (I realize that --force is tested elsewhere,
but only with an explicitly-provided branch name, whereas this dwims
the branch name.)
