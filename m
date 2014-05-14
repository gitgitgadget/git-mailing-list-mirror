From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 24/31] refs.c: make unlock_ref static
Date: Wed, 14 May 2014 15:13:23 -0700
Message-ID: <1400105610-21194-25-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhS9-0000IL-H5
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbaENWOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:05 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:61502 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbaENWNl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:41 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so442878vcb.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NXLW6S2tV9jkvnPTfV298PSDpoif+U1inr0VwGiUp5A=;
        b=LDKB8RGbFV8aEg2FUYrj3KUqNF83hopAyRDq73sAldDTraUHLz9plprP760hrRoRte
         jNkyQ2Kdq8eC+HhGs/N4tPzhW6l/PKG94k2X45Zq1OaZ7NpQx/uB7mIGKrtAmaN1LrRw
         rNn6q+ISx8Zq2k0bvQ/9eNDmtPn8RdxQ9UyyCVf4FKUDeGrcUQa79w0HbpMpKUUEwVCw
         Ed62o+sVB7T5bCahHxMj+Rjwb8KByd9G+cBcp+thubvT31PYmYikf1RR60F6Ze0I+nhL
         8HGMEOnQOgfhAiBa6arp+2oUEwq8lwnHpWHOZTL4tD+KQXgW05uTgm5+eCQ6r1Qoy8r+
         7zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NXLW6S2tV9jkvnPTfV298PSDpoif+U1inr0VwGiUp5A=;
        b=Wp806cmBNNl1MQ2R6PWXxYbZ2kG3Xx1Ep+LqS8CE/B9Yf1XyskR8DBADqzOl1eSu3Q
         ZhO2FIm5DwBHkjvLZB4bIllprUgiXbJnbNrqWgFxvwBfEB9UIysH7IqSb1pUhycSQ9N+
         cdPQkqEwdNrTFz6Bun4W1+5bSRtH0iRdZmIO3KOhvRXQ94kjR0YbCu8XPDsBWKXXkLll
         GwUVTaNqSLs+/Q/kwm/1OnW+7nniNbEzy8A2fDbIoOJs8PVtPbnZIOgC6Ugxx+s3GU3E
         MTmo5i4Mh7CmqJUKqT2hfhKvb7g+yeVCE4ymoLCwEC9GwXZAtVtCsot3b9cG+OMrlIfu
         bIaQ==
X-Gm-Message-State: ALoCoQkx1lp0aQGRQjWGTSMLypemoyAWl6aXFx6f9CkQ2GuNL08uCMO9m48PVGv8LXItQ6LIhjvf
X-Received: by 10.58.43.170 with SMTP id x10mr3043808vel.36.1400105620650;
        Wed, 14 May 2014 15:13:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si151205yhb.6.2014.05.14.15.13.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 807615A41E5;
	Wed, 14 May 2014 15:13:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4283AE0973; Wed, 14 May 2014 15:13:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249031>

We no longer need to export unlock_ref. Make the function static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 20 ++++++++++----------
 refs.h |  3 ---
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 17feec5..6933036 100644
--- a/refs.c
+++ b/refs.c
@@ -1931,6 +1931,16 @@ int refname_match(const char *abbrev_name, const char *full_name)
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
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
@@ -2674,16 +2684,6 @@ int commit_ref(struct ref_lock *lock)
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
index 6c628bb..47982ca 100644
--- a/refs.h
+++ b/refs.h
@@ -145,9 +145,6 @@ extern int close_ref(struct ref_lock *lock);
 /** Close and commit the ref locked by the lock */
 extern int commit_ref(struct ref_lock *lock);
 
-/** Release any lock taken but not written. **/
-extern void unlock_ref(struct ref_lock *lock);
-
 /** Setup reflog before using. **/
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
-- 
2.0.0.rc3.506.g3739a35
