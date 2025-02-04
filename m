Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4EC15B0EF
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641990; cv=none; b=sO5hXBqhjl1orHfhDGaHRERYsVcBo3H+HVckjUEI6P4lRz0nPX+wgsOPmuJUfkg0omgqyl3A5bdd9kYZAwYyYdgfjjvqG8LDPHQaHCcnDvS67NEjnF577hf14hQx/aFqnAQNwMD2GfaulBzJ7gl+3TNq2nD4jmISsFn6DVYLXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641990; c=relaxed/simple;
	bh=hp0Y+c1DTxKSnGvyDMZhas88cHvhfU313nlyVpEayic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Akri91SAki1V3MR4ixqUr4QyvaV/O+aabFlz9yUjAQV6Asg5DDhcZuTkp4GQBN7OwYjRtc70J97u4oI4CYRzi8XfVhf17rBDOeR/LcaE7gBr9gpWSQ3Pw5dPCJG7iAce3CwliNxbr6tZWfQPyF1vh7FXFXvsYkdhqxWVjGlxBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D32Cid/u; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D32Cid/u"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so6946458a91.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 20:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738641987; x=1739246787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uz/Lkw/pPvD6GgKWN7JRL6zgGJcri82lQpkMJTV+Foc=;
        b=D32Cid/uXHa5RDh9Tzay9SuYpUkjryLSN/Ia+5lyGBBmUD+Is+mpNKWk7bmQ26otSk
         3qeGAed1Cfm9iIaR5plP+RdIG+Kh56fJWvunYEt7Vk+DsuAdNE4/utfOPxKf81kXCQcR
         MoKoLIb+YlakzilzAaojVP+24b+yJoe1ion+kfYqQgup60bt7eu2yRjqCBRiE1uhOGcu
         1FUkfdcsYXLO3f6oI5scXSNTopKpMPL6PyjVTVyKfGZtfse3UtBnt5+b75qyBsNmqgen
         /2Z2XaMyW8na2k43skqfh2uuLGSGeVL935a3Eox9XYc1dgbW1v8BFR397P6ivkYq8wc6
         nKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738641987; x=1739246787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uz/Lkw/pPvD6GgKWN7JRL6zgGJcri82lQpkMJTV+Foc=;
        b=eQ5IPI8rKuNUVokXTSp7AAmvoU4i9Qh+O8ndY3p6LO0xF6lM75Wkpw8uZsY4AoEqLF
         uUzi+p4dMCnqq5Dia0pKKIdp7vKMLCgz1Q29xZ6CsJYXqHOYSLBphwv+MtrRgL5gWF06
         xJ2VW74YNNhBwmiwJEJbeEBwAAKPZGX6TnBJrZwlS8w7gGgPuknoNWXLCeyP2vsskxQr
         X5eNIkvCNjT+xDXHlNQH01ZmdYWQshEtsA5cJCSI9dEpIATJugKi6x6vY2G+Mp5lv/ea
         tOB3W0NWsYxnmdEeyPkpPE84jYqL9P8Sz0KilKR+FzZqV1ywoJaQfdGyUi9OOpRp74wY
         5Bnw==
X-Gm-Message-State: AOJu0Yw8I2xkXXJUBhlap/YZcby+xXG2kN46yhfqk+ABVPt4jc/EtXWO
	wTEo+Pe3a4oyifup2dTOuozVHyI8x8SxPjrJ5SxSSzOaEfF71W4noGCTNg==
X-Gm-Gg: ASbGncuHSyeThY/SoWCbxp1Reb9FGMlGjmJxuFmHuvdndsXbO+TjmlMQEmYd3UkOPc7
	UU8VXSg9feH3v7EUzEoieKqa5Ydjd7LJAArZzgDFtvw0Td2bZOXDPC6nY5R8pn3RFj3io37KqGD
	PyhMkyQ33K1CLESY5utjlcvEacTVsVivFHOqVUnbot6uvKPK7s7FY0D+EaonhHiTyPU0sXCVbv8
	ikMLkSefqTBDkCH6g9ZMiae+U/yKQl5ydbr3DtRv+WxADtbKFO1hPTpf1izGr7aHbXX/kXxZY5E
	qIqwr0Wkf890Zg==
X-Google-Smtp-Source: AGHT+IEUCC6m+mNCkcsfMnsBOWJDj2GuSTN8Tg5b/zDr1bXqFZAzcnG29pZyKQzr7+rElVd2Rko3qw==
X-Received: by 2002:a17:90b:548e:b0:2f4:4500:bb4d with SMTP id 98e67ed59e1d1-2f83ac0a3d9mr35238959a91.20.1738641986811;
        Mon, 03 Feb 2025 20:06:26 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bd09cb1sm12272583a91.21.2025.02.03.20.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:06:25 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Pavel Rappo <pavel.rappo@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Elijah Newren <newren@gmail.com>,
	Matthew Rogers <mattr94@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [GSoC][PATCH v4 5/5] refspec: relocate apply_refspecs and related funtions
Date: Tue,  4 Feb 2025 09:35:58 +0530
Message-Id: <20250204040558.34766-6-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204040558.34766-1-meetsoni3017@gmail.com>
References: <20250201064202.76116-1-meetsoni3017@gmail.com>
 <20250204040558.34766-1-meetsoni3017@gmail.com>
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
 remote.h  | 11 -----------
 4 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/refspec.c b/refspec.c
index cab0b0d127..0dbbd1e799 100644
--- a/refspec.c
+++ b/refspec.c
@@ -9,6 +9,7 @@
 #include "strvec.h"
 #include "refs.h"
 #include "refspec.h"
+#include "remote.h"
 #include "strbuf.h"
 
 /*
@@ -447,3 +448,34 @@ int refspec_find_match(struct refspec *rs, struct refspec_item *query)
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
+		if (refname_matches_negative_refspec_item(ref->name, rs)) {
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
+	if (refspec_find_match(rs, &query))
+		return NULL;
+
+	return query.dst;
+}
diff --git a/refspec.h b/refspec.h
index be20ba53ab..2a28d043be 100644
--- a/refspec.h
+++ b/refspec.h
@@ -96,4 +96,16 @@ void refspec_find_all_matches(struct refspec *rs,
 				    struct refspec_item *query,
 				    struct string_list *results);
 
+/*
+ * Remove all entries in the input list which match any negative refspec in
+ * the refspec list.
+ */
+struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
+
+/*
+ * Search for a refspec that matches the given name and return the
+ * corresponding destination (dst) if a match is found, NULL otherwise.
+ */
+char *apply_refspecs(struct refspec *rs, const char *name);
+
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index 4c5940482f..7f27c59a5b 100644
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
-		if (refname_matches_negative_refspec_item(ref->name, rs)) {
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
-	if (refspec_find_match(rs, &query))
-		return NULL;
-
-	return query.dst;
-}
-
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
 	return refspec_find_match(&remote->fetch, refspec);
diff --git a/remote.h b/remote.h
index 516ba7f398..b4bb16af0e 100644
--- a/remote.h
+++ b/remote.h
@@ -261,17 +261,6 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
-int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs);
-
-/*
- * Remove all entries in the input list which match any negative refspec in
- * the refspec list.
- */
-struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
-
-int refspec_find_match(struct refspec *rs, struct refspec_item *query);
-char *apply_refspecs(struct refspec *rs, const char *name);
-
 int check_push_refs(struct ref *src, struct refspec *rs);
 int match_push_refs(struct ref *src, struct ref **dst,
 		    struct refspec *rs, int flags);
-- 
2.34.1

