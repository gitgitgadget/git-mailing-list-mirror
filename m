Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB725211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 22:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeLEWcz (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 17:32:55 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:35881 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEWcz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 17:32:55 -0500
Received: by mail-vs1-f74.google.com with SMTP id r133so11073407vsc.3
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 14:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=TzJAFwTNm0v+50+pbify629TwxUjKmzaq4p9toyEveE=;
        b=XrW4wSZ2utl2679zWZRsULxzGIE324yvkaWpov3mnrqOxhJXvEoooI5QNsUTooMzc9
         TgHnQQLI2+vyjlIknq0k4wdC252q+Sxmv8A5n2MCS+ylSAqxlB2WTnvnvW3bbP+T7UGJ
         oW8vNYzl1+BYdCDwrbGnGK/XfFTkqMkpIZWp+KYQ+msqqVARBVhoLIjzYB8QiL1xrEvH
         ifKS0P29GcfNlBxV+wmPa+K2Pw6BFFFBc6AcodjQsv+GNJ3YmHTHTxWU3mVCuWGUNic5
         CGqXvjfxhvGUYXI8M8+ltL4Eof/g4dAVH+mzAzN4t9+VoLYoZPwXSIoUgpr8b0KL/00C
         XV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=TzJAFwTNm0v+50+pbify629TwxUjKmzaq4p9toyEveE=;
        b=ryuj1sznXiqoWx9CvTqRXXoUSLBevlnOgm5jdzYDUBHs54bb/Ihra4jz1bIjf+k81F
         1gZS2PndmQqGjQ7HqnI96rsEMqnHqyWfLyrIYGcKk94ExCSRKuMFVwjpBh3gNakUSiim
         QEn0tUBVqCoy6Ks6Nt7QNZ9KDjvIfi5Ne2+62owZoeQYathL9pDsC8G6tiIrIa62A+J2
         PVRvridHxDDyF9dUjQJDVa4/0fCwimtdlFh5X5DHEa8d6T+e7iSyztpS/RarKmwi9waC
         vn9BhQGVCyY+6AA6kGWtMT3Jv4AL5+dsHLS9xxO6xU6byQBaSyf9j8ys1g6Zfey8hHNV
         zjJA==
X-Gm-Message-State: AA+aEWZzTpSAsyAYyAmMPFoXkkD4OEoh1HiyF6gptkDwVwY7YQrTRAz6
        kuQDZsU/S97VDjtTUpWeBoMytmVpYTMDE/Id9+QUNKz0MZAqhB0zmnzD3+eo4atiRlbmLl/x1x4
        EOyEKi3lA5b/ejd92OZTkwub5ZIuNBp5fdNaxkr/+R2zThIpvcskf0zMVnAk9aV8=
X-Google-Smtp-Source: AFSGD/VQ7j5uGOJP74v1pEoVlolkTa5vipLqSjEhSBYkof5Xlr43C/diJ6V3MQJJqx5CN+HgxkkxGmY7G5ts6w==
X-Received: by 2002:a1f:bfc7:: with SMTP id p190mr22056082vkf.1.1544049174468;
 Wed, 05 Dec 2018 14:32:54 -0800 (PST)
Date:   Wed,  5 Dec 2018 14:32:49 -0800
Message-Id: <cover.1544048946.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH 0/2] Add commit-graph fuzzer and fix buffer overflow
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new fuzz test for the commit graph and fix a buffer read-overflow
that it discovered.

Josh Steadmon (2):
  commit-graph, fuzz: Add fuzzer for commit-graph
  commit-graph: fix buffer read-overflow

 .gitignore          |  1 +
 Makefile            |  1 +
 commit-graph.c      | 76 +++++++++++++++++++++++++++++++++------------
 fuzz-commit-graph.c | 18 +++++++++++
 4 files changed, 77 insertions(+), 19 deletions(-)
 create mode 100644 fuzz-commit-graph.c

-- 
2.20.0.rc2.403.gdbc3b29805-goog

