From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 2/9] Show some progress information when checking for
	upstream merges.
Date: Tue, 28 Apr 2009 16:09:46 +0100
Message-ID: <20090428150946.27261.60198.stgit@pc1117.cambridge.arm.com>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:13:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyp02-0002lt-Fr
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbZD1PKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbZD1PKj
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:10:39 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48920 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762105AbZD1PKg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 11:10:36 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n3SF6eZm027021;
	Tue, 28 Apr 2009 16:06:40 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 16:10:32 +0100
In-Reply-To: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.375.g65f9.dirty
X-OriginalArrivalTime: 28 Apr 2009 15:10:32.0783 (UTC) FILETIME=[79A91DF0:01C9C813]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117787>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/lib/transaction.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 582ee72..13323dd 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -390,6 +390,7 @@ class StackTransaction(object):
 
     def check_merged(self, patches):
         """Return a subset of patches already merged."""
+        out.start('Checking for patches merged upstream')
         merged = []
         if self.temp_index_tree != self.stack.head.data.tree:
             self.temp_index.read_tree(self.stack.head.data.tree)
@@ -408,4 +409,5 @@ class StackTransaction(object):
                 self.temp_index_tree = None
             except git.MergeException:
                 pass
+        out.done('%d found' % len(merged))
         return merged
