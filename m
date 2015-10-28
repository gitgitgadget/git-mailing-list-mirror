From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 01/26] refs.c: create a public version of verify_refname_available
Date: Tue, 27 Oct 2015 22:14:02 -0400
Message-ID: <1445998467-11511-2-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:14:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGL-0000pm-7I
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198AbbJ1COn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:14:43 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33182 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbbJ1COl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:14:41 -0400
Received: by igbkq10 with SMTP id kq10so108250263igb.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w+SAiMmlQAOCszvaADeaHMj85g+oCUnKxwFemThxPEE=;
        b=tK66+Zx6nL1mqXRXEwTWb8VBwbr+7kDRST8lUGfNnWmVOR7gJQAesaIg5DXvOFN/mz
         Rs2RA/Pq/7aZpiQsaNm66NZiR8jvuLEzkPZeaW7ssl8Gqh8hr13Okj1kJBFFMK0krK0/
         LwXkmbGn0N3XzUhZD1Gtsim0kZUnymK5EAFZJUKErOjtHzo8DqKRNvND2BMwSTNvNXLY
         L5n8ISwcaVadoNJvKRs+v+Qx3Oxy9LwT6sewNXBfdQ8s3x1vlp5Uy5+ysGGVxNAICpd5
         t5K5HbqXmJqauQIHno/+K/MYdhGYoI4Fe2SZiV1R3CPk9IsUi9ytiVX+9G9yECNDvfRl
         pqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w+SAiMmlQAOCszvaADeaHMj85g+oCUnKxwFemThxPEE=;
        b=kRHAyzxV/8NReFKjYfX7d0woPiEzuOFb8ZBJoJ+1kD/d9aVcZYL9Iu6Zaxe/EoK/+W
         htig3buEBjkS5X7a0FWuxFF9/79Ivm9FCjfhJva8eHu9kBbKzH9HUYTTSPBeGfFXadnA
         lfoOs7Tm6TyotUayW9JJdEavk96RGZmiYoQsAGipH00uWwBr15Cz2VOcerMO7ZxiWOrL
         YsOpEIXgwhm52O6AFoYSMjsKm6etlwYCalFUcuQBPhNDK5l6qnW6gNqQlQ1B5kIWXU8W
         c9uTnX+FnLofvhw2Wppyseoft2pWjztXOFtl/kvudDzWofdjPTJ6gLMyfXbQ/TFDutsL
         Qbkg==
X-Gm-Message-State: ALoCoQnI7CSEhElLv0c1SnyUZECv1dY1mgGL4E5Va/MKNw20xZAFa+5DVxSOutLnp1Fjo4GMZpDZ
X-Received: by 10.50.43.134 with SMTP id w6mr379825igl.32.1445998481051;
        Tue, 27 Oct 2015 19:14:41 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.14.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:14:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280327>

From: Ronnie Sahlberg <sahlberg@google.com>

Create a public version of verify_refname_available that backends can
provide.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 65 ++++++++++++++++++++++++++++++-----------------------------------
 refs.h | 20 ++++++++++++++++++++
 2 files changed, 50 insertions(+), 35 deletions(-)

diff --git a/refs.c b/refs.c
index 132eff5..fe71ea0 100644
--- a/refs.c
+++ b/refs.c
@@ -279,7 +279,7 @@ struct ref_dir {
  * presence of an empty subdirectory does not block the creation of a
  * similarly-named reference.  (The fact that reference names with the
  * same leading components can conflict *with each other* is a
- * separate issue that is regulated by verify_refname_available().)
+ * separate issue that is regulated by verify_refname_available_dir().)
  *
  * Please note that the name field contains the fully-qualified
  * reference (or subdirectory) name.  Space could be saved by only
@@ -897,25 +897,13 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 /*
  * Return 0 if a reference named refname could be created without
  * conflicting with the name of an existing reference in dir.
- * Otherwise, return a negative value and write an explanation to err.
- * If extras is non-NULL, it is a list of additional refnames with
- * which refname is not allowed to conflict. If skip is non-NULL,
- * ignore potential conflicts with refs in skip (e.g., because they
- * are scheduled for deletion in the same operation). Behavior is
- * undefined if the same name is listed in both extras and skip.
- *
- * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "refs/foo/bar" conflicts
- * with both "refs/foo" and with "refs/foo/bar/baz" but not with
- * "refs/foo/bar" or "refs/foo/barbados".
- *
- * extras and skip must be sorted.
+ * See verify_refname_available for details.
  */
-static int verify_refname_available(const char *refname,
-				    const struct string_list *extras,
-				    const struct string_list *skip,
-				    struct ref_dir *dir,
-				    struct strbuf *err)
+static int verify_refname_available_dir(const char *refname,
+					const struct string_list *extras,
+					const struct string_list *skip,
+					struct ref_dir *dir,
+					struct strbuf *err)
 {
 	const char *slash;
 	int pos;
@@ -2464,9 +2452,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		 */
 		strbuf_git_path(&orig_ref_file, "%s", orig_refname);
 		if (remove_empty_directories(&orig_ref_file)) {
+			struct ref_dir *loose_refs;
+			loose_refs = get_loose_refs(&ref_cache);
 			last_errno = errno;
-			if (!verify_refname_available(orig_refname, extras, skip,
-						      get_loose_refs(&ref_cache), err))
+			if (!verify_refname_available_dir(orig_refname, extras,
+							  skip, loose_refs,
+							  err))
 				strbuf_addf(err, "there are still refs under '%s'",
 					    orig_refname);
 			goto error_return;
@@ -2479,8 +2470,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	if (!refname) {
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
-		    !verify_refname_available(orig_refname, extras, skip,
-					      get_loose_refs(&ref_cache), err))
+		    !verify_refname_available_dir(orig_refname, extras, skip,
+						  get_loose_refs(&ref_cache),
+						  err))
 			strbuf_addf(err, "unable to resolve reference %s: %s",
 				    orig_refname, strerror(last_errno));
 
@@ -2493,8 +2485,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * our refname.
 	 */
 	if (is_null_oid(&lock->old_oid) &&
-	    verify_refname_available(refname, extras, skip,
-				     get_packed_refs(&ref_cache), err)) {
+	    verify_refname_available_dir(refname, extras, skip,
+					 get_packed_refs(&ref_cache), err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -3127,10 +3119,7 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	int ret;
 
 	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip,
-					get_packed_refs(&ref_cache), &err)
-		&& !verify_refname_available(newname, NULL, &skip,
-					     get_loose_refs(&ref_cache), &err);
+	ret = !verify_refname_available(newname, NULL, &skip, &err);
 	if (!ret)
 		error("%s", err.buf);
 
@@ -3299,6 +3288,17 @@ static int should_autocreate_reflog(const char *refname)
 		!strcmp(refname, "HEAD");
 }
 
+int verify_refname_available(const char *newname, struct string_list *extra,
+			     struct string_list *skip, struct strbuf *err)
+{
+	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
+	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
+	return verify_refname_available_dir(newname, extra, skip,
+					    packed_refs, err) ||
+		verify_refname_available_dir(newname, extra, skip,
+					     loose_refs, err);
+}
+
 /*
  * Create a reflog for a ref.  If force_create = 0, the reflog will
  * only be created for certain refs (those for which
@@ -4334,8 +4334,6 @@ static int ref_present(const char *refname,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
-	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -4378,10 +4376,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (verify_refname_available(update->refname,
 					     &affected_refnames, NULL,
-					     loose_refs, err) ||
-		    verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
-					     packed_refs, err)) {
+					     err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
 		}
diff --git a/refs.h b/refs.h
index 6d30c98..7367a7f 100644
--- a/refs.h
+++ b/refs.h
@@ -218,6 +218,26 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
 int pack_refs(unsigned int flags);
 
 /*
+ * Return 0 if a reference named refname could be created without
+ * conflicting with the name of an existing reference.
+ * Otherwise, return a negative value and write an explanation to err.
+ * If extras is non-NULL, it is a list of additional refnames with
+ * which refname is not allowed to conflict. If skip is non-NULL,
+ * ignore potential conflicts with refs in skip (e.g., because they
+ * are scheduled for deletion in the same operation). Behavior is
+ * undefined if the same name is listed in both extras and skip.
+ *
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
+ *
+ * skip must be sorted.
+ */
+int verify_refname_available(const char *newname, struct string_list *extra,
+			     struct string_list *skip, struct strbuf *err);
+
+/*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
-- 
2.4.2.658.g6d8523e-twtrsrc
