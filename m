Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65AC47ECC1
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922816; cv=none; b=LvHK1o2saz73TYFP1kJYjlIrsK+KdPCu3s6pz58l8HylQSSZbYnendGm1OHMRtBm/i3V0HbPxAkMVynELovHjDNODnsVXzvgJOpF0Z1LqMQtRtOWXNTDFyoV1mlFCATvjCBp4Bn2I3TIgUCLY4PfkTR/x5ju8HSG28K4qJrIDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922816; c=relaxed/simple;
	bh=uyE8zuZxX7I/mtAuTOJ47QpfAZ43yV64zj+XQSF8aGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pV2XG3K9umNdpXbCKQo9VVP/ipf053Vx7oFax6YsHyc2M6gVls1bEAcjnz/n9RdH0UEnm/kt53ujw+g19dO0QaoXgmv7hWDKpX6qLsvmzChe5nG/ZW06b5MBhzoGts1GYzunslVqlaq5dm27jxtO9lBRGqVFVIN3GYQ9NPjmqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VZxCKSx+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hVW918Dd; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VZxCKSx+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hVW918Dd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D6961D00029;
	Tue, 20 Jan 2026 10:26:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 10:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922814;
	 x=1769009214; bh=YXumM2DZQzv4y78q3WjLuqjbAYe1cbeEp4OzBH9qBDo=; b=
	VZxCKSx+mrPEJ1NsjrMfhnQQwjV+kU6GWRmUk1IixfM8iDJmxYS+udC2BaTrcLO4
	b/zt2Gdj4TYT4zFjDFt/XawEonzQAjAcs9IuO2355HNm1lNO60VXvfEL16+G9vuD
	89tGujXcLEI6zGv2DbeXixF34llCpMFIdaSWmqr9B1O+5e3c+pi2DRotw5eMjf62
	dxTgnod5SpKWry6jv8yok6eWUZchhxRRvEldPLh/IqqmuKnWkf0oWB/o3gcmAOvv
	uIOt7UURARmGNpYcsYIv5ZrJW97pxLvwtOTnZdN59n/fV61DyjkV+k+esl6UdSJq
	z3/NhVTl573vrBRFKGdEjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922814; x=
	1769009214; bh=YXumM2DZQzv4y78q3WjLuqjbAYe1cbeEp4OzBH9qBDo=; b=h
	VW918DdYdUH8crxhNctwUeDI63MH7EZXsmqgWsXgyumHZlht14V7Ks2mCNKXPY+H
	qZOTrueZONB3CodKCJRwsbLczHW6IWvxZsuxHV5+3j0DlfZpc932Yeno5du74Gol
	X+sSwN5Hq0rCCHSyT0QucxEq0QgUz5MnkYCUAt/keCuIqgLe0QzTNeScYK/Ume//
	OmsydxdkG0Um+wmBpalCl51I5Y9G1/vwNQozU3DmtV+je6GVN+CUaHzGYhKzalHa
	249fbXgTRUzW0n3h1a2WDhEQ4oF+1s5b3ofyxsln8oxYF66H7B0Kt+1lr5itZoQ8
	fCh8vQxIYsRXi9qk0/8JQ==
X-ME-Sender: <xms:vp5vaQP25NmSzIjnrYo3PP24qFCfSHZPmJMQaBpN6qS6vGVbIVR6pw>
    <xme:vp5vad8xdkOV27jJKMAxdMzwgjsc6dSDTYNh8ojTcRe0UqSuHGrjT8Ki3E5CTH8E8
    pQIxX8V4sAAHnKorRkh1XBOB779r9crJK6wvJswYjKVSY5wGJMBLw>
X-ME-Received: <xmr:vp5vacSjn7PJG2sbopxc8jfbg7TUUFT5NogtAjrLCMafESGGI4-yrcyuTDieW2Gnm72JMvqdBgjrhhps302BQs03HNQw6OHvH5EmY3LZgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeelnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vp5vaXng6rEaNlwRtOF0GfodkdcazS6VDHBZuILKD3RSURAiQgFbRA>
    <xmx:vp5vaUR_e1FmPlwlUhc0reMuxr8so_H2PbSTOK-tRSv41aIQbZK5Hw>
    <xmx:vp5vadOVMj8oKdHQ_xu6xOOMvP6eAc-uMTVCgHQYSqvm3lUKhMWj0Q>
    <xmx:vp5vaVVwlPuHphm8vk74DGlgVWo3CiyTt-0yOQypOglSaiHC8Ybo6Q>
    <xmx:vp5vafymh-5Ti3ZAqpZV-Vpyb1U0rd6P6EsIWSana5EM_tqnV2HB9CRq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e53b88b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:26:10 +0100
Subject: [PATCH v2 14/14] odb: drop unused
 `for_each_{loose,packed}_object()` functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-14-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
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
2.53.0.rc0.250.g0ac79233d6.dirty

