From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/2] dash doesn't do curly brace expansion, so avoid that
Date: Sun, 29 Apr 2007 23:09:55 +0200
Message-ID: <20070429210955.4004.31074.stgit@yoghurt>
References: <20070429210713.4004.60467.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 23:32:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiH07-0001iT-DV
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 23:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161459AbXD2VcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 29 Apr 2007 17:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161461AbXD2VcH
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 17:32:07 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:43713 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161459AbXD2VcF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Apr 2007 17:32:05 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:38717 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <kha@treskal.com>)
	id 1HiGfE-0003G5-9V; Sun, 29 Apr 2007 23:10:37 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HiGeZ-00014K-Kg; Sun, 29 Apr 2007 23:09:55 +0200
In-Reply-To: <20070429210713.4004.60467.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HiGfE-0003G5-9V.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HiGfE-0003G5-9V 753f0be1acd71a6cb436f6ed265f4fd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45841>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

I have dash as /bin/sh, and it doesn't seem to expand stuff in curly
braces, which breaks t1800. Work around this by not using curly brace
expansion to generate test data.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t1800-import.sh      |    4 +---
 t/t1800-import/foo.txt |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/t/t1800-import.sh b/t/t1800-import.sh
index ed10fa8..8c8c9a0 100755
--- a/t/t1800-import.sh
+++ b/t/t1800-import.sh
@@ -6,9 +6,7 @@ test_description=3D'Test the import command'
 test_expect_success \
     'Initialize the StGIT repository' \
     '
-    for x in {do,di,da}{be,bi,bo}{dam,dim,dum}; do
-      echo $x
-    done > foo.txt &&
+    cp ../t1800-import/foo.txt . &&
     git add foo.txt &&
     git commit -a -m "initial version" &&
     stg init
diff --git a/t/t1800-import/foo.txt b/t/t1800-import/foo.txt
new file mode 100644
index 0000000..ad01662
--- /dev/null
+++ b/t/t1800-import/foo.txt
@@ -0,0 +1,27 @@
+dobedam
+dobedim
+dobedum
+dobidam
+dobidim
+dobidum
+dobodam
+dobodim
+dobodum
+dibedam
+dibedim
+dibedum
+dibidam
+dibidim
+dibidum
+dibodam
+dibodim
+dibodum
+dabedam
+dabedim
+dabedum
+dabidam
+dabidim
+dabidum
+dabodam
+dabodim
+dabodum
