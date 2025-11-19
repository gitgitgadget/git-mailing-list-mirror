Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573432938E
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538671; cv=none; b=KtNjhnLeZtM8pHkPlmyS6RKzZ9gqX+Ecf8S538G7YvMUbZwV7YZJ/J71sp6Uq+PVBz+dwrhBYQWUXtrhCxJueIHP661EOymjL2a0D93wneRe00Hh97iRM954ugpkci1KfvCQ70WTLeK1Bbgd165fuxxmxNxhkz3Vrv6Qg45rBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538671; c=relaxed/simple;
	bh=HP/X7kGB+PP0mLuNztfmRu8hqJnzmuJttwliyxECaEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6udLtRfscm5saUTrSnKBNbiDEUch121ztA4/7bDL/10M6blWTxS4JbtlzEcDppxW9sT9MwZUWJjA/NChLUUhy4qVlPQP7BBMWWgMlMNrcblFCjcO/Shmds/goobDFKR43PU0bdu1X5grilfyehBZjfWKM3Y/Ul/+krXIs0HMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MhF69wP8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bzj1bd+/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MhF69wP8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bzj1bd+/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A1FD4EC00A5
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 02:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538668;
	 x=1763625068; bh=B3zXhNHkziCii2nnCMxv0wy/IXXAiS75jtsZgv2N82c=; b=
	MhF69wP8j+AaYPUIJPDurKssVhcsn3h9aRfBFkZNa59NjVI/Tf1cuqk2NstGVgth
	rnx3X3mpIEcL2cXqznutXhSlCcJO8oLTNZmsFdBdartM6cWPsbz60BAWLe8C//r2
	rHF83EQMwjH6VE+67a1p5sO5OdNzCElOh9OuXrmcOz/VCqxxQ2JEwAmmM0pTIZZz
	18MvTo1e7L02PbIXOE+4LqJbVKWV8rEcaxdTR3TML0RqWzfz1Nr40LjPtjwmOdOE
	ESToPwQo1zgvaMk2ffFLHjFUBxI1Za1cu+j2w6qLlUrlFbSt1sT4/4YIjhMejl8K
	me+qR808/0rXjDIclIwrwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538668; x=
	1763625068; bh=B3zXhNHkziCii2nnCMxv0wy/IXXAiS75jtsZgv2N82c=; b=b
	zj1bd+/1HMnXYlvyFS72lEOlIzyiFSFw35ZUm48TyYKp7vEi0UoQvuMrQCTM7LJP
	MLlPmQEv/RPAUQ7AhMEJ9E7LMfHjw/fKMRnLXixPkS1h8MncIOBd2FMy6bX0BVfY
	W+tnhs/aLZXCtJWFacBYoXXFrDZkxFLKtqf917Qe0cCErFDDYrDuRplhTGL95u5C
	hiicwBHckCfNEbwQg/PDuSej/P4L1UP1yN6wx9FnJL68e4oUtdJ7KcEoZAacrGdl
	5Vno+GIovSKKoGkbJmqD9U3/yJ6pMjBNZqEm14gHrJxwb9gCDKZ0aM4JprjbUbm2
	xJUDbe8OkJaQ+FdAcPjHg==
X-ME-Sender: <xms:7HYdaYpS0r6zjIa_bn7Fl2m2tLkbiLp8Ih_jjwx60k3XB7o5DCmnlg>
    <xme:7HYdaVk1jZ_gDTjMXV_Ts6KJTUSp20GlVKi-17Med_QNB4r9rWbqtE2ZHUz2jNjJn
    mThRrjsX1NEujumH19tUkqVlUScmLgY7zMbTzVFK4DC51qxs1-kvg>
X-ME-Received: <xmr:7HYdaS0YPKVYluFMICJ8QNfeDEy2S8PxdbUm5WLJsKqVOTXU7TqXRryw3Hs2lZKUTnv7Ag_DQA21OumWuNC_p4mWQ6FrHVWWnih2wNCtzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:7HYdaVA6QBDlEte5MKNukfboVAYl-GneGv0y6KuSHctx05JGTCFcOg>
    <xmx:7HYdaXypoWIFWXHvD_XLNuipO3Fxbnl_DQ70vLeuK_c8uxMMO730Lg>
    <xmx:7HYdabl-FcVIk3Y6QYAO4JoZPXxohCdL6Cy7LocN8EqWlM1bBZVUsg>
    <xmx:7HYdaUE0jIlSb3MCrHn1C6cjRAbZ-e_Q1RsA8VMOvkvBUo-5MZZJKQ>
    <xmx:7HYdacK9925-0HvCR46ZVy_ONEuAADLmtCnEH5ZFZM7b8sU0J-dcMu8w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6567cb34 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:50:51 +0100
Subject: [PATCH 03/13] odb: adopt logic to close object databases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-3-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The logic to close an object database is currently contained in the
packfile subsystem. That choice is somewhat relatable, as most of the
logic really is to close resources associated with the packfile store
itself. But we also end up handling object sources and commit graphs,
which certainly is not related to packfiles.

Move the function into the object database subsystem and rename it to
`odb_close()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c  |  2 +-
 builtin/gc.c     |  2 +-
 builtin/repack.c |  2 +-
 midx-write.c     |  2 +-
 odb.c            | 18 +++++++++++++++++-
 odb.h            |  7 +++++++
 packfile.c       | 15 ---------------
 packfile.h       |  1 -
 run-command.c    |  2 +-
 scalar.c         |  2 +-
 10 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c990f398ef..b19b302b06 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1617,7 +1617,7 @@ int cmd_clone(int argc,
 	transport_disconnect(transport);
 
 	if (option_dissociate) {
-		close_object_store(the_repository->objects);
+		odb_close(the_repository->objects);
 		dissociate_from_references();
 	}
 
diff --git a/builtin/gc.c b/builtin/gc.c
index d212cbb9b8..961fa343c4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1048,7 +1048,7 @@ int cmd_gc(int argc,
 	report_garbage = report_pack_garbage;
 	odb_reprepare(the_repository->objects);
 	if (pack_garbage.nr > 0) {
-		close_object_store(the_repository->objects);
+		odb_close(the_repository->objects);
 		clean_pack_garbage();
 	}
 
diff --git a/builtin/repack.c b/builtin/repack.c
index cfdb4c0920..d9012141f6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -488,7 +488,7 @@ int cmd_repack(int argc,
 
 	string_list_sort(&names);
 
-	close_object_store(repo->objects);
+	odb_close(repo->objects);
 
 	/*
 	 * Ok we have prepared all new packfiles.
diff --git a/midx-write.c b/midx-write.c
index c73010df6d..60497586fd 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1459,7 +1459,7 @@ static int write_midx_internal(struct odb_source *source,
 	}
 
 	if (ctx.m || ctx.base_midx)
-		close_object_store(ctx.repo->objects);
+		odb_close(ctx.repo->objects);
 
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
diff --git a/odb.c b/odb.c
index 3ec21ef24e..bcefa5cede 100644
--- a/odb.c
+++ b/odb.c
@@ -9,6 +9,7 @@
 #include "khash.h"
 #include "lockfile.h"
 #include "loose.h"
+#include "midx.h"
 #include "object-file-convert.h"
 #include "object-file.h"
 #include "odb.h"
@@ -1044,6 +1045,21 @@ struct object_database *odb_new(struct repository *repo)
 	return o;
 }
 
+void odb_close(struct object_database *o)
+{
+	struct odb_source *source;
+
+	packfile_store_close(o->packfiles);
+
+	for (source = o->sources; source; source = source->next) {
+		if (source->midx)
+			close_midx(source->midx);
+		source->midx = NULL;
+	}
+
+	close_commit_graph(o);
+}
+
 static void odb_free_sources(struct object_database *o)
 {
 	while (o->sources) {
@@ -1076,7 +1092,7 @@ void odb_clear(struct object_database *o)
 		free((char *) o->cached_objects[i].value.buf);
 	FREE_AND_NULL(o->cached_objects);
 
-	close_object_store(o);
+	odb_close(o);
 	packfile_store_free(o->packfiles);
 	o->packfiles = NULL;
 
diff --git a/odb.h b/odb.h
index 9bb28008b1..71b4897c82 100644
--- a/odb.h
+++ b/odb.h
@@ -169,6 +169,13 @@ struct object_database {
 struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
+/*
+ * Close the object database and all of its sources so that any held resources
+ * will be released. The database can still be used after closing it, in which
+ * case these resources may be reallocated.
+ */
+void odb_close(struct object_database *o);
+
 /*
  * Clear caches, reload alternates and then reload object sources so that new
  * objects may become accessible.
diff --git a/packfile.c b/packfile.c
index 40f733dd23..af71eaf7e3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -359,21 +359,6 @@ void close_pack(struct packed_git *p)
 	oidset_clear(&p->bad_objects);
 }
 
-void close_object_store(struct object_database *o)
-{
-	struct odb_source *source;
-
-	packfile_store_close(o->packfiles);
-
-	for (source = o->sources; source; source = source->next) {
-		if (source->midx)
-			close_midx(source->midx);
-		source->midx = NULL;
-	}
-
-	close_commit_graph(o);
-}
-
 void unlink_pack_path(const char *pack_name, int force_delete)
 {
 	static const char *exts[] = {".idx", ".pack", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};
diff --git a/packfile.h b/packfile.h
index 58fcc88e20..d9226a072a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -279,7 +279,6 @@ struct object_database;
 unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 void close_pack_windows(struct packed_git *);
 void close_pack(struct packed_git *);
-void close_object_store(struct object_database *o);
 void unuse_pack(struct pack_window **);
 void clear_delta_base_cache(void);
 struct packed_git *add_packed_git(struct repository *r, const char *path,
diff --git a/run-command.c b/run-command.c
index ed9575bd6a..e3e02475cc 100644
--- a/run-command.c
+++ b/run-command.c
@@ -743,7 +743,7 @@ int start_command(struct child_process *cmd)
 	fflush(NULL);
 
 	if (cmd->close_object_store)
-		close_object_store(the_repository->objects);
+		odb_close(the_repository->objects);
 
 #ifndef GIT_WINDOWS_NATIVE
 {
diff --git a/scalar.c b/scalar.c
index f754311627..2aeb191cc8 100644
--- a/scalar.c
+++ b/scalar.c
@@ -931,7 +931,7 @@ static int cmd_delete(int argc, const char **argv)
 	if (dir_inside_of(cwd, enlistment.buf) >= 0)
 		res = error(_("refusing to delete current working directory"));
 	else {
-		close_object_store(the_repository->objects);
+		odb_close(the_repository->objects);
 		res = delete_enlistment(&enlistment);
 	}
 	strbuf_release(&enlistment);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

