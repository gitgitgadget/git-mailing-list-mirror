Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DA71F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeHJTWw (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:22:52 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38629 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeHJTWw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:22:52 -0400
Received: by mail-wm0-f48.google.com with SMTP id t25-v6so2562644wmi.3
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZCTgMmtTit0RKo4rfT6BJqvMvBlCfZ4u/zhkDNXDwDc=;
        b=naduToHeGHe6V9t5kHuS3R3hHQRCKUSdMOPn6yh8habClOMz1zv3cTo8FSjGlMOGVR
         e98ALf5swUFAn0252scCVrxZm0TX1s7xbS4Is0oG2PEePv3wK3xWubAgENyGf+Eh28D3
         q3PBXWbkkS5uefVgZBSxR1V9QTb3MLOQ32/4FxZFXv2kCSdeVCa2+ISSm+Rh2Ym9RCxT
         1mlwKtDl+DwfVK9MAzzlpCeAaD552vGlsbcuI6LCMznlQ/OYk+roPwbeTv1/3MCr4IZu
         rnV1/k5OL3JS7SKtEL6BWWENnD5y7uj/aMrwqYZew+b5r4hwYdnKsRpZNK6DM4mubEOq
         M0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCTgMmtTit0RKo4rfT6BJqvMvBlCfZ4u/zhkDNXDwDc=;
        b=uV1S822M9W8DngxTy+A8CmaroqzbmcsSv4PulLTb6kSOuCvaJtoKXcn4Cyd6UBC//G
         XUB94H3JzSEH6sMwsoGtQ95MOCHPHelSAHeuhQ8ERRCLTkUsr44E8gmcCDO0iTQ+mN7r
         azRRreCPnVW7MJeKkc+W5ZAICQZ1Vvl915NbPQ2DUs+ccDqS+ynjWs57iqJtALquU1iS
         3kTw1I38/ouTikSypVT1ctkOvqV86vl2dFBaarPhpq0AEjg1d3C8gZo4e/bU7RNyXwYP
         JRR0WKnE+8nuce91kEbVUTTX/GI2So8MRe1lxUUYJiuIb0JC1BUZUoFYKAGCqi+6YyOW
         +a8g==
X-Gm-Message-State: AOUpUlF65AbXYBs+eFqvHSGaQ1fFHAlCgX7YdCvaBC7uWX6ci8FwWpqT
        d4VugMCbkYAoHI+nZhWawBoGwlbU
X-Google-Smtp-Source: AA+uWPxXIAoSN0Q0RHYAaCNTbx8sN7kDAjoxCOzeqMZ5sNasRWAclNeadfCGgjCbRk0dujWCcTJWZw==
X-Received: by 2002:a1c:96c8:: with SMTP id y191-v6mr1935323wmd.37.1533919932594;
        Fri, 10 Aug 2018 09:52:12 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:11 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 00/20] rebase -i: rewrite in C
Date:   Fri, 10 Aug 2018 18:51:27 +0200
Message-Id: <20180810165147.4779-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series rewrite the interactive rebase from shell to C.

It is based on ffc6fa0e39 ("Fourth batch for 2.19 cycle", 2018-07-24).
This apply cleanly to 1d89318c48 ("Fifth batch for 2.19 cycle"), and
does not break tests.

Changes since v5:

 - [01/20] Make write_message() public.

 - [04/20] Use write_message() inside of edit_todo_list().

 - [08/20, 11/20 & 17/20] Return -1 instead of 1 in case of error inside
   of complete_action(), edit_todo_list(), append_todo_help_to_file(),
   and do_interactive_rebase().

 - [11/20] Better error management in complete_action().

 - [11/20] Use error() to show the message "Nothing to do".

 - [11/20] Typofix.

Alban Gruin (20):
  sequencer: make three functions and an enum from sequencer.c public
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
 builtin/rebase--helper.c       |  88 ---------
 builtin/rebase--interactive.c  | 264 +++++++++++++++++++++++++++
 cache.h                        |   1 +
 editor.c                       |  27 ++-
 git-rebase--interactive.sh     | 283 -----------------------------
 git-rebase--preserve-merges.sh |  10 +-
 git-rebase.sh                  |  47 ++++-
 git.c                          |   2 +-
 rebase-interactive.c           |  90 ++++++++++
 rebase-interactive.h           |   8 +
 sequencer.c                    | 318 +++++++++++++++++++++++++++------
 sequencer.h                    |  22 ++-
 strbuf.h                       |   2 +
 t/t3404-rebase-interactive.sh  |  10 ++
 17 files changed, 731 insertions(+), 449 deletions(-)
 delete mode 100644 builtin/rebase--helper.c
 create mode 100644 builtin/rebase--interactive.c
 delete mode 100644 git-rebase--interactive.sh
 create mode 100644 rebase-interactive.c
 create mode 100644 rebase-interactive.h

-- 
2.18.0

