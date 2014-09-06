From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 20/32] api-lockfile: document edge cases
Date: Sat,  6 Sep 2014 09:50:34 +0200
Message-ID: <1409989846-22401-21-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 10:00:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAue-0005R8-Q1
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 10:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbaIFH7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:55 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49036 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751408AbaIFH7w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:52 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Sep 2014 03:59:52 EDT
X-AuditID: 12074411-f79d86d000006a97-81-540abd3a6e75
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.7D.27287.A3DBA045; Sat,  6 Sep 2014 03:52:26 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHJ006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:25 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqGu1lyvEYFGPtkXXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi86Or4wObB5/339g8nj4qovd41nvHkaPi5eUPT5vkvO4/WwbSwBb
	FLdNUmJJWXBmep6+XQJ3xpF3S5kL5ghUdB/ay9bAuJK3i5GTQ0LARKL1yGpGCFtM4sK99Wxd
	jFwcQgKXGSUWbPjPDuEcY5JY9uM9WBWbgK7Eop5mJpCEiEAbo8Sui5tZQRLMAikSHc+7wYqE
	Bawlrv+YzAJiswioSiz79g7M5hVwlVg5cQHUOjmJDbv/g9mcQPHpTZ1gtpCAi0T7yX6mCYy8
	CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmurlZpbopaaUbmKEhJrgDsYZJ+UOMQpwMCrx
	8BY4cIUIsSaWFVfmHmKU5GBSEuXNWw4U4kvKT6nMSCzOiC8qzUktPsQowcGsJMLbMRkox5uS
	WFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4HXZA9QoWJSanlqRlplTgpBm
	4uAEGc4lJVKcmpeSWpRYWpIRD4qO+GJgfICkeID2soK08xYXJOYCRSFaTzHqcqzr/NbPJMSS
	l5+XKiXOywRSJABSlFGaB7cCllheMYoDfSzMKwZSxQNMSnCTXgEtYQJaYp7OCbKkJBEhJdXA
	mM5xqX11S5r778VbcucvtsznsFrcIBUzqeUyX6I8R7y/pFDAx1h5T2sB5zZD5cd+HQqi2gbr
	a15PXMuev+zt6k/r3F/eDZ6idPKO6rb8lFVfJWXTpm58sasjToX/02TLtIwiX4PP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256580>

* Document the behavior of commit_lock_file() when it fails, namely
  that it rolls back the lock_file object and sets errno
  appropriately.

* Document the behavior of rollback_lock_file() when called for a
  lock_file object that has already been committed or rolled back,
  namely that it is a NOOP.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 9a94ead..2514559 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -64,19 +64,22 @@ unable_to_lock_die::
 
 commit_lock_file::
 
-	Take a pointer to the `struct lock_file` initialized
-	with an earlier call to `hold_lock_file_for_update()`,
-	close the file descriptor and rename the lockfile to its
-	final destination.  Returns 0 upon success, a negative
-	value on failure to close(2) or rename(2).  It is a bug to
-	call `commit_lock_file()` for a `lock_file` object that is not
+	Take a pointer to the `struct lock_file` initialized with an
+	earlier call to `hold_lock_file_for_update()`, close the file
+	descriptor and rename the lockfile to its final destination.
+	Return 0 upon success.  On failure, rollback the lock file and
+	return -1, with `errno` set to the value from the failing call
+	to `close(2)` or `rename(2)`.  It is a bug to call
+	`commit_lock_file()` for a `lock_file` object that is not
 	currently locked.
 
 rollback_lock_file::
 
 	Take a pointer to the `struct lock_file` initialized
 	with an earlier call to `hold_lock_file_for_update()`,
-	close the file descriptor and remove the lockfile.
+	close the file descriptor and remove the lockfile.  It is a
+	NOOP to call `rollback_lock_file()` for a `lock_file` object
+	that has already been committed or rolled back.
 
 close_lock_file::
 	Take a pointer to the `struct lock_file` initialized
-- 
2.1.0
