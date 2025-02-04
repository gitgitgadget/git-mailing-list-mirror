Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548E16FF44
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641979; cv=none; b=Opvg7Gmvg4JPi+lFlx1nD+z8wtIQphWj6jxbJxc7WoQiwQdnQ8gmxMKxYRvRqJdP9IANzbbrjDu0I3VtNJLFLhqSOgEmdnTH3+ukYTiuOUa/mAypzfuVwrIDyC8bw/bJMV+L6RTtwfwLmIUy/l7h3bu1TRsLjC5ch0Gd4rdzc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641979; c=relaxed/simple;
	bh=OeYLS3WZ2+RTWYOVZivojvdAHmyuufU3UCKZEI3gjXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YKvdDyamqOUndE6S2NZqtYxH5mMVc/oYP3a6wY/zOyws1TyvFxzE9I7uHI7WJVboj5tMtyU2IAXgR+UrbdNFJGjz55/gE8n7gG64/augW46Qc8MyozdMhh2r5Nx03ny5rJcCxi4/DTw3cZ56Q9oaIUVJB32KoNNlOu00a2rlMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw1Pdp+D; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw1Pdp+D"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so8899746a91.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 20:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738641977; x=1739246777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrkFf0+1B586BYPUmx4yFi2Vp+dfGSg1x4gcoqndSeM=;
        b=Mw1Pdp+D/4DA+sdpfqHWWLKPoPc7tkXJDAhrsNvWoMVVJYgcnUs9SJb1TTJWPjb7Ki
         AwLqo6L2mqHxCtnaCYq7k3L+L3xEc/XN7Xh815q7bCNgIeW708xVyy3E+d9JTPg276lD
         JGILBRW1P93orNMcEtIBDUBhL1FbzqfsCBegJm5EPhxaOWnDIyXY0MyF8kATKGV0JOIB
         slVFv8Wf2jOFobu9t14PimLgTkO2yjJr5OIfgNyGDfETQrm8crPgIJSMr3KDzM4q9pvb
         TTma+1gi0z00XA+4vEl0mt0MszMLyE7IkGorjrChnffvc9jA8WyfHft689qMdikOFFBH
         Xobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738641977; x=1739246777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrkFf0+1B586BYPUmx4yFi2Vp+dfGSg1x4gcoqndSeM=;
        b=CzRu5TerrTQgGs1i/cgo3aKLKtwvISy0eChcFZcI8C6g3WfXszQ0DfVN5l8H9b53t7
         f5lzBKqWsUejs05Ljy6qAMKLYLvT6KxVgqGnUMEtmlbAUEYiUpk7HA8LMs+QZ+CuaY2Z
         BoJnzcNj8ymxAlxKM1q65YgSjlVkem53t+td2e+8HLjesCoTMgXef8yQ9/5G40doh0Qz
         Ge2ZClGlqNKgnVltafAKz+gCHK/M/qTu7gW2epBflDQgLHoSG4XT36uCWHhgwup3tKAE
         PFKf8UaNX8kb2cGsMsjM6NPk6T3ehik86cX3C+CFRgIHYTyGWe1tmj3vT4hFOWnjsygJ
         eQNA==
X-Gm-Message-State: AOJu0YyZcvfGerzkkPnrfwk/QLndADQyOsk95Ak9ZSxuxGjF6gsp7BTK
	qMI1flbrZKJIRvSzA5z7Str6e+g6QATiDGzx9FO0v8SQyBwWPq1JtQqg1w==
X-Gm-Gg: ASbGnctV34LfIKJYUSWIDCd5PNXCFMB6PQh0be1bxkoDZHdJQhKRZYcIjMdvKWqTfxL
	NTKNTFHfy7OCVsE/pfVCtm0YDhb4nEH9BmasClzblaH288i1/Bym2dEC1bVj8coyB4AdwZ5eaf3
	4J3Bl5jzEb1dbczH+V67sqYozBzhEWDCFnGtiyKyICznsld0Fq9u9abdONeT5ik/GD+DdYI7+2j
	kWrG0hJg+7chQD0OztgXGieIEJjue9q1Hss1bVDMKsiw/azz0HLvs1842BxXuZo58nOoTZs808V
	dwNUlTYNktB8Kg==
X-Google-Smtp-Source: AGHT+IF5e3AP57DZ/5LtquHXiVZ6sMatiDqif7wAiLgnUMNfK+7AXYCQKSIYoytPcYn5jowOCqIXdg==
X-Received: by 2002:a17:90b:288c:b0:2f4:432d:250d with SMTP id 98e67ed59e1d1-2f83ac17f80mr34026129a91.21.1738641977012;
        Mon, 03 Feb 2025 20:06:17 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bd09cb1sm12272583a91.21.2025.02.03.20.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:06:16 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Matthew Rogers <mattr94@gmail.com>
Subject: [GSoC][PATCH v4 3/5] remote: rename query_refspecs functions
Date: Tue,  4 Feb 2025 09:35:56 +0530
Message-Id: <20250204040558.34766-4-meetsoni3017@gmail.com>
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

Rename functions related to handling refspecs in preparation for their
move from `remote.c` to `refspec.c`. Update their names to better
reflect their intent:

    - `query_refspecs()` -> `refspec_find_match()` for clarity, as it
      finds a single matching refspec.

    - `query_refspecs_multiple()` -> `refspec_find_all_matches()` to
      better reflect that it collects all matching refspecs instead of
      returning just the first match.

    - `query_matches_negative_refspec()` ->
      `refspec_find_negative_match()` for consistency with the
      updated naming convention, even though this static function
      didn't strictly require renaming.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 builtin/push.c |  2 +-
 remote.c       | 20 ++++++++++----------
 remote.h       |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 90de3746b5..92d530e5c4 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -78,7 +78,7 @@ static void refspec_append_mapped(struct refspec *refspec, const char *ref,
 			.src = matched->name,
 		};
 
-		if (!query_refspecs(&remote->push, &query) && query.dst) {
+		if (!refspec_find_match(&remote->push, &query) && query.dst) {
 			refspec_appendf(refspec, "%s%s:%s",
 					query.force ? "+" : "",
 					query.src, query.dst);
diff --git a/remote.c b/remote.c
index 1da8ec7037..b510809a56 100644
--- a/remote.c
+++ b/remote.c
@@ -925,7 +925,7 @@ struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
 	return ref_map;
 }
 
-static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
+static int refspec_find_negative_match(struct refspec *rs, struct refspec_item *query)
 {
 	int i, matched_negative = 0;
 	int find_src = !query->src;
@@ -982,7 +982,7 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 	return matched_negative;
 }
 
-static void query_refspecs_multiple(struct refspec *rs,
+static void refspec_find_all_matches(struct refspec *rs,
 				    struct refspec_item *query,
 				    struct string_list *results)
 {
@@ -990,9 +990,9 @@ static void query_refspecs_multiple(struct refspec *rs,
 	int find_src = !query->src;
 
 	if (find_src && !query->dst)
-		BUG("query_refspecs_multiple: need either src or dst");
+		BUG("refspec_find_all_matches: need either src or dst");
 
-	if (query_matches_negative_refspec(rs, query))
+	if (refspec_find_negative_match(rs, query))
 		return;
 
 	for (i = 0; i < rs->nr; i++) {
@@ -1013,7 +1013,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 	}
 }
 
-int query_refspecs(struct refspec *rs, struct refspec_item *query)
+int refspec_find_match(struct refspec *rs, struct refspec_item *query)
 {
 	int i;
 	int find_src = !query->src;
@@ -1021,9 +1021,9 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	char **result = find_src ? &query->src : &query->dst;
 
 	if (find_src && !query->dst)
-		BUG("query_refspecs: need either src or dst");
+		BUG("refspec_find_match: need either src or dst");
 
-	if (query_matches_negative_refspec(rs, query))
+	if (refspec_find_negative_match(rs, query))
 		return -1;
 
 	for (i = 0; i < rs->nr; i++) {
@@ -1054,7 +1054,7 @@ char *apply_refspecs(struct refspec *rs, const char *name)
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.src = (char *)name;
 
-	if (query_refspecs(rs, &query))
+	if (refspec_find_match(rs, &query))
 		return NULL;
 
 	return query.dst;
@@ -1062,7 +1062,7 @@ char *apply_refspecs(struct refspec *rs, const char *name)
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return query_refspecs(&remote->fetch, refspec);
+	return refspec_find_match(&remote->fetch, refspec);
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
@@ -2487,7 +2487,7 @@ static int get_stale_heads_cb(const char *refname, const char *referent UNUSED,
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.dst = (char *)refname;
 
-	query_refspecs_multiple(info->rs, &query, &matches);
+	refspec_find_all_matches(info->rs, &query, &matches);
 	if (matches.nr == 0)
 		goto clean_exit; /* No matches */
 
diff --git a/remote.h b/remote.h
index 66ee53411d..516ba7f398 100644
--- a/remote.h
+++ b/remote.h
@@ -269,7 +269,7 @@ int refname_matches_negative_refspec_item(const char *refname, struct refspec *r
  */
 struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
 
-int query_refspecs(struct refspec *rs, struct refspec_item *query);
+int refspec_find_match(struct refspec *rs, struct refspec_item *query);
 char *apply_refspecs(struct refspec *rs, const char *name);
 
 int check_push_refs(struct ref *src, struct refspec *rs);
-- 
2.34.1

