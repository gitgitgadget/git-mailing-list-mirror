Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D39C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLAT1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLAT1j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:27:39 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C4BCF9
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:27:37 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 11-20020a63000b000000b004776fe2eebfso2482854pga.9
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 11:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhFvxOTtDVsVIvDDtiSjZfhYyykMUe4az/D4qrfxjNA=;
        b=hyzgiZiuRtPLn5kbibdFqGDbiTSEFghpKdtJffqX1lzOuD8ZJ5oXXkpjUqUHLVwv0T
         3FCf8VDVlqtskyYqz7CqAsVs1rGuZQMmQlz6Ck95q7rrtQh9kSzDwEEMpoT4GKPovqRy
         DFNH786/gHF3i+IABSepV96AO5ReDBzg15DD9Hy6SpoksHS886JPhivYI8jFDtFHxSUJ
         RNM9pQYyPuw+1Ov1DSmoLlc1AdQnk7s8NZMcnkIfBkyX9ixfJzE+hOUePTm0Xg8EukHL
         C2Zo038CsUoTMJJsHV1Q6p0vRSv1IBGm34AlB1v9jrJEolWKYoTdxDLo5QBdnM+k7Y2V
         zigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhFvxOTtDVsVIvDDtiSjZfhYyykMUe4az/D4qrfxjNA=;
        b=pgjLpyLlXn46/lGIarhiHeNHS6g7Dcmfh5ncrYHOoYm5jZML9G/wGN66AKndLCAYAK
         7Ha4MWTMFediZNut4fvEdqkiCOmhNkf+tGeclYn9zS2YZICc4+m/mMWpwL5IN3CHYIQ8
         9yoGpWokpkMmjcFnZvMpAckk4zBOqRiIwgmid9yCAyh1D5DVZoMfoE9Wio2tcoYidlYn
         Hid4/obUKpGROTB81atDLn5g+OkCEFhvLHAS8LaQXwYC0p+542dznzTAPwGo6KszN02V
         hmBX8BD58hC+NBUTAy8mIlD7WNd8NmJi2HlFPpfPtUqMM4euYmqzMDYyJKb+4gmkDqfa
         RGMQ==
X-Gm-Message-State: ANoB5pkO1Wor8P6jBW+ubp3rTnZ2G+/v6yh+d5GdLVGUT041Q2kOuyAe
        c0RIunh1FTp5/ySX29OAuzlFvPV6dN1rIW0Sx7aVrLDT4g7Q6fmFu0azTh6506WtjCqEWoeYfUX
        4ikPa6OOteoOIOGdC5aLzoXBlQhQYCgrS0hfO7qD+t+WPv5XDJr1Kf1P4JCkJ69zbvnjiwdyEcS
        xR
X-Google-Smtp-Source: AA0mqf50QLy3JdENXh3+ai/1cYPHfx965CkP1UviVZtTPxNMUl8gSoRbJ3InZOCT1wZfb3Uw2ld0sDm0zhPOe+cQ/nVX
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:cf0e:0:b0:477:b603:f754 with
 SMTP id j14-20020a63cf0e000000b00477b603f754mr39375734pgg.232.1669922857282;
 Thu, 01 Dec 2022 11:27:37 -0800 (PST)
Date:   Thu,  1 Dec 2022 11:27:30 -0800
In-Reply-To: <cover.1669922792.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1669922792.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <604160e79cef94fd8e03fe025990c999bb795395.1669922792.git.jonathantanmy@google.com>
Subject: [PATCH v2 1/4] object-file: reread object with exact same args
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an object in do_oid_object_info_extended() is found in a packfile,
but corrupt, that packfile entry is marked as bad and the read is
retried. Currently, this is done by invoking the function again but with
the replace target of the object and with no flags.

This currently works, but will be clumsy when a later patch modifies
this function to also return the "real" object being read (that is, the
replace target). It does not make sense to pass a pointer in order to
receive this information when no replace lookups are requested, which is
exactly what the reinvocation does.

Therefore, change this reinvocation to pass exactly the arguments which
were originally passed. This also makes us forwards compatible with
future flags that may change the behavior of this function. This does
slow down the case when packfile corruption is detected, but that is
expected to be a very rare case.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 26290554bb..1cde477267 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1621,7 +1621,7 @@ static int do_oid_object_info_extended(struct repository *r,
 	rtype = packed_object_info(r, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
-		return do_oid_object_info_extended(r, real, oi, 0);
+		return do_oid_object_info_extended(r, oid, oi, flags);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

