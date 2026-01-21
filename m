Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226B48B379
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999875; cv=none; b=Nq7BuSHruM3iaJZnuk0EA6G6Jio+TQBpL4M1XmNaTQkusJMhAtC5YfBVtFBHvNC8/HVLyU6Zgr8HnokmRcmiW5hRJXEFtuPBbonyVQOh7dhbQnW6yWrNjdBM7ThsB9ZABcvlKWzVbJGz+AjZOmDwv6mBIgQQKHGuVyWR3COxHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999875; c=relaxed/simple;
	bh=9E/Mrc0ZDSMBSoxj9gQEPpyZMbKi+tlV1hLZjmcjz3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6EmNyZ0hvm036ZfLcxeHq6bjbL+0BjnPUq+11WuGP07ZNE4iWFDiFYGxxY+LxgvQ8WCqK1486QVfh0AOnAdH5Qzy/sjtYki5rr8rbomXZEvxGHsVlywEMfIyJu7xOAZxS6D4IgLcfxKqzTcWvYKpf/ICKRLyQMe0ETU9Lwg5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GcyYZTL5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4hPWAjX; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GcyYZTL5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4hPWAjX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4A687A0148;
	Wed, 21 Jan 2026 07:51:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 21 Jan 2026 07:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999872;
	 x=1769086272; bh=bi8WCaNByaBijflS3KVbt5akEQqNsYSXpML54WYIJk0=; b=
	GcyYZTL5HAXXmef+sCBcX4pG8oxYetDJln0suOxm5mD6VtsyJbMgXbCpOQRXTiva
	Vdj1mkGgjiU7NsVfYEBoWLW/hvHoW2oTtf0ugaV5hRyxrTK/Vsn/6etex4bBcyVM
	pBH9RAdez3Vd74du7tRLg34pqi2ybY4G88NmDZp2IwJOVH08VkIZoTtzLZveZPaD
	OfvFwRPY05+7esyoiPe253kKZtN8MmDa/Ra8a7z7RlVMjswhlvfqygucCvQ7J0hX
	L25mglqoymlg634X6IpdWWqQ9H9nJrmrGh0HzXLtl7IlVF2xggEnR8PRz7l2vbqh
	01hu6+hpqsMUMR3RoI/Ggw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999872; x=
	1769086272; bh=bi8WCaNByaBijflS3KVbt5akEQqNsYSXpML54WYIJk0=; b=B
	4hPWAjXOsWe5GDBEVCEFbPOzGTXuP/O3a6AptewoheBZ5T2Qy7apLguC8IXhaPeh
	rpI+gFB/xRfJclDfeMxmBet5b3UcwuRS4K4E70LFYx6qR76N8vgko5wH3kaL5rKg
	UcS12NGF9BR78Kr4lH+HI2BOTe0MeAglhQcBEEONNyRzBs2lWeQt4TkK6OnOP5r+
	M2R4Kg35nE+zjUIg37LUwTyGlnySMTXIuOXUZurUtpiLWUXVIjTdCV7duLNe4rEx
	lsVMJcdG+U7pFFODJQJfg9rQg0MXuwfh8mbdavOncd/dRJNvIABYuEiabslSxDV8
	sxWpDtmxnIIFfirEG5ZIg==
X-ME-Sender: <xms:wMtwaQ4ZDbTImz1XTZVMVi04QmRkHQAgi5kGHCzdWgXfN-8HcdjSqA>
    <xme:wMtwaY7_LA4XmzhWLzquf-RWXQYxJAOrSbvMjfTFomBI2wm0yZgkm81D_XXZZoQE3
    OHdKkbUjZayCV7qgGSV8VOjCqD5-CuSY8wvHXyzPRfp1eJTlAOz>
X-ME-Received: <xmr:wMtwaUdxlJ9NeF9-4zbsPnjtx0VRK88531xg-d827gAdpKfPfK08x5gzpBuyzgLWsgmPNWHpfpolHB1XzYKRo_6P0jrx49f2BnIYqrtMRZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wMtwaUATjihoGTL7E6xK3w8a0m2KlsWd6oyF_QWvJxtFDyU22pz1wg>
    <xmx:wMtwaf_nCtaFE0RqDwU2ZkgKbUbduUY1Tqc1OLiyXbIRqTxqrp5Krg>
    <xmx:wMtwaXIvvj7p8PfeOhZgBQkeW6zgX_9ffxXj5TjY7qxEaDKi6tkd4g>
    <xmx:wMtwaQiznbbM8Tnh_6PQYvdjFu8raoceSsFNrmrWR_giKJNf51nGFw>
    <xmx:wMtwaT9WECrEel_CcDMVnQBPqaOLrmeRcNOke9EPyefQ-V62OpKAamF->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:51:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 941dfa3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:51:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:30 +0100
Subject: [PATCH v3 14/14] odb: drop unused
 `for_each_{loose,packed}_object()` functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-14-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
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
index c96ec21f86..6f56b5e2dc 100644
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
@@ -2424,14 +2365,44 @@ int packfile_store_for_each_object(struct packfile_store *store,
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
2.53.0.rc0.250.g0ac79233d6.dirty

