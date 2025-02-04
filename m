Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D716FF44
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 04:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641984; cv=none; b=cxNH3fwrH8F12noo0JfGhW1e+oQzNotln1ZwuLIzMy9Mdcwf/9t0/+0HR0GT3wmq0nF3ggPCQycI/isMAOvpadAahYwLjBL5WoLQC7hOLZ10WtaEOXR3LXs08gf90vrPmQkj25q360ci1P4BqHrULjqdlvKRsPa5TN2WspRpFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641984; c=relaxed/simple;
	bh=agnH6QuGvkQnX11XBvFQApbm+qS1yxqTvQRjSk7ZwQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9Cw/FJ2MOj1vTtvbBF1WigsiA/Alza5Km7zI9Dsnrvn0DbYzxzY3dFcFuppjgP9YIT0QjxkS5aDzfC8SW9beZB11jC7wgFdJ2M+x8QXyEkk0SV3pJZlWh33Xup94WFbNbDT4MdVqWHqbltNjciDxER6SoMPe7J/1Lx7SoyGoS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3hkTp+6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3hkTp+6"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f441791e40so6570319a91.3
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 20:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738641981; x=1739246781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=944Czf3HLevK8LFL7a16D1dQvg24llj7qF62WNejlzU=;
        b=E3hkTp+6xHffXIRgjUbHY/ka2oFiX4g+Pltg317W3x2aySrCQpvkU/be5xPEp2nW9o
         IJQsXerqkFaDcZVQ7irjy7S4fv1n/Ds2fyBEDSSYuO7SxqQJmNj2bZE2njTlQjvBI32a
         aImJVESTZGmep7wDbf15ZueBuxBattKwpcrggQvWML2XtiiRbzYn4U1aKxgLi4J0EQQE
         QGMLb7tGiytcrERDQC7zOGKNBAYn4BAqfmil36CbEUV6WypO+HzoLCKS+y20K3+IHxT4
         VEXv0gOi9Xr/MnP7xfPmUsin59dvfIw5G6pcUK0P47q21wmX3WOdcaTD4FQs0FBt1ug1
         SRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738641981; x=1739246781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=944Czf3HLevK8LFL7a16D1dQvg24llj7qF62WNejlzU=;
        b=MjPIK6DsIFyM1HTo/9RImQ8c+V2uLDm4HEJum08KOkPprkTI/siLvQfZ/J+LJVeePN
         fXJ8OGhXUuaE0lK5HrOTR8ntNPONoNjvKQKmD/o38apxwELDwTbWCESN2Gj2RVGcKdSi
         QnJHpRN6CXwf/b0SaPMxeofHMozYe7i2y4PPAIchnggk+E7DOfCs3NkshSIYNtNDPvko
         7HPdt8a6NuopG1uaz/pOZVny0BG9Q8jWa4IAvZhCVoRJwAPZlVgXRMU/j6mOWM+Tbbh6
         oVeeFTbUsEG/8YYYjxmdSKUtoFlBYO+Trqj+XaAAKZC8mrWfFjKMxOSXNKVmrDQOnmO6
         VhDg==
X-Gm-Message-State: AOJu0YwbfFILsjvuz6qBI3DV/dJ+nJMSSGltg4OXHSuHJ/SLEs2EnaaE
	LXKK8PQEHmPd9RNHdiQniEPhFwm7/QYWteVBGET0ylDMl9MB3b4JDloioA==
X-Gm-Gg: ASbGncv50Rb3gO3G6SmlXHTtCnnSSMos7T0XPsGeC2NzkO4v8Tj5iEZIhQEWZH6LMmL
	qGwT8I4UGPmdXACrJUkSHKVuHFhz2koIdhk8fiavGHajaCxMV3+3jmEZcInqsnhQwkYZUaXXfM2
	nGfIDW3lICUF3fUBOyyakqXksWQNmKN9gKpjqYjOCxMVWKxYoPUKRYBb6bDcHh0mAlClkB6BfVB
	nmnDTRNoykztXBGQmvYM9+yI8ofgQmFcldkeSCqJ76Mo5Aa0qxkmqsW5PIeAsvqUnhOuRWcqt5M
	4QUJruExXpamXA==
X-Google-Smtp-Source: AGHT+IE8DojESGMY8Afss8FcDz/6rs3edWeaAVOLYCoTWuFfrgLIc2jmsJFz+TC3BjxtouQmT5Kv6g==
X-Received: by 2002:a17:90a:dfc7:b0:2ee:c6c8:d89f with SMTP id 98e67ed59e1d1-2f83abf3750mr40687663a91.14.1738641980797;
        Mon, 03 Feb 2025 20:06:20 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bd09cb1sm12272583a91.21.2025.02.03.20.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:06:20 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nipunn Koorapati <nipunn@dropbox.com>
Subject: [GSoC][PATCH v4 4/5] refspec: relocate matching related functions
Date: Tue,  4 Feb 2025 09:35:57 +0530
Message-Id: <20250204040558.34766-5-meetsoni3017@gmail.com>
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

Move the functions `refspec_find_match()`, `refspec_find_all_matches()`
and `refspec_find_negative_match()` from `remote.c` to `refspec.c`.
These functions focus on matching refspecs, so centralizing them in
`refspec.c` improves code organization by keeping refspec-related logic
in one place.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refspec.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h |  16 +++++++
 remote.c  | 122 -----------------------------------------------------
 3 files changed, 139 insertions(+), 122 deletions(-)

diff --git a/refspec.c b/refspec.c
index b447768304..cab0b0d127 100644
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
@@ -324,3 +325,125 @@ int refname_matches_negative_refspec_item(const char *refname, struct refspec *r
 	}
 	return 0;
 }
+
+static int refspec_find_negative_match(struct refspec *rs, struct refspec_item *query)
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
+		if (refname_matches_negative_refspec_item(reversed.items[i].string, rs))
+			matched_negative = 1;
+	}
+
+	string_list_clear(&reversed, 0);
+
+	return matched_negative;
+}
+
+void refspec_find_all_matches(struct refspec *rs,
+				    struct refspec_item *query,
+				    struct string_list *results)
+{
+	int i;
+	int find_src = !query->src;
+
+	if (find_src && !query->dst)
+		BUG("refspec_find_all_matches: need either src or dst");
+
+	if (refspec_find_negative_match(rs, query))
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
+int refspec_find_match(struct refspec *rs, struct refspec_item *query)
+{
+	int i;
+	int find_src = !query->src;
+	const char *needle = find_src ? query->dst : query->src;
+	char **result = find_src ? &query->src : &query->dst;
+
+	if (find_src && !query->dst)
+		BUG("refspec_find_match: need either src or dst");
+
+	if (refspec_find_negative_match(rs, query))
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
index 584d9c9eb5..be20ba53ab 100644
--- a/refspec.h
+++ b/refspec.h
@@ -30,6 +30,8 @@ struct refspec_item {
 	char *raw;
 };
 
+struct string_list;
+
 #define REFSPEC_FETCH 1
 #define REFSPEC_PUSH 0
 
@@ -80,4 +82,18 @@ int refname_matches_negative_refspec_item(const char *refname, struct refspec *r
 int match_name_with_pattern(const char *key, const char *name,
 				   const char *value, char **result);
 
+/*
+ * Queries a refspec for a match and updates the query item.
+ * Returns 0 on success, -1 if no match is found or negative refspec matches.
+ */
+int refspec_find_match(struct refspec *rs, struct refspec_item *query);
+
+/*
+ * Queries a refspec for all matches and appends results to the provided string
+ * list.
+ */
+void refspec_find_all_matches(struct refspec *rs,
+				    struct refspec_item *query,
+				    struct string_list *results);
+
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index b510809a56..4c5940482f 100644
--- a/remote.c
+++ b/remote.c
@@ -925,128 +925,6 @@ struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
 	return ref_map;
 }
 
-static int refspec_find_negative_match(struct refspec *rs, struct refspec_item *query)
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
-		if (refname_matches_negative_refspec_item(reversed.items[i].string, rs))
-			matched_negative = 1;
-	}
-
-	string_list_clear(&reversed, 0);
-
-	return matched_negative;
-}
-
-static void refspec_find_all_matches(struct refspec *rs,
-				    struct refspec_item *query,
-				    struct string_list *results)
-{
-	int i;
-	int find_src = !query->src;
-
-	if (find_src && !query->dst)
-		BUG("refspec_find_all_matches: need either src or dst");
-
-	if (refspec_find_negative_match(rs, query))
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
-int refspec_find_match(struct refspec *rs, struct refspec_item *query)
-{
-	int i;
-	int find_src = !query->src;
-	const char *needle = find_src ? query->dst : query->src;
-	char **result = find_src ? &query->src : &query->dst;
-
-	if (find_src && !query->dst)
-		BUG("refspec_find_match: need either src or dst");
-
-	if (refspec_find_negative_match(rs, query))
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
-- 
2.34.1

