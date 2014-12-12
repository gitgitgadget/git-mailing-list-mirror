From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 21/24] refs.c: remove unlock_ref/close_ref/commit_ref from the refs api
Date: Fri, 12 Dec 2014 09:57:00 +0100
Message-ID: <1418374623-5566-22-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM32-0004td-5R
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965445AbaLLI5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:54 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58938 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934683AbaLLI5l (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:41 -0500
X-AuditID: 1207440c-f79376d00000680a-06-548aae0424da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.8E.26634.40EAA845; Fri, 12 Dec 2014 03:57:40 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nV023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:39 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqMuyrivE4MB5JYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFv8m1Fhs3tzO4sDu8ff9ByaPnbPusnss2FTqcfGSssfnTXIBrFHc
	NkmJJWXBmel5+nYJ3BlPX31nLWgWrVhxpZ2tgbFZsIuRk0NCwETi+aFljBC2mMSFe+vZuhi5
	OIQELjNKLLr2lxHCOcYk0XzyMwtIFZuArsSinmYmEFtEQE1iYtshFpAiZoEfjBITZx9hBkkI
	C0RJ3Lz0gh3EZhFQlTi59ACYzSvgIrF39l2gqRxA6+Qktq7zBglzAoUvtjwBmy8k4CyxdUUn
	6wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJTSjcxQoKMZwfjt3UyhxgF
	OBiVeHhfpHaFCLEmlhVX5h5ilORgUhLl/T4ZKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE928U
	UI43JbGyKrUoHyYlzcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8GhJMEbtwaoUbAoNT21Ii0z
	pwQhzcTBCTKcS0qkODUvJbUosbQkIx4UG/HFwOgASfEA7Q0GaectLkjMBYpCtJ5iVJQS520F
	SQiAJDJK8+DGwlLHK0ZxoC+FeetAqniAaQeu+xXQYCagwcu3dIAMLklESEk1MPqEuFvudEn9
	73f1560lvZ+/fjWLvM7u+ne/w8Gw6sndwavsAo3Y50c9N7bjCArcfbPEe26+wd4pU9nvbTmq
	Isdez5nKdexxaeTN5en/WvY57t28UmLGs9vC4pdeW89+ptz/8XtobIG9nNam90/m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261333>

From: Ronnie Sahlberg <sahlberg@google.com>

unlock|close|commit_ref can be made static since there are no more external
callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 24 ++++++++++++------------
 refs.h |  9 ---------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 0252fcc..618ef9c 100644
--- a/refs.c
+++ b/refs.c
@@ -2090,6 +2090,16 @@ int refname_match(const char *abbrev_name, const char *full_name)
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
@@ -2888,7 +2898,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 1;
 }
 
-int close_ref(struct ref_lock *lock)
+static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
@@ -2896,7 +2906,7 @@ int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-int commit_ref(struct ref_lock *lock)
+static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
@@ -2904,16 +2914,6 @@ int commit_ref(struct ref_lock *lock)
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
index 99e707b..4bb58b9 100644
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
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
  */
-- 
2.1.3
