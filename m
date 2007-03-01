From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/8] Add contrib/stg-swallow: completely merge an unapplied
	patch into current one
Date: Fri, 02 Mar 2007 00:03:55 +0100
Message-ID: <20070301230355.32459.76241.stgit@gandelf.nowhere.earth>
References: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 00:04:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMuJr-00041v-U5
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 00:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbXCAXEH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161215AbXCAXEH
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:04:07 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:49855 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161212AbXCAXEG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:04:06 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5B3AF3771;
	Fri,  2 Mar 2007 00:04:04 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 57D1F1F084;
	Fri,  2 Mar 2007 00:03:55 +0100 (CET)
In-Reply-To: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41146>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-swallow |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-swallow b/contrib/stg-swallow
new file mode 100755
index 0000000..5014f39
--- /dev/null
+++ b/contrib/stg-swallow
@@ -0,0 +1,19 @@
+#!/bin/sh
+set -e
+
+# stg-swallow - completely merge an unapplied patch into current one
+
+# Copyright (c) 2006-2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+# FIXME:
+# - should provide support for conflict solving ?
+
+[ "$#" = 1 ] || { echo >&2 "Usage: $(basename $0) <patch>"; exit 1; }
+patch="$1"
+
+stg pick --fold "$patch"
+stg refresh
+stg push "$patch"
+#stg clean "$patch"
+stg pop; stg clean -u
