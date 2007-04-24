From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [--to=spearce@spearce.org PATCH] Detect resource changes.
Date: Wed, 25 Apr 2007 01:31:17 +0200
Message-ID: <20070424233117.27409.11307.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Apr 25 01:32:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgUUM-00014D-6d
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 01:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbXDXXbn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 19:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754654AbXDXXbn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 19:31:43 -0400
Received: from [83.140.172.130] ([83.140.172.130]:5604 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754296AbXDXXbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 19:31:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5C720802896
	for <git@vger.kernel.org>; Wed, 25 Apr 2007 01:25:47 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20909-04 for <git@vger.kernel.org>; Wed, 25 Apr 2007 01:25:47 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 0EDFE802873
	for <git@vger.kernel.org>; Wed, 25 Apr 2007 01:25:47 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 8B14C28EC5
	for <git@vger.kernel.org>; Wed, 25 Apr 2007 01:31:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id jaIglA-YUbnt for <git@vger.kernel.org>;
	Wed, 25 Apr 2007 01:31:18 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id C700B28EA6
	for <git@vger.kernel.org>; Wed, 25 Apr 2007 01:31:17 +0200 (CEST)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45494>

Another oops from the patch to use git ordering in trees.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../spearce/egit/core/project/GitProjectData.java  |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
index 00d5186..431e0c4 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -387,7 +387,8 @@ public class GitProjectData {
 				public boolean visit(final IResourceDelta d)
 						throws CoreException {
 					final int f = d.getFlags();
-					IResource r = d.getResource();
+					IResource res = d.getResource();
+					IResource r = res;
 					if ((f & IResourceDelta.CONTENT) != 0
 							|| (f & IResourceDelta.ENCODING) != 0
 							|| r instanceof IContainer) {
@@ -420,7 +421,7 @@ public class GitProjectData {
 							try {
 								synchronized (cacheTree) {
 									final TreeEntry e;
-									if (r.getType() == IResource.FILE)
+									if (res.getType() == IResource.FILE)
 										e = cacheTree.findBlobMember(s);
 									else
 										e = cacheTree.findTreeMember(s);
