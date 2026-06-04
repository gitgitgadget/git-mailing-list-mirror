Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809F409628
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570288; cv=none; b=WN31DEAmjViyc25Y+MtVnS6GRGmfGyBvmvajrItJoLx6yo9mYoxtE626C5m/sh2F8n5N+QlHQdFDRQIVoOFpqTsT3h8MbWtYDbUAmiV5wbaFrQHQWOWSmTaRoYhn7CNIwuBrcm+dm2cVQT9JP1z+XtFEBiv4pp0k0hHIRRtYmi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570288; c=relaxed/simple;
	bh=ZWl4cOSbYLv2OVGhCYVvBOFdXyZoifMkafdP9NcC9Nc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NGfvCtWMIVS9GnyWe7V7vVNhG9rrx8H0XnyHZjY/UBc5hNuuub5rA6ttBi3BKeMIldKQEI9BJlcQlkjqzDP1xGZLBh8AUpSxumNy16cFLWjPvMgisT39+mHUPPgqBZW1InZPdRpybNhSFbyChuB60xYGnjtxKm6tKa5L/enJZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzoWu8cD; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzoWu8cD"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-307263ad0cbso611523eec.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780570287; x=1781175087; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QeGyCIZWa9uX7kqXOdw0IxXzAKbm1RcprbV076zQJw=;
        b=VzoWu8cDNKIU2xghVjAPKE8siKne/d8YXZbZT6rUCsSm84vwyrhlNX5hg5qzouzEBa
         kS1Xw/K2g+3bFOs81smjZLwjqomWXeUx1vr2oDpwVGIH5IEqO5R3KPfPo5ig+a4Xt60/
         WIEEEiFsoWuk7IBiDmwYvxd/vCxS4m+IEoHQMHr3PY7dgr2jbEx0PXTvNjxjSvgyVqwY
         8m2zu5fLLMGxJrQJ38keutEJ0zd4VSzIw91efuNc0twQNFKs5LZHFOzpjO50XIabMWNp
         Bb+Awykl30SAYh3BKUSvJImRm3YqrNWK3BHkxh2zwH7TNuDn5ebhWNznolHsR3760Ge+
         quqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570287; x=1781175087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3QeGyCIZWa9uX7kqXOdw0IxXzAKbm1RcprbV076zQJw=;
        b=ABYkeJR+qYppqD3xU82MI2xekwaNw5dXZHoBSJtdzwC2WBHif5Bvr71A7fI/zRflt7
         6E9zzWRSqTfnDd7D+IfAlq8GOdKM/iWwGCkuLz7y53I6jq+xmyFSf7Kfv+ItCldb536H
         xgTloXN5iaR+hiFu8BWxbbLfIe7LLxSBSsIh9UUgSssslfVhTvuG7ujlH3UQoFD+XdMg
         +L1hZdHo4E+jhj7u83nUVNEXEn+g+utwicpUWgR5F3kbYIAPh2IQXorxl7sqsGsQyGm7
         2HotDNvx6AfiYn82jiWeuzNeDEDZygZmfRBssHQDGo94SKg2Dmw+oOJRIkDDXfmSFLUO
         pjIw==
X-Gm-Message-State: AOJu0YyaCvxkGolTqaH3Da6fewVr9/yXByNag8SDnJbWvGwIPzwT9jF8
	GDV2qapcLjS6osTJWsZ2p5XfLzFQCfa7sA1yYbcMUjRFtGGPbriWWNG7MLsKkA==
X-Gm-Gg: Acq92OETPYkseSensJNGpWtt6HcfY3Mj+dXme7z+XdZFcuJ6GJpCPeTdDp+/Hu+zY8t
	WTcgQlOSi4Q7X9KWfYZXNwOpCH8al1rBKknU7t0nO2x1ojTk5OA7d5CMs/SYoaRh4xvMNoixUhb
	axlZdeaxnkTe3PTvAwQ8aELEYxZo6KOgU7uj+EZeR/jFP10siQGQ1QLzAAWvhyrhQG2tVlnlDNY
	7kqy72b11lVfZOzVF+jmpIzJGvqRtLA256+ZTF6TnKuM8lZkokb7i3l/AOTQ/fWFF4lIC/NWqLy
	57/cuAPu8oabcI+01NiHVE+3o5+Srf+Ma5DeBxKEonmcJhpPOMG651lfMk0iYAR1tMvc/sWuZEJ
	PdzXanhrmpo/932l2A6k5UE1D8J56ECXS4QyFIBzBc/UbLMtI+m2HTfblP9b+ra7e8eIdddPCny
	dOTECtMjqm8WBpTDvC8nDln80gNhg8xJhEoQccAw==
X-Received: by 2002:a05:7300:ac90:b0:2ed:6f94:9d96 with SMTP id 5a478bee46e88-3074fb5b8f2mr3509703eec.19.1780570286633;
        Thu, 04 Jun 2026 03:51:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.209.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba046esm4367976eec.9.2026.06.04.03.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:51:26 -0700 (PDT)
Message-Id: <460d733feeaf2a94fe28d7509cc4128e9c0a7610.1780570273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 10:51:11 +0000
Subject: [PATCH 6/7] packfile,delta: drop the `cast_size_t_to_ulong()`
 wrappers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When I started the transition from `unsigned long` to `size_t`, in the
interest of keeping the patches reviewable, I introduced these calls to
prevent data type narrowing from silently failing to handle large object
sizes. I also introduced `*_sz()` variants that would allow most of the
callers to keep using that `unsigned long` that the 90s kindly asked to
be returned.

After the preceding commits, the only places that called the narrow
wrappers either no longer exist or already use the `_sz` form
internally, so the wrappers just narrow values back through
`cast_size_t_to_ulong()` for no reason.

Drop them and rename the `_sz` variants back to the natural names.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h       | 14 ++------------
 packfile.c    | 28 ++++++++--------------------
 packfile.h    |  2 +-
 patch-delta.c |  4 ++--
 4 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/delta.h b/delta.h
index bb149dc82b..eb5c6d2fdb 100644
--- a/delta.h
+++ b/delta.h
@@ -86,11 +86,8 @@ void *patch_delta(const void *src_buf, size_t src_size,
  * This must be called twice on the delta data buffer, first to get the
  * expected source buffer size, and again to get the target buffer size.
  */
-/*
- * Size_t variant that doesn't truncate - use for >4GB objects on Windows.
- */
-static inline size_t get_delta_hdr_size_sz(const unsigned char **datap,
-					   const unsigned char *top)
+static inline size_t get_delta_hdr_size(const unsigned char **datap,
+					const unsigned char *top)
 {
 	const unsigned char *data = *datap;
 	size_t cmd, size = 0;
@@ -104,11 +101,4 @@ static inline size_t get_delta_hdr_size_sz(const unsigned char **datap,
 	return size;
 }
 
-static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
-					       const unsigned char *top)
-{
-	size_t size = get_delta_hdr_size_sz(datap, top);
-	return cast_size_t_to_ulong(size);
-}
-
 #endif
diff --git a/packfile.c b/packfile.c
index dab0a9b16d..c174982d10 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1164,11 +1164,12 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 }
 
 /*
- * Size_t variant for >4GB delta results on Windows.
+ * Read a delta object's header at curpos in p (already inflated as needed)
+ * and return the size of the result object (the post-application target).
  */
-static size_t get_size_from_delta_sz(struct packed_git *p,
-				     struct pack_window **w_curs,
-				     off_t curpos)
+size_t get_size_from_delta(struct packed_git *p,
+			   struct pack_window **w_curs,
+			   off_t curpos)
 {
 	const unsigned char *data;
 	unsigned char delta_head[20], *in;
@@ -1215,18 +1216,10 @@ static size_t get_size_from_delta_sz(struct packed_git *p,
 	data = delta_head;
 
 	/* ignore base size */
-	get_delta_hdr_size_sz(&data, delta_head+sizeof(delta_head));
+	get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
 
 	/* Read the result size */
-	return get_delta_hdr_size_sz(&data, delta_head+sizeof(delta_head));
-}
-
-unsigned long get_size_from_delta(struct packed_git *p,
-				  struct pack_window **w_curs,
-				  off_t curpos)
-{
-	size_t size = get_size_from_delta_sz(p, w_curs, curpos);
-	return cast_size_t_to_ulong(size);
+	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
 }
 
 int unpack_object_header(struct packed_git *p,
@@ -1634,12 +1627,7 @@ static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_off
 				ret = -1;
 				goto out;
 			}
-			/*
-			 * Use size_t variant to avoid die() on >4GB deltas.
-			 * oi->sizep is unsigned long, so truncation may occur,
-			 * but streaming code uses its own size_t tracking.
-			 */
-			size = get_size_from_delta_sz(p, &w_curs, tmp_pos);
+			size = get_size_from_delta(p, &w_curs, tmp_pos);
 			if (size == 0) {
 				ret = -1;
 				goto out;
diff --git a/packfile.h b/packfile.h
index 0b5ae3f9fc..bd4494906d 100644
--- a/packfile.h
+++ b/packfile.h
@@ -458,7 +458,7 @@ int is_pack_valid(struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t,
 		   enum object_type *, size_t *);
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, size_t *sizep);
-unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
+size_t get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, size_t *);
 off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
 		     off_t *curpos, enum object_type type,
diff --git a/patch-delta.c b/patch-delta.c
index 44cda97994..42199fa956 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -27,12 +27,12 @@ void *patch_delta(const void *src_buf, size_t src_size,
 	top = (const unsigned char *) delta_buf + delta_size;
 
 	/* make sure the orig file size matches what we expect */
-	size = get_delta_hdr_size_sz(&data, top);
+	size = get_delta_hdr_size(&data, top);
 	if (size != src_size)
 		return NULL;
 
 	/* now the result size */
-	size = get_delta_hdr_size_sz(&data, top);
+	size = get_delta_hdr_size(&data, top);
 	dst_buf = xmallocz(size);
 
 	out = dst_buf;
-- 
gitgitgadget

