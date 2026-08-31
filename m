Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9963C0A13
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158803; cv=none; b=Q6ayxRY6Nh007DxFj+7e2NcTMbhQsHTGzgP7JUqdSIDQ0jWwGkrsTjZAbl7XeF2eYCc/pE4XsB4aQNp7ZopHCQB0wATT7XyCvBhV17uvQce9k09vAjBq8bVLI/nYkLahhIyJPj0nz0sJcXdqEjP+jA9fCx11NVmfXzn6oBvUJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158803; c=relaxed/simple;
	bh=CjLA8HVUtvR+TUmKRQJeRe/DDHwvJJQJl18ylsyGR/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZR7lF0VpZiYAT9mwZAVrnpzai4pZl5h8zpn202ZeXIvu8kS2JqLchI0tFLlj2bKjM9ybAR5ba58Eo9QtNYxKtBLD/I3o9O+RQ9zeAlrVvB23sooGOw/kAOy7J1iQo5TldDE7neSOC4W9YShymVn/b0YttLlybK0fquiBbZ6PPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xhq6Z8nB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kG2lg2Z4; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xhq6Z8nB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kG2lg2Z4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A3A21D00138;
	Mon, 31 Aug 2026 02:46:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 31 Aug 2026 02:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788158801;
	 x=1788245201; bh=UGXm0bCIsDRRLXrblUFPhL5oL5LWCMME6Fp68+gf2H4=; b=
	Xhq6Z8nB6dsoXWhtfdepgKN8X1YB7UfpGqLDaGEt4bcaOP6fBBYWO2Rsa01QhG68
	M8v26LVoWWMeZky6nOz5gOnTknCCUOzgr1UQ0lVwNxrBqaCq01N/pgswiqEmLSAC
	MW/eaczugKy0KfJBfCYXlcJlAqQsjLEyWxMntW+N7dM7WOtkYr71LiV2TK6lxfuZ
	XJPXpurhBdIMUz4C8dkWcM0cGbQi1SlG6v89v3v2q9qlMIEm6btletYnC8DdcpSN
	xXjdTNbFZkyx9mZYdO4XtMpGFvg7fh2Age7g2Dc55CGbueFZJF2x2VJqi0Dmd3ZL
	EYOH+iQlDrxdHQmbNcUvXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788158801; x=
	1788245201; bh=UGXm0bCIsDRRLXrblUFPhL5oL5LWCMME6Fp68+gf2H4=; b=k
	G2lg2Z4sH2nSqbfgiCA21lxUGuhRyNkyrn5yKZUEmuZI2OBGMDo9TKep7MLhqcBY
	mMGNBRne8fjOA/6J9cnH+UB3zRf6RWtMyySYdt63eDDIpu6O649qSQJBMj3X0KYC
	k/crXW3HlcRRboRrK62Qd2PmQ0Ij1WGaHUCjHKu26e7KApMK73W2Fu7g2bZKgJi6
	VLnQP79mK/MCYZHzREcr0irltmwmcQHU9ZXdL1rm9km14CInJeDIqh6tjjxm6lcg
	Mwx3ajb8AwFzx/a/f334FMP++Vo0vm7UxYA2doPj25DLlqAFP+o4DwLZBunSgGld
	3T3F2ADkiPg5+Y9zOVcRQ==
X-ME-Sender: <xms:USOVapxbulwx2qf8f2WRsn_7rkvsU6tVa6s4Zsn3typUL0B4wS4NFA>
    <xme:USOVavTICn6jJLapld9y4rM8UYd4nRFF80QI2U87OiI9Xtu_1xK3ZfjiQ5WosN_gc
    b2zi2qoY02cE84i5BK6g1JsCdYiTtZLoQLkebn3kdsKuHXur0N-Rl4>
X-ME-Received: <xmr:USOVag--W2gq-A-tAEe-oh3PIu25ItlbDcDh2xe4aDOGgVXUNoHwMyQIqg-IJQvm1Cp4Gw>
X-ME-Proxy-Cause: dmFkZTGLrLfDR2QysCD1sy02sCIscVXYgf7HnQNb0oRy2AstlcT8j//StZGRQxtK4z737z
    jEkccgktQSvlsoWH51ayjElXLfFiJlE9Ld2yCvQg9pvtZJRb0kuEjfTelMb298HIQ5Sap3
    OR/LCLdgHsRTUOb7siL+bdcMOFnTQzmurZWmfyQxXQ3aPeK+K3gFY+G88APxnURU4Y5rPW
    hkQfMtR+f0D5fYF7sGNl+qsWHb3/ITM4SpBPQfvcBFnrTlTuPZ7aQbNXxajOf/wPRVXwG4
    QPKJ5gzoK1oCCo/ATkfIKod9SoHmei4GGYxeSeqkDxcDnAScUkfEbZ5rhFXJGd1EX0vbiJ
    vna/su2jogcWRKgoH+gadJZ+P9VW3WvKQr4lL6yXc6EfTxTmn63+CXag+skslQj0Ldx++h
    BZUvgdQ7/w+txNYfk7af3eHZUWxkETeFnIu+EaO+ool2tewavljKupU489ukUMku3DgvLj
    YoE5FzC0vpjkCMHOqPH/PV2MCFn8iI5stJFSViAQFkFeGgEkrH1xHUdQ/ygrpVUZUI3hx+
    waIckylZgA2OId0ShBK6Wlc8nQo7e8yHnAkTqS8YU7ETwTjXpLSoQD9DugYckWgeMu2z2a
    RVJY7bzO3y0Nb2+pFikuJ/omTgl7lVta7PITn8MamK1fKJV3B6C27dh2ptUA
X-ME-Proxy: <xmx:USOVamqvfzt7lFQx79MxQNrXD1zRs8dwbI25lviufpBVeUUYcG-QBg>
    <xmx:USOVatlpdZj9zPcaFA22o-hlgBm1JVeCNsa6Zz27udGSIbsTrpQ86w>
    <xmx:USOVatLyusZ1ZHbdiTYMKZOzj2mpSYgDCL2l_otZWN9gtOnF1KGBvA>
    <xmx:USOVaizC7mR9bf7SX_ucLE8sLIj6fQjfwdIqiI2_c2GDGvC15wBKXQ>
    <xmx:USOValiw1O2wd2bGi7TGtaV_hr0AtEkos9gOQHp6BpW4hJ6I0jxRlCQX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:46:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39eddd4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:46:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 08:46:22 +0200
Subject: [PATCH v2 08/10] builtin/fsck: move bitmap verification into the
 packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-source-fsck-v2-8-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
In-Reply-To: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The checks for bitmaps live in `verify_bitmap_files()`, which is called
by "builtin/fsck.c". These checks are obviously specific to the "packed"
backend.

Move the logic into `odb_source_packed_fsck()`. As in preceding commits,
this means that we now properly honor both "--connectivity-only" and
"--no-full". Furthermore, we drop the dedicated `ERROR_BITMAP` bit and
instead use the generic `ERROR_OBJECT` bit.

Note that this change also adapts `verify_bitmap_files()` to be
focused on a single "packed" source instead of verifying bitmaps from
all sources. This change is required as we already know to loop around
the sources in `odb_fsck()` itself.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c                |  5 -----
 odb/source-packed.c           |  3 +++
 pack-bitmap.c                 | 26 ++++++++++----------------
 pack-bitmap.h                 |  2 +-
 t/t5326-multi-pack-bitmaps.sh | 10 +++++++++-
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 06e72877f3..2f7d29aa56 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -23,7 +23,6 @@
 #include "run-command.h"
 #include "sparse-index.h"
 #include "worktree.h"
-#include "pack-bitmap.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -50,7 +49,6 @@ static timestamp_t now;
 #define ERROR_REFS 010
 #define ERROR_COMMIT_GRAPH 020
 #define ERROR_MULTI_PACK_INDEX 040
-#define ERROR_BITMAP 0200
 
 static const char *describe_object(const struct object_id *oid)
 {
@@ -1068,9 +1066,6 @@ int cmd_fsck(int argc,
 		free_worktrees(worktrees);
 	}
 
-	if (verify_bitmap_files(repo))
-		errors_found |= ERROR_BITMAP;
-
 	check_connectivity(repo);
 
 	if (repo->settings.core_commit_graph) {
diff --git a/odb/source-packed.c b/odb/source-packed.c
index e5e69636dd..2b5dc502f5 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -909,6 +909,9 @@ static int odb_source_packed_fsck(struct odb_source *source,
 	if (verify_reverse_indices(packed, opts) < 0)
 		ret = -1;
 
+	if (verify_bitmap_files(packed))
+		ret = -1;
+
 	return ret;
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index e0fb57d332..3de8e9590c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3410,28 +3410,22 @@ static int verify_bitmap_file(const struct git_hash_algo *algop,
 	return res;
 }
 
-int verify_bitmap_files(struct repository *r)
+int verify_bitmap_files(struct odb_source_packed *source)
 {
-	struct odb_source *source;
-	struct packed_git *p;
+	struct packfile_list_entry *e;
+	struct multi_pack_index *m;
 	int res = 0;
 
-	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct multi_pack_index *m = get_multi_pack_index(files->packed);
-		char *midx_bitmap_name;
-
-		if (!m)
-			continue;
-
-		midx_bitmap_name = midx_bitmap_filename(m);
-		res |= verify_bitmap_file(r->hash_algo, midx_bitmap_name);
+	m = get_multi_pack_index(source);
+	if (m) {
+		char *midx_bitmap_name = midx_bitmap_filename(m);
+		res |= verify_bitmap_file(source->base.odb->repo->hash_algo, midx_bitmap_name);
 		free(midx_bitmap_name);
 	}
 
-	repo_for_each_pack(r, p) {
-		char *pack_bitmap_name = pack_bitmap_filename(p);
-		res |= verify_bitmap_file(r->hash_algo, pack_bitmap_name);
+	for (e = packfile_store_get_packs(source); e; e = e->next) {
+		char *pack_bitmap_name = pack_bitmap_filename(e->pack);
+		res |= verify_bitmap_file(source->base.odb->repo->hash_algo, pack_bitmap_name);
 		free(pack_bitmap_name);
 	}
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 1385027c1f..847ad4762d 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -205,7 +205,7 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git);
 
 int bitmap_is_preferred_refname(struct repository *r, const char *refname);
 
-int verify_bitmap_files(struct repository *r);
+int verify_bitmap_files(struct odb_source_packed *source);
 
 struct ewah_bitmap *read_bitmap(const unsigned char *map,
 				size_t map_size, size_t *map_pos);
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 86beab1dae..8047459b00 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -498,7 +498,15 @@ test_expect_success 'git fsck correctly identifies good and bad bitmaps' '
 	corrupt_file "$packbitmap" &&
 	test_must_fail git fsck 2>err &&
 	test_grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
-	test_grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err
+	test_grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err &&
+
+	# The bitmap checks are performed with "--no-full", but not with
+	# "--connectivity-only".
+	test_must_fail git fsck --no-full 2>err &&
+	test_grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
+	test_grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err &&
+	git fsck --connectivity-only 2>err &&
+	test_grep ! "invalid checksum" err
 '
 
 test_expect_success 'corrupt MIDX with bitmap causes fallback' '

-- 
2.55.0.979.g7e5102b832.dirty

