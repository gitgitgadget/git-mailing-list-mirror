Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787AE313E2F
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784213; cv=none; b=SEkl4NTxheDnGGlFWRa++sLSIkdLMf5pRTssAxZA0azZ8ZMBMcxsZj8c04/ulpbh28lZVBacWa2xIyf4aG+ZHYeaEttPu9q74jLiVtl7e2BlKhaRKT3MsiBeGx9bn5EwNMTIi/SHpwwv/OAUB4P2nESQDD5Qi+O7CMdToPZgTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784213; c=relaxed/simple;
	bh=fSKWbN0vBlH9stK+EbJCSCl5PmCWkIwQZ+JmwqM2sM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OLkVUt+1FdhrLLcjhyLqbvI4eJajk3rom4Z/J7U0+NxbyUythl6tMt6XVSSjd5JoZ4LKDpCMX4hW+JPBYUx5BnbR7vx3D1z6iX0v+/pEQGOGPd6Zb5Hbyc6KRwJ9RvicigPsIqxJeZI1zroHvXjEHmL9SNTqEQfbYrrfKHIZ1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BaaPbfbv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BMzn4MI2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BaaPbfbv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BMzn4MI2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4411EEC009D
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 15 Dec 2025 02:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765784209;
	 x=1765870609; bh=ISo4ufU0ftI3ehrtJ4HsxNMBnXxK1oGO1w0mh9TENmw=; b=
	BaaPbfbvNRoZXKQ96KXeR6J3aCLkQyuAakFVtQil+B3h1KCxK0mtVhv1TZuBqgIu
	d7P+m82BXVOK2SoEwYcnBvbfl78C/bB8Pcb02HJBVxU+5aeL1Buj4rRx11AWWdfo
	rol0V3agkKtVqCCF9vsoSFWFAEO1zhJ39vJaQjRpcdDM0mtw3IK7R7hQK7FiTltN
	V2ewFl25Qt4cY84HiGLUGpo75tCved3hAZuQ3xAkP7JVJtkvB2R1q3uUkb6WlZFs
	3MWbiH1E267A9uteBnx3ijVaMixBB7Kxduy1hINb2BKa/aCKAYWsUbzuRZMAskVo
	/zrZOdGjWYYF++I/VRlazQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765784209; x=
	1765870609; bh=ISo4ufU0ftI3ehrtJ4HsxNMBnXxK1oGO1w0mh9TENmw=; b=B
	Mzn4MI2lYfNgo/xZUbssX7WnBK2xNLSIkbtbsN6PNVuG2/iFqf5Yhh56HNuZlPf+
	P+KbYki2did+wUG8NY5YST3O5nvtLf38/EKqtKj/zczhiouWvcstZ7LmG3dCHlZB
	cUkFucOx/t6i09NG/EltzwqCWxHDZ8jau73PhXOFlNcZD7l0JouG6M7SLl0DM9r6
	6FGtkLYPtQxXvHlXOsW8pDWSbmEFxIDFHbHSZNUybrL/5R/iFgPNZYEgut1/jVsB
	TDKR0fJH5UQ4jBsjDYrIKlRm7I01StAlj+T758UH6V4/SJwgSECSsE2olfwP0oGx
	RRVEdeCWrryv6Sja2WHrg==
X-ME-Sender: <xms:kbo_acN2lEcIghMO4-FXXyjanpUC7onPhLTz9-5qylnEywjps-_ilw>
    <xme:kbo_aZ7XTRkeNrz2Q5tdSwNAMU9-ygbve9FaBsWmPe5_363YES_LAaj5BKrjqOPzU
    PAnoEHPsjcC6yhPEqv1ncwG0QVc3umaXBlQFArT6NfeEXLO2oDU>
X-ME-Received: <xmr:kbo_aY4tp_v0Sy9f-1CBzoA7zEerNTCPT0NlsOYbiv_wppsdp1gOwWf7zzPGZiNHMWC_YvjX_YvpzjIbq7kGvg43bxbayQ4DbowjxgcS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefiedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:kbo_aZ16eeQaXZeji0fCF-Hh6h_VU1gHjaF6D2doaw5OTsYxdHu2MA>
    <xmx:kbo_aUU4wzv2Ul2TtIzyGNTZ5X-USC85scxooRq038j9fCJWVpx3aQ>
    <xmx:kbo_aU7g801011wwOJuXwMDc1-ZApqyXTU2QMLyv3CXGGrb3eD82LA>
    <xmx:kbo_abKeQ8ewYsBqOd-U-gRrNJXq1hmhBo1mEk6HVK9Rxjf8o2BgWw>
    <xmx:kbo_aXT4cOScJ6nehk0UGrURxjz5A5ha3MKqAb7r2XeasWwHyThuW_et>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f091f259 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Dec 2025 07:36:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Dec 2025 08:36:27 +0100
Subject: [PATCH 08/10] packfile: inline `find_kept_pack_entry()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-b4-pks-pack-store-via-source-v1-8-433aac465295@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The `find_kept_pack_entry()` function is only used in
`has_oject_kept_pack()`, which is only a trivial wrapper itself. Inline
the latter into the former.

Furthermore, reorder the code so that we can drop the declaration of the
function in "packfile.h". This allow us to make the function file-local.

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
index 6872b16755..2fb87a26d6 100644
--- a/packfile.h
+++ b/packfile.h
@@ -444,12 +444,6 @@ int packed_object_info(struct repository *r,
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

