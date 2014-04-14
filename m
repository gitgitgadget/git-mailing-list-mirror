From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 15/25] commit_lock_file(): inline temporary variable
Date: Mon, 14 Apr 2014 15:54:45 +0200
Message-ID: <1397483695-10888-16-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:56:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhN4-0001dI-A1
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbaDNNzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:36 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55519 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755102AbaDNNzc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:32 -0400
X-AuditID: 1207440f-f79326d000003c9f-5c-534be8d3b73a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.65.15519.3D8EB435; Mon, 14 Apr 2014 09:55:32 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09F010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:30 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqHvlhXewwQ5Hi64r3UwWDb1XmC1W
	/qyxuL1iPrPFr8NP2C1+tPQwW5x508ho0dnxldGBw+Pv+w9MHjtn3WX3eNa7h9Hj4iVlj8UP
	vDw+b5LzuPt/J5PH7WfbWAI4orhtkhJLyoIz0/P07RK4M15NWcpS8J+1YnXXRKYGxncsXYyc
	HBICJhJn5+5khLDFJC7cW8/WxcjFISRwmVFi4e1jUM5JJol/DW2sIFVsAroSi3qamUBsEQE1
	iYlth1hAipgF2pkkDu3oBUsIC7hLzOjeDmazCKhKnJ1+lh3E5hVwlZi4dAszxDo5iZPHJgMN
	5eDgBIov/JAFEhYScJG4+2UK6wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE30cjNL
	9FJTSjcxQkKRfwdj13qZQ4wCHIxKPLwdc7yDhVgTy4orcw8xSnIwKYnyZtwACvEl5adUZiQW
	Z8QXleakFh9ilOBgVhLhdd0KlONNSaysSi3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnK
	cHAoSfAaA2NOSLAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UG/HFwOgASfEA7U16
	DrK3uCAxFygK0XqKUVFKnLcEJCEAksgozYMbC0swrxjFgb4U5pUA2c4DTE5w3a+ABjMBDWZp
	BxtckoiQkmpgnFgT0HIlx+PtdhXPnFPLojO+nE2vDEkTe/zhg9NtW55jsx+a85wP6ZuwZ9LB
	ZR55ZWdS+fKusNzmPivKbrKg6sXfp/3hPWskLOYt4flUcETIVDi3WjD+B5f6kn9N 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246237>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 477bf4b..664b0c3 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -288,12 +288,14 @@ int close_lock_file(struct lock_file *lk)
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
1.9.1
