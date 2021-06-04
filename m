Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85704C47082
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 02:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A377601FA
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 02:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFDCnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 22:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDCnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 22:43:31 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15410C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 19:41:33 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id s16-20020a0cdc100000b02902177eec9426so5826282qvk.4
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 19:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=o7rTTBWEE4ZQIMoJXLhtw554aiFCuivy0zv+U9kXizY=;
        b=ofSWUuwyuQmyY1ivzC+P3f4yZb0PqHIBllIYHy6HJ1yfucAMZqVmh0TLGnMO028oy7
         x+PQbM84A+oWhjaJ/0VJt+eFhxt5QfChB0bk0gcBScai3kLmB9UeKRSq4+c4wmkG8BY3
         vKZYw3MMy8mlSOsCTho/oXN/d00zcrUve25JqQPka6SJu60l6ZtpszNxZuU4Bb8v+3gB
         hlHpITdfYKjD2bSWZLXdC7eiFUGhGmfAyX3sI89ZoB06QqK8cI1HaLqXuB2b9XNraMTd
         1Rd/YNBZBgUbElayf+OozQgOKRh0tegzeod/zZsY+1v1r+Z4ySK7Dru7mIJVHxzKdw2D
         vttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=o7rTTBWEE4ZQIMoJXLhtw554aiFCuivy0zv+U9kXizY=;
        b=AoOqfG2oTybhPMZ6WHVVijeMIR+hPYjyODMM1j1eCB8k1j54pTdQiNnRnTAvJms/55
         qBYSblYyBCmYRGF19ba/hkOH9C6jozarnY4SxYBCYCjh3Pkzn3tR6l6VFQnz1fkCrpOo
         /1HjTbbCK7c8IAVqIKuA04ghX31EophHBzNjWAtzn7DnFZSCw4Z7Z6kudd8IBl8In4mj
         WFJsHs3kl0i8r5g89cIZ6szZXGoRyDB/ANJZhagIvb/6lY2H75IA7ZaoX3G7rvXiEUXQ
         lViD9XCDk4pONjku6GEyVxZW8IKhAz1XVlbwQGIi6i4HOtLuQQY1oIAf9uRnwXJeiqdU
         lwpg==
X-Gm-Message-State: AOAM530sn6zUxxlhVg+7jfqrejbf0+exHYbwL27eNcIb6BOUrKuRf5T8
        FxJvANFl4oNJYI28eECWvemIegaGj8QUcjqSqJXmBYAZtR2rotgEt5vn87unX8d3utw573y6uCX
        7C9MqgR4Y4/euj7+ZJQY6580JAP9KdcItYax+DNV+AZY5dyZdtlJQw4OIbtLQ77Y=
X-Google-Smtp-Source: ABdhPJxHegB1lokA2Qd2nofG1140QFgPRenMN7054iY6cRn/H4ERrZzR7l5Nl+hyNPqdlsxoYyp4CGVo6hQn6A==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:764e:f4e3:9f99:dcfd])
 (user=steadmon job=sendgmr) by 2002:ad4:5227:: with SMTP id
 r7mr2716487qvq.41.1622774492175; Thu, 03 Jun 2021 19:41:32 -0700 (PDT)
Date:   Thu,  3 Jun 2021 19:41:30 -0700
Message-Id: <07a3f409730fb7d725042ee24b7556d17efe4676.1622774341.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH] docs: fix api-trace2 doc for "too_many_files" event
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 87db61a (trace2: write discard message to sentinel files,
2019-10-04), we added a new "too_many_files" event for when trace2
logging would create too many files in an output directory.
Unfortunately, the api-trace2 doc described a "discard" event instead.
Fix the doc to use the correct event name.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 3f52f981a2..037a91cbca 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -396,14 +396,14 @@ only present on the "start" and "atexit" events.
 }
 ------------
 
-`"discard"`::
+`"too_many_files"`::
 	This event is written to the git-trace2-discard sentinel file if there
 	are too many files in the target trace directory (see the
 	trace2.maxFiles config option).
 +
 ------------
 {
-	"event":"discard",
+	"event":"too_many_files",
 	...
 }
 ------------
-- 
2.32.0.rc1.229.g3e70b5a671-goog

