Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21910238152
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564953; cv=none; b=gpwivRE2a4cyjbVNr4qg0eSJLRP/F71PSw77WLqxOaFmNsKu9P2AS14fYwzo0BGKGtds7H7Xyag4/XSbElCdmCG5wEV2rKRWhgMelDzIvBZESKQ7AGYfB/qY3mYvRJ/u33FywXnfJtQeDDEQcb3QUgk0txlMDmZBIgIh4XJyOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564953; c=relaxed/simple;
	bh=DTvIGeAqYKaoIODKitoEPhn+InOi7TLOyGxFauN5Wng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DY5eIl9Gb7wrAPYpaXPr8SSylguEpD1cN8OhjAjvW6xue8zIn18Y4N9jGksvLATFjs01M5nWTZO9IE/0yJn/JaM/CWmSTHuz3qm2zWnZ2AhMKVc3YJv8+nURjlGEHRUe0OAOeAexTC1kyb6LaKrlNFSCYWsDs2x2gHalg1UkcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=StmpP01z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KqW9E9hr; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="StmpP01z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqW9E9hr"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5150F11401DD;
	Fri, 25 Apr 2025 03:09:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564950;
	 x=1745651350; bh=DTkAGtZJJLWXA8zhGTR+ew/+MigYWjQWiYAcevIhS3Y=; b=
	StmpP01zXG9GdTiRIx7ESQ3fCsd7uGeinUF/7G8TRXUcSeezHQw+DFQXkgEm4p5i
	eeCmLVjwqXx8Gk4Cx1zDHlrUFq7rgG3HPbREBklNiWMU0ntMXuUmePCu7WLcVNeM
	qZRwbEvvf5og9NWQOGofMy59yX3DS0qAaoOexxJf46ePJe0bhhdTz8vKf3U/1OaB
	A9nReIXN0n860yrC7d3ppnG0RmCh/O7eEMNSX8Cx8DgzE7kWsu6CTGR/UJdPakAO
	GZUW0pILGSFeDBzcPe793E6J+YEQ44uQEf5+Pw3YmVr4oCJIH7ThevLwbRmB75E2
	guBzgqLkmy6OkVJffZorRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564950; x=
	1745651350; bh=DTkAGtZJJLWXA8zhGTR+ew/+MigYWjQWiYAcevIhS3Y=; b=K
	qW9E9hrp/3rr7ZUg431m5ee1a/BDN52CemN6717HHMXDQdqjiw1LMowG8z6NO892
	nW9Mrm7bpHuf3NgQHj91+++vV+PTpe/NZdKDblGD+NlGZ+GMhtCs2fFtIIqWxaoE
	pYr6vr+yCsTPoKmd8Ke0ICqk7HsYpzuZEoi9YexPpKA2y8EP5oYM/zVzS95XSRB3
	K6Rzxzai8GZ6kejNA65fuPJLKVo5d9F6g5LAtSqbn4L8dXOmA4uN4bBJgVIpArkn
	4pMDkP9LzebYwJh9x/+6Hm6qWmTG3ndObLJUGZ6PQMs+8FuLB/EMITsQlPy6MBxr
	bs0C8sjIcudn3cSDObKaA==
X-ME-Sender: <xms:FjULaBp8qKzZu52m4ObWLWj-Ls8ze_k-fnJDJa56UlhK9BLWf6LfDQ>
    <xme:FjULaDpPKh_sCQsW85TACBlLnShjNO7XPNv6wa5yg9X5CY3LAAe1pJok1_7Cr8PjZ
    Nir2c1FFOzGQAzYXw>
X-ME-Received: <xmr:FjULaOMvCpVb0zfHpnXx7GxCKeJQi5VLr3jwEN4TQ8Xp8Rv8tTtI8ctVEZ8nJKz6b0GWkk7TKX7UWjdwBY60TBkmDmc5DWgWI3hwqfwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FjULaM7Bg-BKwiq4HJpKMnqwAps-Ar-ClYS8Zke9BnODHkqTqL9hYQ>
    <xmx:FjULaA5dZIIdb0ds8X2pcR5PimbkP7-XWPddY91rygS8-OK3VhZ0Cg>
    <xmx:FjULaEjPJB6mlgALCjYnI9bsY6-FcLon0iNMjgFIFA-ukO4pZvS4sA>
    <xmx:FjULaC6D5OAErT3E-HsxsxP-mQrqPDCWgpkKfP2wshZgkktKawf1xA>
    <xmx:FjULaIUDy440dvytRwlqGXynyI5aMEzR787GX0vwjheFXlUt-LpMaWNu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:09:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 735a1ef6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:09:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:09:04 +0200
Subject: [PATCH v2 13/13] object-store: drop `repo_has_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-13-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

In the preceding commits we have converted all users of
`repo_has_object_file()` and its `_with_flags()` variant to instead use
`has_object()`. Drop these functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-store.c | 14 --------------
 object-store.h | 17 -----------------
 2 files changed, 31 deletions(-)

diff --git a/object-store.c b/object-store.c
index 2db34804e8f..2f51d0e3b03 100644
--- a/object-store.c
+++ b/object-store.c
@@ -949,20 +949,6 @@ int has_object(struct repository *r, const struct object_id *oid,
 	return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
 }
 
-int repo_has_object_file_with_flags(struct repository *r,
-				    const struct object_id *oid, int flags)
-{
-	if (!startup_info->have_repository)
-		return 0;
-	return oid_object_info_extended(r, oid, NULL, flags) >= 0;
-}
-
-int repo_has_object_file(struct repository *r,
-			 const struct object_id *oid)
-{
-	return repo_has_object_file_with_flags(r, oid, 0);
-}
-
 void assert_oid_type(const struct object_id *oid, enum object_type expect)
 {
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
diff --git a/object-store.h b/object-store.h
index c6055376f49..2330374990b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -280,23 +280,6 @@ enum {
 int has_object(struct repository *r, const struct object_id *oid,
 	       unsigned flags);
 
-/*
- * These macros and functions are deprecated. If checking existence for an
- * object that is likely to be missing and/or whose absence is relatively
- * inconsequential (or is consequential but the caller is prepared to handle
- * it), use has_object(), which has better defaults (no lazy fetch in a partial
- * clone and no rechecking of packed storage). In the unlikely event that a
- * caller needs to assert existence of an object that it fully expects to
- * exist, and wants to trigger a lazy fetch in a partial clone, use
- * oid_object_info_extended() with a NULL struct object_info.
- *
- * These functions can be removed once all callers have migrated to
- * has_object() and/or oid_object_info_extended().
- */
-int repo_has_object_file(struct repository *r, const struct object_id *oid);
-int repo_has_object_file_with_flags(struct repository *r,
-				    const struct object_id *oid, int flags);
-
 void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
 /*

-- 
2.49.0.901.g37484f566f.dirty

