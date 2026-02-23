Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97B30BBA9
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863498; cv=none; b=U0dqRYnvs7tXg3C2GVnzmcGwywmT6oLmeL17cc1EKcoCvTBetALh3jGVab3v8qNRkgN/x64FfsmqbbfUiL6ATrsdqQ6lyPQjNs5u3P/Ln+OXC4yTFvCf/PVky9EunAchFpySZ1bMbN+XKgHFEvfQtlkb5FtqVRAa3ZV8XO2L8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863498; c=relaxed/simple;
	bh=Hu7h+y9lu2jjF7JpgeuB4wC+OH7fflGNyy+Hh/fbQC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwDLFuLE5jAxT4812B9QpSJchvQXHefHuwz3c/RJ3TMLa844Yjn7QfhHF+WgjGWyDyMdw1c8G9GMty7v1P0en2GgLPixE1ihpHaC+tLIqDDM70o6z7KiBy6qWopi91RwBzHeuO5CjzDnwzuZkMT2ENnrCyK/QH6WAZdlojubuTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EtJS/xwf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AKTKOriT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EtJS/xwf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AKTKOriT"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 57DE3EC054E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 23 Feb 2026 11:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863496;
	 x=1771949896; bh=rhRiEFGd5s8gANgWczoNzCk4N9Pc5GBHyb+0rYyEIRU=; b=
	EtJS/xwfOueBlgjjNW90bB8uIzua+FFrDa+zDOUxPY1A2YpufmEde+uwWbSqN7I5
	JNawkEW5UGEAqqgx5SZFEGVuoCnu1080CsGqPYVbEiOLsaMNbEFM76KlJRVznIHK
	znBOB+de51Z6HlNgdWwQHbd7zUqCDzKVQ+HpQS75EPoNfi+u106SwtUiFx9bWAYU
	IR7hMqUHcQiNHveU5GTwotkWRb9YXwb5mNtW7GCXycwU7MBycusnD+cVARBRpZDd
	LRIwguRRoT47IBq+O/E1/kuqyf1RErJIDca6AmDIX1tBQdno9Vown1/zQB3ZpurR
	/OIAbfDFoLf28dkl+c83qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863496; x=
	1771949896; bh=rhRiEFGd5s8gANgWczoNzCk4N9Pc5GBHyb+0rYyEIRU=; b=A
	KTKOriT8NA3EbJt8SP42KV456H7wv20mZ1Qgx0WU5dk6dIasPiZueJv7SV2AwDmV
	jstOu5ImcRdbZAqfR2Pzh4kZOhWyOzeEyviNzkwOkqQHaOxOQq41rygggAhGLzvk
	OkNUPF8UrKWc55GfuKu0wrOVG8yAtLn+OEhnICLXDKc/wnVHSZJj1pHJM9vUlQx3
	zM3SCBOzPfrVfueGH2EXqeuBBzIjQxWN84ldgR01g0kyO+VboI6VkI2owdKeHf7g
	nlzxiLcXcnL8PA/0PDVnB1C2N4tzxJ57yF+JBhbaKfuUAadDXhcP6GSZdwU92AFT
	I3kSF080FOrW8mnzxI1hg==
X-ME-Sender: <xms:yH2caaPJnCpqmpc9BbEfV9RZoxfbwHd60qu-ayPnUWTvlACdfw4FKg>
    <xme:yH2caf5gzuSwv90UYpU6fu7RtqxtUT6D14X-3INDo87jckPBJGGybxQwmz3QuMvm6
    mTrkj7ntqPV-3nYiy1BE5_eWZ4BPVxpp3-1oLbF3gVMEfY19RFSk4M>
X-ME-Received: <xmr:yH2caW7rTQFl83YJNwA0us1KkpmrxYSPvX2dzYpCPc7R3B2kOjVmpubGTwkJ2TWj-3pgjebq1P0eOm5DvpSjkuPlS9m59-fTnDNziOaOtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:yH2caf2Sj2WdjZjzTLnLP5i3Zl8692fB1pPGDpqDnSvg64m5ni9HYQ>
    <xmx:yH2caSXZkcT2i02yA1o4_bpkgQ_V6x4zJjmazL9ZrOl_fb23uCiBMA>
    <xmx:yH2caa6f98D2_1xSfW6VzASEqMNVirBre3QqkYhoXSzO5Is0qqZpDg>
    <xmx:yH2caZJaTMq_rObaJZPfPaVpPSZBiVdysxBI1wB5cmteQcQWQGMGxw>
    <xmx:yH2caa-bMsWeXIFV9XH6rrDoFZEVBQovY_ydm0ke9r92E6y-swwjsFPV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e7be89a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:17:55 +0100
Subject: [PATCH 04/17] odb: move reparenting logic into respective
 subsystems
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-4-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The primary object database source may be initialized with a relative
path. When reparenting the process to a different working directory we
thus have to update this path and have it point to the same path, but
relative to the new working directory.

This logic is handled in the object database layer. It consists of three
steps:

  1. We undo any potential temporary object directory, which are used
     for transactions. This is done so that we don't end up modifying
     the temporary object database source that got applied for the
     transaction.

  2. We then iterate through the non-transactional sources and reparent
     their respective paths.

  3. We reapply the temporary object directory, but update its path.

All of this logic is heavily tied to how the object database source
handles paths in the first place. It's an internal implementation
detail, and as sources may not even use an on-disk path at all it is not
a mechanism that applies to all potential sources.

Refactor the code so that the logic to reparent the sources is hosted by
the "files" source and the temporary object directory subsystems,
respectively. This logic is easier to reason about, but it also ensures
that this logic is handled at the correct level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              | 37 -------------------------------------
 odb/source-files.c | 23 +++++++++++++++++++++++
 tmp-objdir.c       | 42 +++++++++++++++++++-----------------------
 tmp-objdir.h       | 15 ---------------
 4 files changed, 42 insertions(+), 75 deletions(-)

diff --git a/odb.c b/odb.c
index e5aa8deb88..86f7cf70a8 100644
--- a/odb.c
+++ b/odb.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "chdir-notify.h"
 #include "commit-graph.h"
 #include "config.h"
 #include "dir.h"
@@ -1037,38 +1036,6 @@ int odb_write_object_stream(struct object_database *odb,
 	return odb_source_loose_write_stream(odb->sources, stream, len, oid);
 }
 
-static void odb_update_commondir(const char *name UNUSED,
-				 const char *old_cwd,
-				 const char *new_cwd,
-				 void *cb_data)
-{
-	struct object_database *odb = cb_data;
-	struct tmp_objdir *tmp_objdir;
-	struct odb_source *source;
-
-	tmp_objdir = tmp_objdir_unapply_primary_odb();
-
-	/*
-	 * In theory, we only have to do this for the primary object source, as
-	 * alternates' paths are always resolved to an absolute path.
-	 */
-	for (source = odb->sources; source; source = source->next) {
-		char *path;
-
-		if (is_absolute_path(source->path))
-			continue;
-
-		path = reparent_relative_path(old_cwd, new_cwd,
-					      source->path);
-
-		free(source->path);
-		source->path = path;
-	}
-
-	if (tmp_objdir)
-		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
-}
-
 struct object_database *odb_new(struct repository *repo,
 				const char *primary_source,
 				const char *secondary_sources)
@@ -1089,8 +1056,6 @@ struct object_database *odb_new(struct repository *repo,
 
 	free(to_free);
 
-	chdir_notify_register(NULL, odb_update_commondir, o);
-
 	return o;
 }
 
@@ -1136,8 +1101,6 @@ void odb_free(struct object_database *o)
 
 	string_list_clear(&o->submodule_source_paths, 0);
 
-	chdir_notify_unregister(NULL, odb_update_commondir, o);
-
 	free(o);
 }
 
diff --git a/odb/source-files.c b/odb/source-files.c
index a43a197157..df0ea9ee62 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1,13 +1,28 @@
 #include "git-compat-util.h"
+#include "abspath.h"
+#include "chdir-notify.h"
 #include "object-file.h"
 #include "odb/source.h"
 #include "odb/source-files.h"
 #include "packfile.h"
 
+static void odb_source_files_reparent(const char *name UNUSED,
+				      const char *old_cwd,
+				      const char *new_cwd,
+				      void *cb_data)
+{
+	struct odb_source_files *files = cb_data;
+	char *path = reparent_relative_path(old_cwd, new_cwd,
+					    files->base.path);
+	free(files->base.path);
+	files->base.path = path;
+}
+
 void odb_source_files_free(struct odb_source_files *files)
 {
 	if (!files)
 		return;
+	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
 	odb_source_loose_free(files->loose);
 	packfile_store_free(files->packed);
 	odb_source_release(&files->base);
@@ -25,5 +40,13 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->loose = odb_source_loose_new(&files->base);
 	files->packed = packfile_store_new(&files->base);
 
+	/*
+	 * Ideally, we would only ever store absolute paths in the source. This
+	 * is not (yet) possible though because we access and assume relative
+	 * paths in the primary ODB source in some user-facing functionality.
+	 */
+	if (!is_absolute_path(path))
+		chdir_notify_register(NULL, odb_source_files_reparent, files);
+
 	return files;
 }
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 9f5a1788cd..e436eed07e 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -36,6 +36,21 @@ static void tmp_objdir_free(struct tmp_objdir *t)
 	free(t);
 }
 
+static void tmp_objdir_reparent(const char *name UNUSED,
+				const char *old_cwd,
+				const char *new_cwd,
+				void *cb_data)
+{
+	struct tmp_objdir *t = cb_data;
+	char *path;
+
+	path = reparent_relative_path(old_cwd, new_cwd,
+				      t->path.buf);
+	strbuf_reset(&t->path);
+	strbuf_addstr(&t->path, path);
+	free(path);
+}
+
 int tmp_objdir_destroy(struct tmp_objdir *t)
 {
 	int err;
@@ -51,6 +66,7 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 
 	err = remove_dir_recursively(&t->path, 0);
 
+	chdir_notify_unregister(NULL, tmp_objdir_reparent, t);
 	tmp_objdir_free(t);
 
 	return err;
@@ -137,6 +153,9 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX",
 		    repo_get_object_directory(r), prefix);
 
+	if (!is_absolute_path(t->path.buf))
+		chdir_notify_register(NULL, tmp_objdir_reparent, t);
+
 	if (!mkdtemp(t->path.buf)) {
 		/* free, not destroy, as we never touched the filesystem */
 		tmp_objdir_free(t);
@@ -315,26 +334,3 @@ void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
 							  t->path.buf, will_destroy);
 	t->will_destroy = will_destroy;
 }
-
-struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
-{
-	if (!the_tmp_objdir || !the_tmp_objdir->prev_source)
-		return NULL;
-
-	odb_restore_primary_source(the_tmp_objdir->repo->objects,
-				   the_tmp_objdir->prev_source, the_tmp_objdir->path.buf);
-	the_tmp_objdir->prev_source = NULL;
-	return the_tmp_objdir;
-}
-
-void tmp_objdir_reapply_primary_odb(struct tmp_objdir *t, const char *old_cwd,
-		const char *new_cwd)
-{
-	char *path;
-
-	path = reparent_relative_path(old_cwd, new_cwd, t->path.buf);
-	strbuf_reset(&t->path);
-	strbuf_addstr(&t->path, path);
-	free(path);
-	tmp_objdir_replace_primary_odb(t, t->will_destroy);
-}
diff --git a/tmp-objdir.h b/tmp-objdir.h
index fceda14979..ccf800faa7 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -68,19 +68,4 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
  */
 void tmp_objdir_replace_primary_odb(struct tmp_objdir *, int will_destroy);
 
-/*
- * If the primary object database was replaced by a temporary object directory,
- * restore it to its original value while keeping the directory contents around.
- * Returns NULL if the primary object database was not replaced.
- */
-struct tmp_objdir *tmp_objdir_unapply_primary_odb(void);
-
-/*
- * Reapplies the former primary temporary object database, after potentially
- * changing its relative path.
- */
-void tmp_objdir_reapply_primary_odb(struct tmp_objdir *, const char *old_cwd,
-		const char *new_cwd);
-
-
 #endif /* TMP_OBJDIR_H */

-- 
2.53.0.536.g309c995771.dirty

