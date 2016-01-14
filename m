From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 02/20] refs: add methods for misc ref operations
Date: Thu, 14 Jan 2016 11:25:59 -0500
Message-ID: <1452788777-24954-3-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkka-00032a-GK
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbcANQ1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:27:48 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36567 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297AbcANQ0d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:33 -0500
Received: by mail-qg0-f54.google.com with SMTP id e32so398097547qgf.3
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HVLp7FSbZt/TSwwU/ROZAOjyid3D0MJdQsGo27kz05c=;
        b=OXTbFqNq4Oe7Vbgr5wvca4bpFQKv3JAe6I92DEAASBBtQ5uQN5ZTmeHHV+5vdDkz8J
         ikAyxjzm4oxKpcj9Zlx9Thsl4z5dDTJzCaKGNpt+N1uqm3ioFIeJksgYz5pzOJ3oYFkJ
         uHqtgv8OfoEdhQAoFDDZDEiMrWnWb2tax0/5LwYF2Ml2+1kl2TE0OzH2piRVg5zuK3+D
         wU/tK5WbxlJtg1nPxx6dNPQ0+41xCv+e8BVhsYR4kXizRdy9ST9HE1BTzc7cONDPyhie
         5IQu2pDQDItdU3JvVw9FBImKIBpJShxxnZDavSg1aQyr17csigbq24g9Afp4OjN3idVx
         ox7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HVLp7FSbZt/TSwwU/ROZAOjyid3D0MJdQsGo27kz05c=;
        b=MTwi0USmeJ8wF5Cpwkqg4O3dEoW71u0g8O9p2cd2AVExB5/U71DVeLRCZjJorcovba
         u50Ge5+EYrkYtgY21vUq/jCzBfPYlCF5sUNprpLY7Q8hl3svFn4qdHwxCSOEK0q5K4eS
         Y8kZDmB+A8ml27NVjm8eGYT+IXgeWDcmPB5Ayb8LMYSklwy4S5CzjU3tglhi7MfcXYMm
         OMj2oFc708yuCrcsjyy2WgYArJE4y0twI+72f4h5byMu5cIfWxMfG9S2klhEqKUk2h4J
         lNfX/kyEaEcyfSR1Q+b+SaZZyyPn56Q6qdY4+n7jo1xOe/hCD1SAgzZrCeLZhaH7LmrC
         hOnA==
X-Gm-Message-State: ALoCoQmrpB+VJYFMP6A0dL4myJGEonXC8L91RsvujKNKW+junLJUJ4Ac1JXcreFJ2+IJS94mV1dAhILJdiygf8owXy7dHv7Zkg==
X-Received: by 10.140.167.135 with SMTP id n129mr6558108qhn.73.1452788793080;
        Thu, 14 Jan 2016 08:26:33 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:32 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284056>

From: Ronnie Sahlberg <sahlberg@google.com>

Add ref backend methods for:
resolve_ref_unsafe, verify_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c    |  1 +
 refs.c               | 36 ++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 33 +++++++++++++++++++++++----------
 refs/refs-internal.h | 23 +++++++++++++++++++++++
 4 files changed, 83 insertions(+), 10 deletions(-)

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
diff --git a/refs.c b/refs.c
index 485b905..7103781 100644
--- a/refs.c
+++ b/refs.c
@@ -1111,3 +1111,39 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 69708e6..783eb03 100644
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
@@ -2252,7 +2255,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+static int files_pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2443,10 +2446,10 @@ out:
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
@@ -2866,7 +2869,9 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 	return 0;
 }
 
-int create_symref(const char *refname, const char *target, const char *logmsg)
+static int files_create_symref(const char *refname,
+			       const char *target,
+			       const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
@@ -3520,4 +3525,12 @@ struct ref_storage_be refs_be_files = {
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
index b110c77..0528239 100644
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
 struct ref_storage_be {
 	struct ref_storage_be *next;
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
2.4.2.749.g730654d-twtrsrc
