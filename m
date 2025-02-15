Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C6C2ED
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739609149; cv=none; b=D2y4WpJ4OelN8X9MroA0L4s6sRyYcAD/7Rdu7dv9D3RPVQlyI5FQ/YL6TwRkgA66ILWZJMXQ1prmw/AOYcZ9EwNW0k/xr+C0dED2ha4uCcMthbBeh64lbMx0Z67JdVezDM+ecuxU+cQL9OebTZDovToQfkq5xGHu7MxDrb5XMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739609149; c=relaxed/simple;
	bh=ETg1pFv0TYLm60mkmQ84X3s3BvRcFWzqXq/HxGqCk1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XL080LUOl2bYwQJm5T57lxPjk8YnKM4jDvRysHxgBoHRghZw95Vo+tg6A8CSLctOH5nwE0FxiKs1jBq1pFVWnbao+T3NMntx5/jFu5h0Sbr27cQSvIunppSi52JjipT49LxH3ShceXWKhr9JhntjgLWIoF9kztz7DfjjEWcqxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoOU3p42; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoOU3p42"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d28c215eso39955475ad.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 00:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739609146; x=1740213946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nyoh7yrmlZtxmzZzyxRmkSvcIOuvH6c7qh9ipn8MvPk=;
        b=HoOU3p42x1Edzt96tbHj7F3vwoUTcPK7hLHfm1m8pQwBHlkDx3BCszvlajvAA4Y2/8
         v/KyRdmP8MWolXEMty6pC70Eb1hKyO8fWDYgPyFHXUWCLnskF40WoFZ+GyW5MbbyYgVI
         Ju/lthH0YAVTiQu3KjI+aqsrBmKzcWrF+Gi9My6YcJfvjHcHwNx7dwdGzAYs3KHIw6CN
         mH1F3WTURCWhlS56SnKR348ghbE+I9lRxwQBvB0Y8Wf/q4YpkwF1JcYQGhdExxkq6LP+
         8uYTnVKWotf6tM5NzZFgHUqNnTcfxxcvTdwysO9T2MHDOP0awP7rrvu3nVRKqqfEqgdv
         h6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739609146; x=1740213946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nyoh7yrmlZtxmzZzyxRmkSvcIOuvH6c7qh9ipn8MvPk=;
        b=qffPA94tQqMD96M7Rzi5i+vMMYVt+Ty+W38FOYQHN6+Y0pt/2PCmY8OmzH4hiKts7t
         5dxJn1eSj9RM+macX1j5Rblr5/WBf2CkxwsMSKQshmL8BVp2y//DuNqd6XZydIGk/KU8
         jUK5ZM40w0eD3tkMhqsKfhlgwIUecJ+4Y8Fgn9l5YMy2dv8hNpGooJDbujXJUaiH4EBs
         wczUHnXTfcfZsB2nmQix+aaraREH6hAtFGJZspTlbBsGCD2B3KR7Ei2Jj4WQvqrcBlLX
         YqmO5tlC2+5swRXtllr85xUgolS5SFY9/PAIrbyzGsrmV666FnsGLHj03B6N8SwWizxU
         aUvg==
X-Gm-Message-State: AOJu0YwOiqDiIjtssSTR7Ep5M5MBGE73sJC49pcRCXsywhWsvrmN+RTf
	q9jQe12jAR5Fvq7h1lmKumP1vZwCYEV7H5owwj9wL7sooDJEOhJSvjWcPyWM
X-Gm-Gg: ASbGncs8i5sybePyxsokFzoeVBHDeHR+tZNaARtGi7oLnKvwLBCL2qb6gcCoiZMZmKq
	OGcbj2D56KIVda6j3gC7xvDZUFOvHNVY5guW1KdAN0hGMvLrOr9F2EzPLKUcznCtM1iYZy856yN
	jqWWvEDn5Wbe2mFOWfqRWqeK6/Tt5XxKyq21AU7sUSiq8HsxrHgJF248u6AwMfKAAx1cMCDnWQi
	tD45EC7onOUbdTVbf4FbQcKyWwg0rdOtT+xV90hPbx98KEbyBLd7DeELgKOIW1vPiYvphnTpKMI
	9uMN32ufysuefQ==
X-Google-Smtp-Source: AGHT+IGdRK/Ye7uL190fdRD00FmrxIGoymvW6SbjWtgr22bWax1t8KhVX8GtbKBS5WIYfAaFU2r/jg==
X-Received: by 2002:a17:903:1cc:b0:215:a04a:89d5 with SMTP id d9443c01a7336-22104013698mr38183885ad.2.1739609145964;
        Sat, 15 Feb 2025 00:45:45 -0800 (PST)
Received: from meet.. ([103.240.170.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55963c0sm39497065ad.251.2025.02.15.00.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 00:45:45 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2] refspec: clarify function naming and documentation
Date: Sat, 15 Feb 2025 14:15:39 +0530
Message-Id: <20250215084539.73799-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214053938.26807-1-meetsoni3017@gmail.com>
References: <20250214053938.26807-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename `match_name_with_pattern()` to `match_refname_with_pattern()` to
better reflect its purpose and improve documentation comment clarity.
The previous function name and parameter names were inconsistent, making
it harder to understand their roles in refspec matching.

- Rename parameters:
  - `key` -> `pattern` (globbing pattern to match)
  - `name` -> `refname` (refname to check)
  - `value` -> `replacement` (replacement mapping pattern)

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
changes in v2:
    - updated parameter names as per review. Namely:
        - `src_pattern` -> `pattern`
        - `dst_pattern` -> `replacement`
    - updated comment and commit message.

Range-diff against v1:
1:  8bd849b7c2 ! 1:  aa47431720 refspec: clarify function naming and documentation
    @@ Commit message
         it harder to understand their roles in refspec matching.
     
         - Rename parameters:
    -      - `key` -> `src_pattern` (source globbing pattern)
    +      - `key` -> `pattern` (globbing pattern to match)
           - `name` -> `refname` (refname to check)
    -      - `value` -> `dst_pattern` (destination mapping pattern)
    +      - `value` -> `replacement` (replacement mapping pattern)
     
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     
    @@ refspec.c: void refspec_ref_prefixes(const struct refspec *rs,
      
     -int match_name_with_pattern(const char *key, const char *name,
     -				   const char *value, char **result)
    -+int match_refname_with_pattern(const char *src_pattern, const char *refname,
    -+				   const char *dst_pattern, char **result)
    ++int match_refname_with_pattern(const char *pattern, const char *refname,
    ++				   const char *replacement, char **result)
      {
     -	const char *kstar = strchr(key, '*');
    -+	const char *kstar = strchr(src_pattern, '*');
    ++	const char *kstar = strchr(pattern, '*');
      	size_t klen;
      	size_t ksuffixlen;
      	size_t namelen;
    @@ refspec.c: void refspec_ref_prefixes(const struct refspec *rs,
      	if (!kstar)
     -		die(_("key '%s' of pattern had no '*'"), key);
     -	klen = kstar - key;
    -+		die(_("source pattern '%s' has no '*'"), src_pattern);
    -+	klen = kstar - src_pattern;
    ++		die(_("pattern '%s' has no '*'"), pattern);
    ++	klen = kstar - pattern;
      	ksuffixlen = strlen(kstar + 1);
     -	namelen = strlen(name);
     -	ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
     -		!memcmp(name + namelen - ksuffixlen, kstar + 1, ksuffixlen);
     -	if (ret && value) {
     +	namelen = strlen(refname);
    -+	ret = !strncmp(refname, src_pattern, klen) && namelen >= klen + ksuffixlen &&
    ++	ret = !strncmp(refname, pattern, klen) && namelen >= klen + ksuffixlen &&
     +		!memcmp(refname + namelen - ksuffixlen, kstar + 1, ksuffixlen);
    -+	if (ret && dst_pattern) {
    ++	if (ret && replacement) {
      		struct strbuf sb = STRBUF_INIT;
     -		const char *vstar = strchr(value, '*');
    -+		const char *vstar = strchr(dst_pattern, '*');
    ++		const char *vstar = strchr(replacement, '*');
      		if (!vstar)
     -			die(_("value '%s' of pattern has no '*'"), value);
     -		strbuf_add(&sb, value, vstar - value);
     -		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
    -+			die(_("destination pattern '%s' has no '*'"), dst_pattern);
    -+		strbuf_add(&sb, dst_pattern, vstar - dst_pattern);
    ++			die(_("replacement '%s' has no '*'"), replacement);
    ++		strbuf_add(&sb, replacement, vstar - replacement);
     +		strbuf_add(&sb, refname + klen, namelen - klen - ksuffixlen);
      		strbuf_addstr(&sb, vstar + 1);
      		*result = strbuf_detach(&sb, NULL);
    @@ refspec.h: void refspec_ref_prefixes(const struct refspec *rs,
     - * Checks whether a name matches a pattern and optionally generates a result.
     - * Returns 1 if the name matches the pattern, 0 otherwise.
     + * Checks if a refname matches a globbing refspec pattern.
    -+ * If dst_pattern is provided, computes the mapped destination refname.
    -+ * Returns 1 if refname matches src_pattern, 0 otherwise.
    ++ * If replacement is provided, computes the corresponding mapped refname.
    ++ * Returns 1 if refname matches pattern, 0 otherwise.
       */
     -int match_name_with_pattern(const char *key, const char *name,
     -				   const char *value, char **result);
    -+int match_refname_with_pattern(const char *src_pattern, const char *refname,
    -+				   const char *dst_pattern, char **result);
    ++int match_refname_with_pattern(const char *pattern, const char *refname,
    ++				   const char *replacement, char **result);
      
      /*
       * Queries a refspec for a match and updates the query item.

 refspec.c | 34 +++++++++++++++++-----------------
 refspec.h |  9 +++++----
 remote.c  |  6 +++---
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/refspec.c b/refspec.c
index 3d6cf4dc92..4cb80b5208 100644
--- a/refspec.c
+++ b/refspec.c
@@ -269,28 +269,28 @@ void refspec_ref_prefixes(const struct refspec *rs,
 	}
 }
 
-int match_name_with_pattern(const char *key, const char *name,
-				   const char *value, char **result)
+int match_refname_with_pattern(const char *pattern, const char *refname,
+				   const char *replacement, char **result)
 {
-	const char *kstar = strchr(key, '*');
+	const char *kstar = strchr(pattern, '*');
 	size_t klen;
 	size_t ksuffixlen;
 	size_t namelen;
 	int ret;
 	if (!kstar)
-		die(_("key '%s' of pattern had no '*'"), key);
-	klen = kstar - key;
+		die(_("pattern '%s' has no '*'"), pattern);
+	klen = kstar - pattern;
 	ksuffixlen = strlen(kstar + 1);
-	namelen = strlen(name);
-	ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
-		!memcmp(name + namelen - ksuffixlen, kstar + 1, ksuffixlen);
-	if (ret && value) {
+	namelen = strlen(refname);
+	ret = !strncmp(refname, pattern, klen) && namelen >= klen + ksuffixlen &&
+		!memcmp(refname + namelen - ksuffixlen, kstar + 1, ksuffixlen);
+	if (ret && replacement) {
 		struct strbuf sb = STRBUF_INIT;
-		const char *vstar = strchr(value, '*');
+		const char *vstar = strchr(replacement, '*');
 		if (!vstar)
-			die(_("value '%s' of pattern has no '*'"), value);
-		strbuf_add(&sb, value, vstar - value);
-		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
+			die(_("replacement '%s' has no '*'"), replacement);
+		strbuf_add(&sb, replacement, vstar - replacement);
+		strbuf_add(&sb, refname + klen, namelen - klen - ksuffixlen);
 		strbuf_addstr(&sb, vstar + 1);
 		*result = strbuf_detach(&sb, NULL);
 	}
@@ -301,7 +301,7 @@ static int refspec_match(const struct refspec_item *refspec,
 			 const char *name)
 {
 	if (refspec->pattern)
-		return match_name_with_pattern(refspec->src, name, NULL, NULL);
+		return match_refname_with_pattern(refspec->src, name, NULL, NULL);
 
 	return !strcmp(refspec->src, name);
 }
@@ -352,7 +352,7 @@ static int refspec_find_negative_match(struct refspec *rs, struct refspec_item *
 			const char *key = refspec->dst ? refspec->dst : refspec->src;
 			const char *value = refspec->src;
 
-			if (match_name_with_pattern(key, needle, value, &expn_name))
+			if (match_refname_with_pattern(key, needle, value, &expn_name))
 				string_list_append_nodup(&reversed, expn_name);
 		} else if (refspec->matching) {
 			/* For the special matching refspec, any query should match */
@@ -397,7 +397,7 @@ void refspec_find_all_matches(struct refspec *rs,
 		if (!refspec->dst || refspec->negative)
 			continue;
 		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result))
+			if (match_refname_with_pattern(key, needle, value, result))
 				string_list_append_nodup(results, *result);
 		} else if (!strcmp(needle, key)) {
 			string_list_append(results, value);
@@ -426,7 +426,7 @@ int refspec_find_match(struct refspec *rs, struct refspec_item *query)
 		if (!refspec->dst || refspec->negative)
 			continue;
 		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result)) {
+			if (match_refname_with_pattern(key, needle, value, result)) {
 				query->force = refspec->force;
 				return 0;
 			}
diff --git a/refspec.h b/refspec.h
index f62f83a7ee..e2b5cc54ef 100644
--- a/refspec.h
+++ b/refspec.h
@@ -75,11 +75,12 @@ void refspec_ref_prefixes(const struct refspec *rs,
 int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs);
 
 /*
- * Checks whether a name matches a pattern and optionally generates a result.
- * Returns 1 if the name matches the pattern, 0 otherwise.
+ * Checks if a refname matches a globbing refspec pattern.
+ * If replacement is provided, computes the corresponding mapped refname.
+ * Returns 1 if refname matches pattern, 0 otherwise.
  */
-int match_name_with_pattern(const char *key, const char *name,
-				   const char *value, char **result);
+int match_refname_with_pattern(const char *pattern, const char *refname,
+				   const char *replacement, char **result);
 
 /*
  * Queries a refspec for a match and updates the query item.
diff --git a/remote.c b/remote.c
index 5574b6a00f..5d3d1773dc 100644
--- a/remote.c
+++ b/remote.c
@@ -1322,9 +1322,9 @@ static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
 			const char *dst_side = item->dst ? item->dst : item->src;
 			int match;
 			if (direction == FROM_SRC)
-				match = match_name_with_pattern(item->src, ref->name, dst_side, &name);
+				match = match_refname_with_pattern(item->src, ref->name, dst_side, &name);
 			else
-				match = match_name_with_pattern(dst_side, ref->name, item->src, &name);
+				match = match_refname_with_pattern(dst_side, ref->name, item->src, &name);
 			if (match) {
 				matching_refs = i;
 				break;
@@ -1942,7 +1942,7 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
-		if (match_name_with_pattern(refspec->src, ref->name,
+		if (match_refname_with_pattern(refspec->src, ref->name,
 					    refspec->dst, &expn_name) &&
 		    !ignore_symref_update(expn_name, &scratch)) {
 			struct ref *cpy = copy_ref(ref);
-- 
2.34.1

