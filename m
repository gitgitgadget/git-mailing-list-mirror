Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E3920A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbdLERwu (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:52:50 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35103 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdLERwt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:52:49 -0500
Received: by mail-it0-f65.google.com with SMTP id f143so3552134itb.0
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 09:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9fGsSooy7ivMe1epwkDD4phdrOyTEDuNUWu3Bhz3K7M=;
        b=cgjl0w21tAEgvovLU4NjeadYsjvZRWPEa9L16ZdZmbzemQK+XQW7uS2GBqPRk6/AKQ
         UA5BU5VIXZatI4xCMPMPHTcnY1b6Cb9aEUjjVsEJSXLWVaC1Hr+O2lzKk6jUXzFhOa0E
         oBl+PpMCBk0rCZoqJKR/1BepmZxXFbM3oaIg3N/FN+75Ahxxtqcsgorkf3JOCVZ4JX2H
         QyTpv83PCDjVWlEtGPdvUHeJzO4vR5M+bvAmHL4Xu44Rvd7atH6Pj60nLHnjgzUBUwFW
         UbhhEj5ISChv1lyyw0B7ljjUyG5NcZInytdQDQNiUANrtwAj3KuKlTh/9x7rbnMxpd4w
         NyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9fGsSooy7ivMe1epwkDD4phdrOyTEDuNUWu3Bhz3K7M=;
        b=OTse3IvM89ytv3X5SYVuYs18pQk6rMhKUmze5jmptgKcJO8N1lbwT5WlumHvu+sAMz
         /xKlilKlyroYBmW08jJhxXZQaQZ64UM49YBlnV1HV96F22ou1B6Y0MFmiOWjaQ8sUXYF
         ZNn5JkcNzykqAarVtRmmCbV5O+qSSunI4EHMTfu008qK9//7gtSEGW75PH8tROHAx5s2
         ZDX+HzLm+3lis7dLDCEWR470NkSFbG0/Ut7WHSNM4zUbmjWWyLfyo968J2PHn27U0NU/
         xerNH0owogH2wgcmmGhRJI4ICsTD3SBCx18p8pcdLNR7C8qNgbxV70UTgh/hhEHs9Mfh
         F0Hg==
X-Gm-Message-State: AJaThX55mg6u7dBqcGYcNyBJiH8dxEjhNkq4tf9CFXbYK0j1bkUDb4Q4
        88tFjFYLX3jwmTyLQQK3HNLRYvbXaP0=
X-Google-Smtp-Source: AGs4zMawYAojrZpRiNGcali32oG/zUQq+mJBvSZTloqvHh/pF8roFhYWRuUMiSdBoAPWEQ1GOtcpVg==
X-Received: by 10.107.47.197 with SMTP id v66mr30051075iov.102.1512496368763;
        Tue, 05 Dec 2017 09:52:48 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i195sm264737ioi.44.2017.12.05.09.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 09:52:48 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 0/9] rebase -i: add config to abbreviate command names
Date:   Tue,  5 Dec 2017 12:52:26 -0500
Message-Id: <20171205175235.32319-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.gbdce6e0789cb
In-Reply-To: <20171127045514.25647-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

This series will add the 'rebase.abbreviateCommands' configuration
option to allow `git rebase -i` to default to the single-letter command
names when generating the todo list.

Using single-letter command names can present two benefits. First, it
makes it easier to change the action since you only need to replace a
single character (i.e.: in vim "r<character>" instead of
"ciw<character>").  Second, using this with a large enough value of
'core.abbrev' enables the lines of the todo list to remain aligned
making the files easier to read.

Changes in V2:
- Refactor and rename 'transform_todo_ids'
- Replace SHA-1 by OID in rebase--helper.c
- Update todo list related functions to take a generic 'flags' parameter
- Rename 'add_exec_commands' function to 'sequencer_add_exec_commands'
- Rename 'add-exec' option to 'add-exec-commands'
- Use 'strbur_read_file' instead of rewriting it
- Make 'command_to_char' return 'comment_char_line' if no single-letter
  command name is defined
- Combine both tests into a single test case
- Update commit messages

Changes in V2:
- Rename 'transform_todo_insn' to 'transform_todos'
- Fix flag name TODO_LIST_SHORTE{D,N}_IDS

Liam Beguin (9):
  Documentation: move rebase.* configs to new file
  Documentation: use preferred name for the 'todo list' script
  rebase -i: set commit to null in exec commands
  rebase -i: refactor transform_todo_ids
  rebase -i: replace reference to sha1 with oid
  rebase -i: update functions to use a flags parameter
  rebase -i -x: add exec commands via the rebase--helper
  rebase -i: learn to abbreviate command names
  t3404: add test case for abbreviated commands

 Documentation/config.txt        |  31 +-------
 Documentation/git-rebase.txt    |  19 +----
 Documentation/rebase-config.txt |  52 +++++++++++++
 builtin/rebase--helper.c        |  29 +++++---
 git-rebase--interactive.sh      |  23 +-----
 sequencer.c                     | 126 +++++++++++++++++++++-----------
 sequencer.h                     |  10 ++-
 t/t3404-rebase-interactive.sh   |  22 ++++++
 8 files changed, 186 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/rebase-config.txt

-- 
2.15.1.280.g10402c1f5b5c

