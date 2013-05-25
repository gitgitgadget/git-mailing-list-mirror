From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 19/25] show_head_ref(): do not shadow name of argument
Date: Sat, 25 May 2013 11:08:18 +0200
Message-ID: <1369472904-12875-20-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATu-0005LV-CC
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab3EYJJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:30 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:61913 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754347Ab3EYJJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:25 -0400
X-AuditID: 12074412-b7f216d0000008d4-5b-51a07fc47870
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.35.02260.4CF70A15; Sat, 25 May 2013 05:09:24 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gut000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:23 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqHukfkGgwZQ55hZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzni0qpOl4DZrxctv+g2M11i6GDk5JARMJA5ObYSyxSQu3FvP1sXI
	xSEkcJlRoqPvJQuEc4FJ4uDndjaQKjYBXYlFPc1MILaIgKPEiQfXWUGKmAV6GSUePvoOlhAW
	8JRon3GKFcRmEVCVuDf1CiOIzSvgKvF5wW42iHUKEpdnrWHuYuTg4ASKvz3BCRIWEnCReP7p
	HOsERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9HIzS/RSU0o3MULCTGgH4/qTcocY
	BTgYlXh4BcrnBwqxJpYVV+YeYpTkYFIS5eWvXRAoxJeUn1KZkVicEV9UmpNafIhRgoNZSYSX
	IQUox5uSWFmVWpQPk5LmYFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwetRB9QoWJSanlqR
	lplTgpBm4uAEEVwgG3iANgSCFPIWFyTmFmemQxSdYlSUEudNAEkIgCQySvPgBsASwitGcaB/
	hHlTQKp4gMkErvsV0GAmoME3c+eDDC5JREhJNTCa5yTbbzV5YOrC51TKO/HvoVkMTHdLPvBq
	BDHz5yZYbhczqO+3vRrQ5XXA+0Xf1mh5z0yr33+Dkl/Prr+x7+SRlyceie7xnOv3/u6jmxxi
	eccOX/uSyliRy8G/4aGSD+eKN33N3VI9e2eZTrAUF20I8zvJsvRfrESxd8K+B6p1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225503>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 http-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 6b85ffa..3135835 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -416,8 +416,8 @@ static int show_head_ref(const char *name, const unsigned char *sha1,
 	struct strbuf *buf = cb_data;
 
 	if (flag & REF_ISSYMREF) {
-		unsigned char sha1[20];
-		const char *target = resolve_ref_unsafe(name, sha1, 1, NULL);
+		unsigned char unused[20];
+		const char *target = resolve_ref_unsafe(name, unused, 1, NULL);
 		const char *target_nons = strip_namespace(target);
 
 		strbuf_addf(buf, "ref: %s\n", target_nons);
-- 
1.8.2.3
