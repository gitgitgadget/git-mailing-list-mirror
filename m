Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9041FECAE
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974226; cv=none; b=UpgrPWjrqtNe4XcBYAhlJ0yFQxGfTySGLYwMcByKZPmFFmEPkPzvyN+Qu/zEI2yZTcUOlFGyds10A7eKFXh4oERKUOzmns010K9jUsbtG+QeHmFSPpvmBU9ng0svyRK60dMXPU9NGWlEgrXk9ope0pCnNnpvjzlpPi2vQv2NOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974226; c=relaxed/simple;
	bh=3WHQ7aF3NMX92kDrju9ub5FvlnUWo5ArMmF7qgbYUy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KlzvsNFB+jaVeUlklSUSQ16101kepa+FAVn5HJNF27wMAYFcdCYHNYQAvCvw6fm73ry+ABwd2LKlsBC9dU2aCVntA7j7ztWkZnJAjh2Si1MmnQo9HzhEZ5ra5bOKw63f9gHjLWKcb3Q7bBNljuWQJh2rLdwSrgt+wgayOa7a8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGqOhoI3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGqOhoI3"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso6378943a91.1
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 02:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737974224; x=1738579024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JLfxKVJowgWQZQ4bSKvbvFklzzDkrfm+J0x0+3JsqY=;
        b=SGqOhoI3vRN5k1++lCJb4V2PN39NzN106fvMSc6JJ2wrx3XQaGLFU+TyZu/D74jbxf
         62/qpehBu7T9pXAPJUyE5I4TJYN/MDfVgof3+3DNdwbaNUHcgt0ij+xJO3GznC079djJ
         vev4jd8s5oS5Mm3Zzs7o5uNNGscPc7d6SmJRGiFCWKPVhd5rLMZzBiGePQ3XIBYZON6v
         6AJZAgqsVjKmrgjhy21V1NBHNAcBCbT6C50QbsBpagA0HyBuTbT1u0LnWg/+9wfUR+iZ
         dYtHc1xyBW8PEifX2vj4xU0sPNXZ+UjyKHYO0jDRGFHTD0BPevTw6aMoZDr33S6/yVvJ
         4ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737974224; x=1738579024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JLfxKVJowgWQZQ4bSKvbvFklzzDkrfm+J0x0+3JsqY=;
        b=gJKHhxQNJkIL5MtDi4wSMCVwvKPBwtKH+W8E9b5YiWVkP4gYJWn+mvE9vwmhf8DPfy
         RGGFni0i4guAz3diJbgNJtlWjbAwZYzbrhSXyatJCgBVtLvNJb7raJHIGuVmi7xd1yEP
         PaRsA/2Gy9I11ZlPTprAmTVPkWy5CBI+mc+faklsFaFUyP5iC8TBNiUSWhzYEsaGUKho
         IXqkKqXCjAJnfUvMDgfxNpTXM4eF0car2nM59Km42MU0KV5sRW7+eNH4oQ+E4R322ruJ
         5fTuVrzONj8BjJ1B2R7o5Hg+2o5waYmJN5TH5+Ez/n0jvjW7TBc2enM1Bq8+zLMML50V
         g+/Q==
X-Gm-Message-State: AOJu0YzgTEPh/GRnfK1gtDXvjZlP2WRyp2naAMlbmiSFLhivIG/XQjUH
	EUXdUh1oMuXMAz0lvVCwc/NEMhX23Dky13KzM3ghJP2c9Dl0GuJJlug+Eg+Cv80=
X-Gm-Gg: ASbGncvLiMYQIqwTImcvGKbz4Hb/tbTLovXeSfuAgO25TDCL1EqBwwnBBTSYbhkJHl8
	Gzzv1t3REieeiZOOGAL+dSw0fUrzHkO7UqpERuiuZ1o9rjoUc2pCS09LhnlPCVGs6/ute+oTBzW
	scLaV29sXxcpy9/c69Ok3PRTWyYlEbmToJk7+Qhx88EUcIOU1zcw5M5kX6AGA9kFG2HOlojBPXN
	9rz/dUv4SW0epnD0sHM9sGN6lvJuN/sJc5luz0gQogL8FM4shBipfGFB6w5VSVdKv80tRgDefax
	2bc=
X-Google-Smtp-Source: AGHT+IGMO7TpmfjKY+qrHOK3oPunwbH2AQusg0u0VqX4eQE5VRzkGKJv/8Tm30J5CfekrokfwoCUwQ==
X-Received: by 2002:a17:90b:2747:b0:2ef:7be8:e987 with SMTP id 98e67ed59e1d1-2f7ff3581a8mr18885372a91.12.1737974223985;
        Mon, 27 Jan 2025 02:37:03 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa454f5sm6879439a91.1.2025.01.27.02.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:37:03 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Matthew Rogers <mattr94@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] refspec: relocate apply_refspecs and related funtions
Date: Mon, 27 Jan 2025 16:06:44 +0530
Message-Id: <20250127103644.36627-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127103644.36627-1-meetsoni3017@gmail.com>
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the functions `apply_refspecs()` and `apply_negative_refspecs()`
from `remote.c` to `refspec.c`. These functions focus on applying
refspecs, so centralizing them in `refspec.c` improves code organization
by keeping refspec-related logic in one place.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refspec.c | 32 ++++++++++++++++++++++++++++++++
 refspec.h | 12 ++++++++++++
 remote.c  | 31 -------------------------------
 remote.h  |  8 --------
 4 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/refspec.c b/refspec.c
index 72b3911110..d279d6032a 100644
--- a/refspec.c
+++ b/refspec.c
@@ -9,6 +9,7 @@
 #include "strvec.h"
 #include "refs.h"
 #include "refspec.h"
+#include "remote.h"
 #include "strbuf.h"
 
 /*
@@ -447,3 +448,34 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	}
 	return -1;
 }
+
+struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
+{
+	struct ref **tail;
+
+	for (tail = &ref_map; *tail; ) {
+		struct ref *ref = *tail;
+
+		if (omit_name_by_refspec(ref->name, rs)) {
+			*tail = ref->next;
+			free(ref->peer_ref);
+			free(ref);
+		} else
+			tail = &ref->next;
+	}
+
+	return ref_map;
+}
+
+char *apply_refspecs(struct refspec *rs, const char *name)
+{
+	struct refspec_item query;
+
+	memset(&query, 0, sizeof(struct refspec_item));
+	query.src = (char *)name;
+
+	if (query_refspecs(rs, &query))
+		return NULL;
+
+	return query.dst;
+}
diff --git a/refspec.h b/refspec.h
index d0788de782..231bcfb33e 100644
--- a/refspec.h
+++ b/refspec.h
@@ -100,4 +100,16 @@ void query_refspecs_multiple(struct refspec *rs,
 				    struct refspec_item *query,
 				    struct string_list *results);
 
+/*
+ * Remove all entries in the input list which match any negative refspec in
+ * the refspec list.
+ */
+struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
+
+/*
+ * Applies refspecs to a name and returns the corresponding destination.
+ * Returns the destination string if a match is found, NULL otherwise.
+ */
+char *apply_refspecs(struct refspec *rs, const char *name);
+
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index 2c46611821..641dd1125f 100644
--- a/remote.c
+++ b/remote.c
@@ -907,37 +907,6 @@ void ref_push_report_free(struct ref_push_report *report)
 	}
 }
 
-struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
-{
-	struct ref **tail;
-
-	for (tail = &ref_map; *tail; ) {
-		struct ref *ref = *tail;
-
-		if (omit_name_by_refspec(ref->name, rs)) {
-			*tail = ref->next;
-			free(ref->peer_ref);
-			free(ref);
-		} else
-			tail = &ref->next;
-	}
-
-	return ref_map;
-}
-
-char *apply_refspecs(struct refspec *rs, const char *name)
-{
-	struct refspec_item query;
-
-	memset(&query, 0, sizeof(struct refspec_item));
-	query.src = (char *)name;
-
-	if (query_refspecs(rs, &query))
-		return NULL;
-
-	return query.dst;
-}
-
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
 	return query_refspecs(&remote->fetch, refspec);
diff --git a/remote.h b/remote.h
index f3da64dc41..b4bb16af0e 100644
--- a/remote.h
+++ b/remote.h
@@ -261,14 +261,6 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
-/*
- * Remove all entries in the input list which match any negative refspec in
- * the refspec list.
- */
-struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
-
-char *apply_refspecs(struct refspec *rs, const char *name);
-
 int check_push_refs(struct ref *src, struct refspec *rs);
 int match_push_refs(struct ref *src, struct ref **dst,
 		    struct refspec *rs, int flags);
-- 
2.34.1

