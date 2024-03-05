Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE60134AC
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 01:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601753; cv=none; b=qXYukO5SbIPnKjB1c0ruZ5M+izvdLOxf6BGZr9OFXmDDJQikv0unKUpEyl/JBRwH58NtM+IioaC4agBqVBcECrdvmV4KQp4/35h9WXE3Ju8n+sOi3kmv77mJzr/MESYHDn234M7HZFtS7sUIrUiCfRFxnhR7TZlrBhNSdCT3SL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601753; c=relaxed/simple;
	bh=zSWET9XHltTI4dv7J2oQE+rBaTTvhLwC5sDkBHBn51I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NblmtOCZN8N7dRg1xvC5u5Mch5D456DSxpLgSmNFr28qm3LKg43TyYYvPtXiHhOH23M0mUNDE9TQGofK4QAdImm68lJYC9aqGzgAGOxPxlZEXmUG+7xTClpaBXJvYwmILEH4jO7+yki5+k0VoLsUGUxvZofjzSHx1tafVA+0+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--atneya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EVQuUqzv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--atneya.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVQuUqzv"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60942936e31so91961107b3.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 17:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709601751; x=1710206551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJMXaOH3wOHu7qLOMyVPppYQQizpgRw31SFU8Zn1pCc=;
        b=EVQuUqzvfft/AszcoNcVQHP7vO94PbwgIC6OvxLIwcF1VzOk09tEJX9yrXZ+MBY1BN
         TXJPBHfD2eFJQ8rOO7Nf3gv/1lwFoNCThuGgI4eFF4rOPCzH5588KLLsnhC/o8KeJqd+
         q4GIoiHtiozZrW9QB9we5DJ82XwcVTOcILjgBkqi5WfacXZgE8wpHxQJq2OscfF0jAtK
         TcpUXj5HlDOJFKcTdxkieOSA1MGucV0nk9uDkrbbiut4/0LHnmRbEd+DoBAMkTFAxwpA
         eO0Mv8tbKb45zYK6LnXnSQKuESzgXJWI9CiyYJJ5G2XNg+DE8v17d7CzyupFWkKj5P5u
         D6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709601751; x=1710206551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJMXaOH3wOHu7qLOMyVPppYQQizpgRw31SFU8Zn1pCc=;
        b=QDH5Vp2BgeAZU/XQ1DoSz2UrzPfauVBqMDciA+L6a7Gz9PDVkgf9smJ5Pi8/T+pjdR
         xXsNnxeD3QqGNZfTlNvOfsVK3qFp+BYqkYnNM/8FmpFYfQ8O6DkhtBtqYTFbRD37XJUy
         b7OLhKTgDUFVGsC0bsCUzQEB1hWtFyC38vZo6Uj7Z3v9JtBeVhvOzgsqUWf5Kfxw9Xhn
         +iSqsBlcUKxS5bMZseUE/C2upuSggd9JcrWumbuRyEinA+0xQPA18geI3jO5qtX7Sn0S
         yjMJxdUDGShzRLfQ+1qWZ/vkeR953QExeG7sO/44sAjEHWdbm87Y1ZJj3iVvjWG69ZwM
         by0w==
X-Gm-Message-State: AOJu0Yyfy+WGZLY+TS7dw6L8zVkmqIYl7PrLM59WiWWPt5WyUL+tedDg
	gBUZvQEyTSGmXgFUZh8JViuezeBjUy/lAuY/C5PdjMm/qYcYETDd1zysdhHhyQRQ9kTNH2ewFWc
	wFQ22yLnOJvrRlkbWTGQGZugneFUUHvUQ/dRO+neOU6bXXbD2JjcvodW1vCa2zlOEFKd+xkYBjp
	JDtvX10Xt8F0WLm4NhMEkzl6+l3ebz
X-Google-Smtp-Source: AGHT+IGN562l15+umteGzUaDfamJc7ZxS1cG1ohhIvP3ZBG3t6yIlAjxwGRs71uhVjrfgg+eQ3Uc4ZP+fZI=
X-Received: from capy.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:151e])
 (user=atneya job=sendgmr) by 2002:a81:9809:0:b0:609:2031:1e09 with SMTP id
 p9-20020a819809000000b0060920311e09mr2955831ywg.6.1709601751128; Mon, 04 Mar
 2024 17:22:31 -0800 (PST)
Date: Mon,  4 Mar 2024 17:21:13 -0800
In-Reply-To: <20240305012112.1598053-2-atneya@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305012112.1598053-2-atneya@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305012112.1598053-5-atneya@google.com>
Subject: [RFC PATCH 3/3] Preload submodule state in refresh_index
From: Atneya Nair <atneya@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, jeffhost@microsoft.com, me@ttaylorr.com, 
	nasamuffin@google.com, Atneya Nair <atneya@google.com>
Content-Type: text/plain; charset="UTF-8"

refresh_index currently parallelizes updating cache_entries for regular
files based on lstat. Expand preload to parallelize exploring the
checked out state of submodules, which is substantially more expensive.

Cache the state of the submodule in memory, to avoid unnecessary
re-computation (similar to regular files).

This speeds up git status, and other operations which examine the read
index, especially in repositories with many submodules.

Signed-off-by: Atneya Nair <atneya@google.com>
---

Notes:
    For now, I added a new field to store the submodule state.
    
    Open questions:
    - Where can we efficiently store the submodule state? I assume we can
    re-use some of the ce_flags which aren't used for submodules?
    
    - Why can threads only go up to 64? Can we make this user configurable?

 preload-index.c | 25 ++++++++++++++++++++++---
 read-cache-ll.h |  1 +
 read-cache.c    |  3 +++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 63fd35d64b..091b22fa4c 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -22,7 +22,7 @@
  * to have at least 500 lstat's per thread for it to
  * be worth starting a thread.
  */
-#define MAX_PARALLEL (20)
+#define MAX_PARALLEL (60)
 #define THREAD_COST (500)
 
 struct progress_data {
@@ -59,8 +59,21 @@ static void *preload_thread(void *_data)
 
 		if (ce_stage(ce))
 			continue;
-		if (S_ISGITLINK(ce->ce_mode))
+		if (S_ISGITLINK(ce->ce_mode)) {
+			// This call evaluates the submodule HEAD for GITLINK, which really does determine
+			// if there is a change (for index purposes). We can't use the traditional path of
+			// marking as VALID, because valid can't be used for submodules due to other code
+			// paths in which valid may skip investigation of the worktree in the submodule.
+			// Gitlinks also aren't statable, or fsmonitorable, so caching doesn't have the same
+			// semantics.
+			// Use a special entry to mark the ref change state and its validity. Future calls
+			// to ce_compare_gitlink will leverage this.
+			if (lstat(ce->name, &st))
+				continue;
+			ce->sub_ref_state = (!!(ie_match_stat(index, ce, &st,
+					CE_MATCH_RACY_IS_DIRTY|CE_MATCH_IGNORE_FSMONITOR) & DATA_CHANGED) << 1) | 0x1;
 			continue;
+		}
 		if (ce_uptodate(ce))
 			continue;
 		if (ce_skip_worktree(ce))
@@ -107,11 +120,17 @@ void preload_index(struct index_state *index,
 	struct thread_data data[MAX_PARALLEL];
 	struct progress_data pd;
 	int t2_sum_lstat = 0;
+	int link_count = 0;
 
 	if (!HAVE_THREADS || !core_preload_index)
 		return;
 
-	threads = index->cache_nr / THREAD_COST;
+	for (i = 0; i < index->cache_nr; i++) {
+		link_count += (S_ISGITLINK(index->cache[i]->ce_mode));
+	}
+	// Exploring gitlinks are much more expensive than lstat, so modify the cost
+	threads = (index->cache_nr / THREAD_COST) + (link_count / 25);
+
 	if ((index->cache_nr > 1) && (threads < 2) && git_env_bool("GIT_TEST_PRELOAD_INDEX", 0))
 		threads = 2;
 	if (threads < 2)
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 2a50a784f0..5555bb0ae9 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -27,6 +27,7 @@ struct cache_entry {
 	unsigned int mem_pool_allocated;
 	unsigned int ce_namelen;
 	unsigned int index;	/* for link extension */
+	unsigned int sub_ref_state; /* TODO pack somewhere. Lowest bit valid, second lowest dirty. */
 	struct object_id oid;
 	char name[FLEX_ARRAY]; /* more */
 };
diff --git a/read-cache.c b/read-cache.c
index f546cf7875..541d40ca30 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -271,6 +271,9 @@ static int ce_compare_gitlink(const struct cache_entry *ce)
 	 *
 	 * If so, we consider it always to match.
 	 */
+	if (ce->sub_ref_state & 0x1)
+		/* Check the cached value */
+		return ce->sub_ref_state >> 1;
 	if (resolve_gitlink_ref(ce->name, "HEAD", &oid) < 0)
 		return 0;
 	return !oideq(&oid, &ce->oid);
-- 
2.44.0.rc1.240.g4c46232300-goog

