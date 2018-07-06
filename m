Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285761F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 12:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeGFMIp (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 08:08:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43418 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753705AbeGFMIo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 08:08:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so8303156pfm.10
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BWiJce84OnyC/m/8zPTnxmtggg4dkUk9rTTvJ3CXoAw=;
        b=LEf0MbcJ8j56s0YynNXz4/8X5VRG+jQCJ5qiCg3+LDfSpkUYEPCGDftsj+8ctvjEO4
         t53tdw/npyOceol0ipv0/w+q1TVCJ5+artvMHlyIJoNSPZMd0v/8LQD5kTzAm4PqtkMX
         LU8bwE9DCKEAkasD4k77TO/b3A2sfau3aelUeMg8yDnps5l4QPswOZVhUrpYJEjXQfyR
         GA6x89N+b3InhfGJklDpaV45rfMX/Ow6n9KvG1+R+K0EUpTypbGf6jVzdeBnEAMLPVmy
         MWnJUtRK2MSu7RCKfXk0pVGh+3ad+akvhnYA64hRUqEk0JVCcg5XGGjjcUOySbr+aM6L
         fMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BWiJce84OnyC/m/8zPTnxmtggg4dkUk9rTTvJ3CXoAw=;
        b=XLtvORoCcT84mcnzz4bxOjvR68CEBHVH+HHF8CbAh6AY7dCKZm9CCNaxOV4Z1yhIXA
         E+hVK0Ns2foCT4BcBXFST18Nl6aZJsZ+NFtls3SlvXzwCQHy4wtx4/tdLPhkVkvyN51Y
         NYTcAZVNzb8evxuHojHnKeY0s/+DdxZsQH6ioiK4ACAlYvkUrvNhFcj3HLkG/tlAAqxK
         z+FnTkOsfOvO+9iZK0rOcV9ghBB91M70e62VCInMPAf4J1ce2pKyBZ+mbhQ4qCcqWMwG
         POPiQKwhjfEmoNpHEDm/A10TKw4X2wwmtxrOiYdzNTblIC8rUXKrHFGw/8Ndcpplj1II
         3PsQ==
X-Gm-Message-State: APt69E25loIOfH20ZAAfRzr+d774vCNkYqcgrNjKOxrrT/8WpldV+l5a
        SbgQ6bH5kY2R+Ncwm6JMOn9EgihFlLA=
X-Google-Smtp-Source: AAOMgpdZWR0dZk5VuuRk59DoB249mFFrCaSO3hgh6ACC4FwambsfhQMw2nUaIPtLp63UH8/T7MYYcQ==
X-Received: by 2002:a62:ed13:: with SMTP id u19-v6mr10384276pfh.125.1530878924059;
        Fri, 06 Jul 2018 05:08:44 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.186])
        by smtp.gmail.com with ESMTPSA id j23-v6sm13925519pfi.137.2018.07.06.05.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 05:08:43 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH v3 0/4] rebase: rewrite rebase in C
Date:   Fri,  6 Jul 2018 17:53:11 +0545
Message-Id: <20180706120815.17851-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180628074655.5756-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a GSoC project, I have been working on the builtin rebase.

The motivation behind the rewrite of rebase i.e. from shell script to C
are for following reasons:

1.  Writing shell scripts and getting it to production is much faster
    than doing the equivalent in C but lacks in performance and extra
    workarounds are needed for non-POSIX platforms.

2.  Git for Windows is at loss as the installer size increases due to
    addition of extra dependencies for the shell scripts which are usually
    available in POSIX compliant platforms.

This series of patches serves to demonstrate a minimal builtin rebase
which supports running `git rebase <upstream>` and also serves to ask for
reviews.

Changes since v2:

  -  Fix commit messages of patches.

  -  Acknowledge Junio's reviews.

  -  Demonstrate an alternative approach to setting of environment variables
     via `run_command_v_opt_cd_env()` which would be visible by spawned
     process from rebase backends as this is not safe.

Pratik Karki (4):
  rebase: start implementing it as a builtin
  rebase: refactor common shell functions into their own file
  sequencer: refactor the code to detach HEAD to checkout.c
  builtin/rebase: support running "git rebase <upstream>"

 .gitignore                            |   2 +
 Makefile                              |   4 +-
 builtin.h                             |   1 +
 builtin/rebase.c                      | 291 ++++++++++++++++++++++++++
 checkout.c                            |  64 ++++++
 checkout.h                            |   3 +
 git-rebase.sh => git-legacy-rebase.sh |  62 +-----
 git-rebase--common.sh                 |  61 ++++++
 git.c                                 |   6 +
 sequencer.c                           |  58 +----
 10 files changed, 437 insertions(+), 115 deletions(-)
 create mode 100644 builtin/rebase.c
 rename git-rebase.sh => git-legacy-rebase.sh (91%)
 create mode 100644 git-rebase--common.sh

-- 
2.18.0

