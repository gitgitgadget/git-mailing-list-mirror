Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340381474A9
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715117; cv=none; b=k615+5yGF4If+7lR2uMMWGa29vgGwpL7jH55OyuXVoyW7z0HXfCQNuwE0fvWU8fua0Wm3fpBkuf6irBbDVUWNg05UiJDthZ/KUca696EUWmywX2U6jswTK5yjXw+UqjqLTP4Nm1LlBU7EkfY6LxeiAgEjai1lkhNcsP25nRsT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715117; c=relaxed/simple;
	bh=gwos665eZ6F5tukUUE5Av3afHvvz6uK5XBXr8k7y5TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KocTTnn28OrTXXC6SZtzJ4fN2yPo+rncYKt2rHex9Q5LcHr9H5KTHZkzsPb7bD1Lor+6D4bFvdixavCO26H9jVeBmz3sJ7IWzJi+p+vm/MOpE9dx2zhdVxmiaosmJvP9YU5pkQM8NeiuChIige67IABRlLNL9usdBbJ75QidCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PSIe7Tte; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PSIe7Tte"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-24c9f6338a4so789310fac.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715115; x=1718319915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDY2Yi6BRuPZQBff8tNJLIy3fifVqigeLpZR8oqZerA=;
        b=PSIe7Tte5H057C0Dtu271V1+veX4tyswUOGNKHSUkr/gnS2Be96qP2kotwhN8WFOGK
         9T7iIbGcV9N1WvR6ny+I6pefNJulQ5NChaD1WjZl1iwtAwUGvKEpndzv3Sy8OvhmD8dc
         6X9hEj3tbGaFZQUBY62jEP/itxU3z9YRy59ArBn4fot94lsuJvMnAxkLQ14l9bNK19j6
         nckVa5ssnNEKE20ORnc9803Ep9+NP5mNyA8ZwIB1CvBuGKLqU1stA97v2LUv1IlkL+9w
         L+SJAjWDK5ePBjjPNvRJfU5qbHXxCLUUNo6IR9YU+WZ5RkE1NdO+1Vcpxyph/HhK+HzX
         njrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715115; x=1718319915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDY2Yi6BRuPZQBff8tNJLIy3fifVqigeLpZR8oqZerA=;
        b=KNn+pqYksGfbDX8K+nv2Oh/MCA7/QgeOVN2rS+FG/VsbQONX9ZZqWlc8xTooZX/2EA
         UVnPjL2RLB7AEdmoBFNRwBtwz2ESC1Kf/Ab4i539FXnvqveWdqikxcABoCThbCLu5mvp
         4slahz2XcdZVZKTTXm6muAJ9O9YRmzH3M9Ym1cK2I2v+BFq5LI5oiuCQ08P3U0Qimqlu
         LF1tTabqUvxzohsY0fXeeDfptgbNhv1SgdVFyrKNA4vBC1RE/ZMwg+7liC5ty5AFITjT
         7QoKdh1wCbxWke6XES5vgGjO1QU+s5j9rsT8P0MoBwwTHj3UzYTX60XjzVEnVbVVsyeU
         14UA==
X-Gm-Message-State: AOJu0Yw8RfZHGsY1wIfeFF82HU6A++5TNQpXqbg8TS86s+A5jny825Fv
	zUdCDbB9fxjktvaw351txrExhA/RVjDSKZpdvLSvVvPv6jS6qKXdcwnR3pgq8tkdeZAQcCXTkyB
	zAd0=
X-Google-Smtp-Source: AGHT+IGJ+jiKuAl3/juE5QA+r+Ar2Q+q2hWp9vKgMxAyQ63Uizia1BfSdeUQiR18mCsskTnw8sY7Iw==
X-Received: by 2002:a05:6870:a194:b0:250:7913:1712 with SMTP id 586e51a60fabf-254645901c8mr1023820fac.35.1717715114904;
        Thu, 06 Jun 2024 16:05:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795332df4c7sm102553485a.127.2024.06.06.16.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:05:14 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:05:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 16/19] midx: implement verification support for incremental
 MIDXs
Message-ID: <f729ed76121f8f38f71d5811cdeca0045e60ce8b.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

Teach the verification implementation used by `git multi-pack-index
verify` to perform verification for incremental MIDX chains by
independently validating each layer within the chain.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 47 ++++++++++++++++++++++++++++++-----------------
 midx.h |  2 ++
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/midx.c b/midx.c
index ac44fcefc2..ae3e30a062 100644
--- a/midx.c
+++ b/midx.c
@@ -467,6 +467,13 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 	return 0;
 }
 
+struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
+				   uint32_t pack_int_id)
+{
+	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
+	return m->packs[local_pack_int_id];
+}
+
 #define MIDX_CHUNK_BITMAPPED_PACKS_WIDTH (2 * sizeof(uint32_t))
 
 int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
@@ -814,6 +821,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	uint32_t i;
 	struct progress *progress = NULL;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	struct multi_pack_index *curr;
 	verify_midx_error = 0;
 
 	if (!m) {
@@ -836,8 +844,8 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_delayed_progress(_("Looking for referenced packfiles"),
-					  m->num_packs);
-	for (i = 0; i < m->num_packs; i++) {
+						  m->num_packs + m->num_packs_in_base);
+	for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
 		if (prepare_midx_pack(r, m, i))
 			midx_report("failed to load pack in position %d", i);
 
@@ -857,17 +865,20 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	if (flags & MIDX_PROGRESS)
 		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
 						 m->num_objects - 1);
-	for (i = 0; i < m->num_objects - 1; i++) {
-		struct object_id oid1, oid2;
 
-		nth_midxed_object_oid(&oid1, m, i);
-		nth_midxed_object_oid(&oid2, m, i + 1);
+	for (curr = m; curr; curr = curr->base_midx) {
+		for (i = 0; i < m->num_objects - 1; i++) {
+			struct object_id oid1, oid2;
 
-		if (oidcmp(&oid1, &oid2) >= 0)
-			midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
-				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
+			nth_midxed_object_oid(&oid1, m, m->num_objects_in_base + i);
+			nth_midxed_object_oid(&oid2, m, m->num_objects_in_base + i + 1);
 
-		midx_display_sparse_progress(progress, i + 1);
+			if (oidcmp(&oid1, &oid2) >= 0)
+				midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
+					    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
+
+			midx_display_sparse_progress(progress, i + 1);
+		}
 	}
 	stop_progress(&progress);
 
@@ -877,8 +888,8 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	 * each of the objects and only require 1 packfile to be open at a
 	 * time.
 	 */
-	ALLOC_ARRAY(pairs, m->num_objects);
-	for (i = 0; i < m->num_objects; i++) {
+	ALLOC_ARRAY(pairs, m->num_objects + m->num_objects_in_base);
+	for (i = 0; i < m->num_objects + m->num_objects_in_base; i++) {
 		pairs[i].pos = i;
 		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
 	}
@@ -892,16 +903,18 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
-	for (i = 0; i < m->num_objects; i++) {
+	for (i = 0; i < m->num_objects + m->num_objects_in_base; i++) {
 		struct object_id oid;
 		struct pack_entry e;
 		off_t m_offset, p_offset;
 
 		if (i > 0 && pairs[i-1].pack_int_id != pairs[i].pack_int_id &&
-		    m->packs[pairs[i-1].pack_int_id])
-		{
-			close_pack_fd(m->packs[pairs[i-1].pack_int_id]);
-			close_pack_index(m->packs[pairs[i-1].pack_int_id]);
+		    m->packs[pairs[i-1].pack_int_id]) {
+			uint32_t pack_int_id = pairs[i-1].pack_int_id;
+			struct packed_git *p = nth_midxed_pack(m, pack_int_id);
+
+			close_pack_fd(p);
+			close_pack_index(p);
 		}
 
 		nth_midxed_object_oid(&oid, m, pairs[i].pos);
diff --git a/midx.h b/midx.h
index 94de16a8c4..9d30935589 100644
--- a/midx.h
+++ b/midx.h
@@ -95,6 +95,8 @@ void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
+struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
+				   uint32_t pack_int_id);
 int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
 		       struct bitmapped_pack *bp, uint32_t pack_int_id);
 int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
-- 
2.45.2.437.gecb9450a0e

