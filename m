Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397BC34AB05
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947617; cv=none; b=CnVNpfCDAiEuuwhwqWBe3kMfb/Eg84mOkw23KWDK7hxUrW5DDhxjwY/s65K/VsUB9EPNcmQ2S9xSLEx69zGJY5o0BAkOyJfZ0WFStWUmezQAKy4XpVjT+D/RppirICnB4zX2kD7rRdaVtxRJpfeu/Elj7ZGOxITlYSFn4vvy86Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947617; c=relaxed/simple;
	bh=scivwbWkDwqxYFgmUloHBZOe8PPAStj/4HVn2XiD0ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QwaYIdMcI7ZZ99BtebW/D4jiIi5pkYj+uMd8QK/QQT3q8zLcsDw3OfMsLT/HofmPBBA1ja7Wpf1wcmouD5PPMx/6aUbVVnL+R83IxpEOzAmeSGAxj1oh7IouUtfpLOEBfvHaEZwQpmhtwhcX/oEN5iBnidrxbCZacAas5w0nKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DjpF6q4l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=np7V5djv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DjpF6q4l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="np7V5djv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 853C2EC018A;
	Fri,  9 Jan 2026 03:33:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 09 Jan 2026 03:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947615;
	 x=1768034015; bh=CtAnegE5wKQU5yDCX2izfjVgSEbL0+huD+1pCH2rSZM=; b=
	DjpF6q4l+JhBKHIL2dmK/d5Q8zstlGjHypidLa5m5HiGUwPtROANsSA+ddItYkcU
	UMyGhitqxtTRZ3k0SxvBSXiSmR3ucaqHa3NID6UHZ0dnsYkQlPNIjQ+Age+ptmMH
	cAw/KpoIuBsdFeRS+YGBTMkNDmltNiItp4qVoTRG1pyRJAUQ2b+nsI0cPM8LzDnr
	1hUCsEtKaAORQXopR3JmvmtQ6xN4jGfaMqNAk4rITU4p3cYzyEluvMvVjqW6mE+a
	OvbpvdPW9VjSTic91CkfJ31ZGlDlTQi7k2MNcs+KRGdGbhiUqxPTb2KA1SDXq3CF
	62r6CI/BI43KlCHGscDXSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947615; x=
	1768034015; bh=CtAnegE5wKQU5yDCX2izfjVgSEbL0+huD+1pCH2rSZM=; b=n
	p7V5djvRy1S9UooEEiJIAcN0FqSOW/EYX349+N1K2eHotR+ezfbMBfrisxxHFGEb
	NofIBPxdyfG6aAtwH65QeYpSe29TFLI6LIpA+gVjGsLrtcaF2Gv4EH7RDO4mJOkm
	DzFpkJpKhXkL3UVCA1vhtcoLAPFIAkA3oyEJ70EzbmwmmOOpYpOUrWWJavZecI6M
	Zr2kLH0nWPPUWqIWqUXAnh4b5MIQ/Q/l9bhrO3QaNsnUfiLYxi028cIqztZtLW4v
	4UyMbMYL0owVOQG9d5aHKh39U5jjWOKqprMgNHTCaKYFyiKJv1SB3BHUHxhd+eVs
	kd5Y3YjL0cx9eAPenrNjg==
X-ME-Sender: <xms:X71gaQ9mDI7Fmb7CsuI3Px2oE2mFKeOwZa8m0bxtBzYWS6mx3gop2A>
    <xme:X71gafuu-xm6d8ZkUDP58yHtYURMcT_I2E1yjIxY_MEImQPcXpP4L_ApUdAxM9vjj
    0tN8ONCC9CPn0104ShSbmRFfqb_vMYzafBZ7ZAyx4pse8V8LvVvQA>
X-ME-Received: <xmr:X71gabAQrZaRnKHwvMJVBRJo6rPzeyFJtT8JdClJLDzl36pZ6iJ2rLkndJQGtWdv2z56Bt95TUO0RuTwDmflsMfZrlJh_r-ceq819Nkhew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopeht
    ohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:X71gafVIDoAntXMhAaeCAHCHEGhOxx9SsVJfCn5dFSXAAHYR-4wkjw>
    <xmx:X71gaRBkvsAiljKY-6bQxvfGZUeZXeUMZgVy85Pj9ia_MilpteJt1w>
    <xmx:X71gaa9ITYwabGwErQnD-x0LQN187KG_82X2RHpdSrACx3fwqoP_qg>
    <xmx:X71gaQFAdHesiscUK8Di2vlzXIWmn3afcJlnABwvOBvoBIlXUD8qLA>
    <xmx:X71gaXDUo-g0JDSc_HOf0YCFkgBU0xnMJiQ3r6rVSBImrUk_HGOUfs2N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:33:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e2fe7026 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:33:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:33:16 +0100
Subject: [PATCH v3 08/10] packfile: inline `find_kept_pack_entry()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-pack-store-via-source-v3-8-877fd7b7bf81@pks.im>
References: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

The `find_kept_pack_entry()` function is only used in
`has_object_kept_pack()`, which is only a trivial wrapper itself. Inline
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
2.52.0.542.g9473a8513b.dirty

