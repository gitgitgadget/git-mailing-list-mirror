Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509121F516
	for <e@80x24.org>; Mon,  2 Jul 2018 10:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932882AbeGBK6B (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 06:58:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47012 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933968AbeGBK6A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 06:58:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id s11-v6so5829614wra.13
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 03:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hG8H+jqayoOo9mOWG2ifE54Dah1LE1LJJNv+Mhz7DBM=;
        b=dzQupAjBoUU31Uhoz0/ABAcNT0eLHrbJtpLbKs06Ph5EnV2kQ7dQAZVgZOoZerT95p
         nTicZvSK7L4xBc/NZ6QUdk1nIYlqc1Tzylmq0wRByUZy4Bsie4kJctKEEKs59VwDI69b
         CzC8A4KbKhjDJGMPx7DnCXy0u+7yYZSHhvinlssALdsjIGdgtfO2rZd4jRGxYUKy7wNC
         ak0WH4gA62SY8bd9sBAn9w4APavUNnT6laXYJvRwrmiznhrFEMZtI3kWFnV+hEkYFRG/
         0RRYcW/G4DT+3f9ubQ98/lVH9hJjyH00WEC54sDKFv0aJbu6n3aCnez53Nnlwu5ffoj+
         z/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hG8H+jqayoOo9mOWG2ifE54Dah1LE1LJJNv+Mhz7DBM=;
        b=RiKQNZsUPAGPQWeaZ7juVj1BxLH0oIvkehRrp0WHmEQL0GxnaiibGclokfQqpTj4EN
         Kk5Ufd4zROiA7kU036Ps5Cx3vESgdiTtGqBA/RUx5B2iN0WHefpzJBVKyTlzEb6gUAwv
         g60A1wf7JabxnnOd9kLPRE3i5uny9CYRAIjyGeUUax0tGtMqcg1bdC0grqkVYsXPbA1Q
         +MMvq5yDsfEposfnGfhH+WPXdz6urnA0WpuoMrNoBty5iRPtrrcYr5htsZ1MMgJ6G13c
         F67x56R41pqJ8u7I0+/Ce9Zm/BZW3Jh13R1jy0GYCGpPrKla9dNesurA0PlAukGEcdmd
         niLA==
X-Gm-Message-State: APt69E2K54OdNjqCQZMSvs9yk9nIglr7yOuwIyPXc8NviMLffQqqRoP2
        5pEtZzIjqtHxoJlUFKcR2/utyfV7
X-Google-Smtp-Source: AAOMgpdaM/goCVSaJSfwEa9pMhQX1/7PvGrGv/aySNHEEJg5bMStBJpohkpPhTXiQ5hBb7hMwHx+cg==
X-Received: by 2002:adf:d842:: with SMTP id k2-v6mr6401628wrl.26.1530529078706;
        Mon, 02 Jul 2018 03:57:58 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.googlemail.com with ESMTPSA id m64-v6sm7462437wmb.38.2018.07.02.03.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 03:57:57 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 0/7] rebase -i: rewrite some parts in C
Date:   Mon,  2 Jul 2018 12:57:10 +0200
Message-Id: <20180702105717.26386-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series rewrites some parts of interactive rebase from shell
to C:

 - append_todo_help(). The C version covers a bit more than the shell
   version.

 - The edit-todo functionnality.

 - The reflog operations.

The v1 of this series is an aggregate made by Junio of my patch series
about append_todo_help() (v3), edit-todo (v2) and reflog (v5), and can
be found in the branch `ag/rebase-i-in-c`.

This branch is based on master (as of 2018-07-02).

Changes since v1:

 - Introducing rebase-interactive.c to contain functions necessary for
   interactive rebase.

 - Show an error message when append_todo_help() fails to edit the todo
   list.

 - Renaming enumeration check_level and its values to avoid namespace
   pollution.

 - Moving append_todo_help() and edit_todo() from sequencer.c to
   interactive-rebase.c.

Alban Gruin (7):
  sequencer: make two functions and an enum from sequencer.c public
  rebase--interactive: rewrite append_todo_help() in C
  editor: add a function to launch the sequence editor
  rebase-interactive: rewrite the edit-todo functionality in C
  sequencer: add a new function to silence a command, except if it
    fails.
  rebase -i: rewrite setup_reflog_action() in C
  rebase -i: rewrite checkout_onto() in C

 Makefile                   |   1 +
 builtin/rebase--helper.c   |  24 +++++++-
 cache.h                    |   1 +
 editor.c                   |  27 ++++++++-
 git-rebase--interactive.sh | 100 +++----------------------------
 rebase-interactive.c       |  99 ++++++++++++++++++++++++++++++
 rebase-interactive.h       |   7 +++
 sequencer.c                | 120 +++++++++++++++++++++++++------------
 sequencer.h                |  14 +++++
 strbuf.h                   |   2 +
 10 files changed, 260 insertions(+), 135 deletions(-)
 create mode 100644 rebase-interactive.c
 create mode 100644 rebase-interactive.h

-- 
2.18.0

