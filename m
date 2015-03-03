From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 1/7] write_ref_sha1(): remove check for lock == NULL
Date: Tue,  3 Mar 2015 12:43:11 +0100
Message-ID: <1425382997-24984-2-git-send-email-mhagger@alum.mit.edu>
References: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:43:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSlEf-0003kG-1p
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 12:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225AbbCCLna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 06:43:30 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57595 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755934AbbCCLn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 06:43:29 -0500
X-AuditID: 12074412-f79e46d0000036b4-15-54f59e602810
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.F7.14004.06E95F45; Tue,  3 Mar 2015 06:43:28 -0500 (EST)
Received: from michael.fritz.box (p5DDB193E.dip0.t-ipconnect.de [93.219.25.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t23BhJqE016748
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Mar 2015 06:43:25 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1E2Y9zXE4Ol+EYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLX609DBb9PZ9YrXYvLmdxeLMm0ZGB06Pv+8/MHnsnHWX3WPBplKP
	Z717GD0uXlL2WPzAy+PzJrkA9ihum6TEkrLgzPQ8fbsE7oxNU7tZC+ayVjw6eIqpgbGfpYuR
	k0NCwETiYvtuZghbTOLCvfVsXYxcHEIClxkl9na3MUM4x5gknrYeYQWpYhPQlVjU08wEYosI
	qElMbDsENolZ4AeTxKEVtSC2sIC7xOpp74BqODhYBFQlJvTzgYR5BVwkrk74yASxTE7i/PGf
	YIs5BVwlVq7dygpSLgRUc+tDxQRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL
	9FJTSjcxQgJRaAfj+pNyhxgFOBiVeHgnsH8NEWJNLCuuzD3EKMnBpCTKKz8bKMSXlJ9SmZFY
	nBFfVJqTWnyIUYKDWUmE9/wUoBxvSmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILUIpis
	DAeHkgTvqjlAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGguIgvBkYGSIoHaO8+
	kHbe4oLEXKAoROspRl2OBe37ZzIJseTl56VKifOuBCkSACnKKM2DWwFLO68YxYE+FuZVnQtU
	xQNMWXCTXgEtYQJackvxC8iSkkSElFQD40Tex2EiVx/c97KwcDGImvijXjtk8Y+2RovtEx6e
	+HTJdkbpFD0rhsy5uRWVS9vaquf0u/45HL0t4GbZ48vthdcb7XWNGUvqJ9f3/A/e 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264651>

None of the callers pass NULL to this function, and there doesn't seem
to be any usefulness to allowing them to do so.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/refs.c b/refs.c
index ab2f2a9..e82d503 100644
--- a/refs.c
+++ b/refs.c
@@ -3079,10 +3079,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 	static char term = '\n';
 	struct object *o;
 
-	if (!lock) {
-		errno = EINVAL;
-		return -1;
-	}
 	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
 		unlock_ref(lock);
 		return 0;
-- 
2.1.4
