Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1B9B1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeGaTlr (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:41:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53690 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbeGaTlq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:41:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so4065974wmh.3
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/E7zOIrLMh7C2OW7O8hVNotoXNFOj9DmrxUxndGOGU=;
        b=VwtzwqAdIdVhTPAySuFz2e8gkUVQAQM4ENTRLoSxYBy9nMIotLiYVLecFCW6hVufye
         R/0VwhJd5TphJKpnCiRknyk1WvoWmZvHQjaZAF3/uOdDRt+leXGSoE31aKSoEz5W8nI3
         mO3UZUIaQNcd0hk8EKAxT+ys1MhRDj55KsEPPCAJywexd900DxjleC2V3KjZ7VUQSDx1
         M/OxOkC8xmNUKcshgU/p7hTgOpDjKU4hCwOu1Z+4408UoSBkmEDq+048igZTmv7fdVL9
         cyWN2dikaUEiHXPyLX+h0nD1eOR4LKAuF/TQADE14K5IbX9iU9E/63ly/CEVcE2Na7Jz
         zhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/E7zOIrLMh7C2OW7O8hVNotoXNFOj9DmrxUxndGOGU=;
        b=WJMu0mlBe16dBpn6cUfQ9m9Jmk3hm6ltWOtYkp0Nx5jWJU8TVdgsTi7Ly3NyP9nB/y
         Od67Drqc4bfBovo8DSqaPI430dOoU6wv262qO647UucgjgNx+YWCuKVATWaRd2s/9z/S
         jyJgWDgTz5AP/OIm/mdoDxC9KfYOjCK984HbAP9Tw5xTRaurzqzZqfHqeCgD191ff4zO
         SfRWdG0gYjPmUCF4Amf9m9Gx18FsX8b2L1DaWCs6kNbFK0b0j+YpiFnrwDkKGQhbQRuu
         OFjJJePvr0CSeqI2iHyqgVyi2+B5OZbIlYcASTf8OLdPw1YJea3eVWvYnp9iIYU8pk0P
         Lx7Q==
X-Gm-Message-State: AOUpUlHua6mDae+BDKFodX43kR0tN+1Djpyb6FTlxGKgo1Jkg9kUJR9o
        UnLi9s/IPs2XZ3iRDI0UF98RUIZe
X-Google-Smtp-Source: AAOMgpe8Vvwj7kutRfQeciJnxU7LbJNeQfSPCzXxU+4Mon7I8LfeaUp/nqQ5uq89gdL+XUYBVTef0A==
X-Received: by 2002:a1c:6f88:: with SMTP id c8-v6mr450538wmi.49.1533060017683;
        Tue, 31 Jul 2018 11:00:17 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:16 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 00/20] rebase -i: rewrite in C
Date:   Tue, 31 Jul 2018 19:59:43 +0200
Message-Id: <20180731180003.5421-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series rewrite the interactive rebase from shell to C.

It is based on ffc6fa0e39 ("Fourth batch for 2.19 cycle", 2018-07-24).
The v4 was based on b7bd9486 ("Third batch for 2.19 cycle", 2018-07-18).
I wanted to make sure my series works well with 'bb/pedantic',
'jk/empty-pick-fix', and 'as/sequencer-customizable-comment-char', as
they modified sequencer.c.

Changes since v4:

 - [15/20] Add a newline char to $state_dir/quiet in write_basic_state(), even
   if $GIT_QUIET is not set

 - [20/20] Remove the declaration of cmd_rebase__helper() in builtin.h

Alban Gruin (20):
  sequencer: make two functions and an enum from sequencer.c public
  rebase -i: rewrite append_todo_help() in C
  editor: add a function to launch the sequence editor
  rebase -i: rewrite the edit-todo functionality in C
  sequencer: add a new function to silence a command, except if it fails
  rebase -i: rewrite setup_reflog_action() in C
  rebase -i: rewrite checkout_onto() in C
  sequencer: refactor append_todo_help() to write its message to a
    buffer
  sequencer: change the way skip_unnecessary_picks() returns its result
  t3404: todo list with commented-out commands only aborts
  rebase -i: rewrite complete_action() in C
  rebase -i: remove unused modes and functions
  rebase -i: implement the logic to initialize $revisions in C
  rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in
    C
  rebase -i: rewrite write_basic_state() in C
  rebase -i: rewrite init_basic_state() in C
  rebase -i: implement the main part of interactive rebase as a builtin
  rebase--interactive2: rewrite the submodes of interactive rebase in C
  rebase -i: remove git-rebase--interactive.sh
  rebase -i: move rebase--helper modes to rebase--interactive

 .gitignore                     |   1 -
 Makefile                       |   5 +-
 builtin.h                      |   2 +-
 builtin/rebase--helper.c       |  88 ----------
 builtin/rebase--interactive.c  | 264 ++++++++++++++++++++++++++++
 cache.h                        |   1 +
 editor.c                       |  27 ++-
 git-rebase--interactive.sh     | 283 ------------------------------
 git-rebase--preserve-merges.sh |  10 +-
 git-rebase.sh                  |  47 ++++-
 git.c                          |   2 +-
 rebase-interactive.c           |  96 ++++++++++
 rebase-interactive.h           |   8 +
 sequencer.c                    | 311 +++++++++++++++++++++++++++------
 sequencer.h                    |  19 +-
 strbuf.h                       |   2 +
 t/t3404-rebase-interactive.sh  |  10 ++
 17 files changed, 729 insertions(+), 447 deletions(-)
 delete mode 100644 builtin/rebase--helper.c
 create mode 100644 builtin/rebase--interactive.c
 delete mode 100644 git-rebase--interactive.sh
 create mode 100644 rebase-interactive.c
 create mode 100644 rebase-interactive.h

-- 
2.18.0

