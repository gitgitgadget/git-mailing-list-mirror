Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8A47532A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935750; cv=none; b=f+rE/w+e/y4/Uc+mmiIdcUcyDqqTIM3GeCGce/jpIv5a7sXF0NCU7mEVob0y6lkCoxma/aAhDXbgZX8TS4VDLKNPHtenkEoFee9ekf8XhRaH6IyarsGQyBYYajnfEPMOzKEDSilMmIHCFQesSvq4jnxa/OBM6wDm3azlj3PEW+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935750; c=relaxed/simple;
	bh=fIHCpIIsJAq0/2typ72DqddprGazEAm07/F+z+PlgIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrAZlcx+ArrLKIqIRgCXRpc/6qvsbzqW57guFlCfNn9VbaxaBA5ZrKJEtty9/EsXYAVx38ULBLLnntSE5XTKx36ql4vXTDK5oVz2wVA+JBeYYz/QGsFSrmxYVbfvUeW7hiTMySKP8+kejXWdhHGYPRGxY0MwHYDnWTt/iQPOanw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EL2voH6E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZuKcMWv; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EL2voH6E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZuKcMWv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F12C5EC008A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 06:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935739;
	 x=1791022139; bh=zp8R6S0NW93amo92iv7WDsC/kGT+D7q5wldk4gkdErU=; b=
	EL2voH6E7szeby4Gi1NQgmmU7dRTvJB/pTAgTJ4qU/hF5bnhuVMB/OlWASXxceRT
	xX0GIfwwVFbtBw+djLBlEYEuUWyyZLq8Kj4Tdu1bP/fZxKT12ejcK6xWfVScpzQ7
	TuRpcZNdArHQbzu17YjkWUyHk5mLN5YpDzXYghewGSEQEt6S4v34/uMbNzdSetDW
	9M7dy1IKVq4gmpxJGhqOvqmGmi10T28QQBUKu/EVJQgvYY1GjEiWHMiilgXRAmJN
	f2CPw6NYJ2DxqR4sTKma40/DumekX2rJQE3rviS2Is6RK1fF9PUQAslCX6rMDeRv
	PXBtC/bfnEghZ63ZhuLTaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935739; x=
	1791022139; bh=zp8R6S0NW93amo92iv7WDsC/kGT+D7q5wldk4gkdErU=; b=B
	ZuKcMWv3t12LlNCkyiMrLTTT/HOOuP5hkxuO2GSivPRnDR/wHZXbJo8IS6tqTCyx
	hoZ8WXtGPeQXlYWHsRl+GCF7UY8077LMhO7wtxhH7MOdBDmVdm228NW39gH3PTVd
	I2zE2nG5qMRV9GzMNUQGkmcYVSUZgyV/HjuPto10mEt9hMkx1R42ZC7713CnGgiC
	T4NZpmzGAS6KKl6WEb4SACPNCW6fogc8aChdnOcDlAiX0fOYoJBLhPHg4RfajIsi
	iZk2AmcjLXE/7JOC4Sm3VOtsm6A47S4qA4+abJ5pEwm25wL2q+jzHCk91255zj8i
	dHEROZZpaiWSI+WPfI9Eg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935739; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:n09smEnhxKTsXs+FYpqPt/xGIu0m5tRNI/DbDvPjUF/chFR
	vVS8DSuRqCx11XQXdeNwc+Ph+MzWYreUZEXmULvPVoyAsqHnHuSYICX6zzMDKUxt
	SMEo8LxEBQ3ZT08unpkZWt6lir2E6FHOVxYYWRBNxuALKcf3wmpZXBUAPE4abb2H
	9xKbfoX9e3f6KYG3uPy40L57qFtiAU2kGkiSG66Edu8mmcJyetBt6cn3plvZoSj0
	hIBgYYPzDe7kYSNJK0HLFzXK0k5FDtqhBbsk6gpMym89mfr13lbI2a7TWdq8EATb
	j8pvubGd3ih9Q8vUh44IooonPpyt79hidCOMzeQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZziF/S8Ow5L+kFWZxfQX4D8+vWuhrylsvisXMzvI2Vk=:fIHCpIIsJAq0/2typ72DqddprGazEAm07/F+z+PlgIg=;
X-ME-Sender: <xms:u4K_ag-P0IgOZbJkYncYsM152tbK0XWdmkHF36TkYWpfSoM24dKuJQ>
    <xme:u4K_avp3yCtIUwOZFmUfS9LpZXJsTIhi2Xkj_yfxl-Wcb2h7BN2q3JIdm7ykWCQOd
    b4H2bWOKIuViYNRVdQnJQqU6rwpPTAJfK8mFgkNspZwFCw4YGCJvA>
X-ME-Received: <xmr:u4K_arocwKJP_OBPsPyRmpHUqnWlM7N-L67Jim5kEyaafTrToetN2g>
X-ME-Proxy-Cause: dmFkZTFvOK4jYs8bmv+4O9CJB3svfji8iLEOFoCwK34zCJslpABupSh+C0y5dxm/zLncdv
    yQTGU6/8v+W4Tj0P3wSU4VAzn5ekuceJwRD+e02GBBfmEvzNeX8xCgz/hxjWHe8zslboFQ
    5hRWz12yruO5mw5aJTfenIOHadtmdwey+6BTIr3i3W//+DDzD2z7Sw9CmdhD9khWGsJSU5
    URCqeGZFfDhvS4SGx87ak2MmAEtN9/C0xA1WNVFnsvglwt1EsnzPgICOxXNdoizDsEBNmN
    vDt0TjyiJsMaYQmMqRu6XxOV4oD+e10CP3qwGIJVZ79fIzfxRcuk7aE4m9D6f4fRcvjcOh
    yNNAOaubYI4I3oGLMJ1fCXUBocXd9J+iAZLlNmJzAH51tpW7SVlAnNVQcyO0zuqK8zke1y
    f8CAlw6uPy0E5S4N0Bv7ksYDCjm3OVUvWa2a0X7jTUMCgKIBcANNdGok+u3IlxE3J+pa06
    QHggcvyOQUapTdyeoXwmt1QYGDfygLu8mHPEIlYsMGBRhFvWVJxlipFbB/djahMtPc21H+
    kfhGZ6fHb9IgtN/KsUPeBTEiP8IIOhXwtjfQfUPut/2ZGBscV+wt5rU3ULVaGTkTzsKoVn
    zPYryPJ/QYMDV/cNxN6nDhNRGmIQRULzfUxMm8ciEM7gZAikIbRCGjy11SOA
X-ME-Proxy: <xmx:u4K_alnYiBUdplvKfmBWYuTWw44u7S2ivtbtQV1bdzsXn23iJbV4AA>
    <xmx:u4K_alEJ1V6Kw35M1TXFrDMnuypd7PXje9a4f6FJ7mVSQnzipQcdAQ>
    <xmx:u4K_amqqal3AzcReHgz7yc84wxwesdKsg5nMCmICv6501sV4KR4YkA>
    <xmx:u4K_ap7UPLC1CVCYeiTP68nTBVB0LUv9mprzlWL7tmOaYjcwb75G7g>
    <xmx:u4K_agvwt1O1UVXL5YajIFmISkchTvcyz9zFAuu5wNef8FXfbSxF_cT4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acb8aa0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:23 +0200
Subject: [PATCH 12/13] odb/source-files: move alternates into the backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-12-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Originally, when designing pluggable object databases the goal was that
the object database can have multiple sources, and every source attached
to it could use a different backend. This would have allowed for quite a
lot of flexibility, as you could trivially mix and match different kinds
of object storages in whatever way you like.

But while well-intentioned, this design led to a bunch of conceptual
problems:

  - We're now trying to read objects in source order, whereas we
    previously tried to read objects via packfiles before trying to read
    them via loose objects. This led to a performance regression when
    using alternates or when using a quarantine directory.

  - Some data structures are supposed to only ever exist once, like for
    example bitmaps and commit graphs. At the same time, those data
    structures also span across the union of all objects, so they may
    cross sources.

  - It is unclear how we can extend GIT_OBJECT_DIRECTORY or
    GIT_ALTERNATE_OBJECT_DIRECTORIES to become backend-agnostic in a
    backwards-compatible way. In general, introducing an object storage
    extension into the current status quo where alternates may have to
    be extended to become generic was proving to be painful.

  - Some mechanisms of alternates assume way too much about how exactly
    their backends work. Alternate refs for example assume that the
    alternate is backed by a filesystem path, and that this filesystem
    path may also allow us to read references. This is not a given
    though, as backends may not even have local data at all.

In short, there are a bunch of conceptual mismatches when we have
alternates and pluggable object databases coexist. So while the original
idea was nice, it does not result in a system that is easy to reason
about.

Correct course by moving alternates into the "files" source itself so
that it becomes an implementation detail thereof so that we can avoid
all of these shortcomings. While it's unfortunate that we cannot easily
mix and match sources now, that ability doesn't go away. It's still very
much feasible to introduce a new backend that allows for exactly that
use case, and such a backend may also be a lot more flexible as we can
now add new logic to determine which objects should be stored where. So
the original motivation for having per-source backends can still be
realized with the new architecture.

Note that as part of this move, we also handle the GIT_OBJECT_DIRECTORY
and GIT_ALTERNATE_OBJECT_DIRECTORIES environment variables in the
"files" backend. This may be surprising at first, but object directories
are very much a concept of that backend, too. So these variables would
have bad interactions with other backends, and they create a bit of a
mismatch with the eventual object storage extension that we plan to
introduce.

Note that this commit is way larger than I'd like it to be. I'm sorry, I
couldn't find a way to split it up further. That being said, most of the
changes are straight-forward conversions that go from iterating over
sources to iterating over object directories. The more involved changes
are moving the infrastructure to track individual sources from "odb.c"
and moving them into "odb/source-files.c".

This also serves to show a bit of a who's-who of commands that don't
work properly with pluggable object databases. Almost all of these
commands are related to housekeeping though -- some of them will be
converted eventually, like for example commit graphs or MIDXs. But many
of them will stay incompatible going forward as they are simply too
specific to the "files" backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/count-objects.c    |   2 +-
 builtin/fast-import.c      |  18 +--
 builtin/fetch.c            |   2 +-
 builtin/fsck.c             |   6 +-
 builtin/gc.c               |  14 +-
 builtin/index-pack.c       |   2 +-
 builtin/multi-pack-index.c |   6 +-
 builtin/pack-objects.c     |  64 ++++----
 builtin/prune.c            |   2 +-
 bundle.c                   |   2 +-
 commit-graph.c             |  28 ++--
 diagnose.c                 |   2 +-
 fetch-pack.c               |   2 +-
 http-walker.c              |   2 +-
 http.c                     |   6 +-
 loose.c                    |  16 +-
 midx.c                     |  29 ++--
 odb.c                      | 354 +++++----------------------------------------
 odb.h                      |  33 +----
 odb/source-files.c         | 260 ++++++++++++++++++++++++++++++---
 odb/source-files.h         |  23 ++-
 odb/source.c               |   5 +-
 odb/source.h               |  25 +---
 odb/streaming.c            |   8 +-
 odb/transaction.c          |   2 +-
 pack-bitmap.c              |   8 +-
 packfile.c                 |  28 ++--
 packfile.h                 |  21 ++-
 path.c                     |   2 +-
 prune-packed.c             |   2 +-
 repack.c                   |   4 +-
 repository.c               |   4 +-
 setup.c                    |   2 +-
 t/helper/test-read-graph.c |   2 +-
 tmp-objdir.c               |   4 +-
 35 files changed, 441 insertions(+), 549 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index f2abfaccec..3f7b20fde5 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -118,7 +118,7 @@ int cmd_count_objects(int argc,
 		report_linked_checkout_garbage(the_repository);
 	}
 
-	for_each_loose_file_in_source(the_repository->objects->sources,
+	for_each_loose_file_in_source(the_repository->objects->source,
 				      count_loose, count_cruft, NULL, NULL);
 
 	if (verbose) {
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 0bf76b028b..5fc082bcc7 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -895,7 +895,7 @@ static void end_packfile(void)
 	running = 1;
 	clear_delta_base_cache();
 	if (object_count) {
-		struct odb_source_files *files = odb_source_files_downcast(pack_data->repo->objects->sources);
+		struct odb_source_files *files = odb_source_files_downcast(pack_data->repo->objects->source);
 		struct packed_git *new_p;
 		struct object_id cur_pack_oid;
 		char *idx_name;
@@ -975,7 +975,7 @@ static int store_object(
 	struct object_id *oidout,
 	uintmax_t mark)
 {
-	struct odb_source *source;
+	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->source);
 	void *out, *delta;
 	struct object_entry *e;
 	unsigned char hdr[96];
@@ -1002,10 +1002,8 @@ static int store_object(
 		return 1;
 	}
 
-	for (source = the_repository->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-
-		if (!packfile_list_find_oid(packfile_store_get_packs(files->dirs->packed), &oid))
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (!packfile_list_find_oid(packfile_store_get_packs(dir->packed), &oid))
 			continue;
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
@@ -1125,10 +1123,10 @@ static void truncate_pack(struct hashfile_checkpoint *checkpoint)
 
 static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 {
+	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->source);
 	size_t in_sz = 64 * 1024, out_sz = 64 * 1024;
 	unsigned char *in_buf = xmalloc(in_sz);
 	unsigned char *out_buf = xmalloc(out_sz);
-	struct odb_source *source;
 	struct object_entry *e;
 	struct object_id oid;
 	unsigned long hdrlen;
@@ -1212,10 +1210,8 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		goto out;
 	}
 
-	for (source = the_repository->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-
-		if (!packfile_list_find_oid(packfile_store_get_packs(files->dirs->packed), &oid))
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (!packfile_list_find_oid(packfile_store_get_packs(dir->packed), &oid))
 			continue;
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a4b21d2651..2e9c14d4ed 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2902,7 +2902,7 @@ int cmd_fetch(int argc,
 
 		trace2_region_enter("fetch", "write-commit-graph", the_repository);
 		write_commit_graph_reachable(the_repository,
-					     the_repository->objects->sources->path,
+					     the_repository->objects->source->path,
 					     commit_graph_flags,
 					     NULL);
 		trace2_region_leave("fetch", "write-commit-graph", the_repository);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9af4cc085b..da90cf84bf 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -868,7 +868,6 @@ int cmd_fsck(int argc,
 		OPT_BOOL(0, "references", &check_references, N_("check reference database consistency")),
 		OPT_END(),
 	};
-	struct odb_source *source;
 	struct snapshot snap = {
 		.nr = 0,
 		.alloc = 0,
@@ -983,13 +982,14 @@ int cmd_fsck(int argc,
 	check_connectivity(repo);
 
 	if (repo->settings.core_commit_graph) {
+		struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-		for (source = repo->objects->sources; source; source = source->next) {
+		for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
 			child_process_init(&commit_graph_verify);
 			commit_graph_verify.git_cmd = 1;
 			strvec_pushl(&commit_graph_verify.args, "commit-graph",
-				     "verify", "--object-dir", source->path, NULL);
+				     "verify", "--object-dir", dir->abspath, NULL);
 			if (show_progress)
 				strvec_push(&commit_graph_verify.args, "--progress");
 			else
diff --git a/builtin/gc.c b/builtin/gc.c
index 7acd4f3215..28ada9f566 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -734,7 +734,7 @@ int cmd_gc(int argc,
 
 	if (the_repository->settings.gc_write_commit_graph == 1)
 		write_commit_graph_reachable(the_repository,
-					     the_repository->objects->sources->path,
+					     the_repository->objects->source->path,
 					     !opts.quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
@@ -998,7 +998,7 @@ static int loose_object_auto_condition(struct gc_config *cfg UNUSED)
 	if (loose_object_auto_limit < 0)
 		return 1;
 
-	return for_each_loose_file_in_source(the_repository->objects->sources,
+	return for_each_loose_file_in_source(the_repository->objects->source,
 					     loose_object_count,
 					     NULL, NULL, &count);
 }
@@ -1033,7 +1033,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	 * Do not start pack-objects process
 	 * if there are no loose objects.
 	 */
-	if (!for_each_loose_file_in_source(r->objects->sources,
+	if (!for_each_loose_file_in_source(r->objects->source,
 					   bail_on_loose,
 					   NULL, NULL, NULL))
 		return 0;
@@ -1045,7 +1045,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 		strvec_push(&pack_proc.args, "--quiet");
 	else
 		strvec_push(&pack_proc.args, "--no-quiet");
-	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->sources->path);
+	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->source->path);
 
 	pack_proc.in = -1;
 
@@ -1073,7 +1073,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	else if (data.batch_size > 0)
 		data.batch_size--; /* Decrease for equality on limit. */
 
-	for_each_loose_file_in_source(r->objects->sources,
+	for_each_loose_file_in_source(r->objects->source,
 				      write_loose_object_to_stdin,
 				      NULL, NULL, &data);
 
@@ -1396,7 +1396,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	int result = 0;
 	struct lock_file lk;
 	struct repository *r = the_repository;
-	char *lock_path = xstrfmt("%s/maintenance", r->objects->sources->path);
+	char *lock_path = xstrfmt("%s/maintenance", r->objects->source->path);
 	enum auto_gc_hook_result auto_gc_hook_result = AUTO_GC_HOOK_UNDECIDED;
 
 	if (repo_hold_lock_file_for_update(r, &lk, lock_path, LOCK_NO_DEREF) < 0) {
@@ -2972,7 +2972,7 @@ static int update_background_schedule(const struct maintenance_start_opts *opts,
 	unsigned int i;
 	int result = 0;
 	struct lock_file lk;
-	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->sources->path);
+	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->source->path);
 
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
 		if (errno == EEXIST)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 70860b8f27..0264c18c5f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1640,7 +1640,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	if (do_fsck_object && startup_info->have_repository) {
 		struct odb_source_files *files =
-			odb_source_files_downcast(the_repository->objects->sources);
+			odb_source_files_downcast(the_repository->objects->source);
 		packfile_store_load_pack(files->dirs->packed, final_index_name, 0);
 	}
 
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index fc8b494996..c48212290c 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -80,7 +80,7 @@ static int parse_object_dir(const struct option *opt, const char *arg,
 	char **value = opt->value;
 	free(*value);
 	if (unset)
-		*value = xstrdup(the_repository->objects->sources->path);
+		*value = xstrdup(the_repository->objects->source->path);
 	else
 		*value = real_pathdup(arg, 1);
 	return 0;
@@ -426,8 +426,8 @@ int cmd_multi_pack_index(int argc,
 
 	if (the_repository &&
 	    the_repository->objects &&
-	    the_repository->objects->sources)
-		opts.object_dir = xstrdup(the_repository->objects->sources->path);
+	    the_repository->objects->source)
+		opts.object_dir = xstrdup(the_repository->objects->source->path);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_multi_pack_index_usage, 0);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 070659b6ed..ca3a891dfb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1566,11 +1566,10 @@ static int want_cruft_object_mtime(struct repository *r,
 				   const struct object_id *oid,
 				   unsigned flags, uint32_t mtime)
 {
-	struct odb_source *source;
+	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 
-	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct packed_git **cache = packfile_store_get_kept_pack_cache(files->dirs->packed, flags);
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		struct packed_git **cache = packfile_store_get_kept_pack_cache(dir->packed, flags);
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
@@ -1753,21 +1752,19 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 				     off_t *found_offset,
 				     uint32_t found_mtime)
 {
+	struct odb_source_files *files =
+		odb_source_files_downcast(the_repository->objects->source);
 	int want;
 	struct packfile_list_entry *e;
-	struct odb_source *source;
 
 	if (!exclude && local) {
 		/*
-		 * Note that we start iterating at `sources->next` so that we
-		 * skip the local object source.
+		 * Note that we start iterating at `dirs->next` so that we
+		 * skip the local object directory.
 		 */
-		struct odb_source *source = the_repository->objects->sources->next;
-		for (; source; source = source->next) {
-			struct odb_source_files *files = odb_source_files_downcast(source);
-			if (!odb_source_read_object_info(&files->dirs->loose->base, oid, NULL, 0, NULL))
+		for (struct odb_files_dir *dir = files->dirs->next; dir; dir = dir->next)
+			if (!odb_source_read_object_info(&dir->loose->base, oid, NULL, 0, NULL))
 				return 0;
-		}
 	}
 
 	/*
@@ -1785,9 +1782,8 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		*found_offset = 0;
 	}
 
-	for (source = the_repository->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct multi_pack_index *m = get_multi_pack_index(files->dirs->packed);
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		struct multi_pack_index *m = get_multi_pack_index(dir->packed);
 		struct pack_entry e;
 
 		if (m && midx_fill_entry(m, oid, &e, NULL) == MIDX_FILL_HIT) {
@@ -1797,14 +1793,12 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		}
 	}
 
-	for (source = the_repository->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-
-		for (e = files->dirs->packed->packs.head; e; e = e->next) {
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		for (e = dir->packed->packs.head; e; e = e->next) {
 			struct packed_git *p = e->pack;
 			want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (!exclude && want > 0)
-				packfile_list_prepend(&files->dirs->packed->packs, p);
+				packfile_list_prepend(&dir->packed->packs, p);
 			if (want != -1)
 				return want;
 		}
@@ -4170,14 +4164,13 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 		if (!want_object_in_pack_mtime(oid, 0, &pack, &offset, mtime))
 			return;
 		if (!pack && type == OBJ_BLOB) {
-			struct odb_source *source = the_repository->objects->sources;
+			struct odb_source_files *files =
+				odb_source_files_downcast(the_repository->objects->source);
 			int found = 0;
 
-			for (; !found && source; source = source->next) {
-				struct odb_source_files *files = odb_source_files_downcast(source);
-				if (!odb_source_read_object_info(&files->dirs->loose->base, oid, NULL, 0, NULL))
+			for (struct odb_files_dir *dir = files->dirs; !found && dir; dir = dir->next)
+				if (!odb_source_read_object_info(&dir->loose->base, oid, NULL, 0, NULL))
 					found = 1;
-			}
 
 			/*
 			 * If a traversed tree has a missing blob then we want
@@ -4512,7 +4505,8 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
 
 static void add_objects_in_unpacked_packs(void)
 {
-	struct odb_source *source;
+	struct odb_source_files *files =
+		odb_source_files_downcast(to_pack.repo->objects->source);
 	time_t mtime;
 	struct odb_for_each_object_options opts = {
 		.flags = ODB_FOR_EACH_OBJECT_PACK_ORDER |
@@ -4526,13 +4520,11 @@ static void add_objects_in_unpacked_packs(void)
 		.source_infop = &source_info,
 	};
 
-	for (source = to_pack.repo->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-
-		if (!source->local)
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (!dir->local)
 			continue;
 
-		if (odb_source_for_each_object(&files->dirs->packed->base, &oi,
+		if (odb_source_for_each_object(&dir->packed->base, &oi,
 					       add_object_in_unpacked_pack, NULL, &opts))
 			die(_("cannot open pack index"));
 	}
@@ -4576,7 +4568,7 @@ static int add_loose_object(const struct object_id *oid, const char *path,
  */
 static void add_unreachable_loose_objects(struct rev_info *revs)
 {
-	for_each_loose_file_in_source(the_repository->objects->sources,
+	for_each_loose_file_in_source(the_repository->objects->source,
 				      add_loose_object, NULL, NULL, revs);
 }
 
@@ -4640,11 +4632,9 @@ static int force_object_loose(struct odb_source *source,
 	size_t len;
 	int ret;
 
-	for (struct odb_source *s = source->odb->sources; s; s = s->next) {
-		struct odb_source_files *files = odb_source_files_downcast(s);
-		if (!odb_source_read_object_info(&files->dirs->loose->base, oid, NULL, 0, NULL))
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
+		if (!odb_source_read_object_info(&dir->loose->base, oid, NULL, 0, NULL))
 			return 0;
-	}
 
 	oi.typep = &type;
 	oi.sizep = &len;
@@ -4691,7 +4681,7 @@ static void loosen_unused_packed_objects(void)
 			if (!packlist_find(&to_pack, &oid) &&
 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
 			    !loosened_object_can_be_discarded(&oid, p->mtime)) {
-				if (force_object_loose(the_repository->objects->sources,
+				if (force_object_loose(the_repository->objects->source,
 						       &oid, &p->mtime))
 					die(_("unable to force loose object"));
 				loosened_objects_nr++;
diff --git a/builtin/prune.c b/builtin/prune.c
index a7e4678d11..97f4c1418b 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -198,7 +198,7 @@ int cmd_prune(int argc,
 		revs.exclude_promisor_objects = 1;
 	}
 
-	for_each_loose_file_in_source(repo->objects->sources,
+	for_each_loose_file_in_source(repo->objects->source,
 				      prune_object, prune_cruft, prune_subdir, &revs);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
diff --git a/bundle.c b/bundle.c
index f55a521b2a..a81fd29505 100644
--- a/bundle.c
+++ b/bundle.c
@@ -239,7 +239,7 @@ int verify_bundle(struct repository *r,
 		.quiet = 1,
 	};
 
-	if (!r || !r->objects || !r->objects->sources)
+	if (!r || !r->objects || !r->objects->source)
 		return error(_("need a repository to verify a bundle"));
 
 	for (i = 0; i < p->nr; i++) {
diff --git a/commit-graph.c b/commit-graph.c
index 7cc486d140..673d54db29 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -15,6 +15,7 @@
 #include "hash-lookup.h"
 #include "commit-graph.h"
 #include "odb.h"
+#include "odb/source-files.h"
 #include "oid-array.h"
 #include "path.h"
 #include "alloc.h"
@@ -38,7 +39,7 @@ void git_test_write_commit_graph_or_die(struct repository *repo)
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	if (write_commit_graph_reachable(repo, repo->objects->sources->path, flags, NULL))
+	if (write_commit_graph_reachable(repo, repo->objects->source->path, flags, NULL))
 		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
 }
 
@@ -657,7 +658,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 	CALLOC_ARRAY(oids, count);
 
 	for (i = 0; i < count; i++) {
-		struct odb_source *source;
+		struct odb_source_files *files;
 
 		if (strbuf_getline_lf(&line, fp) == EOF)
 			break;
@@ -670,9 +671,11 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 		}
 
 		valid = 0;
-		for (source = odb->sources; source; source = source->next) {
-			char *graph_name = get_split_graph_filename(source->path, line.buf);
-			struct commit_graph *g = load_commit_graph_one(odb->repo, source->path, graph_name);
+
+		files = odb_source_files_downcast(odb->source);
+		for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+			char *graph_name = get_split_graph_filename(dir->abspath, line.buf);
+			struct commit_graph *g = load_commit_graph_one(odb->repo, dir->abspath, graph_name);
 
 			free(graph_name);
 
@@ -742,7 +745,7 @@ struct commit_graph *read_commit_graph_one(struct repository *repo,
  */
 static struct commit_graph *prepare_commit_graph(struct repository *r)
 {
-	struct odb_source *source;
+	struct odb_source_files *files;
 
 	/*
 	 * Early return if there is no object database or if the commit graph is
@@ -773,8 +776,9 @@ static struct commit_graph *prepare_commit_graph(struct repository *r)
 	if (!commit_graph_compatible(r))
 		return NULL;
 
-	for (source = r->objects->sources; source; source = source->next) {
-		r->objects->commit_graph = read_commit_graph_one(r, source->path);
+	files = odb_source_files_downcast(r->objects->source);
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		r->objects->commit_graph = read_commit_graph_one(r, dir->abspath);
 		if (r->objects->commit_graph)
 			break;
 	}
@@ -2003,7 +2007,7 @@ static int fill_oids_from_commits(struct write_commit_graph_context *ctx,
 
 static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 {
-	struct odb_source *source;
+	struct odb_source_files *files;
 	enum object_type type;
 	struct odb_for_each_object_options opts = {
 		.flags = ODB_FOR_EACH_OBJECT_PACK_ORDER,
@@ -2018,9 +2022,9 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 			_("Finding commits for commit graph among packed objects"),
 			ctx->approx_nr_objects);
 
-	for (source = ctx->r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		odb_source_for_each_object(&files->dirs->packed->base, &oi, add_packed_commits_oi,
+	files = odb_source_files_downcast(ctx->r->objects->source);
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		odb_source_for_each_object(&dir->packed->base, &oi, add_packed_commits_oi,
 					   ctx, &opts);
 	}
 
diff --git a/diagnose.c b/diagnose.c
index 89240e47d6..2c1bcfe431 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -228,7 +228,7 @@ int create_diagnostics_archive(struct repository *r,
 
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
-	dir_file_stats(odb_source_files_downcast(r->objects->sources)->dirs, &buf);
+	dir_file_stats(odb_source_files_downcast(r->objects->source)->dirs, &buf);
 	odb_for_each_alternate(r->objects, dir_file_stats, &buf);
 	strvec_push(&archiver_args, buf.buf);
 
diff --git a/fetch-pack.c b/fetch-pack.c
index aad07b1153..b14e3ba71b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1075,7 +1075,7 @@ static int get_pack(struct fetch_pack_args *args,
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && (pack_lockfiles || fsck_objects)) {
 		int is_well_formed;
-		char *pack_lockfile = index_pack_lockfile(the_repository->objects->sources,
+		char *pack_lockfile = index_pack_lockfile(the_repository->objects->source,
 							  cmd.out,
 							  &is_well_formed);
 
diff --git a/http-walker.c b/http-walker.c
index 0a6c99f471..4f50dd9b8d 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -540,7 +540,7 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 	} else if (!oideq(&obj_req->oid, &req->real_oid)) {
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
-		struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
+		struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->source);
 		struct strbuf buf = STRBUF_INIT;
 		odb_loose_path(files->dirs->loose, &buf, &req->oid);
 		ret = error("unable to write sha1 filename %s", buf.buf);
diff --git a/http.c b/http.c
index fe6ec88a21..230c4de494 100644
--- a/http.c
+++ b/http.c
@@ -2718,7 +2718,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 void http_install_packfile(struct packed_git *p,
 			   struct packfile_list *list_to_remove_from)
 {
-	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
+	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->source);
 	packfile_list_remove(list_to_remove_from, p);
 	packfile_store_add_pack(files->dirs->packed, p);
 }
@@ -2846,7 +2846,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 struct http_object_request *new_http_object_request(const char *base_url,
 						    const struct object_id *oid)
 {
-	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
+	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->source);
 	char *hex = oid_to_hex(oid);
 	struct strbuf filename = STRBUF_INIT;
 	struct strbuf prevfile = STRBUF_INIT;
@@ -2987,7 +2987,7 @@ void process_http_object_request(struct http_object_request *freq)
 
 int finish_http_object_request(struct http_object_request *freq)
 {
-	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
+	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->source);
 	struct stat st;
 	struct strbuf filename = STRBUF_INIT;
 
diff --git a/loose.c b/loose.c
index 957bf83e6b..d6a2bb5ba3 100644
--- a/loose.c
+++ b/loose.c
@@ -113,11 +113,10 @@ int loose_object_map_load(struct odb_source_loose *loose)
 
 int repo_read_loose_object_map(struct repository *repo)
 {
-	struct odb_source *source;
+	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
 
-	for (source = repo->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (loose_object_map_load(files->dirs->loose) < 0)
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (loose_object_map_load(dir->loose) < 0)
 			return -1;
 	}
 
@@ -126,7 +125,7 @@ int repo_read_loose_object_map(struct repository *repo)
 
 int repo_write_loose_object_map(struct repository *repo)
 {
-	struct odb_source_files *files = odb_source_files_downcast(repo->objects->sources);
+	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
 	kh_oid_map_t *map = files->dirs->loose->map->to_compat;
 	struct lock_file lock;
 	int fd;
@@ -231,13 +230,12 @@ int repo_loose_object_map_oid(struct repository *repo,
 			      const struct git_hash_algo *to,
 			      struct object_id *dest)
 {
-	struct odb_source *source;
+	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
 	kh_oid_map_t *map;
 	khiter_t pos;
 
-	for (source = repo->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct loose_object_map *loose_map = files->dirs->loose->map;
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		struct loose_object_map *loose_map = dir->loose->map;
 		if (!loose_map)
 			continue;
 		map = (to == repo->compat_hash_algo) ?
diff --git a/midx.c b/midx.c
index c0f82c4163..8638ddf0be 100644
--- a/midx.c
+++ b/midx.c
@@ -829,21 +829,15 @@ void clear_incremental_midx_files_ext(struct odb_source_packed *source, const ch
 
 void clear_midx_file(struct repository *r)
 {
-	struct odb_source_files *files;
+	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 	struct strbuf midx = STRBUF_INIT;
 
-	if (r->objects) {
-		struct odb_source *source;
-
-		for (source = r->objects->sources; source; source = source->next) {
-			files = odb_source_files_downcast(source);
-			if (files->dirs->packed->midx)
-				close_midx(files->dirs->packed->midx);
-			files->dirs->packed->midx = NULL;
-		}
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (dir->packed->midx)
+			close_midx(dir->packed->midx);
+		dir->packed->midx = NULL;
 	}
 
-	files = odb_source_files_downcast(r->objects->sources);
 	get_midx_filename(files->dirs->packed, &midx);
 
 	if (remove_path(midx.buf))
@@ -858,18 +852,15 @@ void clear_midx_file(struct repository *r)
 void clear_incremental_midx_files(struct repository *r,
 				  const struct strvec *keep_hashes)
 {
-	struct odb_source_files *files;
-	struct odb_source *source;
+	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 	struct strbuf chain = STRBUF_INIT;
 
-	for (source = r->objects->sources; source; source = source->next) {
-		files = odb_source_files_downcast(source);
-		if (files->dirs->packed->midx)
-			close_midx(files->dirs->packed->midx);
-		files->dirs->packed->midx = NULL;
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (dir->packed->midx)
+			close_midx(dir->packed->midx);
+		dir->packed->midx = NULL;
 	}
 
-	files = odb_source_files_downcast(r->objects->sources);
 	get_midx_chain_filename(files->dirs->packed, &chain);
 
 	if (!keep_hashes && remove_path(chain.buf))
diff --git a/odb.c b/odb.c
index 8b54271c27..98c5c862f5 100644
--- a/odb.c
+++ b/odb.c
@@ -13,11 +13,10 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
-#include "odb/source-inmemory.h"
 #include "odb/source-files.h"
+#include "odb/source-inmemory.h"
 #include "path.h"
 #include "promisor-remote.h"
-#include "quote.h"
 #include "replace-object.h"
 #include "run-command.h"
 #include "setup.h"
@@ -28,48 +27,6 @@
 #include "trace2.h"
 #include "write-or-die.h"
 
-/*
- * NEEDSWORK: we're using "core.ignoreCase" to deduplicate alternates that
- * _may_ be the same. This requires quite a bit of boilerplate for dubious
- * benefit:
- *
- *   - Duplicating alternates should really only lead to regressed performance.
- *
- *   - We don't properly resolve symlinks or mointpoints, so we may still end
- *     up duplicating alternates.
- *
- *   - The value may be lying, in which case we might deduplicate alternates
- *     that are in fact not mapping to the same directory.
- *
- * We should investigate whether we can remove this whole mechanism outright.
- */
-static int odb_source_paths_cmp(struct object_database *o,
-				const char *a, const char *b)
-{
-	if (o->source_paths_icase < 0) {
-		int icase = 0;
-		repo_config_get_bool(o->repo, "core.ignorecase", &icase);
-		o->source_paths_icase = icase;
-	}
-
-	return o->source_paths_icase ? strcasecmp(a, b) : strcmp(a, b);
-}
-
-static int odb_source_by_path_cmp(const void *cb_data,
-				  const struct hashmap_entry *entry,
-				  const struct hashmap_entry *entry_or_key,
-				  const void *keydata)
-{
-	struct object_database *o = (struct object_database *)cb_data;
-	const struct odb_source *source = container_of(entry, const struct odb_source, by_path_entry);
-	const char *path = keydata;
-
-	if (!path)
-		path = container_of(entry_or_key, const struct odb_source, by_path_entry)->path;
-
-	return odb_source_paths_cmp(o, source->path, path);
-}
-
 int odb_mkstemp(struct object_database *odb,
 		struct strbuf *temp_filename, const char *pattern)
 {
@@ -91,154 +48,6 @@ int odb_mkstemp(struct object_database *odb,
 	return xmkstemp_mode(temp_filename->buf, mode);
 }
 
-/*
- * Return non-zero iff the path is usable as an alternate object database.
- */
-static bool odb_is_source_usable(struct object_database *o, const char *path)
-{
-	struct strbuf normalized_objdir = STRBUF_INIT;
-	struct hashmap_entry key;
-	bool usable = false;
-
-	strbuf_realpath(&normalized_objdir, o->sources->path, 1);
-
-	/* Detect cases where alternate disappeared */
-	if (!is_directory(path)) {
-		error(_("object directory %s does not exist; "
-			"check .git/objects/info/alternates"),
-		      path);
-		goto out;
-	}
-
-	/*
-	 * Prevent the common mistake of listing the same
-	 * thing twice, or object directory itself.
-	 */
-	if (!hashmap_get_size(&o->source_by_path)) {
-		assert(!o->sources->next);
-		hashmap_entry_init(&o->sources->by_path_entry,
-				   strihash(o->sources->path));
-		hashmap_add(&o->source_by_path, &o->sources->by_path_entry);
-	}
-
-	if (!odb_source_paths_cmp(o, path, normalized_objdir.buf))
-		goto out;
-
-	hashmap_entry_init(&key, strihash(path));
-	if (hashmap_get(&o->source_by_path, &key, path))
-		goto out;
-
-	usable = true;
-
-out:
-	strbuf_release(&normalized_objdir);
-	return usable;
-}
-
-void parse_alternates(const char *string,
-		      int sep,
-		      const char *relative_base,
-		      struct strvec *out)
-{
-	struct strbuf pathbuf = STRBUF_INIT;
-	struct strbuf buf = STRBUF_INIT;
-
-	if (!string || !*string)
-		return;
-
-	while (*string) {
-		const char *end;
-
-		strbuf_reset(&buf);
-		strbuf_reset(&pathbuf);
-
-		if (*string == '#') {
-			/* comment; consume up to next separator */
-			end = strchrnul(string, sep);
-		} else if (*string == '"' && !unquote_c_style(&buf, string, &end)) {
-			/*
-			 * quoted path; unquote_c_style has copied the
-			 * data for us and set "end". Broken quoting (e.g.,
-			 * an entry that doesn't end with a quote) falls
-			 * back to the unquoted case below.
-			 */
-		} else {
-			/* normal, unquoted path */
-			end = strchrnul(string, sep);
-			strbuf_add(&buf, string, end - string);
-		}
-
-		if (*end)
-			end++;
-		string = end;
-
-		if (!buf.len)
-			continue;
-
-		if (!is_absolute_path(buf.buf) && relative_base) {
-			strbuf_realpath(&pathbuf, relative_base, 1);
-			strbuf_addch(&pathbuf, '/');
-		}
-		strbuf_addbuf(&pathbuf, &buf);
-
-		strbuf_reset(&buf);
-		if (!strbuf_realpath(&buf, pathbuf.buf, 0)) {
-			error(_("unable to normalize alternate object path: %s"),
-			      pathbuf.buf);
-			continue;
-		}
-
-		/*
-		 * The trailing slash after the directory name is given by
-		 * this function at the end. Remove duplicates.
-		 */
-		while (buf.len && buf.buf[buf.len - 1] == '/')
-			strbuf_setlen(&buf, buf.len - 1);
-
-		strvec_push(out, buf.buf);
-	}
-
-	strbuf_release(&pathbuf);
-	strbuf_release(&buf);
-}
-
-static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
-							const char *source,
-							int depth)
-{
-	struct odb_source *alternate = NULL;
-	struct strvec sources = STRVEC_INIT;
-
-	if (!odb_is_source_usable(odb, source))
-		goto error;
-
-	alternate = odb_source_new(odb, source, false);
-
-	/* add the alternate entry */
-	*odb->sources_tail = alternate;
-	odb->sources_tail = &(alternate->next);
-
-	hashmap_entry_init(&alternate->by_path_entry, strihash(alternate->path));
-	if (hashmap_get(&odb->source_by_path, &alternate->by_path_entry,
-			alternate->path))
-		BUG("source must not yet exist");
-	hashmap_add(&odb->source_by_path, &alternate->by_path_entry);
-
-	/* recursively add alternates */
-	odb_source_read_alternates(alternate, &sources);
-	if (sources.nr && depth + 1 > 5) {
-		error(_("%s: ignoring alternate object stores, nesting too deep"),
-		      source);
-	} else {
-		for (size_t i = 0; i < sources.nr; i++)
-			odb_add_alternate_recursively(odb, sources.v[i], depth + 1);
-	}
-
- error:
-	strvec_clear(&sources);
-	return alternate;
-}
-
 char *compute_alternate_path(const char *path, struct strbuf *err)
 {
 	char *ref_git = NULL;
@@ -410,34 +219,22 @@ void odb_for_each_alternate_ref(struct object_database *odb,
 int odb_for_each_alternate(struct object_database *odb,
 			 odb_for_each_alternate_fn cb, void *payload)
 {
-	struct odb_source *alternate;
+	struct odb_source_files *files = odb_source_files_downcast(odb->source);
 	int r = 0;
 
-	for (alternate = odb->sources->next; alternate; alternate = alternate->next) {
-		r = cb(odb_source_files_downcast(alternate)->dirs, payload);
+	for (struct odb_files_dir *dir = files->dirs->next; dir; dir = dir->next) {
+		r = cb(dir, payload);
 		if (r)
 			break;
 	}
 	return r;
 }
 
-static void odb_prepare_alternates(struct object_database *odb,
-				   const char *alternate_db)
-{
-	struct strvec sources = STRVEC_INIT;
-
-	parse_alternates(alternate_db, PATH_SEP, NULL, &sources);
-	odb_source_read_alternates(odb->sources, &sources);
-
-	for (size_t i = 0; i < sources.nr; i++)
-		odb_add_alternate_recursively(odb, sources.v[i], 0);
-
-	strvec_clear(&sources);
-}
-
 int odb_has_alternates(struct object_database *odb)
 {
-	return !!odb->sources->next;
+	if (odb->source->type != ODB_SOURCE_FILES)
+		return 0;
+	return !!odb_source_files_downcast(odb->source)->dirs->next;
 }
 
 int obj_read_use_lock = 0;
@@ -481,16 +278,12 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 		return 0;
 
 	while (1) {
-		struct odb_source *source;
-
-		for (source = odb->sources; source; source = source->next) {
-			ret = odb_source_read_object_info(source, real, oi, flags,
-							  corrupt_err.len ? NULL : &corrupt_err);
-			if (!ret)
-				goto out;
-			if (ret != ODB_READ_NOT_FOUND)
-				corrupt = true;
-		}
+		ret = odb_source_read_object_info(odb->source, real, oi, flags,
+						  corrupt_err.len ? NULL : &corrupt_err);
+		if (!ret)
+			goto out;
+		if (ret != ODB_READ_NOT_FOUND)
+			corrupt = true;
 
 		/*
 		 * When the object hasn't been found we try a second read and
@@ -498,15 +291,13 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 		 * caches or reload on-disk state.
 		 */
 		if (!(flags & OBJECT_INFO_QUICK)) {
-			for (source = odb->sources; source; source = source->next) {
-				ret = odb_source_read_object_info(source, real, oi,
-								  flags | OBJECT_INFO_SECOND_READ,
-								  corrupt_err.len ? NULL : &corrupt_err);
-				if (!ret)
-					goto out;
-				if (ret != ODB_READ_NOT_FOUND)
-					corrupt = true;
-			}
+			ret = odb_source_read_object_info(odb->source, real, oi,
+							  flags | OBJECT_INFO_SECOND_READ,
+							  corrupt_err.len ? NULL : &corrupt_err);
+			if (!ret)
+				goto out;
+			if (ret != ODB_READ_NOT_FOUND)
+				corrupt = true;
 		}
 
 		/* Check if it is a missing object */
@@ -748,11 +539,7 @@ int odb_has_object(struct object_database *odb, const struct object_id *oid,
 int odb_freshen_object(struct object_database *odb,
 		       const struct object_id *oid)
 {
-	struct odb_source *source;
-	for (source = odb->sources; source; source = source->next)
-		if (odb_source_freshen_object(source, oid, NULL))
-			return 1;
-	return 0;
+	return odb_source_freshen_object(odb->source, oid, NULL);
 }
 
 int odb_for_each_object_ext(struct object_database *odb,
@@ -761,18 +548,7 @@ int odb_for_each_object_ext(struct object_database *odb,
 			    void *cb_data,
 			    const struct odb_for_each_object_options *opts)
 {
-	int ret;
-
-	for (struct odb_source *source = odb->sources; source; source = source->next) {
-		if (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
-			continue;
-
-		ret = odb_source_for_each_object(source, request, cb, cb_data, opts);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return odb_source_for_each_object(odb->source, request, cb, cb_data, opts);
 }
 
 int odb_for_each_object(struct object_database *odb,
@@ -791,7 +567,6 @@ int odb_count_objects(struct object_database *odb,
 		      enum odb_count_objects_flags flags,
 		      unsigned long *out)
 {
-	struct odb_source *source;
 	unsigned long count = 0;
 	int ret;
 
@@ -800,15 +575,9 @@ int odb_count_objects(struct object_database *odb,
 		return 0;
 	}
 
-	for (source = odb->sources; source; source = source->next) {
-		unsigned long c;
-
-		ret = odb_source_count_objects(source, flags, &c);
-		if (ret < 0)
-			goto out;
-
-		count += c;
-	}
+	ret = odb_source_count_objects(odb->source, flags, &count);
+	if (ret < 0)
+		goto out;
 
 	odb->object_count = count;
 	odb->object_count_valid = 1;
@@ -879,13 +648,7 @@ int odb_find_abbrev_len(struct object_database *odb,
 		goto out;
 	}
 
-	for (struct odb_source *source = odb->sources; source; source = source->next) {
-		ret = odb_source_find_abbrev_len(source, oid, len, &len);
-		if (ret)
-			goto out;
-	}
-
-	ret = 0;
+	ret = odb_source_find_abbrev_len(odb->source, oid, len, &len);
 	*out = len;
 
 out:
@@ -941,7 +704,7 @@ int odb_write_object_ext(struct object_database *odb,
 		compat_oid_p = &compat_oid;
 	}
 
-	return odb_source_write_object(odb->sources, buf, len, type,
+	return odb_source_write_object(odb->source, buf, len, type,
 				       oid, compat_oid_p, NULL, flags);
 }
 
@@ -949,19 +712,19 @@ int odb_write_object_stream(struct object_database *odb,
 			    struct odb_stream *stream,
 			    struct object_id *oid)
 {
-	return odb_source_write_object_stream(odb->sources, stream, oid);
+	return odb_source_write_object_stream(odb->source, stream, oid);
 }
 
 int odb_optimize(struct object_database *odb,
 		 const struct odb_optimize_options *opts)
 {
-	return odb_source_optimize(odb->sources, opts);
+	return odb_source_optimize(odb->source, opts);
 }
 
 bool odb_optimize_required(struct object_database *odb,
 			   const struct odb_optimize_options *opts)
 {
-	return odb_source_optimize_required(odb->sources, opts);
+	return odb_source_optimize_required(odb->source, opts);
 }
 
 void odb_generate_pack_options_release(struct odb_generate_pack_options *opts)
@@ -975,9 +738,9 @@ int odb_generate_pack(struct object_database *odb,
 		      struct odb_pack_generator **out,
 		      const struct odb_generate_pack_options *opts)
 {
-	if (!odb->sources->generate_pack)
+	if (!odb->source->generate_pack)
 		return error(_("primary object source does not support generating packfiles"));
-	return odb_source_generate_pack(odb->sources, out, opts);
+	return odb_source_generate_pack(odb->source, out, opts);
 }
 
 int odb_pack_generator_finish(struct odb_pack_generator *generator)
@@ -988,55 +751,29 @@ int odb_pack_generator_finish(struct odb_pack_generator *generator)
 struct object_database *odb_new(struct repository *repo,
 				enum odb_new_flags flags)
 {
-	char *primary_source = NULL, *secondary_sources = NULL;
 	struct object_database *o;
 
 	CALLOC_ARRAY(o, 1);
 	o->repo = repo;
 	pthread_mutex_init(&o->replace_mutex, NULL);
-	hashmap_init(&o->source_by_path, odb_source_by_path_cmp, o, 0);
-	o->source_paths_icase = -1;
-
-	if (flags & ODB_NEW_HONOR_ENV) {
-		primary_source = xstrdup_or_null(getenv(DB_ENVIRONMENT));
-		secondary_sources = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
-	}
-	if (!primary_source)
-		primary_source = xstrfmt("%s/objects", repo->commondir);
 
-	o->sources = odb_source_new(o, primary_source, true);
-	o->sources_tail = &o->sources->next;
+	o->source = odb_source_new(o, flags);
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
-	odb_prepare_alternates(o, secondary_sources);
-
-	free(secondary_sources);
-	free(primary_source);
 	return o;
 }
 
 void odb_close(struct object_database *o)
 {
-	struct odb_source *source;
-	for (source = o->sources; source; source = source->next)
-		odb_source_close(source);
+	odb_source_close(o->source);
 	close_commit_graph(o);
 }
 
 static void odb_free_sources(struct object_database *o)
 {
-	while (o->sources) {
-		struct odb_source *next;
-
-		next = o->sources->next;
-		odb_source_free(o->sources);
-		o->sources = next;
-	}
-
+	odb_source_free(o->source);
 	odb_source_free(o->inmemory_objects);
 	o->inmemory_objects = NULL;
-
-	hashmap_clear(&o->source_by_path);
 }
 
 void odb_free(struct object_database *o)
@@ -1055,24 +792,12 @@ void odb_free(struct object_database *o)
 
 void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
 {
-	struct odb_source *source;
-
 	obj_read_lock();
 
-	/*
-	 * Reprepare alt odbs, in case the alternates file was modified
-	 * during the course of this process. This only _adds_ odbs to
-	 * the linked list, so existing odbs will continue to exist for
-	 * the lifetime of the process. Consequently, we don't have to
-	 * reprocess GIT_ALTERNATE_OBJECT_DIRECTORIES here.
-	 */
-	if (flags & ODB_PREPARE_FLUSH_CACHES) {
-		odb_prepare_alternates(o, NULL);
+	if (flags & ODB_PREPARE_FLUSH_CACHES)
 		o->object_count_valid = 0;
-	}
 
-	for (source = o->sources; source; source = source->next)
-		odb_source_prepare(source, flags);
+	odb_source_prepare(o->source, flags);
 
 	obj_read_unlock();
 }
@@ -1084,8 +809,5 @@ void odb_reprepare(struct object_database *o)
 
 int odb_fsck(struct object_database *odb, struct odb_fsck_options *options)
 {
-	int ret = 0;
-	for (struct odb_source *source = odb->sources; source; source = source->next)
-		ret |= odb_source_fsck(source, options);
-	return ret;
+	return odb_source_fsck(odb->source, options);
 }
diff --git a/odb.h b/odb.h
index 4143812f55..0ccc47ee73 100644
--- a/odb.h
+++ b/odb.h
@@ -28,13 +28,16 @@ char *compute_alternate_path(const char *path, struct strbuf *err);
 
 /*
  * The object database encapsulates access to objects in a repository. It
- * manages one or more sources that store the actual objects which are
- * configured via alternates.
+ * manages the object source as well as auxiliary data structures required to
+ * manage objects.
  */
 struct object_database {
 	/* Repository that owns this database. */
 	struct repository *repo;
 
+	/* The source backing this object database. */
+	struct odb_source *source;
+
 	/*
 	 * State of current object database transaction. Only one
 	 * transaction may be pending at a time. Is NULL when no transaction is
@@ -42,27 +45,6 @@ struct object_database {
 	 */
 	struct odb_transaction *transaction;
 
-	/*
-	 * Set of all object directories; the main directory is first (and
-	 * cannot be NULL after initialization). Subsequent directories are
-	 * alternates.
-	 */
-	struct odb_source *sources;
-	struct odb_source **sources_tail;
-
-	/*
-	 * Map of object database sources, keyed by their respective paths.
-	 * This map is used to detect the case where the same source is
-	 * registered multiple times.
-	 */
-	struct hashmap source_by_path;
-
-	/*
-	 * Whether source paths shall be compared case-insensitively, as
-	 * determined by "core.ignoreCase".
-	 */
-	int source_paths_icase;
-
 	/*
 	 * Objects that should be substituted by other objects
 	 * (see git-replace(1)).
@@ -822,9 +804,4 @@ int odb_generate_pack(struct object_database *odb,
  */
 int odb_pack_generator_finish(struct odb_pack_generator *generator);
 
-void parse_alternates(const char *string,
-		      int sep,
-		      const char *relative_base,
-		      struct strvec *out);
-
 #endif /* ODB_H */
diff --git a/odb/source-files.c b/odb/source-files.c
index 6aaf625352..072f515b36 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -15,6 +15,7 @@
 #include "packfile.h"
 #include "path.h"
 #include "promisor-remote.h"
+#include "quote.h"
 #include "repack.h"
 #include "run-command.h"
 #include "strbuf.h"
@@ -71,6 +72,7 @@ static void odb_source_files_free(struct odb_source *source)
 		odb_files_dir_free(files->dirs);
 		files->dirs = next;
 	}
+	hashmap_clear(&files->dirs_by_path);
 
 	odb_source_release(&files->base);
 	free(files);
@@ -174,6 +176,160 @@ static int odb_source_files_create_on_disk(struct odb_source *source,
 	return ret;
 }
 
+/*
+ * NEEDSWORK: we're using "core.ignoreCase" to deduplicate alternates that
+ * _may_ be the same. This requires quite a bit of boilerplate for dubious
+ * benefit:
+ *
+ *   - Duplicating alternates should really only lead to regressed performance.
+ *
+ *   - We don't properly resolve symlinks or mointpoints, so we may still end
+ *     up duplicating alternates.
+ *
+ *   - The value may be lying, in which case we might deduplicate alternates
+ *     that are in fact not mapping to the same directory.
+ *
+ * We should investigate whether we can remove this whole mechanism outright.
+ */
+static int odb_files_dir_paths_cmp(struct odb_source_files *files,
+				   const char *a, const char *b)
+{
+	if (files->dirs_paths_icase < 0) {
+		int icase = 0;
+		repo_config_get_bool(files->base.odb->repo, "core.ignorecase", &icase);
+		files->dirs_paths_icase = icase;
+	}
+
+	return files->dirs_paths_icase ? strcasecmp(a, b) : strcmp(a, b);
+}
+
+static int odb_files_dir_by_path_cmp(const void *cb_data,
+				     const struct hashmap_entry *entry,
+				     const struct hashmap_entry *entry_or_key,
+				     const void *keydata)
+{
+	struct odb_source_files *files = (struct odb_source_files *)cb_data;
+	const struct odb_files_dir *dir = container_of(entry, const struct odb_files_dir, by_path_entry);
+	const char *path = keydata;
+
+	if (!path)
+		path = container_of(entry_or_key, const struct odb_files_dir, by_path_entry)->abspath;
+
+	return odb_files_dir_paths_cmp(files, dir->abspath, path);
+}
+
+/*
+ * Return non-zero iff the path is usable as an alternate object directory.
+ */
+static bool odb_files_dir_is_usable(struct odb_source_files *files,
+				    const char *path)
+{
+	struct strbuf normalized_objdir = STRBUF_INIT;
+	struct hashmap_entry key;
+	bool usable = false;
+
+	strbuf_realpath(&normalized_objdir, files->dirs->abspath, 1);
+
+	/* Detect cases where alternate disappeared */
+	if (!is_directory(path)) {
+		error(_("object directory %s does not exist; "
+			"check .git/objects/info/alternates"),
+		      path);
+		goto out;
+	}
+
+	/*
+	 * Prevent the common mistake of listing the same
+	 * thing twice, or object directory itself.
+	 */
+	if (!hashmap_get_size(&files->dirs_by_path)) {
+		assert(!files->dirs->next);
+		hashmap_entry_init(&files->dirs->by_path_entry,
+				   strihash(files->dirs->abspath));
+		hashmap_add(&files->dirs_by_path, &files->dirs->by_path_entry);
+	}
+
+	if (!odb_files_dir_paths_cmp(files, path, normalized_objdir.buf))
+		goto out;
+
+	hashmap_entry_init(&key, strihash(path));
+	if (hashmap_get(&files->dirs_by_path, &key, path))
+		goto out;
+
+	usable = true;
+
+out:
+	strbuf_release(&normalized_objdir);
+	return usable;
+}
+
+static void parse_alternates(const char *string,
+			     int sep,
+			     const char *relative_base,
+			     struct strvec *out)
+{
+	struct strbuf pathbuf = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!string || !*string)
+		return;
+
+	while (*string) {
+		const char *end;
+
+		strbuf_reset(&buf);
+		strbuf_reset(&pathbuf);
+
+		if (*string == '#') {
+			/* comment; consume up to next separator */
+			end = strchrnul(string, sep);
+		} else if (*string == '"' && !unquote_c_style(&buf, string, &end)) {
+			/*
+			 * quoted path; unquote_c_style has copied the
+			 * data for us and set "end". Broken quoting (e.g.,
+			 * an entry that doesn't end with a quote) falls
+			 * back to the unquoted case below.
+			 */
+		} else {
+			/* normal, unquoted path */
+			end = strchrnul(string, sep);
+			strbuf_add(&buf, string, end - string);
+		}
+
+		if (*end)
+			end++;
+		string = end;
+
+		if (!buf.len)
+			continue;
+
+		if (!is_absolute_path(buf.buf) && relative_base) {
+			strbuf_realpath(&pathbuf, relative_base, 1);
+			strbuf_addch(&pathbuf, '/');
+		}
+		strbuf_addbuf(&pathbuf, &buf);
+
+		strbuf_reset(&buf);
+		if (!strbuf_realpath(&buf, pathbuf.buf, 0)) {
+			error(_("unable to normalize alternate object path: %s"),
+			      pathbuf.buf);
+			continue;
+		}
+
+		/*
+		 * The trailing slash after the directory name is given by
+		 * this function at the end. Remove duplicates.
+		 */
+		while (buf.len && buf.buf[buf.len - 1] == '/')
+			strbuf_setlen(&buf, buf.len - 1);
+
+		strvec_push(out, buf.buf);
+	}
+
+	strbuf_release(&pathbuf);
+	strbuf_release(&buf);
+}
+
 static int read_alternates(const char *object_dir, struct strvec *out)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -192,11 +348,70 @@ static int read_alternates(const char *object_dir, struct strvec *out)
 	return 0;
 }
 
+static void odb_add_alternate_recursively(struct odb_source_files *files,
+					  const char *path,
+					  int depth)
+{
+	struct odb_files_dir *alternate;
+	struct strvec alternates = STRVEC_INIT;
+
+	if (!odb_files_dir_is_usable(files, path))
+		goto out;
+
+	alternate = odb_files_dir_new(files->base.odb, path, false);
+
+	/* add the alternate entry */
+	*files->dirs_tail = alternate;
+	files->dirs_tail = &(alternate->next);
+
+	hashmap_entry_init(&alternate->by_path_entry, strihash(alternate->abspath));
+	if (hashmap_get(&files->dirs_by_path, &alternate->by_path_entry,
+			alternate->abspath))
+		BUG("object directory must not yet exist");
+	hashmap_add(&files->dirs_by_path, &alternate->by_path_entry);
+
+	/* recursively add alternates */
+	read_alternates(alternate->abspath, &alternates);
+	if (alternates.nr && depth + 1 > 5) {
+		error(_("%s: ignoring alternate object stores, nesting too deep"),
+		      path);
+	} else {
+		for (size_t i = 0; i < alternates.nr; i++)
+			odb_add_alternate_recursively(files, alternates.v[i], depth + 1);
+	}
+
+ out:
+	strvec_clear(&alternates);
+}
+
+static void odb_prepare_alternates(struct odb_source_files *files,
+				   const char *alternate_db)
+{
+	struct strvec alternates = STRVEC_INIT;
+
+	parse_alternates(alternate_db, PATH_SEP, NULL, &alternates);
+	read_alternates(files->dirs->abspath, &alternates);
+
+	for (size_t i = 0; i < alternates.nr; i++)
+		odb_add_alternate_recursively(files, alternates.v[i], 0);
+
+	strvec_clear(&alternates);
+}
+
 static void odb_source_files_prepare(struct odb_source *source,
 				     enum odb_prepare_flags flags)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 
+	/*
+	 * Reprepare alternates, in case the alternates file was modified
+	 * during the course of this process. This only _adds_ directories to
+	 * the linked list, so existing directories will continue to exist
+	 * for the lifetime of the process.
+	 */
+	if (flags & ODB_PREPARE_FLUSH_CACHES)
+		odb_prepare_alternates(files, NULL);
+
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
 		odb_source_prepare(&dir->loose->base, flags);
 		odb_source_prepare(&dir->packed->base, flags);
@@ -1009,23 +1224,15 @@ static int odb_source_files_fsck(struct odb_source *source,
 
 struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, const char *obj_dir)
 {
+	struct odb_source_files *files = odb_source_files_downcast(odb->source);
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
 	struct strbuf odb_path_real = STRBUF_INIT;
-	struct odb_files_dir *dir = NULL;
-	struct odb_source *source;
-
-	for (source = odb->sources; source; source = source->next) {
-		struct odb_source_files *files;
-
-		if (source->type != ODB_SOURCE_FILES)
-			continue;
-		files = odb_source_files_downcast(source);
+	struct odb_files_dir *dir;
 
-		strbuf_realpath(&odb_path_real, files->dirs->abspath, 1);
-		if (!strcmp(obj_dir_real, odb_path_real.buf)) {
-			dir = files->dirs;
+	for (dir = files->dirs; dir; dir = dir->next) {
+		strbuf_realpath(&odb_path_real, dir->abspath, 1);
+		if (!strcmp(obj_dir_real, odb_path_real.buf))
 			break;
-		}
 	}
 
 	free(obj_dir_real);
@@ -1034,14 +1241,27 @@ struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, con
 }
 
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
-					      const char *path,
-					      bool local)
+					      enum odb_new_flags flags)
 {
 	struct odb_source_files *files;
+	char *object_dir = NULL;
+	char *alternates = NULL;
+
+	if (flags & ODB_NEW_HONOR_ENV) {
+		object_dir = xstrdup_or_null(getenv(DB_ENVIRONMENT));
+		alternates = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+	}
+	if (!object_dir)
+		object_dir = xstrfmt("%s/objects", odb->repo->commondir);
 
 	CALLOC_ARRAY(files, 1);
-	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
-	files->dirs = odb_files_dir_new(odb, path, local);
+	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, object_dir, true);
+
+	hashmap_init(&files->dirs_by_path, odb_files_dir_by_path_cmp, files, 0);
+	files->dirs_paths_icase = -1;
+
+	files->dirs = odb_files_dir_new(odb, object_dir, true);
+	files->dirs_tail = &files->dirs->next;
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
@@ -1067,8 +1287,12 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	 * is not (yet) possible though because we access and assume relative
 	 * paths in the primary ODB source in some user-facing functionality.
 	 */
-	if (!is_absolute_path(path))
+	if (!is_absolute_path(object_dir))
 		chdir_notify_register(odb_source_files_reparent, files);
 
+	odb_prepare_alternates(files, alternates);
+
+	free(object_dir);
+	free(alternates);
 	return files;
 }
diff --git a/odb/source-files.h b/odb/source-files.h
index 36af0c1b8b..837e890304 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -18,6 +18,12 @@ struct odb_files_dir {
 	/* List of alternate object directories. */
 	struct odb_files_dir *next;
 
+	/*
+	 * Entry in the files source's map of directories, keyed by this
+	 * directory's path.
+	 */
+	struct hashmap_entry by_path_entry;
+
 	/* The two sources derived from this object directory. */
 	struct odb_source_loose *loose;
 	struct odb_source_packed *packed;
@@ -46,12 +52,25 @@ struct odb_source_files {
 	 * alternates.
 	 */
 	struct odb_files_dir *dirs;
+	struct odb_files_dir **dirs_tail;
+
+	/*
+	 * Map of object directories, keyed by their respective paths. This
+	 * map is used to detect the case where the same directory is
+	 * registered multiple times.
+	 */
+	struct hashmap dirs_by_path;
+
+	/*
+	 * Whether directory paths shall be compared case-insensitively, as
+	 * determined by "core.ignoreCase".
+	 */
+	int dirs_paths_icase;
 };
 
 /* Allocate and initialize a new object source. */
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
-					      const char *path,
-					      bool local);
+					      enum odb_new_flags flags);
 
 /*
  * Optimize the files object database source by repacking loose objects and
diff --git a/odb/source.c b/odb/source.c
index 30188b806d..b25ef14df8 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -24,10 +24,9 @@ const char *odb_source_type_to_name(enum odb_source_type type)
 }
 
 struct odb_source *odb_source_new(struct object_database *odb,
-				  const char *path,
-				  bool local)
+				  enum odb_new_flags flags)
 {
-	return &odb_source_files_new(odb, path, local)->base;
+	return &odb_source_files_new(odb, flags)->base;
 }
 
 void odb_source_init(struct odb_source *source,
diff --git a/odb/source.h b/odb/source.h
index 9fd2b2e5b5..6718aced6a 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -49,24 +49,9 @@ struct odb_create_on_disk_options {
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
- * on-disk format. An object database can have multiple sources:
- *
- *   - The primary source, which is typically located in "$GIT_DIR/objects".
- *     This is where new objects are usually written to.
- *
- *   - Alternate sources, which are configured via "objects/info/alternates" or
- *     via the GIT_ALTERNATE_OBJECT_DIRECTORIES environment variable. These
- *     alternate sources are only used to read objects.
+ * on-disk format.
  */
 struct odb_source {
-	struct odb_source *next;
-
-	/*
-	 * Entry in the object database's map of sources, keyed by this
-	 * source's path.
-	 */
-	struct hashmap_entry by_path_entry;
-
 	/* Object database that owns this object source. */
 	struct object_database *odb;
 
@@ -331,13 +316,11 @@ struct odb_source {
 };
 
 /*
- * Allocate and initialize a new source for the given object database located
- * at `path`. `local` indicates whether or not the source is the local and thus
- * primary object source of the object database.
+ * Allocate and initialize a new source for the given object database. The path
+ * of the source is derived from repository paths.
  */
 struct odb_source *odb_source_new(struct object_database *odb,
-				  const char *path,
-				  bool local);
+				  enum odb_new_flags flags);
 
 /*
  * Initialize the source for the given object database located at `path`.
diff --git a/odb/streaming.c b/odb/streaming.c
index 8f2143cab5..5ac172beb6 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -182,12 +182,8 @@ static int istream_source(struct odb_stream **out,
 			  struct object_database *odb,
 			  const struct object_id *oid)
 {
-	struct odb_source *source;
-
-	for (source = odb->sources; source; source = source->next)
-		if (!odb_source_read_object_stream(out, source, oid))
-			return 0;
-
+	if (!odb_source_read_object_stream(out, odb->source, oid))
+		return 0;
 	return open_istream_incore(out, odb, oid);
 }
 
diff --git a/odb/transaction.c b/odb/transaction.c
index f6f20088ec..69824a3921 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -12,7 +12,7 @@ int odb_transaction_begin(struct object_database *odb,
 	if (odb->transaction)
 		return error(_("object database transaction already pending"));
 
-	ret = odb_source_begin_transaction(odb->sources, out, flags);
+	ret = odb_source_begin_transaction(odb->source, out, flags);
 	if (!ret)
 		odb->transaction = *out;
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 52556b4543..d3c7997fb3 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -712,15 +712,13 @@ static int open_bitmap_for_source(struct odb_source_packed *source,
 static int open_bitmap(struct repository *r,
 		       struct bitmap_index *bitmap_git)
 {
-	struct odb_source *source;
+	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 	bool found = false;
 
 	assert(!bitmap_git->map);
 
-	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-
-		if (!open_bitmap_for_source(files->dirs->packed, bitmap_git))
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (!open_bitmap_for_source(dir->packed, bitmap_git))
 			found = true;
 
 		/*
diff --git a/packfile.c b/packfile.c
index 93b69d7f50..ebe430662e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -273,14 +273,13 @@ static void scan_windows(struct packed_git *p,
 
 static int unuse_one_window(struct object_database *odb)
 {
-	struct odb_source *source;
+	struct odb_source_files *files = odb_source_files_downcast(odb->source);
 	struct packfile_list_entry *e;
 	struct packed_git *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
-	for (source = odb->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		for (e = files->dirs->packed->packs.head; e; e = e->next)
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		for (e = dir->packed->packs.head; e; e = e->next)
 			scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
 	}
 
@@ -450,15 +449,14 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
 
 static int close_one_pack(struct repository *r)
 {
-	struct odb_source *source;
+	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 	struct packfile_list_entry *e;
 	struct packed_git *lru_p = NULL;
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		for (e = files->dirs->packed->packs.head; e; e = e->next) {
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		for (e = dir->packed->packs.head; e; e = e->next) {
 			if (e->pack->pack_fd == -1)
 				continue;
 			find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
@@ -1921,11 +1919,10 @@ struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed
 
 int has_object_pack(struct repository *r, const struct object_id *oid)
 {
-	struct odb_source *source;
+	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 
-	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (!odb_source_read_object_info(&files->dirs->packed->base, oid, NULL, 0, NULL))
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (!odb_source_read_object_info(&dir->packed->base, oid, NULL, 0, NULL))
 			return 1;
 	}
 
@@ -1935,14 +1932,13 @@ int has_object_pack(struct repository *r, const struct object_id *oid)
 int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 			 unsigned flags)
 {
-	struct odb_source *source;
+	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 	struct pack_entry e;
 
-	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
 		struct packed_git **cache;
 
-		cache = packfile_store_get_kept_pack_cache(files->dirs->packed, flags);
+		cache = packfile_store_get_kept_pack_cache(dir->packed, flags);
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
diff --git a/packfile.h b/packfile.h
index fd1cf0ad6c..ed3378c457 100644
--- a/packfile.h
+++ b/packfile.h
@@ -69,20 +69,20 @@ void packfile_store_add_pack(struct odb_source_packed *store,
 struct packfile_list_entry *packfile_store_get_packs(struct odb_source_packed *store);
 
 struct repo_for_each_pack_data {
-	struct odb_source *source;
+	struct odb_files_dir *dir;
 	struct packfile_list_entry *entry;
 };
 
 static inline struct repo_for_each_pack_data repo_for_eack_pack_data_init(struct repository *repo)
 {
 	struct repo_for_each_pack_data data = { 0 };
+	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
 
-	for (struct odb_source *source = repo->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct packfile_list_entry *entry = packfile_store_get_packs(files->dirs->packed);
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		struct packfile_list_entry *entry = packfile_store_get_packs(dir->packed);
 		if (!entry)
 			continue;
-		data.source = source;
+		data.dir = dir;
 		data.entry = entry;
 		break;
 	}
@@ -92,23 +92,22 @@ static inline struct repo_for_each_pack_data repo_for_eack_pack_data_init(struct
 
 static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *data)
 {
-	struct odb_source *source;
+	struct odb_files_dir *dir;
 
 	data->entry = data->entry->next;
 	if (data->entry)
 		return;
 
-	for (source = data->source->next; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct packfile_list_entry *entry = packfile_store_get_packs(files->dirs->packed);
+	for (dir = data->dir->next; dir; dir = dir->next) {
+		struct packfile_list_entry *entry = packfile_store_get_packs(dir->packed);
 		if (!entry)
 			continue;
-		data->source = source;
+		data->dir = dir;
 		data->entry = entry;
 		return;
 	}
 
-	data->source = NULL;
+	data->dir = NULL;
 	data->entry = NULL;
 }
 
diff --git a/path.c b/path.c
index c3a709a928..4608a56927 100644
--- a/path.c
+++ b/path.c
@@ -396,7 +396,7 @@ static void adjust_git_path(struct repository *repo,
 		strbuf_splice(buf, 0, buf->len,
 			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
-		replace_dir(buf, git_dir_len + 7, repo->objects->sources->path);
+		replace_dir(buf, git_dir_len + 7, repo->objects->source->path);
 	else if (repo_settings_get_hooks_path(repo) && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, repo_settings_get_hooks_path(repo));
 	else if (repo->different_commondir)
diff --git a/prune-packed.c b/prune-packed.c
index d49dc11957..b6749b8d13 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -40,7 +40,7 @@ void prune_packed_objects(int opts)
 		progress = start_delayed_progress(the_repository,
 						  _("Removing duplicate objects"), 256);
 
-	for_each_loose_file_in_source(the_repository->objects->sources,
+	for_each_loose_file_in_source(the_repository->objects->source,
 				      prune_object, NULL, prune_subdir, &opts);
 
 	/* Ensure we show 100% before finishing progress */
diff --git a/repack.c b/repack.c
index e20431690c..53c34197f3 100644
--- a/repack.c
+++ b/repack.c
@@ -59,7 +59,7 @@ void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 				  bool wrote_incremental_midx)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct odb_source_files *files = odb_source_files_downcast(repo->objects->sources);
+	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
 	struct multi_pack_index *m = get_multi_pack_index(files->dirs->packed);
 	strbuf_addf(&buf, "%s.pack", base_name);
 	if (m && files->base.local && midx_contains_pack(m, buf.buf)) {
@@ -158,7 +158,7 @@ void existing_packs_collect(struct existing_packs *existing,
 			string_list_append(&existing->non_kept_packs, buf.buf);
 	}
 
-	existing->source = existing->repo->objects->sources;
+	existing->source = existing->repo->objects->source;
 
 	string_list_sort(&existing->kept_packs);
 	string_list_sort(&existing->non_kept_packs);
diff --git a/repository.c b/repository.c
index b857e1c580..fa4214ff41 100644
--- a/repository.c
+++ b/repository.c
@@ -126,9 +126,9 @@ const char *repo_get_common_dir(struct repository *repo)
 
 const char *repo_get_object_directory(struct repository *repo)
 {
-	if (!repo->objects->sources)
+	if (!repo->objects->source)
 		BUG("repository hasn't been set up");
-	return repo->objects->sources->path;
+	return repo->objects->source->path;
 }
 
 const char *repo_get_index_file(struct repository *repo)
diff --git a/setup.c b/setup.c
index 29474fc292..bc7d451917 100644
--- a/setup.c
+++ b/setup.c
@@ -2669,7 +2669,7 @@ void create_object_database(struct repository *repo,
 
 	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
 
-	if (odb_source_create_on_disk(repo->objects->sources, &opts) < 0)
+	if (odb_source_create_on_disk(repo->objects->source, &opts) < 0)
 		die(_("failed creating object database"));
 }
 
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index a75c817e47..62e2384052 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -78,7 +78,7 @@ int cmd__read_graph(int argc, const char **argv)
 	int ret = 0;
 
 	setup_git_directory(the_repository);
-	source = the_repository->objects->sources;
+	source = the_repository->objects->source;
 
 	prepare_repo_settings(the_repository);
 
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 2f2ffbbc7d..3debb60270 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -60,7 +60,7 @@ static void tmp_objdir_reparent(const char *old_cwd,
  */
 static void tmp_objdir_restore_source(struct tmp_objdir *t)
 {
-	struct odb_source_files *files = odb_source_files_downcast(t->repo->objects->sources);
+	struct odb_source_files *files = odb_source_files_downcast(t->repo->objects->source);
 	struct odb_files_dir *cur_dir = files->dirs;
 
 	if (t->temp_dir != files->dirs)
@@ -159,7 +159,7 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 				     const char *prefix,
 				     int will_destroy)
 {
-	struct odb_source_files *files = odb_source_files_downcast(r->objects->sources);
+	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 	static int installed_handlers;
 	struct tmp_objdir *t;
 

-- 
2.56.0.379.gc618271300.dirty

