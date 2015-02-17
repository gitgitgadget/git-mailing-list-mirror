From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/13] refs.c: Change some "flags" to "unsigned int"
Date: Tue, 17 Feb 2015 18:00:13 +0100
Message-ID: <1424192423-27979-4-git-send-email-mhagger@alum.mit.edu>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:00:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlVy-0003mH-VU
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbbBQRAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:00:39 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:65308 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751621AbbBQRAh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:00:37 -0500
X-AuditID: 12074412-f79e46d0000036b4-27-54e373b50031
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 55.B1.14004.5B373E45; Tue, 17 Feb 2015 12:00:37 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXY000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:36 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLu1+HGIQeNaQYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZHw9sYytYaVbR/Ma+gfGjVhcjJ4eEgInEjY6zzBC2mMSFe+vZuhi5
	OIQELjNK/D30gQXCOc4kcejHH0aQKjYBXYlFPc1MILaIgJrExLZDLCA2s8BqJomtd9lAbGEB
	d4nvLR/ZQWwWAVWJyxt+g/XyCrhItG1eDrVNTuL88Z9gNqeAq8SyX8vA6oWAauZ3zGaawMi7
	gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZIkAntYFx/Uu4QowAHoxIP
	r8WERyFCrIllxZW5hxglOZiURHnDix6HCPEl5adUZiQWZ8QXleakFh9ilOBgVhLhDUoByvGm
	JFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfCaggwVLEpNT61Iy8wpQUgz
	cXCCDOeSEilOzUtJLUosLcmIB0VGfDEwNkBSPEB7s0DaeYsLEnOBohCtpxgVpcR5U0ASAiCJ
	jNI8uLGw1PGKURzoS2HedSBVPMC0A9f9CmgwE9Dg+X8egQwuSURISTUwLj/bqbbz9347vq8x
	Ys4LPvyRm5nRNDWrzcigPeHGW6eJiw7t5Pd/PSGs2vjJ/9ttC5uuOHdnxh1Y3OZzJ9lAN867
	aT3PCZ8Qvcaqhe+f1R25M/F7c3KTywPu5292Hl/HEna0wGuNb35jqsx1ttbuUs2n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263956>

Change the following functions' "flags" arguments from "int" to
"unsigned int":

* ref_transaction_update()
* ref_transaction_create()
* ref_transaction_delete()
* update_ref()
* delete_ref()
* lock_ref_sha1_basic()

Also change the "flags" member in "struct ref_update" to unsigned.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c |  3 ++-
 cache.h              |  2 +-
 refs.c               | 18 +++++++++---------
 refs.h               | 10 +++++-----
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2497ba4..9a1659e 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -353,7 +353,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
 	const char *refname, *oldval;
 	unsigned char sha1[20], oldsha1[20];
-	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
+	unsigned int flags = 0;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
diff --git a/cache.h b/cache.h
index f704af5..ab265be 100644
--- a/cache.h
+++ b/cache.h
@@ -568,7 +568,7 @@ extern void update_index_if_able(struct index_state *, struct lock_file *);
 extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
 
-extern int delete_ref(const char *, const unsigned char *sha1, int delopt);
+extern int delete_ref(const char *, const unsigned char *sha1, unsigned int flags);
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
diff --git a/refs.c b/refs.c
index 4de1383..a203e44 100644
--- a/refs.c
+++ b/refs.c
@@ -2256,7 +2256,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    const struct string_list *skip,
-					    int flags, int *type_p)
+					    unsigned int flags, int *type_p)
 {
 	char *ref_file;
 	const char *orig_refname = refname;
@@ -2740,14 +2740,14 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
+int delete_ref(const char *refname, const unsigned char *sha1, unsigned int flags)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, refname, sha1, delopt,
+	    ref_transaction_delete(transaction, refname, sha1, flags,
 				   sha1 && !is_null_sha1(sha1), NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
@@ -3571,7 +3571,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 struct ref_update {
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
+	unsigned int flags; /* REF_NODEREF? */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
@@ -3644,7 +3644,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   unsigned int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3678,7 +3678,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
-			   int flags, const char *msg,
+			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
 	return ref_transaction_update(transaction, refname, new_sha1,
@@ -3688,7 +3688,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   unsigned int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
 	return ref_transaction_update(transaction, refname, null_sha1,
@@ -3697,7 +3697,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 
 int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
-	       int flags, enum action_on_err onerr)
+	       unsigned int flags, enum action_on_err onerr)
 {
 	struct ref_transaction *t;
 	struct strbuf err = STRBUF_INIT;
@@ -3781,7 +3781,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
-		int flags = update->flags;
+		unsigned int flags = update->flags;
 
 		if (is_null_sha1(update->new_sha1))
 			flags |= REF_DELETING;
diff --git a/refs.h b/refs.h
index 9bf2148..92b8597 100644
--- a/refs.h
+++ b/refs.h
@@ -276,7 +276,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   unsigned int flags, int have_old, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -291,7 +291,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
-			   int flags, const char *msg,
+			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -305,7 +305,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   unsigned int flags, int have_old, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -328,8 +328,8 @@ void ref_transaction_free(struct ref_transaction *transaction);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-		const unsigned char *sha1, const unsigned char *oldval,
-		int flags, enum action_on_err onerr);
+	       const unsigned char *sha1, const unsigned char *oldval,
+	       unsigned int flags, enum action_on_err onerr);
 
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
-- 
2.1.4
