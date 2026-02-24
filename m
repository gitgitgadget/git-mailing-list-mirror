Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED3C2DEA68
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959585; cv=none; b=HkOtPEWL5h+xAfOpMQWLSL12SECUxLKkZY77INzalfL9if80kr/66hVXG2gkYdI0rXfXRdv8hJla1ujp/FDebpO66XqLFYzoHtxECDghfJYKzbLwcgS3lc4alCzgYHUwPnw7VHbExYLbbJZ2USsM2tA+oPTOe+dpbFn/tPoeSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959585; c=relaxed/simple;
	bh=aOohPY4KRZCE/SwTfRcUdHha/tzsChIK4ZziVHaSDUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK3/j3VrocnozVMbNNZghAKRvfX6HAQFMARL5otRxttBkdGhddrJ902ptwDbzlHmk/0HFs5dqtOFFxx9Bz2S2Fu6YRSLaOUvMqYpBgSztF9ZgqIJ5NdFYiq3TxiruMtbZDAVH77QwrsP5JNLhJ38PfKmedCl9j+jl1we4cyg5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nD3sHnkv; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nD3sHnkv"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-897002b7576so77459416d6.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959582; x=1772564382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WRIs6QESrK37CfcXMYu4duAScIndgs+RbvotXJ0bvbc=;
        b=nD3sHnkvAiNQf1/9c+j7MKpyvRS9plDSoNRH6qoi/PNrLLIewFcKUPHOCzgKTD1aUf
         fIThkPgACc0h3Wp6tM4OczaIfrRJeNfjsGWtb1YnY0x5027XoB7kgf5MgaRq9CvK3VTp
         uWejL2HBH0dbSXhvtPKsqQ5/+frTPNa6vrqNuco3mcnCz0+RvmcR2gEzF2p1UjM+L14V
         pULKZEEEIg/EFpr4NujbWDhK8YwqWDvmWEzUb7b9WdyJsgXvEriusbGMebVXnpofZp3B
         3q6CalAWIEA4DVWGvPKGDZR+6/3gd5BCJ6+PBDgGoQFAASboIl/yMejWP5TKq04mXSdf
         2kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959582; x=1772564382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRIs6QESrK37CfcXMYu4duAScIndgs+RbvotXJ0bvbc=;
        b=u0EBd1Gu/tnnrEGXD7qJUVMfE/wdTw3aF/qbUDi6QpywGi9peVPQmfZftcamaOs1qj
         ON2jIQDr3bOEXnMuvFtPWjmIT3cpMrdP0MV63lyYcX0myb+gqxuwQWklojb/8+hSqoKq
         AghQSIQYoSS/4JnNQ0z96GDR2LJMgoATsL+EKC+gI+kOUmj8YHbtBXVSjPWZWiIbZUie
         1Rp/iubOe0QntJUwB9RJUsvBMXNQnOUg0Euzvu5+nV4Zoh+LLwUL8m561s6EZ0wmekWq
         TcEzKDRbdXSwOYUUAK0MI5IVI9gvUYATsFYljImcVqZ4rlo6TgV+osS1VFrKHGhrOlyN
         wU1w==
X-Gm-Message-State: AOJu0YzG7ExJ0qwfOSQb47myxC6Sh8mOSw/2xMvPWSEJx1g1Tu1Z+zMa
	f/PfoVS+zGLJpBXAfIRy6xdV2mWIz+MHwYabqVpkhEPluB+RQGltgGetW1iW2mIJASvC+dwZf2c
	Tw564ZEvUZQ==
X-Gm-Gg: AZuq6aKMydTFkzx+5g45P+IA+0k6gVSXIqE6MQwyVJV3TfYhYK9BFL9wCWpOUmsS4n5
	OgSObgGEgDbyeIeRysVP/BXQatEIkFGdDhUmpA82f/ubbmXNrKbbRq/OBkesYJThV5zr/7UJPdr
	qFvtm7G1DXYlGl639grQBQE8DWkGeBicc7aIILbI4qZ7Yl/OBy73H2HhXJorzW5lkJJO+kRUN9f
	PqoCJvUCC8FedWzmvUgzODbs+/p2CA2al8+HshKQuSQTAYs4mmQMestjzum8XwYa1eGTXUqV+0n
	AzZoyayBRYhe4BDwa0IS8HBqzFGs3/cfUGmolIUFVSO2vcd1dWX+WbLxuLG/18shoflspLfOp0T
	WJZjZuf3bGCu8u/BESDje9pkGFs8zCbxtxZprQnmOpt5aHGbEWhWhM5Ppn6NbUaXX4l6futj0w6
	x6DAgiUdhhymgzzpq6hS4hSj7dS8vAULkhmKUhfbK5VydxK5XnWTg3VMHON89u85y43FqbwW564
	zZytwqYG85mO8XSakwLCa9yLm26bg==
X-Received: by 2002:a05:620a:29d1:b0:8c7:1156:efd8 with SMTP id af79cd13be357-8cb8ca0e734mr1627923785a.29.1771959582178;
        Tue, 24 Feb 2026 10:59:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0460e1sm1283498285a.2.2026.02.24.10.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:59:41 -0800 (PST)
Date: Tue, 24 Feb 2026 13:59:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/17] midx: rename `get_midx_checksum()` to
 `midx_get_checksum_hash()`
Message-ID: <61dd8e65d1a6d4c68648f73de1e4f991c9d6f2cf.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

Since 541204aabea (Documentation: document naming schema for structs and
their functions, 2024-07-30), we have adopted a naming convention for
functions that would prefer a name like, say, `midx_get_checksum()` over
`get_midx_checksum()`.

Adopt this convention throughout the midx.h API. Since this function
returns a raw (that is, non-hex encoded) hash, let's suffix the function
with "_hash()" to make this clear. As a side effect, this prepares us
for the subsequent change which will introduce a "_hex()" variant that
encodes the checksum itself.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c              | 6 +++---
 midx.c                    | 2 +-
 midx.h                    | 2 +-
 pack-bitmap.c             | 8 ++++----
 pack-revindex.c           | 4 ++--
 t/helper/test-read-midx.c | 4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 6485cb67068..73d33752ef1 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -946,7 +946,7 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(midx_exts); i++) {
-		const unsigned char *hash = get_midx_checksum(m);
+		const unsigned char *hash = midx_get_checksum_hash(m);
 
 		get_midx_filename_ext(m->source, &from,
 				      hash, midx_exts[i].non_split);
@@ -1151,7 +1151,7 @@ static int write_midx_internal(struct odb_source *source,
 		while (m) {
 			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
 				error(_("could not load reverse index for MIDX %s"),
-				      hash_to_hex_algop(get_midx_checksum(m),
+				      hash_to_hex_algop(midx_get_checksum_hash(m),
 							m->source->odb->repo->hash_algo));
 				goto cleanup;
 			}
@@ -1520,7 +1520,7 @@ static int write_midx_internal(struct odb_source *source,
 		for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
 			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
 
-			keep_hashes[j] = xstrdup(hash_to_hex_algop(get_midx_checksum(m),
+			keep_hashes[j] = xstrdup(hash_to_hex_algop(midx_get_checksum_hash(m),
 								   r->hash_algo));
 			m = m->base_midx;
 		}
diff --git a/midx.c b/midx.c
index 2a6b18954c5..1d072bd9931 100644
--- a/midx.c
+++ b/midx.c
@@ -24,7 +24,7 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
 
-const unsigned char *get_midx_checksum(const struct multi_pack_index *m)
+const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m)
 {
 	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
 }
diff --git a/midx.h b/midx.h
index 7c7e0b59121..62d6105195f 100644
--- a/midx.h
+++ b/midx.h
@@ -85,7 +85,7 @@ struct multi_pack_index {
 #define MIDX_EXT_BITMAP "bitmap"
 #define MIDX_EXT_MIDX "midx"
 
-const unsigned char *get_midx_checksum(const struct multi_pack_index *m);
+const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m);
 void get_midx_filename(struct odb_source *source, struct strbuf *out);
 void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
 			   const unsigned char *hash, const char *ext);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 972203f12b6..6307bbdf1e1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -441,11 +441,11 @@ char *midx_bitmap_filename(struct multi_pack_index *midx)
 	struct strbuf buf = STRBUF_INIT;
 	if (midx->has_chain)
 		get_split_midx_filename_ext(midx->source, &buf,
-					    get_midx_checksum(midx),
+					    midx_get_checksum_hash(midx),
 					    MIDX_EXT_BITMAP);
 	else
 		get_midx_filename_ext(midx->source, &buf,
-				      get_midx_checksum(midx),
+				      midx_get_checksum_hash(midx),
 				      MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
@@ -502,7 +502,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (load_bitmap_header(bitmap_git) < 0)
 		goto cleanup;
 
-	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum,
+	if (!hasheq(midx_get_checksum_hash(bitmap_git->midx), bitmap_git->checksum,
 		    bitmap_repo(bitmap_git)->hash_algo)) {
 		error(_("checksum doesn't match in MIDX and bitmap"));
 		goto cleanup;
@@ -2819,7 +2819,7 @@ void test_bitmap_walk(struct rev_info *revs)
 
 		if (bitmap_is_midx(found))
 			fprintf_ln(stderr, "Located via MIDX '%s'.",
-				   hash_to_hex_algop(get_midx_checksum(found->midx),
+				   hash_to_hex_algop(midx_get_checksum_hash(found->midx),
 						     revs->repo->hash_algo));
 		else
 			fprintf_ln(stderr, "Located via pack '%s'.",
diff --git a/pack-revindex.c b/pack-revindex.c
index 56cd803a679..294b802d402 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -390,11 +390,11 @@ int load_midx_revindex(struct multi_pack_index *m)
 
 	if (m->has_chain)
 		get_split_midx_filename_ext(m->source, &revindex_name,
-					    get_midx_checksum(m),
+					    midx_get_checksum_hash(m),
 					    MIDX_EXT_REV);
 	else
 		get_midx_filename_ext(m->source, &revindex_name,
-				      get_midx_checksum(m),
+				      midx_get_checksum_hash(m),
 				      MIDX_EXT_REV);
 
 	ret = load_revindex_from_disk(m->source->odb->repo->hash_algo,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 6de5d1665af..b8fefb1a124 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -34,7 +34,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 		return 1;
 
 	if (checksum) {
-		while (m && strcmp(hash_to_hex(get_midx_checksum(m)), checksum))
+		while (m && strcmp(hash_to_hex(midx_get_checksum_hash(m)), checksum))
 			m = m->base_midx;
 		if (!m)
 			return 1;
@@ -94,7 +94,7 @@ static int read_midx_checksum(const char *object_dir)
 	m = setup_midx(object_dir);
 	if (!m)
 		return 1;
-	printf("%s\n", hash_to_hex(get_midx_checksum(m)));
+	printf("%s\n", hash_to_hex(midx_get_checksum_hash(m)));
 
 	close_midx(m);
 	return 0;
-- 
2.53.0.171.gde83996e422

