From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 02/21] refs: add methods for misc ref operations
Date: Mon, 11 Jan 2016 20:22:01 -0500
Message-ID: <1452561740-8668-3-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:22:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aInfY-0003CZ-Qf
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761802AbcALBWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:41 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34278 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761133AbcALBWa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:30 -0500
Received: by mail-qg0-f47.google.com with SMTP id 6so339423329qgy.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQB1SgMxVprD24WJil3/Ne72W0xvrYq8n9R316dSaX8=;
        b=d16jSatipQ0KOq3Fi+EzmwN5u9Te+c6VJR0f3ixDDcgB12AxKpqo9PNalONpUO8v0c
         J8XmqwmuYSarlQEr5ZW4Uh3KntUGjOjfyyZuPBOCzTTf/SiaPYWB4HLT0e0gthGfmA0F
         iPnzp9jWTdnBEL1ZxptgCG9ZZxx5qoOdH8KLJAE6UincyRJ5q6hNmflNHjBNuq7Cnz5M
         B7gS8YXBdlRIzLXcrCMPMT9E8qcgS7GFxOqr5eOVdYWWlQVe9bH6kCBuj67mIx1hcxCP
         2duj/lL5NhZ4WNoJ98tGB7w3P3MIdN0uUjBEV5V4pmOa1XE+KKSicCr8tRS4iC0ZGuAH
         gSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IQB1SgMxVprD24WJil3/Ne72W0xvrYq8n9R316dSaX8=;
        b=Ejt0+Xmzz1+5AIIuInimUYRwo2gH0QEvLGeJs/Hg5YY2G15aDa5QIvCvZthMn3yCZw
         /NsZSkzWNSnCRkIJtgAQy5eVs1bbIq3m5ZOSr7xV3hnYz2R9U6WdY8idkHzGrUUeMjdI
         Oe0cc2QjJnYHszIp2JGncnI/A9LY2srKbqlN3cSJAS0TfeRSi1W/xrfXtWiOERZY9oqr
         5qRm/wvyb+1pd8PmD2dE7yBZ1bDxTpoTadqAfBZ2yqJxIbM9SztacGY6JyINrvTP3B7O
         TYvFy/D2yJWz4WewzTbLLkyoJllhlw7ccGl6ejSHV/+RO7SNi9647MX+Z1G4bdqehY0n
         3h2Q==
X-Gm-Message-State: ALoCoQk2LzzqoJrCht6nOia7NLhQN36yZqtUo41VmmXudQYvantHrXAKT1EaEN63U8LQLe3Hm8SWIAi0hBH89LbW7bfmVS+xkQ==
X-Received: by 10.140.44.68 with SMTP id f62mr49250953qga.106.1452561749410;
        Mon, 11 Jan 2016 17:22:29 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:28 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283741>

From: Ronnie Sahlberg <sahlberg@google.com>

Add ref backend methods for:
resolve_ref_unsafe, verify_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c    |  1 +
 refs.c               | 36 ++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 34 +++++++++++++++++++++++-----------
 refs/refs-internal.h | 23 +++++++++++++++++++++++
 4 files changed, 83 insertions(+), 11 deletions(-)

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
index 831ee12..6875ff9 100644
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
index 684a517..e65afff 100644
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
@@ -3515,4 +3519,12 @@ struct ref_storage_be refs_be_files = {
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
