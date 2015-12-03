From: David Turner <dturner@twopensource.com>
Subject: [PATCH 02/16] refs: add methods for misc ref operations
Date: Wed,  2 Dec 2015 19:35:07 -0500
Message-ID: <1449102921-7707-3-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:37:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4HtP-0008GH-Ra
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857AbbLCAgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:10 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:34547 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757056AbbLCAfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:39 -0500
Received: by ioir85 with SMTP id r85so64745983ioi.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+qZ1oXcSmWSOqnxo5snmEjnAgRbbSXGaOqEtwYypRig=;
        b=CjeHghNJBLr/U4U2jJvteP70W125M0CSPWJBdo9oC8H7oztLv4zJym70pEWoa9JdVB
         1mQdG2PqiyClzIBdf6hXIYYCHTubp4bpakuwErxXA46L5eV375Zvqk0Sdvr6TckPJfqS
         TfyRjE9JSVhG/iP6En2nYSSq7pMfvDucIB7cr3SrhlJaerghPe7dh7LwRfLD16WAs+Dg
         zmP2lMXS1EI+AG68oMJlWdx9jQlMSWUvOsYmctfNDnIIJLtwweTz3C7GxV6Xw3Psb0m4
         ehKjGo5DfBeDMgcjjkT2GyQNo2KbNNNDnS1h9ZRYuRoGDXdbS3EMg5jffaBTGq/9gwdE
         AN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+qZ1oXcSmWSOqnxo5snmEjnAgRbbSXGaOqEtwYypRig=;
        b=LRrFNTdAWut/G5h+R6Ixd/rmWgXFw7Sj1rGUK9w5N2RKFX3VrYjJaBveexLO09ga6K
         /jTodAT0+GZgG+tWnBbJNMsev2n66Np9+s4HKU02sK8q77nGIZiHc+xmtKqXdWmQXU9I
         d6kflO0WEmoRAhc8r6gjJaBlOF1d5Pxu5o+oAolL+/MdjEAWOJtQgpFuzzM+K1kxPDgv
         VpC2z2/LPJlyCpzo92T99IkswWLVX95eenwzj05HCPbpoauT00Io5e1Mby0gK8S2elDj
         /06gCXL54T1YfDkIwcXTLq6QlVLhF2EaAA+63Ef6Fc4p7ikBx208NsIJ2jLwSgLKs1XJ
         NRyA==
X-Gm-Message-State: ALoCoQlKFC8O8ZcEbgWWUXR8MxpCPBUetAG1l1RRAlUaVnDXHJczBqtX3FAoLKS+0xaZ2eWAUHnQ
X-Received: by 10.107.46.94 with SMTP id i91mr7137464ioo.67.1449102938331;
        Wed, 02 Dec 2015 16:35:38 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:37 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281940>

From: Ronnie Sahlberg <sahlberg@google.com>

Add ref backend methods for:
resolve_ref_unsafe, verify_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/init-db.c    |  1 +
 cache.h              |  7 +++++++
 refs.c               | 36 ++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 34 +++++++++++++++++++++++-----------
 refs/refs-internal.h | 23 +++++++++++++++++++++++
 5 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 07229d6..26e1cc3 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -8,6 +8,7 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "refs.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
diff --git a/cache.h b/cache.h
index 51c35c3..707455a 100644
--- a/cache.h
+++ b/cache.h
@@ -1111,6 +1111,13 @@ extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as s
 extern int interpret_branch_name(const char *str, int len, struct strbuf *);
 extern int get_sha1_mb(const char *str, unsigned char *sha1);
 
+/*
+ * Return true iff abbrev_name is a possible abbreviation for
+ * full_name according to the rules defined by ref_rev_parse_rules in
+ * refs.c.
+ */
+extern int refname_match(const char *abbrev_name, const char *full_name);
+
 extern int validate_headref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
diff --git a/refs.c b/refs.c
index babba8a..9562325 100644
--- a/refs.c
+++ b/refs.c
@@ -1114,3 +1114,39 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 {
 	return the_refs_backend->transaction_commit(transaction, err);
 }
+
+const char *resolve_ref_unsafe(const char *ref, int resolve_flags,
+			       unsigned char *sha1, int *flags)
+{
+	return the_refs_backend->resolve_ref_unsafe(ref, resolve_flags, sha1,
+						    flags);
+}
+
+int verify_refname_available(const char *refname, struct string_list *extra,
+			     struct string_list *skip, struct strbuf *err)
+{
+	return the_refs_backend->verify_refname_available(refname, extra, skip, err);
+}
+
+int pack_refs(unsigned int flags)
+{
+	return the_refs_backend->pack_refs(flags);
+}
+
+int peel_ref(const char *refname, unsigned char *sha1)
+{
+	return the_refs_backend->peel_ref(refname, sha1);
+}
+
+int create_symref(const char *ref_target, const char *refs_heads_master,
+		  const char *logmsg)
+{
+	return the_refs_backend->create_symref(ref_target, refs_heads_master,
+					       logmsg);
+}
+
+int resolve_gitlink_ref(const char *path, const char *refname,
+			unsigned char *sha1)
+{
+	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index be34772..25fba43 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1333,7 +1333,8 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+static int files_resolve_gitlink_ref(const char *path, const char *refname,
+				     unsigned char *sha1)
 {
 	int len = strlen(path), retval;
 	char *submodule;
@@ -1565,8 +1566,10 @@ static const char *resolve_ref_1(const char *refname,
 	}
 }
 
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags)
+static const char *files_resolve_ref_unsafe(const char *refname,
+					    int resolve_flags,
+					    unsigned char *sha1,
+					    int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct strbuf sb_contents = STRBUF_INIT;
@@ -1615,7 +1618,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
@@ -2246,7 +2249,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+static int files_pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2437,10 +2440,10 @@ out:
 	return ret;
 }
 
-int verify_refname_available(const char *newname,
-			     struct string_list *extras,
-			     struct string_list *skip,
-			     struct strbuf *err)
+static int files_verify_refname_available(const char *newname,
+					  struct string_list *extras,
+					  struct string_list *skip,
+					  struct strbuf *err)
 {
 	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
@@ -2811,8 +2814,9 @@ static int commit_ref_update(struct ref_lock *lock,
 	return 0;
 }
 
-int create_symref(const char *ref_target, const char *refs_heads_master,
-		  const char *logmsg)
+static int files_create_symref(const char *ref_target,
+			       const char *refs_heads_master,
+			       const char *logmsg)
 {
 	char *lockpath = NULL;
 	char ref[1000];
@@ -3515,4 +3519,12 @@ struct ref_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+
+	files_pack_refs,
+	files_peel_ref,
+	files_create_symref,
+
+	files_resolve_ref_unsafe,
+	files_verify_refname_available,
+	files_resolve_gitlink_ref,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f2c74f3..236bce9 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -201,10 +201,33 @@ int rename_ref_available(const char *oldname, const char *newname);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
 
+/* misc methods */
+typedef int pack_refs_fn(unsigned int flags);
+typedef int peel_ref_fn(const char *refname, unsigned char *sha1);
+typedef int create_symref_fn(const char *ref_target,
+			     const char *refs_heads_master,
+			     const char *logmsg);
+
+/* resolution methods */
+typedef const char *resolve_ref_unsafe_fn(const char *ref,
+					  int resolve_flags,
+					  unsigned char *sha1, int *flags);
+typedef int verify_refname_available_fn(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
+typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
+				   unsigned char *sha1);
+
 struct ref_be {
 	struct ref_be *next;
 	const char *name;
 	ref_transaction_commit_fn *transaction_commit;
+
+	pack_refs_fn *pack_refs;
+	peel_ref_fn *peel_ref;
+	create_symref_fn *create_symref;
+
+	resolve_ref_unsafe_fn *resolve_ref_unsafe;
+	verify_refname_available_fn *verify_refname_available;
+	resolve_gitlink_ref_fn *resolve_gitlink_ref;
 };
 
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.749.g0ed01d8-twtrsrc
