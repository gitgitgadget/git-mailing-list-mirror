Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285418E745
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924338; cv=none; b=nlWmT6Ww5i6+WcwCrnyJ7azxC1idsBhiUZvACP7R/HwR41gDQu8Yj5ronuRTu0x4NfsFDpUhm73ym/EEL+COdqDMFVqvodVzg4Mc6YEUvwyIyZPPje6Vw/qVWrksa5bXb+VhELPjHZQwnlJFE0mxce57mXaqnVyfBwXTakY4goI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924338; c=relaxed/simple;
	bh=QmWTmIvhpHM/oVktMS/6Ee4C8yvrejce12hND3uphdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMFDpem+0uljmMeiBMD65oWEgVa/0LYsYF8uSESVsIBnGUNRMYSszJCw6sp1KjcNVis87gXj0QOTLiJ0tCzmsmL7WWc74KPOJvDDdePr5x3afywQ2TopHqRoTI9NMHoJqOtSjPEqKsJslqQhG4u1oNbvS1JoBgt/1dBUS6wjsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=szCOf7gY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fwVqDOh2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="szCOf7gY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fwVqDOh2"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id F26ED138FC3A;
	Thu, 29 Aug 2024 05:38:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 29 Aug 2024 05:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924335; x=1725010735; bh=eY0BWSJmUe
	a/oC4SgDpxZ9RnyqLvySn/M72sEw9Qq4E=; b=szCOf7gYljEnOuv5a8z2GW/hUE
	4UZFF0NFgRCMoOU3RcIhPOZqiqkh22gb/wmMIBk59umslL9vZuC7EwADllZ4lFYl
	c1wciK09PQtoxf/JTq7fiewddz0HVcgZy7mIfxDpgaI3DQOZ66z3JVzRF2VY69Fi
	PU8axqAFT00OpmxB34fXKa8V/lC02FvAq9k6jNJI5RomGMZVOCfN0Cn9I4BBOSdP
	5Z809gA9hbkGuZwRnLckYJDWJWlT7vXrOxQgZqYBqiS6Oxp+3O/142Wzz3iJGkKn
	Aw80M9G5xuz1Hruc5vuUTJCETQfGjFS022vfBoV4kTR6T7RbIgY9bEiMBRlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924335; x=1725010735; bh=eY0BWSJmUea/oC4SgDpxZ9RnyqLv
	ySn/M72sEw9Qq4E=; b=fwVqDOh2wG/NXubJFfxb4M9lbCB88oEB9AgEM+J6Q7Se
	3tScaFt8rSVZW8QeNOsA0d1VYG6oxFcfp3Zi/+zNBXIPB1h2t3UhDORst9Tmkv+P
	MLzUzhiuV644v+fbiz+fq1DWe+ZqfypB58aaQmgLILMSnwZCW9PmjS6TBO2OJGzq
	wYg1rCYKItuwPhLhCUBQ63/oCUG6UffiJ54YghOIozu1zEZPxIgC2g6roMk0/Xqv
	DDMxjYZ9sXjyevh0UPKiGeUXMkUmjoFkLBtAZ66+5f4YOK6KDjHqBYp7sKjqJ8Fv
	f69u/ve5bitvvrpShCdtNikJQkl3XA99qPInheFlug==
X-ME-Sender: <xms:r0HQZpJrSMJ-9dJMFQmSJXKRH_x0M_FtWksjyxY_xhZ_7PUCwVSKCg>
    <xme:r0HQZlIVCdg1GcFfgt_LTXNezB2AW_a-lEQfaMIMRIJezr8reLMCdxAIS6NXd9pUO
    y6S63-_Zwa3JhcMpw>
X-ME-Received: <xmr:r0HQZhsY_t-gP7l2ZPP65btlI4Yk4GwEUx5yEHHzjASxpOfvBpEjCHborQ_HAwl_TLkLJXeFCqjjjDwlKlRq-PwcXixvtUUo0z4fUhDpLfP2TMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:r0HQZqbxn5AK3_zxQhJKb_uI-YCxL8Tm5XqkcI1peEA3vhjtYOKVEw>
    <xmx:r0HQZgbMgDyQU7BNLGXrC6lCe7RLKbSkhYRN00lLgydTZne972bihg>
    <xmx:r0HQZuDekkShqd3GpbefFYD37z8a2VhRzqqTrXugsJ44_JpyrIDSGQ>
    <xmx:r0HQZua240-g6pANTHTFEQ4SzxIdy_Fnnfal3ZpOwyup7zHH8K36aw>
    <xmx:r0HQZvkT-77yCc5POGCxfC5lfFr_5WQdhq5-KeVvAgG_jDwHoAHzxIcq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:38:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b3f0aa6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:46 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 09/21] environment: move `odb_mkstemp()` into object layer
Message-ID: <8321454adc8f4a1ebf68cd5adc93a19ef03c8f27.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

The `odb_mkstemp()` function is quite clearly tied to the object store,
but regardless of that it is located in "environment.c". Move it over,
which also helps to get rid of dependencies on `the_repository` in the
environment subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bundle-uri.c      |  1 +
 environment.c     | 34 ----------------------------------
 environment.h     | 15 ---------------
 object-file.c     | 33 +++++++++++++++++++++++++++++++++
 object-store-ll.h | 15 +++++++++++++++
 5 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 1e0ee156ba3..c5f9948d6bf 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -13,6 +13,7 @@
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

