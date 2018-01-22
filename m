Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94E91F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbeAVLT3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:19:29 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41222 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeAVLT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:19:28 -0500
Received: by mail-ot0-f194.google.com with SMTP id 44so7124026otk.8
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6H6v/KEuvQLZONHfaOT703KLvLu25pNrxy6SN0Qhspw=;
        b=P4zReA+69DZLV1pR5k5xjQ6UElJppFT3sJRDp9t2w9v7kgtk3RYfUN5NAN3kLJ6biM
         QMjvouBfoMMHiPwl+gi6O8bp66en9M5QFchzaZNjUlG+8A1Q9pOf4C2E95zGYOyABRM7
         GSQ6foUHMxKsu+KehPiG+Vln1uc9mlpRxDHmYMUUbRu7A1uzrItfUlRljAeqoFlbd2OA
         aByy65WJFYG9HPgvC6Kt570JCdl4LXmcxsimYTvsbDYXMKgot7SuA1BMay02RS+wfWLi
         0MyFpS/seBsGPSI73eneY4AXoFp3Wsh8p5IjCGYVfJpVldMAoKqniLwekFgftYxg6TIX
         q9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6H6v/KEuvQLZONHfaOT703KLvLu25pNrxy6SN0Qhspw=;
        b=pq3Ad5ZwMAWPREzCMYiWeWEbkUQmru6dzHEYHewXETHUktc6YBQ5zfSQeqbHN0jBfC
         cr4VvfdSK55A6mgy6WqAlEFMJMTBh6TYqCyr8Uml8VVSvWYfwK7VRtitACtsd0wyLdtY
         zi6QErptwr4DeHhZ3IgtWKyMEKNBfHNqK3lAs3cdmMq4KC0iys3iSciS14IXHo7tgPuP
         3eevltudicsi/anxPdxbyTEHzQ7BxbjAfWBPAjaZQwisgSu+EJY96yuUw0cD/nDVVpXM
         X3QAQqlSo0kru8dcK8G3UB4PkQKr3WqDtK/oUzrtipMgjcSdLtowISncGHnFIVbGgiQC
         97PA==
X-Gm-Message-State: AKwxytf5QgEVceVc7IoWw2fucjGalFEy+uwJliSNuyCh3Rc9DjdZxwq7
        nXuOW1qgARiBfF/j6OV3+8IxYeLY9dajG6PoGVTQow==
X-Google-Smtp-Source: AH8x227P2aJAjh+U+wzmqGNKn6RkNQ4a0pmNkophOuJPBLB3tsEHro7MI4ogvnmoAjxn2W/LRLthl8UUEKZbzo6Gmrc=
X-Received: by 10.157.53.12 with SMTP id o12mr3833501otc.181.1516619968040;
 Mon, 22 Jan 2018 03:19:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.27.3 with HTTP; Mon, 22 Jan 2018 03:18:57 -0800 (PST)
In-Reply-To: <20180121120208.12760-1-t.gummerer@gmail.com>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Jan 2018 18:18:57 +0700
Message-ID: <CACsJy8D9LS7e=cVE3Fq2qOnxK5++nFg2vjuhkNtRO-Bx0X1j6w@mail.gmail.com>
Subject: Re: [PATCH] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 21, 2018 at 7:02 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently 'git worktree add <path>' creates a new branch named after the
> basename of the path by default.  If a branch with that name already
> exists, the command refuses to do anything, unless the '--force' option
> is given.
>
> However we can do a little better than that, and check the branch out if
> it is not checked out anywhere else.  This will help users who just want
> to check an existing branch out into a new worktree, and save a few
> keystrokes.
>
> As the current behaviour is to simply 'die()' when a brach with the name
> of the basename of the path already exists, there are no backwards
> compatibility worries here.
>
> We will still 'die()' if the branch is checked out in another worktree,
> unless the --force flag is passed.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> This is a follow-up to
> https://public-inbox.org/git/20171118181345.GC32324@hank/, where this
> was first suggested, but I didn't want to do it as part of that
> series.  Now I finally got around to implementing it.
>
>  Documentation/git-worktree.txt |  9 +++++++--
>  builtin/worktree.c             | 22 +++++++++++++++-------
>  t/t2025-worktree-add.sh        | 15 ++++++++++++---
>  3 files changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 41585f535d..98731b71a7 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -61,8 +61,13 @@ $ git worktree add --track -b <branch> <path> <remote>/<branch>
>  ------------
>  +
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

It starts getting a bit too magical to me. We probably should print
something "switching to branch..." or "creating new branch ..."  to
let people know what decision was taken, unless --quiet is given. Yeah
I know --quiet does not exist. You don't need to add it now either
since nobody has asked for it.

More or less related to this, there was a question [1] whether we
could do better than $(basename <path>) for determining branch name.
Since you're doing start to check if a branch exists, people may start
asking to check for branch "foo/bar" from the path abc/foo/bar instead
of just branch "bar".

[1] https://github.com/git-for-windows/git/issues/1390

>
>  list::
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 7cef5b120b..148a864bb9 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -411,13 +411,21 @@ static int add(int ac, const char **av, const char *prefix)
>         if (ac < 2 && !opts.new_branch && !opts.detach) {
>                 int n;
>                 const char *s = worktree_basename(path, &n);
> -               opts.new_branch = xstrndup(s, n);
> -               if (guess_remote) {
> -                       struct object_id oid;
> -                       const char *remote =
> -                               unique_tracking_name(opts.new_branch, &oid);
> -                       if (remote)
> -                               branch = remote;
> +               const char *branchname = xstrndup(s, n);
> +               struct strbuf ref = STRBUF_INIT;

Perhaps a blank line after this to separate var declarations and the rest.

> +               if (!strbuf_check_branch_ref(&ref, branchname) &&
> +                   ref_exists(ref.buf)) {
> +                       branch = branchname;

Hmm.. do we need UNLEAK(branch);? Maybe you should try valgrind, I'm not sure.

> +                       opts.checkout = 1;
> +               } else {
> +                       opts.new_branch = branchname;
> +                       if (guess_remote) {
> +                               struct object_id oid;
> +                               const char *remote =
> +                                       unique_tracking_name(opts.new_branch, &oid);
> +                               if (remote)
> +                                       branch = remote;
> +                       }
>                 }
>         }
>
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 2b95944973..721b0e4c26 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -198,13 +198,22 @@ test_expect_success '"add" with <branch> omitted' '
>         test_cmp_rev HEAD bat
>  '
>
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
> +
> +test_expect_success '"add" auto-vivify fails with checked out branch' '
> +       git checkout -b test-branch &&
> +       test_must_fail git worktree add test-branch &&
> +       test_path_is_missing test-branch
>  '
>
>  test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
> --
> 2.16.0.312.g896df04e46
>



-- 
Duy
