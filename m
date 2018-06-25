Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9AB1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 13:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755533AbeFYNop (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 09:44:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35231 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755345AbeFYNoo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 09:44:44 -0400
Received: by mail-wr0-f194.google.com with SMTP id c13-v6so3801376wrq.2
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+Qn+7PYQAGaSVAE+j747RwM3QLbgjL5FUZaa46h9W0=;
        b=tgsfJHutt0aYpLazU7Mii1LDApHW+dgfj0S6Oj7+KQ24t2uMGnXCh8KNKJIwCWhmAV
         YqY8klyxwG4TreeKSihF16TMTzqfb07erxeYFG3es6LEq/SJy1wgXDl9+GKcZ7WY4TRd
         EoMotuw1RYt27RO1TTvsiQZ+jg+KgPhXikZ/nwc2ItFpFU3CqN/a8FmTegr+ZMoyQpQb
         WSgrYq9l+87frBkNJD2+3sR1ba/oPI0U4Io9G0k39nljt3opHqdFN2rWT0e8lhbidwgd
         Ktif7/McVSRgsazTAEWdxDVjD5ihFGXXpG3PmrIy7A09u2hoSGqd8PzahP0o+/a1MbNw
         2hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+Qn+7PYQAGaSVAE+j747RwM3QLbgjL5FUZaa46h9W0=;
        b=qNQ1jWUEZCJLFBzCeaDYwTfehudfS383H9fNR2dUG6/hYv7Q/rCne8GVkR3cwI3WdI
         YiELQh5YaxDf/BC6y0iJ10IBwjvFkkujnrYLKTF78G9mn38uX6g5gYno2bJD49U2gUms
         SrL0Nvqod5o9sdw1WgOexBYcZ+c8ULjLCK6z+qAa8R95ctKdt6n/2rTUuvhiLNXp6qnG
         5Z76pNSfLVggIQ4G0VO0iDiMGlHQKfSyRgpVXEZ/C0JOBXIpebFY04Lc69HDaMNtpq/s
         0f1DY6ltR2qFKdn9vVPGAMc57iPNo9GxLKbjbNW5x9o6MISGlnawfzePU1e6YzRy5Lin
         BR3g==
X-Gm-Message-State: APt69E1qxHPANOdFVcL7YpGuCjT5Qqr9/9hFLpC0586NZ0ZWO5IdkYmP
        bQfaq5qzkHxBrIszJC6CQKTcjw5U
X-Google-Smtp-Source: ADUXVKLdbYrk+acca/rxCPXyWoO//H0QOEV6SMT9TL7SfaubbAtE2yY4yVpDEIpR0UWaDozWHnAqzg==
X-Received: by 2002:adf:ec89:: with SMTP id z9-v6mr10875916wrn.160.1529934283446;
        Mon, 25 Jun 2018 06:44:43 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id 13-v6sm11020369wmi.2.2018.06.25.06.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 06:44:42 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 0/3] rebase -i: rewrite reflog operations in C
Date:   Mon, 25 Jun 2018 15:44:16 +0200
Message-Id: <20180625134419.18435-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180621141732.19952-1-alban.gruin@gmail.com>
References: <20180621141732.19952-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series rewrites the reflog operations from shell to C.  This
is part of the effort to rewrite interactive rebase in C.

The first commit is dedicated to creating a function to silence a
command, as the sequencer will do in several places with these patches.

This branch is based on ag/rebase-i-rewrite-todo, and does not conflict
with pu (as of 2018-06-25).

Changes since v3:

 - Removing a comment from run_command_silent_on_success()

 - Changing the order of setup_reflog_action() and checkout_onto()
   rewrites in the series

 - Renaming checkout_onto() to detach_onto()

 - Renaming checkout_base_commit() (rewrite of setup_reflog_action()) to
   checkout_onto()

 - Using the `else` keyword to call run_command_silent_on_success() or
   run_command() in run_git_commit() and run_git_checkout().

Alban Gruin (3):
  sequencer: extract a function to silence a command, except if it fails
  rebase -i: rewrite checkout_onto() in C
  rebase -i: rewrite setup_reflog_action() in C

 builtin/rebase--helper.c   |  13 ++++-
 git-rebase--interactive.sh |  28 ++--------
 sequencer.c                | 101 +++++++++++++++++++++++++++----------
 sequencer.h                |   6 +++
 4 files changed, 97 insertions(+), 51 deletions(-)

-- 
2.18.0

