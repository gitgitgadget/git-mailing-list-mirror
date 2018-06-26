Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A6C1F597
	for <e@80x24.org>; Tue, 26 Jun 2018 16:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeFZQXL (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 12:23:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40202 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeFZQXI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 12:23:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so2490231wma.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o2d8IJ8KP7Gq5XEFHW6Fi4ppyiSVWbIlDpTleiKRc4o=;
        b=pl7OGnT4eBf0SuRldQ82SvRDoSKtZro6EPWurb5X7bD8A/DMNEGLQegNK98iu7IT81
         29jmxhsLFeDIIiOabF9NDpaux0qQfeLSlQLLvjiI1tI2ROrTuLX+MhPT1Rmqz4iqcwtA
         Ax5n/alu3t+yra0pf2P67JwST1FPIsUs4gInkW74NFn5WvN7oxJYU3s1m/TLCIL6HhqP
         SGS9Xx854REiPawllGBGq+UpoHhxm8edpyPcLULDh2qn4K74318WhsUfHIWx1seQXxRo
         Bxh6iFPInfA+EWcbpGNIOh1B3N411E6T9DXNWvKe7Wysk65cCSOLCixrX37KzyFqOKLJ
         f+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o2d8IJ8KP7Gq5XEFHW6Fi4ppyiSVWbIlDpTleiKRc4o=;
        b=qcW5pDenrDPRd+suOUCeYIw8Yu97au1qH2J3zzPxHgzsFQqdPPtsHuhRkPG6OvYRts
         fy3eEbva6i8nrFIJzJx9cXaw/4VWUGnZofkZJNyAFotIWUzfaYGzX+JU1BKYh057uuyh
         2xoJc1EXXdw6lITyrO0Mc+uCH4bUvQfRn0vzoYJp6ZF4S9MWNVu50kmnU2XwHF/+h+76
         Q0SJOg3La2tY69o42isJAShs/lIvJO5XF9+io2K818RJTcsGYcE3Y36kOY9F7U+qXfIQ
         h+AFK099OakM7R9zZF8pD9XqrQVRJbvuUC5DAp5uIy6lV39oFIAemYIzx+KiwDfRKu22
         6iDg==
X-Gm-Message-State: APt69E3IRLqYgzJgqT19pstXRbkaLcBKCmHqJLYCDTVDFCoJTPxuUZlG
        4jbt2RClp2E7tIvy9Aws+cfK6yEl
X-Google-Smtp-Source: AAOMgpcaNiSAjp9+8Mo35RcLhU4RcWdnHLfS9GCbANqAhq1kR/Z1+/x5egMEuAiEn38U9KZ5codqyA==
X-Received: by 2002:a1c:1588:: with SMTP id 130-v6mr2065805wmv.35.1530030186807;
        Tue, 26 Jun 2018 09:23:06 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id n17-v6sm3545723wmd.14.2018.06.26.09.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 09:23:05 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 0/2] rebase -i: rewrite the edit-todo functionality in C
Date:   Tue, 26 Jun 2018 18:21:41 +0200
Message-Id: <20180626162143.31608-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180613152211.12580-1-alban.gruin@gmail.com>
References: <20180613152211.12580-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch rewrites the edit-todo functionality from shell to C. This is
part of the effort to rewrite interactive rebase in C.

This patch is based on the fourth iteration of my series rewriting
append_todo_help() in C.

Changes since v2:

 - Moving edit_todo() from sequencer.c to interactive-rebase.c.

Alban Gruin (2):
  editor: add a function to launch the sequence editor
  rebase-interactive: rewrite the edit-todo functionality in C

 builtin/rebase--helper.c   | 13 ++++++++-----
 cache.h                    |  1 +
 editor.c                   | 27 +++++++++++++++++++++++++--
 git-rebase--interactive.sh | 11 +----------
 rebase-interactive.c       | 31 +++++++++++++++++++++++++++++++
 rebase-interactive.h       |  1 +
 strbuf.h                   |  2 ++
 7 files changed, 69 insertions(+), 17 deletions(-)

-- 
2.18.0

