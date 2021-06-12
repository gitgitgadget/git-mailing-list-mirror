Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3EDC48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4EFE60FE5
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhFLLRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 07:17:20 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:46767 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhFLLRU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 07:17:20 -0400
Received: by mail-wm1-f47.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so10037161wmq.5
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+Pu9oUyklMI08zS2jpbuB7PdIO/A6mzjiIcqCUSH88s=;
        b=khQVDoBjr1qVmSoFsqLTiLRWxNy98j9iZ8ikEWoF6sy0SFXgJnbM7QU3bch+VQ+JHX
         IAl47xgkuZ6us9qdgf6O+HjmLjkNcQRQaFCN6Di+FRw9RcYXGuib8r/YmFuihAfbJpzr
         nYZ9gtQ42qV+aHwAVDPrmtMBgLaxjoUTF6fOnzShipmR8rJYSQoaUV6v9ihg4zfeNlTK
         IRwU8c8SlTide7GZCCNArwlaY48B7CtzCXSYUxqjt4LmkxM5iPkmnRfG5urHXQ3JTN7Y
         a1eYA+KqYM41QmwoBFigcSHkFmCMuCU2YDV+s+dMg1IecsI/X9mUaNopIGkdThPC3fAp
         U2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Pu9oUyklMI08zS2jpbuB7PdIO/A6mzjiIcqCUSH88s=;
        b=O95CKMZj/5FR8IBIZYkLwoGCEVg//pPHJ4ZzZUCq4xn5vKGq0Hg1I1aAdhgr6mwWnS
         M7fja3ipijkmFYZmBWG+MsKly6PHynAspO+itTwLnnGAwXiEIDroxxp5x2sfdl+W1Dt9
         o0yFylWWnNfv7OGDt287nXlJdA4jBn3Sl0Fhkzkno6aag0aOsmNBK9I4/WLKM0RzOD8X
         9XnZuHu0J/0isaLDPYP81VX8zvoxf7mJPTDp+TmFyvEM0JOC0pkjMMK8Ym6sqpNT/uHN
         CfnSlt8eafrMl0RUkC5s0VWh0b0R2fyTQcUBRbxVCcFFmqaDaVeJ8C9kv5VLXKaTVMmA
         7UoA==
X-Gm-Message-State: AOAM532MBvo0VkhizZjRtNmXdMj+byEbcUZ5CS0mYkFRot4CkqY0gcqP
        xSPBJcLPL1MXgoiTN1AfBbcazktZd2M=
X-Google-Smtp-Source: ABdhPJy9z9yAc/mJjJJmPzaTcumJRX9WF8UxCibJmGJBQmTunUl0vjEBUgQnTac4FFnZ66bZ8Jf00g==
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr7771812wmq.38.1623496459989;
        Sat, 12 Jun 2021 04:14:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm11179230wro.76.2021.06.12.04.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 04:14:19 -0700 (PDT)
Message-Id: <pull.980.git.1623496458.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Jun 2021 11:14:09 +0000
Subject: [PATCH 0/8] [GSOC][RFC] cat-file: reuse ref-filter logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series make cat-file reuse ref-filter logic, which based on
5a5b5f78 ([GSOC] ref-filter: add %(rest) atom)

 1. Modified the logic of cat-file --batch, use verify_ref_format() and
    format_ref_array_item() to get object data.
 2. Re-implement --textconv, --filters.

Now cat-file can support most ref-filter atoms, like %(tree), %(parent),
%(if)...

There is still an unresolved issue: performance overhead is very large, so
that when we use:

git cat-file --batch --batch-all-objects >/dev/null

on git.git, it may fail.

ZheNing Hu (8):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom
  [GSOC] ref-filter: teach get_object() return useful value
  [GSOC] cat-file: reuse ref-filter logic
  [GSOC] cat-file: reuse err buf in batch_objet_write()
  [GSOC] cat-file: re-implement --textconv, --filters options

 Documentation/git-cat-file.txt     |   6 +
 Documentation/git-for-each-ref.txt |   9 +
 builtin/cat-file.c                 | 267 ++++++------------------
 builtin/tag.c                      |   2 +-
 ref-filter.c                       | 320 +++++++++++++++++++++++------
 ref-filter.h                       |  13 +-
 t/t1006-cat-file.sh                | 252 +++++++++++++++++++++++
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 211 +++++++++++++++++++
 t/t6301-for-each-ref-errors.sh     |   2 +-
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 12 files changed, 818 insertions(+), 276 deletions(-)


base-commit: 1197f1a46360d3ae96bd9c15908a3a6f8e562207
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-980%2Fadlternative%2Fcat-file-batch-refactor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-980/adlternative/cat-file-batch-refactor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/980
-- 
gitgitgadget
