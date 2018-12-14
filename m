Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F8520A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbeLOAAH (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:00:07 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:36270 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeLOAAH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:00:07 -0500
Received: by mail-qk1-f202.google.com with SMTP id b185so6525330qkc.3
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hp43ehZaH75QI1/WxYtjNzcjRWwPQWLhAHKpahFJml8=;
        b=FED1/T0Hwe4O6FzcHvTDEu+NYb4UudgfFmnnA0vB/vuB1OuYVjxZkb86Jby7Fke/hc
         LpiUmPH0lFacpkqMKutOYdbWhl9arDMkHoXiuMO1gBy4/fbV4t7PlBnt57AOC8ZSvWM/
         CKZ3txfv9P+K/oS6bDMBtnG2lGHuF874YqUjk4iJz+7BX3IwxANCbITzeG60xa6MlxdS
         ZJxI095Sj8EIyr0XHmsfov6PertOWdeoRjWEDg/gCpujl7McTZsnYZqStGj0yxelsZvK
         8IEm+RdLIZCWfCJWRZFGYZ1mHlC/UHh96fay8/k+4AVIwIXaCJQsAWJzYudURgOokWbX
         lfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hp43ehZaH75QI1/WxYtjNzcjRWwPQWLhAHKpahFJml8=;
        b=Trn58//2X+joYJQFqJBFD99qCydBX7Ek7Ohx3+TCDgly59xGkw86UdTfeFeyGh07fq
         ffdzNz2naqTiV78Ci1qgT8IPgs2dqsKLVthUWDlQYD+ha/G+KeFEncvDe5gsTmKbaJ/u
         pRjUOKIXR8AJWboQ4a1biBzVmQXEKK7CSnwgKl6ZIB7K4v1U6UVXlc3dJBnbiTiLiH94
         jHFMXYgz4iWg7J892hme0/DyuIPDPBEuvph5WzM/1sKTI1dH+tDsV/3ipFQFQoOW1eBb
         UTe7an2ZQxhMySiR6Ni1rCibuDvMqP5Nfx48sFNEFgU6+FkJ16KN8Dubsvn6RQaiQf03
         kvvA==
X-Gm-Message-State: AA+aEWY9VMEf/BaykZv+GBbS7pG8ab0PmDcfAJmNkq/4uAR5i+QFOP4e
        Ge1x/e4P+kYjJ0EFHlU9wKakNPnhuAqJ
X-Google-Smtp-Source: AFSGD/XrKMCeQ+gQaFKhQL/1bIQHFL9IKsQxWbMKrEVg/hZK7zsPspW9jIUCbkftxokfnCZ+GcFllhVkV/+v
X-Received: by 2002:a37:6647:: with SMTP id a68mr4889170qkc.16.1544832006337;
 Fri, 14 Dec 2018 16:00:06 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:59:41 -0800
In-Reply-To: <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com>
Message-Id: <20181214235945.41191-1-sbeller@google.com>
Mime-Version: 1.0
References: <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 0/4] submodules: unset core.worktree when no working tree present
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
I reworded the commit messages to explain the patches from the ground up
instead of only linking to the old commits, that got reverted.

> Just pretend that the ealier commits and their reversion never
> happened, and further pretend that we are doing the best thing that
> should happen to our codebase.

I disagree with that first stance (I can freely admit those commits happened),
but agree on the second point, so I explained why the code is the best
for the code base now. So I kept those pointers in there, too, to make it
easier for future code archeologists. 

v1:

A couple days before the 2.19 release we had a bug report about
broken submodules[1] and reverted[2] the commits leading up to them.

The behavior of said bug fixed itself by taking a different approach[3],
specifically by a weaker enforcement of having `core.worktree` set in a
submodule [4].

The revert [2] was overly broad as we neared the release, such that we wanted
to rather keep the known buggy behavior of always having `core.worktree` set,
rather than figuring out how to fix the new bug of having 'git submodule update'
not working in old style repository setups.

This series re-introduces those reverted patches, with no changes in code,
but with drastically changed commit messages, as those focus on why it is safe
to re-introduce them instead of explaining the desire for the change.

[1] https://public-inbox.org/git/2659750.rG6xLiZASK@twilight
[2] f178c13fda (Revert "Merge branch 'sb/submodule-core-worktree'", 2018-09-07)
[3] 4d6d6ef1fc (Merge branch 'sb/submodule-update-in-c', 2018-09-17)
[4] 74d4731da1 (submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree, 2018-08-13)
Stefan Beller (4):
  submodule update: add regression test with old style setups
  submodule: unset core.worktree if no working tree is present
  submodule--helper: fix BUG message in ensure_core_worktree
  submodule deinit: unset core.worktree

 builtin/submodule--helper.c        |  4 +++-
 submodule.c                        | 14 ++++++++++++++
 submodule.h                        |  2 ++
 t/lib-submodule-update.sh          |  5 +++--
 t/t7400-submodule-basic.sh         |  5 +++++
 t/t7412-submodule-absorbgitdirs.sh |  7 ++++++-
 6 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.20.0.405.gbc1bbc6f85-goog

