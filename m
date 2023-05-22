Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C46AC77B73
	for <git@archiver.kernel.org>; Mon, 22 May 2023 21:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjEVVsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 17:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjEVVsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 17:48:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F64EDB
        for <git@vger.kernel.org>; Mon, 22 May 2023 14:48:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba81b37d9d2so11959869276.3
        for <git@vger.kernel.org>; Mon, 22 May 2023 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684792092; x=1687384092;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+jeMCbUadJSxfUWrWXagNO+/xHaPl9VK60GVKOcporQ=;
        b=oxwHhNkDAtYbbZcY/ep/WAjs+6KYmIFz0reLhoPOCXJru0SXMSrpumUF2+3lj8tXIQ
         /w/L+fl0IqKUKtZNaKSw6LEbaEnrdunvCx+HqhPbBsz/Qff3X2ccdPcW9ZoiXL2hdVTL
         5qbVhUGUfp/2JPgCddLaatcZZEtl2g/Ada1DSv7uwUzfVaLl945fnCmW65KXFwvu3XzK
         MH2qd6UQU+W/5Hhg3qbhmWGB6zhuIQp4Ex/RiYdVOza50ahOWaEuUZjah7BELeuvQ3JU
         Jy9vazKl/Ev3qEBSnOwf5j2oQNqyTo7Z4mTAWv5cshI3NlgB+Cz6rTCxiOAb09ipkgne
         RB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684792092; x=1687384092;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jeMCbUadJSxfUWrWXagNO+/xHaPl9VK60GVKOcporQ=;
        b=lDeM9eewPdE9vymsJncGkpaeVljth7y6oq3/B+paMrEkSBoghmQSp2mY0tmLQcu7fP
         /cfgfh1StnL9DwMO/z2mISmzV0o9Ji6nGuPEjGFE4t9wQzpwhSL+6aGTDLuhnA/8Bhps
         Ygqe+33lvglF+riP1nUtCrizijbiKhkByWDtzacuCemTEfPuxCYaJKaZv8fXkZcCZXMN
         tM4qSeiZuLPluHwQpRroP7JOb8/t11zaOItYh13h/2Zbps+u9tlwE+Z7SNdk/8vIIkX+
         iFpJMtss969bdLwD7o2dQt2YB9EBDcMZQaNltDS72nhRcGJQBm7LCRgQD4tqntwBH4oy
         zP3Q==
X-Gm-Message-State: AC+VfDyBo5Q6qrfVzcR4J3hvVY83dY+N6BI9ampHs7cQb6crWSkZmrxr
        8sva0qZ5aF5kYcp1AhDszcV60FYifUvjQcCSOlu6mvKFoIK/V4FAqDckXJz65DjgneSM0MY5BQa
        JtsMUPvt3pfl8tvahR59EMyoefcp6QPUGCxlw4DkUk+N9libli4RUt47jz1ouM5umjhl0MFC5SM
        oy
X-Google-Smtp-Source: ACHHUZ53IzUIBKBEBaAShKkKDfj83YdWegpPboM9MWf3974jFS7VHBcagQ/+yqTQxHFS00q16nmVgnPHWGRR2V+HIuod
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:e715:4b4d:d1be:8ec0])
 (user=jonathantanmy job=sendgmr) by 2002:a25:9191:0:b0:bac:2448:2aa3 with
 SMTP id w17-20020a259191000000b00bac24482aa3mr1405262ybl.9.1684792092556;
 Mon, 22 May 2023 14:48:12 -0700 (PDT)
Date:   Mon, 22 May 2023 14:48:05 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <cover.1684790529.git.jonathantanmy@google.com>
Subject: [PATCH 0/2] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the conversation in [1], here are patches to fix the murmur3
hash function used in creating (and interpreting) changed path filters,
and also to bump the version number to 2.

This is I think the simplest way to do this (invalidating all existing
changed path filters). The resource-consuming part of creating a changed
path filter is in computing the changed paths (thus, reading trees and
calculating changes), and to check if a changed path filter could be
reused, one would need to compute the changed paths anyway in order to
determine if any of them have high-bit strings, so I did not pursue this
further. Server operators might be able to reuse changed path filters
if, for example, they have a more efficient way to determine that no
paths in a repo have the high bit set, but I think that this is out of
scope for the Git project.

In patch 2, I couldn't figure out how to make Bash pass high-bit strings
as a CLI argument for some reason, so I hardcoded the string I wanted
in the test helper instead. If anyone knows how to pass such strings,
please let me know.

[1] https://lore.kernel.org/git/20230511224101.972442-1-jonathantanmy@google.com/

Jonathan Tan (2):
  t4216: test wrong bloom filter version rejection
  commit-graph: fix murmur3, bump filter ver. to 2

 bloom.c               | 14 +++++++-------
 bloom.h               |  9 ++++++---
 commit-graph.c        |  4 ++--
 t/helper/test-bloom.c |  7 +++++++
 t/t0095-bloom.sh      |  8 ++++++++
 t/t4216-log-bloom.sh  | 36 +++++++++++++++++++++++++++++++++---
 6 files changed, 63 insertions(+), 15 deletions(-)

-- 
2.40.1.698.g37aff9b760-goog

