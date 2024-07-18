Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B930145A1F
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721332555; cv=none; b=tfYp6z/Tl9biZ5p4dlj3aF04mWij+W/SOnw1ieNAmnSQcSMKsc3g4xNFS5c8mP5Ag66g/436j+sA0Fm3lzJrv4IQVZsyY7mlsnKk9GUuX8F0pum8rRryyRxHh3ONRu+9I6EIYRAeh3MGmZnsf9F49Yo1biMbmL0QNhSCMJS8ojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721332555; c=relaxed/simple;
	bh=1bQe/3g7JyEqMVLdLQDZcHy7LDgcVD3zaTvBCmXPwE4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JhNNCGwM9gmfRhjF+bJzN145IIHux38F7lcTQX/wGpUEQvBN7X1tgB3I3xPrSJfNYv8zoF/oOBiArXTt4LHU9Me5FRTeyfE+wDPUoqvGqvSYILsxjVTLxk8fvEZJXypYiP7OMcPG2dm9VwqsaBipUBXQbym83KvGvB5rIERXL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScYy1LIs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScYy1LIs"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3686b285969so130830f8f.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721332551; x=1721937351; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ye4j3W8FwjAhukIrNPgom0agTMcOPBUbhtjSqUmBekk=;
        b=ScYy1LIs6Mtct1Fv3T7YSHS5pO1MeP7MbrWaGsmjHlK4I0z3HBxwWJv/Lve0qaXlkY
         TdFQL5PqcTFE7Ou7A7QO+eCAUU2WidgUta42EJQUzUaGzC+qna6f0xSL8SvEQ1+OhkfG
         O8K5i5bGWN+YrDSBKtxKO8S9S3CiptoVbSKGdCqOKP0ms5mEXmNM1Sry+DGzqaJlNe9G
         T9uCZdXJupG6x3NybxL33K2nLWdpfyyz3cG6ntMcmgeiWwxLBKgMswy9/qLBo+bUkDwU
         6hUYzPnS+DQvsRwYgmd5w+KFO8Hs6i8ad3so9aF2rc+sEN9ZGECh7FE3aaOxopmmDqTS
         b0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721332551; x=1721937351;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ye4j3W8FwjAhukIrNPgom0agTMcOPBUbhtjSqUmBekk=;
        b=CqWEJWkzEFzFTJCsOx3xwERGc3UJdq0/uBb9ayHDy0cgb26ZPcISvac25yktrY+w6Y
         GWSG90tQjiinkNE+TJc8c2J+n4RxBTV144Ga+RpQ4p/lYmq9aCjHi4lXaQaLtf332Xe1
         G64ooMd7U5ErrLrjeo2DiecrrqBpyzWHBodaHyMD9Hl8EJNQHkq8SZG9N/Fg2hMKb3X+
         UYfKZ4hFbPu9ISG+227FPASvm1+06H3/F3ZJBmiYbC85hboPYlMTFJTLfeKTqGbwXh28
         QJwrD3dlmSXP51keOyioMSloIqwLd5vO6zWwwS2a4pO67Oo62DrHEdfhg74K0VhqXVtW
         KVJA==
X-Gm-Message-State: AOJu0YyHfFnnlUBlsyiaI5dYuTmBcrOJ0FLgzTWSNLjzOdS/jHIIEZBZ
	Y51DXzzi1RRZ3mlyv8d1oRW2ikkW/yzrcI1YdXTtNFj4J61W2uu9sf5Osw==
X-Google-Smtp-Source: AGHT+IE/HLcpv9hpvcuG78jK4gou6BSSb2e8ZOT/Ql6nTSwfe5Lhg9YMxVZjnojm3wEmZtmQVfrmXg==
X-Received: by 2002:a5d:6091:0:b0:367:9625:bd06 with SMTP id ffacd0b85a97d-36831707925mr3838032f8f.42.1721332551428;
        Thu, 18 Jul 2024 12:55:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368727f0791sm440492f8f.44.2024.07.18.12.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:55:50 -0700 (PDT)
Message-Id: <ce1e495a730cb8c9319aaeddf341dce9a773e1e6.1721332546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
References: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jul 2024 19:55:46 +0000
Subject: [PATCH 2/2] midx-write: revert use of --stdin-packs
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
    me@ttayllorr.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This reverts b7d6f23a171 (midx-write.c: use `--stdin-packs` when
repacking, 2024-04-01) and then marks the test created in the previous
change as passing.

The fundamental issue with the reverted change is that the focus on
pack-files separates the object selection from how the multi-pack-index
selects a single pack-file for an object ID with multiple copies among
the tracked pack-files.

The change was made with the intention of improving delta compression in
the resulting pack-file, but that can be resolved with the existing
object list mechanism. There are other potential pitfalls of doing an
object walk at this time if the repository is a blobless partial clone,
and that will require additional testing on top of the one that changes
here.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c                | 18 +++++++++---------
 t/t5319-multi-pack-index.sh |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 65e69d2de78..960cc46250e 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1474,8 +1474,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
 	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
 
-	strvec_pushl(&cmd.args, "pack-objects", "--stdin-packs", "--non-empty",
-		     NULL);
+	strvec_push(&cmd.args, "pack-objects");
 
 	strvec_pushf(&cmd.args, "%s/pack/pack", object_dir);
 
@@ -1499,15 +1498,16 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	}
 
 	cmd_in = xfdopen(cmd.in, "w");
-	for (i = 0; i < m->num_packs; i++) {
-		struct packed_git *p = m->packs[i];
-		if (!p)
+
+	for (i = 0; i < m->num_objects; i++) {
+		struct object_id oid;
+		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
+
+		if (!include_pack[pack_int_id])
 			continue;
 
-		if (include_pack[i])
-			fprintf(cmd_in, "%s\n", pack_basename(p));
-		else
-			fprintf(cmd_in, "^%s\n", pack_basename(p));
+		nth_midxed_object_oid(&oid, m, i);
+		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
 	}
 	fclose(cmd_in);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 327376233c5..5cce0be19e6 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1004,7 +1004,7 @@ test_expect_success 'repack --batch-size=<large> repacks everything' '
 	)
 '
 
-test_expect_failure 'repack/expire loop' '
+test_expect_success 'repack/expire loop' '
 	git init repack-expire &&
 	test_when_finished "rm -fr repack-expire" &&
 	(
-- 
gitgitgadget
