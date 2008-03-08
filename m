From: Johan Herland <johan@herland.net>
Subject: [PATCH 01/11] Add test for cloning with "--reference" repo being a
 subset of source repo
Date: Sat, 8 Mar 2008 18:03:55 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081803070.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:12:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8Cv-0001xb-E1
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbYCHXLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbYCHXLT
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:11:19 -0500
Received: from iabervon.org ([66.92.72.58]:48095 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbYCHXLT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:11:19 -0500
Received: (qmail 18553 invoked by uid 1000); 8 Mar 2008 23:03:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:03:55 -0000
X-X-Sender: barkalow@iabervon.org
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76612>

The first test in this series tests "git clone -l -s --reference B A C",
where repo B is a superset of repo A (A has one commit, B has the same
commit plus another). In this case, all objects to be cloned are already
present in B.

However, we should also test the case where the "--reference" repo is a
_subset_ of the source repo (e.g. "git clone -l -s --reference A B C"),
i.e. some objects are not available in the "--reference" repo, and will
have to be found in the source repo.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t5700-clone-reference.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index b6a5486..d318780 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -113,4 +113,9 @@ diff expected current'
 
 cd "$base_dir"
 
+test_expect_success 'cloning with reference being subset of source (-l -s)' \
+'git clone -l -s --reference A B E'
+
+cd "$base_dir"
+
 test_done
-- 
1.5.4.3.327.g614d7.dirty

