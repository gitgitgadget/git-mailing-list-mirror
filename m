From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Fix t4200-rerere for white-space from "wc -l"
Date: Wed, 4 Apr 2007 15:39:05 -0400
Message-ID: <20070404193905.GA23358@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 21:39:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZBK6-0007Jq-Vx
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 21:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766905AbXDDTjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 15:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766906AbXDDTjL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 15:39:11 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:37938 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766905AbXDDTjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 15:39:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 981041FFC143
	for <git@vger.kernel.org>; Wed,  4 Apr 2007 19:39:08 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43769>

On OS X, wc outputs 6 spaces before the number of lines, so the test
expecting the string "10" failed.  Changing the test to use -eq for
numerical equality ignores the problematic whitespace.

Also fix the grammar of the test name while making changes to it.
There's only one preimage, so it's "has", not "have".
---
 t/t4200-rerere.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 8b611bb..cd939ac 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -50,10 +50,10 @@ test_expect_success 'recorded preimage' "grep ======= $rr/preimage"
 test_expect_success 'no postimage or thisimage yet' \
 	"test ! -f $rr/postimage -a ! -f $rr/thisimage"
 
-test_expect_success 'preimage have right number of lines' '
+test_expect_success 'preimage has right number of lines' '
 
 	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
-	test "$cnt" = 10
+	test "$cnt" -eq 10
 
 '
 
-- 
1.5.1.rc3.30.ga8f4
