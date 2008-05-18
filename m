From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Ensure that a test is run in the trash directory
Date: Sun, 18 May 2008 17:27:00 +0200
Message-ID: <20080518152700.GC3058@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 17:27:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxknj-0006px-UD
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 17:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055AbYERP1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 11:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbYERP1E
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 11:27:04 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:30213 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbYERP1D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 11:27:03 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarAeHyXUdQ==
Received: from tigra.home (Fac65.f.strato-dslnet.de [195.4.172.101])
	by post.webmailer.de (mrclete mo8) (RZmta 16.34)
	with ESMTP id f02224k4IEWBLy ; Sun, 18 May 2008 17:27:01 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C2E1F277BD;
	Sun, 18 May 2008 17:27:00 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B39BD56D28; Sun, 18 May 2008 17:27:00 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82388>

Exit with error if cd into the "trash directory" failed (error
already reported, so just exit).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Multi-user systems have their own kind of glitches: _someone_ removes
your files.

 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5002fb0..d1018c9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -419,7 +419,7 @@ rm -fr "$test" || {
 }
 
 test_create_repo "$test"
-cd "$test"
+cd "$test" || exit 1
 
 this_test=$(expr "./$0" : '.*/\(t[0-9]*\)-[^/]*$')
 for skp in $GIT_SKIP_TESTS
-- 
1.5.5.1.354.g902c
