Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78FB279780
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913152; cv=none; b=KHqtUK2QSncehOpypxAuW8iXloVjPN7CJa3DOoyjAnLuLzLiMaM2wyZIZxajMz4F19xySqkJlKRVZzeqi1T3z6/N6JiOhq3iNY4kov+xg8e00aDA+5+YxJ0Ox96o20cUJrvxLCXFX3QHzRKUAKgWBBwyoa7LYDenMLsJXK0mTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913152; c=relaxed/simple;
	bh=sG9IXpVZ+/hrnDEWJP1JguwBa32C6eQK1r1xLkeGq8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCq8xl/7EXK/FWQGDY4ILTM1JrKTGIOKfxMZSWNRPfNMEuUj9Tj5mDiBz/ZdzWMNkg7FXfRkUZjXZeacDTLKnf9juf2V7yMY5M/khtwYc3bFXJlpffyBl2H8Ylyw0KAOA55hDLSTXfTWilg+a+JhKXlqFjk7r5DPedkZ9oCfw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qyn6sNlT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KLkFHw/3; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qyn6sNlT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KLkFHw/3"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D49D1380516;
	Tue, 29 Apr 2025 03:52:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 29 Apr 2025 03:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745913150;
	 x=1745999550; bh=ixnmdmqMQslMltCSLZPd8ZtwFGjrEtd5U3/EmzTQE4M=; b=
	Qyn6sNlTurdjhDOig/WHlj6ICGFanpIUfIWOTMXSP5quFGd/gBCJATib6FgJ3AjR
	bEOuj3Idi30ddw1s5U/3WzZ/qb/5AhjmVe8UBNkvfS8MENIuou2u+vKIU4LlaLfj
	63L2geJEbEue7F3R49Ogp905wK1T97jyGFgBV8SMRQM3smNLF+uza0MM4EmhygDv
	nxlbDfVjDO+uj6ppqs7ET3Lxo88z9DWRhP+4xaFOJbCQl0CWwRYBwSgX/asEY5Wv
	0Mc0mfU9u2kVyKVaCYECE1Aimgh3lVJtUcYWtsL4q92+K5L81Wbn8oFrR2Xf5qyA
	atmyYw7ouIDE5/HgjZOsMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745913150; x=
	1745999550; bh=ixnmdmqMQslMltCSLZPd8ZtwFGjrEtd5U3/EmzTQE4M=; b=K
	LkFHw/3BPStkO1LRnYOWcp8wFtRvtYI74BT4FpaE1JMD04ZU313qlSzk0pG8P6WE
	ZF9l/ExyTyxgXM0ENPcaF96xmFOsT6t8/Ta83egkrDJqMEd8yw9IKk0bz1LrypNb
	XSafS87zluEuJFRujCUKQp2dP1loNnScCvxgORKT0zRHBvis7PM7GlF60+DQaLjk
	t5IxExRe11J44Vu/mIQ+D+3TDHm6l1EyAui6z1IDcKULDX8nYNtv39/Gr5GS6Mxd
	6d28hGTvbCFX/YJnjAVvn/OWHDh4DZraN2KF0TCq5t5Prt+XyKBgjOeJPzcaa8aR
	GbJoa4GdyToCwyZG/eZsQ==
X-ME-Sender: <xms:PoUQaN6BkM9tjAbnpYHnECZ4d2vcNR2H0FPyTkjJjM5kYblJa9Yvwg>
    <xme:PoUQaK7b0rnzXINupd4uHLObHH5tUd-sqxGNYNB-R-K_C0Y5Bbqf6dJjO_gboOYem
    qrwuG-G55emV-W1yQ>
X-ME-Received: <xmr:PoUQaEc17u9WPpjOho3a75GfKKrfKEGrsu_V0jJHAxlbuXa6jvUq6d40QdiJxLVjgu3TARsIXMVNsruCMA9BH6FBJ4fi3cUlpylBn2DDUYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PoUQaGLloSCVx3WLqrMRZB-IX0g80fF71kPDE-Q1yOe4_eeKp3WU1Q>
    <xmx:PoUQaBJ7oAeW2PUfQVdnsZbeItZSIO1to7LwJRCrWNpuFc8_8R7sqw>
    <xmx:PoUQaPwuZf9ti2ZziG2ogAquQVnfmJ9ugvwZ5X1L8MUwEr16yI7QUQ>
    <xmx:PoUQaNL6OPEfruHePmNXrbl0pQaOy3T6d5dft1JLgiIpTVaXLLlRBA>
    <xmx:PoUQaOls9uQgJEqXcQLytxlPwrGdcvAm7I8wbZial2OtzMLkOiOavbFl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 03:52:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12df889c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 07:52:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Apr 2025 09:52:21 +0200
Subject: [PATCH v3 7/7] object-store: drop `repo_has_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-pks-object-store-cleanups-v3-7-42902bad09a1@pks.im>
References: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
In-Reply-To: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
index f0e111464c2..c2fe5a19605 100644
--- a/object-store.h
+++ b/object-store.h
@@ -276,23 +276,6 @@ enum {
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
2.49.0.967.g6a0df3ecc3.dirty

