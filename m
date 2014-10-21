From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 13/15] refs.c: make unlock_ref/close_ref/commit_ref static
Date: Tue, 21 Oct 2014 12:24:20 -0700
Message-ID: <1413919462-3458-14-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:24:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf3A-0000PF-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbaJUTYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:24:48 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:37955 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723AbaJUTYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:24:36 -0400
Received: by mail-qa0-f73.google.com with SMTP id cm18so186895qab.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jb+Ktj1V/NEZOvn4NyW4Mf5azV/irtwmOUDPnSLUMXY=;
        b=OMWCpiNbC+/nmQqwQtzhaufcEPlI5r//TQnXeIXIXoR0mTKI5Gqc6HDLkvd9QhUuBU
         8Mf5v1D0cXPgWdmJ2v7DuxBL+3yWBxn3WvduuV6Emm1K01q4sZBa84GtF1H6+lNS0sPG
         bjUgbXb4rMH09Beifb412aY3/2J22Ueim7j+ePyhw5jZ+hVuvOD9YMDnSo/VMhYzBHqY
         UpgGyVCx7qtLmrO7Talx5VVEzPR6VjwDFJCdjCJ6H6oneE3Cnq83UdsgTtfnfQH7MUjs
         JqdlFUG2XG6N7468qXq28mDbp6me2lpo4IYJsRJjAINkfJNxFWPuGU4AW4DL2yFGpu+R
         FNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jb+Ktj1V/NEZOvn4NyW4Mf5azV/irtwmOUDPnSLUMXY=;
        b=COscne9pvEXK4rsKyGTmm+85JZLbJTanvLpivCx+58CW6oepD03T6bjXamSv2NTmH3
         sTdzUENz/AvRY9mG0A+yvnMZdLSq7BlbPnFO7UZMws9trGB+jVyGSkxcqm+24jX4J4ki
         Ki0CElMTSIzP/zPpCscG4qWN6PJgMPs+O0w1m5wJpFDgasOmnzpxJR6U3Qq/hHn2s6to
         9V79/zNaDmVC6oO8wd8TFHwzYl1MEltPVPXaTTLHcWOm98f5M00IswMLUoyf+49Dg4En
         Q3m8vGaE2NF8Na1kBoI7BidOnirV5jd1tWntMck09hQAQtesP4t9lMhKWS5uuRL9BoHx
         5qgw==
X-Gm-Message-State: ALoCoQmPjx0y00aRYjSXQhkrIvXXR+qXobjdWTWx1YUfzvKO3D4fwzNZz9Zfao7HdgW8Lt0+aEaC
X-Received: by 10.236.53.130 with SMTP id g2mr23883604yhc.31.1413919475620;
        Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n24si582839yha.6.2014.10.21.12.24.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id layt37lL.1; Tue, 21 Oct 2014 12:24:35 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AF29FE11BF; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit a4369f77d1975566bcd29bfa46720d48372c241d upstream.

unlock|close|commit_ref can be made static since there are no more external
callers.

Change-Id: I743f9daaa1c101fdc781a76283c2e8b462591d07
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 24 ++++++++++++------------
 refs.h |  9 ---------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 952cc66..5e5f066 100644
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
