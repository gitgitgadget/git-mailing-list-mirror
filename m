Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1651F1F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfGDJQY (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:16:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41632 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfGDJQX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:16:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id p15so4735851eds.8
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 02:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WvRoXgNCXYSwyKzrmMC0Tku1nyAe4uScmbPd5dfJ4SU=;
        b=GaRy85NWmlv7RGSmaNOk/uCWjkD/6rv42p73H01wKzjmDq8950KxpYeBqqytkCN2YQ
         7jGKnJ+BHkt0bTLO9P5nYf68lk0kb6UFTDJwfw2vonqszImVzxZC5rsn0z0yPUvqcnj1
         oGiadziSYJPK/jIgUdo6WNt6EqtB3f1RaQcKeHq0v0c8Kaf+TlIgHxFcjsLiG8eiqt6K
         bDVMDxiP+UHi4/hiqdNUwBVHffxu4HvMXt2Ltdw05ZdgOADvCweh5n9VRYBCCEiemQ61
         CP/q9i4k+rEovOs84Bq9ZGOUbl6/m/0HOIWG/iuCls6qLQSu4lNNEKRK/C8MIbgwFYch
         TvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WvRoXgNCXYSwyKzrmMC0Tku1nyAe4uScmbPd5dfJ4SU=;
        b=f+brl9DEu7wZl2VwXzMsWWrJmjN4iA5xCpWfbxblFLn3yx/q/K1mcM1/oPDIkrWCGB
         RkmEU99ahFisvkVhaeTQVc+0bYfiiC3qqvuJniTnf7OuU0r8uDIt/uaaPrXEnENqpME4
         LQaIb6g/Lr8otaweQSmt2M7yUkGq1mZTUbdU0v61p/vRLOGf1Ymds01xAna7ouruCWPh
         iyImmIpoVVmB0HHkS5ApPUoiUxaeb9ZV9MP+u17ND45nWGFhY+G4XprXTrwHRz+jTcad
         qAuKslfufOlahiqrvyUS7aOZYSZ8E71gqPDAkSmzlr++bsu6kkm1T/BwgJ3b7DKcW1bH
         TKeg==
X-Gm-Message-State: APjAAAXFPfxHzD/R1eBom/6Kgw35nu7fLmvVALdPIyhzwFDpSTVuTxVU
        i1CyHswyhlD0/cIiu4PoP2gusngJ
X-Google-Smtp-Source: APXvYqz2AkeGMyP1io4hdqhYpyg/UQudXk7XE8boNohdLojewRajy6M9hd1WJEJ1vxHJ0cn1UDPrqw==
X-Received: by 2002:a50:f599:: with SMTP id u25mr48700188edm.195.1562231782421;
        Thu, 04 Jul 2019 02:16:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q50sm1481039edd.91.2019.07.04.02.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:16:22 -0700 (PDT)
Date:   Thu, 04 Jul 2019 02:16:22 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jul 2019 09:16:20 GMT
Message-Id: <pull.213.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] diff: release all handles before running external diff
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

On Windows, it is not possible to overwrite a file as long as any process
holds a read handle to it. Even keeping regions memory-mapped prevents that.

When git difftool calls git diff, it might be the user's intention to write
the file(s) via the diff tool, so let's make sure that they are not
memory-mapped at that stage.

Johannes Schindelin (1):
  diff: munmap() file contents before running external diff

 diff.c | 4 ++++
 1 file changed, 4 insertions(+)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-213%2Fdscho%2Fmunmap-before-ext-diff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-213/dscho/munmap-before-ext-diff-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/213
-- 
gitgitgadget
