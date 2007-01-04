From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/5] Add contrib/stg-swallow: completely merge an unapplied patch into current one
Date: Fri, 05 Jan 2007 00:46:58 +0100
Message-ID: <20070104234658.13580.98141.stgit@gandelf.nowhere.earth>
References: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 00:48:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2cJc-0004Fq-BY
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 00:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbXADXsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 18:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbXADXsE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 18:48:04 -0500
Received: from postfix2-g20.free.fr ([212.27.60.43]:53979 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030290AbXADXsD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 18:48:03 -0500
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 91BFF898681
	for <git@vger.kernel.org>; Thu,  4 Jan 2007 23:48:06 +0100 (CET)
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 4055527A1B;
	Fri,  5 Jan 2007 00:47:00 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1H2cIe-0001lB-CB; Fri, 05 Jan 2007 00:47:08 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35961>




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
