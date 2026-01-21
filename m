Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6067481AAF
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999850; cv=none; b=t4EN9c5cMmpX8uEwo0qCA0klN/V0PQOb3LZ+3oq+en0fNmcwSzOB4ilJs0C7U+wlyUd8WXayouLdH7DBrfuWYFE0Tf02aK/zfz0qBHAIGhyvp6/5UnNXFwb9SPWH+TLkhStfOxjh9DgMDWLYLpzca/mWpI7sEaGRP/oXUysO0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999850; c=relaxed/simple;
	bh=xbYgNUWj4+m0BjVlhY1zI/gZmzZhwoVkCZ6j1gX/xX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISP75zxWuyb4jCmxxw301SrQZelYMLNKLmEZ0HjkyvQHThaAzOoR6RR7sNVU0lmXS7PG8xj7XPjbXObpIFBvnnFH/mGsVVUQSqOQ7F2ydgQd0kAXJy59cq9sYUm6H2syt5+eBMG4C06EV+K783ReOHqvabNayMxzW89w/YDU5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KSzYT6yz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m4FUSBap; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KSzYT6yz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m4FUSBap"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C6AFC1D00016;
	Wed, 21 Jan 2026 07:50:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 21 Jan 2026 07:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999844;
	 x=1769086244; bh=9IK9tGmUznhWX3U7/oLqpH/mUDkpXY5mYRpgaEbKs5A=; b=
	KSzYT6yzO2I6yych+R+UPzufIc1klu3jIM6nq5WI2ufNXZb+tsCEkTfL4ktQR2ME
	ve9/Jz18WcOLDpzwGDXiDSetbWDe8cgKYRCgkN+2vLsE+6ZKlGYV8UZvOjDHWfZF
	7YhRwGEWP4SHrApf1Q2OO4WTSYQ7xQkFx0Y9ra7zuD1QkJa247z9/zTAjp7zVudI
	tcfplHhkL03HZduw4c6etztCG+EPkOQz1pAz4PoTdNWjFKb1ZQH7KA6wNoRzTesU
	el2wSgWrhn56R5S449frPG6+s7DvdZV9LwzP9nk3ZkOckcdSIK7A0W+yl5jHr4rR
	SKwoxgh8ZGWKqW1Bq/jdXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999844; x=
	1769086244; bh=9IK9tGmUznhWX3U7/oLqpH/mUDkpXY5mYRpgaEbKs5A=; b=m
	4FUSBapuggGSox6x7sN22Ukmc5B9KKGm3fOfXisaZoJFReuJL+rUo8L/yscW4+W+
	TVOK2c2OopBg58tPwxS6GtyNrRrohSpE0XHJWtq7PaRclldYY2m3ufKeszfD2amI
	r9BiaLTB92iDT6Ymf27/rs07Nv4oZM6D//jiXWX63NcuRU16tiM/ogFrO0hfAMW4
	48Nw69PURjFJgmOAXdv7Ur9ao/ILVt89CJwdudyNFBAjwIwPnJForvHcmdov3fn9
	RCehPVsff9l2R3JLjkzBSZjUdJMGbrMUA5PTISYeC5PkG0Z0haJz6QGkWmhnS4sh
	njBG41k/TWcXqGsUrGBjA==
X-ME-Sender: <xms:pMtwaWzg4AjPEM9i2R8djiYfGW55z3uN0dAHUglkv-cVPWqlciT8aw>
    <xme:pMtwaZRWH8AxmRmkyxO6ZnXoD5XHOBfLIxwgjft3NYhcB6zRAFaUKg0Z08tS4qPp2
    VxMk82n16mRWiyYdxLLZFEVjdL7VRrJYMWQCQi_hYb0TQfaLoQT>
X-ME-Received: <xmr:pMtwadXieosA4-GBVo86Ny6tgX11XE-NQMxBF2sng9nz8UYaw8rfssbEOD8owcxRwm_Iq2s7xGGyKb6txpj4EavnP-9Mzw_Neu0GMN6sYuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:pMtwabYAmnYQ6h3TB7J53scxuqHCw_ItMc7Ytxs-KbdsuEoDyEYFIQ>
    <xmx:pMtwaT0HPwWQc7NrcibgBvDQYohTViUvqTau_MZrh1D4Fl_f3r-poA>
    <xmx:pMtwadgwKb3KaciECMZ3LCU54nUocsTBOY2TrJ1CibI6YFgvfjI3Rg>
    <xmx:pMtwaXbvdmvjXG6L1cE79Lb31_QMMugsbujNMXO2kLqCLZ-Bnr9dAw>
    <xmx:pMtwaU0FkcWAqaMTN9rt7cUTOz9xk2p8M3YbV0zoD8E8SeHrFbiXsYqU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:50:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cba746e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:50:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:21 +0100
Subject: [PATCH v3 05/14] packfile: extract function to iterate through
 objects of a store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-5-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

In the next commit we're about to introduce a new function that knows to
iterate through objects of a given packfile store. Same as with the
equivalent function for loose objects, this new function will also be
agnostic of backends by using a `struct object_info`.

Prepare for this by extracting a new shared function to iterate through
a single packfile store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 78 ++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/packfile.c b/packfile.c
index 79fe64a25b..d15a2ce12b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2301,51 +2301,63 @@ int for_each_object_in_pack(struct packed_git *p,
 	return r;
 }
 
-int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, unsigned flags)
+static int packfile_store_for_each_object_internal(struct packfile_store *store,
+						   each_packed_object_fn cb,
+						   void *data,
+						   unsigned flags,
+						   int *pack_errors)
 {
-	struct odb_source *source;
-	int r = 0;
-	int pack_errors = 0;
+	struct packfile_list_entry *e;
+	int ret = 0;
 
-	odb_prepare_alternates(repo->objects);
+	store->skip_mru_updates = true;
 
-	for (source = repo->objects->sources; source; source = source->next) {
-		struct packfile_list_entry *e;
+	for (e = packfile_store_get_packs(store); e; e = e->next) {
+		struct packed_git *p = e->pack;
 
-		source->packfiles->skip_mru_updates = true;
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
+			*pack_errors = 1;
+			continue;
+		}
 
-		for (e = packfile_store_get_packs(source->packfiles); e; e = e->next) {
-			struct packed_git *p = e->pack;
+		ret = for_each_object_in_pack(p, cb, data, flags);
+		if (ret)
+			break;
+	}
 
-			if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
-				continue;
-			if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
-			    !p->pack_promisor)
-				continue;
-			if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
-			    p->pack_keep_in_core)
-				continue;
-			if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
-			    p->pack_keep)
-				continue;
-			if (open_pack_index(p)) {
-				pack_errors = 1;
-				continue;
-			}
+	store->skip_mru_updates = false;
 
-			r = for_each_object_in_pack(p, cb, data, flags);
-			if (r)
-				break;
-		}
+	return ret;
+}
 
-		source->packfiles->skip_mru_updates = false;
+int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
+			   void *data, unsigned flags)
+{
+	struct odb_source *source;
+	int pack_errors = 0;
+	int ret = 0;
 
-		if (r)
+	odb_prepare_alternates(repo->objects);
+
+	for (source = repo->objects->sources; source; source = source->next) {
+		ret = packfile_store_for_each_object_internal(source->packfiles, cb, data,
+							      flags, &pack_errors);
+		if (ret)
 			break;
 	}
 
-	return r ? r : pack_errors;
+	return ret ? ret : pack_errors;
 }
 
 static int add_promisor_object(const struct object_id *oid,

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

