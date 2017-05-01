Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223911F78F
	for <e@80x24.org>; Mon,  1 May 2017 22:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbdEAWrd (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 18:47:33 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35337 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbdEAWrc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 18:47:32 -0400
Received: by mail-lf0-f53.google.com with SMTP id 75so66315966lfs.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=n7LDLESr/aeG91x6bdKZ5PphT+p9pINhjPr+h6E50VY=;
        b=a990ah6Q4CG02Q0Ftu5az4Blqq+LZ/SW3yvP7mB41MjXxhwVyEAfbO+QTiYvoOrzdD
         n+OHAeguIkKhVKy1pNYuBhlxtZh/83qARHTSPckVb95XlYBltAKB1BxRlRpc88X6T3hL
         G+x8YMVADm1oiN/ePmS7uQtM7RaCNfbpv5yxzH0/Bc8xmJEFPRyhSfLjNH4iX/GMcRzy
         /a8lvO73fBKHkz4aEGVvLlKtSjzRFBDdpkwCokoEyVn1eWYnlYvIYu0bDzF1tf+gt4N2
         ecOFDDeVo2PDy94vPWdUQ6FB/7fvj6QGsJWLA8TdiGdqiM5MGLhl5IK8ze7J+fMjkGUH
         RQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=n7LDLESr/aeG91x6bdKZ5PphT+p9pINhjPr+h6E50VY=;
        b=ujGzqhhkqBC4h6ij5fmTYum4NwizftzR+/cfmX+j2rpAexop9m3WjlmUfZCEFKiYt+
         t0N6h3SYXBHMvUEjhF9E0WLVuHMkSq3oux/DHpnG7SKW5k97Fbhg0tqP/+BVV1IXFS8Z
         eQv9IFn6/qIJihJnlLWeSxD63oDC5erVsENAWADNkhHo8V8+oW7W/E0hq7de0dWkmeA6
         eH27TinWHFpvxVAbUaXCMzn4igyzUY4q7lsOvOeD4jwK1It/N7p3DC8HNZTQ09ZrRC3u
         K9KYn1I4zRisxtXV7QsQdjLlavyPKO/T5cGoviLPR8ig53bS8i5ZQVxTzJ28qJ1QkueD
         RCLA==
X-Gm-Message-State: AN3rC/6gSDJ7rbbHen3XFAGNq+X7JQsQglysGSmDBXcHaHk4iPWqB1TR
        lG1tlMK/sq0OLQY++wp+0LoY5uiUwA==
X-Received: by 10.46.6.1 with SMTP id 1mr9863252ljg.69.1493678850262; Mon, 01
 May 2017 15:47:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.193.136 with HTTP; Mon, 1 May 2017 15:46:59 -0700 (PDT)
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Mon, 1 May 2017 19:46:59 -0300
Message-ID: <CAEA2_RLvjRDytE03hfe84TTqvCQm324BXV=GvTU3UVqNWJUXiQ@mail.gmail.com>
Subject: [RFC] [GSoC] Port git-add--interactive.perl:status_cmd to C
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there,

So, in the GSoC proposal I sent about porting git-add--interactive to
C[1], I expected I would be able to do a couple of small patches to
git-add to familiarize myself with the Git API and have a better clue
of how the porting process would go by. Due to the unexpected size my
microproject ended up taking (though in a good way, I think) I chose
to focus on that and ended up not sending those anticipated patches.
However, I *did* have time to study how I'd go for the port more
closely, and I'd like some comments on what you think of it. Be I
accepted or not into GSoC some days from now, I think the topic might
interest others that might want to tackle this task.

As I went through the code, I grew to believe that a good way to make
a step-by-step conversion might be to get add--interactive "commands"
(as in status_cmd, update_cmd, add_untracked_cmd etc.) ported one at a
time over a set of patch series. For each series, one X_cmd Perl
subroutine would become a one-line call to
"git-add-interactive--helper X <args>" (a builtin). This would make
understanding a function as complex as list_and_choose() to being
ported to C way easier: for each command, a new functionality would be
added on-demand instead of having the whole function sent over at
once. Afterwards, a final series would likely set up the "interactive
main loop" in C and retire the Perl script.

I tried to apply this philosophy to porting `status_cmd` to C, and
easily got most of the configuration/color logic into C by mimicking
what builtins like clean.c do.

The next issue I came up with (and do not yet have a solution) is how
reproduce git-add--interactive's list_modified(). The Perl script runs
git-diff-index and git-diff-files, does some clever string parsing of
their outputs and "merges" the output of both in a single table to
display the number of added/removed lines in a given file BOTH between
HEAD+index and index+tree.

Reproducing either of these comparisons "natively" would simply
require running run_diff_index() or run_diff_files() with
DIFF_FORMAT_NUMSTAT and tweaking diff_flush() to format appropriately
for the "interactive--add case". Furthermore, the current output
prefix options would manage to cover the eventual case of `update_cmd`
selecting files. To output both comparisons, however, I can't come up
with any simple solution. Would you have any ideas?

-- Daniel.

[1]: https://public-inbox.org/git/CAEA2_RJEf4vjgcaux8a1KWh1-vxLLmv1--Vjf9wiEQoF+gVDtA@mail.gmail.com/
