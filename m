Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A16208E9
	for <e@80x24.org>; Sat,  4 Aug 2018 01:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeHDDwK (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 23:52:10 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:34090 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbeHDDwK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 23:52:10 -0400
Received: by mail-ua0-f202.google.com with SMTP id n10-v6so3965296uao.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 18:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WsCGrc0C4LCgXMFHyrlwtVyN6esU6s32UWCDUWshj0s=;
        b=tIJeRzw0J93w7pITJjbKL8tCEoS/Yfezx9XUS+cGl7byHoxlahaz3hnOgf/OTRSY2U
         xnS3Db+Q1zIDGkB3wiaFJlbjFzT56TMclV+CkHD7HVYwahGDIh7RpNz9wuBprNNyhquI
         NA/W4OCtBKYKJwX4iRaociDHV73wKW15YdT6uXSrVAVnmWrFg0L5OcFJfTfiFtZGSc3M
         GOkcUfU8kCADfxhGTZxmI6aRhcDU4gMPbASvh1eLDUEkE2SGnTWrYW3gvqXgesrm3+Zp
         9rUPW0W9SvzOQdwMC38WQEdqrUNiCklzgkF7XLAeai+uojMf7rebgJw7Gq/rX+cmZrF2
         VS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WsCGrc0C4LCgXMFHyrlwtVyN6esU6s32UWCDUWshj0s=;
        b=jHEWYckl8gde0E+1Qbe9DNyfrYri45Yj/JKyvJAlfrd+6qwW8GUn0CVtWp2gy8e2H7
         Ncq72dq3sggVWf0ny61pM/pnwXAxqEXd7Dsrvt6Rqfe89CX5ktXO0HwSEg7iWK9wE1u9
         eddQrYI1WaJMjr5ZnCSh8proVRfzW8OSCdio/zpAxwdYalTCozepVohIGyyVTmXaU/5f
         LDVbjYlZ604FuAczqgExwaLoR6ppPwxDotJJNx/n74FIUgacezPPqAsH10N4jbqoP4jn
         2Vc2fn8RprwdmjCDc/ivuEOKH6T+wtlGFJds6cXYu/9Zz6JKcnu8bOI4bDpDbCxb52sc
         Esfw==
X-Gm-Message-State: AOUpUlGSr+BAOPeKxu8zlhYo3tkHDx5CqEbzmY85Tcos5T2nPcSVl/Ro
        soJZ8lESjwwQCoy6v3SyAD67+7oH2Wxeh7GEiLK7rT789NxFyPVQ7hL4EcQW8s+Yl5K1lDiCvlx
        XJ7uSnUzcbhp8FrtAeMM19VSR9YaP9Sgb2thne9CwQdgir6X0udSKtXGwzNNb
X-Google-Smtp-Source: AAOMgpeKKf60YRSC467TYLa/A+PlkohjJl+a9l+FTZakxNxJU74UU0I+uq/EgT+8caP46URUc8rvYkKXpWv9
X-Received: by 2002:ab0:50d7:: with SMTP id d23-v6mr4479001uaa.125.1533347601177;
 Fri, 03 Aug 2018 18:53:21 -0700 (PDT)
Date:   Fri,  3 Aug 2018 18:53:10 -0700
Message-Id: <20180804015317.182683-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 0/7] improve range-diffs coloring and [RFC] move detection
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This builds on top of sb/range-diff-colors, which builds on js/range-diff.
As Thomas seemed happy with the range-diff and said
"and fwiw I didn't think there's anything major that needs to be addressed."
I found it reasonable to build more on top of those series.
[1] https://public-inbox.org/git/20180729215053.GE9955@hank.intra.tgummerer.com/
It can also be found via
  git fetch https://github.com/stefanbeller/git moved-in-patches

This series provides for 2 goals, which share a common base refactoring:

The refactoring part is to allow the diff machinery to prefix
old/new/context lines with prefixes as chosen by the user.

The first feature is to slightly adapt coloring of range-diff to have the
file markers

  --- a/diff.c
  +++ b/diff.c
  
be shown as context color. This is done by using custom prefixes for
old/new/context lines in the inner diffs and indenting all other lines
instead by a white space indicating it to be context.

The second feature is more RFC-ish in nature and just exposes the
mechanism to the user in a meaning-ful way.
All of the diff family (including format-patch) as well as apply/am
can use */~ instead of +/- for moved lines of code.

Thanks,
Stefan

Stefan Beller (7):
  diff.c: emit_line_0 to take string instead of first sign
  diff.c: add --output-indicator-{new, old, context}
  range-diff: make use of different output indicators
  range-diff: indent special lines as context
  diff.c: rename color_moved to markup_moved
  diff.c: factor determine_line_color out of
    emit_diff_symbol_from_struct
  diff/am: enhance diff format to use */~ for moved lines

 apply.c               |  12 +++
 diff.c                | 180 ++++++++++++++++++++++++++----------------
 diff.h                |  10 ++-
 range-diff.c          |  17 +++-
 t/t3206-range-diff.sh |  12 +--
 5 files changed, 153 insertions(+), 78 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

