From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 13/15] refs.c: make unlock_ref/close_ref/commit_ref static
Date: Mon,  3 Nov 2014 08:55:55 -0800
Message-ID: <1415033757-9539-14-git-send-email-sahlberg@google.com>
References: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 17:58:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlKxu-0002zG-NB
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 17:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbaKCQ6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 11:58:44 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:45013 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbaKCQ4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 11:56:05 -0500
Received: by mail-oi0-f74.google.com with SMTP id u20so1331388oif.5
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aQFfRwYQdbxL8IVhIuMiqrfgH+mWKRXC31Jev2NF0ww=;
        b=KBfc4FNj29HDBJyUNq+MfJTR4K7Fq+wk4h/uR1KW+Ab8tGbPjweVQJSk+WlctWd6Kk
         ByV7CV88J4i4a1vZuSN3Hyovy1mO0s2iQ+KvQxDJoeO03zNnj7nKhiybPh75uiUGKtrZ
         EP6RjeQcDUjALjvumBTHd8CvBzJ0whbLnOA/s23jFTOxM3YmlM9kyjRzzCLbayAdBEr+
         Iv2vBYpQqgnPFqgmqmgL0kCXN1/QQAOvIMuPc4bAszI+a3ojFnrEia85VqSg3muRSG/2
         N96WHBO8SI/fJVPMR0C0GoZAvuYRQooI/GdQFEGqmdS6yxziwXeZ83HEASGA0UVxhwQ+
         E3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aQFfRwYQdbxL8IVhIuMiqrfgH+mWKRXC31Jev2NF0ww=;
        b=X2XZD+smSW+V441tFYe1cHUCIVwAr458SEqmgLBILV9maUKvNcQHh9V7Gu4QdBwZrb
         5vIa+w3HEjQ6JTs4NxEVm0ZK/pHkA5PLFEnfKsFJyTKxWwUZ/3SnzZ5imFXp+ENRHYof
         5NUMZ1WYSTLnLqio+dGXipXrUuVCiUhVZGcwR/EpEBGc2N7eXslxeUUPVXj/kBpvj7J2
         up3orqeL/yCzB63DbBFXLY11qrWPAYDPWxgwLjmEZiTKEJ+2Hd0Ymwxoo39hvykyPmK8
         ASo5UUzEDhKbMcbdy0/txq1eHyYpo3DMLoa/RlzDPW17rdghtBgNsIN9uCImDf4gEmkR
         GKkQ==
X-Gm-Message-State: ALoCoQmEmZaSiruyxzQdniw2Kw//LYLFhCE/SxxdLJCV7oD9JBsHWjHiYycT3sVPXouMUEUkFnUE
X-Received: by 10.182.122.194 with SMTP id lu2mr31472161obb.43.1415033764492;
        Mon, 03 Nov 2014 08:56:04 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 30si477754yhw.1.2014.11.03.08.56.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 08:56:04 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 3isnQdmo.1; Mon, 03 Nov 2014 08:56:04 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C4A12E1109; Mon,  3 Nov 2014 08:56:02 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unlock|close|commit_ref can be made static since there are no more external
callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 24 ++++++++++++------------
 refs.h |  9 ---------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 0b46bd9..e4ad4f4 100644
--- a/refs.c
+++ b/refs.c
@@ -2096,6 +2096,16 @@ int refname_match(const char *abbrev_name, const char *full_name)
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
@@ -2894,7 +2904,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 1;
 }
 
-int close_ref(struct ref_lock *lock)
+static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
@@ -2902,7 +2912,7 @@ int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-int commit_ref(struct ref_lock *lock)
+static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
@@ -2910,16 +2920,6 @@ int commit_ref(struct ref_lock *lock)
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
index 17e3a3c..025e2cb 100644
--- a/refs.h
+++ b/refs.h
@@ -198,15 +198,6 @@ extern struct ref_lock *lock_any_ref_for_update(const char *refname,
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
 extern int read_ref_at(const char *refname, unsigned int flags,
 		       unsigned long at_time, int cnt,
-- 
2.1.0.rc2.206.gedb03e5
