From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Add description of OFS_DELTA to the pack format description
Date: Sun, 6 Apr 2008 15:47:39 +0200
Message-ID: <20080406134739.GA29815@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 15:48:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiVEO-0003dh-Q4
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 15:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbYDFNrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 09:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbYDFNrm
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 09:47:42 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:48542 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751506AbYDFNrl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 09:47:41 -0400
Received: (qmail 13 invoked by uid 5842); 6 Apr 2008 15:47:39 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78892>



Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---

I'll take it in smaller steps this time.

 Documentation/technical/pack-format.txt |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index aa87756..f6b1405 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -103,10 +103,20 @@ Pack file entry: <+
      packed object data:
         If it is not DELTA, then deflated bytes (the size above
 		is the size before compression).
-	If it is DELTA, then
+	If it is REF_DELTA, then
 	  20-byte base object name SHA1 (the size above is the
 		size of the delta data that follows).
           delta data, deflated.
+	If it is OFS_DELTA, then
+	  n-byte offset (see below) (the size above is the
+		size of the delta data that follows).
+          delta data, deflated.
+
+     offset encoding:
+          n bytes with MSB set in all but the last one.
+          The offset is then the number constructed by
+          concatenating the lower 7 bit of each byte, and
+          adding 2^7 + 2^14 + ... + 2^(7*(n-1)) to the result.
 
 
 = Version 2 pack-*.idx files support packs larger than 4 GiB, and
-- 
1.5.5-rc3.GIT
