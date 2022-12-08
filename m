Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C99C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 20:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiLHU52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 15:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiLHU5U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 15:57:20 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7C9934F4
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 12:57:17 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c12-20020a170902d48c00b00189e5443387so2344356plg.15
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 12:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwKbvaXU+L0SbOjSLYra6EM27mGx94iI5RwBlo+OQpM=;
        b=Fm3PpQyF4bgYhbXfi4SlPH0iVRTjjnfAbrd7QDI2Zu28qjgxp0LUYB2zKc94eKGZ6n
         4blkCdOfsEtHsTdACDFPAih4vg95v1XXAwKRtvc75zOpTW7Pz0H0QDjhvK1GQCiGKqq5
         VBTZ25nWTB3NHzrFGbo+HaGYbLscfmnEYG8WJ9psM05hq3Th9JyufREZnxGSoTIkwUU5
         NqfMKqY1ThVT04FP9QH0oOFAgwpG0uJ1kOMBrKga0RJ+0917/q/vQf07H16/2e41C8YG
         JZXzQ4rnPYsTfaKw9g66y18BEzu9y+mz3fxhxKSbX5cjYI1FwciNbT2rgrhqDEYutKhM
         Gd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwKbvaXU+L0SbOjSLYra6EM27mGx94iI5RwBlo+OQpM=;
        b=J39coZz16FsM1nXJKfmJ+y654MDwcnEWVkq1hUduL/OXUKOr3GXMmPuusjv8q8/NaG
         PCm3PyMHX5rsf5Gn20bSr6TqhGv1G4iCTfF73corOHMSAInSRFVI/pXZI2v1AQxFrYLD
         EUksajlbj8YflMb8fk+h6/h8L2oigIMaWza2ZAfxzD7+vEgo1DEifZJmQX6QoYuh6Gm9
         KYuBs+mpfH/CIwm3fS+fIDTdSgmDobkRNWfyxPatehjwNMik4Omkyfq9xY7sz1P23oki
         So8VZxFDPFC4xeZeuiu0bCw2+VPdJI3kBtVbElzLWT5XzwmzWJeFLvDMcyy9+hHXLLyM
         d6nQ==
X-Gm-Message-State: ANoB5pkQFkK9kqFUTPsbYbJZz/ZHw/kY4m2sur0f21cX5U0tRh4YnMV9
        JyDvtd1uz5qGS0FjmOeqM122m+tMVq4Y2IKBdy4SAjsU3POD/A8DzQIONHTdiN8m5APfAvvOQsa
        eG3+ttaHcX01OvNPhYf1noTMLokhH3Ce3qy+iZW/iATBvdpqk5NJeMU1IlyAxFuMPwrA+r2VTHQ
        M2
X-Google-Smtp-Source: AA0mqf4qzvQvHMrb4lIEqTsRbbWxg/eK8oAb7V2JokJDtUwCI52w+GljKoksbsg0AlNHKBjqC+Q+4+g5gLxYulwbjvnM
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:8406:b0:205:d3f8:5241 with
 SMTP id j6-20020a17090a840600b00205d3f85241mr105997506pjn.188.1670533037064;
 Thu, 08 Dec 2022 12:57:17 -0800 (PST)
Date:   Thu,  8 Dec 2022 12:57:05 -0800
In-Reply-To: <cover.1670532905.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670532905.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <be0b08cac219357e1ce9cd46fd7ab5c13344699b.1670532905.git.jonathantanmy@google.com>
Subject: [PATCH v3 1/4] object-file: remove OBJECT_INFO_IGNORE_LOOSE
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        avarab@gmail.com, gitster@pobox.com
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
2.39.0.rc1.256.g54fd8350bd-goog

