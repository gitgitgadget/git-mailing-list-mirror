Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10FE279903
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529775; cv=none; b=RdRnDHTvw8uuUYEZPMQiZU69dDhPAv6iK4JcicM8d1eu+RZCCuzh3goW+y6JhUHelumFK67zDpRaIlrIfgbq1MX7Dz4ds7RLGUHzXHCQFJeiYzZvAb2RBSVZiJxTzCRsLgNhHI4l4YTwYmaeYAS1KKOk0DYoORJgGny4+4OPQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529775; c=relaxed/simple;
	bh=OUNXOj+Sqq4CxbNhcnqtUeaBjD4+rywbsYBOIghjoX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITZlKSi1JskC1UkZ1DMPhFiREVFmroLBbwKpIaNkLM9hTfbs6K8/10i9OyCWJmGWy7SY9/xdclgKd11rtDRfMp4lGKXFvBIAmKoFD5k69SR5uZ/7IYLt9xGjfDVE6eXR1vseUg5NO/9mV0vhg7n0YtUip+HMllrgOnDV3+d3a+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wCC84DqA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ehs7Xyrb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wCC84DqA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ehs7Xyrb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CB670138146A
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 07:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529770;
	 x=1746616170; bh=0kkhX3oNgVcJJl5SR8sea/HED5ksKpernmclZc5tA4k=; b=
	wCC84DqA/exzQtlFArs4zdMNyEfD4L+CcgParaF2YQ4IjcpjvDRsuw5qdyxPgh9H
	g+CDGTF/ymAfweQmv9UBGYyduoHwRRiixLkjEwFbDJCYuUAkhhLD2F7SiTZO6nCi
	YsS+kH6ZJgKGtWZvgGs7cBRQ5y5ll50M71C4L6wZ8FpxYt8ODCyCQDIklVSUuDRX
	E7UoCJfF1ogQrwTzPlxFIA8VN5d5vUkO+7CAKbVWjZU/4Nka8wNV/bBhs6JQaXlx
	Wn3MUqClsee30iX2WzU8fuEYIYCM6IIq9rKFMro0PbtR9GTPHKvUk5I/1AuALA0+
	jjQGIGHviOyIa86AOi7eqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529770; x=
	1746616170; bh=0kkhX3oNgVcJJl5SR8sea/HED5ksKpernmclZc5tA4k=; b=e
	hs7XyrbjEeE253Z8xkCm1Cxiw22Vr5E4KIu7xtEwjJvKzgLwbH8BtFMs2CRgpQA1
	0m36y5pPnUbRM+I3jSMQUJ8fGB5+yoTYctGe406TVzKDfZ5WNS24qNfHDSJsLEGF
	FagqV5qlYFnufhXlu0O1w0mMR8Dro9izSqf2IAKwY4/17r4AZ86/FqteU8hefn8l
	1RLcVvBKVxRVq8MVXIE7z6k2efZWHIW3sPo9+M3hCbn3F+5XkFvWyJxmX3wDdTd0
	+tYQRQWwTU8JN5rrpxRpbJB11BOsivud2Ir9ig0ibgpo80y/97OuF+u1A3lUqclR
	T58USpYxypszejteOYwog==
X-ME-Sender: <xms:6u0ZaOCsCh0gsCX6Gswbw5ICd0R2BVfB6rybWl1GKrdb61vNMjN9gg>
    <xme:6u0ZaIj3Utte2iXEH4gkhFTB1wFU0kSIUq3mib9vSqvJqcrjL1QjSj4rHy0sF98vL
    LcCsKUhbfz695fjiA>
X-ME-Received: <xmr:6u0ZaBntdwXH7kyrbVYS-naJiEyoqJ4Ln32zIfJvVVTxjtrOnwuE59iVKVTkB-cy_NZfnFBiFlpxGGAoLbHPCtLJrukPwWIzppWdLJni>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6u0ZaMzVA5lSBkMNLkhegjsIZxrxGx1ynfaWgmPXByq_PmDVGjwuWA>
    <xmx:6u0ZaDQUC9WGyMZhkxmxiuCdbzGEzAzgvucM-TPSGzG-AVWeBoLliw>
    <xmx:6u0ZaHbutOKHuNoGEArBm6ox-jxY6M4ZbbMw06Kw3Aam9B1YnkXZEg>
    <xmx:6u0ZaMQdrbAMwI7I7-qsDvdsZkiiuMvGDtEUdJAXqRzDKvRAM-Zv7g>
    <xmx:6u0ZaI8BKl8okjdd5dw55v02mIhueqDG5bEtFm5qeatEv4SYh-JEgDo6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 56f98798 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:26 +0200
Subject: [PATCH 13/17] odb: rename `oid_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-13-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Rename `oid_object_info()` to `odb_read_object_info()` as well as their
`_extended()` variant to match other functions related to the object
database and our modern coding guidelines.

Introduce compatibility wrappers so that any in-flight topics will
continue to compile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive.c                     |  2 +-
 blame.c                       |  4 +--
 builtin/blame.c               |  4 +--
 builtin/cat-file.c            | 26 ++++++++++---------
 builtin/describe.c            |  3 ++-
 builtin/fast-export.c         |  2 +-
 builtin/fast-import.c         | 17 ++++++------
 builtin/fsck.c                |  7 ++---
 builtin/gc.c                  |  2 +-
 builtin/grep.c                |  2 +-
 builtin/index-pack.c          | 13 +++++-----
 builtin/ls-files.c            |  2 +-
 builtin/ls-tree.c             |  4 +--
 builtin/mktree.c              |  8 +++---
 builtin/pack-objects.c        | 30 ++++++++++++----------
 builtin/prune.c               |  4 +--
 builtin/repack.c              |  2 +-
 builtin/replace.c             | 10 ++++----
 builtin/rev-list.c            |  6 +++--
 builtin/tag.c                 |  4 +--
 builtin/unpack-objects.c      |  2 +-
 commit-graph.c                |  2 +-
 commit.c                      |  3 ++-
 diff.c                        | 18 ++++++-------
 fetch-pack.c                  |  4 +--
 list-objects-filter.c         |  2 +-
 log-tree.c                    |  2 +-
 merge-ort.c                   |  4 +--
 object-file.c                 |  2 +-
 object-file.h                 |  2 +-
 object-name.c                 | 16 ++++++------
 object.c                      |  6 ++---
 odb.c                         | 60 ++++++++++++++++++++++---------------------
 odb.h                         | 46 +++++++++++++++++++++++++++------
 pack-bitmap-write.c           |  4 +--
 pack-bitmap.c                 |  8 +++---
 packfile.c                    |  5 ++--
 promisor-remote.c             |  4 +--
 protocol-caps.c               |  2 +-
 reachable.c                   |  2 +-
 read-cache.c                  |  6 ++---
 ref-filter.c                  |  4 +--
 remote.c                      |  5 ++--
 sequencer.c                   |  5 ++--
 streaming.c                   |  8 +++---
 submodule.c                   |  5 ++--
 t/helper/test-partial-clone.c |  2 +-
 tag.c                         |  2 +-
 48 files changed, 213 insertions(+), 170 deletions(-)

diff --git a/archive.c b/archive.c
index 7fa2cc2596a..f2511d530d5 100644
--- a/archive.c
+++ b/archive.c
@@ -215,7 +215,7 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 
 	/* Stream it? */
 	if (S_ISREG(mode) && !args->convert &&
-	    oid_object_info(args->repo, oid, &size) == OBJ_BLOB &&
+	    odb_read_object_info(args->repo->objects, oid, &size) == OBJ_BLOB &&
 	    size > repo_settings_get_big_file_threshold(the_repository))
 		return write_entry(args, oid, path.buf, path.len, mode, NULL, size);
 
diff --git a/blame.c b/blame.c
index 0ceea080a80..97db3355af4 100644
--- a/blame.c
+++ b/blame.c
@@ -116,7 +116,7 @@ static void verify_working_tree_path(struct repository *r,
 		unsigned short mode;
 
 		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode) &&
-		    oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
+		    odb_read_object_info(r->objects, &blob_oid, NULL) == OBJ_BLOB)
 			return;
 	}
 
@@ -1245,7 +1245,7 @@ static int fill_blob_sha1_and_mode(struct repository *r,
 		return 0;
 	if (get_tree_entry(r, &origin->commit->object.oid, origin->path, &origin->blob_oid, &origin->mode))
 		goto error_out;
-	if (oid_object_info(r, &origin->blob_oid, NULL) != OBJ_BLOB)
+	if (odb_read_object_info(r->objects, &origin->blob_oid, NULL) != OBJ_BLOB)
 		goto error_out;
 	return 0;
  error_out:
diff --git a/builtin/blame.c b/builtin/blame.c
index 15eda60af90..91586e6852b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -837,7 +837,7 @@ static int is_a_rev(const char *name)
 
 	if (repo_get_oid(the_repository, name, &oid))
 		return 0;
-	return OBJ_NONE < oid_object_info(the_repository, &oid, NULL);
+	return OBJ_NONE < odb_read_object_info(the_repository->objects, &oid, NULL);
 }
 
 static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
@@ -848,7 +848,7 @@ static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
 	oidcpy(&oid, oid_ret);
 	while (1) {
 		struct object *obj;
-		int kind = oid_object_info(r, &oid, NULL);
+		int kind = odb_read_object_info(r->objects, &oid, NULL);
 		if (kind == OBJ_COMMIT) {
 			oidcpy(oid_ret, &oid);
 			return 0;
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2fa5e3f43bd..da172155c85 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -137,7 +137,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	switch (opt) {
 	case 't':
 		oi.type_name = &sb;
-		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
+		if (odb_read_object_info_extended(the_repository->objects, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		if (sb.len) {
 			printf("%s\n", sb.buf);
@@ -155,7 +155,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			oi.contentp = (void**)&buf;
 		}
 
-		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
+		if (odb_read_object_info_extended(the_repository->objects, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 
 		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
@@ -189,7 +189,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		/* else fallthrough */
 
 	case 'p':
-		type = oid_object_info(the_repository, &oid, NULL);
+		type = odb_read_object_info(the_repository->objects, &oid, NULL);
 		if (type < 0)
 			die("Not a valid object name %s", obj_name);
 
@@ -226,7 +226,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 		if (exp_type_id == OBJ_BLOB) {
 			struct object_id blob_oid;
-			if (oid_object_info(the_repository, &oid, NULL) == OBJ_TAG) {
+			if (odb_read_object_info(the_repository->objects,
+						 &oid, NULL) == OBJ_TAG) {
 				char *buffer = repo_read_object_file(the_repository,
 								     &oid,
 								     &type,
@@ -244,7 +245,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			} else
 				oidcpy(&blob_oid, &oid);
 
-			if (oid_object_info(the_repository, &blob_oid, NULL) == OBJ_BLOB) {
+			if (odb_read_object_info(the_repository->objects,
+						 &blob_oid, NULL) == OBJ_BLOB) {
 				ret = stream_blob(&blob_oid);
 				goto cleanup;
 			}
@@ -303,7 +305,7 @@ struct expand_data {
 
 	/*
 	 * After a mark_query run, this object_info is set up to be
-	 * passed to oid_object_info_extended. It will point to the data
+	 * passed to odb_read_object_info_extended. It will point to the data
 	 * elements above, so you can retrieve the response from there.
 	 */
 	struct object_info info;
@@ -493,12 +495,12 @@ static void batch_object_write(const char *obj_name,
 			data->info.sizep = &data->size;
 
 		if (pack)
-			ret = packed_object_info(the_repository, pack, offset,
-						 &data->info);
+			ret = packed_object_info(the_repository, pack,
+						 offset, &data->info);
 		else
-			ret = oid_object_info_extended(the_repository,
-						       &data->oid, &data->info,
-						       OBJECT_INFO_LOOKUP_REPLACE);
+			ret = odb_read_object_info_extended(the_repository->objects,
+							    &data->oid, &data->info,
+							    OBJECT_INFO_LOOKUP_REPLACE);
 		if (ret < 0) {
 			report_object_status(opt, obj_name, &data->oid, "missing");
 			return;
@@ -881,7 +883,7 @@ static int batch_objects(struct batch_options *opt)
 
 	/*
 	 * Expand once with our special mark_query flag, which will prime the
-	 * object_info to be handed to oid_object_info_extended for each
+	 * object_info to be handed to odb_read_object_info_extended for each
 	 * object.
 	 */
 	memset(&data, 0, sizeof(data));
diff --git a/builtin/describe.c b/builtin/describe.c
index 96cb68e5e5d..fbf305d7624 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -552,7 +552,8 @@ static void describe(const char *arg, int last_one)
 
 	if (cmit)
 		describe_commit(&oid, &sb);
-	else if (oid_object_info(the_repository, &oid, NULL) == OBJ_BLOB)
+	else if (odb_read_object_info(the_repository->objects,
+				      &oid, NULL) == OBJ_BLOB)
 		describe_blob(oid, &sb);
 	else
 		die(_("%s is neither a commit nor blob"), arg);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 0505f289a94..6c93cf0a8aa 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1200,7 +1200,7 @@ static void import_marks(char *input_file, int check_exists)
 		if (last_idnum < mark)
 			last_idnum = mark;
 
-		type = oid_object_info(the_repository, &oid, NULL);
+		type = odb_read_object_info(the_repository->objects, &oid, NULL);
 		if (type < 0)
 			die("object not found: %s", oid_to_hex(&oid));
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 413304db9b5..2718376f2c9 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1756,8 +1756,8 @@ static void insert_object_entry(struct mark_set **s, struct object_id *oid, uint
 	struct object_entry *e;
 	e = find_object(oid);
 	if (!e) {
-		enum object_type type = oid_object_info(the_repository,
-							oid, NULL);
+		enum object_type type = odb_read_object_info(the_repository->objects,
+							     oid, NULL);
 		if (type < 0)
 			die("object not found: %s", oid_to_hex(oid));
 		e = insert_object(oid);
@@ -2416,8 +2416,8 @@ static void file_change_m(const char *p, struct branch *b)
 		enum object_type expected = S_ISDIR(mode) ?
 						OBJ_TREE: OBJ_BLOB;
 		enum object_type type = oe ? oe->type :
-					oid_object_info(the_repository, &oid,
-							NULL);
+					odb_read_object_info(the_repository->objects,
+							     &oid, NULL);
 		if (type < 0)
 			die("%s not found: %s",
 					S_ISDIR(mode) ?  "Tree" : "Blob",
@@ -2553,7 +2553,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 			die("Not a blob (actually a %s): %s",
 				type_name(oe->type), command_buf.buf);
 	} else if (!is_null_oid(&oid)) {
-		enum object_type type = oid_object_info(the_repository, &oid,
+		enum object_type type = odb_read_object_info(the_repository->objects, &oid,
 							NULL);
 		if (type < 0)
 			die("Blob not found: %s", command_buf.buf);
@@ -2895,7 +2895,8 @@ static void parse_new_tag(const char *arg)
 	} else if (!repo_get_oid(the_repository, from, &oid)) {
 		struct object_entry *oe = find_object(&oid);
 		if (!oe) {
-			type = oid_object_info(the_repository, &oid, NULL);
+			type = odb_read_object_info(the_repository->objects,
+						    &oid, NULL);
 			if (type < 0)
 				die("Not a valid object: %s", from);
 		} else
@@ -3085,8 +3086,8 @@ static struct object_entry *dereference(struct object_entry *oe,
 	const unsigned hexsz = the_hash_algo->hexsz;
 
 	if (!oe) {
-		enum object_type type = oid_object_info(the_repository, oid,
-							NULL);
+		enum object_type type = odb_read_object_info(the_repository->objects,
+							     oid, NULL);
 		if (type < 0)
 			die("object not found: %s", oid_to_hex(oid));
 		/* cache it! */
diff --git a/builtin/fsck.c b/builtin/fsck.c
index ffae00b1723..f1da67eb26b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -71,7 +71,8 @@ static const char *printable_type(const struct object_id *oid,
 	const char *ret;
 
 	if (type == OBJ_NONE)
-		type = oid_object_info(the_repository, oid, NULL);
+		type = odb_read_object_info(the_repository->objects,
+					    oid, NULL);
 
 	ret = type_name(type);
 	if (!ret)
@@ -232,8 +233,8 @@ static void mark_unreachable_referents(const struct object_id *oid)
 	 * (and we want to avoid parsing blobs).
 	 */
 	if (obj->type == OBJ_NONE) {
-		enum object_type type = oid_object_info(the_repository,
-							&obj->oid, NULL);
+		enum object_type type = odb_read_object_info(the_repository->objects,
+							     &obj->oid, NULL);
 		if (type > 0)
 			object_as_type(obj, type, 0);
 	}
diff --git a/builtin/gc.c b/builtin/gc.c
index ea13660dba1..1876d4b230b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1006,7 +1006,7 @@ static int dfs_on_ref(const char *refname UNUSED,
 
 	if (!peel_iterated_oid(the_repository, oid, &peeled))
 		oid = &peeled;
-	if (oid_object_info(the_repository, oid, NULL) != OBJ_COMMIT)
+	if (odb_read_object_info(the_repository->objects, oid, NULL) != OBJ_COMMIT)
 		return 0;
 
 	commit = lookup_commit(the_repository, oid);
diff --git a/builtin/grep.c b/builtin/grep.c
index e9816cce8cd..83da86405fa 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -520,7 +520,7 @@ static int grep_submodule(struct grep_opt *opt,
 		struct strbuf base = STRBUF_INIT;
 
 		obj_read_lock();
-		object_type = oid_object_info(subrepo, oid, NULL);
+		object_type = odb_read_object_info(subrepo->objects, oid, NULL);
 		obj_read_unlock();
 		data = read_object_with_reference(subrepo,
 						  oid, OBJ_TREE,
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8e5acefde40..82cf80b89d1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -260,7 +260,8 @@ static unsigned check_object(struct object *obj)
 
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
-		int type = oid_object_info(the_repository, &obj->oid, &size);
+		int type = odb_read_object_info(the_repository->objects,
+						&obj->oid, &size);
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
@@ -908,7 +909,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		enum object_type has_type;
 		unsigned long has_size;
 		read_lock();
-		has_type = oid_object_info(the_repository, oid, &has_size);
+		has_type = odb_read_object_info(the_repository->objects, oid, &has_size);
 		if (has_type < 0)
 			die(_("cannot read existing object info %s"), oid_to_hex(oid));
 		if (has_type != type || has_size != size)
@@ -1495,9 +1496,9 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		struct oid_array to_fetch = OID_ARRAY_INIT;
 		for (i = 0; i < nr_ref_deltas; i++) {
 			struct ref_delta_entry *d = sorted_by_pos[i];
-			if (!oid_object_info_extended(the_repository, &d->oid,
-						      NULL,
-						      OBJECT_INFO_FOR_PREFETCH))
+			if (!odb_read_object_info_extended(the_repository->objects,
+							   &d->oid, NULL,
+							   OBJECT_INFO_FOR_PREFETCH))
 				continue;
 			oid_array_append(&to_fetch, &d->oid);
 		}
@@ -1823,7 +1824,7 @@ static void repack_local_links(void)
 	oidset_iter_init(&outgoing_links, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
 		struct object_info info = OBJECT_INFO_INIT;
-		if (oid_object_info_extended(the_repository, oid, &info, 0))
+		if (odb_read_object_info_extended(the_repository->objects, oid, &info, 0))
 			/* Missing; assume it is a promisor object */
 			continue;
 		if (info.whence == OI_PACKED && info.u.packed.pack->pack_promisor)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 821339b07d4..ff975e7be06 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -251,7 +251,7 @@ static void expand_objectsize(struct repository *repo, struct strbuf *line,
 {
 	if (type == OBJ_BLOB) {
 		unsigned long size;
-		if (oid_object_info(repo, oid, &size) < 0)
+		if (odb_read_object_info(repo->objects, oid, &size) < 0)
 			die(_("could not get object info about '%s'"),
 			    oid_to_hex(oid));
 		if (padded)
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 62b6fd58c16..4d616dd5282 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -27,7 +27,7 @@ static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
 {
 	if (type == OBJ_BLOB) {
 		unsigned long size;
-		if (oid_object_info(the_repository, oid, &size) < 0)
+		if (odb_read_object_info(the_repository->objects, oid, &size) < 0)
 			die(_("could not get object info about '%s'"),
 			    oid_to_hex(oid));
 		if (padded)
@@ -217,7 +217,7 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 
 	if (type == OBJ_BLOB) {
 		unsigned long size;
-		if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
+		if (odb_read_object_info(the_repository->objects, oid, &size) == OBJ_BAD)
 			xsnprintf(size_text, sizeof(size_text), "BAD");
 		else
 			xsnprintf(size_text, sizeof(size_text),
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 016b0e5b224..81df7f6099f 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -124,10 +124,10 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 
 	/* Check the type of object identified by oid without fetching objects */
 	oi.typep = &obj_type;
-	if (oid_object_info_extended(the_repository, &oid, &oi,
-				     OBJECT_INFO_LOOKUP_REPLACE |
-				     OBJECT_INFO_QUICK |
-				     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
+	if (odb_read_object_info_extended(the_repository->objects, &oid, &oi,
+					  OBJECT_INFO_LOOKUP_REPLACE |
+					  OBJECT_INFO_QUICK |
+					  OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
 		obj_type = -1;
 
 	if (obj_type < 0) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 99b63cb0980..da35d684081 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2154,10 +2154,10 @@ static void prefetch_to_pack(uint32_t object_index_start) {
 	for (i = object_index_start; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = to_pack.objects + i;
 
-		if (!oid_object_info_extended(the_repository,
-					      &entry->idx.oid,
-					      NULL,
-					      OBJECT_INFO_FOR_PREFETCH))
+		if (!odb_read_object_info_extended(the_repository->objects,
+						   &entry->idx.oid,
+						   NULL,
+						   OBJECT_INFO_FOR_PREFETCH))
 			continue;
 		oid_array_append(&to_fetch, &entry->idx.oid);
 	}
@@ -2298,19 +2298,19 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 
 		/*
 		 * No choice but to fall back to the recursive delta walk
-		 * with oid_object_info() to find about the object type
+		 * with odb_read_object_info() to find about the object type
 		 * at this point...
 		 */
 		give_up:
 		unuse_pack(&w_curs);
 	}
 
-	if (oid_object_info_extended(the_repository, &entry->idx.oid, &oi,
-				     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0) {
+	if (odb_read_object_info_extended(the_repository->objects, &entry->idx.oid, &oi,
+					  OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0) {
 		if (repo_has_promisor_remote(the_repository)) {
 			prefetch_to_pack(object_index);
-			if (oid_object_info_extended(the_repository, &entry->idx.oid, &oi,
-						     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0)
+			if (odb_read_object_info_extended(the_repository->objects, &entry->idx.oid, &oi,
+							  OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0)
 				type = -1;
 		} else {
 			type = -1;
@@ -2384,12 +2384,13 @@ static void drop_reused_delta(struct object_entry *entry)
 	if (packed_object_info(the_repository, IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
-		 * fall back to oid_object_info, which may find another copy.
+		 * fall back to odb_read_object_info, which may find another copy.
 		 * And if that fails, the error will be recorded in oe_type(entry)
 		 * and dealt with in prepare_pack().
 		 */
 		oe_set_type(entry,
-			    oid_object_info(the_repository, &entry->idx.oid, &size));
+			    odb_read_object_info(the_repository->objects,
+						 &entry->idx.oid, &size));
 	} else {
 		oe_set_type(entry, type);
 	}
@@ -2677,7 +2678,8 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
 		packing_data_lock(&to_pack);
-		if (oid_object_info(the_repository, &e->idx.oid, &size) < 0)
+		if (odb_read_object_info(the_repository->objects,
+					 &e->idx.oid, &size) < 0)
 			die(_("unable to get size of %s"),
 			    oid_to_hex(&e->idx.oid));
 		packing_data_unlock(&to_pack);
@@ -4063,7 +4065,7 @@ static void add_objects_in_unpacked_packs(void)
 static int add_loose_object(const struct object_id *oid, const char *path,
 			    void *data UNUSED)
 {
-	enum object_type type = oid_object_info(the_repository, oid, NULL);
+	enum object_type type = odb_read_object_info(the_repository->objects, oid, NULL);
 
 	if (type < 0) {
 		warning(_("loose object at %s could not be examined"), path);
@@ -4449,7 +4451,7 @@ static int option_parse_cruft_expiration(const struct option *opt UNUSED,
 static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
 {
 	struct object_info info = OBJECT_INFO_INIT;
-	if (oid_object_info_extended(the_repository, &obj->oid, &info, 0))
+	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
 		BUG("should_include_obj should only be called on existing objects");
 	return info.whence != OI_PACKED || !info.u.packed.pack->pack_promisor;
 }
diff --git a/builtin/prune.c b/builtin/prune.c
index 7bbfb14c2be..339017c7ccf 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -99,8 +99,8 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 	if (st.st_mtime > expire)
 		return 0;
 	if (show_only || verbose) {
-		enum object_type type = oid_object_info(the_repository, oid,
-							NULL);
+		enum object_type type = odb_read_object_info(the_repository->objects,
+							     oid, NULL);
 		printf("%s %s\n", oid_to_hex(oid),
 		       (type > 0) ? type_name(type) : "unknown");
 	}
diff --git a/builtin/repack.c b/builtin/repack.c
index 8145474cf8d..a89c2b704fb 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -707,7 +707,7 @@ static int midx_snapshot_ref_one(const char *refname UNUSED,
 	if (oidset_insert(&data->seen, oid))
 		return 0; /* already seen */
 
-	if (oid_object_info(the_repository, oid, NULL) != OBJ_COMMIT)
+	if (odb_read_object_info(the_repository->objects, oid, NULL) != OBJ_COMMIT)
 		return 0;
 
 	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
diff --git a/builtin/replace.c b/builtin/replace.c
index 11c7e2d4c0c..5ff2ab723cb 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -65,8 +65,8 @@ static int show_reference(const char *refname,
 			if (repo_get_oid(data->repo, refname, &object))
 				return error(_("failed to resolve '%s' as a valid ref"), refname);
 
-			obj_type = oid_object_info(data->repo, &object, NULL);
-			repl_type = oid_object_info(data->repo, oid, NULL);
+			obj_type = odb_read_object_info(data->repo->objects, &object, NULL);
+			repl_type = odb_read_object_info(data->repo->objects, oid, NULL);
 
 			printf("%s (%s) -> %s (%s)\n", refname, type_name(obj_type),
 			       oid_to_hex(oid), type_name(repl_type));
@@ -185,8 +185,8 @@ static int replace_object_oid(const char *object_ref,
 	struct strbuf err = STRBUF_INIT;
 	int res = 0;
 
-	obj_type = oid_object_info(the_repository, object, NULL);
-	repl_type = oid_object_info(the_repository, repl, NULL);
+	obj_type = odb_read_object_info(the_repository->objects, object, NULL);
+	repl_type = odb_read_object_info(the_repository->objects, repl, NULL);
 	if (!force && obj_type != repl_type)
 		return error(_("Objects must be of the same type.\n"
 			       "'%s' points to a replaced object of type '%s'\n"
@@ -334,7 +334,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	if (repo_get_oid(the_repository, object_ref, &old_oid) < 0)
 		return error(_("not a valid object name: '%s'"), object_ref);
 
-	type = oid_object_info(the_repository, &old_oid, NULL);
+	type = odb_read_object_info(the_repository->objects, &old_oid, NULL);
 	if (type < 0)
 		return error(_("unable to get object type for %s"),
 			     oid_to_hex(&old_oid));
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ee25d61c802..eed73f5fc0b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -110,7 +110,8 @@ static off_t get_object_disk_usage(struct object *obj)
 	off_t size;
 	struct object_info oi = OBJECT_INFO_INIT;
 	oi.disk_sizep = &size;
-	if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
+	if (odb_read_object_info_extended(the_repository->objects,
+					  &obj->oid, &oi, 0) < 0)
 		die(_("unable to get disk usage of %s"), oid_to_hex(&obj->oid));
 	return size;
 }
@@ -346,7 +347,8 @@ static void show_commit(struct commit *commit, void *data)
 static int finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
+	if (odb_read_object_info_extended(the_repository->objects,
+					  &obj->oid, NULL, 0) < 0) {
 		finish_object__ma(obj, name);
 		return 1;
 	}
diff --git a/builtin/tag.c b/builtin/tag.c
index cf2ea4b4993..e0b27396c6b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -304,7 +304,7 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 	struct strbuf header = STRBUF_INIT;
 	int should_edit;
 
-	type = oid_object_info(the_repository, object, NULL);
+	type = odb_read_object_info(the_repository->objects, object, NULL);
 	if (type <= OBJ_NONE)
 		die(_("bad object type."));
 
@@ -401,7 +401,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 	}
 
 	strbuf_addstr(sb, " (");
-	type = oid_object_info(the_repository, oid, NULL);
+	type = odb_read_object_info(the_repository->objects, oid, NULL);
 	switch (type) {
 	default:
 		strbuf_addstr(sb, "object of unknown type");
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 7bf395eec84..405e78bc592 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -232,7 +232,7 @@ static int check_object(struct object *obj, enum object_type type,
 
 	if (!(obj->flags & FLAG_OPEN)) {
 		unsigned long size;
-		int type = oid_object_info(the_repository, &obj->oid, &size);
+		int type = odb_read_object_info(the_repository->objects, &obj->oid, &size);
 		if (type != obj->type || type <= 0)
 			die("object of unexpected type");
 		obj->flags |= FLAG_WRITTEN;
diff --git a/commit-graph.c b/commit-graph.c
index ff72f7e32ae..9c2740a8cab 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1862,7 +1862,7 @@ static int add_ref_to_set(const char *refname UNUSED,
 
 	if (!peel_iterated_oid(the_repository, oid, &peeled))
 		oid = &peeled;
-	if (oid_object_info(the_repository, oid, NULL) == OBJ_COMMIT)
+	if (odb_read_object_info(the_repository->objects, oid, NULL) == OBJ_COMMIT)
 		oidset_insert(data->commits, oid);
 
 	display_progress(data->progress, oidset_size(data->commits));
diff --git a/commit.c b/commit.c
index aa65183d8b6..d4aa9c7a5f8 100644
--- a/commit.c
+++ b/commit.c
@@ -585,7 +585,8 @@ int repo_parse_commit_internal(struct repository *r,
 		return 0;
 	}
 
-	if (oid_object_info_extended(r, &item->object.oid, &oi, flags) < 0)
+	if (odb_read_object_info_extended(r->objects, &item->object.oid,
+					  &oi, flags) < 0)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
 			     oid_to_hex(&item->object.oid));
diff --git a/diff.c b/diff.c
index 193da8bee68..75cfedf18a5 100644
--- a/diff.c
+++ b/diff.c
@@ -4230,14 +4230,14 @@ int diff_populate_filespec(struct repository *r,
 			info.contentp = &s->data;
 
 		if (options && options->missing_object_cb) {
-			if (!oid_object_info_extended(r, &s->oid, &info,
-						      OBJECT_INFO_LOOKUP_REPLACE |
-						      OBJECT_INFO_SKIP_FETCH_OBJECT))
+			if (!odb_read_object_info_extended(r->objects, &s->oid, &info,
+							   OBJECT_INFO_LOOKUP_REPLACE |
+							   OBJECT_INFO_SKIP_FETCH_OBJECT))
 				goto object_read;
 			options->missing_object_cb(options->missing_object_data);
 		}
-		if (oid_object_info_extended(r, &s->oid, &info,
-					     OBJECT_INFO_LOOKUP_REPLACE))
+		if (odb_read_object_info_extended(r->objects, &s->oid, &info,
+						  OBJECT_INFO_LOOKUP_REPLACE))
 			die("unable to read %s", oid_to_hex(&s->oid));
 
 object_read:
@@ -4252,8 +4252,8 @@ int diff_populate_filespec(struct repository *r,
 		}
 		if (!info.contentp) {
 			info.contentp = &s->data;
-			if (oid_object_info_extended(r, &s->oid, &info,
-						     OBJECT_INFO_LOOKUP_REPLACE))
+			if (odb_read_object_info_extended(r->objects, &s->oid, &info,
+							  OBJECT_INFO_LOOKUP_REPLACE))
 				die("unable to read %s", oid_to_hex(&s->oid));
 		}
 		s->should_free = 1;
@@ -7019,8 +7019,8 @@ void diff_add_if_missing(struct repository *r,
 {
 	if (filespec && filespec->oid_valid &&
 	    !S_ISGITLINK(filespec->mode) &&
-	    oid_object_info_extended(r, &filespec->oid, NULL,
-				     OBJECT_INFO_FOR_PREFETCH))
+	    odb_read_object_info_extended(r->objects, &filespec->oid, NULL,
+					  OBJECT_INFO_FOR_PREFETCH))
 		oid_array_append(to_fetch, &filespec->oid);
 }
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 47fa7fa4c49..0f5de1c94d1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -149,8 +149,8 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 	}
 
 	while (1) {
-		if (oid_object_info_extended(the_repository, oid, &info,
-					     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK))
+		if (odb_read_object_info_extended(the_repository->objects, oid, &info,
+						  OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK))
 			return NULL;
 		if (type == OBJ_TAG) {
 			struct tag *tag = (struct tag *)
diff --git a/list-objects-filter.c b/list-objects-filter.c
index cb9c16734b1..ec7aebaffd0 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -310,7 +310,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 		assert(obj->type == OBJ_BLOB);
 		assert((obj->flags & SEEN) == 0);
 
-		t = oid_object_info(r, &obj->oid, &object_length);
+		t = odb_read_object_info(r->objects, &obj->oid, &object_length);
 		if (t != OBJ_BLOB) { /* probably OBJ_NONE */
 			/*
 			 * We DO NOT have the blob locally, so we cannot
diff --git a/log-tree.c b/log-tree.c
index 1d05dc1c701..233bf9f227c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -176,7 +176,7 @@ static int add_ref_decoration(const char *refname, const char *referent UNUSED,
 		return 0;
 	}
 
-	objtype = oid_object_info(the_repository, oid, NULL);
+	objtype = odb_read_object_info(the_repository->objects, oid, NULL);
 	if (objtype < 0)
 		return 0;
 	obj = lookup_object_by_type(the_repository, oid, objtype);
diff --git a/merge-ort.c b/merge-ort.c
index f86c84635f0..5d4501085e9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4374,8 +4374,8 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 
 			if ((ci->filemask & side_mask) &&
 			    S_ISREG(vi->mode) &&
-			    oid_object_info_extended(opt->repo, &vi->oid, NULL,
-						     OBJECT_INFO_FOR_PREFETCH))
+			    odb_read_object_info_extended(opt->repo->objects, &vi->oid, NULL,
+							  OBJECT_INFO_FOR_PREFETCH))
 				oid_array_append(&to_fetch, &vi->oid);
 		}
 	}
diff --git a/object-file.c b/object-file.c
index c70a3fc317a..25db71dc1e6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1211,7 +1211,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	oi.typep = &type;
 	oi.sizep = &len;
 	oi.contentp = &buf;
-	if (oid_object_info_extended(the_repository, oid, &oi, 0))
+	if (odb_read_object_info_extended(the_repository->objects, oid, &oi, 0))
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
 	if (compat) {
 		if (repo_oid_to_algop(repo, oid, compat, &compat_oid))
diff --git a/object-file.h b/object-file.h
index aff33f61bb4..c7a559a0502 100644
--- a/object-file.h
+++ b/object-file.h
@@ -8,7 +8,7 @@
 struct index_state;
 
 /*
- * Set this to 0 to prevent oid_object_info_extended() from fetching missing
+ * Set this to 0 to prevent odb_read_object_info_extended() from fetching missing
  * blobs. This has a difference only if extensions.partialClone is set.
  *
  * Its default value is 1.
diff --git a/object-name.c b/object-name.c
index 919a3e7a9f8..1745f97757c 100644
--- a/object-name.c
+++ b/object-name.c
@@ -251,7 +251,7 @@ static int disambiguate_commit_only(struct repository *r,
 				    const struct object_id *oid,
 				    void *cb_data UNUSED)
 {
-	int kind = oid_object_info(r, oid, NULL);
+	int kind = odb_read_object_info(r->objects, oid, NULL);
 	return kind == OBJ_COMMIT;
 }
 
@@ -262,7 +262,7 @@ static int disambiguate_committish_only(struct repository *r,
 	struct object *obj;
 	int kind;
 
-	kind = oid_object_info(r, oid, NULL);
+	kind = odb_read_object_info(r->objects, oid, NULL);
 	if (kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
@@ -279,7 +279,7 @@ static int disambiguate_tree_only(struct repository *r,
 				  const struct object_id *oid,
 				  void *cb_data UNUSED)
 {
-	int kind = oid_object_info(r, oid, NULL);
+	int kind = odb_read_object_info(r->objects, oid, NULL);
 	return kind == OBJ_TREE;
 }
 
@@ -290,7 +290,7 @@ static int disambiguate_treeish_only(struct repository *r,
 	struct object *obj;
 	int kind;
 
-	kind = oid_object_info(r, oid, NULL);
+	kind = odb_read_object_info(r->objects, oid, NULL);
 	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
@@ -307,7 +307,7 @@ static int disambiguate_blob_only(struct repository *r,
 				  const struct object_id *oid,
 				  void *cb_data UNUSED)
 {
-	int kind = oid_object_info(r, oid, NULL);
+	int kind = odb_read_object_info(r->objects, oid, NULL);
 	return kind == OBJ_BLOB;
 }
 
@@ -399,7 +399,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		return 0;
 
 	hash = repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV);
-	type = oid_object_info(ds->repo, oid, NULL);
+	type = odb_read_object_info(ds->repo->objects, oid, NULL);
 
 	if (type < 0) {
 		/*
@@ -514,8 +514,8 @@ static int sort_ambiguous(const void *va, const void *vb, void *ctx)
 {
 	struct repository *sort_ambiguous_repo = ctx;
 	const struct object_id *a = va, *b = vb;
-	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
-	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
+	int a_type = odb_read_object_info(sort_ambiguous_repo->objects, a, NULL);
+	int b_type = odb_read_object_info(sort_ambiguous_repo->objects, b, NULL);
 	int a_type_sort;
 	int b_type_sort;
 
diff --git a/object.c b/object.c
index 3b15469139d..868d89eed42 100644
--- a/object.c
+++ b/object.c
@@ -214,7 +214,7 @@ enum peel_status peel_object(struct repository *r,
 	struct object *o = lookup_unknown_object(r, name);
 
 	if (o->type == OBJ_NONE) {
-		int type = oid_object_info(r, name, NULL);
+		int type = odb_read_object_info(r->objects, name, NULL);
 		if (type < 0 || !object_as_type(o, type, 0))
 			return PEEL_INVALID;
 	}
@@ -315,7 +315,7 @@ struct object *parse_object_with_flags(struct repository *r,
 	}
 
 	if ((!obj || obj->type == OBJ_BLOB) &&
-	    oid_object_info(r, oid, NULL) == OBJ_BLOB) {
+	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
 		if (!skip_hash && stream_object_signature(r, repl) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
@@ -331,7 +331,7 @@ struct object *parse_object_with_flags(struct repository *r,
 	 */
 	if (skip_hash && discard_tree &&
 	    (!obj || obj->type == OBJ_TREE) &&
-	    oid_object_info(r, oid, NULL) == OBJ_TREE) {
+	    odb_read_object_info(r->objects, oid, NULL) == OBJ_TREE) {
 		return &lookup_tree(r, oid)->object;
 	}
 
diff --git a/odb.c b/odb.c
index 8901e3f43a3..919b8772f86 100644
--- a/odb.c
+++ b/odb.c
@@ -647,7 +647,7 @@ static int register_all_submodule_backends(struct object_database *odb)
 	return ret;
 }
 
-static int do_oid_object_info_extended(struct repository *r,
+static int do_oid_object_info_extended(struct object_database *odb,
 				       const struct object_id *oid,
 				       struct object_info *oi, unsigned flags)
 {
@@ -660,7 +660,7 @@ static int do_oid_object_info_extended(struct repository *r,
 
 
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
-		real = lookup_replace_object(r, oid);
+		real = lookup_replace_object(odb->repo, oid);
 
 	if (is_null_oid(real))
 		return -1;
@@ -668,7 +668,7 @@ static int do_oid_object_info_extended(struct repository *r,
 	if (!oi)
 		oi = &blank_oi;
 
-	co = find_cached_object(r->objects, real);
+	co = find_cached_object(odb, real);
 	if (co) {
 		if (oi->typep)
 			*(oi->typep) = co->type;
@@ -677,7 +677,7 @@ static int do_oid_object_info_extended(struct repository *r,
 		if (oi->disk_sizep)
 			*(oi->disk_sizep) = 0;
 		if (oi->delta_base_oid)
-			oidclr(oi->delta_base_oid, r->hash_algo);
+			oidclr(oi->delta_base_oid, odb->repo->hash_algo);
 		if (oi->type_name)
 			strbuf_addstr(oi->type_name, type_name(co->type));
 		if (oi->contentp)
@@ -687,17 +687,17 @@ static int do_oid_object_info_extended(struct repository *r,
 	}
 
 	while (1) {
-		if (find_pack_entry(r, real, &e))
+		if (find_pack_entry(odb->repo, real, &e))
 			break;
 
 		/* Most likely it's a loose object. */
-		if (!loose_object_info(r, real, oi, flags))
+		if (!loose_object_info(odb->repo, real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
 		if (!(flags & OBJECT_INFO_QUICK)) {
-			reprepare_packed_git(r);
-			if (find_pack_entry(r, real, &e))
+			reprepare_packed_git(odb->repo);
+			if (find_pack_entry(odb->repo, real, &e))
 				break;
 		}
 
@@ -707,15 +707,15 @@ static int do_oid_object_info_extended(struct repository *r,
 		 * `odb_add_submodule_backend_by_path()` on that submodule's
 		 * ODB). If any such ODBs exist, register them and try again.
 		 */
-		if (register_all_submodule_backends(r->objects))
+		if (register_all_submodule_backends(odb))
 			/* We added some alternates; retry */
 			continue;
 
 		/* Check if it is a missing object */
-		if (fetch_if_missing && repo_has_promisor_remote(r) &&
+		if (fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
 		    !already_retried &&
 		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
-			promisor_remote_get_direct(r, real, 1);
+			promisor_remote_get_direct(odb->repo, real, 1);
 			already_retried = 1;
 			continue;
 		}
@@ -725,7 +725,7 @@ static int do_oid_object_info_extended(struct repository *r,
 			if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
 				die(_("replacement %s not found for %s"),
 				    oid_to_hex(real), oid_to_hex(oid));
-			if ((p = has_packed_and_bad(r, real)))
+			if ((p = has_packed_and_bad(odb->repo, real)))
 				die(_("packed object %s (stored in %s) is corrupt"),
 				    oid_to_hex(real), p->pack_name);
 		}
@@ -738,10 +738,10 @@ static int do_oid_object_info_extended(struct repository *r,
 		 * information below, so return early.
 		 */
 		return 0;
-	rtype = packed_object_info(r, e.p, e.offset, oi);
+	rtype = packed_object_info(odb->repo, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
-		return do_oid_object_info_extended(r, real, oi, 0);
+		return do_oid_object_info_extended(odb, real, oi, 0);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
@@ -789,7 +789,7 @@ static int oid_object_info_convert(struct repository *r,
 		oi = &new_oi;
 	}
 
-	ret = oid_object_info_extended(r, &oid, oi, flags);
+	ret = odb_read_object_info_extended(r->objects, &oid, oi, flags);
 	if (ret)
 		return -1;
 	if (oi == input_oi)
@@ -839,33 +839,35 @@ static int oid_object_info_convert(struct repository *r,
 	return ret;
 }
 
-int oid_object_info_extended(struct repository *r, const struct object_id *oid,
-			     struct object_info *oi, unsigned flags)
+int odb_read_object_info_extended(struct object_database *odb,
+				  const struct object_id *oid,
+				  struct object_info *oi,
+				  unsigned flags)
 {
 	int ret;
 
-	if (oid->algo && (hash_algo_by_ptr(r->hash_algo) != oid->algo))
-		return oid_object_info_convert(r, oid, oi, flags);
+	if (oid->algo && (hash_algo_by_ptr(odb->repo->hash_algo) != oid->algo))
+		return oid_object_info_convert(odb->repo, oid, oi, flags);
 
 	obj_read_lock();
-	ret = do_oid_object_info_extended(r, oid, oi, flags);
+	ret = do_oid_object_info_extended(odb, oid, oi, flags);
 	obj_read_unlock();
 	return ret;
 }
 
 
 /* returns enum object_type or negative */
-int oid_object_info(struct repository *r,
-		    const struct object_id *oid,
-		    unsigned long *sizep)
+int odb_read_object_info(struct object_database *odb,
+			 const struct object_id *oid,
+			 unsigned long *sizep)
 {
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.typep = &type;
 	oi.sizep = sizep;
-	if (oid_object_info_extended(r, oid, &oi,
-				      OBJECT_INFO_LOOKUP_REPLACE) < 0)
+	if (odb_read_object_info_extended(odb, oid, &oi,
+					  OBJECT_INFO_LOOKUP_REPLACE) < 0)
 		return -1;
 	return type;
 }
@@ -896,7 +898,7 @@ int pretend_object_file(struct repository *repo,
 
 /*
  * This function dies on corrupt objects; the callers who want to
- * deal with them should arrange to call oid_object_info_extended() and give
+ * deal with them should arrange to call odb_read_object_info_extended() and give
  * error messages themselves.
  */
 void *repo_read_object_file(struct repository *r,
@@ -911,7 +913,7 @@ void *repo_read_object_file(struct repository *r,
 	oi.typep = type;
 	oi.sizep = size;
 	oi.contentp = &data;
-	if (oid_object_info_extended(r, oid, &oi, flags))
+	if (odb_read_object_info_extended(r->objects, oid, &oi, flags))
 		return NULL;
 
 	return data;
@@ -977,13 +979,13 @@ int has_object(struct repository *r, const struct object_id *oid,
 	if (!(flags & HAS_OBJECT_FETCH_PROMISOR))
 		object_info_flags |= OBJECT_INFO_SKIP_FETCH_OBJECT;
 
-	return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
+	return odb_read_object_info_extended(r->objects, oid, NULL, object_info_flags) >= 0;
 }
 
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect)
 {
-	enum object_type type = oid_object_info(odb->repo, oid, NULL);
+	enum object_type type = odb_read_object_info(odb, oid, NULL);
 	if (type < 0)
 		die(_("%s is not a valid object"), oid_to_hex(oid));
 	if (type != expect)
diff --git a/odb.h b/odb.h
index 1558f467425..2613f2c6c03 100644
--- a/odb.h
+++ b/odb.h
@@ -252,9 +252,6 @@ void *repo_read_object_file(struct repository *r,
 			    enum object_type *type,
 			    unsigned long *size);
 
-/* Read and unpack an object file into memory, write memory to an object file */
-int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
-
 /*
  * Add an object file to the in-memory object store, without writing it
  * to disk.
@@ -326,9 +323,24 @@ struct object_info {
 /* Die if object corruption (not just an object being missing) was detected. */
 #define OBJECT_INFO_DIE_IF_CORRUPT 32
 
-int oid_object_info_extended(struct repository *r,
-			     const struct object_id *,
-			     struct object_info *, unsigned flags);
+/*
+ * Read object info from the object database and populate the `object_info`
+ * structure. Returns 0 on success, a negative error code otherwise.
+ */
+int odb_read_object_info_extended(struct object_database *odb,
+				  const struct object_id *oid,
+				  struct object_info *oi,
+				  unsigned flags);
+
+/*
+ * Read a subset of object info for the given object ID. Returns an `enum
+ * object_type` on success, a negative error code otherwise. If successful and
+ * `sizep` is non-NULL, then the size of the object will be written to the
+ * pointer.
+ */
+int odb_read_object_info(struct object_database *odb,
+			 const struct object_id *oid,
+			 unsigned long *sizep);
 
 enum {
 	/* Retry packed storage after checking packed and loose storage */
@@ -350,7 +362,7 @@ void odb_assert_oid_type(struct object_database *odb,
 /*
  * Enabling the object read lock allows multiple threads to safely call the
  * following functions in parallel: repo_read_object_file(),
- * read_object_with_reference(), oid_object_info() and oid_object_info_extended().
+ * read_object_with_reference(), odb_read_object_info() and odb().
  *
  * obj_read_lock() and obj_read_unlock() may also be used to protect other
  * section which cannot execute in parallel with object reading. Since the used
@@ -358,7 +370,7 @@ void odb_assert_oid_type(struct object_database *odb,
  * reading functions. However, beware that in these cases zlib inflation won't
  * be performed in parallel, losing performance.
  *
- * TODO: oid_object_info_extended()'s call stack has a recursive behavior. If
+ * TODO: odb_read_object_info_extended()'s call stack has a recursive behavior. If
  * any of its callees end up calling it, this recursive call won't benefit from
  * parallel inflation.
  */
@@ -406,4 +418,22 @@ void *read_object_with_reference(struct repository *r,
 				 unsigned long *size,
 				 struct object_id *oid_ret);
 
+/* Compatibility wrappers, to be removed once Git 2.50 has been released. */
+#include "repository.h"
+
+static inline int oid_object_info_extended(struct repository *r,
+					   const struct object_id *oid,
+					   struct object_info *oi,
+					   unsigned flags)
+{
+	return odb_read_object_info_extended(r->objects, oid, oi, flags);
+}
+
+static inline int oid_object_info(struct repository *r,
+				  const struct object_id *oid,
+				  unsigned long *sizep)
+{
+	return odb_read_object_info(r->objects, oid, sizep);
+}
+
 #endif /* ODB_H */
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c847369eaaa..c5183b619c1 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -144,8 +144,8 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
 			break;
 
 		default:
-			real_type = oid_object_info(writer->to_pack->repo,
-						    &entry->idx.oid, NULL);
+			real_type = odb_read_object_info(writer->to_pack->repo->objects,
+							 &entry->idx.oid, NULL);
 			break;
 		}
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 467a3e91035..0bd6f1c282f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1868,8 +1868,8 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 		size_t eindex_pos = pos - bitmap_num_objects_total(bitmap_git);
 		struct eindex *eindex = &bitmap_git->ext_index;
 		struct object *obj = eindex->objects[eindex_pos];
-		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
-					     &oi, 0) < 0)
+		if (odb_read_object_info_extended(bitmap_repo(bitmap_git)->objects, &obj->oid,
+						  &oi, 0) < 0)
 			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
 	}
 
@@ -3220,8 +3220,8 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 				       i)))
 			continue;
 
-		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
-					     &oi, 0) < 0)
+		if (odb_read_object_info_extended(bitmap_repo(bitmap_git)->objects,
+						  &obj->oid, &oi, 0) < 0)
 			die(_("unable to get disk usage of '%s'"),
 			    oid_to_hex(&obj->oid));
 
diff --git a/packfile.c b/packfile.c
index 263056a6279..61920744168 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1310,7 +1310,7 @@ static int retry_bad_packed_offset(struct repository *r,
 		return OBJ_BAD;
 	nth_packed_object_id(&oid, p, pack_pos_to_index(p, pos));
 	mark_bad_packed_object(p, &oid);
-	type = oid_object_info(r, &oid, NULL);
+	type = odb_read_object_info(r->objects, &oid, NULL);
 	if (type <= OBJ_NONE)
 		return OBJ_BAD;
 	return type;
@@ -1843,7 +1843,8 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 				oi.typep = &type;
 				oi.sizep = &base_size;
 				oi.contentp = &base;
-				if (oid_object_info_extended(r, &base_oid, &oi, 0) < 0)
+				if (odb_read_object_info_extended(r->objects, &base_oid,
+								  &oi, 0) < 0)
 					base = NULL;
 
 				external_base = base;
diff --git a/promisor-remote.c b/promisor-remote.c
index 2baa286bfd0..be6f82d12f8 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -245,8 +245,8 @@ static int remove_fetched_oids(struct repository *repo,
 	struct object_id *new_oids;
 
 	for (i = 0; i < oid_nr; i++)
-		if (oid_object_info_extended(repo, &old_oids[i], NULL,
-					     OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+		if (odb_read_object_info_extended(repo->objects, &old_oids[i], NULL,
+						  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
 			remaining[i] = 1;
 			remaining_nr++;
 		}
diff --git a/protocol-caps.c b/protocol-caps.c
index 3022f69a1bd..ecdd0dc58d5 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -64,7 +64,7 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 		strbuf_addstr(&send_buffer, oid_str);
 
 		if (info->size) {
-			if (oid_object_info(r, &oid, &object_size) < 0) {
+			if (odb_read_object_info(r->objects, &oid, &object_size) < 0) {
 				strbuf_addstr(&send_buffer, " ");
 			} else {
 				strbuf_addf(&send_buffer, " %lu", object_size);
diff --git a/reachable.c b/reachable.c
index 9dc748f0b9a..e984b68a0c4 100644
--- a/reachable.c
+++ b/reachable.c
@@ -211,7 +211,7 @@ static void add_recent_object(const struct object_id *oid,
 	 * later processing, and the revision machinery expects
 	 * commits and tags to have been parsed.
 	 */
-	type = oid_object_info(the_repository, oid, NULL);
+	type = odb_read_object_info(the_repository->objects, oid, NULL);
 	if (type < 0)
 		die("unable to get object info for %s", oid_to_hex(oid));
 
diff --git a/read-cache.c b/read-cache.c
index dce1056ec7c..be664f857b4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3758,9 +3758,9 @@ void prefetch_cache_entries(const struct index_state *istate,
 
 		if (S_ISGITLINK(ce->ce_mode) || !must_prefetch(ce))
 			continue;
-		if (!oid_object_info_extended(the_repository, &ce->oid,
-					      NULL,
-					      OBJECT_INFO_FOR_PREFETCH))
+		if (!odb_read_object_info_extended(the_repository->objects,
+						   &ce->oid, NULL,
+						   OBJECT_INFO_FOR_PREFETCH))
 			continue;
 		oid_array_append(&to_fetch, &ce->oid);
 	}
diff --git a/ref-filter.c b/ref-filter.c
index 4ce45440ad1..f9f2c512a8c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2302,8 +2302,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 		oi->info.sizep = &oi->size;
 		oi->info.typep = &oi->type;
 	}
-	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
-				     OBJECT_INFO_LOOKUP_REPLACE))
+	if (odb_read_object_info_extended(the_repository->objects, &oi->oid, &oi->info,
+					  OBJECT_INFO_LOOKUP_REPLACE))
 		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
 				       oid_to_hex(&oi->oid), ref->refname);
 	if (oi->info.disk_sizep && oi->disk_size < 0)
diff --git a/remote.c b/remote.c
index 17a842f5684..72c36239d31 100644
--- a/remote.c
+++ b/remote.c
@@ -1182,7 +1182,7 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 		BUG("'%s' is not a valid object, "
 		    "match_explicit_lhs() should catch this!",
 		    matched_src_name);
-	type = oid_object_info(the_repository, &oid, NULL);
+	type = odb_read_object_info(the_repository->objects, &oid, NULL);
 	if (type == OBJ_COMMIT) {
 		advise(_("The <src> part of the refspec is a commit object.\n"
 			 "Did you mean to create a new branch by pushing to\n"
@@ -1412,7 +1412,8 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			continue; /* not a tag */
 		if (string_list_has_string(&dst_tag, ref->name))
 			continue; /* they already have it */
-		if (oid_object_info(the_repository, &ref->new_oid, NULL) != OBJ_TAG)
+		if (odb_read_object_info(the_repository->objects,
+					 &ref->new_oid, NULL) != OBJ_TAG)
 			continue; /* be conservative */
 		item = string_list_append(&src_tag, ref->name);
 		item->util = ref;
diff --git a/sequencer.c b/sequencer.c
index 35f4e68d59f..bb012a4bfd9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5502,9 +5502,8 @@ int sequencer_pick_revisions(struct repository *r,
 
 		if (!repo_get_oid(r, name, &oid)) {
 			if (!lookup_commit_reference_gently(r, &oid, 1)) {
-				enum object_type type = oid_object_info(r,
-									&oid,
-									NULL);
+				enum object_type type = odb_read_object_info(r->objects,
+									     &oid, NULL);
 				res = error(_("%s: can't cherry-pick a %s"),
 					    name, type_name(type));
 				goto out;
diff --git a/streaming.c b/streaming.c
index 29cc877f22a..032f134dc10 100644
--- a/streaming.c
+++ b/streaming.c
@@ -44,7 +44,7 @@ struct git_istream {
 
 	union {
 		struct {
-			char *buf; /* from oid_object_info_extended() */
+			char *buf; /* from odb_read_object_info_extended() */
 			unsigned long read_ptr;
 		} incore;
 
@@ -403,8 +403,8 @@ static int open_istream_incore(struct git_istream *st, struct repository *r,
 	oi.typep = type;
 	oi.sizep = &st->size;
 	oi.contentp = (void **)&st->u.incore.buf;
-	return oid_object_info_extended(r, oid, &oi,
-					OBJECT_INFO_DIE_IF_CORRUPT);
+	return odb_read_object_info_extended(r->objects, oid, &oi,
+					     OBJECT_INFO_DIE_IF_CORRUPT);
 }
 
 /*****************************************************************************
@@ -422,7 +422,7 @@ static int istream_source(struct git_istream *st,
 
 	oi.typep = type;
 	oi.sizep = &size;
-	status = oid_object_info_extended(r, oid, &oi, 0);
+	status = odb_read_object_info_extended(r->objects, oid, &oi, 0);
 	if (status < 0)
 		return status;
 
diff --git a/submodule.c b/submodule.c
index 788c9e55ed3..f8373a9ea7d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -968,7 +968,7 @@ static int check_has_commit(const struct object_id *oid, void *data)
 		return 0;
 	}
 
-	type = oid_object_info(&subrepo, oid, NULL);
+	type = odb_read_object_info(subrepo.objects, oid, NULL);
 
 	switch (type) {
 	case OBJ_COMMIT:
@@ -1752,8 +1752,7 @@ static int fetch_start_failure(struct strbuf *err UNUSED,
 static int commit_missing_in_sub(const struct object_id *oid, void *data)
 {
 	struct repository *subrepo = data;
-
-	enum object_type type = oid_object_info(subrepo, oid, NULL);
+	enum object_type type = odb_read_object_info(subrepo->objects, oid, NULL);
 
 	return type != OBJ_COMMIT;
 }
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index dba227259a2..d8488007493 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -23,7 +23,7 @@ static void object_info(const char *gitdir, const char *oid_hex)
 		die("could not init repo");
 	if (parse_oid_hex_algop(oid_hex, &oid, &p, r.hash_algo))
 		die("could not parse oid");
-	if (oid_object_info_extended(&r, &oid, &oi, 0))
+	if (odb_read_object_info_extended(r.objects, &oid, &oi, 0))
 		die("could not obtain object info");
 	printf("%d\n", (int) size);
 
diff --git a/tag.c b/tag.c
index 5f6868bf7b1..144048fd5e0 100644
--- a/tag.c
+++ b/tag.c
@@ -52,7 +52,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 	unsigned long size;
 	int ret;
 
-	type = oid_object_info(the_repository, oid, NULL);
+	type = odb_read_object_info(the_repository->objects, oid, NULL);
 	if (type != OBJ_TAG)
 		return error("%s: cannot verify a non-tag object of type %s.",
 				name_to_report ?

-- 
2.49.0.1045.g170613ef41.dirty

