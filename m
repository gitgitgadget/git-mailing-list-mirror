From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/25] lockfile: define a constant LOCK_SUFFIX_LEN
Date: Mon,  7 Apr 2014 01:33:52 +0200
Message-ID: <1396827247-28465-11-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbQ-000602-E1
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbaDFXfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:45 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53206 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754633AbaDFXfB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:01 -0400
X-AuditID: 1207440e-f79c76d000003e2c-75-5341e4a59708
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 30.39.15916.5A4E1435; Sun,  6 Apr 2014 19:35:01 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWv011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:34:59 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLv0iWOwwcqV/BZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+NE0zq2ghVcFR2901gaGKdwdDFyckgImEhsWzST
	GcIWk7hwbz1bFyMXh5DAZUaJSXueMkI4x5kk3rd/YwSpYhPQlVjU08wEYosIqElMbDvEAlLE
	LHCDUeLdvsNADgeHsICrxO2NuSA1LAKqEouPz2QDsXmBwm/v/WOE2CYncfLYZFYQmxMovm7y
	XBYQW0jABWjMPbYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6+VmluilppRuYoSE
	Ht8Oxvb1MocYBTgYlXh4VxxyDBZiTSwrrsw9xCjJwaQkymt5DyjEl5SfUpmRWJwRX1Sak1p8
	iFGCg1lJhPfADaAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC9+hj
	oEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UGzEFwOjAyTFA7T3Ikg7b3FBYi5Q
	FKL1FKOilDjvzEdACQGQREZpHtxYWEJ5xSgO9KUw7zKQdh5gMoLrfgU0mAlocEOYHcjgkkSE
	lFQDY/eEOfMN1Ys5V7OHvp0rYf96j2mT0iad910t/ha7DlxObUl3sW/QOZny5sHDFDulCZfy
	3Z26XuhN0vKaHFR+OOIt9/Mq37SqPre7F9xKdHdddD850fbbsq5wp4ebJ9xVnrRn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245812>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 2438430..1bd0ae1 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -178,14 +178,17 @@ static char *resolve_symlink(char *p, size_t s)
 	return p;
 }
 
+/* We append ".lock" to the filename to derive the lockfile name: */
+#define LOCK_SUFFIX_LEN 5
 
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
 	/*
-	 * subtract 5 from size to make sure there's room for adding
-	 * ".lock" for the lock file name
+	 * subtract LOCK_SUFFIX_LEN from size to make sure there's
+	 * room for adding ".lock" for the lock file name:
 	 */
-	static const size_t max_path_len = sizeof(lk->filename) - 5;
+	static const size_t max_path_len = sizeof(lk->filename) -
+					   LOCK_SUFFIX_LEN;
 
 	if (!lock_file_list) {
 		/* One-time initialization */
@@ -302,7 +305,7 @@ int commit_lock_file(struct lock_file *lk)
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - 5; /* .lock */
+	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
 	result_file[i] = 0;
 	if (rename(lk->filename, result_file))
 		return -1;
-- 
1.9.1
