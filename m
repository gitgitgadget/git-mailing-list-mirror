From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 20/35] api-lockfile: document edge cases
Date: Tue, 16 Sep 2014 21:33:41 +0200
Message-ID: <1410896036-12750-21-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:42:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTydx-0003lx-J3
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbaIPTmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:42:25 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60015 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755140AbaIPTmI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:08 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Sep 2014 15:42:08 EDT
X-AuditID: 1207440d-f797f6d000000a4a-62-541890d64d27
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 2F.81.02634.6D098145; Tue, 16 Sep 2014 15:34:46 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcO001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:44 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqHttgkSIwavdvBZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdceTdUuaCOQIV3Yf2sjUwruTtYuTkkBAwkbg16zYb
	hC0mceHeeiCbi0NI4DKjxP5DyxkhnBNMEg+3H2YBqWIT0JVY1NPMBJIQEWhjlNh1cTMriMMs
	0M0o8f7EaSaQKmEBa4kza7eCdbAIqEoce/KXFcTmFXCV+Nm0kRVin5zEht3/gVZwcHACxb/u
	KwAxhQRcJA7e9ZvAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkjg
	8e5g/L9O5hCjAAejEg+vxyPxECHWxLLiytxDjJIcTEqivP+6JUKE+JLyUyozEosz4otKc1KL
	DzFKcDArifD+8AXK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkePmA
	ESYkWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qN+GJgdICkeID2aoO08xYXJOYC
	RSFaTzHqcqzr/NbPJMSSl5+XKiXOa9MPVCQAUpRRmge3ApZmXjGKA30sDDGKB5ii4Ca9AlrC
	BLTkbI8YyJKSRISUVANj6j3PrsxUx1050wJtPVl3/nNf6OPlpaF7zdtG7rrt/ENrmQoStyV7
	TZfatOBl9TN7HTPriU4nb8scnXRu3uLaraJrqjLmB2+I8565PfeK5AZBH9FD7tUJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257174>

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
