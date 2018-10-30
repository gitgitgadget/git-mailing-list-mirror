Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14BFD1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 14:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeJ3XJn (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 19:09:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33735 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeJ3XJn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 19:09:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id q5-v6so2026257pgv.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+pwyM95LFjypTLHvdXpR0+AeNhNrn4yjMFBh48w+MSQ=;
        b=hVn8AFj3f0aQ7+FBroctIgIs5Qqj0y7LdVhlU+RKU0rmkGKHJXAFb20W5bp1EYJrWu
         OifWXYQT/JM0xNBVtK+/N2GRNlxb060dwLJscBzmerJv7i3gXIfRQUPSnHk97gh9ayq+
         c11VXHWXPxDEp7zxUbhckgzMDDpLHMXrpniqgHtw4kTUTHpENvaLD8ByjWBfMniFS3nA
         jChy19XDnMm9Eof+HIsOUagFguzDDrqRQLl4rzAOeUQaV20Q538ZfU2hXDJsj9eMdYpf
         FmD39tDPEWYrWrl1cwrDAZs5wA/AuJ6xuT/dU/B/MfQZ8pcsxTAqL3Yj6nfR4g9ubNxd
         o69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+pwyM95LFjypTLHvdXpR0+AeNhNrn4yjMFBh48w+MSQ=;
        b=NzKsuA8xTEolGr6jn75+5yeQ3g5XQnm6Rht5GU5/Pn30xjBjr459rxMInAhleGLYuZ
         5njjQ83SvFPMi2jE0C1dYRiVzPzGJ5tP+gnD5AyI+VnJAvVqFNqQBK5gGYn/TY4Sqzbk
         A14ugoQxrPf2xCNa4YFhjRffinXhU2a1JGH/zNjwXu/93NqN3gIOtCwarShNZ0/ECGX7
         MVmR+eOCqyxX0hvFv07d3iN57Cz0CQkar2fOpKf1Bb/rWisMybJqxb45x9UfFoXTExPU
         lGGqieeCxEVU4cGj/AiWLYsnLX7OJajif/tq5ifCrmAzPYt5T+/zMeXMO66P0gdSYi6T
         BxvA==
X-Gm-Message-State: AGRZ1gKjZTLOvgzci1oFkUshduhxYim63Viz0+xI7b+Z5i/VAKbq0yph
        bMAni+WBLS6cM1fqtHAnJkki8Y5i
X-Google-Smtp-Source: AJdET5cDkrYv2kW9YnZUDT0UWMVLXsL5hyhCA3ILz4nHVdMEgxim2X+gR4tQrfI/4slJZ2xIirXuTg==
X-Received: by 2002:a63:1d62:: with SMTP id d34-v6mr18564167pgm.180.1540908963722;
        Tue, 30 Oct 2018 07:16:03 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id m16-v6sm22019420pff.173.2018.10.30.07.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 07:16:02 -0700 (PDT)
Date:   Tue, 30 Oct 2018 07:16:02 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 14:15:57 GMT
Message-Id: <pull.60.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] Make add_missing_tags() linear
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, newren@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported earlier [1], the add_missing_tags() method in remote.c has
quadratic performance. Some of that performance is curbed due to the
generation-number cutoff in in_merge_bases_many(). However, that fix doesn't
help users without a commit-graph, and it can still be painful if that
cutoff is sufficiently low compared to the tags we are using for
reachability testing.

Add a new method in commit-reach.c called get_reachable_subset() which does
a many-to-many reachability test. Starting at the 'from' commits, walk until
the generation is below the smallest generation in the 'to' commits, or all
'to' commits have been discovered. This performs only one commit walk for
the entire add_missing_tags() method, giving linear performance in the worst
case.

Tests are added in t6600-test-reach.sh to ensure get_reachable_subset()
works independently of its application in add_missing_tags().

Thanks, -Stolee

[1] 
https://public-inbox.org/git/CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com/

Derrick Stolee (3):
  commit-reach: implement get_reachable_subset
  test-reach: test get_reachable_subset
  remote: make add_missing_tags() linear

 commit-reach.c        | 70 +++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h        | 10 +++++++
 remote.c              | 34 ++++++++++++++++++++-
 t/helper/test-reach.c | 34 ++++++++++++++++++---
 t/t6600-test-reach.sh | 52 ++++++++++++++++++++++++++++++++
 5 files changed, 195 insertions(+), 5 deletions(-)


base-commit: c670b1f876521c9f7cd40184bf7ed05aad843433
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-60%2Fderrickstolee%2Fadd-missing-tags-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-60/derrickstolee/add-missing-tags-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/60
-- 
gitgitgadget
