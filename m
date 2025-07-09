Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD12D320B
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059883; cv=none; b=L04ePP/6ziYBjn6iE4e03vyN2715LanMJasV0WZc+Y6yj06Z8SkyUxPtQfdsy3WUB8ORna93sHl5pGiG+guOTfyk0hf9Pfs+IHIXttJHidLCjpigEi8hTLuQqBws02DA14bmb1SWIalrexH5p5rWRGUowFxgzs7h2fpngiQeRII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059883; c=relaxed/simple;
	bh=cUYJDI8F6IzMh3NwhGzwGkT8ksZZtC2y8KwEpPBvuSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ouk6XMSZDgDUDHEf8Usckzfuqi+TNUlEH5USzONL2pZw2KytBzwVW5xNUm740D+DHxsqo0/8UPmLBP0PWkJxV5MVUsb6cSYnF+z6fC5eUQ3feG2WRSlUb4PPSSvAPIy8g3sTox++UZGfZ7szCtX56KrTuAMxv0flk/Z7bzgK5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nPu9lzCd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jDeHhLH3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nPu9lzCd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDeHhLH3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A9774EC04B6
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 09 Jul 2025 07:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059879;
	 x=1752146279; bh=ARy30gU/q09QySD7WXcUdT9QT9wMoxDZhuRBDH9kQYk=; b=
	nPu9lzCdKki2iBbop8jQzEpfcN+dn/VBQxkcpsHc6BZ93DMdJAGLtVl3TI1EH/g3
	aSKBTv8NX2Lz86lxxgAOlctXAgB6e0eMxQmGWw8PV1ha3LVxxIMQA9/4Rsa0VFI6
	pTNxoDWaVsY+QeJ1MCWpnLmrWOJuVrWOC8iB4ucTLXyTcPxL7AVo4P7grB2l3BmA
	wOkrgG+ZNGEFl8EER/Yy5JjdmUa1WXrN4HAArfa2PdRhAh3nF9WpNxlJ0Vx8Wg2I
	1lZJ/NjXjs5GLBQvJrdXVY5siizjHyk1vTwzfj4jSs/e3q3acRDef11eAjq/MeYW
	GPEniu/PD02qJ68/ZzAMpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059879; x=
	1752146279; bh=ARy30gU/q09QySD7WXcUdT9QT9wMoxDZhuRBDH9kQYk=; b=j
	DeHhLH37ghngYEMSwu2SVW2yDCh/zpgIfWWXm0/oCGNx3j0LM2H8iwvbcK1jsmva
	bYQBSA2i6BQrSn/rEEfX6Jpm6e0EsSh1Z9GhxcUCsvzCVKBaxbNUNhNQyWyFtCVw
	DAHISTcFp0UoRLiH0DKSqLM57ik1d9/ZxKjRM3MHf5KP/I+C6/2pQwOvEM8RI4h+
	fwKPSK5uAop9cJuLMZRXeGLt1Fc02hCyOmVuF1DTYWijZ3zOH8I4bGlVqQMVlyNY
	nk1PWbnpEqtU5HjaFSMzEhe/hftapWh/X/LZM4uvmYg0buB5yrFw42ifY45xJrcZ
	Jj/0OZjdp5natMJELtSww==
X-ME-Sender: <xms:509uaKSxhmGtB4Wq8oqkla8c7OxXc8eljTb4j0eEiCRZSRnQGCqq8w>
    <xme:509uaBxmRQFEjrhGx9ShojKiKS8-UvIuWIkGovlAHnP2e1phF3PEpK4bOeZ-sGGxp
    gEZc-ad5sQRFeT68Q>
X-ME-Received: <xmr:509uaBMjj7aBKVNpimoqaVwlxifjrTkjTbh-Duoy1JX39YWzElizRsDvzyvW-gfklYo3uNy0opogcqVafC9GacpqQVPE0phEQbiaoF02PATEVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:509uaIP2HcWQuEQ4H4_-Q5kFhVcn6Q8E9Ct0mhL0gz7xeReiMT-rdw>
    <xmx:509uaLSUqnVnpZnZOQz7vzV5pzKGrO7IY9B46sOq0FGBZUzc2Qszjg>
    <xmx:509uaCASKphluZO4pscaayPaUB8VJV3LLsmX-aiGTf_KsfqHYhwARg>
    <xmx:509uaCgXRuS9kr4kvOYHhFNrHkYE7ff1Pt3tzaijeA6P-Mcr2Xg65g>
    <xmx:509uaDLCD-69_JBtO4UvJZEkd6C-vQYXBw4XVDw-AuP_r5gCT9i-eVWZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8907d39d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:23 +0200
Subject: [PATCH 13/19] object-file: get rid of `the_repository` in loose
 object iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-13-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The iterators for loose objects still rely on `the_repository`. Refactor
them:

  - `for_each_loose_file_in_objdir()` is refactored so that the caller
    is now expected to pass an `odb_source` as parameter instead of the
    path to that source. Furthermore, it is renamed accordingly to
    `for_each_loose_file_in_source()`.

  - `for_each_loose_object()` is refactored to take in an object
    database now and calls the above function in a loop.

This allows us to get rid of the global dependency.

Adjust callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c      |  2 +-
 builtin/count-objects.c |  2 +-
 builtin/fsck.c          | 14 ++++++++------
 builtin/gc.c            | 10 ++++------
 builtin/pack-objects.c  |  5 ++---
 builtin/prune.c         |  2 +-
 object-file.c           | 18 +++++++++---------
 object-file.h           |  5 +++--
 prune-packed.c          |  2 +-
 reachable.c             |  2 +-
 10 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2492a0b6f39..aa1498aa60f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -848,7 +848,7 @@ static void batch_each_object(struct batch_options *opt,
 	};
 	struct bitmap_index *bitmap = prepare_bitmap_git(the_repository);
 
-	for_each_loose_object(batch_one_object_loose, &payload, 0);
+	for_each_loose_object(the_repository->objects, batch_one_object_loose, &payload, 0);
 
 	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
 						 batch_one_object_bitmapped, &payload)) {
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index f687647931e..e70a01c628e 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -117,7 +117,7 @@ int cmd_count_objects(int argc,
 		report_linked_checkout_garbage(the_repository);
 	}
 
-	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
+	for_each_loose_file_in_source(the_repository->objects->sources,
 				      count_loose, count_cruft, NULL, NULL);
 
 	if (verbose) {
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0084cf7400b..f0854ce5d84 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -393,7 +393,8 @@ static void check_connectivity(void)
 		 * and ignore any that weren't present in our earlier
 		 * traversal.
 		 */
-		for_each_loose_object(mark_loose_unreachable_referents, NULL, 0);
+		for_each_loose_object(the_repository->objects,
+				      mark_loose_unreachable_referents, NULL, 0);
 		for_each_packed_object(the_repository,
 				       mark_packed_unreachable_referents,
 				       NULL,
@@ -687,7 +688,7 @@ static int fsck_subdir(unsigned int nr, const char *path UNUSED, void *data)
 	return 0;
 }
 
-static void fsck_object_dir(const char *path)
+static void fsck_source(struct odb_source *source)
 {
 	struct progress *progress = NULL;
 	struct for_each_loose_cb cb_data = {
@@ -701,8 +702,8 @@ static void fsck_object_dir(const char *path)
 		progress = start_progress(the_repository,
 					  _("Checking object directories"), 256);
 
-	for_each_loose_file_in_objdir(path, fsck_loose, fsck_cruft, fsck_subdir,
-				      &cb_data);
+	for_each_loose_file_in_source(source, fsck_loose,
+				      fsck_cruft, fsck_subdir, &cb_data);
 	display_progress(progress, 256);
 	stop_progress(&progress);
 }
@@ -994,13 +995,14 @@ int cmd_fsck(int argc,
 		fsck_refs(the_repository);
 
 	if (connectivity_only) {
-		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
+		for_each_loose_object(the_repository->objects,
+				      mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(the_repository,
 				       mark_packed_for_connectivity, NULL, 0);
 	} else {
 		odb_prepare_alternates(the_repository->objects);
 		for (source = the_repository->objects->sources; source; source = source->next)
-			fsck_object_dir(source->path);
+			fsck_source(source);
 
 		if (check_full) {
 			struct packed_git *p;
diff --git a/builtin/gc.c b/builtin/gc.c
index 21bd44e1645..6eefefc63d2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1301,7 +1301,7 @@ static int loose_object_auto_condition(struct gc_config *cfg UNUSED)
 	if (loose_object_auto_limit < 0)
 		return 1;
 
-	return for_each_loose_file_in_objdir(the_repository->objects->sources->path,
+	return for_each_loose_file_in_source(the_repository->objects->sources,
 					     loose_object_count,
 					     NULL, NULL, &count);
 }
@@ -1336,7 +1336,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	 * Do not start pack-objects process
 	 * if there are no loose objects.
 	 */
-	if (!for_each_loose_file_in_objdir(r->objects->sources->path,
+	if (!for_each_loose_file_in_source(r->objects->sources,
 					   bail_on_loose,
 					   NULL, NULL, NULL))
 		return 0;
@@ -1376,11 +1376,9 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	else if (data.batch_size > 0)
 		data.batch_size--; /* Decrease for equality on limit. */
 
-	for_each_loose_file_in_objdir(r->objects->sources->path,
+	for_each_loose_file_in_source(r->objects->sources,
 				      write_loose_object_to_stdin,
-				      NULL,
-				      NULL,
-				      &data);
+				      NULL, NULL, &data);
 
 	fclose(data.in);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e8e85d8278b..9e85293730b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4342,9 +4342,8 @@ static int add_loose_object(const struct object_id *oid, const char *path,
  */
 static void add_unreachable_loose_objects(void)
 {
-	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
-				      add_loose_object,
-				      NULL, NULL, NULL);
+	for_each_loose_file_in_source(the_repository->objects->sources,
+				      add_loose_object, NULL, NULL, NULL);
 }
 
 static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
diff --git a/builtin/prune.c b/builtin/prune.c
index 339017c7ccf..bf5d3bb152c 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -200,7 +200,7 @@ int cmd_prune(int argc,
 		revs.exclude_promisor_objects = 1;
 	}
 
-	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
+	for_each_loose_file_in_source(the_repository->objects->sources,
 				      prune_object, prune_cruft, prune_subdir, &revs);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
diff --git a/object-file.c b/object-file.c
index bd93f17dcfe..b894379d22c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1388,7 +1388,7 @@ static int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	return r;
 }
 
-int for_each_loose_file_in_objdir(const char *path,
+int for_each_loose_file_in_source(struct odb_source *source,
 				  each_loose_object_fn obj_cb,
 				  each_loose_cruft_fn cruft_cb,
 				  each_loose_subdir_fn subdir_cb,
@@ -1397,11 +1397,10 @@ int for_each_loose_file_in_objdir(const char *path,
 	struct strbuf buf = STRBUF_INIT;
 	int r;
 
-	strbuf_addstr(&buf, path);
+	strbuf_addstr(&buf, source->path);
 	for (int i = 0; i < 256; i++) {
-		r = for_each_file_in_obj_subdir(i, &buf, the_repository->hash_algo,
-						obj_cb, cruft_cb,
-						subdir_cb, data);
+		r = for_each_file_in_obj_subdir(i, &buf, source->odb->repo->hash_algo,
+						obj_cb, cruft_cb, subdir_cb, data);
 		if (r)
 			break;
 	}
@@ -1410,14 +1409,15 @@ int for_each_loose_file_in_objdir(const char *path,
 	return r;
 }
 
-int for_each_loose_object(each_loose_object_fn cb, void *data,
+int for_each_loose_object(struct object_database *odb,
+			  each_loose_object_fn cb, void *data,
 			  enum for_each_object_flags flags)
 {
 	struct odb_source *source;
 
-	odb_prepare_alternates(the_repository->objects);
-	for (source = the_repository->objects->sources; source; source = source->next) {
-		int r = for_each_loose_file_in_objdir(source->path, cb, NULL,
+	odb_prepare_alternates(odb);
+	for (source = odb->sources; source; source = source->next) {
+		int r = for_each_loose_file_in_source(source, cb, NULL,
 						      NULL, data);
 		if (r)
 			return r;
diff --git a/object-file.h b/object-file.h
index d52b335e85b..1b1ab95423d 100644
--- a/object-file.h
+++ b/object-file.h
@@ -86,7 +86,7 @@ typedef int each_loose_cruft_fn(const char *basename,
 typedef int each_loose_subdir_fn(unsigned int nr,
 				 const char *path,
 				 void *data);
-int for_each_loose_file_in_objdir(const char *path,
+int for_each_loose_file_in_source(struct odb_source *source,
 				  each_loose_object_fn obj_cb,
 				  each_loose_cruft_fn cruft_cb,
 				  each_loose_subdir_fn subdir_cb,
@@ -99,7 +99,8 @@ int for_each_loose_file_in_objdir(const char *path,
  *
  * Any flags specific to packs are ignored.
  */
-int for_each_loose_object(each_loose_object_fn, void *,
+int for_each_loose_object(struct object_database *odb,
+			  each_loose_object_fn, void *,
 			  enum for_each_object_flags flags);
 
 
diff --git a/prune-packed.c b/prune-packed.c
index 92fb4fbb0ed..d49dc11957c 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -40,7 +40,7 @@ void prune_packed_objects(int opts)
 		progress = start_delayed_progress(the_repository,
 						  _("Removing duplicate objects"), 256);
 
-	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
+	for_each_loose_file_in_source(the_repository->objects->sources,
 				      prune_object, NULL, prune_subdir, &opts);
 
 	/* Ensure we show 100% before finishing progress */
diff --git a/reachable.c b/reachable.c
index e984b68a0c4..5706ccaede3 100644
--- a/reachable.c
+++ b/reachable.c
@@ -319,7 +319,7 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 	oidset_init(&data.extra_recent_oids, 0);
 	data.extra_recent_oids_loaded = 0;
 
-	r = for_each_loose_object(add_recent_loose, &data,
+	r = for_each_loose_object(the_repository->objects, add_recent_loose, &data,
 				  FOR_EACH_OBJECT_LOCAL_ONLY);
 	if (r)
 		goto done;

-- 
2.50.1.327.g047016eb4a.dirty

