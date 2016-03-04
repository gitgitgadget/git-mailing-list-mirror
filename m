From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/2] xdiff/xprepare: use the XDF_DIFF_ALG() macro to access
 flag bits
Date: Fri, 4 Mar 2016 23:09:36 +0000
Message-ID: <56DA15B0.6050306@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 00:09:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abyqv-0005CF-84
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 00:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760351AbcCDXJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 18:09:41 -0500
Received: from avasout03.plus.net ([84.93.230.244]:57675 "EHLO
	avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760128AbcCDXJk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 18:09:40 -0500
Received: from [10.0.2.15] ([80.189.40.55])
	by avasout03 with smtp
	id Rz9d1s0071BQLD401z9fQ3; Fri, 04 Mar 2016 23:09:39 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=X8+vUzne c=1 sm=1 tr=0
 a=LVbmpxbf7ppclCt3pfQTng==:117 a=LVbmpxbf7ppclCt3pfQTng==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=3_c7iVZYy0nvpK3UpOoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288279>


Commit 307ab20b3 ("xdiff: PATIENCE/HISTOGRAM are not independent option
bits", 19-02-2012) introduced the XDF_DIFF_ALG() macro to access the
flag bits used to represent the diff algorithm requested. In addition,
code which had used explicit manipulation of the flag bits was changed
to use the macros.

However, one example of direct manipulation remains. Update this code to
use the XDF_DIFF_ALG() macro.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 xdiff/xprepare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 63a22c6..5ffcf99 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -304,7 +304,7 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		return -1;
 	}
 
-	if (!(xpp->flags & XDF_HISTOGRAM_DIFF))
+	if (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)
 		xdl_free_classifier(&cf);
 
 	return 0;
-- 
2.7.0
