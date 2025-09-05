Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF7F280A5F
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100390; cv=none; b=hoW7uUCgUQrzQbifE2djIOsyGfzAiiTquy2h0BpqoOPidUz0Ce+eQkhpyxbuUMdktLRGmG/B86wZQaTAEdKnaJoln0J4dYqDn+HnM+qUU02VKytePrEMKOVIIAr9LHA3n9UYfAXGyCLBEw9FO5u+joRPSQG8ycGYq2cu7jNNkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100390; c=relaxed/simple;
	bh=l40ndDw+DKrP/+6g0b0mLAidZjbr+PnpIzIehZoebXE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pVmy3r1iJraXCiWgAhQE9dl6lEpeqUAn2h8h1L83bbiDtdk5ejs2g8Oo5SLuwFR7+cst2P4xIf0Pggo3LEGMaAMh1b5mRcBpPR8MzzNvRlWUqt/DbRIAJpbYGbIQUMO+904y7JwuN7Of5ZEXX016vHNhz10Zvo//pQWQ1J2ASCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivoqnDOy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivoqnDOy"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47175d02dcso1981455a12.3
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757100386; x=1757705186; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2Aicuqtz6vKwzuCYP+TMDlq23U8VQGcsB4/2dnbuMI=;
        b=ivoqnDOysmVloBkCszq7wvsKcPJdrdsUUZSXvENUTvRDd3RD7ZdN0QKFfZDjbrJKlE
         Cz29Bl4LWuTjiSbPB1KjJ7x83VYb8OJtlpa7dlrGhYDF+c6+X3W98GFf5mOTRGI1VQjn
         mUpEZOVZNr8KrsZJQhU5uGu5Fo1sYzhh5Mp1GiNIsJjjr4/I7PX2C9NVbIvcDFOuV1XV
         fGVRxIkTZFTHW85E6XTOo7kh35NaPRcS7KcdqIFdztui3GJ7h1EJzotvszSsFMGXt53f
         RzH1EsCn2jjHOFcXOBPPBMiqniHcn+qT3xewRiWk1JVVgutDuqjzdLu0pGB5MEVPMFPE
         KN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100386; x=1757705186;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2Aicuqtz6vKwzuCYP+TMDlq23U8VQGcsB4/2dnbuMI=;
        b=G+jVlujuS83KUeBnbe+1WeV1OOyl37B1wqkvNndxYjXUZYN3CK+QHXsBPN0/Go/gO1
         J4qmOAUaZvXEf1HcwcvgpUaJphnF3QwZD/R6SrgQymSwo3BvgED6UREX9TuTc3TnYfO/
         TxMHlXkU23iRdGF+1hEJJyQm+fGgdIqiD3P5VyDC49yasfXrCkpr5nrB30rH/hYGMFZ7
         ZVtS3AyUtwxoyeefE6NwY7z57qd9mVtMNP4vZdzNGTlWjUyMdBqMatxquKM3v2Bi2p4s
         b2j1OCHYzsrQhlcI/AwMSsrySCshxgi0+/eFuolr++XZ5vk86EKqewN5OA8fhBGRvHIQ
         wuGw==
X-Gm-Message-State: AOJu0Yw2ZcXJOqBT8vOb01qKjpZl6d7wNGfhkgpuVGK3sAupxes3seAW
	k3TL5xhkIVWdPYAHFVHtyR4iAOP4MTJEZpAnWUVVsmazXHAt1SkpiWN4aJsspQ==
X-Gm-Gg: ASbGnctycrWMld5XxqMm3DBlrkH1O7g3FGDlh0kDkYaaNFkbhkPsVZcfZKVJTfTxYVm
	UavqEMfucnAETws1XrdYapqJv8DqbsXvsC60bhCb9l2ojYhMxBicCdn10oypZskkJ9wUBRtnghf
	fu+KNAb9u5u6B/ZYO+RoPZzz/Hque3dG4goPE9/i75Oe2I1qVLJLMCwOZSqMYv9AtliPLashwC8
	IlsPqQVzPUuOsGIjA9glKwVwKOX+Vhtyw8KIUeUCW7XySPpuMfY1Zz0JWswCgMHe60WCkQdS4Be
	+EqbL3+ZHiOSdF+SU+6FaREkI5Ch2erSIU5w3vJQd7QSPcdY9KPKSHAq4ZxjRbVBYx73GtbxH5A
	1uZUgHxmvocT5uG30u8pKyoiMgSgoqHSG3EYj
X-Google-Smtp-Source: AGHT+IHe7nbgd06r9ImlGA12fM/kChLFAF99ZidtzwWvbeBXG7Zi13mzoxtkKcEp84tgy4PDDPzZOw==
X-Received: by 2002:a17:903:3d0b:b0:24a:c62a:dede with SMTP id d9443c01a7336-24ac62aea77mr262277775ad.26.1757100384443;
        Fri, 05 Sep 2025 12:26:24 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648c89bsm221500575ad.109.2025.09.05.12.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:26:23 -0700 (PDT)
Message-Id: <b113b3f01238c393af647cf7718cbafa628209ea.1757100378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
References: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
	<pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Sep 2025 19:26:16 +0000
Subject: [PATCH v3 4/6] midx-write: use uint32_t for preferred_pack_idx
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
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

midx-write.c has the DISABLE_SIGN_COMPARE_WARNINGS macro defined for a
few reasons, but the biggest one is the use of a signed
preferred_pack_idx member inside the write_midx_context struct. The code
currently uses -1 to indicate an unset preferred pack but pack int ids
are normally handled as uint32_t. There are also a few loops that search
for the preferred pack by name and those iterators will need updates to
uint32_t in the next change.

For now, replace the use of -1 with a 'NO_PREFERRED_PACK' macro and an
equality check. The macro stores the max value of a uint32_t, so we
cannot store a preferred pack that appears last in a list of 2^32 total
packs, but that's expected to be unreasonable already. Furthermore, with
this change we end up extending the range from 2^31 possible packs to
2^32-1.

There are some careful things to worry about with initializing the
preferred pack in the struct and using that value when searching for a
preferred pack that was already incorrect but accidentally working when
the index was initialized to zero.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index cb0211289d..1822268ce2 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -24,6 +24,7 @@
 #define BITMAP_POS_UNKNOWN (~((uint32_t)0))
 #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
+#define NO_PREFERRED_PACK (~((uint32_t)0))
 
 extern int midx_checksum_valid(struct multi_pack_index *m);
 extern void clear_midx_files_ext(const char *object_dir, const char *ext,
@@ -104,7 +105,7 @@ struct write_midx_context {
 	unsigned large_offsets_needed:1;
 	uint32_t num_large_offsets;
 
-	int preferred_pack_idx;
+	uint32_t preferred_pack_idx;
 
 	int incremental;
 	uint32_t num_multi_pack_indexes_before;
@@ -260,7 +261,7 @@ static void midx_fanout_sort(struct midx_fanout *fanout)
 static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 					struct multi_pack_index *m,
 					uint32_t cur_fanout,
-					int preferred_pack)
+					uint32_t preferred_pack)
 {
 	uint32_t start = m->num_objects_in_base, end;
 	uint32_t cur_object;
@@ -274,7 +275,7 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 	end = m->num_objects_in_base + ntohl(m->chunk_oid_fanout[cur_fanout]);
 
 	for (cur_object = start; cur_object < end; cur_object++) {
-		if ((preferred_pack > -1) &&
+		if ((preferred_pack != NO_PREFERRED_PACK) &&
 		    (preferred_pack == nth_midxed_pack_int_id(m, cur_object))) {
 			/*
 			 * Objects from preferred packs are added
@@ -364,7 +365,8 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 						    preferred, cur_fanout);
 		}
 
-		if (-1 < ctx->preferred_pack_idx && ctx->preferred_pack_idx < start_pack)
+		if (ctx->preferred_pack_idx != NO_PREFERRED_PACK &&
+		    ctx->preferred_pack_idx < start_pack)
 			midx_fanout_add_pack_fanout(&fanout, ctx->info,
 						    ctx->preferred_pack_idx, 1,
 						    cur_fanout);
@@ -1040,7 +1042,9 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct tempfile *incr;
-	struct write_midx_context ctx = { 0 };
+	struct write_midx_context ctx = {
+		.preferred_pack_idx = NO_PREFERRED_PACK,
+	 };
 	int bitmapped_packs_concat_len = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
@@ -1148,7 +1152,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		goto cleanup; /* nothing to do */
 
 	if (preferred_pack_name) {
-		ctx.preferred_pack_idx = -1;
+		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 
 		for (i = 0; i < ctx.nr; i++) {
 			if (!cmp_idx_or_pack_name(preferred_pack_name,
@@ -1158,12 +1162,12 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			}
 		}
 
-		if (ctx.preferred_pack_idx == -1)
+		if (ctx.preferred_pack_idx == NO_PREFERRED_PACK)
 			warning(_("unknown preferred pack: '%s'"),
 				preferred_pack_name);
 	} else if (ctx.nr &&
 		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
-		struct packed_git *oldest = ctx.info[ctx.preferred_pack_idx].p;
+		struct packed_git *oldest = ctx.info[0].p;
 		ctx.preferred_pack_idx = 0;
 
 		/*
@@ -1199,17 +1203,17 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			 * objects to resolve, so the preferred value doesn't
 			 * matter.
 			 */
-			ctx.preferred_pack_idx = -1;
+			ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 		}
 	} else {
 		/*
 		 * otherwise don't mark any pack as preferred to avoid
 		 * interfering with expiration logic below
 		 */
-		ctx.preferred_pack_idx = -1;
+		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 	}
 
-	if (ctx.preferred_pack_idx > -1) {
+	if (ctx.preferred_pack_idx != NO_PREFERRED_PACK) {
 		struct packed_git *preferred = ctx.info[ctx.preferred_pack_idx].p;
 
 		if (open_pack_index(preferred))
-- 
gitgitgadget

