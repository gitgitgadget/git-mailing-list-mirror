From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 16/32] commit_lock_file(): inline temporary variable
Date: Sat,  6 Sep 2014 09:50:30 +0200
Message-ID: <1409989846-22401-17-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAua-0005Mq-2u
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbaIFH7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:53 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49036 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751481AbaIFH7w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:52 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Sep 2014 03:59:52 EDT
X-AuditID: 12074411-f79d86d000006a97-7d-540abd34f51d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 39.7D.27287.43DBA045; Sat,  6 Sep 2014 03:52:20 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHF006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:19 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqGuylyvEYNEZE4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujNezPrIUNLBVXLu1gqWB8T1LFyMnh4SAicTGE0eZIWwxiQv31rN1
	MXJxCAlcZpRYe+AWK0hCSOAYk8SPFgkQm01AV2JRTzMTSJGIQBujxK6Lm8GKmAVSJDqedzOC
	2MIC7hINB5eBbWARUJX4suc+E4jNK+AqcfLFPkaIbXISG3b/B7M5geLTmzoZIZa5SLSf7Gea
	wMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZIoAnuYJxxUu4QowAH
	oxIPb4EDV4gQa2JZcWXuIUZJDiYlUd685UAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwdk4Fy
	vCmJlVWpRfkwKWkOFiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJXpc9QI2CRanpqRVpmTkl
	CGkmDk6Q4VxSIsWpeSmpRYmlJRnxoNiILwZGB0iKB2gvK0g7b3FBYi5QFKL1FKMxR0vT214m
	jnWd3/qZhFjy8vNSpcR5mUBKBUBKM0rz4BbBUswrRnGgv4V5xUCqeIDpCW7eK6BVTECrzNM5
	QVaVJCKkpBoYt3i+arwZ9Zu97doOcb8r2+w+c6jFZeitDuZmsF9ntsKiSXvNma/l3hI/lk7U
	N2YNmrXMICFr0aQjR7P32PJurF+/ef7hWUq3FtfHq0n//cj6bFbGTfUNdxlcn6gW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256579>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index dacfc28..d64cf6b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -306,12 +306,14 @@ int reopen_lock_file(struct lock_file *lk)
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
-	size_t i;
+
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
+
 	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
-	result_file[i] = 0;
+	/* remove ".lock": */
+	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
+
 	if (rename(lk->filename, result_file))
 		return -1;
 	lk->filename[0] = 0;
-- 
2.1.0
