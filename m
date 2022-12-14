Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05651C4167B
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 19:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbiLNTRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 14:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiLNTRv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 14:17:51 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD826547
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:17:50 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r22-20020a63ce56000000b00478f1cfb0fbso2353953pgi.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=btxCyeS5SO84pefgv4RjQiddE/osSnoaoKyl/DOE4MM=;
        b=UG5wGsFSHkNC5iIHLEdJy4T3UIvMgLAhl7eJtwt28qTad5KekhVyfKbMyUwrJ6pQ01
         lYDAWKzprWJUYr6lHy+Jh6A+QGuow/n5pQKV94paC6iLHYgLRd3Q7ipVydmFNPoEd8+8
         rKd0YX5tH5/Gfrh/WiGhgC2GuS0YI1k4t2DUMMgVmkTEp7aFORO5AhWJEF0flK6rDKNY
         jxN9MLlYsdrdyqd18oq0+vgZJRcu0BU5PtVfMyXOyVh5kFasXxJ5ZM7fg11IALxqxcjG
         TFfoQr7em4fwGCnSwuMZJYLGVp4Q9ttHbMjH7c0L5twJNJLx1QH7MANWrMzbKtIDZ3g0
         AhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btxCyeS5SO84pefgv4RjQiddE/osSnoaoKyl/DOE4MM=;
        b=HLM/nCMAeIJSWQkLD3pkDUsig8f/+iDehSbSU2xBXxBynbPO+g/4F+ZaPeLB9e7URN
         ws/AR54geygw0NrdSFFyi86xTefyBBAzcyV0VPhdEMqN/+akMqfMWIgS+zLDT3jR33CE
         8B2t2yiEuyaOtFLOc2qy25HGs2o+Zr3IqfSSioQmqHBxqqg7nWBnJxsaWLlajS736kKQ
         nWb63riKSPuMjVo/Nsg/hkuPAF4HJCurLGhMNXXhpE/n1KTrzaeqRHaG37ns2kTWArUU
         JaN4B7lR7LhDP6LihML4a15mU7Nqj6rDzbej28sMAMJYYpVS5UFOWZPmJ0vmp5aWuSDG
         OlEw==
X-Gm-Message-State: AFqh2kpKp0gWpcvZ4eRJ9s7TruvPnMq22lgearVF97PodY9spQl4TNa/
        0NyyXLLO33rctwOaxUq94mBuuuA2ePxOJ67b8Md7bUkab/ZFuVLpspWuxcmj9TPa8wmGa8VbBa1
        IEILrXBG3aQtMAj/HFZPEyklp+XhGLV1laOqsARd+3cKj6sEAlSv3RZUSodxKyTPV47I3HfHxvv
        YX
X-Google-Smtp-Source: AMrXdXsZ6BxthtE22sDdK/dI00V1y0MSnGSgR3CMhy7IZQrEFi/Bd2843UK5S4KnrOxEuerP6fKpA4iGVtJNjG9VATyG
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:da02:b0:219:1d0a:34a6 with
 SMTP id e2-20020a17090ada0200b002191d0a34a6mr80353pjv.1.1671045469176; Wed,
 14 Dec 2022 11:17:49 -0800 (PST)
Date:   Wed, 14 Dec 2022 11:17:40 -0800
In-Reply-To: <cover.1671045259.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1671045259.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <be0b08cac219357e1ce9cd46fd7ab5c13344699b.1671045259.git.jonathantanmy@google.com>
Subject: [PATCH v6 1/4] object-file: remove OBJECT_INFO_IGNORE_LOOSE
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Its last user was removed in 97b2fa08b6 (fetch-pack: drop
custom loose object cache, 2018-11-12), so we can remove it.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c  | 3 ---
 object-store.h | 4 +---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 26290554bb..cf724bc19b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1575,9 +1575,6 @@ static int do_oid_object_info_extended(struct repository *r,
 		if (find_pack_entry(r, real, &e))
 			break;
 
-		if (flags & OBJECT_INFO_IGNORE_LOOSE)
-			return -1;
-
 		/* Most likely it's a loose object. */
 		if (!loose_object_info(r, real, oi, flags))
 			return 0;
diff --git a/object-store.h b/object-store.h
index 1be57abaf1..b1ec0bde82 100644
--- a/object-store.h
+++ b/object-store.h
@@ -434,13 +434,11 @@ struct object_info {
 #define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
-/* Do not check loose object */
-#define OBJECT_INFO_IGNORE_LOOSE 16
 /*
  * Do not attempt to fetch the object if missing (even if fetch_is_missing is
  * nonzero).
  */
-#define OBJECT_INFO_SKIP_FETCH_OBJECT 32
+#define OBJECT_INFO_SKIP_FETCH_OBJECT 16
 /*
  * This is meant for bulk prefetching of missing blobs in a partial
  * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
-- 
2.39.0.314.g84b9a713c41-goog

