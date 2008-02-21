From: Onno Kortmann <onno@gmx.net>
Subject: [PATCH 2/2] Test the 'stg rename' command
Date: Thu, 21 Feb 2008 22:43:18 +0100
Message-ID: <200802212243.18922.onno@gmx.net>
References: <20080218140005.GA18668@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 22:43:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJCv-0000Vf-HO
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 22:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756656AbYBUVnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 16:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756552AbYBUVnW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 16:43:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:39421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755507AbYBUVnV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 16:43:21 -0500
Received: (qmail invoked by alias); 21 Feb 2008 21:43:19 -0000
Received: from 14-235-dsl.kielnet.net (EHLO noodle.okhome) [89.27.235.14]
  by mail.gmx.net (mp017) with SMTP; 21 Feb 2008 22:43:19 +0100
X-Authenticated: #482760
X-Provags-ID: V01U2FsdGVkX18B59JiApABx2Anyi5PMXFwJpmsm2+2pS6BaKSnIJ
	vLsE5EnHBtnJX3
In-Reply-To: <20080218140005.GA18668@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.1
X-TUID: 09313abb1c2359ce
X-Length: 1835
X-UID: 18
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74665>

This just tests the few basic cases of the stg rename command.

Signed-off-by: Onno Kortmann <onno@gmx.net>
---

 t/t2900-rename.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100755 t/t2900-rename.sh

diff --git a/t/t2900-rename.sh b/t/t2900-rename.sh
new file mode 100755
index 0000000..a8f8f0b
--- /dev/null
+++ b/t/t2900-rename.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Onno Kortmann
+# Parts taken from the other test scripts
+# in this directory.
+#
+
+test_description='stg rename test
+
+Tests some parts of the stg rename command.'
+
+. ./test-lib.sh
+stg init
+
+test_expect_success 'Rename in empty' '
+   ! stg rename foo
+'
+
+test_expect_success 'Rename single top-most' '
+   stg new -m foo
+   stg rename bar
+'
+# bar
+
+test_expect_success 'Rename non-existing' '
+   ! stg rename neithersuchpatch norsuchpatch
+'
+
+test_expect_success 'Rename with two arguments' '
+   stg new -m baz
+   stg rename bar foo
+'
+# foo,baz
+
+test_expect_success 'Rename to existing name' '
+   ! stg rename foo baz
+'
+
+test_expect_success 'Rename to same name' '
+   ! stg rename foo foo
+'
+
+test_expect_success 'Rename top-most when others exist' '
+   stg rename bar
+'
+
+test_done
