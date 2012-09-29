From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/9] real_path_internal(): add comment explaining use of cwd
Date: Sat, 29 Sep 2012 08:15:55 +0200
Message-ID: <1348899362-4057-3-git-send-email-mhagger@alum.mit.edu>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:16:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqLp-0002M0-3w
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519Ab2I2GQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:16:25 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:42198 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753070Ab2I2GQX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 02:16:23 -0400
X-AuditID: 12074413-b7f786d0000008bb-ec-50669236eb92
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 4A.49.02235.63296605; Sat, 29 Sep 2012 02:16:22 -0400 (EDT)
Received: from michael.fritz.box (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T6G73x026219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 02:16:21 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqGs2KS3A4MolcYuuK91MFg29V5gt
	jp6ysLi9Yj6zxfp3V5kdWD3+vv/A5LFz1l12j4uXlD0+b5ILYInitklKLCkLzkzP07dL4M54
	8mYdS8EC1oprRy+yNDC2s3QxcnJICJhIHLq/hQ3CFpO4cG89kM3FISRwmVHiyvlpTBDOWSaJ
	10fmgnWwCehKLOppZgKxRQTUJCa2HWIBKWIWmMQo0bPhATtIQljAX+LztvnMIDaLgKrE7fM/
	wJp5BZwlNq46zQSxTlHix/c1YDWcAi4Sv3ums4LYQkA1j/beYZ3AyLuAkWEVo1xiTmmubm5i
	Zk5xarJucXJiXl5qka65Xm5miV5qSukmRkgoCe9g3HVS7hCjAAejEg+v9vHUACHWxLLiytxD
	jJIcTEqivDkT0wKE+JLyUyozEosz4otKc1KLDzFKcDArifBmFAOV86YkVlalFuXDpKQ5WJTE
	edWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeA1BhgoWpaanVqRl5pQgpJk4OEEEF8gGHqANNSCF
	vMUFibnFmekQRacYFaXEeRNBEgIgiYzSPLgBsKh/xSgO9I8wbyBIFQ8wYcB1vwIazAQ0eOmm
	JJDBJYkIKakGxjW7T/r4XGfevZjN1Lza+Plj99rmSI7s+xLHPZm3fz1n2rFp1uQJkTN+C8zQ
	W1z2u/FBn/zcPSa6iz/vlnT9I/Trj8mN7Xafs/I0FyntDotpMGPJsJzmJH5C9ffdnex7H2w4
	Xq2ks09KZOrn2VHle3fv6t19d7++7OZp8zcd3HLzuMyNRc97XsxSYinOSDTUYi4q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206635>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/abspath.c b/abspath.c
index a7ab8e9..f8a526f 100644
--- a/abspath.c
+++ b/abspath.c
@@ -35,7 +35,14 @@ static const char *real_path_internal(const char *path, int die_on_error)
 {
 	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
 	char *retval = NULL;
+
+	/*
+	 * If we have to temporarily chdir(), store the original CWD
+	 * here so that we can chdir() back to it at the end of the
+	 * function:
+	 */
 	char cwd[1024] = "";
+
 	int buf_index = 1;
 
 	int depth = MAXDEPTH;
-- 
1.7.11.3
