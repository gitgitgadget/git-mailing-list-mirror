Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF071C3BF9
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738328148; cv=none; b=sRymLZxzaoPRkMn97pYJ3u/97PeMOX9i+MJbhgvh4dNdjT6/SMnoPmLpHryuy51vTu3ywNwvWhhhed6BynMx/6n7us0RQVzap17W1ZQ2C+hZHKOOxZEbR3qqLNry+FqtYUY4KZs+u/lVxvwcP7B4B32WAM+7JVAz7LRjPKnjYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738328148; c=relaxed/simple;
	bh=MUmoo9D81s+fpxwV20tsjVQatVHvEQBI0/L/uN7u0hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3rSw3nEfQNgXKwkTyKNnwb0qL1y7894/lplh8pA3+X/c9ByTcWjwmRDi1WUlvZjsMkA+ajcj59oghoM2vpuq/kcSQBrQ6VWATfjYJIabY/cp3yKftFoxeCb5u2ah3WeTsjzuEAv2CEh5s0H88HK60oLKfxYJ4uLHqZrMFyTqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ei38dLfv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OApF9OPj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ei38dLfv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OApF9OPj"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 038BF1140198;
	Fri, 31 Jan 2025 07:55:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 31 Jan 2025 07:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738328144;
	 x=1738414544; bh=EKb6EBgbHdoOYXDWWXZ9hP71nn6G4ttmlGyvxA19wlY=; b=
	ei38dLfvOVJbRNeu7MP8ibaisBJatVJlrhrZGVoZdP9D1rw+67+b/ATr67a5YVty
	r7NbX0LBSpkM6cZDsUj7kWfittdH8pPFMmcLYYBuDxwhFei5DYIMpvpJTGtyxB9n
	SzT/LrkFuzEjWVeGRoZBzmGXKIfdHnegvAo2q0ge/GoCicGnIgchUe4+u0PbCe1H
	/RT5H+tuNcOcWVLWvRYVuY3ncvZaVKtjRYo77Py1Q4/LfS5nfFCdACRH4H+vS0S0
	lyvsQcG8V9bdvgrfWZJFqISdi6RcwtId3RTuoaChnpfWY/RbtOka+oN2LIoVXrWv
	+Rr/r46o/WCuPcZN37CWuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738328144; x=
	1738414544; bh=EKb6EBgbHdoOYXDWWXZ9hP71nn6G4ttmlGyvxA19wlY=; b=O
	ApF9OPjhknpfkc3Y08TiuP6TJ5e8Jt8qdx6JJp0FZsp57vGVUITVahIupl0ZlrnY
	jpXoxQAv+khx0UXYDX//XdnmmIeIba7CRpwJGWxaxhpmQwVbL+5Eesyzmolm7CAF
	4kKkkUP/YG8UNPYRvhBn0MwDZm0LRwYzLRG39/occlvK5tsxhAK3jcfnqJhYDiGx
	99/jF1eCYTYYAS1w4+FT7HLQEiwPDyrRG1jlpGER9b4h9HojKjddkwOUsAFnw09a
	+b/DAj8bUUunLoHaonPnIDFqd+DfaTcfLTTYdkJ/WN/EN+AZv/5ANS09Se8B3p0j
	4z/WndoAU4vezaT5gJ3Yg==
X-ME-Sender: <xms:UMicZ4J9u2PD55Qmy0jRufefimGmKIWEGBOHcWXBAc9qT5KM6zIC0g>
    <xme:UMicZ4JYZaFltTiTZFehEEAHkSgKNQjpUFddVhTdVHHAbP6HZEL_-26fyizKr2odm
    z29S5EjM4pGNnDu-A>
X-ME-Received: <xmr:UMicZ4vT4xATH0YtC3MUJNSRRpWkujZrp47QjFb-SIrf2uN1Ikr5iCgVEvxlixX2ba4s8Mxm5voxrgPRt466jxZ9Yw1xI2DD93u6HK3FrJkwuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:UMicZ1ZgF7QFeWoo37L78E-UDFHeTjEQbn3ljJls1BiiWLbeJq8tfA>
    <xmx:UMicZ_YMDU4IalV9NMUZ6cgnC8hHTjywQFbmjQuUOKIy-bbKiHUz1Q>
    <xmx:UMicZxAl4rzl4mioOZWxuaZ4HocfC4PTD1wbsTkl72WCuIYoahHQMQ>
    <xmx:UMicZ1a58xZIRRT3ZrsVCA3QOqFle4sQNROJUpCy4_kNn3wH_TYIuQ>
    <xmx:UMicZ7EcJP94CYObwyi4JJp3OmWP_t12WJGCeafrykmsvdX10WUQTZOJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 07:55:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 32480738 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 12:55:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 13:55:31 +0100
Subject: [PATCH 4/4] global: adapt callers to use generic hash context
 helpers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-b4-pks-hash-context-direct-v1-4-67a6d3f49d6e@pks.im>
References: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
In-Reply-To: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Adapt callers to use generic hash context helpers instead of using the
hash algorithm to update them. This makes the callsites easier to reason
about and removes the possibility that the wrong hash algorithm is used
to update the hash context's state. And as a nice side effect this also
gets rid of a bunch of users of `the_hash_algo`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c      | 12 ++++++------
 builtin/index-pack.c       | 13 ++++++-------
 builtin/patch-id.c         | 12 ++++++------
 builtin/receive-pack.c     | 16 ++++++++--------
 builtin/unpack-objects.c   |  9 ++++-----
 bulk-checkin.c             |  6 +++---
 csum-file.c                | 14 +++++++-------
 diff.c                     | 24 ++++++++++++------------
 http-push.c                |  4 ++--
 http.c                     |  6 +++---
 object-file.c              | 32 +++++++++++++++-----------------
 pack-check.c               |  4 ++--
 pack-write.c               | 14 +++++++-------
 read-cache.c               | 14 +++++++-------
 rerere.c                   | 14 +++++++-------
 t/helper/test-hash-speed.c |  4 ++--
 t/helper/test-hash.c       |  4 ++--
 t/unit-tests/u-hash.c      |  4 ++--
 trace2/tr2_sid.c           |  4 ++--
 19 files changed, 103 insertions(+), 107 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9862704c62..91f88c467f 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -959,9 +959,9 @@ static int store_object(
 	hdrlen = format_object_header((char *)hdr, sizeof(hdr), type,
 				      dat->len);
 	the_hash_algo->init_fn(&c);
-	the_hash_algo->update_fn(&c, hdr, hdrlen);
-	the_hash_algo->update_fn(&c, dat->buf, dat->len);
-	the_hash_algo->final_oid_fn(&oid, &c);
+	git_hash_update(&c, hdr, hdrlen);
+	git_hash_update(&c, dat->buf, dat->len);
+	git_hash_final_oid(&oid, &c);
 	if (oidout)
 		oidcpy(oidout, &oid);
 
@@ -1113,7 +1113,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	hdrlen = format_object_header((char *)out_buf, out_sz, OBJ_BLOB, len);
 
 	the_hash_algo->init_fn(&c);
-	the_hash_algo->update_fn(&c, out_buf, hdrlen);
+	git_hash_update(&c, out_buf, hdrlen);
 
 	crc32_begin(pack_file);
 
@@ -1131,7 +1131,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 			if (!n && feof(stdin))
 				die("EOF in data (%" PRIuMAX " bytes remaining)", len);
 
-			the_hash_algo->update_fn(&c, in_buf, n);
+			git_hash_update(&c, in_buf, n);
 			s.next_in = in_buf;
 			s.avail_in = n;
 			len -= n;
@@ -1157,7 +1157,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		}
 	}
 	git_deflate_end(&s);
-	the_hash_algo->final_oid_fn(&oid, &c);
+	git_hash_final_oid(&oid, &c);
 
 	if (oidout)
 		oidcpy(oidout, &oid);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 40e49868b1..5ee13661a1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -301,7 +301,7 @@ static void flush(void)
 	if (input_offset) {
 		if (output_fd >= 0)
 			write_or_die(output_fd, input_buffer, input_offset);
-		the_hash_algo->update_fn(&input_ctx, input_buffer, input_offset);
+		git_hash_update(&input_ctx, input_buffer, input_offset);
 		memmove(input_buffer, input_buffer + input_offset, input_len);
 		input_offset = 0;
 	}
@@ -482,7 +482,7 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 	if (!is_delta_type(type)) {
 		hdrlen = format_object_header(hdr, sizeof(hdr), type, size);
 		the_hash_algo->init_fn(&c);
-		the_hash_algo->update_fn(&c, hdr, hdrlen);
+		git_hash_update(&c, hdr, hdrlen);
 	} else
 		oid = NULL;
 	if (type == OBJ_BLOB && size > big_file_threshold)
@@ -502,7 +502,7 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 		status = git_inflate(&stream, 0);
 		use(input_len - stream.avail_in);
 		if (oid)
-			the_hash_algo->update_fn(&c, last_out, stream.next_out - last_out);
+			git_hash_update(&c, last_out, stream.next_out - last_out);
 		if (buf == fixed_buf) {
 			stream.next_out = buf;
 			stream.avail_out = sizeof(fixed_buf);
@@ -512,7 +512,7 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 		bad_object(offset, _("inflate returned %d"), status);
 	git_inflate_end(&stream);
 	if (oid)
-		the_hash_algo->final_oid_fn(oid, &c);
+		git_hash_final_oid(oid, &c);
 	return buf == fixed_buf ? NULL : buf;
 }
 
@@ -1286,9 +1286,8 @@ static void parse_pack_objects(unsigned char *hash)
 
 	/* Check pack integrity */
 	flush();
-	the_hash_algo->init_fn(&tmp_ctx);
-	the_hash_algo->clone_fn(&tmp_ctx, &input_ctx);
-	the_hash_algo->final_fn(hash, &tmp_ctx);
+	git_hash_clone(&tmp_ctx, &input_ctx);
+	git_hash_final(hash, &tmp_ctx);
 	if (!hasheq(fill(the_hash_algo->rawsz), hash, the_repository->hash_algo))
 		die(_("pack is corrupted (SHA1 mismatch)"));
 	use(the_hash_algo->rawsz);
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 923ff2bb77..cdef2ec10a 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -85,7 +85,7 @@ static size_t get_one_patchid(struct object_id *next_oid, struct object_id *resu
 		    !skip_prefix(line, "From ", &p) &&
 		    starts_with(line, "\\ ") && 12 < strlen(line)) {
 			if (verbatim)
-				the_hash_algo->update_fn(&ctx, line, strlen(line));
+				git_hash_update(&ctx, line, strlen(line));
 			continue;
 		}
 
@@ -104,10 +104,10 @@ static size_t get_one_patchid(struct object_id *next_oid, struct object_id *resu
 			    starts_with(line, "Binary files")) {
 				diff_is_binary = 1;
 				before = 0;
-				the_hash_algo->update_fn(&ctx, pre_oid_str,
-							 strlen(pre_oid_str));
-				the_hash_algo->update_fn(&ctx, post_oid_str,
-							 strlen(post_oid_str));
+				git_hash_update(&ctx, pre_oid_str,
+						strlen(pre_oid_str));
+				git_hash_update(&ctx, post_oid_str,
+						strlen(post_oid_str));
 				if (stable)
 					flush_one_hunk(result, &ctx);
 				continue;
@@ -165,7 +165,7 @@ static size_t get_one_patchid(struct object_id *next_oid, struct object_id *resu
 		/* Add line to hash algo (possibly removing whitespace) */
 		len = verbatim ? strlen(line) : remove_space(line);
 		patchlen += len;
-		the_hash_algo->update_fn(&ctx, line, len);
+		git_hash_update(&ctx, line, len);
 	}
 
 	if (!found_next)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d2360c453c..cc358600ca 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -572,8 +572,8 @@ static void hmac_hash(unsigned char *out,
 	memset(key, '\0', GIT_MAX_BLKSZ);
 	if (the_hash_algo->blksz < key_len) {
 		the_hash_algo->init_fn(&ctx);
-		the_hash_algo->update_fn(&ctx, key_in, key_len);
-		the_hash_algo->final_fn(key, &ctx);
+		git_hash_update(&ctx, key_in, key_len);
+		git_hash_final(key, &ctx);
 	} else {
 		memcpy(key, key_in, key_len);
 	}
@@ -586,15 +586,15 @@ static void hmac_hash(unsigned char *out,
 
 	/* RFC 2104 2. (3) & (4) */
 	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, k_ipad, sizeof(k_ipad));
-	the_hash_algo->update_fn(&ctx, text, text_len);
-	the_hash_algo->final_fn(out, &ctx);
+	git_hash_update(&ctx, k_ipad, sizeof(k_ipad));
+	git_hash_update(&ctx, text, text_len);
+	git_hash_final(out, &ctx);
 
 	/* RFC 2104 2. (6) & (7) */
 	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, k_opad, sizeof(k_opad));
-	the_hash_algo->update_fn(&ctx, out, the_hash_algo->rawsz);
-	the_hash_algo->final_fn(out, &ctx);
+	git_hash_update(&ctx, k_opad, sizeof(k_opad));
+	git_hash_update(&ctx, out, the_hash_algo->rawsz);
+	git_hash_final(out, &ctx);
 }
 
 static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index d72885510c..8383bcf404 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -70,7 +70,7 @@ static void *fill(int min)
 	if (min > sizeof(buffer))
 		die("cannot fill %d bytes", min);
 	if (offset) {
-		the_hash_algo->update_fn(&ctx, buffer, offset);
+		git_hash_update(&ctx, buffer, offset);
 		memmove(buffer, buffer + offset, len);
 		offset = 0;
 	}
@@ -667,10 +667,9 @@ int cmd_unpack_objects(int argc,
 	}
 	the_hash_algo->init_fn(&ctx);
 	unpack_all();
-	the_hash_algo->update_fn(&ctx, buffer, offset);
-	the_hash_algo->init_fn(&tmp_ctx);
-	the_hash_algo->clone_fn(&tmp_ctx, &ctx);
-	the_hash_algo->final_oid_fn(&oid, &tmp_ctx);
+	git_hash_update(&ctx, buffer, offset);
+	git_hash_clone(&tmp_ctx, &ctx);
+	git_hash_final_oid(&oid, &tmp_ctx);
 	if (strict) {
 		write_rest();
 		if (fsck_finish(&fsck_options))
diff --git a/bulk-checkin.c b/bulk-checkin.c
index db1958b525..0f40c5dac9 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -194,7 +194,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 				if (rsize < hsize)
 					hsize = rsize;
 				if (hsize)
-					the_hash_algo->update_fn(ctx, ibuf, hsize);
+					git_hash_update(ctx, ibuf, hsize);
 				*already_hashed_to = offset;
 			}
 			s.next_in = ibuf;
@@ -271,7 +271,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  OBJ_BLOB, size);
 	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, obuf, header_len);
+	git_hash_update(&ctx, obuf, header_len);
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & HASH_WRITE_OBJECT) != 0) {
@@ -306,7 +306,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
-	the_hash_algo->final_oid_fn(result_oid, &ctx);
+	git_hash_final_oid(result_oid, &ctx);
 	if (!idx)
 		return 0;
 
diff --git a/csum-file.c b/csum-file.c
index 3383515669..5c54b3a0b9 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -50,7 +50,7 @@ void hashflush(struct hashfile *f)
 
 	if (offset) {
 		if (!f->skip_hash)
-			f->algop->update_fn(&f->ctx, f->buffer, offset);
+			git_hash_update(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -73,7 +73,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	if (f->skip_hash)
 		hashclr(f->buffer, f->algop);
 	else
-		f->algop->final_fn(f->buffer, &f->ctx);
+		git_hash_final(f->buffer, &f->ctx);
 
 	if (result)
 		hashcpy(result, f->buffer, f->algop);
@@ -128,7 +128,7 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * f->offset is necessarily zero.
 			 */
 			if (!f->skip_hash)
-				f->algop->update_fn(&f->ctx, buf, nr);
+				git_hash_update(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -217,7 +217,7 @@ void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpo
 {
 	hashflush(f);
 	checkpoint->offset = f->total;
-	f->algop->clone_fn(&checkpoint->ctx, &f->ctx);
+	git_hash_clone(&checkpoint->ctx, &f->ctx);
 }
 
 int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
@@ -228,7 +228,7 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
 	    lseek(f->fd, offset, SEEK_SET) != offset)
 		return -1;
 	f->total = offset;
-	f->algop->clone_fn(&f->ctx, &checkpoint->ctx);
+	git_hash_clone(&f->ctx, &checkpoint->ctx);
 	f->offset = 0; /* hashflush() was called in checkpoint */
 	return 0;
 }
@@ -256,8 +256,8 @@ int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 		return 0; /* say "too short"? */
 
 	algop->init_fn(&ctx);
-	algop->update_fn(&ctx, data, data_len);
-	algop->final_fn(got, &ctx);
+	git_hash_update(&ctx, data, data_len);
+	git_hash_final(got, &ctx);
 
 	return hasheq(got, data + data_len, algop);
 }
diff --git a/diff.c b/diff.c
index 7f570ebdf9..019fb893a7 100644
--- a/diff.c
+++ b/diff.c
@@ -6415,7 +6415,7 @@ void flush_one_hunk(struct object_id *result, struct git_hash_ctx *ctx)
 	unsigned short carry = 0;
 	int i;
 
-	the_hash_algo->final_fn(hash, ctx);
+	git_hash_final(hash, ctx);
 	the_hash_algo->init_fn(ctx);
 	/* 20-byte sum, with carry */
 	for (i = 0; i < the_hash_algo->rawsz; ++i) {
@@ -6434,14 +6434,14 @@ static int patch_id_consume(void *priv, char *line, unsigned long len)
 		return 0;
 	new_len = remove_space(line, len);
 
-	the_hash_algo->update_fn(data->ctx, line, new_len);
+	git_hash_update(data->ctx, line, new_len);
 	data->patchlen += new_len;
 	return 0;
 }
 
 static void patch_id_add_string(struct git_hash_ctx *ctx, const char *str)
 {
-	the_hash_algo->update_fn(ctx, str, strlen(str));
+	git_hash_update(ctx, str, strlen(str));
 }
 
 static void patch_id_add_mode(struct git_hash_ctx *ctx, unsigned mode)
@@ -6449,7 +6449,7 @@ static void patch_id_add_mode(struct git_hash_ctx *ctx, unsigned mode)
 	/* large enough for 2^32 in octal */
 	char buf[12];
 	int len = xsnprintf(buf, sizeof(buf), "%06o", mode);
-	the_hash_algo->update_fn(ctx, buf, len);
+	git_hash_update(ctx, buf, len);
 }
 
 /* returns 0 upon success, and writes result into oid */
@@ -6493,9 +6493,9 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		len2 = remove_space(p->two->path, strlen(p->two->path));
 		patch_id_add_string(&ctx, "diff--git");
 		patch_id_add_string(&ctx, "a/");
-		the_hash_algo->update_fn(&ctx, p->one->path, len1);
+		git_hash_update(&ctx, p->one->path, len1);
 		patch_id_add_string(&ctx, "b/");
-		the_hash_algo->update_fn(&ctx, p->two->path, len2);
+		git_hash_update(&ctx, p->two->path, len2);
 
 		if (p->one->mode == 0) {
 			patch_id_add_string(&ctx, "newfilemode");
@@ -6514,24 +6514,24 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 			/* don't do anything since we're only populating header info */
 		} else if (diff_filespec_is_binary(options->repo, p->one) ||
 		    diff_filespec_is_binary(options->repo, p->two)) {
-			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->one->oid),
+			git_hash_update(&ctx, oid_to_hex(&p->one->oid),
 					the_hash_algo->hexsz);
-			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->two->oid),
+			git_hash_update(&ctx, oid_to_hex(&p->two->oid),
 					the_hash_algo->hexsz);
 		} else {
 			if (p->one->mode == 0) {
 				patch_id_add_string(&ctx, "---/dev/null");
 				patch_id_add_string(&ctx, "+++b/");
-				the_hash_algo->update_fn(&ctx, p->two->path, len2);
+				git_hash_update(&ctx, p->two->path, len2);
 			} else if (p->two->mode == 0) {
 				patch_id_add_string(&ctx, "---a/");
-				the_hash_algo->update_fn(&ctx, p->one->path, len1);
+				git_hash_update(&ctx, p->one->path, len1);
 				patch_id_add_string(&ctx, "+++/dev/null");
 			} else {
 				patch_id_add_string(&ctx, "---a/");
-				the_hash_algo->update_fn(&ctx, p->one->path, len1);
+				git_hash_update(&ctx, p->one->path, len1);
 				patch_id_add_string(&ctx, "+++b/");
-				the_hash_algo->update_fn(&ctx, p->two->path, len2);
+				git_hash_update(&ctx, p->two->path, len2);
 			}
 
 			if (fill_mmfile(options->repo, &mf1, p->one) < 0 ||
diff --git a/http-push.c b/http-push.c
index 36867af2f8..1b030d96f4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -774,8 +774,8 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 			lock->token = xstrdup(ctx->cdata);
 
 			the_hash_algo->init_fn(&hash_ctx);
-			the_hash_algo->update_fn(&hash_ctx, lock->token, strlen(lock->token));
-			the_hash_algo->final_fn(lock_token_hash, &hash_ctx);
+			git_hash_update(&hash_ctx, lock->token, strlen(lock->token));
+			git_hash_final(lock_token_hash, &hash_ctx);
 
 			lock->tmpfile_suffix[0] = '_';
 			memcpy(lock->tmpfile_suffix + 1, hash_to_hex(lock_token_hash), the_hash_algo->hexsz);
diff --git a/http.c b/http.c
index f08b2ae474..f4504133e8 100644
--- a/http.c
+++ b/http.c
@@ -2597,8 +2597,8 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 		freq->stream.next_out = expn;
 		freq->stream.avail_out = sizeof(expn);
 		freq->zret = git_inflate(&freq->stream, Z_SYNC_FLUSH);
-		the_hash_algo->update_fn(&freq->c, expn,
-					 sizeof(expn) - freq->stream.avail_out);
+		git_hash_update(&freq->c, expn,
+				sizeof(expn) - freq->stream.avail_out);
 	} while (freq->stream.avail_in && freq->zret == Z_OK);
 	return nmemb;
 }
@@ -2763,7 +2763,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		return -1;
 	}
 
-	the_hash_algo->final_oid_fn(&freq->real_oid, &freq->c);
+	git_hash_final_oid(&freq->real_oid, &freq->c);
 	if (freq->zret != Z_STREAM_END) {
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
diff --git a/object-file.c b/object-file.c
index b7f2af515f..00c3a4b910 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1199,7 +1199,7 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 
 	/* Sha1.. */
 	r->hash_algo->init_fn(&c);
-	r->hash_algo->update_fn(&c, hdr, hdrlen);
+	git_hash_update(&c, hdr, hdrlen);
 	for (;;) {
 		char buf[1024 * 16];
 		ssize_t readlen = read_istream(st, buf, sizeof(buf));
@@ -1210,9 +1210,9 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 		}
 		if (!readlen)
 			break;
-		r->hash_algo->update_fn(&c, buf, readlen);
+		git_hash_update(&c, buf, readlen);
 	}
-	r->hash_algo->final_oid_fn(&real_oid, &c);
+	git_hash_final_oid(&real_oid, &c);
 	close_istream(st);
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
@@ -1957,9 +1957,9 @@ static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_c
 			     char *hdr, int *hdrlen)
 {
 	algo->init_fn(c);
-	algo->update_fn(c, hdr, *hdrlen);
-	algo->update_fn(c, buf, len);
-	algo->final_oid_fn(oid, c);
+	git_hash_update(c, hdr, *hdrlen);
+	git_hash_update(c, buf, len);
+	git_hash_final_oid(oid, c);
 }
 
 static void write_object_file_prepare(const struct git_hash_algo *algo,
@@ -2246,9 +2246,9 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 	stream->avail_in = hdrlen;
 	while (git_deflate(stream, 0) == Z_OK)
 		; /* nothing */
-	algo->update_fn(c, hdr, hdrlen);
+	git_hash_update(c, hdr, hdrlen);
 	if (compat && compat_c)
-		compat->update_fn(compat_c, hdr, hdrlen);
+		git_hash_update(compat_c, hdr, hdrlen);
 
 	return fd;
 }
@@ -2264,14 +2264,13 @@ static int write_loose_object_common(struct git_hash_ctx *c, struct git_hash_ctx
 				     const size_t compressed_len)
 {
 	struct repository *repo = the_repository;
-	const struct git_hash_algo *algo = repo->hash_algo;
 	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	int ret;
 
 	ret = git_deflate(stream, flush ? Z_FINISH : 0);
-	algo->update_fn(c, in0, stream->next_in - in0);
+	git_hash_update(c, in0, stream->next_in - in0);
 	if (compat && compat_c)
-		compat->update_fn(compat_c, in0, stream->next_in - in0);
+		git_hash_update(compat_c, in0, stream->next_in - in0);
 	if (write_in_full(fd, compressed, stream->next_out - compressed) < 0)
 		die_errno(_("unable to write loose object file"));
 	stream->next_out = compressed;
@@ -2291,16 +2290,15 @@ static int end_loose_object_common(struct git_hash_ctx *c, struct git_hash_ctx *
 				   struct object_id *compat_oid)
 {
 	struct repository *repo = the_repository;
-	const struct git_hash_algo *algo = repo->hash_algo;
 	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	int ret;
 
 	ret = git_deflate_end_gently(stream);
 	if (ret != Z_OK)
 		return ret;
-	algo->final_oid_fn(oid, c);
+	git_hash_final_oid(oid, c);
 	if (compat && compat_c)
-		compat->final_oid_fn(compat_oid, compat_c);
+		git_hash_final_oid(compat_oid, compat_c);
 
 	return Z_OK;
 }
@@ -3059,7 +3057,7 @@ static int check_stream_oid(git_zstream *stream,
 	int status = Z_OK;
 
 	the_hash_algo->init_fn(&c);
-	the_hash_algo->update_fn(&c, hdr, stream->total_out);
+	git_hash_update(&c, hdr, stream->total_out);
 
 	/*
 	 * We already read some bytes into hdr, but the ones up to the NUL
@@ -3079,7 +3077,7 @@ static int check_stream_oid(git_zstream *stream,
 		if (size - total_read < stream->avail_out)
 			stream->avail_out = size - total_read;
 		status = git_inflate(stream, Z_FINISH);
-		the_hash_algo->update_fn(&c, buf, stream->next_out - buf);
+		git_hash_update(&c, buf, stream->next_out - buf);
 		total_read += stream->next_out - buf;
 	}
 	git_inflate_end(stream);
@@ -3094,7 +3092,7 @@ static int check_stream_oid(git_zstream *stream,
 		return -1;
 	}
 
-	the_hash_algo->final_oid_fn(&real_oid, &c);
+	git_hash_final_oid(&real_oid, &c);
 	if (!oideq(expected_oid, &real_oid)) {
 		error(_("hash mismatch for %s (expected %s)"), path,
 		      oid_to_hex(expected_oid));
diff --git a/pack-check.c b/pack-check.c
index f20209fccb..d0aeb5ec41 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -77,9 +77,9 @@ static int verify_packfile(struct repository *r,
 			pack_sig_ofs = p->pack_size - r->hash_algo->rawsz;
 		if (offset > pack_sig_ofs)
 			remaining -= (unsigned int)(offset - pack_sig_ofs);
-		r->hash_algo->update_fn(&ctx, in, remaining);
+		git_hash_update(&ctx, in, remaining);
 	} while (offset < pack_sig_ofs);
-	r->hash_algo->final_fn(hash, &ctx);
+	git_hash_final(hash, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
 	if (!hasheq(hash, pack_sig, the_repository->hash_algo))
 		err = error("%s pack checksum mismatch",
diff --git a/pack-write.c b/pack-write.c
index 9004d1d095..cfcb7297b8 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -406,9 +406,9 @@ void fixup_pack_header_footer(int pack_fd,
 			  pack_name);
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
-	the_hash_algo->update_fn(&old_hash_ctx, &hdr, sizeof(hdr));
+	git_hash_update(&old_hash_ctx, &hdr, sizeof(hdr));
 	hdr.hdr_entries = htonl(object_count);
-	the_hash_algo->update_fn(&new_hash_ctx, &hdr, sizeof(hdr));
+	git_hash_update(&new_hash_ctx, &hdr, sizeof(hdr));
 	write_or_die(pack_fd, &hdr, sizeof(hdr));
 	partial_pack_offset -= sizeof(hdr);
 
@@ -423,7 +423,7 @@ void fixup_pack_header_footer(int pack_fd,
 			break;
 		if (n < 0)
 			die_errno("Failed to checksum '%s'", pack_name);
-		the_hash_algo->update_fn(&new_hash_ctx, buf, n);
+		git_hash_update(&new_hash_ctx, buf, n);
 
 		aligned_sz -= n;
 		if (!aligned_sz)
@@ -432,11 +432,11 @@ void fixup_pack_header_footer(int pack_fd,
 		if (!partial_pack_hash)
 			continue;
 
-		the_hash_algo->update_fn(&old_hash_ctx, buf, n);
+		git_hash_update(&old_hash_ctx, buf, n);
 		partial_pack_offset -= n;
 		if (partial_pack_offset == 0) {
 			unsigned char hash[GIT_MAX_RAWSZ];
-			the_hash_algo->final_fn(hash, &old_hash_ctx);
+			git_hash_final(hash, &old_hash_ctx);
 			if (!hasheq(hash, partial_pack_hash,
 				    the_repository->hash_algo))
 				die("Unexpected checksum for %s "
@@ -454,8 +454,8 @@ void fixup_pack_header_footer(int pack_fd,
 	free(buf);
 
 	if (partial_pack_hash)
-		the_hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
-	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
+		git_hash_final(partial_pack_hash, &old_hash_ctx);
+	git_hash_final(new_pack_hash, &new_hash_ctx);
 	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
diff --git a/read-cache.c b/read-cache.c
index 5e765d9af5..7ef01c3806 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1739,8 +1739,8 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 		return 0;
 
 	the_hash_algo->init_fn(&c);
-	the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
-	the_hash_algo->final_fn(hash, &c);
+	git_hash_update(&c, hdr, size - the_hash_algo->rawsz);
+	git_hash_final(hash, &c);
 	if (!hasheq(hash, start, the_repository->hash_algo))
 		return error(_("bad index file sha1 signature"));
 	return 0;
@@ -2576,8 +2576,8 @@ static int write_index_ext_header(struct hashfile *f,
 	if (eoie_f) {
 		ext = htonl(ext);
 		sz = htonl(sz);
-		the_hash_algo->update_fn(eoie_f, &ext, sizeof(ext));
-		the_hash_algo->update_fn(eoie_f, &sz, sizeof(sz));
+		git_hash_update(eoie_f, &ext, sizeof(ext));
+		git_hash_update(eoie_f, &sz, sizeof(sz));
 	}
 	return 0;
 }
@@ -3634,12 +3634,12 @@ static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
 		if (src_offset + 8 + extsize < src_offset)
 			return 0;
 
-		the_hash_algo->update_fn(&c, mmap + src_offset, 8);
+		git_hash_update(&c, mmap + src_offset, 8);
 
 		src_offset += 8;
 		src_offset += extsize;
 	}
-	the_hash_algo->final_fn(hash, &c);
+	git_hash_final(hash, &c);
 	if (!hasheq(hash, (const unsigned char *)index, the_repository->hash_algo))
 		return 0;
 
@@ -3660,7 +3660,7 @@ static void write_eoie_extension(struct strbuf *sb, struct git_hash_ctx *eoie_co
 	strbuf_add(sb, &buffer, sizeof(uint32_t));
 
 	/* hash */
-	the_hash_algo->final_fn(hash, eoie_context);
+	git_hash_final(hash, eoie_context);
 	strbuf_add(sb, hash, the_hash_algo->rawsz);
 }
 
diff --git a/rerere.c b/rerere.c
index 5ff9624b57..c42cee618b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -396,12 +396,12 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
 			strbuf_addbuf(out, &two);
 			rerere_strbuf_putconflict(out, '>', marker_size);
 			if (ctx) {
-				the_hash_algo->update_fn(ctx, one.buf ?
-							 one.buf : "",
-							 one.len + 1);
-				the_hash_algo->update_fn(ctx, two.buf ?
-							 two.buf : "",
-							 two.len + 1);
+				git_hash_update(ctx, one.buf ?
+						one.buf : "",
+						one.len + 1);
+				git_hash_update(ctx, two.buf ?
+						two.buf : "",
+						two.len + 1);
 			}
 			break;
 		} else if (hunk == RR_SIDE_1)
@@ -453,7 +453,7 @@ static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_siz
 	strbuf_release(&out);
 
 	if (hash)
-		the_hash_algo->final_fn(hash, &ctx);
+		git_hash_final(hash, &ctx);
 
 	return has_conflicts;
 }
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index 803f41c89d..fbf67fe6bd 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -6,8 +6,8 @@
 static inline void compute_hash(const struct git_hash_algo *algo, struct git_hash_ctx *ctx, uint8_t *final, const void *p, size_t len)
 {
 	algo->init_fn(ctx);
-	algo->update_fn(ctx, p, len);
-	algo->final_fn(final, ctx);
+	git_hash_update(ctx, p, len);
+	git_hash_final(final, ctx);
 }
 
 int cmd__hash_speed(int ac, const char **av)
diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index f9a3db487a..f0ee61c8b4 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -48,9 +48,9 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 		}
 		if (this_sz == 0)
 			break;
-		algop->update_fn(&ctx, buffer, this_sz);
+		git_hash_update(&ctx, buffer, this_sz);
 	}
-	algop->final_fn(hash, &ctx);
+	git_hash_final(hash, &ctx);
 
 	if (binary)
 		fwrite(hash, 1, algop->rawsz, stdout);
diff --git a/t/unit-tests/u-hash.c b/t/unit-tests/u-hash.c
index 05204e7b6c..bd4ac6a6e1 100644
--- a/t/unit-tests/u-hash.c
+++ b/t/unit-tests/u-hash.c
@@ -13,8 +13,8 @@ static void check_hash_data(const void *data, size_t data_length,
 		const struct git_hash_algo *algop = &hash_algos[i];
 
 		algop->init_fn(&ctx);
-		algop->update_fn(&ctx, data, data_length);
-		algop->final_fn(hash, &ctx);
+		git_hash_update(&ctx, data, data_length);
+		git_hash_final(hash, &ctx);
 
 		cl_assert_equal_s(hash_to_hex_algop(hash,algop), expected_hashes[i - 1]);
 	}
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index c42696ef52..1c1d27b0ee 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -46,8 +46,8 @@ static void tr2_sid_append_my_sid_component(void)
 		strbuf_add(&tr2sid_buf, "Localhost", 9);
 	else {
 		algo->init_fn(&ctx);
-		algo->update_fn(&ctx, hostname, strlen(hostname));
-		algo->final_fn(hash, &ctx);
+		git_hash_update(&ctx, hostname, strlen(hostname));
+		git_hash_final(hash, &ctx);
 		hash_to_hex_algop_r(hex, hash, algo);
 		strbuf_addch(&tr2sid_buf, 'H');
 		strbuf_add(&tr2sid_buf, hex, 8);

-- 
2.48.1.502.g6dc24dfdaf.dirty

