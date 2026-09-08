Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A404370ADC
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851453; cv=none; b=Dyd9T9JrFV8CVg9JnVxECoYoUPH9sGA3HAcDDtOV0+cfbB063C3GmDpuqz0c6FRAvHrkvKhLXmf6XV8vBEdxGhfW/TJYex0LdJwPOZ67rI7Np0XpMeA6aXqEH2DWAfQIWDXTr9s2l+hQ712J6oSSRg47gR76QIS+KsoEn9PTktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851453; c=relaxed/simple;
	bh=5tCpkkpNKdPa5mBecHQS/2Z6W+NFNfiyF8Hm3rK374c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBK/AKxZODdToaHc09iPrRt/7l7nOiIsYKsZ+WiAdTBWl2zHxeqSrq0NC1Wo1XaSU1isY4OUmx43LSNPCsDv+1YuB/aYEPiyEH3iN+piHs6dRqDaYSfN/joeWsyi9opyCJOUT92cZ0dmBwoyDWOskGTdxRyAGz/UqajRiCmW9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pierre.co; spf=pass smtp.mailfrom=pierre.co; dkim=pass (2048-bit key) header.d=pierre.co header.i=@pierre.co header.b=QuHCwk+L; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pierre.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pierre.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pierre.co header.i=@pierre.co header.b="QuHCwk+L"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-857ff9fef54so37390807b3.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 00:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pierre.co; s=google; t=1788851450; x=1789456250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6AF4OP3lIr+6BKSCctBGJb3V28WengSb057ADY9jC8k=;
        b=QuHCwk+LKWim0ItdaXwmeFEgM6ht1DdG4XIvxCwM9iErz1zCyCJXOb+PIVU9GWo2Kt
         BClQ6n2015y3rZFS/2pM5tGql4hWczoDNBeQ+Ut1utcZbL+6H/79pni34MRKrIlH3R7x
         43MwC8dIrLD8FE9DGmv6waTUWNqnUj4ZDFbhzvhgH4pWXSyBrl/n5onUYIJPCU4MunNg
         C1S/BbUxDcyqaEZqwGTWtm36f24IeQc5j/Fs7zkPvaF7vH2+KKALtVHxvMIbzyburGzW
         s+upbiTkBe38OiGwpV2ku/HmKlDyquzJC43E616ztA+MX1RNoFB1f2rDbjkF9oRIuXmF
         +0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788851450; x=1789456250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6AF4OP3lIr+6BKSCctBGJb3V28WengSb057ADY9jC8k=;
        b=CYXt/rQkEGT40qvgQZWEHvo4DllvmPWtquZVUo6mKYmwMigOT0Mppr5jjGinFRyH4o
         fKQAkLN83G8n6xCle64vB0rsd7k6sLk2SjFwk7EJso3pT/DfMyNyODQH+XR1a+M47yUS
         m4G/gcC6pkIeWofpJRoyFsDyQBDSjeZO3TdBOiTwOb9YZjO/zA4/sRZJZMLegfhP0Shz
         EiN4ue53uXJ/I+ZM4o5/7BZAMr9jIeCC6Fv0e/oqQgmUU4W/zKBB8El2mwqAofuWXC+z
         xNGb/nYvHY53HKUttIYLjLWXBsUpX0OwDeiQR8AhFpTYZaT8KfmNGiOyUcKInTcz2HPQ
         LeKg==
X-Gm-Message-State: AFuF++lPEhOzmfUBzHwGQkNuPL5bEkFJholrf1k3kfI3iZ9C/3IPGgrA
	k2apeRXUs7gwoG9cD2Xlx8RMJzV6u3DNylTX2z2OzD9WJbxhsEQAqUn9tU7gUXBhOrBqqZPy92n
	gJ4Pt3Pg=
X-Gm-Gg: AYBFou0k0fxhW9kJEqu/o7MZTwCwLp9ebqdUbDAHZgSXRGZ6UvNpKRgJrCrYmSwvA89
	tuGcFDz5XW2ToS9g9HJUjpZ9qSDBoGufgOOlnUUbQCk/QFOqe+pasLFgOienv/6ueOG77nKbHW6
	XDkSTb/s4SQNcL0X18NmdDMZqellxkQ30jDChMeYWXhLnACywb8Nf7yq9mknoWGkQqGQ2cioGmf
	7usrtM5oz2Ypnu2ZASHqdWXA+f+JSUnKB+Dw6rNFq4WqGEQrp+nu+lsQOF3qHgXZsh7udufSYLj
	ACtR9waknSC81iS4Fymic9EyOna0HR5M7N1cePHZ5lLW3AMMXn0A9KnTTWKum2/BvdDYc7m7uYz
	/Rztqh36/VCogUQfZ0FHN2ukrUamBdeBSdAU0rEMendXvE6u1CEUys90dSNZHsAHg+WLe5nutOc
	d3TzRLzzcOAfY8fxSM5JtDORrflXR++kCgNHsrbMh1PiC6/r5bzIS4CSeHgx7oqyqV0RSyvQMjt
	EecHqYZ+Kn/eCYZfw==
X-Received: by 2002:a05:690c:e28a:10b0:873:5bb2:6c0a with SMTP id 00721157ae682-8735bb26e53mr47335727b3.52.1788851449892;
        Tue, 08 Sep 2026 00:10:49 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:2f70:7f50:487f:902a:a276:a9c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8749af79c56sm56459467b3.22.2026.09.08.00.10.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 00:10:49 -0700 (PDT)
From: Pia Park <pia@pierre.co>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2] midx-write: skip writes with no object entries
Date: Tue,  8 Sep 2026 00:10:16 -0700
Message-ID: <eef33827000cf106544174ed000129c2989af1cd.1788851232.git.pia@pierre.co>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ap-KYtsDXXwbBzDM@com-79390>
References: <ap-KYtsDXXwbBzDM@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A MIDX write can find packs without finding any objects, either because
the packs are empty or because an incremental write finds only objects
already indexed by an earlier layer. The existing early exit checks only
the number of packs, so these cases publish a zero-object MIDX without a
reverse index.

Empty MIDXs were already published by 662148c435 (midx: write object
offsets, 2018-07-12); the failure mode appeared in 27afc272c4 (midx:
implement writing incremental MIDX bitmaps, 2025-03-20), when
incremental bitmap writes began loading reverse indexes from prior
layers.

Reproducible on master as of b8242b093d (The 23rd batch, 2026-09-07),
starting with a non-incremental write:

    git init --bare --object-format=sha1 empty.git &&
    (
        cd empty.git &&
        git pack-objects objects/pack/pack </dev/null &&
        git multi-pack-index write &&
        git multi-pack-index write --incremental --bitmap
    )

The first write succeeds but publishes an empty MIDX, which also fails
verification with "the midx contains no oid". The second write exits
with status 255, reporting "could not load reverse index for MIDX".
Starting with an incremental write has the same problem.

Exit before publication whenever the computed entry list is empty, for
both non-incremental and incremental writes, including compaction. Take
the existing cleanup path after pack/drop validation and before
acquiring a lock or creating a temporary MIDX file. This leaves existing
MIDX files untouched and preserves the error when there are no pack
files to index.

Return success silently. Empty-object writes already return 0, including
when --bitmap warns, so preserve that exit status for existing callers
while omitting the warning and empty MIDX.

Test empty packs in a bare repository, empty incremental layers, and
packs containing only objects indexed by an earlier layer. Check silent
success, preservation of existing files, and subsequent writes that add
new objects. Update the existing bitmap test to expect neither an empty
MIDX nor a bitmap.

Signed-off-by: Pia Park <pia@pierre.co>
---
Thanks, Taylor. I kept exit status 0 because empty-object writes
already succeed, including when --bitmap emits its warning. Would you
prefer an error here instead? The existing no-pack-files error is
unchanged.

Changes since v1:

* Apply the check to all write modes, including compaction, at the
  location in your sketch, after pack/drop validation.
* Preserve exit status 0 and skip empty publication silently.
* Add the non-incremental bare-repository reproduction and check later
  incremental and non-incremental bitmap writes with real objects.
* Update t5326's existing test that expected an empty MIDX and a warning.
  Keep explicit empty-pack and duplicate-only incremental tests.
* Identify the verified 2018 empty-MIDX behavior and the 2025 introduction
  of the reverse-index failure, using reference-format citations.

The implementation passed 885 tests across the eight MIDX/bitmap/repack
scripts. After the test-only revisions, all 481 tests in the three
changed scripts passed, along with test lint and whitespace checks.

 midx-write.c                            |  5 +-
 t/t5319-multi-pack-index.sh             | 35 ++++++++++++
 t/t5326-multi-pack-bitmaps.sh           | 13 +++--
 t/t5334-incremental-multi-pack-index.sh | 75 +++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 9 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 8537102254..3038bbfad2 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1617,9 +1617,8 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	}
 
 	if (!ctx.entries_nr) {
-		if (opts->flags & MIDX_WRITE_BITMAP)
-			warning(_("refusing to write multi-pack .bitmap without any objects"));
-		opts->flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
+		result = 0;
+		goto cleanup;
 	}
 
 	if (ctx.incremental) {
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 68143cb5b7..c239a87d10 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -54,6 +54,41 @@ test_expect_success "don't write midx with no packs" '
 	test_path_is_missing pack/multi-pack-index
 '
 
+test_expect_success 'skip non-incremental MIDX with no objects' '
+	git init --bare empty.git &&
+	(
+		cd empty.git &&
+		git pack-objects objects/pack/pack </dev/null &&
+		ls objects/pack >files.expect &&
+
+		for bitmap in "" --bitmap
+		do
+			git multi-pack-index write $bitmap >out 2>&1 &&
+			test_must_be_empty out &&
+			test_path_is_missing objects/pack/multi-pack-index &&
+			ls objects/pack >files.actual &&
+			test_cmp files.expect files.actual || return 1
+		done &&
+
+		git multi-pack-index write --incremental --bitmap &&
+		test_dir_is_empty objects/pack/multi-pack-index.d &&
+
+		echo blob | git hash-object -w --stdin >in &&
+		git pack-objects objects/pack/pack <in &&
+		git multi-pack-index write --incremental --bitmap &&
+		test_line_count = 1 objects/pack/multi-pack-index.d/multi-pack-index-chain &&
+		git multi-pack-index verify &&
+
+		echo another | git hash-object -w --stdin >in &&
+		git pack-objects objects/pack/pack <in &&
+		git multi-pack-index write --bitmap &&
+		test_path_is_file objects/pack/multi-pack-index &&
+		midx="$(midx_checksum objects)" &&
+		test_path_is_file objects/pack/multi-pack-index-$midx.bitmap &&
+		git multi-pack-index verify
+	)
+'
+
 test_expect_success SHA1 'warn if a midx contains no oid' '
 	cp "$TEST_DIRECTORY"/t5319/no-objects.midx $objdir/pack/multi-pack-index &&
 	test_must_fail git multi-pack-index verify &&
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 86beab1dae..490008d1d7 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -305,7 +305,7 @@ test_midx_bitmap_cases () {
 		)
 	'
 
-	test_expect_success 'no .bitmap is written without any objects' '
+	test_expect_success 'no MIDX or .bitmap is written without any objects' '
 		rm -fr repo &&
 		git init repo &&
 		test_when_finished "rm -fr repo" &&
@@ -318,13 +318,14 @@ test_midx_bitmap_cases () {
 			pack-$empty.idx
 			EOF
 
+			ls $objdir/pack >files.expect &&
 			git multi-pack-index write --bitmap --stdin-packs \
-				<packs 2>err &&
+				<packs >out 2>&1 &&
 
-			test_grep "bitmap without any objects" err &&
-
-			test_path_is_file $midx &&
-			test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
+			test_must_be_empty out &&
+			test_path_is_missing $midx &&
+			ls $objdir/pack >files.actual &&
+			test_cmp files.expect files.actual
 		)
 	'
 
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index f0b82b5f65..fbcc19feeb 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -195,4 +195,79 @@ test_expect_success 'non-incremental write with existing incremental chain' '
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
+			git multi-pack-index write --incremental "$bitmap" >out 2>&1 &&
+			test_must_be_empty out &&
+			test_dir_is_empty "$midxdir" || return 1
+		done &&
+
+		write_midx_layer &&
+		test_line_count = 1 "$midx_chain" &&
+		git multi-pack-index verify
+	)
+'
+
+test_expect_success 'skip MIDX layer with empty pack' '
+	git init empty-pack &&
+	(
+		cd empty-pack &&
+		git config maintenance.auto false &&
+		write_midx_layer &&
+
+		git pack-objects $packdir/pack </dev/null &&
+		cp "$midx_chain" chain.expect &&
+		ls "$packdir" "$midxdir" >files.expect &&
+
+		for bitmap in --bitmap --no-bitmap
+		do
+			git multi-pack-index write --incremental "$bitmap" >out 2>&1 &&
+			test_must_be_empty out &&
+			test_cmp chain.expect "$midx_chain" &&
+			ls "$packdir" "$midxdir" >files.actual &&
+			test_cmp files.expect files.actual || return 1
+		done &&
+
+		write_midx_layer &&
+		test_line_count = 2 "$midx_chain" &&
+		git multi-pack-index verify &&
+		git rev-list --test-bitmap 2.2
+	)
+'
+
+test_expect_success 'skip MIDX layer with duplicate pack' '
+	git init duplicate-pack &&
+	(
+		cd duplicate-pack &&
+		git config maintenance.auto false &&
+		write_midx_layer &&
+
+		git rev-parse HEAD^{tree} >in &&
+		git pack-objects $packdir/pack <in &&
+		cp "$midx_chain" chain.expect &&
+		ls "$packdir" "$midxdir" >files.expect &&
+
+		for bitmap in --bitmap --no-bitmap
+		do
+			git multi-pack-index write --incremental "$bitmap" >out 2>&1 &&
+			test_must_be_empty out &&
+			test_cmp chain.expect "$midx_chain" &&
+			ls "$packdir" "$midxdir" >files.actual &&
+			test_cmp files.expect files.actual || return 1
+		done &&
+
+		write_midx_layer &&
+		test_line_count = 2 "$midx_chain" &&
+		git multi-pack-index verify &&
+		git rev-list --test-bitmap 2.2
+	)
+'
+
 test_done
