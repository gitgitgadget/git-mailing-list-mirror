Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462242089D
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208585; cv=none; b=jEgCgbGMxjDjDgGaCwYPOIiiRINQuRM4kkdCd3Il8cjRfg4gLAABIjvl4RWKC5LvCNVsW61+qpYlc6jhpWUaQ6pDWinR2hXYBuVTy8PBLySPdiJYfxGBA1L+Pc6bfyvz7YTrqtBH1cqWN+SUqRBacSuGRx9ubVyvPtxOCd3mhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208585; c=relaxed/simple;
	bh=Oqy/CQEwAcO+3Fm9s62sDo5YR8uMwia9ld+CFVhyIKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWMsph7TfMt9Y2eu01lgSZ/CPrsoA3e+4HBUQZ9v6tve0goUzhtptQaEVwVHVKa0rFvF4sM0Rc+SoS9n7YQr7PaN8OvohGGWiAvdDYuHXrxxuwpx9L6gShOflvOoaT/zaDVag0mR/tnX/cyR2B42/sBjIZn2hm+T1/SBWwei4lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nM/rwDBX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM/rwDBX"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c999f162c9aso4190974a12.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208583; x=1784813383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KpBqtK6L5B7tzZs+3FelA5kJdvWJuTWKkHOggDh/6w0=;
        b=nM/rwDBXDkQWL9rjgCnxuGtqjhZP7t2kVtC6DJYojYqsvaWhXivFWhEHyvbivz1SQe
         zUGT6y/Mn5PXM2smvCQc6NoxayXcD1aJmRmD1nSP6y1PVCzj6uju9RYniCDJhgtf/Uoe
         ZPTcpjD52uIPB8fbrw4tCUdCOvGE+vrYsI2VgxHPgyiZHdfrabqYkfddNnGK624Ft1nt
         onnTiD4o0tSLioOIhC5mrV7+zqtE4FubrZuTAiHulBUDq/nmoNtrtQ4arL2tkBlR6way
         Vd/qSFnKDGUe1L4bGLM9lkPJDfA2x4/mgydpOZiFuoYDGceXE/6/usBHBAQ0mWdc97WD
         5fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208583; x=1784813383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KpBqtK6L5B7tzZs+3FelA5kJdvWJuTWKkHOggDh/6w0=;
        b=S2wafqGMdpt3zzNzgpaGhoFtcTdpqZqXjFHZdIxPiRhuPotRyCq1z0W4CMK4d1ogrp
         lUgAlHYjONGhPVG3+MFSuiioZF3Mkm7LWJ0Sgdpg446NlJXBBmX7UVZ4bNsIDm8RF/nH
         E7PcwwhBXf1UGSyxa2lX3o+YG/TcgSL2MkWXboHeIjiIq+4h27KdFjqScrgRp3goLhGK
         UesMTtXwqvIX0Dm6hht/Kd0cTfUBTNyr3Hsshzbbi/TjWwt/FxkHp6QsL/bhUKC5FjyE
         mE9GNtavuhQoQMoD5ErhKFQZKHkvOlYWNJTR1XTwVrHfKp14Dqlz6Rq9b1zuytVaMzeJ
         5uDw==
X-Gm-Message-State: AOJu0YxjumxeccJZ+H4J8V0rGpw2aGLT48SLp9/gHELtYak9VAXsi/gr
	V7nkmvAsOcQ2PCnN9xEKFBiEsqAT8Kpvp1szdUsTlCtkPT8dgyv1/cSZBkRUFRXe
X-Gm-Gg: AfdE7clcfYG4tlxCSoEh8XW5ZOWPi1ohl4lng6ZCBHocLnvm8AsM+Fjcyr/O6uwo9z9
	cqwjnvS8YQM8ALINJHYlLhbBq/nmEwatD9YpraJNiyqA5snwYujUtvjeloE+LW4Tj8lJE8mKQLe
	qIYKFLM6LXSJbhxQWd5as6zaRsEktWXGNtHk4T0ce1dg5p9EETSAiHc8+CwWygwbCmqcPQu/B8B
	M0Oir+9JR/PTnXUdZa7VHDDTt1jpxK83IyAIUa6kr6mEvxoRbGLZT7Hz3IbKC6nSG59uNrE0IoB
	tejNcSSwP971LXYrCizPvKevBsYfcXCmV+pkqH0UI0fA2Gt/dxIGA6wS2r0z0jujnEBM50+WBAm
	VMSRiyYxrQtUZkCsgNTTDBl+iDn0YpD6ZWcOslwrKt+lFzV15+o6sZ78Xo3kJQaFeclUZHafGas
	05sCMXLt9Z/FkJwmytTTK5u2o88rVffvAUdyljgn63Xy2cC79ULXedUM1hIdDjxUxjXDNR5Im2M
	RUzbenfLYPrM1nzzbNIzKeQN6sGUFJLLPV7Qker4JYLiQXEIFIYsB8=
X-Received: by 2002:a05:6a21:101:b0:3c3:9b44:982d with SMTP id adf61e73a8af0-3c39b44f10dmr1098144637.42.1784208583109;
        Thu, 16 Jul 2026 06:29:43 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fb:4543:3010:936c:4da8:7aa1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd31sm13291188eec.4.2026.07.16.06.29.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 06:29:42 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [RFC PATCH 5/7] t7706: test --drop-filtered enumeration and validation
Date: Thu, 16 Jul 2026 18:58:46 +0530
Message-ID: <20260716132848.95982-6-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for the --drop-filtered option.

  * Validation: --drop-filtered requires --filter and -a, is
    incompatible with --filter-to and --write-bitmap-index, --dry-run
    only takes effect with --drop-filtered, and --drop-filtered
    requires a promisor remote.

  * Enumeration: in a repository with a promisor remote, --dry-run
    lists promisor blobs above the filter threshold and excludes
    smaller ones. Promisor blobs are created with a synthetic promisor
    pack, following the helper pattern used in t0410.

  * Safety: a locally created large blob, which is not a promisor
    object and therefore not recoverable from the remote, is never
    listed as a drop candidate.

  * Non-destructiveness: --dry-run leaves the filtered objects intact
    in the repository.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/meson.build                   |   1 +
 t/t7706-repack-drop-filtered.sh | 139 ++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)
 create mode 100755 t/t7706-repack-drop-filtered.sh

diff --git a/t/meson.build b/t/meson.build
index 8ae6ab6c5f..37f272d7f4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -962,6 +962,7 @@ integration_tests = [
   't7703-repack-geometric.sh',
   't7704-repack-cruft.sh',
   't7705-repack-incremental-midx.sh',
+  't7706-repack-drop-filtered.sh',
   't7800-difftool.sh',
   't7810-grep.sh',
   't7811-grep-open.sh',
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
new file mode 100755
index 0000000000..b558807847
--- /dev/null
+++ b/t/t7706-repack-drop-filtered.sh
@@ -0,0 +1,139 @@
+#!/bin/sh
+
+test_description='git repack --drop-filtered enumerates
+filtered promisor blobs'
+
+. ./test-lib.sh
+
+delete_object () {
+	local repo="$1" &&
+	local obj="$2" &&
+	local path="$repo/.git/objects/$(test_oid_to_path "$obj")" &&
+	rm "$path"
+}
+
+# pack the objects into a promisor pack inside "repo",
+# it is a pack accompanied by an empty ".promisor" marker file. objects
+# in such a pack are treated as recoverable from the promisor remote.
+pack_as_from_promisor () {
+	HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
+	>repo/.git/objects/pack/pack-$HASH.promisor &&
+	echo $HASH
+}
+
+# write a blob of $1 bytes into "repo", record it as coming from the
+# promisor remote (promisor pack), and remove the loose copy so the
+# object is only present in the promisor pack.
+promisor_blob () {
+	test-tool genrandom "$1" "$2" >blob_content &&
+	OID=$(git -C repo hash-object -w --stdin <blob_content) &&
+	printf "%s\n" "$OID" | pack_as_from_promisor >/dev/null &&
+	delete_object repo "$OID" &&
+	echo "$OID"
+}
+
+# checks for options validations before any promisor walk
+test_expect_success 'setup plain repo for validation' '
+	git init plain &&
+	test_commit -C plain initial &&
+	git clone --bare plain plain.git &&
+	git -C plain.git repack -a -d
+'
+
+test_expect_success '--drop-filtered requires --filter' '
+	test_must_fail git -C plain.git repack --drop-filtered --dry-run -a 2>err &&
+	test_grep "drop-filtered requires --filter" err
+'
+
+test_expect_success '--drop-filtered cannot be used with --filter-to' '
+	test_must_fail git -C plain.git repack --drop-filtered \
+		--filter=blob:limit=1k --filter-to=./filter-out 2>err &&
+	test_grep "options .--drop-filtered. and .--filter-to. cannot be used together" err
+'
+
+test_expect_success '--dry-run only takes effect with --drop-filtered' '
+	test_must_fail git -C plain.git repack --dry-run 2>err &&
+	test_grep "dry-run only takes effect with --drop-filtered" err
+'
+
+test_expect_success '--drop-filtered without --dry-run is rejected' '
+	test_must_fail git -C plain.git repack --drop-filtered \
+		--filter=blob:limit=1k -a 2>err &&
+	test_grep "drop-filtered doesn.t work without --dry-run yet" err
+'
+
+test_expect_success '--drop-filtered requires -a' '
+	test_must_fail git -C plain.git repack --drop-filtered \
+		--filter=blob:limit=1k --dry-run 2>err &&
+	test_grep "drop-filtered requires -a" err
+'
+
+test_expect_success '--drop-filtered fails with --write-bitmap-index' '
+	test_must_fail git -C plain.git repack --drop-filtered \
+		--filter=blob:limit=1k --dry-run -a -b 2>err &&
+	test_grep "options .--drop-filtered. and .--write-bitmap-index. cannot be used together" err
+'
+
+test_expect_success '--drop-filtered fails without a promisor remote' '
+	test_must_fail git -C plain.git repack --drop-filtered \
+		--filter=blob:limit=1k --dry-run -a 2>err &&
+	test_grep "drop-filtered requires a promisor remote" err
+'
+
+# enumeration and safety tests using promisor packs
+test_expect_success 'setup repo with a promisor remote' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo base &&
+
+	# mark the repo as a partial clone with a promisor remote so the
+	# promisor walk and the safety guard are satisfied.
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone origin &&
+	git -C repo config remote.origin.promisor true &&
+	git -C repo config remote.origin.url "." &&
+
+	BIG=$(promisor_blob big 3072) &&
+	SMALL=$(promisor_blob small 512) &&
+	echo "$BIG" >big_oid &&
+	echo "$SMALL" >small_oid
+'
+
+test_expect_success 'promisor blob over the threshold is listed' '
+	BIG=$(cat big_oid) &&
+	SMALL=$(cat small_oid) &&
+
+	git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k --dry-run -a >out &&
+
+	test_grep "$BIG" out &&
+	test_grep ! "$SMALL" out
+'
+
+test_expect_success 'locally created blob is never listed' '
+	BIG=$(cat big_oid) &&
+
+	# large blob that exists only locally (no promisor pack) must
+	# never be a drop candidate: dropping it would be unrecoverable
+	# data loss.
+	test-tool genrandom local 4096 >local_content &&
+	LOCAL=$(git -C repo hash-object -w --stdin <local_content) &&
+
+	git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k --dry-run -a >out &&
+
+	test_grep "$BIG" out &&
+	test_grep ! "$LOCAL" out
+'
+
+test_expect_success '--dry-run does not remove the filtered objects' '
+	BIG=$(cat big_oid) &&
+
+	git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k --dry-run -a >out &&
+
+	# candidate blob must still be present after a dry run.
+	git -C repo cat-file -e "$BIG"
+'
+
+test_done
-- 
2.54.0

