From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 04/27] refs: add methods for misc ref operations
Date: Thu, 18 Feb 2016 00:17:27 -0500
Message-ID: <1455772670-21142-5-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:18:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGzJ-0001Hk-Al
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424730AbcBRFSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:36 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:32828 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424573AbcBRFSb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:31 -0500
Received: by mail-qg0-f47.google.com with SMTP id b35so29342681qge.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WXIwnZTstkLOxPnaDguhsm2lZm98wKFsjXH/T26uJVA=;
        b=cg8KwvFRBvP5gQ7508ZBJNrvDFDSFXYbGNwpvW3QIxoXRoHVqCbT8sU9TyBklLfSDY
         0tBJZ7XBe6zxVwgGu6ZPixpxa0F1crjHWEBmUf+BwkhJhI9yOPpppnJBMnH4xg1COxDN
         ZnCmF8hi3QUsHOO2u294lekD0Lp1KZMnO8DeVE0W+043o/pVzrt9ratAdKRH5dXvfUlR
         /biEw2ctfP/BrV8uFLm/ighTc/19G4hqzwsCs+dTyzQi1AGAUNu6rioNmFuHOorMLqIK
         oAKHFPHzvXD3dUVPj1DnaQTciSpNqgxA8Y8ErhxoTCMAZMReEdPOniTn9DpidJW6d3XT
         NkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WXIwnZTstkLOxPnaDguhsm2lZm98wKFsjXH/T26uJVA=;
        b=jQPrvD+Pzb7pC539nijLmBZgEOr/z19A74ze95d4wuGsC4P6uVc1EIzXoKdnCUDtPc
         aJ6IxxzIOCW+4U3ZeAs0K6pMZwAbWZJgNHIqRFGMqBMhU7qOOedMtK6e1e8DtTtopVVo
         YJL1o88KiniO5U4oL7KV5UD5RY+1VWr7MLJgl0AIA4IG96p728ktK/3bhhKvYer7IYpZ
         chltt2ljbfG2iqBImmwwXwt6tqNxr6sazEB2UTTE+5Up29dbEERFVtLFeqGkcajKpXFs
         aq0VHOkrR8137hToTkCErsOLERe2Q1tMmeDowADPAWZl0D4FQfQ51e0h5bx3JMlGGAbT
         6HqQ==
X-Gm-Message-State: AG10YOSq/j/VHR8trmMPHtGYN5PI2KVpGtbJSq1wCamPFuzA5Qkb3ZeXgxB8ve3BwEP6cQ==
X-Received: by 10.140.104.50 with SMTP id z47mr6686603qge.68.1455772710454;
        Wed, 17 Feb 2016 21:18:30 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:29 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286579>

From: Ronnie Sahlberg <sahlberg@google.com>

Add ref backend methods for:
resolve_ref_unsafe, verify_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 36 ++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 33 +++++++++++++++++++++++----------
 refs/refs-internal.h | 23 +++++++++++++++++++++++
 3 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index ac885cb..bfe3b4e 100644
--- a/refs.c
+++ b/refs.c
@@ -1197,3 +1197,39 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index caeb478..dec8575 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1340,7 +1340,8 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+static int files_resolve_gitlink_ref(const char *path, const char *refname,
+				     unsigned char *sha1)
 {
 	int len = strlen(path), retval;
 	struct strbuf submodule = STRBUF_INIT;
@@ -1580,8 +1581,10 @@ static const char *resolve_ref_1(const char *refname,
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
@@ -1630,7 +1633,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
@@ -2190,7 +2193,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+static int files_pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2381,10 +2384,10 @@ out:
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
@@ -2804,7 +2807,9 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 	return 0;
 }
 
-int create_symref(const char *refname, const char *target, const char *logmsg)
+static int files_create_symref(const char *refname,
+			       const char *target,
+			       const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
@@ -3458,4 +3463,12 @@ struct ref_storage_be refs_be_files = {
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
index c240ca6..ed458fb 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -210,10 +210,33 @@ int do_for_each_ref(const char *submodule, const char *base,
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
 
 extern struct ref_storage_be refs_be_files;
-- 
2.4.2.767.g62658d5-twtrsrc
