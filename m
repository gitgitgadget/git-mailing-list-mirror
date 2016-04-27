From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 23/29] unlock_ref(): move definition higher in the file
Date: Wed, 27 Apr 2016 18:57:40 +0200
Message-ID: <81ffd15cf36487d744e5565c49a5b105b1d06da9.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSo0-00040G-0X
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbcD0Q6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:45 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59417 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753011AbcD0Q6m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:42 -0400
X-AuditID: 12074413-473ff700000008c7-5d-5720efc2e3bb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 5C.58.02247.2CFE0275; Wed, 27 Apr 2016 12:58:42 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6a022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:40 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqHvovUK4wfs5QhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7ozZ09cwFdzmqji+5TZzA+N1ji5GTg4JAROJybN6
	mboYuTiEBLYySiy4uowVwjnOJPHnZy8jSBWbgK7Eop5mJhBbRMBBYvnKX+wgRcwCTUwS35c3
	sYAkhAXcJV707mADsVkEVCUmPd3NDmLzCkRJ7J51iQ1inZzE5ekPwGxOAQuJL61vwRYICZhL
	LHmwmn0CI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCFBJryDcddJ
	uUOMAhyMSjy8BRIK4UKsiWXFlbmHGCU5mJREeZecBQrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS
	4Z3+BijHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgPfoOqFGwKDU9
	tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFAXxxcA4AEnxAO0tBWnnLS5IzAWKQrSeYlSU
	Eud9DZIQAElklObBjYWljleM4kBfCvNeAKniAaYduO5XQIOZgAZfPiQLMrgkESEl1cDI9XLy
	nLAoiRTmh+usc+bLfmb/582s4xldlJzUeKzx4289f58FV9N+nL2fpqt/urU4NSFffO/jBWHf
	Jy1SXsbpzij47HTEpA+v7NUKM96JB9n47jj1f/fpS4u83r+8c4n7aPwNj6K9Omnf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292758>

This avoids the need for a forward declaration in the next patch.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 546656a..8f2a795 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1545,6 +1545,16 @@ out:
 	return ret;
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
 /*
  * Peel the entry (if possible) and return its new peel_status.  If
  * repeel is true, re-peel the entry even if there is an old peeled
@@ -1703,16 +1713,6 @@ int do_for_each_ref(const char *submodule, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
-static void unlock_ref(struct ref_lock *lock)
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
  * Verify that the reference locked by lock has the value old_sha1.
  * Fail if the reference doesn't exist and mustexist is set. Return 0
-- 
2.8.1
