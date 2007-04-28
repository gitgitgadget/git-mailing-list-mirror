From: Dana How <how@cswitch.com>
Subject: [PATCH] Ensure test-genrandom availability for t5301/t5302
Date: Sat, 28 Apr 2007 12:46:02 -0700
Message-ID: <4633A47A.4020508@cswitch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 28 21:56:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hht1v-0007e6-Ra
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 21:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031277AbXD1T4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 15:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031275AbXD1T4L
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 15:56:11 -0400
Received: from mta.cswitch.com ([64.186.171.234]:32975 "EHLO mta.cswitch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031277AbXD1T4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 15:56:09 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Apr 2007 15:56:09 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mta.cswitch.com (Postfix) with ESMTP id C49A0600046
	for <git@vger.kernel.org>; Sat, 28 Apr 2007 12:46:03 -0700 (PDT)
X-Virus-Scanned: amavisd-new at cswitch.com
Received: from mta.cswitch.com ([127.0.0.1])
	by localhost (pakmara.cswitch.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w7RsmtrBqHNH for <git@vger.kernel.org>;
	Sat, 28 Apr 2007 12:46:02 -0700 (PDT)
Received: from pinnacles.cswitch.com (selcannip.cswitch.com [192.168.18.65])
	by mta.cswitch.com (Postfix) with ESMTP id 36593600042
	for <git@vger.kernel.org>; Sat, 28 Apr 2007 12:46:02 -0700 (PDT)
Received: from [192.168.1.30] ([192.168.1.30]) by pinnacles.cswitch.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 28 Apr 2007 12:46:02 -0700
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
X-OriginalArrivalTime: 28 Apr 2007 19:46:02.0456 (UTC) FILETIME=[DA25CD80:01C789CD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45795>


Check for this as well as test-chmtime in test-lib.sh

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 t/test-lib.sh |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2c6bd3..d7838fc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -268,11 +268,14 @@ test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
-if ! test -x ../test-chmtime; then
-	echo >&2 'You need to build test-chmtime:'
-	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
-	exit 1
-fi
+for prog in test-chmtime test-genrandom
+do
+	if ! test -x ../$prog; then
+		echo >&2 "You need to build $prog:"
+		echo >&2 "Run \"make $prog\" in the source (toplevel) directory"
+		exit 1
+	fi
+done
 
 # Test repository
 test=trash
-- 
1.5.2.rc0.71.g4342-dirty
