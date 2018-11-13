Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA7D1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbeKNBIL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:08:11 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37928 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731809AbeKNBIL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:08:11 -0500
Received: by mail-pf1-f169.google.com with SMTP id v76-v6so3371402pfa.5
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eYvWllmArqu9wTWojjLzidqE74joCAfQChWhgzEE0do=;
        b=ZpQr9GOrSwhIrpex9g5MhwJ72z6P/hs1xHAYHy8gyaDlaSN1ELyO+KcKQVbB8ClVy8
         tXxTS6ThlNh2efO1cviwVz2w5GFYsXycmInHCqgOH9XQhOEoYuBEgLsHaq1g85J+LBlY
         OBKfF7pdImBmiDAju53cvGwnDhYA6JyHQCeoO1kXHkXYLUJLnSatHHpXTGaiiFrd4TB8
         XJo8oCf72sIQhO1l6ubjVg49JFm/oCm6fq1fBfQONq3l2M0RWFU0k2vSu1ECETJb4604
         E5ygR67RnvNKrvuiaDqyuLpESOIAVOc8o3ycQAdrjQTw4WOiXQRfxuwPqIbXkt36GGeU
         lrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=eYvWllmArqu9wTWojjLzidqE74joCAfQChWhgzEE0do=;
        b=tWIePWHdDMTVGDO8L4fdscAozGz+ZJNK62nuWWdLo95uBLxt10umUudM59Q9L3Oow8
         KWkhvKx1pMb+C0jCDrL4gxEI8KjQ2OWNzjFv5VNwExTh/kLzg/TuW4UratNUCNNUxoxy
         NjlxElnGGoOWlZA+ZELKXKHtgenu799HqhwTv/IUEpKQDwGqODEEKFxIyK1h6SG3y3X/
         H6XRplpoq2UZRp0csM5JY1otrpDjFxlylM6ChZwJhhVi+d8nJYgIt25r/mIWcXn/pnTc
         1sUBrKRe+mwXRV/JjAIeNJFnbM9aOwFypaaPW/OHDVCDRS055wt9shlbRDaFqNrjXkVs
         aNaA==
X-Gm-Message-State: AGRZ1gK0DLNJCiPSQXCfWJipthDikm/P1/aXgC4v1k/1AA4HIvtXUsYT
        UcN2Ec7mPXEX1jekt7eK+FgQlAWd
X-Google-Smtp-Source: AJdET5fJxmZpLrgqTY8GCIHSWEjCwbU0OifOhFHws0u3q06C8cJECNvBmCHqW7KGrBSj4/hSUxJCuA==
X-Received: by 2002:a62:6383:: with SMTP id x125-v6mr5466083pfb.13.1542121777380;
        Tue, 13 Nov 2018 07:09:37 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 5-v6sm25125474pfg.141.2018.11.13.07.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:09:36 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:09:36 -0800 (PST)
X-Google-Original-Date: Tue, 13 Nov 2018 15:09:33 GMT
Message-Id: <pull.79.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] bundle: fix issue when bundles would be empty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And yet another patch coming through Git for Windows...

Gaël Lhez (1):
  bundle: refuse to create empty bundle

 bundle.c                | 7 ++++---
 t/t5607-clone-bundle.sh | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-79%2Fdscho%2Fcreate-empty-bundle-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-79/dscho/create-empty-bundle-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/79
-- 
gitgitgadget
