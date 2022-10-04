Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E83C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 21:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJDVN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 17:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJDVNx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 17:13:53 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CAC696E5
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 14:13:52 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id h1-20020a62b401000000b0056161cd284fso4535892pfn.16
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQUalwW7Eaesvmmhsqau3NzxbJY5laxHnzD0HXJnfVk=;
        b=Z35LQ+ouMI/iRaaBSELILr5mJTrzaoIfHI/+TevTpRC2Z5o7DY27UPlsUIRPNVFNDL
         nPpBQDkHEneimWVmygtzPxShm1k40dSKLE0k+S73Hj2mnINvfE4jgb8URAS09zN5ueIp
         +BF17QOwuuZ/pUS30OoA1u5yw6sGng3Bpw2Z6VY7ZhNZHKY26/UQQcFFboe5O2aaqN6D
         QMAm4gi4J9EyItg0fo/mb3UCBhkFctMdwPRcl2ldekKrOrQTopIoOhBQUKI9H78YPGgI
         5xQ/1iTtiS0vcA0OCmbtiGd3phQ1wgbX9yCrEpsNYFcbFlxFc/iEHUcYUHpfIzou1IO6
         o/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQUalwW7Eaesvmmhsqau3NzxbJY5laxHnzD0HXJnfVk=;
        b=OJ37uflzIijizwl1j3V8SJ3UPokWsNO5GYOpngN7P+M3hLWL2q1qS1MJko/s//3jvg
         dhgEOEEai75buVoP18G7lUv7Rs8+lVWN6CqJXxViZn3egijGVN+3mdbiAr+G1DwqTU6k
         ACqKxA35my7uDGjFFVVzkvbPyzVzQ9bv2ECG5/cALSwGPyTV7g+mO3szLa9LWKCsTESK
         /NFztRuOWEPsi/m+zPbFXD/d4mkGxk7PVc4aPupz2LHTl32/KCL25mDYeKciFlyUJ2TF
         Cw85fKhLn4COmxXtGfIOHwNoyyg/LiAHb1A2BQHf3tz58s8BQAV5b1Zp07btQ3iIxK1c
         yyrg==
X-Gm-Message-State: ACrzQf3bVZTRbTnHP+y/kJspKONnAeb2yKD4VJM4JuEQDX0lVMNVlWuN
        pgfOkBsxybsSGCR0GRdoRCkTT9Lwp326q939gREtTVOBRajBpTx4wi+2Ac9p/62WZIvfdB1Z8mG
        SgUmO818Hnde5BRNDV6sT6eDVCiL3g6cBLNNxibYzOdITy0+9+pp3lvxAyYZVfHSllhh/kWZ0Yf
        9M
X-Google-Smtp-Source: AMsMyM7TiteYg+q6jPFuDIT1HSHl23tYjtSACr1c1jgs8Z8MeISTMoVIyqUJJvUeUWO0wGDVLIAxUYEeXL1bLJQ7m+KK
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with
 SMTP id d6-20020a17090acd0600b00203ae0e6a21mr409601pju.0.1664918031064; Tue,
 04 Oct 2022 14:13:51 -0700 (PDT)
Date:   Tue,  4 Oct 2022 14:13:40 -0700
In-Reply-To: <cover.1664917853.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1664316642.git.jonathantanmy@google.com> <cover.1664917853.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <207332c2dff047866a298ba7f72f043a009702f3.1664917853.git.jonathantanmy@google.com>
Subject: [PATCH v2 1/2] promisor-remote: remove a return value
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No caller of promisor_remote_get_direct() is checking its return value,
so remove it.

Not checking the return value means that the user would not know
whether the failure of reading an object is due to the promisor remote
not supplying the object or because of local repository corruption, but
this will be fixed in a subsequent patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.38.0.rc1.362.ged0d419d3c-goog

