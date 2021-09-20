Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951A0C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 00:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A4B61211
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 00:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhIUA4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 20:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbhIUAyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 20:54:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0186C1030BC
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:57:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so30383392wrg.5
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=98adKlZeSP1FGR/EWOmc2K2ZkC83WpcGpjkimPim25Q=;
        b=NAtyMriIPazZS2ns9INIacHPLKUCDpGxtoCsUe2g7VU1Mi+fyIF5ssjkpO92T3B/BD
         lySrbHYHkURVcozCibxw+O8JVstIhtfg2ZJFI+As8G2vfyqmFB2CqzbLRTExH63MwQTn
         WZB51IjmsUYINsOJ6+8AGGlFF7M9L78QN/t7nBByQZ4LeW23D3RqXCl9GSWCpkDtb78X
         SYyohXwfFZmj0GbhrBH+O0MovlmUMfCK4FaXefdSOMeK4orCADNSFSu43u8RihS39Sq7
         8QhN9QCF430aI4hXkskeO+tXKdb+fNzNdQ6o8InC6HTcNeJTqTllyoNbC5A6c+Zt4GqX
         LMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=98adKlZeSP1FGR/EWOmc2K2ZkC83WpcGpjkimPim25Q=;
        b=scf0W69IeFAgCK2BVtDpHjWoiykR9Q+QArhQ7lYcfCQh7J57WrbDYj1Jl0sVv8nzyc
         t7vusQb3aqXh/yNUbpK/dlZ/YIxnOLbZw9Y4IVo4NCQTgCgwp4lCQrXiub8KTS/1tadf
         027ZGmpzYvkmsYHm4hppxGh7vq35fbgoStkvjLwcgoZ2jZYsBFcj2nMhQi21vWrMZ+Xp
         haB3mopRFyF8fDlYwpIWe3VPKzBiwyZle8CGyyRUBBlphfAnijAKC1/VDoQJHB4+13Ra
         0zRivNUc6AaE15WYvg0d/91omZJpMsw+FFyZ3/FZIcIrmWX32vLr4rKz2dN+cVgKSftc
         08+A==
X-Gm-Message-State: AOAM530A6AnV6m5Qafi3ycfUn6abE0qkMc8c/0xAtf3hmoFL4gcCMkod
        Y3z2QLyYP5CbjkT2UAmVzcMpe1lAHas=
X-Google-Smtp-Source: ABdhPJzsQ4RgfW60jGAtwXhZPs7m5BmKzg8O9M9h9w6lYd3jsVCjej4cghXySSJjr4vSSXJ3vLyGZg==
X-Received: by 2002:a05:600c:4a16:: with SMTP id c22mr339137wmp.72.1632160659329;
        Mon, 20 Sep 2021 10:57:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b187sm219663wmd.33.2021.09.20.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:57:39 -0700 (PDT)
Message-Id: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:57:35 +0000
Subject: [PATCH 0/3] Sparse checkout: fix mixed-mode pattern issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, calbabreaker@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a memory leak reported in [1], but also fixes some behavior
concerns around the sparse-checkout command when the sparse-checkout file
does not use cone mode patterns, but cone mode is enabled.

[1]
https://lore.kernel.org/git/CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com/

 1. The first patch fixes the OOM as recommended by Taylor.
 2. The second patch changes the behavior of 'git sparse-checkout init
    --cone' to overwrite the sparse-checkout file if the patterns are not in
    cone mode.
 3. The third patch causes 'git sparse-checkout add' to fail if cone mode is
    enabled but the existing patterns are not in cone mode. This also
    requires strengthening our pattern filtering to require the first
    character be a slash ('/'), which should have been there from the start.

Thanks, -Stolee

Derrick Stolee (3):
  sparse-checkout: fix OOM error with mixed patterns
  sparse-checkout: clear patterns when switching modes
  sparse-checkout: refuse to add to bad patterns

 builtin/sparse-checkout.c          | 18 +++++++++++++++---
 dir.c                              |  2 +-
 t/t1091-sparse-checkout-builtin.sh | 22 ++++++++++++++++++++--
 3 files changed, 36 insertions(+), 6 deletions(-)


base-commit: 4c719308ce59dc70e606f910f40801f2c6051b24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1043%2Fderrickstolee%2Fsparse-checkout-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1043/derrickstolee/sparse-checkout-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1043
-- 
gitgitgadget
