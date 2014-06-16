From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 13/14] refs.c: make unlock_ref/close_ref/commit_ref static
Date: Mon, 16 Jun 2014 09:51:44 -0700
Message-ID: <1402937505-6091-14-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa98-00035X-UL
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbaFPQwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:06 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:50943 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbaFPQvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:51 -0400
Received: by mail-pd0-f202.google.com with SMTP id r10so248431pdi.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PpXYdIOK9qKHTuWKQxeTZlqo2W/7TFQi60aGHxzRuDI=;
        b=KcWoQVuYCbKXviBjy+BTfjxwM5MIqZ52Pp2mUdJ5iN70F6rNIk+b1B1XF+IgvIbloN
         o0sTTg5QlvrO16/B/cHd7FgAY2vcLf+YjzwTbjLqKenuZH8AiipnVm8vHEx99Lqa8SQS
         e1uU7swfuL3/Tjqyv2cBbklgAy5Wtz1KTT7TjETGLxYxPSde2hZfKuGxLbXc5JRNwxJQ
         C8VLQ8OapwVDYUSADsfBTMCXbU0Uql4Q6cAbNwThvknNm7g1kHPc17swtMEJ+7OYIHAm
         pC414TQh4bGZGNeEpktE19gZqo6mtrbM9d2RCmpB3tzUZrI5BbQC7FdOorgjQEvV6nsi
         L+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PpXYdIOK9qKHTuWKQxeTZlqo2W/7TFQi60aGHxzRuDI=;
        b=Xb/GcVOpDFEsCklBz2eesLxNX7YQ4fshkWUmPet4vMymYlWmL6bITPF5MwZNu3ZVzB
         d9pqJs4isalfkH1h2rIKYfzkPy6OM6BIhP1edbv8zn6WEfmGWt2H//Edwyn1R/aoSoix
         8AKu6jHi/yrMxVuEX6qKw1Qwc0C8f2HUyb92TLCLbb9YqsOhf2+R+4rSdodLv4aUNaVQ
         AbBtt8aYFE9lm0mJXIMnn+Hxh274G32SWLwFry39+VBI0RBMLawRCYTLB8QjPJUBBNvA
         raMfw2bWwHoQwkmQCTCAtvK+TLsboXwCI5bpuPH054rGcXe57F2gDNNfc2AypTCQ/mav
         sfig==
X-Gm-Message-State: ALoCoQkPuKg6Z7RuFgn2ewpa07oH3goG6qwST34USvBn0wY/SyYG4klOQbLjxIOI4RY1522L2Ptg
X-Received: by 10.66.137.2 with SMTP id qe2mr972316pab.43.1402937509977;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si983373yhk.4.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C3A885A461A;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 713C8E179B; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251727>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 24 ++++++++++++------------
 refs.h |  9 ---------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index f579d63..3f16445 100644
--- a/refs.c
+++ b/refs.c
@@ -1962,6 +1962,16 @@ int refname_match(const char *abbrev_name, const char *full_name)
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
@@ -2786,7 +2796,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 1;
 }
 
-int close_ref(struct ref_lock *lock)
+static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
@@ -2794,7 +2804,7 @@ int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-int commit_ref(struct ref_lock *lock)
+static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
@@ -2802,16 +2812,6 @@ int commit_ref(struct ref_lock *lock)
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
index c19ca82..2025b96 100644
--- a/refs.h
+++ b/refs.h
@@ -193,15 +193,6 @@ extern struct ref_lock *lock_any_ref_for_update(const char *refname,
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
2.0.0.770.gd892650.dirty
