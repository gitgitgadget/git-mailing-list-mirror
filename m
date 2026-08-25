Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3C481A94
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668232; cv=none; b=UyWWc8M7d13qYqO11aoJYbrc23f5DJcSyXiNS4k+fgE23uOmyLKqQddEljDo7KsJoZ3JuyeErjAGl6HmcQFSd8QB/ItVHPDcj//v42sMzxG32xHKet8B0M7F6Dtz+8BHqei9MBcuH5A/tdYVRp3HtWXlue09+x7gfaoJJ5zgKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668232; c=relaxed/simple;
	bh=u5q4FHNMqfgGucL/HK5IEeIFPWVBMddCOq8X7s7ceWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ny1I3e7wqczB7lVR0AWPR0H8CvEiy02Mhc5LzoDjJAQYICfeK43UCTVANugBgGMRDL5O55UtzUHMmXAptS3fmhxZbr6J+ET4J4DIRSVaBWSkZ1f0oA1acOde2oCdcZ3jPt02YqqSZWrOA/W/h1Q9dFN0k4zZ7iSl+moe2WFsg84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LS8eNWU/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GBZBbLFi; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LS8eNWU/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GBZBbLFi"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1852D1D00123
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 25 Aug 2026 10:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787668229;
	 x=1787754629; bh=yueGcid8xVTPkxd3NNJ5Uf9jgyiY1rbDp8u/8N1G7Z8=; b=
	LS8eNWU/HeeB6GtYwUJSceZVPt1yeqr/pKHWRu8eMMQMi7mZrR7ZuhNtvMyfC3ra
	ulAnhPgK+t7TYLWoCRixMsxVeYVD8S9OD75r0EXgwcYaCNnw97AOFgtp0vc04vqw
	yxoDURQ961LomtNO2S2IMokx2y85Pb5lPfd9uyXywnhq4y8c9ImT77UNAK3TtNx5
	s2rkQQ0onmgOVaXfarWIy8T4EhTZEIz44toSeFkU8eT1z4FDbQXK/NYfyrRdUyoy
	ftvoHZjlbhOqNaB/00a0jYLtGk2j0p1hogpxymKqhf2QYHbxnsswO7eY/Shb8ONJ
	YL1RR66JRptojt6Sni8OtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787668229; x=
	1787754629; bh=yueGcid8xVTPkxd3NNJ5Uf9jgyiY1rbDp8u/8N1G7Z8=; b=G
	BZBbLFi2RiUvnQcUeeGYBS0Qv/M2rC8pa25pbEAISWk2sb2TmeCOThswRQ8NzeDT
	Dl6oT7UYjeG5+7JXTLu8N2zO1d+9qJWIpokjQiu1FUEaCchHfcNgq3UoMnmbpSNI
	xIjWW/v0DMPeZYZA3KRoK+DW8nVO6MM6Aq//6y46RIRetbM7KJbO3EBNyghwyN85
	dgZ+BOVzdqugDAZW+du9dzMLZXTem6ID9k5VYBjgBMW9RW206ZV/TIrFz4voSI1c
	bls2EfbheLeVauznqSyvyiCxi/HNEZXBZR4zl8o2w6XvYJCSzwGjfh6kIIbmPHuK
	LFrLwj8KPvhmowUR2p/Jw==
X-ME-Sender: <xms:BaeNagB7PNcuHd-v7ERbqFWa3YkGmEhhuKVfzvMrmo7p-yM41nspuA>
    <xme:BaeNapdz4gX0bOWpX0yp90-DbrlQ9E9tqucWsdSHYOSL4i32E20sPkbs-oYc14_xd
    nUNecehMnRGDDnLuKtqw6kvKY0AGBosyzL46FBcFiPIrsaOS7RSow>
X-ME-Received: <xmr:BaeNapNMm_Il6bu2ZnUC-Jk-ITlvNYZFBYwsiJzRwiUbh0y3lzMUqoCHqr7k5tCtrQdAx9W0fcgEqp0bVvlKkPcCVeViWLO5heGhNB5oqg>
X-ME-Proxy-Cause: dmFkZTGOmSEoA9+neI+y6KiFqVXJj0lCm5MyPrg5bG3mwmIfeptIuZK7pOspHB6dr6A3jw
    0b/nHilbJLti9juHqkQtupslXwSfMeDhLeTytcgAkgbV5IYLLNRDfbNZwb8KKAtTqC7BGu
    RkE7+oesP2tvNj31/eakZnAWVEErj3M2qF0Lr2Tnt7Be2UkyMqYngT1/WrI2kQn2isyTAn
    XQBfDsHBrb4V+jW4kTy1dcwAq5rnGQeLikoGIjyTQHK8hFdW6U12c6P5gTTsozsE8NAAfa
    Z34rMM9NxT8cpJVaHMuMXC8bYMvWvlH7A/119w9iGKyCoQJIG7KBeAj1ZQLj0M5keapHRp
    iNuphfSWhOU2UmNwJvxjGVdIwdpIb5hEc5twwFjKqwWWGSpV1TH1AGvWiTFuYu4BuzS1NW
    uULq8am2wJV0gpIwLm3DzSrLzo2VRyw9e+WiXUZCzHa7yrxSn1hYOjIDW/tw+SO8ml11Yh
    4wztUrqFjhxfNQwY/ARw4DoaquH6t9N7It5f8aecG29Qc9JeEpLbIdKt+8gqXd7hpKkU1R
    1uk2cjm7w2FMxKBujQGI5nKHEkhafQgj1OpckOK1kU2hcFO/NNb0rvPBwnIlxUKsl8lsBa
    Ww3SbE1Sy+H9VdF6SMV06sblMy/p6cpo+NgpYT+Ahq6c34u0jh6WhEPu2ujA
X-ME-Proxy: <xmx:BaeNar4t5Uy86gc8j2oWnFOBG6R8gBbQNKtxQnxDCnoL4zyI7Q1CVg>
    <xmx:BaeNalIj-jTsPT2f195UYCiA0lODBNv7oZK0KI6aLwpoqGOUdyblzg>
    <xmx:BaeNateif7fNcJJYIqQbN59NlHK2bMD8tNXM-lo2JYkA0AUObYteUw>
    <xmx:BaeNageJ2Gx2M8DkLydF1YxmnP1gzYC-hva9aY38YY_wZDdUgrWZvw>
    <xmx:BaeNarBomKyBhbVc5qGAuulEm7VW-B3sN23BuOeMqX7C43jUwksGQHHP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9dbbb008 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:30:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:30:09 +0200
Subject: [PATCH 07/10] builtin/fsck: move reverse index verification into
 the packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-source-fsck-v1-7-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The checks for reverse indexes live in `check_pack_rev_indexes()`, which
is hosted in "builtin/fsck.c". These checks are obviously specific to
the "packed" backend.

Move the logic into `odb_source_packed_fsck()`. As in the preceding
commit, drop the dedicated `ERROR_PACK_REV_INDEX` bit and instead use
the generic `ERROR_OBJECT` bit.

Note that this changes behaviour in two ways:

  - The checks are now skipped when "--connectivity-only" was passed.
    This is because we don't even run `odb_fsck()` at all when that
    flag has been passed by the user, and not verifying data structures
    of the object database matches the documented intent of that flag,
    which is to only check the connectivity of reachable objects.

  - The checks are now skipped for non-local sources when "--no-full"
    was passed. This is, again, in line with the documented intent of
    that flag.

Add a test to cast these semantics into stone.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c           | 37 -------------------------------------
 odb/source-packed.c      | 39 +++++++++++++++++++++++++++++++++++++++
 t/t5325-reverse-index.sh |  8 ++++++++
 3 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index e504dae904..06e72877f3 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -23,7 +23,6 @@
 #include "run-command.h"
 #include "sparse-index.h"
 #include "worktree.h"
-#include "pack-revindex.h"
 #include "pack-bitmap.h"
 
 #define REACHABLE 0x0001
@@ -51,7 +50,6 @@ static timestamp_t now;
 #define ERROR_REFS 010
 #define ERROR_COMMIT_GRAPH 020
 #define ERROR_MULTI_PACK_INDEX 040
-#define ERROR_PACK_REV_INDEX 0100
 #define ERROR_BITMAP 0200
 
 static const char *describe_object(const struct object_id *oid)
@@ -890,40 +888,6 @@ static int mark_object_for_connectivity(const struct object_id *oid,
 	return 0;
 }
 
-static int check_pack_rev_indexes(struct repository *r, int show_progress)
-{
-	struct progress *progress = NULL;
-	struct packed_git *p;
-	uint32_t pack_count = 0;
-	int res = 0;
-
-	if (show_progress) {
-		repo_for_each_pack(r, p)
-			pack_count++;
-		progress = start_delayed_progress(r,
-						  "Verifying reverse pack-indexes", pack_count);
-		pack_count = 0;
-	}
-
-	repo_for_each_pack(r, p) {
-		int load_error = load_pack_revindex_from_disk(p);
-
-		if (load_error < 0) {
-			error(_("unable to load rev-index for pack '%s'"), p->pack_name);
-			res = ERROR_PACK_REV_INDEX;
-		} else if (!load_error &&
-			   !load_pack_revindex(r, p) &&
-			   verify_pack_revindex(p)) {
-			error(_("invalid rev-index for pack '%s'"), p->pack_name);
-			res = ERROR_PACK_REV_INDEX;
-		}
-		display_progress(progress, ++pack_count);
-	}
-	stop_progress(&progress);
-
-	return res;
-}
-
 static void fsck_refs(struct repository *r)
 {
 	struct child_process refs_verify = CHILD_PROCESS_INIT;
@@ -1104,7 +1068,6 @@ int cmd_fsck(int argc,
 		free_worktrees(worktrees);
 	}
 
-	errors_found |= check_pack_rev_indexes(repo, show_progress);
 	if (verify_bitmap_files(repo))
 		errors_found |= ERROR_BITMAP;
 
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0d3599f8fe..e5e69636dd 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -10,6 +10,7 @@
 #include "odb/source-packed.h"
 #include "odb/streaming.h"
 #include "pack.h"
+#include "pack-revindex.h"
 #include "packfile.h"
 #include "pack-bitmap.h"
 #include "progress.h"
@@ -861,6 +862,41 @@ static int verify_packs(struct odb_source_packed *source,
 	return ret;
 }
 
+static int verify_reverse_indices(struct odb_source_packed *source,
+				  struct odb_fsck_options *opts)
+{
+	struct progress *progress = NULL;
+	struct packfile_list_entry *e;
+	uint32_t pack_count = 0;
+	int res = 0;
+
+	if (opts->flags & ODB_FSCK_PROGRESS) {
+		for (e = packfile_store_get_packs(source); e; e = e->next)
+			pack_count++;
+		progress = start_delayed_progress(source->base.odb->repo,
+						  "Verifying reverse pack-indexes", pack_count);
+		pack_count = 0;
+	}
+
+	for (e = packfile_store_get_packs(source); e; e = e->next) {
+		int load_error = load_pack_revindex_from_disk(e->pack);
+
+		if (load_error < 0) {
+			error(_("unable to load rev-index for pack '%s'"), e->pack->pack_name);
+			res = -1;
+		} else if (!load_error &&
+			   !load_pack_revindex(source->base.odb->repo, e->pack) &&
+			   verify_pack_revindex(e->pack)) {
+			error(_("invalid rev-index for pack '%s'"), e->pack->pack_name);
+			res = -1;
+		}
+		display_progress(progress, ++pack_count);
+	}
+	stop_progress(&progress);
+
+	return res;
+}
+
 static int odb_source_packed_fsck(struct odb_source *source,
 				  struct odb_fsck_options *opts)
 {
@@ -870,6 +906,9 @@ static int odb_source_packed_fsck(struct odb_source *source,
 	if ((opts->flags & ODB_FSCK_FULL) && verify_packs(packed, opts) < 0)
 		ret = -1;
 
+	if (verify_reverse_indices(packed, opts) < 0)
+		ret = -1;
+
 	return ret;
 }
 
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 5493791938..6b81abf663 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -204,4 +204,12 @@ test_expect_success 'fsck catches invalid header: hash function' '
 		"reverse-index file .* has unsupported hash id"
 '
 
+test_expect_success 'fsck --no-full checks rev-index, --connectivity-only does not' '
+	test_must_fail git -C corrupt fsck --no-full 2>err &&
+	test_grep "has unsupported hash id" err &&
+
+	git -C corrupt fsck --connectivity-only 2>err &&
+	test_grep ! "has unsupported hash id" err
+'
+
 test_done

-- 
2.55.0.822.g20453c30eb.dirty

