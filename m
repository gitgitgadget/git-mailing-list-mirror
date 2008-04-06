From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH v3] Add description of OFS_DELTA to the pack format description
Date: Sun, 6 Apr 2008 22:51:49 +0200
Message-ID: <20080406205149.GD7075@bohr.gbar.dtu.dk>
References: <20080406134739.GA29815@bohr.gbar.dtu.dk> <20080406190724.GG10274@spearce.org> <20080406201907.GB7075@bohr.gbar.dtu.dk> <20080406202821.GN10274@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 06 22:52:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jibqs-0000Dn-6w
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 22:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbYDFUvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 16:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753400AbYDFUvv
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 16:51:51 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:49296 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752954AbYDFUvv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 16:51:51 -0400
Received: (qmail 16038 invoked by uid 5842); 6 Apr 2008 22:51:49 +0200
Content-Disposition: inline
In-Reply-To: <20080406202821.GN10274@spearce.org>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78928>


Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---
 Documentation/technical/pack-format.txt |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index aa87756..6b2170f 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -103,10 +103,24 @@ Pack file entry: <+
      packed object data:
         If it is not DELTA, then deflated bytes (the size above
 		is the size before compression).
-	If it is DELTA, then
+	If it is REF_DELTA, then
 	  20-byte base object name SHA1 (the size above is the
 		size of the delta data that follows).
           delta data, deflated.
+	If it is OFS_DELTA, then
+	  n-byte offset (see below) interpreted as a negative
+                offset from the type-byte of the header of the
+                ofs-delta entry (the size above is the size of
+                the delta data that follows).
+          delta data, deflated.
+
+     offset encoding:
+          n bytes with MSB set in all but the last one.
+          The offset is then the number constructed by
+          concatenating the lower 7 bit of each byte, and
+          for n >= 2 adding 2^7 + 2^14 + ... + 2^(7*(n-1))
+          to the result.
+          
 
 
 = Version 2 pack-*.idx files support packs larger than 4 GiB, and
-- 
1.5.5-rc3.GIT
