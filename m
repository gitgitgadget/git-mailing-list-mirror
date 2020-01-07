Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AE6C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C53208C4
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7YKqCGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgAGOzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:55:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45263 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGOzu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 09:55:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so54238769wrj.12
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 06:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=s8lyyjXBBqwr1+s2pXqT6jzk++lwIwG7Lesea8l7h40=;
        b=S7YKqCGfyQ/0tHjtvSnOuHrOieHNRCtYnOkMoVnQr+OjwEcj6yq3D5gNs90IRBpM9e
         upK0woN0Ycyb/Duj5YxzVEk2K75iqvA04zxC6OsoO/5+B7kSP3hqF0a5Bhqh771OZaii
         vwAOgi87lq1vSzCoXFQjoM2ITOjvOcaBw9M6z2YHts1E5xl4hATAPqpP4bIVJKnN0vHJ
         87A0DlgtRQUDHEIbgUb5gNV7GB/wNZqWJQt1T859OW1vMJmiZH4YPJ20ekL3soFTpujn
         lPEbI3UeEejrqP05Zal+4xsfJWamVcv+Ro4/qbZSR49LFGB1rrWJDagNcJlemLKYEwcW
         +dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s8lyyjXBBqwr1+s2pXqT6jzk++lwIwG7Lesea8l7h40=;
        b=aHaav9AQrnqb5AcuQpgUwj/uxYYl4uBtgh0zSqF4wxDavL1yOGc0laYP8Cq/bjEIpe
         s0uGZt/oz3i+j+IeWu6sq/2oePtsWN2XMP7UuTjOod4PGEhnnN0AYMBjsR1adTYy8g3b
         mgqjp/TkaJ5+qu+baHoiGBXszGzapILhSW8RE4MvHoV2x4zwJa/Pmmr0RqjTL9HkKTOo
         W9VHhGUtmfcnu67gBYxS8GSkNjQ8LD7K7GecypFVzL1NsAYK4/zqL3kD3aI7ghvwghZ0
         88MIPWpUEcQSK+9akew8SRJyIbfZ8i4tQJp4YcumFn/WnBt6i2bBJ8TLKqckXjLte3yu
         0jYg==
X-Gm-Message-State: APjAAAV5G+daTLP++7HBiYxaJj6vVHZNWnQxO94shXLmI218Sii1U16u
        DNk2BGqURHAUxNcKiFealuvqHGB2
X-Google-Smtp-Source: APXvYqzZvcpPuh9pyUb5f478aWherRqwZbZl6xNj0rfT3YwNkO3cMPN+3DnP/8h1AfXJLpXs+Q7SKQ==
X-Received: by 2002:adf:bc4f:: with SMTP id a15mr109842681wrh.160.1578408948070;
        Tue, 07 Jan 2020 06:55:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm27949516wmd.36.2020.01.07.06.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:55:47 -0800 (PST)
Message-Id: <pull.517.git.1578408947.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 14:55:44 +0000
Subject: [PATCH 0/3] Fix two bugs in graph.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, brad@brad-smith.co.uk, sunshine@sunshineco.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a possible fix for the bug reported in [1].

The first commit fixes the runtime failure due to the assert() statement.

The second commit replaces the assert() statements with a macro that
triggers a BUG().

The third commit adds another test that shows a more complicated example and
how the new code in v2.25.0-rc1 has a behavior change that is not
necessarily wanted.

Thanks, -Stolee

[1] 
https://lore.kernel.org/git/CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com/

Derrick Stolee (3):
  graph: fix case that hit assert()
  graph: replace assert() with graph_assert() macro
  t4215: add bigger graph collapse test

 graph.c                      |  39 +++++++------
 t/t4215-log-skewed-merges.sh | 105 +++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 18 deletions(-)


base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-517%2Fderrickstolee%2Fgraph-assert-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-517/derrickstolee/graph-assert-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/517
-- 
gitgitgadget
