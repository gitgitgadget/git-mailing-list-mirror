From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 21/23] refs-be-files.c: add methods for misc ref operations
Date: Tue, 19 Aug 2014 09:30:45 -0700
Message-ID: <1408465847-30384-22-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKc-0002zZ-Py
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbaHSQbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:37 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:56647 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbaHSQay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:54 -0400
Received: by mail-oa0-f74.google.com with SMTP id eb12so1479199oac.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ioQJbrVhyfS1v/dLVvHQhfigvPh1+duy3YMdR2NG4mk=;
        b=LZiJej28HzFzuQwWF6kugKJ9wouER2dmaEYV8cnB/5LUP403Xy9LF6o1kQmMZ548gi
         WhndLbHHEGfxj6823xQBqrpxhtgwFQCuoVhkAogOAJCikLHpFviR5A4mW5ZUZWti8yyJ
         vkEpXGY9KRefo6bFmWjlGf3TfjUygWFqqOlLo6umXkMPzrAhjlpuizc0yX14xlbeOvy1
         f4PyTPkO8RbMPNZB3W55QxnnSUfU9BMsx8CTVh4YYm701uBB5qe3NBCOblAdupzdS0Pl
         x+HaR1yiqLiK5FSNRYDqGgIR4qO3Sh5T+rKzxbwqYtlq5sFZ68pF8nRhZSMHu7+2UFSD
         K1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ioQJbrVhyfS1v/dLVvHQhfigvPh1+duy3YMdR2NG4mk=;
        b=bPwqFgMUOuCU9ZgOIRRByXjFRUDWN06d8IOtCxVcqHgtTWOlxOqZT7qBvCnldtW8QV
         LaRvZAhaG2SncgRrCzqqLgtVfvGyjNi9aBj8byV2DQKw1VR+9MqqnqUjJuXCDbf2HlHG
         bzBjYJfgBk3rGtZFfJYBK8yIyIHhsoilTqs57cPmZfM10Zp/9VrQWdlWxop2m/Sx+bL9
         6z7X/MlRJKLnALP+rTV87JdWeGQrQEQPMIsNpuKSAg5dOCDRdGixebC6QI42hRR5Cw+y
         aFfTPmgnyqwk8MvRiVy5WWe/4F1YoWC9Hh7vr4A2voz/8aQzD5f0TF+hMwMPUx0n+Xt1
         5iQQ==
X-Gm-Message-State: ALoCoQkABL4/yGL2m4PWyxBXC758jKKI66jVeEt/eoIakwlOBRAMqCJd0e2LjYXM9Ltykv8mr+Tz
X-Received: by 10.43.1.133 with SMTP id nq5mr23554890icb.21.1408465853834;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t75si329276yhe.5.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9946831C536;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4E0C6E0E84; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255486>

Add ref backend methods for:
resolve_ref_unsafe, is_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 25 ++++++++++++++++++-------
 refs.c          | 33 +++++++++++++++++++++++++++++++++
 refs.h          | 18 ++++++++++++++++++
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 464d488..b09f0fc 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1114,7 +1114,8 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 	return get_ref_dir(refs->loose);
 }
 
-int is_refname_available(const char *refname, const char **skip, int skipnum)
+static int files_is_refname_available(const char *refname, const char **skip,
+				      int skipnum)
 {
 	if (!is_refname_available_dir(refname, get_packed_refs(&ref_cache),
 				      skip, skipnum))
@@ -1188,7 +1189,8 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+static int files_resolve_gitlink_ref(const char *path, const char *refname,
+				     unsigned char *sha1)
 {
 	int len = strlen(path), retval;
 	char *submodule;
@@ -1247,7 +1249,9 @@ static const char *handle_missing_loose_ref(const char *refname,
 }
 
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
+static const char *files_resolve_ref_unsafe(const char *refname,
+					    unsigned char *sha1, int flags,
+					    int *ref_flag)
 {
 	int depth = MAXDEPTH;
 	ssize_t len;
@@ -1466,7 +1470,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
@@ -2080,7 +2084,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags, struct strbuf *err)
+static int files_pack_refs(unsigned int flags, struct strbuf *err)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2453,8 +2457,9 @@ static int write_ref_sha1(struct ref_lock *lock,
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
@@ -3304,6 +3309,12 @@ struct ref_be refs_files = {
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
diff --git a/refs.c b/refs.c
index 2db1a74..60b6241 100644
--- a/refs.c
+++ b/refs.c
@@ -888,3 +888,36 @@ int delete_reflog(const char *refname)
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
diff --git a/refs.h b/refs.h
index 0a68986..5257437 100644
--- a/refs.h
+++ b/refs.h
@@ -382,6 +382,18 @@ typedef int (*for_each_reflog_fn)(each_ref_fn fn, void *cb_data);
 typedef int (*reflog_exists_fn)(const char *refname);
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
 
 struct ref_be {
 	transaction_begin_fn transaction_begin;
@@ -397,6 +409,12 @@ struct ref_be {
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
2.0.1.552.g1af257a
