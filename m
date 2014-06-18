From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 13/14] refs.c: make unlock_ref/close_ref/commit_ref static
Date: Wed, 18 Jun 2014 10:09:05 -0700
Message-ID: <1403111346-18466-14-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMn-0007A7-1O
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbaFRRJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:33 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:54200 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so300918oag.3
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=owjc/VHZ64T6cZpbAvE24UKuGm7gAyGRQBHDbvOFTaE=;
        b=Uzxv18E6FSJGuDyOT8bM8lRLKJf5PlgPT47Fbqn/qrbiSIKxxgFJ5WaZO0iZK3T3rU
         bPYYv3QN5WxdVt2Y0STdTENCI0EfxBzakmMftxxwiZVVyRUBIEB8wKLaU5j/ke77DU0U
         HKhCfN0yov51UvlJn0MzGsDNTSDCqeiwmLqa5JiVmCyrLy0hl4roHGoWU52ZKivinR4q
         NMF/oxP+6quZlZsnUGEu8AZ7wHNKsob1uhAjUf8PG4/W0JdaIGU0zu7v9b290DoTe519
         sX8JFxqqZ2BpA34o4yc5gpEb2B26aWZq8vBdurOAcG7WNJlREvL2iubkYM7Im0ZYETK8
         lFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=owjc/VHZ64T6cZpbAvE24UKuGm7gAyGRQBHDbvOFTaE=;
        b=UZzgGHSfU9NEyqooAZ2Pctema9qohCHvgK/mN+3DcrU0s+RdTu6Rejx2fw2bOQm5BR
         PQkeeJd7a1dPAj7MOpR6m8tFASo8nHsKkh8LcI31FWQX5nDE0R7n99u1ZXi9PfUt5bmD
         9Pu+t/VQ1EQr19Uyd58gHYfngpUGAyJPFGqTgP5DkwM/lYiD5uR60lH0tLF9QLyhNEKr
         hEvvfNifi7NqebKXwOWdyUtKQtaT/eVJOrtwn1AeSau58hlJ7+nxFLqkDdCu67g1zrZ3
         wBHMHfi4zdg5TSLy/XyAcD/7Gocj6YIqcbuJEO8H3VQWbn9V3Lzl4cS9onR2063Ik+jI
         wFwg==
X-Gm-Message-State: ALoCoQnwiWyrZJx4IH2JuvBeHA8oEodzVhvmbgjmCHNhWpsJNKgs1Hlvevq0AUXkOJqNWbNrlSQ/
X-Received: by 10.50.148.1 with SMTP id to1mr2104504igb.0.1403111350162;
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si173683yhb.3.2014.06.18.10.09.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 05B0C5A478E;
	Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CE474E0DBC; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252001>

unlock|close|commit_ref can be made static since there are no more external
callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 24 ++++++++++++------------
 refs.h |  9 ---------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 9653a01..ff98682 100644
--- a/refs.c
+++ b/refs.c
@@ -1960,6 +1960,16 @@ int refname_match(const char *abbrev_name, const char *full_name)
 	return 0;
 }
 
+static void unlock_ref(struct ref_lock *lock)
+{
+	/* Do not free lock->lk -- atexit() still looks at them */
+	if (lock->lk)
+		rollback_lock_file(lock->lk);
+	free(lock->ref_name);
+	free(lock->orig_ref_name);
+	free(lock);
+}
+
 /* This function should make sure errno is meaningful on error */
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
@@ -2769,7 +2779,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 1;
 }
 
-int close_ref(struct ref_lock *lock)
+static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
@@ -2777,7 +2787,7 @@ int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-int commit_ref(struct ref_lock *lock)
+static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
@@ -2785,16 +2795,6 @@ int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-void unlock_ref(struct ref_lock *lock)
-{
-	/* Do not free lock->lk -- atexit() still looks at them */
-	if (lock->lk)
-		rollback_lock_file(lock->lk);
-	free(lock->ref_name);
-	free(lock->orig_ref_name);
-	free(lock);
-}
-
 /*
  * copy the reflog message msg to buf, which has been allocated sufficiently
  * large, while cleaning up the whitespaces.  Especially, convert LF to space,
diff --git a/refs.h b/refs.h
index e7892fc..5054388 100644
--- a/refs.h
+++ b/refs.h
@@ -194,15 +194,6 @@ extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
 
-/** Close the file descriptor owned by a lock and return the status */
-extern int close_ref(struct ref_lock *lock);
-
-/** Close and commit the ref locked by the lock */
-extern int commit_ref(struct ref_lock *lock);
-
-/** Release any lock taken but not written. **/
-extern void unlock_ref(struct ref_lock *lock);
-
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 		       unsigned char *sha1, char **msg,
-- 
2.0.0.467.g08c0633
