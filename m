Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D304C1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754246AbcIDQK0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:10:26 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55325 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754025AbcIDQKN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:10:13 -0400
X-AuditID: 12074414-ca3ff70000000931-29-57cc4730fded
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 15.9A.02353.0374CC75; Sun,  4 Sep 2016 12:09:20 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5a026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:18 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/38] read_raw_ref(): take a (struct ref_store *) argument
Date:   Sun,  4 Sep 2016 18:08:20 +0200
Message-Id: <7bebb0f31efc5fe78fab9d31e055a7ce91898c81.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqGvgfibc4PQqBYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGTv6WlgKHitULL66iLmB8YJUFyMn
        h4SAicT1jysZuxi5OIQEtjJK7P3+khkkISRwkkniww9HEJtNQFdiUU8zE4gtIqAmMbHtEAtI
        AzNIzayJM9lBEsICfhLbH/9mA7FZBFQlOh91AU3l4OAViJKYtVMaYpmcxKVtX8DmcwpYSJzZ
        PZcZpERIwFyi/UX2BEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0LfRyM0v0UlNKNzFC
        wk1kB+ORk3KHGAU4GJV4eC20z4QLsSaWFVfmHmKU5GBSEuWddfBkuBBfUn5KZUZicUZ8UWlO
        avEhRgkOZiURXm0XoHLelMTKqtSifJiUNAeLkjjvt8XqfkIC6YklqdmpqQWpRTBZGQ4OJQne
        BlegRsGi1PTUirTMnBKENBMHJ8hwHqDh80FqeIsLEnOLM9Mh8qcYFaXEeUNAtgqAJDJK8+B6
        YengFaM40CvCvIpuQFU8wFQC1/0KaDAT0OB1u0+DDC5JREhJNTA2Rr4L/JWq/3i6SOEJnoM/
        +8R95mj2dN14ZzP592P3S5vkjasnrBe+FZXwz+3W4llHr+ZWenJrP2jeGDB54d4us81sL+ZP
        sF9ofJCbdaO0maZ0xJRL7ZWrnJtfixgvWXJjWkrVPOfJtwsZtL9vYm5k8mW9/nzivJjbCxTT
        W7XS5/38xPbK6kK0EktxRqKhFnNRcSIA3F1WEeICAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And make the function work for submodules.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               |  4 +++-
 refs/files-backend.c | 18 +++++++++++++-----
 refs/refs-internal.h |  9 ++++++---
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 9475844..9e6b005 100644
--- a/refs.c
+++ b/refs.c
@@ -1222,6 +1222,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	static struct strbuf sb_refname = STRBUF_INIT;
 	int unused_flags;
 	int symref_count;
+	struct ref_store *refs = get_ref_store(NULL);
 
 	if (!flags)
 		flags = &unused_flags;
@@ -1249,7 +1250,8 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
-		if (read_raw_ref(refname, sha1, &sb_refname, &read_flags)) {
+		if (read_raw_ref(refs, refname,
+				 sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3b0c837..ce6fe94 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1349,11 +1349,12 @@ static int resolve_packed_ref(struct files_ref_store *refs,
 	return -1;
 }
 
-int read_raw_ref(const char *refname, unsigned char *sha1,
+int read_raw_ref(struct ref_store *ref_store,
+		 const char *refname, unsigned char *sha1,
 		 struct strbuf *referent, unsigned int *type)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "read_raw_ref");
+		files_downcast(ref_store, 1, "read_raw_ref");
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
@@ -1365,7 +1366,12 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
 
 	*type = 0;
 	strbuf_reset(&sb_path);
-	strbuf_git_path(&sb_path, "%s", refname);
+
+	if (*refs->base.submodule)
+		strbuf_git_path_submodule(&sb_path, refs->base.submodule, "%s", refname);
+	else
+		strbuf_git_path(&sb_path, "%s", refname);
+
 	path = sb_path.buf;
 
 stat_ref:
@@ -1592,8 +1598,9 @@ static int lock_raw_ref(const char *refname, int mustexist,
 			unsigned int *type,
 			struct strbuf *err)
 {
+	struct ref_store *ref_store = get_ref_store(NULL);
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "lock_raw_ref");
+		files_downcast(ref_store, 0, "lock_raw_ref");
 	struct ref_lock *lock;
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
@@ -1683,7 +1690,8 @@ static int lock_raw_ref(const char *refname, int mustexist,
 	 * fear that its value will change.
 	 */
 
-	if (read_raw_ref(refname, lock->old_oid.hash, referent, type)) {
+	if (read_raw_ref(ref_store, refname,
+			 lock->old_oid.hash, referent, type)) {
 		if (errno == ENOENT) {
 			if (mustexist) {
 				/* Garden variety missing reference. */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index b7367ab..fa41d51 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -484,9 +484,11 @@ extern struct ref_iterator *current_ref_iter;
 int do_for_each_ref_iterator(struct ref_iterator *iter,
 			     each_ref_fn fn, void *cb_data);
 
+struct ref_store;
+
 /*
- * Read the specified reference from the filesystem or packed refs
- * file, non-recursively. Set type to describe the reference, and:
+ * Read a reference from the specified reference store, non-recursively.
+ * Set type to describe the reference, and:
  *
  * - If refname is the name of a normal reference, fill in sha1
  *   (leaving referent unchanged).
@@ -522,7 +524,8 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
  * - in all other cases, referent will be untouched, and therefore
  *   refname will still be valid and unchanged.
  */
-int read_raw_ref(const char *refname, unsigned char *sha1,
+int read_raw_ref(struct ref_store *ref_store,
+		 const char *refname, unsigned char *sha1,
 		 struct strbuf *referent, unsigned int *type);
 
 /* refs backends */
-- 
2.9.3

