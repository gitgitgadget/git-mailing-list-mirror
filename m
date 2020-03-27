Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1729C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7976620716
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq6EX08k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgC0SBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:01:43 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:35926 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgC0SBn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 14:01:43 -0400
Received: by mail-ot1-f43.google.com with SMTP id l23so10683346otf.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3wFBRAAtnpmUXIzV7AvQO2JZGJ4X0LNx8kn6EAzoYA=;
        b=Qq6EX08kHLhKGxU0sKGX+KQPjDwKgwi+NeaQhiuBFjhE6nq9pYCuCp2D+tmdqnfY4M
         +YAIviwmur4oAPH9WWCr/I+vnE9GYks1I1To2prg/JoTpxn9F2konjvNKRIDWbGolbB9
         7YdPjki52CUyKcOcePWiwKqKWkfqbolN0EK0x/q6cesOi5bZVmxBzzkCBwKUN7vc0z3V
         IwBUYOXJZ/XtzLT7NoZRn+yoSg3uuWFRBrd7P2I+AqxucnHQmZ+YvzMoGMT2c7M8bejh
         Dbh9iDIBoCI8DWc0QMyD4HKB52nD/tvk2wIe8V3HsF39jJyTXQhvtoxWx1oe0E4I2CnA
         2/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3wFBRAAtnpmUXIzV7AvQO2JZGJ4X0LNx8kn6EAzoYA=;
        b=aiYSx0LzLGkbJnLe7Hkw5V/II+AbnZqbw+1aXYFZyapwbCVWFhWFg6hPBjNBICVDnf
         sjRoxmN7pDvFPikMZ+sDdCdlnRb+xce0ugJpoYMOkALJMGodos9yGKQJxVSMU+C+7oAz
         lQDL1YLB+emqg+3tj5dY/0TMGDL5Jf9RG4+V+TsBCP/JulThOrH/mg/KLn3Ipxxjhrqe
         I6DFFSAYN9LLlJwL0MkMRUjBsdgvEW7zYdDOsTbXN/rGZq5JI437Py66uDjoqeryKSys
         XTCk/r3gaQttbLd+gY45sR1DA44bNpAPAUMJoqzv7J2/JNufp4SGXg3diHg7w9BcHIkq
         F+Tw==
X-Gm-Message-State: ANhLgQ0YxvzbJJx943HJ0zjdP3O2SlN2cYc/pdlNSRYEIOpSPGUk/UN9
        fHhMr60VWDU9wPthAFvINaPlmzXaW+y5iw+jPK0=
X-Google-Smtp-Source: ADFU+vu2vSnHw5Ov5JBqSgn93t0RideFpnrlMNDtI9UcASnj/Ts63D60TBhys9xXdMKkaOpL1gNSZwl9lBbLcb6/t7s=
X-Received: by 2002:a4a:3e90:: with SMTP id t138mr532261oot.24.1585332102079;
 Fri, 27 Mar 2020 11:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
 <20200325053908.GC651138@coredump.intra.peff.net> <CABPp-BF9LDfaw8=S4yqtuZ5U70Jcj_yZHq17Y7SUa17DwRqMSA@mail.gmail.com>
 <CAM+g_NtHC5ukU3jchVfud_H_m_h29UQ8vmwQoND8s_Q9Hv70Fg@mail.gmail.com>
 <CAM+g_Nvt3X4d5cjKajzDOcoDgNS4bVkj3a0KvVm4yDEW-J7v2w@mail.gmail.com>
 <CAM+g_NsUfw6zDRj8H1VNdheKFSHgC9gz7nVy0vbtpTKkYzjjtA@mail.gmail.com>
 <CABPp-BHMMw+L6fgfdVEEXnhH0w0aK6KfKA9Aq+aSuzWD0Cgr8g@mail.gmail.com>
 <CABPp-BFMN+pnOjEe2tZZJp3_Noojn5j1ip3dh8Xz9hCZoKJbxw@mail.gmail.com>
 <20200326072840.GA2198456@coredump.intra.peff.net> <CAM+g_NthmmJh3=Tp3ea6PmDr1h2-WtpiSTO8q02V3judc9p-Kg@mail.gmail.com>
In-Reply-To: <CAM+g_NthmmJh3=Tp3ea6PmDr1h2-WtpiSTO8q02V3judc9p-Kg@mail.gmail.com>
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Fri, 27 Mar 2020 11:01:30 -0700
Message-ID: <CAM+g_NtV5iUM=VJHOX7Um2DFLzjq-x76TYa_P_U6q5HBRmCY=A@mail.gmail.com>
Subject: Re: "git rebase" behavior change in 2.26.0
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I ran a "pull" today morning w/o sufficient coffee and thus forgot to
disable the "pull.rebase" and was bitten by that again.  Here is what
I see when using "GIT_TRACE2=1 git -c pull.rebase=true pull
--ff-only":
...
10:54:50.578673 run-command.c:735                 child_start[2] git
merge --ff-only FETCH_HEAD
10:54:50.580385 common-main.c:48                  version 2.26.0
10:54:50.580404 common-main.c:49                  start
/usr/lib/git-core/git merge --ff-only FETCH_HEAD
10:54:50.580587 repository.c:130                  worktree
/home/nkiesel/work/Platform
10:54:50.580785 git.c:440                         cmd_name merge (pull/merge)
Already up to date.
10:54:50.589803 git.c:674                         exit elapsed:0.009835 code:0
10:54:50.589827 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.009874 code:0
10:54:50.590887 run-command.c:990                 child_exit[2]
pid:939370 code:0 elapsed:0.012205
10:54:50.590919 run-command.c:735                 child_start[3] git
rebase --onto d0527895a4df44f00162b68011b803e597fd400f
d0527895a4df44f00162b68011b803e597fd400f
10:54:50.592396 common-main.c:48                  version 2.26.0
10:54:50.592412 common-main.c:49                  start
/usr/lib/git-core/git rebase --onto
d0527895a4df44f00162b68011b803e597fd400f
d0527895a4df44f00162b68011b803e597fd400f
10:54:50.592568 repository.c:130                  worktree
/home/nkiesel/work/Platform
10:54:50.592714 git.c:440                         cmd_name rebase (pull/rebase)
10:54:50.593142 builtin/rebase.c:1669             cmd_mode undefined
10:54:50.614154 run-command.c:735                 child_start[0] git
checkout d0527895a4df44f00162b68011b803e597fd400f
10:54:50.678813 run-command.c:990                 child_exit[0]
pid:939392 code:0 elapsed:0.064656
Successfully rebased and updated refs/heads/nextrelease.
10:54:50.697724 git.c:674                         exit elapsed:0.105715 code:0
10:54:50.697734 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.105729 code:0
10:54:50.698307 run-command.c:990                 child_exit[3]
pid:939371 code:0 elapsed:0.107373
10:54:50.698343 git.c:674                         exit elapsed:5.904200 code:0
10:54:50.698354 trace2/tr2_tgt_normal.c:123       atexit elapsed:5.904211 code:0

I would argue that "--ff-only" would mean to never rebase, but clearly
git runs a rebase of HEAD onto HEAD and i assume by that setting
ORIG_HEAD to HEAD as colloquial damage.
