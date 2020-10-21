Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1018C561F8
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 12:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D8E82224E
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 12:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHcTPVcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442620AbgJUMuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 08:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442617AbgJUMuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 08:50:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A422C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 05:50:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so1410016pgb.10
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4twxcSb92uP06QooGoq4ba49+7zsFaK90v5xjL3vUfM=;
        b=JHcTPVcygbs6oYxMa+FlRs2bC5Vp0UjxKAnnM65HVmXfAFh/+b4ZVvrie2L6CAUtCo
         QXxWnZuDJsL1ZIFNyp3GNlPf6FeE3JO68IybFacG3vHI+iI1erhTmgwDbFcodE97Jrcx
         ZEXpS4jBvbynwcNMEE3j73/cFjsHFjkzBtVc0Fhhu7AeSGKTgQeXe+65eXw5kgbkcC9o
         5gu1u8mKRg/DWCroK2K/Lo/pu1COKCyMItTvAIWVC5pCzsM2TKxOdzkdZtetqVzTMyJX
         31WKzO0om+ZV825gVd4A88aYiJlIEkl/xwcIv2TJ9DDyw6ld155stHSt4laHuUc2S5ng
         sqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4twxcSb92uP06QooGoq4ba49+7zsFaK90v5xjL3vUfM=;
        b=FVT+0H3X2T29XpoN0LbCpLkjU1h9l/Gz/No+JU6QBKjXI3lIAJAJLLPmdG9RW+pUDK
         JmVP17ycBfN56GDE+GegIzEIZ47lnLHsHFZWuFB45THOAKYOJAsZj8AJAWPLQTt9/IBO
         s/hz8NjIijCPjsM0salt2Jqxtweg48D4NzQRR6ZQP1RspAEMj5Zl6UcxgbifRy1Hj1jl
         +3qukGFtoefgfiLBUIbvL5DQnbWvzNQAwFeNbyoQVdcQ5GfhWUWryf7jUL+cH2Fm2bAW
         PZcNqb/pCmixts4nXV7+kqSS8KRGQjFiFdozWeuZZWN0Bzhrrg+App6pv03JZRMdz4Nx
         g2UQ==
X-Gm-Message-State: AOAM533WdJpUH1E7nAxNjb2RGzg4YtacY/4FoNYWM3iAeEGtn5piKnXd
        ICUDclGXEeIjpDmaRvjr9JFGeNjA7SMq9w==
X-Google-Smtp-Source: ABdhPJy3jm/U31QXL2XyoeBngk/kdQLHPIZ2q3gxKg6tamMWfunNWEx2PciCsh9L5it5DPoMxIYyPw==
X-Received: by 2002:a65:47c2:: with SMTP id f2mr3285662pgs.4.1603284623644;
        Wed, 21 Oct 2020 05:50:23 -0700 (PDT)
Received: from localhost.localdomain ([106.215.55.55])
        by smtp.googlemail.com with ESMTPSA id j24sm2054857pjn.9.2020.10.21.05.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 05:50:23 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v5 0/5][Outreachy] modernize the test scripts
Date:   Wed, 21 Oct 2020 18:18:18 +0530
Message-Id: <20201021124823.2217-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201020121152.21645-1-charvi077@gmail.com>
References: <20201020121152.21645-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this patch series, I have combined all the correct patches
from version 3 and version 4 and this patch series consists of
(v3 1-4/5 + v4) patches, else everything remains unchanged.
I have also tested by applying it locally, in order to confirm 
that these patches are usable.

Thanks to Junio and Taylor for the guidance.

This patch series :
 -modernize the three test scripts : t7101, t7201 and t7102.
 - cleans up with 5 types of changes in all the three scripts.
   1. Converting the old style test format to new one
   2. Removing blankspaces in test bodies
   3. Removing whitespaces after the redirect operator, according to
      CodingGuidelines 
   4. Using 'git -C' to avoid use of another subshell 
   5. Placing commands in separate lines


Charvi Mendiratta (5):
  t7101,t7102,t7201: modernize test formatting
  t7102,t7201: remove unnecessary blank spaces in test body
  t7102,t7201: remove whitespace after redirect operator
  t7201: use 'git -C' to avoid subshell
  t7201: put each command on a separate line

 t/t7101-reset-empty-subdirs.sh |  66 ++++++++++-----------
 t/t7102-reset.sh               |  63 ++++++++------------
 t/t7201-co.sh                  | 102 +++++++++++++--------------------
 3 files changed, 96 insertions(+), 135 deletions(-)

-- 
2.29.0.rc1

