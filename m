Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F30296FDD
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799955; cv=none; b=d6GoHmHmnERh2bc89tp97wZxyudElr/IJ6mTwP6tdjVTXYxTZ+f/qMOb4tKOtJQ2dOyA0Tm5O/30qhkF1amvMC7JlJ+ChEi77z41/XTW8GOeM4lOJkRAHPx2Q+eCEP16mztvMj/ekX18aNKyAm2jSpBuZO2h5/xzp/InxWk7iyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799955; c=relaxed/simple;
	bh=XhwuFb14AykJ2dKugIHpzNQZYYtPXOja9S1RI5EdTrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJm2pt/YJF47h412DiiXHq9QdiZuptpRMP/u50b1g91qOJPB+uNOloHmnVbztqzibqzOhW3aRY+Cx66JO/1oeUSeOjygyfeWScughBCEG4hHajGoj6Nua0NZcQnMIWfQadjtORI4u7j0Yr1zJRvzy+JN92e88cTkjoLy357z5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H9HvmSSW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i+bxq7SW; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H9HvmSSW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i+bxq7SW"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B0A7D1140129;
	Fri,  9 May 2025 10:12:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 10:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799952;
	 x=1746886352; bh=KGFkFQ5cpxeJijnUZNeHo4KR/eMC3LuYng71HK1FaRE=; b=
	H9HvmSSW4NuOUgX3f396MffvyJXowoAueUi1AETVfIzxoDVAXcc3GXwQHU/Op1Iz
	zlRcB+deBkgMVBJwJGZ/Gvh1q8qt/e//e6CgUpDP0L2GrWuqyESRsh2y6tAKsn5j
	cu/H/7s3fRRtrDKWyxlSTiUmVdYXPr0xoZ1tqGkAGXaARaHez18aAj7ohh89wYmd
	02kPuhGeznxSWCwB2STm8klCc1vKhGn8oFiO1JjOWPlqOWqWS4Fl3m9gnfPhx2Ft
	pve3vygndz2ZcGMzIHZiRqmbgygwANnK7aEigNTAraeJEBc7yGXcsMQmAngJJ27C
	L2BwPATDZA3kNIJ6cod/AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799952; x=
	1746886352; bh=KGFkFQ5cpxeJijnUZNeHo4KR/eMC3LuYng71HK1FaRE=; b=i
	+bxq7SWzkjMj2PN/nO7pCM0MSRavYK7Vg7WjWxwmdYBpUSkSYSWjbKU/7upJMeet
	errDsA32W3CDuAvXDUjkh3vQDSBZOatfU4F0nh17y3Y9wDNNWIX3bFZVRTnUVqyQ
	lID031w7a9WmeE/vj7JebuV+oOGb17txcvTMjIXi7ISe4kydlT6efIORYTt2hxdB
	LD7BEQTbK1SO7N0zmxEUUM3klxAP2nP8KBRXbLEuzEDbyZly5+DLIbGiVC1xM6Xz
	DJVQfy1T2S8JTGgAdFzn//iQh6S05x8ynh9T0E7hpG8PyqacaEyQhsm3ZOE23TAc
	/GKWB0WQqgqQfBjMBRU9g==
X-ME-Sender: <xms:UA0eaHLSXIos_MpnTgaPihjAUB0Up7tXiTfb42aOeMH9og6QiWdHJw>
    <xme:UA0eaLIipnPZFkRhC9BXWQtRSSeKi3A0FaY7XWM1LLYDip37dONmkYIpzsXNW7ajI
    p5HsBxyM4paafUSHw>
X-ME-Received: <xmr:UA0eaPsJYdBy7VFpDKnJj77NMjL4--CsSnzyyiJdqT5t_F1Fpigu8LUlJ7EPdHJHpBep1TjdhZ1_69obSoZdGrgCLM8X3PMZZx0PWNj2PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UA0eaAYukAqSSPjG73EqUmtqAk8e3jc2VuCqlFDrz7PqNEn6a5JwWg>
    <xmx:UA0eaObAiOYeCr_FXfXCoM4oTGLfb2pZ9M1S1M1aEXWaklBVTinmew>
    <xmx:UA0eaEBid84CbiNmMTFWFXRu-yDzuyw_xIgO02H11iuXvowdOTMhMA>
    <xmx:UA0eaMbmt7CQ4hy5RpZjXHofoVJHLcsSj7ahT8euHZrNtT2qkgKvoQ>
    <xmx:UA0eaO0gg7upbTCNUPNQJ719V_cCMiqdjclxlE1wDCaBY1MjptLTfagj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44ff329a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 16:12:17 +0200
Subject: [PATCH v2 17/17] odb: rename `read_object_with_reference()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-17-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Rename `read_object_with_reference()` to `odb_read_object_peeled()` to
match other functions related to the object database and our modern
coding guidelines. Furthermore though, the old name didn't really
describe very well what this function actually does, which is to walk
down any commit and tag objects until an object of the required type has
been found. This is generally referred to as "peeling", so the new name
should be way more descriptive.

No compatibility wrapper is introduces as the function is not used a lot
throughout our codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/user-manual.adoc |  4 ++--
 builtin/cat-file.c             |  4 ++--
 builtin/fast-import.c          | 19 ++++++++-----------
 builtin/grep.c                 |  9 +++------
 builtin/pack-objects.c         |  4 ++--
 odb.c                          | 17 +++++++++--------
 odb.h                          | 15 +++++++--------
 tree-walk.c                    | 10 ++++------
 8 files changed, 37 insertions(+), 45 deletions(-)

diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
index d2b478ad232..e86b2ad9f8a 100644
--- a/Documentation/user-manual.adoc
+++ b/Documentation/user-manual.adoc
@@ -4301,11 +4301,11 @@ Now, for the meat:
 
 -----------------------------------------------------------------------------
         case 0:
-                buf = read_object_with_reference(sha1, argv[1], &size, NULL);
+                buf = odb_read_object_peeled(r->objects, sha1, argv[1], &size, NULL);
 -----------------------------------------------------------------------------
 
 This is how you read a blob (actually, not only a blob, but any type of
-object).  To know how the function `read_object_with_reference()` actually
+object).  To know how the function `odb_read_object_peeled()` actually
 works, find the source code for it (something like `git grep
 read_object_with | grep ":[a-z]"` in the Git repository), and read
 the source.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 571b5cc2ad5..ed0fce9b490 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -255,8 +255,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			 * fall-back to the usual case.
 			 */
 		}
-		buf = read_object_with_reference(the_repository, &oid,
-						 exp_type_id, &size, NULL);
+		buf = odb_read_object_peeled(the_repository->objects, &oid,
+					     exp_type_id, &size, NULL);
 
 		if (use_mailmap) {
 			size_t s = size;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 1973c504e25..b1389c59211 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2535,10 +2535,9 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		oidcpy(&commit_oid, &commit_oe->idx.oid);
 	} else if (!repo_get_oid(the_repository, p, &commit_oid)) {
 		unsigned long size;
-		char *buf = read_object_with_reference(the_repository,
-						       &commit_oid,
-						       OBJ_COMMIT, &size,
-						       &commit_oid);
+		char *buf = odb_read_object_peeled(the_repository->objects,
+						   &commit_oid, OBJ_COMMIT, &size,
+						   &commit_oid);
 		if (!buf || size < the_hash_algo->hexsz + 6)
 			die("Not a valid commit: %s", p);
 		free(buf);
@@ -2604,9 +2603,8 @@ static void parse_from_existing(struct branch *b)
 		unsigned long size;
 		char *buf;
 
-		buf = read_object_with_reference(the_repository,
-						 &b->oid, OBJ_COMMIT, &size,
-						 &b->oid);
+		buf = odb_read_object_peeled(the_repository->objects, &b->oid,
+					     OBJ_COMMIT, &size, &b->oid);
 		parse_from_commit(b, buf, size);
 		free(buf);
 	}
@@ -2699,10 +2697,9 @@ static struct hash_list *parse_merge(unsigned int *count)
 			oidcpy(&n->oid, &oe->idx.oid);
 		} else if (!repo_get_oid(the_repository, from, &n->oid)) {
 			unsigned long size;
-			char *buf = read_object_with_reference(the_repository,
-							       &n->oid,
-							       OBJ_COMMIT,
-							       &size, &n->oid);
+			char *buf = odb_read_object_peeled(the_repository->objects,
+							   &n->oid, OBJ_COMMIT,
+							   &size, &n->oid);
 			if (!buf || size < the_hash_algo->hexsz + 6)
 				die("Not a valid commit: %s", from);
 			free(buf);
diff --git a/builtin/grep.c b/builtin/grep.c
index f84298af0f6..7619479ddad 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -522,9 +522,7 @@ static int grep_submodule(struct grep_opt *opt,
 		obj_read_lock();
 		object_type = odb_read_object_info(subrepo->objects, oid, NULL);
 		obj_read_unlock();
-		data = read_object_with_reference(subrepo,
-						  oid, OBJ_TREE,
-						  &size, NULL);
+		data = odb_read_object_peeled(subrepo->objects, oid, OBJ_TREE, &size, NULL);
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(oid));
 
@@ -705,9 +703,8 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		struct strbuf base;
 		int hit, len;
 
-		data = read_object_with_reference(opt->repo,
-						  &obj->oid, OBJ_TREE,
-						  &size, NULL);
+		data = odb_read_object_peeled(opt->repo->objects, &obj->oid,
+					      OBJ_TREE, &size, NULL);
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(&obj->oid));
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 06bdeb4223b..e88a13dbb9f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2055,8 +2055,8 @@ static void add_preferred_base(struct object_id *oid)
 	if (window <= num_preferred_base++)
 		return;
 
-	data = read_object_with_reference(the_repository, oid,
-					  OBJ_TREE, &size, &tree_oid);
+	data = odb_read_object_peeled(the_repository->objects, oid,
+				      OBJ_TREE, &size, &tree_oid);
 	if (!data)
 		return;
 
diff --git a/odb.c b/odb.c
index dfebeb4c8c0..fd7fe398d2d 100644
--- a/odb.c
+++ b/odb.c
@@ -914,11 +914,11 @@ void *odb_read_object(struct object_database *odb,
 	return data;
 }
 
-void *read_object_with_reference(struct repository *r,
-				 const struct object_id *oid,
-				 enum object_type required_type,
-				 unsigned long *size,
-				 struct object_id *actual_oid_return)
+void *odb_read_object_peeled(struct object_database *odb,
+			     const struct object_id *oid,
+			     enum object_type required_type,
+			     unsigned long *size,
+			     struct object_id *actual_oid_return)
 {
 	enum object_type type;
 	void *buffer;
@@ -930,7 +930,7 @@ void *read_object_with_reference(struct repository *r,
 		int ref_length = -1;
 		const char *ref_type = NULL;
 
-		buffer = odb_read_object(r->objects, &actual_oid, &type, &isize);
+		buffer = odb_read_object(odb, &actual_oid, &type, &isize);
 		if (!buffer)
 			return NULL;
 		if (type == required_type) {
@@ -950,9 +950,10 @@ void *read_object_with_reference(struct repository *r,
 		}
 		ref_length = strlen(ref_type);
 
-		if (ref_length + r->hash_algo->hexsz > isize ||
+		if (ref_length + odb->repo->hash_algo->hexsz > isize ||
 		    memcmp(buffer, ref_type, ref_length) ||
-		    get_oid_hex_algop((char *) buffer + ref_length, &actual_oid, r->hash_algo)) {
+		    get_oid_hex_algop((char *) buffer + ref_length, &actual_oid,
+				      odb->repo->hash_algo)) {
 			free(buffer);
 			return NULL;
 		}
diff --git a/odb.h b/odb.h
index 911448f4d42..0f26ee3216c 100644
--- a/odb.h
+++ b/odb.h
@@ -263,6 +263,12 @@ void *odb_read_object(struct object_database *odb,
 		      enum object_type *type,
 		      unsigned long *size);
 
+void *odb_read_object_peeled(struct object_database *odb,
+			     const struct object_id *oid,
+			     enum object_type required_type,
+			     unsigned long *size,
+			     struct object_id *oid_ret);
+
 /*
  * Add an object file to the in-memory object store, without writing it
  * to disk.
@@ -374,7 +380,7 @@ void odb_assert_oid_type(struct object_database *odb,
 /*
  * Enabling the object read lock allows multiple threads to safely call the
  * following functions in parallel: odb_read_object(),
- * read_object_with_reference(), odb_read_object_info() and odb().
+ * odb_read_object_peeled(), odb_read_object_info() and odb().
  *
  * obj_read_lock() and obj_read_unlock() may also be used to protect other
  * section which cannot execute in parallel with object reading. Since the used
@@ -423,13 +429,6 @@ enum for_each_object_flags {
 	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
 };
 
-
-void *read_object_with_reference(struct repository *r,
-				 const struct object_id *oid,
-				 enum object_type required_type,
-				 unsigned long *size,
-				 struct object_id *oid_ret);
-
 /* Compatibility wrappers, to be removed once Git 2.50 has been released. */
 #include "repository.h"
 
diff --git a/tree-walk.c b/tree-walk.c
index 766af99f466..e449a1320e5 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -90,7 +90,7 @@ void *fill_tree_descriptor(struct repository *r,
 	void *buf = NULL;
 
 	if (oid) {
-		buf = read_object_with_reference(r, oid, OBJ_TREE, &size, NULL);
+		buf = odb_read_object_peeled(r->objects, oid, OBJ_TREE, &size, NULL);
 		if (!buf)
 			die(_("unable to read tree (%s)"), oid_to_hex(oid));
 	}
@@ -611,7 +611,7 @@ int get_tree_entry(struct repository *r,
 	unsigned long size;
 	struct object_id root;
 
-	tree = read_object_with_reference(r, tree_oid, OBJ_TREE, &size, &root);
+	tree = odb_read_object_peeled(r->objects, tree_oid, OBJ_TREE, &size, &root);
 	if (!tree)
 		return -1;
 
@@ -681,10 +681,8 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 			void *tree;
 			struct object_id root;
 			unsigned long size;
-			tree = read_object_with_reference(r,
-							  &current_tree_oid,
-							  OBJ_TREE, &size,
-							  &root);
+			tree = odb_read_object_peeled(r->objects, &current_tree_oid,
+						      OBJ_TREE, &size, &root);
 			if (!tree)
 				goto done;
 

-- 
2.49.0.1077.gc0e912fd4c.dirty

