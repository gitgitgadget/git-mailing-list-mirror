From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH v3 4/4] Add test for diff-tree --stdin with two trees
Date: Sun, 10 Aug 2008 18:13:04 +0200
Message-ID: <20080810161304.7116.56769.stgit@yoghurt>
References: <20080810161035.7116.2171.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 18:14:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSDYn-0004tT-8o
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 18:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbYHJQNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2008 12:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbYHJQNI
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 12:13:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3171 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbYHJQNI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 12:13:08 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KSDt2-0008LK-00; Sun, 10 Aug 2008 17:35:20 +0100
In-Reply-To: <20080810161035.7116.2171.stgit@yoghurt>
User-Agent: StGIT/0.14.3.223.g12ca.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91850>

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
