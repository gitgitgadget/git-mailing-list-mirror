Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6803BFE42
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158801; cv=none; b=nZsZt2K5A0qW5C1lMDzIoPvO1C14Cgv/OQfmKXylMtyM0LFYq75qCMhgH6NMa72QHKN/vUbJU3G0F3fDKB+NI7LxIwx8jdzKdLer2xugXLUV3p5jo5xihY2iDPZTdEvqwGRc08YxqufirUkVQwwRHdOPMsux8jvqLtJ6WcYECww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158801; c=relaxed/simple;
	bh=378SWtAY/hPKMGFELT3fAiVvd1eWUS3pkt9AlS53DJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQHNWmv2zulNq2wmv0X7GMhpUy+AO3gTiIG9/G14foZAtdhkhBgfvLt0bHMfYqEue+dJR0SSEFyEnDfUmEKBj8I85TlXVKZZ6AZ0v1uApQ2wFj+za5+3JTlrvpxxJgWvq/Leamg5pPDG1yUUI/3gwZQiB416z6n4jRwLtpSQaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VmurycX/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRY2UlNM; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VmurycX/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRY2UlNM"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 66FAD7A0115;
	Mon, 31 Aug 2026 02:46:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 31 Aug 2026 02:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788158799;
	 x=1788245199; bh=+fXRGn41f36BPzXXMtr6vPCbQ+JHmu3XmQdUVmV1hz4=; b=
	VmurycX/NNYz8IVlR5kTVzTsZPysOnLMI0R6D952gAV7MCkTFksQnVgdE5MZqCw8
	wNsKfLMS8ckGaOVBQY3DBl9pp3cW3lxJjP4zuIqV84QOzbc68TfediyHZKV/jeEC
	JUIomzQnBSUSsrauNFaYFUU2lgaM85Zg/YJS9vYDlF7cwcC6WbCidXcG+wNWqaFF
	GgI4Es8JSF1aKP5TRKVY6x3+aTC8bVjTp9eMmm+T/PXSlEeQVkLV9ublHNefNIpJ
	L+pGRmpA+ZSN+RuHOuyM+h0Osuy5dma7pNesAQYUxdFru+ozHTRg6viPzRiTJz3/
	FBJn9L2huNxKZGmdEmT7Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788158799; x=
	1788245199; bh=+fXRGn41f36BPzXXMtr6vPCbQ+JHmu3XmQdUVmV1hz4=; b=a
	RY2UlNMec8/tkHx4d5fNnXwnAqJ3osWWKWc+rIIKt9aOB1ElTPdcaN33oT9Z/UHW
	cePIQLuvBWsSVyqM5tEP/7wX2au5AJOzlQ7MOFj/SvVfNtGZPbHdvTJS3Yk1bZfs
	NrlQf4xSob34ZlG5Yv+p4SHQ56EvYk+Uiqxr5w7ewkeehtaU0pvF1TNNma1OUzs3
	GMnx+tAXj5WRaSL5mHyOUeBWjbZf+dwesuv99NJ0KDf3+nsd7zgMoCwgtXmaOQYA
	xlF2JUO1exSvqQJ7cdXlMKxAR/jmVg+DEmOUCLOiGWcKbq3qNxaSGW+DaBhV059h
	w13kAmumUojh19x81UTwg==
X-ME-Sender: <xms:TyOVavATJfJXZTQG82CGuukFCAurfPdhyiB1Cm78Z_2h0NKu2fdUog>
    <xme:TyOVari8hsMyweBHM-Vwkzla3_SvPOqaqCn1IPQlIz2U_bF7WYvKa1SO8kVUDlI0C
    8LhRhmSKGZO52oULHZYmY3_KkwvQKxi-Ju2SI0YR22p6ft0PUcXng>
X-ME-Received: <xmr:TyOVaoOg1AtxCj8pDLAEnR5JzO-XXN00NCBt0xBpdG56Xb3JkwNxL7Vj7Gufpc354DY2zA>
X-ME-Proxy-Cause: dmFkZTEe8Ul2EjrCFwZwZRteSgzNuGZPpjwE5XvdpqCiCgejnbpZ6/4kYWOHUYmrmSOL6v
    kcQ9hOiQ4wIuHMdDilFzR2+Nn+AIfFqF9HKYh9awvOZmsFG01v+WklRv5mOn52sB+IuH1l
    QcAR09GApEyqJPpFQDqxf5/Gv8hnFXEX1O+RvZbJgbqOYMv155bmNsH+eSN4UWBKZVwtfL
    Gfl/NksxGC+5xFypYtI0oLPXEnoPYYhPk/+MgHZHll2Spxj3xTLw/tN22zrAk+NNTtPt/n
    fEGqcT3eMagJzWMJJ62cnjJVlZbbrC8XjNQ5n+DR/WKSlBTLa558KbJhldd8eXQo1ZMHn2
    pF1zmgFrKDm3vjyFt67Fa/aFZmr/0IliyKl1iCPQcpWkPJ43OUDZ+/5T6FG+EsQ/X9vVoC
    jdP69VcT7p7MzhyH6qe7Zdp4dZpraOvpOk5+qOruXJxg/rzQdURb+zGJPFMDPKIG9YtC50
    hJSxlrYI4dSAONTKwtEpjYcX8PRr4IKYKprP1WdqNWfTXb9iiF712bpUku7ZLwHjcRqeyB
    /i9vC17GfbkEc1UOciL7QAjEm3VoiKSA8N0uku/MKdX67rUvg7BLoDyCszMMTaXM/H3IlQ
    fcbXQjlB2YYHSv0p/xcC1CyZEXre+/rwa3z0FXmZtofERqYmpZUSMxgas9OA
X-ME-Proxy: <xmx:TyOVas5SXMwGsg2-QvQKQMFQwf56kfD4NsNq8ViElFlc5tfdEwr6CA>
    <xmx:TyOVam3TYtk_CdmiLve1eZqhBqPSOy4BdBuHnIOj2_pHU27tsVbfng>
    <xmx:TyOVatbeG2XAWNvdDKlNtMD9Eodalcy_L-HIEOII9qeh-NgLUTdpKw>
    <xmx:TyOVauDX7vM1OixW_AiyOLNdRx6cU7C2Qj7hnrMgPRRYdb2ENSPA-w>
    <xmx:TyOVauzN53WeLbfNJcnxb52tEeI00kMLY5pPDbw1FYs_aU_sEhPxjN3Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:46:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c7f3d6cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:46:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 08:46:21 +0200
Subject: [PATCH v2 07/10] builtin/fsck: move reverse index verification
 into the packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-source-fsck-v2-7-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
In-Reply-To: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
2.55.0.979.g7e5102b832.dirty

