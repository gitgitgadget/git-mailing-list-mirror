Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBE1C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 22:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiI0WMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiI0WMj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 18:12:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D91CFE5
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:12:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-349e6acbac9so103986447b3.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=hlPh1yM8II+eATi9HhMoiNW95pQ2XsD5kHlNh+6YKnc=;
        b=rI3gFECq6rvnI8T6UV3BTE3fcKpqhXuQe6vAKFJr38pYWDbeiHFU+ymFhwNslLKPTv
         dZaqn2aW5nd6EYNRAOZEgtnbtUVoLXkypXeEBZ5pLvy0BDfXN1J+P1VtRVcd436mAyf2
         ha4uPVM7ri1eWCKQ8LZ7lmTu7uvaC9a91SXnHEiy13xKZx+BD+LIGP3hJ+aaXt3eNBnw
         WwTnL2ZyUM5JN1sDCBFLEIiv0UPJrH4KTF8U52ekE36WoC1sC5U4PoHvU3ddOJwZxhMf
         CS6BVH61agxJ54WMT74lNN1T9B1N+EC1myvjFwPTAEmjeOM2TAAfhDJqkiSLHDppOukC
         FAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=hlPh1yM8II+eATi9HhMoiNW95pQ2XsD5kHlNh+6YKnc=;
        b=dQhv8vVUa1JY6JbdY1LZlsLJIWq8QeTl4ddfTfQp0S44lV+RsgDHdh9K9IAQRvXgus
         yEM7eUN5ZlqgPB0H1SEJUbsVDMcFZHRULsi9TYK7lSDRviqIDImzBPefs1W5Aj5W8FpB
         8alIniKWDNBH0ew4T4gUCKlmlUuQagrC/tGTK6d88t33gCBu1B9LUF9qPlCg2cM4VTvY
         KdrEwe7CmpQySZH0X3CgsrGI96TXT3S4HzpCvjwzlCOzksgA4nz9osCTWAiaPDqX8KIz
         WZDqrX+btFfwAKVBg6hb7/wYX2QI4jwP447MoW4DN+rB3oS4QzuzrkdcJbRJd6BL1T9O
         o+Rg==
X-Gm-Message-State: ACrzQf2N+dOX7Zpis1853PNieIzdCD5ouErs6siH2c29UWI6kLrLd8SW
        8cHWAK/IvlMy0RNC9TXHN5XrOzfLYkptQXYrnvYMrvyvp6807mSfakXpWCyGnHDiM8c8P9+c5eR
        rJWxkvUtobrbH60Hhbh8noEAezb5RoWo3VA3IcMjRAKVLhlow+UWB5yPJvBbfWG1ym/lAzW5CBS
        GZ
X-Google-Smtp-Source: AMsMyM4SRziJh/gsEnIdkigR1QHQ3kovqkv/u88S09vWfarnKq1joeewK3M37Yeng/QTl7fMTHTf1bliN+aSXrB58hVY
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:554a:0:b0:346:ce61:135f with
 SMTP id j71-20020a81554a000000b00346ce61135fmr28459849ywb.79.1664316758416;
 Tue, 27 Sep 2022 15:12:38 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:12:29 -0700
In-Reply-To: <cover.1664316642.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1664316642.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <7cef8088cebe368e66237837eacec71381182ec1.1664316642.git.jonathantanmy@google.com>
Subject: [PATCH 1/2] promisor-remote: remove a return value
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No caller of promisor_remote_get_direct() is checking its return value,
so remove it.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 promisor-remote.c | 12 ++++--------
 promisor-remote.h | 11 +++++------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 68f46f5ec7..8b4d650b4c 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -230,18 +230,17 @@ static int remove_fetched_oids(struct repository *repo,
 	return remaining_nr;
 }
 
-int promisor_remote_get_direct(struct repository *repo,
-			       const struct object_id *oids,
-			       int oid_nr)
+void promisor_remote_get_direct(struct repository *repo,
+				const struct object_id *oids,
+				int oid_nr)
 {
 	struct promisor_remote *r;
 	struct object_id *remaining_oids = (struct object_id *)oids;
 	int remaining_nr = oid_nr;
 	int to_free = 0;
-	int res = -1;
 
 	if (oid_nr == 0)
-		return 0;
+		return;
 
 	promisor_remote_init(repo);
 
@@ -256,12 +255,9 @@ int promisor_remote_get_direct(struct repository *repo,
 				continue;
 			}
 		}
-		res = 0;
 		break;
 	}
 
 	if (to_free)
 		free(remaining_oids);
-
-	return res;
 }
diff --git a/promisor-remote.h b/promisor-remote.h
index edc45ab0f5..df36eb08ef 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -39,13 +39,12 @@ static inline int has_promisor_remote(void)
 
 /*
  * Fetches all requested objects from all promisor remotes, trying them one at
- * a time until all objects are fetched. Returns 0 upon success, and non-zero
- * otherwise.
+ * a time until all objects are fetched.
  *
- * If oid_nr is 0, this function returns 0 (success) immediately.
+ * If oid_nr is 0, this function returns immediately.
  */
-int promisor_remote_get_direct(struct repository *repo,
-			       const struct object_id *oids,
-			       int oid_nr);
+void promisor_remote_get_direct(struct repository *repo,
+				const struct object_id *oids,
+				int oid_nr);
 
 #endif /* PROMISOR_REMOTE_H */
-- 
2.37.3.998.g577e59143f-goog

