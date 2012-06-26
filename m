From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/9] git p4 test: wait longer for p4d to start
Date: Mon, 25 Jun 2012 21:18:17 -0400
Message-ID: <1340673505-10551-2-git-send-email-pw@padd.com>
References: <1340673505-10551-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 03:23:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjKVF-0004Kg-Bb
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 03:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757931Ab2FZBSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 21:18:49 -0400
Received: from honk.padd.com ([74.3.171.149]:40024 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757814Ab2FZBSs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 21:18:48 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id E6DD12E87;
	Mon, 25 Jun 2012 18:18:47 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A2CE231383; Mon, 25 Jun 2012 21:18:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.72.gebb7ee5
In-Reply-To: <1340673505-10551-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200608>

Running tests at high parallelism on a slow machine, 5 sec is
not enough to wait for p4d to start.  Change it to 10 sec.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 121e380..0080eae 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -37,7 +37,7 @@ start_p4d() {
 		p4d -q -r "$db" -p $P4DPORT &
 		echo $! >"$pidfile"
 	) &&
-	for i in 1 2 3 4 5 ; do
+	for i in 1 2 3 4 5 6 7 8 9 10 ; do
 		p4 info >/dev/null 2>&1 && break || true &&
 		echo waiting for p4d to start &&
 		sleep 1
-- 
1.7.11.rc2.72.gebb7ee5
