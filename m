Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB6CC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695B520737
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nab4vCS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgC0Set (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:34:49 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37014 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgC0Set (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 14:34:49 -0400
Received: by mail-ot1-f51.google.com with SMTP id g23so10805943otq.4
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhNrBUVgj831Q9P9NRwNZRIW4CumJaOULobKMqHixmQ=;
        b=nab4vCS3clXJOjgJJNokItwHf+9IXg3NfaqOuv0MziqDdoY780uNlzx96k6oqSytrP
         Y7viVvFQjOXoob2/dkLBboKEQoEnmTV8QpfGs/GVW0pQxJqcGNJ3lWTiMt0j/0atHqMn
         c0KYY4Qte/KXtIT93fheTSknawqBETcs635h1+tpGp6US6Jr+kl7Hxok5C/Gxxcg5an1
         EJScmOewKSdTPxlq/WSYmFlMWiolKFAVab+96gtkY+0l7FgT+gMLiesgIpDVDyXvQXWK
         qPhin6s28cbQR6Wt2Uf9KwOc/i5kI0bAxnkpEDSHXm8hP2L2sJQ1qRzbSVktbp1rXJYr
         i+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhNrBUVgj831Q9P9NRwNZRIW4CumJaOULobKMqHixmQ=;
        b=qCzlKi7eOsRq3enyFZ1EiSjOuSltEWA8/cwfaaQ18e5nfiFSJgZmwc4c6L3fXJbrzY
         //NI3nT3YH81DViYQbzTU58rVJmFA7bg3Rq0K0hcjRY4Ha2SQ3r4GkadWFpEJcA7j9jA
         ajvNWW7kicwNIHpPfmr95I/xCA3RGf1Spv58Q4b0aTBuF2CyhDZQSu81ryyKHxVFFMol
         BbHnw3rQ1R5AqvfgzRW2V+R3quimtnayIoK95tA1qXOwHAwh+C1ZncsT0aGhhWGGeHqR
         jrfKRUJQlWZp3Mu+ELiNeX3ZsaTIQAkRQmBjy7fNrWE3mEOI+z1MDdxf4BkiKjCT8Sgs
         LS1A==
X-Gm-Message-State: ANhLgQ02L/mYxVWA2LB/thBgIZhZQDuwEoApGttHqTSHz576vyGffmjP
        yXznFvsNiHmJWCUlZcE66A+XwsH+y/GsddAG9RHW7ZKdHI0=
X-Google-Smtp-Source: ADFU+vtwhkfCCJCoW9CvHR4kSezwsM4tGRzkegWgFiV2KYeoX37fIJ6eqG1YNsPXLyc3KLhvMAVGc9EUS4MPE8T4x6s=
X-Received: by 2002:a4a:9451:: with SMTP id j17mr667048ooi.30.1585334087702;
 Fri, 27 Mar 2020 11:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
 <20200325053908.GC651138@coredump.intra.peff.net> <CABPp-BF9LDfaw8=S4yqtuZ5U70Jcj_yZHq17Y7SUa17DwRqMSA@mail.gmail.com>
 <CAM+g_NtHC5ukU3jchVfud_H_m_h29UQ8vmwQoND8s_Q9Hv70Fg@mail.gmail.com>
 <CAM+g_Nvt3X4d5cjKajzDOcoDgNS4bVkj3a0KvVm4yDEW-J7v2w@mail.gmail.com>
 <CAM+g_NsUfw6zDRj8H1VNdheKFSHgC9gz7nVy0vbtpTKkYzjjtA@mail.gmail.com>
 <CABPp-BHMMw+L6fgfdVEEXnhH0w0aK6KfKA9Aq+aSuzWD0Cgr8g@mail.gmail.com>
 <CABPp-BFMN+pnOjEe2tZZJp3_Noojn5j1ip3dh8Xz9hCZoKJbxw@mail.gmail.com>
 <20200326072840.GA2198456@coredump.intra.peff.net> <CAM+g_NthmmJh3=Tp3ea6PmDr1h2-WtpiSTO8q02V3judc9p-Kg@mail.gmail.com>
 <CAM+g_NtV5iUM=VJHOX7Um2DFLzjq-x76TYa_P_U6q5HBRmCY=A@mail.gmail.com>
In-Reply-To: <CAM+g_NtV5iUM=VJHOX7Um2DFLzjq-x76TYa_P_U6q5HBRmCY=A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Mar 2020 11:34:36 -0700
Message-ID: <CABPp-BHihQjMc9qugVtVTZVduRxLYUAhf18R5c=3Lb5bcRzjAw@mail.gmail.com>
Subject: Re: "git rebase" behavior change in 2.26.0
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 11:01 AM Norbert Kiesel <nkiesel@gmail.com> wrote:
>
> I ran a "pull" today morning w/o sufficient coffee and thus forgot to
> disable the "pull.rebase" and was bitten by that again.  Here is what
> I see when using "GIT_TRACE2=1 git -c pull.rebase=true pull
> --ff-only":
> ...
> 10:54:50.578673 run-command.c:735                 child_start[2] git
> merge --ff-only FETCH_HEAD
> 10:54:50.580385 common-main.c:48                  version 2.26.0
> 10:54:50.580404 common-main.c:49                  start
> /usr/lib/git-core/git merge --ff-only FETCH_HEAD
> 10:54:50.580587 repository.c:130                  worktree
> /home/nkiesel/work/Platform
> 10:54:50.580785 git.c:440                         cmd_name merge (pull/merge)
> Already up to date.
> 10:54:50.589803 git.c:674                         exit elapsed:0.009835 code:0
> 10:54:50.589827 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.009874 code:0
> 10:54:50.590887 run-command.c:990                 child_exit[2]
> pid:939370 code:0 elapsed:0.012205
> 10:54:50.590919 run-command.c:735                 child_start[3] git
> rebase --onto d0527895a4df44f00162b68011b803e597fd400f
> d0527895a4df44f00162b68011b803e597fd400f
> 10:54:50.592396 common-main.c:48                  version 2.26.0
> 10:54:50.592412 common-main.c:49                  start
> /usr/lib/git-core/git rebase --onto
> d0527895a4df44f00162b68011b803e597fd400f
> d0527895a4df44f00162b68011b803e597fd400f
> 10:54:50.592568 repository.c:130                  worktree
> /home/nkiesel/work/Platform
> 10:54:50.592714 git.c:440                         cmd_name rebase (pull/rebase)
> 10:54:50.593142 builtin/rebase.c:1669             cmd_mode undefined
> 10:54:50.614154 run-command.c:735                 child_start[0] git
> checkout d0527895a4df44f00162b68011b803e597fd400f
> 10:54:50.678813 run-command.c:990                 child_exit[0]
> pid:939392 code:0 elapsed:0.064656
> Successfully rebased and updated refs/heads/nextrelease.
> 10:54:50.697724 git.c:674                         exit elapsed:0.105715 code:0
> 10:54:50.697734 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.105729 code:0
> 10:54:50.698307 run-command.c:990                 child_exit[3]
> pid:939371 code:0 elapsed:0.107373
> 10:54:50.698343 git.c:674                         exit elapsed:5.904200 code:0
> 10:54:50.698354 trace2/tr2_tgt_normal.c:123       atexit elapsed:5.904211 code:0
>
> I would argue that "--ff-only" would mean to never rebase, but clearly
> git runs a rebase of HEAD onto HEAD and i assume by that setting
> ORIG_HEAD to HEAD as colloquial damage.

When I run the exact same command in my test repo, I see:

[newren@tiger clone]$ GIT_TRACE2=1 git -c pull.rebase=true pull --ff-only
11:13:16.376197 common-main.c:48                  version 2.26.0
11:13:16.376228 common-main.c:49                  start
/home/newren/floss/git/git -c pull.rebase=true pull --ff-only
11:13:16.376457 repository.c:130                  worktree
/home/newren/floss/git/testing/pull-rebase-orig-head/clone
11:13:16.376605 git.c:440                         cmd_name pull (pull)
11:13:16.378095 run-command.c:735                 child_start[0] git
merge-base --fork-point refs/remotes/origin/master master
11:13:16.380766 run-command.c:990                 child_exit[0]
pid:1247445 code:0 elapsed:0.002662
11:13:16.380827 run-command.c:735                 child_start[1] git
fetch --update-head-ok
11:13:16.382368 common-main.c:48                  version 2.26.0
11:13:16.382388 common-main.c:49                  start
/home/newren/floss/git/git fetch --update-head-ok
11:13:16.382493 repository.c:130                  worktree
/home/newren/floss/git/testing/pull-rebase-orig-head/clone
11:13:16.382579 git.c:440                         cmd_name fetch (pull/fetch)
11:13:16.383141 run-command.c:735                 child_start[0]
'git-upload-pack
'\''/home/newren/floss/git/testing/pull-rebase-orig-head/repo/'\'''
11:13:16.386079 common-main.c:48                  version 2.26.0
11:13:16.386096 common-main.c:49                  start
git-upload-pack
/home/newren/floss/git/testing/pull-rebase-orig-head/repo/
11:13:16.386119 git.c:440                         cmd_name upload-pack
(pull/fetch/upload-pack)
11:13:16.388828 run-command.c:735                 child_start[0] git
pack-objects --revs --thin --stdout --progress --delta-base-offset
--include-tag
remote: 11:13:16.390448 common-main.c:48                  version 2.26.0
remote: 11:13:16.390464 common-main.c:49                  start
/home/newren/floss/git/git pack-objects --revs --thin --stdout
--progress --delta-base-offset --include-tag
remote: 11:13:16.390554 repository.c:130                  worktree
/home/newren/floss/git/testing/pull-rebase-orig-head/repo/.git
remote: 11:13:16.390670 git.c:440                         cmd_name
pack-objects (pull/fetch/upload-pack/pack-objects)
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
11:13:16.392266 run-command.c:735                 child_start[1] git
unpack-objects --pack_header=2,3
remote: 11:13:16.392261 git.c:674                         exit
elapsed:0.002147 code:0
remote: 11:13:16.392274 trace2/tr2_tgt_normal.c:123       atexit
elapsed:0.002162 code:0
11:13:16.392507 run-command.c:990                 child_exit[0]
pid:1247449 code:0 elapsed:0.003677
11:13:16.393548 common-main.c:48                  version 2.26.0
11:13:16.393560 common-main.c:49                  start
/home/newren/floss/git/git unpack-objects --pack_header=2,3
11:13:16.393691 repository.c:130                  worktree
/home/newren/floss/git/testing/pull-rebase-orig-head/clone
11:13:16.393832 git.c:440                         cmd_name
unpack-objects (pull/fetch/unpack-objects)
Unpacking objects: 100% (3/3), 252 bytes | 252.00 KiB/s, done.
11:13:16.394854 git.c:674                         exit elapsed:0.001576 code:0
11:13:16.394865 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.001588 code:0
11:13:16.395069 run-command.c:990                 child_exit[1]
pid:1247450 code:0 elapsed:0.002802
11:13:16.395157 git.c:674                         exit elapsed:0.009406 code:0
11:13:16.395176 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.009429 code:0
11:13:16.395394 run-command.c:990                 child_exit[0]
pid:1247447 code:0 elapsed:0.012252
11:13:16.395476 run-command.c:735                 child_start[2] git
rev-list --objects --stdin --not --all --quiet --alternate-refs
11:13:16.396725 common-main.c:48                  version 2.26.0
11:13:16.396738 common-main.c:49                  start
/home/newren/floss/git/git rev-list --objects --stdin --not --all
--quiet --alternate-refs
11:13:16.396855 repository.c:130                  worktree
/home/newren/floss/git/testing/pull-rebase-orig-head/clone
11:13:16.396927 git.c:440                         cmd_name rev-list
(pull/fetch/rev-list)
11:13:16.397946 git.c:674                         exit elapsed:0.001493 code:0
11:13:16.397959 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.001511 code:0
11:13:16.398176 run-command.c:990                 child_exit[2]
pid:1247451 code:0 elapsed:0.002694
From /home/newren/floss/git/testing/pull-rebase-orig-head/repo
   2ccdb90..2c21563  master     -> origin/master
11:13:16.399051 run-command.c:735                 child_start[3] git gc --auto
11:13:16.400295 common-main.c:48                  version 2.26.0
11:13:16.400309 common-main.c:49                  start
/home/newren/floss/git/git gc --auto
11:13:16.400413 repository.c:130                  worktree
/home/newren/floss/git/testing/pull-rebase-orig-head/clone
11:13:16.400508 git.c:440                         cmd_name gc (pull/fetch/gc)
11:13:16.400708 git.c:674                         exit elapsed:0.000696 code:0
11:13:16.400719 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.000708 code:0
11:13:16.400909 run-command.c:990                 child_exit[3]
pid:1247452 code:0 elapsed:0.001853
11:13:16.400939 git.c:674                         exit elapsed:0.018943 code:0
11:13:16.400958 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.018962 code:0
11:13:16.401150 run-command.c:990                 child_exit[1]
pid:1247446 code:0 elapsed:0.020317
11:13:16.401475 run-command.c:735                 child_start[2] git
merge --ff-only FETCH_HEAD
11:13:16.402718 common-main.c:48                  version 2.26.0
11:13:16.402735 common-main.c:49                  start
/home/newren/floss/git/git merge --ff-only FETCH_HEAD
11:13:16.402854 repository.c:130                  worktree
/home/newren/floss/git/testing/pull-rebase-orig-head/clone
11:13:16.402953 git.c:440                         cmd_name merge (pull/merge)
Updating 2ccdb90..2c21563
Fast-forward
11:13:16.404582 run-command.c:735                 child_start[0] git gc --auto
11:13:16.406161 common-main.c:48                  version 2.26.0
11:13:16.406178 common-main.c:49                  start
/home/newren/floss/git/git gc --auto
11:13:16.406301 repository.c:130                  worktree
/home/newren/floss/git/testing/pull-rebase-orig-head/clone
11:13:16.406395 git.c:440                         cmd_name gc (pull/merge/gc)
11:13:16.406663 git.c:674                         exit elapsed:0.000929 code:0
11:13:16.406680 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.000950 code:0
11:13:16.406934 run-command.c:990                 child_exit[0]
pid:1247454 code:0 elapsed:0.002345
 numbers | 1 +
 1 file changed, 1 insertion(+)
11:13:16.407320 git.c:674                         exit elapsed:0.004889 code:0
11:13:16.407336 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.004907 code:0
11:13:16.407556 run-command.c:990                 child_exit[2]
pid:1247453 code:0 elapsed:0.006076
11:13:16.407617 run-command.c:735                 child_start[3] git
rebase --onto 2c21563a2dd61db0a502100ce1da5b6b0ecf8337
2c21563a2dd61db0a502100ce1da5b6b0ecf8337
11:13:16.409886 common-main.c:48                  version 2.26.0
11:13:16.409917 common-main.c:49                  start
/home/newren/floss/git/git rebase --onto
2c21563a2dd61db0a502100ce1da5b6b0ecf8337
2c21563a2dd61db0a502100ce1da5b6b0ecf8337
11:13:16.410166 repository.c:130                  worktree
/home/newren/floss/git/testing/pull-rebase-orig-head/clone
11:13:16.410402 git.c:440                         cmd_name rebase (pull/rebase)
11:13:16.410705 builtin/rebase.c:1669             cmd_mode undefined
Current branch master is up to date.
11:13:16.412385 run-command.c:735                 child_start[0] git gc --auto
11:13:16.413967 common-main.c:48                  version 2.26.0
11:13:16.413983 common-main.c:49                  start
/home/newren/floss/git/git gc --auto
11:13:16.414075 repository.c:130                  worktree
/home/newren/floss/git/testing/pull-rebase-orig-head/clone
11:13:16.414152 git.c:440                         cmd_name gc (pull/rebase/gc)
11:13:16.414363 git.c:674                         exit elapsed:0.000748 code:0
11:13:16.414375 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.000763 code:0
11:13:16.414607 run-command.c:990                 child_exit[0]
pid:1247456 code:0 elapsed:0.002218
11:13:16.414690 git.c:674                         exit elapsed:0.005410 code:0
11:13:16.414720 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.005441 code:0
11:13:16.414925 run-command.c:990                 child_exit[3]
pid:1247455 code:0 elapsed:0.007305
11:13:16.414984 git.c:674                         exit elapsed:0.039375 code:0
11:13:16.415023 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.039415 code:0

So there is no checkout for me; and while it's a useful hint it's not
yet clear to me why you have one.  Anyway, on my side:

$ git log --oneline --reverse; git rev-parse --short ORIG_HEAD
9691d52 initial
1d5a4c1 add another
0da5805 add another
ccea292 add another
100c273 add another
c911eef add another
2ccdb90 add another
2c21563 (HEAD -> master, origin/master, origin/HEAD) add another
2ccdb90


So, I'll repeat the same questions I asked last time, and see if you
will answer them this time:

What's in your .git/config, and in your $HOME/.gitconfig?  (Or maybe
just the output of 'git config --list'?)
What hooks do you have setup in .git/hooks/?
