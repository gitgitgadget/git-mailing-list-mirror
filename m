From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 20/23] refs.c: add methods for misc ref operations
Date: Wed, 13 Aug 2014 13:15:04 -0700
Message-ID: <1407960907-18189-21-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:15:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexc-0008V4-Gj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbaHMUPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:45 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:40433 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-pd0-f201.google.com with SMTP id g10so84629pdj.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gvFlLuH7Hqq8lsiDt7GWs7r3IObZXKv4Pf6vsUn5hOA=;
        b=pxRK8t8oG537mYIsVIrpyH8lUjgSEdmurhsEgiZXKbcjzZqdh+0EgHYpanII9kXB7V
         Cc3eaNghLNEFcVezZqVJFIILmXU4ILQlx2Hq+tG3OSCXOMG5gkjhWoezAhthgbGiv8zi
         xqtxTtOMRoBOmkCi4jIzZeC+dN00TajCJ1fIa7c8zATufcDGJsm5/KINlTES6FXy7OXa
         CxAz/EAQpt6Mf20t5TO/lFYdcjQ3C5VsfwkK6m6uEel8Vz0hvGKUpFD2Zfdsb2KJVGdK
         8AVZZJ9Vif67O1SKlOUD25m3s/uZSnSLT5Bx1PAcXlM6p3liV2eXBwwhUhSElBVIn5G5
         57vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gvFlLuH7Hqq8lsiDt7GWs7r3IObZXKv4Pf6vsUn5hOA=;
        b=Goo3uHk7/cm+0E/q93HgPJjnKZj1dVi0ahkuPntIUhFQNDlQ8eKdFClmeB6p9BIwPn
         RAbjyhjNVzVDCY8R7rTcglLsxDNSS+5L03XbU0n2/Dm05EuU4GPZr5wPL6gjK1YFVcZn
         U+1T/LqlvzUFyPpw/sSj4pIKZDAQ5DRpaKDygDeKZyVyhxhn/Sl3OwSTWuFx5IMDDx8d
         z8sx8o3P766RGnqi01mNV6mclq1VydzMX6BJfQXO1qkBjo2ulkQBk24/BJxHFWKol4tn
         yFStHsQ2TYf4b+55fIBiBeXBfWdR8/avc64nBjMz2Ucnoo33YrGm9wUqP9sLO9eVwfLl
         VeUQ==
X-Gm-Message-State: ALoCoQnIP5oEZckO4aHkTAVh2Vvn2dVreXo0F6RmQhsALiuWhlmZhUbiLf6Dg/bhUvUH59DScVOb
X-Received: by 10.66.66.196 with SMTP id h4mr3460498pat.22.1407960910912;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l23si210426yhg.1.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A5C465A43D3;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8600EE0AD1; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255237>

Add ref backend methods for:
resolve_ref_unsafe, is_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 33 +++++++++++++++++++++++++++++++++
 refs.c        | 22 +++++++++++++++-------
 refs.h        | 19 +++++++++++++++++++
 3 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 68152d6..d9688e2 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -885,3 +885,36 @@ int delete_reflog(const char *refname)
 {
 	return refs->delete_reflog(refname);
 }
+
+const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1,
+			       int reading, int *flag)
+{
+	return refs->resolve_ref_unsafe(ref, sha1, reading, flag);
+}
+
+int is_refname_available(const char *refname, const char **skip, int skipnum)
+{
+	return refs->is_refname_available(refname, skip, skipnum);
+}
+
+int pack_refs(unsigned int flags, struct strbuf *err)
+{
+	return refs->pack_refs(flags, err);
+}
+
+int peel_ref(const char *refname, unsigned char *sha1)
+{
+	return refs->peel_ref(refname, sha1);
+}
+
+int create_symref(const char *ref_target, const char *refs_heads_master,
+		  const char *logmsg)
+{
+	return refs->create_symref(ref_target, refs_heads_master, logmsg);
+}
+
+int resolve_gitlink_ref(const char *path, const char *refname,
+			unsigned char *sha1)
+{
+	return refs->resolve_gitlink_ref(path, refname, sha1);
+}
diff --git a/refs.c b/refs.c
index 699b548..9439809 100644
--- a/refs.c
+++ b/refs.c
@@ -1114,7 +1114,8 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 	return get_ref_dir(refs->loose);
 }
 
-int is_refname_available(const char *refname, const char **skip, int skipnum)
+static int files_is_refname_available(const char *refname, const char **skip,
+				      int skipnum)
 {
 	if (!is_refname_available_dir(refname, get_packed_refs(&ref_cache),
 				      skip, skipnum))
@@ -1188,7 +1189,7 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+static int files_resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
 {
 	int len = strlen(path), retval;
 	char *submodule;
@@ -1247,7 +1248,7 @@ static const char *handle_missing_loose_ref(const char *refname,
 }
 
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
+static const char *files_resolve_ref_unsafe(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
 {
 	int depth = MAXDEPTH;
 	ssize_t len;
@@ -1466,7 +1467,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
@@ -2080,7 +2081,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags, struct strbuf *err)
+static int files_pack_refs(unsigned int flags, struct strbuf *err)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2453,8 +2454,9 @@ static int write_ref_sha1(struct ref_lock *lock,
 	return 0;
 }
 
-int create_symref(const char *ref_target, const char *refs_heads_master,
-		  const char *logmsg)
+static int files_create_symref(const char *ref_target,
+			       const char *refs_heads_master,
+			       const char *logmsg)
 {
 	const char *lockpath;
 	char ref[1000];
@@ -3301,6 +3303,12 @@ struct ref_be refs_files = {
 	files_reflog_exists,
 	files_create_reflog,
 	files_delete_reflog,
+	files_resolve_ref_unsafe,
+	files_is_refname_available,
+	files_pack_refs,
+	files_peel_ref,
+	files_create_symref,
+	files_resolve_gitlink_ref,
 };
 
 struct ref_be *refs = &refs_files;
diff --git a/refs.h b/refs.h
index 302eb03..ab120c5 100644
--- a/refs.h
+++ b/refs.h
@@ -384,6 +384,19 @@ typedef int (*reflog_exists_fn)(const char *refname);
 typedef int (*create_reflog_fn)(const char *refname);
 typedef int (*delete_reflog_fn)(const char *refname);
 
+typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
+		unsigned char *sha1, int reading, int *flag);
+
+typedef int (*is_refname_available_fn)(const char *refname, const char **skip,
+				       int skipnum);
+typedef int (*pack_refs_fn)(unsigned int flags, struct strbuf *err);
+typedef int (*peel_ref_fn)(const char *refname, unsigned char *sha1);
+typedef int (*create_symref_fn)(const char *ref_target,
+				const char *refs_heads_master,
+				const char *logmsg);
+typedef int (*resolve_gitlink_ref_fn)(const char *path, const char *refname,
+				      unsigned char *sha1);
+
 struct ref_be {
 	transaction_begin_fn transaction_begin;
 	transaction_update_sha1_fn transaction_update_sha1;
@@ -398,6 +411,12 @@ struct ref_be {
 	reflog_exists_fn reflog_exists;
 	create_reflog_fn create_reflog;
 	delete_reflog_fn delete_reflog;
+	resolve_ref_unsafe_fn resolve_ref_unsafe;
+	is_refname_available_fn is_refname_available;
+	pack_refs_fn pack_refs;
+	peel_ref_fn peel_ref;
+	create_symref_fn create_symref;
+	resolve_gitlink_ref_fn resolve_gitlink_ref;
 };
 
 extern struct ref_be *refs;
-- 
2.0.1.556.g3edca4c
