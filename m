Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DCD46E002
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935732; cv=none; b=Zmz6HFiHVNOHhBdLrk3Mho4lLGJD9e3rSWjGY3wLI91qxzpDq8vWLiSlzBPDKcKczmoV9LG0Cj03GmE4gVJpksSo/p3n6KrJq6E++aOZ+f9uTuyBoHhQwYC84HSRwEp0+cPCRDAiMi6XtrPmZboGsKX6KjjvwUkc6ipc+i0CU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935732; c=relaxed/simple;
	bh=NqZXA0yEr8s+wAmhXPNn6rv77eY6J9BTvQPYWt6kryc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=odTucIhp813cUo6HZ0uxll22KYHn3NxX39E9SaQ5gEuMG/Wt6d0XzBB2zHMMd2usKTB8kEujHgYdN+k//pF6BNWrQCyaLVUUM2VPNonWtohmEgUvyb+Klzn5wrHe4vS3de5t3dxvsvFvLlz5iNoYyrXt/JXdnwy0D+4TXSI6jmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c8DX5ezY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TCX8JPSQ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c8DX5ezY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TCX8JPSQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A14C14000F5
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 06:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935729;
	 x=1791022129; bh=udyNZ3ofWbtZEcalaaqxelqRtjY4ZkLhmYCVgWDeQJI=; b=
	c8DX5ezYTNJ2+K4xvLzg7/l8QvkVy2HxE/YdOU83a88ma2jMvV6Gkc/RmuXC2Fvo
	O4U4VwmPueKdfVHQLqvt4mW/0OEN2jEXFcW39PWpnk6E6tPWLKBUu9WVXEUM8oOL
	L4Ft3HjrxC1O+sJQhSzv4HLhgp1+vqwmlXzv0VoVOM+e8EcWIrSQi/V/tBLxtw+G
	/oUKw9geurKmz+l/bgPwTLRIij+qXDxm80sTc4W+aP9Cipu5RbxcY9aOL/Z6ij0A
	4POOZfkwwbt2UJ5DSXcAnRc4TB1YAAWR6kTVaKUU1KZH0Mcn09IoC5QT8PkiNebm
	t0VbOLr/AH2AYgwApyNOjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935729; x=
	1791022129; bh=udyNZ3ofWbtZEcalaaqxelqRtjY4ZkLhmYCVgWDeQJI=; b=T
	CX8JPSQORRIstZu1Qp3PCUOnX7JwyqCzeoWRG1+QgGU6JIFaNwpXI5SWLsY1bO8F
	eoBz5zgeFhG/nCdYL8KkEJGmkAzkVzmI30HDHbMqxqBE90DXYGBH4ewWm9T/e09/
	1IoBYjbks07fWxKu0Ly/Z/+kOoNAv51EBTkJvq4Ov5GoXadlnXcBRIWLhA23KxUg
	YNtKAkM8MndvNCPlQsC7JQZgNnYY7YCRh1v0PTjUJEmJVAeNEQ9ZZjH0PAzTSCIR
	3XpnIFX7BHs3Lr1Y2mAdN3cxsYRRzS+BZIdYsN14AuKwG5iqcfohwFNiGMQzbB1z
	BuAc0Ll4sULgVl5DkdjPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935729; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kcgmeZdJsONtc6i9KPyOg8dTUebSa/Z0Icx/0j3OWCf50Mg
	Tl4idFEg35tQwM0UENPkMg+eXD8WCFGn/sgixdyaKVBXmZ1TxD0HvPnKOesPJ1hF
	565lpgvLIJl0hrCC39IiYegGPoG740tbrIq5b6aHxZ9TevVnQ4u6uIpdlyDLp+hY
	S98HuaJHemq+Uix4MfCBVNr/GkO0hzew+rE4uCI8+wOH0zLb30pDgIRBHioJ6dup
	Abk0c7IoK5hIPrGC6MbKUcriiaSqjyyq0mbcv4Sja3lREK/DmCM/kibwBelktdAo
	0RBfcwWO9bvuJa2a2frG61gtWSJXgxMWXEoAjmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BU6KdPozrnqU7IsLnyNMdtSY8D2S6kR3mtDsJTDsfxc=:NqZXA0yEr8s+wAmhXPNn6rv77eY6J9BTvQPYWt6kryc=;
X-ME-Sender: <xms:sYK_aio82eN1b6Yr0WPRVxnJD5jZBXdvqyx9zBAZy1S95joc_VdYzg>
    <xme:sYK_anlu5Lh5n54PHvceARQXwqH57xQ5O_bH6AegjnlvFGkgJkcvoWUCm4tPEvhgX
    uG5KNnrNKE9e-9DUrmQok9iJRmPlHjof2l88YPyATmkRrLXhFLe9Q>
X-ME-Received: <xmr:sYK_as0qMjZ27nPWsi_LlUR4pMd4VJFP3hkNyejokDsz4HMG8QRF4Q>
X-ME-Proxy-Cause: dmFkZTGAT02lWTZ/HZawnJ/tDJEmEBXLVXxp6MwfA/io4Sxs1l6nT0wzEatoE2fQMDbtpm
    p0gp3n+u0XxYK2N4CQJybkQ1pbEPbrSkjwMeQilVYtooN5JISXASRzysfZGGIuJXYdcQ1Q
    qw/0sdw7da59Q0SGLpwm6WfVe/qbUZmqSgAHokGVJjigUduGeTV/2p0+YAoIgeZDKIboWK
    ebR9j+mvlr+Li/orgYXO2KvuEcbG8RX+IvhOj5yP0wLdgUXh9ZcoXnCXSq+sDT3gVR0jjs
    eIV0I8m87VeWDEn8imSElR4amTLvkCL6Ubwj3FCmUaPVx6oac0qqCnbee4tzgW3UNEhYhM
    GX9TclQQuqDbTvKmuJNRrcp62OB+hMqfOH4LshqHbBbo2jbRl003cXlUAyw95VvFQ3xKjM
    orUMEYO7hQnpQ9oXkqP2LrRJZv0yAARdEWMhp2Q9hTPIGREGaGh15yasTTRxJVnAgrOU2K
    7ms1GJaxeivFgFNjPn3tWtHQqfHl20MFuXn4LRd5c2RktonQJx7nnA4Zvwry0zAtGF4WNC
    Y1KsyXVuTbUrGBLrgiRDt1DJyTeNI1ZmHr2bHkzIRllTi/Q7XYyCvZVv23BHUX2grYEjAJ
    JvEeCAR7xUSCxOgjqMXiifOR6DzoLtwWPrEJN9S8PZKalWHSF4BtxTn5VyyA
X-ME-Proxy: <xmx:sYK_anDoQcmD7EJYkn5hxyfVZWSlqJ0wQTGjgN0CNHaBGXe9-RvY1Q>
    <xmx:sYK_ahyNSfDeGWxA65pPZCd9xXqEnWWT_bFxy0WhdInJJJBMIFX0Rg>
    <xmx:sYK_atkpk4PvVmimyOdpqcA2fil01ourn2uZSHeY2gyA5j7PhFR1Hw>
    <xmx:sYK_auHQTA4AGE3exGnRIbBAn_aom3q_VgVsPNyq_sd9q8YzphF5pQ>
    <xmx:sYK_auIzQVJ155YoBtkDl6DwqMW0ILFp4DMO02c_a6jtPm9jiHeiB1Dj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ad209fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:19 +0200
Subject: [PATCH 08/13] tmp-objdir: manage quarantine as an object directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-8-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.56.0.379.gc618271300.dirty

