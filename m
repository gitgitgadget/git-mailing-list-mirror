From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Add test for cloning with "--reference" repo being a subset
 of source repo
Date: Thu, 22 May 2008 18:03:00 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805221759430.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 00:04:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzItK-0006Yi-Pb
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 00:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762541AbYEVWDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 18:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761779AbYEVWDE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 18:03:04 -0400
Received: from iabervon.org ([66.92.72.58]:58045 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761258AbYEVWDC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 18:03:02 -0400
Received: (qmail 24995 invoked by uid 1000); 22 May 2008 22:03:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 May 2008 22:03:00 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82660>

From: Johan Herland <johan@herland.net>

The first test in this series tests "git clone -l -s --reference B A C",
where repo B is a superset of repo A (A has one commit, B has the same
commit plus another). In this case, all objects to be cloned are already
present in B.

However, we should also test the case where the "--reference" repo is a
_subset_ of the source repo (e.g. "git clone -l -s --reference A B C"),
i.e. some objects are not available in the "--reference" repo, and will
have to be found in the source repo.

Signed-off-by: Johan Herland <johan@herland.net>
Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
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
1.5.3.7
