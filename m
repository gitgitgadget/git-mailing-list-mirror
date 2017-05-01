Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9E61F78F
	for <e@80x24.org>; Mon,  1 May 2017 19:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbdEATH6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 15:07:58 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32896 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdEATHz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 15:07:55 -0400
Received: by mail-pf0-f177.google.com with SMTP id q20so24472228pfg.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Gub0FcYGmqqHXSMAHahiMj0FXfRUgpKmGVWapqRmKXQ=;
        b=E3ktIWA2VSk+Si9xT65ZniXNiFVsi0RwqRd0scvhMm7X+z6cF/MCPKDxduOFUFBk3S
         3yFGt+bsfIQvTYOGN3eGmBuH3w6rJRQQzltUfLA+k4ctyU+Fq59878ny40LbBRYiU5+c
         QvjC4BxCUcTPPJMhhJ/wP1y7BP+HRqJTpBlri8hp4aQqqoWGYcpi5Nlgf1O56cqxW9I1
         GGCmXODrUOD21Qz3jHmI3MqABBc4OhP0RIs5RK5CY3y0q7oKEvG8QcMBihCnYQhgEUGD
         AgV75iFqH5RheHzbDlQSKpH35jnJEPhaTL2QUY/0xl0x9hwxtqf+q5Mfaxiio1nWQWXc
         LHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gub0FcYGmqqHXSMAHahiMj0FXfRUgpKmGVWapqRmKXQ=;
        b=FJf9x8JZUkgg/Jwg10GBgJ3CjuA0zxI5RhZUNpPjrJTXz6i/ZynaoZRxqA5pPBz/Xs
         WOMNqYr1ccvD3jCYwJe87gY5yZOmrsLhYtDlTDwpj75QUF3+0Tcjeg10NHl9acr0vroR
         H4cIodFh85NT6xwimWQYyyMo7DXxK15iA9uHh3k2JJlUgMejnSiweAvax673MMfgpeeJ
         KovOrMVjEkXWkRHveNUeN6tpjJp55dWKkXTOf5rtBKbof/jFl4Sq0T98vg2vbn6ZTKWE
         KJNJjXSWHbfcc1gSzifFgx5OXcwxQ8Cd0MstC+W4W/A43yWX+fm+z+v0Td54xulNCz9a
         UDzw==
X-Gm-Message-State: AN3rC/6Xm2qHiVQPBUPnxV3tPx9T55o3+53KGq3XNMSReIW+PD2o3b41
        4uY8C6rUMJnwG3GM
X-Received: by 10.99.114.22 with SMTP id n22mr28721492pgc.163.1493665674193;
        Mon, 01 May 2017 12:07:54 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c4be:9746:6a14:c7a4])
        by smtp.gmail.com with ESMTPSA id p62sm25016422pfi.7.2017.05.01.12.07.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 12:07:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
Date:   Mon,  1 May 2017 12:07:14 -0700
Message-Id: <20170501190719.10669-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.1.gbc33f0f778
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This applies to origin/master.

For better readability and understandability for newcomers it is a good idea
to not offer 2 APIs doing the same thing with on being the #define of the other.

In the long run we may want to drop the macros guarded by
NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.

My main reason for this patch is to try out coccinelle as well as a
discussion I had off list about maintainability of software.

I just made these patches and wonder if now is a good time to pull through and
convert the rest as well?

Thanks,
Stefan

Stefan Beller (5):
  cache.h: drop read_cache()
  cache.h: drop active_* macros
  cache.h: drop read_cache_from
  cache.h: drop read_cache_preload(pathspec)
  cache.h: drop read_cache_unmerged()

 apply.c                              | 10 +++----
 builtin/add.c                        | 10 +++----
 builtin/am.c                         | 14 +++++-----
 builtin/blame.c                      | 10 +++----
 builtin/check-attr.c                 |  2 +-
 builtin/check-ignore.c               |  4 +--
 builtin/checkout-index.c             | 10 +++----
 builtin/checkout.c                   | 53 ++++++++++++++++++------------------
 builtin/clean.c                      |  2 +-
 builtin/commit.c                     | 32 +++++++++++-----------
 builtin/describe.c                   |  2 +-
 builtin/diff-files.c                 |  4 +--
 builtin/diff-index.c                 |  6 ++--
 builtin/diff.c                       | 14 +++++-----
 builtin/fsck.c                       | 14 +++++-----
 builtin/grep.c                       | 10 +++----
 builtin/ls-files.c                   | 38 +++++++++++++-------------
 builtin/merge-index.c                | 12 ++++----
 builtin/merge.c                      | 14 +++++-----
 builtin/mv.c                         | 12 ++++----
 builtin/pull.c                       |  2 +-
 builtin/read-tree.c                  |  4 +--
 builtin/reset.c                      |  4 +--
 builtin/rev-parse.c                  |  2 +-
 builtin/rm.c                         | 18 ++++++------
 builtin/submodule--helper.c          | 10 +++----
 builtin/update-index.c               | 52 ++++++++++++++++++-----------------
 cache.h                              | 10 -------
 check-racy.c                         |  6 ++--
 diff-lib.c                           |  6 ++--
 diff.c                               | 10 +++----
 dir.c                                | 20 +++++++-------
 merge-recursive.c                    | 30 ++++++++++----------
 merge.c                              |  2 +-
 pathspec.c                           | 14 +++++-----
 read-cache.c                         |  4 +--
 rerere.c                             | 32 +++++++++++-----------
 revision.c                           | 22 +++++++--------
 sequencer.c                          | 27 +++++++++---------
 sha1_name.c                          | 16 +++++------
 submodule.c                          | 16 +++++------
 t/helper/test-dump-cache-tree.c      |  4 +--
 t/helper/test-dump-untracked-cache.c |  2 +-
 t/helper/test-lazy-init-name-hash.c  | 10 +++----
 t/helper/test-read-cache.c           |  2 +-
 t/helper/test-scrap-cache-tree.c     |  4 +--
 t/t2107-update-index-basic.sh        |  2 +-
 tree.c                               |  8 +++---
 wt-status.c                          | 12 ++++----
 49 files changed, 309 insertions(+), 315 deletions(-)

-- 
2.13.0.rc1.1.gbc33f0f778

