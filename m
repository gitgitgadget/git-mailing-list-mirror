Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C778374193
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475141; cv=none; b=uLFMDF01Sm4FyNuMpD9tr/t24Xqmx95i617quA2ilQR8iP0dYSPhlarJBMsxXNT7IdnoNFYndTb6ZxpR02xoMD136q92if6BD5SeDUHpbfKP2a2/lv3nH64l0Bk5Ei1R54BLl4IN4+QOeKPm38j5v+K8d/Ai0kVBpAyFaaI3hEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475141; c=relaxed/simple;
	bh=STKCo/+m2s5VJRumlOIlB0k9ih/dtQe015J7yif8KCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LVN1HjaAZYB4eBmBLdtuds4eI834Nvi4/cD7VjV9yhjKKYjmjc1SBlEQHHNB/R7aeAYxFRw+bB8IYAcFAxlPWu+84bwHIBHcZYflY9dMH3drqWO2+OZekdTuU3wUH1ugWJ8PjMEXtFU+6gccL3fq5Kb6cjETstAExYlZAWDCCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cGJEkG7H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/xJtOwK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cGJEkG7H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/xJtOwK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 8906F1D000E9
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 15 Jan 2026 06:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475132;
	 x=1768561532; bh=jc49U72XphJTNskspYKGd1aPvbyQ4bpfLBuB06Svl3U=; b=
	cGJEkG7H/tu0Ca1fEW4XB6ucekgtnaA+X/TfuvveXVJAc5Z6NZ7ggBOwuv46FEk9
	VX8E64BNQ2Y/DYZOAsUt4mgWX9tyEpgdC1Cdmgd21N/WSNkUvdPojlU8MlCMmqDa
	6KbkeBrrUpNWGU4iVNoTNR8vk+Z76j4du1TSCRSfj71sbTGM7Z3iVsPC4DRCZ7QT
	H+KOxFokRIoJFhqlXz+9xbFUK+pgAX2XS4ZxmEHexQv+3MpnuqnV9AA9us69JAhr
	kTeEnIdlUKR6gALIw0Pl6L0GQWCxRF42+J4P1UFzFWMYebPAR3EtEGIhq8Wg+Qch
	DAg3lhBotyuMUhZJeG6Utw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475132; x=
	1768561532; bh=jc49U72XphJTNskspYKGd1aPvbyQ4bpfLBuB06Svl3U=; b=b
	/xJtOwKlK+4gBal/26B/aC0gZeoDhFEfzScyGj1d2W4+Eo1kmJog6BVOGQ+FKrn7
	Q435QJcbl0jOl603OzgH6a7oZf8AKb1INAbt5I3QtI7QvacMu5x6bdzqIVbvQ7qv
	k4C38lr8q2Rzsit/RgGvB1XKiEQ3obcDQhpfo/8WeJ7ChzO2GfrRg/HetYdbQNX3
	FEcwYMmb4k+yWH+4flx4WvPxqDe7zfDfB9lWNmdNFceHR55HpZ2qCC421kJq3tWV
	c87YV03BcZW+tgf9jysfz4WCkzfRG1B4HNOAbTi3h3ePvpXfdTIlddBZYdcLdxi4
	gpjKaAzjSvMoRDt7L4D0w==
X-ME-Sender: <xms:_MloaQUgI1CHD5tQOLt45LV71Qw4eQlKZqU7WoYACyCOhdtL_wx_vA>
    <xme:_Mloabg09S7zqCztWJqtsa1H27BcCUayxlB1Dfyagkjuxe3rAl7kjDKbpAt1csmt6
    5bpPClpVpnzl0FCDaK02319TylT8harekyneyItyaY2i3T2ZKBP>
X-ME-Received: <xmr:_MloaaAth_E1Pbs94ClBRxQK1R67ndSun5BBCpvQ2QGvuV4rrY9l6kPwdKzNDxUq2Zaci-7Yv5xKWUH_wVv9bOhcxUlNyd9GOR8bsD2JjwaTdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:_MloaUeugYEVVrc1dBdoL0QUtgswo3X_G_veZ0tWptt_yXyK8fm_Rw>
    <xmx:_MloaafzY4PffXsqe0Vc4Qg74qdtWkP6Mx9QDWyarWmiJSNzPwPnsQ>
    <xmx:_MloaQi1FfBZWDQ-YMPqbE-YIyH2_qtUudhDtbIY85rPfS_AG0n_jA>
    <xmx:_MloaeRNQpxHx6H6VZypd5-iwSuArQzvttkieB3fWJT6sDycmkEbAw>
    <xmx:_MloaXkdat8WYMFOSpu7SS9QQ2oszU_YFWzxGRTNvfwjL6GzA9p7enA7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 281011e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:43 +0100
Subject: [PATCH 14/14] odb: drop unused `for_each_{loose,packed}_object()`
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-14-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We have converted all callers of `for_each_loose_object()` and
`for_each_packed_object()` to use their new replacement functions
instead. We can thus remove them now.

Do so and inline `packfile_store_for_each_object_internal()` now that it
only has a single callsite again. This makes it a bit easier to follow
the callback indirection that is happening there.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 20 -------------
 object-file.h | 11 -------
 packfile.c    | 92 +++++++++++++++++++----------------------------------------
 packfile.h    |  2 --
 4 files changed, 29 insertions(+), 96 deletions(-)

diff --git a/object-file.c b/object-file.c
index c0f896673b..bc5209f2fe 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1802,26 +1802,6 @@ int for_each_loose_file_in_source(struct odb_source *source,
 	return r;
 }
 
-int for_each_loose_object(struct object_database *odb,
-			  each_loose_object_fn cb, void *data,
-			  enum odb_for_each_object_flags flags)
-{
-	struct odb_source *source;
-
-	odb_prepare_alternates(odb);
-	for (source = odb->sources; source; source = source->next) {
-		int r = for_each_loose_file_in_source(source, cb, NULL,
-						      NULL, data);
-		if (r)
-			return r;
-
-		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY)
-			break;
-	}
-
-	return 0;
-}
-
 struct for_each_object_wrapper_data {
 	struct odb_source *source;
 	struct object_info *oi;
diff --git a/object-file.h b/object-file.h
index 048b778531..af7f57d2a1 100644
--- a/object-file.h
+++ b/object-file.h
@@ -126,17 +126,6 @@ int for_each_loose_file_in_source(struct odb_source *source,
 				  each_loose_subdir_fn subdir_cb,
 				  void *data);
 
-/*
- * Iterate over all accessible loose objects without respect to
- * reachability. By default, this includes both local and alternate objects.
- * The order in which objects are visited is unspecified.
- *
- * Any flags specific to packs are ignored.
- */
-int for_each_loose_object(struct object_database *odb,
-			  each_loose_object_fn, void *,
-			  enum odb_for_each_object_flags flags);
-
 /*
  * Iterate through all loose objects in the given object database source and
  * invoke the callback function for each of them. If given, the object info
diff --git a/packfile.c b/packfile.c
index c96ec21f86..493d81fdca 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2326,65 +2326,6 @@ int for_each_object_in_pack(struct packed_git *p,
 	return r;
 }
 
-static int packfile_store_for_each_object_internal(struct packfile_store *store,
-						   each_packed_object_fn cb,
-						   void *data,
-						   unsigned flags,
-						   int *pack_errors)
-{
-	struct packfile_list_entry *e;
-	int ret = 0;
-
-	store->skip_mru_updates = true;
-
-	for (e = packfile_store_get_packs(store); e; e = e->next) {
-		struct packed_git *p = e->pack;
-
-		if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
-			continue;
-		if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
-		    !p->pack_promisor)
-			continue;
-		if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
-		    p->pack_keep_in_core)
-			continue;
-		if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
-		    p->pack_keep)
-			continue;
-		if (open_pack_index(p)) {
-			*pack_errors = 1;
-			continue;
-		}
-
-		ret = for_each_object_in_pack(p, cb, data, flags);
-		if (ret)
-			break;
-	}
-
-	store->skip_mru_updates = false;
-
-	return ret;
-}
-
-int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, unsigned flags)
-{
-	struct odb_source *source;
-	int pack_errors = 0;
-	int ret = 0;
-
-	odb_prepare_alternates(repo->objects);
-
-	for (source = repo->objects->sources; source; source = source->next) {
-		ret = packfile_store_for_each_object_internal(source->packfiles, cb, data,
-							      flags, &pack_errors);
-		if (ret)
-			break;
-	}
-
-	return ret ? ret : pack_errors;
-}
-
 struct packfile_store_for_each_object_wrapper_data {
 	struct packfile_store *store;
 	struct object_info *oi;
@@ -2424,12 +2365,37 @@ int packfile_store_for_each_object(struct packfile_store *store,
 		.cb = cb,
 		.cb_data = cb_data,
 	};
+	struct packfile_list_entry *e;
 	int pack_errors = 0, ret;
 
-	ret = packfile_store_for_each_object_internal(store, packfile_store_for_each_object_wrapper,
-						      &data, flags, &pack_errors);
-	if (ret)
-		return ret;
+	store->skip_mru_updates = true;
+
+	for (e = packfile_store_get_packs(store); e; e = e->next) {
+		struct packed_git *p = e->pack;
+
+		if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+			continue;
+		if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+		    !p->pack_promisor)
+			continue;
+		if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
+		    p->pack_keep_in_core)
+			continue;
+		if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
+		    p->pack_keep)
+			continue;
+		if (open_pack_index(p)) {
+			pack_errors = 1;
+			continue;
+		}
+
+		ret = for_each_object_in_pack(p, packfile_store_for_each_object_wrapper,
+					      &data, flags);
+		if (ret)
+			break;
+	}
+
+	store->skip_mru_updates = false;
 
 	return pack_errors ? -1 : 0;
 }
diff --git a/packfile.h b/packfile.h
index ab0637fbe9..8e0d2b7661 100644
--- a/packfile.h
+++ b/packfile.h
@@ -340,8 +340,6 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn, void *data,
 			    unsigned flags);
-int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, unsigned flags);
 
 /*
  * Iterate through all packed objects in the given packfile store and invoke

-- 
2.52.0.660.gd05f3a8ea5.dirty

