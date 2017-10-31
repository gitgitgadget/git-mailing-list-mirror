Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C941F20437
	for <e@80x24.org>; Tue, 31 Oct 2017 18:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbdJaSTS (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:19:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:56648 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbdJaSTR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:19:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id b85so14368688pfj.13
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hZ7BQBCP5FjsbHWX/Xn9Q4MZTwxg6rm+DadDcij3VE8=;
        b=EA39HsfGkXUGeAVNjbJ1eBZh+tZLISD4VQowx2i22hQBGKKU40IruBC5QaC4JFPqX2
         IU5aodiNOUBseQ0LrxpfoNDSNMCDIuelyD6XMcXgdTKXt0Gl1XIKxO9ZIV7DN0Ysbj2l
         yxrA834J+iY9Lp08FvU11MyJ6etbokwlBCiEMO6pQrQpS+XFGzo7sSWTHwtN2aM9DZGi
         tqYUGSEKo+1TGIitfihD7VgeQk9xBxIYc44PKbibYN8pMJy/NPuMZJUAeIno3oDImtgg
         P9BkLSQEqtDzGkU+Ba/tcAjKdKR7hsPpfqqu4CpXefqyySESh6CRPwE53FeYnbHuRWUT
         KiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hZ7BQBCP5FjsbHWX/Xn9Q4MZTwxg6rm+DadDcij3VE8=;
        b=rBrxpkYNQ65rDZT5aM385vDLnE5WFrEVcQuwcelh5caJmbcQ/oJuP5grf1ZDaIHYhe
         UwpChR86kGMnynE+HS3+2F4AhkvnsZKQfkbR+OWdbB4QbQ+1K07NAIH5wsHUR3879UoU
         yqaRy4IGHymEXH9Svb4SRVbnACH+0b1J8fVRJhrFmkKuDtfLZbLUjAY3M/oeNEiOBOVP
         jyHmthAfPRABBNVzYLqm0ZAk173Ed0eEEWni74AGNERAoymrVEpKpxS9I6NzKfBbAT5F
         EeiisbtoAN5ujvNh8AWgMnalv29g/Q+zTw34c0j0PErQQ0TJyrKHs9jcPMobsJcNc2q1
         4NvA==
X-Gm-Message-State: AMCzsaVEagrLGwsq+ZUiFEgzv17izU+L8eQsWXNqtLZvNkmxJ4B1/6Bn
        1rMFomT5wjyTwkvLYgrfNrPWc4+hYnw=
X-Google-Smtp-Source: ABhQp+TDO7tAJ3M/H8tJKTseA8J7gGSmd3Saznrx+pc3PAh7MSIvhpuDHmQDf+YpyESl4qxeYRj3Ow==
X-Received: by 10.98.87.207 with SMTP id i76mr2936507pfj.134.1509473956126;
        Tue, 31 Oct 2017 11:19:16 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id a78sm4308985pfl.122.2017.10.31.11.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 11:19:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 0/8] convert diff flags to be stored in a struct
Date:   Tue, 31 Oct 2017 11:19:03 -0700
Message-Id: <20171031181911.42687-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171030194646.27473-1-bmwill@google.com>
References: <20171030194646.27473-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v3:
 * Now always pass struct diff_flags by reference and don't return the struct
   but rather modify the passed in struct.
 * Don't clear TEXTCONV_SET_VIA_CMDLINE when --no-textconv is passed
 * added additional patches (set out separately before) to remove the macros
   and change the struct members to lowercase

Brandon Williams (8):
  add, reset: use DIFF_OPT_SET macro to set a diff flag
  diff: convert flags to be stored in bitfields
  diff: add flag to indicate textconv was set via cmdline
  diff: remove touched flags
  diff: remove DIFF_OPT_TST macro
  diff: remove DIFF_OPT_SET macro
  diff: remove DIFF_OPT_CLR macro
  diff: make struct diff_flags members lowercase

 blame.c               |  16 ++---
 builtin/add.c         |   4 +-
 builtin/am.c          |  10 +--
 builtin/blame.c       |  10 +--
 builtin/commit.c      |   7 +-
 builtin/diff.c        |   8 +--
 builtin/fast-export.c |   2 +-
 builtin/log.c         |  27 ++++----
 builtin/reset.c       |   2 +-
 builtin/rev-list.c    |   2 +-
 combine-diff.c        |  10 +--
 diff-lib.c            |  30 +++++----
 diff-no-index.c       |   8 +--
 diff.c                | 175 +++++++++++++++++++++++++-------------------------
 diff.h                |  88 ++++++++++++++-----------
 diffcore-pickaxe.c    |   8 +--
 diffcore-rename.c     |   6 +-
 log-tree.c            |   2 +-
 merge-recursive.c     |   4 +-
 notes-merge.c         |   4 +-
 patch-ids.c           |   2 +-
 revision.c            |  24 +++----
 sequencer.c           |   5 +-
 submodule.c           |  16 ++---
 tree-diff.c           |  16 ++---
 wt-status.c           |  18 +++---
 26 files changed, 259 insertions(+), 245 deletions(-)

-- 
2.15.0.403.gc27cc4dac6-goog

