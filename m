Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5336D23D7F0
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 01:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788832106; cv=none; b=cd9lGillvLwaAENX1xH2PH72DtGwVcglB/EvOunfb8mFCC8VWBvlKwIlYjR4a2+vv4laiFkYcDMWUxdV4Rdo4vM4Ezduf69rpxykXo2BJvauBpJo3ZCGqufLg2LQ+z8vWgEdBHsFjuRLzV90+nFDLYr2sHY/088+TqdWIePr1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788832106; c=relaxed/simple;
	bh=DrUB3nsAL05T2FN43HyhLkOlRlZVDqwi65ft9Obyaok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vls5sXQSRhaNnzNbCF3/+DWoHFEuKmH+YtePlpgS9eRZ2DCXxBKqWFpmKnSnqx+tThGWXv/M2X2Mt8u6bvbkF9+meAAbQ4VYbdv8wU3AXwgzP8Fndiyz6jClYqIOcRkY5u9EKy0os4S+0NushO+MdDIF+82VqW3ZJzqexBPGD90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pierre.co; spf=pass smtp.mailfrom=pierre.co; dkim=pass (2048-bit key) header.d=pierre.co header.i=@pierre.co header.b=hFzm8PxD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pierre.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pierre.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pierre.co header.i=@pierre.co header.b="hFzm8PxD"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8568e3ecfc3so2701059b3a.3
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 18:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pierre.co; s=google; t=1788832104; x=1789436904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=prYKO9jg4vFGrmnal1tdnUVgxb0JvFBz2C2h2o1AtNo=;
        b=hFzm8PxDTAFsrFKhOzTI4ilTZWCGbtxKfGG2Y1PRKGwCnsBxhJ2frGnCc6qTXw3+qc
         HoJZ1lT6GbVUWLH4pTtzerfneQ4NIGO2oPeYYVhqkMiAjXkV/DxfIbCKZntXIngpt2G4
         1aRUvcuJT7AURxg9IG55QycDUObip/6MPi3nvH/wL5+ClO0Aehewzp3LtmeOrnSu5HqF
         cxZaFD7QyWzJg67eGZ/SWH4W7ggMH/Nw5ZNRWUgcZRi3c7PW0Z+oCw72F7ZvMQdKYtV/
         Jku6WPXIXjifyPDkfNGjuQh59I7SeEsJ4mzkEYaA5SxzBpFn0Vq18fkG58dxxrwoSGBI
         DOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788832105; x=1789436905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=prYKO9jg4vFGrmnal1tdnUVgxb0JvFBz2C2h2o1AtNo=;
        b=mEbYu9YScq45cFVKnKk6Tyc9FJ/FAV/HP/xVkEEwRwzYw0XLVl+Gys8UPKMNBVEHH9
         /LPNHISZVzjFvFfx9em61ApKBHeH/rldp/7zZE402MpPHdJMSoZ9x8dwYpzhNnMShTfA
         TopZRsu8ZHZ7oAJlbCRNYXxRiJE+SWPr/dbnl2VcZvNx/px09+1gY8K3Jwcm5cZX9zls
         W8EVQlGBhOqXEDxYyjem0cPJuo1VX7qhIazqs/i8ANZYgjSu0CDjuLvWhfJIv2vDjhd3
         CKQUAfZcSlP5+Hg5aWq9m5B7p1/PGJgaFZ6YVdSXwXMMUuZ1ZLW0qPfR2e/qP9lJSfVl
         1iSA==
X-Gm-Message-State: AFuF++l1IW5O/i+QLl1hCIdXJFTit8cXqPJuhHD3TF89hUTO0nt5bWvT
	axaM0M27Zto7m8LiDA1lIkGuTyJJavtbjA1q2Ib6u1xqyssKavJyHjLeaiFeXFm5MvmCcMjCX3l
	BErF8xEw=
X-Gm-Gg: AYBFou0uwqJebVahmT8Tn/UGpvTW2of2i8J+suqAUa2Ic8M6cAaw6L6X0cmJqBUDex7
	F+M6VquUdpQXm+UjZOdCxcPBwu/4oM6Fgucr5trPAaIITbxIxsfqzYBfm6+o+0cLxCqGYOyh8WU
	pz+q2AK0H3eDppe6c8jvPCNZQNkIQMKMCUh/JRGa4FfUrcjqHasPRqlPtVZ6ZU0IIG6M5oti73R
	1Q8/2xD8QF6J3Bu3cgyj81EzQYtNyuCZYigptkzhQULCQ8M5jovWpCDbOq+pkj8jd9tUynDiHrJ
	z9FvP4vRVibYFvZQWCOjtRv0FXoDLTIG810uFTIdFOkVH1TUS5XH0admlQ5Hg6EUQiiMzlxm07p
	7ywGkndt+EhGDCP+oO5PBnf59fxgAZbhUfGyWw4K0sYc4jwciPgBx55WB7rXPSYbuqjLiXL5dxV
	qamVkQqhfalfEZw0ILoMXHtLEOfHG32ZnqFcwCLXfCWCcCIiLLn8tOfe7LVTgSoWvhP6tEJGAhY
	TiPDBWbxLrVgxTTXj8ok03Em1NBYL74kk+PTgc=
X-Received: by 2002:a05:6a21:3a94:b0:3cd:2e96:5929 with SMTP id adf61e73a8af0-3da3a0a2b84mr44479351637.14.1788832104606;
        Mon, 07 Sep 2026 18:48:24 -0700 (PDT)
Received: from localhost.localdomain (gw-v170.static.monkeybrains.net. [158.247.70.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm24391574eec.23.2026.09.07.18.48.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 18:48:23 -0700 (PDT)
From: Pia Park <pia@pierre.co>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] midx-write: skip empty incremental layers
Date: Mon,  7 Sep 2026 18:46:40 -0700
Message-ID: <20260908014720.19705-1-pia@pierre.co>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An incremental MIDX write can find new packs without finding any new
objects, either because the packs are empty or because their objects
are already indexed by an earlier layer.

The existing early exit checks the number of packs, so these cases
publish a zero-object layer without a reverse index. A subsequent
incremental write with --bitmap fails when loading that reverse index.

Reproducible on master as of
b8242b093d9e941a34460d715e3ce616a34ac3fe (2026-09-07), using:

    git init --bare --object-format=sha1 empty.git &&
    (
        cd empty.git &&
        git config midx.version 2 &&
        git pack-objects objects/pack/pack </dev/null &&
        git multi-pack-index write --incremental --bitmap &&
        git multi-pack-index write --incremental --bitmap
    )

The first write succeeds but publishes the empty layer
3c8853aad425100c5ee2ee22209bb0bb3df9ca37. The second exits with status
255, reporting "could not load reverse index for MIDX".

Return success through the existing cleanup path when
compute_sorted_entries() finds no entries for a non-compacting
incremental write. This prevents publishing an empty layer that causes
subsequent incremental writes with --bitmap to fail with exit status
255. Exit before acquiring a lock or creating a temporary MIDX file,
leaving the existing chain untouched.

Add regression tests for empty initial layers, empty packs, and packs
containing only duplicate objects. Check silent success, preservation
of the existing chain and file list, and subsequent writes that add
new objects.

Signed-off-by: Pia Park <pia@pierre.co>
---
Built with DEVELOPER=1 and ran these scripts before and after:

  t5319-multi-pack-index.sh
  t5326-multi-pack-bitmaps.sh
  t5327-multi-pack-bitmaps-rev.sh
  t5332-multi-pack-reuse.sh
  t5334-incremental-multi-pack-index.sh
  t5335-compact-multi-pack-index.sh
  t7700-repack.sh
  t7705-repack-incremental-midx.sh

All 881 baseline tests and all 884 tests with the patch passed. The
three new regressions fail on the unpatched build. Test lint and
whitespace checks passed.

Both empty and duplicate-only pack reproductions also fail on a fresh,
unmodified build of upstream master at the base commit shown below.

 midx-write.c                            |  5 +++
 t/t5334-incremental-multi-pack-index.sh | 58 +++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/midx-write.c b/midx-write.c
index 8537102254..cdb2ef0474 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1518,6 +1518,11 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 	compute_sorted_entries(&ctx, start_pack);
 
+	if (ctx.incremental && !ctx.compact && !ctx.entries_nr) {
+		result = 0;
+		goto cleanup;
+	}
+
 	ctx.large_offsets_needed = 0;
 	for (size_t i = 0; i < ctx.entries_nr; i++) {
 		if (ctx.entries[i].offset > 0x7fffffff)
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index f0b82b5f65..4bdfa61d38 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -195,4 +195,62 @@ test_expect_success 'non-incremental write with existing incremental chain' '
 	)
 '
 
+test_expect_success 'skip initial MIDX layer with no objects' '
+	git init empty &&
+	(
+		cd empty &&
+		git config maintenance.auto false &&
+		git pack-objects $packdir/pack </dev/null &&
+
+		for bitmap in --bitmap --no-bitmap
+		do
+			git multi-pack-index write --incremental "$bitmap" >out 2>err &&
+			test_must_be_empty out &&
+			test_must_be_empty err &&
+			test_dir_is_empty "$midxdir" || return 1
+		done &&
+
+		write_midx_layer &&
+		test_line_count = 1 "$midx_chain" &&
+		git multi-pack-index verify
+	)
+'
+
+for pack in empty duplicate
+do
+	test_expect_success "skip MIDX layer with $pack pack" '
+		git init "$pack-pack" &&
+		(
+			cd "$pack-pack" &&
+			git config maintenance.auto false &&
+			write_midx_layer &&
+
+			if test "$pack" = duplicate
+			then
+				git rev-parse HEAD^{tree} >in
+			else
+				>in
+			fi &&
+			git pack-objects $packdir/pack <in &&
+			cp "$midx_chain" chain.expect &&
+			ls "$packdir" "$midxdir" >files.expect &&
+
+			for bitmap in --bitmap --no-bitmap
+			do
+				git multi-pack-index write --incremental "$bitmap" >out 2>err &&
+				test_must_be_empty out &&
+				test_must_be_empty err &&
+				test_cmp chain.expect "$midx_chain" &&
+				ls "$packdir" "$midxdir" >files.actual &&
+				test_cmp files.expect files.actual || return 1
+			done &&
+
+			write_midx_layer &&
+			test_line_count = 2 "$midx_chain" &&
+			git multi-pack-index verify &&
+			git rev-list --test-bitmap 2.2
+		)
+	'
+done
+
 test_done

base-commit: b8242b093d9e941a34460d715e3ce616a34ac3fe
-- 
2.55.0

