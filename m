Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951DB126F1E
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738392190; cv=none; b=WMppOdg6Grw2N1mxor50i4v2e3O/1RB03P1i53qSAXTTcKsJrBdgHjNKp7C2TUKy4psbtH/mTmS5340ypB7v00q8b42LomrX7IJpuZdGI45Zf28prKgpeUFuE1cHAH/xdpMUlCFURbN+qdnA++SNNZzAES+lTtOFDhs1Bdq6XPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738392190; c=relaxed/simple;
	bh=o0RSl/GTWUbwoOVBaZeyzZsfazQZv4I9jj3N0c/i/7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQ9hMIkd/kQ13z+21sgBXBWunoyzLkkN4e8sPO64EwqR7qkN2GpZFLhEu0MjWL8RIapGl1AQsd8uhJnWlyca0ptI7qIT7apWigNqN9SzGjhE8H9YZIuf/Rkz9zIs4mpBJWtJP3gROpC8gxusAXrHYg573QaSInh+zbOcTRxKmJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyPz0qw2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyPz0qw2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166f1e589cso69067625ad.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738392187; x=1738996987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csK2Ph5s9/p6teNNvidx4xGEocrCytCWN/BhSGHMWuM=;
        b=SyPz0qw2ltwapLTl9iUWE4i9H4NCN1mVruSnFpFXA9rSaQ6QuxOnaSitAdetmOvY9K
         oWAb9QKpKPCHBaKKLSWIrw3CY20EO70ExV9lfMAFWBdj6Tl1LmH0sxtxxZoU4HIVPh82
         /TwDaWE7/Hh4pzojygyi1ll5s/72PnGu316KN2Q9jr4vjhiQsa46v6pf8RvNdWdzO0Km
         PleLfYaoeLFXcmCUt1NigAiPZdG8aRY52E58KOFT6ysNZzm98oF0iV2dJjpqTkKgsdTe
         Zq98kSHkbRPYc+dpIb3cI2TDg3b8YDKsVwDGAVXCaYa0EwPgRsNQ/QUAl8OWmSsgLGm5
         DdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738392187; x=1738996987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csK2Ph5s9/p6teNNvidx4xGEocrCytCWN/BhSGHMWuM=;
        b=R+aTRF+WI/L26Sq9FHaDG6xMJVNjS3UYQbsalPKcQayfa/6xxTIdfxcIJS2SgthhPj
         ZOBwtgtkS/uDj8v0Ae1bEpR1b+E0ge5VHLs7RsY+A3FcH2a8sMxwX139SSgGXDK6VaBd
         iTYPe0mkSGPq+5Dr/Xz5dzecDAthfKJUchRGhPV81hcr0BhoBpSuL1yrm/pGSiJZ4oqs
         vqWFSM9xSz88XzGjNKzZEX1RccvUyEsLbs332T2U0AVlnNX4glfdb5C0OOa9r0sIeSCk
         yv6Wkn8ZRxr5QbMizisKK521PeTSMNMsA5OezzmkZ+0apPvH0kQvqbrwj+BkXWYnadPM
         nmzA==
X-Gm-Message-State: AOJu0YwIaUfOXhF71Y5yQC7N+5r3oSMpvL/EHNcGFgIYv2L7tkdUU9gM
	8OEEE1n2P525kVc3XXGohBcR8YMCXNBFuTS7t3AFuC20jTDQlowCyzA29BWL
X-Gm-Gg: ASbGnctaV+GDSLubpJcEImxBA9FRmxAFJkJOqwhdEE1nBVl3Hjvj7od6e3uZUimhTKv
	M0k9xDDTatXQEhGyN/JL+/7vgxVZSMGNYmOBQEudirjEMY/B/V7yseyNpK+AijgEBscZzxMCHed
	51x21UQUJ4aW61I/2zDZ5waWoLwUMDxRs0QL53C6PUkpd88qaWpGMMkm1DnjFDlg2oFz0wx4pno
	KkFvELu2rw4F+5zso1f04nEc+likfxIv0+/6IOccQxMgdOJ8ttP61fvlkO6d1y7Mo/3syvYx+W0
	pkt9OHmZQf1TsA==
X-Google-Smtp-Source: AGHT+IE/rBlifCEywCCP5vxUHUtTkFYEWZS7Fwnu4F8GiueJ7DHMeOD5fqPBKmjuH9ajoOOwjRYRYw==
X-Received: by 2002:a05:6a21:78c:b0:1e1:9f77:da92 with SMTP id adf61e73a8af0-1ed7a5ee31emr20667335637.33.1738392186905;
        Fri, 31 Jan 2025 22:43:06 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0e8ef61sm4058592a12.78.2025.01.31.22.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 22:43:06 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Matthew Rogers <mattr94@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v3 3/5] refactor(remote): rename query_refspecs functions
Date: Sat,  1 Feb 2025 12:12:00 +0530
Message-Id: <20250201064202.76116-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201064202.76116-1-meetsoni3017@gmail.com>
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
 <20250201064202.76116-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename `query_refspecs()` to `find_refspec_match` for clarity, as it
finds a single matching refspec.

Rename `query_refspecs_multiple()` to `find_all_refspec_matches` to
better reflect that it collects all matching refspecs instead of
returning just the first match.

Rename `query_matches_negative_refspec()` to
`find_negative_refspec_match` for consistency with the updated naming
convention.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 builtin/push.c |  2 +-
 remote.c       | 20 ++++++++++----------
 remote.h       |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 90de3746b5..e6527b0b04 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -78,7 +78,7 @@ static void refspec_append_mapped(struct refspec *refspec, const char *ref,
 			.src = matched->name,
 		};
 
-		if (!query_refspecs(&remote->push, &query) && query.dst) {
+		if (!find_refspec_match(&remote->push, &query) && query.dst) {
 			refspec_appendf(refspec, "%s%s:%s",
 					query.force ? "+" : "",
 					query.src, query.dst);
diff --git a/remote.c b/remote.c
index 1da8ec7037..4654bce5d4 100644
--- a/remote.c
+++ b/remote.c
@@ -925,7 +925,7 @@ struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
 	return ref_map;
 }
 
-static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
+static int find_negative_refspec_match(struct refspec *rs, struct refspec_item *query)
 {
 	int i, matched_negative = 0;
 	int find_src = !query->src;
@@ -982,7 +982,7 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 	return matched_negative;
 }
 
-static void query_refspecs_multiple(struct refspec *rs,
+static void find_all_refspec_matches(struct refspec *rs,
 				    struct refspec_item *query,
 				    struct string_list *results)
 {
@@ -990,9 +990,9 @@ static void query_refspecs_multiple(struct refspec *rs,
 	int find_src = !query->src;
 
 	if (find_src && !query->dst)
-		BUG("query_refspecs_multiple: need either src or dst");
+		BUG("find_all_refspec_matches: need either src or dst");
 
-	if (query_matches_negative_refspec(rs, query))
+	if (find_negative_refspec_match(rs, query))
 		return;
 
 	for (i = 0; i < rs->nr; i++) {
@@ -1013,7 +1013,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 	}
 }
 
-int query_refspecs(struct refspec *rs, struct refspec_item *query)
+int find_refspec_match(struct refspec *rs, struct refspec_item *query)
 {
 	int i;
 	int find_src = !query->src;
@@ -1021,9 +1021,9 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	char **result = find_src ? &query->src : &query->dst;
 
 	if (find_src && !query->dst)
-		BUG("query_refspecs: need either src or dst");
+		BUG("find_refspec_match: need either src or dst");
 
-	if (query_matches_negative_refspec(rs, query))
+	if (find_negative_refspec_match(rs, query))
 		return -1;
 
 	for (i = 0; i < rs->nr; i++) {
@@ -1054,7 +1054,7 @@ char *apply_refspecs(struct refspec *rs, const char *name)
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.src = (char *)name;
 
-	if (query_refspecs(rs, &query))
+	if (find_refspec_match(rs, &query))
 		return NULL;
 
 	return query.dst;
@@ -1062,7 +1062,7 @@ char *apply_refspecs(struct refspec *rs, const char *name)
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return query_refspecs(&remote->fetch, refspec);
+	return find_refspec_match(&remote->fetch, refspec);
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
@@ -2487,7 +2487,7 @@ static int get_stale_heads_cb(const char *refname, const char *referent UNUSED,
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.dst = (char *)refname;
 
-	query_refspecs_multiple(info->rs, &query, &matches);
+	find_all_refspec_matches(info->rs, &query, &matches);
 	if (matches.nr == 0)
 		goto clean_exit; /* No matches */
 
diff --git a/remote.h b/remote.h
index 66ee53411d..f109310eda 100644
--- a/remote.h
+++ b/remote.h
@@ -269,7 +269,7 @@ int refname_matches_negative_refspec_item(const char *refname, struct refspec *r
  */
 struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
 
-int query_refspecs(struct refspec *rs, struct refspec_item *query);
+int find_refspec_match(struct refspec *rs, struct refspec_item *query);
 char *apply_refspecs(struct refspec *rs, const char *name);
 
 int check_push_refs(struct ref *src, struct refspec *rs);
-- 
2.34.1

