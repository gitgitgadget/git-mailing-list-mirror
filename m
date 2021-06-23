Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A7C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F362660FEB
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFWWdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWWdR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:33:17 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2520EC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:30:58 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z6-20020a0cfec60000b0290263740e5b2aso4595718qvs.6
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OHDmDA512c1khYtblZYHCVftv4gerf2zkiWwfabCBDo=;
        b=uRrVsyGuJzcQpUm4SjQc6g5OXeiGR8WSnOUQlZJgyC0ftNgB3KXuZLWRidtOtiLdrc
         Rq5a0YS0InMzKBcbs2N2Sx+3OrI4ITqJGVUPchoFs9kqATQ6CuqDsy2lZMd7FIdYhYUG
         G+/BfOOU7w6ZxQCmiJc/3dss7mqaxErDeh2XWJEi+Yh6xFybcRhqe76ykAneX8pFwnpA
         0Y+T2WaiVn/ATXqr/F41UCSejbJqPs81yc89Q5bR6p/WUhT3LwDKBP98a9uJDum2zQyR
         r9T8NiSQagyrt46cSv9kY/e6iJYiDg+XTtdRbvB/o8KP5XYO6jxdXWkqOW154XlfdxG5
         8zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OHDmDA512c1khYtblZYHCVftv4gerf2zkiWwfabCBDo=;
        b=V3js7mMSUm6l1LOYzqQeOBBibPvpYzEbTuCapXuByQ3bC8q8NQrwthexsbNjlcwPf3
         N1woitzJRRioZy8oeKQ2HPMR0CyyyBXZUDvc7JgIR/+Mkudzd9GDDsBUj9xXYGQI+u4e
         SY6N7thCyYONCq7t+o55YPashUSSEOGEKWlqUyx+NB//oGoD94rH58KvZe0jyPEoqDau
         y0MZdCQnp1m76BnYva11vQQuk0+qb6kFAbmTWFaPfp3AkjKdzAYqqHf+/wKQVyjoZgJU
         /g/KF1souWgMkZIx+hxUHCQFNnLQhor75atV2Bk9usHBVX86sc08J7tlJ6fYsAKMWxHn
         g7Yg==
X-Gm-Message-State: AOAM530UeqZMpBTA3C3whVBMv+UrGXD4HjDeAQUgWEQepX2LkFEM203I
        QBgD+POV6mSS0poXpypoBks4hKCKCXITSn9kkAsfWtD2TZGU33k0W53vHhp7IXko46D7W5PSCS1
        yE7Y+xTw3pVMQOfIigiL5W3VFuz69uUz1bLQoSrcT8qdSaOc/jWgr9+8f/oHvsyaEqxrqZTgRd/
        V4
X-Google-Smtp-Source: ABdhPJxEps/enfyxwQIxaO7K8b5S0AGjylflWcHNWJobY5PuIpd5VDxY6+mq+F/ru6PO/eIMMbct5jWugIMHMYWdjgCJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:49cf:: with SMTP id
 j15mr2138392qvy.34.1624487457233; Wed, 23 Jun 2021 15:30:57 -0700 (PDT)
Date:   Wed, 23 Jun 2021 15:30:50 -0700
Message-Id: <cover.1624486920.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 0/3] Push negotiation fixes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Testing at $DAYJOB revealed some bugs in some fundamental scenarios, and
here are their fixes.

Jonathan Tan (3):
  send-pack: fix push.negotiate with remote helper
  send-pack: fix push nego. when remote has refs
  fetch: die on invalid --negotiation-tip hash

 builtin/fetch.c       |  4 +++-
 builtin/send-pack.c   |  1 +
 send-pack.c           |  6 +++--
 t/t5510-fetch.sh      |  9 ++++++++
 t/t5516-fetch-push.sh | 54 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 3 deletions(-)

-- 
2.32.0.288.g62a8d224e6-goog

