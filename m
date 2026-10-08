Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D246EF98
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448590; cv=none; b=pvqbIXNEsjusbyrD253Wy5vCyeKGlY0qaPfiQ8/aKX6fneCtiHlcR0rknQ2O6aVvSt/E+KyX5E3Ge9OyIqlZz9MuKsXBt8uk5novn99klUNWojKsVl7As8VX4It5QHZswo41jwDonhD7LxEFy+3xZj38YO9Ywz+rbgpmjQ5wzfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448590; c=relaxed/simple;
	bh=KWTRRqGl+oBMEsDYynw9ZEssPv8LOGfIAzMEMUJIK5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pCI+TYJNXVC5INSkDXTwmgnOD/hyL6H9Z3CeiNp6YvCEwBU2kej8ajYTF5X/KrZUSVvlkffFjNdeLuNh7vZQY2khLtTHzA9AaYLGMO8Xej5Kqr7xMtSbxEaDTDdPmuv3u6Ku+7xaiZNVCIToBhuF0LO6peA6zQmHoFr2YVsS4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eGO5go/C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yaEPqLv5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eGO5go/C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yaEPqLv5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 29C94EC0053
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 08 Oct 2026 04:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448588;
	 x=1791534988; bh=TVif3WCCN0msp1nAQCtB1u4kEQ5EOWG/CwVBPDoZ9wo=; b=
	eGO5go/CBqBW8kCpidnfiHTdlEprTjzkCoLnb4Hlt7FinN9yiOCD1DtKWWxJdbNO
	qbJlqmIsxaoYA6y+VZARD45I7+VTxhyETbKfWabD+4bE0/l7WXSNp3TeDvGKDNF7
	labJnNyzheMztpHrV5lb4NjpjE0dKJHe8tjqxJceDijvbzDgc2ATSzYzPj2Ubb+M
	8bh/vSRReH0EBfG1zngxtuzmipFSWVwd5Hc9YmAQrh8K9W2j5BhbWYn/qGFRrJ18
	qNBDmWoyIDk7fVKG1QtBdkHmVz//U5/wZIz2yPptDWf/Z/mEPR8GqMCj9LgfUZgl
	F0Hys+VfOKv00N35UdZrzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448588; x=
	1791534988; bh=TVif3WCCN0msp1nAQCtB1u4kEQ5EOWG/CwVBPDoZ9wo=; b=y
	aEPqLv5Vr6WOPBuQ0mikWhJZTzXR5DEAYYS0irV2TqauiZ8FN3jsYo0pH4okhqo1
	IfqbB3OiK6R63LMFHkJvUJHpRRvQ6fRrzczjn2sbwEeNcWX8lM2KPQ8R4hQzTzhN
	G2TRL0jSZDjMbMsKFy99AYYSGrER7wytR2irXOv+LqMokeuVZPPOS8w1ggAQuKuY
	6XNwSPxfcdMoSZv2M9EKBA9P/tJekyBtZOFtUIzZzLdpoO9OrnkCyYHEs6IHn2Au
	rnsMNDQQGbSHLH9VOo/Sc/+aQaEu/Un9J4vYaaaTWR4JueszCY3KqOdYSUAix/Un
	bSEoD/W1ZEGKNKqPCanVg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448588; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nRmdW+qKCBJn2HtNFFIf1EPZBsIlDj+U6+vukD+tZSyToTT
	dw/J4Fz73BpBu5LiAoBUyoU2UjmiedFNd4DEuGTcMh0o5bPJW1/U94Us/PF7JYea
	BiLaVBBwvT/SK2HosVFHbCEllFJLKW4HVqBsMONj+JfKCXu10t5BrYQP4FC9d49e
	CNdLHbFjpJ0W71jWalMvP/vgZy9Psxd9he5HFgxY+uFByWSSuoRj71CRVJ/Z4OmO
	KtZJu2WdoWj1KBeK6N3ZkhzZuVS/K+XhVxP3MfQClSvB4z/dg3teDbyhbADdErAe
	KD3NUzcinO4Rd1imYqMA8PRd2eCUpBQB08YZDYg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4l4ML7UV74VpSlWRkD8/dmeL57igbTgncIVuQ2snV2s=:KWTRRqGl+oBMEsDYynw9ZEssPv8LOGfIAzMEMUJIK5M=;
X-ME-Sender: <xms:DFbHal8kJXIL6PiRHVTtg_5iYXnBs0BDS-IsPdXQQUUDWx50Jee8RA>
    <xme:DFbHavt1pbpvVtK41xf5nhMRnqkpzZtNmV7mPsJ0y5dJupu_BSVhdZjBenKQ0IHd5
    WQK7BsiGbQVa34mBz-wPyebMz8OhNj3_dK8dyyJGqng6lVz7GxW9dE>
X-ME-Received: <xmr:DFbHagq0H8LvnPhG40M5Rd06x3lVjZwQRRmwvjTJHwATq3PRJV5ovQ>
X-ME-Proxy-Cause: dmFkZTFMGpXxnK42Rq6iYV3I2uYmG3BxizFEOsUaaQexV4Dp9EnK1tnMOTu4E8Ppe5iMqg
    9CkbBUPXFdP9jwEGVDOZSwmWvsD7DXTVYRjSZzbyvONhawRyAdzVXeq8VZGGa0G00PNA1X
    +ycB5EgRH0XmXgbI7KmpoUC+Svp+LOWaMIShZJVwgjRS99pxgu3Xw9h3zHqzu9iq8jxhLw
    9zLLHVLfkgYGtlMrqvh4QLphpvuHJEkr4WMJ1/4m+aaVeJ+qOniJVqK+98/hElR8tzOZoI
    hj/O4Kq6WgWr04r4wqAhTgiROpeL1/khSa3WwGNalObIJe8b5ShHYmDvy04dQ3A6xd+yte
    ORVm09Ko4Rdhm4AjvNSrEo1UDza+Eiol1OB1ydDLll9nd6wgubbyptkbU+OyqRf01z17o1
    HojX1neA8jeSied6JN7xcbkuXfxiql27+KaV3YA/KXE5hxJMula8X05ZAMqhBqoVCq66f6
    I8u2rpFgcQLokyPSSwmKU9FEE52k1ag90ZEKLY1SuPQtUpKd2oJiDUitX7wTQGC8yr2KVx
    IGB8hZZ2OxFEoQ5Hc1c54XrKEPf9plJDVcFdyez1EC8n9KtlnTFhN8AsmAKllpBqXRRZPp
    641NRzY87j1FTJyvepSJyljL1Z9eDynvt52dJLo+4ztuCBNNiXdLvzUYwPCA
X-ME-Proxy: <xmx:DFbHakntUvBXFZyD2So8O_wALvDZDmx3kRinXJ0FK9k7omQ5BeOGBw>
    <xmx:DFbHaswbkcv6gAwCVaswEnZOOsWQJn_jQFlheiGC_YW7xzz0hQ8Npg>
    <xmx:DFbHakkJajF5mNsXzasfAVMy9_RLLbEmfLFPyg9z3FRfbQR8IRaVRA>
    <xmx:DFbHatc8XgeG9NDe_svvt3aQeqCWhUlcasL-jGUs9SXfmqf7aP-ccw>
    <xmx:DFbHaksNh_apcUhtaxaIw_-KH7yvbf5m9UMlFOfzwBn7Q_4Yqz6CJPlg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 931e7786 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 10:35:58 +0200
Subject: [PATCH v2 08/13] tmp-objdir: manage quarantine as an object
 directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-odb-move-alternates-v2-8-b47e8189baa5@pks.im>
References: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

When creating a quarantine directory via the "tmp-objdir" subsystem we
create a new "files" backend that new objects part of the transaction
can be written to. In a future commit though we'll move handling of
alternates into the "files" backend, and as part of that it will no
longer be possible for us to have multiple sources attached to a single
object database.

In a preceding commit, we have prepared the "files" backend to be able
to handle multiple object directories. We don't use that mechanism for
alternates yet, but will start doing so in a subsequent commit. But with
that infrastructure ready we can already migrate tmp-objdirs over to use
this new mechanism.

Adapt the subsystem so we create a `struct odb_files_dir` instead of a
new "files" source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c |  4 ++--
 tmp-objdir.c  | 48 +++++++++++++++++++++++++++++-------------------
 tmp-objdir.h  |  4 ++--
 3 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/object-file.c b/object-file.c
index a4cbf8b081..fe9139c96d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -488,7 +488,7 @@ struct odb_transaction_files {
 	enum odb_transaction_flags flags;
 
 	struct tmp_objdir *objdir;
-	struct odb_source *quarantine;
+	struct odb_files_dir *quarantine;
 	struct transaction_packfile packfile;
 	const char *prefix;
 
@@ -1443,7 +1443,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 			return -1;
 		}
 
-		odb_source_prepare(transaction->quarantine,
+		odb_source_prepare(&transaction->quarantine->packed->base,
 				   ODB_PREPARE_FLUSH_CACHES);
 	}
 
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 31a7920be7..a3903b6e6d 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -12,13 +12,17 @@
 #include "quote.h"
 #include "odb.h"
 #include "odb/source.h"
+#include "odb/source-files.h"
+#include "odb/source-loose.h"
+#include "odb/source-packed.h"
 #include "repository.h"
 
 struct tmp_objdir {
 	struct repository *repo;
 	struct strbuf path;
 	struct strvec env;
-	struct odb_source *prev_source;
+	struct odb_files_dir *temp_dir;
+	struct odb_files_dir *orig_dir;
 	int will_destroy;
 };
 
@@ -57,18 +61,19 @@ static void tmp_objdir_reparent(const char *old_cwd,
  */
 static void tmp_objdir_restore_source(struct tmp_objdir *t)
 {
-	struct odb_source *cur_source = t->repo->objects->sources;
+	struct odb_source_files *files = odb_source_files_downcast(t->repo->objects->sources);
+	struct odb_files_dir *cur_dir = files->dirs;
 
-	if (strcmp(t->path.buf, cur_source->path))
+	if (t->temp_dir != files->dirs)
 		BUG("expected %s as primary object store; found %s",
-		    t->path.buf, cur_source->path);
+		    t->temp_dir->abspath, cur_dir->abspath);
 
-	if (cur_source->next != t->prev_source)
+	if (t->temp_dir->next != t->orig_dir)
 		BUG("we expect the old primary object store to be the first alternate");
 
 	t->repo->disable_ref_updates = false;
-	t->repo->objects->sources = t->prev_source;
-	odb_source_free(cur_source);
+	files->dirs = t->orig_dir;
+	odb_files_dir_free(cur_dir);
 }
 
 int tmp_objdir_destroy(struct tmp_objdir *t)
@@ -81,7 +86,7 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 	if (t == the_tmp_objdir)
 		the_tmp_objdir = NULL;
 
-	if (t->prev_source)
+	if (t->orig_dir)
 		tmp_objdir_restore_source(t);
 
 	err = remove_dir_recursively(&t->path, 0);
@@ -315,11 +320,11 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (!t)
 		return 0;
 
-	if (t->prev_source) {
-		if (t->repo->objects->sources->will_destroy)
+	if (t->orig_dir) {
+		if (t->will_destroy)
 			BUG("migrating an ODB that was marked for destruction");
 		tmp_objdir_restore_source(t);
-		t->prev_source = NULL;
+		t->orig_dir = NULL;
 	}
 
 	strbuf_addbuf(&src, &t->path);
@@ -341,10 +346,12 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
 	return t->env.v;
 }
 
-struct odb_source *tmp_objdir_replace_primary_odb(struct tmp_objdir *t,
-						  int will_destroy)
+struct odb_files_dir *tmp_objdir_replace_primary_odb(struct tmp_objdir *t,
+						     int will_destroy)
 {
-	if (t->prev_source)
+	struct odb_source_files *files = odb_source_files_downcast(t->repo->objects->sources);
+
+	if (t->temp_dir)
 		BUG("the primary object database is already replaced");
 	t->will_destroy = will_destroy;
 
@@ -353,11 +360,14 @@ struct odb_source *tmp_objdir_replace_primary_odb(struct tmp_objdir *t,
 	 * alternate. Disable ref updates while a temporary source is active,
 	 * since the objects in the database may roll back.
 	 */
-	t->prev_source = t->repo->objects->sources;
-	t->repo->objects->sources = odb_source_new(t->repo->objects, t->path.buf, false);
-	t->repo->objects->sources->next = t->prev_source;
-	t->repo->objects->sources->will_destroy = will_destroy;
+	t->temp_dir = odb_files_dir_new(t->repo->objects, t->path.buf, false);
+	t->temp_dir->loose->base.will_destroy = will_destroy;
+	t->temp_dir->packed->base.will_destroy = will_destroy;
+	t->temp_dir->next = files->dirs;
+
+	t->orig_dir = files->dirs;
+	files->dirs = t->temp_dir;
 	t->repo->disable_ref_updates = true;
 
-	return t->repo->objects->sources;
+	return t->temp_dir;
 }
diff --git a/tmp-objdir.h b/tmp-objdir.h
index 05f0d08d10..5ed0db1ee0 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -61,7 +61,7 @@ void tmp_objdir_discard_objects(struct tmp_objdir *);
  * If will_destroy is nonzero, the object directory may not be migrated. Returns
  * the newly installed primary source.
  */
-struct odb_source *tmp_objdir_replace_primary_odb(struct tmp_objdir *,
-						  int will_destroy);
+struct odb_files_dir *tmp_objdir_replace_primary_odb(struct tmp_objdir *,
+						     int will_destroy);
 
 #endif /* TMP_OBJDIR_H */

-- 
2.56.0.406.ga2d225a756.dirty

