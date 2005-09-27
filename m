From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH]: cogito testsuite fix - expect "m foo", not "M foo"
Date: Mon, 26 Sep 2005 21:06:01 -0400
Message-ID: <1127783161.11578.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 03:06:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK3vA-0002Dl-68
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 03:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVI0BGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 21:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVI0BGJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 21:06:09 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:48277 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964793AbVI0BGI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 21:06:08 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EK3v4-0006qW-Qx
	for git@vger.kernel.org; Mon, 26 Sep 2005 21:06:06 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EK3uz-0001oG-Lg; Mon, 26 Sep 2005 21:06:01 -0400
To: Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9360>

Signed-off-by: Pavel Roskin <proski@gnu.org>

testsuite fix - expect "m foo", not "M foo"

commit bb42b67ac543416f974d502e269f134ed80bdd4b introduced status 'm'
for modified files that won't be committed.  This change also broke test
19 in t9202-merge-on-dirty.sh, which expects status 'M'.  I believe the
'm' status is correct in this test, so it's the testsuite that need to
be adjusted.

diff --git a/t/t9202-merge-on-dirty.sh b/t/t9202-merge-on-dirty.sh
--- a/t/t9202-merge-on-dirty.sh
+++ b/t/t9202-merge-on-dirty.sh
@@ -89,7 +89,7 @@ cp branch1/foo branch1/foo-
 test_expect_failure 'merging branch2 to branch1 (clean)' \
 		"(cd branch1 && cg-merge </dev/null)"
 test_expect_success 'checking if we still have our local change' \
-		'(cd branch1 && cg-status -w | grep -q "^M foo" && cmp foo foo-)'
+		'(cd branch1 && cg-status -w | grep -q "^m foo" && cmp foo foo-)'
 # This test is useful if the previous one failed - did it get lost or
 # accidentally committed?
 test_expect_success 'checking that we didn'\''t commit the local change' \


-- 
Regards,
Pavel Roskin
