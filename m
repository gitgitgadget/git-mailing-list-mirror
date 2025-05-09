Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5329671E
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799952; cv=none; b=Awvm8ktX0jK7asR42SJi1e6be2VXbl9yEuFAH4h1scOsnTVpU5rjoAgp2IWav+PQEr0k1d0DEUeh6C2l8qMt4egexROuLA/lZJ+A4MlwhG1x2H8qIXwhm0qUKcmq4hqHmewnrV4nFasg3XZ3kaQnGYLhj/oISytjcX0nStzckZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799952; c=relaxed/simple;
	bh=GLfTbP/KlaESXBjk8/lWrus1I8/snAkugGFzTHFUXwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpRf+hsPNMzVF/QZ/KC7X15qzi16ewxnrJ5HSNmjXUovBAWklt6IBW9eTnDTvQzUbwGfNRHOn3w0hvltDVMFcUIwYM5vzpUed0UVvlTjOv7mFIzx6Faike2k4TVWgHQrEb1jmHGWUaIkJ9aAt0ttdqzSGfTD7Um4WoxQITST+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=utGJ9Z/C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NmisGsUi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="utGJ9Z/C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NmisGsUi"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B49DA1140126;
	Fri,  9 May 2025 10:12:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 09 May 2025 10:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799948;
	 x=1746886348; bh=+pCMqBG5M4ypm+cDUy1Ds0V8FNlMEU4iE1uREVNBOqs=; b=
	utGJ9Z/CJU/Ac/GpMbBm6Sotsqg1q4vGns9miI0cduPNMvohSa2Ap+jZIItXff9E
	NMa+0UtDwnOX7FQqXf7l9kIzXIGKiEsd9yO2WbsQPeohQzpB4Ox1JbE5Xj/0/W9a
	LO3Tv9+MYejaAl1CloyV2DHRYgmWVdfcAVT7ChlG4Ck6mO2HLNjl0s88txQsFphv
	WOK7ea7r+05RT8dT+OOo5xoddx6YrQ3pE7Fj11rc1oSLJQRHYul5GKfDSmuWAMT5
	NnwMc6mUrZip6ReoA7Ct+sdka3UgDYGRA/3cS8Qz4QCptr7F0Raf6+14DenL+nzD
	mPn9ZaUBJlzab2SUDnkcQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799948; x=
	1746886348; bh=+pCMqBG5M4ypm+cDUy1Ds0V8FNlMEU4iE1uREVNBOqs=; b=N
	misGsUiuMbfoCGSL65dFlmYR+G59Pn4Mde2jFi5daHWyHyKNH9d/HW1AhXV/nZ44
	uBTwunIW2KoXPp+ZPlMcmPssEZckpKJm0D17tI/2Xk666e8sGJPClTmtMl7aBj7T
	Bq4ZB7+gPW3bY4PswZcSqIeLh9En2qe4n5ojJ9JAE1WzhbabvrIoKW2K6x6V4ieE
	SGEcEicmFiW/KaN0zlPLhG5eX+B0h1BTSBbnGCitADseqhwZc+ifNWeC/Bn9Rngr
	NVAIZFQTb/mOsN4V1MCLdHosTR94WigOV1Rw5yxi7opHGRMUt0qT+RzygRGJ5nND
	eZJ4IVVL6EX64DFaT41gw==
X-ME-Sender: <xms:TA0eaO18LeCpsd7qTkpBDn44RCt4YWGvbSS9tu-qxWXcfxigYIdo2Q>
    <xme:TA0eaBE7DUpMhuaaZdcIm_H7PmX4NObeviX-U81DhKQvMrxv7fCL2OjGJjINN99Lk
    ToAMVa8QWnXTPrxIQ>
X-ME-Received: <xmr:TA0eaG7Ev5P_IsrBKb2VePapFMIcVyq8CU5e4NWBB-YWsD66hbdSDGuAhsgqG6bgNsUoMuw2m-5jOY56wGncRK0hwERgB1ZNzqDQ9ZLo7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:TA0eaP3ibPFjwAiSDSL-jcUq3enE0KKF8IYYGCFqO9ybyZj18gSgcw>
    <xmx:TA0eaBG4y4KpgN9D8SgDeqUADgpnylNPMzsY7_b-jIHMtgYtzHSSdA>
    <xmx:TA0eaI9Br6ZIB3PXYtiA9L1dDnQvkpTyHsb_2xLtJa66M7tahf2FUg>
    <xmx:TA0eaGn19lFsvybQev0fTaNbhvIFa9qnGoXI3J43WPvSfuMtNOY2Uw>
    <xmx:TA0eaAzG2T4AvMJBcxQVmyaG03UoGfwusThwB8KM1Qs3-H1GT5OxvISz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0de983e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 16:12:14 +0200
Subject: [PATCH v2 14/17] odb: rename `repo_read_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-14-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Rename `repo_read_object_file()` to `odb_read_object()` to match other
functions related to the object database and our modern coding
guidelines.

Introduce a compatibility wrapper so that any in-flight topics will
continue to compile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c                  | 10 +++++-----
 archive.c                |  2 +-
 attr.c                   |  2 +-
 bisect.c                 |  6 +++---
 blame.c                  | 13 ++++++-------
 builtin/cat-file.c       | 26 +++++++++++---------------
 builtin/difftool.c       |  2 +-
 builtin/fast-export.c    |  6 +++---
 builtin/fast-import.c    |  8 ++++----
 builtin/grep.c           |  8 ++++----
 builtin/index-pack.c     |  8 ++++----
 builtin/log.c            |  2 +-
 builtin/merge-tree.c     | 12 ++++++------
 builtin/mktag.c          |  4 ++--
 builtin/notes.c          |  6 +++---
 builtin/pack-objects.c   | 30 +++++++++++++++---------------
 builtin/tag.c            |  4 ++--
 builtin/unpack-file.c    |  2 +-
 builtin/unpack-objects.c |  4 ++--
 bundle.c                 |  2 +-
 combine-diff.c           |  2 +-
 commit.c                 |  6 +++---
 config.c                 |  2 +-
 dir.c                    |  2 +-
 entry.c                  |  4 ++--
 fmt-merge-msg.c          |  4 ++--
 fsck.c                   |  2 +-
 grep.c                   |  4 ++--
 http-push.c              |  4 ++--
 mailmap.c                |  2 +-
 match-trees.c            |  4 ++--
 merge-blobs.c            |  8 ++++----
 merge-ort.c              |  2 +-
 notes-cache.c            |  2 +-
 notes-merge.c            |  2 +-
 notes.c                  | 13 +++++++------
 object.c                 |  2 +-
 odb.c                    | 19 +++++++------------
 odb.h                    | 29 +++++++++++++++++++++++------
 read-cache.c             |  6 +++---
 reflog.c                 |  4 ++--
 rerere.c                 |  5 ++---
 submodule-config.c       |  4 ++--
 tag.c                    |  6 +++---
 tree-walk.c              |  6 +++---
 tree.c                   |  4 ++--
 xdiff-interface.c        |  2 +-
 47 files changed, 157 insertions(+), 150 deletions(-)

diff --git a/apply.c b/apply.c
index 879f04df31e..56cd0540350 100644
--- a/apply.c
+++ b/apply.c
@@ -3210,8 +3210,8 @@ static int apply_binary(struct apply_state *state,
 		unsigned long size;
 		char *result;
 
-		result = repo_read_object_file(the_repository, &oid, &type,
-					       &size);
+		result = odb_read_object(the_repository->objects, &oid,
+					 &type, &size);
 		if (!result)
 			return error(_("the necessary postimage %s for "
 				       "'%s' cannot be read"),
@@ -3273,8 +3273,8 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 		unsigned long sz;
 		char *result;
 
-		result = repo_read_object_file(the_repository, oid, &type,
-					       &sz);
+		result = odb_read_object(the_repository->objects, oid,
+					 &type, &sz);
 		if (!result)
 			return -1;
 		/* XXX read_sha1_file NUL-terminates */
@@ -3503,7 +3503,7 @@ static int resolve_to(struct image *image, const struct object_id *result_id)
 
 	image_clear(image);
 
-	data = repo_read_object_file(the_repository, result_id, &type, &size);
+	data = odb_read_object(the_repository->objects, result_id, &type, &size);
 	if (!data || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(result_id));
 	strbuf_attach(&image->buf, data, size, size + 1);
diff --git a/archive.c b/archive.c
index f2511d530d5..f5a9d45c8d3 100644
--- a/archive.c
+++ b/archive.c
@@ -98,7 +98,7 @@ static void *object_file_to_archive(const struct archiver_args *args,
 			       (args->tree ? &args->tree->object.oid : NULL), oid);
 
 	path += args->baselen;
-	buffer = repo_read_object_file(the_repository, oid, type, sizep);
+	buffer = odb_read_object(the_repository->objects, oid, type, sizep);
 	if (buffer && S_ISREG(mode)) {
 		struct strbuf buf = STRBUF_INIT;
 		size_t size = 0;
diff --git a/attr.c b/attr.c
index e5680db7f65..d1daeb0b4d9 100644
--- a/attr.c
+++ b/attr.c
@@ -779,7 +779,7 @@ static struct attr_stack *read_attr_from_blob(struct index_state *istate,
 	if (get_tree_entry(istate->repo, tree_oid, path, &oid, &mode))
 		return NULL;
 
-	buf = repo_read_object_file(istate->repo, &oid, &type, &sz);
+	buf = odb_read_object(istate->repo->objects, &oid, &type, &sz);
 	if (!buf || type != OBJ_BLOB) {
 		free(buf);
 		return NULL;
diff --git a/bisect.c b/bisect.c
index a7939216d00..f24474542ec 100644
--- a/bisect.c
+++ b/bisect.c
@@ -155,9 +155,9 @@ static void show_list(const char *debug, int counted, int nr,
 		unsigned commit_flags = commit->object.flags;
 		enum object_type type;
 		unsigned long size;
-		char *buf = repo_read_object_file(the_repository,
-						  &commit->object.oid, &type,
-						  &size);
+		char *buf = odb_read_object(the_repository->objects,
+					    &commit->object.oid, &type,
+					    &size);
 		const char *subject_start;
 		int subject_len;
 
diff --git a/blame.c b/blame.c
index 97db3355af4..858d2d74df9 100644
--- a/blame.c
+++ b/blame.c
@@ -1041,9 +1041,9 @@ static void fill_origin_blob(struct diff_options *opt,
 				    &o->blob_oid, 1, &file->ptr, &file_size))
 			;
 		else
-			file->ptr = repo_read_object_file(the_repository,
-							  &o->blob_oid, &type,
-							  &file_size);
+			file->ptr = odb_read_object(the_repository->objects,
+						    &o->blob_oid, &type,
+						    &file_size);
 		file->size = file_size;
 
 		if (!file->ptr)
@@ -2869,10 +2869,9 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 				    &sb->final_buf_size))
 			;
 		else
-			sb->final_buf = repo_read_object_file(the_repository,
-							      &o->blob_oid,
-							      &type,
-							      &sb->final_buf_size);
+			sb->final_buf = odb_read_object(the_repository->objects,
+							&o->blob_oid, &type,
+							&sb->final_buf_size);
 
 		if (!sb->final_buf)
 			die(_("cannot read blob %s for path %s"),
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index da172155c85..d6b9afca06e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -74,7 +74,7 @@ static int filter_object(const char *path, unsigned mode,
 {
 	enum object_type type;
 
-	*buf = repo_read_object_file(the_repository, oid, &type, size);
+	*buf = odb_read_object(the_repository->objects, oid, &type, size);
 	if (!*buf)
 		return error(_("cannot read object %s '%s'"),
 			     oid_to_hex(oid), path);
@@ -206,8 +206,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			ret = stream_blob(&oid);
 			goto cleanup;
 		}
-		buf = repo_read_object_file(the_repository, &oid, &type,
-					    &size);
+		buf = odb_read_object(the_repository->objects, &oid,
+				      &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 
@@ -228,10 +228,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			struct object_id blob_oid;
 			if (odb_read_object_info(the_repository->objects,
 						 &oid, NULL) == OBJ_TAG) {
-				char *buffer = repo_read_object_file(the_repository,
-								     &oid,
-								     &type,
-								     &size);
+				char *buffer = odb_read_object(the_repository->objects,
+							       &oid, &type, &size);
 				const char *target;
 
 				if (!buffer)
@@ -412,10 +410,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 				if (!textconv_object(the_repository,
 						     data->rest, 0100644, oid,
 						     1, &contents, &size))
-					contents = repo_read_object_file(the_repository,
-									 oid,
-									 &type,
-									 &size);
+					contents = odb_read_object(the_repository->objects,
+								   oid, &type, &size);
 				if (!contents)
 					die("could not convert '%s' %s",
 					    oid_to_hex(oid), data->rest);
@@ -432,8 +428,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		unsigned long size;
 		void *contents;
 
-		contents = repo_read_object_file(the_repository, oid, &type,
-						 &size);
+		contents = odb_read_object(the_repository->objects, oid,
+					   &type, &size);
 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
 
@@ -542,8 +538,8 @@ static void batch_object_write(const char *obj_name,
 			size_t s = data->size;
 			char *buf = NULL;
 
-			buf = repo_read_object_file(the_repository, &data->oid, &data->type,
-						    &data->size);
+			buf = odb_read_object(the_repository->objects, &data->oid,
+					      &data->type, &data->size);
 			if (!buf)
 				die(_("unable to read %s"), oid_to_hex(&data->oid));
 			buf = replace_idents_using_mailmap(buf, &s);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index fac613e3bc3..e4bc1f83169 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -320,7 +320,7 @@ static char *get_symlink(struct repository *repo,
 	} else {
 		enum object_type type;
 		unsigned long size;
-		data = repo_read_object_file(repo, oid, &type, &size);
+		data = odb_read_object(repo->objects, oid, &type, &size);
 		if (!data)
 			die(_("could not read object %s for symlink %s"),
 				oid_to_hex(oid), path);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 6c93cf0a8aa..33f304dd0ad 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -323,7 +323,7 @@ static void export_blob(const struct object_id *oid)
 		object = (struct object *)lookup_blob(the_repository, oid);
 		eaten = 0;
 	} else {
-		buf = repo_read_object_file(the_repository, oid, &type, &size);
+		buf = odb_read_object(the_repository->objects, oid, &type, &size);
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
 		if (check_object_signature(the_repository, oid, buf, size,
@@ -869,8 +869,8 @@ static void handle_tag(const char *name, struct tag *tag)
 		return;
 	}
 
-	buf = repo_read_object_file(the_repository, &tag->object.oid, &type,
-				    &size);
+	buf = odb_read_object(the_repository->objects, &tag->object.oid,
+			      &type, &size);
 	if (!buf)
 		die("could not read tag %s", oid_to_hex(&tag->object.oid));
 	message = memmem(buf, size, "\n\n", 2);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2718376f2c9..1973c504e25 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1265,7 +1265,7 @@ static void load_tree(struct tree_entry *root)
 			die("Can't load tree %s", oid_to_hex(oid));
 	} else {
 		enum object_type type;
-		buf = repo_read_object_file(the_repository, oid, &type, &size);
+		buf = odb_read_object(the_repository->objects, oid, &type, &size);
 		if (!buf || type != OBJ_TREE)
 			die("Can't load tree %s", oid_to_hex(oid));
 	}
@@ -3002,7 +3002,7 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 	char *buf;
 
 	if (!oe || oe->pack_id == MAX_PACK_ID) {
-		buf = repo_read_object_file(the_repository, oid, &type, &size);
+		buf = odb_read_object(the_repository->objects, oid, &type, &size);
 	} else {
 		type = oe->type;
 		buf = gfi_unpack_entry(oe, &size);
@@ -3110,8 +3110,8 @@ static struct object_entry *dereference(struct object_entry *oe,
 		buf = gfi_unpack_entry(oe, &size);
 	} else {
 		enum object_type unused;
-		buf = repo_read_object_file(the_repository, oid, &unused,
-					    &size);
+		buf = odb_read_object(the_repository->objects, oid,
+				      &unused, &size);
 	}
 	if (!buf)
 		die("Can't load object %s", oid_to_hex(oid));
diff --git a/builtin/grep.c b/builtin/grep.c
index 311c940aa9e..f84298af0f6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -573,8 +573,8 @@ static int grep_cache(struct grep_opt *opt,
 			void *data;
 			unsigned long size;
 
-			data = repo_read_object_file(the_repository, &ce->oid,
-						     &type, &size);
+			data = odb_read_object(the_repository->objects, &ce->oid,
+					       &type, &size);
 			if (!data)
 				die(_("unable to read tree %s"), oid_to_hex(&ce->oid));
 			init_tree_desc(&tree, &ce->oid, data, size);
@@ -666,8 +666,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			unsigned long size;
 
-			data = repo_read_object_file(the_repository,
-						     &entry.oid, &type, &size);
+			data = odb_read_object(the_repository->objects,
+					       &entry.oid, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
 				    oid_to_hex(&entry.oid));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 82cf80b89d1..d33392cab65 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -914,8 +914,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			die(_("cannot read existing object info %s"), oid_to_hex(oid));
 		if (has_type != type || has_size != size)
 			die(_("SHA1 COLLISION FOUND WITH %s !"), oid_to_hex(oid));
-		has_data = repo_read_object_file(the_repository, oid,
-						 &has_type, &has_size);
+		has_data = odb_read_object(the_repository->objects, oid,
+					   &has_type, &has_size);
 		read_unlock();
 		if (!data)
 			data = new_data = get_data_from_pack(obj_entry);
@@ -1515,8 +1515,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
-		data = repo_read_object_file(the_repository, &d->oid, &type,
-					     &size);
+		data = odb_read_object(the_repository->objects, &d->oid,
+				       &type, &size);
 		if (!data)
 			continue;
 
diff --git a/builtin/log.c b/builtin/log.c
index fe9cc5ebecb..f2040b18159 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -714,7 +714,7 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf = repo_read_object_file(the_repository, oid, &type, &size);
+	char *buf = odb_read_object(the_repository->objects, oid, &type, &size);
 	unsigned long offset = 0;
 
 	if (!buf)
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 709ae3966a6..21fb0b2df1d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -75,9 +75,9 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	const char *path = entry->path;
 
 	if (!entry->stage)
-		return repo_read_object_file(the_repository,
-					     &entry->blob->object.oid, &type,
-					     size);
+		return odb_read_object(the_repository->objects,
+				       &entry->blob->object.oid, &type,
+				       size);
 	base = NULL;
 	if (entry->stage == 1) {
 		base = entry->blob;
@@ -100,9 +100,9 @@ static void *origin(struct merge_list *entry, unsigned long *size)
 	enum object_type type;
 	while (entry) {
 		if (entry->stage == 2)
-			return repo_read_object_file(the_repository,
-						     &entry->blob->object.oid,
-						     &type, size);
+			return odb_read_object(the_repository->objects,
+					       &entry->blob->object.oid,
+					       &type, size);
 		entry = entry->link;
 	}
 	return NULL;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 1809b38f937..1b391119de8 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -54,8 +54,8 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 	void *buffer;
 	const struct object_id *repl;
 
-	buffer = repo_read_object_file(the_repository, tagged_oid, &type,
-				       &size);
+	buffer = odb_read_object(the_repository->objects, tagged_oid,
+				 &type, &size);
 	if (!buffer)
 		die(_("could not read tagged object '%s'"),
 		    oid_to_hex(tagged_oid));
diff --git a/builtin/notes.c b/builtin/notes.c
index 783d4932ca6..a9529b1696a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -152,7 +152,7 @@ static void copy_obj_to_fd(int fd, const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf = repo_read_object_file(the_repository, oid, &type, &size);
+	char *buf = odb_read_object(the_repository->objects, oid, &type, &size);
 	if (buf) {
 		if (size)
 			write_or_die(fd, buf, size);
@@ -319,7 +319,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	strbuf_init(&msg->buf, 0);
 	if (repo_get_oid(the_repository, arg, &object))
 		die(_("failed to resolve '%s' as a valid ref."), arg);
-	if (!(value = repo_read_object_file(the_repository, &object, &type, &len)))
+	if (!(value = odb_read_object(the_repository->objects, &object, &type, &len)))
 		die(_("failed to read object '%s'."), arg);
 	if (type != OBJ_BLOB) {
 		strbuf_release(&msg->buf);
@@ -722,7 +722,7 @@ static int append_edit(int argc, const char **argv, const char *prefix,
 		unsigned long size;
 		enum object_type type;
 		struct strbuf buf = STRBUF_INIT;
-		char *prev_buf = repo_read_object_file(the_repository, note, &type, &size);
+		char *prev_buf = odb_read_object(the_repository->objects, note, &type, &size);
 
 		if (!prev_buf)
 			die(_("unable to read %s"), oid_to_hex(note));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index da35d684081..580a5c1996b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -337,13 +337,13 @@ static void *get_delta(struct object_entry *entry)
 	void *buf, *base_buf, *delta_buf;
 	enum object_type type;
 
-	buf = repo_read_object_file(the_repository, &entry->idx.oid, &type,
-				    &size);
+	buf = odb_read_object(the_repository->objects, &entry->idx.oid,
+			      &type, &size);
 	if (!buf)
 		die(_("unable to read %s"), oid_to_hex(&entry->idx.oid));
-	base_buf = repo_read_object_file(the_repository,
-					 &DELTA(entry)->idx.oid, &type,
-					 &base_size);
+	base_buf = odb_read_object(the_repository->objects,
+				   &DELTA(entry)->idx.oid, &type,
+				   &base_size);
 	if (!base_buf)
 		die("unable to read %s",
 		    oid_to_hex(&DELTA(entry)->idx.oid));
@@ -506,9 +506,9 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 				       &size, NULL)) != NULL)
 			buf = NULL;
 		else {
-			buf = repo_read_object_file(the_repository,
-						    &entry->idx.oid, &type,
-						    &size);
+			buf = odb_read_object(the_repository->objects,
+					      &entry->idx.oid, &type,
+					      &size);
 			if (!buf)
 				die(_("unable to read %s"),
 				    oid_to_hex(&entry->idx.oid));
@@ -1895,7 +1895,7 @@ static struct pbase_tree_cache *pbase_tree_get(const struct object_id *oid)
 	/* Did not find one.  Either we got a bogus request or
 	 * we need to read and perhaps cache.
 	 */
-	data = repo_read_object_file(the_repository, oid, &type, &size);
+	data = odb_read_object(the_repository->objects, oid, &type, &size);
 	if (!data)
 		return NULL;
 	if (type != OBJ_TREE) {
@@ -2762,9 +2762,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	/* Load data if not already done */
 	if (!trg->data) {
 		packing_data_lock(&to_pack);
-		trg->data = repo_read_object_file(the_repository,
-						  &trg_entry->idx.oid, &type,
-						  &sz);
+		trg->data = odb_read_object(the_repository->objects,
+					    &trg_entry->idx.oid, &type,
+					    &sz);
 		packing_data_unlock(&to_pack);
 		if (!trg->data)
 			die(_("object %s cannot be read"),
@@ -2777,9 +2777,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 	if (!src->data) {
 		packing_data_lock(&to_pack);
-		src->data = repo_read_object_file(the_repository,
-						  &src_entry->idx.oid, &type,
-						  &sz);
+		src->data = odb_read_object(the_repository->objects,
+					    &src_entry->idx.oid, &type,
+					    &sz);
 		packing_data_unlock(&to_pack);
 		if (!src->data) {
 			if (src_entry->preferred_base) {
diff --git a/builtin/tag.c b/builtin/tag.c
index e0b27396c6b..46cbf892e34 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -244,7 +244,7 @@ static void write_tag_body(int fd, const struct object_id *oid)
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
 
-	orig = buf = repo_read_object_file(the_repository, oid, &type, &size);
+	orig = buf = odb_read_object(the_repository->objects, oid, &type, &size);
 	if (!buf)
 		return;
 	if (parse_signature(buf, size, &payload, &signature)) {
@@ -407,7 +407,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 		strbuf_addstr(sb, "object of unknown type");
 		break;
 	case OBJ_COMMIT:
-		if ((buf = repo_read_object_file(the_repository, oid, &type, &size))) {
+		if ((buf = odb_read_object(the_repository->objects, oid, &type, &size))) {
 			subject_len = find_commit_subject(buf, &subject_start);
 			strbuf_insert(sb, sb->len, subject_start, subject_len);
 		} else {
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index b92fd4710a9..4360872ae07 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -14,7 +14,7 @@ static char *create_temp_file(struct object_id *oid)
 	unsigned long size;
 	int fd;
 
-	buf = repo_read_object_file(the_repository, oid, &type, &size);
+	buf = odb_read_object(the_repository->objects, oid, &type, &size);
 	if (!buf || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(oid));
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 405e78bc592..4bc6575a574 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -516,8 +516,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	if (resolve_against_held(nr, &base_oid, delta_data, delta_size))
 		return;
 
-	base = repo_read_object_file(the_repository, &base_oid, &type,
-				     &base_size);
+	base = odb_read_object(the_repository->objects, &base_oid,
+			       &type, &base_size);
 	if (!base) {
 		error("failed to read delta-pack base object %s",
 		      oid_to_hex(&base_oid));
diff --git a/bundle.c b/bundle.c
index c67f85126da..66d0e8eaf0e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -305,7 +305,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	if (revs->max_age == -1 && revs->min_age == -1)
 		goto out;
 
-	buf = repo_read_object_file(the_repository, &tag->oid, &type, &size);
+	buf = odb_read_object(the_repository->objects, &tag->oid, &type, &size);
 	if (!buf)
 		goto out;
 	line = memmem(buf, size, "\ntagger ", 8);
diff --git a/combine-diff.c b/combine-diff.c
index cf23a753407..4ea2dc93c4f 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -325,7 +325,7 @@ static char *grab_blob(struct repository *r,
 		*size = fill_textconv(r, textconv, df, &blob);
 		free_filespec(df);
 	} else {
-		blob = repo_read_object_file(r, oid, &type, size);
+		blob = odb_read_object(r->objects, oid, &type, size);
 		if (!blob)
 			die(_("unable to read %s"), oid_to_hex(oid));
 		if (type != OBJ_BLOB)
diff --git a/commit.c b/commit.c
index d4aa9c7a5f8..28ee6b73ae6 100644
--- a/commit.c
+++ b/commit.c
@@ -374,7 +374,7 @@ const void *repo_get_commit_buffer(struct repository *r,
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
-		ret = repo_read_object_file(r, &commit->object.oid, &type, &size);
+		ret = odb_read_object(r->objects, &commit->object.oid, &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
 			    oid_to_hex(&commit->object.oid));
@@ -1275,8 +1275,8 @@ static void handle_signed_tag(const struct commit *parent, struct commit_extra_h
 	desc = merge_remote_util(parent);
 	if (!desc || !desc->obj)
 		return;
-	buf = repo_read_object_file(the_repository, &desc->obj->oid, &type,
-				    &size);
+	buf = odb_read_object(the_repository->objects, &desc->obj->oid,
+			      &type, &size);
 	if (!buf || type != OBJ_TAG)
 		goto free_return;
 	if (!parse_signature(buf, size, &payload, &signature))
diff --git a/config.c b/config.c
index 883dd066827..142c37215a8 100644
--- a/config.c
+++ b/config.c
@@ -1942,7 +1942,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	unsigned long size;
 	int ret;
 
-	buf = repo_read_object_file(repo, oid, &type, &size);
+	buf = odb_read_object(repo->objects, oid, &type, &size);
 	if (!buf)
 		return error(_("unable to load config blob object '%s'"), name);
 	if (type != OBJ_BLOB) {
diff --git a/dir.c b/dir.c
index e11342e1366..251dedf1f5e 100644
--- a/dir.c
+++ b/dir.c
@@ -302,7 +302,7 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 	*size_out = 0;
 	*data_out = NULL;
 
-	data = repo_read_object_file(the_repository, oid, &type, &sz);
+	data = odb_read_object(the_repository->objects, oid, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return -1;
diff --git a/entry.c b/entry.c
index 75d55038d7c..cae02eb5039 100644
--- a/entry.c
+++ b/entry.c
@@ -93,8 +93,8 @@ void *read_blob_entry(const struct cache_entry *ce, size_t *size)
 {
 	enum object_type type;
 	unsigned long ul;
-	void *blob_data = repo_read_object_file(the_repository, &ce->oid,
-						&type, &ul);
+	void *blob_data = odb_read_object(the_repository->objects, &ce->oid,
+					  &type, &ul);
 
 	*size = ul;
 	if (blob_data) {
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 1a8c972adf3..40174efa3de 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -526,8 +526,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		struct object_id *oid = origins.items[i].util;
 		enum object_type type;
 		unsigned long size;
-		char *buf = repo_read_object_file(the_repository, oid, &type,
-						  &size);
+		char *buf = odb_read_object(the_repository->objects, oid,
+					    &type, &size);
 		char *origbuf = buf;
 		unsigned long len = size;
 		struct signature_check sigc = { NULL };
diff --git a/fsck.c b/fsck.c
index e69baab3af7..23965e1880f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1293,7 +1293,7 @@ static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		if (oidset_contains(blobs_done, oid))
 			continue;
 
-		buf = repo_read_object_file(the_repository, oid, &type, &size);
+		buf = odb_read_object(the_repository->objects, oid, &type, &size);
 		if (!buf) {
 			if (is_promisor_object(the_repository, oid))
 				continue;
diff --git a/grep.c b/grep.c
index dc77e6c4631..932647e4a65 100644
--- a/grep.c
+++ b/grep.c
@@ -1931,8 +1931,8 @@ static int grep_source_load_oid(struct grep_source *gs)
 {
 	enum object_type type;
 
-	gs->buf = repo_read_object_file(gs->repo, gs->identifier, &type,
-					&gs->size);
+	gs->buf = odb_read_object(gs->repo->objects, gs->identifier,
+				  &type, &gs->size);
 	if (!gs->buf)
 		return error(_("'%s': unable to read %s"),
 			     gs->name,
diff --git a/http-push.c b/http-push.c
index d1b1bb23711..9481825abfb 100644
--- a/http-push.c
+++ b/http-push.c
@@ -369,8 +369,8 @@ static void start_put(struct transfer_request *request)
 	ssize_t size;
 	git_zstream stream;
 
-	unpacked = repo_read_object_file(the_repository, &request->obj->oid,
-					 &type, &len);
+	unpacked = odb_read_object(the_repository->objects, &request->obj->oid,
+				   &type, &len);
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 
 	/* Set it up */
diff --git a/mailmap.c b/mailmap.c
index b18e74c2110..56c72102d9e 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -196,7 +196,7 @@ int read_mailmap_blob(struct string_list *map, const char *name)
 	if (repo_get_oid(the_repository, name, &oid) < 0)
 		return 0;
 
-	buf = repo_read_object_file(the_repository, &oid, &type, &size);
+	buf = odb_read_object(the_repository->objects, &oid, &type, &size);
 	if (!buf)
 		return error("unable to read mailmap object at %s", name);
 	if (type != OBJ_BLOB) {
diff --git a/match-trees.c b/match-trees.c
index 4704f95c340..5a8a5c39b04 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -63,7 +63,7 @@ static void *fill_tree_desc_strict(struct repository *r,
 	enum object_type type;
 	unsigned long size;
 
-	buffer = repo_read_object_file(r, hash, &type, &size);
+	buffer = odb_read_object(r->objects, hash, &type, &size);
 	if (!buffer)
 		die("unable to read tree (%s)", oid_to_hex(hash));
 	if (type != OBJ_TREE)
@@ -199,7 +199,7 @@ static int splice_tree(struct repository *r,
 	if (*subpath)
 		subpath++;
 
-	buf = repo_read_object_file(r, oid1, &type, &sz);
+	buf = odb_read_object(r->objects, oid1, &type, &sz);
 	if (!buf)
 		die("cannot read tree %s", oid_to_hex(oid1));
 	init_tree_desc(&desc, oid1, buf, sz);
diff --git a/merge-blobs.c b/merge-blobs.c
index ba8a3fdfd82..6fc27994171 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -12,8 +12,8 @@ static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 	unsigned long size;
 	enum object_type type;
 
-	buf = repo_read_object_file(the_repository, &obj->object.oid, &type,
-				    &size);
+	buf = odb_read_object(the_repository->objects, &obj->object.oid,
+			      &type, &size);
 	if (!buf)
 		return -1;
 	if (type != OBJ_BLOB) {
@@ -79,8 +79,8 @@ void *merge_blobs(struct index_state *istate, const char *path,
 			return NULL;
 		if (!our)
 			our = their;
-		return repo_read_object_file(the_repository, &our->object.oid,
-					     &type, size);
+		return odb_read_object(the_repository->objects, &our->object.oid,
+				       &type, size);
 	}
 
 	if (fill_mmfile_blob(&f1, our) < 0)
diff --git a/merge-ort.c b/merge-ort.c
index 5d4501085e9..53417d399c7 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3624,7 +3624,7 @@ static int read_oid_strbuf(struct merge_options *opt,
 	void *buf;
 	enum object_type type;
 	unsigned long size;
-	buf = repo_read_object_file(the_repository, oid, &type, &size);
+	buf = odb_read_object(the_repository->objects, oid, &type, &size);
 	if (!buf) {
 		path_msg(opt, ERROR_OBJECT_READ_FAILED, 0,
 			 path, NULL, NULL, NULL,
diff --git a/notes-cache.c b/notes-cache.c
index 344f67762b8..dd56feed6e8 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -87,7 +87,7 @@ char *notes_cache_get(struct notes_cache *c, struct object_id *key_oid,
 	value_oid = get_note(&c->tree, key_oid);
 	if (!value_oid)
 		return NULL;
-	value = repo_read_object_file(the_repository, value_oid, &type, &size);
+	value = odb_read_object(the_repository->objects, value_oid, &type, &size);
 
 	*outsize = size;
 	return value;
diff --git a/notes-merge.c b/notes-merge.c
index de6a52e2e7f..586939939f2 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -340,7 +340,7 @@ static void write_note_to_worktree(const struct object_id *obj,
 {
 	enum object_type type;
 	unsigned long size;
-	void *buf = repo_read_object_file(the_repository, note, &type, &size);
+	void *buf = odb_read_object(the_repository->objects, note, &type, &size);
 
 	if (!buf)
 		die("cannot read note %s for object %s",
diff --git a/notes.c b/notes.c
index fc000e501d2..73eb5f00cf5 100644
--- a/notes.c
+++ b/notes.c
@@ -816,15 +816,15 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 
 	/* read in both note blob objects */
 	if (!is_null_oid(new_oid))
-		new_msg = repo_read_object_file(the_repository, new_oid,
-						&new_type, &new_len);
+		new_msg = odb_read_object(the_repository->objects, new_oid,
+					  &new_type, &new_len);
 	if (!new_msg || !new_len || new_type != OBJ_BLOB) {
 		free(new_msg);
 		return 0;
 	}
 	if (!is_null_oid(cur_oid))
-		cur_msg = repo_read_object_file(the_repository, cur_oid,
-						&cur_type, &cur_len);
+		cur_msg = odb_read_object(the_repository->objects, cur_oid,
+					  &cur_type, &cur_len);
 	if (!cur_msg || !cur_len || cur_type != OBJ_BLOB) {
 		free(cur_msg);
 		free(new_msg);
@@ -880,7 +880,7 @@ static int string_list_add_note_lines(struct string_list *list,
 		return 0;
 
 	/* read_sha1_file NUL-terminates */
-	data = repo_read_object_file(the_repository, oid, &t, &len);
+	data = odb_read_object(the_repository->objects, oid, &t, &len);
 	if (t != OBJ_BLOB || !data || !len) {
 		free(data);
 		return t != OBJ_BLOB || !data;
@@ -1290,7 +1290,8 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (!oid)
 		return;
 
-	if (!(msg = repo_read_object_file(the_repository, oid, &type, &msglen)) || type != OBJ_BLOB) {
+	if (!(msg = odb_read_object(the_repository->objects, oid, &type, &msglen)) ||
+	    type != OBJ_BLOB) {
 		free(msg);
 		return;
 	}
diff --git a/object.c b/object.c
index 868d89eed42..c1553ee4330 100644
--- a/object.c
+++ b/object.c
@@ -335,7 +335,7 @@ struct object *parse_object_with_flags(struct repository *r,
 		return &lookup_tree(r, oid)->object;
 	}
 
-	buffer = repo_read_object_file(r, oid, &type, &size);
+	buffer = odb_read_object(r->objects, oid, &type, &size);
 	if (buffer) {
 		if (!skip_hash &&
 		    check_object_signature(r, repl, buffer, size, type) < 0) {
diff --git a/odb.c b/odb.c
index 3d5d4ff8454..5202f107af2 100644
--- a/odb.c
+++ b/odb.c
@@ -30,7 +30,7 @@ KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 
 /*
  * This is meant to hold a *small* number of objects that you would
- * want repo_read_object_file() to be able to return, but yet you do not want
+ * want odb_read_object() to be able to return, but yet you do not want
  * to write them into the object store (e.g. a browse-only
  * application).
  */
@@ -896,15 +896,10 @@ int pretend_object_file(struct repository *repo,
 	return 0;
 }
 
-/*
- * This function dies on corrupt objects; the callers who want to
- * deal with them should arrange to call odb_read_object_info_extended() and give
- * error messages themselves.
- */
-void *repo_read_object_file(struct repository *r,
-			    const struct object_id *oid,
-			    enum object_type *type,
-			    unsigned long *size)
+void *odb_read_object(struct object_database *odb,
+		      const struct object_id *oid,
+		      enum object_type *type,
+		      unsigned long *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	unsigned flags = OBJECT_INFO_DIE_IF_CORRUPT | OBJECT_INFO_LOOKUP_REPLACE;
@@ -913,7 +908,7 @@ void *repo_read_object_file(struct repository *r,
 	oi.typep = type;
 	oi.sizep = size;
 	oi.contentp = &data;
-	if (odb_read_object_info_extended(r->objects, oid, &oi, flags))
+	if (odb_read_object_info_extended(odb, oid, &oi, flags))
 		return NULL;
 
 	return data;
@@ -935,7 +930,7 @@ void *read_object_with_reference(struct repository *r,
 		int ref_length = -1;
 		const char *ref_type = NULL;
 
-		buffer = repo_read_object_file(r, &actual_oid, &type, &isize);
+		buffer = odb_read_object(r->objects, &actual_oid, &type, &isize);
 		if (!buffer)
 			return NULL;
 		if (type == required_type) {
diff --git a/odb.h b/odb.h
index d75a5f9d44b..e4a3763914a 100644
--- a/odb.h
+++ b/odb.h
@@ -130,7 +130,7 @@ struct object_database {
 
 	/*
 	 * This is meant to hold a *small* number of objects that you would
-	 * want repo_read_object_file() to be able to return, but yet you do not want
+	 * want odb_read_object() to be able to return, but yet you do not want
 	 * to write them into the object store (e.g. a browse-only
 	 * application).
 	 */
@@ -249,10 +249,19 @@ void odb_add_to_alternates_file(struct object_database *odb,
 void odb_add_to_alternates_memory(struct object_database *odb,
 				  const char *dir);
 
-void *repo_read_object_file(struct repository *r,
-			    const struct object_id *oid,
-			    enum object_type *type,
-			    unsigned long *size);
+/*
+ * Read an object from the database. Returns the object data and assigns object
+ * type and size to the `type` and `size` pointers, if these pointers are
+ * non-NULL. Returns a `NULL` pointer in case the object does not exist.
+ *
+ * This function dies on corrupt objects; the callers who want to deal with
+ * them should arrange to call odb_read_object_info_extended() and give error
+ * messages themselves.
+ */
+void *odb_read_object(struct object_database *odb,
+		      const struct object_id *oid,
+		      enum object_type *type,
+		      unsigned long *size);
 
 /*
  * Add an object file to the in-memory object store, without writing it
@@ -363,7 +372,7 @@ void odb_assert_oid_type(struct object_database *odb,
 
 /*
  * Enabling the object read lock allows multiple threads to safely call the
- * following functions in parallel: repo_read_object_file(),
+ * following functions in parallel: odb_read_object(),
  * read_object_with_reference(), odb_read_object_info() and odb().
  *
  * obj_read_lock() and obj_read_unlock() may also be used to protect other
@@ -438,4 +447,12 @@ static inline int oid_object_info(struct repository *r,
 	return odb_read_object_info(r->objects, oid, sizep);
 }
 
+static inline void *repo_read_object_file(struct repository *r,
+					  const struct object_id *oid,
+					  enum object_type *type,
+					  unsigned long *size)
+{
+	return odb_read_object(r->objects, oid, type, size);
+}
+
 #endif /* ODB_H */
diff --git a/read-cache.c b/read-cache.c
index be664f857b4..46986798a38 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -254,7 +254,7 @@ static int ce_compare_link(const struct cache_entry *ce, size_t expected_size)
 	if (strbuf_readlink(&sb, ce->name, expected_size))
 		return -1;
 
-	buffer = repo_read_object_file(the_repository, &ce->oid, &type, &size);
+	buffer = odb_read_object(the_repository->objects, &ce->oid, &type, &size);
 	if (buffer) {
 		if (size == sb.len)
 			match = memcmp(buffer, sb.buf, size);
@@ -3514,8 +3514,8 @@ void *read_blob_data_from_index(struct index_state *istate,
 	}
 	if (pos < 0)
 		return NULL;
-	data = repo_read_object_file(the_repository, &istate->cache[pos]->oid,
-				     &type, &sz);
+	data = odb_read_object(the_repository->objects, &istate->cache[pos]->oid,
+			       &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
diff --git a/reflog.c b/reflog.c
index 4f8a3b717cd..747b82eada8 100644
--- a/reflog.c
+++ b/reflog.c
@@ -140,8 +140,8 @@ static int tree_is_complete(const struct object_id *oid)
 	if (!tree->buffer) {
 		enum object_type type;
 		unsigned long size;
-		void *data = repo_read_object_file(the_repository, oid, &type,
-						   &size);
+		void *data = odb_read_object(the_repository->objects, oid,
+					     &type, &size);
 		if (!data) {
 			tree->object.flags |= INCOMPLETE;
 			return 0;
diff --git a/rerere.c b/rerere.c
index 951e4bf8b41..8bb97c98229 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1000,9 +1000,8 @@ static int handle_cache(struct index_state *istate,
 			break;
 		i = ce_stage(ce) - 1;
 		if (!mmfile[i].ptr) {
-			mmfile[i].ptr = repo_read_object_file(the_repository,
-							      &ce->oid, &type,
-							      &size);
+			mmfile[i].ptr = odb_read_object(the_repository->objects,
+							&ce->oid, &type, &size);
 			if (!mmfile[i].ptr)
 				die(_("unable to read %s"),
 				    oid_to_hex(&ce->oid));
diff --git a/submodule-config.c b/submodule-config.c
index 0f775f93259..2730a47fad1 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -743,8 +743,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	if (submodule)
 		goto out;
 
-	config = repo_read_object_file(the_repository, &oid, &type,
-				       &config_size);
+	config = odb_read_object(the_repository->objects, &oid,
+				 &type, &config_size);
 	if (!config || type != OBJ_BLOB)
 		goto out;
 
diff --git a/tag.c b/tag.c
index 144048fd5e0..1d52686ee10 100644
--- a/tag.c
+++ b/tag.c
@@ -60,7 +60,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 				repo_find_unique_abbrev(the_repository, oid, DEFAULT_ABBREV),
 				type_name(type));
 
-	buf = repo_read_object_file(the_repository, oid, &type, &size);
+	buf = odb_read_object(the_repository->objects, oid, &type, &size);
 	if (!buf)
 		return error("%s: unable to read file.",
 				name_to_report ?
@@ -222,8 +222,8 @@ int parse_tag(struct tag *item)
 
 	if (item->object.parsed)
 		return 0;
-	data = repo_read_object_file(the_repository, &item->object.oid, &type,
-				     &size);
+	data = odb_read_object(the_repository->objects, &item->object.oid,
+			       &type, &size);
 	if (!data)
 		return error("Could not read %s",
 			     oid_to_hex(&item->object.oid));
diff --git a/tree-walk.c b/tree-walk.c
index 34b0fff4873..766af99f466 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -795,9 +795,9 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 			 */
 			retval = DANGLING_SYMLINK;
 
-			contents = repo_read_object_file(r,
-						    &current_tree_oid, &type,
-						    &link_len);
+			contents = odb_read_object(r->objects,
+						   &current_tree_oid, &type,
+						   &link_len);
 
 			if (!contents)
 				goto done;
diff --git a/tree.c b/tree.c
index 341b7c2ff3f..1ef743d90f4 100644
--- a/tree.c
+++ b/tree.c
@@ -193,8 +193,8 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 
 	if (item->object.parsed)
 		return 0;
-	buffer = repo_read_object_file(the_repository, &item->object.oid,
-				       &type, &size);
+	buffer = odb_read_object(the_repository->objects, &item->object.oid,
+				 &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 01e6e378ea6..0e5d38c9600 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -187,7 +187,7 @@ void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 		return;
 	}
 
-	ptr->ptr = repo_read_object_file(the_repository, oid, &type, &size);
+	ptr->ptr = odb_read_object(the_repository->objects, oid, &type, &size);
 	if (!ptr->ptr || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(oid));
 	ptr->size = size;

-- 
2.49.0.1077.gc0e912fd4c.dirty

