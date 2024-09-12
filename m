Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928D1A3BD4
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140592; cv=none; b=TGF/65EMEMAJSUHyd3Y3eN0lb3Q9GgK8lXOI/QkvSXslBMq79NPkz4EXKVe5LUNQ/++31MDA4jPmlvtqeq/rRDINXO65GhUMIqy5DMCP4T+eEmDLKd1jscav6b0NjpH0/AvWhNT5zVcyrQpYzcsQBC6oNvONRnEerNkcejO24b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140592; c=relaxed/simple;
	bh=PT4lPzQ9G2Ri0F+lmqvBNswi8qSX7ttf7tpfNNIqEWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ST2AVuznXW/8DHncedz4VbTjWRphrh4FpqsaA/Xpn/nlqAvcgSKWd9S3bjNUl7etqnMHkN6J5WYmYjaeLT7eRXUpOGOgYOKbP7OutS0OJjXWidtDzvUCLHT0JNOuSI+T5udBZLVT5wKqcklENbNGRc6vub4eHQkvnQMP5yBb8gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tR95sQqT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQuaXmr1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tR95sQqT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQuaXmr1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B1A721380625;
	Thu, 12 Sep 2024 07:29:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 12 Sep 2024 07:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140589; x=1726226989; bh=DYoYt1paYM
	ZnFG78HHjz4bZEAyCKrpbLNx9qIi48DEY=; b=tR95sQqTyk9HKwTaduoyhiO2lc
	l+3W639i8X7AHTM+1HgrmDvvb2ot7FTvxm04yTyHbWVFyWq0E8SmkD3+Yb3kSSrU
	INaT2XPFK0Crwcl/uB64QYl8ErdhojX+5U54vRqkln8dMX4el7O3IsHdi+JpvcjJ
	1mrUJusctUOZ2HJHgyQ7ZsastBMFosPRBD37XFPxgsO6J4mSFtWqgQB0CKG6BDjA
	3eUSfhoJhxgWwRuw2HTTa23DQWioS3siUX4tLKQbkosAuut6jQjeQZVyUo20R658
	zTD/pkRvriSXSq2LtEewcxUl/5/CCUJ+2fRFJe7vLa10Slhku7lP2E0+EtaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140589; x=1726226989; bh=DYoYt1paYMZnFG78HHjz4bZEAyCK
	rpbLNx9qIi48DEY=; b=HQuaXmr1Lu+VhTryiA38L7Vlkhq+jwV7k6q4eer40sjN
	GpT3SFHXWSMJ8dsiZRlg2va2jvc3UjnSzAhjb8GOJeE3bz5AjgdxbALY3szAPcpD
	xVhXXG/kdTepQVEgiQI4XYg11C/jZN/ngDaTkQHTFv/ioY3RBZTQA7chqmr2utcg
	PEoNKics058XFZxN+VUEBHuxN002Jsq6VzJ2+ZU4KWC0OuQ6MDIZqfBtvduT1wXS
	HA31WwoZrJRnjUyFp9Qk9oNB4FOygUfiKXNT0NeB21d/At+FMzEa/bALCBbvPsnh
	VqBIZFFF9+uuLfRHgMCZQztpIz5/iRTdjauj2wXGHg==
X-ME-Sender: <xms:rdDiZr1h6QJpmvvg4PLoGukBLhagyx5JUYI8zRSt3mGF4iEu-kGuAg>
    <xme:rdDiZqGHYDMyoGWIGZhIhIs-3_TjDL5ZjwfezX3i8Xuob1uFznI16Gh9DWv83IECR
    zrNC6o24fwEx5imRw>
X-ME-Received: <xmr:rdDiZr69wDftt0Ni4C3AOXoNfB2gtzyOYANCM5qhrhzNwjU1PMoNcTuE8RJJ5kFn0Ee0GxMAYAeAwV2gbzE8mObSYjyNNjy4KYacSEvQy52j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:rdDiZg3qlNvWV43zerHczf_H9jWyDxj2EMcoMJHdfOTeiR2snAFqEg>
    <xmx:rdDiZuEZ746hhUTCGy2opZtpp2-3Q9Mm4KKyGwaWhbHbHmPA1lTnwA>
    <xmx:rdDiZh_HYCfPetVhgA2uCLe07xhYkT5oB3fQa1LrnQVW8yBpBTRaZw>
    <xmx:rdDiZrkzTJxUVuYbQzuoPR1WWOOmposZ6KmWE45hxOGUh8DlHIPObA>
    <xmx:rdDiZrPNGgrpg4lQeFx3tJRnc7wnJWIJ7loPgN49BU7R2t3YVzdEQPmx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:29:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5a25f607 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:40 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:29:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 09/21] environment: move object database functions into
 object layer
Message-ID: <b164373d10bea7da632cb30ac85853e3162739a7.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

The `odb_mkstemp()` and `odb_pack_keep()` functions are quite clearly
tied to the object store, but regardless of that they are located in
"environment.c". Move them over, which also helps to get rid of
dependencies on `the_repository` in the environment subsystem.

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
2.46.0.551.gc5ee8f2d1c.dirty

