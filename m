Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBB171E65
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008966; cv=none; b=pgK1gfSExrLSDujEsMerIilRwn19bviVppD7DkbjzdbvAuY6Rk1qBmF77FqIJXA22Yyb5aBoBcv2KSSnieegtluQ2HUz77yLS1isibh5H5Jjk8PfzcJvcsnZIPTDui9/ngdUZqCzCJA2i9WDvBNPaxi/QN5eDKrEUyhxt64IuUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008966; c=relaxed/simple;
	bh=7FlUWH34xV50jWr4R+KmwLKrUw6lhPCMltwzgcXTnJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niAuu86WNGnJAeq1bfVC6q88VLNkAdIcYYV7UbcG7ml/nQ22/PUiSCtBC/d97pTIxaSdcJ3XpBH26Y+TnXoTiU8JmjGBl22eYWg3m8XFGeHTxNV3rJrvtBJpz7DWIVa3Dv/7K9T0nu5pGhCt0+42v2Ohj06WKrL5988jn4crm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gkKILTTg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Enfq3mVL; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gkKILTTg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Enfq3mVL"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AB6A2114022E;
	Fri, 30 Aug 2024 05:09:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 30 Aug 2024 05:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008963; x=1725095363; bh=/V0TukJ6Dj
	WW7fQeR3viYT60KXRL9/FFuaVEmSmuoJc=; b=gkKILTTg/7AEDx/t6aqpg1Hgy/
	fFq+jr/6ubzvleEHXOSTabi+xgxwZ+I4TBvfb2JVovJeGGMZPiED14YUPHZYlsU/
	eRLhau6caWBK1TUSCMo85V17IruRR6Xd+L0YbCEyINfaGTZWuzrkWOSrf28LNsDl
	IApkHR4z+jvZ82PG2eWeN2oIyop+gosHAqZnGG8hbzmYGghrZGvC9EkVt9lUWTCg
	399PMXWKfQhV2hGLA4UhZtz2RUBBIZAtN05HxRSrmT5IpPU7mRa7hSfenGP3SUa9
	QAMMfoKnI61q1cANdg+Ybp4IA/Tm0YYaHxYlT6XNcA96IT9z2rrgv8Pury1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008963; x=1725095363; bh=/V0TukJ6DjWW7fQeR3viYT60KXRL
	9/FFuaVEmSmuoJc=; b=Enfq3mVLKuMm0/mKYfPh2/S5CO9j9yBqk5Jy5cf1vqXO
	PBEb/ctd9bxbNPUaNrgs83RrETuJtBCT2jmPNVxfjsiMoSxjfLgfSXs9AfRQFkuM
	l9+eIeujVBT5NNbrQfPKjwWrq1mEfrPoYPueyN5W3Qcwpw+yFViQD3lIE9N4JySd
	pGgnoPqkuXGZafoKfVwdnmAAhjyoAXh6WQusGnG12Z9fTAutFi3wgD28dY1paEGn
	m9OR2Lvp/ddY+11Dd89Lk329ViA031pl0pDLjXMi1G9OBgOGP0cq+sSehweZRMPm
	k6K7o6No9zwfIclCvUnco8BFpswOf4jfVdhcWVXgXw==
X-ME-Sender: <xms:Q4zRZjviG5lqokk9yczEP-H3ilhTN8GLXYImnuonxScSvi-uXLspfQ>
    <xme:Q4zRZkdxej6kaawZfyI0WXf998epoqKJHFUy9Vxzrnzt7Zy3HwJ8iiBWaI-jWSYty
    QCFzjIZerZkCrbS_Q>
X-ME-Received: <xmr:Q4zRZmxdvJLHS5Wq41NiQa1mB2Y0__u8CnKdLOs1fqrIAbzWmr93qDKqNWoLJFH1gB0KyWdilCBmI5YExr4lB8IMyJquZLrLVdQJhfAMVetjneju1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:Q4zRZiM7lsIjBkN77S64Oy0c5mWuU6USHfmvn4UlHhL1XZ70Tuik2g>
    <xmx:Q4zRZj9koO0qOhdo5fWLRjMrU3rPjWMqYAdh-5x40oBQJHujTF937Q>
    <xmx:Q4zRZiXlVdRSbQPzfxHZBu1GsywHKoT-UB9o2HTWD_SNqh5aDv8BFw>
    <xmx:Q4zRZkdgK1s5aEvKrMUgqKndzZ273LY4xDrHxMa6CeneS8GEQ6qLAQ>
    <xmx:Q4zRZvYQmAk31HeLvOpmXJuZFJz56kzX9tQ4aUG7TSOowFDbL3oh6Vw_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 97930346 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:11 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/21] environment: move `odb_mkstemp()` into object layer
Message-ID: <ac2cc4e03719ecf6d6a2eb4aacb8a162429addb0.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

The `odb_mkstemp()` function is quite clearly tied to the object store,
but regardless of that it is located in "environment.c". Move it over,
which also helps to get rid of dependencies on `the_repository` in the
environment subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bundle-uri.c      |  2 +-
 environment.c     | 34 ----------------------------------
 environment.h     | 15 ---------------
 object-file.c     | 33 +++++++++++++++++++++++++++++++++
 object-store-ll.h | 15 +++++++++++++++
 5 files changed, 49 insertions(+), 50 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 1e0ee156ba3..eb8eca078bb 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -4,7 +4,6 @@
 #include "bundle-uri.h"
 #include "bundle.h"
 #include "copy.h"
-#include "environment.h"
 #include "gettext.h"
 #include "refs.h"
 #include "run-command.h"
@@ -13,6 +12,7 @@
 #include "config.h"
 #include "fetch-pack.h"
 #include "remote.h"
+#include "object-store-ll.h"
 
 static struct {
 	enum bundle_list_heuristic heuristic;
diff --git a/environment.c b/environment.c
index 4d0637b3822..f337efd1dd5 100644
--- a/environment.c
+++ b/environment.c
@@ -23,7 +23,6 @@
 #include "commit.h"
 #include "strvec.h"
 #include "object-file.h"
-#include "object-store-ll.h"
 #include "path.h"
 #include "replace-object.h"
 #include "tmp-objdir.h"
@@ -268,39 +267,6 @@ void set_git_work_tree(const char *new_work_tree)
 	repo_set_worktree(the_repository, new_work_tree);
 }
 
-int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
-{
-	int fd;
-	/*
-	 * we let the umask do its job, don't try to be more
-	 * restrictive except to remove write permission.
-	 */
-	int mode = 0444;
-	git_path_buf(temp_filename, "objects/%s", pattern);
-	fd = git_mkstemp_mode(temp_filename->buf, mode);
-	if (0 <= fd)
-		return fd;
-
-	/* slow path */
-	/* some mkstemp implementations erase temp_filename on failure */
-	git_path_buf(temp_filename, "objects/%s", pattern);
-	safe_create_leading_directories(temp_filename->buf);
-	return xmkstemp_mode(temp_filename->buf, mode);
-}
-
-int odb_pack_keep(const char *name)
-{
-	int fd;
-
-	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
-	if (0 <= fd)
-		return fd;
-
-	/* slow path */
-	safe_create_leading_directories_const(name);
-	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
-}
-
 static void set_git_dir_1(const char *path)
 {
 	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
diff --git a/environment.h b/environment.h
index 52e1803aba6..682d4f2e3b5 100644
--- a/environment.h
+++ b/environment.h
@@ -200,21 +200,6 @@ extern int grafts_keep_true_parents;
 
 extern int repository_format_precious_objects;
 
-/*
- * Create a temporary file rooted in the object database directory, or
- * die on failure. The filename is taken from "pattern", which should have the
- * usual "XXXXXX" trailer, and the resulting filename is written into the
- * "template" buffer. Returns the open descriptor.
- */
-int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
-
-/*
- * Create a pack .keep file named "name" (which should generally be the output
- * of odb_pack_name). Returns a file descriptor opened for writing, or -1 on
- * error.
- */
-int odb_pack_keep(const char *name);
-
 const char *get_log_output_encoding(void);
 const char *get_commit_output_encoding(void);
 
diff --git a/object-file.c b/object-file.c
index fa4121b98ad..968da27cd41 100644
--- a/object-file.c
+++ b/object-file.c
@@ -419,6 +419,39 @@ enum scld_error safe_create_leading_directories_const(const char *path)
 	return result;
 }
 
+int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
+{
+	int fd;
+	/*
+	 * we let the umask do its job, don't try to be more
+	 * restrictive except to remove write permission.
+	 */
+	int mode = 0444;
+	git_path_buf(temp_filename, "objects/%s", pattern);
+	fd = git_mkstemp_mode(temp_filename->buf, mode);
+	if (0 <= fd)
+		return fd;
+
+	/* slow path */
+	/* some mkstemp implementations erase temp_filename on failure */
+	git_path_buf(temp_filename, "objects/%s", pattern);
+	safe_create_leading_directories(temp_filename->buf);
+	return xmkstemp_mode(temp_filename->buf, mode);
+}
+
+int odb_pack_keep(const char *name)
+{
+	int fd;
+
+	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+	if (0 <= fd)
+		return fd;
+
+	/* slow path */
+	safe_create_leading_directories_const(name);
+	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+}
+
 static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
 {
 	int i;
diff --git a/object-store-ll.h b/object-store-ll.h
index c5f2bb2fc2f..53b8e693b1b 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -231,6 +231,21 @@ struct raw_object_store {
 struct raw_object_store *raw_object_store_new(void);
 void raw_object_store_clear(struct raw_object_store *o);
 
+/*
+ * Create a temporary file rooted in the object database directory, or
+ * die on failure. The filename is taken from "pattern", which should have the
+ * usual "XXXXXX" trailer, and the resulting filename is written into the
+ * "template" buffer. Returns the open descriptor.
+ */
+int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
+
+/*
+ * Create a pack .keep file named "name" (which should generally be the output
+ * of odb_pack_name). Returns a file descriptor opened for writing, or -1 on
+ * error.
+ */
+int odb_pack_keep(const char *name);
+
 /*
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
-- 
2.46.0.421.g159f2d50e7.dirty

