From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 3/4] git-p4: one test missing config
 git-p4.skipSubmitEditCheck
Date: Sat, 30 Jul 2011 20:39:36 -0400
Message-ID: <20110731003936.GD4867@arf.padd.com>
References: <20110731003557.GA4867@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 02:39:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnK4G-0000lD-EM
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 02:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab1GaAjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 20:39:41 -0400
Received: from honk.padd.com ([74.3.171.149]:36341 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275Ab1GaAjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 20:39:39 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 11A8F223A;
	Sat, 30 Jul 2011 17:39:39 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id AA89031731; Sat, 30 Jul 2011 20:39:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110731003557.GA4867@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178225>

Add this missing line in one of the tests.  Otherwise, on fast
machines, the following git-p4 commit will complain that nobody
edited the submission message.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 04d8413..24a8b79 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -207,6 +207,7 @@ test_expect_success 'refuse to preserve users without perms' '
 	test_when_finished cleanup_git &&
 	cd "$git" &&
 	p4_ungrant_admin alice &&
+	git config git-p4.skipSubmitEditCheck true &&
 	echo "username-noperms: a change by $bobuser" >> file1 &&
 	git commit --author "$bobuser <$bobemail>" -m "perms: a change by $bobuser" file1 &&
 	! P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
-- 
1.7.5.4
