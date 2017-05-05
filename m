Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0F7207B3
	for <e@80x24.org>; Fri,  5 May 2017 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755363AbdEESoJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 14:44:09 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33332 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754732AbdEESoB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 14:44:01 -0400
Received: by mail-qk0-f196.google.com with SMTP id o85so2054974qkh.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pi9VzTVmSjyhxDv0YoTa2YQrxB1L0L7bdxcuzPURkdE=;
        b=ZLbSXcXkuH59ek4UkkJGL269FY83DebIyWIree0juLECNRsHulJM5BeRHNHS98QWJk
         Jmte+/G69sCzGvaIo06a5lQUjSmU5RKscCUTHH2rymy5b/w+PFEKEXG1dZCPh3DLseR9
         RQeK1kfb0+ayYHn1QjeQGXroG9NoLhhHTvDEOh5PgBddQBrVR5qOIFrxkdcEPquuppBg
         ojIdchhmdeaYNSthFl72jVHEh8CdJ4w/IceQTT2HDvDqIE7xQBIumWfJdhWikhnJLEyP
         uYySFbdWXYXdQgiKv6BL1vf0AwqsUmnOD3suNYzYqwUyFTBAR6xUAJl03sNAhhnXim6F
         +Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pi9VzTVmSjyhxDv0YoTa2YQrxB1L0L7bdxcuzPURkdE=;
        b=ADdlPPRCKxl9/LGQP+rADAxVOAlxc+SUpcyVlz4lr9klR+mhL5ozRu0v+qjuDcn6Ko
         xfkffNjyub3aIPJTkwMTi25aJ/uJARNHtrhLwdwBU9NWaCQmKoVH5PXH4/bxta3zM5fg
         qhdkvog9jZAWLCxQ/TU9XK5ZkPSd+ltG76MiRKoLyiilgpM/00a8VYApoyvwu7YkYJf/
         C6feIk1BQfnaG0ombx8+xJnnVK5VAOdgSd4VVcAAsOcR8zmeWecLPJy6cP/v7kDx2BlC
         XYz4CYFP/2NbSWnq9FJyLQOB+lI06aBmlzwB985zY/4EApoyKqS1d/9uIhWeFYO/+MY2
         48eg==
X-Gm-Message-State: AN3rC/5JvxpW1HyztewEmwEjX2PdTJ368QcNiYgda2Basjp1NRcKcjD0
        MM+8MBocgzPJyg==
X-Received: by 10.55.204.16 with SMTP id r16mr15211697qki.169.1494009836004;
        Fri, 05 May 2017 11:43:56 -0700 (PDT)
Received: from localhost.localdomain (gwmind.semfio.usp.br. [143.107.127.12])
        by smtp.gmail.com with ESMTPSA id p184sm3733369qkb.17.2017.05.05.11.43.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 11:43:54 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH 0/3] Port git-add--interactive.perl:status_cmd to C
Date:   Fri,  5 May 2017 15:43:37 -0300
Message-Id: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hm, it looks like my GSoC project won't be in the Git organization,
although I'm still interested in going for this so I guess I'll send
patches to implement my proposal anyway (although certainly in a slower
pace than I would if on the program).

This series introduces git-add-interactive--helper (or should it be
called git-add--interactive--helper?) as a builtin capable of doing
what the Perl script's status_cmd() would do.

I wish this patch series could have been smaller, although I don't
think it would make sense to bring add-interactive "subunits" smaller
than a command to the helper, and status_cmd (aside from probably
add_untracked_cmd) was the simplest one to do after all -- and still
required ~250 lines on the new builtin.

Another regret I had was not being able to retire any code from the
Perl script yet (and will likely not be able to do so until all
commands have been ported), but that is not such a big thing after
all.

As for the new builtin, I think the color handling code is pretty
straightforward. In fact, it was practically copied from places like
clean.c or diff.c (which makes me wonder if some of that code could
be generalized to avoid duplication). The same goes for the pretty
simple option parsing code.

Bigger issues seem to arise when dealing with getting the numstat.
While (as Junio anticipated on an RFC) some tasks like getting the
actual diff and splitting it may require making the "diff
machinery" write to a temporary file that we will read and do things
with, I think it would be weird to do that for parsing a simple
numstat from it. My first instinct was to create something like
show_numstat_interactive() or something on diff.c (analogous to the
other show_* functions). Doing that, however, would stumble upon
another issue: we would not be able to print both a file's diff
against the index (obtained from run_diff_index) and against the
worktree (obtained from run_diff_files) in that function. The solution
I came up with was to export the diffstat interface from diff.c into
the world and allow our new builtin to use that and build our status_cmd
output. Unless this breaks some rule of Git's API design, the result
seems pretty reasonable to me.

Travis CI build: https://travis-ci.org/theiostream/git/builds/229232202

Looking forward for feedback,
Daniel.

Daniel Ferreira (3):
  diff: export diffstat interface
  add--interactive: add builtin helper for interactive add
  add--interactive: use add-interactive--helper for status_cmd

 .gitignore                        |   1 +
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/add-interactive--helper.c | 258 ++++++++++++++++++++++++++++++++++++++
 diff.c                            |  17 +--
 diff.h                            |  19 ++-
 git-add--interactive.perl         |   4 +-
 git.c                             |   1 +
 8 files changed, 282 insertions(+), 20 deletions(-)
 create mode 100644 builtin/add-interactive--helper.c

--
2.7.4 (Apple Git-66)

