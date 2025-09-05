Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAD28137D
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100391; cv=none; b=T6wOD7x16cyd4LCY3FVOM2qr5xB09gbdCZtApAnR+QIoCbHyrBwLnopDpoP+OznBvXZuFWye4deQtYVJaw+AebA45VXtedfkpEGSplQdv1PbyYXYwUMPU/ulXytLafWU+yXgzqr20dCIL1xcv5bEtwWsheMQfb0QsaiketGpIJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100391; c=relaxed/simple;
	bh=BBvU01KZb8LVvEzxAhEFAlkmhiEVZ70adIrYGY5A9/8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S78qLyqj9kOlqYIm8y1kRIKZ6hh7uDayFek5hAknf+s/qOREQ74J+sh19vCLGt4ZBrXqHHcK9/3N6CL0d3aggzZpSqVA0IWx6dsZY8VI7l+rnEjco9QyaZYg69wsWx/fyNSgbEhi+gI32wWlqerzFLSg+JucD3H4omFBe+UBWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYjVUtqX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYjVUtqX"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b520c9c291dso838553a12.1
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757100389; x=1757705189; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0YPzAPfyGqJBE9xxnVOVMGqO3hwT3OquLyRW+s/bN4=;
        b=NYjVUtqXXj1qUgQ5C+I247CHXAlAoIfuJXn3ByHJxH6NpKqk4ikE7TlCv5fI5MH6Ca
         kSHtLY3Nan5262RBjqYCM+6oZu2xWAQcuh4UYslwEgfiyVSVv17CNs5AZMFLpzmdFdG1
         KBa3ZJoh7EtRiGusHh3y0bWwZFRExUvbzsksecPlPRiLjKjbOY1U3NE/Ud+wRpO/U+UH
         ELQrMbe4NNRbDQ7eG9/rTmJJv0y0EbMtat57d7AVPpeMD53qdD2KRlK5+yl6ymPqlGHT
         B96j9d4HUcJJt2eCgOrOMFzRa3RGzNLp84h2S7z2qhmCV5BPsz7qRaK4HEnYkwhjsduF
         vE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100389; x=1757705189;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0YPzAPfyGqJBE9xxnVOVMGqO3hwT3OquLyRW+s/bN4=;
        b=fP7Iaq50ley50dcEQl6wmSrlUcCh3DjE7yM0IvEs4wfXWTwbZUewApwlqV9KdYy2N9
         3JfHpXnbrGJ/TDxOGxNVyLZhKyPmTAk+TRYfi11LNdwmrj6fbmVu1XyEc1Y29FMVohDp
         j2ZEt8dDGZ6ygVcbjVHcp7U7IKfPa6Bm59gROpvwVqholyJAKOUpbr2Vv1LpSHRg4ViQ
         R2M++evTKXCkvpiL2NqNMg2dFNn2g/fmdhjq17mHU6mMPxDJhzadk+4yujnZ7cI2Il5H
         YSPlgb0zbCWSH5/b2t/TmcSoJuZSUBjdiQbYqc7Xwwma3ocTSsF4VYl+s8BcTa599hpn
         +uiQ==
X-Gm-Message-State: AOJu0Yy1LHYLjlip0yiXR912v329nsK4Lu+LBgCVPKHbbbqrfPoIii/l
	C/QKtKAu89vsHURY1BEtpLrl7a+kkNUi47L8bWxZOTubKmJ0qMi04WfEFJPoug==
X-Gm-Gg: ASbGncuflDP2e6OBQ1iDbICycFtk8mJcZNu6M8GBLWLEIIViHWEghP4xvo7DIA3m8+B
	Hotkqb3B68mtrxNl8wClhYwhFeR2fPCBOlSmM9fyGG1oD3iFJU1KS3nCPjNSUE2CKeF2B2Exfhg
	3ZfLvj2mlePdtQneaNd4BYVQ6lmRbAMJsoa1dPfKtviVV63LFYK5kK4YD/gNA+ypwLFe2i3hZCv
	OfFZnva5fo5cC0R5Sh3wS4UmZC0pE2A3E2iQy3/hiw3DGR2Inbtsr6T/1BcvCo+tSoNoYyPyvQE
	BNwBj31GjiYRRx+KN8ufOv3E0niD+D28pq5+eRkmWDiBV+uwWmQPj2zBoneQLTuOUAVbdPlmytp
	+0SSUeU5WhwDwy54kIQ0epCjGiA==
X-Google-Smtp-Source: AGHT+IGRxW5eu1xlw5wQBAaG24qrRNW3k7R2QpKUC7lUjbHoLlNTs+/agOm3UayXbtQmobMb5bI/Iw==
X-Received: by 2002:a17:902:ebc9:b0:24c:7bc6:7ad7 with SMTP id d9443c01a7336-24c7bc67d09mr173375785ad.3.1757100388900;
        Fri, 05 Sep 2025 12:26:28 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3670e5csm19864436a12.53.2025.09.05.12.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:26:28 -0700 (PDT)
Message-Id: <224be4ee5c66a5d161ba35754dd324b8ee53d07c.1757100378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
References: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
	<pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Sep 2025 19:26:18 +0000
Subject: [PATCH v3 6/6] midx-write: simplify error cases
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

The write_midx_internal() method uses gotos to jump to a cleanup section to
clear memory before returning 'result'. Since these jumps are more common
for error conditions, initialize 'result' to -1 and then only set it to 0
before returning with success. There are a couple places where we return
with success via a jump.

This has the added benefit that the method now returns -1 on error instead
of an inconsistent 1 or -1.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index cd7bf7554a..72189f74bb 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1046,7 +1046,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	int bitmapped_packs_concat_len = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
-	int result = 0;
+	int result = -1;
 	const char **keep_hashes = NULL;
 	struct chunkfile *cf;
 
@@ -1099,14 +1099,12 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 				error(_("could not load reverse index for MIDX %s"),
 				      hash_to_hex_algop(get_midx_checksum(m),
 							m->repo->hash_algo));
-				result = 1;
 				goto cleanup;
 			}
 			ctx.num_multi_pack_indexes_before++;
 			m = m->base_midx;
 		}
 	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
-		result = 1;
 		goto cleanup;
 	}
 
@@ -1142,12 +1140,16 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			 */
 			if (!want_bitmap)
 				clear_midx_files_ext(object_dir, "bitmap", NULL);
+
+			result = 0;
 			goto cleanup;
 		}
 	}
 
-	if (ctx.incremental && !ctx.nr)
+	if (ctx.incremental && !ctx.nr) {
+		result = 0;
 		goto cleanup; /* nothing to do */
+	}
 
 	if (preferred_pack_name) {
 		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
@@ -1221,7 +1223,6 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		if (!preferred->num_objects) {
 			error(_("cannot select preferred pack %s with no objects"),
 			      preferred->pack_name);
-			result = 1;
 			goto cleanup;
 		}
 	}
@@ -1260,10 +1261,8 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			}
 		}
 
-		if (missing_drops) {
-			result = 1;
+		if (missing_drops)
 			goto cleanup;
-		}
 	}
 
 	/*
@@ -1309,7 +1308,6 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
-		result = 1;
 		goto cleanup;
 	}
 
@@ -1329,14 +1327,12 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		incr = mks_tempfile_m(midx_name.buf, 0444);
 		if (!incr) {
 			error(_("unable to create temporary MIDX layer"));
-			result = -1;
 			goto cleanup;
 		}
 
 		if (adjust_shared_perm(r, get_tempfile_path(incr))) {
 			error(_("unable to adjust shared permissions for '%s'"),
 			      get_tempfile_path(incr));
-			result = -1;
 			goto cleanup;
 		}
 
@@ -1414,7 +1410,6 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 				      midx_hash, &pdata, commits, commits_nr,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
-			result = 1;
 			clear_packing_data(&pdata);
 			free(commits);
 			goto cleanup;
@@ -1440,21 +1435,17 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 		if (!chainf) {
 			error_errno(_("unable to open multi-pack-index chain file"));
-			result = -1;
 			goto cleanup;
 		}
 
-		if (link_midx_to_chain(ctx.base_midx) < 0) {
-			result = -1;
+		if (link_midx_to_chain(ctx.base_midx) < 0)
 			goto cleanup;
-		}
 
 		get_split_midx_filename_ext(r->hash_algo, &final_midx_name,
 					    object_dir, midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
 			error_errno(_("unable to rename new multi-pack-index layer"));
-			result = -1;
 			goto cleanup;
 		}
 
@@ -1487,6 +1478,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	clear_midx_files(r, object_dir, keep_hashes,
 			 ctx.num_multi_pack_indexes_before + 1,
 			 ctx.incremental);
+	result = 0;
 
 cleanup:
 	for (size_t i = 0; i < ctx.nr; i++) {
-- 
gitgitgadget
