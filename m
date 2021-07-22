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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57022C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 07:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3037D61260
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 07:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhGVG6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhGVG6p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 02:58:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD78EC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 00:39:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r11so4825162wro.9
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=3Br89pslKZMlz9apDGdURJ7io96tlpsr6jo2fKevMJY=;
        b=Hl3JvxnG6/ewHKwbzjOClArJaX4KvEeHLAVzHjVzJtaNlS/5UnXOvJo1cYe/1InmWC
         ujvHzCDdEiG4tFc1Zo3NdzSaYWo/wioTyzq5TAe1bpNu/ckDx8g6mZBgU0ZG3PbClQf4
         K0vENM2/IvbC7CV2zAMHAR/YvyOJfDq2Z6J9/c35Ey2uZHc+NQsL0mT3/0o8fkHIhJE9
         38Xu+rHFEZsR+KdUl6lKFObTgiava8Iw+8sMBHJy4M4jC6ZsJN9k+r9fMceuAEa7G6ZZ
         /cabCrTYM1NO2WsdV95JJYLYk8GwtRVbgQzTwHJUK5FAW6U/nLoCP/zu9RkOXtEZFuUX
         PJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3Br89pslKZMlz9apDGdURJ7io96tlpsr6jo2fKevMJY=;
        b=i4m+E+Ep9SIRe+87JnnPTgAotgWIXpeKN31Wb2/SdQ+E5tsdSxBEvN7izv/I+8UIdn
         7vGFyHewyPFFKR3EHmc3ku4ESXgSRonT9/yu/d8ViU/aqPpGgGgooBzZQvVW3sfSg7wk
         pxyvAgo8O3LT3gWPagxoazipv07teht8dgF+APEDYGf5X3FlSsL8SR5XhN3Z7rYFsvwf
         gE96oAxz/K+q3F6Y41rbGanqZb9b00E5au4mUDshmoragFAQoYfn/l/Exr3RTeQBQDlj
         ZHkyImxLpwoo+xJgVGR+2jxi3iPovXLBcGICic1rG9GAWgZ6x9Dm94ZGhKjK+x/F4Mx0
         TAcA==
X-Gm-Message-State: AOAM5338dibZyDZ8weHZhMbNy83kJ41m0E2FOt3DxIA/7IlSsbiaKP+L
        oRlXucRrVNPn8Whi2MZMokLDWqAfeXs=
X-Google-Smtp-Source: ABdhPJw7bjg99JsL+6vlJAp9Ya04Ebe2oKdyQX6EGAbhizJ8fRoxhIPN1s/4gbu3s4CkJDvQTI9/Jw==
X-Received: by 2002:a5d:608c:: with SMTP id w12mr23482896wrt.53.1626939558474;
        Thu, 22 Jul 2021 00:39:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm1853896wma.21.2021.07.22.00.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 00:39:18 -0700 (PDT)
Message-Id: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 07:39:11 +0000
Subject: [PATCH 0/5] [GSOC] ref-filter: add %(raw) and %(rest) atoms
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is split from my main patch series zh/ref-filter-raw-data,
to make things easier for reviewers to read.

This patch series provided %(raw) and %(rest) for ref-filter, which will be
used by zh/cat-file-reuse-ref-filter-logic later.

ZheNing Hu (5):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: --format=%(raw) re-support --perl
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom

 Documentation/git-for-each-ref.txt |   9 ++
 builtin/tag.c                      |   2 +-
 quote.c                            |  17 ++
 quote.h                            |   1 +
 ref-filter.c                       | 240 ++++++++++++++++++++++-------
 ref-filter.h                       |   9 +-
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 235 ++++++++++++++++++++++++++++
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 10 files changed, 463 insertions(+), 62 deletions(-)


base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1000%2Fadlternative%2Fref-filter-raw-data-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1000/adlternative/ref-filter-raw-data-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1000
-- 
gitgitgadget
