Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B667314A8E
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303576; cv=none; b=f/6sjVuj6GqpX1Bfar4FcpXVL0E/bFL7w7By+Hkzb4g501Wy2CMg+QtI0ySlSEZkRAjbO0+v4o9g2x+Qk+aKf2kP0choa1SHYkTRoGQGXtF7Go47KIrHlqFh/28rQPtxO2ErWm+RHsKIVSSB9oSBFgAgMFPMa9YSop8BLBC/6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303576; c=relaxed/simple;
	bh=ef2cyxIYyNOi6uUnCzW8cNaUjuhGByxkE7NaAWcWv7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g+FotwjAd6/L0BrEHzEnCBFHTnZt3KAcd0kVj3hMRcTkem5DxfGyzL6I4Q0a7xvzjHXkyoVnXDoYwRsbXslfhZ1Ve97sK5qvSeq5GpiKUqGV5pacb2FlsTHzeBd1y8CRzcQvimWVytMvstGMD6ehsGVfEi3DU0sbjE+IDydQ6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DAyTBH8q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UZpBTstA; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DAyTBH8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UZpBTstA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D76991D0005A
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 08:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782303573;
	 x=1782389973; bh=rOuF4isixuhTks0DSGvR35YxzESkaw1tMc+qcPbx6Uc=; b=
	DAyTBH8q/NbPNpQ04fvz+r/liOMJ9qMWCZaV5Q0gViv1A7UNZQo4js9rR9wb26i5
	HwpNaIY+++N/5pD1yHKh+LpwzcUNA/gVtiZyTlNXudi35kAtJfqT70h1ffI6tm+Y
	6Sg6ihJ0+hf+xgmuCq69nYotrdgNRrZIx95N8IR215aVz9QFuIbEuBUG6lXIecch
	5vNoXp1euTGcNWk+vHTYudokaVN4mi000kMBDUWAGNHy7CkxWJwvGlu0WwioHQ/4
	8O/JqGnZrI9BEFFY2WZFKiO2++zFmPdOc6yJTBXQIIsFNeXvMA8zRUBxoVfYaugs
	VuJ+pIsMEtikVbV2r8IiQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782303573; x=
	1782389973; bh=rOuF4isixuhTks0DSGvR35YxzESkaw1tMc+qcPbx6Uc=; b=U
	ZpBTstACvhRJ2wBXbBACnL9TV58r1U6Zr4dM8BxQ0P5UwChhR0qvNkjn1tRezqiQ
	u3M33HRTbmwYTjeRgZSO3be52VjvvFQxniHpA3JlhPc+P/+SlSwG2zSaouaxiZCu
	grgEueykaf5YCkQHOX8S1a7y+Ih3L+H2oiKYYLRb4YJcu3TuGp72P3OSgtS3MDEy
	9qzcDej5G3dUBH4O+nn364+FKZl7uMXVn4ZOKJnQEZlFh7bJtnKvhsWgJeGCty1o
	rkz7FZMGwpvaH7hFEYDgGsK8S/NJMADr1opvJ+s7Tz8W4gbGbX3CTJVd49yNvoyz
	IzEwAt460np389R3vimWg==
X-ME-Sender: <xms:Vcs7asnO2VDjjMD5cfVYW18KFumGhHRXc4ikbe_JD3gxRIAtJn_1tg>
    <xme:Vcs7aiy2cbIpWlfEiyYrqjuKGrYptSyGCZHqi1URZvaZan1vj5nhsE2oWzW9NQMGd
    yeazgKCaRnXI091lH1xsho9rVEe271ZuKavkabkRuwP0BrFq5-g2w>
X-ME-Received: <xmr:Vcs7agSEyLjYIwnCZRzuO4mMYWFv-_rMQvm7vMCQhE11ahi83SbPTPJjv3DAJrBBcZr8GS_RkZVHqWnBgGXwbousvVgCIDbIGfKk89k0>
X-ME-Proxy-Cause: dmFkZTG1EQtmOEZwQT28Mh0KvYQUMdhjD7eojiWG3PlO/9h4j4NutEfcg7BCaFGwjcQYpT
    TvxZi5sWS2LnJofAWlpIVhus7XnkMaqoSAST1OsXbGYGbJXivApQX2IcT77wO7lNMq8C4z
    qIDIw7B9Hk2fWrCoMYnHMUd7lKaAv7NUCwt6cmR0YE+TCZrveFJQTA/R4wBpaPSJ9Gq9ZM
    rlY2wAGkYb9PpVIeevgqMG3qjf0PsmTdi5CUTVSLxebETAMxBmDasjZV8oRhpQpQAmT+0g
    asl4RqXXV+rOsSQqSZMv0W4r4juFNhWp2e7MDjFJraGDgGA7j5DV8CSAGsAH5YKueD2irl
    1UXqeO8r440wResTOQuTe6F5sD3Cp0Lr0tsSEDHEFE9aE4Htzc0fpNTJrYySkA2Ge7295q
    bbwzHIudE3++2ELiNzfntJgdNxsmTfptfpwgXXER1UwZ16RaAfoiYzjgtoeH6Kpc9Z2VsV
    NRn4OtX5dS2KYsvO4xYdyQVeeWwxbuMzcOkBx7KkY58VsbHT+IUgww0FS3zhY0fnD1gIAX
    P//AlrYbbYuPoZdvhRSSrWUInJE372gK+5YeXkj8UrmmCSS6zIR6a5lqcADAlvbrneACML
    nZl+d0tb7mA/OYS5t4T5Gygm/9+4nkRFaW9jMPCUUv6H1ExYnkRZsmW8vRug
X-ME-Proxy: <xmx:Vcs7attOIWgQbRXXDLCWZYt6-3la6xjCupDtsM761xSfbzfm4n4qQg>
    <xmx:Vcs7aqtKEIAgiyvC57CiOhJ3uevYqI4v5KGJ83ysOOEIKUZokMyKFQ>
    <xmx:Vcs7arxZVAsd6sywiTmuSbckWYagoRujhICAAqxU28ULb-9RNWi0jg>
    <xmx:Vcs7aogm2GsNlNEJ7SpXgL7N2DNwUV8QF8488Dfb2JzAAA1VtLrZOg>
    <xmx:Vcs7ag0LQ_BYSvMFj0AON7GU-6Nruxh69jwc1rf1Wjhl2TA9wNTPFGkU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c7f701d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 24 Jun 2026 12:19:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 14:19:15 +0200
Subject: [PATCH 2/6] odb: make backend-specific fields optional
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-b4-pks-odb-drop-whence-v1-2-8d1877b790ac@pks.im>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `struct object_info` carries two pieces of information
about how an object was looked up:

  - The `whence` enum identifying the backend.

  - The backend-tagged union `u` exposing backend-specific details
    (currently only the packed-source case, which records the owning
    pack, offset and packed object type).

The union is populated unconditionally, even though most callers don't
care about provenance at all.

Split the backend-specific union out into a new public type, `struct
object_info_source`, and make the object info structure carry it via
just another opt-in request pointer. As with all the other requestable
information, callers that need source info allocate a `struct
object_info_source` on the stack and point `sourcep` at it; callers that
don't care about it simply leave the field as a `NULL` pointer. Adapt
callers accordingly.

Note that the `whence` enum is strictly-speaking also backend-specific
information, so it would be another good candidate to be moved into the
`struct object_info_source`. For now though it is left alone, as it will
be replaced by a `struct odb_source` pointer in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     |  8 +++++--
 builtin/index-pack.c   |  8 +++++--
 builtin/pack-objects.c | 15 +++++++++----
 odb.c                  |  3 ++-
 odb.h                  | 60 +++++++++++++++++++++++++++++++++-----------------
 packfile.c             | 33 ++++++++++++++-------------
 reachable.c            |  5 ++++-
 7 files changed, 87 insertions(+), 45 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8726485f1f..adc626ce30 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -835,7 +835,8 @@ static int batch_one_object_oi(const struct object_id *oid,
 {
 	struct for_each_object_payload *payload = _payload;
 	if (oi && oi->whence == OI_PACKED)
-		return payload->callback(oid, oi->u.packed.pack, oi->u.packed.offset,
+		return payload->callback(oid, oi->sourcep->u.packed.pack,
+					 oi->sourcep->u.packed.offset,
 					 payload->payload);
 	return payload->callback(oid, NULL, 0, payload->payload);
 }
@@ -906,7 +907,10 @@ static void batch_each_object(struct batch_options *opt,
 						&payload, flags);
 		}
 	} else {
-		struct object_info oi = { 0 };
+		struct object_info_source oi_source;
+		struct object_info oi = {
+			.sourcep = &oi_source,
+		};
 
 		for (source = the_repository->objects->sources; source; source = source->next) {
 			struct odb_source_files *files = odb_source_files_downcast(source);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f396658468..77af26db8f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1825,11 +1825,15 @@ static void repack_local_links(void)
 
 	oidset_iter_init(&outgoing_links, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
-		struct object_info info = OBJECT_INFO_INIT;
+		struct object_info_source info_source;
+		struct object_info info = {
+			.sourcep = &info_source,
+		};
+
 		if (odb_read_object_info_extended(the_repository->objects, oid, &info, 0))
 			/* Missing; assume it is a promisor object */
 			continue;
-		if (info.whence == OI_PACKED && info.u.packed.pack->pack_promisor)
+		if (info.whence == OI_PACKED && info_source.u.packed.pack->pack_promisor)
 			continue;
 
 		if (!cmd.args.nr) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 620d9ce085..9deb37e9e8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4491,8 +4491,9 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
 				       void *data UNUSED)
 {
 	if (cruft) {
-		add_cruft_object_entry(oid, OBJ_NONE, oi->u.packed.pack,
-				       oi->u.packed.offset, NULL, *oi->mtimep);
+		add_cruft_object_entry(oid, OBJ_NONE, oi->sourcep->u.packed.pack,
+				       oi->sourcep->u.packed.offset, NULL,
+				       *oi->mtimep);
 	} else {
 		add_object_entry(oid, OBJ_NONE, "", 0);
 	}
@@ -4509,8 +4510,10 @@ static void add_objects_in_unpacked_packs(void)
 			 ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
 			 ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS,
 	};
+	struct object_info_source oi_source;
 	struct object_info oi = {
 		.mtimep = &mtime,
+		.sourcep = &oi_source,
 	};
 
 	odb_prepare_alternates(to_pack.repo->objects);
@@ -5000,10 +5003,14 @@ static int option_parse_cruft_expiration(const struct option *opt UNUSED,
 
 static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
 {
-	struct object_info info = OBJECT_INFO_INIT;
+	struct object_info_source info_source;
+	struct object_info info = {
+		.sourcep = &info_source,
+	};
+
 	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
 		BUG("should_include_obj should only be called on existing objects");
-	return info.whence != OI_PACKED || !info.u.packed.pack->pack_promisor;
+	return info.whence != OI_PACKED || !info_source.u.packed.pack->pack_promisor;
 }
 
 static int is_not_in_promisor_pack(struct commit *commit, void *data) {
diff --git a/odb.c b/odb.c
index 7d555be09f..99f4e7551c 100644
--- a/odb.c
+++ b/odb.c
@@ -692,7 +692,8 @@ static int oid_object_info_convert(struct repository *r,
 		}
 	}
 	input_oi->whence = new_oi.whence;
-	input_oi->u = new_oi.u;
+	if (input_oi->sourcep)
+		*input_oi->sourcep = *new_oi.sourcep;
 	return ret;
 }
 
diff --git a/odb.h b/odb.h
index 3834a0dcbf..770900289a 100644
--- a/odb.h
+++ b/odb.h
@@ -248,6 +248,38 @@ int odb_pretend_object(struct object_database *odb,
 		       void *buf, size_t len, enum object_type type,
 		       struct object_id *oid);
 
+/*
+ * Object information that can be used to uniquely identify an object and learn
+ * more about how exactly it is stored.
+ */
+struct object_info_source {
+	/*
+	 * Backend-specific information about the specific object. This can be
+	 * used for example to uniquely identify a given object in case it
+	 * exists multiple times.
+	 */
+	union {
+		/*
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } cached;
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } loose;
+		 */
+		struct {
+			struct packed_git *pack;
+			off_t offset;
+			enum packed_object_type {
+				PACKED_OBJECT_TYPE_UNKNOWN,
+				PACKED_OBJECT_TYPE_FULL,
+				PACKED_OBJECT_TYPE_OFS_DELTA,
+				PACKED_OBJECT_TYPE_REF_DELTA,
+			} type;
+		} packed;
+	} u;
+};
+
 struct object_info {
 	/* Request */
 	enum object_type *typep;
@@ -269,32 +301,20 @@ struct object_info {
 	 */
 	time_t *mtimep;
 
+	/*
+	 * Backend-specific information that tells the caller where exactly an
+	 * object was looked up from. This information should help disambiguate
+	 * object lookups in case the same object exists in multiple sources,
+	 * or multiple times in the same source.
+	 */
+	struct object_info_source *sourcep;
+
 	/* Response */
 	enum {
 		OI_CACHED,
 		OI_LOOSE,
 		OI_PACKED,
 	} whence;
-	union {
-		/*
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } cached;
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } loose;
-		 */
-		struct {
-			struct packed_git *pack;
-			off_t offset;
-			enum packed_object_type {
-				PACKED_OBJECT_TYPE_UNKNOWN,
-				PACKED_OBJECT_TYPE_FULL,
-				PACKED_OBJECT_TYPE_OFS_DELTA,
-				PACKED_OBJECT_TYPE_REF_DELTA,
-			} type;
-		} packed;
-	} u;
 };
 
 /*
diff --git a/packfile.c b/packfile.c
index 2b741d7a76..688c410b35 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1422,22 +1422,25 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
 	}
 
 	oi->whence = OI_PACKED;
-	oi->u.packed.offset = obj_offset;
-	oi->u.packed.pack = p;
 
-	switch (type) {
-	case OBJ_NONE:
-		oi->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
-		break;
-	case OBJ_REF_DELTA:
-		oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
-		break;
-	case OBJ_OFS_DELTA:
-		oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
-		break;
-	default:
-		oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
-		break;
+	if (oi->sourcep) {
+		oi->sourcep->u.packed.offset = obj_offset;
+		oi->sourcep->u.packed.pack = p;
+
+		switch (type) {
+		case OBJ_NONE:
+			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
+			break;
+		case OBJ_REF_DELTA:
+			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
+			break;
+		case OBJ_OFS_DELTA:
+			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
+			break;
+		default:
+			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_FULL;
+			break;
+		}
 	}
 
 	ret = 0;
diff --git a/reachable.c b/reachable.c
index 101cfc2727..2fc5b82d62 100644
--- a/reachable.c
+++ b/reachable.c
@@ -235,7 +235,8 @@ static int add_recent_object(const struct object_id *oid,
 	add_pending_object(data->revs, obj, "");
 	if (data->cb) {
 		if (oi->whence == OI_PACKED)
-			data->cb(obj, oi->u.packed.pack, oi->u.packed.offset, *oi->mtimep);
+			data->cb(obj, oi->sourcep->u.packed.pack,
+				 oi->sourcep->u.packed.offset, *oi->mtimep);
 		else
 			data->cb(obj, NULL, 0, *oi->mtimep);
 	}
@@ -252,9 +253,11 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 	unsigned flags;
 	enum object_type type;
 	time_t mtime;
+	struct object_info_source oi_source;
 	struct object_info oi = {
 		.mtimep = &mtime,
 		.typep = &type,
+		.sourcep = &oi_source,
 	};
 	int r;
 

-- 
2.55.0.rc1.745.g43192e7977.dirty

