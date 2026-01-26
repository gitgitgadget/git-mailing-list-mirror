Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63832E6BB
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421123; cv=none; b=nSFvvrgQybJA15F7ktF1RuZYwARaETB1iQON87oWZTg5MSjaod+/59wDrRCNTB+0U3spMSitH8e15ENvrGuoRpxMesigP3uDPKnVCaEmCzSSAiZDnfDJoY60bIr4YHTKGu6kkZAnfXc0nywdrIwWcP+FwS3nvNniDdAB+4EIPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421123; c=relaxed/simple;
	bh=SXkXowA4lgze8O22NBte/0qKXbPyRJ29jyMq8ue/qYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hYbpnAQy0CoYdrF6NN5D/D6yr3zcjL7AXtzCDZrSDddwrdMatrmxo6FGEr4Ij2oWHPx8jb4nwOTmJZDWCPM1YyCEVRZZ/1vECVuMLN0lnyZLMKYV9DGtU+a2b3+bAKjRTyB2PUZ7tC54emCXr/mussgSiTYo4KHSlWzcu4yRUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XMdUVs27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EiMG+3Qv; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XMdUVs27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EiMG+3Qv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 507597A0013;
	Mon, 26 Jan 2026 04:52:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 26 Jan 2026 04:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421121;
	 x=1769507521; bh=K/A1ztGXUmTnoE3dUNpk9qemXCaS+0MuelUJX0WTMds=; b=
	XMdUVs27Cu9kHFNNvtjfQNrEMSIeiMfQeAeCy0zzpN+XOmrqrlhMVTBqTLTPcnI0
	2cs4pJH4Lu+1mACT5E371MyApA+muRwVn4V1NerQxcSftaEP6DDEb3X69jJaSC71
	CNFAj0XHEj8n2jVQFpHnhljydHsuVw6M5YA0pSsaeluS5ZJoZfek7xS1zMHHU8Hz
	ZzFQafyyMI3mbsGenNhffbuiiWIN1xU67NLeyhE1fxFwJWZNHPt5Xkcx8feslQb6
	5AKYPulQgoPLhYCFA4wEHTEfJUUoEnRkp2HAyZKuIpzF3F1c4U9FTZEm3kBVeKZV
	f6QiX1v4SdbbgMoLnc7e4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421121; x=
	1769507521; bh=K/A1ztGXUmTnoE3dUNpk9qemXCaS+0MuelUJX0WTMds=; b=E
	iMG+3QvdAwc19aJeLq6zdKW3Z2lgr6NIBcaloIKeOLG5QNgy5RMdxHu5i+jk2os5
	EtKSl+onXr1agu6BJrMB+DZvbm2fQEWcZxZ3Po9PxgH9R0YxKsMqO1cb9vJGNe/X
	tNmoZc6DFV3MckqqxMWwmHbc11MZkjy3QsMft399mNbIK3r7RufxyZr1UdPzAELv
	wQbZ78FCebabaTaOEwdv3g05N3dpxaF/lkJzPiaWlQ/1UHE8HfQWKJC33dX0RRza
	islDUu2TKKHGce6VJyJnEbW7AlcBld1pO6On06Rf2Qlwcc5kJrYVWcVgbdWfNmIM
	8ZI5r3IiqCTc4qIPkFR8A==
X-ME-Sender: <xms:QTl3aZWlBJkX5HzyD5QNcDooKqKVexDuVi2WCUCySy1Lu-endm28Og>
    <xme:QTl3aQkfSZLxWeePq8fLEZPwbcakH9Zy65PnI6VD6lfmx6fAG93AFK7SeMnk_64Ek
    HE4A9gdqWwgEyLE_1qc-RXnmfaVBHKOgRHJ2eCF5_W0iHdBWHKKLw>
X-ME-Received: <xmr:QTl3aaZaOtOsFUeQ5Nw44mN8kLlE847oBF93oXsXShnIcpnDI6X6Vci8wjigdu1LHsziDwbQpsG2OS9161tjYOncgUvEFvYya5FmpWI3aoU6bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QTl3abPKcbu4ZJD89r-BcFFyFkLgD0QaCKm_idwZMlsQzgTbHSVblA>
    <xmx:QTl3afZV1c_NKnZCzcyAR2Gr1C-NktTysKMbLX4DnBEq3dmwiaEhLQ>
    <xmx:QTl3aZ3rbgqz32fq8V4iFPU_3-i_gCu2E4TqEg1fvfanHTAKuPZQtg>
    <xmx:QTl3aVdzkPuGGtNTi0r4TmpUs5gf7RYq5wWNv0mcKawu6Ecp0SdKUA>
    <xmx:QTl3aV4M9Q0nO-Cfp0Y0MXBsc-xAJcQDUSE1qhLgj-Ftg_8n1iaIJW1R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:52:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a200348 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:30 +0100
Subject: [PATCH v4 14/14] odb: drop unused
 `for_each_{loose,packed}_object()` functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-14-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We have converted all callers of `for_each_loose_object()` and
`for_each_packed_object()` to use their new replacement functions
instead. We can thus remove them now.

Do so and inline `packfile_store_for_each_object_internal()` now that it
only has a single callsite again. This makes it a bit easier to follow
the callback indirection that is happening there.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 20 ------------
 object-file.h | 11 -------
 packfile.c    | 99 +++++++++++++++++++++--------------------------------------
 packfile.h    |  2 --
 4 files changed, 35 insertions(+), 97 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5537ab2c37..6785821c8c 100644
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
 	const struct object_info *request;
diff --git a/object-file.h b/object-file.h
index b5eac0349e..d9979baea8 100644
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
  * invoke the callback function for each of them. If an object info request is
diff --git a/packfile.c b/packfile.c
index 845633139f..57fbf51876 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2327,65 +2327,6 @@ int for_each_object_in_pack(struct packed_git *p,
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
 	const struct object_info *request;
@@ -2428,14 +2369,44 @@ int packfile_store_for_each_object(struct packfile_store *store,
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
+			goto out;
+	}
+
+	ret = 0;
 
-	return pack_errors ? -1 : 0;
+out:
+	store->skip_mru_updates = false;
+
+	if (!ret && pack_errors)
+		ret = -1;
+	return ret;
 }
 
 struct add_promisor_object_data {
diff --git a/packfile.h b/packfile.h
index b7964f0289..1a1b720764 100644
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
2.53.0.rc1.267.g6e3a78c723.dirty

