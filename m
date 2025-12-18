Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21B263C7F
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040952; cv=none; b=idRm/y36BAwNvw2yEzNTmh03pqp5bPPIIe/8UGqMaWZ0CpugIsn2iM0AtoMFeiN4mHjyIPvsmlVscZqkwcLYMCHYXBWrNVDus+pAJebckoxoS/oaCdfLAXpXppi3NdTdDzVMFPTWYkxrQbuUmxilxufMoUbjS2vtg/UqXqyOoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040952; c=relaxed/simple;
	bh=MVpWsjIkb3kAlYVINODS4vy+DfoOytonqW9eCByDfyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5ydH5dAp5hEwac/VE7eyFpLF3nkRa1PYX4jyfVL6Oi0el2QuGy6htP0olpTD0MRku1ZmWgOd+bl20GvweRmwLUJeQ1dWPJLDUO1djUz5xPQ9f0JIY8hd3OZWnyN5hSvyN4jSawjIP1FOycGC0wCQVakeFTQGFnYh7AejgoD71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DV6CEKZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MAtJ5JZU; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DV6CEKZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MAtJ5JZU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 469C07A019E;
	Thu, 18 Dec 2025 01:55:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 18 Dec 2025 01:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766040950;
	 x=1766127350; bh=sMCJSqUxXzdXWqLePqQtfx2ZZKnA2P5y74l0ejg9qsA=; b=
	DV6CEKZSSFerACSSy4/Mc4GY1oRMx7vuR09uycJw/z7JlcpXgZHsQbSMbEmL4S1z
	0ZYqoTQl4jE5tfLsolr/JGnCaxJNd2O4Xi4gkHuSFXc2XY51MRC5U8Lzcqd0eB+V
	7bGsUpPciBZSH9DUmcNzcL6NSIqxMhMUwVu4xjwzgaK2dfOKVl+a9RaPc62IV3up
	nmGmoDj2iO+4FExX5I1QUQaM2LfztfMiF/uMgT7qGT8d+lME3n+o6ib2h8Moborc
	+IydiZksLzD4MKYG4hp9804PBjZ6edKmHUHs4vMjGRh4fnSIdSfEOyXtw/1FKNQZ
	BX09eGqCzqn7z+wuD9iTiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766040950; x=
	1766127350; bh=sMCJSqUxXzdXWqLePqQtfx2ZZKnA2P5y74l0ejg9qsA=; b=M
	AtJ5JZUSHHshFryIwxWVGHLwVA+gkyGERqIKDIAwoOfk6Z0/96cDqFCPnS8rS0ji
	h+z0uNxikk4OtiDPQRveQmYSf1c+ngfkMFDesis3lFs5mf+GRanXFBJXV/IhiKwe
	m2baxhznkrU5MawugJpkEI0IlSl6lFhh2Cb5xZ78ztYWkss0iiP18IWkXeGFEJaA
	xXXL2fEDT2Dl14XUxPd7ym0v55rBN5WYg06o1TvSnnxTVIhN/fdtH/ccm320w3py
	M1uH1BY4vd/plCb0vd7j8l5pi/w2G5lQlI3NRnzhdAouVhdsY7NH0N8QEzJeDKQf
	4U568ULJ8MXLDSWhwr+FQ==
X-ME-Sender: <xms:dqVDabhknNSFig2FiWitrGvk1zwu7EVWEFxel7xq793UQJoAfNxYmA>
    <xme:dqVDaeDRR0tN4GYQrUjZG6rnLejOdkGnVW_b3uDiV285ojSmN-Q9dfKgsbfzA_m1P
    uGohZLZw5iOFtFvJ2GWjfgZBk53P9p0moq4T5OGuRaV8fZ4GlMw>
X-ME-Received: <xmr:dqVDaYuS7IIGZlmhk2fzLjNqVo1pOqH39wD7Q4EqIqLzAp7_uukk0DiZnqSbkxxjFNbwYdaZcPfNkuOyI-JRw4KPahgi0XeNz4RcmYxNCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dqVDaTaQYRRxTWsAu-GQrsephx3fbO-5Hs1Bh0o5PH3JKCd2Lbsj6Q>
    <xmx:dqVDabVoqQTxTeJ6t3CcnFaKxlU8uYOYVG7xoFpc9FUALfymObcaWw>
    <xmx:dqVDaX4eqEpN2APhYp1BwJwjtCw833rMPE37iR-KD44bO5c2yheZ0A>
    <xmx:dqVDaWjithCWr4Jq5JWn6mwrT5TULncc2QN2PdV_6bwqrWTEWp-inQ>
    <xmx:dqVDaTTr2G3uGnShO_0G0j9nPc9b4P1UQJx3F0wEMSL2kvwdddO8o2-O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:55:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5171b30d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:55:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:55:27 +0100
Subject: [PATCH v2 08/10] packfile: inline `find_kept_pack_entry()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-pack-store-via-source-v2-8-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The `find_kept_pack_entry()` function is only used in
`has_oject_kept_pack()`, which is only a trivial wrapper itself. Inline
the latter into the former.

Furthermore, reorder the code so that we can drop the declaration of the
function in "packfile.h". This allows us to make the function file-local.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 28 ++++++++++------------------
 packfile.h |  6 ------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/packfile.c b/packfile.c
index 23d8f7cb93..3bce1b150d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2215,12 +2215,17 @@ struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *st
 	return store->kept_cache.packs;
 }
 
-int find_kept_pack_entry(struct repository *r,
-			 const struct object_id *oid,
-			 unsigned flags,
-			 struct pack_entry *e)
+int has_object_pack(struct repository *r, const struct object_id *oid)
+{
+	struct pack_entry e;
+	return find_pack_entry(r, oid, &e);
+}
+
+int has_object_kept_pack(struct repository *r, const struct object_id *oid,
+			 unsigned flags)
 {
 	struct odb_source *source;
+	struct pack_entry e;
 
 	for (source = r->objects->sources; source; source = source->next) {
 		struct packed_git **cache;
@@ -2229,7 +2234,7 @@ int find_kept_pack_entry(struct repository *r,
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
-			if (fill_pack_entry(oid, e, p))
+			if (fill_pack_entry(oid, &e, p))
 				return 1;
 		}
 	}
@@ -2237,19 +2242,6 @@ int find_kept_pack_entry(struct repository *r,
 	return 0;
 }
 
-int has_object_pack(struct repository *r, const struct object_id *oid)
-{
-	struct pack_entry e;
-	return find_pack_entry(r, oid, &e);
-}
-
-int has_object_kept_pack(struct repository *r, const struct object_id *oid,
-			 unsigned flags)
-{
-	struct pack_entry e;
-	return find_kept_pack_entry(r, oid, flags, &e);
-}
-
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn cb, void *data,
 			    enum for_each_object_flags flags)
diff --git a/packfile.h b/packfile.h
index 07f7cdbad1..08a666d538 100644
--- a/packfile.h
+++ b/packfile.h
@@ -445,12 +445,6 @@ int packed_object_info(struct repository *r,
 void mark_bad_packed_object(struct packed_git *, const struct object_id *);
 const struct packed_git *has_packed_and_bad(struct repository *, const struct object_id *);
 
-/*
- * Iff a pack file in the given repository contains the object named by sha1,
- * return true and store its location to e.
- */
-int find_kept_pack_entry(struct repository *r, const struct object_id *oid, unsigned flags, struct pack_entry *e);
-
 int has_object_pack(struct repository *r, const struct object_id *oid);
 int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 			 unsigned flags);

-- 
2.52.0.351.gbe84eed79e.dirty

