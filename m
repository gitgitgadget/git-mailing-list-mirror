Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830FB29AAF8
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363811; cv=none; b=KZ9rYtO5qo9xRWcK1ui3hoh6hnVbql5UshnjfzlVqTHXXHxpG1IW2OhajS8BWpsj6v3R7jmY6mRQemMv4TUayxRsJVZfVDb3mb13+d4ETTqDkgBTrIYzPYR0JWQxjI1gcwWEdVpJgBZpqXlbT7xbqn2W7wCVdUGx4QXhm0NcsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363811; c=relaxed/simple;
	bh=1EEgyTNkw0Gi+a2Yhv++9HMkqiy4qjubw90SepeiiJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SoTiS0pfomckQ8QN1LWSfsvp+Yrq5dRNg5pandhbx2ab7T2jkrjdvlTxaci4vdRGDNOcdx0Hly8gBw5h1mDpuODnbGQBoN6xuGc2LOJoMyhUAPrrPdqrNawXTG5+UAwc2/LQFD0CJ2s36ljeZpWkEJjYQNXTL76/aDXJAP7BpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FeIi3WXQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bn7hwFnm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FeIi3WXQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bn7hwFnm"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A74B1380293;
	Fri, 11 Apr 2025 05:30:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 11 Apr 2025 05:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744363808;
	 x=1744450208; bh=y3jNd6xNmp+ZPn26Ke2cG/tgG8y1dpn77U39FoN5tUE=; b=
	FeIi3WXQ+8bOrA9enJE9KF1Lo7Uq9LrB29VjEPayRTPvwuCoqkbJjDprr9VdbE3i
	ZUSZgYeqWgMLtzQBDcowkRbjxRQmMjTKsvAXVv4g4CBzkoDB2rD++T9d6pIbbCKb
	ayNk2BpLwpAvJdI8hDm3bBdWd0rZaS90Wm9A7VDSr8xW6p3ejOyMuGXacmCOiFmi
	NXT7rEXc0410iRMVInjh7d6XEIftJfnEaFx+Do8Wqg7PU40wTPvkTTkNu5d//p6T
	2ucaIoXHFOo577ifl7ilvokLc6ecZKwaFKp1lJPLtMUh3sXVoQL0WHzjrsXeyhOF
	l7+mV8/rak7wrdHhqz4WDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744363808; x=
	1744450208; bh=y3jNd6xNmp+ZPn26Ke2cG/tgG8y1dpn77U39FoN5tUE=; b=b
	n7hwFnmCDAqKUJITZW8XiQiIluL6YU7F9dCHaXfaRdliKfK00BNVVW/yJEtzy3c1
	pRKiz+3tdDOPcnYAlefkdE1FO6tVpolVtw+jaCCaj6lXJlzeL3/RNscbSKimL2lj
	jBmAQU4xKS5+c54Z7oTixcTSwBvm66Yp6Al3kPXRBG5wQZ6MG8ojBefTIWhgpK7R
	QuFSmPsBkYH3zyeQg9aFXXSJ0XZjHiz9w4W7JxFDjIu3MKwpPQz40UZIQrRrH5Gu
	+TQy43/+kazof+2CL+qB6sUkBEMCu7ADpxyQVEPGrahhCJ9g8CPF6uKW5WEhDfu4
	3THgnHrT/47LltdPgzaJA==
X-ME-Sender: <xms:IOH4Z4bahA-oqlHYwzLShzgXcwvB1U5c4SSoZczabJdyIvvKqh--qw>
    <xme:IOH4ZzaLY-dcTn5nQkQG5bzEvKJwh7ceXEJobP6OVUiPHSbMZTblpwSqqxiqEG4tC
    xpaXyNBG3CmqyE2mg>
X-ME-Received: <xmr:IOH4Zy8inRWshit5FdkvUPSBgKQ3zdyxagBzmpMyw0jbWCtTGsJMYTBc6QIUHxSMcLCWwlUG7Snh9Zu1q2xoEB3G5dg5_jQ0L4kwLkK5CDm6UJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IOH4Zyo01er2ff4PM3ipq_9ka-DM_dNFpUK5ujBlsI9AJKNX1U8-dQ>
    <xmx:IOH4Zzq2oEjeiGKgCL47KYUrinwXZTu0D0kJP8iu6j4xhcBoELOVaw>
    <xmx:IOH4ZwRPhBpVevwE21W3Em5IGgQgFsajf1vsgX5K2wTqJQ6RjFZjXg>
    <xmx:IOH4ZzrOoOv0c6_sQ_pDSySBVTa6pMoPCSCzQAulsQRohTkzDzm-sw>
    <xmx:IOH4Z3HW4vel3uYPVNP0sOAJgvkZOkCvtwlLrIL0vR1p3bqnpFn5uyXF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:30:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27e03259 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:30:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Apr 2025 11:29:57 +0200
Subject: [PATCH v2 8/9] object-store: remove global array of cached objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-pks-split-object-file-v2-8-2bea0c9033ae@pks.im>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
In-Reply-To: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Cached objects are virtual objects that can be set up without writing
anything into the object store directly. This mechanism for example
allows us to create fake commits in git-blame(1).

The cached objects are stored in a global variable. Refactor the code so
that we instead store the array as part of the raw object store. This is
another step into the direction of libifying our object database.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 blame.c           |  2 +-
 object-store-ll.h | 14 +++++++++++++-
 object-store.c    | 39 +++++++++++++++++++++++----------------
 3 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/blame.c b/blame.c
index 703dab43e78..b7c5bd692e6 100644
--- a/blame.c
+++ b/blame.c
@@ -277,7 +277,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 	convert_to_git(r->index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
-	pretend_object_file(buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
+	pretend_object_file(the_repository, buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
 
 	/*
 	 * Read the current index, replace the path entry with
diff --git a/object-store-ll.h b/object-store-ll.h
index 8bb0f33f9a8..bb5e8798a1b 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -151,6 +151,8 @@ static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
 	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
 }
 
+struct cached_object_entry;
+
 struct raw_object_store {
 	/*
 	 * Set of all object directories; the main directory is first (and
@@ -203,6 +205,15 @@ struct raw_object_store {
 		unsigned flags;
 	} kept_pack_cache;
 
+	/*
+	 * This is meant to hold a *small* number of objects that you would
+	 * want repo_read_object_file() to be able to return, but yet you do not want
+	 * to write them into the object store (e.g. a browse-only
+	 * application).
+	 */
+	struct cached_object_entry *cached_objects;
+	size_t cached_object_nr, cached_object_alloc;
+
 	/*
 	 * A map of packfiles to packed_git structs for tracking which
 	 * packs have been loaded already.
@@ -272,7 +283,8 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
  * object in persistent storage before writing any other new objects
  * that reference it.
  */
-int pretend_object_file(void *, unsigned long, enum object_type,
+int pretend_object_file(struct repository *repo,
+			void *buf, unsigned long len, enum object_type type,
 			struct object_id *oid);
 
 struct object_info {
diff --git a/object-store.c b/object-store.c
index ea2d86c429b..17fa06a86fa 100644
--- a/object-store.c
+++ b/object-store.c
@@ -30,31 +30,31 @@
  * to write them into the object store (e.g. a browse-only
  * application).
  */
-static struct cached_object_entry {
+struct cached_object_entry {
 	struct object_id oid;
 	struct cached_object {
 		enum object_type type;
 		const void *buf;
 		unsigned long size;
 	} value;
-} *cached_objects;
-static int cached_object_nr, cached_object_alloc;
+};
 
-static const struct cached_object *find_cached_object(const struct object_id *oid)
+static const struct cached_object *find_cached_object(struct raw_object_store *object_store,
+						      const struct object_id *oid)
 {
 	static const struct cached_object empty_tree = {
 		.type = OBJ_TREE,
 		.buf = "",
 	};
-	int i;
-	const struct cached_object_entry *co = cached_objects;
+	const struct cached_object_entry *co = object_store->cached_objects;
 
-	for (i = 0; i < cached_object_nr; i++, co++) {
+	for (size_t i = 0; i < object_store->cached_object_nr; i++, co++)
 		if (oideq(&co->oid, oid))
 			return &co->value;
-	}
-	if (oideq(oid, the_hash_algo->empty_tree))
+
+	if (oid->algo && oideq(oid, hash_algos[oid->algo].empty_tree))
 		return &empty_tree;
+
 	return NULL;
 }
 
@@ -650,7 +650,7 @@ static int do_oid_object_info_extended(struct repository *r,
 	if (!oi)
 		oi = &blank_oi;
 
-	co = find_cached_object(real);
+	co = find_cached_object(r->objects, real);
 	if (co) {
 		if (oi->typep)
 			*(oi->typep) = co->type;
@@ -853,18 +853,21 @@ int oid_object_info(struct repository *r,
 	return type;
 }
 
-int pretend_object_file(void *buf, unsigned long len, enum object_type type,
+int pretend_object_file(struct repository *repo,
+			void *buf, unsigned long len, enum object_type type,
 			struct object_id *oid)
 {
 	struct cached_object_entry *co;
 	char *co_buf;
 
-	hash_object_file(the_hash_algo, buf, len, type, oid);
-	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
-	    find_cached_object(oid))
+	hash_object_file(repo->hash_algo, buf, len, type, oid);
+	if (repo_has_object_file_with_flags(repo, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
+	    find_cached_object(repo->objects, oid))
 		return 0;
-	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
-	co = &cached_objects[cached_object_nr++];
+
+	ALLOC_GROW(repo->objects->cached_objects,
+		   repo->objects->cached_object_nr + 1, repo->objects->cached_object_alloc);
+	co = &repo->objects->cached_objects[repo->objects->cached_object_nr++];
 	co->value.size = len;
 	co->value.type = type;
 	co_buf = xmalloc(len);
@@ -1021,6 +1024,10 @@ void raw_object_store_clear(struct raw_object_store *o)
 	o->odb_tail = NULL;
 	o->loaded_alternates = 0;
 
+	for (size_t i = 0; i < o->cached_object_nr; i++)
+		free((char *) o->cached_objects[i].value.buf);
+	FREE_AND_NULL(o->cached_objects);
+
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	close_object_store(o);
 

-- 
2.49.0.777.g153de2bbd5.dirty

