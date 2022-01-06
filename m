Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D19C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 18:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiAFSrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 13:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242981AbiAFSrT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 13:47:19 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D2C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 10:47:19 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id i6-20020a170902c28600b00149b3c82d16so676627pld.12
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 10:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=QmbtETa1NkQqN5iY5kzfhKQyZMRhef8kJ8NeJquOqos=;
        b=T/3I6ecD3cFzl2ZI6Wv1z91N5VK6x4BW2zVkrvFzW29kvGQMw+c8XgCIaUgfCzPMF0
         IyEEqGEnhhEYjvSHu1lrIS8CejAYECABegAwvIaStabL3xnbUKHNO2Um73lsulYHkdco
         gLVJSqzxGIOe68kM0Dbr9I5A1Ge1CmB7HvClPrFC5Ynm72w6YnImdWauiRKJwN2NA8RK
         uJZuuR7Y5c8uAr3Hk0yWLJvX+NivUSsMWdHoK0e0/A8MFplPBqg1umqibX+cQzvLLxqC
         Ht0JYaxuuUHBFlawnr/jNAMRPN1/3fTLvD/bhJL/p9ONfLN97GTbEvHxHJ0dDOskydea
         Di3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=QmbtETa1NkQqN5iY5kzfhKQyZMRhef8kJ8NeJquOqos=;
        b=C8q97gr9MVI38iz/fBDjhg/oyJO/vzZwS5kOK6RmqAdeMyXXHfEmsnv8tRuN4Hficu
         ynPNwHDPrO2CIBI5/eGzjUG6j7WUNQ2qQR20+LC/iXpcXDEALNa00kK6jcqevHaBeSsw
         E0CerSfEKcxK0e7C414FKZNaAQreJJBmQuzME0la1pFcexsY2pOM5X7IRiQpNnm9rodE
         CuZ9iuYC4oi7nQrHGbDhqiUwEx8EfmxK7xLqwcig8FCpM5/UMEmyj/UTve/6+gSfOqju
         O7vn6jImQK0uBpth5Zu26j4FaxJStOX0Q2y5nqqwDmCN7aHIp0JdBtuMDorjXm75Z4qQ
         MwsQ==
X-Gm-Message-State: AOAM533Cmasb3GvTGAJH9GqRlJpHEGrgHaDwaAlWggHiw/yIv8c5mZ0i
        srHDLNC26mOdebxOY8h24sZSCEe6FtE3tA==
X-Google-Smtp-Source: ABdhPJz/4xfgVsfGvZ/PmWMC8pA597PT0mTrg4IohcBuHcdCLbalg6KLzI0rhxcI69BcDwhZDAaH6NBm0HF65Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2304:b0:4ba:4cbb:8289 with SMTP
 id h4-20020a056a00230400b004ba4cbb8289mr60908077pfh.79.1641494839218; Thu, 06
 Jan 2022 10:47:19 -0800 (PST)
Date:   Thu, 06 Jan 2022 10:47:16 -0800
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
Message-Id: <kl6lr19k7lcb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
Subject: Re: [PATCH v6 00/17] hook.[ch]: new library to run hooks + simple
 hook conversion
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> A trivial update to v5 to rebase it past conflicts with topics that
> recently landed on "master". For v5 see:
> https://lore.kernel.org/git/cover-v5-00.17-00000000000-20211123T114206Z-a=
varab@gmail.com/
>
> Emily Shaffer (14):
>   hook: add 'run' subcommand
>   gc: use hook library for pre-auto-gc hook
>   am: convert {pre,post}-applypatch to use hook.h
>   rebase: convert pre-rebase to use hook.h
>   am: convert applypatch-msg to use hook.h
>   merge: convert post-merge to use hook.h
>   hooks: convert non-worktree 'post-checkout' hook to hook library
>   hooks: convert worktree 'post-checkout' hook to hook library
>   send-email: use 'git hook run' for 'sendemail-validate'
>   git-p4: use 'git hook' to run hooks
>   commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>   read-cache: convert post-index-change to use hook.h
>   receive-pack: convert push-to-checkout hook to hook.h
>   run-command: remove old run_hook_{le,ve}() hook API
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>   hook API: add a run_hooks() wrapper
>   hook API: add a run_hooks_l() wrapper
>   git hook run: add an --ignore-missing flag
>
>  .gitignore                 |   1 +
>  Documentation/git-hook.txt |  45 +++++++++++++
>  Documentation/githooks.txt |   4 ++
>  Makefile                   |   1 +
>  builtin.h                  |   1 +
>  builtin/am.c               |   6 +-
>  builtin/checkout.c         |   3 +-
>  builtin/clone.c            |   3 +-
>  builtin/gc.c               |   3 +-
>  builtin/hook.c             |  84 +++++++++++++++++++++++
>  builtin/merge.c            |   2 +-
>  builtin/rebase.c           |   3 +-
>  builtin/receive-pack.c     |   7 +-
>  builtin/worktree.c         |  26 +++----
>  command-list.txt           |   1 +
>  commit.c                   |  15 +++--
>  git-p4.py                  |  70 ++-----------------
>  git-send-email.perl        |  22 +++---
>  git.c                      |   1 +
>  hook.c                     | 131 ++++++++++++++++++++++++++++++++++++
>  hook.h                     |  57 ++++++++++++++++
>  read-cache.c               |   3 +-
>  reset.c                    |   3 +-
>  run-command.c              |  33 ---------
>  run-command.h              |  17 -----
>  t/t1800-hook.sh            | 134 +++++++++++++++++++++++++++++++++++++
>  t/t9001-send-email.sh      |   4 +-
>  27 files changed, 522 insertions(+), 158 deletions(-)
>  create mode 100644 Documentation/git-hook.txt
>  create mode 100644 builtin/hook.c
>  create mode 100755 t/t1800-hook.sh
>
> Range-diff against v5:
>  1:  4ca52feebb8 =3D  1:  ba6fd47482e hook: add 'run' subcommand
>  2:  6275b97a306 =3D  2:  cfba5c139e7 hook API: add a run_hooks() wrapper
>  3:  b5b3051b2e5 =3D  3:  a4cca074bcb gc: use hook library for pre-auto-g=
c hook
>  4:  c88eb5d4c25 =3D  4:  ce57ce1adcb am: convert {pre,post}-applypatch t=
o use hook.h
>  5:  1d8f7b7e4c1 =3D  5:  d6162fbef80 hook API: add a run_hooks_l() wrapp=
er
>  6:  d49a1444345 =3D  6:  4c1a8951fc5 rebase: convert pre-rebase to use h=
ook.h
>  7:  191fdad0165 =3D  7:  d8aa5e8345f am: convert applypatch-msg to use h=
ook.h
>  8:  119b92fbeae =3D  8:  6f8d3754b4f merge: convert post-merge to use ho=
ok.h
>  9:  359ba416e84 !  9:  d3107034806 hooks: convert non-worktree 'post-che=
ckout' hook to hook library
>     @@ builtin/checkout.c
>       #include "ll-merge.h"
>       #include "lockfile.h"
>       #include "merge-recursive.h"
>     -@@ builtin/checkout.c: struct branch_info {
>     +@@ builtin/checkout.c: static void branch_info_release(struct branch=
_info *info)
>       static int post_checkout_hook(struct commit *old_commit, struct com=
mit *new_commit,
>       			      int changed)
>       {
> 10:  b7599be95a7 ! 10:  bff7c1513ca hooks: convert worktree 'post-checkou=
t' hook to hook library
>     @@ builtin/worktree.c: static int add_worktree(const char *path, cons=
t char *refnam
>      -		const char *hook =3D find_hook("post-checkout");
>      -		if (hook) {
>      -			const char *env[] =3D { "GIT_DIR", "GIT_WORK_TREE", NULL };
>     --			cp.git_cmd =3D 0;
>     +-			struct child_process cp =3D CHILD_PROCESS_INIT;
>      -			cp.no_stdin =3D 1;
>      -			cp.stdout_to_stderr =3D 1;
>      -			cp.dir =3D path;
>     --			cp.env =3D env;
>     --			cp.argv =3D NULL;
>     +-			strvec_pushv(&cp.env_array, env);
>      -			cp.trace2_hook_name =3D "post-checkout";
>      -			strvec_pushl(&cp.args, absolute_path(hook),
>      -				     oid_to_hex(null_oid()),
> 11:  f1c84d7f627 =3D 11:  7d9c0a73568 git hook run: add an --ignore-missi=
ng flag
> 12:  4e0f94d9102 =3D 12:  8ea3b250dff send-email: use 'git hook run' for =
'sendemail-validate'
> 13:  e858f332a62 =3D 13:  a184afd1ffd git-p4: use 'git hook' to run hooks
> 14:  9a5956cc028 =3D 14:  1a43e50617f commit: convert {pre-commit,prepare=
-commit-msg} hook to hook.h
> 15:  6fd47c4c499 =3D 15:  08b7e63ba5b read-cache: convert post-index-chan=
ge to use hook.h
> 16:  b201ea46f4b =3D 16:  c47b36ab41a receive-pack: convert push-to-check=
out hook to hook.h
> 17:  281d17b04db ! 17:  7b99a4b633c run-command: remove old run_hook_{le,=
ve}() hook API
>     @@ run-command.c: int async_with_fork(void)
>      -	strvec_push(&hook.args, p);
>      -	while ((p =3D va_arg(args, const char *)))
>      -		strvec_push(&hook.args, p);
>     --	hook.env =3D env;
>     +-	if (env)
>     +-		strvec_pushv(&hook.env_array, (const char **)env);
>      -	hook.no_stdin =3D 1;
>      -	hook.stdout_to_stderr =3D 1;
>      -	hook.trace2_hook_name =3D name;
> --=20
> 2.34.1.1146.gb52885e7c44


The Google folks picked up this series for our "review club" sessions
(which is open to the public, as you know ;)). As Junio mentioned in the
last "What's Cooking" [1], he would like serious review on the patches
you contributed, so that is where we focused most of our attention.

The code itself looks quite good, but one concern that came up was that
the motivation behind this series doesn't seem immediately obvious to
first time readers. This series has existed in some form for a very long
time; the first patches for config-based hooks I could find date back to
2019! [2]. So keeping everyone on the same page is definitely hard, but
it's worthwhile if it means that someone can pick up the series without
having to be familiar with the prior work.

With that in mind, your original cover letter [3] does a good job at
describing the "what" of the series - what it does (extend the hook API
and replace calls), what it is (an incremental restart of an ejected
topic). However, it's hard to recreate the motivation behind this series
based on the cover letter and its papertrail. Much of the Google team is
fairly familiar with the feature, but newcomers (including myself) have
a hard time piecing together the story based on this thread alone.

I found myself asking some questions when reading this cover letter, and
here are some suggestions to make this friendlier for new readers:

* Why do we want config based hooks in the first place?

  Convincing us that we want this is Emily's job, not yours, but it
  helps to know how this fits in with the whole thing. As a convenience,
  linking to Emily's original series would save the reader a lot of
  thread-following.

* How does this series contribute to config based hooks?
* Why did we need this reroll in the first place?
* How does this series meet the goals of the reroll?=20

  These are pretty difficult to pin down without being familiar with the
  original series too. Emily probably knows the anwers to these, so you
  have at least one person who can review the series based on these
  questions, but it's pretty challenging for others to figure this out.

  This question is probably best answered in the cover letter, or at the
  very least, links to suggested reading and the order in which to read
  them.

* What benefit does this series bring irrespective of config based
  hooks?

  This is best answered in the cover letter as well, but the payoff is
  way bigger than the previous set of questions. If you can sell
  reviewers on the idea that this series independently mergeable, is
  good for the project on its own (I think that it is!), _and_ it
  contributes to config based hooks, then reviewers have a good reason
  to look at it even if they aren't particularly invested in config
  based hooks. I think this is even more important because we want
  reviews saying "yes this series is good for the project".

TL;DR this is basically a long-winded way of saying that for a
long-running work in progress like this one, new reviewers are probably
scared off by having to recreate the context leading up to this series,
and anything we can do to lessen that burden will be greatly
appreciated :)

[1] https://lore.kernel.org/git/xmqq1r1lfwyq.fsf@gitster.g
[2] https://lore.kernel.org/git/20191210023335.49987-1-emilyshaffer@google.=
com/
[3] https://lore.kernel.org/git/cover-00.13-00000000000-20211012T131934Z-av=
arab@gmail.com/
