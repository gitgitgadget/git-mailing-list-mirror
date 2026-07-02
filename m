Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0FB4963D2
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993736; cv=none; b=SmiMgx0J0qedHnoOGhDZ0uEsqzd7ipJe3fwRnxmU0bNG3Kn3kOqSS8c1DDKXowOyijvoX57R2X9pPUL6z30ddk1iCnqKpt5y93H4rVKdL04WIu7dLYjKWY/SqCleAWgxQfTfmUGyWokbSLl4egn2/jkJ9/6PSXLXf7JfZKbGZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993736; c=relaxed/simple;
	bh=Nfod1XUbX+FbORljt8QORdmWezgh/2kIE5zbbeAkf6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W+hv3iBG2cmwpj5R9Es+6b9rsX+p7jhGGO8/APoLu8yPLZ3pD4Xff3pBxfow5GMEbbFYpEZUOdShVlBkI1Tq5UvL0ilhU6ydecNi7r0iDHOkmU2dZSQixgqCeMdLeD2pv2BpXUOU+PGDqFUAvpbPuCXfE06kGzXuNdJLl1tzWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ELY+tf1c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dt1ApZEF; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ELY+tf1c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dt1ApZEF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 393D31D0009D;
	Thu,  2 Jul 2026 08:02:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 02 Jul 2026 08:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993733;
	 x=1783080133; bh=EYbiViMz3Krie2hsxtgk8RY0Ef1oNzvUGWuqHkqb7P0=; b=
	ELY+tf1cSje53CGT99TDZf7yo3XNtHS+hMHiTodJv+RpOw01AFj2+ndE2PsqWETz
	vLx7UI3AbPnnt1dU5uxoHM05Ppmriy3xEbILlO9FzwbjTpWwEw6A1THmLmm4Vrzg
	DNm3Jv4L4ZlaTViZB13O7D1dfhx08ww20661tDe2FRM8tf9Yz+0lVb7shk4xNLXI
	e6eiqXMxynaeyPNMMV/rr1k5ke/wl/Cf7JX2Bd+BzGqqjzpjbGOYsD7kkJVN9J/k
	JODiDTAe7wTl3Z3sEXYgm98I10/Ip82llr/SxPwza1SmZS5f12qurEfUTG0x/ibP
	/odN+ZouE0QwBzIJFFwBTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993733; x=
	1783080133; bh=EYbiViMz3Krie2hsxtgk8RY0Ef1oNzvUGWuqHkqb7P0=; b=d
	t1ApZEFG9U86u7NgUaHdI8MKxvjCLbWLxBt0yr2NqdFkSPHOW39ASFip3mPJW4ji
	JBHPRq4WBe8nyqU5bnneAswGaLiC5YOIYJDLxQW5N/3+wnLFmnGte6pZGsJkHdJv
	EA3MUBc7XaxEyYaJLCeoIl5bYPh4wX4/qSkIg1IK4MGqp22+Ab8q4axburZkb/Ev
	LwX/+t+WrumOoEJ+DQ6WeK4KfD9M0b0My8jdNHmi5p1L9z0hYDnYCV3IBivnTZEF
	E/Bh/t2UPQvKM9bmGhbbFLRHNS3IFIbXEeJhteMEpAQJ0kFShTxYmMW/ONsPIQy7
	QFprrJJLwMFhR1lIGSd6w==
X-ME-Sender: <xms:RFNGauNzNcoeToFiJHW9AoVFlddNkR3P_YW8IZ_v6CNgQsfj_PK_8g>
    <xme:RFNGakZB9n8vBbUm1PfNj4TkpUF61-M-9wiHx9z6O7yQQBwsc88Ol7VfRk8KW_W4D
    rQN2K9GLiuIG8gRQRrCXM74KNR3AoQUpCJUz_sd7tVx-lZFUPLV2w>
X-ME-Received: <xmr:RFNGaiq3hM8dlsxAyH6UOaYM_aGR3d7tmQTA1cqOQPRXU30GhcjACawkzy8iTNa3CRUEO3ZBNbtL6gmsFwHzSyF7g_U7nnNbIKPjbVjDexSalw>
X-ME-Proxy-Cause: dmFkZTE/th2xBgxnWzTGuRC5i8I8CzueNFe2An1XZ36BT/xcl/31EDmri4/8jXeurrOfUl
    Nq5RkyADpf2fHHQJPG8FPj04oL7/sIQKCDAxOvxgTR1U/+x+o2GAzySJ78Xc0/KZ8yR0Or
    7SPIEdxWna2+6sc8M4zmU6so8ctaf+W3CuxWrApjDnUARHJdat/rcZGmYkP5RTHhY8d7pf
    KNBN7WCXEyNs6thNoxHUNviEr1zWBgaBZJvZuD5om0ooNQ7qlUHcPjWxna0m+KERM6aH/a
    MxOSRvLWeOpHOOeFkZ5mxkboP549lw7s0mc6qktJdjB6t8d+5wX7NftstHfeI+I0+CmcUq
    fIchyG5j4N6OfcQJAGYHHRyE6z0SPP9oGwkNcK/b/8Cy6pKm76g9kvUT+fihhRDbhYsNiO
    O3AmVDyWOhdSQS1gRj+leZf6ZC0ayNvuGBiiuH+aWms2+hCHUYEpwQqZ/tD9ZmhbN3f4S1
    9ji59WNmFvXeWrEd5ZzizZO7pnC4jWkHeDEIpf+SopQ1iYVrEimd+lpO/6FFK8uvcgiBmG
    AlED2pO1/a8P6+F0JRO00jnhmVMaYbbaEkDmDEWrvK7FKpyP0jyFmVjZob4N4sB1gR8xYJ
    jj5Cwueins9cX+0fI7OnqPPwb1/QnssDdVpSbYiHdl90+hYsHz8QPZnuxusg
X-ME-Proxy: <xmx:RFNGaoY8lMcx0Sms3GqtP3fmQwOosaXli6sr3wKNcQg-6rReQNm4ew>
    <xmx:RFNGaqSkZ5LtJucc9rcrmZMN34QBl-AhxW1IaXJRI-Xa6rEt6wbYHw>
    <xmx:RFNGav7yzX0yGso6TjuKxpbb_gK1uM-BaMzEXvZbK9G_hd66tPneyg>
    <xmx:RFNGavyz-0y6Mzzst7BDP6CBnLk_PZty8KtqeKBsxD95xtV7FYvc-Q>
    <xmx:RVNGajQELGtZJC8zEFXvLP5oI1G2cyKV2IKs65iaepY3ie1dz0uHcn-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:02:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e64c7f72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:02:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:02:01 +0200
Subject: [PATCH v2 3/6] odb: add `source` field to struct
 object_info_source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-odb-drop-whence-v2-3-b0af7468ad95@pks.im>
References: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
In-Reply-To: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

The previous commit introduced `struct object_info_source` as an opt-in
container for backend-specific information, but for now we only moved
preexisting data into this structure. Most importantly, the caller has
no way yet to learn about which source an object was actually looked up
from. Instead, callers have to rely on the `whence` enum to distinguish
the object type, but cannot use that enum to tell the object source.

Add a `struct odb_source *source` field to the structure and populate it
from each backend's lookup path.

The `whence` enum is still set and used by callers; it will be removed
in a subsequent commit now that `sourcep->source` can identify the
backend on its own.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     |  8 ++++----
 builtin/index-pack.c   |  6 +++---
 builtin/pack-objects.c | 14 +++++++-------
 odb.c                  |  4 ++--
 odb.h                  | 11 +++++++----
 odb/source-inmemory.c  |  3 +++
 odb/source-loose.c     |  2 ++
 packfile.c             | 20 ++++++++++++--------
 reachable.c            |  8 ++++----
 9 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index adc626ce30..0aca6acb75 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -835,8 +835,8 @@ static int batch_one_object_oi(const struct object_id *oid,
 {
 	struct for_each_object_payload *payload = _payload;
 	if (oi && oi->whence == OI_PACKED)
-		return payload->callback(oid, oi->sourcep->u.packed.pack,
-					 oi->sourcep->u.packed.offset,
+		return payload->callback(oid, oi->source_infop->u.packed.pack,
+					 oi->source_infop->u.packed.offset,
 					 payload->payload);
 	return payload->callback(oid, NULL, 0, payload->payload);
 }
@@ -907,9 +907,9 @@ static void batch_each_object(struct batch_options *opt,
 						&payload, flags);
 		}
 	} else {
-		struct object_info_source oi_source;
+		struct odb_source_info source_info;
 		struct object_info oi = {
-			.sourcep = &oi_source,
+			.source_infop = &source_info,
 		};
 
 		for (source = the_repository->objects->sources; source; source = source->next) {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 77af26db8f..fe6e70522d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1825,15 +1825,15 @@ static void repack_local_links(void)
 
 	oidset_iter_init(&outgoing_links, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
-		struct object_info_source info_source;
+		struct odb_source_info source_info;
 		struct object_info info = {
-			.sourcep = &info_source,
+			.source_infop = &source_info,
 		};
 
 		if (odb_read_object_info_extended(the_repository->objects, oid, &info, 0))
 			/* Missing; assume it is a promisor object */
 			continue;
-		if (info.whence == OI_PACKED && info_source.u.packed.pack->pack_promisor)
+		if (info.whence == OI_PACKED && source_info.u.packed.pack->pack_promisor)
 			continue;
 
 		if (!cmd.args.nr) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9deb37e9e8..b7ef90f67c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4491,8 +4491,8 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
 				       void *data UNUSED)
 {
 	if (cruft) {
-		add_cruft_object_entry(oid, OBJ_NONE, oi->sourcep->u.packed.pack,
-				       oi->sourcep->u.packed.offset, NULL,
+		add_cruft_object_entry(oid, OBJ_NONE, oi->source_infop->u.packed.pack,
+				       oi->source_infop->u.packed.offset, NULL,
 				       *oi->mtimep);
 	} else {
 		add_object_entry(oid, OBJ_NONE, "", 0);
@@ -4510,10 +4510,10 @@ static void add_objects_in_unpacked_packs(void)
 			 ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
 			 ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS,
 	};
-	struct object_info_source oi_source;
+	struct odb_source_info source_info;
 	struct object_info oi = {
 		.mtimep = &mtime,
-		.sourcep = &oi_source,
+		.source_infop = &source_info,
 	};
 
 	odb_prepare_alternates(to_pack.repo->objects);
@@ -5003,14 +5003,14 @@ static int option_parse_cruft_expiration(const struct option *opt UNUSED,
 
 static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
 {
-	struct object_info_source info_source;
+	struct odb_source_info source_info;
 	struct object_info info = {
-		.sourcep = &info_source,
+		.source_infop = &source_info,
 	};
 
 	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
 		BUG("should_include_obj should only be called on existing objects");
-	return info.whence != OI_PACKED || !info_source.u.packed.pack->pack_promisor;
+	return info.whence != OI_PACKED || !source_info.u.packed.pack->pack_promisor;
 }
 
 static int is_not_in_promisor_pack(struct commit *commit, void *data) {
diff --git a/odb.c b/odb.c
index 99f4e7551c..34c35c47a5 100644
--- a/odb.c
+++ b/odb.c
@@ -692,8 +692,8 @@ static int oid_object_info_convert(struct repository *r,
 		}
 	}
 	input_oi->whence = new_oi.whence;
-	if (input_oi->sourcep)
-		*input_oi->sourcep = *new_oi.sourcep;
+	if (input_oi->source_infop)
+		*input_oi->source_infop = *new_oi.source_infop;
 	return ret;
 }
 
diff --git a/odb.h b/odb.h
index 770900289a..659bf8afe1 100644
--- a/odb.h
+++ b/odb.h
@@ -249,10 +249,13 @@ int odb_pretend_object(struct object_database *odb,
 		       struct object_id *oid);
 
 /*
- * Object information that can be used to uniquely identify an object and learn
- * more about how exactly it is stored.
+ * Object database source information that can be used to uniquely identify an
+ * object and learn more about how exactly it is stored.
  */
-struct object_info_source {
+struct odb_source_info {
+	/* The source that this object has been looked up from. */
+	struct odb_source *source;
+
 	/*
 	 * Backend-specific information about the specific object. This can be
 	 * used for example to uniquely identify a given object in case it
@@ -307,7 +310,7 @@ struct object_info {
 	 * object lookups in case the same object exists in multiple sources,
 	 * or multiple times in the same source.
 	 */
-	struct object_info_source *sourcep;
+	struct odb_source_info *source_infop;
 
 	/* Response */
 	enum {
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index e004566d76..1d173bfa46 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -52,6 +52,9 @@ static void populate_object_info(struct odb_source_inmemory *source,
 		*oi->contentp = xmemdupz(object->buf, object->size);
 	if (oi->mtimep)
 		*oi->mtimep = 0;
+	if (oi->source_infop)
+		oi->source_infop->source = &source->base;
+
 	oi->whence = OI_CACHED;
 }
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 66e6bb8d3f..c254957602 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -196,6 +196,8 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 			oi->typep = NULL;
 		if (oi->delta_base_oid)
 			oidclr(oi->delta_base_oid, loose->base.odb->repo->hash_algo);
+		if (oi->source_infop && !ret)
+			oi->source_infop->source = &loose->base;
 		if (!ret)
 			oi->whence = OI_LOOSE;
 	}
diff --git a/packfile.c b/packfile.c
index 688c410b35..ce51d1e5a3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1324,7 +1324,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, &ent->ent);
 }
 
-int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
+int packed_object_info_with_index_pos(struct odb_source_packed *source,
 				      struct packed_git *p, off_t obj_offset,
 				      uint32_t *maybe_index_pos, struct object_info *oi)
 {
@@ -1423,22 +1423,26 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
 
 	oi->whence = OI_PACKED;
 
-	if (oi->sourcep) {
-		oi->sourcep->u.packed.offset = obj_offset;
-		oi->sourcep->u.packed.pack = p;
+	if (oi->source_infop) {
+		if (!source)
+			BUG("cannot request source without an owning source");
+		oi->source_infop->source = &source->base;
+
+		oi->source_infop->u.packed.offset = obj_offset;
+		oi->source_infop->u.packed.pack = p;
 
 		switch (type) {
 		case OBJ_NONE:
-			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
+			oi->source_infop->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
 			break;
 		case OBJ_REF_DELTA:
-			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
+			oi->source_infop->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
 			break;
 		case OBJ_OFS_DELTA:
-			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
+			oi->source_infop->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
 			break;
 		default:
-			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_FULL;
+			oi->source_infop->u.packed.type = PACKED_OBJECT_TYPE_FULL;
 			break;
 		}
 	}
diff --git a/reachable.c b/reachable.c
index 2fc5b82d62..bf76b48fc5 100644
--- a/reachable.c
+++ b/reachable.c
@@ -235,8 +235,8 @@ static int add_recent_object(const struct object_id *oid,
 	add_pending_object(data->revs, obj, "");
 	if (data->cb) {
 		if (oi->whence == OI_PACKED)
-			data->cb(obj, oi->sourcep->u.packed.pack,
-				 oi->sourcep->u.packed.offset, *oi->mtimep);
+			data->cb(obj, oi->source_infop->u.packed.pack,
+				 oi->source_infop->u.packed.offset, *oi->mtimep);
 		else
 			data->cb(obj, NULL, 0, *oi->mtimep);
 	}
@@ -253,11 +253,11 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 	unsigned flags;
 	enum object_type type;
 	time_t mtime;
-	struct object_info_source oi_source;
+	struct odb_source_info source_info;
 	struct object_info oi = {
 		.mtimep = &mtime,
 		.typep = &type,
-		.sourcep = &oi_source,
+		.source_infop = &source_info,
 	};
 	int r;
 

-- 
2.55.0.795.g602f6c329a.dirty

