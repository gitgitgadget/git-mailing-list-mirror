Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92527781D
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372601; cv=none; b=jAOKoZZ/Yn/Jz/v/WH5gAh0z+4uQV66TfHfE/bwYGggczk0aJVxjvqbPnDDDaz3YoVl+vCyx3OTYt0CDNL9w/IRvjMcaG2pcwJZIZ6ovfiaLBCUxsdne5e8IovXCxu33s4PM9l1Q8vwXQo8wmRjv4GZF7eyBbElP4uwVz+HYMkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372601; c=relaxed/simple;
	bh=rKNl32fNlicEJdQjAyC1egOGNBrQXC3eol1wPZZrPaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OcxRnc4px/AESDXQRsi/OgCygzeo0ri9bDdNg7gQC0rIS0OnRRu+iICMwqWhRtIlNZfEZcBljDAgbX2U5VjYa111u2rStfGSldE0XtrAbRhI9kA7vxFZbeGWVXwsRKBctVlxYFXzwSxLwdSzkIoSW3WuBrhxERFZEx1Q5ytBHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ppmx4Bpp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DyXJqLzo; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ppmx4Bpp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DyXJqLzo"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A48591400386;
	Tue,  1 Jul 2025 08:23:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 01 Jul 2025 08:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751372598;
	 x=1751458998; bh=FOFDi+NRhzmEhywmsPpZTHajo1P9PafsO0I3rJVHdlg=; b=
	Ppmx4BpppT1XQiqVTOhv7utBfU4edEnsVoZADpq83QcTHijZxugZip64oP9TC7b3
	mZf12geuChNGH5181VoFCr7dzh4Vkg7LPaG5jOAzZT6+j0yKF9ff8R7+M53F2RIl
	hCy+Hy83aElghgTMG6ikckQrUDSuZn+q2KAAAqURhFhTWt8hbKvHncGEI7mRqzML
	czIcdQKI/FQhBQNSQs7ei7a3d/RDg1P4icq0Q07gIoXm8dX2bS6jGRBc0ykStYmE
	qhdzNZ4uA+0Lam4WjOk7EHmAnMybnPcO9J5vP+TBHF8FXA+j1r1Ff4YFHbewsd3K
	CUCMSG2AxzHnEY2zTVvSfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751372598; x=
	1751458998; bh=FOFDi+NRhzmEhywmsPpZTHajo1P9PafsO0I3rJVHdlg=; b=D
	yXJqLzoNlaiFYAkobBdy6bEf2sLEmp9X+bFaYSSmqffeUpzfVxQMILXareDdiblQ
	e8P1PBp100DCbSyoek76cfC5+kdmM87KQw0vZbfDh6KlPg1o6vwpQsLGFGzNXP8P
	oCeJmIcUN0KrLzG7kPGcHGtVZys1/p/8ps1IRl7AuEsF5RS5sE44pwMKwn355SKx
	0uFXUbH2t7D54s2dyO0fQRvLURLM+CSFOwa5H870NzpUTeKs0LuGqRR4BK+90X74
	mYUy+XL0wPrvRlD/Uyg2QF4OowcHYnzJJPH7ypr5MxgUhd40NRo2+hNLqDVFlj72
	UMcK2BrOod/qV0NqBhN8g==
X-ME-Sender: <xms:NtNjaLaVbQunElg3RmgUkQnSrhsiojxYkEpW4R19fnGbBCgCB3iirw>
    <xme:NtNjaKZe6HEJXc85Wse4T_mZb37GPB6vjJEODEDIBpWMXClv3skaOj2IlEQV1L77Y
    vtY6obSDWtd2ZJQuQ>
X-ME-Received: <xmr:NtNjaN_IYXEUGQl4YuanC_3HbGlzkxAUp2QOkV9Vhg15PRJ5Oc8koMBr7XikMjxzkrvAE6r8POUBbmS41aiq21V-qBf7HZiJZ_nTd_zSRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepth
    hoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:NtNjaBpNkvUq26flxx9lXpUGs6scSg2Eg3DLP7pPDbmf_a6Gcxzctg>
    <xmx:NtNjaGr0y9wrtCrgGY1mG-VRQhMl2n0qEAQk_w0xe7LpKKDnb5bGyg>
    <xmx:NtNjaHTpDP-f1VadeR0pTNuajR5x8RR-BZ3jIziApaHEcH40Yz9crg>
    <xmx:NtNjaOovy3MCRBcMFiPh4xIxhJpr4gb3vYa9J_k-TaNZAq_atyjaxg>
    <xmx:NtNjaATfkvhBn55Xcg0b6JjUbptuoLSO7wK7YcLUEFMaI5qzEEnfcHa9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:23:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57ff5d4d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:23:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Jul 2025 14:22:29 +0200
Subject: [PATCH v6 17/17] odb: rename `read_object_with_reference()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-pks-object-store-wo-the-repository-v6-17-dbf3894ab4e2@pks.im>
References: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
In-Reply-To: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Rename `read_object_with_reference()` to `odb_read_object_peeled()` to
match other functions related to the object database and our modern
coding guidelines. Furthermore though, the old name didn't really
describe very well what this function actually does, which is to walk
down any commit and tag objects until an object of the required type has
been found. This is generally referred to as "peeling", so the new name
should be way more descriptive.

No compatibility wrapper is introduced as the function is not used a lot
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
index 01672ec74bd..08afecbf57c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -246,8 +246,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
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
index 5de61dfffe8..39273d9c0fd 100644
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
index 217903d7b14..1f48a0448e3 100644
--- a/odb.c
+++ b/odb.c
@@ -905,11 +905,11 @@ void *odb_read_object(struct object_database *odb,
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
@@ -921,7 +921,7 @@ void *read_object_with_reference(struct repository *r,
 		int ref_length = -1;
 		const char *ref_type = NULL;
 
-		buffer = odb_read_object(r->objects, &actual_oid, &type, &isize);
+		buffer = odb_read_object(odb, &actual_oid, &type, &isize);
 		if (!buffer)
 			return NULL;
 		if (type == required_type) {
@@ -941,9 +941,10 @@ void *read_object_with_reference(struct repository *r,
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
index e4c51f8c38e..e922f256802 100644
--- a/odb.h
+++ b/odb.h
@@ -274,6 +274,12 @@ void *odb_read_object(struct object_database *odb,
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
@@ -382,7 +388,7 @@ void odb_assert_oid_type(struct object_database *odb,
 /*
  * Enabling the object read lock allows multiple threads to safely call the
  * following functions in parallel: odb_read_object(),
- * read_object_with_reference(), odb_read_object_info() and odb().
+ * odb_read_object_peeled(), odb_read_object_info() and odb().
  *
  * obj_read_lock() and obj_read_unlock() may also be used to protect other
  * section which cannot execute in parallel with object reading. Since the used
@@ -431,13 +437,6 @@ enum for_each_object_flags {
 	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
 };
 
-
-void *read_object_with_reference(struct repository *r,
-				 const struct object_id *oid,
-				 enum object_type required_type,
-				 unsigned long *size,
-				 struct object_id *oid_ret);
-
 /* Compatibility wrappers, to be removed once Git 2.51 has been released. */
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
2.50.0.195.g74e6fc65d0.dirty

