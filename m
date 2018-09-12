Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EC441F404
	for <e@80x24.org>; Wed, 12 Sep 2018 15:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeILUwx (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 16:52:53 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:49091 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeILUwx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 16:52:53 -0400
Received: by mail-qk1-f201.google.com with SMTP id u129-v6so1955961qkf.15
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KdcF0PvvH4CW9ZFCYbckJxcaB1xkaZswpoyDZjaXtvM=;
        b=nJTmRI4zXIbXPBDRPSFoJUNPbJlNTnG7a/bdVHn9go1FoSu5CKQry6aeE5QQIjvTJY
         RGCgVuqk9UQpeQD/sR0HknJXpdivNykBsbfUT00cd/cHfpy7ipCx+j8bgRqnQtHZlTFy
         M48f3xf1FCSY7qC/06BrneDilveOnfqvFWtKx4F3lxJ3/x2z7/TeefUMd79duOmHAHyh
         sLJgfWxull5ZfokhdVwnlRO/nCUvhZUfoEkbPR177oXLF9bvOkHMytijOuBfNMHLLjnr
         IdNVV8jMSTuVA7UKnSvTqlb07h0nOjy4tPMLx+lDIRgLiLOZVSS/MBv9QWYT+bYtGt6d
         yiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KdcF0PvvH4CW9ZFCYbckJxcaB1xkaZswpoyDZjaXtvM=;
        b=Yiamasqc9TexaGrE2YrkZZ1/l4MWar+jX9kqU59amXU2ZLJAOWm82DhItntz2F0tmU
         Gg2Z3us7+Rdw66HHmqNFA6aE3LhaHN/ng5H23mCTXAYr0jKQoj69ZoKvPFZDDSK0jrBb
         pn6DS68hkJPpSqGJCSLPgToMBn4dYuTaAapjSSDth8rqWY8A97zaFihsQOwLUlehHzGl
         leJ69NggjBB+bS0pMxfw/qVEWGUXdGKsxayFQ3WG+iAPE7j3ia6U/I6sS974sFE+eyqZ
         bCacVao9Jap88/Xu87VjMS/10D9cNQCSlMQ6R/oTd1PFmqHwNcnd3lluCL6E4CvxvaQI
         IUkg==
X-Gm-Message-State: APzg51CeJyrf/da/jDdmp6QmWcTHT7IXRQ6Ood6kOBihEQGhbfoVe8Yr
        dN23d/dvyTXLzOhpZvaUgROtfSw5O5+Hs7+Z7s5//LMky6bA5eSTIBW1t+hj7hGGP9gFKwumOYU
        Q+SbbC8NirDQAh6W/Ply2HCZ3Pkl8vtZwedM3i/Hy/xMXumM7CSFqtCTwf6vFVrMlpBKPRWMMiI
        5P
X-Google-Smtp-Source: ANB0VdY7IEbByNGzGsHl4KsxAm7B9udBJIXDk06YH7Gbwyu294Cd2qJgYODAYBvzB671/G12nPdL1S/9bqmFGtWR9OuD
X-Received: by 2002:a0c:8937:: with SMTP id 52-v6mr748825qvp.54.1536767266276;
 Wed, 12 Sep 2018 08:47:46 -0700 (PDT)
Date:   Wed, 12 Sep 2018 08:47:37 -0700
In-Reply-To: <cover.1536767071.git.jonathantanmy@google.com>
Message-Id: <72399daf65b9c0a7ed12589584f5108a9ff6fc26.1536767071.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1536767071.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 1/2] fetch-object: provide only one fetching function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fetch-object.h currently provides two functions (fetch_object() and
fetch_objects()) that could be replaced by a single, more flexible
function. Replace those two functions with the more flexible function.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-object.c | 16 +++++-----------
 fetch-object.h |  8 ++------
 sha1-file.c    |  2 +-
 unpack-trees.c |  2 +-
 4 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/fetch-object.c b/fetch-object.c
index 853624f81..1af1bf857 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -23,21 +23,15 @@ static void fetch_refs(const char *remote_name, struct ref *ref)
 	fetch_if_missing = original_fetch_if_missing;
 }
 
-void fetch_object(const char *remote_name, const unsigned char *sha1)
-{
-	struct ref *ref = alloc_ref(sha1_to_hex(sha1));
-	hashcpy(ref->old_oid.hash, sha1);
-	fetch_refs(remote_name, ref);
-}
-
-void fetch_objects(const char *remote_name, const struct oid_array *to_fetch)
+void fetch_objects(const char *remote_name, const struct object_id *oids,
+		   int oid_nr)
 {
 	struct ref *ref = NULL;
 	int i;
 
-	for (i = 0; i < to_fetch->nr; i++) {
-		struct ref *new_ref = alloc_ref(oid_to_hex(&to_fetch->oid[i]));
-		oidcpy(&new_ref->old_oid, &to_fetch->oid[i]);
+	for (i = 0; i < oid_nr; i++) {
+		struct ref *new_ref = alloc_ref(oid_to_hex(&oids[i]));
+		oidcpy(&new_ref->old_oid, &oids[i]);
 		new_ref->next = ref;
 		ref = new_ref;
 	}
diff --git a/fetch-object.h b/fetch-object.h
index 4b269d07e..d2f996d4e 100644
--- a/fetch-object.h
+++ b/fetch-object.h
@@ -1,11 +1,7 @@
 #ifndef FETCH_OBJECT_H
 #define FETCH_OBJECT_H
 
-#include "sha1-array.h"
-
-extern void fetch_object(const char *remote_name, const unsigned char *sha1);
-
-extern void fetch_objects(const char *remote_name,
-			  const struct oid_array *to_fetch);
+void fetch_objects(const char *remote_name, const struct object_id *oids,
+		   int oid_nr);
 
 #endif
diff --git a/sha1-file.c b/sha1-file.c
index 97b742384..2edf4564f 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1317,7 +1317,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 			 * TODO Pass a repository struct through fetch_object,
 			 * such that arbitrary repositories work.
 			 */
-			fetch_object(repository_format_partial_clone, real->hash);
+			fetch_objects(repository_format_partial_clone, real, 1);
 			already_retried = 1;
 			continue;
 		}
diff --git a/unpack-trees.c b/unpack-trees.c
index f25089b87..82a83dbc6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -392,7 +392,7 @@ static int check_updates(struct unpack_trees_options *o)
 		}
 		if (to_fetch.nr)
 			fetch_objects(repository_format_partial_clone,
-				      &to_fetch);
+				      to_fetch.oid, to_fetch.nr);
 		fetch_if_missing = fetch_if_missing_store;
 		oid_array_clear(&to_fetch);
 	}
-- 
2.19.0.397.gdd90340f6a-goog

