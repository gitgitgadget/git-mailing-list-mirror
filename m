From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 1/2] Prefix submodule names with the path basename
Date: Sat,  3 Apr 2010 21:04:39 +0100
Message-ID: <1270325080-22951-2-git-send-email-peter@pcc.me.uk>
References: <20100327094427.GA30216@progeny.tock>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 03 22:05:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny9bC-0005tJ-Ed
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 22:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910Ab0DCUFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 16:05:25 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:40543 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890Ab0DCUFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 16:05:20 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1Ny9ap-0004i8-87; Sat, 03 Apr 2010 21:05:19 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1Ny9al-0005zD-UZ; Sat, 03 Apr 2010 21:05:17 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <20100327094427.GA30216@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143900>

We should include some component of the submodule path in the submodule
name to make it possible to identify a particular submodule by its
name.  At the same time we should be conscious of the fact that the
submodule path may change.  Including the entire submodule path in
the submodule name is likely to confuse users if the path changes.
The basename is the component of the path which is least likely
to change, which is a factor in favour of its inclusion in the
submodule name.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 git-submodule.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index f05ff4e..4f0d7df 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -120,6 +120,9 @@ gen_uid()
 {
 	path="$1"
 
+	pathbase=$(basename "$path")
+	echo -n "$pathbase"-
+
 	(
 	 echo "$path"
 	 echo $$
-- 
1.6.5
