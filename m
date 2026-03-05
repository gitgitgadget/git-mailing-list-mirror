Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF083248F6F
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720401; cv=none; b=cy4a4i1an1FolbRyGcum1KqeTMA1Et45Y0quy3u7KIm4GxDoMt1Yxt1lnL5dt7RvsZ0aJ3yPpylYoK2ZUlAt1Ei33VkcSSlEhtmKWo5ogpWwNTTZkaPzGeHVqqwpEhtlK5XuGUrhaQNyC4hn7ampqLLqm7Jxw/igd9c+DRJVILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720401; c=relaxed/simple;
	bh=SPpOHYTgp7x179i1q/M3oOyLCryYy61iinEJYXZIK/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSo8zGlKj9CTeVlSQjMp8PiLAbwnYNjf9FIxabrvCmQymCTSKODoPDYGBjq5VsPsmcOW+OieBKBiWL3gbKfWqx1Y5dzKzD09qEqV4tSlwPQjbz/Qt+McvoycLAbp9It5qoEBh+i5bE/TbQlsM7NWGjo6r/bGxaGdEGzVj+0gLCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m82T/ZeN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bbv/HrKO; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m82T/ZeN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bbv/HrKO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A7577A01F4;
	Thu,  5 Mar 2026 09:19:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 09:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720398;
	 x=1772806798; bh=Pf9bwrLfskpG7obKi8pMev37fsmSa10CvQW4oJV8Sss=; b=
	m82T/ZeNL1BzOdccKuXabyuGme6lFRKk2Xicfge0C/lBrswAjZ+MXrm4xL1w1dAI
	JrWFxA0KoQxGqSDTY8gbk7vIB/ycJpwhMPTuaD8tleH70XEw87L8kwlnCmR0Bsgh
	LFfvtKKzl/IYX7yI2aTd90TRb8K/zEvr+V/l/rr4osZbLuDhcVLeD5t0ITEVaoJP
	autnV6rk0YbNhmzuPVLBxaLJOVlpz0iL2pkFQod2RCo2KhFfMHvtiyjH0o9keGfj
	bncAr3TlwTQMI5FAjWX5FYvSK7UQLhO9FVXjuyzj0QYid/GBbBWyT4/wGGtHqzhv
	hIMNlfEgxkidKVSagyHmGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720398; x=
	1772806798; bh=Pf9bwrLfskpG7obKi8pMev37fsmSa10CvQW4oJV8Sss=; b=b
	bv/HrKOfx6Ea70hSJJjmnEsVeddorLVYGyoCUudHZYUIL6cxjiw8JQMA8gObaMzM
	wW9u8djlp/83DwK3SdijSghu++g43Xsr4I+nkHaHpg+k9jx/rVPTUaUA8ozmyZzs
	XtqiM1/skPC9zFBmTne9BIP9OKEUgrVNc1hwHu7bL8L1pYZtMbDeDFiDqREUPX4S
	8irj2yu/62K4AYrastyoQ3G4GLgjLtf5vsU/vEn/GxH6Rk9B+hGw+1fNzu7eNT+X
	+DuhEIOtRBashoQHlhkPx0aLjjxkKCcp2QHf8j72MGCu9DavEG/qn1zGnB57ua5z
	uaH6XU4T5nt5W5TuUddYA==
X-ME-Sender: <xms:DpGpaS7e39uVA0inwBkbYs_9om_X2JPiKQY7zKCz9HRmIXVDKePUJw>
    <xme:DpGpaS6uhdm3ORbK4mw_jTrnzJn6M8HuMNx7uMicem5K3tW6MD91F11VxoghD8fzh
    dfvd_OPvHEnimGtGSu7pT6qoTFNfQ3zunuEEw4LiyOzlZbk8hzYEQ>
X-ME-Received: <xmr:DpGpaWeLupzJ1R-72xyzRFSplUvcu7IFCWm2hUxxJlv11ICk7wsN2zgTFxE11JF53oCGcHW_hZRe6-nsscUjsOfseDTqHNjBKjgRo1ISy42Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DpGpaeDyvwLwsk_bIbwBlJm0G2sjj_P_E21VnwuAC2vp3OpcDm14OQ>
    <xmx:DpGpaR_fsHO7vIk5BW_La_rxd8BnDGsQWtediYlYOUZAAhjT8UZhvw>
    <xmx:DpGpaRIo7wuIwt9WQo7m6QN9GibLMFxc543HFwLoZ2EzCFIW0L0sEA>
    <xmx:DpGpaShPVwfKQlWoLJCoCdMSyPSZwTvaz5FXSCVZgspJB0V4cjiwAw>
    <xmx:DpGpaV9Y8BvwBnwJGaepNxlBn3BEXCuhuBgTUSN0RTvQI5DkRlW0_qyr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:19:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b797c5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:19:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:44 +0100
Subject: [PATCH v2 04/17] odb: move reparenting logic into respective
 subsystems
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-4-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The primary object database source may be initialized with a relative
path. When the process changes its current working directory we thus
have to update this path and have it point to the same path, but
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
2.53.0.797.g7842e34a66.dirty

