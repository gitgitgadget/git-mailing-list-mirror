From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/5] safe_create_leading_directories(): modernize format of "if" chaining
Date: Sun, 22 Dec 2013 08:14:07 +0100
Message-ID: <1387696451-32224-2-git-send-email-mhagger@alum.mit.edu>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 22 08:22:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VudMp-0003tw-5o
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 08:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab3LVHWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 02:22:23 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52777 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752613Ab3LVHWX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Dec 2013 02:22:23 -0500
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Dec 2013 02:22:23 EST
X-AuditID: 1207440c-b7f566d000004272-8c-52b6915d63b9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A4.DE.17010.D5196B25; Sun, 22 Dec 2013 02:14:37 -0500 (EST)
Received: from michael.fritz.box (p57A25B75.dip0.t-ipconnect.de [87.162.91.117])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBM7ERFL023935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 22 Dec 2013 02:14:36 -0500
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqBs7cVuQQecbUYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5oXHqFuWArW8W8f5dZGhif
	sXQxcnJICJhIHHp5mg3CFpO4cG89kM3FISRwmVHixIZNrBDOCSaJ9286WUGq2AR0JRb1NDOB
	2CICahIT2w6BTWIWcJDY/LmREcQWFoiU2DftE1icRUBV4umrK2D1vAIuEkvWHmeC2KYgse/S
	STCbU8BVYuqXjWDzhYBqdrx6xDSBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzM
	Er3UlNJNjJBg4dnB+G2dzCFGAQ5GJR7eAxLbgoRYE8uKK3MPMUpyMCmJ8nJPAArxJeWnVGYk
	FmfEF5XmpBYfYpTgYFYS4V3jCpTjTUmsrEotyodJSXOwKInzqi5R9xMSSE8sSc1OTS1ILYLJ
	ynBwKEnwdoAMFSxKTU+tSMvMKUFIM3FwgggukA08QBsWghTyFhck5hZnpkMUnWJUlBLn7QFJ
	CIAkMkrz4AbA4voVozjQP8K8y0CqeIApAa77FdBgJqDBxms3gQwuSURISTUwqi57IP9z3tKc
	jQdktLbfcZuXmjAlyySy1uPtIck9D94eMRPo/BcxY2UN95faR70z3y6dsvxG4PoLMfNP1qk3
	8Sw28XVa0HTu58Mip8UKDzI0eRnl6wMmfHNOZXhn13Qn0u2qpiXLkQM8H+8LxU85UqwVEBrc
	neBw7W4zn+qdihkzuj8t+PJvuxJLcUaioRZzUXEiAFF8DOzGAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239639>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index daacc0c..c9245a6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -125,8 +125,7 @@ int safe_create_leading_directories(char *path)
 				*pos = '/';
 				return -3;
 			}
-		}
-		else if (mkdir(path, 0777)) {
+		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
 				; /* somebody created it since we checked */
@@ -134,8 +133,7 @@ int safe_create_leading_directories(char *path)
 				*pos = '/';
 				return -1;
 			}
-		}
-		else if (adjust_shared_perm(path)) {
+		} else if (adjust_shared_perm(path)) {
 			*pos = '/';
 			return -2;
 		}
-- 
1.8.5.1
