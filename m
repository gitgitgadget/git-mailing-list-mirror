Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE76DC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BDB21D7D
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYiAJqPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAWTlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:41:23 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46419 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAWTlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:41:23 -0500
Received: by mail-wr1-f53.google.com with SMTP id z7so4424103wrl.13
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 11:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dBKLNJ9690ngAMrJ5OOnMUJmyc9h1avbrmAoPUIEz9k=;
        b=lYiAJqPhwhSM6j25lwyt1CH2V5zuvBDJ/CISBfe8ubao0c2lZXKWqxES1iap79zcT1
         zR/xwjxCLGpyEMPbHcrIJfxBcTHVv4KBIezPToza4PrNH/y/dudzMGXo8cLlIySJroD/
         UC0fSmRrC0PkcyveNhhN1T13X4dNGuHQOz2Mzo4wzbRLXihsvWM4QEwl9YDM/PQZ6EQE
         tIhv90I74ItZazgu1uvE6+bauxY4pAWkl6viM2fQGtwBvW/Wt1xkXV+d9SI8sbhbNQEV
         GIC5hyL8fEJFzhUWdgPQqN+lwl4xHP5m5Q7HfUGVAgiulnYewhbqNlVt4TWJwPE7swMe
         JZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dBKLNJ9690ngAMrJ5OOnMUJmyc9h1avbrmAoPUIEz9k=;
        b=QY7gORaH7LbpkhG0bXjDS3eJX/l+ksS3vVp3p7reiYiJSwVdffwwU0uoz9AOfyfmc9
         fHhy6F15yO4roH+mVyqEjXvJfD55Uc7UUfAjw74YTDrs5kXMW3aLhGgCEymPCk4rnszW
         IUGNn0kYD9VP6jcCfvS1YArQN7KpMp7TTiooaKJ/ngjeFTSoM1PbmSTiViTL40qpUaHE
         5WJq85sbhWHg41rumjgzqYPveV3eb+LBf7DnvNbl1+oOE+1/eCVrTRhROHRWnfC52h4d
         MYJzhfXY80HspOLj0HL6SM7q4r6S68VDF2rwyCZcZGqipTEf0Y2jxkNj1icadEGS8+Pe
         anVA==
X-Gm-Message-State: APjAAAUPBTgvJjsXge8zyWRfaKhYm/3aAKljsFHf0VvlJxyVEU/Q50fr
        V/RCLFpVtvBeP1hWVNtq+5Jty08u
X-Google-Smtp-Source: APXvYqwxgWnZhHRWaKjpGq6UeDy4SnYBlzsTlvCHluQxGuuNJdz3Yb66KTet7I9ogVF8VwrvLZwT7A==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr18955096wrt.366.1579808480953;
        Thu, 23 Jan 2020 11:41:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm3812110wmh.21.2020.01.23.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:41:20 -0800 (PST)
Message-Id: <pull.539.git.1579808479.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 19:41:14 +0000
Subject: [PATCH 0/5] Reftable support git-core
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the reftable library, and hooks it up as a ref backend.

Han-Wen Nienhuys (5):
  setup.c: enable repo detection for reftable
  create .git/refs in files-backend.c
  Document how ref iterators and symrefs interact
  Add reftable library
  Reftable support for git-core

 Makefile                  |   23 +-
 builtin/init-db.c         |    2 -
 refs.c                    |   18 +-
 refs.h                    |    2 +
 refs/files-backend.c      |    4 +
 refs/refs-internal.h      |    4 +
 refs/reftable-backend.c   |  780 ++++++++++++++++++++++++++++
 reftable/README.md        |   12 +
 reftable/VERSION          |  293 +++++++++++
 reftable/basics.c         |  180 +++++++
 reftable/basics.h         |   38 ++
 reftable/block.c          |  382 ++++++++++++++
 reftable/block.h          |   71 +++
 reftable/block_test.c     |  145 ++++++
 reftable/blocksource.h    |   20 +
 reftable/bytes.c          |    0
 reftable/constants.h      |   27 +
 reftable/dump.c           |  102 ++++
 reftable/file.c           |   98 ++++
 reftable/iter.c           |  211 ++++++++
 reftable/iter.h           |   56 ++
 reftable/merged.c         |  262 ++++++++++
 reftable/merged.h         |   34 ++
 reftable/merged_test.c    |  247 +++++++++
 reftable/pq.c             |  116 +++++
 reftable/pq.h             |   34 ++
 reftable/reader.c         |  672 ++++++++++++++++++++++++
 reftable/reader.h         |   52 ++
 reftable/record.c         | 1030 +++++++++++++++++++++++++++++++++++++
 reftable/record.h         |   79 +++
 reftable/record_test.c    |  313 +++++++++++
 reftable/reftable.h       |  396 ++++++++++++++
 reftable/reftable_test.c  |  434 ++++++++++++++++
 reftable/slice.c          |  179 +++++++
 reftable/slice.h          |   39 ++
 reftable/slice_test.c     |   38 ++
 reftable/stack.c          |  931 +++++++++++++++++++++++++++++++++
 reftable/stack.h          |   40 ++
 reftable/stack_test.c     |  265 ++++++++++
 reftable/test_framework.c |   60 +++
 reftable/test_framework.h |   63 +++
 reftable/tree.c           |   60 +++
 reftable/tree.h           |   24 +
 reftable/tree_test.c      |   54 ++
 reftable/writer.c         |  586 +++++++++++++++++++++
 reftable/writer.h         |   46 ++
 setup.c                   |   20 +-
 47 files changed, 8530 insertions(+), 12 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/bytes.c
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/reftable_test.c
 create mode 100644 reftable/slice.c
 create mode 100644 reftable/slice.h
 create mode 100644 reftable/slice_test.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h


base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/539
-- 
gitgitgadget
