From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] Documentation: document pitfalls with 3-way merge
Date: Sun,  8 Dec 2013 20:40:27 +0000
Message-ID: <1386535227-209788-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 21:41:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VplA6-0003eS-QM
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 21:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530Ab3LHUku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 15:40:50 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34550 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759941Ab3LHUke (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Dec 2013 15:40:34 -0500
Received: from vauxhall.crustytoothpaste.net (vauxhall.local [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B6D5F2807E
	for <git@vger.kernel.org>; Sun,  8 Dec 2013 20:40:33 +0000 (UTC)
X-Mailer: git-send-email 1.8.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239050>

Oftentimes people will make the same change in two branches, revert the change
in one branch, and then be surprised when a merge reinstitutes that change when
the branches are merged.  Add an explanatory paragraph that explains that this
occurs and the reason why, so people are not surprised.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
This is a documentation fix that I've been holding onto for a week or so.  I
noticed that a lot of people were surprised by this behavior, and figured it
would be better to document it.  I'm not sure that this is the right place for
it, and I'm happy to take suggestions on how to improve the wording.

 Documentation/merge-strategies.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 49a9a7d..fb6e593 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -113,3 +113,11 @@ subtree::
 	match the tree structure of A, instead of reading the trees at
 	the same level. This adjustment is also done to the common
 	ancestor tree.
+
+With the strategies that use 3-way merge (including the default, 'recursive'),
+if a change is made on both branches, but later reverted on one of the
+branches, that change will be present in the merged result; some people find
+this behavior confusing.  It occurs because only the heads and the merge base
+are considered when performing a merge, not the individual commits.  The merge
+algorithm therefore considers the reverted change as no change at all, and
+substitutes the changed version instead.
-- 
1.8.5.1
