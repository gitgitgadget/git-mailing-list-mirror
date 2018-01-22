Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8B1E1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 20:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeAVUPK (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 15:15:10 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:38773 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeAVUPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 15:15:05 -0500
Received: by mail-wr0-f176.google.com with SMTP id x1so10052536wrb.5
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 12:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sHX6fULp8dUEZH7ouEJKmKgNt8VpwJ7EXHwYP+ag9DA=;
        b=ETgC1VOOEK2qUSO5foIsB6i/GrwnSpqKObOXRuXeDy+OxL1LWZIG6yzFH8B/+lVfMH
         iAB4wmpmp0RDXX1gLeNazphH+HzvpMrO6b2oOqbxS6U5D/BtJPfJ0CLozLrwLHANisxg
         vkXJ0bvutFZgQBulhgNAX/vaFQVhKnRiUDXWkvJF+xm6OUXKuQHKdKuDBs1fdP8uc3zL
         AAgLDdbkN4oYKBY8H9tBd6PEJ7z2DqfuUiHVTMEuGcFS+M8dmdlHet70Kfc2zVBuycWc
         0mEzFEAyRzr9w6bQ735QuNMx/La0T4mpuYzuM3372e3SDcAw8eqbaEXfTJHL3VrKYUgC
         JZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sHX6fULp8dUEZH7ouEJKmKgNt8VpwJ7EXHwYP+ag9DA=;
        b=Fw/38MIzJULAwqW4jOd6ZcVZO/6KQC2udhn+mmh7TL28TZfmOoQLZ5NQFvP1AmqkKY
         CIISIg/ekGceMr2xRceH6HBhgDSz9p0RiwoTg6WZc/ZDcJoeQSlR8ou6eHuHQv0mReG8
         Kj8dl73k8LoxbI7ea77XvIMv8UB/WUc4i3ipTysKt9q5wOfOFKcXMGoFSDFEoGCKCfIo
         eoaHfXxNLbYuZ8pg5TEDqVh7i29BzuUJ7SzBhNnGlQ9bIBlk06el6d4lMUzqyhATBAnC
         98ecKFlyZZSV0DWmpV0mlFx5q6/eW4VZTg8nf3zKS6emy83a5A94itObkQqecJKZ46FF
         3zCA==
X-Gm-Message-State: AKwxyter265Qu0iN70ndeHtqnlu8xDeI+pQU7CZUsvd65TjRv6HKj2/P
        Fnz+8SLhRhYKBm734Nd1Ufw=
X-Google-Smtp-Source: AH8x227Hk5dBm15cz+akcaukW1voRA5ef/XyFeVXymRWqD3Nt9keHMWalG5FHymiGuFEHk5Cwc3NWw==
X-Received: by 10.223.198.198 with SMTP id c6mr37353wrh.159.1516652104435;
        Mon, 22 Jan 2018 12:15:04 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id x127sm6103980wmb.36.2018.01.22.12.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 12:15:03 -0800 (PST)
Date:   Mon, 22 Jan 2018 20:17:28 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] worktree: teach "add" to check out existing branches
Message-ID: <20180122201728.GA2130@hank>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
 <CACsJy8D9LS7e=cVE3Fq2qOnxK5++nFg2vjuhkNtRO-Bx0X1j6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8D9LS7e=cVE3Fq2qOnxK5++nFg2vjuhkNtRO-Bx0X1j6w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/22, Duy Nguyen wrote:
> On Sun, Jan 21, 2018 at 7:02 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > [...]
> >  +
> >  If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
> > -then, as a convenience, a new branch based at HEAD is created automatically,
> > -as if `-b $(basename <path>)` was specified.
> > +then, as a convenience, a worktree with a branch named after
> > +`$(basename <path>)` (call it `<branch>`) is created.  If `<branch>`
> > +doesn't exist, a new branch based on HEAD is automatically created as
> > +if `-b <branch>` was given.  If `<branch>` exists in the repository,
> > +it will be checked out in the new worktree, if it's not checked out
> > +anywhere else, otherwise the command will refuse to create the
> > +worktree.
> 
> It starts getting a bit too magical to me. We probably should print
> something "switching to branch..." or "creating new branch ..."  to
> let people know what decision was taken, unless --quiet is given. Yeah
> I know --quiet does not exist. You don't need to add it now either
> since nobody has asked for it.

I think that's a good idea.  I'll add that, thanks.

> More or less related to this, there was a question [1] whether we
> could do better than $(basename <path>) for determining branch name.
> Since you're doing start to check if a branch exists, people may start
> asking to check for branch "foo/bar" from the path abc/foo/bar instead
> of just branch "bar".

Thanks for pointing me at this.  I feel like we might get ourselves
some backwards compatibility worries when doing that.  Lets say
someone has a branch 'feature/a', using 'git worktree feature/a' would
currently create a new branch 'a', and does not die.

I'd guess most users would want 'feature/a' checked out in that case,
but we can't exactly be sure we won't break anyones workflow here.
With your suggestion I guess that would be mitigated somehow as it
shows which action is taken, but dunno.

Should we hide this behaviour behind a flag, and plan for it
eventually becoming the default?

> [1] https://github.com/git-for-windows/git/issues/1390
> 
> >
> >  list::
> >
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 7cef5b120b..148a864bb9 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -411,13 +411,21 @@ static int add(int ac, const char **av, const char *prefix)
> >         if (ac < 2 && !opts.new_branch && !opts.detach) {
> >                 int n;
> >                 const char *s = worktree_basename(path, &n);
> > -               opts.new_branch = xstrndup(s, n);
> > -               if (guess_remote) {
> > -                       struct object_id oid;
> > -                       const char *remote =
> > -                               unique_tracking_name(opts.new_branch, &oid);
> > -                       if (remote)
> > -                               branch = remote;
> > +               const char *branchname = xstrndup(s, n);
> > +               struct strbuf ref = STRBUF_INIT;
> 
> Perhaps a blank line after this to separate var declarations and the rest.

Will add. 

> > +               if (!strbuf_check_branch_ref(&ref, branchname) &&
> > +                   ref_exists(ref.buf)) {
> > +                       branch = branchname;
> 
> Hmm.. do we need UNLEAK(branch);? Maybe you should try valgrind, I'm not sure.

Good question, I'll have a look, thanks.

> > +                       opts.checkout = 1;
> > +               } else {
> > +                       opts.new_branch = branchname;
> > +                       if (guess_remote) {
> > +                               struct object_id oid;
> > +                               const char *remote =
> > +                                       unique_tracking_name(opts.new_branch, &oid);
> > +                               if (remote)
> > +                                       branch = remote;
> > +                       }
> >                 }
> >         }
> >
> > diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> > index 2b95944973..721b0e4c26 100755
> > --- a/t/t2025-worktree-add.sh
> > +++ b/t/t2025-worktree-add.sh
> > @@ -198,13 +198,22 @@ test_expect_success '"add" with <branch> omitted' '
> >         test_cmp_rev HEAD bat
> >  '
> >
> > -test_expect_success '"add" auto-vivify does not clobber existing branch' '
> > +test_expect_success '"add" auto-vivify checks out existing branch' '
> >         test_commit c1 &&
> >         test_commit c2 &&
> >         git branch precious HEAD~1 &&
> > -       test_must_fail git worktree add precious &&
> > +       git worktree add precious &&
> >         test_cmp_rev HEAD~1 precious &&
> > -       test_path_is_missing precious
> > +       (
> > +               cd precious &&
> > +               test_cmp_rev precious HEAD
> > +       )
> > +'
> > +
> > +test_expect_success '"add" auto-vivify fails with checked out branch' '
> > +       git checkout -b test-branch &&
> > +       test_must_fail git worktree add test-branch &&
> > +       test_path_is_missing test-branch
> >  '
> >
> >  test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
> > --
> > 2.16.0.312.g896df04e46
> >
> 
> 
> 
> -- 
> Duy
