Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A364963C6
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993732; cv=none; b=mfPqKmFg9teIVy86BnkdN2WxLWo4Zi3NNI0aHF1OFphbhx+ye330wjG6luhtrXvGKtgcZvZe7zgm1psbadpYsGT2O6AbapUTylHR63dFevs0ofewUR1vlN3jPUri22FumGZmxKvyeVlewzlGh6eRmgLfqvX2pZ154oODGhag8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993732; c=relaxed/simple;
	bh=TOsOD+u6Ja3uny5rVF5GBl+JM5MM3CWIK8LUq8u/oF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKpEWgkfcEd2Ws/1JTb1MCHxfBcPXzPEmqKvw/FVTsCqL7GkYsXfNIGx9NmBBX6WyUB41JlBT5OGH3JvdOCQ/kaYMLQzwNiMNZdAyJVgatUaAcysN/YiWvq7fcKVDX4l5KUEeThSTqN2334mYL3cB9iBTMA3xvldvqjiziBb/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LxQCcunn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PIZPwyN/; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LxQCcunn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PIZPwyN/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D2DF67A0048;
	Thu,  2 Jul 2026 08:02:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 08:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993729;
	 x=1783080129; bh=R6YXc46/3+L2oJgfGmCN8+WwwrdhbaTyklp0yrqxPsY=; b=
	LxQCcunnuyqgMRturS12pfYr+0DsnaSsYDWbrLZbfaiLrnRIVf9ujOJLzFaYuH+H
	WQftHNXYCQY1x5pI5Brgrk7p3X3IENGiCL60/gAWwzElImp1F4RJJDf1AtAxIQiL
	aoP+EGLUAsG60y4n4L986gewmC5IlOl/HyCMgrttFJj499a7L9HnRWGrFn3C4L+J
	yAoR89SLIbKvFjTcIM+3s8kn3rLROVmXot4epHLBoES3k3NBcWGRpzlhQ4F4e8PQ
	TOWiyNgwQFgsaWjDj0Tyry7jw/NYRwk2Y1ul0VUWO9FQwAxiQ71nkOUc3C1GCsH/
	MF/9GYe1vs1cirWM2D65tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993729; x=
	1783080129; bh=R6YXc46/3+L2oJgfGmCN8+WwwrdhbaTyklp0yrqxPsY=; b=P
	IZPwyN/4KpTO7w3iXpkywr3ELrjy9NBGo9x2GxHat63LIi8j7IiMh5AROum6qYy0
	1hapLdqREOOsuO8fdoWUwhM6wCrhwyiHVDApfCk1DNmDPdezyRMuaVjOOCfNGb8P
	WnprHiCv06G9rKwahE5im7QJxUSvShJfeiOW5b46IFSRptdor5bXkYzOiNhKRJ71
	EgdevPXi4lKT+UY3LdyAZ07wKCWvlqtk4NkKYZdPfSS43SNlvuu3u+HEt0Z+hVr9
	8LJDcdV+LvNk4qug03yVWvt7n4NK5H5N6N9ErB9MbcZPghzwLOROuQ+AxaodCOpf
	htNJz8b3+gg0EI0obgH0Q==
X-ME-Sender: <xms:QVNGakUAxb0f5ianFKvUkhwAkrJ8mFgG4tQBp8ZHjuCENm-F9rHNNQ>
    <xme:QVNGagATjZIU9LHdnQMkgZdxPOAYz8lhHEDCNsKB6TFj-9eCU6nrarT06nBgwEZEX
    qH8e8Nf7S0sUbzugNgAZlxarAsgDk0kIJ1nsJIR0_0qeh7wnOxfAg>
X-ME-Received: <xmr:QVNGalwfod220URbzUjaNyGiKfbqSQjtlEEduVBsK2Qi9nbpOji2papxxzXGdVz9GKfQS_oyru2hiDEa85rzXr-fYtgIuvkhYrgb5KySKuQzdQ>
X-ME-Proxy-Cause: dmFkZTE/th2xBgxnWzTGuRC5i8I8CzueNFe2An1XZ36BT/xcl/31EDmri4/8jXeurrOfUl
    Nq5RkyADpf2fHHQJPG8FPj04oL7/sIQKCDAxOvxgTR1U/+x+o2GAzySJ78Xc0/KZ8yR0Or
    7SPIEdxWna2+6sc8M4zmU6so8ctaf+W3CuxWrApjDnUARHJdat/rcZGmYkP5RTHhY8d7pf
    KNBN7WCXEyNs6thNoxHUNviEr1zWBgaBZJvZuD5om0ooNQ7qlUHcPjWxna0m+KERM6aH/a
    MxOSRvLWeOpHOOeFkZ5mxkboP549lw7s0mc6qktJdjB6t8d+5wX7NftstHfeI+I0+CmcDz
    UkchbGscIEG6gc4Pce0W4wS4zeIhw1kF+suyTXsXVJaQ2Z1EGTMNlcUSEWPHqDFeBoN1Tz
    Z2C6186dNPGGXZVlDtvsoFllbatsbiCoCUzHKKJTO+nYf3v1FBs4YQSUhEyF6G1i89JdJj
    CTmCDjzxpu+0A5e2gb2XezNbW84rUEKKWNxjJvOJaEB7zwgsqxWus7lEV69cWm90ExLDVK
    /F5YVmNGKj3/pAKaxOPCLQRq7294M2PX92P1tbOHlJ+f1QKj3xDnaVAh6Ab+YTZSzqc/7e
    74XV0W2X3NAI2T7ioL6+sOqDPCGLE/viHNvwRs01YfMnUAR95HmNWasVGp6A
X-ME-Proxy: <xmx:QVNGatCFYbnjXxlfzmN1XiSiVjCQd9pcKo7avOvnMqXxG4gdSFww4g>
    <xmx:QVNGaiZV4LLFu22HlZHpkZK0yB3wq0IPcOu3mkRjCofIDs37AF8nuw>
    <xmx:QVNGaljmnTO5rd3Ez5Gpd21t3pUkI3zI8mfy-HmrQl-ltHPM6FI0Jw>
    <xmx:QVNGak4tIe6e0v2gzm56TljfQf8jZePJbkPXXsgCYmsr0N2fW5JZng>
    <xmx:QVNGakB9sD0VjKoiEjQD4Y1qjEmRWbcpOH5XzMGCi6acV_E01-8F4iKA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:02:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8198e555 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:02:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:02:00 +0200
Subject: [PATCH v2 2/6] odb: make backend-specific fields optional
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-odb-drop-whence-v2-2-b0af7468ad95@pks.im>
References: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
In-Reply-To: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
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
2.55.0.795.g602f6c329a.dirty

