Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4A6C433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 02:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384114AbhLDCo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 21:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbhLDCo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 21:44:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9323BC061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 18:41:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so6336961wme.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 18:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WDN2IDjd2XBF23CnNWYa2KNYBxwimmnG3evN+HMWaTw=;
        b=M/XUbM0lisQvHosnoMaruuPop6w3Vwy47aDwR/HAPX6c92MyYf7bf7yyYjP135PNtU
         Bcnvlt1GQXwK+dkwwFuuaQMUpzvAXfKknp0hIQO8j8NIFbXA7qh6NMzYnCSvpBJoOzxs
         eIRwsK1K+wXkAM41ShCUV+XHEdrUxUUSC2xe0pCYptjpIpTY7I642TILK/+6jKbLa4Qv
         /U/4rNkprbc3Vk1JnLcBQVEzbYxKdDGFTm8BgHJwjH8LPwvY3W/KuXnuHnP8PREkNr72
         iocTLSEPiXNtwqBZn33feyWA882R7lJlXjcXfZAFqcsiNq1W1kEMLgBTfYJ8U+0Y5YS0
         xoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WDN2IDjd2XBF23CnNWYa2KNYBxwimmnG3evN+HMWaTw=;
        b=lIQKu+dFEPDJzz4WErRjMZh7co2ZAxUI4j0coMKCUgP7h9uLyhuKqneiQRigD3aO/K
         jy3Bch3o39IPduLZHwQP/rvkjcm9TYfcnGBCbWnwD0G1sngjyEPhvYtNvptKo6rLnyJX
         KIzETkf5SrGI8CBetMxJqRVm5clJExoeTz18IIiPU9OH+k+eaYRs/iBl3e3yfviCXxAn
         zZT38wxBHoftaeGbecVN+dwC5RYwl8ncJbwqi9xLac88q6T3CvG3xrDcIjwOQlyfOU6A
         +ElAcqphCnVxCfgEdG0xAt2UIeIhxXGnNkjUGxyVLQnTRr2M7p4F19K1b4qELCWX/eKs
         U84Q==
X-Gm-Message-State: AOAM530ZB+2thLxlqFQK1px0zGsQbesxlt94NA9u03/GX5ii5X67dRMh
        8Tm9Fo0xW0zMigmo4JURq82aRk0pyRQ=
X-Google-Smtp-Source: ABdhPJxFWmnpFeKjulS1/YbnfBQ1RuFlQLZmsjdUMfm9TZDNAtpBCnpi9ooSRhEProA2gWIrzsSr4w==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr20352629wmi.114.1638585659718;
        Fri, 03 Dec 2021 18:40:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14sm4228953wrp.70.2021.12.03.18.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 18:40:59 -0800 (PST)
Message-Id: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 02:40:56 +0000
Subject: [PATCH 0/2] ns/tmp-objdir: add support for temporary writable databases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New interface into the tmp-objdir API to help in-core use of the quarantine
feature.

This patch series was formerly part of the ns/batched-fsync topic [1]. It's
now split out into its own gitgitgadget PR and discussion thread since it is
the base for en/remerge-diff as well.

The most recent feedback was in [2]. I removed printing from prune_subdir
and simplified the strbuf handling in prune_tmp_file.

References: [1]
https://lore.kernel.org/git/pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/CABPp-BH6m4q_EoX77bqLcpCN1HRfJ_XayeCV2O0sRybX53rPrw@mail.gmail.com/

Neeraj Singh (2):
  tmp-objdir: new API for creating temporary writable databases
  tmp-objdir: disable ref updates when replacing the primary odb

 builtin/prune.c        | 20 ++++++++++++---
 builtin/receive-pack.c |  2 +-
 environment.c          |  9 +++++++
 object-file.c          | 50 ++++++++++++++++++++++++++++++++++++--
 object-store.h         | 26 ++++++++++++++++++++
 object.c               |  2 +-
 refs.c                 |  2 +-
 repository.c           |  2 ++
 repository.h           |  1 +
 tmp-objdir.c           | 55 +++++++++++++++++++++++++++++++++++++++---
 tmp-objdir.h           | 29 +++++++++++++++++++---
 11 files changed, 183 insertions(+), 15 deletions(-)


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1091%2Fneerajsi-msft%2Fns%2Ftmp-objdir-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1091/neerajsi-msft/ns/tmp-objdir-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1091
-- 
gitgitgadget
