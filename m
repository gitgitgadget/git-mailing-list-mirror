Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F58220899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbdHNVbT (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:31:19 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35226 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdHNVbS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:31:18 -0400
Received: by mail-pg0-f43.google.com with SMTP id v189so54834370pgd.2
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7E9pm/cWHYdXx5EM018AUKz5kJd3oNuZyjfPQ8QO86U=;
        b=LRmvs2M/Qc7TAkoT2jyokE7RdrLx+B20nLw2tzefiqAgp6g9Kjtqt2cQ9jVrvNbKug
         pVhDge4Axzlhex/ywm0EKXrXFW98Vi5Y6NOc+/CqTD9ZJOzadZrZObdnz+XOGkEZo/eH
         PgN45RamMIoGff5gM3cS7EWtJuUZkjH0q0F5TDjTVxW0nOX9NOC86rCLLvtW93VAtTv3
         fqbgnFeB2brX7WCn/eFKLViHMGU9CCvr3PiW+TXHQLhReZ7P7/cG1DCS0IIhMmTkW/vs
         B/zUynmDIqwDV0PLExxC9IcJ2qvsU8yOjXMbJjsh4L618qqmffV+l+4/DTIIpYbsBb/A
         Uaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7E9pm/cWHYdXx5EM018AUKz5kJd3oNuZyjfPQ8QO86U=;
        b=dYEAJf29sAmuJC9HnfLuAo8RTTKJlvUzzT8KDZmyVCFEHQdZcVvyGA4GtF5dbJc2ys
         OxHnqKMhLREZkP1VtbvJbARnZ8BUe1mU3BXivq81E08LFhILn2MEX5ema1qSvlfeIHsO
         4MpVHbm4EVJGSg0VS9Cx7rpEva2pH5pRxslZEUydYdpeQvv+KTIXibcA29saFGLxpGG6
         gh4eo+6lsdgFvfj5Vv1qzA3o0M/3ZLvd6Tnd+U9xOlSr1xiB/yqZoGtf2m5EBicvuClC
         fpV/uZW/dWd4Dne0dJp0t+NKoTPSUctbViEvRHnZ/kXYL6yXFzmQYEl/Aa4qgUNCBtYj
         y+WQ==
X-Gm-Message-State: AHYfb5g2D8is+JxSk9BibgLAEmTGmdOr7cDAJ5gd3HN0YzDJIFG/xWeP
        JVl175p1qTfJuD/sTBaoOw==
X-Received: by 10.99.53.133 with SMTP id c127mr24778093pga.231.1502746277341;
        Mon, 14 Aug 2017 14:31:17 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id e63sm5570016pfc.24.2017.08.14.14.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 14:31:16 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 0/3] Fixes to "diff --color-moved" MIN_BLOCK_LENGTH handling
Date:   Mon, 14 Aug 2017 14:31:09 -0700
Message-Id: <cover.1502745892.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are on sb/diff-color-move.

Patches 1 and 2 are unchanged.

It was pointed out to me that the documentation for
"--color-moved=zebra" is ambiguous, but could plausibly describe the
current behavior. I still think that the current behavior is confusing,
so I have retained patch 3, but have updated the commit message and
documentation to describe this situation. I also proceeded with updating
the test mentioned in the previous cover letter to produce the expected
result (describing the modification in the commit message).

(If we do decide that the current behavior is correct, I can send
another patch to update the documentation to be less ambiguous and maybe
update the code to not use a name like MIN_BLOCK_LENGTH, as it is the
number of adjacent moved lines that we are checking, not the length of a
block.)

Jonathan Tan (3):
  diff: avoid redundantly clearing a flag
  diff: respect MIN_BLOCK_LENGTH for last block
  diff: check MIN_BLOCK_LENGTH at start of new block

 Documentation/diff-options.txt |   6 +--
 diff.c                         |  35 ++++++++++----
 t/t4015-diff-whitespace.sh     | 106 +++++++++++++++++++++++++++++++++++------
 3 files changed, 122 insertions(+), 25 deletions(-)

-- 
2.14.1.480.gb18f417b89-goog

