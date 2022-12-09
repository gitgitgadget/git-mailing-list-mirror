Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D41C04FDE
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 21:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLIVoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLIVoc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 16:44:32 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342D5303EF
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 13:44:32 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 134-20020a63008c000000b00478b9313e0eso3790538pga.9
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 13:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwKbvaXU+L0SbOjSLYra6EM27mGx94iI5RwBlo+OQpM=;
        b=J3Jn8rTw4BR/pAhENzv2HsqMqy9MCA8rrXR7zpKHs6gc071jjIEOxeJxRbVNNSBB0A
         yTNVUb8WIHK3C2c9Pb++RAeSQXNBCkDtaDcKrhVKjnzMeOjtsLthniaCLKE0bAjJvRFH
         g2F88+AiP9Qf9K/UJELCUtUV6g5hn4lueU9bUbRricuh4HvxWljHPSN5aSdmollO2Lp9
         bdHrn3HZ/wDWpwMEhneXeukTMNyePL0fyKz8PDWQ9DnD5+fKXLQHOwYV97C7J8M8eFIZ
         Ocrnw8B/Ach52wVJV7ngHlfHDBjZhCmLoBtwEf0qucUPba85na6pAEtZtCimkrBTSr3A
         1vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwKbvaXU+L0SbOjSLYra6EM27mGx94iI5RwBlo+OQpM=;
        b=O3CdYlc9I2U9X3xXMR2IB4PgRf+wAfN5xjTa1Dx725w2u9UVz/HWxAg13ylvXLf3z0
         kuZKRboWOwPb8voZ0alHcC5OJm8bSZ1EwiBiqbvKyyYcphCBKc2VWQKEfEmxnsULi7Zl
         /d54UfHoNmWjw6M82gxAZbvgj6jCkt104YVv+FLfozGJfjLWzcEE9A/EuA+2OURZKbf8
         UIky1MjW+y2TSruQCWf9NfrqffHVVgiLXtPuK538XMtLxRn5uAfj3RcOftWXiUs2d3PQ
         vNxhvhaqW5qmIPK9zB34mqrrIA0FYzHi0skWHpedu/3ssqdyofModib/BabsvH9/G/NH
         +nyg==
X-Gm-Message-State: ANoB5pl7ataOzhN4ptu6LSzfAz6osio7ZvGckf5/4CCEhutav9m9foeF
        qOgBCTSXmP0izZFVLf8URP9+3ulOZPZrLD2Sle8LYSADMkI2SpQFAwBsPGAr2R2XF54/2XLI8j9
        PV1WQceaBkCflSt1VeC2MDeX/ptukruHqaYZgvSJ1TsCghDXlx0xo2NkkHXvsVlGHsQaZbOfc6J
        QN
X-Google-Smtp-Source: AA0mqf6KerEcHz0zKqgrXivtnVJTzDYe6Fgl+QmqkWhp+woEVvknwT6jUBRREKQpxfRluBLpL5xl1EUNx7Aznvrcuucp
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:6b07:b0:189:93a5:bcc6 with
 SMTP id o7-20020a1709026b0700b0018993a5bcc6mr49934054plk.156.1670622271662;
 Fri, 09 Dec 2022 13:44:31 -0800 (PST)
Date:   Fri,  9 Dec 2022 13:44:22 -0800
In-Reply-To: <cover.1670622176.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670622176.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <be0b08cac219357e1ce9cd46fd7ab5c13344699b.1670622176.git.jonathantanmy@google.com>
Subject: [PATCH v4 1/4] object-file: remove OBJECT_INFO_IGNORE_LOOSE
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        avarab@gmail.com
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

