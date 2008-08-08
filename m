From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 3/3] Add test for diff-tree --stdin with two trees
Date: Fri, 08 Aug 2008 22:48:35 +0200
Message-ID: <20080808204834.7744.10469.stgit@yoghurt>
References: <20080808204348.7744.46006.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 22:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRYuL-0005D8-8U
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 22:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbYHHUsq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 16:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbYHHUsp
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 16:48:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4161 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbYHHUsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 16:48:45 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KRZEX-0000vu-00; Fri, 08 Aug 2008 22:10:49 +0100
In-Reply-To: <20080808204348.7744.46006.stgit@yoghurt>
User-Agent: StGIT/0.14.3.222.g9ef2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91713>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t4002-diff-basic.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)


diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index a4cfde6..27743c4 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -169,6 +169,20 @@ test_expect_success \
      cmp -s .test-a .test-recursive-AB'
=20
 test_expect_success \
+    'diff-tree --stdin of known trees.' \
+    'echo $tree_A $tree_B | git diff-tree --stdin > .test-a &&
+     echo $tree_A $tree_B > .test-plain-ABx &&
+     cat .test-plain-AB >> .test-plain-ABx &&
+     cmp -s .test-a .test-plain-ABx'
+
+test_expect_success \
+    'diff-tree --stdin of known trees.' \
+    'echo $tree_A $tree_B | git diff-tree -r --stdin > .test-a &&
+     echo $tree_A $tree_B > .test-recursive-ABx &&
+     cat .test-recursive-AB >> .test-recursive-ABx &&
+     cmp -s .test-a .test-recursive-ABx'
+
+test_expect_success \
     'diff-cache O with A in cache' \
     'git read-tree $tree_A &&
      git diff-index --cached $tree_O >.test-a &&
