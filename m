Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2941D100
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827916; cv=none; b=uwAZW3hfG0QV4Le80YkJpvBLNEbig35tY3+HKDoJPo867sjocsSoF8J8uAZYs74H++5JSQ8m8oPi1jmmqTtpxV1lqZ1ysaXEaTxkWoNVPFSkd7prMTik2YSgffzHRdTfRA13vKHnXGDnUrUSrevY31vB8SycHLzGv1MpP+S2r70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827916; c=relaxed/simple;
	bh=SFuBWGsw9Y11StVa1UlbFH8OyGkEfTvzrJZnSoh/QrI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENJhEbQ400CC1ld1NNvgZ7NKhc/vtmZtzu66Mgryv4GmfbG7vDTgWphR4J6Y3GLWdQbbu84+7Nfx/5XdAtV75Om7jc7bOP9hnMzU2vSIDV0Q6wSE7ksWHhsir0nlj977he8w6/ggrdUUzPHGHOpDgOXhitfbrGTyJGrWtyhX1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=MOMyHxlx; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="MOMyHxlx"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-49df3b68539so255595fac.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790827913; x=1791432713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uj5YixdyrnP/1q21/VRuUdrpfv0CA79098lpufR6r3I=;
        b=MOMyHxlx0LUkrjBaKovaB7EN3JGddC98JPXpv0n7NibP4KDYlqsN95Bxdk92njrNxP
         ILorgTRyg1wpcV61cFrk2rS451vfYzLXliZnbaYD2G6LrwtViYg+WdcuYhmLTeFEnpY7
         r+PcNf4SY9l8geLs7LH8TIzMOuOfUyZkbhtnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827913; x=1791432713;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uj5YixdyrnP/1q21/VRuUdrpfv0CA79098lpufR6r3I=;
        b=eS9lpM3IIUYQEVzTF4Go1LbW+K51EKHJEkKMHSnycmmBr9ylbP8eVwMLsFxO3YWqVF
         cDB+nxjRK4wdmeEbqqvHgLrNS4BX16/TWUNCcW8NIwYTzNuFm56d143NBWnHBs5FonVC
         2CzVTT7OmtIeTnZxvAYQxVDo7P8kX8dxh1gfFHe/CVCIvzUuHnd+1rWrR2/Q+w4b4h/T
         BKQXyGwnzx7G4Wn0qKICGAiTRnEAfAiXs98EFkDvvTwPBd0hAs+Lk9g4+ghZOuCjlrmH
         J23UZ8qRk9IIY9NBhMOOcwasZ3JslQoZeeR0lUJWwGPihlhmFuGB+DyAEQ4Rs/HrqKyK
         ZRLA==
X-Gm-Message-State: AFuF++l+8qorqbBgkegU9nN5GmsmlrqGQeGAdvDuGXb8JrxsBSC86QkB
	oE6ZxqnK1N1oLWa/mZciS/V5L02ls/4ShKbA8wf7lrD/5zospQRZXh7Iy7iVjwLZ6OSZCWhNG5/
	QgSrIZ6g=
X-Gm-Gg: AYBFou3MzaqxdyKsngUcSpZWfRq3iOgQRhHkgnbsM3TDYzOXkgTGY2TFQ7y1ySDZHD4
	wAPWGHB2g94ol/fynmWmeBySxeoK824gc9nHyNtzUpGNCA/WM9Uwq5FUVhjC/zL1VDyo0dlQ4Wa
	dZ7iUqn01R9GwxoC8UjN6mmcf1MmE6RNjejXUpHCKgQLbQS5U/RuPjZT5XMaC8f+BvQPiYlPmlu
	z4sak0RT8tE+q2xKhLgZF2bJ3d2JtXIGXAbkotN6fCJ0DDB/ywvEtSpUyueiD9wGRlqqDLLu7ZD
	qjY2qafVqdP9NG62K05kC8cCUx6lU9FLaH7dk1BLKGDL72W9N9/AJRdf9I+NY4KkmfZLCLg/sgV
	y/tQTbeOB9dV8fbz1mwtTFAjkvpRz+OZSWZL/DTrX30AGn/hE1ROirFCvrq67n0OMiyatWmqxi5
	8Wwu/lMJnstI7qQyZcOrLNA6mo6CnsG21lsiFGp/sadltFqlzeaXqXtpDVG40R8gxhBzxeYzqMm
	myyostjpxmVxHJe0u6hUBuS7pOQJVFWFnXJdQ+Cwju6CnbsOwhUaaUEy4oYkzn89k/lgLIeqXyw
	y8dPzFdH
X-Received: by 2002:a05:6870:e98a:b0:48f:e0f6:bd56 with SMTP id 586e51a60fabf-49df06a949amr1727506fac.43.1790827913489;
        Wed, 30 Sep 2026 21:11:53 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49decead467sm1942534fac.1.2026.09.30.21.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:11:53 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Wed, 30 Sep 2026 23:11:51 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH v2 5/8] repack: follow kept packs when omitting cruft from
 the MIDX
Message-ID: <51e20444dac1223f0e0485dc5799ed6d592f7614.1790827875.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790827875.git.me@ttaylorr.com>

When performing a geometric repack with 'repack.midxMustContainCruft'
set to "false", Git uses '--stdin-packs=follow' to copy (once-cruft)
objects needed for reachability closure out of cruft packs. .keep packs
do not normally participate in that walk, though they *are* included in
the resulting MIDX.

A .keep pack can contain a commit that reaches an object whose only copy
is in a cruft pack. When there is no previous MIDX and the repack writes
a new pack, neither `midx_has_unknown_packs()` nor the `!names.nr`
fallback require that cruft pack to be included. If the kept commit (or
a descendant of it) is selected for bitmap coverage, the bitmap writer
fails because the MIDX does not contain all of its reachable objects.

Pass excluded kept packs to the follow walk, using '!' for packs outside
the existing MIDX and '^' for packs already covered by it. This copies
needed objects out of cruft without copying objects in the kept packs.
It also avoids including all cruft merely because a concurrent push has
installed a temporary '.keep' file.

With '--pack-kept-objects', packs with '.keep' files participate in the
geometric repack, and thus may have their objects copied. Packs
specified as kept via '--keep-pack' still exclude their objects, even
when their packs fall below the geometric split.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 builtin/repack.c        | 31 ++++++++++++++++++++++++++---
 repack-midx.c           |  5 +++++
 t/t7704-repack-cruft.sh | 43 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 88b05e96b5b..27d6668a4ab 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -476,9 +476,11 @@ int cmd_repack(int argc,
 	show_progress = !po_args.quiet && isatty(2);
 
 	strvec_push(&cmd.args, "--keep-true-parents");
-	for (i = 0; i < keep_pack_list.nr; i++)
-		strvec_pushf(&cmd.args, "--keep-pack=%s",
-			     keep_pack_list.items[i].string);
+	/* Geometric follow walks exclude these packs through stdin instead. */
+	if (!(geometry.split_factor && !midx_must_contain_cruft))
+		for (i = 0; i < keep_pack_list.nr; i++)
+			strvec_pushf(&cmd.args, "--keep-pack=%s",
+				     keep_pack_list.items[i].string);
 	strvec_push(&cmd.args, "--non-empty");
 	if (!geometry.split_factor) {
 		/*
@@ -593,6 +595,29 @@ int cmd_repack(int argc,
 
 			fprintf(in, "%c%s\n", marker, basename);
 		}
+		if (!midx_must_contain_cruft) {
+			struct strbuf buf = STRBUF_INIT;
+
+			for_each_string_list_item(item, &existing.kept_packs) {
+				char marker = '^';
+
+				strbuf_reset(&buf);
+				strbuf_addf(&buf, "%s.pack", item->string);
+
+				if (po_args.pack_kept_objects &&
+				    !string_list_has_string(&keep_pack_list,
+							    buf.buf))
+					continue;
+
+				/* Exclusions override any inclusion above. */
+				if (!string_list_has_string(&existing.midx_packs,
+							    buf.buf))
+					marker = '!';
+
+				fprintf(in, "%c%s\n", marker, buf.buf);
+			}
+			strbuf_release(&buf);
+		}
 		fclose(in);
 	}
 
diff --git a/repack-midx.c b/repack-midx.c
index 64c7f8d0f42..9f7786aaac5 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -197,6 +197,7 @@ static void midx_included_packs(struct string_list *include,
 	}
 
 	if (opts->midx_must_contain_cruft ||
+	    (!geometry->split_factor && existing->kept_packs.nr) ||
 	    midx_has_unknown_packs(include, geometry, existing)) {
 		/*
 		 * If there are one or more unknown pack(s) present (see
@@ -209,6 +210,10 @@ static void midx_included_packs(struct string_list *include,
 		 * reachability closure if the MIDX is bitmapped and one
 		 * or more of the bitmap's selected commits reaches a
 		 * once-cruft object that was later made reachable.
+		 *
+		 * Kept packs may also depend on cruft objects, since
+		 * they are included above without necessarily being
+		 * traversed by a non-geometric repack.
 		 */
 		for_each_string_list_item(item, &existing->cruft_packs) {
 			/*
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index f7f83e70ffe..bc6d6f588fa 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -798,6 +798,49 @@ test_expect_success 'incremental repack includes cruft for MIDX bitmaps' '
 	)
 '
 
+test_expect_success 'geometric repack follows kept packs to cruft objects' '
+	setup_cruft_exclude_tests kept-cruft &&
+	(
+		cd kept-cruft &&
+
+		# Put HEAD in a kept pack, while its parent is still in
+		# a cruft pack.
+		pack=$(echo "HEAD^..HEAD" | git pack-objects --revs $packdir/pack) &&
+		git prune-packed &&
+		GIT_TEST_MULTI_PACK_INDEX=0 \
+		git repack -d --geometric=2 --write-midx --write-bitmap-index \
+			--keep-pack=pack-$pack.pack &&
+
+		test-tool find-pack -c 1 HEAD &&
+		test-tool read-midx --show-objects $objdir >midx &&
+		cruft=$(ls $packdir/*.mtimes) &&
+		test_grep ! "$(basename "$cruft" .mtimes).idx" midx
+	)
+'
+
+test_expect_success 'full repack retains cruft pack in MIDX for unreachable kept objects' '
+	setup_cruft_exclude_tests unreachable-kept-cruft &&
+	(
+		cd unreachable-kept-cruft &&
+
+		pack=$(echo "HEAD^..HEAD" | git pack-objects --revs $packdir/pack) &&
+		touch $packdir/pack-$pack.keep &&
+
+		# Make the kept commit unreachable so that the full
+		# repack leaves its parent in a cruft pack.
+		git reset --hard one &&
+		git tag -d four &&
+		git reflog expire --all --expire=all &&
+
+		GIT_TEST_MULTI_PACK_INDEX=0 \
+		git repack -a --write-midx --write-bitmap-index &&
+
+		test-tool read-midx --show-objects $objdir >midx &&
+		cruft=$(ls $packdir/*.mtimes) &&
+		test_grep "$(basename "$cruft" .mtimes).idx" midx
+	)
+'
+
 test_expect_success 'repack --write-midx includes cruft when instructed' '
 	setup_cruft_exclude_tests exclude-cruft-when-instructed &&
 	(
-- 
2.56.0.8.ga42f775cbe2

