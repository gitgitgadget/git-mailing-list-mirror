From: Phil Hord <hordp@cisco.com>
Subject: [PATCH] t/t7407: fix two typos in submodule tests
Date: Fri,  9 Aug 2013 16:12:54 -0400
Message-ID: <1376079174-7226-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, git@vger.kernel.org,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>, Phil Hord <hordp@cisco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:22:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7tCw-0005QD-NW
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031030Ab3HIUWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:22:43 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:25229 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030994Ab3HIUWm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:22:42 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Aug 2013 16:22:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1341; q=dns/txt; s=iport;
  t=1376079762; x=1377289362;
  h=from:to:cc:subject:date:message-id;
  bh=zSiULrr/VZiEhSKc/6TNBHHac95YkdP/k975O4Ig2cM=;
  b=M2x+ljFQZ10kBps3neN5aFTiyU1Uo08YCknGIDp6yBW01ho2CsyQ9EoQ
   7pBc75qsexN8bSMzUw/wYeTEhyU8eCb+mLmQl11aPYXDTSAfPOIbkEWfR
   0M/nmkO/PoOZEw7G3aEhTgAJEo/7f9eawKWIPu+1r7JM40LZEPUmviTq1
   c=;
X-IronPort-AV: E=Sophos;i="4.89,848,1367971200"; 
   d="scan'208";a="245603486"
Received: from rcdn-core2-2.cisco.com ([173.37.113.189])
  by rcdn-iport-7.cisco.com with ESMTP; 09 Aug 2013 20:13:01 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-41.cisco.com [64.100.104.41])
	by rcdn-core2-2.cisco.com (8.14.5/8.14.5) with ESMTP id r79KD1Fh011587;
	Fri, 9 Aug 2013 20:13:01 GMT
X-Mailer: git-send-email 1.8.4.rc1.433.g415b943
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232025>

In t/t7407-submodule-foreach.sh there is a typo in one of the
path names given for a test step.  The correct path is
nested1/nested2/.git, but nested1/nested1/nested2/.git is
given instead.  The typo is hidden because this line also
accidentally omits the && chain operator.  The omitted chain
also means the return values of all the previous commands in
this test are also being ignored.

Fix the path and add the chain operator so the entire test
sequence can be properly validated.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 t/t7407-submodule-foreach.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 91d4fd1..be93f10 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -145,7 +145,7 @@ test_expect_success 'use "submodule foreach" to checkout 2nd level submodule' '
 		git rev-parse --resolve-git-dir nested1/.git &&
 		test_must_fail git rev-parse --resolve-git-dir nested1/nested2/.git &&
 		git submodule foreach "git submodule update --init" &&
-		git rev-parse --resolve-git-dir nested1/nested1/nested2/.git
+		git rev-parse --resolve-git-dir nested1/nested2/.git &&
 		test_must_fail git rev-parse --resolve-git-dir nested1/nested2/nested3/.git
 	)
 '
-- 
1.8.4.rc1.433.g415b943
