Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB771440635
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668235; cv=none; b=KKkI+O+W19RWHWb37b2ya+EADpdydouVMkRIvsgqFT94M/AD7I6vhHY8uilcSolMHm9E7JeJacSP4wQ+LyWfJtM69MpE/MzQh5ekL0zp2jTkv4WXP9tNBd6hPH3jHE2uBeVztQreG5+qEFmIZ/30cDv/vypQjrgMwYwCTd/4vQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668235; c=relaxed/simple;
	bh=3KVVkcQ6ThbFrgJqz6bByZ/epauilCfKh4R/U9oAnUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drPVykT0mCEQXVMokvkFDNRs/VcEVGXlEyAVgk8U9pPepIXk+TM3LHgc0f9eblQyXMVX6qZBpNL8InxHuLVldnBAhe/aeTIQ/hfXaIACi8g9K8U50hhqZwHq5OsNpwGR4MEJrziXDREIghD8nNZJn0swKqArrDUksA5TECtaffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PYxuKqNg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9SfXxGd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PYxuKqNg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9SfXxGd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DA821D0011A
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 25 Aug 2026 10:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787668232;
	 x=1787754632; bh=V/PoEgvCYiWm+jV2cCQC+YVxtH57oOSg2ooe06YHSGs=; b=
	PYxuKqNgBfZ58zeCxhqVnsM05tJ3JuRyoTYR1ZzbTbRC24u5U7kFbtZTCrKGRYl+
	Dzn59sS9JdMF5Eok50Z7giTEAl9gZBh5/wukQN6tdVvrYEcprGUJkkdKDhiGGxhX
	t11+uNlENgoPQd9jmUwpgb4OCJRMlxYH3oSDsF/nCOSDbLNjSc8J3uPa6ep6A8+4
	6VCdZcVebd+eHaHhmmrVbTx/eu9ZDf+y2uvxIZi+nQsmF/HC5WJ8S53wLn91SfIF
	K30vj2Ht/ZolqAE7HizfQCDnwQVE7FmKJpN72nsbLiQ+YLQKXBwLARMQXZjqN1d+
	XmhstcMeNt7JztmIkLNbFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787668232; x=
	1787754632; bh=V/PoEgvCYiWm+jV2cCQC+YVxtH57oOSg2ooe06YHSGs=; b=U
	9SfXxGdkMWJXG5darUi5hOkLzWe2JKf+0RwwO7+ERALGmRxODUWJi+Ct2IzZt2VY
	Lc+oRS/x1Ehu41auDUok9obnxeOtrRsSa/UFkpsJrM2jdcyJ4oOiye7lnC4udSwP
	rBaBC51IXU+9mtdmLl5XOCb7AZbN/7jZcDV+Hl3A/EwcbI2tXpwQAxI7LJx68iFq
	gkjXdd0JjFDBzTrcZoxx0AZ0R0Mp/rROznvA7fjagFlY7ySmVQ6z6a8HRuc+Hu7A
	+ppt/q+CY8GZSWDik2bAVKJi/fKaftsNYRq+AhIfUDD9DDos3a9OILd0jblNzJ7n
	o0oqPKL/uq4D6NirI5h9A==
X-ME-Sender: <xms:CKeNap6aSGnTcPOy6Zcc_P5gbPUKj0Pp60mEIeEb3WxkjlWdHWRpuA>
    <xme:CKeNat3dG0Pz5oG_XR8ldAqIfrTSjeH_xpktiD7bGhKbcJdPX0z4OOZIuCCUA4Djz
    YPlF81k3n9bhQ5TYLpUVBiR6HzLSRjzn6gR4XC1ghbBkBThjWNw1fI>
X-ME-Received: <xmr:CKeNamFwEEZoggH90vWvh_v0gKB8MnY_mHTzKLo4OYrsAAnNcKHqYE3d6_odSgthyrdQfpT49n5I8EOPObgl9nA-8tjWQUAyoEOUSt6G1w>
X-ME-Proxy-Cause: dmFkZTGjEr9Entbw/LdH1oPRcQy4kfu4RbSZvb4vUdKWZEwL4+rS3zFFf/CQulkEiyWsb+
    SKRbqpNpID3T1jEqO07fEkVdT7k8FrOxZjkpdkYm2mWU78qKFUJzMpKQhmkOpG2IHwCErY
    f+PGMcUoX7DR6tT0I34RzrRVZOGeht69oOxUz4q+t4Skwullivpyt67JK199B8iqnLGwhK
    OmKhwtLnLe9fBvXtohjF+ztYl/sa925tevsAXEH3nc7aYOxD0XgEUCCyTdqmWkxA6UTb9Q
    ICJOOFMerSjMLUELDwtlUcZO5OusVe0mEtKW+xzGe7qy0RBak4GVSEHgPXU15C+2Q4dYIA
    dI9G+JpHnDOIWL2dHzS8vFuhnfGQHW8uglW7t6J/Y67RZIZMyWP0gPOmbHgeQvrZDKlY2E
    VGILOgih5NjHgI2fDglNYhvYrC53I8B4E+UGBv+yaS2QZoRADY+4aoPUKC+sh/lm3hXSua
    BxWF/QgL4YNMb8v4nujhJ7EsWQasPeZgBWhSR30OhPsGkXs700Jo0bgTI1STSu8mxondoB
    JwSEElEUMLxkh/d7TE6lyMBEJ6HdyE5x+6SL1Io1YlRYznhG0JUgaFOSxlkxNtbRzzzaCm
    Fayorw6pWoSSAvqioOLlU/l9MgI80L5x5NSMp7CIaPZr0lockBvu03rp20tw
X-ME-Proxy: <xmx:CKeNanSA2LlBk7p1-icHnzy_reG9WY0UVGSiboD-7uJpKWARLHJp4w>
    <xmx:CKeNatDeq0jV1CrGkSiJti_GBbUN1MDzluCC7ue1dxequmRNjFVYhA>
    <xmx:CKeNan2rx-ROSH_XDqaP_GNGRQE0A8Lehfgldt4drqvJ9IN2wOr0wg>
    <xmx:CKeNarVbUVn4_qVPFrtw_3z3aHC5skkF3qAnfpQnk6nmYLW36_f4Rw>
    <xmx:CKeNaubUffeuWPI_f_H9Z20KPqns6OoTD5SqKDxlV92tJGA3M55xvO5t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16924f0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:30:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:30:10 +0200
Subject: [PATCH 08/10] builtin/fsck: move bitmap verification into the
 packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-source-fsck-v1-8-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The checks for bitmaps live in `verify_bitmap_files()`, which is called
by "builtin/fsck.c". These checks are obviously specific to the "packed"
backend.

Move the logic into `odb_source_packed_fsck()`. As in preceding commits,
this means that we now properly honor both "--connectivity-only" and
"--no-full". Furthermore, we drop the dedicated `ERROR_BITMAP` bit and
instead use the generic `ERROR_OBJECT` bit.

Note that this change also adapts `verify_bitmap_files()` to be
focussed on a single "packed" source instead of verifying bitmaps from
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
2.55.0.822.g20453c30eb.dirty

