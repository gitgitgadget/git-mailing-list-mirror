From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] fast-import: Fix uninitialized variable
Date: Wed, 23 May 2007 23:00:22 +0200
Message-ID: <200705232300.22278.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 23 23:02:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqxy2-0001DL-I1
	for gcvg-git@gmane.org; Wed, 23 May 2007 23:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbXEWVBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 17:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755849AbXEWVBt
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 17:01:49 -0400
Received: from verein.lst.de ([213.95.11.210]:33433 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755240AbXEWVBr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 17:01:47 -0400
Received: from luria.local (157.80-203-65.nextgentel.com [80.203.65.157])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l4NL1fpX029614
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Wed, 23 May 2007 23:01:43 +0200
User-Agent: KMail/1.9.6
Content-Disposition: inline
X-Spam-Score: -0.349 () BAYES_30
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48175>

Fix uninitialized last_object->no_free variable that is accessed in 
store_object.

Signed-off-by: Simon Hausmann <simon@lst.de>
---
 fast-import.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ffa00fd..0ddf8fe 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1122,6 +1122,7 @@ static void store_tree(struct tree_entry *root)
 		|| le->pack_id != pack_id) {
 		lo.data = NULL;
 		lo.depth = 0;
+		lo.no_free = 0;
 	} else {
 		mktree(t, 0, &lo.len, &old_tree);
 		lo.data = old_tree.buffer;
-- 
1.5.2.24.g93d4
