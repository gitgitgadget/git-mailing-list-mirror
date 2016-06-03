From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 35/38] refs: add methods to init refs db
Date: Fri,  3 Jun 2016 23:04:10 +0200
Message-ID: <5e50cbd4240bd341612254a8a290e7fc008d5326.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJ6-00025e-Eu
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932971AbcFCVGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:53 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53980 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932975AbcFCVFe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:34 -0400
X-AuditID: 12074412-51bff700000009f7-40-5751f118716a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 5A.A4.02551.811F1575; Fri,  3 Jun 2016 17:05:28 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kd1003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:27 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqCvxMTDc4ME6G4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGdsu8RTsEC54uzTJ+wNjG9luhg5
	OSQETCTmn97L2MXIxSEksJVR4se06cwQznEmiSnbT7KCVLEJ6Eos6mlmArFFBCIkGl61gHUw
	C8xhkrj9sJMZJCEsYCHxtvUSmM0ioCqxd2IrWDOvQJTEg0lLmSHWyUlcnv6ADcTmBKpv+bwK
	rEZIwFyi8dRhlgmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5ihASd
	0A7G9SflDjEKcDAq8fAWPAsMF2JNLCuuzD3EKMnBpCTKu/cOUIgvKT+lMiOxOCO+qDQntfgQ
	owQHs5IIb8proBxvSmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILUIpisDAeHkgSv/Aeg
	RsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQDMQXA6MAJMUDtJcbpJ23uCAxFygK
	0XqKUVFKnPfQe6CEAEgiozQPbiwslbxiFAf6Upg3GaSKB5iG4LpfAQ1mAhpc8MgfZHBJIkJK
	qoFxvq2x0MaJ7neLz1am71RKnBLjEhwsXXCxZHYfy8OHb7acUxabZpwWttfLS/lz0w/+mEMS
	EySOBhULmPer3dKwVl+1+/oxxolyM4qNRWYVX5/7Zu/GRUaHPqiyKD4RNDXUM/E4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296405>

From: David Turner <dturner@twopensource.com>

Alternate refs backends might not need the refs/heads directory and so
on, so we make ref db initialization part of the backend.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c    | 21 +++++++++++----------
 refs.c               |  8 ++++++++
 refs.h               |  2 ++
 refs/files-backend.c | 18 ++++++++++++++++++
 refs/refs-internal.h |  3 +++
 5 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index b2d8d40..082fa9f 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -180,13 +180,7 @@ static int create_default_files(const char *template_path)
 	char junk[2];
 	int reinit;
 	int filemode;
-
-	/*
-	 * Create .git/refs/{heads,tags}
-	 */
-	safe_create_dir(git_path_buf(&buf, "refs"), 1);
-	safe_create_dir(git_path_buf(&buf, "refs/heads"), 1);
-	safe_create_dir(git_path_buf(&buf, "refs/tags"), 1);
+	struct strbuf err = STRBUF_INIT;
 
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
@@ -210,12 +204,19 @@ static int create_default_files(const char *template_path)
 	 */
 	if (get_shared_repository()) {
 		adjust_shared_perm(get_git_dir());
-		adjust_shared_perm(git_path_buf(&buf, "refs"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/heads"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/tags"));
 	}
 
 	/*
+	 * We need to create a "refs" dir in any case so that older
+	 * versions of git can tell that this is a repository.
+	 */
+	safe_create_dir(git_path("refs"), 1);
+	adjust_shared_perm(git_path("refs"));
+
+	if (refs_init_db(&err))
+		die("failed to set up refs db: %s", err.buf);
+
+	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
diff --git a/refs.c b/refs.c
index 8ab9862..7dc67a6 100644
--- a/refs.c
+++ b/refs.c
@@ -1292,6 +1292,14 @@ static const char *resolve_ref_recursively(struct ref_store *refs,
 	return NULL;
 }
 
+/* backend functions */
+int refs_init_db(struct strbuf *err)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->init_db(refs, err);
+}
+
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
diff --git a/refs.h b/refs.h
index 132dcef..20fae94 100644
--- a/refs.h
+++ b/refs.h
@@ -66,6 +66,8 @@ int ref_exists(const char *refname);
 
 int is_branch(const char *refname);
 
+extern int refs_init_db(struct strbuf *err);
+
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5681141..b2d677e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -4061,10 +4061,28 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	return -1;
 }
 
+static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
+{
+	/* Check validity (but we don't need the result): */
+	files_downcast(ref_store, 0, "init_db");
+
+	/*
+	 * Create .git/refs/{heads,tags}
+	 */
+	safe_create_dir(git_path("refs/heads"), 1);
+	safe_create_dir(git_path("refs/tags"), 1);
+	if (get_shared_repository()) {
+		adjust_shared_perm(git_path("refs/heads"));
+		adjust_shared_perm(git_path("refs/tags"));
+	}
+	return 0;
+}
+
 struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_ref_store_create,
+	files_init_db,
 	files_transaction_commit,
 	files_initial_transaction_commit,
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f944b7a..6c46353 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -474,6 +474,8 @@ struct ref_store;
  */
 typedef struct ref_store *ref_store_init_fn(const char *submodule);
 
+typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
+
 typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err);
@@ -578,6 +580,7 @@ struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_store_init_fn *init;
+	ref_init_db_fn *init_db;
 	ref_transaction_commit_fn *transaction_commit;
 	ref_transaction_commit_fn *initial_transaction_commit;
 
-- 
2.8.1
