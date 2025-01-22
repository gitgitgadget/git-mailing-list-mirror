Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999CE57D
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737532394; cv=none; b=Wa0inXZ57c7OAEYH2iHTE12D6eURCiCjQK9W50zJnvBbZufevp01Iyhsvj6+TYAlMoq7TSS6mJTuMfAWTvSWwixiubo2vm4Teul6bFbHshShqk2wZ9ztU84X4jHYTR+trY7h6m2ihyMRZ8h5ReRUVtbtrxL5AZYIEqIM0BJZ2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737532394; c=relaxed/simple;
	bh=RM9oxGvIddV6y0RTRNUr/6IFUdaZHAYwOD4WpppURKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W1qw5JR/zmw8pnGE8Sxfgt1Tvk2KShyb4nAh5xapTTwSI69IgASYlmHYUe5+JluwqbZKS3gXgiembs2uhYfWFy/1DNLIOFC9Y56aBUgXXKZ7iHwGFMu8M3l13CQlDyHaR8UCXEyfa6kLy9THnnsn6nIJworSiUJKKkw1VxSntDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFmri7vL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFmri7vL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21670dce0a7so136927935ad.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 23:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737532391; x=1738137191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKWIurZ/gr8rxXXZJw9UR1eZYaROcq+xytn8YmmF7ng=;
        b=NFmri7vLlPzAOema+Ut5oTM+T2ZIziWE7+Ug/MbrptdwNgbkqa6ruyfvbNN3tuvW3P
         pB0gjiGOOIvxRIVBKuNV6VwT6EQ/+peq7uAekoM4/UVcTDQa9s9vZH76/ih7M2EB20Cv
         w6NxoXSRmHsJT2VRqyFnZSCWlwW9IsakuQjrFoX0KRM9h+B0l47W3DXiDkVBzN96RxLa
         SauGvxVfFdLkYJ0JQLL/vDau4BjwdnqF9fMRFy+U1qqkwE7SRbpJebNDyKu0KgMsVy0G
         RRWjQLAmB1mNgu3Dhv9MLk78aD2aa6YqjykxPqIDD1UoHfwaWnuiKMTedhdY3ENTy69N
         cizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737532391; x=1738137191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKWIurZ/gr8rxXXZJw9UR1eZYaROcq+xytn8YmmF7ng=;
        b=VSpW1b6KRrTxq78tDZv8TfQMrbkI1kq5gLV4/TvDfW4W9PiAdIsH2iwHryvulvhJ+c
         jwQlv/9DpLBgVtg6yTQ7j3aXjt4REOM+ZAlbqDhv+/Xq9IJmFGl9uP3mIwh8AX3yG3dU
         wSguQrc2vADw/UxYW56XJ4mbUry1z2UH9/9pwhDe/OcZ9PLkQZqTIZdKulPoo+gmWCtY
         9HQrpywXikUVd8st4P4PniD2e6ZEJdsBaiSaUBkvwD+WDHMG3t8qw011iHZ1z9UeLn3s
         fP+wb1nQNO9lzwnOXpZHLWbbM+nO/uARQ98JTtISdnx31eaktlSsLEZT9X/koJFTCuGO
         +3DA==
X-Gm-Message-State: AOJu0YxD4qAlPF6okl9AsieOLBslVmcaumFPKqK3l0WWSU+ehfJFim2j
	6wLDAd8Cq77izCjz3cgnQi+ShPpZWij67b6812QdI7wT7wC5ZxLrycnmCm6R
X-Gm-Gg: ASbGncuMWoNA8arSnV4reLNeutYivvsX9sayPKbIdxAiLysEkrfyoS+q7QkM8+Npxkx
	MSx7VcZStK0nGx+4Xej5xcKV/lA1BEWpUu06AuP+SupzgR8yaP5cdfP0o0K9ByknZgjzxnqpLJr
	VgyvPJzyR1lOsSA+2ZhQAsInNM1hYTeGe/tO2TAoVHIk/RqDE/sCjENj0JcFIf2YEM7Tw6DMy0A
	I3McoOHULDjn8SfvxmN1+YjMN8nvxVbGPIyCoOCovrQm8vBAVgsxHXsJ00/BPc+7N1E
X-Google-Smtp-Source: AGHT+IEuQENaoE8yL/tBUGK1ncueNp8NyVLwESDqSxY3c5iuPXcY5JZV3z/rN0ke/zpr9SuQAuh50g==
X-Received: by 2002:a17:902:f54e:b0:215:72aa:693f with SMTP id d9443c01a7336-21c352de455mr265651085ad.9.1737532391076;
        Tue, 21 Jan 2025 23:53:11 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3acce3sm89284155ad.119.2025.01.21.23.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 23:53:10 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Nipunn Koorapati <nipunn@dropbox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 2/3] refspec: relocate query related functions
Date: Wed, 22 Jan 2025 13:21:53 +0530
Message-Id: <20250122075154.5697-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122075154.5697-1-meetsoni3017@gmail.com>
References: <20250122075154.5697-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the functions `query_refspecs()`, `query_refspecs_multiple()` and
`query_matches_negative_refspec()` from `remote.c` to `refspec.c`. These
functions focus on querying refspecs, so centralizing them in `refspec.c`
improves code organization by keeping refspec-related logic in one place.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refspec.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h |   7 ++++
 remote.c  | 122 -----------------------------------------------------
 remote.h  |   1 -
 4 files changed, 130 insertions(+), 123 deletions(-)

diff --git a/refspec.c b/refspec.c
index 66989a1d75..72b3911110 100644
--- a/refspec.c
+++ b/refspec.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
+#include "string-list.h"
 #include "strvec.h"
 #include "refs.h"
 #include "refspec.h"
@@ -324,3 +325,125 @@ int omit_name_by_refspec(const char *name, struct refspec *rs)
 	}
 	return 0;
 }
+
+static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
+{
+	int i, matched_negative = 0;
+	int find_src = !query->src;
+	struct string_list reversed = STRING_LIST_INIT_DUP;
+	const char *needle = find_src ? query->dst : query->src;
+
+	/*
+	 * Check whether the queried ref matches any negative refpsec. If so,
+	 * then we should ultimately treat this as not matching the query at
+	 * all.
+	 *
+	 * Note that negative refspecs always match the source, but the query
+	 * item uses the destination. To handle this, we apply pattern
+	 * refspecs in reverse to figure out if the query source matches any
+	 * of the negative refspecs.
+	 *
+	 * The first loop finds and expands all positive refspecs
+	 * matched by the queried ref.
+	 *
+	 * The second loop checks if any of the results of the first loop
+	 * match any negative refspec.
+	 */
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *refspec = &rs->items[i];
+		char *expn_name;
+
+		if (refspec->negative)
+			continue;
+
+		/* Note the reversal of src and dst */
+		if (refspec->pattern) {
+			const char *key = refspec->dst ? refspec->dst : refspec->src;
+			const char *value = refspec->src;
+
+			if (match_name_with_pattern(key, needle, value, &expn_name))
+				string_list_append_nodup(&reversed, expn_name);
+		} else if (refspec->matching) {
+			/* For the special matching refspec, any query should match */
+			string_list_append(&reversed, needle);
+		} else if (!refspec->src) {
+			BUG("refspec->src should not be null here");
+		} else if (!strcmp(needle, refspec->src)) {
+			string_list_append(&reversed, refspec->src);
+		}
+	}
+
+	for (i = 0; !matched_negative && i < reversed.nr; i++) {
+		if (omit_name_by_refspec(reversed.items[i].string, rs))
+			matched_negative = 1;
+	}
+
+	string_list_clear(&reversed, 0);
+
+	return matched_negative;
+}
+
+void query_refspecs_multiple(struct refspec *rs,
+				    struct refspec_item *query,
+				    struct string_list *results)
+{
+	int i;
+	int find_src = !query->src;
+
+	if (find_src && !query->dst)
+		BUG("query_refspecs_multiple: need either src or dst");
+
+	if (query_matches_negative_refspec(rs, query))
+		return;
+
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *refspec = &rs->items[i];
+		const char *key = find_src ? refspec->dst : refspec->src;
+		const char *value = find_src ? refspec->src : refspec->dst;
+		const char *needle = find_src ? query->dst : query->src;
+		char **result = find_src ? &query->src : &query->dst;
+
+		if (!refspec->dst || refspec->negative)
+			continue;
+		if (refspec->pattern) {
+			if (match_name_with_pattern(key, needle, value, result))
+				string_list_append_nodup(results, *result);
+		} else if (!strcmp(needle, key)) {
+			string_list_append(results, value);
+		}
+	}
+}
+
+int query_refspecs(struct refspec *rs, struct refspec_item *query)
+{
+	int i;
+	int find_src = !query->src;
+	const char *needle = find_src ? query->dst : query->src;
+	char **result = find_src ? &query->src : &query->dst;
+
+	if (find_src && !query->dst)
+		BUG("query_refspecs: need either src or dst");
+
+	if (query_matches_negative_refspec(rs, query))
+		return -1;
+
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *refspec = &rs->items[i];
+		const char *key = find_src ? refspec->dst : refspec->src;
+		const char *value = find_src ? refspec->src : refspec->dst;
+
+		if (!refspec->dst || refspec->negative)
+			continue;
+		if (refspec->pattern) {
+			if (match_name_with_pattern(key, needle, value, result)) {
+				query->force = refspec->force;
+				return 0;
+			}
+		} else if (!strcmp(needle, key)) {
+			*result = xstrdup(value);
+			query->force = refspec->force;
+			return 0;
+		}
+	}
+	return -1;
+}
diff --git a/refspec.h b/refspec.h
index 9556d08bd5..d3c97bfdc5 100644
--- a/refspec.h
+++ b/refspec.h
@@ -1,6 +1,8 @@
 #ifndef REFSPEC_H
 #define REFSPEC_H
 
+#include "string-list.h"
+
 #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
 
 /**
@@ -79,4 +81,9 @@ int omit_name_by_refspec(const char *name, struct refspec *rs);
 int match_name_with_pattern(const char *key, const char *name,
 				   const char *value, char **result);
 
+int query_refspecs(struct refspec *rs, struct refspec_item *query);
+void query_refspecs_multiple(struct refspec *rs,
+				    struct refspec_item *query,
+				    struct string_list *results);
+
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index 40c2418065..2c46611821 100644
--- a/remote.c
+++ b/remote.c
@@ -925,128 +925,6 @@ struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
 	return ref_map;
 }
 
-static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
-{
-	int i, matched_negative = 0;
-	int find_src = !query->src;
-	struct string_list reversed = STRING_LIST_INIT_DUP;
-	const char *needle = find_src ? query->dst : query->src;
-
-	/*
-	 * Check whether the queried ref matches any negative refpsec. If so,
-	 * then we should ultimately treat this as not matching the query at
-	 * all.
-	 *
-	 * Note that negative refspecs always match the source, but the query
-	 * item uses the destination. To handle this, we apply pattern
-	 * refspecs in reverse to figure out if the query source matches any
-	 * of the negative refspecs.
-	 *
-	 * The first loop finds and expands all positive refspecs
-	 * matched by the queried ref.
-	 *
-	 * The second loop checks if any of the results of the first loop
-	 * match any negative refspec.
-	 */
-	for (i = 0; i < rs->nr; i++) {
-		struct refspec_item *refspec = &rs->items[i];
-		char *expn_name;
-
-		if (refspec->negative)
-			continue;
-
-		/* Note the reversal of src and dst */
-		if (refspec->pattern) {
-			const char *key = refspec->dst ? refspec->dst : refspec->src;
-			const char *value = refspec->src;
-
-			if (match_name_with_pattern(key, needle, value, &expn_name))
-				string_list_append_nodup(&reversed, expn_name);
-		} else if (refspec->matching) {
-			/* For the special matching refspec, any query should match */
-			string_list_append(&reversed, needle);
-		} else if (!refspec->src) {
-			BUG("refspec->src should not be null here");
-		} else if (!strcmp(needle, refspec->src)) {
-			string_list_append(&reversed, refspec->src);
-		}
-	}
-
-	for (i = 0; !matched_negative && i < reversed.nr; i++) {
-		if (omit_name_by_refspec(reversed.items[i].string, rs))
-			matched_negative = 1;
-	}
-
-	string_list_clear(&reversed, 0);
-
-	return matched_negative;
-}
-
-static void query_refspecs_multiple(struct refspec *rs,
-				    struct refspec_item *query,
-				    struct string_list *results)
-{
-	int i;
-	int find_src = !query->src;
-
-	if (find_src && !query->dst)
-		BUG("query_refspecs_multiple: need either src or dst");
-
-	if (query_matches_negative_refspec(rs, query))
-		return;
-
-	for (i = 0; i < rs->nr; i++) {
-		struct refspec_item *refspec = &rs->items[i];
-		const char *key = find_src ? refspec->dst : refspec->src;
-		const char *value = find_src ? refspec->src : refspec->dst;
-		const char *needle = find_src ? query->dst : query->src;
-		char **result = find_src ? &query->src : &query->dst;
-
-		if (!refspec->dst || refspec->negative)
-			continue;
-		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result))
-				string_list_append_nodup(results, *result);
-		} else if (!strcmp(needle, key)) {
-			string_list_append(results, value);
-		}
-	}
-}
-
-int query_refspecs(struct refspec *rs, struct refspec_item *query)
-{
-	int i;
-	int find_src = !query->src;
-	const char *needle = find_src ? query->dst : query->src;
-	char **result = find_src ? &query->src : &query->dst;
-
-	if (find_src && !query->dst)
-		BUG("query_refspecs: need either src or dst");
-
-	if (query_matches_negative_refspec(rs, query))
-		return -1;
-
-	for (i = 0; i < rs->nr; i++) {
-		struct refspec_item *refspec = &rs->items[i];
-		const char *key = find_src ? refspec->dst : refspec->src;
-		const char *value = find_src ? refspec->src : refspec->dst;
-
-		if (!refspec->dst || refspec->negative)
-			continue;
-		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result)) {
-				query->force = refspec->force;
-				return 0;
-			}
-		} else if (!strcmp(needle, key)) {
-			*result = xstrdup(value);
-			query->force = refspec->force;
-			return 0;
-		}
-	}
-	return -1;
-}
-
 char *apply_refspecs(struct refspec *rs, const char *name)
 {
 	struct refspec_item query;
diff --git a/remote.h b/remote.h
index 0d109fa9c9..f3da64dc41 100644
--- a/remote.h
+++ b/remote.h
@@ -267,7 +267,6 @@ struct ref *ref_remove_duplicates(struct ref *ref_map);
  */
 struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
 
-int query_refspecs(struct refspec *rs, struct refspec_item *query);
 char *apply_refspecs(struct refspec *rs, const char *name);
 
 int check_push_refs(struct ref *src, struct refspec *rs);
-- 
2.34.1

