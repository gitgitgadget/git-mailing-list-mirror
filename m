Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85FCE2023D
	for <e@80x24.org>; Thu, 29 Jun 2017 01:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbdF2BNj (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 21:13:39 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33926 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdF2BNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 21:13:37 -0400
Received: by mail-pg0-f48.google.com with SMTP id t186so39919363pgb.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 18:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QNAUNmsfK5lIJVScJ9yJPlba/uQH4c8UUO8aS3tDfxQ=;
        b=ZPZKbF6wjdUMcVMEOSL3jfZEKxeQQbLSv3H6gadlRSkIcbtkp+1VYJ9lpMFbdvi1RF
         5OGNQ5Er+iSqBoemOgsiVWDIqUzYQ8huLtrBADW7P4ACgeRYv+Hj8AndMCSo9Xr82Pm4
         /fmleeOewy22/sZgcXjGG5snwF3iFKN4jeLI9vept0dWpFLLuuVTm/VhemUVOzywduB6
         yFgAtAI+7eyarTJguB7B3JfRNsu7kFtoZLDa18ZQOMkjZeIYIznshfkcu2sJ3YJFxqAh
         dIfJ2jWyye8XPF6p3jKxwSDE/6AKBB5qt/74xeQIuB241OF+ikSdzQq2FAIppBL/pmmE
         Q/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QNAUNmsfK5lIJVScJ9yJPlba/uQH4c8UUO8aS3tDfxQ=;
        b=rQsTK1kgBE3VJFAKk4Ry/wDMSi5xkEiyyXc3P+3fVese1o48JbwGBeAQM7CXPERPK/
         Ra25XbiBDdMXbAyipNtZhA3dOuJuF3VCIlFms5ZI4iVfHxEa+kT/YjbHakLWC767M128
         HiM6Yog42LPb2ehixnY/dPku+23OFZCC0+Q2BVx5M/vbwaX+ReuVntJBdJoddvk1Yw5X
         mPT4SY72IoKrTbJxcLBAO/HufKM5txd01CwDxnNZbiMxysbCG41EM/HgBE/mdlYtE+zv
         NHtrncKoVOdcRsLO/70wOWlhvD2QliIENrhU2LAaDfwnsWmw3paZx1Ommay1VesTEnK3
         /q+g==
X-Gm-Message-State: AKS2vOxujDC1QieRXqyLnqiZmCTbQRH3yRULsgJrCxgzRnipQuTr0Uwj
        fKo/Ia2CTG6ath5SbjlTmw==
X-Received: by 10.99.175.87 with SMTP id s23mr13390690pgo.240.1498698817012;
        Wed, 28 Jun 2017 18:13:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:18c6:2a3:5614:1523])
        by smtp.gmail.com with ESMTPSA id u17sm8356932pfa.133.2017.06.28.18.13.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 18:13:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Introduce data field in hashmap and migrate docs to header 
Date:   Wed, 28 Jun 2017 18:13:32 -0700
Message-Id: <20170629011334.11173-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://public-inbox.org/git/xmqqpodnvmmw.fsf@gitster.mtv.corp.google.com/
for context why we need a new data field.  Implement that.

Once upon a time we had a long discussion where to put documentation best.
The answer was header files as there documentation has less chance
to become stale and be out of date.  Improve the docs by
* migrating them to the header
* clarifying how the compare function is to be used
* how the arguments to hashmap_get/remove should be used.

Thanks,
Stefan

Stefan Beller (2):
  hashmap.h: compare function has access to a data field
  hashmap: migrate documentation from Documentation/technical into
    header

 Documentation/technical/api-hashmap.txt | 309 --------------------------------
 attr.c                                  |   4 +-
 builtin/describe.c                      |   6 +-
 builtin/difftool.c                      |  20 ++-
 builtin/fast-export.c                   |   5 +-
 config.c                                |   7 +-
 convert.c                               |   3 +-
 diffcore-rename.c                       |   2 +-
 hashmap.c                               |  17 +-
 hashmap.h                               | 256 +++++++++++++++++++++++---
 name-hash.c                             |  12 +-
 oidset.c                                |   5 +-
 patch-ids.c                             |   6 +-
 refs.c                                  |   4 +-
 remote.c                                |   7 +-
 sha1_file.c                             |   5 +-
 sub-process.c                           |   5 +-
 sub-process.h                           |   6 +-
 submodule-config.c                      |  10 +-
 t/helper/test-hashmap.c                 |  15 +-
 20 files changed, 325 insertions(+), 379 deletions(-)
 delete mode 100644 Documentation/technical/api-hashmap.txt

-- 
2.13.0.31.g9b732c453e

