From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v6 2/7] tests: paint known breakages in bold yellow
Date: Sun, 16 Dec 2012 18:28:10 +0000
Message-ID: <1355682495-22382-3-git-send-email-git@adamspiers.org>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:39:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkJ7T-0007Pf-3F
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 19:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab2LPSi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 13:38:56 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41197 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab2LPSi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 13:38:56 -0500
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Dec 2012 13:38:55 EST
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 772EB2E65F
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 18:28:18 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
In-Reply-To: <1355682495-22382-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211595>

Bold yellow seems a more appropriate color than bold green when
considering the universal traffic lights coloring scheme, where
green conveys the impression that everything's OK, and amber that
something's not quite right.

Likewise, change the color of the summarized total number of known
breakages from bold red to bold yellow to be less alarmist and more
consistent with the above.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/test-lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d0b236f..710f051 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -213,6 +213,8 @@ then
 			tput bold; tput setaf 1;; # bold red
 		skip)
 			tput bold; tput setaf 2;; # bold green
+		warn)
+			tput bold; tput setaf 3;; # bold brown/yellow
 		pass)
 			tput setaf 2;;            # green
 		info)
@@ -311,7 +313,7 @@ test_known_broken_ok_ () {
 
 test_known_broken_failure_ () {
 	test_broken=$(($test_broken+1))
-	say_color skip "not ok $test_count - $@ # TODO known breakage"
+	say_color warn "not ok $test_count - $@ # TODO known breakage"
 }
 
 test_debug () {
@@ -408,7 +410,7 @@ test_done () {
 	fi
 	if test "$test_broken" != 0
 	then
-		say_color error "# still have $test_broken known breakage(s)"
+		say_color warn "# still have $test_broken known breakage(s)"
 		msg="remaining $(($test_count-$test_broken)) test(s)"
 	else
 		msg="$test_count test(s)"
-- 
1.7.12.1.396.g53b3ea9
