From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 7/8] Add contrib/stg-mdiff: display diffs of diffs.
Date: Fri, 02 Mar 2007 00:04:10 +0100
Message-ID: <20070301230410.32459.93054.stgit@gandelf.nowhere.earth>
References: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 00:04:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMuK5-00047i-Ac
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 00:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161218AbXCAXEW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbXCAXEW
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:04:22 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:49950 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161218AbXCAXEV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:04:21 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E7B743948;
	Fri,  2 Mar 2007 00:04:19 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id A88941F084;
	Fri,  2 Mar 2007 00:04:10 +0100 (CET)
In-Reply-To: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41148>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-mdiff |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-mdiff b/contrib/stg-mdiff
new file mode 100755
index 0000000..cd0c678
--- /dev/null
+++ b/contrib/stg-mdiff
@@ -0,0 +1,23 @@
+#!/bin/bash
+set -e
+
+# stg-mdiff - display meta-diffs, ie. diffs of diffs
+
+# Main use: show evolutions of a patch.
+# eg. stg-mdiff foo@stable foo
+#     stg-mdiff foo 012345567ABCD # sha1 for "foo" as integrated upstream
+
+# Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+usage()
+{
+    echo "Usage: $(basename $0) <patch1> <patch2>"
+    exit 1
+}
+
+if [ "$#" != 2 ]; then
+    usage
+fi
+
+colordiff -u <(stg show "$1") <(stg show "$2") | less -RFX
