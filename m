Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006846A5ED
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668232; cv=none; b=jMO2Wxj6O0SQgkHLR08c2JQekclLncvCCO8kkH2JbuYVZpdi3Dk9Via1zYFhNqJYxElHh/p8YAeQL4mi8pAxHewwRw5VGou9PAmP39Xrk8a9K+0XJnrDo8ID/iYRaJG18DwKUinzJXBuIZokt7FQL7ZKg0xQWEpNK0rRbuHOR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668232; c=relaxed/simple;
	bh=yxiSFYtSAyXwp2kLoqzm4A4O8Uf2TnPzR/df9IHWDr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xl9yJX7p3/NLgrsWUwnXscn7DiqEg/FPe+MrEVrro+JYVLRzSitQkkplCZTbn6mlMlbA23aCTPDeIkczhJoe73RXoYIpegxP/oRsGoXW+HYsdpZAKyyankTRPQEHLjZxrMpFTBvpVwJZgDGPAwTlN7RrNCGR8u5bmMnm3VwiAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cOX8gI4y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YLd4j1oi; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cOX8gI4y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YLd4j1oi"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1ED181D00134
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 25 Aug 2026 10:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787668227;
	 x=1787754627; bh=0/riAKORmE5Q8sBTrcnAQf2PrrXMd5cWgd0lynxOXnE=; b=
	cOX8gI4ygYfCw3Y7kAQgS10Y5HOSGOFnWbjuqiGGiMYNO4rEPbBQkgDbMhtNTXNi
	KgMOjBj7gbc2YnTJlNoQBUFAhexgUFz++3gP1wj7T+jRG4TaVvemeKGSGq1She+T
	WB+MuaRct8T/M4sjiN4PYPiujqJBPuHaJvCKQQa5jNBHflKybGpPGrO0IUUgaJXe
	rjUD6BSZqI6aAXFIALn4qvcVvO8INM3fpbOZm62VMiI8cf8UrupVPhAv0HtoJAgt
	v9Jckcb56JPvu/YZwF9iPtJliDPbVMhHNnKLcc1uYx10L4irr29SBBvgV4+amure
	1SgfTld79ULeQ9JflY9/3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787668227; x=
	1787754627; bh=0/riAKORmE5Q8sBTrcnAQf2PrrXMd5cWgd0lynxOXnE=; b=Y
	Ld4j1oi4xauj5i/jXx/kqsNZlzX2uqDWdoC0Xjvcf7WeRkQpDewOPduMnKJ0EAj+
	/DhoExXJ+nujWDTb/CC6HV6jAKzumBv4XEuPrty4DEbB3GPxKv4TtPAcZ8X1lBZ8
	Dz8++A5wHxQmAAr/ov2cpJNn6anct7WC9mwgWCMqTf/GGcxhV+JoI7m/zilFHeUf
	z8WGxIUs4Lj2OR/MJwbUvXJKRRhs2qJHPgCEB1ORoEqj0hqZN/A9Fw0ewayPx+Xn
	iNKAJVuv1a1olAHhOr7i+LHEccmaMK+YvfTlccrXAWKUb2EiFNFV7MKbjkTI3cfI
	odIMxRfjbJpTkz6QrkUWw==
X-ME-Sender: <xms:A6eNaum8LPJx2bd_knvb6TU4ML2LhKxo72tmm_8TlsECDXBwqN0aYA>
    <xme:A6eNaszZMSqXT9vYyt77AuSH9lIH4_qLXkvtc3yMRb-z5IlBHFt64iOtC4Duorn15
    r3eR8g_QVzdWKPTVhe8G8Yyjyg-7c8XJSQ_AoPHTOnH8qlZPmianw>
X-ME-Received: <xmr:A6eNaiRvGe3EiI3La4iqTVncWt74odBDcvqO7WxyKKDbiUlmvNALAZRFfmq3w1tuTcaebxX1f53c-6QwqluWWdH0cCoTrEUwJDzrJAG3yw>
X-ME-Proxy-Cause: dmFkZTGOmSEoA9+neI+y6KiFqVXJj0lCm5MyPrg5bG3mwmIfeptIuZK7pOspHB6dr6A3jw
    0b/nHilbJLti9juHqkQtupslXwSfMeDhLeTytcgAkgbV5IYLLNRDfbNZwb8KKAtTqC7BGu
    RkE7+oesP2tvNj31/eakZnAWVEErj3M2qF0Lr2Tnt7Be2UkyMqYngT1/WrI2kQn2isyTAn
    XQBfDsHBrb4V+jW4kTy1dcwAq5rnGQeLikoGIjyTQHK8hFdW6U12c6P5gTTsozsE8NAAfa
    Z34rMM9NxT8cpJVaHMuMXC8bYMvWvlH7A/119w9iGKyCoQJIG7KBeAj1ZQLj0M5keapHMX
    LDezsbRF2D7EzfIHChblCfNlxhojRWWu/RXLONd8Hh8qmHWFoNBqxBx30YFY3X3Wry8d/3
    qE6ZJvmFaT13qPTo5pim/qcMkGjDxCjtNQtAT3xanogNhQCsWAB5beOMLXUmbXjhA/lOPv
    9cjpdixYTGEQy6xOg1Dzbpe4+9I16HkRjUbabxYhaMeX2rOxo1MFYWANXcbtMTjhvEoWQA
    ZCqdyeRfAAH4JQk37jLjykFWHavqC5scf0n6CF4y5izE0EoOgI6bwAFMQO/zidWGsavjQP
    YZlVAV8ulPAcr5kwBA69cbLynaqst5mjDUVqWrhC0M+/z44LWEqg2+QG3GEg
X-ME-Proxy: <xmx:A6eNansrVOPeEvARimcaD33Q0tXdftVzLqHfBnQZndC4-G6oY8Xk6g>
    <xmx:A6eNasv6b8qVDOf9kTwQmQa-22IFAPRzp8rJYHEr4DfFXen0DsSOyg>
    <xmx:A6eNalwXz8u1WccFqy8dK3shxxulImaRruPqGot14Wrf9oMVoP_6HQ>
    <xmx:A6eNaqij-DX1p0o9fUSdI7VaMkKbyGjxM-7SPn3-K3RwmtBDtZVdgg>
    <xmx:A6eNaq1PZpbT_n1t6FZaanfX7II1hZsIqujeaTszEcIbAzwqlvAu5Gw3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9b25a82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:30:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:30:08 +0200
Subject: [PATCH 06/10] builtin/fsck: move packfile verification into the
 packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-source-fsck-v1-6-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move the packfile verification out of `cmd_fsck()` and into the "packed"
source. While doing so, thread the progress meter and object callback
through the newly introduced `struct odb_fsck_options` so that the
caller's preferences are honoured without exposing those details at the
"builtin/fsck.c" level.

Note that the old code reported failures when verifying packfiles with
the `ERROR_PACK` bit, which gets returned to the caller via the exit
code. This bit is neither exercised in our test suite nor is it
documented anywhere in our codebase. Furthermore, this bit is highly
specific to the object storage backend, which makes it a bad fit for the
new pluggable infrastructure. So instead of retaining these semantics,
we drop them and return the generic `ERROR_OBJECT` bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c      | 33 ++++-----------------------------
 odb.h               |  7 +++++++
 odb/source-packed.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index adbe192e56..e504dae904 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -7,7 +7,6 @@
 #include "blob.h"
 #include "tag.h"
 #include "refs.h"
-#include "pack.h"
 #include "cache-tree.h"
 #include "fsck.h"
 #include "parse-options.h"
@@ -49,7 +48,6 @@ static int show_dangling = 1;
 static timestamp_t now;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
-#define ERROR_PACK 04
 #define ERROR_REFS 010
 #define ERROR_COMMIT_GRAPH 020
 #define ERROR_MULTI_PACK_INDEX 040
@@ -967,6 +965,8 @@ int cmd_fsck(int argc,
 {
 	struct odb_fsck_options odb_fsck_opts = {
 		.flags = ODB_FSCK_FULL,
+		.object_cb = fsck_obj_buffer,
+		.object_payload = repo,
 	};
 	int keep_cache_objects = 0;
 	int name_objects = 0;
@@ -1019,6 +1019,8 @@ int cmd_fsck(int argc,
 		show_progress = isatty(2);
 	if (verbose)
 		show_progress = 0;
+	if (show_progress)
+		odb_fsck_opts.flags |= ODB_FSCK_PROGRESS;
 
 	if (write_lost_and_found) {
 		odb_fsck_opts.flags |= ODB_FSCK_FULL;
@@ -1056,33 +1058,6 @@ int cmd_fsck(int argc,
 		if (odb_fsck(repo->objects, &odb_fsck_opts) < 0)
 			errors_found |= ERROR_OBJECT;
 
-		if (odb_fsck_opts.flags & ODB_FSCK_FULL) {
-			struct packed_git *p;
-			uint32_t total = 0, count = 0;
-			struct progress *progress = NULL;
-
-			if (show_progress) {
-				repo_for_each_pack(repo, p) {
-					if (open_pack_index(p))
-						continue;
-					total += p->num_objects;
-				}
-
-				progress = start_progress(repo,
-							  _("Checking objects"), total);
-			}
-
-			repo_for_each_pack(repo, p) {
-				/* verify gives error messages itself */
-				if (verify_pack(repo,
-						p, fsck_obj_buffer, repo,
-						progress, count))
-					errors_found |= ERROR_PACK;
-				count += p->num_objects;
-			}
-			stop_progress(&progress);
-		}
-
 		if (fsck_finish(&fsck_obj_options))
 			errors_found |= ERROR_OBJECT;
 	}
diff --git a/odb.h b/odb.h
index 76c15e48f5..0bf6c8d7d2 100644
--- a/odb.h
+++ b/odb.h
@@ -215,11 +215,18 @@ enum odb_fsck_flags {
 	 * verification of their metadata.
 	 */
 	ODB_FSCK_FULL = (1 << 0),
+
+	/* Display a progress meter, if sensible. */
+	ODB_FSCK_PROGRESS = (1 << 1),
 };
 
 /* Options that shall be passed to `odb_fsck()`. */
 struct odb_fsck_options {
 	enum odb_fsck_flags flags;
+
+	int (*object_cb)(const struct object_id *oid, enum object_type type,
+			 unsigned long size, void *buffer, int *eaten, void *cb_data);
+	void *object_payload;
 };
 
 /*
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 7aacf4bc45..0d3599f8fe 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -9,8 +9,10 @@
 #include "midx.h"
 #include "odb/source-packed.h"
 #include "odb/streaming.h"
+#include "pack.h"
 #include "packfile.h"
 #include "pack-bitmap.h"
+#include "progress.h"
 
 static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
@@ -827,10 +829,48 @@ static void odb_source_packed_free(struct odb_source *source)
 	free(packed);
 }
 
-static int odb_source_packed_fsck(struct odb_source *source UNUSED,
-				  struct odb_fsck_options *opts UNUSED)
+static int verify_packs(struct odb_source_packed *source,
+			struct odb_fsck_options *opts)
 {
-	return 0;
+	struct progress *progress = NULL;
+	struct packfile_list_entry *e;
+	uint32_t total = 0, count = 0;
+	int ret = 0;
+
+	if (opts->flags & ODB_FSCK_PROGRESS) {
+		for (e = packfile_store_get_packs(source); e; e = e->next) {
+			if (open_pack_index(e->pack))
+				continue;
+			total += e->pack->num_objects;
+		}
+
+		progress = start_progress(source->base.odb->repo,
+					  _("Checking objects"), total);
+	}
+
+	for (e = packfile_store_get_packs(source); e; e = e->next) {
+		/* verify gives error messages itself */
+		if (verify_pack(source->base.odb->repo, e->pack,
+				opts->object_cb, opts->object_payload,
+				progress, count))
+			ret = -1;
+		count += e->pack->num_objects;
+	}
+	stop_progress(&progress);
+
+	return ret;
+}
+
+static int odb_source_packed_fsck(struct odb_source *source,
+				  struct odb_fsck_options *opts)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	int ret = 0;
+
+	if ((opts->flags & ODB_FSCK_FULL) && verify_packs(packed, opts) < 0)
+		ret = -1;
+
+	return ret;
 }
 
 struct odb_source_packed *odb_source_packed_new(struct object_database *odb,

-- 
2.55.0.822.g20453c30eb.dirty

