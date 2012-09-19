From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 1/6] Change the color of individual known breakages
Date: Wed, 19 Sep 2012 18:15:10 +0100
Message-ID: <1348074915-19985-2-git-send-email-git@adamspiers.org>
References: <1348074915-19985-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:15:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TENs1-0001m5-3f
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520Ab2ISRPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:15:20 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:44885 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142Ab2ISRPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:15:18 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id EB21E2E5DE;
	Wed, 19 Sep 2012 18:15:16 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348074915-19985-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205948>

Bold yellow seems a more appropriate color than bold green when
considering the universal traffic lights coloring scheme, where green
conveys the impression that everything's OK, and amber that
something's not quite right.

Likewise, change the color of the summarized total number of known
breakages from bold red to bold yellow to be less alarmist and more
consistent with the above.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/test-lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f8e3733..426820e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -183,6 +183,8 @@ then
 			tput bold; tput setaf 1;; # bold red
 		skip)
 			tput bold; tput setaf 2;; # bold green
+		warn)
+			tput bold; tput setaf 3;; # bold yellow
 		pass)
 			tput setaf 2;;            # green
 		info)
@@ -281,7 +283,7 @@ test_known_broken_ok_ () {
 
 test_known_broken_failure_ () {
 	test_broken=$(($test_broken+1))
-	say_color skip "not ok $test_count - $@ # TODO known breakage"
+	say_color warn "not ok $test_count - $@ # TODO known breakage"
 }
 
 test_debug () {
@@ -375,7 +377,7 @@ test_done () {
 	fi
 	if test "$test_broken" != 0
 	then
-		say_color error "# still have $test_broken known breakage(s)"
+		say_color warn "# still have $test_broken known breakage(s)"
 		msg="remaining $(($test_count-$test_broken)) test(s)"
 	else
 		msg="$test_count test(s)"
-- 
1.7.12.147.g6d168f4
