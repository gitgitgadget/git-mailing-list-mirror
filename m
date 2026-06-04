Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F94409606
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570286; cv=none; b=sYIk3MXtXdRF04tpTQn8QBwJx6wicmNlayzjo+W6Quoa4o2NGUJiiV13BC+2JUW/rXjpWPSqPil3fAw2rrWJj03evFgIio80v8i/1ho4EHUI0WhVqObyG9lttBtj56zaSoqrBupa7cIMsTQh0rL2O5aY9BoR/HYgqZC8zV9KVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570286; c=relaxed/simple;
	bh=kOEhHbaJSui/w5Y/zOdzp4ARrD6/S3+JVw/cTFmQPqA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Hk0+srGg8HdI84OJTqvwTdL+ZBtKMrVJmwWZHlyvoyvRMisqMDAEJ1+Vi2g11ieTaEvxWtyak74WX5S9sp4/e89ABkvmdj/AraZvkRCksiGf0crlH3v7yKh0zFgQll8+u24xONl9IscBWC/s5MBz1OVk4TF7rxmJu/AoNZJoKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjq42GLT; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjq42GLT"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-137dd3af345so503877c88.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780570284; x=1781175084; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwHXtMhN1ebxigEsR6OZydX/TUUP6ntIyyu67U8Qc78=;
        b=Pjq42GLTkVyTSTS8ZSoQNINCfLDtrIAxTydZBgNbZehHdTId3HNd9mLDWc4nMjksdr
         WXGl6/YczVpz4plYqr1uFpq7N5OS1BjzxXj0a0OE5DQWq4rXHJarHbeAJWAlkrhEha6+
         ktE7UmlmkkFR8uSkzdlVL2irlM6UgYqfgaYD408Kdp3IoeOfqjar2kTefrhUEPcyQ7I0
         5KLpDLJFnGqrhbm/YXABlXxcLEVOaJL7la2AVO+F80N/ZVBeU6AI+xsmxO7mOMhCM7m/
         o5sL/nhmIfX/lRa4Q/CDETljr6YDbVEIr+LH7w++UsH5CGYb6F5cUOgo5/mlJMfna2XE
         eFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570284; x=1781175084;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PwHXtMhN1ebxigEsR6OZydX/TUUP6ntIyyu67U8Qc78=;
        b=nMftBGqFtbmDbE4cVysl+EkAP3oQ+aMPfxh5k7xBPtGZvEihckXRe/P6WWJpRUH+sf
         vtsfc59Fm23pt4fa5GC3aW2KytBSEpq12pPToBdycp8o4soo9PS88sqkAdvw6msPP/pZ
         NDfx/VVtL8CB/wNNSsDV/DY3cPPD57xT53RmS5LBNsVD99vFfJXO5jMEMYUVPUfSHVSc
         K9BGnz4KZqjUVrkpwWfwFwkLJ2bNExb7S7RYO84f+EBNJM1rUxTwgVRCkmm37q+3BtcE
         /D4flXdaRlwBySt5Bn0xQSuie8LXc8pbMxtvQdDuxeRYPBjU610Dx7vPILjRT/sF2C/Q
         pESA==
X-Gm-Message-State: AOJu0Yx1QPYzub3X6uTxMJF7QzOR/NfMy5+kUA4+sr9oIU/esMTHjqH7
	M4nerPmCHjN6l1p8L65EQiyAqY9ka1Hap84WBATCf7k3FVbceWytAdu30sJkfw==
X-Gm-Gg: Acq92OEkeNHYryBaa1GQ3JdhTJnKBLrl3UMySp/gVjtb0AeREMJYdI4YTM5DEDsRxmV
	abnjB2BVr5ctpWP7o+2K1L0QYd/Z/co3EhCevlJ1/oPu4MvP57mea+nNQVlQtI8FaZXu+z3n/T2
	wHmEb3VU3+2KR0kzZEgdyaODKDuXwXIt6fZKFsfcejxGdGI0ST1F3NTklfRknOm138xM9/aKU0t
	MWNwXg+o3KvmssQ9+Gxa7dfm/YzbdwcHi0vj3StGntZKhH98Zj8dkbKws362g+93f5hCT754P47
	dBcoGv70oU1c/c1apDaeWPAJhzKYHEXl5jeH9+jxg3zbKz55P3RadnAk4XdtmyTckhzPhlLfpug
	qelSxCYJLKtZGCUGAm8uvumodYcjopWdv/7vw951i5k1TeIt3O5aDMlELfEMJABkcQmKxMGzB92
	0X9ZRsldykhz24mireQD7hyDb9RV//3hTATt+E9w==
X-Received: by 2002:a05:7022:497:b0:136:d237:b42f with SMTP id a92af1059eb24-137f6c2ff84mr3097676c88.32.1780570284279;
        Thu, 04 Jun 2026 03:51:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.209.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f554fbc3sm3278706c88.13.2026.06.04.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:51:22 -0700 (PDT)
Message-Id: <68750ba2d112073b2f3bd2998ee01a4cdd2fb904.1780570273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 10:51:10 +0000
Subject: [PATCH 5/7] pack-objects: use size_t for in-core object sizes
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

`pack-objects` stores per-entry object sizes in either the 31-bit
`size_` member of the `struct object_entry` or, when the value does not
fit, the `pack->delta_size[]` spill array.  The accessors (`oe_size`,
`oe_delta_size`, `oe_get_size_slow`, `oe_size_*_than`) and the setters
(`oe_set_size`, `oe_set_delta_size`) used `unsigned long` for the spill
type, which on Windows means the spill silently caps at 4 GiB per entry.
That is what made `upload-pack` die with "object too large to read on
this platform" when serving the >4 GiB blob in `t5608` tests 5 and 6
when run with `GIT_TEST_CLONE_2GB`.

Widen them all to `size_t` (including `pack->delta_size`) and drop the
three `cast_size_t_to_ulong()` calls in `check_object()` that guarded
`in_pack_size`.  The two `SET_SIZE(entry, canonical_size)` calls in the
same function stay cast-free as before, since `canonical_size` is still
`unsigned long` until a later commit widens `object_info::sizep`.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 35 ++++++++++++++++++-----------------
 pack-objects.h         |  2 +-
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 975f04d699..bb372d0b03 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -66,8 +66,8 @@ static inline struct object_entry *oe_delta(
 		return &pack->objects[e->delta_idx - 1];
 }
 
-static inline unsigned long oe_delta_size(struct packing_data *pack,
-					  const struct object_entry *e)
+static inline size_t oe_delta_size(struct packing_data *pack,
+				   const struct object_entry *e)
 {
 	if (e->delta_size_valid)
 		return e->delta_size_;
@@ -83,11 +83,11 @@ static inline unsigned long oe_delta_size(struct packing_data *pack,
 	return pack->delta_size[e - pack->objects];
 }
 
-unsigned long oe_get_size_slow(struct packing_data *pack,
-			       const struct object_entry *e);
+size_t oe_get_size_slow(struct packing_data *pack,
+			const struct object_entry *e);
 
-static inline unsigned long oe_size(struct packing_data *pack,
-				    const struct object_entry *e)
+static inline size_t oe_size(struct packing_data *pack,
+			     const struct object_entry *e)
 {
 	if (e->size_valid)
 		return e->size_;
@@ -145,7 +145,7 @@ static inline void oe_set_delta_sibling(struct packing_data *pack,
 
 static inline void oe_set_size(struct packing_data *pack,
 			       struct object_entry *e,
-			       unsigned long size)
+			       size_t size)
 {
 	if (size < pack->oe_size_limit) {
 		e->size_ = size;
@@ -159,7 +159,7 @@ static inline void oe_set_size(struct packing_data *pack,
 
 static inline void oe_set_delta_size(struct packing_data *pack,
 				     struct object_entry *e,
-				     unsigned long size)
+				     size_t size)
 {
 	if (size < pack->oe_delta_size_limit) {
 		e->delta_size_ = size;
@@ -496,7 +496,7 @@ static void copy_pack_data(struct hashfile *f,
 
 static inline int oe_size_greater_than(struct packing_data *pack,
 				       const struct object_entry *lhs,
-				       unsigned long rhs)
+				       size_t rhs)
 {
 	if (lhs->size_valid)
 		return lhs->size_ > rhs;
@@ -2277,7 +2277,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		default:
 			/* Not a delta hence we've already got all we need. */
 			oe_set_type(entry, entry->in_pack_type);
-			SET_SIZE(entry, cast_size_t_to_ulong(in_pack_size));
+			SET_SIZE(entry, in_pack_size);
 			entry->in_pack_header_size = used;
 			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
@@ -2331,8 +2331,8 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		if (have_base &&
 		    can_reuse_delta(&base_ref, entry, &base_entry)) {
 			oe_set_type(entry, entry->in_pack_type);
-			SET_SIZE(entry, cast_size_t_to_ulong(in_pack_size)); /* delta size */
-			SET_DELTA_SIZE(entry, cast_size_t_to_ulong(in_pack_size));
+			SET_SIZE(entry, in_pack_size); /* delta size */
+			SET_DELTA_SIZE(entry, in_pack_size);
 
 			if (base_entry) {
 				SET_DELTA(entry, base_entry);
@@ -2355,7 +2355,8 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 			 * object size from the delta header.
 			 */
 			delta_pos = entry->in_pack_offset + entry->in_pack_header_size;
-			canonical_size = get_size_from_delta(p, &w_curs, delta_pos);
+			canonical_size = get_size_from_delta(p, &w_curs,
+							     delta_pos);
 			if (canonical_size == 0)
 				goto give_up;
 			SET_SIZE(entry, canonical_size);
@@ -2711,7 +2712,7 @@ static pthread_mutex_t progress_mutex;
 
 static inline int oe_size_less_than(struct packing_data *pack,
 				    const struct object_entry *lhs,
-				    unsigned long rhs)
+				    size_t rhs)
 {
 	if (lhs->size_valid)
 		return lhs->size_ < rhs;
@@ -2734,8 +2735,8 @@ static inline void oe_set_tree_depth(struct packing_data *pack,
  * reconstruction (so non-deltas are true object sizes, but deltas
  * return the size of the delta data).
  */
-unsigned long oe_get_size_slow(struct packing_data *pack,
-			       const struct object_entry *e)
+size_t oe_get_size_slow(struct packing_data *pack,
+			const struct object_entry *e)
 {
 	struct packed_git *p;
 	struct pack_window *w_curs;
@@ -2769,7 +2770,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 
 	unuse_pack(&w_curs);
 	packing_data_unlock(&to_pack);
-	return cast_size_t_to_ulong(size);
+	return size;
 }
 
 static int try_delta(struct unpacked *trg, struct unpacked *src,
diff --git a/pack-objects.h b/pack-objects.h
index 83299d4732..e97e84ddcb 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -141,7 +141,7 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
-	unsigned long *delta_size;
+	size_t *delta_size;
 
 	/*
 	 * Only one of these can be non-NULL and they have different
-- 
gitgitgadget

