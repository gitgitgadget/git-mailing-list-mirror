Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCD485956
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133270; cv=none; b=KUQ++LotMo6xsb1562pXQQeDIqtS/qUtOvA2aDWfALEnI3RBxacJ+7p3J55ePIjlCiU3cdctzPPzwbMkwkpWp8SLZ3XnMxMXVqpU4YZkBZK2xDwCnkUUpG/XkTdkEdZ1ceoDuqDJvE50GFQHHEYxACkt2jkMxMB7cguL9+RW5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133270; c=relaxed/simple;
	bh=fnQ9WFLntDM3QMGNpqpZfnwNV3uvUpjS7RCj7lsAHWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCEhayN8QDwBt9cssH2XyKinHfOKw0NlaoCB8AKiWheSmEDJuE0Xvc5jpaB+dWesRMVcV8QJAAjZq3wjcWFg1tahfvfRWv5abXml3+N0KDx6hvger4Lh7ob30hb+ezCoxlliLL14LxZVOlpKdZVn3T5hHYw6L4GXYOkWV5OYiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oSOzX0ZH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fYVEdhxM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oSOzX0ZH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fYVEdhxM"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E45AEC0207;
	Fri, 11 Sep 2026 09:27:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 11 Sep 2026 09:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789133265;
	 x=1789219665; bh=OmtGj2hC2ezvXShnyCVce+HVhw1POw/SFj7cNo0CFMs=; b=
	oSOzX0ZH+JHk4/0t5RHLByCw2z7OnyufpHNExiB4gG0nl4iV0kB5l69tQsK9wtNt
	R1Hd/bZEUnWYJhug3w6CX2e0gXvYXRDi8+VSFE5dpXHKlSxAYY7xAVUX3eE5v1fU
	YpOkElzzA04O6gEoPtFgzvn1ydRsA3dYXydrBEZufVOkVq7cBXMQNzKf5vNsy5Md
	f1JzNImM+BZOs/W7KtFHEcjj7qKb7PLJD6bp+UIjMjzVfLW4ZuJ5MAgC3uOpOmGf
	MmI0sO8yfuwZoRfo+jBJ2KlhXqVdrdbRTUQSXnaFIRbvJhZSfenLTnH/JJhJd8lC
	FcgLTioKQAh34INMxrGncg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789133265; x=
	1789219665; bh=OmtGj2hC2ezvXShnyCVce+HVhw1POw/SFj7cNo0CFMs=; b=f
	YVEdhxMF3AbRUgEJzvpBnzKl/qSQKqIsFAiVychTMRtbIc2EpsvOpdLbYwyoKD6O
	yMiopWy9hbz49GXG/iWPUs1gKVHqfx3MzC38z0zX7M/1mATS3cQWTa0GYxYjVP0e
	dDy08rl2IkAfaOV7Z732TzcxS5pHirbNvII3Dvt41N0ohw+xzsN3+5hat9ti7BnW
	026K4WV8+rCgN4qsAyKsqwPb5HJGmjj4HeYhAC1hVofAgtOBsD7d4Yb/DSv9tYQ5
	aypQTbJDZUEFLZljHMgOl9L3V4ypZomYAmeQnPK1TZxp6llZcReCgZ2QqCPnF7so
	DOHPW2mbZjjcmnJa8g7NA==
X-ME-Sender: <xms:0QGkajH1uhOOBehygDEYqjx0OZD7TGkaaIZG244PqwvlAJrc-yWpYQ>
    <xme:0QGkanxj4pdVyzDsBskhCPFF5PzZymSrw4ZpshkJbyOyCY2WrKtW68WFMTzDwxO8Z
    vyH7AJzDkOWqYxbYPl91-PecZpujeHCjIpGH6F4gi1gLzS8Z03k-wSG>
X-ME-Received: <xmr:0QGkaijMk4PqUt8OEnWaCdxyfrLJIrICSKU4jXkj29lpoR8RU0AgKEi0mARz6xSKKsn_-Q>
X-ME-Proxy-Cause: dmFkZTFhKNTY4gaJzL8unHorI0O2mIjovbOSn/bb4FfWdQC69pOMNnSpJupj+k3b5RRAEh
    CKbErTW3WczRhRJwwrJkvaRsvQIzXEXE2C+BN/DKoL4Gbfz/Eo1tEu7eUCGtvI2UYkaIkN
    pdzF4Cl414GlPSVfplCLhQTY1vxDPnsAjpUCtDjPcnIgviIidiwFFMtURzMpzxs3Vu7cEM
    3nEkQWJ43K7d/I7qMYYZ6hxKZuNC1lSeitb76YKd6w//fOV1p7l3EElcNKMWcMdULICz/K
    NpH5skcEvh10Ou1QeaUv5hQYKlpJ4gF4a0EGGL8oCdZIc9NRujjRUNoZU+qfCLCaHmP9KT
    4vZuvDZ+FBE8KnYKdCciveemuYqp6Xyikvyz0FFupavVtJomol6yIl9+MA4WGXUiVHta5j
    GlE4CuJYjKpBVbJK+sTPN10CAsUeWkWdvkRbp6KhlINlVpdYqobxrpCExFcRYhocYedBqL
    V6xR0k7QfmasUxyVNkEfaEktjPRVXtyQsoWD4E8UU3LlG4QsEmmXNseBIh1hfpYx/a1KPh
    mNCs5hlBf650cXt3WNoS0F+WdUcd3kEJg56Vk+ep+LKkuB47mM+blmUHeGq5j9e4KEBCXA
    plh19NspCycIXogbtLD6k2kCLKJ62b9iq/A1olu4RLMTfBOpYbtM0Ob+YGgA
X-ME-Proxy: <xmx:0QGkaqxgBJ0mEhhIvBVr0k3mzr6UpvHFJMKlXXc6DdY55P86GWdjWA>
    <xmx:0QGkatIsqXpEogW44qaKjX3Tba6C6jeUbk4lkcZ9DkOYPaMunaF12g>
    <xmx:0QGkapRCdrDn2mjsWRdbrl3YLVYzc8d-9kRsSH-ig55jiSzffz-S2g>
    <xmx:0QGkatpabohmixskdITGoLYSBJ3grzg38tGj3dZvItPkikNRk32nRQ>
    <xmx:0QGkarzApC6FaWiK-kPp3bZWA0RZ62G1Q1lPOf6txF5qCbZ9-OhTjHHj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 09:27:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f4cf89c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 13:27:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 15:27:30 +0200
Subject: [PATCH v3 06/10] builtin/fsck: move packfile verification into the
 packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-source-fsck-v3-6-ef2fdc085e38@pks.im>
References: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
In-Reply-To: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
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
2.55.0.1074.ge7621b4bad.dirty

