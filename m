From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 13/15] refs.c: make unlock_ref/close_ref/commit_ref static
Date: Wed, 23 Jul 2014 10:03:53 -0700
Message-ID: <1406135035-26441-14-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zyI-0004nO-Rw
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbaGWREl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:41 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:52020 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932488AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so418584ieb.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SyHCKlkSJ/PgYsQ6XXoG/hi71jvxNWVOlj7dx/rB7XQ=;
        b=nHokKeeceuqwgynX60+QNv4Nc1aO54gW4GHD+3yM4LzmXE8VWePYUvrDWipWBfS+z1
         W4yle00cXf1uVMMwLr+0ZDOpKSv8BDARBE8WaHBRerHlBJRbAZZnx9+Sh1WAHllqKWyO
         uPrvhQAveVDH/EqYHK6N9pscE7fcq0Hf92Xer2WSidnSqXKgy6WrO9+Xnjv7Jz/TnDxt
         /4AtPmYySMreu89UwjAV5oFdtW9vlqM8Ap4EMNGnwr1TN7OYpz+Us2ZbbR4MlSDtFm3U
         tev4S7kL3Yc0+7nLTrn4GgPsrrIrBPX7u0t9k44/V2XaOpwh4uSqm7ux6TUlvpVPvZac
         02XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SyHCKlkSJ/PgYsQ6XXoG/hi71jvxNWVOlj7dx/rB7XQ=;
        b=l0hWF32fHItghtcE54/fZAQqYDFMeR3wGvpUOVmlL6lB80jw6z6r+xJYVr4IzlXexF
         fvwrtz2iI1VHfcmMTrdvdiSBn4gt5aGAEmqd24eLqIBc7Y+wHrkbs4i0gwC1PJMizr7B
         m6QE4/9a/Y6AJSQDJJ69UgjRiQO7ORo70rRVb8UCec115zxRZBxjqtfRZLhYHiEnlZGJ
         KdhdVt+yBM0kQC3b7wDbW9xl4FjjTWkUw2TwldJ8duI/ZeST+zBJJG5MYI62QpeAGdiq
         QafEXk3UrdCawX6WHSmdF8KlaZXRQVLlsi36cHr2Haa6rFrKEblhObg2uVXIxKG0u02n
         NFnw==
X-Gm-Message-State: ALoCoQnmZ899qvPY7l9FGij10diqBTzMpQo5W8dF9JfUNJuwcGKQNgP4jhFTBZtC13/p2U0abmnm
X-Received: by 10.50.33.18 with SMTP id n18mr9238370igi.8.1406135038968;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v44si487010yhv.0.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CACDE31C34E;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A8C5FE0B1A; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254094>

unlock|close|commit_ref can be made static since there are no more external
callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 24 ++++++++++++------------
 refs.h |  9 ---------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index b7940e0..b74e5ff 100644
--- a/refs.c
+++ b/refs.c
@@ -1969,6 +1969,16 @@ int refname_match(const char *abbrev_name, const char *full_name)
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
@@ -2766,7 +2776,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 1;
 }
 
-int close_ref(struct ref_lock *lock)
+static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
@@ -2774,7 +2784,7 @@ int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-int commit_ref(struct ref_lock *lock)
+static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
@@ -2782,16 +2792,6 @@ int commit_ref(struct ref_lock *lock)
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
index 6763f69..65d6360 100644
--- a/refs.h
+++ b/refs.h
@@ -187,15 +187,6 @@ extern struct ref_lock *lock_any_ref_for_update(const char *refname,
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
2.0.1.508.g763ab16
