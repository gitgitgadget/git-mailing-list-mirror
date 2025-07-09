Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2A194A44
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047723; cv=none; b=f00acJSJfnODh8QqpKkc0YYfrLSevTcYiqNKACGmc+QMAo5trffkMk4KcDq+wWypHh/3PMbEhgLwjFvgbK9FvxhgGJVLlmLbvFrRCDtOr5/IPrKMZwFs3nN067Ck7XN6yg3a1QjvCl/oHNpkhh9rbvILWqA78Vj4efwEhZO72/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047723; c=relaxed/simple;
	bh=XfeB3wLw89jzovfzTBetIZhwJ6hc4fyOc7McRpYd4lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIiHUlt1LjNjIkDhiK21eep3utwJ7SuEQ0BKdg/TvAgWMocRXQ+lxoVeaY6Jbt29qqtIJ27h4yxtr8v0WVUxEf91ajRmI18hkhXcyxHMbbtBgNdvzey9+n9UnFZBiYLdFgQzJ317kxqtmNqqulW1w7u1ySh7wlv6AgKRXc97260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TvztsVeS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MFlBhY31; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TvztsVeS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MFlBhY31"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAEB914001DD
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 03:55:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Jul 2025 03:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752047720;
	 x=1752134120; bh=ZE+X3lr4XPDDiQ3ItNBu3/QNisRLi2aNBFoGlDeIexk=; b=
	TvztsVeSszcr6wz6i8RSCZxa8taf83GtgSAHKowkgQPgWqSQA7IhPvdfDEBTJZlp
	Qi1Y7ZT0bUKZcj62mN7OIzQdlzT/bQ/qTBgPXmtkyQfLhud4HMW47SPJOq2rn/E5
	wPfVIWvs+E9d7FYDr2N5dV5vae2Nx8vSm7iq0tAU/6GtkZcIfwKfjEm9HVEkPzng
	ZueysgCsKIxdzfI/5XfYOC+exqlEQ3pVxSX0Dux7RXPlHSeH/0SqlMkrjgR/jNWJ
	+E043xIwJUuHXhZ+AJtQWDyiZlMKFziQlUJ7P9EfaoTTGmXSvOOsPw9M0D2q7dCM
	mbBBCuFfjrwRtqfwJiriGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752047720; x=
	1752134120; bh=ZE+X3lr4XPDDiQ3ItNBu3/QNisRLi2aNBFoGlDeIexk=; b=M
	FlBhY31Z6X8ZfRheIA4R9l49MPFTbPGvpFZrDoMWW0Sc6shNoRtrqejdxV7UGxPG
	ovhWYQzmAFjIe/bfUUgCe3mvrZLQ/LXWv4OSZlRGHwIbu8zVVoq0UG9LO6iJ8N+k
	OpBIX9BNosKIsiiOduUV/DUNGe8QfODBDOoIxl85KhD2hYWg8NwL+onw/pAASy3a
	l+HOQkU0GttM2oqJDPi6m3BcoVzqASoiL6LlioruW6EUvMmeNFPM4CfDZtYkYErG
	FPrGepCF2gNyhTlXYsUIP5Go40/ZLP0EokTLAtqf9lCAYBy/ZuZczopmV64GZAXU
	PQPrsLxGVU3VZljFUqEGg==
X-ME-Sender: <xms:aCBuaNuJ3Tn35XY6wqDrEh_jKAEV9uF0UvWDdt28oBtoOCxfyRiPfA>
    <xme:aCBuaIffNClvUyV_SsQfzH0pg0fxMxxHsCI2o6L9CbKNPRAOIs_dCICJyIRJmeh-r
    YkPRD0hQWBe46UvrA>
X-ME-Received: <xmr:aCBuaKL3P5dvQqCvCwkpzAnoPAZ-Zhq8cc_aejGWdGqKlO3u5NQCDf7hLvPSE_g3rwoVDWYsYWfAQjTWDTbgsP9WdVKiLN7Eto3DYTgAapFk-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:aCBuaGbxNEWDYkPKnjAtd4sUa5mmEaUduCVhHhgFuAqmFXz4MvS2OA>
    <xmx:aCBuaFtZH8i4IuUbltRJQeO9e1nlWvK023kOE-Jk5euVgvnNIoTEHg>
    <xmx:aCBuaDvXg7jUGuIviO1VmVzUD_XP2Eki4UEWgXvPdqLryJtlf0nXfQ>
    <xmx:aCBuaKdFeXANuZEM7z-keqEqZ2WBVY61zFYEWvpeWK1t1mfo55sVmQ>
    <xmx:aCBuaNU7t3DJlZ_ULCssa76MUgyvR-GzB-QTdz1XR6eI3aOAEbAui0W3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 03:55:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b7e77b4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 07:55:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 09:54:49 +0200
Subject: [PATCH 1/8] midx: start tracking per object database source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-midx-via-odb-alternate-v1-1-f31150d21331@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Multi-pack indices are tracked via `struct multi_pack_index`. This data
structure is stored as a linked list inside `struct object_database`,
which is the global database that spans across all of the object
sources.

This layout causes two problems:

  - Multi-pack indices aren't global to an object database, but instead
    there can be one multi-pack index per source. This creates a
    mismatch between the on-disk layout and how things are organized in
    the object database subsystems and makes some parts, like figuring
    out whether a source has an MIDX, quite awkward.

  - Multi-pack indices are an implementation detail of how efficient
    access for packfiles work. As such, they are neither relevant in the
    context of loose objects, nor in a potential future where we have
    pluggable backends.

Refactor `prepare_multi_pack_index_one()` so that it works on a specific
source, which allows us to easily store a pointer to the multi-pack
index inside of it. For now, this pointer exists next to the existing
linked list we have in the object database. Users will be adjusted in
subsequent patches to instead use the per-source pointers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 19 +++++++++++--------
 midx.h     |  7 ++++---
 odb.h      | 11 +++++++++--
 packfile.c |  4 +++-
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/midx.c b/midx.c
index 3c5bc821730..a91231bfcdf 100644
--- a/midx.c
+++ b/midx.c
@@ -724,28 +724,29 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 	return 0;
 }
 
-int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local)
+int prepare_multi_pack_index_one(struct odb_source *source, int local)
 {
+	struct repository *r = source->odb->repo;
 	struct multi_pack_index *m;
-	struct multi_pack_index *m_search;
 
 	prepare_repo_settings(r);
 	if (!r->settings.core_multi_pack_index)
 		return 0;
 
-	for (m_search = r->objects->multi_pack_index; m_search; m_search = m_search->next)
-		if (!strcmp(object_dir, m_search->object_dir))
-			return 1;
-
-	m = load_multi_pack_index(r, object_dir, local);
+	if (source->multi_pack_index)
+		return 1;
 
+	m = load_multi_pack_index(r, source->path, local);
 	if (m) {
 		struct multi_pack_index *mp = r->objects->multi_pack_index;
 		if (mp) {
 			m->next = mp->next;
 			mp->next = m;
-		} else
+		} else {
 			r->objects->multi_pack_index = m;
+		}
+		source->multi_pack_index = m;
+
 		return 1;
 	}
 
@@ -837,6 +838,8 @@ void clear_midx_file(struct repository *r)
 	if (r->objects && r->objects->multi_pack_index) {
 		close_midx(r->objects->multi_pack_index);
 		r->objects->multi_pack_index = NULL;
+		for (struct odb_source *source = r->objects->sources; source; source = source->next)
+			source->multi_pack_index = NULL;
 	}
 
 	if (remove_path(midx.buf))
diff --git a/midx.h b/midx.h
index 9d1374cbd58..b1626a9a7c4 100644
--- a/midx.h
+++ b/midx.h
@@ -3,11 +3,12 @@
 
 #include "string-list.h"
 
+struct bitmapped_pack;
+struct git_hash_algo;
 struct object_id;
+struct odb_source;
 struct pack_entry;
 struct repository;
-struct bitmapped_pack;
-struct git_hash_algo;
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -123,7 +124,7 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
-int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
+int prepare_multi_pack_index_one(struct odb_source *source, int local);
 
 /*
  * Variant of write_midx_file which writes a MIDX containing only the packs
diff --git a/odb.h b/odb.h
index e922f256802..8e79c7be520 100644
--- a/odb.h
+++ b/odb.h
@@ -9,10 +9,11 @@
 #include "string-list.h"
 #include "thread-utils.h"
 
+struct multi_pack_index;
 struct oidmap;
 struct oidtree;
-struct strbuf;
 struct repository;
+struct strbuf;
 
 /*
  * Compute the exact path an alternate is at and returns it. In case of
@@ -55,6 +56,13 @@ struct odb_source {
 	/* Map between object IDs for loose objects. */
 	struct loose_object_map *loose_map;
 
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c and midx.c
+	 */
+	struct multi_pack_index *multi_pack_index;
+
 	/*
 	 * This is a temporary object store created by the tmp_objdir
 	 * facility. Disable ref updates since the objects in the store
@@ -75,7 +83,6 @@ struct odb_source {
 };
 
 struct packed_git;
-struct multi_pack_index;
 struct cached_object_entry;
 
 /*
diff --git a/packfile.c b/packfile.c
index af9ccfdba62..16efc2fdca3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -372,6 +372,8 @@ void close_object_store(struct object_database *o)
 	if (o->multi_pack_index) {
 		close_midx(o->multi_pack_index);
 		o->multi_pack_index = NULL;
+		for (struct odb_source *source = o->sources; source; source = source->next)
+			source->multi_pack_index = NULL;
 	}
 
 	close_commit_graph(o);
@@ -1037,7 +1039,7 @@ static void prepare_packed_git(struct repository *r)
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		int local = (source == r->objects->sources);
-		prepare_multi_pack_index_one(r, source->path, local);
+		prepare_multi_pack_index_one(source, local);
 		prepare_packed_git_one(r, source->path, local);
 	}
 	rearrange_packed_git(r);

-- 
2.50.1.327.g047016eb4a.dirty

