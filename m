From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/4] Don't use test_expect_failure when more than one
	thing could fail
Date: Sun, 26 Aug 2007 22:26:15 +0200
Message-ID: <20070826202615.15933.76401.stgit@yoghurt>
References: <20070826202309.15933.54183.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:27:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOhQ-00068z-8t
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbXHZU0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbXHZU0r
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:26:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3257 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbXHZU00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:26:26 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOgZ-0005sg-00; Sun, 26 Aug 2007 21:26:16 +0100
In-Reply-To: <20070826202309.15933.54183.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56715>

It's much better to use ! for the part that you actually expect to
fail; that way, the test will still scream if something _else_ goes
wrong.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t2101-pull-policy-pull.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2101-pull-policy-pull.sh b/t/t2101-pull-policy-pull.sh
index 793491c..14d5adb 100755
--- a/t/t2101-pull-policy-pull.sh
+++ b/t/t2101-pull-policy-pull.sh
@@ -39,11 +39,11 @@ test_expect_success \
 # as rewinding, and thus heads/origin is not moved, but the stack
 # is still correctly rebased
=20
-test_expect_failure \
+test_expect_success \
     'Rewind/rewrite upstream commit and pull it from clone, without --=
merged' \
     '
     (cd upstream && echo b >> file2 && stg refresh) &&
-    (cd clone && stg pull)
+    (cd clone && ! stg pull)
     '
=20
 test_expect_success \
