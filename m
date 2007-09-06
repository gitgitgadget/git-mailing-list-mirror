From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Cleanup unnecessary file modifications in t1400-update-ref
Date: Wed, 5 Sep 2007 22:15:21 -0400
Message-ID: <20070906021521.GA31651@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, krh@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 04:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT6u3-0006oV-NL
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345AbXIFCP1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 22:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757336AbXIFCP1
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:15:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35465 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756819AbXIFCP0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2007 22:15:26 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT6tj-0005WX-Md; Wed, 05 Sep 2007 22:15:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 97EAC20FBAE; Wed,  5 Sep 2007 22:15:21 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57798>

Kristian H=C3=B8gsberg pointed out that the two file modifications
we were doing during the 'creating initial files' step are not even
used within the test suite.  This was actually confusing as we do
not even need these changes for the tests to pass.  All that really
matters here is the specific commit dates are used so that these
appear in the branch's reflog, and that the dates are different so
that the branch will update when asked and the reflog entry is
also updated.  There is no need for the file modification.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t1400-update-ref.sh |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index c4c0dfa..ce045b2 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -198,11 +198,9 @@ test_expect_success \
 	 GIT_AUTHOR_DATE=3D"2005-05-26 23:41" \
 	 GIT_COMMITTER_DATE=3D"2005-05-26 23:41" git-commit -F M -a &&
 	 h_OTHER=3D$(git rev-parse --verify HEAD) &&
-	 echo FIXED >F &&
 	 GIT_AUTHOR_DATE=3D"2005-05-26 23:44" \
 	 GIT_COMMITTER_DATE=3D"2005-05-26 23:44" git-commit --amend &&
 	 h_FIXED=3D$(git rev-parse --verify HEAD) &&
-	 echo TEST+FIXED >F &&
 	 echo Merged initial commit and a later commit. >M &&
 	 echo $h_TEST >.git/MERGE_HEAD &&
 	 GIT_AUTHOR_DATE=3D"2005-05-26 23:45" \
--=20
1.5.3.1.840.g0fedbc
