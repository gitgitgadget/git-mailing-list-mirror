From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/4] Copy remote and merge settings when cloning a branch
Date: Sun, 04 Feb 2007 00:32:26 -0500
Message-ID: <20070204053226.15035.40105.stgit@dv.roinet.com>
References: <20070204053221.15035.88015.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 06:32:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDZzT-0003HP-AT
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 06:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbXBDFcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 00:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbXBDFcf
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 00:32:35 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:48772 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbXBDFc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 00:32:28 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDZyE-0008G9-Hk
	for git@vger.kernel.org; Sun, 04 Feb 2007 00:31:22 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDZzG-0003v8-PI; Sun, 04 Feb 2007 00:32:26 -0500
In-Reply-To: <20070204053221.15035.88015.stgit@dv.roinet.com>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38650>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/stack.py |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index c3bf3c6..2e01f52 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -632,6 +632,15 @@ class Series(StgitObject):
         # fast forward the cloned series to self's top
         new_series.forward_patches(applied)
 
+        # Clone remote and merge settings
+        value = config.get('branch.%s.remote' % self.__name)
+        if value:
+            config.set('branch.%s.remote' % target_series, value)
+
+        value = config.get('branch.%s.merge' % self.__name)
+        if value:
+            config.set('branch.%s.merge' % target_series, value)
+
     def delete(self, force = False):
         """Deletes an stgit series
         """
