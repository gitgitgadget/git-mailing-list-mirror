Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 211B91F516
	for <e@80x24.org>; Thu, 28 Jun 2018 10:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeF1KE1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 06:04:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44093 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeF1KE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 06:04:26 -0400
Received: by mail-wr0-f194.google.com with SMTP id p12-v6so4870431wrn.11
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rA6tklcYEh6vpHKNjAKzGME596csVVOm6VOp4AnV7KI=;
        b=TAKV00/BU0V3qXTfrxBu5fJ1y9dpUqYMl9rPcQ/BuK3SzVVC0BE2rCtzJ5OCPrjy32
         ljj81YjfuQ3Uukih06PwudAbx4IXtqu4W7rDKxbMHTNhx23t9yHsf+qopr1iC3aAjQmB
         tEqzp7R0ThGvRiPzKo0ZsnaCbKR8xS/CwEUoowWqJ2naBf1bGl2Mg26SIRrSHzgAI4nb
         /Dq4xMH7MONhddESKmPm1iDFgF9GJ9mdzFzJXyOJupdwFMMXX6a3J3RcKX6D6Uu70sXM
         oROM4+5+ANAfcBUMnYMyCdo900GntAsPS+pD9cuOuF5tOrcNWaV3Q5WzuH5fm8pm/hp9
         yRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rA6tklcYEh6vpHKNjAKzGME596csVVOm6VOp4AnV7KI=;
        b=oPriWCbd3KQUG3Gu/hvd+tas08WoNo0eIwB9K3NuFguRnl4EVAWmsDA4IpkfBq3HZ0
         c1CVMhTb2McqF5nuSK5E/BbSkaT+dw5r/6G8obt73gUAdAadppB/nYs8c4X3cUhoLFDl
         AfpzAK9pWJBjuTY0c9ihDHa9v24An7sz5DiW7ExvTAPAjcDD6099XCAJah9PqTMJj2hn
         qWdgTYcf62mGADOoXqO1b3HkpK3TEydXOZGMn8KE5ZfYgMHJTBmhys9idWInkrhAhIvv
         hYMYcyyKN+q20IUzYDX1EgondPgvaY8z3jQJJ3izKhUnaneUvuXsUklnjA4hnv5790+X
         DS/g==
X-Gm-Message-State: APt69E1R9LYcbn/c4A2H7jMt5ThNCXHT4ZFVhYEUGRPgg4z0dhPC5Lvc
        fI8DgFxaAJngH3BoMRmXP00DxB3r
X-Google-Smtp-Source: AAOMgpcMq6AEitOczPAOBxg4+PLOuE+OFliUNBY7SJHTabTMVoe/lPeQXIskawM3uh1I8WmYNtQ6EA==
X-Received: by 2002:adf:8124:: with SMTP id 33-v6mr437725wrm.220.1530180265203;
        Thu, 28 Jun 2018 03:04:25 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.googlemail.com with ESMTPSA id x10-v6sm4857893wrn.25.2018.06.28.03.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 03:04:24 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 0/2] rebase -i: rewrite append_todo_help() in C
Date:   Thu, 28 Jun 2018 12:04:09 +0200
Message-Id: <20180628100411.8092-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626161643.31152-1-alban.gruin@gmail.com>
References: <20180626161643.31152-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch rewrites append_todo_help() from shell to C. The C version
covers a bit more than the old shell version. To achieve that, some
parameters were added to rebase--helper.

This also introduce a new source file, rebase-interactive.c.

This is part of the effort to rewrite interactive rebase in C.

This is based on next, as of 2018-06-28.

Changes since v4:

 - Renaming enumeration check_level and its values to avoid namespace
   pollution.

Alban Gruin (2):
  sequencer: make two functions and an enum from sequencer.c public
  rebase--interactive: rewrite append_todo_help() in C

 Makefile                   |  1 +
 builtin/rebase--helper.c   | 11 ++++--
 git-rebase--interactive.sh | 52 ++---------------------------
 rebase-interactive.c       | 68 ++++++++++++++++++++++++++++++++++++++
 rebase-interactive.h       |  6 ++++
 sequencer.c                | 22 +++++-------
 sequencer.h                |  8 +++++
 7 files changed, 103 insertions(+), 65 deletions(-)
 create mode 100644 rebase-interactive.c
 create mode 100644 rebase-interactive.h

-- 
2.18.0

